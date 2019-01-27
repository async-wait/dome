<template>
    <div class="music-hall-index">
        <personalized v-for="(item, index) in content"
            :key="index"
            :bgcolor="item.bgcolor"
            :title="item.title"
            :tab="item.tab"
            :data="item.data"
            :className="item.class"
        ></personalized>
    </div>
</template>

<script>
import Personalized from './personalized/personalized';
import {getPersonalized, getNewMusic, getRanking} from '@/api/musicHall/index';
export default {
    name: 'music-hall-index',
    data() {
        return {
            content: [
                {
                    title: '歌单推荐',
                    bgcolor: 'gray',
                    tab: [],
                    class: 'recommend',
                    data: []
                },
                {
                    title: '新歌首发',
                    bgcolor: '',
                    tab: ['全部', '华语', '欧美', '日本', '韩国'],
                    class: 'new-music',
                    data: []
                },
                {
                    title: '排行榜',
                    bgcolor: 'gray',
                    tab: [],
                    class: 'ranking',
                    data: {
                        liux: [],
                        hotMusic: [],
                        newMusic: [],
                        es: [],
                        hguo: []
                    }
                },
                {
                    title: 'MV',
                    bgcolor: '',
                    tab: ['精选', '内地', '韩国','欧美', '日本', '港台'],
                    class: 'mv',
                    data: []
                }
            ]
        }
    },
    components: {
        Personalized
    },
    mounted () {
        this.$nextTick(() => {
            this._getPersonalized();
            this._getNewMusic();
            this._getRanking();
        });
    },
    methods: {
        // 歌单推荐
        _getPersonalized() {
            getPersonalized()
                .then((res) => {
                    let result = res.data.result;
                    this.content[0].data = this.getDataArr(result, 5);
                })
                .catch(err => {
                    console.log(err);
                });
        },
        // 新歌速递
        _getNewMusic() {
            getNewMusic()
                .then((res) => {
                    let result = res.data.data;
                    this.content[1].data = this.getDataArr(result, 9);
                })
                .catch(err => {
                    console.log(err);
                });
        },
        _getRanking() {
            let arr = [0, 1, 3, 6, 11];
            arr.forEach((v, i) => {
                getRanking({idx: v})
                    .then((res) => {
                        console.log(res);
                    })
                    .catch(err => {
                        console.log(err);
                    });
            });
        },
        /**
         * @param {Object} data要处理的数据
         * @param {Number} num分页一张要显示多少数据
         * @return {Array} arr返回数组
         */
        getDataArr(data, num) {
            let arr = [];
            for (let i = 0; i < num; i++) {
                arr[i] = data.splice(0, num);
            }
            return arr;
        }
    }
}
</script>

<style lang="less" scoped>
    .music-hall-index {
        color: #000;
    }
</style>

