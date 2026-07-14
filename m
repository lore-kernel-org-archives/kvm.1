Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F3D1A9F96
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 05:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007042; cv=none; b=atSOlfT79RNCIJWeTS4ZCoVC9wcBOPjhWRcf3V/j1rtOvyBqfpnC3b34mkx/HSD5vp0516Zh6nOuqomDWmqrHNa07fJDjxnZ3r01cfgNf/UwMndQn85erK7e3hXr74NslAXaP+BDxGyKuPNkroyZT8NU8MdnNICH7xeQLXrnFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007042; c=relaxed/simple;
	bh=jbPV9W/U0vba/iOGgCFLm7WNcbqrb7DPzZqn/W2T4+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WccON9rB5sMV3XkXtaSzqhLv5TdRUgjGqWjX7w0cpdsgIouOxnCfTBxMBX4VcVrk1YcM1uYxASoN5eyGxI37YiSNVYOtV47W7AeAG+aHwt6i4Kye3O5Mb+cO3ysZwhnTJW4/gzOEaDcybiGmvwa5U6Yq1gIEt7tkk/r3Ctlmib4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8xptJNM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8xptJNM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6264F1F000E9;
	Tue, 14 Jul 2026 05:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784007040;
	bh=irHX8YLvXSRPYdz5v8kdsIfSVKVSY7nKSNRLQYDbYPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V8xptJNMEfJfW7rhSvbwG/qnXqEEuNvKOlQ99bRFEWCfsPgy3ivnFr/70PV1kfSIi
	 /NktWHim0jy83GFGE5FU7xoptylt18Df2jTm4LJE0y22C3g2TQjhm9qwx6xcBkLiIS
	 gDG5/z63i7v+i/N668wg9PydkRWC7opvLcuO+uuaoNqB00ig+B9BqLokE4Q2pwAyKs
	 uS1jY/bJwqSoZ+nBHTbnPVucRYqY5m0J2XHygYJU6M4LNC97NSuxr9qW29lMMh5q5Y
	 fzWwZJmyzGoIaItMUlROw7P2mwpjWYpOLTKu8bDa2dK7pbodCc8lFsn3DMG84aA0fF
	 25jdL1+bCuwtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] KVM: nSVM: Track fresh VMCB02 DecodeAssist bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <e07b2a62d7dedf6bcddc16076cf2892e83db977b.1783999988.git.zhang_wei@open-hieco.net>
References: <cover.1783999988.git.zhang_wei@open-hieco.net>
 <e07b2a62d7dedf6bcddc16076cf2892e83db977b.1783999988.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 05:30:39 +0000
Message-Id: <20260714053040.6264F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch fails to set `vmcb02_insn_bytes_fresh` to `true` when re=
flecting a host-intercepted Guest Page Fault (`#PF`) to L1, discarding hard=
ware-provided DecodeAssist bytes.

Pre-existing issues:
- [High] KVM incorrectly identifies synthesized nested page faults (NPFs) a=
s hardware-generated if they occur during emulation of an original hardware=
 NPF, passing a stale `exit_info_2` (GPA) to L1.
--

--- Patch [3]: [PATCH v2 3/8] KVM: nSVM: Track fresh VMCB02 DecodeAssist by=
tes ---
commit 1b65a65904c11af4f22d9f6d0ea2c488ec16575d
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: nSVM: Track fresh VMCB02 DecodeAssist bytes

Track whether VMCB02 contains DecodeAssist instruction bytes from the
hardware VM-Exit currently being reflected to L1. Clear the fields before
each nested run so stale bytes cannot be mistaken for fresh hardware state.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index b340dc9991adb..70e2ee3af78b2 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -33,13 +33,21 @@
> =20
>  #define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
> =20
> +static void nested_svm_clear_insn_bytes(struct vmcb *vmcb)
> +{
> +	vmcb->control.insn_len =3D 0;
> +	memset(vmcb->control.insn_bytes, 0,
> +	       sizeof(vmcb->control.insn_bytes));
> +}
> +
>  static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
>  				       struct x86_exception *fault)
>  {
>  	struct vcpu_svm *svm =3D to_svm(vcpu);
>  	struct vmcb *vmcb =3D svm->vmcb;
> +	bool from_hardware =3D vmcb->control.exit_code =3D=3D SVM_EXIT_NPF;
> =20
> -	if (vmcb->control.exit_code !=3D SVM_EXIT_NPF) {
> +	if (!from_hardware) {

[Severity: High]
This isn't a bug introduced by this patch, but does evaluating the original
hardware exit code correctly identify emulator-synthesized nested page faul=
ts?

If an L2 guest accesses an unmapped MMIO region, it causes a hardware NPF.
L0 intercepts it and starts emulation. If the emulator then performs a guest
page table walk or instruction fetch which faults in the nested NPT, the
emulator injects a new NPF to L1 by calling nested_svm_inject_npf_exit().

Because the VMCB exit code still contains the original hardware NPF exit co=
de,
this check evaluates to true. This causes KVM to skip updating the faulting
GPA with the new faulting address, misleading the L1 hypervisor with the
original MMIO GPA and incorrectly marking stale instruction bytes as fresh.

[ ... ]
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 5137416be593d..fa65f6a1a59ba 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -238,6 +238,13 @@ struct svm_nested_state {
>  	 * on its side.
>  	 */
>  	bool force_msr_bitmap_recalc;
> +
> +	/*
> +	 * True if VMCB02's DecodeAssist instruction bytes belong to the hardwa=
re
> +	 * VM-Exit currently being reflected to L1.  KVM-synthesized exits leave
> +	 * it clear.
> +	 */
> +	bool vmcb02_insn_bytes_fresh;

[Severity: High]
Does KVM need to set vmcb02_insn_bytes_fresh to true when reflecting a=20
host-intercepted Guest Page Fault (#PF) to L1?

If L0 KVM intercepts a #PF from L2 (e.g., for shadow paging or async PF),
it processes the fault and later queues it for reflection to L1 if L1 also
intercepts it. KVM synthesizes the exit via
nested_svm_inject_exception_vmexit():

arch/x86/kvm/svm/nested.c:nested_svm_inject_exception_vmexit() {
	...
	vmcb->control.exit_code =3D SVM_EXIT_EXCP_BASE + ex->vector;
	...
}

However, this path fails to set vmcb02_insn_bytes_fresh to true. Since the
flag defaults to false when entering L2, it remains false, and any
hardware-provided DecodeAssist bytes for the #PF are discarded. This could
break instruction decoding and emulation logic in the L1 hypervisor.

>  };
> =20
>  struct vcpu_sev_es_state {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783999988.gi=
t.zhang_wei@open-hieco.net?part=3D3
