for commit in $(git log --reverse --since=yesterday --pretty=%H); do
  git cherry-pick $commit
done
