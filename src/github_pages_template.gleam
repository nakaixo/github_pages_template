import gleam/io
import gleam_community/ansi
import nakai
import pages/index
import pages/not_found
import simplifile as file

pub fn make_page(route: String) {
  io.println(
    ansi.green("==>") <> " " <> ansi.bold("page") <> " " <> "//" <> route,
  )

  case route {
    "index.html" -> index.page()
    _ -> not_found.page()
  }
  |> nakai.to_string()
  |> file.write(to: "output/" <> route)
}

pub fn main() {
  io.println(ansi.green("==>") <> " Building to output/")
  let assert Ok(_) = file.create_directory_all("output/")
  let assert Ok(_) = make_page("index.html")
  let assert Ok(_) = make_page("404.html")
  Ok(Nil)
}
