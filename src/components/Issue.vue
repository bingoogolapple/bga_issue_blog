<template>
  <div id="issue" class="panel panel-default">
    <div class="panel-heading">
      <a v-for="tag in activeIssue.labels" href="#" @click="updateActiveLabel(tag)">
        <span class="label label-default" :style="{ backgroundColor: '#' + tag.color }">{{tag.name}}</span>
      </a>
    </div>
    <div class="panel-body">
      <comment :comment="activeIssue"></comment>
      <comment v-for="comment in comments" :comment="comment"></comment>
    </div>
  </div>
</template>
<script>
  import { mapGetters, mapActions } from 'vuex'
  import Comment from './Comment.vue'

  export default{
    watch: {
      activeIssue: function (issue) {
        if (issue.comments > 0) {
          this.$http.get(issue.comments_url).then(response => {
            this.setComments(response.data)
          }).catch(response => {
            console.log(response.data)
          })
        }
      }
    },
    components: {Comment},
    computed: {
      ...mapGetters([
        'activeIssue',
        'comments'
      ])
    },
    methods: {
      ...mapActions([
        'updateActiveLabel',
        'setComments'
      ])
    }
  }
</script>
<style lang="scss" scoped>
  #issue {
    margin: 0px;
    float: left;
    width: calc(100% - 590px);
    overflow-y: auto;
    height: 100%;
    .panel-heading {
      a {
        &:hover, &:focus {
          text-decoration: none;
        }
      }
    }
  }
</style>
