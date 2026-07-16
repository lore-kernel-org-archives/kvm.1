Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962A7445AF8
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225722; cv=none; b=tUXpGEnOCTztpGzGWlosj9KelsKfjzt3jU+SUXqBudSfOtYBnoX5QY1eJ2L07uESEQmUTqCVzGyX4Z/0eqOhHFZ8gx7AJ9kG7uGKEqWXkPyX/vOvqGlBTT9+a+tVng/6Z2MlXCbKMrNMV1ec/Ri9DPNzisUc/VpsTkp9+yPCaPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225722; c=relaxed/simple;
	bh=xDYSoUPrA5BnWA99MVHEfmO3r+n0ypDkoYPnNjV4p/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eO79EGByhUPUaTBP52lwMgNsqRR8bey0xvakDw0Z9shAZAQiuodgrtWJH1uSq500956JRW7GlLSGkjt2D7xWSkjpxWuoWiVFur3X2P9Z5cxPa5TGtab5ySh79aU+MyLhSInmA7e10KrGitTNo5LgqEJyvjdOnQbUJO0wzRMGyAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQS7xIFV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQS7xIFV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Bf3DEj+Rm6QGcYhGWBRVx8rQIjklskExWGYebe9dcE=;
	b=RQS7xIFVUiUpYjR5zbg8WToBSNOd24vPrcoRGDwkO4Gisi0u0gnkJRjl6VNjFM53GWXUKN
	xuQ6hqg00Uf09dtErRdHvztNsayQ6l9OYiCXRgB7u9FF5iXBnT1FqmuuWlu9QFyD5IAatR
	XRqsSWXT869PcOBSzZFsP+S3alEaWzQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-YhdexhexMWi-kTv2A0JlMg-1; Thu,
 16 Jul 2026 14:15:07 -0400
X-MC-Unique: YhdexhexMWi-kTv2A0JlMg-1
X-Mimecast-MFC-AGG-ID: YhdexhexMWi-kTv2A0JlMg_1784225706
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEFD81955F30;
	Thu, 16 Jul 2026 18:15:05 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7F4641800480;
	Thu, 16 Jul 2026 18:15:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 12/24] KVM: Encapsulate memattrs array into anonymous struct
Date: Thu, 16 Jul 2026 14:14:44 -0400
Message-ID: <20260716181456.402786-13-pbonzini@redhat.com>
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

The metadata surrounding memory attributes is about to grow, so
encapsulate the memory attributes array within an anonymous struct to
provide namespacing.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/kvm_host.h |  8 +++++---
 virt/kvm/kvm_main.c      | 10 +++++-----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f10ab70b99dc..341f2e97f3cb 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -874,8 +874,10 @@ struct kvm {
 	struct notifier_block pm_notifier;
 #endif
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
-	/* Protected by slots_lock (for writes) and RCU (for reads) */
-	struct xarray mem_attr_array;
+	struct {
+		/* Protected by slots_lock (for writes) and RCU (for reads) */
+		struct xarray array;
+	} mem_attrs;
 #endif
 	char stats_id[KVM_STATS_NAME_SIZE];
 };
@@ -2563,7 +2565,7 @@ static inline bool kvm_mem_attributes_may_exec(u64 attrs)
 
 static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {
-	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
+	return xa_to_value(xa_load(&kvm->mem_attrs.array, gfn));
 }
 
 bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d920ce5b6739..20113069562e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1116,7 +1116,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
 	xa_init(&kvm->vcpu_array);
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
-	xa_init(&kvm->mem_attr_array);
+	xa_init(&kvm->mem_attrs.array);
 #endif
 
 	INIT_LIST_HEAD(&kvm->gpc_list);
@@ -1301,7 +1301,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	srcu_barrier(&kvm->srcu);
 	cleanup_srcu_struct(&kvm->srcu);
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
-	xa_destroy(&kvm->mem_attr_array);
+	xa_destroy(&kvm->mem_attrs.array);
 #endif
 	kvm_arch_free_vm(kvm);
 	preempt_notifier_dec();
@@ -2439,7 +2439,7 @@ u64 kvm_supported_mem_attributes(struct kvm *kvm)
 bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 				     unsigned long mask, unsigned long attrs)
 {
-	XA_STATE(xas, &kvm->mem_attr_array, start);
+	XA_STATE(xas, &kvm->mem_attrs.array, start);
 	unsigned long index;
 	void *entry;
 
@@ -2578,7 +2578,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	 * partway through setting the new attributes.
 	 */
 	for (i = start; i < end; i++) {
-		r = xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
+		r = xa_reserve(&kvm->mem_attrs.array, i, GFP_KERNEL_ACCOUNT);
 		if (r)
 			goto out_unlock;
 
@@ -2588,7 +2588,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	kvm_handle_gfn_range(kvm, &pre_set_range);
 
 	for (i = start; i < end; i++) {
-		r = xa_err(xa_store(&kvm->mem_attr_array, i, entry,
+		r = xa_err(xa_store(&kvm->mem_attrs.array, i, entry,
 				    GFP_KERNEL_ACCOUNT));
 		KVM_BUG_ON(r, kvm);
 		cond_resched();
-- 
2.52.0


