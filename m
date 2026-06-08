Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643B33E638B
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780946821; cv=none; b=aigDIzmuKJGPZyNzb4Sw9csB1/VGbscoqnkcDu0r3SW5uZTj1FYZJ2/dKk5tovLCfSuXcVQN3EtUyFm/NQ9vLpE4hTXCsSReqWisorywLak4qTHJ73SW7vtqCmxpsdwVI+20v5v9cwPBlXbeB0+Or9PS49WBe65SpFditbYHI9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780946821; c=relaxed/simple;
	bh=2GhmWhWT0TyPw76szLqjpwAUjPaTWS1PuE+k/GO+jp0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ab9ZZYvh12ZvL6l7nh8dsdi9lVReuVgOZuepmshA2gA+XsvDMTwE4Q6Hyx5j9bAJjUEa2Ephkec1I6CqC3Qi4s1nLIwWuqH2Ed9DdNEUnJYMJZqQ8aPNYaggC2OnOV8Bg53txKBGDKOVvblp5HXywzvzUQTNW90INf7AqPNbhAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVji1j31; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVji1j31"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042CE1F00893;
	Mon,  8 Jun 2026 19:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780946819;
	bh=6Zz1mWHkm/3pVEJiEj7jUs/vfoH5/NLolP4qjx+oj8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BVji1j31bKp9Fsr+EEHwJw6CKPgFelkXnl0EOAhwfBU4naN80gt58rZWhOZBpkCNg
	 B7j0KGigB5BWoTuRD7boWnZik5ypvHdH2N2CjjjXakXeox1mLAcRNKDSsQUQOv49Pd
	 fm6gnqxC7guuE4y7w0o7sAIsAwyRV9C2Qm0OI1It24C+30uzirHTaTpPscjuqzMamJ
	 CwGyL8y/2Uv8clX9bGAmmMF4g3CV9ChTArnNHl3XEQ6uphz/BB+nnJvQWemjEZ0EbK
	 UNeG8h63hTwH4zd49rHotSq51cRSFwLj0U4LR9xAegjNmU18SqvAKlUjMb6Uge25m3
	 GK742x4/30ZxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 22/34] KVM: selftests: Add master clock offset test
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608145455.89187-23-dwmw2@infradead.org>
References: <20260608145455.89187-23-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 19:26:58 +0000
Message-Id: <20260608192659.042CE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The test uses an undefined, hallucinated ioctl macro `KVM_GET_CLOC=
K_GUEST` and fails to check the return value of `__vcpu_ioctl`, leading to =
compilation errors and potential use of uninitialized stack memory.
- [Medium] The test incorrectly assumes KVM master clock mode remains activ=
e when vCPUs have different TSC offsets.
- [Medium] The test code's assertion for `KVM_CLOCK_TSC_STABLE` directly co=
ntradicts the commit message.
- [Medium] The test incorrectly expects `PVCLOCK_TSC_STABLE_BIT` to be clea=
red when the master clock is active.
--

commit 810ed346c3086cf1091b3ee7294755bdf43c9973
Author: David Woodhouse <dwmw@amazon.co.uk>

Verify that KVM master clock mode remains active when vCPUs have different =
TSC offsets

This commit adds a test to verify that KVM master clock mode remains active
when vCPUs have different TSC offsets but the same frequency. It creates
three vCPUs, offsets one of them, and confirms the KVM_CLOCK_HOST_TSC
behavior.

>  - KVM_CLOCK_TSC_STABLE is NOT set (offsets differ)

[Severity: Medium]
Does this commit message contradict the implementation? The message states
that KVM_CLOCK_TSC_STABLE should NOT be set, but the test code explicitly
asserts that it is set.

> diff --git a/tools/testing/selftests/kvm/x86/masterclock_offset_test.c b/=
tools/testing/selftests/kvm/x86/masterclock_offset_test.c
> new file mode 100644
> index 000000000000..88e2bd2edab5
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/masterclock_offset_test.c
[ ... ]
> @@ -0,0 +1,180 @@
[ ... ]
> +	/* Check master clock is active */
> +	memset(&clock, 0, sizeof(clock));
> +	vm_ioctl(vm, KVM_GET_CLOCK, &clock);
> +	pr_info("KVM_GET_CLOCK flags: 0x%x\n", clock.flags);
> +	TEST_ASSERT(clock.flags & KVM_CLOCK_HOST_TSC,
> +		    "Master clock should be active, flags=3D0x%x", clock.flags);

[Severity: Medium]
Will this assertion fail? KVM disables the master clock (use_master_clock)
if all online vCPUs do not have matching TSC offsets and generations. Since
vcpus[2] is explicitly set to a different offset earlier in the test,
KVM_CLOCK_HOST_TSC shouldn't be set here.

> +	TEST_ASSERT(clock.flags & KVM_CLOCK_TSC_STABLE,
> +		    "KVM_CLOCK_TSC_STABLE should be set, flags=3D0x%x", clock.flags);

[Severity: Medium]
Is this assertion correct? The commit message claims that
KVM_CLOCK_TSC_STABLE is NOT set, but this code asserts that it is present
in clock.flags.

> +
> +	/* Get per-vCPU pvclock in order 0, 2, 1 */
> +	int order[] =3D {0, 2, 1};
> +	for (i =3D 0; i < 3; i++) {
> +		int idx =3D order[i];
> +		__vcpu_ioctl(vcpus[idx], KVM_GET_CLOCK_GUEST, &pvti[idx]);

[Severity: High]
Does the KVM_GET_CLOCK_GUEST macro exist? It doesn't appear to be defined
in the KVM UAPI or selftests headers, which would cause a compilation error.

Additionally, __vcpu_ioctl() returns an error code instead of asserting on
failure. Since the return value isn't checked, any failure leaves the pvti
array uninitialized. Could we use vcpu_ioctl() or check the return value
to ensure we don't operate on uninitialized memory during pvclock_calc()?

[ ... ]
> +	/* PVCLOCK_TSC_STABLE_BIT should NOT be set (offsets differ) */
> +	TEST_ASSERT(!(pvti[2].flags & PVCLOCK_TSC_STABLE_BIT),
> +		    "PVCLOCK_TSC_STABLE_BIT should NOT be set, flags=3D0x%x",
> +		    pvti[2].flags);

[Severity: Medium]
Is this expectation correct when the master clock is active? In KVM, when
use_master_clock is true (which is required for KVM_CLOCK_HOST_TSC above),
kvm_guest_time_update() unconditionally sets PVCLOCK_TSC_STABLE_BIT in the
pvclock structure. If the master clock were actually active, this assertion
would always fail.

[ ... ]
> +	/* Re-read pvclocks */
> +	for (i =3D 0; i < 3; i++)
> +		__vcpu_ioctl(vcpus[order[i]], KVM_GET_CLOCK_GUEST, &pvti[order[i]]);

[Severity: High]
As mentioned above, KVM_GET_CLOCK_GUEST appears to be undefined, and the
unchecked __vcpu_ioctl() return value risks leaving pvti uninitialized
before it is read again.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145455.8918=
7-1-dwmw2@infradead.org?part=3D22
