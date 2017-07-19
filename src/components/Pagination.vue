<template>
  <ul class="paginataion-container">
    <span>共110条</span>
    <img class="left-page"/>
    <input type="text" class="current-page" v-model="currentPage" @keyup.enter="changeCurrentPage()"/>
    <span class="page-count">&nbsp;/&nbsp;{{pageCount}}</span>
    <img class="right-page"/>
  </ul>
</template>
<style lang="scss" scoped>
  .paginataion-container {
    width: 365px;
    height: 38px;
    background-color: rgba(0,0,0, 0.1);
    img {
      width: 38px;
      height: 38px;
      content: url("../assets/left-page-normal.png");
    }
  }
  .total-num {
    height: 20px;
    line-height: 20px;
    margin: 9px;
    font-size: 14px;
    color: #4b595f;
  }
  .left-page {
    margin-right: 45px;
  }
  .current-page {
    width: 48px;
    height: 26px;
    border: solid 1px #ebeef0;
    font-size: 14px;
    text-align: center;
    margin-top: 6px;
    color: #03a9f4;
  }
  .page-count {
    height: 16px;
    line-height: 16px;
    margin-top: 11px;
    font-size: 14px;
    color: #4b595f;
    margin-right: 45px;
  }
  .right-page {
  }
</style>
<script>
  export default {
    props: {
      totalNum: {
        type: Number,
        required: true,
        default: 0
      },
      currentPage: {
        type: Number,
        required: true,
        default: 1
      },
      pageSize: {
        type: [Number, String],
        required: false,
        default: 10,
        validator (val) {
          return val >= 3
        }
      }
    },
    data: function () {
      return {
        pageCount: 1
      }
    },
    methods: {},
    mounted: function () {
      this.$nextTick(function () {
        console.log('currentPage', this.currentPage)
        console.log('pageSize', this.pageSize)
        console.log('totalNum', this.totalNum)
      })
    }
  }
</script>
