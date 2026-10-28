Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219176;
	b=bjGD1kcjDcN1uLldpiIbxp/9U6lm+dMb/nf/sJBLPfSbMCryLX5+G4/BSBfH4AeFr10o
	 emoA3XasuJLMoBODnikZXtELASYu5PGsd55RhGMppq324OxaVjr9nqu/3IrXKKsBynD9H
	 DD6ESpnNWp8hZ0qnj4bl4HZjFhauIicBzRWTmGtqXgqx08AsXSMqNxobyQ977oNwlefjw
	 xWdFkslr2BBhmKB/VPYTCMzGH4wACUazADv6PhKLZw/Tpl8a6gPv9MRpx58+zT09B4R+y
	 vJ17SKv9fE+0SFpRKx3ghi+x/3yxnNFNRPcMIY1GJ78hu4lxV2hWA4pE97ypoaox+kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=fTgOs18rglJdr0BQjgxR3d8iHdveVS92Tu/yM+voRyg=;
	b=S6wZS1YUKNuVNII2tJCq+rdq9AAtITXzVHP27Mm8h4T3ywli7h9h1XR65VyW0mwVEDKj
	 ocRlYtIA3AQk76+PxcZ9kfmf49lhPzdMFyEUAu6IM/llQB30HmARgqSuKWfE5RLojj+As
	 BX9x+yStuQgMBxemnTcQavLhUYnjbZFd24KVx4HVIa7TwbnEWC91bac5nEMVP1LG2mehC
	 Slhi74zcFmUOREFBL9s7XyFxZc9F22RjLbBY3v7I0KUW/4P+8K7ZNQpcXyK1VAEQBLvky
	 Y1Fb5DMB2iOWCFUup9hNL5HN+R3cqlgTHZ8VZoH94CPumBNwXFSajMLmv7qD1pgggyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=moUEUMKf;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471BE60A2603
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 20:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 471BE60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=moUEUMKf
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3adcb81f487so2110506a91.3
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793219176; x=1793823976; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fTgOs18rglJdr0BQjgxR3d8iHdveVS92Tu/yM+voRyg=;
        b=moUEUMKfXzWIaEOuyhzzX3O2aSE3RCFeOWqSY7s3LmytaMuT1odKjwiTblUlc2vjvZ
         iTSIKv6wmMACYLOw9Ncs9NxE0XQseolRNs9w1XVQAHBGya/gly8xkKVCTeNZe+gk//DF
         ur723EWhT6eJA1ZWvFJ2IgbEeZPMRUTEYDge4p+Ez/dJ9+T2BFi7fBSpR3OYOWT2/OwX
         vqPAfp3t1k00KGCGh5Mji5sQxeLG+i3FTZp35JlRSqFsHvyFzvwQKuLNdsDOrq/hAYOu
         gRvYrlU8TDruVSehI59k7nu2Mp9mv8A7x4/Q3EXwvnUjm9sakjlewhoDZE0GMxzDuQcG
         TdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793219176; x=1793823976;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fTgOs18rglJdr0BQjgxR3d8iHdveVS92Tu/yM+voRyg=;
        b=sUsNLIWcX6rK0WGTP1/ypu0OLqiMEkltZbrVbSwNlRFWuy7InfAvr9349+JfMOl3/s
         Mz1h+aJPyTHBlayU5Dw54fi34TzAl14EYo5FPnjlUAEFGwYhYeSLOrloW+qtVMiXNqzh
         qlmFKqPf2VlGpoNqVDgrOT0U+CF/BsY89MZ1K2uRFqOKMKUR3415S/01zY3R6/GfnUMy
         n0SMQMGF3+jLF11u63RYJHS8iwyUw8ukNxahtkdJeyRvbrDR1AVaISPjFBBL7yNnZVW/
         uWTntZEMbtEMaad8mQcwyV2gqF76cS1YA67MULxG3f87EtnRjPoNqMIs7QKrXS0dkeob
         PEAg==
X-Gm-Message-State: AFq9FYI+rqlGo89RMLTaAg5U1E7DvUnMJW3SPrt6LAAFSVwU/xlr+n+a
	fvgKL6/8nYPNw9ZTfbMBWc4PS/tPFg8rt2440wZOEPg8I86OTZSE2dZ8YAA/xAaX+eGCFdBl9Uh
	8qkpurQ==
X-Received: from plkk3.prod.google.com ([2002:a17:902:c403:b0:2e8:f377:a4d4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dfcd:b0:3ac:a203:e0a5
 with SMTP id 98e67ed59e1d1-3ae581a981fmr2744312a91.11.1793219175487; Wed, 28
 Oct 2026 13:26:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 13:26:06 -0700
In-Reply-To: <20261028202607.1844883-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028202607.1844883-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028202607.1844883-4-seanjc@google.com>
Subject: [PATCH 3/4] KVM: x86/mmu: Add automatic prefaulting/prefetching for
 TDP MMU faults
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Marangoni <mamarang@amazon.com>
Content-Type: text/plain; charset="UTF-8"

Leverage the prefault code to add "automatic" prefetching of surrounding
SPTEs when handling TDP MMU page faults.  As pointed out by Marco, the TDP
MMU doesn't support prefetching SPTEs, which puts the TDP MMU at a severe
performance disadvantage relative to the shadow MMU when faulting in guest
memory at 4KiB granularity, and in general is a gap in the TDP MMU.

Use the prefault flow to prefetch SPTEs instead of the more minimal, custom
approach used by the shadow MMU.  Reusing the prefault flow sacrifices a
small amount of performance (the standard page fault path is "heavier"),
but is vastly simpler, supports backing memory that can't be GUP'd, and
shares its maintenance burden with KVM_PRE_FAULT_MEMORY.  E.g. multiple
flaws in x86's prefault code were practically impossible to hit with
userspace-driven prefaulting, but were hit almost immediately with
KVM-driven automatic prefetching.

Provide a writable module param to let userspace control the number of
pages to prefault, as KVM needs a control of some kind, and letting the
user choose how aggressively to prefetch is just as easy as hardcoding the
number of PTEs to prefetch.  I.e. supporting a variety of use cases is all
but free.  Default to PTE_PREFETCH_NUM as that's been KVM's behavior for
the shadow MMU for decades, i.e. even if it was arbitrary, it's gotten a
*lot* of mileage and so presumably is a reasonable default.

Instead of unconditionally bailing on hugepage faults, skip prefetching if
the original installed page size covers at least the number of pages the
user wants to prefetch.  In practice, it's unlikely hugepage prefetching
will see much, if any, use, but it's practically free to support, and will
allow for more experimentation and tuning.

Note!  Check for an incompatible memslot *before* invoking the specific
page fault handler, and thus before fast page faults are handled, otherwise
the fast page fault handler can "fix" a fault that never happened and log a
spurious, non-existent access.

Do NOT prefetch in response to protection faults, i.e. if there was already
a shadow-present SPTE, because prefetching in that scenario is unlikely to
be beneficial.  Note, this would also prevent spurious dirty logging via
fast page faults, but (obviously) only for writes, i.e. wouldn't block fast
handling for !PRESENT page faults when A/D bits are disabled.  I.e. the
aforementioned early check is still necessary to avoid spurious dirty log
entries (or KVM would need to explicitly treat auto-prefetch "faults" as
"can't be fast").

Lastly, don't go down the slow I/O path for auto-prefetch faults, as the
goal is for auto-prefetching to be light and fast, i.e. to pull in SPTEs
without significantly increasing the latency of handling page faults.

For now, use the auto-prefaulting code to the TDP MMU, i.e. defer
converting direct shadow MMUs to a separate change.

Reported-by: Marco Marangoni <mamarang@amazon.com>
Closes: https://lore.kernel.org/all/20260825140159.70997-1-mamarang@amazon.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 64 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3bd0d921778d..c56a2eaa4646 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -122,8 +122,15 @@ static int max_huge_page_level __read_mostly;
 static int tdp_root_level __read_mostly;
 static int max_tdp_level __read_mostly;
 
+/*
+ * The exact number of PTEs that can be prefetched for the shadow MMU, and the
+ * default number of pages to prefault/prefetch pages for the TDP MMU.
+ */
 #define PTE_PREFETCH_NUM		8
 
+static unsigned int __read_mostly auto_prefault_nr_pages = PTE_PREFETCH_NUM;
+module_param(auto_prefault_nr_pages, uint, 0644);
+
 #include <trace/events/kvm.h>
 
 /* make pte_list_desc fit well in cache lines */
@@ -4709,10 +4716,12 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 	/*
 	 * If resolving the page failed because I/O is needed to fault-in the
 	 * page, then either set up an asynchronous #PF to do the I/O, or if
-	 * doing an async #PF isn't possible, retry with I/O allowed.  All
-	 * other failures are terminal, i.e. retrying won't help.
+	 * doing an async #PF isn't possible, retry with I/O allowed.  Never
+	 * go down the slow I/O path for automatic prefetching, as the goal is
+	 * for it to be light and fast.  All other failures are terminal, i.e.
+	 * retrying won't help.
 	 */
-	if (fault->pfn != KVM_PFN_ERR_NEEDS_IO)
+	if (fault->pfn != KVM_PFN_ERR_NEEDS_IO || fault->auto_prefetch)
 		return RET_PF_CONTINUE;
 
 	if (!fault->prefetch && kvm_can_do_async_pf(vcpu)) {
@@ -5072,6 +5081,18 @@ static int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		 */
 		fault.gfn = gpa_to_gfn(fault.addr) & ~kvm_gfn_direct_bits(vcpu->kvm);
 		fault.slot = kvm_vcpu_gfn_to_memslot(vcpu, fault.gfn);
+
+		if (fault.auto_prefetch) {
+			r = kvm_check_memslot_usable_for_auto_prefetch(fault.slot, ACC_ALL);
+			if (r)
+				return r;
+		}
+	} else {
+		/*
+		 * Indirect MMUs need to use a dedicated prefetch mechanism, as
+		 * the associated guest PTE factors into the prefetching.
+		 */
+		WARN_ON_ONCE(fault.auto_prefetch);
 	}
 
 	/*
@@ -6654,11 +6675,44 @@ static int kvm_mmu_write_protect_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	return RET_PF_EMULATE;
 }
 
+static void kvm_mmu_auto_prefault(struct kvm_vcpu *vcpu, gpa_t start,
+				  u64 error_code, u8 level)
+{
+	gfn_t nr_pages = READ_ONCE(auto_prefault_nr_pages);
+	int nr_pages_msb;
+	gfn_t i;
+
+	if (error_code & (PFERR_RSVD_MASK | PFERR_PRESENT_MASK))
+		return;
+
+	if (!tdp_mmu_enabled || vcpu->arch.mmu->page_fault != kvm_tdp_page_fault)
+		return;
+
+	nr_pages = min(nr_pages, KVM_PAGES_PER_HPAGE(PG_LEVEL_1G));
+	if (KVM_PAGES_PER_HPAGE(level) >= nr_pages)
+		return;
+
+	nr_pages_msb = find_last_bit((unsigned long *)&nr_pages, sizeof(nr_pages));
+
+	start = ALIGN_DOWN(start, gfn_to_gpa(BIT_ULL(nr_pages_msb)));
+
+	for (i = 0; i < nr_pages; i += KVM_PAGES_PER_HPAGE(level)) {
+		gpa_t gpa = start + gfn_to_gpa(i);
+
+		if (gpa < start || gpa_to_gfn(gpa) > kvm_mmu_max_gfn())
+			return;
+
+		if (kvm_tdp_page_prefault(vcpu, gpa, error_code, KVM_PREFETCH_AUTO, &level))
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
@@ -6692,7 +6746,7 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 
 		r = kvm_mmu_do_page_fault(vcpu, cr2_or_gpa, error_code,
 					  KVM_PREFETCH_NONE,
-					  &emulation_type, NULL);
+					  &emulation_type, &level);
 		if (KVM_BUG_ON(r == RET_PF_INVALID, vcpu->kvm))
 			return -EIO;
 	}
@@ -6703,6 +6757,8 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 	if (r == RET_PF_WRITE_PROTECTED)
 		r = kvm_mmu_write_protect_fault(vcpu, cr2_or_gpa, error_code,
 						&emulation_type);
+	else if (r == RET_PF_FIXED)
+		kvm_mmu_auto_prefault(vcpu, cr2_or_gpa, error_code, level);
 
 	if (r == RET_PF_FIXED)
 		vcpu->stat.pf_fixed++;
-- 
2.56.0.313.g2479322e68-goog

