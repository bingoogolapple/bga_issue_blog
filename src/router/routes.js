/**
 * Created by bingoogolapple on 2017/7/14.
 */
import mainRoutes from './main-routes'

/**
 * 路由表配置
 */
export default [
  {
    name: 'AboutMe',
    path: '/AboutMe',
    component: resolve => require.ensure([], () => resolve(require('@/views/AboutMe.vue')), 'AboutMe')
  },
  {
    name: 'GitHub',
    path: '/GitHub',
    component: resolve => require.ensure([], () => resolve(require('@/views/GitHub.vue')), 'GitHub')
  },
  {
    path: '/',
    component: resolve => require.ensure([], () => resolve(require('@/views/Blog.vue')), 'Blog'),
    children: mainRoutes
  },
  {
    path: '*',
    redirect: '/'
  }
]
