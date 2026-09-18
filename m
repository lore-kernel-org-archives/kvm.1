Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336124AF9D4
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719370; cv=none; b=FKEIDYVjrPJy7VBaq0RgLDEI8cUQTebLjRorO2T5EcXsdD8+sgT/FzPBQHc8nU2l0bF3WOxJfFz6STkoubNG3/ba7tTk5vaZg+gRtTRCQ18RTAZqJ+Swgbe1lE0oZWaOL10VeBbWeU4g/w/sVaw6KEE1u7TcKyqOE6mT37KtM2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719370; c=relaxed/simple;
	bh=3W9xldtaGe7Ff2NkNCQJOcGzl15r04ouTawyPDxtIbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CaQgMaEAb5lYZJYQs4Mo4yxi1mNvzRVqAqrIn5Cg3jrXQclQLmcdtF6Yszh5FOc/YOlSOqUQ3bFHivAIpeziOYQZJuN0u3iEVYliKsR4izZIrOsLnh/5O6MmgxRpxOoTOMMJEOvSesLS3jSdgsvi36vo172LtGz5n5GnqVJ30j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ht4K3JGO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ht4K3JGO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789719363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTS8CM36DMSHYjVobhMBvWQts9TN4lc2TtJAx1vS/HI=;
	b=ht4K3JGOJ2BIDPD+qWWVTHmgi+hnRj6oE5HP0trZTX8Bktdaxx8LxhHbpmqmjaWr9KxCVJ
	pD4fYFUYDvVosQTxFoQ/wCI05GDRcUDC9eRH/zmusXgcx19AlELZhrvaCuUPSpvmT/GPVt
	k5y9KXQxTTCdgWbd5h82gCMBEnlQkpc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-nM4JldxnPD6IlP0LxSbQbw-1; Fri,
 18 Sep 2026 04:16:00 -0400
X-MC-Unique: nM4JldxnPD6IlP0LxSbQbw-1
X-Mimecast-MFC-AGG-ID: nM4JldxnPD6IlP0LxSbQbw_1789719359
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48E89195604E;
	Fri, 18 Sep 2026 08:15:59 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9DE5E30001A2;
	Fri, 18 Sep 2026 08:15:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH v2 17/28] KVM: Introduce kvm_check_gen()/kvm_memslots_check_gen()
Date: Fri, 18 Sep 2026 04:15:32 -0400
Message-ID: <20260918081543.139871-18-pbonzini@redhat.com>
In-Reply-To: <20260918081543.139871-1-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In many cases, retrieving kvm_memslots is followed by a check on
the generation of the slots.  Introduce a helper function that
either does the check alone, or compounds it with returning the
struct kvm_memslots* to the caller.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c       | 10 ++--------
 include/linux/kvm_host.h | 13 +++++++++++++
 virt/kvm/kvm_main.c      |  8 ++++----
 virt/kvm/pfncache.c      | 10 ++++------
 4 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6c0c95b92b5a..5b7ff5d9af75 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2049,7 +2049,6 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 {
 	struct gfn_to_hva_cache *ghc = &vcpu->arch.st.cache;
 	struct kvm_steal_time __user *st;
-	struct kvm_memslots *slots;
 	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
 	u64 steal;
 	u32 version;
@@ -2065,9 +2064,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	if (WARN_ON_ONCE(current->mm != vcpu->kvm->mm))
 		return;
 
-	slots = kvm_memslots(vcpu->kvm);
-
-	if (unlikely(slots->generation != ghc->generation ||
+	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) ||
 		     gpa != ghc->gpa ||
 		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
 		/* We rely on the fact that it fits in a single page. */
@@ -2617,7 +2614,6 @@ static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
 {
 	struct gfn_to_hva_cache *ghc = &vcpu->arch.st.cache;
 	struct kvm_steal_time __user *st;
-	struct kvm_memslots *slots;
 	static const u8 preempted = KVM_VCPU_PREEMPTED;
 	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
 
@@ -2644,9 +2640,7 @@ static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
 	if (unlikely(current->mm != vcpu->kvm->mm))
 		return;
 
-	slots = kvm_memslots(vcpu->kvm);
-
-	if (unlikely(slots->generation != ghc->generation ||
+	if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) ||
 		     gpa != ghc->gpa ||
 		     kvm_is_error_hva(ghc->hva) || !ghc->memslot))
 		return;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 24d04322d89e..7599ab7ad7ef 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2644,6 +2644,19 @@ static inline int kvm_mem_attributes_may_write_gfn(struct kvm *kvm, gfn_t gfn)
 	return kvm_mem_attributes_may_write(attrs);
 }
 
+static inline bool kvm_memslots_check_gen(struct kvm *kvm, u64 slots_generation, struct kvm_memslots **p_slots)
+{
+	struct kvm_memslots *slots = *p_slots = kvm_memslots(kvm);
+	return slots->generation == slots_generation;
+}
+
+static inline bool kvm_check_gen(struct kvm *kvm, u64 slots_generation)
+{
+	struct kvm_memslots *slots;
+	return kvm_memslots_check_gen(kvm, slots_generation, &slots);
+}
+
+
 #ifdef CONFIG_KVM_GUEST_MEMFD
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 994a33a09448..89e79d3f27f0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3523,14 +3523,14 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 				  void *data, unsigned int offset,
 				  unsigned long len)
 {
-	struct kvm_memslots *slots = kvm_memslots(kvm);
+	struct kvm_memslots *slots;
 	int r;
 	gpa_t gpa = ghc->gpa + offset;
 
 	if (WARN_ON_ONCE(len + offset > ghc->len))
 		return -EINVAL;
 
-	if (slots->generation != ghc->generation) {
+	if (unlikely(!kvm_memslots_check_gen(kvm, ghc->generation, &slots))) {
 		if (__kvm_gfn_to_hva_cache_init(slots, ghc, ghc->gpa, ghc->len))
 			return -EFAULT;
 	}
@@ -3561,14 +3561,14 @@ int kvm_read_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 				 void *data, unsigned int offset,
 				 unsigned long len)
 {
-	struct kvm_memslots *slots = kvm_memslots(kvm);
+	struct kvm_memslots *slots;
 	int r;
 	gpa_t gpa = ghc->gpa + offset;
 
 	if (WARN_ON_ONCE(len + offset > ghc->len))
 		return -EINVAL;
 
-	if (slots->generation != ghc->generation) {
+	if (unlikely(!kvm_memslots_check_gen(kvm, ghc->generation, &slots))) {
 		if (__kvm_gfn_to_hva_cache_init(slots, ghc, ghc->gpa, ghc->len))
 			return -EFAULT;
 	}
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 728d2c1b488a..e09703d249bb 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -72,8 +72,6 @@ static bool kvm_gpc_is_valid_len(gpa_t gpa, unsigned long uhva,
 
 bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 {
-	struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
-
 	if (!gpc->active)
 		return false;
 
@@ -81,7 +79,7 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 	 * If the page was cached from a memslot, make sure the memslots have
 	 * not been re-configured.
 	 */
-	if (!kvm_is_error_gpa(gpc->gpa) && gpc->generation != slots->generation)
+	if (!kvm_is_error_gpa(gpc->gpa) && !kvm_check_gen(gpc->kvm, gpc->generation))
 		return false;
 
 	if (kvm_is_error_hva(gpc->uhva))
@@ -290,12 +288,12 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 		if (gpc->uhva != old_uhva)
 			hva_change = true;
 	} else {
-		struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
+		struct kvm_memslots *slots;
 
 		page_offset = offset_in_page(gpa);
 
-		if (gpc->gpa != gpa || gpc->generation != slots->generation ||
-		    kvm_is_error_hva(gpc->uhva)) {
+		if (!kvm_memslots_check_gen(gpc->kvm, gpc->generation, &slots) ||
+		    gpc->gpa != gpa || kvm_is_error_hva(gpc->uhva)) {
 			gfn_t gfn = gpa_to_gfn(gpa);
 
 			gpc->gpa = gpa;
-- 
2.52.0


