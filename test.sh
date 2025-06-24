BRANCH_NAME="qcom-next-test"
CURRVER=$(awk '/^VERSION =/ {v=$3} /^PATCHLEVEL =/ {p=$3} /^EXTRAVERSION =/ {e=$3} END {print v "." p e}' Makefile)
TAG_NAME="${BRANCH_NAME}-${CURRVER}-$(date +%Y%m%d)"
TAGS=$(git tag -l "${TAG_NAME}*")
#git push sgaud qcom-next-staging-test:qcom-next-test -f
if ! echo "$TAGS" | grep -q "^${TAG_NAME}$"; then
	echo "$TAG_NAME"
	#git tag "$TAG_NAME"
	echo "Created tag: $TAG_NAME"
	#git push origin $TAG_NAME
else
	i=1
	while echo "$TAGS" | grep -q "^${TAG_NAME}\.${i}$"; do
		((i++))
	done
	TAG_NAME="${TAG_NAME}.${i}"
	#git tag "$NEW_TAG"
	echo "$TAG_NAME"
	echo "Created tag: $TAG_NAME"
	#git push origin $NEW_TAG
fi
	git tag "$TAG_NAME"
