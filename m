Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611291925BC
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779844883; cv=none; b=l25wfKqVsCvhRWYWHT5Nw8MqdTEA2MyarLps+KYAGZnVSX1yEPIZynTGrMZ8YebTe99p/zBIAMulZ5r8agBPaMrVd6BR6NKjV6BmA03LX59/DZ5Av9sOU4D1mhmWQHOMAPr2IZBW7lA5LxTnIC+9XNsaZ9ewkXsL5cVkDHn8GOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779844883; c=relaxed/simple;
	bh=XuG8x528mEL9Ms+NFaoo7Nfs1wlMlhApT/75mYcbIME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n7p4Eyin6g5jUxd4XZvGe2S+QOPLpAHqP2CPS48ALehtLuFm44KePwvifnn0bJOFKpok1UWBMxFA2vTfo2iuGs7nmUuMyhL2wJxZJ/Dn03LIc/gsAbs6L8G+0oBCM97C4Jjvoo9p9RrQ0pNZXbLdQlYzjITgf/IMRUiCkkN9kPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8T380g3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8T380g3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AD61F000E9;
	Wed, 27 May 2026 01:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779844881;
	bh=ad3XMcIbrt5lL2dEi51Yr1hz8v6CXw1f7XwpYIUv3Qk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h8T380g3kIKJ2BcfzBEVPeAzXIhfiBeVj21xc/JAX1wnH/VBc/gcE7ui1LHmZkfnU
	 8m79H+6ghwvpWGDYYkn/nw9KXV60VMSJlmtXkEpEgP9h428YNntjwglOrnd8v7pXNO
	 PtA43ivzh16p/dJdUdVZKUrNFVjnUclZt+Hxz+qEBhUmxW5hGKxoYkDl0cR0XF58IW
	 8tNYVWz52uxBaqFoeqhZbMsRliUKAd5EUXMnM64YyGCjwNK6WEcNn+lmtbZpa6u6Rw
	 MDYBmWK3wMSqBxbOWNLhI5s+6+BtZOatk4PuKA1Bi0nysbNQ40ta9Dzz1GQzniRPV3
	 eI794DttXY3CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 42/43] KVM: selftests: Add script to exercise
 private_mem_conversions_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260507-gmem-inplace-conversion-v6-42-91ab5a8b19a4@google.com>
References: <20260507-gmem-inplace-conversion-v6-42-91ab5a8b19a4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 01:21:20 +0000
Message-Id: <20260527012121.10AD61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Installation Path Resolution Failure in `private_mem_conversions_t=
est.sh`
- [High] Silent failure and brittle logic due to unhandled helper utility e=
xit status
- [Medium] Bash syntax error when checking default hugepage size if hugetlb=
fs is disabled
- [Medium] Redundant execution of `private_mem_conversions_test` binary
--

commit b88f984e8ecc669593e0deefcd4e6e9441fbfa8c
Author: Ackerley Tng <ackerleytng@google.com>
Subject: KVM: selftests: Add script to exercise private_mem_conversions_test

This commit adds a wrapper script to simplify running the
private_mem_conversions_test with various configurations. It automatically
detects hugepage availability to build a list of source types, running tests
across single and multiple memslots.

> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/sel=
ftests/kvm/Makefile.kvm
> index 6232881be500a..e5769268936a7 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -54,6 +54,7 @@ LIBKVM_loongarch +=3D lib/loongarch/exception.S
> =20
>  # Non-compiled test targets
>  TEST_PROGS_x86 +=3D x86/nx_huge_pages_test.sh
> +TEST_PROGS_x86 +=3D x86/private_mem_conversions_test.sh

[Severity: Medium]
Since the script is added to TEST_PROGS_x86 here, the kselftest harness will
execute it. Will the harness also run the underlying
private_mem_conversions_test binary directly if it remains in
TEST_GEN_PROGS_x86?

Should the C test be moved to TEST_GEN_PROGS_EXTENDED_x86 to prevent it from
being executed twice?

> diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test=
.sh b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.sh
> new file mode 100755
> index 0000000000000..7179a4fcdd498
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.sh
> @@ -0,0 +1,128 @@
[ ... ]
> +script_dir=3D$(dirname "$(realpath "$0")")
> +test_executable=3D"${script_dir}/private_mem_conversions_test"
> +kvm_has_gmem_attributes_tool=3D"${script_dir}/../kvm_has_gmem_attributes"

[Severity: High]
Will this path resolution work correctly when tests are executed from an
installed location (e.g., after make install)?

When installed, TEST_PROGS and TEST_GEN_PROGS_EXTENDED typically end up in
the same flat directory. Does looking for the helper tool in script_dir/../
cause the script to fail immediately with a "utility not found" error in
that environment?

[ ... ]
> +kvm_has_gmem_attributes=3D$("$kvm_has_gmem_attributes_tool" | tail -n1)
> +
> +if [ "$kvm_has_gmem_attributes" -eq 1 ]; then

[Severity: High]
Does this pipeline hide the exit status of the helper tool since set -o
pipefail is not used?

If /dev/kvm is missing, the helper tool might output a SKIP message instead
of a number. Will evaluating the output against 1 trigger a bash syntax
error (integer expression expected), causing the script to incorrectly fall
into the else block?

If it falls into the else block, wouldn't it attempt to run all the
hugepage tests, which will then individually skip and return KSFT_SKIP (4)?

Will the wrapper script misinterpret this return code as a hard failure?

[ ... ]
> +    default_hugepage_size_kb=3D$(get_default_hugepage_size_in_kb)
> +    hugepage_default_enabled=3D0
> +    if [ "$default_hugepage_size_kb" -eq 2048 ]; then

[Severity: Medium]
What happens here if CONFIG_HUGETLB_PAGE is disabled in the kernel?

In that case, /proc/meminfo won't contain Hugepagesize:, making the result
from get_default_hugepage_size_in_kb() an empty string. Will evaluating an
empty string against 2048 trigger a bash syntax error and pollute the test
output?

Should the variable be validated as a non-empty integer or defaulted to 0
before the numeric comparison?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507-gmem-inpla=
ce-conversion-v6-0-91ab5a8b19a4@google.com?part=3D42
