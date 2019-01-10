import Vue from 'vue'
import Router from 'vue-router'
import FindMusic from './FindMusic';
import Friend from './friend';
import MyMusic from './MyMusic';
import Personal from './personal'

Vue.use(Router)

export default new Router({
    routes: [
        {
            path: '/',
            redirect: '/find-music'
        },
        FindMusic,
        Friend,
        MyMusic,
        Personal
    ]
})