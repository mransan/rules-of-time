

all: rules_of_time_typed.ml rules_of_time_dynamic.ml
	ocamlc ./rules_of_time_typed.ml -o rules_of_time_typed.run
	ocamlc ./rules_of_time_dynamic.ml -o rules_of_time_dynamic.run
	./rules_of_time_typed.run

clean:
	rm -f *.cm*
	rm -f *.run
