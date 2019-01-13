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
        <!-- <div v-for="(item, index) in cont" :key="index">{{item.data}}</div> -->
    </div>
</template>

<script>
import Personalized from './personalized/personalized';
import {getPersonalized} from '@/api/musicHall/index';
export default {
    name: 'music-hall-index',
    data() {
        return {
            content: [
                {
                    class: 'recommend',
                    title: '歌单推荐',
                    bgcolor: 'gray',
                    tab: [],
                    data: []
                },
                {
                    title: '新歌首发',
                    bgcolor: '',
                    tab: ['内地', '港台', '欧美', '日本', '韩国'],
                    class: 'new-music',
                    data: []
                },
                {
                    title: '排行榜',
                    bgcolor: 'gray',
                    tab: [],
                    class: 'ranking',
                    data: []
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
        });
    },
    methods: {
        _getPersonalized() {
            getPersonalized({type: 96})
                .then((res) => {
                    let result = res.data.result;
                    this.content[0].data = this.getDataArr(result, 5);
                })
                .catch(err => {
                    console.log(err);
                });
        },
        getDataArr(data, num) {
            let arr = [];
            for (let i = 0; i < num; i++) {
                arr[i] = data.splice(0, 5);
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

