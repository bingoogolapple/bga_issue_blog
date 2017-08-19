<template>
  <div class="comment">
    <div class="comment-title">
      <div @click="openGitHub()">
        <img :src="comment.user.avatar_url">
        <span>{{comment.user.login}}</span>
      </div>
      <span class="time">{{$moment(comment.created_at).format('YYYY-MM-DD HH:mm')}}</span>
    </div>
    <article class="comment-body markdown-body" v-html="comment.body_html"/>
  </div>
</template>
<style lang="scss" scoped>
  .comment {
    margin-top: 30px;
    border-radius: 4px;
    border: solid 1px #eeeeee;
  }

  .comment-title {
    height: 48px;
    line-height: 48px;
    background-color: #f9fafc;
    border-bottom: solid 1px #eeeeee;
    padding: 0px 30px;
    div {
      cursor: pointer;
      float: left;
      img {
        float: left;
        width: 30px;
        height: 30px;
        margin-top: 9px;
        border-radius: 15px;
        margin-right: 12px;
      }
      span {
        font-size: 14px;
        color: #4b595f;
      }
    }
    .time {
      float: right;
      margin-right: 20px;
      font-size: 12px;
      color: #849aa4;
    }
  }

  .comment-body {
    padding: 15px;
    font-size: 14px;
  }
</style>
<script>
  export default {
    props: ['comment'],
    methods: {
      openGitHub () {
        window.open(this.comment.user.html_url)
      }
    }
  }
</script>
