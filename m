Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC9828AB0B
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 03:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779681219; cv=none; b=dR/2pO4/o10OWW6gf9ASyJpVvqpVnrNXNj7AgN6OzmYoPKC6y9XlavfjLLwUZBJyuEhTBUM61TRiTu1eRfkuLzQewsZTN1GKw2LnH2t27/pvBKLqR9cxlSBEU4pEYxA0Tt2brdYz2rICPkdxlcIkuQzh+6xIdqv8eXLK/fp2RUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779681219; c=relaxed/simple;
	bh=W14QzTEmgS7txRHie+hykoF5Exd1rZ2OiFjnZhFVMEw=;
	h=In-Reply-To:Cc:Message-Id:To:Date:Mime-Version:Content-Type:From:
	 References:Subject; b=FaKf4D9nqvqTT1VKJfXDCTD4rBrTin9qiSCFh4xIRsJGj5zmkXtKq6+AN1NsbcFRWt7MmWRvHDHW9JZp/dv+Bmekq1YlBneqVf7c+nuANNC6lnPI5wzn/6YIQpcWUPUcopMRHGMLGIWKOradeGL1RdSwTzBNzqpJHuX0T29WYCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ma0r5BGD; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ma0r5BGD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779681207; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=+3K4IdquGq/BMUbnEB+09u+6AMSIKA8C4cO77IXdWME=;
 b=Ma0r5BGDnx/ChIa7Z+zLb7/Pd7+ajhp4jjUqGNIhjen+hjotJ/N8uRR7DDOdKxAXkyMb75
 9t+zJ3sfzetBRjm6Xj+VIDKdwJuCnH/D4dIcTb4MK9+YYRbb2u/BTIcPshb4zhI6nK8gWK
 /Ecq9fBUT+4afqLBrFsNXEy99tz1jYscZ36zOcYvGxO8f1R4klySrLiC4vKvUrvyo+0iCw
 Bf7I4f6o6c8m346mAglu03LuP1YfUJKV1OBulWXqo+/O5KOjpiUqlcJrmMUFHdYVFWs1zC
 w2LWf3eV/pn9Cpb6HuC2ulA99jhRDIdWdxFKnaSaO+E1eZGpMxfq8Fc2KJNU5Q==
In-Reply-To: <20260525035242.107264-1-yanfei.xu@bytedance.com>
X-Lms-Return-Path: <lba+26a13c7b5+523f22+vger.kernel.org+yanfei.xu@bytedance.com>
Cc: <kvm@vger.kernel.org>, <caixiangfeng@bytedance.com>, 
	<fangying.tommy@bytedance.com>, <yanfei.xu@bytedance.com>, 
	<isyanfei.xu@gmail.com>
Message-Id: <20260525035242.107264-3-yanfei.xu@bytedance.com>
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>
Date: Mon, 25 May 2026 11:52:42 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.20.1
Content-Type: text/plain; charset=UTF-8
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
References: <20260525035242.107264-1-yanfei.xu@bytedance.com>
Subject: [v3 2/2] KVM: irqchip: Cache IRQ routing entries allocation

Cache one VM-local entries[] allocation from a freed IRQ
routing table and reuse it when the next routing update
needs the same allocation size.

This reduces repeated allocation/free churn for frequent
KVM_SET_GSI_ROUTING updates without changing the existing
SRCU lifetime rules. Because cached entries are reused
without being zeroed, initialize the remaining MSI fields
on x86, LoongArch and PowerPC.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
---
 arch/loongarch/kvm/irqfd.c |  2 ++
 arch/powerpc/kvm/mpic.c    |  2 ++
 arch/x86/kvm/irq.c         |  2 ++
 include/linux/kvm_host.h   |  6 ++++
 virt/kvm/irqchip.c         | 61 ++++++++++++++++++++++++++++++++++----
 5 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/kvm/irqfd.c b/arch/loongarch/kvm/irqfd.c
index f4f953b22419..15cc80cde071 100644
--- a/arch/loongarch/kvm/irqfd.c
+++ b/arch/loongarch/kvm/irqfd.c
@@ -60,6 +60,8 @@ int kvm_set_routing_entry(struct kvm *kvm,
 		e->msi.address_lo = ue->u.msi.address_lo;
 		e->msi.address_hi = ue->u.msi.address_hi;
 		e->msi.data = ue->u.msi.data;
+		e->msi.flags = ue->flags;
+		e->msi.devid = ue->u.msi.devid;
 		return 0;
 	default:
 		return -EINVAL;
diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
index 3070f36d9fb8..2785e434fc9d 100644
--- a/arch/powerpc/kvm/mpic.c
+++ b/arch/powerpc/kvm/mpic.c
@@ -1841,6 +1841,8 @@ int kvm_set_routing_entry(struct kvm *kvm,
 		e->msi.address_lo = ue->u.msi.address_lo;
 		e->msi.address_hi = ue->u.msi.address_hi;
 		e->msi.data = ue->u.msi.data;
+		e->msi.flags = ue->flags;
+		e->msi.devid = ue->u.msi.devid;
 		break;
 	default:
 		goto out;
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 9519fec09ee6..6774e4964861 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -332,6 +332,8 @@ int kvm_set_routing_entry(struct kvm *kvm,
 		e->msi.address_lo = ue->u.msi.address_lo;
 		e->msi.address_hi = ue->u.msi.address_hi;
 		e->msi.data = ue->u.msi.data;
+		e->msi.flags = ue->flags;
+		e->msi.devid = ue->u.msi.devid;
 
 		if (kvm_msi_route_invalid(kvm, e))
 			return -EINVAL;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a8d74b25c5cf..54d9641e2b52 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -694,6 +694,7 @@ struct kvm_irq_routing_table {
 	int chip[KVM_NR_IRQCHIPS][KVM_IRQCHIP_NUM_PINS];
 	u32 nr_rt_entries;
 	struct kvm_kernel_irq_routing_entry *entries;
+	size_t entries_size;
 	/*
 	 * Array indexed by gsi. Each entry contains list of irq chips
 	 * the gsi is connected to.
@@ -845,6 +846,11 @@ struct kvm {
 	 * Update side is protected by irq_lock.
 	 */
 	struct kvm_irq_routing_table __rcu *irq_routing;
+	/*
+	 * Cache for the entries[] allocation of a freed IRQ routing table.
+	 */
+	struct kvm_kernel_irq_routing_entry *irq_routing_entries_cache;
+	size_t irq_routing_entries_cache_size;
 
 	struct hlist_head irq_ack_notifier_list;
 #endif
diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index b78f113af4ea..7eb7b99c84f9 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -96,12 +96,54 @@ int kvm_set_irq(struct kvm *kvm, int irq_source_id, u32 irq, int level,
 	return ret;
 }
 
-static void free_irq_routing_table(struct kvm_irq_routing_table *rt)
+static struct kvm_kernel_irq_routing_entry *
+kvm_get_irq_routing_entries_cache(struct kvm *kvm, size_t alloc_size)
 {
+	struct kvm_kernel_irq_routing_entry *entries = NULL;
+	struct kvm_kernel_irq_routing_entry *cache = NULL;
+
+	/*
+	 * Reuse cached entries[] only for an exact allocation-size match.
+	 */
+	mutex_lock(&kvm->irq_lock);
+	if (kvm->irq_routing_entries_cache_size == alloc_size &&
+	    kvm->irq_routing_entries_cache) {
+		entries = kvm->irq_routing_entries_cache;
+	} else if (kvm->irq_routing_entries_cache) {
+		cache = kvm->irq_routing_entries_cache;
+	}
+
+	kvm->irq_routing_entries_cache = NULL;
+	kvm->irq_routing_entries_cache_size = 0;
+	mutex_unlock(&kvm->irq_lock);
+
+	kvfree(cache);
+
+	return entries;
+}
+
+static void free_irq_routing_table(struct kvm *kvm,
+				   struct kvm_irq_routing_table *rt)
+{
+	struct kvm_kernel_irq_routing_entry *entries;
+
 	if (!rt)
 		return;
 
-	kvfree(rt->entries);
+	entries = rt->entries;
+	if (kvm && !ZERO_OR_NULL_PTR(entries)) {
+		mutex_lock(&kvm->irq_lock);
+		if (!kvm->irq_routing_entries_cache) {
+			kvm->irq_routing_entries_cache = entries;
+			kvm->irq_routing_entries_cache_size = rt->entries_size;
+			entries = NULL;
+		}
+		mutex_unlock(&kvm->irq_lock);
+
+		kvfree(entries);
+	} else {
+		kvfree(entries);
+	}
 	kfree(rt);
 }
 
@@ -110,7 +152,10 @@ void kvm_free_irq_routing(struct kvm *kvm)
 	/* Called only during vm destruction. Nobody can use the pointer
 	   at this stage */
 	struct kvm_irq_routing_table *rt = rcu_access_pointer(kvm->irq_routing);
-	free_irq_routing_table(rt);
+	free_irq_routing_table(NULL, rt);
+	kvfree(kvm->irq_routing_entries_cache);
+	kvm->irq_routing_entries_cache = NULL;
+	kvm->irq_routing_entries_cache_size = 0;
 }
 
 static int setup_routing_entry(struct kvm *kvm,
@@ -161,6 +206,7 @@ int kvm_set_irq_routing(struct kvm *kvm,
 {
 	struct kvm_irq_routing_table *new, *old;
 	struct kvm_kernel_irq_routing_entry *e;
+	size_t alloc_size;
 	u32 i, j, nr_rt_entries = 0;
 	int r;
 
@@ -176,12 +222,17 @@ int kvm_set_irq_routing(struct kvm *kvm,
 	if (!new)
 		return -ENOMEM;
 
-	e = kvzalloc_objs(*e, nr, GFP_KERNEL_ACCOUNT);
+	/* Round up to the kmalloc bucket size to improve cache hit rate. */
+	alloc_size = kmalloc_size_roundup(size_mul(sizeof(*e), nr));
+	e = kvm_get_irq_routing_entries_cache(kvm, alloc_size);
+	if (!e)
+		e = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT);
 	if (!e) {
 		r = -ENOMEM;
 		goto out;
 	}
 	new->entries = e;
+	new->entries_size = alloc_size;
 
 	new->nr_rt_entries = nr_rt_entries;
 	for (i = 0; i < KVM_NR_IRQCHIPS; i++)
@@ -218,7 +269,7 @@ int kvm_set_irq_routing(struct kvm *kvm,
 	new = old;
 	r = 0;
 out:
-	free_irq_routing_table(new);
+	free_irq_routing_table(kvm, new);
 
 	return r;
 }
-- 
2.20.1
