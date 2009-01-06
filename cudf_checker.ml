(*****************************************************************************)
(*  libCUDF - CUDF (Common Upgrade Description Format) manipulation library  *)
(*  Copyright (C) 2009  Stefano Zacchiroli <zack@pps.jussieu.fr>             *)
(*                                                                           *)
(*  This program is free software: you can redistribute it and/or modify     *)
(*  it under the terms of the GNU General Public License as published by     *)
(*  the Free Software Foundation, either version 3 of the License, or (at    *)
(*  your option) any later version.                                          *)
(*                                                                           *)
(*  This program is distributed in the hope that it will be useful, but      *)
(*  WITHOUT ANY WARRANTY; without even the implied warranty of               *)
(*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU        *)
(*  General Public License for more details.                                 *)
(*                                                                           *)
(*  You should have received a copy of the GNU General Public License        *)
(*  along with this program.  If not, see <http://www.gnu.org/licenses/>.    *)
(*****************************************************************************)

open ExtLib
open Printf

open Cudf

type solution	(* TODO *)

let solution univ = assert false	(* TODO *)

let is_consistent univ =
  let msg = ref "" in
  let rec satisfied = function
    | FTrue -> true
    | FPkg pkg ->
	mem_package ~only_installed:true ~include_features:true univ pkg
    | FOr fmlas -> List.exists satisfied fmlas
    | FAnd fmlas -> List.for_all satisfied fmlas in
  let disjoint = List.for_all (fun pkg -> not (mem_package univ pkg)) in
    try
      iter_packages univ
	(fun pkg ->
	   if not (satisfied pkg.depends) then begin
	     msg := sprintf "Cannot satisfy dependency: %s" (dump pkg.depends);
	     raise Exit
	   end;
	   if not (disjoint pkg.conflicts) then begin
	     msg := sprintf "Unsolved conflicts: %s" (dump pkg.conflicts);
	     raise Exit
	   end);
      true, !msg
    with Exit -> false, !msg

(* TODO implement is_solution *)
let is_solution inst sol =
  eprintf "WARNING: Cudf_checker.is_solution not implement yet; dummy answer.";
  true, ""

