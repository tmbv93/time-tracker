import {Controller} from 'stimulus'
import Feed from 'models/feed'

export default class extends Controller {
    static targets = ['clock']
    static feed;

    connect() {
        this.feed = new Feed()
        setInterval(() => {
            this.updateClock()
        }, 950)
    }

    updateClock() {
        let now = new Date()
        this.clockTarget.textContent = `${now.getHours()}:${('0' + now.getMinutes()).slice(-2)}`
    }
}