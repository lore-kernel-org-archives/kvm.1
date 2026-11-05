Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910355;
	b=MinYCkdzLhy+tSp2yslUd1oQXKTA3NYJtLX8fQN1MffVUFhKlLVprCN1U/Pj6SobP713
	 nep9uzlbf3RNTRsVOPooewyD0sKJkgW46Lu2z5OTXE+O+pJCaJaG1T8vzm+w3I+5iGsKv
	 gy5/SRD7DxfLh8jaCTszj3injcn6IPAsPwh74Lq6vfVZwTBcj/taQCFr0xnXFfv7Umgsp
	 h2cYrZrGAO4gTjR5taNUN/jNZgYRPKvjG1a6EqYPUmjgpsvLoxaaM9klkLmqvTf2STws2
	 V5lfEMpT/uZou42SdPxcuythOEKkCmo4G6D1mJMqmuFnPJhNYdP/OjrE/lPedNV3jJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910355;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sWflS6cdWNQglp5FPdjNSHREO+j1KZXLsHisfM/YN+s=;
	b=3Ziw1BWCd+wDHkGE/HL2sxpy4KucIfrJvbJpedZXlpREhQ1camtUBMWWgWygrTm4fkwZ
	 cco3TzOwBLLlnvNdT5dAIpNsvK5FV8f3+VDUvKzLrHhn5KRQKmG0bPc7AXaQo/ab7tlv+
	 ilWOpeiTYUv0XEZm86ok0qnUD4DN3mRoLioT4fXI2M2SxEueiXyOjpHRc2dViXqk2blml
	 6Jm+q3G7T/Nf7ylvkDX5OMpQ/c7HTcWjz/j0axNbAo/1eTc4KXDGT3PUd/CVnSsAfcKw3
	 BVIc4oNC8njSxXVVkive3p74UWiE/8yj+DLGxonku18cHleqZbVl0JC2+VcXfBfO9uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8OWumeW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EA1606A329
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8OWumeW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361AA1F0089F;
	Thu,  5 Nov 2026 20:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793910354;
	bh=sWflS6cdWNQglp5FPdjNSHREO+j1KZXLsHisfM/YN+s=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=g8OWumeWmwjCKY0JJBdd2JuSxiXVZBcw0ILXJSrUkqGQKIq1dCFQr2gkM7aE9eUX0
	 uKnGgwcT4XCXPd+dUMlBbLSReMh1xLyMP6SlBpdnsSVUcKcvkMRnzUydrHOOQdxZqR
	 A4sICyc9/NPYwYWDTFAqyxFDbO3VO/OnwoPM8I0RpjvE1sqnXeEQMFGXwcrZ+iMRMS
	 PuEArhDNN8zPFTDTYmHyl1ewntdFeBjthIFXD3uSr0CVo/HWqqaXh3C7y1s9mnMZhz
	 0Dl15HgPsJVzd2QemMcdnJ/Lw4lcGw8R3TcIbW2stau5UG0UuVJn6esmGV+uMOYlfN
	 GNNfQg6PlZMVg==
Message-ID: <sashiko-outbox-200097@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 18/23] KVM: selftests: Add master clock offset test
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261105154955.2525419-19-dwmw2@infradead.org>
References: <20261105154955.2525419-1-dwmw2@infradead.org>
 <20261105154955.2525419-19-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:25:53 +0000
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
- [Medium] KVM: selftests: get_pvtis() never reads guest pvclock pages at K=
VMCLOCK_GPA
- [Low] KVM: selftests: pvclock_calc() and test duplicate pvclock helpers a=
nd tests
--

commit 5c47fcec1d956ca47ab8d39fceaff3ebcc1cad2e
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: selftests: Add master clock offset test

This commit adds a KVM selftest on x86 to verify that master clock mode
remains active and consistent across vCPUs when one vCPU is given a
different TSC offset and the VM clock is advanced with KVM_SET_CLOCK.

> diff --git a/tools/testing/selftests/kvm/x86/masterclock_offset_test.c b/=
tools/testing/selftests/kvm/x86/masterclock_offset_test.c
> new file mode 100644
> index 0000000000000..47a1313eadc9f
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/masterclock_offset_test.c
> @@ -0,0 +1,215 @@
[ ... ]
> +static u64 pvclock_calc(struct pvclock_vcpu_time_info *pvti, u64 guest_t=
sc)
> +{
> +	u64 delta =3D guest_tsc - pvti->tsc_timestamp;
> +
> +	if (pvti->tsc_shift >=3D 0)
> +		delta <<=3D pvti->tsc_shift;
> +	else
> +		delta >>=3D -(int)pvti->tsc_shift;
> +
> +	return pvti->system_time + ((__uint128_t)delta * pvti->tsc_to_system_mu=
l >> 32);
> +}

[Severity: Low]
This isn't a bug, but pvclock_calc() in
tools/testing/selftests/kvm/x86/masterclock_offset_test.c duplicates
__pvclock_read_cycles() from tools/arch/x86/include/asm/pvclock.h (already
used by tools/testing/selftests/kvm/x86/kvm_clock_test.c):

tools/arch/x86/include/asm/pvclock.h:__pvclock_read_cycles() {
	u64 delta =3D tsc - src->tsc_timestamp;
	u64 offset =3D pvclock_scale_delta(delta, src->tsc_to_system_mul,
					     src->tsc_shift);
	return src->system_time + offset;
}

Also, tools/testing/selftests/kvm/x86/pvclock_test.c (in
test_tsc_stable_bit() and test_clock_guest_with_offsets()) and
tools/testing/selftests/kvm/x86/pvclock_migration_test.c (in
check_cross_vcpu_coherence()) already test master clock persistence,
PVCLOCK_TSC_STABLE_BIT clearing, and cross-vCPU pvclock agreement when vCPUs
have divergent TSC offsets.

Could this use __pvclock_read_cycles() and be folded as a test case into
tools/testing/selftests/kvm/x86/pvclock_test.c rather than adding a separate
test binary?

> +static void guest_code(u64 pvti_gpa)
> +{
> +	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, pvti_gpa | KVM_MSR_ENABLED);
> +	for (;;)
> +		GUEST_SYNC(0);
> +}
> +
> +static void get_pvtis(struct kvm_vcpu **vcpus,
> +		      struct pvclock_vcpu_time_info *pvti)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < NR_VCPUS; i++) {
> +		int idx =3D vcpu_order[i];
> +
> +		vcpu_get_clock_guest(vcpus[idx], &pvti[idx]);
> +		pr_info("vCPU %d: tsc_timestamp=3D%lu system_time=3D%lu "
> +			"mul=3D%u shift=3D%d flags=3D0x%x\n",
> +			idx, (unsigned long)pvti[idx].tsc_timestamp,
> +			(unsigned long)pvti[idx].system_time,
> +			pvti[idx].tsc_to_system_mul, pvti[idx].tsc_shift,
> +			pvti[idx].flags);
> +	}
> +}
[ ... ]
> +static void test_set_clock_consistency(struct kvm_vm *vm,
> +				       struct kvm_vcpu **vcpus,
> +				       struct pvclock_vcpu_time_info *pvti,
> +				       struct kvm_clock_data *clock,
> +				       u64 offset0)
> +{
> +	struct kvm_clock_data setclk =3D { .clock =3D clock->clock + ONE_HOUR_N=
S };
> +	u64 clk0;
> +	int i;
> +
> +	/*
> +	 * Add an hour to the VM kvmclock via KVM_SET_CLOCK, run each
> +	 * vCPU to pick up the update, and check they're still in sync.
> +	 */
> +	vm_set_clock(vm, &setclk);
> +
> +	/* Guest code does GUEST_SYNC then exits =E2=80=94 run each to see upda=
te */
> +	for (i =3D 0; i < NR_VCPUS; i++) {
> +		vcpu_run(vcpus[vcpu_order[i]]);
> +		TEST_ASSERT_KVM_EXIT_REASON(vcpus[vcpu_order[i]], KVM_EXIT_IO);
> +	}
> +
> +	get_pvtis(vcpus, pvti);
> +
> +	TEST_ASSERT(pvti[0].system_time =3D=3D pvti[1].system_time &&
> +		    pvti[0].system_time =3D=3D pvti[2].system_time,
> +		    "system_time should still match after KVM_SET_CLOCK");
[ ... ]
> +int main(void)
> +{
[ ... ]
> +	/* Give each vCPU its own pvclock structure within the page */
> +	for (i =3D 0; i < NR_VCPUS; i++)
> +		vcpu_args_set(vcpus[i], 1, KVMCLOCK_GPA +
> +			      i * sizeof(struct pvclock_vcpu_time_info) * 2);
> +
> +	/* Get vCPU 0's default offset and set vCPU 2's offset higher */
> +	offset0 =3D vcpu_get_tsc_offset(vcpus[0]);
> +	vcpu_set_tsc_offset(vcpus[2], offset0 + TSC_OFFSET);
> +
> +	/* Run each vCPU to enable kvmclock (with offset already set) */
> +	for (i =3D 0; i < NR_VCPUS; i++) {
> +		vcpu_run(vcpus[i]);
> +		TEST_ASSERT_KVM_EXIT_REASON(vcpus[i], KVM_EXIT_IO);
> +	}

[Severity: Medium]
Should get_pvtis() also inspect the guest-visible pvclock structures mapped
at KVMCLOCK_GPA rather than only calling vcpu_get_clock_guest()?

In main(), the test maps guest memory at KVMCLOCK_GPA, gives each vCPU its
own pvclock GPA, runs guest_code() to write MSR_KVM_SYSTEM_TIME_NEW, and in
test_set_clock_consistency() runs each vCPU after vm_set_clock() to refresh
the per-vCPU pvclock state.

However, get_pvtis() only calls vcpu_get_clock_guest()
(KVM_GET_CLOCK_GUEST). In arch/x86/kvm/x86.c,
kvm_vcpu_ioctl_get_clock_guest() does not read the guest pvclock page or go
through kvm_guest_time_update(); instead, it synthesizes hv_clock directly
from the VM-wide master clock fields in struct kvm_arch:

arch/x86/kvm/x86.c:kvm_vcpu_ioctl_get_clock_guest() {
	...
		hv_clock.tsc_timestamp =3D kvm_read_l1_tsc(v, ka->master_cycle_now);
		hv_clock.system_time =3D ka->master_kernel_ns + ka->kvmclock_offset;
		hv_clock.tsc_shift =3D ka->master_tsc_shift;
		hv_clock.tsc_to_system_mul =3D ka->master_tsc_mul;
		hv_clock.flags =3D READ_ONCE(ka->all_vcpus_matched_tsc) ?
				 PVCLOCK_TSC_STABLE_BIT : 0;
	...
}

Because kvm_vm_ioctl_set_clock() updates ka->kvmclock_offset synchronously,
get_pvtis() never observes the guest memory at KVMCLOCK_GPA written by
kvm_guest_time_update(), and comparing system_time, tsc_to_system_mul, and
tsc_shift across vCPUs only compares the same VM-wide master_* fields to
themselves regardless of whether the vCPUs were run.

In addition, when main() calls vcpu_set_tsc_offset(vcpus[2], offset0 +
TSC_OFFSET), KVM_REQ_MASTERCLOCK_UPDATE is raised only on vcpus[2]. Running
vcpus[0], vcpus[1], and vcpus[2] in a single pass causes vcpus[0] and
vcpus[1] to populate their guest pvclock pages at KVMCLOCK_GPA before
vcpus[2] runs kvm_update_masterclock() and broadcasts KVM_REQ_CLOCK_UPDATE,
leaving the guest-visible pvclock pages for vcpus[0] and vcpus[1] with a
stale pre-update snapshot where PVCLOCK_TSC_STABLE_BIT is still set.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105154955.2525=
419-1-dwmw2@infradead.org?part=3D18
