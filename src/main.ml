let write_file path content =
  let parent_dir =
    Fpath.of_string path |> Result.get_ok |> Fpath.parent |> Fpath.to_string
  in
  Sys.command ("mkdir -p " ^ parent_dir) |> ignore;
  let oc = open_out path in
  Printf.fprintf oc "%s" content;
  close_out oc

let render_homepage () =
  let html = Templates.Home.make ~posts:Data.Post.all () |> JSX.render in
  write_file "output/index.html" html

let render_post_page (s : Data.Post.t) =
  let html = Templates.Post.render s |> JSX.render in
  write_file ("output/posts/" ^ s.slug ^ "/index.html") html

let render_privacy_policy () =
  let html = Templates.Privacy.make () |> JSX.render in
  write_file "output/privacy/index.html" html

let () =
  render_homepage ();
  render_privacy_policy ();
  Data.Post.all |> List.iter (fun (s : Data.Post.t) -> render_post_page s)
