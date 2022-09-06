# iOS 개발 규칙

## Code Convention
- [AppleDeveloperAcademy Swift Style Guide](https://github.com/DeveloperAcademy-POSTECH/swift-style-guide)

## Commit Message Rules
- `feat`: 새로운 기능 추가
- `fix`: 버그 수정
- `docs`: 문서 수정
- `test`: 테스트 코드 추가
- `refactor`: 코드 리팩토링
- `style`: 코드 의미에 영향을 주지 않는 변경사항
- `chore`: 빌드 부분 혹은 패키지 매니저 수정사항
- `init`: 프로젝트 초기 셋팅

## Git branch (Git-flow)
- `master` : 기준이 되는 브랜치로 제품을 배포하는 브랜치
- `develop` : 개발 브랜치로 개발자들이 이 브랜치를 기준으로 각자 작업한 기능들을 병합
- `feature` : 단위 기능을 개발하는 브랜치로 기능 개발이 완료되면 merge_v2 브랜치에 병합
- `release` : 배포를 위해 master 브랜치로 보내기 전에 먼저 QA(품질검사)를 하기위한 브랜치
- `hotfix` : 배포 후 급한 수정사항을 반영 하기위한 브랜치

1. master_v2 브랜치에서 merge_v2 브랜치를 분기합니다.
2. 개발자들은 merge_v2 브랜치에 자유롭게 커밋을 합니다.
3. 기능 구현이 있는 경우 merge_v2 브랜치에서 feature-* 브랜치를 분기합니다.
4. 배포를 준비하기 위해 merge_v2 브랜치에서 release-* 브랜치를 분기합니다.
5. 테스트를 진행하면서 발생하는 버그 수정은 release-* 브랜치에 직접 반영합니다.
6. 테스트가 완료되면 release 브랜치를 master_v2와 merge_v2 병합합니다.

## Git Convention
1. commit
  - 커밋은 하나의 기능만 커밋합니다. 기능이 여러개일 경우 나눠서 커밋해주세요!
  - 커밋 메세지는 아래 양식을 사용합니다.
```markdown
Feat: 소셜 로그인 추가
- 구글 로그인 기능을 추가했습니다.
```
