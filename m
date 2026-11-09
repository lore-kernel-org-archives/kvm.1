Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188848;
	b=WrWUmg/saa5QSaAa2bJuz+m1vmeDCMTi3N1q+sKVu4NydBS05eldQks1gY70/UATrGEf
	 ImBbmbQSfx/yDPTKiyFgc9KR8RX7NCP3vlQdTSD1OtitxcX8ZvuVN/QP/+w9nz+uTQOHh
	 iXdWF3f7/JA+cwg2+3Ogfj6SOUk2aUpjjfhV3GoVh8seFvs+wbRS+n9rZupqjw9R+Ltaq
	 dkbyMEkIxV0UFzCVZzygKwnz136jm3DT6YpCelgzSXn8LTipIRi3LX47/3Sjwgc7guBL+
	 brp1yYFLZJ8rXEQ7WfY1629/ygB3OaoS+PcknoojQiQ8+gX1g5k62sN/g9AnJfT2tZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188848;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oNyy0DWDA8yFVIzbVtf+fVoyIHOs2497EscnzATp9u4=;
	b=ZpFBQ39NhurFmRUgorABLWg7WAkTEAL4aH3p6BOYRYqS6tssM1PEM09siBaWzOCM2fd4
	 jMoopLYc1rCamkh/sINEk2xzbUYoEULP/q5X61hm2wHZdQpBfb9vQKmsau09d4arTgZwi
	 dFMu6bveLvBMpenE0T2dWHFC8jJWIS6zMBOTZsP5Fi0ud4nwncBrMqbUbqSnKC+TnsuO6
	 mD7i77lUyerUvhUVhlzUseChi6+ODftTBDuVrJDzmYb0ODrUYGHb0iW8rYSH5jwIMvGUH
	 usULBpqEF6Y/OQIAhR7rOdFEQIIPqlKwUj641L3x/1g7SpPWmZHFl8O7q7jDWCaFOHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvuFo4qt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36922606A321
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 01:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvuFo4qt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DA91F0089F;
	Mon,  9 Nov 2026 01:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794188847;
	bh=oNyy0DWDA8yFVIzbVtf+fVoyIHOs2497EscnzATp9u4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IvuFo4qt6Ru9fKXnh1z4A5e1V5kO17l4EBfJ/b+9bPtvkHwwpXBwIWPKiuQgvUCtV
	 nFXmIZ34I3Q7m1ufmrABrc0ygiqbtYzWTQynfPosfFRacM6TKNm6YFNoe082/44NZl
	 Q/TqCKQu9W4wBOKV5rCZSFd6xybm2xph0npXRi3aiI9/5zp1xma2G8aPDvumGjsvda
	 62IJ5NvVcTCnuFmjg7ztOEcinZPYxSl79QXjHykbx2/unEqh5tAyyC+UDWELdyCP3T
	 icv6H3zX/rQW6xScqIoiJagJgwdCHs0XxzYJx726u/goEcMTm8HzcuY/N76RpWnnFc
	 v8mHTgWcTKJyQ==
Message-ID: <sashiko-outbox-204320@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 18/24] KVM: selftests: Add master clock offset test
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>, kvm@vger.kernel.org
In-Reply-To: <20261109012112.3415328-19-dwmw2@infradead.org>
References: <20261109012112.3415328-1-dwmw2@infradead.org>
 <20261109012112.3415328-19-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 01:47:27 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] KVM: selftests: get_pvtis() never reads guest pvclock pages
  at KVMCLOCK_GPA
--

commit afe5627be945a0319bdf870a16137575eb9a6ca5
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: selftests: Add master clock offset test

This commit adds an x86 KVM selftest to verify that master clock mode
remains active and pvclock readings stay consistent across vCPUs with
different TSC offsets, both initially and after advancing the clock via
KVM_SET_CLOCK.

> diff --git a/tools/testing/selftests/kvm/x86/masterclock_offset_test.c b/=
tools/testing/selftests/kvm/x86/masterclock_offset_test.c
> new file mode 100644
> index 0000000000000..faf81872538eb
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/masterclock_offset_test.c
> @@ -0,0 +1,203 @@

[ ... ]

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

[Severity: Medium]
Should get_pvtis() read the per-vCPU pvclock_vcpu_time_info structures
from guest memory at KVMCLOCK_GPA (or check both guest memory and
vcpu_get_clock_guest())?

The test sets up guest memory at KVMCLOCK_GPA, enables
MSR_KVM_SYSTEM_TIME_NEW in guest_code(), and runs each vCPU after
vm_set_clock() so kvm_guest_time_update() refreshes the guest pvclock
structures.  However, get_pvtis() only calls vcpu_get_clock_guest()
(KVM_GET_CLOCK_GUEST), which synthesizes hv_clock directly from the
VM-wide master clock fields in struct kvm_arch without reading the guest
pvclock pages:

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

As a result, the guest memory at KVMCLOCK_GPA is never inspected, and
checking that tsc_to_system_mul, tsc_shift, and system_time match across
vCPUs compares the same VM-wide ka->master_* fields against themselves
regardless of whether vcpu_run() updated the guest pvclock structures.
In addition, because vcpu_set_tsc_offset() on vcpus[2] in main() queues
KVM_REQ_MASTERCLOCK_UPDATE only on vcpus[2], running vcpus[0..2] once in
order populates the guest pvclock structures for vcpus[0] and vcpus[1]
before vcpus[2] runs kvm_update_masterclock() and broadcasts
KVM_REQ_CLOCK_UPDATE, leaving vcpus[0] and vcpus[1] with stale guest
memory state until the next vcpu_run().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109012112.3415=
328-1-dwmw2@infradead.org?part=3D18
