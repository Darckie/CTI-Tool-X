// Hi my existence is a bit of a mess,My name is Kunwar and this is a CTI tool a web component that provides a CTI (Computer Telephony Integration) tool for agents.
//  
const secretKey = "3bbd28e2-e187-40";
const flag = "ON";
const url = "https://sampark:8443/callapi/DBApi"; // Update with your server URL
const url2 = "https://sampark:8443/callapi/CTIApi";
// const urlx = 'https://sampark:8443/callapi/';
const urlx = 'https://cms.samparkccs.in:8443/Agent/';




class CTITool extends HTMLElement {
    constructor() {
        super();
        this.attachShadow({ mode: 'open' });
        this.session = {};
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
                        console.log("extension", extension);


                        extension = extension.message.extension;
                        extensionInput.value = extension;
                        const serviceInput = shadow.getElementById('service');
                        let services = await this.getSingleService(selectedValue);
                        //if response is not in JSON format, handle it using json.text() or similar
                        if (typeof services === 'string') {
                            console.log(services);
                        }

                        services = JSON.parse(services);
                        // service_id: 1
                        // service_name: Test
                        // service_mobile: 8497487834 
                        console.log("services", services);

                        services = services.message;

                        console.log("Extension Status:", extension);


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
                                const Regurl = rsp.message.response;
                                console.log(Regurl);



                                // const password = this.session.websocketExtensionPassword;

                                const sessionKey = this.session.sessionKey;
                                const callingType = this.session.callingType;
                                const regUrl = this.buildRegUrl(agentId, agentExtensionInput, agentPassword, callingType, sessionKey);


                                console.log("THE URL" + regUrl);
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
            console.log(rsp);

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

                        if (lastClickedBtn === smBox) {
                            // Toggle off (restore all buttons)
                            allButtons.forEach(btn => btn.classList.remove('inactive'));
                            lastClickedBtn = null;
                        } else {
                            // Dim others and highlight this one
                            allButtons.forEach(btn => btn.classList.add('inactive'));
                            smBox.classList.remove('inactive');
                            lastClickedBtn = smBox;
                            // Call your action
                        }
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
                extensionStatus.innerHTML = statusObject.extensionStatus;
                agentStatus.innerHTML = statusObject.agentStatus;
                if (statusObject.callNumber) {
                    this.session.callerNumber = statusObject.callNumber;
                }
                console.log(this.session.callerNumber);
                //status since
                // const statusSince = shadow.getElementById('statusSince');
                // statusSince.innerHTML = "STATUS SINCE : (" + statusObject.statusSince + ")";
                const serviceName = shadow.getElementById('srviceName');
                serviceName.innerHTML = this.session.serviceName;
                const agentName = this.session.agentId;
                const agentNameElement = shadow.getElementById('agentName');
                agentNameElement.innerHTML = agentName;
                // extensionId.innerHTML = this.session.Extension;


                // Show the status card
                // statusCard.style.display = 'flex';
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
            if (num.length !== 10) {
                statusTitle.innerHTML = "Invalid number!";
                return;
            } else {
                const refObj = await this.fncRef(num)
                console.log(refObj);
                this.playSound('/sound/dialing.mp3');
                this.session.refLeadId = refObj.refLead;
                this.session.refName = refObj.refName;
                this.session.refId = refObj.refId;

                const callStatus = await this.fncToCall(num);
                console.log(callStatus);
                if (callStatus && callStatus.status === "Failed") {
                    alert(response.message || "Dial failed");
                } else {
                    // Success logic here
                    // alert("Dial success");

                }


            }

        });

        //status logic here-----------------------------


        setInterval(() => {
            this.fncToToggleStatus();
        }, 5000);
        //break logic here-----------------
        // ...existing code...

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
            unbreakBtn.addEventListener('click', () => {
                // Find the checked radio input inside the break list

                const password = shadow.getElementById('agentpassword').value;
                if (password == this.session.agentPassword) {
                    shadow.getElementById('agentpassword').value = '';
                    const breakStatus = this.shadowRoot.getElementById('breakStatus');
                    const breakContainer = this.shadowRoot.getElementById('BreakContainer');
                    breakContainer.style.display = 'none';
                    const breakList = this.shadowRoot.getElementById('breakList');
                    breakStatus.style.display = 'none';
                    breakList.style.display = 'block';
                    this.session.BreakName
                    this.Unbreak();
                } else {
                    shadow.getElementById('agentpassword').value = '';
                    shadow.getElementById('agentpassword').placeholder = 'wrong password';

                }
            });
        }

        // ...existing code...

    }
    // ...break logic code...

    handleBreakSelection(breakName, imgName) {
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
        //break api--------------------------------

        this.break(this.session.agentId, breakName);

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
            this.disposeAction();
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
        this.toggleDisplay(dialPad);

    }
    breakAction = () => {
        // Break Button

        const shadow = this.shadowRoot;
        const breakContainer = shadow.getElementById('BreakContainer');

        this.playSound('/sound/sound.mp3');
        this.hideElement('dialpad');
        this.hideElement('statusCard');
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
        const response = await this.dispose();
        if (response.success) {
            this.fncTOshowMessage(response.message);
            // this.session.callNumber = '';
        }
        console.log("Dispose response:", response);
    }




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


    playSound(src) {
        const audio = new Audio(src);
        audio.play();
    }

    toggleDisplay(element) {
        const statusCard = this.shadowRoot.getElementById('statusCard');
        if (element.style.display === 'none') {
            element.style.display = 'block';
            statusCard.style.display = 'none';
        } else {
            element.style.display = 'none';
            statusCard.style.display = 'block';
        }
        // element.style.display = (element.style.display === 'none') ? 'block' : 'none';
    }

    hideElement(id) {
        const el = this.shadowRoot.getElementById(id);
        if (el) el.style.display = 'none';


    }

    //url 
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
            info.textContent = msg;
        }
        if (serviceBar) {
            serviceBar.style.display = 'none';
        }
        setTimeout(() => {
            if (info) info.style.display = 'none';
            if (serviceBar) serviceBar.style.display = 'flex';
        }, 5000);
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
        console.log(dataSet);
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
        const status = this.shadowRoot.getElementById("agentStatus").textContent;

        if (status != 'IDLE') {
            console.log("agent status is not idle !")
            return false;
        }
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
        const today = new Date();
        const yyyy = today.getFullYear();
        const mm = String(today.getMonth() + 1).padStart(2, '0');
        const dd = String(today.getDate()).padStart(2, '0');
        const currentDate = `${yyyy}-${mm}-${dd}`;

        const dataSet = {
            type: "closeCall",
            disposition: "DISP123",
            callnumber: this.session.callerNumber,
            remarks: "Callback scheduled",
            cbkdate: currentDate,
            main_dispstn_code: "MAIN01",
            sub_dispstn_code: "SUB01",
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


    break(agentId, breakType) {
        const reqObj = {
            type: "break",
            reqtype: "break_start",
            reqtype1: breakType,
            agentId: agentId
        }
        return this.apiPost(url2, reqObj);
    }
    Unbreak() {
        const reqObj = {
            type: "break",
            reqtype: "break_end",
            reqtype1: this.session.BreakName,
            agentId: this.session.agentId
        }
        return this.apiPost(url2, reqObj);
    }

    changeService(agentId, newService) {
        return this.apiPost('/api/changeService', { agentId, newService });
    }

    auto(agentId, autoStatus) {
        return this.apiPost('/api/auto', { agentId, autoStatus });
    }

    transfer(agentId, callId, targetAgent) {
        return this.apiPost('/api/transfer', { agentId, callId, targetAgent });
    }

    conference(agentId, callId, participants) {
        return this.apiPost('/api/conference', { agentId, callId, participants });
    }

    hold(agentId, callId) {
        return this.apiPost('/api/hold', { agentId, callId });
    }

    // request parser function 


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

}

customElements.define('cti-tool', CTITool);
