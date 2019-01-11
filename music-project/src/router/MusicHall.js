const MusicHall = resolve => require(['@/pages/musicHall/index'], resolve);
const Index = resolve => require(['@/pages/musicHall/index/index'], resolve);
const Singer = resolve => require(['@/pages/musicHall/singer/index'], resolve);
const Album = resolve => require(['@/pages/musicHall/album/index'], resolve);
const Ranking = resolve => require(['@/pages/musicHall/ranking/index'], resolve);
const Category = resolve => require(['@/pages/musicHall/category/index'], resolve);
const Radio = resolve => require(['@/pages/musicHall/radio/index'], resolve);
const Mv = resolve => require(['@/pages/musicHall/Mv/index'], resolve);
const AlbumNum = resolve => require(['@/pages/musicHall/albumNum/index'], resolve);

export default {
    name: 'music-hall',
    path: '/music-hall',
    component: MusicHall,
    children: [
        {
            path: '',
            redirect: 'index'
        },
        {
            name: 'index',
            path: 'index',
            component: Index
        },
        {
            name: 'singer',
            path: 'singer',
            component: Singer
        },
        {
            name: 'album',
            path: 'album',
            component: Album
        },
        {
            name: 'ranking',
            path: 'ranking',
            component: Ranking
        },
        {
            name: 'category',
            path: 'category',
            component: Category
        },
        {
            name: 'radio',
            path: 'radio',
            component: Radio
        },
        {
            name: 'mv',
            path: 'mv',
            component: Mv
        },
        {
            name: 'album-num',
            path: 'album-num',
            component: AlbumNum
        }
    ]
}