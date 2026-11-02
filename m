Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641518;
	b=0KTFlYfoV0AZaROqsq3VuCyBSLed2aJpXCp0ReAIuPq4XTWwB9Xv706oYJCoq8NRxbQm
	 77ca29s05Uk2ZKh/2ma4O9Mzl9PKHfYeKwQW9kFKVCI3EanEx6O84iIsrzRXYQbdymhQu
	 Q4XzzWjXa6Cqiq/5wbzmxwBaNor/fqz0IVB5z/wORzpZg6JvCg8uos5Bao/343v5LHsNG
	 4ZqCHnPqmrMBeNHm/ketSqFr+2Z8DZXSVKwnOj4XcZiyCqi2GGHFArluc8oFtUsTQd4AU
	 tMIX5j8hqGT/uq2gUdiCbGHAFQVn/HmkWIi+jAIV7OK9lgHmIJ37B7gnplFXnjVJAfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641518;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=ZCFslrxsWUENi7QdUYeo2A7Ui3X9hq3aD1lq/gZJXjc=;
	b=BtmVMQrbyzCZjfQcBHkYxa7Wo26EWkzzqlpG3Y7Gju4tk5DU3C73NWYQDqO4rFEvhLJK
	 GDJot7+0wfgU5HoAuHE23R0rGHGGRXIgMaNd1CFUDWSr+crGziIVaqs0FF0Lnr0OIjf+J
	 w0JRO6XYOHeO4c3ST8f+AI+5BCnTkiWBhHI3gu/IcI3FKSeiLV9PyZfeGKs+eZJ8VvuTB
	 IrKzUORCZo2H84XQ83QYkG9F8QdIRvZQk6oh2PGr9N2AjpQRcSTSCxbKW731Wu7xDUImQ
	 5z38dK78e8FEn6askzvhKmCWE+dTUrW1aJuXsp7yhYgYeQQUUaYNHHjtQ4wZKKm09Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E1VGK6ry;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E98606D828
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4E98606D828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E1VGK6ry
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZCFslrxsWUENi7QdUYeo2A7Ui3X9hq3aD1lq/gZJXjc=;
	b=E1VGK6ryWQ+lEtdKDirQtx3+zXpcj70Qv+xYQGUngBaUzDAZWgFzlMmFOSvwwf/77Uznzi
	BU+fMQ/6BFIbjMml/CeY8DxFB3hdHaPgg3Wa9WT57NQShF+noBm1SUiYmUCWkBDY/4GoII
	U4CUkjZQf77FlZDmXFrft2RsB4xdOR0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-U-oHoFtTNyaDw4CKU-EeOA-1; Mon,
 02 Nov 2026 12:45:15 -0500
X-MC-Unique: U-oHoFtTNyaDw4CKU-EeOA-1
X-Mimecast-MFC-AGG-ID: U-oHoFtTNyaDw4CKU-EeOA_1793641514
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B8A11800674;
	Mon,  2 Nov 2026 17:45:14 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EBA5D1956087;
	Mon,  2 Nov 2026 17:45:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 18/45] KVM: Include memory protections in result of gfn->hva conversion
Date: Mon,  2 Nov 2026 12:44:45 -0500
Message-ID: <20261102174512.8903-2-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
Link: https://patch.msgid.link/20260918135030.171564-15-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/kvm_host.h | 19 ++++++++++++++
 virt/kvm/kvm_main.c      | 55 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 8442fb29a1ee..3791e4290742 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2623,6 +2623,11 @@ static inline u64 kvm_supported_vm_mem_attributes(struct kvm *kvm)
 {
 	return 0;
 }
+
+static inline unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
+{
+	return 0;
+}
 #endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
 #ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
@@ -2653,6 +2658,20 @@ static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
 }
 #endif /* kvm_arch_has_private_mem */
 
+static inline int kvm_mem_attributes_may_read_gfn(struct kvm *kvm, gfn_t gfn)
+{
+	unsigned long attrs = kvm_get_vm_memory_attributes(kvm, gfn);
+
+	return kvm_mem_attributes_may_read(attrs);
+}
+
+static inline int kvm_mem_attributes_may_write_gfn(struct kvm *kvm, gfn_t gfn)
+{
+	unsigned long attrs = kvm_get_vm_memory_attributes(kvm, gfn);
+
+	return kvm_mem_attributes_may_write(attrs);
+}
+
 #ifdef CONFIG_KVM_GUEST_MEMFD
 bool kvm_gmem_is_private_gfn(struct kvm *kvm, gfn_t gfn);
 bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 717d7aec9a6c..d3f074d7fd6f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2874,13 +2874,38 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(gfn_to_hva_memslot);
 
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
 
@@ -2906,15 +2931,37 @@ unsigned long gfn_to_hva_memslot_prot(struct kvm_memory_slot *slot,
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
+	if (writable && !kvm_mem_attributes_may_write_gfn(kvm, gfn))
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
+	if (writable && !kvm_mem_attributes_may_write_gfn(vcpu->kvm, gfn))
+		*writable = false;
+
+	return addr;
 }
 
 static bool kvm_is_ad_tracked_page(struct page *page)
-- 
2.52.0


