Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B63B5F5D
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786468331; cv=none; b=lLg4LUiQQO4daromQMxcYffxOZHwWqlzOtMPJtdFP+bvhjes+E5UDTOcnWXxBNHffrd6b8AXevUD7zNwQqCR2DRJHtcXD/PYpDLdA0sygyny4ATCBHfn9soY8SvBKCFNbY1b5+XUzQukF19ZaHIS7ldPio4GYDBVFh4KPm0U9OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786468331; c=relaxed/simple;
	bh=rRw18ZT/4KdoRFnzYNEvxKXNcU6Gsa6GEcOC2wP6zCA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jez8LWTvS47YiCSmo5cJ1OOtIlr+TCNIRziORH3bj5bjzmVtEQ7Z7twhQ7Px+fBdV0CjVK82JERgu6RR31YBW+H6/43fVCmcx+6z76AIllcy/lOD81dKsXTkejiMO1NvCDXqpf2nOKPURW1GcHLSFezyICgvtkSkMiZoh1YQNDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G18KGCS7; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G18KGCS7"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cab3e9cd922so9511a12.0
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 10:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786468329; x=1787073129; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hDmw0Bd7Mgi6QHj5D0rabOEXrT9zZ2xMuzlP2EIUA30=;
        b=G18KGCS7J32T4BHEdRlyG29h9HkMK556Iu4OxYJd/lp1uIidcFj4RpnnduvvaiXxIR
         VMFSxyD+lW0CGsj/+yG3lsepXr0BDgYdNv8Gyjd2llcTIr7Vy6huDFopvV/RKpFlW436
         u8OF1doMvrfSIuQOD/rLvjD1vRzP6zHr0UnSeTLZ9qfRCLAf/1w7OuWC3CTjQ6h3E1is
         9deyptkpeu6A5DDCMkHSXsyVvs5Ji/ezNM2IJR/kzRxniiCNtvEgjIJceM+w5HOAgtpe
         lBSbEQ+QJbd7LcwFgDVLlGKqUOAxU7NAekFGc/9psR65J7gOWxt3RmilUWcc70iNsVNO
         EJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786468329; x=1787073129;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hDmw0Bd7Mgi6QHj5D0rabOEXrT9zZ2xMuzlP2EIUA30=;
        b=EwXdrqaneWDsfKI2jygUYlDqrDQ3tIjaoS7vhW5JtKsV27px/ehBzVVGow0ZnS2eTz
         Z0oz0KL5lwfNE9v35dC4vncAUGD4ZsDkoIyv/TrGf0KQ5PjjMDsuznoY/VwkfJNssrT7
         cK/3oqgs73xjUkdQlr4qoKhNgnWc4mZxbdTz2txAtfghefjU9l8KbK/tzKT8tB/3YUJA
         oBNMJzDFB3D97gjB98qpTaLzp/DpYDuSkVEbvk0DaKEQ1OJh4nNpwUT2hwaP9Pzj2zbt
         zddm3Tm7WWbmElNli4RDE2t3jmWgwzOuNHwnsAWkUFWiAXjkOSqcI8Pad09RLPjUq2yd
         pzmQ==
X-Forwarded-Encrypted: i=1; AHgh+RorXnQNGVh4UTW9fBNtLEXP7haRyEVVRNiDsujYaYDmOA5MIawkVmbGD/y5DpMhGExyPZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwJVWnvZxYA1i3mU9qzKjIzKprU1KEdWZp7VI9v+VlYvguuXa/
	jnmpoBsj1KyEX7N43JGHjNjfwmwHjui1WdVvrZGlpnKp5oJz6eGQGXdN3hvPWt/udeoUoWa8u1A
	6BT/E5g==
X-Received: from pgne19.prod.google.com ([2002:a63:7453:0:b0:cbe:dff5:6872])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6003:b0:3b4:71c1:ab29
 with SMTP id adf61e73a8af0-3cc2ba22d6amr7324765637.16.1786468329105; Tue, 11
 Aug 2026 10:12:09 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:12:08 -0700
In-Reply-To: <anpr/H5Hxw1EMkTj@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806214050.78058-1-seanjc@google.com> <20260806214050.78058-5-seanjc@google.com>
 <anpr/H5Hxw1EMkTj@yzhao56-desk.sh.intel.com>
Message-ID: <antX6NCs4-C_ChXD@google.com>
Subject: Re: [PATCH 4/4] KVM: x86/mmu: Add sanity check to detect stale page
 faults in "map private PFN"
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 11, 2026, Yan Zhao wrote:
> On Thu, Aug 06, 2026 at 02:40:50PM -0700, Sean Christopherson wrote:
> > Harden the "map private PFN" flow against potentially-fatal bugs or future
> > KVM changes by checking for a stale "fault" prior to actually mapping the
> > PFN into the guest.  While it should be impossible for the "page fault" to
> > become stale, the sanity check is cheap, whereas a broken assumption would
> > have a high probability of leading to a guest-expoitable use-after-free.
> > 
> > Snapshot the invalidation sequence after acquiring mmu_lock to avoid false
> > positives, even though doing so completely voids anys and all protection
> > against unexpected invalidations.  Pretty much the entire point of
> > kvm_tdp_mmu_map_private_pfn() is that it allows mapping a PFN that was
> > gifted by the caller, i.e. the caller would have to mess up its one and
> > only responsibility.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 379f570ef04f..76e3cd717324 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -5210,6 +5210,16 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> >  		 */
> >  		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));
> >  
> > +		/*
> > +		 * Snapshot the invalidation sequence counter after acquiring
> > +		 * mmu_lock, as guest_memfd guarantees the validity of the pfn,
> > +		 * i.e. any concurrent invalidations are guaranteed to be
> > +		 * irrelevant.
> > +		 */
> > +		fault.mmu_seq = vcpu->kvm->mmu_invalidate_seq;
> Could you explain more about the conditions under which a fault is stale while
> guest_memfd guarantees the validity of the pfn?
> 
> Given that kvm_tdp_mmu_map_private_pfn() already asserts holding slots_lock and
> invalidate_lock, I can't think of one. 

A non-guest_memfd mmu_notifier invalidation bumps mmu_invalidate_seq.  And because
the range-based invalidation checks are deliberately coarse, in-flight invalidations
could also trigger a false positive if GFNs N and N+2 are being invalidate, while
kvm_tdp_mmu_map_private_pfn() is trying to map N+1.

> If we add the sanity check because it's cheap, why don't we save
> fault.mmu_seq before getting the pfn to guard against stale pfn as well?

Because as the changelog says, the whole point of this API is to provide a stable
PFN.  I want to add an is_page_fault_stale() check as defense-in-depth against bugs,
and against future changes, e.g. if we extend is_page_fault_stale() to cover more
reason why a page fault can become stale.  The downside is that is_page_fault_stale()
is susceptible to false positives; the funky code here is to minimize the chances of
a false positives, while maintaining a reasonable level of safety.
