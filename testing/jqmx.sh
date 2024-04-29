grep '^{' ./allstar.log |
 jq --slurp '[.[] | select(.enabled == true and .message == "Policy run result.") ] |
 group_by(.repo) | map({
  repository: .[0].repo,
  summary: {
    passed: map(select(.result == true)| .area),
    failed: map(select(.result == false)| .area)
  }
})' > by_repo.json

grep '^{' ./allstar.log |
 jq --slurp '[.[] | select(.enabled == true and .message == "Policy run result.") ] |
 group_by(.area) | map({
  area: .[0].area,
  summary: {
    passed: map(select(.result == true)| .repo),
    failed: map(select(.result == false)| .repo)
  }
})' > by_area.json
