Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5455750E588
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739459; cv=none; b=IMlo+8WdZq18hyNANiXwX9fY2DVHhIRNpj/KPV/a92Kc5gob7QV6CoLB4wgiPcykUVU9K6dx8AHtZqjSSplj7D4BxlvUy2W4mif/qol5gNT9obWyNtwn88pPCUssnSMHJBUfXCbE0+2P4cU3Sdqkbj9ysDuh+nKQbmWADQEW2gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739459; c=relaxed/simple;
	bh=3ZntO1O6b07VecC9IkjzDDivNOhvCcjZ0rBWZT7nojM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZDWHb1qy4L+HOzBucUjAKTOa7ySGuV2wIJ+D0Lyn2cLX5p+zWdDIJXj8233HMwF6zLndbMuPLWoD49Hs3hY2OvwgYlAS3lS2OKIGUPMPe1tE03fyzeAgtujbYlw5mhtsMis/hFFltZb6TGjLho4MApDkCPHgXX32ZBQCYI+7RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDzazxsb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDzazxsb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789739456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLcA9vPblPxAMil122r7PbaiyvSM1S8mrgYb0mWEprU=;
	b=LDzazxsbbBN2JhlVpBwbCsry9rddT8jIJ9PNUIzTZto9m9OTSmKieraxg6ugFsWF4kLFSu
	oF32n5B1IGHbCoeeNcXrqowZQvzHJYe2PoV/v1HFY0w/YR7BVNiHVhmhMOefEwQimiaNN/
	yIIWltBZd9VhpZouNkHdcYHP1VTZVDQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-9jvLnk1gPlKVzFZrhp0C0Q-1; Fri,
 18 Sep 2026 09:50:52 -0400
X-MC-Unique: 9jvLnk1gPlKVzFZrhp0C0Q-1
X-Mimecast-MFC-AGG-ID: 9jvLnk1gPlKVzFZrhp0C0Q_1789739451
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5424196DFD9;
	Fri, 18 Sep 2026 13:50:51 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1762B433;
	Fri, 18 Sep 2026 13:50:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH 22/31] KVM: Take memory protections into account for accesses with cached gfn->hva
Date: Fri, 18 Sep 2026 09:50:21 -0400
Message-ID: <20260918135030.171564-23-pbonzini@redhat.com>
In-Reply-To: <20260918135030.171564-1-pbonzini@redhat.com>
References: <20260918135030.171564-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

Account for memory attributes when accessing guest memory through
kvm_get/put_guest().

This requires tracking the memory attributes generation as part of
gfn_to_hva_cache's data, invalidate the cached information if the
generation changes, and failing to refresh the cache if restrictive
memory attributes are found within the GPA range.

Similar to how gfn_to_hva_cache disallows caching gfns mapped within
read-only memory slots, gfns marked as read-only by memory attributes
will also fail to initialize. Unsurprisingly, the same behaviour applies
to gfns mapped as non-accessible (NR/NW), while non-executable mappings
are okay.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/kvm_host.h | 20 +++++++++++++++++---
 virt/kvm/kvm_main.c      | 15 +++++++++++----
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ab62ce37bc18..e9c0932f150e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1359,7 +1359,8 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	typeof(v) __user *__uaddr = (typeof(__uaddr))(__addr + offset);	\
 	int __ret = -EFAULT;						\
 									\
-	if (!kvm_is_error_hva(__addr))					\
+	if (!kvm_is_error_hva(__addr) &&                                \
+	    kvm_mem_attributes_may_read_gfn(kvm, gfn))		\
 		__ret = get_user(v, __uaddr);				\
 	__ret;								\
 })
@@ -1379,7 +1380,8 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	typeof(v) __user *__uaddr = (typeof(__uaddr))(__addr + offset);	\
 	int __ret = -EFAULT;						\
 									\
-	if (!kvm_is_error_hva(__addr))					\
+	if (!kvm_is_error_hva(__addr) &&                                \
+	    kvm_mem_attributes_may_write_gfn(kvm, gfn))		\
 		__ret = put_user(v, __uaddr);				\
 	if (!__ret)							\
 		mark_page_dirty(kvm, gfn);				\
@@ -2647,6 +2649,12 @@ static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn
 {
 	return 0;
 }
+static inline bool kvm_range_has_any_memory_attributes(struct kvm *kvm,
+						       gfn_t start, gfn_t end,
+						       unsigned long mask)
+{
+	return false;
+}
 static inline u64 kvm_mem_attributes_generation(struct kvm *kvm)
 {
 	return 0;
@@ -2667,6 +2675,13 @@ static inline int kvm_mem_attributes_may_write_gfn(struct kvm *kvm, gfn_t gfn)
 	return kvm_mem_attributes_may_write(attrs);
 }
 
+static inline bool kvm_range_has_rw_memory_protections(struct kvm *kvm,
+						       gfn_t start, gfn_t end)
+{
+	return kvm_range_has_any_memory_attributes(kvm, start, end,
+			KVM_MEMORY_ATTRIBUTE_NR | KVM_MEMORY_ATTRIBUTE_NW);
+}
+
 static inline bool kvm_memslots_check_gen(struct kvm *kvm, u64 slots_generation,
 					  u64 attrs_generation, struct kvm_memslots **p_slots)
 {
@@ -2682,7 +2697,6 @@ static inline bool kvm_check_gen(struct kvm *kvm, u64 slots_generation,
 	return kvm_memslots_check_gen(kvm, slots_generation, attrs_generation, &slots);
 }
 
-
 #ifdef CONFIG_KVM_GUEST_MEMFD
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c00410bb62a2..2045252bd9c9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3553,15 +3553,22 @@ static int __kvm_gfn_to_hva_cache_init(struct kvm *kvm,
 	 * If the requested region crosses two memslots, we still
 	 * verify that the entire region is valid here.
 	 */
-	for ( ; start_gfn <= end_gfn; start_gfn += nr_pages_avail) {
-		ghc->memslot = __gfn_to_memslot(slots, start_gfn);
-		ghc->hva = gfn_to_hva_many(ghc->memslot, start_gfn,
-					   &nr_pages_avail);
+	for (gfn_t gfn = start_gfn ; gfn <= end_gfn; gfn += nr_pages_avail) {
+		ghc->memslot = __gfn_to_memslot(slots, gfn);
+		ghc->hva = gfn_to_hva_many(ghc->memslot, gfn, &nr_pages_avail);
 		if (kvm_is_error_hva(ghc->hva))
 			return -EFAULT;
 	}
 
+	/*
+	 * RW memory attributes are incompatible with GHC. The RW protection
+	 * check has to happen after storing the generation number.
+	 */
 	ghc->attrs_generation = kvm_mem_attributes_generation(kvm);
+	if (kvm_range_has_rw_memory_protections(kvm, start_gfn, end_gfn + 1)) {
+		ghc->hva = KVM_HVA_ERR_BAD;
+		return -EFAULT;
+	}
 
 	/* Use the slow path for cross page reads and writes. */
 	if (nr_pages_needed == 1)
-- 
2.52.0


