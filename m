Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911813;
	b=08jF6cR5GrCzhHH+XUwbG+2sXE7Cnms2Eh1IZpmmOFdYN28ALKpubsfMpMUMjZTB9iUW
	 pdYigNVcNwlrn8BWAvcCHaslpvTmbiWTV23kWOx/O+uGuPDaq43Fq3WY2oM0fSnsQsgNL
	 1w++ef9GiBgjgv4GkNVJItfD1tNeEjS/D6UtelJX2iVeEwkKKV5C1zgSmuD5HJuKIb1j1
	 g2Ie6xVIHD5OOlT6OHxKnTo+fMJbH2RXHxQWT6+2CDS3Hg9BE1qzVRwiwKbGwHUPEKx/M
	 +5CpeuPLW2GH2276ABukxtzunvXNasKgC6EkhY9Fa16dYNzj5QuHZDlZgFeN0yqQHKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911813;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=htHBb5RKRXu5WdtR6FZClBwBndk93TZ7kxyFwzCeYDM=;
	b=3JgxEjKKgdWj/vkBBU9nKseiMdY3VBO02S1XGWEgjVk7hlGztbZCaQex/+5tfyejHZlJ
	 Ur/6rfU5cBl7mEhnxu4wjgeLSbiPcRxQc6+gIM3E0nmpt6uAJTdB7H98FZrQfLCJg2guT
	 a5jWLVuvcjvmaCmVxh5M2/ZzIbCSStXMFZcw8EI9jGS1dl62IsDuc0ePks6JHVbThF/38
	 PW9D0WlNOEsnCgVDutWDryMLNkXn/8srJLHWuQFdEihe9QvrSkkp5UBeJiQT3GAx5gm6x
	 KP0uDEP9wjy3Fdh0VnbRsuNn9oBtBw1GI8sEkr9dzh96m1NH8akusskcU2UTFKMw5gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="J/+e4wJ6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60F606A326
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/+e4wJ6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818281F0089F;
	Thu,  5 Nov 2026 20:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793911812;
	bh=htHBb5RKRXu5WdtR6FZClBwBndk93TZ7kxyFwzCeYDM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=J/+e4wJ69bBJk1cOuE2kkDQUhNcQIEmtCg2ah9TmvYCnRl8fSbeTo1dvpWOWVoSGg
	 OquFPGzkBVmbDtG1/pIcKpBShmXZ5KrF2HuA6o2eBsiS6MifRcRtKHRIQENLnH9ui0
	 e7WiAlsnX61rzP0AdZr81cnh7SPPXfdskC2zMfOVY54sBCMCH2IQjSvn5HY1DAg8gr
	 7o4C4UcBIzbxmJeCPLYEgOQxpCegGtdktqJ2IcfNXxo3nCJwezUSwU3p9vdoWmG4IL
	 xiSDQs5pCbUXP1db/u/AkbsYXW62bwxjPUdhXbi9hj6HQCUyGiGfvXEhbk+eBufgo4
	 BHskjDYqWXjLQ==
Message-ID: <sashiko-outbox-200154@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 21/23] KVM: selftests: Test that the first user TSC
 write is honoured exactly
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261105154955.2525419-22-dwmw2@infradead.org>
References: <20261105154955.2525419-1-dwmw2@infradead.org>
 <20261105154955.2525419-22-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:50:12 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] KVM: selftests: misplaced timing window and missing KVM_SET_TSC_=
KHZ in main()
- [Low] KVM: selftests: duplicate MSR_IA32_TSC test binary and helpers
--

commit c39adcb632ae1981c065df1ae8906c472090451f
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: selftests: Test that the first user TSC write is honoured exactly

This commit adds an x86 KVM selftest that creates a vCPU, writes a guest TSC
value corresponding to 500ms of runtime via MSR_IA32_TSC, and checks that t=
he
value reads back without being snapped back to the default generation by the
1-second slop heuristic in kvm_synchronize_tsc().

> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/sel=
ftests/kvm/Makefile.kvm
> index 1edc78845fd35..fd063806a7fb9 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -151,6 +151,7 @@ TEST_GEN_PROGS_x86 +=3D x86/xcr0_cpuid_test
>  TEST_GEN_PROGS_x86 +=3D x86/xss_msr_test
>  TEST_GEN_PROGS_x86 +=3D x86/debug_regs
>  TEST_GEN_PROGS_x86 +=3D x86/tsc_msrs_test
> +TEST_GEN_PROGS_x86 +=3D x86/tsc_user_set_test

[Severity: Low]
This isn't a bug, but tools/testing/selftests/kvm/x86/tsc_msrs_test.c alrea=
dy
tests host and guest reads and writes to MSR_IA32_TSC and MSR_IA32_TSC_ADJU=
ST.
Should this narrow MSR_IA32_TSC host-write check be added as a test case in
x86/tsc_msrs_test.c rather than introducing a separate standalone test bina=
ry?

> diff --git a/tools/testing/selftests/kvm/x86/tsc_user_set_test.c b/tools/=
testing/selftests/kvm/x86/tsc_user_set_test.c
> new file mode 100644
> index 0000000000000..6ab76e817f9fe
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/tsc_user_set_test.c
> @@ -0,0 +1,86 @@

[ ... ]

> +int main(void)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	u64 freq_khz, t_write, t_read, slack_cycles, mono_ns;
> +	struct timespec ts;
> +	int r;
> +
> +	/*
> +	 * Start the measured window before vCPU creation: a snapped-back
> +	 * value tracks time since the kernel's default generation (i.e.
> +	 * since creation), so the window the slack is derived from must
> +	 * include everything from creation onwards.
> +	 */
> +	clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
> +	mono_ns =3D ts.tv_sec * 1000000000ULL + ts.tv_nsec;
> +
> +	vm =3D vm_create_with_one_vcpu(&vcpu, NULL);
> +
> +	r =3D __vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL);
> +	TEST_ASSERT(r > 0, "KVM_GET_TSC_KHZ failed");
> +	freq_khz =3D r;

[Severity: Low]
This isn't a bug, but vm_create_with_one_vcpu() calls
kvm_arch_vm_post_create(), which already invokes KVM_GET_TSC_KHZ, asserts t=
hat
it succeeded, and stores the result in the global guest_tsc_khz. In additio=
n,
test_util.h (included via kvm_util.h) provides timespec_to_ns() and
timespec_sub(). Could main() reuse guest_tsc_khz and timespec_to_ns() inste=
ad
of re-querying KVM_GET_TSC_KHZ and open-coding the timespec conversion?

> +
> +	/*
> +	 * The first user write: a guest TSC corresponding to 500ms of
> +	 * runtime. This is within 1s (of virtual cycle time) of the
> +	 * kernel's default generation, so it is exactly the case that
> +	 * the slop heuristic would destroy if it were (incorrectly)
> +	 * armed by the kernel's own internal TSC synchronization.
> +	 */
> +	t_write =3D freq_khz * 500ULL;		/* khz * ms =3D cycles */
> +
> +	vcpu_set_msr(vcpu, MSR_IA32_TSC, t_write);
> +
> +	t_read =3D vcpu_get_msr(vcpu, MSR_IA32_TSC);
> +
> +	clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
> +	mono_ns =3D (ts.tv_sec * 1000000000ULL + ts.tv_nsec) - mono_ns;
> +
> +	/*
> +	 * The TSC advances between the write and the read; bound the
> +	 * difference by the measured elapsed time around the two ioctls
> +	 * plus 10ms of slop, so a descheduled test cannot flake. If the
> +	 * write was snapped to the kernel's default generation, the
> +	 * value read back is ~500ms low (i.e. below t_write), which is
> +	 * unambiguous.
> +	 */
> +	slack_cycles =3D freq_khz * (mono_ns / 1000000ULL + 10);
> +
> +	TEST_ASSERT(t_read >=3D t_write,
> +		    "TSC went backwards from explicit write: wrote %lu, read %lu"
> +		    " (first userspace write was subjected to 1-second slop?)",
> +		    t_write, t_read);
> +	TEST_ASSERT(t_read - t_write < slack_cycles,
> +		    "TSC read back too far from written value: wrote %lu, read %lu",
> +		    t_write, t_read);

[Severity: Medium]
Should the initial clock_gettime(CLOCK_MONOTONIC_RAW, &ts) call in main() be
placed immediately before vcpu_set_msr(vcpu, MSR_IA32_TSC, t_write) rather
than before vm_create_with_one_vcpu(&vcpu, NULL)?

When the kernel honours vcpu_set_msr(vcpu, MSR_IA32_TSC, t_write), the guest
TSC is set to t_write at the time of vcpu_set_msr() and only advances betwe=
en
vcpu_set_msr() and vcpu_get_msr(), matching the second comment that
slack_cycles bounds the elapsed time around the two MSR ioctls.

Conversely, if a buggy kernel snaps the write back to the default generation
established during vCPU creation, t_read tracks the elapsed time since vCPU
creation. Because mono_ns is measured from before vm_create_with_one_vcpu(),
t_read is always less than mono_ns, so t_read - t_write < slack_cycles is
guaranteed to hold for any snapped-back value. If vm_create_with_one_vcpu()
takes between 500ms and 1500ms on a loaded host, a snapped-back TSC will
satisfy both t_read >=3D t_write and t_read - t_write < slack_cycles, causi=
ng
the test to pass on a buggy kernel.

Also, both the commit message and the file header comment note that
kernel-internal TSC synchronization on vCPU creation and frequency changes
must not arm user_set_tsc. During kvm_arch_vcpu_create(), kvm_set_tsc_khz()
runs while l1_tsc_scaling_ratio and l1_tsc_offset are still zero, whereas an
explicit KVM_SET_TSC_KHZ ioctl on an existing vCPU runs with non-zero
l1_tsc_scaling_ratio and l1_tsc_offset. Should main() also test calling
KVM_SET_TSC_KHZ before the first MSR_IA32_TSC write?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105154955.2525=
419-1-dwmw2@infradead.org?part=3D21
