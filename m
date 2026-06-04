Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEE1492514
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591633; cv=none; b=rhKcyk5DmTfLvykMTPYlHdFAD/uMA9O661hItbQSKrx3579dDF/Nq78212yAFDOWI2gRLV2HVEEgfEeQUDfiq3qbB957Ao9eIfA8LfpSK3hx4BCI2DeG0RupgbTH6r31ZsKAgwfzm2EFex0RFppmeS92k3A61kflx0tSXBMx9TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591633; c=relaxed/simple;
	bh=o45CmQRWD5tFGvhbPzw2B8XaE/wg+x2O+LTDY1wvRT8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qp5v8y6k4/dc0JAbMlilf5Bb+7nDrrpc6ZuUJC9XRc93dN7gnXd27Ub2Kb6dZEfU+Yiz3TaM/Itv/bVE05eeQpD6n8hNEgBISBZ9S8EQJM7RRBod13Czxkk4pMuBK6RvUHoBj932+207YEbR8Pwf5y12LN+XoMaGYdpQ5QHxlQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5Fcp6YI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5Fcp6YI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D46A1F00893;
	Thu,  4 Jun 2026 16:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780591631;
	bh=ov3hXK8XkKy/3iKhe738SQy7Tjlfnuys/xAb4dvE734=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O5Fcp6YIG2f52F1W6vmjRxRXxY0agghPwRtpQF3YU5HxSGFMDI88Ali/PGxL/tPLV
	 l21Y8nRsPRfHXUbXVWsVxmcgHGQm5FOPP/MiU6ybwNkZYtp4tozTMS/jR8KU2LD/V1
	 qKGKKzB4M/hLg5B2lr0MthYT/RAcb/B7pLne5PEEYx/neswnp83EbpwMcPvfmLnrxn
	 LtwFQ/3gasr/JKiCrj3gmBCvueHFRy9aYOf0D7+4euxwwHaSCygpKsZ1M42qNh2/70
	 7SKdQUb7I7dThtUZ/xiJXRAKWolbk/7K4Vw1/+wNMMY4nj7+GsB6PPljFfs0LVcrrF
	 rtd/UzGw6+lFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] kunit: Add ability to skip entire test suites
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vaibhav Jain" <vaibhav@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604162805.556135-2-vaibhav@linux.ibm.com>
References: <20260604162805.556135-2-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 16:47:11 +0000
Message-Id: <20260604164711.8D46A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The newly added `suite->status` field is not reset in `kunit_ini=
t_suite()`, leading to a sticky skipped state across multiple debugfs runs.
- [Medium] Bypassing `suite_exit()` when `suite_init()` skips a test suite =
violates standard kernel initialization contracts and forces resource leaks.
--

commit b745c49805409babd4338da1946b7eb586892485
Author: Vaibhav Jain <vaibhav@linux.ibm.com>

kunit: Add ability to skip entire test suites

This commit adds a status field to struct kunit_suite to allow suite_init
callbacks to mark a suite as skipped. When a suite is marked as skipped,
all test cases within the suite are bypassed without execution.

> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 99773e000e1b7..989acc770265d 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c

[ ... ]

> @@ -795,12 +798,20 @@ int kunit_run_tests(struct kunit_suite *suite)
>  	/* Taint the kernel so we know we've run tests. */
>  	add_taint(TAINT_TEST, LOCKDEP_STILL_OK);
> =20
> +	if (suite->status =3D=3D KUNIT_SKIPPED)
> +		goto suite_end;
> +

[Severity: Medium]
Does this cause the suite to remain permanently skipped on subsequent runs?

If a test suite is executed via debugfs and gets skipped, suite->status
becomes KUNIT_SKIPPED. Because kunit_init_suite() does not reset
suite->status back to KUNIT_SUCCESS, this check will immediately bypass
the suite on all subsequent debugfs runs, preventing re-evaluation
of runtime prerequisites.

>  	if (suite->suite_init) {
>  		suite->suite_init_err =3D suite->suite_init(suite);
>  		if (suite->suite_init_err) {
> +			suite->status =3D KUNIT_FAILURE;
>  			kunit_err(suite, KUNIT_SUBTEST_INDENT
>  				  "# failed to initialize (%d)", suite->suite_init_err);
>  			goto suite_end;
> +
> +		} else if (suite->status =3D=3D KUNIT_SKIPPED) {
> +			/* Skip this kunit suite */
> +			goto suite_end;

[Severity: Medium]
Will this leak resources allocated during suite_init() prior to the skip?

Standard kernel initialization patterns guarantee that if an init function
returns 0 (success), the corresponding exit function will be called.

If suite_init() allocates resources, then sets suite->status to
KUNIT_SKIPPED and returns 0, the goto suite_end bypasses the
suite->suite_exit(suite) call.

Does this force test authors to manually free resources before returning 0
when skipping, or should the exit function still be called here?

>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604162805.5561=
35-1-vaibhav@linux.ibm.com?part=3D1
