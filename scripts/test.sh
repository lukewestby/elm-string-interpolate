console_version=$(node -pe 'JSON.parse(process.argv[1])["laszlopandy/elm-console"]' "$(cat elm-stuff/exact-dependencies.json)")
elm-make --yes --output raw-test.js tests/Tests.elm
bash elm-stuff/packages/laszlopandy/elm-console/$console_version/elm-io.sh raw-test.js test.js
node test.js
rm raw-test.js test.js
