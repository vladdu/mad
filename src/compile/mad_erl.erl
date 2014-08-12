-module(mad_erl).
-compile(export_all).
-define(COMPILE_OPTS(Inc, Ebin, Opts), [report, {i, Inc}, {outdir, Ebin}] ++ Opts).

erl_to_beam(Bin, F) -> filename:join(Bin, filename:basename(F, ".erl") ++ ".beam").

compile(File,Inc,Bin,Opt) ->
    BeamFile = erl_to_beam(Bin, File),
    Compiled = mad_compile:is_compiled(BeamFile, File),
    if  Compiled =:= false ->
        io:format("Compiling ~s~n", [File]),
        Opts1 = ?COMPILE_OPTS(Inc, Bin, Opt),
        compile:file(File, Opts1),
        ok;
    true -> ok end.
