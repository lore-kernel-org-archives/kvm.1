Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3340851A73A
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790759; cv=none; b=IRIsu73slxRcbCKc8ijfdidVZnYgJ3f/cH4i40m7S61WbGLt7+WLWePFAbsTQtS77fwG3XrCNG8YNpbRsxT4enD7+04CSIv22rlZcFPuy2pAwZ/uy2a6wzjl+1bCR7o2mZQmH3bhc3/xac+6qjbOT2GpTmu6heC2wYjtm9c32CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790759; c=relaxed/simple;
	bh=0e39SisXitcennN8qlWLGnxqhQtDQkiKHDx9ez6HA4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ew+QdGjlmtRnAnmk4F3IeukaUpe9xf0tpZ+rrpa4g8T2sCbUUpMR9b1KgjKZxwnhkhmmP5CxqtTwrGza89Bu9oDuAVK4J0q2x39TSO0hnMMuOTd+Fx/PswfkKl0g8B5f0NTM5JnSMjxyMBLzd5V3pgbSFZGc4O+NLJsDaRgx67M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWQOhwHF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWQOhwHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FD21F00898;
	Wed, 30 Sep 2026 17:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790790757;
	bh=R9L/4CxU54zLNtsXaLrps/iCjEWiC3qU0pnrCGqr4R8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mWQOhwHFyGe/avUokr+NMDBRpJuXqv9GtGDHRNFkQWUmTGeuWLzPXIdMNmfmYx54e
	 1f67+XusfdrhMtnck0ztM7IXrAP35b0AmL6M5GqAL37NsyL6LcHzcEN+DP8q1Qh+AQ
	 i/pUlSlmSbO5mrOsIMyHKXLsk6UEm0HU5cj+e+TZV4vEZi54eIiH6pXmPovGaF0gx+
	 h5QRY9jSfFANo3UuGBhbX6aWm3y0//92bClj8La/ynchpm7tH3pIm8IPIJfQ0mur2L
	 4YTtR46aEgYa4+woXaGtcmMwdp7fNr6Klzfa1NUyYLUwcIGxR5QE3H3NiWPwSaWoY9
	 JGkXMYdXvmR8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/21] KVM: selftests: Use KVM's reported TSC KHz as
 L0's frequency (sanity checked)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930173635.3362655-14-seanjc@google.com>
References: <20260930173635.3362655-1-seanjc@google.com>
 <20260930173635.3362655-14-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 17:52:37 +0000
Message-Id: <20260930175237.A8FD21F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] kselftest: random test flakiness due to strict 1% tolerance on s=
leep(1)
- [Low] kselftest: masked ioctl failure check due to u64 cast and multiplic=
ation
--

commit 44c3625d55f5d8d3232ad8e1eb92f5cad1eaa9ab
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Use KVM's reported TSC KHz as L0's frequency (sanity checke=
d)

This commit updates the nested TSC scaling test to use KVM's reported
default TSC frequency instead of trying to calibrate it in userspace via=20
RDTSC. It also introduces a sanity check to ensure the observed TSC=20
frequency roughly matches KVM's reported frequency.

> diff --git a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c b/=
tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> index d790ab36a198e..a78585af0ffdf 100644
> --- a/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c
> +++ b/tools/testing/selftests/kvm/x86/nested_tsc_scaling_test.c

[ ... ]

> @@ -212,18 +209,30 @@ static void test_tsc_scaling(u64 l0_tsc_freq, u64 l=
1_scale_factor, u64 l2_scale_
>  int main(int argc, char *argv[])
>  {
>  	u64 l0_tsc_freq, tsc_start, tsc_end, l1_scale, l2_scale;
> +	struct kvm_vm *vm;
> =20
>  	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX) ||
>  		     kvm_cpu_has(X86_FEATURE_SVM));
>  	TEST_REQUIRE(kvm_has_cap(KVM_CAP_TSC_CONTROL));
>  	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
> =20
> +	/*
> +	 * Create a dummy VM to get KVM's default TSC frequency.  All CPUs that
> +	 * support TSC scaling should have a constant TSC, i.e. there's no need
> +	 * to calibrate the "real" TSC.  But do sanity check that the observed
> +	 * TSC is within range of KVM's reported TSC frequency.
> +	 */
> +	vm =3D vm_create_barebones();
> +	l0_tsc_freq =3D (u64)__vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL) * 1000;
> +	TEST_ASSERT(l0_tsc_freq, "vcpu ioctl KVM_GET_TSC_KHZ failed");

[Severity: Low]
Does this properly catch an ioctl failure? If __vm_ioctl() fails and return=
s=20
-1, casting it to a u64 and multiplying by 1000 results in a very large=20
non-zero value (0xfffffffffffffc18).=20

Since TEST_ASSERT only checks if l0_tsc_freq is non-zero, won't this pass=20
using garbage data instead of failing the test?

> +	kvm_vm_free(vm);
> +
> +	printf("L0 TSC frequency is: %lu\n", l0_tsc_freq);
> =20
>  	tsc_start =3D rdtsc();
>  	sleep(1);
>  	tsc_end =3D rdtsc();
> -
> -	l0_tsc_freq =3D tsc_end - tsc_start;
> -	printf("real TSC frequency is around: %lu\n", l0_tsc_freq);
> +	host_check_tsc_freq(0, tsc_end - tsc_start, l0_tsc_freq);

[Severity: Medium]
Could this strict 1% tolerance on sleep(1) introduce random test flakiness=
=20
on loaded systems?

When comparing the constant hardware frequency (l0_tsc_freq) against the=20
cycle delta measured across a userspace sleep(1), scheduling delays could=20
easily cause sleep to exceed 1.01 seconds.=20

If the test environment is heavily loaded, won't a 10ms scheduling delay=20
guarantee that the measured cycles exceed the expected constant cycles by=20
more than 1%, failing the host_check_tsc_freq() assertion?=20

The guest checks in test_tsc_scaling() that call host_check_tsc_freq()=20
also appear to be subject to this same issue since l1_tsc_freq is measured=
=20
using the guest's sleep(1).

> =20
>  	/* Scale L1 "down" and L2 "up" at a random factor from 2 to 10. */
>  	l1_scale =3D (kvm_random_u32(&kvm_rng) % 9) + 2;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930173635.3362=
655-1-seanjc@google.com?part=3D13
