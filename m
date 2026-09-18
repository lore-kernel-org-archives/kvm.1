Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CFA4B04A4
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719372; cv=none; b=XWVPgYKeLrVeAQSjq7vqprrEnjXfCeqGzH/JiUsF1vQ1hpGTgcyd6gb/+CG9CWzD16Cs9elDsWNJu/03Gz6item/VqHhJMYASGN/yp5+1D9/GCj3Ghc7VJSr3cRaIhgztaVQB0yymWtfWg3MvZoqRQ8uzvvFqNqpdLBthqUgZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719372; c=relaxed/simple;
	bh=LG2/6fNzKM3D1tVIK83ssuQn0CPfTGoTKvQuc9FW7VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfMO1qODu/BAPYvA5K0l4Rh49k6b4UYHZhdyt8yrcaHYWEG+ZTpgF3i8vRhfEXcNX755eUI4ZBmW2YUq5szCpHQkdOX+TcsCKoNM5zBkE+jN/cKxW4bhS/fLoKQuwtBynGjBwIdbJyP6BHFlKP1tfjbfnQEwmj3Ui4FxL1GcHBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mso9vqeA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mso9vqeA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789719365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z7WjpcYWka36Pi/4Seg3ZdLwc3xMGEYD5XS7g2LXTR4=;
	b=Mso9vqeAx3oiZ4UghTvVsfkGDypvOa34Uuqc8FZAQBgTnPvlYbNgE9M0ujDdDHjIdiOROS
	bmpr0n+tf9qclQUCPrOAk358asAZYHEMiVVhh/+lnQBAnpudSzMzW7Gkmt9V5+he3N1Jp1
	Or6m4Lnme+TwBxc3oaslFAtxNP+qpfk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-4B6l90TEPqy0ch2d17d2bA-1; Fri,
 18 Sep 2026 04:16:02 -0400
X-MC-Unique: 4B6l90TEPqy0ch2d17d2bA-1
X-Mimecast-MFC-AGG-ID: 4B6l90TEPqy0ch2d17d2bA_1789719361
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4A69195419A;
	Fri, 18 Sep 2026 08:16:00 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 41CC130001A2;
	Fri, 18 Sep 2026 08:16:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH v2 19/28] KVM: Take memory protections into account for accesses with cached gfn->hva
Date: Fri, 18 Sep 2026 04:15:34 -0400
Message-ID: <20260918081543.139871-20-pbonzini@redhat.com>
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
index ea9f3e0625cb..24f46dce192e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3550,15 +3550,22 @@ static int __kvm_gfn_to_hva_cache_init(struct kvm *kvm,
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


