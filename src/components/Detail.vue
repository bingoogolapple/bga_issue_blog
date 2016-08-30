<template>
  <div id="detail">
    <div class="panel-heading">
      <a v-for="tag in activeIssue.labels" href="#" @click="updateActiveLabel(tag)">
        <span class="label label-default" :style="{ backgroundColor: '#' + tag.color }">{{tag.name}}</span>
      </a>
    </div>
    <div class="panel panel-default">
      <div class="panel-body">
        <markdown :comment="activeIssue"></markdown>
        <markdown v-for="comment in comments" :comment="comment"></markdown>
      </div>
    </div>

  </div>
</template>
<script>
  import Markdown from './Markdown.vue'
  import {updateActiveLabel, setComments} from '../vuex/actions'
  import {activeIssue, comments} from '../vuex/getters'

  export default{
    vuex: {
      getters: {
        activeIssue,
        comments
      },
      actions: {
        updateActiveLabel,
        setComments
      }
    },
    watch: {
      activeIssue: function (issue) {
        if (issue.comments > 0) {
          this.$http.get(issue.comments_url).then(function (response) {
            this.setComments(response.json())
          }, function (response) {
            console.log(response.data)
          })
        }
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
