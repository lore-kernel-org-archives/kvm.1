Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B340277C81
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 01:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779845380; cv=none; b=IJe4MAmHjv/MBDXuEphsrzQAcGvBVa8uEQ/r9pieKvEwOlhzf0cvbFaXZ99Tux4xwa7ye1kdWF04IFp1zhg1TOTlKvPspyiHjfnlbv7h9/AdD1L9fP7aKQU3PhuZmvUAVUFdT2AYlvnML9s7HX/wOJe4m133MoSXY2zXmtHqfy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779845380; c=relaxed/simple;
	bh=MZPGz6ctLe0VVMPEGo2AyWnFmsCo0H+g2n86WeNge/g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BnegGSoJX4Oc+wHQ0ntXCdJaISDTjRIokwxSxO7u3k2WF99YIySF2fzBOzm7QnupYFuxLGSXH4e20cuh5wfgb36iPsntVcgqGqoM/9+W4QPwT9xU/3CEFiQyYrVljMYcurNmkUYE3XdGmTokuGoE6/DJGB2vGJnyknsBrJbPHCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK6e4qYS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK6e4qYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162D71F000E9;
	Wed, 27 May 2026 01:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779845379;
	bh=DqQogEqxsdfomAAExE9eLBJLlbsC8jzE3gzxEQS+RzE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eK6e4qYSBBw3tyVAP01KT7qthWV2wtCk1CTILTDJ8jJ5IAnAQWALayh57DmzJKSTw
	 FHIV7k8ygs9rp6aSuABrEkLaEkSSWK+JNHzsFtOU+cM4+WmtM2OLwDM1lniiG1G5qC
	 ltXR7wJGDaAqjzhzAjo7miZdg/o4OQdRwqVbhVMgH1vMj+td4819MLJseYQKa8M2mt
	 qfMtVw5gYHngO/XKlXUWuYsXPkF0Sg3D26cm1dQiHbbacaQkZoCh8mUh8KZm8orY1x
	 kfS2gCkomZHzGavTtEGsUeVJTxAKWJDhPhZkeoyg+jrTONOQ1K1MyFj4Raea1Z0ey0
	 wV11anLI7v+NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 34/43] KVM: selftests: Test that shared/private
 status is consistent across processes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260507-gmem-inplace-conversion-v6-34-91ab5a8b19a4@google.com>
References: <20260507-gmem-inplace-conversion-v6-34-91ab5a8b19a4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 01:29:38 +0000
Message-Id: <20260527012939.162D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] A TOCTOU race condition in the `TEST_STATE_AWAIT` macro causes s=
purious test failures when the child process successfully exits.
- [Medium] The forked child process does not detect parent termination and =
will spin infinitely if the parent process crashes or fails an assertion.
--

commit e61a976fed3c062fac98d04a5f2859ab8c1293f6
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Test that shared/private status is consistent across proces=
ses

This commit adds a test to verify that a guest_memfd's shared/private status
is consistent across processes, and that shared pages mapped in any process
are unmapped from all processes upon conversion.

> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test=
.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> index 960b2da8dd16d..4c33e21f04972 100644
> --- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
[ ... ]
> +/* Test that shared/private memory protections work and are seen from an=
y process. */
> +GMEM_CONVERSION_TEST_INIT_SHARED(forked_accesses)
> +{
[ ... ]
> +	test_state =3D kvm_mmap(sizeof(*test_state), PROT_READ | PROT_WRITE,
> +			      MAP_SHARED | MAP_ANONYMOUS, -1);
> +
> +#define TEST_STATE_AWAIT(__state)						\
> +	while (READ_ONCE(*test_state) !=3D __state) {				\

[Severity: Medium]
Does the child process handle parent termination?

When the child process calls TEST_STATE_AWAIT(), child_pid is 0, so it skips
the waitpid() block below and spins in an infinite loop waiting for the sta=
te
to change.

If the parent process fails an assertion or crashes, it will exit and leave
the child spinning at 100% CPU indefinitely until the global kselftest
timeout triggers.

Could the child check if the parent is still alive during this loop, or set=
up
prctl(PR_SET_PDEATHSIG, SIGKILL) prior to the loop?

> +		if (child_pid !=3D 0) {						\
> +			int status;						\
> +			pid_t pid;						\
> +			do {							\
> +				pid =3D waitpid(child_pid, &status, WNOHANG);	\
> +			} while (pid =3D=3D -1 && errno =3D=3D EINTR);			\
> +			if (pid =3D=3D -1)						\
> +				TEST_FAIL("Couldn't check child status.");	\
> +			else if (pid !=3D 0)					\
> +				TEST_FAIL("Child exited prematurely.");		\

[Severity: Medium]
Is there a race condition here if the child exits after the parent reads the
state but before waitpid() executes?

If READ_ONCE(*test_state) !=3D __state evaluates to true, the parent enters=
 the
loop. If the child concurrently updates the state to __state and then exits
cleanly, waitpid() will detect the child's exit.

Because the state isn't re-evaluated before failing, the parent will
erroneously trigger this premature exit failure.

Could we check READ_ONCE(*test_state) =3D=3D __state again before triggerin=
g the
TEST_FAIL() to avoid spurious failures?

> +		}								\
> +	}
> +
> +#define TEST_STATE_SET(__state) WRITE_ONCE(*test_state, __state)
> +
> +	child_pid =3D fork();
> +	TEST_ASSERT(child_pid !=3D -1, "fork failed");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507-gmem-inpla=
ce-conversion-v6-0-91ab5a8b19a4@google.com?part=3D34
