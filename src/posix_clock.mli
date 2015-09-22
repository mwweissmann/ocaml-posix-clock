(*
Copyright (c) 2015 Markus W. Weissmann <markus.weissmann@in.tum.de>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*)

(** POSIX clocks

  @author Markus W. Weissmann
*)

module Clock :
(** The known clocks. Only some of these are supported by operating systems:
    If a particular clock is found, it's value is set to [Some clock] else to
    [None]. *)
  sig

  type t
  (** clock identifier type *)

  val realtime : t
  (** This clock represents the clock measuring real time for the system.
      The value returned representes the amount of time since the Epoch. *)

  val monotonic : t option
  (** This clock represents a monotonic time with an unspecified point in the
      past. *)

  val process_cputime_id : t option
  (** This clock represents the amount of execution time of the process
      associated with the clock *)

  val thread_cputime_id : t option
  (** This clock represents the amount of exection time of the thread
      associated with the clock *)

  val boottime : t option
  val monotonic_coarse : t option
  val monotonic_fast : t option
  val monotonic_precise : t option
  val monotonic_raw : t option
  val prof : t option
  val realtime_coarse : t option
  val realtime_fast : t option
  val realtime_precise : t option
  val second : t option
  val uptime : t option
  val uptime_fast : t option
  val uptime_precise : t option
  val virtual_ : t option
end

val clock_getres : Clock.t -> (Posix_time.Timespec.t, [>`EUnix of Unix.error]) Result.result
(** [clock_getres clock] returns the resolution (precision) of the specified
    clock.
    If the clock [clock] is not supported by the operating system, [Error]
    is returned.  *)

val clock_gettime : Clock.t -> (Posix_time.Timespec.t, [>`EUnix of Unix.error]) Result.result
(** [clock_gettime clock] retrieves the time of the clock [clock].
    If the clock [clock] is not supported by the operating system, [Error]
    is returned.  *)

val clock_settime : Clock.t -> Posix_time.Timespec.t -> (unit, [>`EUnix of Unix.error]) Result.result
(** [clock_settime clock time] sets the time of the clock [clock] to [time].
    If the clock [clock] is not supported by the operating system, [Error]
    is returned.  *)

val nanosleep : Posix_time.Timespec.t -> ((Posix_time.Timespec.t option), [> `EUnix of Unix.error]) Result.result
(** [nanosleep time] lets the system sleep for [time]. If the call was
    interrupted by a signal, the [Ok] return value will bring [Some time] value
    carrying the remaining time -- otherwise [None]. *)

val clock_nanosleep : Clock.t -> ?abs:bool -> Posix_time.Timespec.t -> ((Posix_time.Timespec.t option), [> `EUnix of Unix.error]) Result.result
(** [clock_nanosleep clock time ~abs:a] lets the system sleep for [time]. The
    duration is based on the clock [clock]. [time] either gives a relative time
    when [~abs] is false or an absolute time when [~abs] is true. The default
    case is relative time.
    The return value is analog to [nanosleep]. *)

val clock_getcpuclockid : int -> (Clock.t, [>`EUnix of Unix.error]) Result.result
(** [clock_getcpuclockid pid] returns the clock for the process of the given
    process-id [pid]. *)

