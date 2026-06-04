Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12938421A19
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591365; cv=none; b=gcFOK+f1nBerLY5JnjtplYTh77gplUmDkvM93x/cv8DARVQi+RTZ11hg1wEcMuLeizuvfDnvc03E/B+XcZKm0hSzTbe1eidLuJeB3Z2jtWY0RCQHEHzEqhrGqVOHtYs2BM5+bzCeTdilWiDPRUT+Ct2xu79kN+LK6/x+RxDuISY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591365; c=relaxed/simple;
	bh=+Igupp8X2v5B37m7AZx48yEacmJ1PBzqQ1rBn78we1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jd98DgkGMK+9osilYlbuczR2aS2WaJjOAcQWRKVVsZp/RECFsX21tK3JAEpVDO4lIp9F9oTRvBw++xXhbNb9YO8+l2cClYoTMrXxZAxM4aXrwk4b83fEZWu4Yrs4CmmDkk9YrvC82xlVZ2bAGq1ElGaqlFAzsgbwXJtvl3AS7QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrhPDsLk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrhPDsLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2871F00893;
	Thu,  4 Jun 2026 16:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780591363;
	bh=Yt/FDNyTJKWaieagneLPp8G1DLHczOtEdjPunRdl4pI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mrhPDsLk/qiww7ao/HWZHU52adlyK1hPMl+vAITdWmluaZpIxa8+uK8VhgrNfDVtN
	 blK5PuAdSKRFF8DZfwn4c7fTe/ZYSL+CzBAtLeSOyZgJ+X+1rdJsWwLMT+d6AF91cO
	 3oxh/htGDyUarvIIjzmzqERTDAW4aSP/AXHHRXUC98qruOJnufJvSuIXhdIp2Yx8lE
	 4tOXYdav6iuRORzSLVqPTIPSnkj1xm42khZB3PtRkJ3JwvexPwu/1JP+mDjioC/HZE
	 USwDEyZMPLgRNTL1b2iRVpAeregGsSO3Dvd7GHvOHaivJUaZVN86qxqPBIB+cDhv60
	 JFRqDVVCyS/Cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] kunit: Add example of test suite that can be
 skipped at runtime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vaibhav Jain" <vaibhav@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604162805.556135-3-vaibhav@linux.ibm.com>
References: <20260604162805.556135-3-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 16:42:43 +0000
Message-Id: <20260604164243.7A2871F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The new example promotes a `suite_init` skip pattern that trigge=
rs multiple existing KUnit infrastructure bugs, leading to resource leaks a=
nd malformed KTAP output.
- [Low] Macro duck-typing API misuse: `kunit_mark_skipped()` is intended fo=
r `struct kunit *` but is passed a `struct kunit_suite *`.
--

commit bb04d5d94394b78bbd531471f54e3d41268deac5
Author: Vaibhav Jain <vaibhav@linux.ibm.com>

kunit: Add example of test suite that can be skipped at runtime

This patch adds an example test suite to kunit-example-test.c demonstrating
how to skip an entire test suite based on runtime conditions. It uses the
suite_init callback to mark the suite as skipped using kunit_mark_skipped().

> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-tes=
t.c
> index 0bae7b7ca0b05..b8ded54fa46d8 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -591,5 +591,34 @@ static struct kunit_suite example_init_test_suite =
=3D {
>   */
>  kunit_test_init_section_suites(&example_init_test_suite);
> =20

[ ... ]

> +static int example_skip_suite_init(struct kunit_suite *suite)
> +{
> +	kunit_mark_skipped(suite, "Test suite expected to be skipped");

[Severity: Medium]
Does this example promote a pattern that triggers underlying KUnit
infrastructure bugs?

The underlying framework bugs predate this patch, but promoting this pattern
could lead to resource leaks. In kunit_run_tests(), skipping a suite causes
it to completely bypass suite_exit():

lib/kunit/test.c:kunit_run_tests() {
    ...
	} else if (suite->status =3D=3D KUNIT_SKIPPED) {
		/* Skip this kunit suite */
		goto suite_end;
	}
    ...
}

This contradicts the KUnit API documentation (which guarantees suite_exit
will run even if suite_init fails) and structurally guarantees a memory leak
if test authors follow this example and allocate resources prior to checking
the skip condition.

Additionally, skipping the suite here leads to malformed KTAP output because
debugfs_print_results() unconditionally prints the test plan without the
inner test results. It also permanently locks the suite in the skipped state
across debugfs re-runs because kunit_init_suite() fails to reset
suite->status back to KUNIT_SUCCESS.

[Severity: Low]
Is it safe to pass a struct kunit_suite pointer to kunit_mark_skipped()?

The kunit_mark_skipped() macro is designed and explicitly documented to
accept a struct kunit pointer (the individual test case context), rather
than a suite:

include/kunit/test.h:
#define kunit_mark_skipped(test, fmt, ...)				\
	do {								\
		WRITE_ONCE((test)->status, KUNIT_SKIPPED);		\

This only compiles because both structs coincidentally share identically
named status and status_comment fields, relying on C macro structural
duck-typing.

If this macro is ever refactored into a type-safe inline function, this
example and any downstream code that copies it will fail to compile. Should
a proper type-safe API like kunit_suite_mark_skipped() be introduced instea=
d?

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604162805.5561=
35-1-vaibhav@linux.ibm.com?part=3D2
