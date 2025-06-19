// Hi my existence is a bit of a mess,My name is Kunwar and this is a CTI tool a web component that provides a CTI (Computer Telephony Integration) tool for agents.

class CTITool extends HTMLElement {
    constructor() {
        super();
        this.attachShadow({ mode: 'open' });
    }

    connectedCallback() {
        //AGENT LOGIN STATUS-----------------------------------
        // const agentId = "Mohan das karamchand Gandhi";
        const agentId = localStorage.getItem('agentId');

        if (!agentId) {
            // fetch('login.html').then(res => res.text()).then(html => {
            //     this.shadowRoot.innerHTML = html;
            //     this.initloginlogic();
            // });
            Promise.all([
                fetch('login.css').then(res => res.text()),
                fetch('login.html').then(res => res.text())
            ])
                .then(([css, html]) => {
                    this.shadowRoot.innerHTML = `<style>${css}</style>${html}`;
                    this.initLoginLogic();
                });
        } else {
            this.renderTool();

        }
    }
    renderTool() {
        Promise.all([
            fetch('style.css').then(res => res.text()),
            fetch('tool.html').then(res => res.text())
        ])
            .then(([css, html]) => {
                this.shadowRoot.innerHTML = `<style>${css}</style>${html}`;
                this.initLogic();
            });
    }
    initLoginLogic() {
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
        const loginBtn = shadow.getElementById('loginBtn');
        if (loginBtn) {
            loginBtn.addEventListener('click', () => {
                const agentIdInput = shadow.getElementById('agentId');
                const agentPasswordInput = shadow.getElementById('agentPassword');
                const agentId = agentIdInput.value.trim();
                const agentPassword = agentPasswordInput.value.trim();
                if (agentId && agentPassword) {

                    // fnc to login to server-------------------------
                    this.loginToServer(agentId, agentPassword)   // 
                        .then(response => {
                            if (response.success) {
                                // Save to localStorage
                                localStorage.setItem('agentId', agentId);
                                localStorage.setItem('agentPassword', agentPassword);
                                // Render tool.html
                                this.renderTool();
                            } else {
                                // Show error or feedback
                                shadow.getElementById('errorMsg').textContent = response.message;
                            }
                        })
                        .catch(error => {
                            console.error('Login error:', error);
                            shadow.getElementById('errorMsg').textContent = "Login failed. Please try again.";
                        });
                } else {
                    // Show error or feedback
                    shadow.getElementById('errorMsg').textContent = "Please enter both fields";
                }
            });
        }
    }

    initLogic() {
        const shadow = this.shadowRoot;
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




        // Dial Button
        const dialBtn = shadow.querySelector('.smBox:nth-child(1)');
        const dialPad = shadow.getElementById('dialpad');
        dialBtn.addEventListener('click', () => {
            this.playSound('/sound/sound.mp3');
            this.hideElement('BreakContainer');
            this.hideElement('statusCard');
            this.toggleDisplay(dialPad);
        });

        // Break Button
        const breakBtn = shadow.querySelector('.smBox:nth-child(6)');
        const breakContainer = shadow.getElementById('BreakContainer');
        breakBtn.addEventListener('click', () => {
            this.playSound('/sound/sound.mp3');
            this.hideElement('dialpad');
            this.hideElement('statusCard');
            this.toggleDisplay(breakContainer);
        });

        // Auto Toggle Button
        let autoStatus = false;
        const autoBtn = shadow.querySelector('.smBox:nth-child(9)');
        const autoImg = shadow.getElementById('auto');
        autoBtn.addEventListener('click', () => {
            this.playSound('/sound/sound.mp3');
            autoImg.src = autoStatus ? '/img/auto.png' : '/img/autoOff2.png';
            autoStatus = !autoStatus;
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

        // Call Button
        const callBtn = shadow.getElementById('callBtn');
        const statusTitle = shadow.getElementById('status_title_id');

        callBtn.addEventListener('click', () => {
            const num = input.value.trim();
            if (num.length !== 10) {
                statusTitle.innerHTML = "Invalid number!";
                return;
            } else {
                statusTitle.innerHTML = "Calling...";
            }
            this.playSound('/sound/dialing.mp3');
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
        // ...existing code...

        // Break Done Button Logic
        const unbreakBtn = shadow.getElementById('unbreakBtn');
        if (unbreakBtn) {
            unbreakBtn.addEventListener('click', () => {
                // Find the checked radio input inside the break list

                const password = shadow.getElementById('agentpassword').value;
                if (password == '1234') {
                    shadow.getElementById('agentpassword').value = '';
                    const breakStatus = this.shadowRoot.getElementById('breakStatus');
                    const breakContainer = this.shadowRoot.getElementById('BreakContainer');
                    breakContainer.style.display = 'none';
                    const breakList = this.shadowRoot.getElementById('breakList');
                    breakStatus.style.display = 'none';
                    breakList.style.display = 'block';
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
        // You can trigger further actions here

    }

    // ...existing code...
    loginToServer(agentId, agentPassword) {
        // Simulate a server login request

        return new Promise((resolve) => {
            setTimeout(() => {
                // Simulate a successful login
                resolve({ success: true });
            }, 1000);
        });
    }
    // async loginToServer(agentId, agentPassword) {
    //     // Make an API call to your server for authentication
    //     try {
    //         const response = await fetch('/api/login', {
    //             method: 'POST',
    //             headers: { 'Content-Type': 'application/json' },
    //             body: JSON.stringify({ agentId, agentPassword })
    //         });
    //         return await response.json();
    //     } catch (error) {
    //         return { success: false, message: 'Network error' };
    //     }
    // }






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
            statusCard.style.display = 'flex';
        }
        // element.style.display = (element.style.display === 'none') ? 'block' : 'none';
    }

    hideElement(id) {
        const el = this.shadowRoot.getElementById(id);
        if (el) el.style.display = 'none';


    }
}

customElements.define('cti-tool', CTITool);
