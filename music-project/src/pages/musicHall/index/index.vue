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
                    for (let i = 0; i < 5; i++) {
                        this.content[0].data[i] = result.splice(0, 5);
                    }
                })
                .catch(err => {
                    console.log(err);
                });
        }
    }
}
</script>

<style lang="less" scoped>
    .music-hall-index {
        color: #000;
    }
</style>

