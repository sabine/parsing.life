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

let render_post_page (post : Data.Post.t) =
  let meta =
    Templates.Layout.
      {
        description = post.summary;
        image = "https://parsing.life/" ^ post.image_src;
        url = "https://parsing.life" ^ post.url;
      }
  in
  let html = Templates.Post.render ~meta post |> JSX.render in
  write_file ("output" ^ post.url ^ "/index.html") html

let render_privacy_policy () =
  let html = Templates.Privacy.make () |> JSX.render in
  write_file "output/privacy/index.html" html

let render_imprint () =
  let html = Templates.Imprint.make () |> JSX.render in
  write_file "output/imprint/index.html" html

let () =
  render_homepage ();
  render_privacy_policy ();
  render_imprint ();
  Data.Post.all |> List.iter (fun (s : Data.Post.t) -> render_post_page s)
