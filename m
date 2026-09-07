Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB6340BCCB
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764426; cv=none; b=Eq9sEjamHwGx9WV73UlFnyG9h78QxcthROiQ0w5oMAsW1n+abPXVPPCmJmyyUO4Ic2nVWPVodd/krRD8Z00XIyDs6G6uuniTLQa3T0BC/F8mFkdW785XMt/Xfu2QmY95/2pkBzpMiIHqJts6im5TzY7T3wPENeC32uwptrEqwgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764426; c=relaxed/simple;
	bh=AtR1TLMinbxPuJKX2t349xZl5our4Sr6VjoeA7j48BM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BpkaMSKY0pr9l1F7EGS3HqTrZfZ0gA1eQOu+75yv0KMrPrNZ/YtP1Z+T98qcXY0UZQR8UvKP09WHuVBKTSwHM2iT/VN1uRI8r2s4NpL4P+BxrAsEbyUHao30yV4D65gBTe1fDbo9Xk5fF7IeOhpoxfTm2fXAWcfTbC9yetR6Nf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNePlwb/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNePlwb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7E11F00A3D;
	Mon,  7 Sep 2026 07:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788764424;
	bh=G7vbL/KCbllkpQsYyZBXB3NGfvBqCioTt5l2adn9kBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DNePlwb//6JPOCaKmgLC7+MwXLPNHdAd2npeSFKAIYKZiDPyMrUhMV2QRvwnGDE2D
	 DZ20Md8JqRndNNME8Q/6DDnDHLy8GPf2UJWFy7yrxYE24khYh78EoF4aoRBr13Cy0t
	 6IRjNkruD51BuyMSwLt/pIq5xjkJM8zIxnthUespuSS1zcGpHhMHHxp+89WRxQPCYm
	 Iqk43D6+PbZWmOkx4HlchnvEYNzGWrYbbXr8H6ipikJ0SpUggEltHRhLY77QG1257i
	 R32WNPoIZpDiCG746/tocWg/DMkiPEAz57ZMaVD+MQA0p+Cp0DmliauV9CZ26uYZod
	 xX1EIeopcqFIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 8/8] KVM: SVM: Add Page modification logging support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikunj A Dadhania" <nikunj@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260907063906.1964557-9-nikunj@amd.com>
References: <20260907063906.1964557-1-nikunj@amd.com>
 <20260907063906.1964557-9-nikunj@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 07:00:23 +0000
Message-Id: <20260907070024.4A7E11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Hardware PML is disabled for nested L2 guests, but the KVM MMU=
 is not informed, causing all memory dirtied by L2 to be silently lost.
- [High] The PML index is reset in memory but the VMCB is not marked dirty,=
 causing the processor to use a stale cached index and livelock.
- [Medium] Missing .flush_pml_buffer implementation in svm_x86_ops causes K=
VM_GET_DIRTY_LOG to return incomplete data.
--

commit d1428c9c095cb0cc4ca5ce0ed8ebb044a3eb17a3
Author: Nikunj A Dadhania <nikunj@amd.com>
Subject: KVM: SVM: Add Page modification logging support

This commit adds support for the Page Modification Logging (PML) feature
on AMD processors. PML automatically logs dirty guest physical addresses to
a buffer when the CPU sets NPT D-bits, offering a hardware-assisted method
for efficient dirty logging.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 73f37b050d0a0..da417c4c59154 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -901,6 +901,13 @@ static void nested_vmcb02_prepare_control(struct vcp=
u_svm *svm)
>  	vmcb02->control.msrpm_base_pa =3D vmcb01->control.msrpm_base_pa;
>  	vmcb_mark_dirty(vmcb02, VMCB_PERM_MAP);
> =20
> +	/*
> +	 * PML is never enabled in hardware for L2.  Make sure that an
> +	 * unexpected PML write would trigger a PML_FULL VM-Exit.
> +	 */
> +	if (pml)
> +		vmcb02->control.pml_index =3D -1;

[Severity: Critical]
By intentionally leaving hardware PML disabled for nested L2 guests in=20
nested_vmcb02_prepare_control without informing the KVM MMU, doesn't this=20
cause all memory dirtied by L2 to be silently lost?

When an L2 guest writes to memory and the host KVM has PML enabled, the KVM=
=20
MMU creates L2 shadow NPT SPTEs as writable but clears the D-bit. If hardwa=
re=20
PML is disabled for L2, the hardware will set the D-bit but will not log th=
e=20
GPA, potentially leading to silent memory corruption upon live migration.

[ ... ]

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 7d59d301e1e54..950c250a77b51 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
[ ... ]
> @@ -3344,6 +3376,45 @@ static int vmmcall_interception(struct kvm_vcpu *v=
cpu)
>  	return kvm_emulate_hypercall(vcpu);
>  }
> =20
> +static void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu, bool ena=
ble)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +	struct vmcb *vmcb01 =3D svm->vmcb01.ptr;
> +
> +	if (enable)
> +		vmcb01->control.misc_ctl |=3D SVM_MISC_ENABLE_PML;
> +	else
> +		vmcb01->control.misc_ctl &=3D ~SVM_MISC_ENABLE_PML;
> +
> +	vmcb_mark_dirty(vmcb01, VMCB_NPT);
> +}
> +
> +static void svm_flush_pml_buffer(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +	struct vmcb_control_area *control =3D &svm->vmcb->control;
> +
> +	/* Do nothing if PML buffer is empty */
> +	if (control->pml_index =3D=3D PML_HEAD_INDEX)
> +		return;
> +
> +	kvm_flush_pml_buffer(vcpu, control->pml_index);
> +
> +	/* Reset the PML index */
> +	control->pml_index =3D PML_HEAD_INDEX;
> +}

[Severity: High]
Since the PML index is reset here without marking the VMCB_NPT field dirty =
via
vmcb_mark_dirty(svm->vmcb, VMCB_NPT), will the CPU hardware ignore the reset
and use a stale cached value?

This could lead to a situation where the processor continuously generates a
PML_FULL VMEXIT on every subsequent write because the cached index remains =
at
zero, causing guest livelock and a performance collapse.

[ ... ]
> @@ -5429,6 +5525,8 @@ struct kvm_x86_ops svm_x86_ops __initdata =3D {
>  	.check_intercept =3D svm_check_intercept,
>  	.handle_exit_irqoff =3D svm_handle_exit_irqoff,
> =20
> +	.update_cpu_dirty_logging =3D svm_update_cpu_dirty_logging,
> +
>  	.deliver_interrupt =3D svm_deliver_interrupt,
>  	.pi_update_irte =3D avic_pi_update_irte,
>  	.setup_mce =3D svm_setup_mce,

[Severity: Medium]
Is there a missing implementation of .flush_pml_buffer in svm_x86_ops?

Without .flush_pml_buffer exported to the generic KVM x86 ops,=20
kvm_vcpu_flush_pml() might silently do nothing. This would result in
KVM_GET_DIRTY_LOG returning incomplete data, potentially delaying live
migration convergence or confusing userspace tools expecting an accurate
snapshot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907063906.1964=
557-1-nikunj@amd.com?part=3D8
