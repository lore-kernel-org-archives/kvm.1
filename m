Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE622D9481
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779681202; cv=none; b=iDUFYPB/HYK8VTtKh6vEcueeRt4iSEZVEkBCciqBniSPA0FS1o73PZcVX+ngE6uq6VyYgW23nCfvDWs1RKocjgKSzM0PackpzYWOvj1fRFCwIRNaBrAOGmgGOn5T26hYZW1aiZ9CIa5lP+PdprqahiSrW7SxEZmFfsmi5FZmwJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779681202; c=relaxed/simple;
	bh=eCg5nnEfRhBAO6LzuVWPcR0uqe5gBRSg4aUlAWkWXKQ=;
	h=To:Subject:Cc:Mime-Version:Date:Content-Type:From:Message-Id:
	 References:In-Reply-To; b=jmXcvCJUfyAt3zyU6jtMkHwEiwKAvzyTfPkQf6SsBlNsDz/Vja3hXdvSLUhZe+3ffN5NJpEU/5uPwniMg8aRt9HvxLzbvGHsopsqK9ngiyHxjpRcf04994HSwDa+r9lHr9e6wBEv8aaZnVEEmNqsPGc13ygny39g+/noBMrLHVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=V1AIRIzh; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="V1AIRIzh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779681196; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=8ya9UPGlW74YJX2t7n7RCe/MjmA4tcTuq7UD1ym4HtU=;
 b=V1AIRIzhBmLwyUrEDjhYfeECgdWUja1MIEUU60OqycRWO9i87MlmbQlw5ceUdr7Vhv4m8I
 thoRCRNYJQWO/n9Eg4PsXEVKw5y8ueI7ZkHRS0FLVbc9p6kOVrFjb21Lj1RJ7wz8tFv1gB
 dFMX+lMiaGu2SX4YLdXFnt/9IgmY5gXX+4UreE5CUq4ezUTltNRPF6iUDzE0yVi/ILdTd9
 dCZk6/HeAxqMb8la6/MKCvFolJvtQqdqVb8vG7Kh9X6ozg/D91corsigBte54u4qiRq/F/
 R2oP/7W8LnYmlvRGhtjJZQWrQ/Vq250N0hbS6dvl+v3/XLESrKJtpcOE0oCj1g==
To: <seanjc@google.com>, <pbonzini@redhat.com>
Subject: [v3 1/2] KVM: irqchip: KVM: Reduce allocation overhead in kvm_set_irq_routing()
Content-Transfer-Encoding: 7bit
Cc: <kvm@vger.kernel.org>, <caixiangfeng@bytedance.com>, 
	<fangying.tommy@bytedance.com>, <yanfei.xu@bytedance.com>, 
	<isyanfei.xu@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
Date: Mon, 25 May 2026 11:52:41 +0800
X-Mailer: git-send-email 2.20.1
Content-Type: text/plain; charset=UTF-8
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Message-Id: <20260525035242.107264-2-yanfei.xu@bytedance.com>
X-Lms-Return-Path: <lba+26a13c7aa+05425f+vger.kernel.org+yanfei.xu@bytedance.com>
References: <20260525035242.107264-1-yanfei.xu@bytedance.com>
In-Reply-To: <20260525035242.107264-1-yanfei.xu@bytedance.com>

In guests with many VFIO devices and MSI-X vectors, kvm_set_irq_routing()
becomes a high-overhead operation. Each invocation walks the entire IRQ
routing table and reallocates/frees every routing entry.

As the routing table grows on each call, entry allocation and freeing
dominate the execution time of this function. In scenarios such as VM
live migration or live upgrade, this behavior can introduce unnecessary
downtime.

Allocate memory for all routing entries in one shot using kvzalloc_objs(),
allowing them to be freed together with a single kfree() call.

Example: On a VM with 120 vCPUs and 15 VFIO devices (virtio-net), the
total number of calls to kzalloc and kfree is over 20000. With this
change, it is reduced to around 30.

Reported-by: Xiangfeng Cai <caixiangfeng@bytedance.com>
Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/irqchip.c       | 37 ++++++++++++-------------------------
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4c14aee1fb06..a8d74b25c5cf 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -693,6 +693,7 @@ struct kvm_kernel_irq_routing_entry {
 struct kvm_irq_routing_table {
 	int chip[KVM_NR_IRQCHIPS][KVM_IRQCHIP_NUM_PINS];
 	u32 nr_rt_entries;
+	struct kvm_kernel_irq_routing_entry *entries;
 	/*
 	 * Array indexed by gsi. Each entry contains list of irq chips
 	 * the gsi is connected to.
diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index 462c70621247..b78f113af4ea 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -98,21 +98,10 @@ int kvm_set_irq(struct kvm *kvm, int irq_source_id, u32 irq, int level,
 
 static void free_irq_routing_table(struct kvm_irq_routing_table *rt)
 {
-	int i;
-
 	if (!rt)
 		return;
 
-	for (i = 0; i < rt->nr_rt_entries; ++i) {
-		struct kvm_kernel_irq_routing_entry *e;
-		struct hlist_node *n;
-
-		hlist_for_each_entry_safe(e, n, &rt->map[i], link) {
-			hlist_del(&e->link);
-			kfree(e);
-		}
-	}
-
+	kvfree(rt->entries);
 	kfree(rt);
 }
 
@@ -187,31 +176,33 @@ int kvm_set_irq_routing(struct kvm *kvm,
 	if (!new)
 		return -ENOMEM;
 
+	e = kvzalloc_objs(*e, nr, GFP_KERNEL_ACCOUNT);
+	if (!e) {
+		r = -ENOMEM;
+		goto out;
+	}
+	new->entries = e;
+
 	new->nr_rt_entries = nr_rt_entries;
 	for (i = 0; i < KVM_NR_IRQCHIPS; i++)
 		for (j = 0; j < KVM_IRQCHIP_NUM_PINS; j++)
 			new->chip[i][j] = -1;
 
 	for (i = 0; i < nr; ++i) {
-		r = -ENOMEM;
-		e = kzalloc_obj(*e, GFP_KERNEL_ACCOUNT);
-		if (!e)
-			goto out;
-
 		r = -EINVAL;
 		switch (ue->type) {
 		case KVM_IRQ_ROUTING_MSI:
 			if (ue->flags & ~KVM_MSI_VALID_DEVID)
-				goto free_entry;
+				goto out;
 			break;
 		default:
 			if (ue->flags)
-				goto free_entry;
+				goto out;
 			break;
 		}
-		r = setup_routing_entry(kvm, new, e, ue);
+		r = setup_routing_entry(kvm, new, e + i, ue);
 		if (r)
-			goto free_entry;
+			goto out;
 		++ue;
 	}
 
@@ -226,10 +217,6 @@ int kvm_set_irq_routing(struct kvm *kvm,
 
 	new = old;
 	r = 0;
-	goto out;
-
-free_entry:
-	kfree(e);
 out:
 	free_irq_routing_table(new);
 
-- 
2.20.1
