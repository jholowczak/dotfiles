function _tide_item_jj
    if not command -sq jj; or not jj root --quiet &>/dev/null
            return 1
        end

        set jj_bookmark (jj log -r@ -n1 --ignore-working-copy --no-graph --color always -T '
          separate(" ",
            bookmarks.map(|x| if(
              x.name().substr(0, 10).starts_with(x.name()),
              x.name().substr(0, 10),
              x.name().substr(0, 9) ++ "…")
            ).join(" "))')
        set jj_tags (jj log -r@ -n1 --ignore-working-copy --no-graph --color always -T '
          separate(" ",
            tags.map(|x| if(
              x.name().substr(0, 10).starts_with(x.name()),
              x.name().substr(0, 10),
              x.name().substr(0, 9) ++ "…")
            ).join(" "))')
        set jj_change_id (jj log -r@ -n1 --ignore-working-copy --no-graph --color always -T '
          separate(" ",
            change_id.shortest())')
        set jj_commit_id (jj log -r@ -n1 --ignore-working-copy --no-graph --color always -T '
          separate(" ",
            commit_id.shortest())')
        set jj_current (jj log -r@ -n1 --ignore-working-copy --no-graph --color always -T '
          separate(" ",
            if(empty, "(e)"),
            if(conflict, "(c)"),
            if(divergent, "(d)"),
            if(hidden, "(h)")
          )
        ' | string trim)
        _tide_print_item jj $_tide_location_color$tide_jj_icon' ' (
            set_color black; echo -ns '('
            set_color normal; echo -ns "$jj_bookmark $jj_tags $jj_change_id $jj_commit_id $jj_current"
            set_color black; echo -ns ')'
        )
end
