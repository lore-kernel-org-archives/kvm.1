Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793037121;
	b=4O+8X4+BWeGC+MDsWAKDyjELxZGymtti2ETBLM+DqoBBllAn9yCe/x5R6OwLfxJmWNE9
	 N4S582MgYN5/NQ0pHuG0fZhrIfrCask8JtkkmblwWimsObxo/AJDiX45H/smo5PuTjhIV
	 gcht6rdQmfUpg6VyL+8CI750HnkIA40+743M2lTxc5iKy6Er5DjADJXyWk45zWAD4nk7C
	 0mZxGPafiHwSZcHREY8fOeI2+qxAro/qB+j4M6sGNY8TGk913WXIbm9IUoZ4iZ2cJ6yfv
	 kYvAYVkjM9Cq0I4h3SBu6Cb7dDb+vHfLGcyIUOY8kwu8z48UKo4H43fPsozLIPBe+Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=La0LweeObaZXk+KmiUrwtJDhtNlJw55vuKFmJ7P+2rk=;
	b=yf85Iuojv08blRk7v5zYu4ejCw7XGFj3hS5OmfO8fjhjfnPFvC4tRDk+yO9vypAM+Bje
	 2829S7D5KSm9J6Qj6EFdpblSFHoGs54WpA6SmR9/hmqNh9iesp/XSLU0KeeUUAvtGhlJm
	 m6XF4yzyna1kNVBFPTxHDLkKC4RTNHcBzn/3c+Huo9r/mgdyva77XSObROFHyX9cN0xz5
	 arLYwg4BclOpIvh36gAYnESjoY8Mv2X769D/upoYs+Iu2/p8R/NNHuKJdSDCALlxxzh+Z
	 Lto4tCu6UsdiekZyvhAMCMgdyG9BoOb+IVKBaHLMMW9wSSC/JKC8RYUAOR+MwOC+fUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GhHbLCPI;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7D1606A31A
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 17:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D7D1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GhHbLCPI
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ad3fc547bfso3089018a91.2
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793037121; x=1793641921; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=La0LweeObaZXk+KmiUrwtJDhtNlJw55vuKFmJ7P+2rk=;
        b=GhHbLCPIFjSY9HIArXCpRT+VB7a0M7n7sxFe+sAJPRrIlyMpa+MV5HMBTfG9nRellU
         7r4kn+xbV+a/pCc6L6HQgS6k8u/h4CGou5BUlqJEjKtJKeus9CGnwvzegcGNq6DVJtan
         Ur1EyEgurnwOknR7qFhoQmKbYJzJoX7kq1kqcD/qV0bCU02TbPyIIhRLk1OdrpyG7qht
         9PN6Hq5SMeeFAkOXMmQwZuEWM2HmzXQwjAnbpNh631cvcGx2/hObHS5YNvlL/HvaAEXd
         HcpuvitCgvGIOJSKK+ocutCpJEy+OyfC2hdLkGUuXu4gCIkDCpYtpxfwGbpYSbc93cBY
         sf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793037121; x=1793641921;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=La0LweeObaZXk+KmiUrwtJDhtNlJw55vuKFmJ7P+2rk=;
        b=Zdz6TeKKdLTontes31XGtWfpvvlQ1vAS0tXuTDIbMtCBvUC5HouCiuj9JwtMNbk6JD
         AnXdFQshaeNmyCXBl0zPLFThYmXuGSK9t2VdQK7x5gK/k09xFDmMKte2vngOsmFJh8/v
         ueqt2KMd8Luc+ztWePfnX53ATRJtxJ3htt2B/fN+J6+3l9RmcQ9cCeT7LgzmFqTe3iyF
         pfQeqHk0YCZFVekHcwdHQr5+KlHJ+WSe2rPWF3w0G5svWcl8egt/ER8bzuLFHuafrL9t
         nG7yN9wGwc6jSVfHc3p8G9xp25SLdkCX5sPBR2M4N6hYnTLcJQpUYdH/kXcPej3cBwfW
         SM8Q==
X-Gm-Message-State: AFq9FYJS0S1PyxzCSDrkyPU6bj/4EwYyGXjNXq8G6A7SkquLHSQN0q8c
	3qlyTAPu5KS/9Z77gm/5UxpbLrPIEmBlfOHcFDweZ++ejXf+AjiQPEWiTjkKaBAsfB7Psgu059q
	67oFMbA==
X-Received: from pjblj15.prod.google.com ([2002:a17:90b:344f:b0:3a4:fb9f:4a65])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c0d:b0:3ac:7556:8ed9
 with SMTP id 98e67ed59e1d1-3adea9dab5cmr5810939a91.10.1793037120447; Mon, 26
 Oct 2026 10:52:00 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:51:59 -0700
In-Reply-To: <sashiko-outbox-182134@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022223052.646891-1-seanjc@google.com> <20261022223052.646891-4-seanjc@google.com>
 <sashiko-outbox-182134@kernel.org>
Message-ID: <at-TP7Il6rWcd5Xh@google.com>
Subject: Re: [PATCH 3/4] KVM: x86: Recompute EFER.LMA instead of inheriting
 the current value on EFER writes
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 22, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> > index c3cb1575fe66e..41f3ec6eb2866 100644
> > --- a/arch/x86/kvm/msrs.c
> > +++ b/arch/x86/kvm/msrs.c
> > @@ -638,8 +638,18 @@ static int set_efer(struct kvm_vcpu *vcpu, u64 efer)
> >  	    (vcpu->arch.efer & EFER_SVME) && !(efer & EFER_SVME))
> >  		return 1;
> >  
> > -	efer &= ~EFER_LMA;
> > -	efer |= vcpu->arch.efer & EFER_LMA;
> > +	if ((efer & EFER_LME) && is_paging(vcpu) && is_pae(vcpu))
> > +		efer |= EFER_LMA;
> > +	else
> > +		efer &= ~EFER_LMA;
> > +
> > +	/*
> > +	 * Toggling EFER.LMA on a bare write to EFER should be impossible, as
> > +	 * it means KVM allowed architecturally invalid state at some point in
> > +	 * the past, i.e. allowed EFER.LMA=1 && (!CR0.PG || !CR4.PAE).
> > +	 */
> > +	if (WARN_ON_ONCE((efer & EFER_LMA) != (vcpu->arch.efer & EFER_LMA)))
> > +		return 1;
> 
> [Severity: High]
> Can a guest or host userspace trigger this WARN_ON_ONCE() and get a spurious
> #GP (or failed RSM / KVM_SET_MSRS) via SVM paths that still leave EFER_LMA
> in vcpu->arch.efer out of sync with (EFER_LME && CR0.PG && CR4.PAE)?

LOL, followed by a freaking disseration.

> Earlier in arch/x86/kvm/msrs.c:set_efer(), KVM rejects changing EFER_LME
> while paging is enabled:
> 
> arch/x86/kvm/msrs.c:set_efer() {
> 	...
> 	if (is_paging(vcpu) && (vcpu->arch.efer & EFER_LME) != (efer & EFER_LME))
> 		return 1;
> 	...
> }
> 
> Because of that check, the recomputed EFER_LMA in set_efer() is always equal
> to ((vcpu->arch.efer & EFER_LME) && is_paging(vcpu) && is_pae(vcpu)). The new
> WARN_ON_ONCE() therefore triggers whenever a vCPU enters set_efer() with
> vcpu->arch.efer & EFER_LMA out of sync with those bits.
> 
> There appear to be three SVM paths where that still happens:
> 
> 1. Nested SVM VMRUN and RSM into L2:
> 
> Architecturally on SVM, VMRUN ignores EFER.LMA in the VMCB save area and sets
> EFER.LMA from (EFER.LME && CR0.PG) in hardware, so nested_vmcb_check_save()
> does not require save->efer & EFER_LMA to match (EFER_LME && CR0.PG):
> 
> arch/x86/kvm/svm/nested.c:nested_vmcb_check_save() {
> 	...
> 	/*
> 	 * These checks are also performed by KVM_SET_SREGS,
> 	 * except that EFER.LMA is not checked by SVM against
> 	 * CR0.PG && EFER.LME.
> 	 */
> 	if ((save->efer & EFER_LME) && (save->cr0 & X86_CR0_PG)) {
> 		if (CC(!(save->cr4 & X86_CR4_PAE)) ||
> 		    CC(!(save->cr0 & X86_CR0_PE)) ||
> 		    CC(!kvm_vcpu_is_legal_cr3(vcpu, save->cr3)))
> 			return false;
> 	...
> }
> 
> However, nested_vmcb02_prepare_save() only clears EFER_LMA when EFER_LME is
> 0, and relies on svm_set_cr0() to update EFER_LMA:
> 
> arch/x86/kvm/svm/nested.c:nested_vmcb02_prepare_save() {
> 	...
> 	/* SVM ignores EFER.LMA if EFER.LME=0 (instead of failing VMRUN). */
> 	if (!(svm->nested.save.efer & EFER_LME))
> 		svm->nested.save.efer &= ~EFER_LMA;
> 
> 	svm_set_efer(vcpu, svm->nested.save.efer);
> 
> 	svm_set_cr0(vcpu, svm->nested.save.cr0);
> 	svm_set_cr4(vcpu, svm->nested.save.cr4);
> 	...
> }
> 
> And svm_set_cr0() only updates EFER_LMA in vcpu->arch.efer when CR0.PG
> transitions relative to the previous vcpu->arch.cr0:
> 
> arch/x86/kvm/svm/svm.c:svm_set_cr0() {
> 	...
> 	if (vcpu->arch.efer & EFER_LME) {
> 		if (!is_paging(vcpu) && (cr0 & X86_CR0_PG)) {
> 			vcpu->arch.efer |= EFER_LMA;
> 			if (!vcpu->arch.guest_state_protected)
> 				svm->vmcb->save.efer |= EFER_LMA | EFER_LME;
> 		}
> 
> 		if (is_paging(vcpu) && !(cr0 & X86_CR0_PG)) {
> 			vcpu->arch.efer &= ~EFER_LMA;
> 			if (!vcpu->arch.guest_state_protected)
> 				svm->vmcb->save.efer &= ~(EFER_LMA | EFER_LME);
> 		}
> 	}
> 	...
> }
> 
> Because L1 must have CR0.PG=1 to execute VMRUN, is_paging(vcpu) is already
> true when svm_set_cr0() runs during VMRUN. If vmcb12 has CR0.PG=1, CR4.PAE=1,
> EFER.LME=1, and EFER.LMA=0, svm_set_cr0() never sets EFER_LMA, leaving L2
> running in 64-bit mode with EFER_LMA=0 in vcpu->arch.efer. When L2 executes a
> valid WRMSR(MSR_EFER) (for example setting EFER_NX or EFER_SCE) or userspace
> calls KVM_SET_MSRS, set_efer() computes EFER_LMA=1, triggers WARN_ON_ONCE(),
> and injects a #GP into L2.

This looks like a KVM bug, i.e. we want the WARN and should fix the underlying
bug.

> Conversely, during RSM to L2 via emulator_leave_smm() -> svm_leave_smm() ->
> enter_svm_guest_mode() -> nested_vmcb02_prepare_save(), emulator_leave_smm()
> clears CR0.PG before calling svm_leave_smm(). If vmcb12 has EFER.LME=1,
> EFER.LMA=1, and CR0.PG=0, is_paging(vcpu) is already false when svm_set_cr0()
> runs, leaving EFER_LMA=1 with CR0.PG=0. When rsm_load_state_64() then calls
> __kvm_emulate_msr_write(vcpu, MSR_EFER, smstate->efer & ~EFER_LMA) ->
> set_efer(), set_efer() computes EFER_LMA=0, triggers WARN_ON_ONCE(), and
> aborts RSM with X86EMUL_UNHANDLEABLE.

Same here?

> 2. KVM_SET_NESTED_STATE and svm_leave_smm() followed by #VMEXIT:
> 
> In arch/x86/kvm/svm/nested.c:svm_set_nested_state(), L1's saved host state in
> vmcb01->save is only checked for ((save->efer & EFER_LMA) &&
> !(save->efer & EFER_LME)) (and svm_leave_smm() copies vmcb01->save from
> guest MSR_VM_HSAVE_PA memory without checking EFER_LMA):
> 
> arch/x86/kvm/svm/nested.c:svm_set_nested_state() {
> 	...
> 	if (!(save->cr0 & X86_CR0_PG) ||
> 	    !(save->cr0 & X86_CR0_PE) ||
> 	    (save->rflags & X86_EFLAGS_VM) ||
> 	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
> 	    !nested_vmcb_check_save(vcpu, &save_cached, false))
> 		goto out_free;
> 	...
> }
> 
> If vmcb01->save has EFER.LME=1, EFER.LMA=0, CR0.PG=1, and CR4.PAE=1, then on
> nested_svm_vmexit() from a paged L2 (where is_paging(vcpu) is already true),
> svm_set_efer() and svm_set_cr0() leave L1 with EFER_LMA=0 while EFER_LME=1,
> CR0.PG=1, and CR4.PAE=1, causing the next WRMSR(MSR_EFER) or KVM_SET_MSRS to
> trigger the WARN_ON_ONCE() in set_efer().

And here.

> 3. SEV-ES and SEV-SNP write traps:
> 
> In arch/x86/kvm/svm/svm.c:cr_trap(), SVM_EXIT_CR0_WRITE_TRAP and
> SVM_EXIT_CR4_WRITE_TRAP call svm_set_cr0() and svm_set_cr4() directly without
> checking consistency between EFER.LMA, CR0.PG, and CR4.PAE:
> 
> arch/x86/kvm/svm/svm.c:cr_trap() {
> 	...
> 	case 0:
> 		old_value = kvm_read_cr0(vcpu);
> 		svm_set_cr0(vcpu, new_value);
> 
> 		kvm_post_set_cr0(vcpu, old_value, new_value);
> 		break;
> 	case 4:
> 		old_value = kvm_read_cr4(vcpu);
> 		svm_set_cr4(vcpu, new_value);
> 
> 		kvm_post_set_cr4(vcpu, old_value, new_value);
> 		break;
> 	...
> }
> 
> Because svm_set_cr0() sets EFER_LMA without checking is_pae(vcpu) (for
> example on an SEV-SNP AP created via SVM_VMGEXIT_AP_CREATE where
> sev_snp_init_protected_guest_state() calls kvm_vcpu_reset() and clears
> vcpu->arch.cr4 while the VMSA has CR4.PAE=1), or if a guest clears CR4.PAE
> observed via cr_trap() while EFER_LMA=1, a subsequent efer_trap() ->
> set_efer() sees EFER_LMA=1 with !is_pae(vcpu) and triggers the WARN_ON_ONCE()
> and #GP.

Ugh.  I _want_ this to be a KVM bug, e.g. as is already pointed out by the comment:

	 * Clear EFER_LMSLE for a related reason: EFER writes are *trapped*,
	 * not intercepted, i.e. hardware has already committed the write by
	 * the time KVM gains control, and the trap is enabled if and only if
	 * the guest is SEV-ES, whose EFER lives in the encrypted VMSA and so
	 * can't be fixed up by KVM.  Rejecting EFER.LMSLE=1 would inject a #GP
	 * *and* leave EFER.LMSLE set in the guest, which is strictly worse
	 * than honoring a write that hardware itself allowed.

"rejecting" a value and injecting a #GP is completely pointless.  The guest already
has the "bad" value in EFER, and a misbehaving guest can simply eat the #GP.

But the issue is really just that KVM simply doesn't have visibility into EFER.LMA
being set.  Heh, which technically makes this a bug fix, since IIUC, the current
code will never set EFER.LMA in this case?

I can't think of any way to do the right thing other than to rely on hardware to
not screw up?  E.g.

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 41f3ec6eb286..3a6a0ebf1932 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -648,7 +648,8 @@ static int set_efer(struct kvm_vcpu *vcpu, u64 efer)
 	 * it means KVM allowed architecturally invalid state at some point in
 	 * the past, i.e. allowed EFER.LMA=1 && (!CR0.PG || !CR4.PAE).
 	 */
-	if (WARN_ON_ONCE((efer & EFER_LMA) != (vcpu->arch.efer & EFER_LMA)))
+	if (WARN_ON_ONCE((efer & EFER_LMA) != (vcpu->arch.efer & EFER_LMA) &&
+			 !vcpu->kvm->arch.has_protected_state))
 		return 1;
 
 	r = kvm_x86_call(set_efer)(vcpu, efer);


Hmm, though all of these cases make me wonder if we'd better off with just a WARN,
i.e. no #GP, since the goal is to enforce a consistent model, which is what the
new code does.

	/*
	 * Toggling EFER.LMA on a bare write to EFER should be impossible, as
	 * it means KVM allowed architecturally invalid state at some point in
	 * the past, i.e. allowed EFER.LMA=1 && (!CR0.PG || !CR4.PAE).
	 */
	WARN_ON_ONCE((efer & EFER_LMA) != (vcpu->arch.efer & EFER_LMA) &&
		     !vcpu->kvm->arch.has_protected_state);
