Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAFB481FC4
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576134; cv=none; b=t9vulroJz9v5j9OjdTvE05c/UNzeUDmTkny2HUiamiCFDM++gCedDIl8QYyh/gXYcCbMfafNP03NmFDr3ln0jEYty7fTGbAhWfgJSbtW1kaq/Woj3oNILtHFKzkcurhXhekmn3sD65GBLSxmARjw4o8japV2eFfXUmpCb09bWoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576134; c=relaxed/simple;
	bh=6wvL9kFs+/iObzzTHi4ROLnjN3QU20HiRZxAvTAZnCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNKJV9sU8UFbe03cZ4124dZdSI3tqM++I3swaGdfaffuyjs5CQWpNQMNaz4EkXbDWgywV2QLZdY4h3JkXzrUbSgpKXXR68ASKmY/a+MUEbrhpP34mX94/00ockqQFFAdDCfprVOsoD+hWGHnmXhn7EWwKSX43SJS2Ip1rrcvvpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=PiWabS+g; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="PiWabS+g"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ff20870ac7so82739646d6.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 12:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576131; x=1785180931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5vrQuTcVEPlse/fTzTDhuMYNi8KtlAM6dYGGAEP65OU=;
        b=PiWabS+gsx9dHJpE7uvcLEyysiFd2d140aPwAGx1VV+eSZjIDrHa0FvlRoBNucUzCM
         vx///xfnA1mPT9ZTvmjfXPbTU7xqC+TtwUkjq7N+kTcSgzxTHJjwr1KIQiYBFRsOMbj7
         XcNON8hU79suSjkLn5YWqzt1tEqkE8meiN1llh41eZ4L+g5k1JKebRCZ4H6kUla9oa1N
         qRSzldcMYTkLEs8Zb+YT7quiSOgREcEutU6bHvlTrlcnHs6Ac4OLFKKoTLba0v8MLBKS
         aEDbr+6vSGBwEfuiytlBW1bmIcGmyJNn60Yk7Hg6yu2sv1ADLfTV2PrhSLiBYjrXmT+M
         je8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576131; x=1785180931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5vrQuTcVEPlse/fTzTDhuMYNi8KtlAM6dYGGAEP65OU=;
        b=HqRuRyA/fTRMxz2j8nWFbn/Hs878i0NuLsjGZWBL+CwgiVrtRD0njb6D/O9knbPy3h
         MecKQ1+i8+0xMhyQ5Gk/3/PivwM7DUYCTLnNH+NozrV45aIcOH+xE5IKIOhHG6m/CGvy
         WOsFAcGT7io/5eYQFpplVRqXKuZ22WJDecKP8zgEH19fNZqewCIhE6N2hR857HdhFMef
         6T4gFoadV9Y0Hd+hEtqPuu81l0zuJcMpqfpgYPDSsx3ngz7l6ZUvoNez2SbELvy9YFGR
         v2I+IR8KtQYavwMNZ9NY33iX6TFcZ513Mz7mL6jzJRv/lso6tnchgqo+qGGrV3kW0zxD
         kQ9A==
X-Forwarded-Encrypted: i=1; AHgh+RpDdIJKNB480yyJzDjFBJ3DL/G3HpnTKukaIj7KvPOaYsevaVW28Rz4cpXMudkud7//CGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqejyhy0Cv0LHCfrOX5cVPcSw/FF7+yLVQ71gWIDwiIoZ5CaX1
	V1pZXp6eNl+lnurKuOxcoWaQTR+eoDRezYwv1dqN5rni57F4xX8g2alFSTAPuRDADz0=
X-Gm-Gg: AfdE7cmu6MJBbLF9ipAr+Lhuuf4l+6YgpqUYtLVjLF1nZgj4Icrer10OUsHBHR7c5bS
	LOtgdsklyI5b3rypHMz+Ei/rtEKpAM1U/WGYLhOz5PZ+MpxV/wazx/zCBv4V+QnBkKOxJwB6WKb
	d6oI9nE+un1TY9ReHzn3LB2T3pizVWRk55SG+vGzFevI3Y+0KvthJichlmbQH2Ez8F3vA0Bu/Yv
	bqw0f1UoVwEOJ21mlUb6l42MwtnFdccFOcHYs8KgjvS07yoo4XS7tnAQzxT/SnqUpbJjw5XtyVx
	xfWl/mEAxSDgj7ilw0TE1BnG542pJ7xB6QetmosMXoNfBRojNA9alvlSWTT8qTOLfysebxA/a4h
	jzEvd0P8a8zMOBbc8cf637mRpL26VwC93UGoKjFkyC3USQI9e3usnR/zfs0Eviuv/cIHYsym3lY
	GhXhsJbhrRqkyAGv+S/zJMJiEIHWK7McwBsbnkckeEsM7arOeDT8HzRBq/qCI3pCg=
X-Received: by 2002:a05:620a:4606:b0:92e:c117:5ecb with SMTP id af79cd13be357-930b430a072mr1502942385a.75.1784576130602;
        Mon, 20 Jul 2026 12:35:30 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:30 -0700 (PDT)
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
Subject: [PATCH v5 20/36] mm/memcontrol: account private-node memory in per-node stats
Date: Mon, 20 Jul 2026 15:34:14 -0400
Message-ID: <20260720193431.3841992-21-gourry@gourry.net>
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

Private nodes folios are charged like any other - the node's per-cpu
lruvec counters are increment even for N_MEMORY_PRIVATE.

The memcg-level totals in memory.stat therefore include this memory,
but the per-node views do not:

  - mem_cgroup_css_rstat_flush() folds the per-node percpu deltas into the
    aggregate only for N_MEMORY nodes, so a private node's lruvec aggregate
    is never refreshed.

  - memory.numa_stat (v2) and the v1 numa_stat skip private nodes, so they
    never emit an Nx= field for one.

So memory.numa_stat does not sum to memory.stat once a cgroup has memory
on a private node.

Include N_MEMORY_PRIVATE in the flush/display process so private-node
memory is folded in and reported per node.

This is pure accounting of memory that already exists and is already
charged, so it is unconditional - regardless of future capabilities.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/memcontrol-v1.c |  8 ++++++--
 mm/memcontrol.c    | 11 +++++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 2dc599484d006..5e464e52dfb9a 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -2132,14 +2132,18 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 	const struct numa_stat *stat;
 	int nid;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+	nodemask_t reportable;
 
 	mem_cgroup_flush_stats(memcg);
 
+	/* Private nodes hold cgroup memory too, report them. */
+	nodes_or(reportable, node_states[N_MEMORY], node_states[N_MEMORY_PRIVATE]);
+
 	for (stat = stats; stat < ARRAY_END(stats); stat++) {
 		seq_printf(m, "%s=%lu", stat->name,
 			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
 						   false));
-		for_each_node_state(nid, N_MEMORY)
+		for_each_node_mask(nid, reportable)
 			seq_printf(m, " N%d=%lu", nid,
 				   mem_cgroup_node_nr_lru_pages(memcg, nid,
 							stat->lru_mask, false));
@@ -2151,7 +2155,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 		seq_printf(m, "hierarchical_%s=%lu", stat->name,
 			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
 						   true));
-		for_each_node_state(nid, N_MEMORY)
+		for_each_node_mask(nid, reportable)
 			seq_printf(m, " N%d=%lu", nid,
 				   mem_cgroup_node_nr_lru_pages(memcg, nid,
 							stat->lru_mask, true));
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f0dde52dc9e0e..4d79e238bc57d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4496,6 +4496,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
 	struct memcg_vmstats_percpu *statc;
 	struct aggregate_control ac;
+	nodemask_t reportable;
 	int nid;
 
 	flush_nmi_stats(memcg, parent);
@@ -4524,7 +4525,9 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	};
 	mem_cgroup_stat_aggregate(&ac);
 
-	for_each_node_state(nid, N_MEMORY) {
+	/* Private nodes must also be accounted or numa_stat is misleading */
+	nodes_or(reportable, node_states[N_MEMORY], node_states[N_MEMORY_PRIVATE]);
+	for_each_node_mask(nid, reportable) {
 		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
 		struct lruvec_stats *lstats = pn->lruvec_stats;
 		struct lruvec_stats *plstats = NULL;
@@ -4947,9 +4950,13 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 {
 	int i;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+	nodemask_t reportable;
 
 	mem_cgroup_flush_stats(memcg);
 
+	/* Private nodes hold cgroup memory too, report them. */
+	nodes_or(reportable, node_states[N_MEMORY], node_states[N_MEMORY_PRIVATE]);
+
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		int nid;
 
@@ -4957,7 +4964,7 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 			continue;
 
 		seq_printf(m, "%s", memory_stats[i].name);
-		for_each_node_state(nid, N_MEMORY) {
+		for_each_node_mask(nid, reportable) {
 			u64 size;
 			struct lruvec *lruvec;
 
-- 
2.53.0-Meta

