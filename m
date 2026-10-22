Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708891;
	b=wo5KL53McdYDpftDhTG6TVEEYI2EpN0BUzwnx3RVpcVjJTB/dJfqTJwWhcvpHGi+GuIF
	 41mprFTz90RRUOdeFLUG3mjCZT0n5yHwQ4VVaNUi7z8+Xecf/NE49zkriOp1xlD06qvht
	 XKm/82Eqh/DPfWUtl5ldV/TUq6JiXBJ6h4qdpYvGqcUTdrPtA//gRnR+8FdIKrIasN8b4
	 Yp0TsmHc9VP22Vn9cK8P5/MgDYw8wqju9Vn8UVZ1CLdjfhMHMAjP8fvgkYPDmoJBZoXF7
	 z1tWRkLUvpL7vNhSNPAjhKtWEiMtWbB8PCZf8Ref8oyqY+ik/nyQxUFiZuc00Vz7iJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708891;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EZX7URfOS3OPTbTtGucDWN7bz5PEnJhJQLNz/9NJMA4=;
	b=URag+oLBW3jFU1esp5BcQWPFQ+xCh0+2S9kx6YjI701suVSxPIA13kHvPn44JUiYvw5j
	 mCNA+314Va51lQkZ6P8t12Zj3cOMPxeWccpnaaPYrydZ0dRWIYFTMJ45ZqUwZNYi3hyZQ
	 m5nRzadXyT5GSRfmkT0jXkdzUAQJ8PW//tj3dSorvJoosQt+jIfhjrlvsjE2Nw53hjiAT
	 1JP6SC6vxhOOUial1QO7zwxfY9jpckNpVm3SUCk1sJPBkGGv9liT2fiLwctYnWmuhzrjJ
	 8jhMcKbwZuqp8Oo5q3LcSdjw7OhPMVYlfMHTnLLfENVZq44QTbCV2ldpEfpWU7Tt+5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXEgDwfJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD5D606A31A
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXEgDwfJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22FD1F01825;
	Thu, 22 Oct 2026 22:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792708891;
	bh=EZX7URfOS3OPTbTtGucDWN7bz5PEnJhJQLNz/9NJMA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QXEgDwfJtC9UMke6RhWJ0ItyRXRkvv2AB0N89oG4XnqZT14xiD5BoqZJl8dBiq12B
	 qMRW0UrVVj8THyr0CE++Z3TIfbSqeqEOsUCFIg+gr3oX+ENUMsgXhDZpFG3mu5Upr2
	 iLzzjSGZXpka2EOqQaZ4DMIGkZisFiytTD4E2xgaGZXo1epiugu33il6VflV4uK8EJ
	 WQnVNTPYIszbOErnXSeQ4qpzfXhyDzAC7EEtjg4VBxgyEjLoJenKb0ZpKRgUlChfWD
	 oNKi0WnqL9HiPwvBHR1TrNkIdCofRJ6a52w+D9Po6EWYRD/7caPQuehYFN4lEYOjK/
	 Vtr9ik8Jg1kAQ==
Message-ID: <sashiko-outbox-182127@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] KVM: nSVM: Synthesize #GP instead of SHUTDOWN if L2
 attempts to clear EFER.SVME
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261022223052.646891-3-seanjc@google.com>
References: <20261022223052.646891-1-seanjc@google.com>
 <20261022223052.646891-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 22:41:30 +0000
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
- [High] kvm: userspace-reachable KVM_BUG_ON() in svm_set_efer() via KVM_SY=
NC_X86_SREGS
--

commit fd2bbc971d026eddf8121873792d458775b0e3cb
Author: Sean Christopherson <seanjc@google.com>

KVM: nSVM: Synthesize #GP instead of SHUTDOWN if L2 attempts to clear EFER.=
SVME

This commit synthesizes a #GP in set_efer() when clearing EFER_SVME while
in guest mode instead of forcing a triple fault shutdown in svm_set_efer().
It also converts the check in svm_set_efer() for clearing EFER_SVME while
is_guest_mode(vcpu) and vcpu->wants_to_run are true into a KVM_BUG_ON()
returning -EIO.

> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index 2df42276fd826..c3cb1575fe66e 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -626,6 +626,18 @@ static int set_efer(struct kvm_vcpu *vcpu, u64 efer)
>  	if (is_paging(vcpu) && (vcpu->arch.efer & EFER_LME) !=3D (efer & EFER_L=
ME))
>  		return 1;
> =20
> +	/*
> +	 * Architecturally (per the APM), clearing EFER.SVME while a guest is
> +	 * running yields undefined behavior, i.e. KVM can do literally
> +	 * anything.  Synthesize a #GP as that is the safest option for KVM,
> +	 * as mixing the current vCPU state (from L2) with L1 and the new EFER
> +	 * (if KVM simply forces the vCPU out of L2) may yield an unexpected
> +	 * end result.
> +	 */
> +	if (is_guest_mode(vcpu) &&
> +	    (vcpu->arch.efer & EFER_SVME) && !(efer & EFER_SVME))
> +		return 1;
> +
>  	efer &=3D ~EFER_LMA;
>  	efer |=3D vcpu->arch.efer & EFER_LMA;
> =20
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 487897ef11dd6..a6ff9635677a1 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -227,17 +227,12 @@ int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
>  	if ((old_efer & EFER_SVME) !=3D (efer & EFER_SVME)) {
>  		if (!(efer & EFER_SVME)) {
>  			/*
> -			 * Architecturally, clearing EFER.SVME while a guest is
> -			 * running yields undefined behavior, i.e. KVM can do
> -			 * literally anything.  Force the vCPU back into L1 as
> -			 * that is the safest option for KVM, but synthesize a
> -			 * triple fault (for L1!) so that KVM at least doesn't
> -			 * run random L2 code in the context of L1.  Do so if
> -			 * and only if the vCPU is actively running, e.g. to
> -			 * avoid positives if userspace is stuffing state.
> +			 * KVM is supposed to synthesize #GP if L2 attempts to
> +			 * clear SVME.
>  			 */
> -			if (is_guest_mode(vcpu) && vcpu->wants_to_run)
> -				kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
> +			if (KVM_BUG_ON(is_guest_mode(vcpu) &&
> +				       vcpu->wants_to_run, vcpu->kvm))
> +				return -EIO;
> =20
>  			svm_leave_nested(vcpu);
>  			/* #GP intercept is still needed for vmware backdoor */

[Severity: High]
Can userspace still reach this KVM_BUG_ON() during KVM_RUN via
KVM_SYNC_X86_SREGS when a vCPU is in guest mode?

In virt/kvm/kvm_main.c:kvm_vcpu_ioctl(), vcpu->wants_to_run is set before
calling kvm_arch_vcpu_ioctl_run():

	vcpu->wants_to_run =3D !READ_ONCE(vcpu->run->immediate_exit__unsafe);
	r =3D kvm_arch_vcpu_ioctl_run(vcpu);
	vcpu->wants_to_run =3D false;

Then arch/x86/kvm/x86.c:kvm_arch_vcpu_ioctl_run() syncs dirty registers
from userspace while vcpu->wants_to_run is already true:

	if (kvm_run->kvm_dirty_regs) {
		r =3D sync_regs(vcpu);
		if (r !=3D 0)
			goto out;
	}

When KVM_SYNC_X86_SREGS is set in kvm_dirty_regs, the call chain
sync_regs() -> kvm_run_sync_regs_from_user() -> __set_sregs() ->
__set_sregs_common() in arch/x86/kvm/regs.c bypasses set_efer() in
arch/x86/kvm/msrs.c and calls svm_set_efer() directly:

	*mmu_reset_needed |=3D vcpu->arch.efer !=3D sregs->efer;
	kvm_x86_call(set_efer)(vcpu, sregs->efer);

If userspace clears EFER_SVME in vcpu->run->s.regs.sregs.efer while
is_guest_mode(vcpu) is true, wouldn't svm_set_efer() trigger the
KVM_BUG_ON() and return -EIO (which __set_sregs_common() ignores) after
already updating vcpu->arch.efer =3D efer and without calling
svm_leave_nested(vcpu)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022223052.6468=
91-1-seanjc@google.com?part=3D2
