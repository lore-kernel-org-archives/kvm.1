Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2F485538D85;
	Tue,  8 Sep 2026 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869436; cv=none; b=DqO/PITgUpmYfvkQ1c/n+QlBG3qD9G6VHnp3eV45q2QN6I3zeknrEy4NLMhAmT93cVGJlwH5WPOsDJmW3tjdY8J8YNCxaBglDkkqp4n8LiMpaK6bsoaDKmzaWUuFdb6QYD7wM2FAEam7x4H0tc1XoBrZd/5j2ywUWEEXh9U10rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869436; c=relaxed/simple;
	bh=kiBE1+g76z4qwzHwHU+V4b7I2l+21nG8jl2+rGPzT8c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NymHPVkzXIPc5fu5++aP+NSuFXGdJExgD0jaHSPrrwMAhvmMgLp8G/egLAft8ytE0LzAT9xZmmo4RGdy+Yi/WG72GDQsmpDQWkQWZlaWguDLmB73sowuLlmSlUDPXoZyHYJ0QLZbDZ5rPbqIDbKAt+f0B92AvIc9LaZI8bbERRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=ixmrfraU; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="ixmrfraU"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] KVM: irqchip: allocate routing entries in chunks
Date: Tue, 8 Sep 2026 20:01:33 +0800
Message-ID: <20260908120133.2381-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc6.internal.baidu.com (172.31.50.50) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1788868908;
	bh=2xDETEACWh44ozaK44g8QqrbA8/wL3drFTvFddCxvNg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=ixmrfraUUjUBCru0y4x5Cvf5tknI2ABrUwcfCoyTG0ADp+DgqHb4anlqd8GtWyM2f
	 q7C0+3iB54dLvBTq1nVUu84Xax5vXbZ2Gl/zskETRY56GyiibGGeBz7wliI/r++Suo
	 V7HnZ+/OGUtGAYN15V3XuOowDRd3aO9kgiV0hQPwiA5e3zTeZBY8Q+XDWVV8Zymidh
	 9vnRDWSNxF8vvaOaa7HRR/oD8vPeE5dN204fZbRxDnuIxl3m+RvMDLultG83cW2T6H
	 9o3dq0N3QVAZinTSuwlcES076IAw/QUuMKj8kzFoibnbvRWwLHJHT06D4RuIhoeJH0
	 JodYb1f0ph2dA==

From: Li RongQing <lirongqing@baidu.com>

kvm_set_irq_routing() allocates each routing entry separately, so
a routing table with thousands of GSIs needs thousands of small
allocations and frees, adding significant allocator overhead.

Allocate the entries in chunks instead: each chunk holds up to
PAGE_SIZE / sizeof(struct kvm_kernel_irq_routing_entry) entries, and
the chunk pointers are kept in the routing table so that all entries
are freed together when the table is released.

Each chunk is capped at PAGE_SIZE instead of allocating one array for
the whole table: with nr up to KVM_MAX_IRQ_ROUTES (4096), a single array
would be a multi-page contiguous request, which is what tends to fail
once memory is fragmented. Page-sized chunks stay on the normal kmalloc
path, and a failed allocation only costs one chunk. The chunk pointer
array uses kvzalloc_objs() and can fall back to vmalloc.

The last chunk is sized to the number of entries actually left, so a
table smaller than one chunk - the common case - allocates only what it
needs.

Measured with an eBPF probe on kvm_set_irq_routing() on an Intel EMR CPU:
when a VM has a 2000+ entry routing table, the time spent in the function
drops from about 700us to about 300us.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/irqchip.c       | 62 +++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 03bfc92..83848d7 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -693,6 +693,8 @@ struct kvm_kernel_irq_routing_entry {
 struct kvm_irq_routing_table {
 	int chip[KVM_NR_IRQCHIPS][KVM_IRQCHIP_NUM_PINS];
 	u32 nr_rt_entries;
+	u32 nr_entry_chunks;
+	struct kvm_kernel_irq_routing_entry **entry_chunks;
 	/*
 	 * Array indexed by gsi. Each entry contains list of irq chips
 	 * the gsi is connected to.
diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index 462c706..044b831 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -18,6 +18,9 @@
 #include <linux/export.h>
 #include <trace/events/kvm.h>
 
+#define KVM_IRQ_ROUTING_ENTRIES_PER_CHUNK	\
+	(PAGE_SIZE / sizeof(struct kvm_kernel_irq_routing_entry))
+
 int kvm_irq_map_gsi(struct kvm *kvm,
 		    struct kvm_kernel_irq_routing_entry *entries, int gsi)
 {
@@ -107,12 +110,14 @@ static void free_irq_routing_table(struct kvm_irq_routing_table *rt)
 		struct kvm_kernel_irq_routing_entry *e;
 		struct hlist_node *n;
 
-		hlist_for_each_entry_safe(e, n, &rt->map[i], link) {
+		hlist_for_each_entry_safe(e, n, &rt->map[i], link)
 			hlist_del(&e->link);
-			kfree(e);
-		}
 	}
 
+	for (i = 0; i < rt->nr_entry_chunks; ++i)
+		kfree(rt->entry_chunks[i]);
+	kvfree(rt->entry_chunks);
+
 	kfree(rt);
 }
 
@@ -170,9 +175,11 @@ int kvm_set_irq_routing(struct kvm *kvm,
 			unsigned nr,
 			unsigned flags)
 {
+	struct kvm_kernel_irq_routing_entry **chunks = NULL;
 	struct kvm_irq_routing_table *new, *old;
 	struct kvm_kernel_irq_routing_entry *e;
 	u32 i, j, nr_rt_entries = 0;
+	u32 nr_chunks;
 	int r;
 
 	for (i = 0; i < nr; ++i) {
@@ -183,6 +190,13 @@ int kvm_set_irq_routing(struct kvm *kvm,
 
 	nr_rt_entries += 1;
 
+	/*
+	 * The chunks hold the routing entries, so they are sized by the number
+	 * of entries passed in by the caller, not by nr_rt_entries, which is
+	 * the size of the GSI map.
+	 */
+	nr_chunks = DIV_ROUND_UP(nr, KVM_IRQ_ROUTING_ENTRIES_PER_CHUNK);
+
 	new = kzalloc_flex(*new, map, nr_rt_entries, GFP_KERNEL_ACCOUNT);
 	if (!new)
 		return -ENOMEM;
@@ -192,26 +206,54 @@ int kvm_set_irq_routing(struct kvm *kvm,
 		for (j = 0; j < KVM_IRQCHIP_NUM_PINS; j++)
 			new->chip[i][j] = -1;
 
+	r = -ENOMEM;
+	if (nr_chunks) {
+		chunks = kvzalloc_objs(*chunks, nr_chunks, GFP_KERNEL_ACCOUNT);
+		if (!chunks)
+			goto out;
+
+		new->entry_chunks = chunks;
+		new->nr_entry_chunks = nr_chunks;
+	}
+
 	for (i = 0; i < nr; ++i) {
+		u32 idx = i / KVM_IRQ_ROUTING_ENTRIES_PER_CHUNK;
+		u32 off = i % KVM_IRQ_ROUTING_ENTRIES_PER_CHUNK;
+
 		r = -ENOMEM;
-		e = kzalloc_obj(*e, GFP_KERNEL_ACCOUNT);
-		if (!e)
-			goto out;
+		if (!chunks[idx]) {
+			struct kvm_kernel_irq_routing_entry *chunk;
+			/*
+			 * A chunk is only entered at its first entry, so nr - i
+			 * is the number of entries left for this chunk; the last
+			 * chunk is short.
+			 */
+			u32 cnt = min_t(u32, nr - i,
+					KVM_IRQ_ROUTING_ENTRIES_PER_CHUNK);
+
+			chunk = kzalloc_objs(*chunk, cnt, GFP_KERNEL_ACCOUNT);
+			if (!chunk)
+				goto out;
+
+			chunks[idx] = chunk;
+		}
+
+		e = chunks[idx] + off;
 
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
 		r = setup_routing_entry(kvm, new, e, ue);
 		if (r)
-			goto free_entry;
+			goto out;
 		++ue;
 	}
 
@@ -228,8 +270,6 @@ int kvm_set_irq_routing(struct kvm *kvm,
 	r = 0;
 	goto out;
 
-free_entry:
-	kfree(e);
 out:
 	free_irq_routing_table(new);
 
-- 
2.9.4

