import DataHandler from 'utils/data_handler'

export default class Feed {

    newSession() {
        DataHandler.postData('work_sessions', {work_session: {}})
    }

    newActivity(description, workSessionId = 'current') {
        DataHandler.postData(`work_sessions/${workSessionId}/activities`, {
            activity: {description: description}
        })
    }
}
