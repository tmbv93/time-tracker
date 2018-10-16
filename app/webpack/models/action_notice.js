export default class ActionNotice {
    static success(text){

        $('#action-notice').text(text)
        $('#action-notice').fadeIn(() ->
            $('#action-notice').fadeOut()
    )
    }
}
