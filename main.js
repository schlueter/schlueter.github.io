(function () {
    function removeBareText(elem) {
        function textNodes() {
            return this.nodeType == 3
        }
        elem.contents()
            .filter(textNodes)
            .remove()
    }
    function onReady() {
        removeBareText($('.container'))
    }
    $(window).ready(onReady())
})()
