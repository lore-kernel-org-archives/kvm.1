Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641522;
	b=UZ2Dw+wbTwTEOd2Ar6DcKkYBWpNIAttHzRrW/IT2c2Y9jFeO1cKK7uRgUtcMPNgZoXra
	 5Eqvb2CLhKmTfHMLgnPPiec3SRMAsAGxT2g0SjH/FboOI4LRGzMutrYX96QVZ9NcLIUUJ
	 5pbInWIz7EHIcGQWqXE7cpNz85b73LgdYMItxJArmdbWcSj3OyhT2ry8+zJ+eMZqIK2dw
	 SPXzIi/ApeqR/dIsi8UMxT/r3TFBfgHNG7GUIddOJfUz8GH3qxzOhDzw3dlJ+qoVqLFTd
	 d7ip6WhIUSWCOrZRQMg/F7+rZFpHZK0mZmWyng7s6/H8pAerq1sKao990XZk8P/L8Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641522;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=2r8eubFmvp9jwY6M2KhztrbWPT112O9jaAuVTtb9jAk=;
	b=HHpm/V64qHYEuXggT7UuWiByt6T7piKPhljvOHuktO7X0TfjkPkacV69OZY5q4deYFCV
	 a5+lDNsjlaIiNhVoKYyOXA27QSAp2/AnPVTgTCFF3QXdkSRUxgLirQ0uW8BRq/cgineqg
	 wATnAJLtbEbQ4DswCNM1Dttp4jOgHJBR/cPtcL2a+bp/SGwJYC1dNTPvodKUnq7s75Hlp
	 +PcnEjn+QthEv1Jo5LpEsYiUlQ4H4im4KdsaQVyGNANq9jSrhQQ1JP+/wDd0qNasyKddm
	 EF/9L0HuwUAl/6mVnaWSaPMW7wgR7Q0tdRzf+iHjjPl1nYpCCqp+DsBC+YN9g3wvQLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uwhw6Slh;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C1A6087601
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9C1A6087601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uwhw6Slh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2r8eubFmvp9jwY6M2KhztrbWPT112O9jaAuVTtb9jAk=;
	b=Uwhw6SlhXqEcMW8r/YcGx50SlCdRPlu6w0+p90q3jH0QrkPX6scdC2+i12yX/7OeXVDsbj
	XfpIJUcFvhqkXCpZwFEPX0iREfJBTjkTjbz/F8X7LcraBmmA108+E4tIaKMsgGv16nHR3j
	v9RRvYY9Al3gJOI5WVXC0JP/tM85cEQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-b_GAFknNNdex6iDpLfwtzQ-1; Mon,
 02 Nov 2026 12:45:18 -0500
X-MC-Unique: b_GAFknNNdex6iDpLfwtzQ-1
X-Mimecast-MFC-AGG-ID: b_GAFknNNdex6iDpLfwtzQ_1793641517
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00B2B1956070;
	Mon,  2 Nov 2026 17:45:17 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7FAAA1956087;
	Mon,  2 Nov 2026 17:45:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 22/45] KVM: Encapsulate memattrs array into anonymous struct
Date: Mon,  2 Nov 2026 12:44:49 -0500
Message-ID: <20261102174512.8903-6-pbonzini@redhat.com>
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

The metadata surrounding memory attributes is about to grow, so
encapsulate the memory attributes array within an anonymous struct to
provide namespacing.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-19-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/kvm_host.h |  8 +++++---
 virt/kvm/kvm_main.c      | 10 +++++-----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 1974cd8d361f..4a1985fe2737 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -876,8 +876,10 @@ struct kvm {
 	struct notifier_block pm_notifier;
 #endif
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
-	/* Protected by slots_lock (for writes) and RCU (for reads) */
-	struct xarray mem_attr_array;
+	struct {
+		/* Protected by slots_lock (for writes) and RCU (for reads) */
+		struct xarray array;
+	} mem_attrs;
 #endif
 	char stats_id[KVM_STATS_NAME_SIZE];
 };
@@ -2609,7 +2611,7 @@ static inline bool kvm_mem_attributes_may_exec(u64 attrs)
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static inline unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {
-	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
+	return xa_to_value(xa_load(&kvm->mem_attrs.array, gfn));
 }
 
 bool kvm_vm_mem_attributes_valid(struct kvm *kvm, unsigned long attrs);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c7b8d1bcf893..635730b5930c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1135,7 +1135,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
 	xa_init(&kvm->vcpu_array);
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
-	xa_init_flags(&kvm->mem_attr_array, XA_FLAGS_ACCOUNT);
+	xa_init_flags(&kvm->mem_attrs.array, XA_FLAGS_ACCOUNT);
 #endif
 
 	INIT_LIST_HEAD(&kvm->gpc_list);
@@ -1320,7 +1320,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	srcu_barrier(&kvm->srcu);
 	cleanup_srcu_struct(&kvm->srcu);
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
-	xa_destroy(&kvm->mem_attr_array);
+	xa_destroy(&kvm->mem_attrs.array);
 #endif
 	kvm_arch_free_vm(kvm);
 	preempt_notifier_dec();
@@ -2504,7 +2504,7 @@ u64 kvm_supported_vm_mem_attributes(struct kvm *kvm)
 bool kvm_range_has_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 					unsigned long mask, unsigned long attrs)
 {
-	XA_STATE(xas, &kvm->mem_attr_array, start);
+	XA_STATE(xas, &kvm->mem_attrs.array, start);
 	unsigned long supported_attrs;
 	unsigned long index;
 	void *entry;
@@ -2668,7 +2668,7 @@ static int kvm_set_vm_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	 * allocates, so no reservations are needed when clearing.
 	 */
 	for (i = start; entry && i < end; i++) {
-		r = xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
+		r = xa_reserve(&kvm->mem_attrs.array, i, GFP_KERNEL_ACCOUNT);
 		if (r)
 			goto out_unlock;
 
@@ -2678,7 +2678,7 @@ static int kvm_set_vm_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	kvm_handle_gfn_range(kvm, &pre_set_range);
 
 	for (i = start; i < end; i++) {
-		r = xa_err(xa_store(&kvm->mem_attr_array, i, entry,
+		r = xa_err(xa_store(&kvm->mem_attrs.array, i, entry,
 				    GFP_KERNEL_ACCOUNT));
 		KVM_BUG_ON(r, kvm);
 		cond_resched();
-- 
2.52.0


