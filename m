Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7972432BFB
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576104; cv=none; b=iZNZB3+Wx+EOZTAaQm4JRdHc/gXU4Yk9b0hFY0lhMzEMPEfb7p+QJclChUXNzUyo0uHZ77w6JNNIc9bXITbqp6GEdXiiay+oVhk1e2jJF/IIwWqcwg8hg2OsFGG9U/6bG3nZ3yo7Y18gP8mTKv0sJQ/uFFbZ5sEr93akw7WkQ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576104; c=relaxed/simple;
	bh=xKT776XlTabqIrpZUU7blZWBtbRPmP402l67UFe57bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srTuJfS59bqX/NQcSvxsAulasDx2x8T8pyhXMN4sSZ0CYH7xcs3g+Xc+2B5OaLH1xBO5suuJSczsp6aZnqvAo/LlZ3xSkpz/sm7j6K2ifG5B9qoloPA26zceXocULdbMBuX07DBGeX5OS5w3aibeQtvfmijFhO7voXT8CTleuzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=W7qL1pau; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="W7qL1pau"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-920f33347f5so818344085a.3
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 12:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576099; x=1785180899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nhj7NM8i+En2OSlvQTOlJiWxfz3FRJxBEkctJdapuZ0=;
        b=W7qL1pauLC8z+ELFwlAMYEglswLPoQq/jEOV4fVHXa5R4YJN0Cf5Iiz5jTbd2i1Z8N
         sposxAFw7DeZw1z/BtTqqWEQwpE3W84l38eiQkFdI7/HKAeYzOhHXIpzsgWErXRb09yO
         u09M4bxAGYEAqHy7B/QNgajyGO3e6QAnJNxyGgZmS3R2Za0yhp28lx7NvF3BUp/s76cX
         QSkTDpfFZloMAjeqtf4+UVSIFFbHqFvq1tEVY9Gv/tZJVqAkZmkaaFs0zyhxBQqv8Vc6
         0wDJTlmt1wIVwfv5DzIVDThFPTUkh8a52O5ajKmJaUbEBmxBGztVyOeiiEgbren+Mg0j
         o1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576099; x=1785180899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nhj7NM8i+En2OSlvQTOlJiWxfz3FRJxBEkctJdapuZ0=;
        b=AiQ2MX20XeuIQIy8ZveONcdQMYeUeX6EaWn7NkO08PCTtrIgVzq9uOLDj6NM/vddrN
         s8JI6FZRQ9Yqlz56DjMghzsLiJqNDoCWhqnaN70IDbvtvf8Vxc2SQx00bXIy5sXzJTdq
         bVHTueQ4SoiODqmGRNenR0+agStrcNMuDujqNIi6lQl0uCeOAfIapuHZCMrYkh6Q0SlB
         sWfGmFG3BCp7ZWgA7z6BLfsDjpnL6MqpAjLQ8nn1jqxTCbg3SICP4wSwzaq9+Ql7xxOa
         8HJzZJVFSBpawCdIpjlId94qbd1Fv45+J4g179a8IfLiY9+pV9f6Gmqw6zhcLqkVzqXS
         Jung==
X-Forwarded-Encrypted: i=1; AHgh+RqsX3UMRMpdgqtvNFIXSsFyP3Xi6+XQaWmeeY6cAlFfUat/70nnn7EuFF61+UbYCVS2Oa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLjLX1wNq5bYsTTfNTzpezwQLBN+lIQJMnqu3qtG4IK0MtacNe
	y+f4nrqJNWupLC0l+TpNp+WE727JUExuX001cMlPJL93beiXTeN+Zb+GEe/a2b+DCHc=
X-Gm-Gg: AfdE7ck7ZZ+dY+c5Nln90F8nS5dDFj3XNOWo4/9Sy2Vh0INZowG5FIA6ELtAD0J3Lck
	Jys/kQEulC1gcb8iEmfUEofmSPfIteUFWU/qy0VWDx/1xTkealIPypai0IRoAP2mO5+vCKXYUis
	0WC/ccvNXy3xz6Mu1i1WDmLxc0o0KJPsS2LGIxP9HC8QMiuMLVUSa1EK13pw72okySMhDub7qqU
	YYtSLLDXyPCTW8zAL+4vQHbyfTXXRRGVfQ92oQCpYjCpXudy0rGY3GuNyQYioxenF8Jo3JE+QUk
	UO8DZo+YPkK7W5LpTUN43nhnQlRxi3PekBUHtI4pWkWBBX7NIwJqH8g1lX3N3QQ3dTyDH376XNI
	zgdgAeucFzjILGwvlhBNwZzhW6ceP87aXKFmCSpzkVDc/8EwgPNBv73rgThNhPUYVjxiNZ6A85t
	FpctZi3aW4DjrayZRItRbYxLbhoN1m9SL0ZMdpat1uXR54csI26cEBbnxn5IRO6Ys=
X-Received: by 2002:a05:620a:4551:b0:92e:be48:80c with SMTP id af79cd13be357-930b41c232dmr1527846385a.57.1784576099368;
        Mon, 20 Jul 2026 12:34:59 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:34:59 -0700 (PDT)
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
Subject: [PATCH v5 08/36] mm/mempolicy: skip private node folios when queueing for migration
Date: Mon, 20 Jul 2026 15:34:02 -0400
Message-ID: <20260720193431.3841992-9-gourry@gourry.net>
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

Private nodes are already kept out of policy nodemasks (only N_MEMORY
nodes are allowed), but an mbind(MPOL_MF_MOVE) walk can still encounter a
private-node folio in the range.  Skip such folios so mempolicy-driven
migration never moves private-node memory.

We already do this for ZONE_DEVICE folios - use the same filter points
for ZONE_DEVICE (with an additional point for large pages).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/mempolicy.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 5720f7f54d942..8e8763f6e5f5b 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -111,6 +111,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/printk.h>
 #include <linux/leafops.h>
+#include <linux/node_private.h>
 #include <linux/gcd.h>
 
 #include <asm/tlbflush.h>
@@ -668,6 +669,8 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
 	}
 	if (!queue_folio_required(folio, qp))
 		return;
+	if (folio_is_private_node(folio))
+		return;
 	if (!(qp->flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
 	    !vma_migratable(walk->vma) ||
 	    !migrate_folio_add(folio, qp->pagelist, qp->flags))
@@ -722,7 +725,7 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 			continue;
 		}
 		folio = vm_normal_folio(vma, addr, ptent);
-		if (!folio || folio_is_zone_device(folio))
+		if (!folio || folio_is_private_managed(folio))
 			continue;
 		if (folio_test_large(folio) && max_nr != 1)
 			nr = folio_pte_batch(folio, pte, ptent, max_nr);
@@ -797,6 +800,8 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 	folio = pfn_folio(pte_pfn(ptep));
 	if (!queue_folio_required(folio, qp))
 		goto unlock;
+	if (folio_is_private_node(folio))
+		goto unlock;
 	if (!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
 	    !vma_migratable(walk->vma)) {
 		qp->nr_failed++;
-- 
2.53.0-Meta

