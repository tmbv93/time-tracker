export default class DataHandler {
    postData(url, data = {}) {
        // Default options are marked with *
        return fetch(url, {
            method: "POST", // *GET, POST, PUT, DELETE, etc.
            mode: "cors", // no-cors, cors, *same-origin
            cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
            credentials: "same-origin", // include, same-origin, *omit
            headers: {
                "X-CSRF-Token": this.getMetaValue("csrf-token"),
                "Content-Type": "application/json; charset=utf-8",
                // "Content-Type": "application/x-www-form-urlencoded",
            },
            redirect: "follow", // manual, *follow, error
            referrer: "no-referrer", // no-referrer, *client
            body: JSON.stringify(data), // body data type must match "Content-Type" header
        })
            .then(() => {
                alert('here');
            }); // parses response to JSON
    }


    getMetaValue(name) {
        const element = document.head.querySelector(`meta[name="${name}"]`)
        return element.getAttribute("content")
    }
}