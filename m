Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642339;
	b=IqRd57iKgCFEmMyVJEz48GJ9zuobY6pOmhkLp43A55I61temLyZJnhwlziTqXRXDsAH0
	 dlgg+feYn7nbtgDV75EGDMN+QGiVF/65J5NBbsTbidz02NJWIOEC73efKV4hurXtDx+KZ
	 /dn1hZm7aLeNXZt+yFHDya54giIoFdcV/nj8kH7wr9fteZ6eCaifNDo4e/L57OzYTNmkI
	 bvxxcsFN59yP8biTLMHghC1AHtTsbkWH0EJgCTtLt4u46QrfJ3i1d0K0px7YeyNDCK7yZ
	 /AqE6/Bk9FUtnsJgH4EnSU4Mj2OU5qsZuoqPEiEJGEcVY2uXyWS3crfe5lP7fjHQcUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642339;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rNTRoXMBrjZYa5i+gJ5FBqTXJJTNyBT1xgxaHVuCE0I=;
	b=ArRnjT/5X3nHnM8yWw12O91GGE21PDA4A05QbAqrv5bFF6YK/1Jr1L22qwaUcwX/W1Sf
	 1Yt8fIvsfWUoWAsPAox1xlSr5kMZkNdT3U30t/QZKa4YTznksaaoc/GsPZKxYPz57QNzX
	 q84KIhYN5biv8OKq1Rh+iNqZBIhNCAfrj3/epSUdGewENJjMGxoNSkiQpf2aOMMZCNahC
	 WPf2iDeSslmd0069VH7o3l1VLnqxBMjVXVZlAjtrcT6nuFUQW/aVYhEIAo0DBYte/jQjY
	 TL92A4ZupCQiZvBAeLunlzGIgVZ4ezM2c/h7W0AXS5bdA9oGSUBUNWc4DN9N3gSunPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aweAF98/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512BD606A5AA
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aweAF98/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00251F00A16;
	Mon,  2 Nov 2026 17:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793642338;
	bh=rNTRoXMBrjZYa5i+gJ5FBqTXJJTNyBT1xgxaHVuCE0I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=aweAF98/uXsh+/lBf5sd8+eCmtFaLnQXQilYFyvFU2tDb2SdJqE7pvDgcyjvtiix3
	 4WcngCyQRZJvZVsqOo1X67/KWljrxD9GufHo/kqPZMZGFjntRFrk355yJinu/v7D4t
	 Wkea4HRcS8t2uNXySuJtGPK29qWLSarTq4TUGstQrkCIdZjNE1Y5m406+S3lIkZjbV
	 rHpu08R5pmBrzmUKOYqsmbAegWLbpXlzkeUiav2tfaLb1p86CkKnz788LAE1lVrGvG
	 ouj/by0yFBG0/dvCzE7QaudCG72RE9hISJ7fp6ACgUvzWHEoWanq7qwiQq2fTF3efy
	 kegBn4QX6SeOQ==
Message-ID: <sashiko-outbox-193888@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/45] KVM: selftests: test hypercall memory fault exits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174130.8779-12-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174130.8779-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 17:58:58 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KVM: selftests: missing TSC clocksource check in test_clock_pair=
ing_fault()
--

commit ec6214ca720546d1e406955e679ce191a860ab11
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: selftests: test hypercall memory fault exits

This commit adds a new x86 KVM selftest to verify that hypercalls invoked
with invalid or read-only GPAs exit to userspace with KVM_EXIT_MEMORY_FAULT
when KVM_CAP_HCALL_FAULT_EXIT is enabled, and updates existing Hyper-V
tests to enable the capability.

Link: https://patch.msgid.link/20260918135030.171564-8-pbonzini@redhat.com

> diff --git a/tools/testing/selftests/kvm/x86/hcall_fault.c b/tools/testin=
g/selftests/kvm/x86/hcall_fault.c
> new file mode 100644
> index 0000000000000..725c59ff750c1
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/hcall_fault.c
> @@ -0,0 +1,246 @@

[ ... ]

> +static void clock_pairing_guest(gpa_t gpa)
> +{
> +	kvm_hypercall(KVM_HC_CLOCK_PAIRING, gpa, KVM_CLOCK_PAIRING_WALLCLOCK, 0=
, 0);
> +	GUEST_DONE();
> +}

[ ... ]

> +static void test_clock_pairing_fault(bool readonly)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	gpa_t gpa;
> +
> +	/* Unlike create_vm do not enable Hyper-V hypercalls. */
> +	vm =3D vm_create_with_one_vcpu(&vcpu, clock_pairing_guest);
> +	create_test_regions(vm);
> +	vm_enable_cap(vm, KVM_CAP_HCALL_FAULT_EXIT, 1);
> +	gpa =3D readonly ? READONLY_GPA : UNMAPPED_OUT_GPA;
> +	vcpu_args_set(vcpu, 1, gpa);
> +
> +	assert_memory_fault(vcpu, gpa, KVM_MEMORY_EXIT_FLAG_WRITE);
> +	kvm_vm_free(vm);
> +}
> +
> +int main(void)
> +{
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_CPUID));
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HCALL_FAULT_EXIT));
> +	TEST_REQUIRE(kvm_cpuid_has(kvm_get_supported_hv_cpuid(),
> +				   HV_ENABLE_EXTENDED_HYPERCALLS));
> +
> +	test_unused_gpas();
> +	test_readonly_input();
> +	test_input_fault();
> +	test_output_fault(false, false);
> +	test_output_fault(true, false);
> +	test_output_fault(false, true);
> +	test_clock_pairing_fault(false);
> +	test_clock_pairing_fault(true);

[Severity: Medium]
In arch/x86/kvm/x86.c, kvm_pv_clock_pairing() checks whether the host
clocksource is TSC-based via kvm_get_walltime_and_clockread() before
translating the GPA or checking vcpu->kvm->arch.hcall_fault_exit:

arch/x86/kvm/x86.c:kvm_pv_clock_pairing() {
	...
	*ret =3D -KVM_EOPNOTSUPP;
	if (clock_type !=3D KVM_CLOCK_PAIRING_WALLCLOCK)
		return 0;
	...
	if (!kvm_get_walltime_and_clockread(&ts, &cycle))
		return 0;
	...
	while (offset < sizeof(clock_pairing)) {
		...
		if (vcpu->kvm->arch.hcall_fault_exit) {
			hva =3D kvm_vcpu_gfn_to_hva_prot(vcpu, gpa_to_gfn(gpa), &writable);
			if (kvm_is_error_hva(hva) || !writable) {
				kvm_prepare_memory_fault_exit(vcpu, gpa & PAGE_MASK, PAGE_SIZE,
							      true, false, false);
				return -EFAULT;
			}
		}
}

If the host clocksource is not TSC-based (e.g., kvm-clock, hpet, or
acpi_pm), kvm_pv_clock_pairing() returns 0 with *ret =3D -KVM_EOPNOTSUPP
without preparing a memory fault exit, and clock_pairing_guest() proceeds to
GUEST_DONE(), causing assert_memory_fault() to fail on KVM_EXIT_IO.

Should main() guard the test_clock_pairing_fault() calls with
sys_clocksource_is_based_on_tsc()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D11
