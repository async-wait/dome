import Vue from 'vue';
import Router from 'vue-router';
import MusicHall from './MusicHall';
import MyMusic from './MyMusic';
import MusicNum from './MusicNum';
Vue.use(Router);

export default new Router({
    routes: [
        {
            path: '/',
            redirect: '/music-hall'
        },
        MusicHall,
        MyMusic,
        MusicNum
    ]
})