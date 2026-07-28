Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47B422423A;
	Tue, 28 Jul 2026 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198967; cv=none; b=oeVhwzOpwGdQNOJfprpwb3YYXRHCS8GqEQP8vLDaEIztWh/mz5Qbftfz95qfD3lp5uMu6V7tAGroQctjuTpNvbdSr2lW6kxWIZHwCUSTMByXax5R1XgPx9QwaMev8dCMEMsyPerSO7AImP+8xw+zkHa5ZeZJ2h0l8uSrfLq7/Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198967; c=relaxed/simple;
	bh=GwuNjf+fY3NRr0yCX55W6I0nzSB0Q6To9kCbN1nIzUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYusjKb7QcajUyH3Grdu70z2bYkdi0vwVPV1y6mQvH0ngC977DscTot0cTaPUhXLmeTCFtvQkn5irUDPRpDyD6KGEgqac2CIkaxpfRrXA/bxjKuy0+sA3fcoRIuvw6NeiLobQ17Gn3oIVBtClzy0D7T9iB38xh9dbA2Gw7+1Ou0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hgy+Gq68; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hgy+Gq68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BFE1F00A3A;
	Tue, 28 Jul 2026 00:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198965;
	bh=dxBIb/pEf85cMgBAYc8a1joLEMuO3tDAey6SdE9KAX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hgy+Gq68HLjTzDsDUf20ubiF/NnBgY4OzZD92ugD+W2S7O3AjIxPkzPyqxcwTYk8P
	 Zo2QxEyfsgvrlXUGmER8iYOfVPEz22Nnig2SHxlqHCV0Oi3upDr1S9a1Gz39NszUSs
	 RLukZvPPPtl03jDVLjL7VEcnjsRPOvJrz/BKbwlVGBzEMI27rRpPYGsF5U6ukCGcCp
	 R3iFlVAXAbfKofXvHGsvbtqGnDiI1D/VzaL1AlxRDgG66e+GEbq2GBQF/mN8u1mSXZ
	 s5C6B9HAHo5Je5rDbDS3KcliQkAoN8HrX5CY9kFhlRmUN6qgWwhb7wBplXtZmjilNu
	 cGs9wNQU50ZGw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v1 04/28] KVM: x86/mmu: Support specifying reserved TLB tags
Date: Tue, 28 Jul 2026 00:35:33 +0000
Message-ID: <20260728003557.1136583-5-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260728003557.1136583-1-yosry@kernel.org>
References: <20260728003557.1136583-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for using the TLB tags allocator for SVM, which has a
range of ASIDs allocated for SEV/SNP, pass in the number of reserved TLB
tags when initializing the TLB tags allocator. The bitmap is
conceptually shifted such that bit=0 corresponds to tag=nr_reserved.

Specifying the minimum value during initialization also makes the API
clearer, as tag=0 is now explicitly reserved by the caller.

No functional change intended for VMX as VPID=0 was already implicitly
reserved.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/mmu.h     |  2 +-
 arch/x86/kvm/mmu/mmu.c | 42 ++++++++++++++++++++++++++++--------------
 arch/x86/kvm/vmx/vmx.h |  2 +-
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index de79e002edf8f..b443a5083bfb0 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -413,7 +413,7 @@ static inline bool kvm_is_gfn_alias(struct kvm *kvm, gfn_t gfn)
 
 typedef unsigned int kvm_tlb_tag_t;
 
-int kvm_init_tlb_tags(unsigned int nr);
+int kvm_init_tlb_tags(unsigned int nr_total, unsigned int nr_reserved);
 void kvm_destroy_tlb_tags(void);
 kvm_tlb_tag_t kvm_alloc_tlb_tag(void);
 void kvm_free_tlb_tag(kvm_tlb_tag_t tag);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d9edba502cac7..05d2ba2598e1b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -8073,9 +8073,17 @@ static struct {
 	spinlock_t	lock;
 	unsigned long	*bitmap;
 	unsigned int	nr;
+	kvm_tlb_tag_t	start;
 } tlb_tags;
 
-int kvm_init_tlb_tags(unsigned int nr)
+/*
+ * Initialize @nr_total TLB tags, where @nr_reserved of those tags are reserved.
+ * Reserved tags start at 0 and are contiguous. Hence, usable tags are
+ * [nr_reserved, nr_total). At least one reserved tag is required, as 0 is the
+ * host TLB tag on both VMX and AMD, and is the value returned on a failed tag
+ * allocation.
+ */
+int kvm_init_tlb_tags(unsigned int nr_total, unsigned int nr_reserved)
 {
 	/*
 	 * Limit the number of TLB tags to VMX's hardcoded maximum of 0x10000
@@ -8085,7 +8093,12 @@ int kvm_init_tlb_tags(unsigned int nr)
 	 * need a solution that works for both Intel and AMD.
 	 */
 	const unsigned int MAX_NR_TLB_TAGS = VMX_NR_VPIDS;
+	unsigned int nr;
 
+	if (WARN_ON_ONCE(!nr_reserved || nr_reserved > nr_total))
+		return -EINVAL;
+
+	nr = nr_total - nr_reserved;
 	if (!nr)
 		return 0;
 
@@ -8099,13 +8112,8 @@ int kvm_init_tlb_tags(unsigned int nr)
 	if (!tlb_tags.bitmap)
 		return -ENOMEM;
 
-	/*
-	 * 0 is the host's TLB tag for both VMX's VPID and SVM's ASID, and is
-	 * returned on failed allocations (e.g. no more tags left).
-	 */
-	__set_bit(0, tlb_tags.bitmap);
-
 	tlb_tags.nr = nr;
+	tlb_tags.start = nr_reserved;
 	spin_lock_init(&tlb_tags.lock);
 	return 0;
 }
@@ -8120,30 +8128,36 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_destroy_tlb_tags);
 
 kvm_tlb_tag_t kvm_alloc_tlb_tag(void)
 {
-	kvm_tlb_tag_t tag;
+	unsigned int bit;
 
 	if (!tlb_tags.bitmap)
 		return 0;
 
 	guard(spinlock)(&tlb_tags.lock);
 
-	tag = find_first_zero_bit(tlb_tags.bitmap, tlb_tags.nr);
-	if (tag >= tlb_tags.nr)
+	bit = find_first_zero_bit(tlb_tags.bitmap, tlb_tags.nr);
+	if (bit >= tlb_tags.nr)
 		return 0;
 
-	__set_bit(tag, tlb_tags.bitmap);
-	return tag;
+	__set_bit(bit, tlb_tags.bitmap);
+	return tlb_tags.start + bit;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_alloc_tlb_tag);
 
 void kvm_free_tlb_tag(kvm_tlb_tag_t tag)
 {
-	if (!tag || WARN_ON_ONCE(tag >= tlb_tags.nr))
+	unsigned int bit;
+
+	if (!tag || WARN_ON_ONCE(tag < tlb_tags.start))
+		return;
+
+	bit = tag - tlb_tags.start;
+	if (WARN_ON_ONCE(bit >= tlb_tags.nr))
 		return;
 
 	guard(spinlock)(&tlb_tags.lock);
 
-	__clear_bit(tag, tlb_tags.bitmap);
+	__clear_bit(bit, tlb_tags.bitmap);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_free_tlb_tag);
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 3de3ee53ccbdc..7b7e57fd549c4 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -343,7 +343,7 @@ static __always_inline u32 vmx_get_intr_info(struct kvm_vcpu *vcpu)
 
 static __always_inline int init_vpids(void)
 {
-	return enable_vpid ? kvm_init_tlb_tags(VMX_NR_VPIDS) : 0;
+	return enable_vpid ? kvm_init_tlb_tags(VMX_NR_VPIDS, 1) : 0;
 }
 
 static __always_inline void destroy_vpids(void)
-- 
2.55.0.229.g6434b31f56-goog

