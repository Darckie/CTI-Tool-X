const glbl_ext = urlParams.get('ext');
const glbl_pwd = urlParams.get('pwd');
const agentid = urlParams.get('agent_id');
const iscalling = urlParams.get('iscalling');
const ip = "cms.samparkccs.in";
var setIntervalVar;
var usbMicrophoneCheck = false;
var autoAns = true;

function unregisterPhone() {
    try {
        let options = {
            all: true
        };

        coolPhone.unregister(options);
    } catch (e) {
        console.log(e);
    }
}

function getMicrophone() {

    mic = {};
    speaker = {};

    navigator.mediaDevices.enumerateDevices()
            .then(function (devices) {
                mic = {};
                speaker = {};
                devices.forEach(function (device) {

                    if (device.kind == "audioinput" && device.label != "") {

                        if ((device.deviceId).includes("default")) {

                            if ((device.label).includes("USB")) {
                                mic[device.deviceId] = device.label;
                              //  document.getElementById("microphone").innerHTML = mic["default"];
                            } else if (!usbMicrophoneCheck) {
                                mic[device.deviceId] = device.label;
                               // document.getElementById("microphone").innerHTML = mic["default"];
                            }

                        }
                    }

                    if (device.kind == "audiooutput" && device.label != "") {

                        speaker[device.deviceId] = device.label;
                        if (speaker.hasOwnProperty("default")) {
                            document.getElementById("speaker").innerHTML = speaker["default"];
                        }
                    }

                    //console.log(device.kind + ": " + device.label +    " id = " + device.deviceId+"speaker=> "+speaker["default"]);



                });
            }).then(function () {


        if (iscalling == 'Y') {
            if ((Object.keys(mic)).length < 1) {
                logoutCount++;
               // sendAlert("Microphone permission blocked,disabled  or disconnected!");

                if (logoutCount >= 5) {
                 //   unregisterPhone();
                 //   logout();
                }
            } else {
                logoutCount = 0;
            }
        }
    });

}





function log(data) {

    //document.getElementById("log").innerHTML = data;
    //document.getElementById("ext-id").innerHTML = glbl_ext;
}

var socket = new JsSIP.WebSocketInterface('wss://' + ip + ':8089/ws');
var configuration = {
    sockets: [socket],
    uri: 'sip:' + glbl_ext + '@' + ip,
    password: glbl_pwd
};



var coolPhone = new JsSIP.UA(configuration);
coolPhone.on('connected', function (e) {
    log("connected...");
});

coolPhone.on('disconnected', function (e) {
    log("disconnected...");
});


var state = {
    callReceived: autoAns,
    callSession: null,
    fromNumber: null,
    toNumber: null,
};


function mutePhone() {

    if ((state.callSession.isMuted()).audio) {
        state.callSession.unmute();
    } else {
        state.callSession.mute();
    }

}

function answerPhone() {

   // clearInterval(setIntervalVar);

   // pauseAudio();
    const callOptions = {
        mediaConstraints: {
            audio: true, // only audio calls
            video: false
        },
        pcConfig: {
            iceServers: [
                {urls: ["stun:stun.l.google.com:19302"]}
            ],
            iceTransportPolicy: "all",
            rtcpMuxPolicy: "negotiate"
        }
    }

    state.callSession.answer(callOptions);
    state.callSession.connection.addEventListener('addstream', (event) => {

        console.log(event);
        var audioElement = document.getElementById("remote-audio");
        audioElement.srcObject = event.stream
        audioElement.play();

    });
   // document.getElementById("btn_answer").style.display = "none";

}

function holdPhone() {

    if ((state.callSession.isOnHold()).local) {
        state.callSession.unhold();
    } else {
        state.callSession.hold();
    }

}

function hangupPhone() {
    state.callSession.terminate();
}


var wib = self;

var isICEFired = false;

coolPhone.on('newRTCSession', function (e) {

    console.log("RTC.." + e.request);
    if (!autoAns) {
        //answerPhone();
        playAudio();
      
    }

    log("Ringing...");

    getMicrophone();
    //const messages = ServiceContainer.get<MessageManagerInterface>(ServiceTypes.Messages)
    //messages.addAlert('New call')

    const session = e.session
    isICEFired = false;



    session.on('failed', function (e) {

        log("Failed...");

       // pauseAudio();
        //    sendAlert("Microphone permission blocked,disabled  or disconnected!");
      //  window.opener.setFocus("none");
        
    });

    session.on('ended', function (e) {
        log("ended...");
       
        if (!isICEFired) {
          //  sendAlert("Microphone disconnected or not working!");
        }

    });

    coolPhone.on('sipEvent', function (e) {

        console.log(e.event);

    });




    var myCandidateTimeout = null;
    session.on('icecandidate', function (candidate, ready) {
        log("ICE FIRED..");
        isICEFired = true;

        console.log('getting a candidate' + candidate.candidate.candidate);
        if (myCandidateTimeout != null)
            clearTimeout(myCandidateTimeout);

        // 5 seconds timeout after the last icecandidate received!
        myCandidateTimeout = setTimeout(candidate.ready, 1000);

    });

    const numberRegexp = /\"(\d+)\"/
    const fromNumber = "1";//(numberRegexp.exec(e.request.headers.From[0].raw))[1]
    const toNumber = "2";//(numberRegexp.exec(e.request.headers.Contact[0].raw))[1].slice(1)

    state = {
        callReceived: autoAns,
        callSession: session,
        fromNumber: fromNumber,
        toNumber: toNumber,
    };

    if (autoAns) {
        const callOptions = {
            mediaConstraints: {
                audio: true, // only audio calls
                video: false
            },
            pcConfig: {
                iceServers: [
                    {urls: ["stun:stun.l.google.com:19302"]}
                ],
                iceTransportPolicy: "all",
                rtcpMuxPolicy: "negotiate"
            }
        }

        state.callSession.answer(callOptions);

//    var alertaudio = new Audio("beep.mp3");
//    alertaudio.play(); 

        state.callSession.connection.addEventListener('addstream', (event) => {

            console.log(event)
            var audioElement = document.getElementById("remote-audio");
            audioElement.srcObject = event.stream
            audioElement.play();
            /* setState = {
             callAnswered: true,
             callReceived: false,
             }; */


        });
    }

});


coolPhone.on('newMessage', function (e) {
    log("newMessage");
});

coolPhone.on('registered', function (e) {
    log("registered");
    setWin();
});
coolPhone.on('unregistered', function (e) {
    log("unregistered");
});
coolPhone.on('registrationFailed', function (e) {
    log("registrationFailed");
});




setCookie("sip_phone", "false");
//localStorage.setItem("sip_phone_open", "true");
setCookie("sip_phone_open", "true");

setTimeout(function () {


    //localStorage.setItem("sip_phone", "true");
    setCookie("sip_phone", "true");
    coolPhone.start();

    setInterval(function () {

        //var currStatus = localStorage.getItem("sip_phone");
        var currStatus = getCookie("sip_phone");

        var win = window.opener;
        if (currStatus == "logout" || currStatus == "false" || win == null) {
            //localStorage.setItem("sip_phone_open", "false");
            setCookie("sip_phone_open", "false");
           // self.close();
        }

    }, 800);

}, 1000);



var breakFlag = false;





function checksession() {
    return;

    if (!window.opener) {

        self.close();

    }




    var xmlhttp = null;
    if (window.XMLHttpRequest)
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    } else
    {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange = function ()
    {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
        {
            var response = xmlhttp.responseText;
            response = response.trim();
            if (response == "N") {
                try {
                    self.close();
                } catch (e) {
                }
                location.href = "extensionerror.jsp";
            }


        }
    }
    xmlhttp.open("GET", "checksession.jsp?agentid=" + agentid, true);
    xmlhttp.send();

}


setInterval(function () {

    getMicrophone();
    checkAgentOnBreak();
//checkSession();

}, 5000);

window.addEventListener("beforeunload", function (e) {
    //localStorage.setItem("sip_phone_open", "false");
    setCookie("sip_phone_open", "false");
    window.opener.fncHangup();
});



function checkAgentOnBreak() {

    try {
        let agentstatus = window.opener.document.getElementById("agentstatus").innerHTML;
        if (agentstatus.includes("BREAK")) {

            breakFlag = true;
        } else {
            if (breakFlag) {
                location.reload();
            }
        }

    } catch (e) {
        console.log("Error getting break status");
    }

}




setWin();
