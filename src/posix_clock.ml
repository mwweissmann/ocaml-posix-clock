external clock_initialize : unit -> (
      int * int option * int option * int option *
      int option * int option * int option * int option *
      int option * int option * int option * int option *
      int option * int option * int option * int option *
      int option * int option
    ) = "clock_initialize"

module Clock = struct
  type t = int

  let (
    realtime,
    monotonic,
    process_cputime_id,
    thread_cputime_id,
    boottime,
    monotonic_coarse,
    monotonic_fast,
    monotonic_precise,
    monotonic_raw,
    prof,
    realtime_coarse,
    realtime_fast,
    realtime_precise,
    second,
    uptime,
    uptime_fast,
    uptime_precise,
    virtual_
  ) = clock_initialize ()
end

external clock_getcpuclockid : int -> (Clock.t, [>`EUnix of Unix.error]) Result.result = "time_clock_getcpuclockid"

external clock_gettime : Clock.t -> (Posix_time.Timespec.t, [>`EUnix of Unix.error]) Result.result = "time_clock_gettime"

external clock_getres : Clock.t -> (Posix_time.Timespec.t, [>`EUnix of Unix.error]) Result.result = "time_clock_getres"

external clock_settime : Clock.t -> Posix_time.Timespec.t -> (unit, [>`EUnix of Unix.error]) Result.result = "time_clock_settime"

external nanosleep : Posix_time.Timespec.t -> ((Posix_time.Timespec.t option), [> `EUnix of Unix.error]) Result.result = "time_nanosleep"

external clock_nanosleep : Clock.t -> ?abs:bool -> Posix_time.Timespec.t -> ((Posix_time.Timespec.t option), [> `EUnix of Unix.error]) Result.result = "time_clock_nanosleep"

(*
external timer_create : Clock.t -> Sigevent.t -> (timer, [>`EUnix of Unix.error]) Result.result = "time_timer_create"
*)

