import gleam/erlang/file
import gleam/io
import gleam/result
import gleam_community/ansi
import nakai
import pages/index
import pages/not_found

pub fn ensure_directory(path: String) {
  case file.is_directory(path) {
    True -> Ok(Nil)
    False -> file.make_directory(path)
  }
}

pub fn make_page(route: String) {
  io.println(
    ansi.green("==>") <> " " <> ansi.bold("page") <> " " <> "//" <> route,
  )

  case route {
    "index.html" -> index.page()
    _ -> not_found.page()
  }
  |> nakai.to_string()
  |> file.write("output/" <> route)
}

pub fn main() {
  io.println(ansi.green("==>") <> " Building to output/")
  use _ <- result.then(ensure_directory("output/"))
  use _ <- result.then(make_page("index.html"))
  use _ <- result.then(make_page("404.html"))
  Ok(Nil)
}
