let dragElement;
let zTicker = 0;
window.onload = addListeners;

function surfaceWindow(win) {
   zTicker++;
   win.style.zIndex = zTicker; 
}

function dragStart(header){
   // disable text highlighting
   document.body.style.userSelect = "none"; 

   // set the drag element to the parent (the window)
   dragElement = header.parentElement;

   // solidify the width of the window
   let bounds = header.parentElement.getBoundingClientRect();
   dragElement.style.width = bounds.width;
   dragElement.style.height = bounds.height;

   // bring to forefront
   surfaceWindow(dragElement);

   window.addEventListener('mousemove', divMove, true);
}

function dragEnd(header)
{
   // re-enable text highlighting
   document.body.style.userSelect = ""; 

   // unset the drag element
   dragElement = null;

   window.removeEventListener('mousemove', divMove, true);
}


function divMove(e){
   var div = dragElement;
   div.style.position = 'absolute';
   div.style.top = (e.clientY - 35) + 'px';
   div.style.left = (e.clientX - 35) + 'px';
}
