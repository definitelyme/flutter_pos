#!/usr/bin/env bash
set -euo pipefail

# Rebuilds firebase/emulator-seed. Start empty emulators first:
#   npx -y firebase-tools@15.28.1 emulators:start --project demo-flutter-pos
cd "$(dirname "$0")/../.."

project='demo-flutter-pos'
auth_url="http://localhost:9099/identitytoolkit.googleapis.com/v1/projects/${project}/accounts"
firestore_url="http://localhost:8080/v1/projects/${project}/databases/(default)/documents"
user_id='test-cashier'
timestamp='2026-01-01T09:00:00.000'

send() {
  local method=$1 url=$2 body=$3
  curl -sS --fail-with-body -X "$method" \
    -H 'Authorization: Bearer owner' \
    -H 'Content-Type: application/json' \
    --data "$body" \
    "$url"
  echo
}

put_product() {
  local id=$1 name=$2 price=$3 description=$4
  send PATCH "${firestore_url}/Product/${id}" "{
    \"fields\": {
      \"id\": {\"integerValue\": \"${id}\"},
      \"createdById\": {\"stringValue\": \"${user_id}\"},
      \"name\": {\"stringValue\": \"${name}\"},
      \"imageUrl\": {\"stringValue\": \"\"},
      \"stock\": {\"integerValue\": \"10\"},
      \"sold\": {\"integerValue\": \"0\"},
      \"price\": {\"integerValue\": \"${price}\"},
      \"description\": {\"stringValue\": \"${description}\"},
      \"createdAt\": {\"stringValue\": \"${timestamp}\"},
      \"updatedAt\": {\"stringValue\": \"${timestamp}\"}
    }
  }"
}

echo 'Creating the test account'
send POST "$auth_url" "{
  \"localId\": \"${user_id}\",
  \"email\": \"cashier@flutterpos.test\",
  \"password\": \"cashier123\",
  \"displayName\": \"Test Cashier\"
}"

echo "Writing User/${user_id}"
send PATCH "${firestore_url}/User/${user_id}" "{
  \"fields\": {
    \"id\": {\"stringValue\": \"${user_id}\"},
    \"email\": {\"stringValue\": \"cashier@flutterpos.test\"},
    \"phone\": {\"nullValue\": null},
    \"name\": {\"stringValue\": \"Test Cashier\"},
    \"gender\": {\"nullValue\": null},
    \"birthdate\": {\"nullValue\": null},
    \"imageUrl\": {\"nullValue\": null},
    \"authProvider\": {\"stringValue\": \"email\"},
    \"createdAt\": {\"stringValue\": \"${timestamp}\"},
    \"updatedAt\": {\"stringValue\": \"${timestamp}\"}
  }
}"

echo 'Writing the products'
put_product 1001 'Arabica beans 250g' 85000 'Whole roasted Arabica coffee beans, 250 g bag.'
put_product 1002 'Green tea 20 bags' 25000 'Green tea, a box of 20 tea bags.'
put_product 1003 'Butter croissant' 18000 'Butter croissant, baked fresh each morning.'

echo 'Exporting to firebase/emulator-seed'
npx -y firebase-tools@15.28.1 emulators:export firebase/emulator-seed --force --project "$project"
