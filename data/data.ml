module Post = struct
  type metadata = {
    slug : string;
    title : string;
    date_published : string;
    image_src : string;
    content : string;
  }
  [@@deriving of_yaml]

  type metadata_list = metadata list [@@deriving of_yaml]

  type t = {
    slug : string;
    title : string;
    date_published : string;
    image_src : string;
    html_content : string;
  }

  let of_metadata (m : metadata) : t =
    {
      slug = m.slug;
      title = m.title;
      date_published = m.date_published;
      image_src = m.image_src;
      html_content =
        Cmarkit_html.of_doc ~safe:false
          (* (Hilite.Md.transform *)
          (Cmarkit.Doc.of_string ~strict:true (String.trim m.content) (* ) *));
    }

  let decode data =
    let metadata = metadata_list_of_yaml data in
    Result.map (List.map of_metadata) metadata

  let all =
    Read_yaml.yaml_file decode "posts.yml"
    |> Read_yaml.Result.get_ok ~error:(fun (`Msg m) -> Invalid_argument m)
end
