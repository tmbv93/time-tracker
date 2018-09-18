import DataHandler from 'utils/data_handler'

export default class WorkSession {
    post () {
        new DataHandler().postData('work_sessions', {work_session: {}})
    }
}
