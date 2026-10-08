Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF2735AC00;
	Thu,  8 Oct 2026 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496876; cv=none; b=JDRdSoi8m5qyDjzE59oqPyT/6LRCvUQx3lwLbHj7+AxaPvWuMT1il1CS7mh4MDlzKaqhI/tFV0t18zMQbGjVKucexUv8NRUBZeHYfB1z2EQk1U7AdiaIW8PnfYRIQLHGXwoj0QGsCUdRMCC0NEw8e+hR8KD12mMYGHmKUMWx9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496876; c=relaxed/simple;
	bh=EzotQ+VubRicpTlXAZVcyznjJayWhgujus9WrzbxhzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Akq0vZWF88hsFrMhT9Nn/4BBgfqntH5ozOCY/WuUFzlAmIq0FrYuaxHUA1M70rrjtPsZQ2scy/XQ2Itve7sXRfUay3MwgChV+XYVnZtvWCExhSW6N5lV91qk1jg6csgicepiKT7LUtHh2iT5gq7w2LBZoxb3WvHAH1Y9cqy06sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8FG/c3j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8FG/c3j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5516B1F000FF;
	Thu,  8 Oct 2026 22:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791496875;
	bh=HRHBCo9kaM9Lq2D+cATOnoVc5/WmJtcVScPwibq2C/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R8FG/c3jwtpFDMkupel4ywaIBMDgC6n4+MaDRvebKc6QOWzbxsXdLrLLmeYF6HO0m
	 P+65lBx3U8TPr4BQjGhZ7zcOX8NaaMEYmkYQ74rQdNwiLuXZRiIEKOJOQfH19IHpck
	 gABK0AYg7cel7wAbFSRszvVL0kQx+mgdIoCIBUeyYw27DEEMs/t7S83a7GD7UpaYRr
	 2FplrINRWXj7Lnzp1idniTPRAld5gVsja9OJaVUERV/atpAgBndhPkGq+zfHdoDTz1
	 kJQ6+xneJdu52zmGOOI65JD02qlXq0178PhW3qaBk5+Ezm6sUUvdSEKv9R2HjYiFWe
	 qOCGJybZZWgsw==
Date: Thu, 8 Oct 2026 22:01:13 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v2 10/29] KVM: SVM: Use a static ASID per vCPU
Message-ID: <asgSaujsiSqYXdXP@google.com>
References: <20261008001425.2458927-1-yosry@kernel.org>
 <20261008001425.2458927-11-yosry@kernel.org>
 <sashiko-outbox-163471@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-163471@kernel.org>

On Thu, Oct 08, 2026 at 12:30:26AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] kvm: SEV VM intra-host migration leaves source vCPUs with the migrated SEV ASID, enabling cross-VM encryption context sharing
> --
> 
> commit f1bcd0115d8d6ff1f7f41fcb1c4ff86d4d68a34e
> Author: Yosry Ahmed <yosry@kernel.org>
> 
> KVM: SVM: Use a static ASID per vCPU
> 
> This commit switches KVM from dynamic ASID allocation to a static per-vCPU
> ASID scheme on SVM. It removes the generation-based wraparound tracking,
> instead tracking pending flushes in the VMCB and reusing the same ASID
> across physical CPUs.
> 
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 0c3befd9bc850..8f27722bc4faf 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> [ ... ]
> > @@ -3875,37 +3868,24 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
> >  {
> [ ... ]
> >  	if (is_sev_guest(vcpu))
> >  		return pre_sev_run(svm, vcpu->cpu);
> >  
> > -	/* FIXME: handle wraparound of asid_generation */
> > -	if (svm->current_vmcb->asid_generation != sd->asid_generation)
> > -		new_asid(svm, sd);
> > +	if (unlikely(svm->vmcb->control.asid == fallback_asid))
> > +		vmcb_set_flush_asid(svm->vmcb);
> >  
> >  	return 0;
> >  }
> 
> [Severity: Critical]
> With the removal of dynamic ASID reallocation in pre_svm_run(), can a source
> vCPU permanently retain its migrated SEV ASID after a
> KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM migration?
> 
> During a KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM migration,
> sev_vm_move_enc_context_from() transfers the SEV ASID to the destination VM
> and marks the source VM as non-SEV. However, it intentionally skips the
> source vCPUs for vanilla SEV VMs:
> 
> arch/x86/kvm/svm/sev.c:sev_vm_move_enc_context_from() {
>         ...
> 		if (!dst->es_active)
> 			continue;
> 
> 		src_vcpu = kvm_get_vcpu(src_kvm, i);
> 		src_svm = to_svm(src_vcpu);
>         ...
> }
> 
> As a result, the source vCPUs retain the transferred SEV ASID (svm->asid)
> and the SVM_MISC_ENABLE_SEV bit in their VMCBs.
> 
> Previously, because the source VM was no longer considered an SEV guest,
> is_sev_guest() would return false, and the dynamic ASID allocation logic in
> pre_svm_run() would force the source vCPU to acquire a new, non-SEV ASID
> before running.
> 
> Now that the dynamic allocation logic is removed, the source vCPU will
> permanently retain the migrated SEV ASID.
> 
> If a malicious userspace hypervisor executes KVM_RUN on these zombie source
> vCPUs, KVM will treat the VM as non-SEV, allowing the hypervisor to bypass
> software protections and map its own nested page tables.

I am no SEV expert, but sev_vm_move_enc_context_from() calls
kvm_vm_dead() on the source VM, so all subsequent IOCTLs should fail,
including KVM_RUN, no?

> 
> Because the VMCB still has the SEV ASID and SEV=1, the hardware will decrypt
> the destination VM's memory using the destination's key. Does this break
> SEV confidentiality and memory isolation by allowing cross-VM encryption
> context sharing?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261008001425.2458927-1-yosry@kernel.org?part=10
