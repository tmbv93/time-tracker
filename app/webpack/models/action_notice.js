export default class ActionNotice {
    static success(text) {
        this.setType('success')
        this.setText(text)
        setTimeout(this.reset, 1000)
    }


    static reset() {
        ActionNotice.setType('initial-state')
        ActionNotice.setText('')
    }

    static setText(text) {
        let html_text_element = document.getElementById('action-notice-text')
        html_text_element.innerHTML = text
    }

    static setType(type) {
        let html_element = document.getElementById('action-notice')
        html_element.className = 'action-notice'
        html_element.classList.add(type)
    }
}
