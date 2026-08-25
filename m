Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817839281D
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694019; cv=none; b=aM1tX5magaL8rskE8ZKnCk0FmBF6sPL3hloDrccN5p07B1qeY97RLMS6AEGjFp40//dSeO+n1KHAUNSNUXDpxa5dswIorNJYmxuyJK0z4exAaLz4kUMO6sj9OHZ2rpr5UNa69VIQq3pHSEVnreFi9fkFYG4WvI268aZmhgKsoq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694019; c=relaxed/simple;
	bh=T1NRonwlglDavH+H1jhQaklfqJ1++hqSqddqGoIhrV4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oITM1fF7NOllJC8ETVzDzoVEVemGmGiAFA0mNY52vF2tcpZVIPlSXtniTs+5b/zvzjEdowaZUiRFjkTu/Q00bfZ36CqrEJC3WZPjNHBMrSrnj5jbZbM1e2PMyHCgR9vbNx8enS488B+UNuDegB+SeFKHa3QrqA/wz6LS4DcoAIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DaimQmSi; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DaimQmSi"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cab048cdb3eso277865a12.0
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 14:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787694018; x=1788298818; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1rOsFHFKon9LTLrUdB7wJjdHjwBOFNMutnJGJcY4iG4=;
        b=DaimQmSi9XbbXSZ3zJ60rzBvkFuM5HVvmKrdSkKJKEdhwcDqZ0aodKoPh7vnP24riC
         0N3gasqpdoYTiu2ywvLLvh/FwBo1ZR5o74eJfjazgX5oonHalsjgAxsSyli2yFO8UUJx
         lPkIl8lCl+tOQ78TggD5uk9Q6sJNTE0vYd+y6CHjC/q6zcHJ6KGOIe5vxhgP/gtbv2gr
         te7oDdJ6/fBY/+RkThXZMNYVxuAWtn3N/SMt7PD4WzxOkse3wkufjr8KTmBfs+vz7G8k
         tcH5NJVNYBdmOWExbQnHgYIibdgPpe1jLB9s7xBO7eonPWyugvw9vCxwycb7GDjRhvDA
         +2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787694018; x=1788298818;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1rOsFHFKon9LTLrUdB7wJjdHjwBOFNMutnJGJcY4iG4=;
        b=Gy9kKtyWGGKuUFdP5RhXjFfTEQyHRdN8gBKbFxN/uByfXM9Bhh/vm6lt6Co0riNHln
         +tJGj1f9DI5gO4VHMfIstl/LBHiji8+jRlJbzF5PDDYpKSYJg5V4Nl2mmMQ2Mp3Yr8pZ
         oxlr8w0ZcEorYTFhK6OSqvTGjTP2Dy7+HNuGFjyoIiVMsgI3YV8ehg0SCMen5gZK0PhI
         0S09x2fLS7PQQZK9YXBy2V3MoL4KHo1MEqqmOLM8CvRMrYAThnr1YjvCamEkQFIsR8oi
         DtBBiPIkE3GFAeMXj9iksNsFH+FkQbtX/fssH0NOzwTWCavQBvM6fB6OkLR1tATbJAv5
         40ug==
X-Forwarded-Encrypted: i=1; AHgh+Rqrv3k2hk3KRcwgMKl4R5zq93FFbLdbeobtXXnSRKjZsP5iY2RIBBHAmg1Z/H0nTG7HJzs=@vger.kernel.org
X-Gm-Message-State: AFuF++kvSicIp5POqa+xcZZWCc07mPVppvV2KWER32wLVv4zHcnsCkLC
	SEiRkeAY65XYg2bDXnDsWwNiGIPX2Igl3Ds5YNVWD4F09Vzrr6rQuGO4EnM1CP0KhBcws5wY/QJ
	C1wtLiA==
X-Received: from pgbeu26.prod.google.com ([2002:a05:6a02:479a:b0:cbe:9dc7:9eeb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:116:b0:3cd:61d5:f342
 with SMTP id adf61e73a8af0-3cf83b22bc2mr2850401637.9.1787694017502; Tue, 25
 Aug 2026 14:40:17 -0700 (PDT)
Date: Tue, 25 Aug 2026 14:40:16 -0700
In-Reply-To: <ao4Daj0hnwjP9Lpf@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260825140159.70997-1-mamarang@amazon.com> <CADrL8HUcr5Fei1PX179bkFmMJ_S+eD267SVgc85cm-rpcahwmA@mail.gmail.com>
 <GV2PR06MB10711C9FE46F33B0613DCB66FB9AF2@GV2PR06MB10711.eurprd06.prod.outlook.com>
 <CADrL8HW8br9KuYoELj4id84ib_tGZrBh3zZGbjerHuM8uiN7hA@mail.gmail.com>
 <ao4CufEI_pRCjbMF@google.com> <ao4Daj0hnwjP9Lpf@google.com>
Message-ID: <ao4LwI2F7jDezZh9@google.com>
Subject: Re: [RFC] KVM: x86/mmu: Prefetch forward run of pages on TDP page faults
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Marco Marangoni <mamarang@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kernel-patches@amazon.com" <kernel-patches@amazon.com>, Riccardo Mancini <mancio@amazon.co.uk>, 
	Michael Zoumboulakis <zoumboul@amazon.com>, Marco Marangoni <marco.marangoni@proton.me>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 25, 2026, Sean Christopherson wrote:
> On Tue, Aug 25, 2026, Sean Christopherson wrote:
> > Somewhat off the cuff and *very* lightly tested, but this seems to do what I want.
> > If it provides comparable performance, I'll write a changelog (or two?  e.g. to
> > have direct MMUs switch in a separate patch), and let Sashiko and other bots rip
> > apart my idea.
> > 
> > Note!  This has a hard dependency on in-flight prefaulting fixes[*].  Without
> > those, prefaulting will hang the vCPU if the root is invalidated.
> > [*] https://lore.kernel.org/all/20260806214050.78058-1-seanjc@google.com
> > 
> > Note #2!  The below deliberately ignores A/D-disabled MMUs.  I can't think of
> > any reason why it matters whether or not KVM can precisely detect accessed SPTEs,
> > all of the aging stuff is already extremely fuzzy.
> 
> And of course I posted an untested version (I ripped out the direct MMU prefetching
> as an afterthough, and dropped a printk).  This version should actually compile.

This breaks dirty_log_test and dirty_log_page_splitting_test, because KVM creates
writable SPTEs in direct MMUs whenever possible.  Because nothing can be simple,
the below in turn breaks pre_fault_memory_test, but I suspect that's a test flaw.

Note, this would also short-circuit async #PF completion when dirty logging is
enabled.  I think that's a good thing?  If not, we could teach kvm_mmu_do_page_fault()
to differentiate between async #PF and unprompted prefetching.

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 88b6aa1f840f..540d6583995c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -874,19 +874,11 @@ static void unaccount_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 	untrack_possible_nx_huge_page(kvm, sp, KVM_SHADOW_MMU);
 }
 
-static struct kvm_memory_slot *gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu,
-							   gfn_t gfn,
-							   bool no_dirty_log)
+static bool kvm_is_memslot_usable_for_prefetch(struct kvm_memory_slot *slot,
+					       unsigned int access)
 {
-	struct kvm_memory_slot *slot;
-
-	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
-	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
-		return NULL;
-	if (no_dirty_log && kvm_slot_dirty_track_enabled(slot))
-		return NULL;
-
-	return slot;
+	return slot && !(slot->flags & KVM_MEMSLOT_INVALID) &&
+	       (!(access & ACC_WRITE_MASK) || !kvm_slot_dirty_track_enabled(slot));
 }
 
 /*
@@ -3181,8 +3173,8 @@ static bool kvm_mmu_prefetch_sptes(struct kvm_vcpu *vcpu, gfn_t gfn, u64 *sptep,
 	if (WARN_ON_ONCE(nr_pages > PTE_PREFETCH_NUM))
 		return false;
 
-	slot = gfn_to_memslot_dirty_bitmap(vcpu, gfn, access & ACC_WRITE_MASK);
-	if (!slot)
+	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
+	if (!kvm_is_memslot_usable_for_prefetch(slot, access))
 		return false;
 
 	nr_pages = kvm_prefetch_pages(slot, gfn, pages, nr_pages);
@@ -4946,6 +4938,8 @@ static int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		 */
 		fault.gfn = gpa_to_gfn(fault.addr) & ~kvm_gfn_direct_bits(vcpu->kvm);
 		fault.slot = kvm_vcpu_gfn_to_memslot(vcpu, fault.gfn);
+		if (prefetch && !kvm_is_memslot_usable_for_prefetch(fault.slot, ACC_ALL))
+			return RET_PF_WRITE_PROTECTED;
 	}
 
 	/*
