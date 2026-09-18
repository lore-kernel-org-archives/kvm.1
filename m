Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D314ABBC3
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719370; cv=none; b=eh90KTnqnvRyj+rFCWwuz77mwdoXnPQlwMDIGurmKwg55GFVo+vFB6m4ke1ykizJ+ALnKip3pJ3AdwEkyao6ve3JFDGJQS+89mi0pZhSA3lHKBWwlRvJgKgJlayj8ptUyGyUxic/9BRvLTaPndeV5Ue8FaAQ5GQeSum6A6FuvCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719370; c=relaxed/simple;
	bh=obeBnTSJ02v2RMdTMxsu9Fevk06HaAr7bV1BDU65XPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Flh6+Ppg/vcA+oJ5YOKkc31Gr5XSIwLu/WfyzdqPRQhQ5/W5cTeHlGm84O+P4boDz6j3OjpQayxqAUaLeHLEIL8c0CrAbUE717K5Ik6NCxeM+0ARM34kWD7fNIdcsIWT8P69jnHILzuajo114zPwNv483QeX0T4TSFH6Ll80olw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAB0sBjl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAB0sBjl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789719364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWfubM76ShOdscVreN61oLBluSMWPZIXXO7BhgwWri4=;
	b=eAB0sBjlFRltJ7M6eHsudTfPZ9VkxHjRKsP9UL34TenOdeFgl7cmUjrg8hqbiAmMDS0+xg
	SGItZVI2B8mcLCGh7skvq80Vb3ZLrQKeFIqs1WR9jaMzO/TyxleNNbXYqN4Pp/S0scjaAh
	01jtuk4wfCCP2vAOiIbJkxagxmUFInQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-TJRXpLzMPAqpsjV62D8SNw-1; Fri,
 18 Sep 2026 04:15:59 -0400
X-MC-Unique: TJRXpLzMPAqpsjV62D8SNw-1
X-Mimecast-MFC-AGG-ID: TJRXpLzMPAqpsjV62D8SNw_1789719358
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76D351944F03;
	Fri, 18 Sep 2026 08:15:58 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CCAE230001A2;
	Fri, 18 Sep 2026 08:15:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH v2 16/28] KVM: Encapsulate memattrs array into anonymous struct
Date: Fri, 18 Sep 2026 04:15:31 -0400
Message-ID: <20260918081543.139871-17-pbonzini@redhat.com>
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
index cddf0b943757..24d04322d89e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -875,8 +875,10 @@ struct kvm {
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
@@ -2592,7 +2594,7 @@ static inline bool kvm_mem_attributes_may_exec(u64 attrs)
 
 static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {
-	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
+	return xa_to_value(xa_load(&kvm->mem_attrs.array, gfn));
 }
 
 bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3932e526870a..994a33a09448 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1117,7 +1117,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 	rcuwait_init(&kvm->mn_memslots_update_rcuwait);
 	xa_init(&kvm->vcpu_array);
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
-	xa_init(&kvm->mem_attr_array);
+	xa_init(&kvm->mem_attrs.array);
 #endif
 
 	INIT_LIST_HEAD(&kvm->gpc_list);
@@ -1302,7 +1302,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
 	srcu_barrier(&kvm->srcu);
 	cleanup_srcu_struct(&kvm->srcu);
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
-	xa_destroy(&kvm->mem_attr_array);
+	xa_destroy(&kvm->mem_attrs.array);
 #endif
 	kvm_arch_free_vm(kvm);
 	preempt_notifier_dec();
@@ -2440,7 +2440,7 @@ u64 kvm_supported_mem_attributes(struct kvm *kvm)
 bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 				     unsigned long mask, unsigned long attrs)
 {
-	XA_STATE(xas, &kvm->mem_attr_array, start);
+	XA_STATE(xas, &kvm->mem_attrs.array, start);
 	unsigned long supported_attrs;
 	unsigned long index;
 	void *entry;
@@ -2581,7 +2581,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	 * partway through setting the new attributes.
 	 */
 	for (i = start; i < end; i++) {
-		r = xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
+		r = xa_reserve(&kvm->mem_attrs.array, i, GFP_KERNEL_ACCOUNT);
 		if (r)
 			goto out_unlock;
 
@@ -2591,7 +2591,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	kvm_handle_gfn_range(kvm, &pre_set_range);
 
 	for (i = start; i < end; i++) {
-		r = xa_err(xa_store(&kvm->mem_attr_array, i, entry,
+		r = xa_err(xa_store(&kvm->mem_attrs.array, i, entry,
 				    GFP_KERNEL_ACCOUNT));
 		KVM_BUG_ON(r, kvm);
 		cond_resched();
-- 
2.52.0


