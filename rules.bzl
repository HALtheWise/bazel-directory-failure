def impl(ctx):
    d = ctx.actions.declare_directory(ctx.attr.out_dir)

    ctx.actions.run_shell(
        outputs = [d, ctx.outputs.out_file],
        command = "mkdir {}/subdir && touch {}/subdir/file.txt && touch {}".format(
            d.path,
            d.path,
            ctx.outputs.out_file.path,
        ),
    )

    return DefaultInfo(files = depset([d, ctx.outputs.out_file]))

custom_rule = rule(
    implementation = impl,
    attrs = {
        "out_dir": attr.string(),
        "out_file": attr.output(),
    },
)
