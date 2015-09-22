# POSIX clocks

This library provides access to the POSIX clocks.

The [API of ocaml-posix-clock](http://time.forge.ocamlcore.org/doc/) is online at the [OCaml Forge](https://forge.ocamlcore.org/).

## Example

```ocaml
open Posix_clock
open Posix_time

let print_timespec time =
  Printf.printf "s = %s, ns = %s"
    (Int64.to_string Timespec.(time.tv_sec))
    (Int64.to_string Timespec.(time.tv_nsec))

let _ =
  let sec1 = Timespec.create Int64.one Int64.zero in (* 1 second, 0 nanoseconds *)

  nanosleep sec1; (* sleep for sec1 *)

  clock_nanosleep Clock.realtime sec1; (* sleep for sec1 on the realtime clock *)

  match Clock.monotonic with
  | Some monotonic_clock -> clock_nanosleep monotonic_clock sec1 (* sleep for sec1 on the monotonic clock *)
  | None -> print_endline "no monotonic clock available";

  let now = clock_gettime Clock.realtime in (* get the current time on the realtime clock *)
  match now with
  | Result.Ok time -> print_timespec time
  | Result.Error (`EUnix err) -> print_endline (Unix.error_message err)
```

The source code of time is available under the MIT license.

This library is originally written by [Markus Weissmann](http://www.mweissmann.de/)
