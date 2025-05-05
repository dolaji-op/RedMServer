$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }
    display(false)

    window.addEventListener('message', function(event) {
        if (event.data.type == "open"){
            display(true)
            set_input_info(event.data.title, event.data.subtext)
            console.log(event.data.title, event.data.subtext)
        } else {
            display(false)       
        }
    })
})

function set_input_info(title, subtext) {
    document.getElementById("header").innerHTML = title;
    document.getElementById("button_2").innerHTML = subtext;
}

function send_values() {
    let text_value = document.getElementById("text_input").value;
    $.post('https://bulgar_inputs/button_2', JSON.stringify({ text: text_value }));
    document.getElementById("form_id").reset();
}

function close_input() {
     document.getElementById("form_id").reset();
   $.post('https://bulgar_inputs/button_1', JSON.stringify({ text: "close" }));
}