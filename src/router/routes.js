/**
 * Created by bingoogolapple on 2017/7/14.
 */
import blogRoutes from './blog-routes'

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
    name: 'Blog',
    path: '/Blog',
    component: resolve => require.ensure([], () => resolve(require('@/views/Blog.vue')), 'Blog'),
    children: blogRoutes
  },
  {
    path: '*',
    redirect: '/Blog'
  }
]
