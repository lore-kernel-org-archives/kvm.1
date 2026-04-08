Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E54A30171C
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775657910; cv=none; b=UYs+QXRVxBLX+m2/x8TxlRpbbCQEl4vTL+0apWxEjd+ElpZIU8Nd6mM74jz1LjD5n2zMMzqZK+/PUO4+3QvknCCS4QTPwJgRYXwXowkT0cnlfoZzEpgM1SBKduJJYLM5adsGVA2TsHiabSqlSFhjJ71Upr7Xc9FGIMkpiLGXiZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775657910; c=relaxed/simple;
	bh=MWhMukfJz5Px4rYHy5pvHORnGRSVNxeb2facl4Is87c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sLz6j85Tsc+YjWhERZ53D8uXW6usZRnBmvyGQ1CLB+OnixooFcs94BChdbRksmEQnUOtDSv5J56H+yM93V4GHnvQ5PobeJBUT5LGF5E/KwlW1+C5NKpHtlqqm8h08CvIDeGGaRgJzPdNZugcu5PA4nTFFj/j6Z2DuM3Wb2AjeXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MPGQAKOc; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MPGQAKOc"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b630753cc38so11925474a12.1
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 07:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775657908; x=1776262708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z+5kCXW5E1B9PDwN4F1scGUFr+1JeNSFb6V10/HvRu4=;
        b=MPGQAKOcmHta2ncvW89fAurGzZ2orXomdYRwsoiE3HUf70BakHI4If8jYWhKe4Z8os
         6toP1k+sAhoguXukBessCT3ZWv6U2BtWsY186DEP/m8GIfuAtaqgzsiDsukCAud2HdQ9
         Ou9adzV+y2jYxTFqBHHmFyjxo2zG9fNpz7+zBJz2GLsWdfGu7w4YAsr3R12V6EJutxor
         5+v2fG2sIzaoRzYc8Wm8Uk6lhQp3pxP+SnjIXt6w9Q3G62pxVWAWBel+DLqrZXxmQncH
         vvYqkAXOKZr5ZuG117xzPGr394+zLD4zSppNE2WvTFvHnnFODBm2IqpTOvBOvBDPUgEs
         rRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775657908; x=1776262708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+5kCXW5E1B9PDwN4F1scGUFr+1JeNSFb6V10/HvRu4=;
        b=hvw2TAIbB+RR+oEiadoBhskb040By8He4XoVuFtwSgQC7xf//8WKkXkF3RjAPDuLqI
         5He9ZQQBXNLVlIltYckJ4nGwp/Ht0O8OgFphoHqUPUcBI5noTFGbDSd7KTDe40p+hCYk
         JjrEacmBg05oNgjqMb5mPiWb0FX0I5FxxNT6i9J5SdqRgcB0ZaSU2G8OoM4bCogM3tg0
         ZqKouPRgWGw0E0H6rDcy8uvlZSfmQ4fRDXl7eJx8DV1hGj9HbBqKlrVpo+y5v75IdNK4
         b2iUzni1aoNhzCw43M1YgiVrCQ5Zz0M0wFinbqwhxo+Fwov+pGd3DobOTEZhPOT+fGdQ
         NzHA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ4d4u18NbDFWT4nbqigO/8mNxXvY1dXJBDhq6/zAbcuWLsZ1I/77Ih0czeofmRhV2C+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9oHuOA2491mBz4YJHI2Z6Y6IFrcIRX66awDzznUabw8X7kl5R
	l5a0H67JCHiUcUoQk+Vz+B7u8rG63yy1SVNoB5LELnwscXLCTxQ3Bcp6CQChXWunpjeMBeU252D
	hbO32eQ==
X-Received: from pgbdo11.prod.google.com ([2002:a05:6a02:e8b:b0:c76:b722:cc2c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a28:b0:398:a060:a967
 with SMTP id adf61e73a8af0-39f2ed92c72mr21884732637.11.1775657908449; Wed, 08
 Apr 2026 07:18:28 -0700 (PDT)
Date: Wed, 8 Apr 2026 07:18:27 -0700
In-Reply-To: <20260408102914.106838-1-ohyunwoods663@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408102914.106838-1-ohyunwoods663@gmail.com>
Message-ID: <adZjswAhbcQmekxZ@google.com>
Subject: Re: [BUG] KVM: NULL pointer dereference in kvm_tdp_mmu_map under
 memory pressure
From: Sean Christopherson <seanjc@google.com>
To: punixcorn <ohyunwoods663@gmail.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 08, 2026, punixcorn wrote:
> Under host memory pressure, a NULL pointer dereference occurs in
> kvm_tdp_mmu_map() at offset 0x24. The exact root cause is unclear --
> it may be an unhandled NULL return from tdp_mmu_alloc_sp(), or a
> violated invariant elsewhere in the map path.

It's pretty much guaranteed to be the latter.

tdp_mmu_alloc_sp() can't fail, as KVM ensures vcpu->arch.mmu_page_header_cache
holds enough pre-allocated entries to service the page fault.  Even if that
invariant fails and KVM exhausts the cache, it should still be impossible for
kvm_mmu_memory_cache_alloc() to return NULL because it will either use a fallback
allocation (after WARNing) and succeed, or BUG_ON() and prevent hitting the NULL
pointer deref.

  void *kvm_mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
  {
	void *p;

	if (WARN_ON(!mc->nobjs))
		p = mmu_memory_cache_alloc_obj(mc, GFP_ATOMIC | __GFP_ACCOUNT);
	else
		p = mc->objects[--mc->nobjs];
	BUG_ON(!p);
	return p;
  }

And even if _that_ didn't suffice, tdp_mmu_alloc_sp() itself deferences the
return sp, so the NULL pointer deref would happen earlier.

  static struct kvm_mmu_page *tdp_mmu_alloc_sp(struct kvm_vcpu *vcpu)
  {
	struct kvm_mmu_page *sp;

	sp = kvm_mmu_memory_cache_alloc(&vcpu->arch.mmu_page_header_cache);
	sp->spt = kvm_mmu_memory_cache_alloc(&vcpu->arch.mmu_shadow_page_cache);

	return sp;
  }

> 
> Crash log:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000024
>   #PF: supervisor read access in kernel mode
>   Oops: 0000 [#1] SMP NOPTI
>   CPU: 2 PID: 1110212 Comm: MainLoopThread Tainted: G U OE 6.19.10-arch1-1
>   Hardware name: Default Default/NLXB, BIOS BQ141 06/27/2024
>   RIP: 0010:kvm_tdp_mmu_map+0x471/0x880 [kvm]
>   Code: 00 00 00 80 48 2b 35 76 72 5c c8 48 c7 44 24 20 00 00 00 00 48 01 f1 48 c1 e9 0c 48 c1 e1 06 48 03 0d 4b 72 5c c8 48 8b 71 28 <0f> b6 4e 24 83 e1 0f 39 ca 0f 85 a7 02 00 00 f6 c4 08 74 26 80 7b
>   RSP: 0018:ffffce128333f790 EFLAGS: 00010286

As noted in your response, I'm 99% certain this is the first derefence of the
shadow page in tdp_mmu_map_handle_target_level():

  static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 					  struct kvm_page_fault *fault,
					  struct tdp_iter *iter)
  {
	struct kvm_mmu_page *sp = sptep_to_sp(rcu_dereference(iter->sptep));
	u64 new_spte;
	int ret = RET_PF_FIXED;
	bool wrprot = false;

	if (WARN_ON_ONCE(sp->role.level != fault->goal_level))  <============= "sp" is NULL
		return RET_PF_RETRY;


The code stream lines up with that on my builds, and "role" is at offset 0x24.

I can think of three possible sources of failure:

  1. KVM installed a non-leaf SPTE without doing set_page_private().
  2. iter->sptep is corrupted/garbage.
  3. iter->sptep points at a freed shadow page, i.e. page->private was nullified
     due to the page being freed and/or re-allocated.

#1 seems unlikely as I wouldn't expect such a bug to manifest intermittently; the
code is pretty fixed/straightforward.

#2 isn't very likely either, given that it's dereferencing the shadow page that
fails.  I.e. KVM did _not_ fail grabbing the shadow page from iter->sptep, then
iter->sptep isn't complete garbage.  But it's still a possibility, e.g. if sptep
is garbage but happens to still point at a valid struct page.

#3 is the most likely option; as it would "just" require a violation of RCU
protection somewhere.

Can you run with this as a debug patch?  With luck, the output will provide some
hint as to what's going wrong.

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 7b1102d26f9c..0332faf8ef9a 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1174,6 +1174,17 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
        int ret = RET_PF_FIXED;
        bool wrprot = false;
 
+       if (WARN_ON_ONCE(!sp)) {
+               pr_warn("NULL sp.  sptep = %lx, spte = %llx, pt[0] = %lx, pt[1] = %lx, pt[2] = %lx, pt[3] = %lx, pt[4] = %lx\n",
+                       (unsigned long)iter->sptep, iter->old_spte,
+                       (unsigned long)iter->pt_path[0],
+                       (unsigned long)iter->pt_path[1],
+                       (unsigned long)iter->pt_path[2],
+                       (unsigned long)iter->pt_path[3],
+                       (unsigned long)iter->pt_path[4]);
+               return RET_PF_RETRY;
+       }
+
        if (WARN_ON_ONCE(sp->role.level != fault->goal_level))
                return RET_PF_RETRY;
 


> Reproduction:
> 
> The issue was observed under heavy host memory pressure while running
> a KVM guest (Android emulator via QEMU).

Can you elaborate on the environment?  Specifically, what is your host setup?
E.g. CPU and platform info, and your .config.

> This has not been fully verified. Sending for maintainer review.
> 
> Environment:
>   Linux 6.19.10-arch1-1 x86_64
>   GNU C 15.2.1
>   Binutils 2.46
> 
> Signed-off-by: punixcorn <ohyunwoods663@gmail.com>
