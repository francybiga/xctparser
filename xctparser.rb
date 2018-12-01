def parse_file(filename)
  ast = `swiftc -print-ast #{filename} 2> /dev/null`

  replacement_map = {"final" => "",
                     "private" => "",
                     "public" => "",
                     "internal" => "",
                     "extension " => "class ",
                     ":" => " : ",
                     "  " => " ", #TODO: verifica se necessario
                     " func " => "func ",
                     "^\s+" => ""}
  replacement_map.each do |k, v|
    ast = ast.gsub(/#{k}/, v)
  end
  ast_lines = ast.split("\n")

  class_mark = "class "
  func_mark = "func "

  curr_class_name = nil
  currentProtocols = []
  #current_set = Set[]

  ast_lines.each do |line|
    if (line.start_with?(class_mark) && (curr_class_name == nil))
      class_name = line.split(" ")[1]
      puts class_name
    end
  end
end

parse_file("AutologinPresenterUITests.swift")
