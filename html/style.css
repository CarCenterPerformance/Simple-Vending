let currentItems = [];

window.addEventListener('message', function(event) {
    if (event.data.action === 'open') {
        currentItems = event.data.items;
        document.getElementById('item-list').innerHTML = '';
        currentItems.forEach((item, index) => {
            document.getElementById('item-list').innerHTML += `
                <div onclick="setCode(${index})">
                    <img src="img/${item.img}" />
                    <div>${item.label}</div>
                    <div>${String(index).padStart(3, '0')}</div>
                </div>
            `;
        });
        document.querySelector('.vending-ui').style.display = 'flex';
    } else if (event.data.action === 'close') {
        document.querySelector('.vending-ui').style.display = 'none';
    }
});

function closeUI() {
    fetch(`https://${GetParentResourceName()}/close`, {
        method: 'POST'
    });
}

let code = "";
function press(n) {
    if (code.length < 3) code += n;
    document.getElementById('code').innerText = code.padStart(3, '0');
    if (parseInt(code) < currentItems.length) {
        document.getElementById('price').innerText = currentItems[parseInt(code)].price + "$";
    }
}

function clearCode() {
    code = "";
    document.getElementById('code').innerText = "000";
    document.getElementById('price').innerText = "0$";
}

function confirmBuy() {
    const index = parseInt(code);
    if (currentItems[index]) {
        fetch(`https://${GetParentResourceName()}/buy`, {
            method: 'POST',
            body: JSON.stringify(currentItems[index])
        });
    }
    clearCode();
}

function setCode(index) {
    code = String(index);
    document.getElementById('code').innerText = code.padStart(3, '0');
    document.getElementById('price').innerText = currentItems[index].price + "$";
}
