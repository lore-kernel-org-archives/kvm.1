Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6AE47FB01
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072626; cv=none; b=gvlFjiW5ycKWzox9RqdqlelLJYp/kprzQVKqDtew0r0krE3ypPnMXcGFYtzOOZ1/MzdXbvit/HuPUMs3ZYvMyJlGhp1dn9Qji0iV9yoT57lbcJRMOBJ2QXQyxuvHhjVwFlvrmxwZ8NcAJB/7ZYmVjIzmi7O10WxrJswAQu9+rB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072626; c=relaxed/simple;
	bh=iLms/lfYAhix7MquwNCpGd9VgWe/28m6UfqKVQmh9iM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aoYsC07zzU4s9uPs9oEDhaPirodkxmuh8cQjpNC1fCHyCgiJtXOvtS+BGmCADJHLkmPfrimlaXpR7IjsfhicFoDIwmtcRRh9ynXeSQkWLzBIaEY3b3vD1USw4mTbDJrL3a3Z01/lJQr7YJOt1CkKx0+HElglt0bVPuDJykJxKSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgyWMgW+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgyWMgW+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55481F00A3F;
	Tue, 18 Aug 2026 17:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787072624;
	bh=PUoT81c4fAeXYz+2zaUBt9Gnk1egot2qPXrhePRbnyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HgyWMgW+9Sf3qtPsMQLUZjTeBsD8A4KL4FTIU1+JI5I4Uw5eFzNE/g9oeR9cZXTEq
	 gVcHiLDHwXzksZxlUGb419lIESDy1yNswEhxuHtQrUagor097fm0TcG5A/7W6UpW3Z
	 /2vjd9cHu/aAij5v4VgrGElNUF6nfCZxLePwF5jUOnRAN8dy3VNpNCgkIOb7Ebkbfs
	 ylo6f8CeXMd1ghX/DvqDZ43sEnL4gODeJxajtAB9yKI13LPo1+Jf9xr4aZKknqptA1
	 0n71vPOJj9deRuPEJKJWjQ/NZ3ZrYDXJe3hTZed7+fcI0iUsIawqH/UCCeypq0siNe
	 Kupa/xA/ORN+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] KVM: nVMX: Make VMPTRLD result in #UD when eVMCS
 is used
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vitaly Kuznetsov" <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260818165258.2613603-2-vkuznets@redhat.com>
References: <20260818165258.2613603-1-vkuznets@redhat.com>
 <20260818165258.2613603-2-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 17:03:44 +0000
Message-Id: <20260818170344.A55481F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch resolves an infinite VM-exit loop for `VMPTRLD` by injec=
ting a `#UD` exception when eVMCS is active, but fails to apply the same fi=
x to `handle_vmptrst`. In `handle_vmptrst`, returning 1 without skipping th=
e instruction or queuing an exception resumes the guest at the exact same i=
nstruction, leading to a permanent infinite VM-exit loop (soft lockup) for =
the vCPU.
--

--- Patch [1]: [PATCH v2 1/4] KVM: nVMX: Make VMPTRLD result in #UD when eV=
MCS is used ---
commit b2e2c0bdf82798edec492517d5390cf5a8348a25
Author: Vitaly Kuznetsov <vkuznets@redhat.com>

KVM: nVMX: Make VMPTRLD result in #UD when eVMCS is used

VMPTRLD with active eVMCS is already forbidden, however, returning 1
without skipping the instruction or queuing an exception will likely
result in L1 getting stuck. Genuine Hyper-V seems to inject #UD under
similar circumstances, mimic the behavior in KVM.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221841

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 6957bb6f5cf7e..c78c67525ac9b 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5883,6 +5883,12 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
>  	if (!nested_vmx_check_permission(vcpu))
>  		return 1;
> =20
> +	/* Forbid normal VMPTRLD if Enlightened version was used */
> +	if (nested_vmx_is_evmptr12_valid(vmx)) {
> +		kvm_queue_exception(vcpu, UD_VECTOR);
> +		return 1;
> +	}
> +
>  	if (nested_vmx_get_vmptr(vcpu, &vmptr, &r))
>  		return r;
> =20
> @@ -5892,10 +5898,6 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
>  	if (vmptr =3D=3D vmx->nested.vmxon_ptr)
>  		return nested_vmx_fail(vcpu, VMXERR_VMPTRLD_VMXON_POINTER);
> =20
> -	/* Forbid normal VMPTRLD if Enlightened version was used */
> -	if (nested_vmx_is_evmptr12_valid(vmx))
> -		return 1;
> -

[Severity: High]
This isn't a bug introduced by this patch, but does handle_vmptrst() suffer
from the same issue that this patch fixes in handle_vmptrld()?

Looking at handle_vmptrst():

arch/x86/kvm/vmx/nested.c:handle_vmptrst() {
...
	if (unlikely(nested_vmx_is_evmptr12_valid(to_vmx(vcpu))))
		return 1;
...
}

Returning 1 here without skipping the instruction or queueing an exception
seems to resume the guest at the exact same VMPTRST instruction, potentially
leading to a permanent infinite VM-exit loop (soft lockup) for the vCPU.

Could handle_vmptrst() also be updated to inject a #UD exception?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818165258.2613=
603-1-vkuznets@redhat.com?part=3D1
