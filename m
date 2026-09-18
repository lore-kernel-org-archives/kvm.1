Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADAD50E5A2
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739454; cv=none; b=q4OFX1dhlItsmIaIxKNrOfQwX276zz5ECK+mXxXyf2SCz7m6lMYikwUL9Gdvas775pUnofNQleeBJFi0jLaBKBUJh5JDhT0IcjKi2YDo7Eha9+LsvUPgGSSvVkcea5FuSniOi4Oj0Eea8sJQvuVS2rLPbgBFH8GI4O+0ZKA1TF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739454; c=relaxed/simple;
	bh=PDbhJnSJId/nHkHj+x63VXubJEYI1c0DioQfK3uXkPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DvTrcEYvrMDPB31VxiElbwfTSS3mliZTNmYrjGl5EX+LeHHM1la08ION5YXBb76N5q+2HwSJXnoDww12CehyjgKIqSveNtUVENp5fSWZe80DPVp48i2K4cPe6NU9CtUl30OIpE2VnyV9D2D0NVzeH0OxCN4hRvfmCzFaH/E0oGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqaCXrgI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqaCXrgI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789739451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VFgdxHE6+HrrZypJ8OgwWId3lIAfHbeaGvwUSKqkUU=;
	b=CqaCXrgIYtqZa5/UJMEHE/xiGVrCQmBI3vhB8+2dg0sZRlzmLH/IrrlbJFA4kCUTg6GHaI
	oogYCWuQne+8SesJh8ai7AQAhszrJfktW8Poz5UGNvg1GJ/zwy+pTBbOkjhEoxpc4lJAE+
	TzKxQjGfJ8Eswd/k1QSB9amWzJFOtL8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-DbsSG9W3M7e9QFi-nE7ttw-1; Fri,
 18 Sep 2026 09:50:47 -0400
X-MC-Unique: DbsSG9W3M7e9QFi-nE7ttw-1
X-Mimecast-MFC-AGG-ID: DbsSG9W3M7e9QFi-nE7ttw_1789739446
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6686A195E937;
	Fri, 18 Sep 2026 13:50:46 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BDF09433;
	Fri, 18 Sep 2026 13:50:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH 16/31] KVM: Take memory protections into account for memory read/write/fetch
Date: Fri, 18 Sep 2026 09:50:15 -0400
Message-ID: <20260918135030.171564-17-pbonzini@redhat.com>
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
---
 virt/kvm/kvm_main.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9fdec95ccce2..acf09059a1cd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3253,11 +3253,13 @@ static int next_segment(unsigned long len, int offset)
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
@@ -3265,6 +3267,11 @@ static int __kvm_read_guest_page(struct kvm_memory_slot *slot, gfn_t gfn,
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
+
+	attrs = kvm_get_memory_attributes(kvm, gfn);
+	if (attrs & attr)
+		return -EFAULT;
+
 	r = __copy_from_user(data, (void __user *)addr + offset, len);
 	if (r)
 		return -EFAULT;
@@ -3276,7 +3283,8 @@ int kvm_read_guest_page(struct kvm *kvm, gfn_t gfn, void *data, int offset,
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 
-	return __kvm_read_guest_page(slot, gfn, data, offset, len);
+	return __kvm_read_guest_page(kvm, slot, gfn, data, offset, len,
+				     KVM_MEMORY_ATTRIBUTE_NR);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_read_guest_page);
 
@@ -3285,7 +3293,8 @@ int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_read_guest_page(slot, gfn, data, offset, len);
+	return __kvm_read_guest_page(vcpu->kvm, slot, gfn, data, offset, len,
+				     KVM_MEMORY_ATTRIBUTE_NR);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest_page);
 
@@ -3294,7 +3303,8 @@ int kvm_vcpu_fetch_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_read_guest_page(slot, gfn, data, offset, len);
+	return __kvm_read_guest_page(vcpu->kvm, slot, gfn, data, offset, len,
+				     KVM_MEMORY_ATTRIBUTE_NX);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_fetch_guest_page);
 
@@ -3338,8 +3348,9 @@ int kvm_vcpu_read_guest(struct kvm_vcpu *vcpu, gpa_t gpa, void *data, unsigned l
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
@@ -3347,6 +3358,9 @@ static int __kvm_read_guest_atomic(struct kvm_memory_slot *slot, gfn_t gfn,
 	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
 		return -EFAULT;
 
+	if (!kvm_mem_attributes_may_read_gfn(kvm, gfn))
+		return -EFAULT;
+
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
@@ -3365,7 +3379,7 @@ int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa,
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 	int offset = offset_in_page(gpa);
 
-	return __kvm_read_guest_atomic(slot, gfn, data, offset, len);
+	return __kvm_read_guest_atomic(vcpu->kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest_atomic);
 
@@ -3383,6 +3397,10 @@ static int __kvm_write_guest_page(struct kvm *kvm,
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


