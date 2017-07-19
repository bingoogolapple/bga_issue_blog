<template>
  <div v-if="issue" class="blog-detail-container">
    <div class="title-container">
      <span class="title">{{issue.title.trim()}}</span>
      <span class="tag tag-small" v-for="label in issue.labels" @click="setActiveLabel(label)"
            :style="{ backgroundColor: '#' + label.color}">{{label.name}}</span>
      <span class="back" @click="back">
        <img src="../assets/back-icon.svg"
             class="back-icon">返回
      </span>
    </div>
    <div class="comment-container">
      <comment :comment="issue"/>
      <comment v-for="comment in comments" :comment="comment"/>
      <div v-if="issue" @click="remark" class="remark">评论</div>
    </div>
  </div>
</template>
<style lang="scss" scoped>
  @import "../css/common";

  $title-container-height: 80px;

  .blog-detail-container {
    @include heightBox($label-list-height);
  }

  .title-container {
    height: $title-container-height;
    line-height: $title-container-height;
    background-color: #f9fafc;
    padding: 0px 50px;
    span {
      float: left;
    }
    .title {
      font-size: 22px;
      color: #4b595f;
      margin-right: 30px;
    }
    .tag {
      margin-top: 28px;
    }
    .back {
      float: right;
      font-size: 14px;
      color: #4b595f;
      margin-right: 30px;
      cursor: pointer;
      img {
        display: inline-block;
        margin-right: 10px;
        width: 18px;
        height: 12px;
        object-fit: contain;
      }
    }
  }

  .comment-container {
    @include heightBox($title-container-height);
    overflow: scroll;
    padding: 0px 50px;
  }

  .remark {
    cursor: pointer;
    user-select: none;
    margin: 30px 0px;
    height: 50px;
    line-height: 50px;
    text-align: center;
    border-radius: 4px;
    font-size: 16px;
    background-color: #eff7ff;
    color: #3593f2;
    &:hover {
      background-color: #3593f2;
      color: #ffffff;
    }
  }
</style>
<script>
  import { mapActions } from 'vuex'
  import Comment from '../components/Comment.vue'

  export default{
    data () {
      return {
        issue: null,
        number: null,
        comments: []
      }
    },
    components: {Comment},
    methods: {
      ...mapActions([
        'updateActiveLabel'
      ]),
      setActiveLabel (label) {
        this.updateActiveLabel(label)
        this.$router.push('/')
      },
      getComments () {
        if (this.issue && this.issue.comments > 0) {
          this.$gitHubApi.getComments(this, this.issue.comments_url).then(response => {
            this.comments = response.data
          })
        }
      },
      getIssue () {
        this.$gitHubApi.getIssue(this, this.number).then(response => {
          this.issue = response.data
          this.getComments()
        })
      },
      back () {
        this.$router.go(-1)
      },
      remark () {
        window.open(this.issue.html_url)
      }
    },
    created () {
      if (this.$route.params.issue) {
        this.issue = this.$route.params.issue
      } else {
        if (this.$route.params.number) {
          this.number = this.$route.params.number
        } else {
          this.$router.replace('/')
        }
      }
    },
    mounted: function () {
      this.$nextTick(function () {
        if (this.issue) {
          this.getComments()
        } else {
          this.getIssue()
        }
      })
    }
  }
</script>
