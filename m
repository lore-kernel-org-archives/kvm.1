Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F3E3CC300
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691886; cv=none; b=I+hQWxeA8Zw6vRpth3vgRDCygHxgKbmhxqBEBkKwAbrL/bju2vFcesgFNQ8NE9PQWDhGLNqaENV415TBlzJyifrb4yuExQ0oeWneoh6Mc94N4L4d/Eg0LVa3ZFnRIohN6eBViR0XRbDHD3m0CqZ7xy9xo0yC1zkc1oGDc3ZhbF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691886; c=relaxed/simple;
	bh=y3JaxVV/ItmvBl2jv06UEW18IWm8frWqmaUiPg1L5gs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=duE+uHLs3gankyP7SQDQwn44GFedrEcic86BOE9qzWJGQR4WHiqsZqz2GmhX3JcDGiVUrOBO/iQfeQyo5Ppy3nZQvLFlq3NpZHqZtJHF3Ted8ZmNRzcpqAKk+2TN+aDZcijf7aEoN2kdiXrQXSe7bchEvw3RcFfu1ymgP6rNxdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FJvIl9YH; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJvIl9YH"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3954def0191so534908a91.3
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787691884; x=1788296684; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kdCwpbXCm4diJMO0qCIhObrfaL6xSD7Kcdv0HWKzDdk=;
        b=FJvIl9YHrrDqcf6WazXNV9GBcqnltCDX++DO6e3rTb6Nl1jmof8rTVaYgtwn8A/9/W
         8Xbny2Eu7EVhVI67CMUWR0WTIQklvvoi6UyfuTYTV2WTj/kUAQsrkgwgSyRLlUzRaUZL
         MQPzFC4gjnbvqYRa2sVbdhKXlVLs3J15QDD0+aCS4XV7Acdo1EamFDCQLMZNmKzNtbTS
         lfXo7BU7jJOgN+x12hhC9dBr+qMK7t0XKb1PCihdujl1ycTykNG/hq+AtsfW5FBG8qkq
         i7DT7WbVANUgRqOJDtadHEtrTaN6WaIcNVIakXsN/iSVk2iuvhEklY3n6gvf4KDVijRT
         4Rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787691884; x=1788296684;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kdCwpbXCm4diJMO0qCIhObrfaL6xSD7Kcdv0HWKzDdk=;
        b=qGCr9l72xXAf3QzEpv3fyn29Lx19ZsbJi8ikP+BebdT3IOhjPkwXiKlrMPOhAlEQ/+
         R70GCnwyg7tIFPl8g492PP7eNfdlPbhJ+Q6b6iVEMTND0wbQB6SMx0XLFJrElv19/jb0
         dTvkGQiVmagG8PRxGuh0ot10GKS4UEApNwR2qHF3+zeDAYBgV9m1AuP3yZIA76tHphL7
         Lscg+anKQbFoDdnFW3HnWSexnWN9fxrMEUKJ4JzqrDYA6lHXgHm3hzxRvKhzNQ+lX9fg
         bQX8eKGj6P2g58BUaSItCcU9hk+ot1FeMEC0+KRlKFopR5LVWjOXLjLeCtbXB7IC/q0i
         ronA==
X-Forwarded-Encrypted: i=1; AHgh+RoKbsIRjqx8SV9DNVHX7qOZMKFkLtKq84PNfrs0CrMKThiKPpJCdiqmRM13S0iIhq8TgyM=@vger.kernel.org
X-Gm-Message-State: AFuF++mSg00h96nH3EVoBo4E9I1aKfEDLqjSMzybTHG3depF984cumkd
	7yxpZpegEKJW9GQL2QD1oSnwL9uecV11s2JFaAaL5dX6XLl+28PJ7o+evYHeUwxiPqqEs3Yldr0
	wPdTAvw==
X-Received: from pgjt20.prod.google.com ([2002:a63:f354:0:b0:cc1:2989:9d19])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cfa8:b0:3cc:8f53:26c0
 with SMTP id adf61e73a8af0-3cf86dd6053mr2583459637.17.1787691883538; Tue, 25
 Aug 2026 14:04:43 -0700 (PDT)
Date: Tue, 25 Aug 2026 14:04:42 -0700
In-Reply-To: <ao4CufEI_pRCjbMF@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260825140159.70997-1-mamarang@amazon.com> <CADrL8HUcr5Fei1PX179bkFmMJ_S+eD267SVgc85cm-rpcahwmA@mail.gmail.com>
 <GV2PR06MB10711C9FE46F33B0613DCB66FB9AF2@GV2PR06MB10711.eurprd06.prod.outlook.com>
 <CADrL8HW8br9KuYoELj4id84ib_tGZrBh3zZGbjerHuM8uiN7hA@mail.gmail.com> <ao4CufEI_pRCjbMF@google.com>
Message-ID: <ao4Daj0hnwjP9Lpf@google.com>
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
> Somewhat off the cuff and *very* lightly tested, but this seems to do what I want.
> If it provides comparable performance, I'll write a changelog (or two?  e.g. to
> have direct MMUs switch in a separate patch), and let Sashiko and other bots rip
> apart my idea.
> 
> Note!  This has a hard dependency on in-flight prefaulting fixes[*].  Without
> those, prefaulting will hang the vCPU if the root is invalidated.
> [*] https://lore.kernel.org/all/20260806214050.78058-1-seanjc@google.com
> 
> Note #2!  The below deliberately ignores A/D-disabled MMUs.  I can't think of
> any reason why it matters whether or not KVM can precisely detect accessed SPTEs,
> all of the aging stuff is already extremely fuzzy.

And of course I posted an untested version (I ripped out the direct MMU prefetching
as an afterthough, and dropped a printk).  This version should actually compile.

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 79c450d677b4..88b6aa1f840f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -118,6 +118,9 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(tdp_mmu_enabled);
 bool __read_mostly eager_page_split = true;
 module_param(eager_page_split, bool, 0644);
 
+unsigned int __read_mostly auto_prefault_nr_pages = KVM_PAGES_PER_HPAGE(PG_LEVEL_2M);
+module_param(auto_prefault_nr_pages, uint, 0644);
+
 static int max_huge_page_level __read_mostly;
 static int tdp_root_level __read_mostly;
 static int max_tdp_level __read_mostly;
@@ -3205,69 +3208,6 @@ static bool kvm_mmu_prefetch_sptes(struct kvm_vcpu *vcpu, gfn_t gfn, u64 *sptep,
 	return true;
 }
 
-static bool direct_pte_prefetch_many(struct kvm_vcpu *vcpu,
-				     struct kvm_mmu_page *sp,
-				     u64 *start, u64 *end)
-{
-	gfn_t gfn = kvm_mmu_page_get_gfn(sp, spte_index(start));
-	unsigned int access = sp->role.access;
-
-	return kvm_mmu_prefetch_sptes(vcpu, gfn, start, end - start, access);
-}
-
-static void __direct_pte_prefetch(struct kvm_vcpu *vcpu,
-				  struct kvm_mmu_page *sp, u64 *sptep)
-{
-	u64 *spte, *start = NULL;
-	int i;
-
-	WARN_ON_ONCE(!sp->role.direct);
-
-	i = spte_index(sptep) & ~(PTE_PREFETCH_NUM - 1);
-	spte = sp->spt + i;
-
-	for (i = 0; i < PTE_PREFETCH_NUM; i++, spte++) {
-		if (is_shadow_present_pte(*spte) || spte == sptep) {
-			if (!start)
-				continue;
-			if (!direct_pte_prefetch_many(vcpu, sp, start, spte))
-				return;
-
-			start = NULL;
-		} else if (!start)
-			start = spte;
-	}
-	if (start)
-		direct_pte_prefetch_many(vcpu, sp, start, spte);
-}
-
-static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
-{
-	struct kvm_mmu_page *sp;
-
-	sp = sptep_to_sp(sptep);
-
-	/*
-	 * Without accessed bits, there's no way to distinguish between
-	 * actually accessed translations and prefetched, so disable pte
-	 * prefetch if accessed bits aren't available.
-	 */
-	if (sp_ad_disabled(sp))
-		return;
-
-	if (sp->role.level > PG_LEVEL_4K)
-		return;
-
-	/*
-	 * If addresses are being invalidated, skip prefetching to avoid
-	 * accidentally prefetching those addresses.
-	 */
-	if (unlikely(vcpu->kvm->mmu_invalidate_in_progress))
-		return;
-
-	__direct_pte_prefetch(vcpu, sp, sptep);
-}
-
 /*
  * Lookup the mapping level for @gfn in the current mm.
  *
@@ -3502,8 +3442,8 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	struct kvm_shadow_walk_iterator it;
 	struct kvm_mmu_page *sp;
-	int ret, access;
 	gfn_t base_gfn = fault->gfn;
+	int access;
 
 	kvm_mmu_hugepage_adjust(vcpu, fault);
 
@@ -3534,13 +3474,8 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	if (WARN_ON_ONCE(it.level != fault->goal_level))
 		return -EFAULT;
 
-	ret = mmu_set_spte(vcpu, fault->slot, it.sptep, access,
-			   base_gfn, fault->pfn, fault);
-	if (ret == RET_PF_SPURIOUS)
-		return ret;
-
-	direct_pte_prefetch(vcpu, it.sptep);
-	return ret;
+	return mmu_set_spte(vcpu, fault->slot, it.sptep, access, base_gfn,
+			    fault->pfn, fault);
 }
 
 static void kvm_send_hwpoison_signal(struct kvm_memory_slot *slot, gfn_t gfn)
@@ -6580,11 +6515,38 @@ static int kvm_mmu_write_protect_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	return RET_PF_EMULATE;
 }
 
+static void kvm_mmu_auto_prefault(struct kvm_vcpu *vcpu, gpa_t start,
+				  u64 error_code, u8 level)
+{
+	gfn_t nr_pages = READ_ONCE(auto_prefault_nr_pages);
+	int nr_pages_msb;
+	gfn_t i;
+
+	if (unlikely(error_code & PFERR_RSVD_MASK))
+		return;
+
+	nr_pages = min(nr_pages, KVM_PAGES_PER_HPAGE(PG_LEVEL_1G));
+	nr_pages_msb = find_last_bit((unsigned long *)&nr_pages, sizeof(nr_pages));
+
+	start = ALIGN_DOWN(start, gfn_to_gpa(BIT_ULL(nr_pages_msb)));
+
+	for (i = KVM_PAGES_PER_HPAGE(level); i < nr_pages; i += KVM_PAGES_PER_HPAGE(level)) {
+		gpa_t gpa = start + gfn_to_gpa(i);
+
+		if (gpa < start || gpa_to_gfn(gpa) > kvm_mmu_max_gfn())
+			return;
+
+		if (kvm_tdp_page_prefault(vcpu, gpa, error_code, &level))
+			return;
+	}
+}
+
 int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
 		       void *insn, int insn_len)
 {
 	int r, emulation_type = EMULTYPE_PF;
 	bool direct = vcpu->arch.mmu->root_role.direct;
+	u8 level;
 
 	if (WARN_ON_ONCE(!VALID_PAGE(vcpu->arch.mmu->root.hpa)))
 		return RET_PF_RETRY;
@@ -6617,7 +6579,7 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 		vcpu->stat.pf_taken++;
 
 		r = kvm_mmu_do_page_fault(vcpu, cr2_or_gpa, error_code, false,
-					  &emulation_type, NULL);
+					  &emulation_type, &level);
 		if (KVM_BUG_ON(r == RET_PF_INVALID, vcpu->kvm))
 			return -EIO;
 	}
@@ -6628,6 +6590,8 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 	if (r == RET_PF_WRITE_PROTECTED)
 		r = kvm_mmu_write_protect_fault(vcpu, cr2_or_gpa, error_code,
 						&emulation_type);
+	else if (r == RET_PF_FIXED)
+		kvm_mmu_auto_prefault(vcpu, cr2_or_gpa, error_code, level);
 
 	if (r == RET_PF_FIXED)
 		vcpu->stat.pf_fixed++;
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 27427e7f22fa..b41b4b78cc81 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -617,7 +617,7 @@ static void FNAME(pte_prefetch)(struct kvm_vcpu *vcpu, struct guest_walker *gw,
 
 	sp = sptep_to_sp(sptep);
 
-	if (sp->role.level > PG_LEVEL_4K)
+	if (sp->role.level > PG_LEVEL_4K || sp->role.direct)
 		return;
 
 	/*
@@ -627,9 +627,6 @@ static void FNAME(pte_prefetch)(struct kvm_vcpu *vcpu, struct guest_walker *gw,
 	if (unlikely(vcpu->kvm->mmu_invalidate_in_progress))
 		return;
 
-	if (sp->role.direct)
-		return __direct_pte_prefetch(vcpu, sp, sptep);
-
 	i = spte_index(sptep) & ~(PTE_PREFETCH_NUM - 1);
 	spte = sp->spt + i;
