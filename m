Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69073D6CDB
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662951; cv=none; b=Frb4VSqSGcqRklSY/pmC8iiXYIFC71Fh+Jcq0Axtx6GlOh/8qzJrdYQMugYDDcb+wcga9OXKvy69MkuHGPQhQ5XQcDfb2z7DdXilF1sjOEsm8LMxsKAxBXz4n8vtL/ArNMs5PsVsyuw66oIffwI6ZHk3InkBilQkLyhZIWYEKy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662951; c=relaxed/simple;
	bh=+oNPlRVWZkPXNPyQBbr8Bs8ziBH4mjuHj8KiiOvpCFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5dCqhhkqlZtKaDSJ6cygnZlcX69NGgrSLgbP62FipuCsvs4xgurfhp/Bz6gsxtHO8IYUb0z0a0/gkOicgJh6JSqUYfiQGhBLA9fZfOBvIkvCUwsKqbZ4pTDU9sxXtl59cVSh8/ioe0tDz4dRxVz1XnFis68x/Z8XbsTQdBseRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSRXEaz8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSRXEaz8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTA3xMak32jLEQHD7hiPfKVXSQGkH1mA3EyLnAnQwvk=;
	b=jSRXEaz8mqW4/620oqN7N4CqZRwWH5SHAIbT3Gj1ULQY784lj9YsCltpa0vHw0Bgks/mcz
	MR1Ix47GDA16HqqVJ30uU88HTwZOehc7AFV7viGQnLpHaYWIgQvANWBiy0cnke9mt4Q4Se
	u1GJPakO6qG8HtS+V/C3jtXn6g3RgDA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-8Jls90JsNNqk3006-tNJIQ-1; Wed,
 08 Apr 2026 11:42:24 -0400
X-MC-Unique: 8Jls90JsNNqk3006-tNJIQ-1
X-Mimecast-MFC-AGG-ID: 8Jls90JsNNqk3006-tNJIQ_1775662942
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED039195608E;
	Wed,  8 Apr 2026 15:42:21 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 07B35180036E;
	Wed,  8 Apr 2026 15:42:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Kai Huang <kai.huang@intel.com>
Subject: [PATCH 03/27] KVM: x86/mmu: free up bit 10 of PTEs in preparation for MBEC
Date: Wed,  8 Apr 2026 11:41:53 -0400
Message-ID: <20260408154217.458420-4-pbonzini@redhat.com>
In-Reply-To: <20260408154217.458420-1-pbonzini@redhat.com>
References: <20260408154217.458420-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Jon Kohler <jon@nutanix.com>

Update SPTE_MMIO_ALLOWED_MASK to allow EPT user executable (bit 10) to
be treated like EPT RWX bit2:0, as when mode-based execute control is
enabled, bit 10 can act like a "present" bit.  Likewise do not include
it in FROZEN_SPTE.

No functional changes intended, other than the reduction of the maximum
MMIO generation that is stored in page tables.

Cc: Kai Huang <kai.huang@intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
Message-ID: <20251223054806.1611168-4-jon@nutanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/vmx.h |  2 ++
 arch/x86/kvm/mmu/spte.h    | 20 +++++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 7fdc6b787d70..59e3b095a315 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -549,10 +549,12 @@ enum vmcs_field {
 #define VMX_EPT_ACCESS_BIT			(1ull << 8)
 #define VMX_EPT_DIRTY_BIT			(1ull << 9)
 #define VMX_EPT_SUPPRESS_VE_BIT			(1ull << 63)
+
 #define VMX_EPT_RWX_MASK                        (VMX_EPT_READABLE_MASK |       \
 						 VMX_EPT_WRITABLE_MASK |       \
 						 VMX_EPT_EXECUTABLE_MASK)
 #define VMX_EPT_MT_MASK				(7ull << VMX_EPT_MT_EPTE_SHIFT)
+#define VMX_EPT_USER_EXECUTABLE_MASK		(1ull << 10)
 
 static inline u8 vmx_eptp_page_walk_level(u64 eptp)
 {
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 28086fa86fe0..4283cea3e66c 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -96,11 +96,11 @@ static_assert(!(EPT_SPTE_MMU_WRITABLE & SHADOW_ACC_TRACK_SAVED_MASK));
 #undef SHADOW_ACC_TRACK_SAVED_MASK
 
 /*
- * Due to limited space in PTEs, the MMIO generation is a 19 bit subset of
+ * Due to limited space in PTEs, the MMIO generation is an 18 bit subset of
  * the memslots generation and is derived as follows:
  *
- * Bits 0-7 of the MMIO generation are propagated to spte bits 3-10
- * Bits 8-18 of the MMIO generation are propagated to spte bits 52-62
+ * Bits 0-6 of the MMIO generation are propagated to spte bits 3-9
+ * Bits 7-17 of the MMIO generation are propagated to spte bits 52-62
  *
  * The KVM_MEMSLOT_GEN_UPDATE_IN_PROGRESS flag is intentionally not included in
  * the MMIO generation number, as doing so would require stealing a bit from
@@ -111,7 +111,7 @@ static_assert(!(EPT_SPTE_MMU_WRITABLE & SHADOW_ACC_TRACK_SAVED_MASK));
  */
 
 #define MMIO_SPTE_GEN_LOW_START		3
-#define MMIO_SPTE_GEN_LOW_END		10
+#define MMIO_SPTE_GEN_LOW_END		9
 
 #define MMIO_SPTE_GEN_HIGH_START	52
 #define MMIO_SPTE_GEN_HIGH_END		62
@@ -133,7 +133,8 @@ static_assert(!(SPTE_MMU_PRESENT_MASK &
  * and so they're off-limits for generation; additional checks ensure the mask
  * doesn't overlap legal PA bits), and bit 63 (carved out for future usage).
  */
-#define SPTE_MMIO_ALLOWED_MASK (BIT_ULL(63) | GENMASK_ULL(51, 12) | GENMASK_ULL(2, 0))
+#define SPTE_MMIO_ALLOWED_MASK (BIT_ULL(63) | GENMASK_ULL(51, 12) | \
+				BIT_ULL(10) | GENMASK_ULL(2, 0))
 static_assert(!(SPTE_MMIO_ALLOWED_MASK &
 		(SPTE_MMU_PRESENT_MASK | MMIO_SPTE_GEN_LOW_MASK | MMIO_SPTE_GEN_HIGH_MASK)));
 
@@ -141,7 +142,7 @@ static_assert(!(SPTE_MMIO_ALLOWED_MASK &
 #define MMIO_SPTE_GEN_HIGH_BITS		(MMIO_SPTE_GEN_HIGH_END - MMIO_SPTE_GEN_HIGH_START + 1)
 
 /* remember to adjust the comment above as well if you change these */
-static_assert(MMIO_SPTE_GEN_LOW_BITS == 8 && MMIO_SPTE_GEN_HIGH_BITS == 11);
+static_assert(MMIO_SPTE_GEN_LOW_BITS == 7 && MMIO_SPTE_GEN_HIGH_BITS == 11);
 
 #define MMIO_SPTE_GEN_LOW_SHIFT		(MMIO_SPTE_GEN_LOW_START - 0)
 #define MMIO_SPTE_GEN_HIGH_SHIFT	(MMIO_SPTE_GEN_HIGH_START - MMIO_SPTE_GEN_LOW_BITS)
@@ -217,10 +218,11 @@ extern u64 __read_mostly shadow_nonpresent_or_rsvd_mask;
  *
  * Only used by the TDP MMU.
  */
-#define FROZEN_SPTE	(SHADOW_NONPRESENT_VALUE | 0x5a0ULL)
+#define FROZEN_SPTE	(SHADOW_NONPRESENT_VALUE | 0x1a0ULL)
 
-/* Frozen SPTEs must not be misconstrued as shadow present PTEs. */
-static_assert(!(FROZEN_SPTE & SPTE_MMU_PRESENT_MASK));
+/* Frozen SPTEs must not be misconstrued as shadow or MMU present PTEs. */
+static_assert(!(FROZEN_SPTE & (SPTE_MMU_PRESENT_MASK |
+			       VMX_EPT_RWX_MASK | VMX_EPT_USER_EXECUTABLE_MASK)));
 
 static inline bool is_frozen_spte(u64 spte)
 {
-- 
2.52.0


