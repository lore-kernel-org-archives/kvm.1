Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641522;
	b=ygQrpATeEsGxZPy8ApVJSjFkWMdIcFZlVX5n6qzqzzcAfShfzUPaIwOB2VeoAjymrZH0
	 erGIjT9pzxWsZvH+w1j/Ew8qdNj0KSndYCq8ehOb2S/Z/fIGxzqpWTJywxdbAxuTGyRHo
	 ejuzlfkVNnLsaWEBitgKdmXjvf7gTrhelfK660KzX8pj/tzg5wGLExdIS65NJkDqfdKV9
	 bWTqWPJuzUsw+JnRuL9u4fbpc7xSDpy9WWPlO9NuLm//jke9X1EozIX22l6J8yMi5CgXu
	 eyizoX1xM3b14Hn8IEPjGc19PKS1cwyeH0ff3ZVluga48BA7Mx8HBdurwrQoIZXbilQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641522;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=yaKAU6Ow7XUYCqR9G0iHJRFxDv4tOlXe6ZZRKBhpn4A=;
	b=5eFdDVKkc79nfGT3i/qEcuKZSFOC35c7suHqEPbRE/+H4PUfSuDoaFKk1m67e8sXX42s
	 jTYV3aesoxXiGwR6sIz9ILAfgXRcjHiOMorlzMwMaBCyVnUgUwLLXs3ue7qpSfWzT9kwq
	 06xcSatGeoYOzBzVJwe1w4H7A6AeTQ5fclCFjs51t4ECxLlOsqx6L4nyLHmsALLDaibjQ
	 ymTkqYIChbJ+mfCBb1xFMZUuPcXAZCEMlQCCxzvlUXFscI++y7DRTsVwthGDWVG4F71NU
	 +Op5SfkCIMM4NXMsCBL1mcyw2Uze8ihpC6k1h92ronnXiEvkXnqu029Gb/cPgqrqZsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cx+huYkY;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9CF606E03A
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE9CF606E03A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cx+huYkY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yaKAU6Ow7XUYCqR9G0iHJRFxDv4tOlXe6ZZRKBhpn4A=;
	b=Cx+huYkYiiirOuyuoStIEHbVy0bh7GbtKs7J3IH32InpDGZFlvMs5HefaIOhA2KZchPBVG
	OuNkj83CQMdvkhncIJbQ1DsfAfN/EGsAurUwIrW5rGhSKqGwT0wuzPrgTgabNXEMquozTm
	roIJLnUtXA+6ekO75+iUvPLpUvOwOv0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-1HrbbgwANhGSxTtZ-qfKRg-1; Mon,
 02 Nov 2026 12:45:16 -0500
X-MC-Unique: 1HrbbgwANhGSxTtZ-qfKRg-1
X-Mimecast-MFC-AGG-ID: 1HrbbgwANhGSxTtZ-qfKRg_1793641515
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA5871956064;
	Mon,  2 Nov 2026 17:45:15 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36FC71956087;
	Mon,  2 Nov 2026 17:45:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 20/45] KVM: Take memory protections into account for memory read/write/fetch
Date: Mon,  2 Nov 2026 12:44:47 -0500
Message-ID: <20261102174512.8903-4-pbonzini@redhat.com>
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

Take into account memory attributes when accessing guest memory through
the kvm_{read,write,fetch}*() family of functions.

All of these pass a struct kvm_memory_slot pointer to the actual
workhorse functions, in order to share code between the VM-wide and
vCPU-specific version of the functions (the latter of which handles the
multi-address-space case).  For this reason they need specific changes
and do not work even though the gfn_to_hva() path has been taught already
about memory protection attributes.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-17-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/kvm_main.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 41818ed5eb3a..de54f52f2158 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3362,11 +3362,13 @@ static int next_segment(unsigned long len, int offset)
 }
 
 /* Copy @len bytes from guest memory at '(@gfn * PAGE_SIZE) + @offset' to @data */
-static int __kvm_read_guest_page(struct kvm_memory_slot *slot, gfn_t gfn,
-				 void *data, int offset, int len)
+static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot *slot,
+				 gfn_t gfn, void *data, int offset, int len,
+				 unsigned long attr)
 {
 	int r;
 	unsigned long addr;
+	unsigned long attrs;
 
 	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
 		return -EFAULT;
@@ -3374,6 +3376,11 @@ static int __kvm_read_guest_page(struct kvm_memory_slot *slot, gfn_t gfn,
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
+
+	attrs = kvm_get_vm_memory_attributes(kvm, gfn);
+	if (attrs & attr)
+		return -EFAULT;
+
 	r = __copy_from_user(data, (void __user *)addr + offset, len);
 	if (r)
 		return -EFAULT;
@@ -3385,7 +3392,8 @@ int kvm_read_guest_page(struct kvm *kvm, gfn_t gfn, void *data, int offset,
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 
-	return __kvm_read_guest_page(slot, gfn, data, offset, len);
+	return __kvm_read_guest_page(kvm, slot, gfn, data, offset, len,
+				     KVM_MEMORY_ATTRIBUTE_NR);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_read_guest_page);
 
@@ -3394,7 +3402,8 @@ int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_read_guest_page(slot, gfn, data, offset, len);
+	return __kvm_read_guest_page(vcpu->kvm, slot, gfn, data, offset, len,
+				     KVM_MEMORY_ATTRIBUTE_NR);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest_page);
 
@@ -3403,7 +3412,8 @@ int kvm_vcpu_fetch_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_read_guest_page(slot, gfn, data, offset, len);
+	return __kvm_read_guest_page(vcpu->kvm, slot, gfn, data, offset, len,
+				     KVM_MEMORY_ATTRIBUTE_NX);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_fetch_guest_page);
 
@@ -3447,8 +3457,9 @@ int kvm_vcpu_read_guest(struct kvm_vcpu *vcpu, gpa_t gpa, void *data, unsigned l
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest);
 
-static int __kvm_read_guest_atomic(struct kvm_memory_slot *slot, gfn_t gfn,
-			           void *data, int offset, unsigned long len)
+static int __kvm_read_guest_atomic(struct kvm *kvm,
+				   struct kvm_memory_slot *slot, gfn_t gfn,
+				   void *data, int offset, unsigned long len)
 {
 	int r;
 	unsigned long addr;
@@ -3456,6 +3467,9 @@ static int __kvm_read_guest_atomic(struct kvm_memory_slot *slot, gfn_t gfn,
 	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
 		return -EFAULT;
 
+	if (!kvm_mem_attributes_may_read_gfn(kvm, gfn))
+		return -EFAULT;
+
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
@@ -3474,7 +3488,7 @@ int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa,
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 	int offset = offset_in_page(gpa);
 
-	return __kvm_read_guest_atomic(slot, gfn, data, offset, len);
+	return __kvm_read_guest_atomic(vcpu->kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest_atomic);
 
@@ -3492,6 +3506,10 @@ static int __kvm_write_guest_page(struct kvm *kvm,
 	addr = gfn_to_hva_memslot(memslot, gfn);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
+
+	if (!kvm_mem_attributes_may_write_gfn(kvm, gfn))
+		return -EFAULT;
+
 	r = __copy_to_user((void __user *)addr + offset, data, len);
 	if (r)
 		return -EFAULT;
-- 
2.52.0


