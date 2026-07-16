Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE9B446057
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225728; cv=none; b=gc86lnArtEnmKxDO7YVvyxHAVSnULIl+GXZnZZsdJrNFe3kLrd/fFAUD1BI/3wtQHwYNXUqScTuKdv+KDtv6lh2l007oZ9g9zce9atF3J7jNXT+KI33dcWfVXN763fTKE1bJhkxugM+w0Vt2uMElEQQJ/PyW3gWOdG6baWT3fWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225728; c=relaxed/simple;
	bh=RbB7+rV+Unnkg8P9NDzl3Ie4WCg1IS/jJMOdDDxS3Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VP2ESeLpdjYY3/rsabavUPru583AZUzrZRIWhdKd0+Ok+RQHAATZtqdAbNH+tMNXK7QNiD11I6rfII1sZp2xTXhTeuEwuzZxqa720tQtN7p32TknGaaljTSgABVasa/fn/043KNUPuM6ByONaUWLHDo8sbxsj1aOsre5MB55+c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SzXMejXn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzXMejXn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tw1WPOSN+5h2YK/GVlX7f0rfZxbYC8aN2XeVHPaNYxU=;
	b=SzXMejXneCJGPqFQAZ+LJ0HN2wdYZNXyN+oXM1hYXIG4poQJTmNGSiBWPGl1NWkOsYKI7s
	nRkAmkMj/wyo1WVIDtCky0WHzmZDJGd/TV5VacoWs41cHducqLaZ8+/DcDzlR7UqzZxQOC
	PMOwemvN1hlVS+uVNWr1oScGtk6+Q30=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-Z8Gc3n8-M_iYNGzGbcFgEg-1; Thu,
 16 Jul 2026 14:15:06 -0400
X-MC-Unique: Z8Gc3n8-M_iYNGzGbcFgEg-1
X-Mimecast-MFC-AGG-ID: Z8Gc3n8-M_iYNGzGbcFgEg_1784225704
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B64181800672;
	Thu, 16 Jul 2026 18:15:04 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 481AB1800480;
	Thu, 16 Jul 2026 18:15:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 10/24] KVM: Include memory protections in result of gfn->hva conversion
Date: Thu, 16 Jul 2026 14:14:42 -0400
Message-ID: <20260716181456.402786-11-pbonzini@redhat.com>
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

All paths that lead to guest memory accesses now need to check whether
memory attributes allow that access.  Users of gfn_to_hva,
kvm_vcpu_gfn_to_hva and their *_prot variant can get it more or
less for free via erroneous return values, so do this first.

Note however that this is not true of the variants that take a cached
kvm_memslots pointer.  These include caches (gfn-to-hva and gfn-to-pfn)
and page faults, both of which will need specific changes; but the more
optimized functions in virt/kvm/kvm_main.c such as kvm_read_guest()
and kvm_write_guest() also retrieve the memslot high in the call chain,
and therefore they will need changes in __kvm_read/write_guest_page().

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/kvm_host.h | 18 +++++++++++++
 virt/kvm/kvm_main.c      | 55 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2dd1b65799e4..f10ab70b99dc 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2593,8 +2593,26 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 {
 	return false;
 }
+static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
+{
+	return 0;
+}
 #endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
 
+static inline int kvm_mem_attributes_may_read_gfn(struct kvm *kvm, gfn_t gfn)
+{
+	unsigned long attrs = kvm_get_memory_attributes(kvm, gfn);
+
+	return kvm_mem_attributes_may_read(attrs);
+}
+
+static inline int kvm_mem_attributes_may_write_gfn(struct kvm *kvm, gfn_t gfn)
+{
+	unsigned long attrs = kvm_get_memory_attributes(kvm, gfn);
+
+	return kvm_mem_attributes_may_write(attrs);
+}
+
 #ifdef CONFIG_KVM_GUEST_MEMFD
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a47b62c2c9ce..56016aab0aad 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2764,13 +2764,38 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(gfn_to_hva_memslot);
 
 unsigned long gfn_to_hva(struct kvm *kvm, gfn_t gfn)
 {
-	return gfn_to_hva_many(gfn_to_memslot(kvm, gfn), gfn, NULL);
+	unsigned long addr;
+
+	addr = gfn_to_hva_many(gfn_to_memslot(kvm, gfn), gfn, NULL);
+	if (kvm_is_error_hva(addr))
+		return addr;
+
+	if (!kvm_mem_attributes_may_read_gfn(kvm, gfn))
+		return KVM_HVA_ERR_BAD;
+
+	if (!kvm_mem_attributes_may_write_gfn(kvm, gfn))
+		return KVM_HVA_ERR_RO_BAD;
+
+	return addr;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(gfn_to_hva);
 
 unsigned long kvm_vcpu_gfn_to_hva(struct kvm_vcpu *vcpu, gfn_t gfn)
 {
-	return gfn_to_hva_many(kvm_vcpu_gfn_to_memslot(vcpu, gfn), gfn, NULL);
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long addr;
+
+	addr = gfn_to_hva_many(kvm_vcpu_gfn_to_memslot(vcpu, gfn), gfn, NULL);
+	if (kvm_is_error_hva(addr))
+		return addr;
+
+	if (!kvm_mem_attributes_may_read_gfn(kvm, gfn))
+		return KVM_HVA_ERR_BAD;
+
+	if (!kvm_mem_attributes_may_write_gfn(kvm, gfn))
+		return KVM_HVA_ERR_RO_BAD;
+
+	return addr;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_gfn_to_hva);
 
@@ -2796,15 +2821,37 @@ unsigned long gfn_to_hva_memslot_prot(struct kvm_memory_slot *slot,
 unsigned long gfn_to_hva_prot(struct kvm *kvm, gfn_t gfn, bool *writable)
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
+	unsigned long addr;
 
-	return gfn_to_hva_memslot_prot(slot, gfn, writable);
+	addr = gfn_to_hva_memslot_prot(slot, gfn, writable);
+	if (kvm_is_error_hva(addr))
+		return addr;
+
+	if (!kvm_mem_attributes_may_read_gfn(kvm, gfn))
+		return KVM_HVA_ERR_BAD;
+
+	if (!kvm_mem_attributes_may_write_gfn(kvm, gfn))
+		*writable = false;
+
+	return addr;
 }
 
 unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn, bool *writable)
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
+	unsigned long addr;
 
-	return gfn_to_hva_memslot_prot(slot, gfn, writable);
+	addr = gfn_to_hva_memslot_prot(slot, gfn, writable);
+	if (kvm_is_error_hva(addr))
+		return addr;
+
+	if (!kvm_mem_attributes_may_read_gfn(vcpu->kvm, gfn))
+		return KVM_HVA_ERR_BAD;
+
+	if (!kvm_mem_attributes_may_write_gfn(vcpu->kvm, gfn))
+		*writable = false;
+
+	return addr;
 }
 
 static bool kvm_is_ad_tracked_page(struct page *page)
-- 
2.52.0


