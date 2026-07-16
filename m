Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3135445AE1
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225719; cv=none; b=XnhS0A+ryRCDRLP+wawss9Ct13XIj6EgKwpH8sjdJE0N7HThQI/lfbt5gGNxtaIXW8EhidjTEImuF1G9KeRmBofrusvNSBqoSVIkFBbkhdm1NwbvsCWwLYQQsODeFoWdClbb+X6oUQp9/NvNtSGfAO0+T2G8JbTnXpSJmo7MNUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225719; c=relaxed/simple;
	bh=4gx87GDfWBQArS2ZGfXt/bxpjrLyyn9ZT0k59nikohw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axE4HX5SgVtynMNC4p/Fe37/UBydHvNtSFFyyUGZeZXnQos9pZ+OxhLbj7usbLDz+5E1dnOywJIs0Rc5FxRB30OWFtiwU1km4ztNgaj846IP8Il1CKBVcmjMcY/IlNajorKlMRabkFtgVBgIbyfF31a5NFrzBz0QnuYsEP17fqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgcNbtvr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgcNbtvr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YNOczln1vCwhatoD+84vy5EZHAV+CFehLYCLKBd8B4=;
	b=HgcNbtvr0MzxdWyOMCNzawa4uwN5BtdhMhK01XnLn8mcnJQBP6tYZG8dJoEFJjvFInYuD1
	3sftuXfsJ7kPrwNIBjbHY1DBlgnTu8kFjSwcd0OigJT4FG64iJm9mB1O7HVBpLwhqKoH2K
	BPVN8CRimvlcUiZtrOm9h8QZcQnBHuM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-uNaYeMmGMp6fg3Xgn7jveQ-1; Thu,
 16 Jul 2026 14:15:08 -0400
X-MC-Unique: uNaYeMmGMp6fg3Xgn7jveQ-1
X-Mimecast-MFC-AGG-ID: uNaYeMmGMp6fg3Xgn7jveQ_1784225707
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C85B41955F08;
	Thu, 16 Jul 2026 18:15:07 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58A341800480;
	Thu, 16 Jul 2026 18:15:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 15/24] KVM: Take memory protections into account for accesses with cached gfn->hva
Date: Thu, 16 Jul 2026 14:14:47 -0400
Message-ID: <20260716181456.402786-16-pbonzini@redhat.com>
In-Reply-To: <20260716181456.402786-1-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
 include/linux/kvm_host.h | 19 +++++++++++++++++--
 virt/kvm/kvm_main.c      | 15 +++++++++++----
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 1fad3eb303c1..71ab2cbecbd1 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1351,7 +1351,8 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	typeof(v) __user *__uaddr = (typeof(__uaddr))(__addr + offset);	\
 	int __ret = -EFAULT;						\
 									\
-	if (!kvm_is_error_hva(__addr))					\
+	if (!kvm_is_error_hva(__addr) &&                                \
+	    kvm_mem_attributes_may_read_gfn(kvm, gfn))		\
 		__ret = get_user(v, __uaddr);				\
 	__ret;								\
 })
@@ -1371,7 +1372,8 @@ int kvm_gfn_to_hva_cache_init(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	typeof(v) __user *__uaddr = (typeof(__uaddr))(__addr + offset);	\
 	int __ret = -EFAULT;						\
 									\
-	if (!kvm_is_error_hva(__addr))					\
+	if (!kvm_is_error_hva(__addr) &&                                \
+	    kvm_mem_attributes_may_write_gfn(kvm, gfn))		\
 		__ret = put_user(v, __uaddr);				\
 	if (!__ret)							\
 		mark_page_dirty(kvm, gfn);				\
@@ -2632,6 +2634,12 @@ static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn
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
@@ -2652,6 +2660,13 @@ static inline int kvm_mem_attributes_may_write_gfn(struct kvm *kvm, gfn_t gfn)
 	return kvm_mem_attributes_may_write(attrs);
 }
 
+static inline bool kvm_range_has_rw_memory_protections(struct kvm *kvm,
+						       gfn_t start, gfn_t end)
+{
+	return kvm_range_has_any_memory_attributes(kvm, start, end,
+			KVM_MEMORY_ATTRIBUTE_NR | KVM_MEMORY_ATTRIBUTE_NW);
+}
+
 #ifdef CONFIG_KVM_GUEST_MEMFD
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2fe4087319ad..a6fd17851c2f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3529,15 +3529,22 @@ static int __kvm_gfn_to_hva_cache_init(struct kvm *kvm,
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


