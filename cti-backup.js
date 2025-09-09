// Hi my existence is a bit of a mess,My name is Kunwar and this is a CTI tool a web component that provides a CTI (Computer Telephony Integration) tool for agents.
//  
const secretKey = "3bbd28e2-e187-40";
const flag = "ON";
const url = "https://sampark:8443/callapi/DBApi"; // Update with your server URL
const url2 = "https://sampark:8443/callapi/CTIApi";
// const urlx = 'https://sampark:8443/callapi/';
const urlx = 'https://cms.samparkccs.in:8443/Agent/';


const ip= "cms.samparkccs.in"; // Update with your server IP


//dispostion flag
var fetchedDisposition = false;
var transferFlag = false;




class CTITool extends HTMLElement {
    constructor() {
        super();
        this.attachShadow({ mode: 'open' });
        this.session = {};

        this.coolPhone = new JsSIP.UA(this.configuration);

        this.coolPhone.on('connected', (e) => {
            this.fncTOshowMessage("connected...");
        });

        this.coolPhone.on('disconnected', (e) => {
            this.fncTOshowMessage("disconnected...");
        });
    }
    async connectedCallback() {
        //AGENT LOGIN STATUS-----------------------------------
        const agentId = this?.session?.aid;
        const Obj_initialization = await this.getInitialization();
        // console.log("THE INITIALIZED OBJECT -----" + Obj_initialization);
        //1st session variable
        if (Obj_initialization && JSON.parse(Obj_initialization).success == true) {
            this.session.websocketExtensionPassword = JSON.parse(Obj_initialization).message.websocketextensionpassword;
            this.session.autoAnswer = JSON.parse(Obj_initialization).message.autoanswer;
            // console.log("THE SESSION OBJECT -----" + this.session.websocketExtensionPassword);
        }   //handle the case where initialization fails
        else {
            console.error("Initialization failed:", Obj_initialization);
            this.shadowRoot.innerHTML = "<p>Initialization failed. Please try again later.</p>";
            return;
        }
        if (!agentId) {
            Promise.all([
                fetch('login.css').then(res => res.text()),
                fetch('login.html').then(res => res.text()),

            ])
                .then(([css, html]) => {
                    this.shadowRoot.innerHTML = `<style>${css}</style>${html}`;
                    this.initLoginLogic();
                });
        } else {
            // If agentId exists, proceed with rendering the tool
            const sessionStatus = await this.getSessionStatus(agentId);
            console.log("THE SESSION STATUS -----" + sessionStatus);
            this.renderTool();
        }
    }
    renderTool(Regurl) {
        Promise.all([
            fetch('style.css').then(res => res.text()),
            fetch('tool.html').then(res => res.text()),
        ]).then(([css, html]) => {
            this.shadowRoot.innerHTML = `<style>${css}</style>${html}`;

            this.initLogic(Regurl);
        });
    }
    async initLoginLogic() {
        const shadow = this.shadowRoot;

        //logic for ctl box----------------------------------------------

        const card = shadow.querySelector('.card');
        let isDragging = false, offsetX = 0, offsetY = 0;
        // Dragging Logic
        card.addEventListener('mousedown', (e) => {
            isDragging = true;
            offsetX = e.clientX - card.offsetLeft;
            offsetY = e.clientY - card.offsetTop;
        });

        document.addEventListener('mousemove', (e) => {
            if (isDragging) {
                card.style.left = `${e.clientX - offsetX}px`;
                card.style.top = `${e.clientY - offsetY}px`;
            }
        });

        document.addEventListener('mouseup', () => {
            isDragging = false;
        });
        //set extension and service
        const agentInput = shadow.getElementById('agentId');
        if (agentInput) {

            agentInput.addEventListener('input', async (event) => {
                shadow.getElementById('agentPassword').value = ''; // Clear password field on agent ID change
            });
        }

        const passInput = shadow.getElementById('agentPassword');


        if (passInput) {
            let debounceTimeout;
            passInput.addEventListener('input', async (event) => {
                clearTimeout(debounceTimeout);

                const selectedValue = shadow.getElementById('agentId').value.trim();
                if (selectedValue) {
                    debounceTimeout = setTimeout(async () => {
                        shadow.getElementById('errorMsg').style.display = 'none';
                        const extensionInput = shadow.getElementById('agentExtension');
                        let extension = await this.getExtensionStatus(selectedValue);

                        extension = JSON.parse(extension);
                        const randomkey = function (length = 10) {
                            return Math.random().toString(36).substring(2, length + 2);
                        };
                        this.session.sessionKey = randomkey();
                        this.session.callingType = extension.message.iscalling;
                        // console.log("extension", extension);


                        extension = extension.message.extension;
                        extensionInput.value = extension;
                        const serviceInput = shadow.getElementById('service');
                        let services = await this.getSingleService(selectedValue);
                        //if response is not in JSON format, handle it using json.text() or similar
                        if (typeof services === 'string') {
                            // console.log(services);
                        }

                        services = JSON.parse(services);
                        // service_id: 1
                        // service_name: Test
                        // service_mobile: 8497487834 
                        // console.log("services", services);

                        services = services.message;

                        // console.log("Extension Status:", extension);


                        // i have to populate the service select boxes
                        // const serviceInput = shadow.getElementById('service');
                        serviceInput.innerHTML = ''; // Clear previous options
                        if (Array.isArray(services)) {
                            services.forEach(service => {
                                const option = document.createElement('option');
                                option.value = service.service_id; // Assuming service_id is the unique identifier
                                option.textContent = service.service_name; // Display the service name
                                this.session.serviceName = service.service_name;
                                serviceInput.appendChild(option);
                            });
                        } else {
                            const option = document.createElement('option');
                            option.value = services.service_id; // Assuming service_id is the unique identifier
                            option.textContent = services.service_name; // Display the service name

                            this.session.serviceName = services.service_name;  //in case of single service only
                            // this.session.serviceId = services?.service_id;
                            serviceInput.appendChild(option);
                        }
                        // serviceInput.value = services;
                    }, 2000);

                } else {
                    const errorMsg = shadow.getElementById('errorMsg');
                    errorMsg.style.display = 'block';
                    errorMsg.textContent = "Please enter a valid Agent ID";
                    console.error("Agent ID is empty or invalid");

                }
            });

        }
        const loginBtn = shadow.getElementById('loginBtn');
        if (loginBtn) {
            loginBtn.addEventListener('click', () => {
                const agentId = shadow.getElementById('agentId').value.trim();
                const agentPassword = shadow.getElementById('agentPassword').value.trim();
                const serviceInput = shadow.getElementById('service').value.trim();
                const agentExtensionInput = shadow.getElementById('agentExtension').value.trim();


                if (agentId && agentPassword && serviceInput && agentExtensionInput) {

                    // fnc to login to server-------------------------
                    this.loginToServer(agentId, agentPassword, agentExtensionInput, serviceInput)   // 
                        .then(response => {
                            const rsp = JSON.parse(response);

                            if (rsp.success == true) {
                                this.session.agentLevel = rsp.message.agentLevel;
                                // console.log("agentLevel is " + rsp.agentLevel)
                                const Regurl = rsp.message.response;
                                // console.log(Regurl);
                                // console.log(rsp)


                                // const password = this.session.websocketExtensionPassword;

                                const sessionKey = this.session.sessionKey;
                                const callingType = this.session.callingType;

                                const regUrl = this.buildRegUrl(agentId, agentExtensionInput, agentPassword, callingType, sessionKey);

                                //phone js logic---------------------------------------------------
                                // console.log("THE URL" + regUrl);
                                shadow.getElementById('errorMsg').style.display = 'none';
                                this.session.agentId = agentId;
                                this.session.serviceId = serviceInput;
                                this.session.Extension = agentExtensionInput;
                                this.session.agentPassword = agentPassword;

                                this.renderTool(regUrl);
                            } else {
                                // Show error or feedback
                                console.error('Login failed:', rsp.message.response);
                                shadow.getElementById('errorMsg').style.display = 'block';
                                shadow.getElementById('errorMsg').textContent = rsp.message.response;
                            }
                        })
                        .catch(error => {
                            console.error('Login error:', error);
                            shadow.getElementById('errorMsg').textContent = "Login failed. Please try again.";
                        });
                } else {
                    // Show error or feedback
                    shadow.getElementById('errorMsg').textContent = "Please enter all fields";
                }
            });
        }
    }

    initLogic(Regurl) {
        const shadow = this.shadowRoot;
        const card = shadow.querySelector('.card');
        let isDragging = false, offsetX = 0, offsetY = 0;

        // const RegIframe = shadow.getElementById('iframex');
        // RegIframe.src = urlx + Regurl;
        window.open(
            urlx + Regurl,
            "_blank",
            "location=no,menubar=no,height=300,width=500,top=100,left=100,titlebar=no,status=no"
        );
        // Dragging Logic
        card.addEventListener('mousedown', (e) => {
            isDragging = true;
            offsetX = e.clientX - card.offsetLeft;
            offsetY = e.clientY - card.offsetTop;
        });

        document.addEventListener('mousemove', (e) => {
            if (isDragging) {
                card.style.left = `${e.clientX - offsetX}px`;
                card.style.top = `${e.clientY - offsetY}px`;
            }
        });

        document.addEventListener('mouseup', () => {
            isDragging = false;
        });
        //#1 -- API 1 
        //  fetch btns--------------------------
        const fncToFetchBtns = async () => {
            const agentId = this.session.agentId;
            if (!agentId) {
                console.error("Agent ID not found in session.");
                return;
            }

            const dataSet = {
                type: 'fetchBtn',
                agentid: agentId,
            };
            const response = await this.apiPost(url, dataSet);
            const rsp = JSON.parse(response);
            // console.log(rsp);

            if (rsp.success === true) {
                const actions = rsp.message;
                const iconSection = shadow.querySelector('.icon-section');
                // iconSection.innerHTML = ''; // clear existing buttons

                actions.forEach(action => {
                    const actionLower = action.toLowerCase();
                    const smBox = document.createElement('div');
                    smBox.className = 'smBox';
                    smBox.setAttribute('data-action', actionLower);

                    const img = document.createElement('img');
                    img.src = `/img/${actionLower}.png`;
                    img.className = 'svgx';
                    img.alt = action;

                    const span = document.createElement('span');
                    span.className = 'icon_title';
                    span.textContent = action;

                    // Attach click event listener here
                    let lastClickedBtn = null; // to track the last clicked button

                    smBox.addEventListener('click', () => {
                        const allButtons = shadow.querySelectorAll('.icon-section .smBox');
                        // if (actionLower === 'dial' || actionLower === 'break' || actionLower === 'dispose' || actionLower === 'transfer') {
                        //     if (lastClickedBtn === smBox) {
                        //         // Toggle off (restore all buttons)
                        //         allButtons.forEach(btn => btn.classList.remove('inactive'));
                        //         lastClickedBtn = null;
                        //     } else {
                        //         // Dim others and highlight this one
                        //         allButtons.forEach(btn => btn.classList.add('inactive'));
                        //         smBox.classList.remove('inactive');
                        //         lastClickedBtn = smBox;
                        //         // Call your action
                        //     }
                        // }
                        this.fncOfAction(actionLower);
                    });


                    smBox.appendChild(img);
                    smBox.appendChild(span);
                    iconSection.appendChild(smBox);
                });

            } else {
                console.error("Failed to fetch actions.");
            }
        };

        fncToFetchBtns();
        //logic to check status of agent and extension
        const fncTocheckStatus = async () => {
            const agentId = this.session.agentId;
            if (!agentId) {
                console.error("Agent ID not found in session.");
                return;
            }
            const dataSet = {
                type: 'checkStatus',
                agentid: agentId,
            }
            const response = await this.apiPost(url2, dataSet);
            const rsp = JSON.parse(response);

            if (rsp.success == true) {
                const statusObject = JSON.parse(rsp.message);
                console.log(statusObject);
                // const statusCard = shadow.getElementById('statusCard');
                const extensionId = shadow.getElementById('extensionId');
                const extensionStatus = shadow.getElementById('extensionstatus');
                const agentStatus = shadow.getElementById('agentStatus');

                if (agentStatus == "UNKNOWN" && extensionStatus == "DOWN") {
                    this.logout(this.session.agentId);
                }

                extensionStatus.innerHTML = statusObject.extensionStatus;
                agentStatus.innerHTML = statusObject.agentStatus;
                if (statusObject.callNumber) {
                    this.session.callerNumber = statusObject.callNumber;
                    console.log(this.session.callerNumber);
                }

                //status since
                // const statusSince = shadow.getElementById('statusSince');
                // statusSince.innerHTML = "STATUS SINCE : (" + statusObject.statusSince + ")";
                const serviceName = shadow.getElementById('srviceName');
                serviceName.innerHTML = this.session.serviceName;
                const agentName = this.session.agentId;
                const agentNameElement = shadow.getElementById('agentName');
                agentNameElement.innerHTML = agentName;



                //swap images based on status------------------------------
                //set call service id -------------------------------
                this.session.callServiceId = statusObject.sid || '0';
                this.session.agentStatus = statusObject.agentStatus;
                this.shadowRoot.getElementById('soundWaves').style.display = "none";  //only for in call
                if (statusObject.agentStatus === 'INCALL') {

                    if (!transferFlag) {
                        this.hideElement('BreakContainer');
                        this.hideElement('dialpad');
                        shadow.getElementById('statusCard').style.display = '';
                        const Callstatus = this.shadowRoot.getElementById('callStatus');
                        // this.shadowRoot.getElementById('soundWaves').style.display = "block";
                        Callstatus.innerHTML = "On Call";
                        this.hideElement('transferSection');
                        this.swapStatusSvg('incall.png');
                    }
                } else if (statusObject.agentStatus === 'HANGUP') {

                    this.hideElement('BreakContainer');
                    this.hideElement('dialpad');
                    shadow.getElementById('statusCard').style.display = '';
                    const Callstatus = this.shadowRoot.getElementById('callStatus');
                    Callstatus.innerHTML = "On Hangup";
                    this.hideElement('transferSection');
                    this.swapStatusSvg('Hangup.png');
                } else if (statusObject.agentStatus === 'WRAPUP') {

                    //dispose logic here----------------------------------------
                    //auto dispose or any other logic--------------------------

                    if (!fetchedDisposition) {
                        this.disposeAction();
                    }
                    // this.hideElement('BreakContainer');
                    // this.hideElement('dialpad');
                    // shadow.getElementById('statusCard').style.display = 'block';
                    // const Callstatus = this.shadowRoot.getElementById('callStatus');
                    // Callstatus.innerHTML = "Dispose";
                    // this.hideElement('transferSection');
                    // this.swapStatusSvg('Dispose.png');

                }

                //swap status container-------------------------------


            } else {
                console.error("Failed to check status:", statusObject);
            }
        }

        fncTocheckStatus();
        this.statusInterval = setInterval(() => {
            fncTocheckStatus();
        }, 2000);

        //logout logic
        const logoutBtn = shadow.getElementById('logout');
        logoutBtn.addEventListener('click', async () => {
            const serverResponse = await this.fncToLogout();
            const rsp = JSON.parse(serverResponse);
            if (rsp.success && rsp.message == 'SUCCESS') {
                //show login page---------
                if (this.statusInterval) {
                    clearInterval(this.statusInterval);
                    this.statusInterval = null;
                }
                this.session = {};

                // 2. Render login page
                Promise.all([
                    fetch('login.css').then(res => res.text()),
                    fetch('login.html').then(res => res.text()),
                ]).then(([css, html]) => {
                    this.shadowRoot.innerHTML = `<style>${css}</style>${html}`;
                    this.initLoginLogic();
                });
            }

        });


        // Dial Pad Input
        const input = shadow.getElementById('dialInput');
        const pressButtons = shadow.querySelectorAll('#dialpad .buttons button');
        pressButtons.forEach(button => {
            const value = button.textContent.trim();
            if (value) {
                button.addEventListener('click', () => {
                    this.playSound('/sound/Tik.mp3');
                    input.value += value;
                });
            }
        });

        // Clear Input
        const clearBtn = shadow.getElementById('clearBtn');
        clearBtn.addEventListener('click', () => {
            input.value = '';
        });

        // #2 API 2 -----------------------------Call Button
        const callBtn = shadow.getElementById('callBtn');
        callBtn.addEventListener('click', async () => {
            const num = input.value.trim();

            const status = this.shadowRoot.getElementById("agentStatus").textContent;
            if (status != 'IDLE') {
                console.log("agent status is not idle !")
                return false;
            }
            if (num.length !== 10) {
                this.fncTOshowMessage("please enter a valid 10 digit number");
                return;
            } else {
                const refObj = await this.fncRef(num)
                console.log(refObj);
                this.playSound('/sound/dialing.mp3');
                this.session.refLeadId = refObj.refLead;
                this.session.refName = refObj.refName;
                this.session.refId = refObj.refId;

                const callStatus = await this.fncToCall(num);
                // console.log(callStatus);
                if (callStatus && callStatus.status === "Failed") {
                    // alert(callStatus.message || "Dial failed");
                    this.fncTOshowMessage("Dial failed: " + (callStatus.message || "Unknown error"));
                } else {
                    // Success logic here
                    // alert("Dial success");
                    const maskedNumber = num.slice(6);
                    const ms = "XXXXXX" + maskedNumber;
                    this.fncTOshowMessage("calling " + ms + " ...");
                    input.value = ms;
                    //logic to show calling svg-----------------------
                    this.hideElement('BreakContainer');
                    this.hideElement('dialpad');
                    const Callstatus = this.shadowRoot.getElementById('callStatus');
                    Callstatus.innerHTML = "Calling " + num;
                    this.hideElement('transferSection');
                    this.swapStatusSvg('calling.png');
                }
            }
        });
        //call api------------------------------------------------
        // Call function when Enter is pressed in the input field
        input.addEventListener('keydown', async (e) => {
            if (e.key === 'Enter') {
                const num = input.value.trim();
                const status = this.shadowRoot.getElementById("agentStatus").textContent;
                if (status != 'IDLE') {
                    console.log("agent status is not idle !");
                    return false;
                }
                if (num.length !== 10) {
                    this.fncTOshowMessage("please enter a valid 10 digit number");
                    return;
                }
                // Call the same function as callBtn click
                const refObj = await this.fncRef(num);
                console.log(refObj);
                this.playSound('/sound/dialing.mp3');
                this.session.refLeadId = refObj.refLead;
                this.session.refName = refObj.refName;
                this.session.refId = refObj.refId;

                const callStatus = await this.fncToCall(num);
                if (callStatus && callStatus.status === "Failed") {
                    this.fncTOshowMessage("Dial failed: " + (callStatus.message || "Unknown error"));
                } else {
                    this.fncTOshowMessage("calling " + num + " ...");
                    this.hideElement('BreakContainer');
                    this.hideElement('dialpad');
                    const Callstatus = this.shadowRoot.getElementById('callStatus');
                    Callstatus.innerHTML = "Calling " + num;
                    this.hideElement('transferSection');
                    this.swapStatusSvg('calling.png');
                }
            }
        });

        //status logic here-----------------------------
        //#3 API 3 Transfer call btn logic----------------------------------------------------------
        const transferBtn = shadow.getElementById('transfer_btn');
        transferBtn.addEventListener('click', async () => {
            const trResponse = await this.transferCall();
            console.log(trResponse);
            transferFlag = false;
            if (trResponse.success) {
                this.fncTOshowMessage(trResponse.message);

            }
        })

        setInterval(() => {
            this.fncToToggleStatus();
        }, 5000);
        //break logic here-----------------


        // Break Done Button Logic
        const breakDoneBtn = shadow.getElementById('breakDoneBtn');
        if (breakDoneBtn) {
            breakDoneBtn.addEventListener('click', () => {
                // Find the checked radio input inside the break list
                const selectedRadio = shadow.querySelector('.list input[type="radio"]:checked');
                if (selectedRadio) {
                    // Get the parent <li> with data attributes
                    const li = selectedRadio.closest('li.element');
                    if (li) {
                        const breakName = li.getAttribute('data-break');
                        const imgName = li.getAttribute('data-img');
                        this.handleBreakSelection(breakName, imgName);
                    }
                }
            });
        }

        //unbreak logic here-----------------
        // Break Done Button Logic
        const unbreakBtn = shadow.getElementById('unbreakBtn');
        if (unbreakBtn) {
            unbreakBtn.addEventListener('click', async () => {
                // Find the checked radio input inside the break list

                const password = shadow.getElementById('agentpassword').value;
                if (password === this.session.agentPassword) {
                    shadow.getElementById('agentpassword').value = '';
                    const breakStatus = this.shadowRoot.getElementById('breakStatus');
                    const breakContainer = this.shadowRoot.getElementById('BreakContainer');
                    breakContainer.style.display = 'none';
                    const breakList = this.shadowRoot.getElementById('breakList');
                    breakStatus.style.display = 'none';
                    breakList.style.display = 'block';
                    const breakName = this.session.BreakName;
                    // this.Unbreak();
                    const breakType = 'unbreak';
                    const unbrsp = await this.break(this.session.agentId, breakName, breakType);
                    console.log(unbrsp + "unbreak response");
                } else {
                    shadow.getElementById('agentpassword').value = '';
                    shadow.getElementById('agentpassword').placeholder = 'wrong password';

                }
            });
        }
        //Dispose logic here-------------------------------------------------
        const disposeBtn = shadow.getElementById('dispose_submit_btn');

        if (disposeBtn) {
            disposeBtn.addEventListener('click', async () => {

                const disposeResponse = await this.dispose();
                console.log(disposeResponse);
                if (disposeResponse.success && disposeResponse.message != "Failed. No Agent Found") {
                    this.fncTOshowMessage(disposeResponse.message);
                    shadow.getElementById('dispose_disp1').value = '';
                    shadow.getElementById('dispose_disp2').value = '';
                    shadow.getElementById('dispose_disp3').value = '';
                    shadow.getElementById('dispose_remarks').value = '';
                    shadow.getElementById('dispose_callback_time').value = '';
                    this.hideElement('disposeSection');
                    fetchedDisposition = false;
                }
            });
        }

    }
    // ...break logic code...

    async handleBreakSelection(breakName, imgName) {
        // Your logic here
        console.log('Selected break:', breakName, 'Image:', imgName);
        const breakStatus = this.shadowRoot.getElementById('breakStatus');
        const breakList = this.shadowRoot.getElementById('breakList');
        const breakImg = this.shadowRoot.getElementById('breakIMG');
        const breakTitle = this.shadowRoot.getElementById('break_title_id');
        breakStatus.style.display = 'block';
        breakList.style.display = 'none';
        breakImg.src = '/img/' + imgName;
        breakTitle.innerHTML = "Agent is on a " + breakName + "Break!";
        this.session.BreakName = breakName;
        const breakType = "break";

        const breakRsp = await this.break(this.session.agentId, breakName, breakType);
        console.log(breakRsp + "break response");
        // You can trigger further actions here

    }

    fncOfAction(action) {
        if (action == 'dial') {
            this.dialAction();
        } else if (action == 'break') {
            this.breakAction();

        } else if (action == 'auto') {
            this.autoAction();

        } else if (action == 'hangup') {
            this.hangupAction();

        } else if (action == 'dispose') {
            if (this.session.agentStatus == 'WRAPUP') {
                // console.log("agentStatus is ", this.session.agentStatus)
                this.disposeAction();
            }

        }
        else if (action == 'hold') {
            this.holdAction();
        }

        else if (action == 'block') {
            this.blockAction();
        }
        else if (action == 'transfer') {
            // i have to render transfer inputs based on the data
            if (this.session.callNumber && this.session.agentStatus == 'INCALL') {
                this.transferAction();
                transferFlag = true;

            } else {
                this.fncTOshowMessage("no call in progress to transfer");
            }

        }
        else if (action == 'conference') {
            // if (this.session.callNumber && this.session.agentStatus == 'INCALL') {
            this.conferenceAction();
            // }
        }
    }
    //swap svg fnc--------------------------------------------------------
    swapStatusSvg(filename) {
        this.shadowRoot.getElementById('statusCard').style.display = '';

        const statusSvg = this.shadowRoot.getElementById('statusSvg');



        if (statusSvg) {
            statusSvg.src = `/img/${filename}`;
        }
    }
    //btn actions
    // Dial Button
    dialAction = () => {
        const shadow = this.shadowRoot;
        const dialPad = shadow.getElementById('dialpad');
        this.playSound('/sound/sound.mp3');
        this.hideElement('BreakContainer');
        this.hideElement('statusCard');
        this.hideElement('transferSection');
        this.toggleDisplay(dialPad);

    }
    breakAction = () => {
        // Break Button

        const shadow = this.shadowRoot;
        const breakContainer = shadow.getElementById('BreakContainer');

        this.playSound('/sound/sound.mp3');
        this.hideElement('dialpad');
        this.hideElement('statusCard');
        this.hideElement('transferSection');
        this.toggleDisplay(breakContainer);


    }
    autoAction = () => {
        const shadow = this.shadowRoot;
        let autoStatus = false;
        const autoImg = shadow.getElementById('auto');
        this.playSound('/sound/sound.mp3');
        autoImg.src = autoStatus ? '/img/auto.png' : '/img/autoOff2.png';
        autoStatus = !autoStatus;

    }

    hangupAction = async () => {
        const response = await this.hangup();
        if (response.success) {
            this.fncTOshowMessage(response.message);
        }
        console.log("Hangup response:", response);

    }

    disposeAction = async () => {
        const shadow = this.shadowRoot;
        const disposeSection = shadow.getElementById('disposeSection');
        disposeSection.style.display = 'block';
        this.hideElement('dialpad');
        this.hideElement('statusCard');
        this.hideElement('BreakContainer');
        this.hideElement('transferSection');

        // Get select elements and their parent groups
        const disposeType1 = shadow.getElementById('dispose_disp1');
        const disposeType2 = shadow.getElementById('dispose_disp2');
        const disposeType3 = shadow.getElementById('dispose_disp3');
        const dispose_disp2_group = shadow.getElementById('dispose_disp2_group');
        const dispose_disp3_group = shadow.getElementById('dispose_disp3_group');

        // Reset selects and hide sub-levels
        disposeType1.innerHTML = '<option value="">Select Disposition 1</option>';
        disposeType2.innerHTML = '<option value="">Select Disposition 2</option>';
        disposeType3.innerHTML = '<option value="">Select Disposition 3</option>';
        dispose_disp2_group.style.display = 'none';
        dispose_disp3_group.style.display = 'none';

        // Fetch disposition data
        const disposeResponse = await this.fetchDispositonData();
        if (disposeResponse.success !== true) {
            this.fncTOshowMessage("Failed to fetch dispositions: " + disposeResponse.message);
            return;
        }


        const disposeList = disposeResponse.message.dispositionList;

        if (!disposeList || disposeList.length === 0) {
            this.fncTOshowMessage("No dispositions found in the response.");
            return;
        }
        fetchedDisposition = true;
        // 1. Render first-level options (unique by name)
        const firstLevelMap = new Map();
        disposeList.forEach(item => {
            const dispObj = item.dispositions["1"];
            Object.entries(dispObj).forEach(([name, code]) => {
                if (name && !firstLevelMap.has(name)) {
                    firstLevelMap.set(name, code);
                }
            });
        });
        firstLevelMap.forEach((code, name) => {
            const option = document.createElement('option');
            option.value = name; // Use name as value for filtering
            option.textContent = name;
            disposeType1.appendChild(option);
        });

        // 2. On change of first-level, render second-level
        disposeType1.onchange = () => {
            const selected1 = disposeType1.value;

            if (selected1 == 'Call Back') {
                shadow.getElementById('dispose_callback_group').style.display = 'block';
            } else {
                shadow.getElementById('dispose_callback_group').style.display = 'none';
            }
            disposeType2.innerHTML = '<option value="">Select Disposition 2</option>';
            disposeType3.innerHTML = '<option value="">Select Disposition 3</option>';
            dispose_disp2_group.style.display = 'none';
            dispose_disp3_group.style.display = 'none';

            if (!selected1) return;

            // Find all items with this first-level selection
            const secondLevelMap = new Map();
            disposeList.forEach(item => {
                const dispObj1 = item.dispositions["1"];
                if (dispObj1 && Object.keys(dispObj1).includes(selected1)) {
                    const dispObj2 = item.dispositions["2"];
                    Object.entries(dispObj2).forEach(([name, code]) => {
                        if (name && code && !secondLevelMap.has(name)) {
                            secondLevelMap.set(name, code);
                        }
                    });
                }
            });

            if (secondLevelMap.size > 0) {
                dispose_disp2_group.style.display = '';
                secondLevelMap.forEach((code, name) => {
                    const option = document.createElement('option');
                    option.value = name; // Use name as value for filtering
                    option.textContent = name;
                    disposeType2.appendChild(option);
                });
            }
        };

        // 3. On change of second-level, render third-level
        disposeType2.onchange = () => {
            const selected1 = disposeType1.value;
            const selected2 = disposeType2.value;
            disposeType3.innerHTML = '<option value="">Select Disposition 3</option>';
            dispose_disp3_group.style.display = 'none';

            if (!selected2) return;

            const thirdLevelMap = new Map();
            disposeList.forEach(item => {
                const dispObj1 = item.dispositions["1"];
                const dispObj2 = item.dispositions["2"];
                if (
                    dispObj1 && Object.keys(dispObj1).includes(selected1) &&
                    dispObj2 && Object.keys(dispObj2).includes(selected2)
                ) {
                    const dispObj3 = item.dispositions["3"];
                    Object.entries(dispObj3).forEach(([name, code]) => {
                        if (name && code && !thirdLevelMap.has(name)) {
                            thirdLevelMap.set(name, code);
                        }
                    });
                }
            });

            if (thirdLevelMap.size > 0) {
                dispose_disp3_group.style.display = '';
                thirdLevelMap.forEach((code, name) => {
                    const option = document.createElement('option');
                    option.value = code;
                    option.textContent = name;
                    disposeType3.appendChild(option);
                });
            }
        };
    };


    conferenceAction = async () => {
        const shadow = this.shadowRoot;
        const conferenceSection = shadow.getElementById('conferenceSection');
        conferenceSection.style.display = 'block';
        this.hideElement('dialpad');
        this.hideElement('statusCard');
        this.hideElement('BreakContainer');
        this.hideElement('transferSection');
        this.hideElement('disposeSection');


    };
    // Find all items

    holdAction = async () => {
        const response = await this.hold();
        if (response.success) {
            this.fncTOshowMessage(response.message);
            // this.session.callNumber = '';
        }
        console.log("Hold response:", response);
    }

    blockAction = async () => {
        const response = await this.block();
        if (response.success) {
            this.fncTOshowMessage(response.message);
            // this.session.callNumber = '';
        }
        console.log("Hold response:", response);
    }

    //Transfer functions-----------------------------------------------------------------------------
    transferAction = async () => {
        await this.renderTransferTypes();
        const shadow = this.shadowRoot;
        const transferSection = shadow.getElementById('transferSection');

        this.playSound('/sound/sound.mp3');
        this.hideElement('dialpad');
        this.hideElement('statusCard');
        this.hideElement('BreakContainer');
        this.toggleDisplay(transferSection);
    }

    async renderTransferTypes() {
        const transferType = this.shadowRoot.getElementById('transfer_type');
        transferType.innerHTML = '<option value="">Select Type</option>';
        const transferList = await this.fetchTransferTypes(); // Should be async if fetching from API
        console.log("Transfer List:", transferList);
        if (transferList.success) {
            const types = transferList.message.data.slice(5, 11) || [];
            types.forEach(type => {
                const option = document.createElement('option');
                option.value = type.gn_sub_value;
                option.textContent = type.gn_value;
                transferType.appendChild(option);
            });
        }

        // Hide all dependent groups initially
        this.shadowRoot.getElementById('service_group').style.display = 'none';
        this.shadowRoot.getElementById('agent_group').style.display = 'none';

        // Set up change handler
        transferType.onchange = (e) => this.handleTransferTypeChange(e.target.value);
    }
    async handleTransferTypeChange(selectedType) {
        // Hide all dependent groups first

        this.shadowRoot.getElementById('agent_group').style.display = 'none';
        this.shadowRoot.getElementById('service_group').style.display = 'none';
        this.shadowRoot.getElementById('extension_group').style.display = 'none';
        if (selectedType === 'Service' || selectedType === 'Agent' || selectedType === 'Atxfer') {
            // Show and populate service options
            this.shadowRoot.getElementById('service_group').style.display = 'block';
            // this.shadowRoot.getElementById('agent_group').style.display = 'block';
            const serviceGroup = this.shadowRoot.getElementById('service_group');
            serviceGroup.style.display = '';
            const servList = await this.getServiceList();
            console.log("Service List:", servList);
            if (Array.isArray(servList) && servList.length > 0) {
                this.renderServiceList(servList);
            }
        } else if (selectedType === 'Extention') {
            this.shadowRoot.getElementById('service_group').style.display = 'none';
            this.shadowRoot.getElementById('agent_group').style.display = 'none';
            // Show and populate agent options
            const extensionGroup = this.shadowRoot.getElementById('extension_group');
            extensionGroup.style.display = '';



        }
    }

    async handleserviceChange(selectedValue) {

        const selectedType = this.shadowRoot.getElementById('transfer_type').value;
        if (selectedType == "Agent" || selectedType == "Atxfer") {
            this.shadowRoot.getElementById('agent_group').style.display = 'block';
            console.log("selected agents --------------" + selectedValue)
            // this.shadowRoot.getElementById('agent_group').style.display = '';
            const agentGroup = this.shadowRoot.getElementById('agent_group');
            // agentGroup.style.display = '';
            const agentList = await this.getAgentList(selectedValue);
            console.log(agentList);
            if (agentList.success) {
                this.renderAgentList(agentList.message);
            }

        } else {
            console.log("either ext or warm");
        }

        // this.shadowRoot.getElementById('agent_group').style.display = 'none';
    }

    //fetch transfer types
    async fetchTransferTypes() {
        const dataSet = {
            type: 'generalsetting',
            agentid: this.session.agentId,
        }
        return this.apiPost(url, dataSet)
            .then(response => JSON.parse(response))
            .catch(error => {
                console.error("Error fetching transfer types:", error);
                return { success: false, message: "Failed to fetch transfer types" };
            });
    }

    //Transfer functions-----------------------------------------------------------------------------
    async getServiceList() {
        const dataSet = {
            type: 'loadservicefortransfer',
            agentid: this.session.agentId,

        }
        const rsp = await this.apiPost(url, dataSet);
        return JSON.parse(rsp);
    }


    async getAgentList(id) {
        const dataSet = {
            type: 'fillcity',
            agentid: this.session.agentId,
            state: id

        }
        const rsp = await this.apiPost(url, dataSet);
        return JSON.parse(rsp);
    }

    renderServiceList(services) {
        const serviceSelect = this.shadowRoot.getElementById('service_option');
        serviceSelect.innerHTML = '<option value="">Select Service</option>';
        services.forEach(service => {
            const option = document.createElement('option');
            option.value = service.value;
            option.textContent = service.name;
            serviceSelect.appendChild(option);
        });

        serviceSelect.onchange = (e) => this.handleserviceChange(e.target.value);
    }


    // 4. Render agent list
    renderAgentList(agents) {
        const agentSelect = this.shadowRoot.getElementById('agent_option');

        agentSelect.innerHTML = '<option value="">Select Agent</option>';
        agents.forEach(agent => {
            const option = document.createElement('option');
            option.value = agent.extension_number;
            option.textContent = agent.agent_name;
            agentSelect.appendChild(option);
        });
    }

    //Transfer functions-----------------------------------------------------------------------------
    fncToToggleStatus = () => {
        const extensionStatus = this.shadowRoot.getElementById('extensionStatus');
        const agentStatus = this.shadowRoot.getElementById('agentStatus');
        const statusDots = this.shadowRoot.querySelectorAll('.status-dot'); // Use class selector

        // logic to toggle status window
        if (extensionStatus && agentStatus && statusDots.length === 2) {
            if (agentStatus.style.display === 'none') {
                agentStatus.style.display = 'flex';
                extensionStatus.style.display = 'none';
                // Set first dot active, second inactive
                statusDots[0].style.backgroundColor = 'green';
                statusDots[1].style.backgroundColor = 'rgb(188, 156, 218)';
            } else {
                extensionStatus.style.display = 'flex';
                agentStatus.style.display = 'none';
                // Set second dot active, first inactive
                statusDots[0].style.backgroundColor = 'rgb(188, 156, 218)';
                statusDots[1].style.backgroundColor = 'green';
            }
        }
    }
    // ...existing code...
    //#############################################################################
    //Dispose list ----------------------------------------------------
    fetchDispositonData = async () => {
        const dataSet = {
            type: 'fillDispositions',
            agentid: this.session.agentId,
            sid: this.session.callServiceId,
            // sid: '0',
            agentlevel: this.session.agentLevel || '0'
        }
        console.log(dataSet);
        const rsp = await this.apiPost(url, dataSet);
        return JSON.parse(rsp);
    }


    //###################################################################################

    playSound(src) {
        const audio = new Audio(src);
        audio.play();
    }

    toggleDisplay(element) {

        if (element.style.display === 'none') {
            element.style.display = 'block';

        } else {
            element.style.display = 'none';

        }
        // element.style.display = (element.style.display === 'none') ? 'block' : 'none';
    }

    hideElement(id) {
        const el = this.shadowRoot.getElementById(id);
        if (el) el.style.display = 'none';


    }
    //url -----------------------------------------------------------------------------------
    buildRegUrl(agentId, extension, password, callingType, sessionKey) {
        return `reg.html?agent_id=${agentId}&ext=${extension}&pwd=${password}&iscalling=${callingType}&sessionkey=${sessionKey}`;
    }

    //api function for 'all api calls' here--------------------------------

    async apiPost(endpoint, data) {
        data = this.Parser(data, 'e'); // Encrypt data if needed
        try {
            const response = await fetch(endpoint, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: data
            });

            const resp = await response.text();
            return this.Parser(resp, 'd')
        } catch (error) {
            return { success: false, message: 'Network error', error };
        }
    }

    // ...Initialization ------------------- 000
    async getInitialization() {
        const dataSet = {
            type: 'initialize',
            agentid: 'test@1232323'
        }
        return this.apiPost(url, dataSet);
    }

    //get session status-------------------------------------------001
    getSessionStatus(agentId) {
        const dataSet = {
            type: 'getwebsip',
            agentid: agentId,
        }
        return this.apiPost(url, dataSet);
    }
    //get extension status-------------------------------------------002
    getExtensionStatus(aid) {
        const dataSet = {
            type: 'getwebsip',
            agentid: aid,
        }
        return this.apiPost(url, dataSet);
    }
    //get single service-------------------------------------------003
    getSingleService(aid) {
        const dataSet = {
            type: 'getServices',
            agentid: aid,
        }
        return this.apiPost(url, dataSet);
    }

    //show msg----------------------------info
    fncTOshowMessage(msg) {
        const info = this.shadowRoot.getElementById('messageInfo');
        const serviceBar = this.shadowRoot.getElementById('serviceX');
        if (info) {
            info.style.display = 'flex';
            let msgx = msg;
            if (msg.startsWith("<RESPONSE")) {

                const match = msg.match(/<STATUSDESC>(.*?)<\/STATUSDESC>/);
                msgx = match ? match[1] : 'Unknown';
                console.log(msgx);

            }
            info.textContent = msgx;
        }
        if (serviceBar) {
            serviceBar.style.display = 'none';
        }
        setTimeout(() => {
            if (info) info.style.display = 'none';
            if (serviceBar) serviceBar.style.display = 'flex';
        }, 10000);
    }

    //get all services-------------------------------------------004
    getAllServices(aid) {
        const dataSet = {
            type: 'getMultiServices',
            agentid: aid,
        }
        return this.apiPost(url, dataSet);
    }

    // logout logic----------------------------005

    fncToLogout() {
        const dataSet = {
            type: 'forcelogout',
            agentid: this.session.agentId,
            extension: this.session.Extension,
            uuid: this.session.sessionKey

        }
        // console.log(dataSet);
        return this.apiPost(url2, dataSet);
        //logic to end the session
    }

    // ...existing code...
    loginToServer(agentId, agentPassword, agentExtension, serviceId) {
        // Simulate a server login request

        const dataSet = {
            type: 'login',
            agentid: agentId,
            password: agentPassword,
            extension: agentExtension,
            service: serviceId
        }
        // console.log(dataSet);
        return this.apiPost(url, dataSet);
    }


    // login(agentId, agentPassword) {
    //     return this.apiPost('/api/login', { agentId, agentPassword });
    // }


    logout(agentId) {
        return this.apiPost('/api/logout', { agentId });
    }


    async fncToCall(phoneNumber) {




        const lead = this.session.refLeadId;
        const batchid = this.session.refLeadName;
        const batchname = this.session.refId;



        this.session.callNumber = phoneNumber;
        const data = {
            type: "mDial",
            num: phoneNumber,
            refid: lead || '',
            batchname: batchname || '',
            batchid: batchid || '',
            sid: this.session.serviceId,
            agentid: this.session.agentId
        };
        const rsp = await this.apiPost(url2, data);
        return JSON.parse(rsp);

    }

    async fncRef(num) {
        const dataObj = {
            type: "getCrmRef",
            num: num,
            serviceref: this.session.serviceId,
            agentid: this.session.agentId
        }
        const rsp = await this.apiPost(url, dataObj);
        return JSON.parse(rsp);
    }

    async dispose() {

        //get all the input elements---------------------
        const dispNameContent = this.shadowRoot.getElementById('dispose_disp1');
        const disposition2 = this.shadowRoot.getElementById('dispose_disp2').value || '';
        const disposition3 = this.shadowRoot.getElementById('dispose_disp3').value || '';
        const remarks = this.shadowRoot.getElementById('dispose_remarks').value || '';
        let callbackDate = this.shadowRoot.getElementById('dispose_callback_time').value || '';

        const dispArr = dispNameContent.options[dispNameContent.selectedIndex];

        const dispName = dispArr.text;
        const disposition1 = dispArr.text;

        const today = new Date();
        const yyyy = today.getFullYear();
        const mm = String(today.getMonth() + 1).padStart(2, '0');
        const dd = String(today.getDate()).padStart(2, '0');
        const currentDate = `${yyyy}-${mm}-${dd}`;

        const fnctoremoveSpecailchar = (remarks) => {
            for (let i = 0; i < remarks.length; i++) {
                if (!remarks[i].match(/^[A-Za-z.-\s]/)) {
                    console.log("yes mithketa = " + remarks[i])
                    remarks.replace(remarks[i], '')
                }
            }
            return remarks;
        }


        const remarksx = fnctoremoveSpecailchar(remarks);

        //alert(remarks);
        callbackDate = callbackDate.replace("/", "-");

        if (callbackDate && callbackDate < currentDate) {
            this.fncTOshowMessage("Please select a valid callback date.!");
            return;
        }
        // logic------------------------based on disposition--------------------
        const dataSet = {
            type: "closeCall",
            disposition: disposition3 || disposition2 || disposition1,
            callnumber: this.session.callerNumber,
            remarks: remarksx,
            cbkdate: callbackDate,
            main_dispstn_code: dispName,   //text ------------------------
            sub_dispstn_code: disposition3 || disposition2 || disposition1,    //disposition value----
            agentid: this.session.agentId
        }
        console.log(dataSet);
        const rsp = await this.apiPost(url2, dataSet);
        return JSON.parse(rsp);
    }

    async hangup() {

        const dataSet = {
            type: "hangupCall",
            agentid: this.session.agentId

        }
        const rsp = await this.apiPost(url2, dataSet);
        return JSON.parse(rsp);
    }


    async break(agentId, breakName, breakType) {
        let reqObj = {};
        if (breakType == 'break') {
            reqObj = {
                type: "break",
                reqtype: "break_start",
                reqtype1: breakName.toLowerCase(),
                agentid: agentId
            }
            console.log(reqObj);
            const resp = await this.apiPost(url2, reqObj);
            return JSON.parse(resp);
        } else {


            reqObj = {
                type: "break",
                reqtype: "break_end",
                reqtype1: this.session.BreakName,
                agentid: this.session.agentId
            }
            console.log(reqObj);
            const resp = await this.apiPost(url2, reqObj);
            return JSON.parse(resp);
        }
    }


    changeService(agentId, newService) {
        return this.apiPost('/api/changeService', { agentId, newService });
    }

    auto(agentId, autoStatus) {
        return this.apiPost('/api/auto', { agentId, autoStatus });
    }

    async transferCall() {
        //extract input details 
        const InputType = this.shadowRoot.getElementById('transfer_type').value || '';
        const InputExtension = this.shadowRoot.getElementById('transfer_extension').value || '';
        const InputService = this.shadowRoot.getElementById('service_option').value || '';
        const InputAgent = this.shadowRoot.getElementById('agent_option').value || '';

        let dataSet = {};



        if (InputType == "Agent") {
            //agents value in extension  //same for axfer
            dataSet = {
                type: "transferCall",
                agentid: this.session.agentId,
                callnumber: this.session.callerNumber,
                extension: InputAgent,
                remarks: 'tum sambhalo bhai'
            }

        }
        else if (InputType == "Service") {
            //service dni no in extension-------------------
            dataSet = {
                type: "transferCall",
                agentid: this.session.agentId,
                callnumber: this.session.callerNumber,
                extension: InputService,
                remarks: 'tum sambhalo bhai'
            }

        } else if (InputType == "Extention") {   //correct the grammer

            dataSet = {
                type: "transferCall",
                agentid: this.session.agentId,
                callnumber: this.session.callerNumber,
                extension: InputExtension,
                remarks: 'tum sambhalo bhai'
            }

        } else if (InputType == "Atxfer") {
            dataSet = {
                type: "atransferCall",
                agentid: this.session.agentId,
                callnumber: this.session.callerNumber,
                extension: InputAgent,
                remarks: 'tum sambhalo bhai'
            }
        } else if (InputType == "BEx.Xfer") {


            dataSet = {
                type: "externaltransferB",
                agentid: this.session.agentId,
                callnumber: this.session.callerNumber,
                extension: InputExtension,
                remarks: 'tum sambhalo bhai'
            }
        } else if (InputType == "AEx.Xfer") {
            dataSet = {
                type: "externaltransferA",
                agentid: this.session.agentId,
                callnumber: this.session.callerNumber,
                extension: InputExtension,
                remarks: 'tum sambhalo bhai'
            }
        }
        console.log(dataSet);
        //warm and for blind 
        const rsp = await this.apiPost(url2, dataSet);
        return JSON.parse(rsp);
    }


    conference(agentId, callId, participants) {
        return this.apiPost('/api/conference', { agentId, callId, participants });
    }

    async hold() {
        const dataSet = {
            type: "hold",
            callnumber: this.session.callerNumber,
            agentid: this.session.agentId

        }
        const rsp = await this.apiPost(url2, dataSet);
        return JSON.parse(rsp);
    }

    // request parser function 


    async block() {
        const dataSet = {
            type: "block",
            callnumber: this.session.callerNumber,
            agentid: this.session.agentId

        }
        const rsp = await this.apiPost(url2, dataSet);
        return JSON.parse(rsp);
    }

    Parser = (data, mode) => {
        if (mode == 'e') {
            if (flag === "OFF") {
                console.log('flag', flag);
                const actualData = JSON.stringify(data);
                console.log('actualData', actualData);
                return JSON.stringify(data);
            }
            return this.getEnc(secretKey, JSON.stringify(data));
        } else {
            if (flag === "OFF") {
                return JSON.stringify(data);
            }
            return this.getDnc(secretKey, data);
        }
    }
    getDnc(pkey, data) {
        // Use window.CryptoJS if available globally
        // const CryptoJS = this.CryptoJS;
        var key = CryptoJS.enc.Latin1.parse(pkey);
        var iv = CryptoJS.enc.Latin1.parse('lkjhyutrdb102dhr');
        var decrypted = CryptoJS.AES.decrypt(data, key, { iv: iv, padding: CryptoJS.pad.ZeroPadding });
        var textString = CryptoJS.enc.Utf8.stringify(decrypted);
        // If decryption fails, textString will be empty
        return textString.trim();
    }
    getEnc(pkey, data) {
        // const CryptoJS = this.CryptoJS;
        var key = CryptoJS.enc.Latin1.parse(pkey);
        var iv = CryptoJS.enc.Latin1.parse('lkjhyutrdb102dhr');

        var encrypted = CryptoJS.AES.encrypt(
            data,
            key,
            {
                iv: iv,
                mode: CryptoJS.mode.CBC,
                padding: CryptoJS.pad.ZeroPadding
            });
        encrypted = encrypted.toString();
        encrypted = encrypted.replaceAll("+", "%2B");
        return encrypted;
    }

    //phone js implementation#################################
    initPhoneJs({ ip, glbl_ext, glbl_pwd, autoAns }) {
        this.coolPhone = null;
        this.mic = {};
        this.speaker = {};
        this.logoutCount = 0;

        // Helper to update mic/speaker in Shadow DOM
        const updateAudioDevices = () => {
            const micSpan = this.shadowRoot.getElementById("microphone");
            const speakerSpan = this.shadowRoot.getElementById("speaker");
            micSpan && (micSpan.textContent = this.mic["default"] || "");
            speakerSpan && (speakerSpan.textContent = this.speaker["default"] || "");
        };

        this.getMicrophone = () => {
            this.mic = {};
            this.speaker = {};
            navigator.mediaDevices.enumerateDevices()
                .then((devices) => {
                    this.mic = {};
                    this.speaker = {};
                    devices.forEach((device) => {
                        if (device.kind == "audioinput" && device.label) {
                            if ((device.deviceId).includes("default")) {
                                this.mic[device.deviceId] = device.label;
                            }
                        }
                        if (device.kind == "audiooutput" && device.label) {
                            this.speaker[device.deviceId] = device.label;
                        }
                    });
                    updateAudioDevices();
                })
                .then(() => {
                    if (autoAns === 'Y') {
                        if (Object.keys(this.mic).length < 1) {
                            this.logoutCount++;
                            this.fncTOshowMessage("Microphone permission blocked, disabled or disconnected!");
                            if (this.logoutCount >= 5) {
                                this.coolPhone.unregister({ all: true });
                                this.logout();
                            }
                        } else {
                            this.logoutCount = 0;
                        }
                    }
                });
        };

        // SIP configuration
        const socket = new JsSIP.WebSocketInterface('wss://' + ip + ':8089/ws');
        const configuration = {
            sockets: [socket],
            uri: 'sip:' + glbl_ext + '@' + ip,
            password: glbl_pwd
        };

        this.coolPhone = new JsSIP.UA(configuration);

        this.coolPhone.on('connected', () => {
            this.fncTOshowMessage("connected...");
        });

        this.coolPhone.on('disconnected', () => {
            this.fncTOshowMessage("disconnected...");
        });

        let state = {
            callReceived: autoAns,
            callSession: null,
            fromNumber: null,
            toNumber: null,
        };

        this.coolPhone.on('newRTCSession', (e) => {
            this.fncTOshowMessage("Ringing...");
            this.getMicrophone();

            const session = e.session;
            state = {
                callReceived: autoAns,
                callSession: session,
                fromNumber: "1",
                toNumber: "2",
            };

            if (autoAns) {
                const callOptions = {
                    mediaConstraints: { audio: true, video: false },
                    pcConfig: {
                        iceServers: [{ urls: ["stun:stun.l.google.com:19302"] }],
                        iceTransportPolicy: "all",
                        rtcpMuxPolicy: "negotiate"
                    }
                };
                state.callSession.answer(callOptions);
                state.callSession.connection.addEventListener('addstream', (event) => {
                    const audioElement = this.shadowRoot.getElementById("remote-audio");
                    if (audioElement) {
                        audioElement.srcObject = event.stream;
                        audioElement.play();
                    }
                });
            }
        });

        // Register other event handlers as needed...

        // Start SIP phone after a short delay
        setTimeout(() => {
            this.coolPhone.start();
        }, 1000);

        // Periodically check microphone
        setInterval(() => {
            this.getMicrophone();
        }, 5000);

        // Expose phone control methods as class methods if needed
        this.mutePhone = () => {
            if (state.callSession && state.callSession.isMuted().audio) {
                state.callSession.unmute();
            } else if (state.callSession) {
                state.callSession.mute();
            }
        };
        this.answerPhone = () => { /* ... */ };
        this.holdPhone = () => { /* ... */ };
        this.hangupPhone = () => { if (state.callSession) state.callSession.terminate(); };
    }
}






