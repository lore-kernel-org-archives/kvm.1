Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1619850E5AE
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739455; cv=none; b=li17LIZL24r2VtYn67aS0Gv/8XKtR4XPZ1mRljwVEeqhzzOF8SxCFt3nMAnzZlq2BGsuOp7DIM4Gn03xRvT5BbHRtURtifeOiD+1kE72Jqv6iTOckJZBYzs88C6NOdM+Jby8vArhukj7ggitPhVTiNhKkmSJFdjSySGfVSZZvYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739455; c=relaxed/simple;
	bh=dWEni+lybDuTEEoU3ZvQC/3fBdEtYZpASB8KU8+yBzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggdnZVvqYFtIoscYPS5+HdZWg5RD5zZIseroTjPryh5bFCuPam4XXINLR0cmdavVh8opm7lxqROjUHiIHg1pCrsjyUjjmnYb3dyL9/R5fz7Ddujnv66F4rDBI/3cOFxaBrhv6ta8qA5HWuJ0qOa1ap/Qny68lZ2wwsvMOZlOz8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIoO/fO3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIoO/fO3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789739451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHFBc6DkdwL++YN+CK5igi2dAqY5s581XWvNs5mlu+4=;
	b=TIoO/fO3O4Dd/qkdCPlkN0ik7vLXW7DBRzzQ8pXadL18WF6RJejmiPIhyJ6IjXhi7Ha7Z2
	VxzCTdETyHGN+sTUrcS/PzPeY7hTRV+Aul965zsDYuF0NwqOyAbw6IrHCfr2XIKh/7HBFO
	THkMag6eC4vuWSo6sKDNTaf+EZjjpTw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-xoqRtvytPxKyrovL4yI4Cg-1; Fri,
 18 Sep 2026 09:50:49 -0400
X-MC-Unique: xoqRtvytPxKyrovL4yI4Cg-1
X-Mimecast-MFC-AGG-ID: xoqRtvytPxKyrovL4yI4Cg_1789739448
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 241E1184B38C;
	Fri, 18 Sep 2026 13:50:48 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 673F2756;
	Fri, 18 Sep 2026 13:50:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH 18/31] KVM: Encapsulate memattrs array into anonymous struct
Date: Fri, 18 Sep 2026 09:50:17 -0400
Message-ID: <20260918135030.171564-19-pbonzini@redhat.com>
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
index 1d111502b8c1..b8e419fb6cbf 100644
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
@@ -2579,7 +2579,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	 * partway through setting the new attributes.
 	 */
 	for (i = start; i < end; i++) {
-		r = xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
+		r = xa_reserve(&kvm->mem_attrs.array, i, GFP_KERNEL_ACCOUNT);
 		if (r)
 			goto out_unlock;
 
@@ -2589,7 +2589,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	kvm_handle_gfn_range(kvm, &pre_set_range);
 
 	for (i = start; i < end; i++) {
-		r = xa_err(xa_store(&kvm->mem_attr_array, i, entry,
+		r = xa_err(xa_store(&kvm->mem_attrs.array, i, entry,
 				    GFP_KERNEL_ACCOUNT));
 		KVM_BUG_ON(r, kvm);
 		cond_resched();
-- 
2.52.0


