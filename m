Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298D3496917
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576143; cv=none; b=nqAocczjfLiZ4Jtj74buJxRfmfg6qm/g8HBalXpRjUPvn3CsnyohHzFgjdQpv/IeSiDRf4AL0xz4Myf+AP1frucPF6a7w0rs8l9Ir2i1XvjbAuVG9cxsEz2ZaYXl+32GipYU8hGv59G9JjriTYO7muRsxo0oMnWmLyndH+f46hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576143; c=relaxed/simple;
	bh=4zcS+WScYQPwZyM+xiHJlRsISzjdbehehXpn4Ix1F20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JstrdMmGgPMafbvAkeGIizaNXHDiMYdqbYV+uQZhSNH+RLlJuOpRDj4IT2sB7WU+xZS+mD58J2luS9ySHJ7SGEbmXwgodRfZRnHn+YcVf/M4fmf2hMBFecC2XVpBvD5NHbbfzEc7RQoe3gZLPsXCBoPt7f4W9YnHi4r5h3IVZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VxO8BlYZ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VxO8BlYZ"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e5cb052edso567185885a.2
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 12:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576138; x=1785180938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KyXKxKoPetSKUj/EMCvw6yCRblDu/3mrIttJowkuK3Y=;
        b=VxO8BlYZBs2PxviIR4POMtkxgvXfoSVhFrreMn3GW0RTQ/sRuUDROF6NeddrqNfxQl
         Xx6HGa6ImPNsOhohdMoHyvb90oU1sgjnuirSs3REP4GVVSDTBZyFec3BAZJP0DmzWoVv
         Fy2FNCQTUvppEj+WgRqfZla8zgJsfOc/2ynw/ThM3y6g+PhEgJgbviGPDxG47j3u1Z6g
         xXHUJ81ivjfp8e0bjlbTMq5X2MV1af0SrSexIOISA6GotWUadFNbEy8xStT5+VX4kccR
         XmrOJesGs9CMqNOYEGi/uABzi1yg5xwqpfIL4KMVzffK8wcJ+SQZDGa2Hk9FggoNa9yt
         AhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576138; x=1785180938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KyXKxKoPetSKUj/EMCvw6yCRblDu/3mrIttJowkuK3Y=;
        b=k6P/5inC5cgTpDZlbDsbheAVIixD+pk3Sh5+rimWQJzzrGm7uE1H9Th0cDHo7WKghy
         y/ubc8LiyyrMCLkIq44615yGuKW21H30HjJK4G293p2OGMDtOgigGe2GGW3PvrktHW0D
         e9q/uZ1tNYFSIWYxC1XitDeb1imeF0BxPnB2TTDa9T63c6Ytz8wr23HDKD9cuahIMJD8
         vNdDivuLNER/wbJYyzV9txrKTcBwvdofwbxLFGqxKLbgCmhSdUIabqjuRUNeooN+d41a
         MddSs/BuD262R4Y3Gfjq0kz8VhD1BVhCfr5NhsWZkHAgIRmetTFV50cOIOMHPimAILnf
         JUPw==
X-Forwarded-Encrypted: i=1; AHgh+Rpjh97haUr6xXBEQgP7IIkw0Z+Rt3WYV2Z8K1QbmS9tmI2wkmzoeyZQIJJWD0zR1NT+ibs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDgE15VTEzhNMdIp6iePjCic5BFDGHANYpQVyN6SoIUMxPNWMO
	c+KdVHkNcVpE+sN00lYqaigZyUWTIO07nX4mzU4ys6q4V+eh/b6JsnJltnrGVTV9a3w=
X-Gm-Gg: AfdE7cmNvtReXn7tpbNjfkB0ZAytv79lDZhIhFBipjxHteaoBwQGbpdhNv2BJYWINmg
	WxpH4zr6b+0jw1YdsfMM6gwmn/LFgHMmi9Au+Wub8sQuplSE53YI47dG4Xsiv/y/i0td1YGrGjl
	Usb5F5dzKU508DLqLjnKS9tT1bHpLnVhKPUI12NChlptUvnmSEqq9omNU/9uZT9ktQJYDqOOdCo
	JggJgnFT5mD4nyieNtdnIwTgO9CeSKgQuhqOsNmThlHWu2/OWxgtKp+yiqTkZaUcC3SPlmvKx11
	bT/9oc6unTfOu312kn5mkng6kmnU66jBDqbkqUWQlIhy4+aTS1ml03ISk8lZt2xEcvERcEwnzZx
	zd5Y2oQMl3uh6u6AB8l8ya5GMjj7lH2jxl+kNCqL/5EUATeEmhEvq36JGkdPTz3TU16N0MtBuFS
	wKv//OstNQcC2+/o3wiWBdkfwk3Cw0t2SuZGRw/V+bQLYjcqslI914zf3s4jlVBBNop7vt1ATfu
	Q==
X-Received: by 2002:a05:620a:44c2:b0:930:a963:da73 with SMTP id af79cd13be357-930b419edc2mr1559559685a.50.1784576138219;
        Mon, 20 Jul 2026 12:35:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:37 -0700 (PDT)
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
Subject: [PATCH v5 23/36] mm/mempolicy: apply policy at the kernel zone for private-node binds
Date: Mon, 20 Jul 2026 15:34:17 -0400
Message-ID: <20260720193431.3841992-24-gourry@gourry.net>
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

apply_policy_zone() raises dynamic_policy_zone to ZONE_MOVABLE when none
of a policy's nodes have non-movable memory, so a bind to movable-only
node does not force kernel-zone allocations onto a zone that cannot
satisfy them - resulting retries forever (livelock).

The current code uses N_HIGH_MEMORY to denote eligibility, but private
nodes are deliberately not in N_HIGH_MEMORY nor N_NORMAL_MEMORY. This
means a private node onlined into ZONE_NORMAL is judged as movable-only.

This means a policy set with set_mempolicy() binding a private node with
ZONE_NORMAL memory will shunt otherwise eligible allocations (like the
task's page tables) back to N_MEMORY nodes.

This also becomes relevant for in-kernel users that want non-movable
memory (such as KVM placing pinned VM memory solely on a private node).

Add policy_private_has_kernel_zone() to consult the actual zones of
the policy's private nodes and keep the policy applied at lower zones
when a kernel-zoned private node can satisfy the allocation.

Only a mempolicy binding a private node pays the zone scan, all other
mempolicies preserve fast-path performance.

Additionally: update the comments in apply_policy_zone for clarity,
because this particular policy mechanism is very confusing.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/mempolicy.c | 48 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 90110e9761122..e83c2c7a94c1d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2091,6 +2091,34 @@ bool vma_policy_mof(struct vm_area_struct *vma)
 	return mof;
 }
 
+/*
+ * true if any policy *private* node can satisfy a !__GFP_MOVABLE allocation.
+ * Policies without private nodes (~MPOL_F_PRIVATE) always return false.
+ *
+ * This provides a way for otherwise-bound kernel allocations to make their
+ * way onto private nodes with ZONE_NORMAL memory without having to audit
+ * every caller.  The cost is a zone scan for private nodes in the mask.
+ */
+static bool policy_private_has_kernel_zone(const struct mempolicy *pol)
+{
+	int nid;
+
+	if (!(pol->flags & MPOL_F_PRIVATE))
+		return false;
+
+	for_each_node_mask(nid, pol->nodes) {
+		pg_data_t *pgdat = NODE_DATA(nid);
+		enum zone_type zt;
+
+		if (!node_is_private(nid))
+			continue;
+		for (zt = ZONE_NORMAL; zt < ZONE_MOVABLE; zt++)
+			if (managed_zone(&pgdat->node_zones[zt]))
+				return true;
+	}
+	return false;
+}
+
 bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
 {
 	enum zone_type dynamic_policy_zone = policy_zone;
@@ -2098,14 +2126,22 @@ bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
 	BUG_ON(dynamic_policy_zone == ZONE_MOVABLE);
 
 	/*
-	 * if policy->nodes has movable memory only,
-	 * we apply policy when gfp_zone(gfp) = ZONE_MOVABLE only.
+	 * dynamic_policy_zone is the lowest zone this policy is enforced for,
+	 * allocations below it ignore the nodemask and fall back freely.
+	 *
+	 * If all policy-nodes are movable-only (all ZONE_MOVABLE), raise the
+	 * dynamic_policy_zone to ZONE_MOVABLE so that only movable allocations
+	 * stay bound - otherwise this would force kernel-zone allocations
+	 * (e.g. page tables) onto a zone that cannot satisfy them.  This
+	 * results in allocation failure and retry loop (livelock).
 	 *
-	 * policy->nodes is intersect with node_states[N_MEMORY].
-	 * so if the following test fails, it implies
-	 * policy->nodes has movable memory only.
+	 * N_HIGH_MEMORY tells us "has a non-movable zone" for ordinary nodes.
+	 * Private nodes are deliberately excluded from N_HIGH_MEMORY, so we
+	 * need to check their actual zones - a kernel-zoned private node can
+	 * hold the allocation and must keep the policy applied.
 	 */
-	if (!nodes_intersects(policy->nodes, node_states[N_HIGH_MEMORY]))
+	if (!nodes_intersects(policy->nodes, node_states[N_HIGH_MEMORY]) &&
+	    !policy_private_has_kernel_zone(policy))
 		dynamic_policy_zone = ZONE_MOVABLE;
 
 	return zone >= dynamic_policy_zone;
-- 
2.53.0-Meta

