Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6558732FA18
	for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 00:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792197876; cv=none; b=DNhH0yDgCviHsD2lyeVjVRwBZ+Ep8c8czU9eMomxsGYF7yxE6HTSKD5p9UVdmftyz6VUn3I6uM3uU0VUTR25jXtmRLPnTNoGeANscdEFGA4GOtxS5ymRxz/BDxLnwQJwZhJS5cK/7HRjrjo7tp6wzmLWAMtRaLWvgyGdfpEuuMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792197876; c=relaxed/simple;
	bh=G9Fn0vKeKlRskLM2MvpP7X/Ls0qMYjJeB4xgPIUiCUA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=a2mi5JuURsV2T2Xo8RVP+E0IvB9Ud1gO8C789HZeTEjFGAS2gjzPAI5ekY3R4/VzsfE9tIRI0uNweZjeWzWJ/GEUKR12+yWzFENOYbyk7boLsznaKadib8W4Wpp6NlysFM7j+gmDqB6/mC9D2hLuioI80Ac/uRPwtZTPNPiBG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5cQhaRi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5cQhaRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED731F000C4;
	Sat, 17 Oct 2026 00:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792197875;
	bh=nrMzVv7PcTsgykqqPRR26QAYYINH6ICvW5nT/PRv/4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O5cQhaRimWygAKnE2VmXRsK/0sk3/obySSezpkGIwyAZtwYHqDlvM2s/0ij/5m3Xm
	 JMjXGcnn4jAE7ZgtVuTFOFtJb2ooFmc0E/hZtjtewRT2iJrSt8rtX6FBDNKlFenFhd
	 v5xevGA8a/69udA4u2LQlwADGWrga21uNYARIOoKAZLgnqabQ+SVr8vL9J+nmJoLzK
	 vRyWjkSGYVpqfMCvm+3JEgsXvQsPGxFMN7P6HXwRD5+xqy8Xz641IY0A5BSOHTa2na
	 kvtfEm1uaaloyI4vivMSXCqhWRmVq3JR232uJoeyAd9rtE6XybsyehXuUxVVTUtEk6
	 5PPdI9ifTyAVA==
Message-ID: <sashiko-outbox-175078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: nSVM: Reset the virtual VMLOAD/VMSAVE bit in
 vmcb02 on every nested VMRUN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amirmohammad Eftekhar" <amirmohammad.eftekhar@cispa.de>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261016235221.33726-2-amirmohammad.eftekhar@cispa.de>
References: <20261016235221.33726-2-amirmohammad.eftekhar@cispa.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 00:44:34 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM: nSVM: guest-triggerable WARN_ON_ONCE in nested_vmcb02_recalc_=
intercepts()
--

commit f74a55775787865d4cf964f0af9f8bea8ecd1acb
Author: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>

KVM: nSVM: Reset the virtual VMLOAD/VMSAVE bit in vmcb02 on every nested VM=
RUN

This commit clears SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE in
vmcb02->control.misc_ctl2 before conditionally setting it in
nested_vmcb02_prepare_control(), and adds a WARN_ON_ONCE() in
nested_vmcb02_recalc_intercepts() if both INTERCEPT_VMLOAD and
SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE are set in vmcb02.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index f9090b601efaa..67985c676db35 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -197,6 +197,14 @@ void nested_vmcb02_recalc_intercepts(struct vcpu_svm=
 *svm)
>  	} else {
>  		WARN_ON_ONCE(!(vmcb02->control.misc_ctl2 & SVM_MISC2_ENABLE_V_VMLOAD_V=
MSAVE));
>  	}
> +
> +	/*
> +	 * If KVM is intercepting VMLOAD/VMSAVE, virtual VMLOAD/VMSAVE must be
> +	 * off, or hardware would honor the virtualization and render the
> +	 * intercept inert.
> +	 */
> +	WARN_ON_ONCE(vmcb_is_intercept(&vmcb02->control, INTERCEPT_VMLOAD) &&
> +		     (vmcb02->control.misc_ctl2 & SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE));
>  }

[Severity: High]
Can an L1 guest or host userspace trigger this WARN_ON_ONCE() at will, and =
is
the hardware precedence between INTERCEPT_VMLOAD and
SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE reversed in the comment and commit message?

In nested_vmcb02_prepare_control(), SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE is set
in vmcb02->control.misc_ctl2 whenever !nested_vmcb_needs_vls_intercept(svm)
is true:

arch/x86/kvm/svm/nested.c:nested_vmcb_needs_vls_intercept() {
	if (!guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_V_VMSAVE_VMLOAD))
		return true;

	if (!nested_npt_enabled(svm))
		return true;

	if (!(svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE))
		return true;

	return false;
}

nested_vmcb_needs_vls_intercept() does not check whether INTERCEPT_VMLOAD is
set in vmcb12 or vmcb01. Immediately after setting
SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE, nested_vmcb02_prepare_control() calls
nested_vmcb02_recalc_intercepts(), which copies vmcb01->control.intercepts =
and
unconditionally ORs vmcb12_ctrl->intercepts into vmcb02->control.intercepts:

arch/x86/kvm/svm/nested.c:nested_vmcb02_recalc_intercepts() {
	...
	for (i =3D 0; i < MAX_INTERCEPT; i++)
		vmcb02->control.intercepts[i] =3D vmcb01->control.intercepts[i];
	...
	for (i =3D 0; i < MAX_INTERCEPT; i++)
		vmcb02->control.intercepts[i] |=3D vmcb12_ctrl->intercepts[i];
}

If an L1 guest sets both INTERCEPT_VMLOAD in vmcb12->control.intercepts and
SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE in vmcb12->control.misc_ctl2 (with nested =
NPT
and X86_FEATURE_V_VMSAVE_VMLOAD enabled), vmcb02 will have both bits set and
hit the new WARN_ON_ONCE() on VMRUN.

This occurs in normal software as well as malicious guests:

1. KVM's own selftest in
tools/testing/selftests/kvm/x86/nested_vmsave_vmload_test.c:l1_guest_code()
explicitly sets both INTERCEPT_VMLOAD | INTERCEPT_VMSAVE and
SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE in vmcb12 and runs L2 to verify that
SVM_EXIT_VMSAVE is still delivered:

	/* ..and SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE set */
	svm->vmcb->control.misc_ctl2 |=3D SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE;

	svm->vmcb->save.rip =3D (u64)l2_guest_code_vmsave;
	run_guest(svm->vmcb, svm->vmcb_gpa);
	GUEST_ASSERT_EQ(svm->vmcb->control.exit_code, SVM_EXIT_VMSAVE);

2. KVM running as an L1 hypervisor sets SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE in
init_vmcb() and never clears it, while svm_recalc_instruction_intercepts()
sets INTERCEPT_VMLOAD whenever L2 has EFER.SVME=3D0 or an Intel-compatible
CPUID:

arch/x86/kvm/svm/svm.c:svm_recalc_instruction_intercepts() {
	/*
	 * No need to toggle any of the vgif/vls/etc. enable bits here, as they
	 * are set when the VMCB is initialized and never cleared (if the
	 * relevant intercepts are set, the enablements are meaningless anyway).
	 */
	...
}

3. Host userspace can also trigger this warning via KVM_SET_NESTED_STATE
(svm_set_nested_state() -> nested_vmcb02_prepare_control() ->
nested_vmcb02_recalc_intercepts()), either by supplying a vmcb12 with both
bits set, or by calling KVM_SET_NESTED_STATE before the first KVM_RUN while
vmcb01->control.intercepts still has INTERCEPT_VMLOAD set from init_vmcb() =
(as
KVM_REQ_RECALC_INTERCEPTS is not serviced until vcpu_enter_guest()), or by
calling KVM_SET_CPUID2 to clear X86_FEATURE_V_VMSAVE_VMLOAD while in guest
mode.

As noted in the svm_recalc_instruction_intercepts() comment and verified by
nested_vmsave_vmload_test.c, AMD SVM hardware gives INTERCEPT_VMLOAD and
INTERCEPT_VMSAVE precedence over SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE. Should t=
he
WARN_ON_ONCE() be dropped (or should SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE not be
set when INTERCEPT_VMLOAD/VMSAVE is set), and the hardware behavior
description in the commit message updated?

> @@ -986,6 +994,13 @@ static void nested_vmcb02_prepare_control(struct vcp=
u_svm *svm)
> =20
>  	/* SVM_MISC2_ENABLE_V_LBR is controlled by svm_update_lbrv() */
> =20
> +	/*
> +	 * vmcb02 is reused across nested VMRUNs and the VLS bit below is only
> +	 * OR-set, so clear it first; a stale bit would let L2 run VMLOAD/VMSAVE
> +	 * unintercepted even on a VMRUN that asks KVM to intercept them.
> +	 */
> +	vmcb02->control.misc_ctl2 &=3D ~SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE;
> +
>  	if (!nested_vmcb_needs_vls_intercept(svm))
>  		vmcb02->control.misc_ctl2 |=3D SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE;
> =20

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016235221.3372=
6-2-amirmohammad.eftekhar@cispa.de?part=3D1
