import axios from 'axios';

const instance = axios.create({
    baseURL: 'http://localhost:3000',
    timeout: 2500,
    headers: {
        'X-Requested-With': 'XMLHttpRequest'
    }
});

const $axios = {
    get(url) {
        return function (params) {
            return instance.get(url, params);
        }
    },
    post(url) {
        return function (data) {
            return instance({
                methods: 'post',
                url,
                data,
                headers: {
                    'Common-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
                }
            });
        }
    }
}

export default $axios;
