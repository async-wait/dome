export function addClass(el, className) {
    if (hasClass(el, className)) {
        return
    }
    let newClass = el.className.split(" ");
    newClass.push(className);
    el.className = newClass.join(" ");
}

export function hasClass(el, className) {
    let reg = new RegExp('(^|\\s)' + className + '(\\s|$)');
    return reg.test(el.className);
}

// 获取dom的自定义属性
export function getData(el, name, val) {
    let prefix = "data-"
    name = prefix + name
    return val ? el.setAttribute(name, val) : el.getAttribute(name)
}