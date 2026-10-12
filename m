Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E453E5EF7;
	Mon, 12 Oct 2026 23:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848209; cv=none; b=gTB5CNM1G8WR8nBJgIdlSialreRJQsJ+9BzJGx4dGLl5Ca+pSwLHJwV09RQHobZdr7MZV32HIUKne5GJm0z5G9WhPRRmLULz711ZGwe22bEOOYsCRlC99fQCiNqBJjw7jXiaSmv62W2zipqEXdP9KqPJYu2dvaZeMSj9c6+G4Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848209; c=relaxed/simple;
	bh=HsgqQFsedMKuOjesq6n4oeRVFgzVBGBapMlMV5ffZlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOWhcmUUr67VgJIo+8hkduNPkvLubkROgoZrCLxpduM0WFeiDNd3qXClbE/ZCfumrJrBKnxOfSszZ5mumLIV4Oz6KZ6zs10BtRZuVzFWde70u1z8pQFKdM0Lh2C7gElaNXrj467xvA/5IW4VFG8TFQRMc31s7nnaaAY/j9zUhnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpL1fOpl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpL1fOpl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51331F0089B;
	Mon, 12 Oct 2026 23:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848208;
	bh=YvAET9y2VxNKCJ3x+K0gvhEWj5YorAI1wWRVXrB61fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HpL1fOplvcIFVW+5vH8CZt1HVhiwmgxiVQibyDj3ScPvPktN7G94xkjTBSlbph39f
	 ziWeqCX/IXKrccFA9ukte+XukFuIEbZwRz8cB7/EHOPEmrYB7RC5/wO8nRYHdZK96R
	 Erxy7AvYlxYDJVToqamJRO6AtJ5N+aP2IlPLgnViAtfhmHt+wV5SdghJfX/tjfkwPx
	 OdCbqU4saLQjiXMLjzB1lXEyT/oN1Pcbk+OJu8DCC0ZeDF75GHSY43ae+0GSeKs2eT
	 KUWFRF+MXJh6y/sOo5l8F2ZtH4m/jSGbXSI/36yxmUcug1BBIHZyo42LVjOC6eEByK
	 OekqEkte5YyjA==
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
Subject: [PATCH v3 04/27] KVM: x86/mmu: Support specifying reserved TLB tags
Date: Mon, 12 Oct 2026 23:36:15 +0000
Message-ID: <20261012233638.2546339-5-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012233638.2546339-1-yosry@kernel.org>
References: <20261012233638.2546339-1-yosry@kernel.org>
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
index 97d49247d9d82..c096c1a2b4684 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -8182,9 +8182,17 @@ static struct {
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
@@ -8194,7 +8202,12 @@ int kvm_init_tlb_tags(unsigned int nr)
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
 
@@ -8208,13 +8221,8 @@ int kvm_init_tlb_tags(unsigned int nr)
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
@@ -8229,30 +8237,36 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_destroy_tlb_tags);
 
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
index a8df797163ecc..3e1ecd9148e9c 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -299,7 +299,7 @@ struct kvm_vmx {
 
 static __always_inline int init_vpids(void)
 {
-	return enable_vpid ? kvm_init_tlb_tags(VMX_NR_VPIDS) : 0;
+	return enable_vpid ? kvm_init_tlb_tags(VMX_NR_VPIDS, 1) : 0;
 }
 
 static __always_inline void destroy_vpids(void)
-- 
2.56.0.385.gd3acb90ef8-goog

