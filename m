Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DDB481252
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576129; cv=none; b=XE2wiu2YSvoraXmIZug3OCbMomYBArnf/K/BZnMVBqM1Xr3pWIk/gQI+5HQTdIdyI3JbQjn2F+lCLEjKsYbeYiVgeQ5RBDCmeqmptvCsdjmFsrCs97XLMZtj9sbWZkCM9iV0kY78l697D2k91zk7RbbpaBV9/Bl2TSBFTwzVu0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576129; c=relaxed/simple;
	bh=AclVB29m5XEXwT6jfLm+y0Vje/ATQlFgKmkw+sbjY3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmRAVA7P4t5vRnB9UzHZwmldgFM2Pjbh4Md3dvK+CjLPdzlB2E+3uAf4jgZsips8/Rji61iLmwgYXbJ2u8mvnreCApZy/TLvRTfGp0ff6qv07itRdF7lDphcTggEGkoZXOfkEzPmRN3ddXKZaAjjP2yTGzt7ilbBAAmSN9rVSeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KTYLBPs3; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KTYLBPs3"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-907ae240ac3so1710216d6.0
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576123; x=1785180923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v2LDhxlVOpgNtSXDCdv8imM0ubGsvF9EJ4oiPoX2j2c=;
        b=KTYLBPs3dWcRB5tNY5Y315YJNYwSMrSW38ozrn7zBlvcl5Bgj0pNovXwYuhmdviEr6
         vGvh5Tm6m6ydUQi82zIG49v7mWgnbI4X0h3X9mabjFu39jmqmc0ad6N6+0VTgyeMRySg
         U67Thqs1ToMZc0ZR+8TgO8LsSqcKGdmBEkEQHgfrraLsi0CXj8Ba77QZxDY5AKvlIRFi
         6q/dihXzF+eQ9FAgtleDsSd4cK5HY0uc5r/y6rh1gmcA1PS8AAV7YHcb3xRC5QQMheCa
         vFx1oCPPO8nV4G83ZDlOcBlYxLNa8TfGyggXhkeXkCtRXY8EycNoBEI8uEixfJ4mDjdy
         lU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576123; x=1785180923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v2LDhxlVOpgNtSXDCdv8imM0ubGsvF9EJ4oiPoX2j2c=;
        b=SmaWPT+5eTefUu4u0J3fGwOQrtzdRAaJIsInk9XdLurWiT7VTOEwTTZ6aqfKlKB3zr
         v4Y+kMngOeMyGQtBy/D3CsDmoipiiDL/Aa3U8EtLI5RRs2QMJuKY9+uRPFsxLzmpEMEI
         MuduyIffjlyOXhhKaM25pUfQR0EZpIz3RvKSgAubm+HznP9VrAaWF0hkh8IW2AhrEOab
         pY8nkoaSGupWUnUBTQv2Daj9Avq9h3kADrYIRGGLy5D/nSArXqpsLcsyVO5sRcoH9Xdn
         UVYLFiwixnGw2eD46wkRSdlVVkHDENRX8x0l6rZb1Bmh7HzoWR8spdwCJZ4iUxUejlca
         isKQ==
X-Forwarded-Encrypted: i=1; AHgh+RpgpddlYee4vtpVBUmeYz7tV+cFyuqq1nMPpZMWGtHAD41Yocaw7xLdansM4BYaDf2ngWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6CKYnWwi4Z5r++7dEiIbVrOX5RyIiyAFQdau7CqdrpUKg6uKU
	g1LpDHL+Qd419tnn/on/LELpYyIZ+gNdCjkkYiNrSVu5gG0EbMs+DM3G1q82JOy5vAo=
X-Gm-Gg: AfdE7cmMfBN6qaWFS83+tisRNnhv3zkygUkjYlYXIamdQOreVCZRDnU7NOQpd1vGQaU
	cfvSynBdYKdo4KTlQ5N37I0ainBGdeMIZAIdTVQ2dBxMO83TN/MIRWxpgKsfQS/HCj9rOU4s3JD
	Y9dNYN6IrzX6zgKWfR9JXAx8dAUK+oYictabStVkqKpC3egtl0iR1Sj4REIIrRDStrVVgTHzKQ5
	ex51CvsbLYvf8Xv4ElkA7im32Ya7GuI1rWelA+vt9/CJzSOF6uhZijTSXunBaTdn6fUyX0LANTW
	yTRv2XIY5+pI0xUanaAulRUA6UxbVytO1xEUGEFhbSbBIBMcXA+yYgYl3Gqybjl3osMyifRZxNR
	657w4kfuI/ENF9W2tehWvuM9idca7U/UJdoJjtYuhsmZyNvmqEmpkGMU/0a35T9oBvQExwIs9gv
	yns2zkJxXKA/HQR06NxiCuudR7F96qziESlGJlDAbw8vwUH6fOUzjJHM8XoyDmpY9L/EcNruNAw
	A==
X-Received: by 2002:a05:620a:288a:b0:92e:f3ca:2ec8 with SMTP id af79cd13be357-930b3e4b8a0mr1508481385a.19.1784576122786;
        Mon, 20 Jul 2026 12:35:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:22 -0700 (PDT)
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
Subject: [PATCH v5 17/36] mm/vmscan: disallow reclaim of private node memory
Date: Mon, 20 Jul 2026 15:34:11 -0400
Message-ID: <20260720193431.3841992-18-gourry@gourry.net>
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

Private nodes do not support reclaim by default, so prevent all
reclaimers from operating on private nodes.

shrink_node() is the common chokepoint for most reclaimers (direct,
kswapd, proactive, mglru, etc), so it's the best place to filter.

DAMON's proactive pageout bypasses shrink_node() entirely, so we
disable DAMON in a separate commit as its own discrete service.

Other reclaim entry points are already covered - e.g. MGLRU's debugfs
interface rejects nids that are not N_MEMORY (N_MEMORY_PRIVATE is
mutually exclusive), and madvise pageout/cold skips private nodes.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/vmscan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e26c6931f5fde..86b2334c23b98 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6141,6 +6141,13 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	struct lruvec *target_lruvec;
 	bool reclaimable = false;
 
+	/*
+	 * Private nodes do not support reclaim by default, filtering here
+	 * captures all normal reclaim paths that may attempt eviction.
+	 */
+	if (node_is_private(pgdat->node_id))
+		return;
+
 	if ((lru_gen_enabled() || lru_gen_switching()) && root_reclaim(sc)) {
 		memset(&sc->nr, 0, sizeof(sc->nr));
 		lru_gen_shrink_node(pgdat, sc);
-- 
2.53.0-Meta

