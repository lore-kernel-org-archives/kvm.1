Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA273ACF06
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 19:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576084; cv=none; b=L9cBoz4AwwjaGJZifS6utzgb5WRxtbDvJ87uciUcJx821QFFRmpx7M+qVIr3U66i76rA2oosIjGkvarpJCN0SxJFpcse/NxFrvSolMwivPfx1/vxX0/HudpNr2lvyZIj/81QU91a4YIpQxP5kph8ccRuOAk9nqTdrun+2gxNjz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576084; c=relaxed/simple;
	bh=xkznVUciWK5ilQNeo3zeGFmer5mxsRIUX4pP0TUSjzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQY8ncMmnj6onQf3ynQgOztZIHpAeVdMdMVmYZ793r2Iblc3GNU5+TvVxflLMzis3hSal7KaxHzmDXzw1KnfIEKiDiEy4XLpL9haOQcETlhM22KOLkEY/aupKtxqGOrYa3ZT+8iww1ijF+fbT+sNzaVWXYfm71Q/kxjKr/vZxzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=mfxN76KP; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="mfxN76KP"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ee88fce572so82093776d6.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 12:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576081; x=1785180881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZACuuDSyenseZGNg/vBzUwDZvK6auP3eLRTsBQnq+WQ=;
        b=mfxN76KPizsUpioEokU/AQzIkDHcbxpE7Tz55y5SxzpMDHFoR/Un+YZdu9yTSmdRmK
         N6d6RtGnDd2qdEF1zXUj9yYb9flukM7gzZQ30orTW5Z0XJQPQGrluVL9Vw9ZknPWCZha
         AxTB5Q8ZuKcZEVTYRH2GmAAPxYZkITNF08QovSvJSAxNijWGf4cbY54ei2KoP6V4/g54
         U0qwqgXPBXUw3qgIWco83vCYO0ZyepC+qiO2wtrZEmQZcl5kSrera29BHxBRmqm+tILe
         M5rBB3qlLE2Xa43ICYnT6o/5JBeUzDlpg3Z0M7l/qi0DeTCvPQwLH/rm8awiJX/pEsEf
         xpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576081; x=1785180881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZACuuDSyenseZGNg/vBzUwDZvK6auP3eLRTsBQnq+WQ=;
        b=qbP7CiVlF7yVPH4IVQdQMBpjPpDqQRlNaW+k9qWJNYrOL1R9rfNk1gkwMUCiThdGV9
         gmH6AIGlrhDyzeNha3vYZN6Hzf2RjHV7w8qv7NmCzizBOKX/80L0fFGjIj9B3ZSA+ETK
         ZS350Vf6T9d3i4BbnOyQZiJ3nJKSv/gXjiLWw8pbnwBFDlwsd3B4oo1hNtsuY4/i12oP
         qhohRJ3Z4vbB78dJpy+NIszDlpeKpv6uu9uza96AcGCTpHq2v0ucaob2aofOcXDKzWxW
         SCI4oDYNq0O688AnPHE2QnE3rPNS0nWHIPyEYxDRx8w4XPbXAdNcX25jGtSiYv6GD1m1
         rv5A==
X-Forwarded-Encrypted: i=1; AHgh+RqPWXOe2JsnxeQMbXRGqUpSbnFW9fEd4QHT465nWTbz+oz0sCNuiuWodCj1+7mDHsTfDxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzPzP1lSzwIZUontwzhUPLzr57WN3IInJ+pSWgOLocgq2z8d0e
	ukG04aCIWPfeEM1K+4HCScZDOTTQO1bVHuU8chhMZowKbLKOdiwFXzvXie0ZeJ2HuLU=
X-Gm-Gg: AfdE7cnSQsec6WYBPgkWW/l5t1v2otOjnO4zqiX91ed4C9u9HO1RcmWKGUQpRigGEjc
	e9vGpQJbw7nTELrsIjMMqpfXxuAILxf2BnPnNtZNPuSdgBrgCkqiNJZzYiSLOCC6Acz/Eva/NIh
	CBnSQlWYGVMUsxCnu0E7p8bKPHDMYQgv94pkSH20lWqRDxRydvXP+kMEe57zrQEwoOGWtbCheMy
	uswv16Z1qeGl9Xn1KSym0RIIqUTFpxFy9gT719Z96JnyxLG32FWZ8FaqeMq+hIElpNH4y1t1GAZ
	vDt7mRouW6YPC53GOo5295duxiMLaVhHBQFWa/upNED6F4k6Txexr+J0qaZLM/AfYk5MigW8Y7m
	9aL3nTQGXnxMD3QAw+R1fwi1uevKOeJgTvbgHxf8JCFtEObzrIyPjR4AVqu8Rp7/e/Ggm8I+7E+
	C19HTfWpLoDrHXcvHU6p7la9+mxSVd6PkHL9fDSaloD6sdw+cKYLdnDYKX0Uf6I8w=
X-Received: by 2002:a05:620a:72d3:10b0:930:d7ba:7e5c with SMTP id af79cd13be357-930d7ba80a6mr431148485a.21.1784576080645;
        Mon, 20 Jul 2026 12:34:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:34:40 -0700 (PDT)
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
Subject: [PATCH v5 01/36] mm: refactor find_next_best_node to find_next_best_node_in
Date: Mon, 20 Jul 2026 15:33:55 -0400
Message-ID: <20260720193431.3841992-2-gourry@gourry.net>
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

find_next_best_node() picks the next-closest node for a fallback list
from the full N_MEMORY set. Refactor it into find_next_best_node_in(),
which takes an explicit candidates nodemask.

This enables building fallback lists with non-N_MEMORY candidates.

No functional change: every caller still selects from N_MEMORY.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/internal.h     |  6 ++++--
 mm/memory-tiers.c |  7 ++++---
 mm/page_alloc.c   | 13 ++++++++-----
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index f26423de4ca28..96d78a7778e88 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1103,7 +1103,8 @@ extern int node_reclaim_mode;
 
 extern unsigned long node_reclaim(struct pglist_data *pgdat,
 				  gfp_t gfp_mask, unsigned int order);
-extern int find_next_best_node(int node, nodemask_t *used_node_mask);
+extern int find_next_best_node_in(int node, nodemask_t *used_node_mask,
+				  const nodemask_t *candidates);
 #else
 #define node_reclaim_mode 0
 
@@ -1112,7 +1113,8 @@ static inline unsigned long node_reclaim(struct pglist_data *pgdat,
 {
 	return 0;
 }
-static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
+static inline int find_next_best_node_in(int node, nodemask_t *used_node_mask,
+					 const nodemask_t *candidates)
 {
 	return NUMA_NO_NODE;
 }
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 54851d8a195b0..25e121851b586 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -370,7 +370,7 @@ int next_demotion_node(int node, const nodemask_t *allowed_mask)
 	 * closest demotion target.
 	 */
 	nodes_complement(mask, *allowed_mask);
-	return find_next_best_node(node, &mask);
+	return find_next_best_node_in(node, &mask, &node_states[N_MEMORY]);
 }
 
 static void disable_all_demotion_targets(void)
@@ -450,7 +450,7 @@ static void establish_demotion_targets(void)
 		memtier = list_next_entry(memtier, list);
 		tier_nodes = get_memtier_nodemask(memtier);
 		/*
-		 * find_next_best_node, use 'used' nodemask as a skip list.
+		 * find_next_best_node_in, use 'used' nodemask as a skip list.
 		 * Add all memory nodes except the selected memory tier
 		 * nodelist to skip list so that we find the best node from the
 		 * memtier nodelist.
@@ -463,7 +463,8 @@ static void establish_demotion_targets(void)
 		 * in the preferred mask when allocating pages during demotion.
 		 */
 		do {
-			target = find_next_best_node(node, &tier_nodes);
+			target = find_next_best_node_in(node, &tier_nodes,
+							&node_states[N_MEMORY]);
 			if (target == NUMA_NO_NODE)
 				break;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f93a6bb9a872d..acf096f525f49 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5743,9 +5743,10 @@ static int numa_zonelist_order_handler(const struct ctl_table *table, int write,
 static int node_load[MAX_NUMNODES];
 
 /**
- * find_next_best_node - find the next node that should appear in a given node's fallback list
+ * find_next_best_node_in - find the next node that should appear in a given node's fallback list
  * @node: node whose fallback list we're appending
  * @used_node_mask: nodemask_t of already used nodes
+ * @candidates: nodemask_t of nodes eligible for selection
  *
  * We use a number of factors to determine which is the next node that should
  * appear on a given node's fallback list.  The node should not have appeared
@@ -5757,7 +5758,8 @@ static int node_load[MAX_NUMNODES];
  *
  * Return: node id of the found node or %NUMA_NO_NODE if no node is found.
  */
-int find_next_best_node(int node, nodemask_t *used_node_mask)
+int find_next_best_node_in(int node, nodemask_t *used_node_mask,
+			   const nodemask_t *candidates)
 {
 	int n, val;
 	int min_val = INT_MAX;
@@ -5767,12 +5769,12 @@ int find_next_best_node(int node, nodemask_t *used_node_mask)
 	 * Use the local node if we haven't already, but for memoryless local
 	 * node, we should skip it and fall back to other nodes.
 	 */
-	if (!node_isset(node, *used_node_mask) && node_state(node, N_MEMORY)) {
+	if (!node_isset(node, *used_node_mask) && node_isset(node, *candidates)) {
 		node_set(node, *used_node_mask);
 		return node;
 	}
 
-	for_each_node_state(n, N_MEMORY) {
+	for_each_node_mask(n, *candidates) {
 
 		/* Don't want a node to appear more than once */
 		if (node_isset(n, *used_node_mask))
@@ -5857,7 +5859,8 @@ static void build_zonelists(pg_data_t *pgdat)
 	prev_node = local_node;
 
 	memset(node_order, 0, sizeof(node_order));
-	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
+	while ((node = find_next_best_node_in(local_node, &used_mask,
+					      &node_states[N_MEMORY])) >= 0) {
 		/*
 		 * We don't want to pressure a particular node.
 		 * So adding penalty to the first node in same
-- 
2.53.0-Meta

