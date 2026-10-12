return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node

    -- Snippets para Vue/Nuxt Components
    ls.add_snippets("vue", {
      -- NuxtLink
      s("nuxtlink", {
        t('<NuxtLink to="'),
        i(1, "/path"),
        t('">'),
        i(2, "Link Text"),
        t('</NuxtLink>'),
      }),

      -- NuxtPage
      s("nuxtpage", {
        t('<NuxtPage />'),
      }),

      -- NuxtLayout
      s("nuxtlayout", {
        t('<NuxtLayout name="'),
        i(1, "default"),
        t('">'),
        t({ '', '  ' }),
        i(2, ''),
        t({ '', '</NuxtLayout>' }),
      }),

      -- NuxtLoadingIndicator
      s("nuxtloading", {
        t('<NuxtLoadingIndicator />'),
      }),

      -- NuxtErrorBoundary
      s("nuxterror", {
        t('<NuxtErrorBoundary>'),
        t({ '', '  ' }),
        i(1, ''),
        t({ '', '  <template #error="{ error }">' }),
        t({ '', '    ' }),
        i(2, '{{ error }}'),
        t({ '', '  </template>' }),
        t({ '', '</NuxtErrorBoundary>' }),
      }),
    })

    -- Snippets para Composables do Nuxt
    ls.add_snippets("vue", {
      -- useFetch
      s("usefetch", {
        t('const { data, pending, error, refresh } = await useFetch("'),
        i(1, "/api/endpoint"),
        t('")'),
      }),

      -- useAsyncData
      s("useasyncdata", {
        t('const { data, pending, error, refresh } = await useAsyncData("'),
        i(1, "key"),
        t('", () => $fetch("'),
        i(2, "/api/endpoint"),
        t('"))'),
      }),

      -- useState
      s("usestate", {
        t('const '),
        i(1, "state"),
        t(' = useState("'),
        i(2, "key"),
        t('", () => '),
        i(3, "initialValue"),
        t(')'),
      }),

      -- useRoute
      s("useroute", {
        t('const route = useRoute()'),
      }),

      -- useRouter
      s("userouter", {
        t('const router = useRouter()'),
      }),

      -- useHead
      s("usehead", {
        t('useHead({'),
        t({ '', '  title: "' }),
        i(1, "Page Title"),
        t('",'),
        t({ '', '  meta: [' }),
        t({ '', '    { name: "description", content: "' }),
        i(2, "Page description"),
        t('" },'),
        t({ '', '  ],' }),
        t({ '', '})' }),
      }),

      -- useSeoMeta
      s("useseometa", {
        t('useSeoMeta({'),
        t({ '', '  title: "' }),
        i(1, "Page Title"),
        t('",'),
        t({ '', '  ogTitle: "' }),
        i(2, "OG Title"),
        t('",'),
        t({ '', '  description: "' }),
        i(3, "Page description"),
        t('",'),
        t({ '', '  ogDescription: "' }),
        i(4, "OG Description"),
        t('",'),
        t({ '', '})' }),
      }),

      -- useServerSeoMeta
      s("useserversseometa", {
        t('useServerSeoMeta({'),
        t({ '', '  title: "' }),
        i(1, "Page Title"),
        t('",'),
        t({ '', '  ogTitle: "' }),
        i(2, "OG Title"),
        t('",'),
        t({ '', '  description: "' }),
        i(3, "Page description"),
        t('",'),
        t({ '', '  ogDescription: "' }),
        i(4, "OG Description"),
        t('",'),
        t({ '', '})' }),
      }),
    })
  end,
}
