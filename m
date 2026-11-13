Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590264;
	b=JRDFsbspbLJCf9sLQkCASfSd8pVGu2FdRSO0IuTLJM2J7eNdsMAKf62Ti7+BXa868U3C
	 KnZANOvaehUbSVarDBsglPsDzJn9iyo6QcJHJm0EyTemcVrZyu8TZP8i4101YUIATBKSz
	 LpEsd8pVEMEiQilRihp9UWLIIRm4+lfjp8BjRrp1ej8YSxRK4kM8YoOGoFc6x5BMEdRr1
	 eSPpmyT5vINktTOB0K1dN4bCZycJTiZcuRluIi2KvjorzLfDH6zEhQW2TfPjXSuQmQT2F
	 YoLOITfd1ACZMvaWhY9pTLEIR9FjaxkFuLfR/ZuiOWCujTg6x+f0id//vqzJo3waMSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590264;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=nvhnqNnm7EM5SLclAEUC92CRUKwUHl9E1jDz3+lLVx8=;
	b=1uW8wmCRGu8srnQ23AGhHAKYpez5g4Ff39pD2MOlYwOYpg/0UMjTKJraQxlpD11fHB5i
	 Wg+QLOPktq3OGQZpaHqKwkZiyH61AglCBvqca4tLSZhlzkqDh1sSkWaMC5Tj5j2sX9T8Q
	 oBDY2iYLp8oN/Z/hA6gkoCm5ZcE5azFzAsNeMe27g8JGjnMnreERlifRKv7WwS4GEtcIC
	 VuaXDdtuWe8jfO7GKXY/UC5W+8Pfu068XU7Pl4BCMaYJgBm4cKRgAgl7fFPzj8G6Btk8T
	 ThiUKVRrSH4yXfpb8+BjnFEVwySyFv5z4y+e9jm6g8gejjub1fgpXAy9IGTPAD5M1hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LJ+P2CYB;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2A160A3823
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 17:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A2A160A3823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LJ+P2CYB
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b1755b2f26so1053798a91.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794590263; x=1795195063; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nvhnqNnm7EM5SLclAEUC92CRUKwUHl9E1jDz3+lLVx8=;
        b=LJ+P2CYBJZznevpZP2XrlphxHlTbU9Ey2HVyzFs9v62AdwC93AjDJ1sExUN9bJBqE+
         3vLU1ECV03+lhH0BVBpc29lik9ElMAc63xj+gAD6cupoiUj0LY99HtF7hJR4/LkGLecf
         vZHo+z8ClSZgQXs6tNti7OqWCAYkMJsVdX1wyuTf9OQIgYr6RnuZwK/IPNWmYiPVspQ0
         QoR41t0wYeHbZ4oYhGnNzQ9Hc40cRoDEM2jrX4I0tQuhqvIGimz2o5MhOyIwSZLKRawa
         m/Zfo1jy12CuYObuzTlGzoCbsb9dHOT+j2zIgIjd5JlP4867HZFTy8G3q+XoqPeeI8vI
         oQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590263; x=1795195063;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nvhnqNnm7EM5SLclAEUC92CRUKwUHl9E1jDz3+lLVx8=;
        b=0Xs9SBWI6r/KhK21ajwcp/pSS2rNeZspOVXK83UIA6zPyQoGqplDzACBD+PXmdRJIF
         taLrQViGR9RYco/47Tv1M/J3XoYXRMVAEIPmI7Pk1fKkujKZJaZKm3QvxQ8jVIjdVg7E
         4YUfGb+7hSFS6T8Qcz4ixdjww3OmtrkDhUZ3KmgrLAHgxYgYYjH0KRp2dmM5rU0EBoOM
         nVYJAa4TMQCA49iHIF2OX4tIa//OtJRTnndvzGLFD9zCpCfxmGD5ThftOtYPMXeOWyKH
         hWSypjPlTFRLiCGudy8O3VMCXEXH0T7/luLEI31mHzkvMnfnSQW+I0DcaYkVPJ3jBrrX
         qAlQ==
X-Gm-Message-State: APuU4Z/w4XshME60FNDzI2JMcA7usrZCnJnk/ouPzVkFdEl4wV6DxoDF
	pGm7FAiu6JHH5TPcCUGC8PVrKBu4L4t0R905pDtvQz/HTZjV1/J1C7OIIZk8a10CgzTt9ZmQPMk
	QAR/6PQ==
X-Received: from pjbbs18.prod.google.com ([2002:a17:90a:f212:b0:3ae:49df:251a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:56cb:b0:3b0:a9de:9880
 with SMTP id 98e67ed59e1d1-3b1b0a3c5e9mr2904745a91.33.1794590262694; Fri, 13
 Nov 2026 09:17:42 -0800 (PST)
Date: Fri, 13 Nov 2026 09:17:41 -0800
In-Reply-To: <sashiko-outbox-213282@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113164000.467175-1-seanjc@google.com> <sashiko-outbox-213282@kernel.org>
Message-ID: <avdGNbOO4562tk10@google.com>
Subject: Re: [PATCH v3] KVM: Skip gfn-based MMU notifier invalidations for
 guest_memfd-only memslots
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 13, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index cf4cb586f1407..599dea22afb81 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -601,6 +601,10 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
> >  			unsigned long hva_start, hva_end;
> >  
> >  			slot = container_of(node, struct kvm_memory_slot, hva_node[slots->node_idx]);
> > +
> > +			if (kvm_slot_has_gmem(slot) && kvm_memslot_is_gmem_only(slot))
> > +				continue;
> 
> [Severity: Critical]
> Can skipping guest_memfd-only memslots here leave writable SPTEs installed by
> x86's kvm_mmu_prefetch_sptes() unzapped when the VMA at slot->userspace_addr
> is unmapped?
> 
> While __kvm_mmu_faultin_pfn() resolves the primary fault from guest_memfd for
> gmem-only memslots, the post-fault PTE prefetch paths (such as FNAME(fetch)()
> -> FNAME(pte_prefetch)() for nested EPT/NPT or shadow paging) call
> kvm_mmu_prefetch_sptes() for neighboring GFNs without checking
> kvm_memslot_is_gmem_only():
> 
> arch/x86/kvm/mmu/mmu.c:kvm_mmu_prefetch_sptes() {
> 	slot = gfn_to_memslot_dirty_bitmap(vcpu, gfn, access & ACC_WRITE_MASK);
> 	if (!slot)
> 		return false;
> 
> 	nr_pages = kvm_prefetch_pages(slot, gfn, pages, nr_pages);
> 	if (nr_pages <= 0)
> 		return false;
> 
> 	for (i = 0; i < nr_pages; i++, gfn++, sptep++) {
> 		mmu_set_spte(vcpu, slot, sptep, access, gfn,
> 			     page_to_pfn(pages[i]), NULL);
> 		...
> 		kvm_release_page_dirty(pages[i]);
> 	}
> }
> 
> kvm_prefetch_pages() resolves PFNs from slot->userspace_addr via
> get_user_pages_fast_only(), and kvm_mmu_prefetch_sptes() installs writable
> SPTEs and drops the page references.  With kvm_handle_hva_range() ignoring
> gmem-only memslots, unmapping or reclaiming the VMA at slot->userspace_addr
> will not zap those prefetched SPTEs, giving the guest a host page
> use-after-free.

Well fudge.  That's a bug that needs to be fixed irrespective of this patch,
though it obviously needs to land first.

The TDP MMU doesn't support automatic prefetching, yet[*], and I'm planning on
using the "normal" fault flow for that support, so I think we can just disable
prefetching for gmem-only slots without negatively impacting any real-world
workload, and punt on proper support until someone cares, e.g.

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f4b12d6aef55..a54196587235 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3245,6 +3245,9 @@ static bool kvm_mmu_prefetch_sptes(struct kvm_vcpu *vcpu, gfn_t gfn, u64 *sptep,
 	if (!slot)
 		return false;
 
+	if (kvm_memslot_is_gmem_only(slot))
+		return false;
+
 	nr_pages = kvm_prefetch_pages(slot, gfn, pages, nr_pages);
 	if (nr_pages <= 0)
 		return false;

[*] https://lore.kernel.org/all/20261028202607.1844883-4-seanjc@google.com
