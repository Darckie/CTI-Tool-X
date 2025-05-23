const card = document.querySelector('.card');
let offsetX = 0;
let offsetY = 0;
let isDragging = false;

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

//auto logic script---------------------------------------------------------------------------------------1

let autoStatus = false;
const fncTOSetAuto = () => {
  const audio = new Audio('/sound/sound.mp3');
  audio.play();
  const auto = document.getElementById('auto');
  if (autoStatus) {
    auto.src = "/img/auto.png";
    autoStatus = false;

  } else {
    auto.src = "/img/autoOff2.png";
    autoStatus = true;
  }
  console.log(auto.src)
}

document.addEventListener('mouseup', () => {
  isDragging = false;
});


// Dial Logic functionality --------------------------------------------------------------------------------2
const fncTODial = () => {
  const audio = new Audio('/sound/sound.mp3');
  audio.play();
  const pad = document.getElementById('dialpad');
  //others to hide
  const breakBtn = document.getElementById('BreakContainer');
  breakBtn.style.display = 'none';
  if (pad.style.display == 'none') {
    pad.style.display = 'block'
  } else {
    pad.style.display = 'none'
  }

}

function press(value) {
  const input = document.getElementById('dialInput');
  const audio = new Audio('/sound/Tik.mp3');
  audio.play();
  input.value += value;
}

function clearInput() {
  document.getElementById('dialInput').value = '';
}

//fnc to call functionality---------------------------------------------------------------------------------------1.2
const fncTOcall = () => {

  const audio = new Audio('/sound/dialing.mp3');
  audio.play();

  const status = document.getElementById('status_title_id');
  status.innerHTML = "Calling...";
  //others to hide
  const num = document.getElementById('dialInput').value;
  if (num.length != 10) {
    status.innerHTML = "invalid number!";
  } else {
    status.innerHTML = "Calling.... ";
  }
}


//break functionality--------------------------------------------------------------------------------2
const fncTOBreak = () => {
  const audio = new Audio('/sound/sound.mp3');
  audio.play();
  const breakBtn = document.getElementById('BreakContainer');

  //others to hide
  const pad = document.getElementById('dialpad');
  pad.style.display = 'none';
  if (breakBtn.style.display == 'none') {
    breakBtn.style.display = 'block';
  } else {
    breakBtn.style.display = 'none';
  }
}



