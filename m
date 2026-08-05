Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C221C84DC
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 03:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785901564; cv=none; b=TUr+HLFnaSfxxta4gYiW20BgSTfRhPqoVJ51O6bHZXKLlFzW2vGQwLzg/TjpdoM4MqHmjfMcJaq3Nz6orPMou4fcalgoajH5b3j4oXyGrCMlPrh3tJt87SwTiiAuWACkSv7XJsh8CO/3aK2KrwMbc313bef1ZW/KDPRJGaOsQMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785901564; c=relaxed/simple;
	bh=K1N199QmN0+5/DMHa2jT80scNogWYCZq0/cOnNK6cZU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EQ4xMkoNsrApgIYUCenkvGgDsgAwxr+rgujOGpViSkjpEW/FDdlepiS/uKs3NzO8BNVUFjSCY/sMntD4Peodk7Qc78iMCIAWfBzCrf98UoxJpLuRcLHlt7vsaY8zS0HNFis2rg2jjy7QLVSGrw/StLU7yawF1u1j98nb5DtYngU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9joDMZg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9joDMZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2BB1F000E9;
	Wed,  5 Aug 2026 03:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785901562;
	bh=PWdUZanx74aNhl6sRRlah5U78PyR9BxnjypVoCTL2S0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U9joDMZgC6LWEjGCN4soLRRdbY3d9VM+8wXZUfbCh1fe1WVaMwj3UKHTrYLsEfz4k
	 c0vYGgBMdtF+X6iRixJrfYRslaXFq8Y9kgO3LodfvevnNJVfcoxS+O+cy2gBi3INxm
	 BT4XWgLTeALgCu6jOdSR9k18gZVXhc1zdDKxeHrT0wghvGKz23J9P7ecWTeRXa/VSh
	 6BQKXbn8/w1nT/SHB+TzJwWzdBhjCMHjW0cVtY7/ppszF/yPr5RoxrLpDjO8Cz3ndf
	 IXyWThrsr46g8E+DYgsU1W7B82x/0RxqGbT/1r8oIOJ1cp8Be0a9LGAfwD9fBYK7hH
	 9cc8mpTSsOt4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: TDX: Enable Bus Lock VM exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiaoyao Li" <xiaoyao.li@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260805031257.1844914-3-xiaoyao.li@intel.com>
References: <20260805031257.1844914-1-xiaoyao.li@intel.com>
 <20260805031257.1844914-3-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 03:46:01 +0000
Message-Id: <20260805034602.5B2BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unmasked bus_lock_detected bit breaks TDX exit handling and guest =
execution.
- [High] Unvalidated VMCS write for BUS_LOCK_DETECTION allows userspace to =
trigger host WARN and crash VM.
- [High] tdx_handle_exit() silently masks negative error codes, returning u=
ndefined state to userspace.
--

--- Patch [2]: [PATCH 2/2] KVM: TDX: Enable Bus Lock VM exit ---
commit a95d478711dc8c7f94ecddd768bf45d636ab7635
Author: Xiaoyao Li <xiaoyao.li@intel.com>

KVM: TDX: Enable Bus Lock VM exit
   =20
Enable Bus Lock VM exit functionality for TDX guests by programming the
BUS_LOCK_DETECTION control in the TD VMCS and by adding the exit handler.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index cdc0d24657acb..c037e9cb5bdfc 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -2031,7 +2031,7 @@ int tdx_complete_emulated_msr(struct kvm_vcpu *vcpu=
, int err)
>  }
> =20
> =20
> -int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
> +static int __tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
>  {
>  	struct vcpu_tdx *tdx =3D to_tdx(vcpu);
>  	u64 vp_enter_ret =3D tdx->vp_enter_ret;

[Severity: High]
Does this code handle the bus_lock_detected bit (bit 26) being set in
vp_enter_ret or the raw 32-bit exit reason?

If userspace triggers a bus lock concurrently with an exit, the hardware can
set bit 26.  Will strict equality checks on vp_enter_ret (such as checking =
for
EXIT_REASON_EPT_MISCONFIG later in this function) fail because the bit is
unmasked?

This also appears to affect tdx_to_vmx_exit_reason(), where comparing the r=
aw
exit reason directly against 16-bit constants like EXIT_REASON_TDCALL will
fail to match if the bus lock bit is set, leading to incorrect emulation.

[ ... ]

> @@ -2141,6 +2143,21 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpat=
h_t fastpath)
>  	return 0;
>  }
> =20
> +int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
> +{
> +	int ret =3D __tdx_handle_exit(vcpu, fastpath);
> +
> +	/* Exit to user space when bus lock was detected */
> +	if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
> +		if (ret > 0)
> +			vcpu->run->exit_reason =3D KVM_EXIT_X86_BUS_LOCK;
> +
> +		vcpu->run->flags |=3D KVM_RUN_X86_BUS_LOCK;
> +		return 0;

[Severity: High]
Does this code silently drop negative error codes?

If __tdx_handle_exit() returns a negative error code (like -EIO or -EFAULT)
while bus_lock_detected is true, it skips setting vcpu->run->exit_reason but
still returns 0.

Could this cause KVM to return success to userspace with an uninitialized or
stale exit_reason instead of propagating the error?

> +	}
> +	return ret;
> +}

[ ... ]

> @@ -3167,6 +3184,10 @@ static int tdx_vcpu_init(struct kvm_vcpu *vcpu, st=
ruct kvm_tdx_cmd *cmd)
>  				vcpu->kvm->arch.notify_window);
>  	}
> =20
> +	if (vcpu->kvm->arch.bus_lock_detection_enabled)
> +		td_vmcs_setbit32(tdx, SECONDARY_VM_EXEC_CONTROL,
> +				 SECONDARY_EXEC_BUS_LOCK_DETECTION);

[Severity: High]
Is it safe to write this execution control to the TD VMCS without verifying=
 if
the TDX module supports it?

If a host userspace process enables KVM_CAP_X86_BUS_LOCK_EXIT but the TDX
module restricts this capability, could td_vmcs_setbit32() fail on TDH.VP.W=
R,
triggering the KVM_BUG_ON() macro and destroying the VM?

> +
>  	tdx->state =3D VCPU_TD_STATE_INITIALIZED;
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805031257.1844=
914-1-xiaoyao.li@intel.com?part=3D2
