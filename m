Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5106D449B03
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615068; cv=none; b=CjCG/igYZTcMG2JjIDOpJoUNhkvZrQseZlwD6UOHVaj+WDouzidUNXM8Y3ZDlUCmYrzoHmlqbVQI/Mezngsr+ysQD4Z1du2BcoBRiCJlBsUPt7OJWU0b/bUdRi4zpiOHvalK04U07BK8rYOsTAHw7Ec2WNMfcx2CSDbeBmwGwp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615068; c=relaxed/simple;
	bh=3PBUOmL4Tx7mP+4VDyPQBA7KIQLqXjRflbNgV5oBfC0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xc+LLumFcFbZc11och1MdK0rvACS1FcZ8OndT9WluqB9OLht77pHsCTAtbL5X0y0BhqafnzLmkuC4IKruGI54Zn5pZSxQvzwin7znYHpEFNtkzgnmUqonvllksDYgzLgZiF1MPfjSSYgTS0jhNuwyVXf4bVCcteI/BO7mu4v/UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLzh5deY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLzh5deY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EB81F000E9;
	Tue, 21 Jul 2026 06:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784615067;
	bh=HHLaa/mGQTGA9pUNxUGo6LpABOJ4f0nDJwsnQSaJT2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FLzh5deYfSHU00f79BgxI1P3FEe126+qTVTalwcnKJNxS2IbS6KKYFoaCABN2DPjD
	 bmh/jJ7brwVWvXtPsM95vJv4+IUoXdEgaUAvqBjRWN0bAjLNwvCC2K/DNjBS8FragU
	 ef/tcAU7Gi2UT6kNc3bc1DQhG3ox3u/DiKmjpD+8eTCVYREtyjPREo3QcVwrZK4bYX
	 WillQbLaNUxSR0rxtPhi1e4AdKSRbooaD/g13cLrxlRkHHy5ckO6SrXFP3pQKb8+8i
	 0GNG7deWkNXYWXIXlxSl7Ru6ZSjhPgi9aAXT5+AGK2QZitd+DGmFgLqK5yVd/3CzlT
	 G/vfiCGmGF/aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: x86: Mark nested RSM-created VM-Enter as
 untrusted
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hao Zhang" <hao_zhang_kdev@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <al8M4gCwsWXS_jMs@192.168.1.215>
References: <al8M4gCwsWXS_jMs@192.168.1.215>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 06:24:26 +0000
Message-Id: <20260721062426.C4EB81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Leaked `nested_run_pending` flag in VMX permanently blocks event i=
njection to L1 after recovering from an invalid untrusted nested state.
--

--- Patch [1]: [PATCH v2] KVM: x86: Mark nested RSM-created VM-Enter as unt=
rusted ---
commit 096beaf30ae7e6e858dddc7bb2b2a980624ad7d1
Author: Hao Zhang <zhanghao1@kylinos.cn>

KVM: x86: Mark nested RSM-created VM-Enter as untrusted

RSM can restore state that indicates the vCPU was running L2 when SMI
arrived.  KVM then re-enters nested guest mode and marks nested_run_pending
so that the next KVM_RUN completes the pending nested transition.

Link to v1: https://lore.kernel.org/all/al3Qbq-jUYE-_72N@192.168.1.215/

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 4d2bacd00ec4f..f54757bd83821 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c

[ ... ]

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index cc75feec05daa..333072cc9bce4 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6720,7 +6720,8 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu,=
 fastpath_t exit_fastpath)
>  	 * invalid guest state should never happen as that means KVM knowingly
>  	 * allowed a nested VM-Enter with an invalid vmcs12.  More below.
>  	 */
> -	if (KVM_BUG_ON(vcpu->arch.nested_run_pending, vcpu->kvm))
> +	if (KVM_BUG_ON(vcpu->arch.nested_run_pending =3D=3D KVM_NESTED_RUN_PEND=
ING,
> +		       vcpu->kvm))
>  		return -EIO;

[Severity: High]
Does this allow the KVM_NESTED_RUN_PENDING_UNTRUSTED flag to leak and lock =
up
the vCPU?

If a malicious L2 guest modifies SMRAM to create an invalid nested state, t=
hen
executes RSM, vmx_leave_smm() restores this state and sets nested_run_pendi=
ng
to KVM_NESTED_RUN_PENDING_UNTRUSTED.

During vmx_vcpu_run(), the invalid state triggers an early return because of
vmx->vt.emulation_required:

	if (unlikely(vmx->vt.emulation_required)) {
		vmx->fail =3D 0;
		vmx->vt.exit_reason.full =3D EXIT_REASON_INVALID_STATE;
		...
		return EXIT_FASTPATH_NONE;
	}

This skips the code block at the end of vmx_vcpu_run() that normally clears
vcpu->arch.nested_run_pending =3D 0.

When __vmx_handle_exit() is subsequently called, the modified KVM_BUG_ON
allows this UNTRUSTED state to fall through without returning -EIO.  KVM th=
en
reaches this block:

		if (vmx->vt.emulation_required) {
			nested_vmx_vmexit(vcpu, EXIT_REASON_TRIPLE_FAULT, 0, 0);
			return 1;
		}

This synthesizes a TRIPLE_FAULT and transitions the vCPU back to L1, but it
doesn't clear the nested_run_pending flag before doing so.

Once back in L1, vmx_interrupt_allowed() unconditionally returns -EBUSY
because the flag is still set:

	if (vcpu->arch.nested_run_pending)
		return -EBUSY;

Will this cause kvm_check_and_inject_events() to constantly request an
immediate exit, permanently livelocking the host vCPU thread in an infinite
VM-Enter/VM-Exit loop?

> =20
>  	if (is_guest_mode(vcpu)) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/al8M4gCwsWXS_jMs@19=
2.168.1.215?part=3D1
