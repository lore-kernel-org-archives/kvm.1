Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6659460
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 01:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830981; cv=none; b=OLAJIIUuXN1/YWxOJLe64fV1DX596b633+tQTh2fQb2antRNcYTDyyyNvcCzBA+0OEU5bhF2GPR0mS1NiiUh7/dmEuq8D09X0cTb7sgezVJwUXXIiKAo8W08nw1db9Gf9tnK1SW53DfjQClmSE66MTQNSWxZuyo3bD7Tpm43EC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830981; c=relaxed/simple;
	bh=D2o0yp+vENp1ihZXbk4ErsOdaP/SoaB2FO1lZp8Iato=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MM9K33yT9owWtdKw6aoszG1jbMlsGD8DU9y2TsFj2XKB3sRR87RLENXSpyNQSY4xMUvjDNGxBqfwCBUxYzH4BDqL8dto7xCRzSdRwkBpeirC+ztuoyV1k2O1AZw99ed3nb8/FsUBubsfD7FRyMdtQmo0SPzVe7DcQWAog7Hpjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIHS72zd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIHS72zd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B871F000E9;
	Fri, 19 Jun 2026 01:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830980;
	bh=cQVbscCt19iPTu1Misyb0AFCTAFBX26E14VrkWnQFaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nIHS72zd31HTjfVcBoZZYQ6biummCQZu0fSVHWyhRSBAhdnavju2pOYmkQMGx4lCv
	 hpP9hVWoHzHSQTkBNKeZx1rhH0tJL3vn+U+I7n+XRese6v0kpOv+FOse4jvx4kiBQf
	 eEI7AjYzEEQWtIRE9psulY3xSCEXWAmdQn3z+cW+hFwOBeRwzIH750+KxBU2R60gSm
	 QzUC9bQ68NjkmJbRRk2wq/aVc9urA3/biz6lJ2tFXBeIpKXsFmE/qNqmrN30Q8rpEi
	 fe5kT94ZwynguG56gjX6PgQ3l0uc4JWoHhX8ACnbEUL4mKhJOf7bxvT5tG9r33PHcK
	 s6Zi0kzcOk7vQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 37/46] KVM: selftests: Test that shared/private
 status is consistent across processes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260618-gmem-inplace-conversion-v8-37-9d2959357853@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-37-9d2959357853@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 01:02:59 +0000
Message-Id: <20260619010300.36B871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Race condition in `TEST_STATE_AWAIT` polling loop causing spurio=
us test failures.
--

commit 3235631ba422bd724225e0caee0e38513d361e5e
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Test that shared/private status is consistent across proces=
ses

Adds a selftest to verify that a guest_memfd shared and private status is
consistent across processes, mapping and unmapping pages using a parent
and child process synchronized via a shared mutex and condition variable.

> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test=
.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> --- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c

[ ... ]

> +/* Test that shared/private memory protections work and are seen from an=
y process. */
> +GMEM_CONVERSION_TEST_INIT_SHARED(forked_accesses)
> +{

[ ... ]

> +#define TEST_STATE_AWAIT(__state)						\
> +	do {									\
> +		pthread_mutex_lock(&sync->mutex);				\
> +		while (sync->step !=3D (__state)) {				\
> +			struct timespec ts, stop;				\
> +			int ret;						\
> +										\
> +			clock_gettime(CLOCK_REALTIME, &ts);			\
> +			stop =3D timespec_add_ns(ts, 100 * 1000000UL);		\
> +										\
> +			ret =3D pthread_cond_timedwait(&sync->cond, &sync->mutex, &stop); \
> +			if (ret =3D=3D ETIMEDOUT) {					\
> +				bool alive =3D (child_pid =3D=3D 0) ?			\
> +					     (getppid() =3D=3D parent_pid) :		\
> +					     (waitpid(child_pid, NULL, WNOHANG) =3D=3D 0); \
> +				TEST_ASSERT(alive, "Other process exited prematurely"); \

[Severity: Medium]
Could this waitpid() call inadvertently reap the child process if it happens
to exit exactly as the timeout expires?

If the child process completes its final step but is delayed by system
scheduling and calls exit(0) just as the parent's 100ms timeout expires,
this waitpid() check will reap the zombie process and return child_pid. This
causes the alive check to evaluate to false and triggers a spurious test
failure.

[ ... ]

> +	test_convert_to_private(t, 0, 0xC, 0xD);
> +
> +	TEST_STATE_SET(STATE_CHECK_PRIVATE);
> +	TEST_STATE_AWAIT(STATE_DONE_CHECKING_PRIVATE);
> +
> +	TEST_ASSERT_EQ(waitpid(child_pid, &status, 0), child_pid);
> +	TEST_ASSERT(WIFEXITED(status) && WEXITSTATUS(status) =3D=3D 0,
> +		    "Child exited with unexpected status");

[Severity: Medium]
Will this final waitpid() call fail with ECHILD if the child was already
reaped by the timeout block above?

Because the earlier waitpid() call in TEST_STATE_AWAIT irreversibly consumes
the child's exit status if it does not use WNOWAIT, this assertion would fa=
il
even if the previous assert was bypassed. This could lead to flaky tests in
heavily loaded environments.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-gmem-inpla=
ce-conversion-v8-0-9d2959357853@google.com?part=3D37
