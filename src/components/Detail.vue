<template>
  <div id="detail">
    <div class="panel-heading">
      <a v-for="tag in activeIssue.labels" href="#" @click="updateActiveLabel(tag)">
        <span class="label label-default" :style="{ backgroundColor: '#' + tag.color }">{{tag.name}}</span>
      </a>
    </div>
    <div class="panel panel-default">
      <div class="panel-body">
        <markdown></markdown>
      </div>
    </div>
  </div>
</template>
<script>
  import Markdown from './Markdown.vue'
  import {updateActiveLabel} from '../vuex/actions'
  import {activeIssue} from '../vuex/getters'

  export default{
    data: function () {
      return {
        testColor: 'FF0000'
      }
    },
    vuex: {
      getters: {
        activeIssue
      },
      actions: {
        updateActiveLabel
      }
    },
    components: {Markdown}
  }
</script>
<style lang="scss" scoped>
  #detail {
    float: left;
    width: calc(100% - 580px);
    overflow: auto;
    height: 100%;
    .panel-heading {
      height: 40px;
      overflow: auto;
      a {
        &:hover, &:focus {
          text-decoration: none;
        }
      }
    }
    .panel {
      height: calc(100% - 40px);
      overflow: auto;
    }
  }
</style>
