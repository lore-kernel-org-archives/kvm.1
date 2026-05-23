Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8F31FB1
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 01:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779498677; cv=none; b=njebBmyYYbmaV+r4E146Ky2DM1G1818PotSRffXDtM2SJ2hkkth4sSDky8PIrRwwiIktValkpv3ToEWUZucT7WhbDNNEWzP8r1jOG/Sao1NYuAW/gB+1mKJhKVs736jFPcEdhf0uNa+5WX/TGr3HEa06QQBZSZfFw+VaT2F5m9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779498677; c=relaxed/simple;
	bh=31+jGojWZkMLH+5QpOl0kFACU8nrEuwlTShITI7HpYU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vcj8QyEJofN1bmlUoWxR8Z5GxpoqzJS7Ng1cburZNDXX8phAE+Nl+Yo6I/aOQ4kqDEo6gZtUStjc6HU6AZyFxr06AcCcoOU54AXHdzw8DpctNmMyL5SD5F1onQGCfShx07n7NHN/mWN4/zzOfOC8puAZBFt9656b9W14s6NBY9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAVZs911; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAVZs911"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6F31F000E9;
	Sat, 23 May 2026 01:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779498675;
	bh=W2aVa9SkX+DrPOFNi7Qm78KEZLdbHA+dtMSIHsM+OTo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BAVZs911jGGJ4Zk3+E4lucp4vPged4X4rpxB1XxESYawHObvn4oBaHQkLe++qRJR7
	 bvu6iFj5PZg5iteTXn8RZeFPQpQCXE3/z7gy2WVGaQfU0m4jO5IZb1kXa3RWPt8Jyn
	 wIjaXNUt80NT8eC9qtyHsT+3ITdMfNDLwPWB4NR57Gep3laO++jhSAOK/mvHgoDzQ6
	 ikNSDqqw8WgCNKHJVWvxZFQkRz+0mgnx+3aCBmTVUBYuS79Srf/C+oUg9CHlf2s+Gq
	 yfJHgo+DMGKv5iDLHIMZkaU0klqyuZ2U3NumHxS/LyQETflGE+Ks0gxUXv/OPMQkhx
	 QubI80CoZF+Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 33/42] KVM: selftests: Test that shared/private
 status is consistent across processes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260522-gmem-inplace-conversion-v7-33-2f0fae496530@google.com>
References: <20260522-gmem-inplace-conversion-v7-33-2f0fae496530@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 01:11:14 +0000
Message-Id: <20260523011115.2C6F31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The child process does not monitor the parent's liveliness, which =
can lead to an infinite spin-loop if the parent process asserts.
- [Medium] A TOCTOU race condition in TEST_STATE_AWAIT causes spurious test=
 failures.
- [Low] Missing waitpid() for the child process at test completion creates =
a zombie process.
--

commit e0edb107acc876d11cc63eba5fc40ea49fb4f37d
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Test that shared/private status is consistent across proces=
ses

This commit adds a test to verify that a guest_memfd's shared/private status
is consistent across processes, and that shared pages are unmapped from all
processes when appropriate. It does this by forking a child process and hav=
ing
the parent and child take turns accessing the shared guest_memfd region.

> diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test=
.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> index f03af2c46426f..04e457409f75e 100644
> --- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
[ ... ]
> @@ -323,6 +323,80 @@ GMEM_CONVERSION_TEST_INIT_SHARED(truncate)
[ ... ]
> +	test_state =3D kvm_mmap(sizeof(*test_state), PROT_READ | PROT_WRITE,
> +			      MAP_SHARED | MAP_ANONYMOUS, -1);
> +
> +#define TEST_STATE_AWAIT(__state)						\
> +	while (READ_ONCE(*test_state) !=3D __state) {				\
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
> +		}								\
> +	}

[Severity: High]
Since child_pid is 0 for the child process, the child doesn't monitor the
parent's status in this loop.

If the parent process encounters a failure (e.g., via a TEST_ASSERT) and ex=
its
before updating the shared state, will the child process enter an infinite
busy-wait loop and spin at 100% CPU in the background?

[Severity: Medium]
Is there a race condition between checking the state and waiting for the
child?

If the parent evaluates the loop condition as true, but before it reaches
waitpid(), the child updates the state and exits, waitpid() will successful=
ly
reap the child and return its PID.

Won't the parent then see (pid !=3D 0) and fail the test with "Child exited
prematurely", even though the child successfully completed its task?

[ ... ]
> +	TEST_STATE_SET(STATE_CHECK_PRIVATE);
> +	TEST_STATE_AWAIT(STATE_DONE_CHECKING_PRIVATE);
> +
> +	kvm_munmap(test_state, sizeof(*test_state));
> +}

[Severity: Low]
Could this code leave the child as a zombie process?

After the parent completes the final TEST_STATE_AWAIT, the loop exits
immediately once the state is updated, bypassing the waitpid() check inside
the loop.

Without a final blocking waitpid() after the loop, it seems the child could
remain a zombie until the main test runner terminates.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inpla=
ce-conversion-v7-0-2f0fae496530@google.com?part=3D33
