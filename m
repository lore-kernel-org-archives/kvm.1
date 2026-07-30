Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC842C4E0
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414845; cv=none; b=PNsutDGbLibuSyVgofUt225reMMEpu6ua+5/iAnErn179swOqCJx3EOCo07ZWHAjTKyin4woZKRptFNujwf+alL8UmUHzoTGyHyW75Y1634Bs4TB7Zopa3nu35cWZY7HJcnq8pHalPFtrelvry15C0Y7GNpWST5sq8fDk/ryUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414845; c=relaxed/simple;
	bh=1gYGfWo1GBxEBqjEM37El2huI9mmM9m2KtOOyNF/Mec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O/McdgmCoPcKsYERyR0cKLU6HbDNwQQupCv8gAQc82jHyLrg9FyKg8DOmhRlgNKy2t6yTTIyo37d0HSiwaisbjoTQJYhE5gdgT3Wuby7fu2tIvRvoL5jxigzg9+B5UhHyy1K+xp+13c82DismYBVJkZkA/FJBJ8HGI12mvbVcpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOW8WWkN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOW8WWkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BA11F000E9;
	Thu, 30 Jul 2026 12:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785414843;
	bh=pjpULwMSclFPB+VyPj/olgFRrzVNYDfpP/EwVC47SmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WOW8WWkN0NcExFuKAK7eAnnEB8WIouHKjtoRGIUKSilfVKuye74wmQU8G5WWCaFjr
	 /t6tgICgy6m7i/pSoLMUHozwqrL0wfL5l8+WhNrizsy/6NkfDr3Kr3491x4cTNk0lN
	 vvGsKtybShquYBG/1DUH0TWOo+tCa0mfLITpvlQu8IaGsk8DU8jMopgEYyB2f+B6MP
	 HNHMhSJWTHoEfSUlnICN7PSB36foECSL0hW1JMfwSm4b5ttrNp9yFKAEvyzROd0W/4
	 bYeWJvsRBWQEy0tLVVBu6k3l0cIFsdGe8twAZp4wcXFYE6am9ONPDU3c1cXFuIejOP
	 zcD1qIvwh1fsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/9] KVM: nSVM: Track hardware-provided instruction
 bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <0d1e1110881aada32e474c74105f3d4cc5ba991e.1785411877.git.zhang_wei@open-hieco.net>
References: <cover.1785411877.git.zhang_wei@open-hieco.net>
 <0d1e1110881aada32e474c74105f3d4cc5ba991e.1785411877.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 12:34:03 +0000
Message-Id: <20260730123403.96BA11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch clears instruction bytes only on nested VMRUN, causing s=
tale DecodeAssist data from L0-handled exits to be falsely flagged as fresh=
 during subsequent intercepts.
- [High] Hardware-provided DecodeAssist data and the fresh flag are lost ac=
ross live migration for a pending nested #PF.
--

--- Patch [3]: [PATCH v3 3/9] KVM: nSVM: Track hardware-provided instructio=
n bytes ---
commit e944fdb4c1650228b5e210eab6c8b6fe2761112a
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: nSVM: Track hardware-provided instruction bytes
   =20
DecodeAssists provides instruction bytes for nested page faults and
intercepted page faults caused by data accesses.  When reflecting such an
exit to L1, KVM needs to distinguish bytes produced by the current hardware
VM-Exit from stale VMCB02 state.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index b63234a2feb8d..6e2ceb700567c 100644
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
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this unconditionally mark the instruction bytes as fresh for any PF_VE=
CTOR,
including instruction fetches where DecodeAssist is inactive?

If so, could this result in stale bytes from a previous hardware VM-Exit
being incorrectly synthesized to the L1 hypervisor?

> +
> +	return r;
>  }

[ ... ]

> @@ -3725,7 +3731,7 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, f=
astpath_t exit_fastpath)
>  		vmexit =3D nested_svm_exit_special(svm);
> =20
>  		if (vmexit =3D=3D NESTED_EXIT_CONTINUE)
> -			vmexit =3D nested_svm_exit_handled(svm);
> +			vmexit =3D nested_svm_exit_handled(svm, true);
                                                              ^^^^

[Severity: High]
By passing true here for all NESTED_EXIT_CONTINUE VM-exits, does this
incorrectly flag stale bytes as fresh for exits where DecodeAssist is
not active?

For example, if L2 causes a data #PF handled by L0 (which writes insn_bytes)
and is resumed without clearing the instruction bytes, and then L2 causes a
different exit intercepted by L1 (like an MSR intercept), will this pass the
stale instruction bytes to L1 as fresh?

> =20
>  		if (vmexit =3D=3D NESTED_EXIT_DONE)
>  			return 1;

[ ... ]

> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index a327bf751ecd5..96d2471a03c8c 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -242,6 +242,12 @@ struct svm_nested_state {
>  	 * on its side.
>  	 */
>  	bool force_msr_bitmap_recalc;
> +
> +	/*
> +	 * True if VMCB02 contains DecodeAssist instruction bytes from the
> +	 * hardware VM-Exit currently being reflected to L1.
> +	 */
> +	bool vmcb02_insn_bytes_fresh;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Will this tracking state be lost across live migration?

Since it appears this flag is added to the nested state structure but omitt=
ed
from KVM_GET_NESTED_STATE serialization, if a migration occurs while a nest=
ed
exit is pending, won't the target host fail to receive the instruction bytes
and potentially cause emulation failure in L1?

>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785411877.gi=
t.zhang_wei@open-hieco.net?part=3D3
