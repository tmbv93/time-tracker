import {Controller} from 'stimulus'
import Log from 'models/work_session'

export default class extends Controller {
    static targets = ['clock']
    static log;

    connect() {
        this.log = new Log()
        setInterval(() => {this.updateClock()}, 950)
    }

    updateClock() {
        let now = new Date()
        this.clockTarget.textContent = `${now.getHours()}:${('0' + now.getMinutes()).slice(-2)}`
    }

    newDay() {
        this.log.post()
    }
}