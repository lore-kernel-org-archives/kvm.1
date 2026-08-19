Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AC33C0626
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 06:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119529; cv=none; b=bq+YGEcoIYKSJbZNiM8NDqXiO81xsl3DjHc3tqPUbAgOhliX7zt8UkADO5YG+38DPur5+bkmmNkKBko2oYs+QK+ZFl195xyy6aQRh8Vkt0rscXxMHQ/nCKq2YR/nYomHl8nuwVQjHqnsfIAG7hGo4WEbpp4b9z939qKblrfpCes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119529; c=relaxed/simple;
	bh=qyWk3wYDEUfKeeygDZzDMMzNPci1Qq+fdb63l0qtVvQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hePv7wyUpwWVyqX4qmbWvs65ZDn3JAG5SVyEkdy4vxwTpWFEiwiwKZUXuNhCW5as0MalCTZYJm1Lo7hJ9pxuaNdB2rkIPugGLGoKnLxRz9jkMvg8X9v7eHYfEYqBeSmE40PXttyCvL4Pb2FNAivs9vlT32Um3ziz6L0A+kn3qI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnViJUuH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnViJUuH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65C21F00A3A;
	Wed, 19 Aug 2026 06:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787119527;
	bh=fSlgTqbLzBO+sRusvC79DuWXEvLMroUqSnMwB36qx2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WnViJUuH7WDTzARWhYB2/od6E6l++Jiyu8kJhhG8B6EhM+RTqqrVKoFfPbgA6dzPX
	 p3HWUIfLepyZarWO4IZId2qQuKQsgEdrDd1jbTAh4siHqCxz+45M6WEwbNFg2SsGHC
	 JwUlQEY+6jy1D3uGF41FkXrDi9fofMIEhY6hVTwGlNueUHqOCVe0RItZ1AYbeZ+GzY
	 GLs6UHqZdCq4at9zd628nYDJfPMt3Yz1QTe9hG9dkMtfuw0zC3weivesL86EL0OJcw
	 9YNxuHN3PYWPYi6Sad7xu1yV2J/x3lIeTvpySv0gn5QmiaK2yWHIzyey+V10uMJqd4
	 F/WxFGbVsDtcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/9] KVM: nSVM: Track hardware-provided instruction
 bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <6b31e31fd550906e29b2a59603f32fef1271a916.1787116250.git.zhang_wei@open-hieco.net>
References: <cover.1787116250.git.zhang_wei@open-hieco.net>
 <6b31e31fd550906e29b2a59603f32fef1271a916.1787116250.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 06:05:27 +0000
Message-Id: <20260819060527.C65C21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `vmcb02_insn_bytes_fresh` flag unconditionally marks DecodeAss=
ist instruction bytes as fresh for all reflected hardware VM-exits, which i=
ncorrectly leaks stale VMCB02 bytes to L1 if multiple L0 exits occur during=
 a single nested run.
--

--- Patch [3]: [PATCH v4 3/9] KVM: nSVM: Track hardware-provided instructio=
n bytes ---
commit f8e0d3f413f3670a241d2de3e149f5cbd8843299
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: nSVM: Track hardware-provided instruction bytes

This commit clears the VMCB02 instruction-byte fields before each nested run
and tracks whether a hardware VM-Exit being reflected to L1 includes fresh
instruction bytes. This tracking is intended to distinguish bytes produced =
by
the current hardware VM-Exit from stale VMCB02 state.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 73f37b050d0a0..d08c30e9a6f44 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c

[ ... ]

> @@ -868,7 +876,10 @@ static void nested_vmcb02_prepare_control(struct vcp=
u_svm *svm)
>  	/*
>  	 * Filled at exit: exit_code, exit_info_1, exit_info_2, exit_int_info,
>  	 * exit_int_info_err, next_rip, insn_len, insn_bytes.
> +	 * Clear stale DecodeAssist data before L2 runs.
>  	 */
> +	nested_svm_clear_insn_bytes(vmcb02);
> +	svm->nested.vmcb02_insn_bytes_fresh =3D false;

[Severity: High]
Does this only clear the instruction bytes during the initial L1 to L2 VMRU=
N?

If L0 handles an intermediate exit (like a nested page fault) and resumes L2
without re-clearing vmcb02, could the instruction bytes from that intermedi=
ate
exit be left behind?

[ ... ]

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index c7c1f1527c3cf..b85e43112db9e 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c

[ ... ]

> @@ -1953,14 +1953,20 @@ static void svm_set_dr7(struct kvm_vcpu *vcpu, un=
signed long value)
>  static int pf_interception(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_svm *svm =3D to_svm(vcpu);
> -
>  	u64 fault_address =3D svm->vmcb->control.exit_info_2;
>  	u64 error_code =3D svm->vmcb->control.exit_info_1;
> +	int r;
> +
> +	r =3D kvm_handle_page_fault(vcpu, error_code, fault_address,
> +				  static_cpu_has(X86_FEATURE_DECODEASSISTS) ?
> +				  svm->vmcb->control.insn_bytes : NULL,
> +				  svm->vmcb->control.insn_len);
> =20
> -	return kvm_handle_page_fault(vcpu, error_code, fault_address,
> -			static_cpu_has(X86_FEATURE_DECODEASSISTS) ?
> -			svm->vmcb->control.insn_bytes : NULL,
> -			svm->vmcb->control.insn_len);
> +	if (is_guest_mode(vcpu) && vcpu->arch.exception_vmexit.pending &&
> +	    vcpu->arch.exception_vmexit.vector =3D=3D PF_VECTOR)
> +		svm->nested.vmcb02_insn_bytes_fresh =3D true;

[Severity: High]
Does this unconditionally set the flag to true for all #PF exits that are
pending for L1?

Hardware doesn't provide DecodeAssist for instruction fetch faults. If an L2
guest triggers a data NPF followed immediately by a fetch fault, could this
leak stale instruction bytes from the data NPF to L1?

> +
> +	return r;
>  }

[ ... ]

> @@ -3723,7 +3729,7 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, f=
astpath_t exit_fastpath)
>  		vmexit =3D nested_svm_exit_special(svm);
> =20
>  		if (vmexit =3D=3D NESTED_EXIT_CONTINUE)
> -			vmexit =3D nested_svm_exit_handled(svm);
> +			vmexit =3D nested_svm_exit_handled(svm, true);

[Severity: High]
Does unconditionally passing true here ignore whether the hardware actually
provided DecodeAssist for this exit?

If the exit didn't populate DecodeAssist, could this pass stale bytes from a
previous exit to L1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787116250.gi=
t.zhang_wei@open-hieco.net?part=3D3
