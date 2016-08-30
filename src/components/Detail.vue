<template>
  <div id="detail">
    <div class="panel-heading">
      <a v-for="label in activeIssue.labels" href="#" @click="updateActiveLabel(label)">
        <span class="label label-default" :style="background-color:#{{label.color}}">{{label.name}}</span>
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
    width: 450px;
    height: 100%;
    .panel-heading {
      height: 30px;
      overflow-x: auto;
      a {
        &:hover, &:focus {
          text-decoration: none;
        }
      }
    }
    .panel {
      height: calc(100% - 30px);
      overflow-y: auto;
    }
  }
</style>
