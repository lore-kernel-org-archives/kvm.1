Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399072;
	b=jmTkMTpMImVjpWK1idKrdJiW2rVRwYLetPELZwqAKObdjwtpUiqE3D8e3BN+6+l9Hbnh
	 w0Z7qNYb1A6rH2iQvQgzrv5VlIY91KhqG3WvY7IDGKLdIQDD07RvBnvF77nCle8LqgB/8
	 /EVLT/Y/SJpWtUpGvlUoDoa/joerfrIqSH6gehCBtT44QPukj9m8qcTsSh2tE723hDuvR
	 RRyUguKfAIRgg11Aak9VH/nlBRVMwNlTjLdwl3guW/2gLteVcvd8HNG+dfvmyMj1iIZ/W
	 MTKtQJj8tjasYi4cJLIeVQUhTxhnF8dmW3wDzoS1TT7UPoq0htyfXeFYmWdx1G2jGAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399072;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LiyYhDUll57MN+i6YDruf1spIaUOsvJrDoh/JrOf4SM=;
	b=KYYwjiI2tK6anBM7yr2dGQTpGoBisL9o7zEJRUtN8nb4z7VdAdJE0gOJnqDXBLQx6Qrh
	 9lgnpqYFACC2aOdovZSzVIY2+Bqsq61GBfHJOhAtf/DqbRM5/AzqVirOr7NtWJd6NpDrP
	 62+KPK6yN4peyXT8zc5YQ2S8PAUvEKOGz/UOwH9C8HpzYPffpQtFpQZ9e3B69C+Lr7Gd2
	 3bjhEQuJnyQETJOa7aGakXwBQ5ICbVEk2Gi4ItClC54Ffw9yoK0tS00zRrIghVx9AEDhn
	 PhEW8ZcaJZa0e0liTvJe0MC/zGtXlF3anPRx6mMuVCCHCg0FHJnKJY/ruX3GpY9wlHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEvVWm+M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2AD606A31A
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEvVWm+M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DD31F0093A;
	Fri, 30 Oct 2026 22:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793399071;
	bh=LiyYhDUll57MN+i6YDruf1spIaUOsvJrDoh/JrOf4SM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YEvVWm+MmQbWtfqDhkXJgVz6nFcLq0JIlXvC5x8DjRYN/dsF8E3cUvVoClANGGnhP
	 KNWobtDJoPz6Xd18GNTGOBqDwYJzjAFparDNklbZKpOEYjJ6uuYMdcclV+Aq+Wpj4G
	 /jfkpLDXPAFNtHl8U+aBc3z2CRNWrfqqrhSx44Fuwg1iMzO7N5lj3/qM/nT22K+N1U
	 gJPKSvuCpTn7EgKs/Zi3VpU+TQIMdO0R8vWOq4yWzYiD408kpNrhMctGpXtyNAyb0g
	 7SG8im4mVIaKxweCav6R5AJslRsK7otxmORm1jOX3Q00uA15WAo+fPXf9TEFyst+8o
	 UQ80oNmIDqVJQ==
Message-ID: <sashiko-outbox-191575@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] KVM: x86: Recompute EFER.LMA instead of
 inheriting the current value on EFER writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261030212721.2606393-6-seanjc@google.com>
References: <20261030212721.2606393-1-seanjc@google.com>
 <20261030212721.2606393-6-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 22:24:31 +0000
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
- [High] kvm: x86: guest-triggerable WARN_ON_ONCE in set_efer() via SVM sta=
te sync
--

commit 5720ef7430b0bd8d9e28950790604b1d1ec8ce2d
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Recompute EFER.LMA instead of inheriting the current value on EFE=
R writes

This commit updates set_efer() to recompute EFER_LMA from EFER_LME,
is_paging(vcpu), and is_pae(vcpu) instead of carrying forward the existing
EFER_LMA value from vcpu->arch.efer, and adds a WARN_ON_ONCE() if the
recomputed EFER_LMA differs from the previous value.

> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index c3cb1575fe66e..c55402970a345 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -638,8 +638,17 @@ static int set_efer(struct kvm_vcpu *vcpu, u64 efer)
>  	    (vcpu->arch.efer & EFER_SVME) && !(efer & EFER_SVME))
>  		return 1;
> =20
> -	efer &=3D ~EFER_LMA;
> -	efer |=3D vcpu->arch.efer & EFER_LMA;
> +	if ((efer & EFER_LME) && is_paging(vcpu) && is_pae(vcpu))
> +		efer |=3D EFER_LMA;
> +	else
> +		efer &=3D ~EFER_LMA;
> +
> +	/*
> +	 * Toggling EFER.LMA on a bare write to EFER should be impossible, as
> +	 * it means KVM allowed architecturally invalid state at some point in
> +	 * the past, i.e. allowed EFER.LMA=3D1 && (!CR0.PG || !CR4.PAE).
> +	 */
> +	WARN_ON_ONCE((efer & EFER_LMA) !=3D (vcpu->arch.efer & EFER_LMA));

[Severity: High]
As reported by Sashiko on v1 [1], can a guest or host userspace trigger this
WARN_ON_ONCE() via SVM paths that leave EFER_LMA in vcpu->arch.efer out of
sync with EFER_LME, X86_CR0_PG, and X86_CR4_PAE?

In arch/x86/kvm/msrs.c:set_efer(), changing EFER_LME while paging is enabled
is rejected earlier:

	if (is_paging(vcpu) && (vcpu->arch.efer & EFER_LME) !=3D (efer & EFER_LME))
		return 1;

As a result, the recomputed EFER_LMA always equals
((vcpu->arch.efer & EFER_LME) && is_paging(vcpu) && is_pae(vcpu)), and the
WARN_ON_ONCE() fires whenever a vCPU enters set_efer() with vcpu->arch.efer=
's
EFER_LMA bit out of sync with EFER_LME, X86_CR0_PG, and X86_CR4_PAE. Several
SVM paths appear to still leave EFER_LMA out of sync:

1. In arch/x86/kvm/svm/nested.c:nested_vmcb02_prepare_save() and
arch/x86/kvm/svm/svm.c:svm_set_cr0():

	/* SVM ignores EFER.LMA if EFER.LME=3D0 (instead of failing VMRUN). */
	if (!(svm->nested.save.efer & EFER_LME))
		svm->nested.save.efer &=3D ~EFER_LMA;

	svm_set_efer(vcpu, svm->nested.save.efer);

	svm_set_cr0(vcpu, svm->nested.save.cr0);
	svm_set_cr4(vcpu, svm->nested.save.cr4);

where svm_set_cr0() only updates EFER_LMA on a transition of X86_CR0_PG
relative to the previous vcpu->arch.cr0:

	if (vcpu->arch.efer & EFER_LME) {
		if (!is_paging(vcpu) && (cr0 & X86_CR0_PG)) {
			vcpu->arch.efer |=3D EFER_LMA;
			if (!vcpu->arch.guest_state_protected)
				svm->vmcb->save.efer |=3D EFER_LMA | EFER_LME;
		}

		if (is_paging(vcpu) && !(cr0 & X86_CR0_PG)) {
			vcpu->arch.efer &=3D ~EFER_LMA;
			if (!vcpu->arch.guest_state_protected)
				svm->vmcb->save.efer &=3D ~(EFER_LMA | EFER_LME);
		}
	}

Because L1 has X86_CR0_PG=3D1 when executing VMRUN, is_paging(vcpu) is alre=
ady
true when svm_set_cr0() runs. If L1 executes VMRUN with vmcb12->save
containing EFER_SVME=3D1, EFER_LME=3D1, EFER_LMA=3D0, X86_CR0_PG=3D1, X86_C=
R0_PE=3D1,
and X86_CR4_PAE=3D1 (which nested_vmcb_check_save() accepts because hardware
SVM ignores EFER_LMA in the VMCB save area), L2 runs with EFER_LMA=3D0 in
vcpu->arch.efer while EFER_LME=3D1, is_paging(vcpu), and is_pae(vcpu) are a=
ll
true. A subsequent WRMSR to MSR_EFER in L2 or KVM_SET_MSRS from userspace
enters set_efer(), computes EFER_LMA=3D1, and triggers the WARN_ON_ONCE().

2. On RSM from SMM into nested SVM via
emulator_leave_smm() -> svm_leave_smm() -> enter_svm_guest_mode() ->
nested_vmcb02_prepare_save(), emulator_leave_smm() clears X86_CR0_PG=3D0
before calling svm_leave_smm(). If vmcb12->save in guest memory has
EFER_SVME=3D1, EFER_LME=3D1, EFER_LMA=3D1, and X86_CR0_PG=3D0,
nested_vmcb02_prepare_save() does not clear EFER_LMA (since EFER_LME=3D1) a=
nd
svm_set_cr0() does not clear EFER_LMA (since is_paging(vcpu) is already
false). Immediately afterward, rsm_load_state_64() calls
__kvm_emulate_msr_write(vcpu, MSR_EFER, smstate->efer & ~EFER_LMA) ->
set_efer(), which computes EFER_LMA=3D0 against vcpu->arch.efer's EFER_LMA=
=3D1
and triggers the WARN_ON_ONCE().

3. In arch/x86/kvm/svm/nested.c:svm_set_nested_state(), the check on L1's
host save state in vmcb01->save only rejects (save->efer & EFER_LMA) &&
!(save->efer & EFER_LME):

	if (!(save->cr0 & X86_CR0_PG) ||
	    !(save->cr0 & X86_CR0_PE) ||
	    (save->rflags & X86_EFLAGS_VM) ||
	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
	    !nested_vmcb_check_save(vcpu, &save_cached, false))
		goto out_free;

and svm_leave_smm() similarly loads vmcb01->save from guest MSR_VM_HSAVE_PA
memory without checking EFER_LMA, allowing vmcb01->save to hold EFER_LME=3D=
1,
EFER_LMA=3D0, X86_CR0_PG=3D1, and X86_CR4_PAE=3D1. On nested_svm_vmexit() f=
rom a
paged L2 (where is_paging(vcpu) is already true):

	svm_set_efer(vcpu, vmcb01->save.efer);
	svm_set_cr0(vcpu, vmcb01->save.cr0 | X86_CR0_PE);
	svm_set_cr4(vcpu, vmcb01->save.cr4);

L1 is left with EFER_LMA=3D0 in vcpu->arch.efer while EFER_LME=3D1, X86_CR0=
_PG=3D1,
and X86_CR4_PAE=3D1, so the next WRMSR to MSR_EFER or KVM_SET_MSRS triggers
the WARN_ON_ONCE().

4. On SEV-SNP AP creation via sev_snp_init_protected_guest_state() and
kvm_vcpu_reset(), KVM initializes vcpu->arch.cr0 =3D X86_CR0_ET,
vcpu->arch.cr4 =3D 0, and vcpu->arch.efer =3D 0 while the guest VMSA can al=
ready
have X86_CR4_PAE=3D1 in hardware. In arch/x86/kvm/svm/svm.c:cr_trap():

	case 0:
		old_value =3D kvm_read_cr0(vcpu);
		svm_set_cr0(vcpu, new_value);

		kvm_post_set_cr0(vcpu, old_value, new_value);
		break;

If the AP traps on an MSR_EFER write setting EFER_LME=3D1 (while vcpu->arch=
.cr0
has X86_CR0_PG=3D0) and then traps on a CR0 write setting X86_CR0_PG=3D1 wi=
thout
having trapped on CR4, cr_trap() -> svm_set_cr0() sets
vcpu->arch.efer |=3D EFER_LMA even though vcpu->arch.cr4 is still 0. A
subsequent MSR_EFER write trap before any CR4 write enters
efer_trap() -> set_efer(), sees !is_pae(vcpu), clears EFER_LMA in
vcpu->arch.efer while the guest is running in long mode, and triggers the
WARN_ON_ONCE().

[1] https://lore.kernel.org/r/sashiko-outbox-182134@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030212721.2606=
393-1-seanjc@google.com?part=3D5
