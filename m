Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C35B27EC7C;
	Tue, 16 Jun 2026 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570545; cv=none; b=qhBtj3L1Eq9AL5N6SmQ4s036lfgL5d/xmlh7gaIAcHQzkdD+NcFXHJI6M7y54dcHtfx5Bl6EKdOnwLaTOUffkV+d93GXMsj8zPDmXAMSshqeP6Ad5WFclRwK2bSQ5N6FFGDsYzJfffyBS9g/O0RI5lb/kRl3zlVIdwkS5JXkSAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570545; c=relaxed/simple;
	bh=LpE2D8JeuiHftJQvIS9kagZYnYqpxAOcqHCzNhSf1xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szqfuZWQLuQ2tUcR5YOyEyxrvta6W0bg+QMHwSnk/cGteIpEYwAnO8bBPLDCeScdBBg9mvCnEcCPcCG3lkBhgd7fYJGjGA7kXLo0eU7/URMmn9GOB0olK2Lybby7GMmwz/ZVm7CPQlGigFiJo7RZoP2jyLJaDwzJuYYjHKGaxzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1ROir2b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1ROir2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306431F00A3A;
	Tue, 16 Jun 2026 00:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570543;
	bh=lws1dRSnHsKo/9vA/82BsxaXe+bSynL/lwearvOELG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n1ROir2bAvW4ojediJZrP/O/ODPS69XqZ9LxldWy+CPZqAK5yudDxv54wktJDmo88
	 iu8kDRK9HvlKex6E+juIjUvvuEmtBNfvBRdSAgSO7ZwaNQwBkJAWLZ0CjS1rX29xhb
	 zCn0zZxls22XLIRxaW+txefdiW0w5ZKc416aSg3ML/SS14ZkiYbgbpbYXQKPuROIf0
	 vhkERcJKrOl0CI03M/nctHcf9rkn1R/dUEyrNWJsIsbPrZf4t7Y0vv1UO/Jt/N8+6O
	 Ib2pRLfQHCFTN3clkHBdkrA0Y17ww+kf+359z9S2xVPi6zdksZndWts+FvUuv/cq7H
	 38bu9I/otwTWg==
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
Subject: [RFC PATCH v2 04/25] KVM: x86/mmu: Support specifying a minimum TLB tag
Date: Tue, 16 Jun 2026 00:41:33 +0000
Message-ID: <20260616004155.1435766-5-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616004155.1435766-1-yosry@kernel.org>
References: <20260616004155.1435766-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for using the TLB tags allocator for SVM, which has a
range of ASIDs allocated for SEV/SNP, pass in a minimum TLB tag when
initializing the TLB tags allocator. The bitmap is conceptually shifted
such that bit=0 corresponds to tag=min.

Specifying the minimum value during initialization also makes the API
clearer, as the passed number of tags becomes the actual number of
*usable* tags, and tag=0 is explicitly excluded by the caller.

No functional change intended for VMX as VPID=0 is not used anyway.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/mmu.h     |  2 +-
 arch/x86/kvm/mmu/mmu.c | 38 +++++++++++++++++++++++---------------
 arch/x86/kvm/vmx/vmx.h |  3 ++-
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 9a2916012cbff..cfffee92b8b71 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -337,7 +337,7 @@ static inline bool kvm_is_gfn_alias(struct kvm *kvm, gfn_t gfn)
 
 typedef unsigned int kvm_tlb_tag_t;
 
-int kvm_init_tlb_tags(unsigned int nr);
+int kvm_init_tlb_tags(kvm_tlb_tag_t min, unsigned int nr);
 void kvm_destroy_tlb_tags(void);
 kvm_tlb_tag_t kvm_alloc_tlb_tag(void);
 void kvm_free_tlb_tag(kvm_tlb_tag_t tag);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e021ed562502f..bf2e0c2205631 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -8197,24 +8197,26 @@ static struct {
 	spinlock_t	lock;
 	unsigned long	*bitmap;
 	unsigned int	nr;
+	kvm_tlb_tag_t	min;
 } tlb_tags;
 
-int kvm_init_tlb_tags(unsigned int nr)
+int kvm_init_tlb_tags(kvm_tlb_tag_t min, unsigned int nr)
 {
-	if (WARN_ON_ONCE(!nr))
-		return -EINVAL;
-
-	tlb_tags.bitmap = bitmap_zalloc(nr, GFP_KERNEL);
-	if (!tlb_tags.bitmap)
-		return -ENOMEM;
+	unsigned int end;
 
 	/*
 	 * 0 is the host's TLB tag for both VMX's VPID and SVM's ASID, and is
 	 * returned on failed allocations (e.g. no more tags left).
 	 */
-	__set_bit(0, tlb_tags.bitmap);
+	if (WARN_ON_ONCE(!min || !nr || check_add_overflow(min, nr, &end)))
+		return -EINVAL;
+
+	tlb_tags.bitmap = bitmap_zalloc(nr, GFP_KERNEL);
+	if (!tlb_tags.bitmap)
+		return -ENOMEM;
 
 	tlb_tags.nr = nr;
+	tlb_tags.min = min;
 	spin_lock_init(&tlb_tags.lock);
 	return 0;
 }
@@ -8229,30 +8231,36 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_destroy_tlb_tags);
 
 kvm_tlb_tag_t kvm_alloc_tlb_tag(void)
 {
-	kvm_tlb_tag_t tag;
+	unsigned int bit;
 
 	if (WARN_ON_ONCE(!tlb_tags.bitmap))
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
+	return tlb_tags.min + bit;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_alloc_tlb_tag);
 
 void kvm_free_tlb_tag(kvm_tlb_tag_t tag)
 {
-	if (!tag || WARN_ON_ONCE(tag >= tlb_tags.nr))
+	unsigned int bit;
+
+	if (!tag || WARN_ON_ONCE(tag < tlb_tags.min))
+		return;
+
+	bit = tag - tlb_tags.min;
+	if (WARN_ON_ONCE(bit >= tlb_tags.nr))
 		return;
 
 	guard(spinlock)(&tlb_tags.lock);
 
-	__clear_bit(tag, tlb_tags.bitmap);
+	__clear_bit(bit, tlb_tags.bitmap);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_free_tlb_tag);
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index d6d35637d94f8..0ddfe9626c126 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -336,7 +336,8 @@ static __always_inline u32 vmx_get_intr_info(struct kvm_vcpu *vcpu)
 
 static __always_inline int init_vpids(void)
 {
-	return enable_vpid ? kvm_init_tlb_tags(VMX_NR_VPIDS) : 0;
+	/* Exclude VPID=0 as it is used for the host */
+	return enable_vpid ? kvm_init_tlb_tags(1, VMX_NR_VPIDS - 1) : 0;
 }
 
 static __always_inline void destroy_vpids(void)
-- 
2.54.0.1136.gdb2ca164c4-goog

