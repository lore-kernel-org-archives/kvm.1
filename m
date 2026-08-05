Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B996A6BB5B
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785901132; cv=none; b=HV4FoY4OW3ugDQxa8GNG75ZIDXSacAI/bK1d+lZypuO1icGWjjlRsqA+h1B52d1m0GvfJ60Pgu8rzVnHcyZi1YhcWwYnWb5mawvxXVVRQzxloc5hUIBSWF2Ytb7WdNildk8Ukqhq2CCL1UDBjHKkswH6nv9BWlhfChL//5ELPGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785901132; c=relaxed/simple;
	bh=myi+OopJSk0FLs1e5f+EsAM1Z/jH1YINrdYHFTdHwZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QEttR/tThOZ0NJvUb1XTQxTA5oknDhgrKxP+B0i0RNtjJ+SdbLmvugQpNKqLwuV58clxCKq16gl4DArSjM+LCGhlTDa8SzGd68BySLPGWAmKuV8tJyxQ1iyGUJ1rcO28qOShNDqgzcKKYJmSsYFtY+LgjSaqmqIufO5QOWs8ECQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmSRR9jl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmSRR9jl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38FAD1F000E9;
	Wed,  5 Aug 2026 03:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785901131;
	bh=xaSZuJQ8hGnFn6qF8E6s2Xyxc+yUPsPu3rOnVphUfSc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LmSRR9jlxFob9IENG7caaCXDW5UP0ZFn2JxkkyNF64nnV6ledOyAJY+XQ7652S6Iv
	 u0t3UYT0P3TqEwa4rD54Zygb/eI4mEkpKk+3qVaPgJabfbpmz1woCULiJGkhc8o4S/
	 PLfd+2f/1prRRc1n+RocDTok2y8GePZ/60UHBUUHwIA3fuyawklPnuOgFzM1/j8MlE
	 31ZLAMlJNF/s8uoi/REJZvzc4z1e3+KowEk5BasqSkRGPP3Sds2blLlBCforzwaS1Y
	 qRJ0NaHK+XZFyGwQxbo5q0TuU8Iuxf0tKv4vW8yxhMydNgc5I3rSQOe7759/B/q6tl
	 tj+xJ7uLNXoWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KVM: TDX: Enable Notify VM exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiaoyao Li" <xiaoyao.li@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260805031257.1844914-2-xiaoyao.li@intel.com>
References: <20260805031257.1844914-1-xiaoyao.li@intel.com>
 <20260805031257.1844914-2-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 03:38:50 +0000
Message-Id: <20260805033851.38FAD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Userspace can trigger a host-side KVM_BUG_ON (which includes a WAR=
N_ON_ONCE) by enabling KVM_CAP_X86_NOTIFY_VMEXIT on a TDX VM when the under=
lying TDX module does not support the feature.
--

--- Patch [1]: [PATCH 1/2] KVM: TDX: Enable Notify VM exit ---
commit c9d2769fa5b2847408c7817858612eb62b0c8346
Author: Xiaoyao Li <xiaoyao.li@intel.com>

KVM: TDX: Enable Notify VM exit

This commit enables Notify VM exit functionality for TDX guests by configur=
ing
the NOTIFY_VM_EXITING and Notify Window in the TD VMCS during vCPU
initialization. It also adds an exit handler to process TDX Notify VM Exits
and delegates NMI blocking state handling to the TDX module.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 545b03d9d10b8..cdc0d24657acb 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
[ ... ]
> @@ -3157,6 +3160,13 @@ static int tdx_vcpu_init(struct kvm_vcpu *vcpu, st=
ruct kvm_tdx_cmd *cmd)
>  	td_vmcs_write64(tdx, POSTED_INTR_DESC_ADDR, __pa(&tdx->vt.pi_desc));
>  	td_vmcs_setbit32(tdx, PIN_BASED_VM_EXEC_CONTROL, PIN_BASED_POSTED_INTR);
> =20
> +	if (kvm_notify_vmexit_enabled(vcpu->kvm)) {
> +		td_vmcs_setbit32(tdx, SECONDARY_VM_EXEC_CONTROL,
> +				 SECONDARY_EXEC_NOTIFY_VM_EXITING);

[Severity: High]
Does this allow an unprivileged userspace process to trigger a host-side
KVM_BUG_ON() and crash the host if panic_on_warn is enabled?

If KVM advertises KVM_CAP_X86_NOTIFY_VMEXIT globally based solely on CPU
hardware support, userspace can enable it for a TDX VM. If the underlying
TDX module (e.g., v1.0) does not support Notify VM Exiting, this write
will fail.

When the TDX module write operation fails, the macro backing
td_vmcs_setbit32() calls tdh_vp_wr_failed(), which triggers a KVM_BUG_ON():

arch/x86/kvm/vmx/tdx.c:tdh_vp_wr_failed() {
	KVM_BUG_ON(1, tdx->vcpu.kvm);
	pr_err("TDH_VP_WR[%s.0x%x]%s0x%llx failed: 0x%llx\n", ...);
}

Should we verify that the loaded TDX module actually supports the Notify VM
Exit feature before attempting to program these TD VMCS fields?

> +		td_vmcs_write32(tdx, NOTIFY_WINDOW,
> +				vcpu->kvm->arch.notify_window);
> +	}
> +
>  	tdx->state =3D VCPU_TD_STATE_INITIALIZED;
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805031257.1844=
914-1-xiaoyao.li@intel.com?part=3D1
