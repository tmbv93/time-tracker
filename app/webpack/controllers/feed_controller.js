import {Controller} from 'stimulus'
import DataHandler from 'utils/data_handler'
import ActionNotice from 'models/action_notice'

export default class extends Controller {
    static targets = ['activity']
    static targetElement = undefined

    // feed refreshes
    connect() {

    }

    editActivity(event) {
        this.targetElement = this.getFeedTarget(event)
        this.targetElement.classList.remove('display')
        this.targetElement.classList.add('edit')

        this.targetElement.getElementsByTagName('input')[0].focus()
    }

    updateActivity(event) {
        if (this.targetElement !== undefined && this.targetElement.classList.contains('edit')) {
            let newDescription = this.targetElement.getElementsByTagName('input')[0].value
            this.targetElement.classList.add('display')
            this.targetElement.classList.remove('edit')
            this.targetElement.getElementsByTagName('span')[0].innerHTML = newDescription

            DataHandler.updateData(`activities/${this.targetElement.dataset.id}`,
                {activity: {description: newDescription}})
                .then(function (response) {
                        response.json().then(function (response) {
                          ActionNotice.success("Activity updated.")
                        })
                    }
                )
        }
    }

    checkKey(event) {
        if (event.key === 'Enter') {
            this.updateActivity(event)
        }
    }

    getFeedTarget(event) {
        if (event.target.classList.contains('feed-event')) {
            return event.target
        } else {
            return event.target.parentElement
        }
    }
}