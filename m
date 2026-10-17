Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDE4296BC8;
	Sat, 17 Oct 2026 00:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196730; cv=none; b=U9h/q53vsVRj1tQYhz3xNhY7sgNVo6+7zumJYZ+TjDGRvsus2Nle1eX2A3u6U9GxoQ55ZUAZBC/JKuM2WaDN30O3iQduxrx4tN6G59UtIpdN96WTM32MCYQI9EtUXHIAg58PNbVCKHQLla0xY3vjBQCBM+Ef7FyQ3OE8w7hcNWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196730; c=relaxed/simple;
	bh=6phze58+1EAMEfpcc7733WPyqHcs5wwcwMeH9Qvw3e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAZGXm1WyLA0+//4yL+51CpKeudLPHOzLlESk9k32fsaSJZG0cFRkSLi0fn4TXM4FpVtJqP/or4Z7K20EGvDVKgb3v5BfXibVEkXapb92FQg/zRcpaSPVAYIHDMDvrkca1Pap6iliDkfpBqSxKso6fSUww5TDAhjcIpvu4M68TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZ/l9etZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZ/l9etZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A8A1F000C5;
	Sat, 17 Oct 2026 00:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196729;
	bh=0ZD6ChK7lg1utHvEY0sj2hl57RF+hR8oMWnZxli03SU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RZ/l9etZbpYWiIt+zAzgTUDaKeHS4t1ldMj1RjoutsPCC7ngDpwZ1fcD4L0+/GPko
	 YmlsZHWIo0hthteX3KV/tdot1Q+aiPFRvpP+NLVYH/DHu0ps4GR7ME8D17NU315wxg
	 E7G8Xw2/lWKSi5uLqrxBdSHmlXhMcC0BW1gFdFjn+EMasmJlACWxfm9OSugyTd9QEl
	 99qepXN5jryXWXvy0M52RlKIe1LJhbbRt1W4tpuZTYa+PRNdnmp3HxMlwaVkisYtoS
	 syHmRnK4h2O4N4ZAOSmArwkJeh6zTwB7ELRF4G+wcGLbmXwhl4aPZjfmkpmI5TbBYE
	 4I29+z285zqeQ==
Date: Sat, 17 Oct 2026 00:25:27 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v3 26/27] KVM: nSVM: Use different ASIDs for L1 and L2
Message-ID: <atK3Y5XxL-zmAvY-@google.com>
References: <20261012233638.2546339-1-yosry@kernel.org>
 <20261012233638.2546339-27-yosry@kernel.org>
 <CALMp9eS8KDozNGT9J_uN69W32QEvTbg2JrtRqN0ESi00b_uq=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eS8KDozNGT9J_uN69W32QEvTbg2JrtRqN0ESi00b_uq=A@mail.gmail.com>

On Fri, Oct 16, 2026 at 02:17:30PM -0700, Jim Mattson wrote:
> On Mon, Oct 12, 2026 at 4:37 PM Yosry Ahmed <yosry@kernel.org> wrote:
> >
> > Now that TLB flushes are properly handled and tracked for L1 vs L2
> > ASIDs, allocate a separate new ASID for L2 for each vCPU, similar to how
> > VMX handles VPIDs. Drop the unconditional flushes and syncs on nested
> > transitions.
> >
> > L1 and L2 can now only share an ASID in two cases:
> > - KVM runs out of ASIDs and uses the fallback ASID for both L1 and L2.
> > - SEV VMs always use the same ASID for SEV-specific requirements.
> >
> > WARN if the ASID is shared otherwise.
> >
> > Initialize last_asid to 0, such that the L2 ASID is always flushed on
> > first nested VM-Enter after it's allocated.
> >
> > On SEV VM migration, free the L2 ASID on the destination vCPU (if nested
> > was already initialized) before overwriting it with the SEV ASID.
> >
> > On a Turin CPU, this results in 8-15% performance boost in CPUID rate
> > microbenchmark [1] and netperf TCP_RR latency/throughput.
> >
> > [1] https://lore.kernel.org/kvm/20231109180646.2963718-1-khorenko@virtuozzo.com/
> >
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  arch/x86/kvm/svm/nested.c | 32 +++++++++++++++++++++++---------
> >  arch/x86/kvm/svm/sev.c    |  6 ++++--
> >  2 files changed, 27 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index 4ffc10bf9232e..6fe68f2ae282d 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -711,6 +711,10 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
> >          * context is not tagged by the ASID, so the shadow NPTs cannot be
> >          * reused across different L2 ASIDs.
> >          *
> > +        * Note, last_asid is initialized as 0, so the first nested VM-Enter
> > +        * after setting EFER.SVME will always flush the TLB to avoid using
> > +        * stale entries.
> > +        *
> >          * If L1 requested a full TLB flush for all ASIDs (including its own),
> >          * L1's own ASID is also flushed on nested VM-Exit, before running L1.
> >          *
> > @@ -727,12 +731,10 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
> >          * If L1 and L2 share the same ASID in hardware (when using the fallback
> >          * ASID for both, or for SEV guests), flush it on nested transitions.
> >          */
> > -       if (svm->asid == svm->nested.asid02)
> > +       if (svm->asid == svm->nested.asid02) {
> > +               WARN_ON_ONCE(svm->asid != fallback_asid && !is_sev_guest(vcpu));
> >                 kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
> > -
> > -       /* TODO: optimize unconditional TLB flush/MMU sync */
> > -       kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
> > -       kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
> > +       }
> 
> Per the APM, volume 2, Section 15.16.1, "TLB Flush":
> 
> > All TLB entries belonging to all ASIDs are flushed by SMI, RSM, MTRR modifications, IORR modifications, and access to other system MSRs that affect address translation.
> 
> With two separate ASIDs and the unconditional flush removed, do we
> flush both ASIDs in the above instances?

SMI and RSM, yeah I think so. kvm_smm_changed() ->
kvm_mmu_reset_context() deletes all roots, and kvm_mmu_load() will flush
the current ASID when a new root is loaded.

MTRR writes seem to do nothing beyond store the value, probably since
0a7b73559b39 ("KVM: x86: Remove VMX support for virtualizing guest MTRR
memtypes"). It is documented as an errata but I maybe KVM should still
flush the TLB? If that's a real bug, it's separate from this series tho.
We just need to make sure if we fix it, we should flush both ASIDs. We
can probably just reset the MMU context here too?

I can't find anything related to IORR in KVM.

For MSRs, I think the relevant ones are EFER and PAT:

- For EFER, a change to KVM_MMU_EFER_ROLE_BITS resets the MMU similar to
  SMI/RSM, so covers both ASIDs. Clearing EFER.SVME frees L2's ASID and
  re-allocating an ASID will flush it by clearing last_asid.

- For PAT, I am not sure if that falls under "system MSRs that affect
  address translation", but KVM isn't flushing for L1 today on PAT
  writes anyway, so I hope not?

> 
> Moreover, does this change the semantics of PV TLB flush? In
> record_steal_time(), we have:
> 
> if (st_preempted & KVM_VCPU_FLUSH_TLB)
>         kvm_vcpu_flush_tlb_guest(vcpu);
> 
> IIUC, an idle vCPU that wakes into L2 will flush only L2's ASID. In
> the past, with a shared ASID, L1's ASID was always flushed on emulated
> VM-exit anyway. Now, L1's ASID will be unaffected. Though I can't find
> any real documentation on PV TLB flush, it *seems* like the remote
> vCPU would want L1's ASID to be flushed. OTOH, this change makes nSVM
> behave just like nVMX.

I am honestly not sure. It seems like we should be flushing the context
that issued the PV flush. But I also suppose (aside from Hyper-V) all L2
PV calls should go to L1, not L0, so should we always flush L1's context
here?

It would be a pre-existing bug, but this series would be adding it to
SVM as well. Adding David here since his name appears all over the git
log for that code, so hopefully he'll tell us for sure.

> 
> 
> Nit: with this change, the following stale comment in
> svm_flush_tlb_asid() needs to be updated:
> 
> /*
> * Flush only the current ASID even if the TLB flush was invoked via
> * kvm_flush_remote_tlbs(). Although flushing remote TLBs requires all
> * ASIDs to be flushed, KVM uses a single ASID for L1 and L2, and
> * unconditionally does a TLB flush on both nested VM-Enter and nested
> * VM-Exit (via kvm_mmu_reset_context()).
> */

Will fix.

Thanks!
