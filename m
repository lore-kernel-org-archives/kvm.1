Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFCF4C9547
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576160; cv=none; b=WW9YBNoQ26aLN6MWvoj9vwtLYbj+XZvzNzJDLodNntNS8WkrLbbNb9jWj8llHZSE3b5VoxZKsGZgcoeZ+zvcaZHCMP/H6jjBvQaKhee+3BxFhuNB/+6l83BCudYMsVp2XljcUysT6G8ta7Sjuq+lmpIERUZRsIT0GQyfVvhqP6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576160; c=relaxed/simple;
	bh=2i1wvyBksR/msTLbpyy04DkOkxRMBM4AkFK/rJ1LuiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvhY0aAqxOni3c8bI+eX024aA2wCEwTSptPR9FC0TQlE5eyPrF/X64Jf4Cv9ClscQ3UknQGaU8RnWrgg6jkGfQBo6PiMYsLiSXe04RfxQG8M2qc9okuaBNT3kHLsdyNYa4Ko7zEKjYcl2K+UWyDDAgQb+9/CYr4E/XrM4gzRaNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=E6L03e85; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="E6L03e85"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e65e18969so422879385a.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576156; x=1785180956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+NQTGhXcHOKD56hvRpu1GEGtUFet41BSGHJhkUlyGRA=;
        b=E6L03e85wqQ471h4HPsX5E/QyE1NNVf2nkbr7Rpd8cZa4D/bp583BEIq893dtyQsd7
         CxJQHFebS8CN4LCcQL2Ot49nYZZIt30cT+QtxC8Rf9pPCk1bbmfWPqKyyGA5i76L0UX0
         2E3HbdQuStL+XrJhuWYgCQaBSXKymi93ZeAL/O3vsPVcz0SSW13n4GKnIyjIppTx41xB
         LQPrHQktr7WyQ0rkA97PSxtSqsPvFMHVESQ2/xyqTTYEScTdUC1VRt53DgyrkPRS6O47
         1QUp+f1tSlEIaFWyrODJuGo4JqlF7MxCbReUknCtFhq9J3TGJ/tJVfQxC0Jkll7LzgAc
         8mEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576156; x=1785180956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+NQTGhXcHOKD56hvRpu1GEGtUFet41BSGHJhkUlyGRA=;
        b=mluvNEm/3XEd6U+FMhW71O8wR0uH8PhgdnbHGvmRFjiyg2AtASEynW2Cq5FRP5T5OL
         1nCNX0s+BmLP1wzwmDMGO23a447bnnQVj1NrDtF6A7Czc32fPf6/29p6hibcj7SJcOJ+
         s9ejiF8jMfY66S6fUh5pTnlQX2WGxPULh2rxbPJ1UDP6rQ0xJrTsrJaQhK4syY7sAcYZ
         4pXhxNEG2b6AFWhzgxKBUJsA6Fv8yP6zKpuJkxpEExXCBWqI7fEnACdyFE48aqXcTBdJ
         zFS33lhcRNEKbXvf9tX5syqsdMOshMxL8bcfVf4E5pNlKSTgUQnHVAzaWchYOVLN9Wvn
         U1Dg==
X-Forwarded-Encrypted: i=1; AHgh+RqiShGnQxVWgSYlkj5+dWH51bYFRxPBgWqGO6WFOXFFbMqvq7ff8gc9lHA0k3OeXoB1nfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxufMunUi7wpKzApRoVj92IuW6eKvPT598vC17D5zb8MV91kV7T
	/vmFU6oVrlu9rrZgpDfGDgdKgceHYSPFPfRuZeN9FVhDTxrIBKtRqXxCO+Zkf4KGNTA=
X-Gm-Gg: AfdE7cm0nzmd70QqleiPUzM1qdb33FsyRGS6EjnGjcjPHgcCq6z1pWdK/g1XyQu7cKC
	ASfiQammAdgmMSyHGKUujU3NvHXPbLYt/QmUWh5SXATZyazpWVRQL2be7y6IL1LfwrioDuX1oaF
	Kyar0rdzmXxbbTQl6Fmnd24H+q3gVZ5vRG7Z0twavdV1hHJPc8F6YLvJ0WZoJf14Ht2YLErs6k5
	9Ls0NpQVmDjGzhA26KewlNC2BdhV/Fxj0whKO8lJvAHmIQuWqg+afWr5+V/CKITYkxN09ZLfJdm
	yRYDq80cG4An165Wn1ja3MQifs5Podf8PX8GbDWB99KHlnBfuBa19rf/TAltpA/9trQ3PARfcE3
	Qu2IYUnfJhay1xJJuSl3YOh2sHzatdG6si5md0fuxXWiuQYfi3h09den3ZRwqvGq4wvv4DUcETF
	sJrYWyIgONk/8AzaeqWVYZoKrWwCpk8D2Q0JTr45Nj9/8Wl+bM+sgoYIT9uTNGleA+NHKWxORE7
	w==
X-Received: by 2002:a05:620a:288a:b0:915:29cd:306c with SMTP id af79cd13be357-930a5f1a98fmr1940964285a.9.1784576154411;
        Mon, 20 Jul 2026 12:35:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:54 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: Zhigang.Luo@amd.com,
	arun.george@samsung.com,
	balbirs@nvidia.com,
	brendan.jackman@linux.dev,
	yuzenghui@huawei.com,
	apopple@nvidia.com,
	alucerop@amd.com,
	matthew.brost@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	osandov@osandov.com,
	jannh@google.com,
	pfalcato@suse.de,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	pbonzini@redhat.com,
	osalvador@suse.de,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	longman@redhat.com,
	ridong.chen@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	sj@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kvm@vger.kernel.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v5 29/36] mm: add NODE_PRIVATE_CAP_DEMOTION for private-node tiering demotion
Date: Mon, 20 Jul 2026 15:34:23 -0400
Message-ID: <20260720193431.3841992-30-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720193431.3841992-1-gourry@gourry.net>
References: <20260720193431.3841992-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A private node is invisible to the tiering/demotion hierarchy by default:
memory-tiers.c never includes it, so reclaim never demotes onto it.

Add NODE_PRIVATE_CAP_DEMOTION to opt a private node into demotion.

When set, memory-tiers adds the node to the demotion set and reclaim's
demote path may target it (allocating from the private zonelist).

Demotion is driven by reclaim, so CAP_DEMOTION requires CAP_RECLAIM.
Otherwise the node can either fill up and drive odd system-wide OOM
behavior, or demotion doesn't work (nothing can demote from the node).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/base/node.c          |  5 +++++
 include/linux/node_private.h | 30 +++++++++++++++++++++++++++++
 mm/memory-tiers.c            | 37 +++++++++++++++++++++++++++---------
 mm/vmscan.c                  |  4 ++++
 4 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 94cd51f51b7e8..3d61ca1b805dc 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -896,6 +896,11 @@ int node_private_register(int nid, struct node_private *np)
 	if (!np || !node_possible(nid))
 		return -EINVAL;
 
+	/* Demotion is driven by reclaim, so it requires reclaim. */
+	if ((np->caps & NODE_PRIVATE_CAP_DEMOTION) &&
+	    !(np->caps & NODE_PRIVATE_CAP_RECLAIM))
+		return -EINVAL;
+
 	mutex_lock(&node_private_lock);
 	mem_hotplug_begin();
 
diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index 7b617b1fa9c28..87b03444b2c97 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -15,6 +15,7 @@ struct page;
 #define NODE_PRIVATE_CAP_RECLAIM	(1UL << 0)	/* allow mm reclaim */
 #define NODE_PRIVATE_CAP_USER_NUMA	(1UL << 1)	/* allow mempolicy */
 #define NODE_PRIVATE_CAP_HOTUNPLUG	(1UL << 2)	/* allow hot-unplug */
+#define NODE_PRIVATE_CAP_DEMOTION	(1UL << 3)	/* allow tiering demotion */
 
 /**
  * struct node_private - Per-node container for N_MEMORY_PRIVATE nodes
@@ -118,6 +119,30 @@ static inline bool node_allows_hotunplug(int nid)
 	return ret;
 }
 
+/**
+ * node_allows_demotion - may kernel tiering demote to this node?
+ * @nid: the node to test
+ *
+ * Governs whether a private node participates in the demotion hierarchy.
+ * Demotion accumulates pages on the node, so CAP_DEMOTION requires CAP_RECLAIM
+ * (enforced at registration) as a safety valve.
+ *
+ * return: true for normal nodes and private nodes opted into CAP_DEMOTION.
+ */
+static inline bool node_allows_demotion(int nid)
+{
+	struct node_private *np;
+	bool ret;
+
+	if (!node_state(nid, N_MEMORY_PRIVATE))
+		return true;
+	rcu_read_lock();
+	np = rcu_dereference(NODE_DATA(nid)->node_private);
+	ret = np && (np->caps & NODE_PRIVATE_CAP_DEMOTION);
+	rcu_read_unlock();
+	return ret;
+}
+
 #else /* !CONFIG_NUMA */
 
 static inline bool folio_is_private_node(struct folio *folio)
@@ -150,6 +175,11 @@ static inline bool node_allows_hotunplug(int nid)
 	return true;
 }
 
+static inline bool node_allows_demotion(int nid)
+{
+	return true;
+}
+
 #endif /* CONFIG_NUMA */
 
 #if defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 25e121851b586..c673080d153e4 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -7,6 +7,7 @@
 #include <linux/memory-tiers.h>
 #include <linux/notifier.h>
 #include <linux/sched/sysctl.h>
+#include <linux/node_private.h>
 
 #include "internal.h"
 
@@ -317,6 +318,21 @@ void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
 	rcu_read_unlock();
 }
 
+/* Tiering set: N_MEMORY | (N_MEMORY_PRIVATE w/ CAP_DEMOTION) */
+static nodemask_t tierable_nodes;
+
+static void update_tierable_nodes(void)
+{
+	int node;
+
+	lockdep_assert_held_once(&memory_tier_lock);
+
+	tierable_nodes = node_states[N_MEMORY];
+	for_each_node_state(node, N_MEMORY_PRIVATE)
+		if (node_allows_demotion(node))
+			node_set(node, tierable_nodes);
+}
+
 /**
  * next_demotion_node() - Get the next node in the demotion path
  * @node: The starting node to lookup the next node
@@ -330,7 +346,7 @@ void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
 int next_demotion_node(int node, const nodemask_t *allowed_mask)
 {
 	struct demotion_nodes *nd;
-	nodemask_t mask;
+	nodemask_t mask, tierable;
 
 	if (!node_demotion)
 		return NUMA_NO_NODE;
@@ -370,7 +386,8 @@ int next_demotion_node(int node, const nodemask_t *allowed_mask)
 	 * closest demotion target.
 	 */
 	nodes_complement(mask, *allowed_mask);
-	return find_next_best_node_in(node, &mask, &node_states[N_MEMORY]);
+	tierable = tierable_nodes;
+	return find_next_best_node_in(node, &mask, &tierable);
 }
 
 static void disable_all_demotion_targets(void)
@@ -378,7 +395,7 @@ static void disable_all_demotion_targets(void)
 	struct memory_tier *memtier;
 	int node;
 
-	for_each_node_state(node, N_MEMORY) {
+	for_each_node_mask(node, tierable_nodes) {
 		node_demotion[node].preferred = NODE_MASK_NONE;
 		/*
 		 * We are holding memory_tier_lock, it is safe
@@ -401,7 +418,7 @@ static void dump_demotion_targets(void)
 {
 	int node;
 
-	for_each_node_state(node, N_MEMORY) {
+	for_each_node_mask(node, tierable_nodes) {
 		struct memory_tier *memtier = __node_get_memory_tier(node);
 		nodemask_t preferred = node_demotion[node].preferred;
 
@@ -435,9 +452,10 @@ static void establish_demotion_targets(void)
 	if (!node_demotion)
 		return;
 
+	update_tierable_nodes();
 	disable_all_demotion_targets();
 
-	for_each_node_state(node, N_MEMORY) {
+	for_each_node_mask(node, tierable_nodes) {
 		best_distance = -1;
 		nd = &node_demotion[node];
 
@@ -455,7 +473,7 @@ static void establish_demotion_targets(void)
 		 * nodelist to skip list so that we find the best node from the
 		 * memtier nodelist.
 		 */
-		nodes_andnot(tier_nodes, node_states[N_MEMORY], tier_nodes);
+		nodes_andnot(tier_nodes, tierable_nodes, tier_nodes);
 
 		/*
 		 * Find all the nodes in the memory tier node list of same best distance.
@@ -464,7 +482,7 @@ static void establish_demotion_targets(void)
 		 */
 		do {
 			target = find_next_best_node_in(node, &tier_nodes,
-							&node_states[N_MEMORY]);
+							&tierable_nodes);
 			if (target == NUMA_NO_NODE)
 				break;
 
@@ -503,7 +521,7 @@ static void establish_demotion_targets(void)
 	 * allocation to a set of nodes that is closer the above selected
 	 * preferred node.
 	 */
-	lower_tier = node_states[N_MEMORY];
+	lower_tier = tierable_nodes;
 	list_for_each_entry(memtier, &memory_tiers, list) {
 		/*
 		 * Keep removing current tier from lower_tier nodes,
@@ -550,7 +568,8 @@ static struct memory_tier *set_node_memory_tier(int node)
 
 	lockdep_assert_held_once(&memory_tier_lock);
 
-	if (!node_state(node, N_MEMORY))
+	/* Include N_MEMORY and N_MEMORY_PRIVATE with CAP_DEMOTION */
+	if (!node_state(node, N_MEMORY) && !node_allows_demotion(node))
 		return ERR_PTR(-EINVAL);
 
 	mt_calc_adistance(node, &adist);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f1722693ac2db..b617f7cd1e716 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -963,6 +963,10 @@ static struct folio *alloc_demote_folio(struct folio *src,
 
 	mtc = (struct migration_target_control *)private;
 
+	if (mtc->nmask &&
+	    nodes_intersects(*mtc->nmask, node_states[N_MEMORY_PRIVATE]))
+		mtc->alloc_flags = ALLOC_ZONELIST_PRIVATE;
+
 	/*
 	 * make sure we allocate from the target node first also trying to
 	 * demote or reclaim pages from the target node via kswapd if we are
-- 
2.53.0-Meta

