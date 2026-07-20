Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DEE42A17E
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576102; cv=none; b=JScy3kAp7M8+7338K3mwKn+4kk0wkrsRlp2GhbLRIghH3jvOlwg4g5/0aEz4t62qxjW56/XkmAFHtRMFXPqaE158pN/wqF/0UXp4ME4evJUrpNhGadsD+KXDpxwAtGteezgbWN6LGmZkdlZxL7smBzNVmaTYHqE42gu8r7gBrgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576102; c=relaxed/simple;
	bh=5WsZz3rVrHU17snClfl3M7UsKRdvN7wn8MZmoue9j4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p087mQfJ+ee6g8COoeCjjLBLURqWyV0g6TW/sowa0pyVjrH0gNZZ/+HYARsRSkLGsR1yQnAkCPm8Ot7Qz6d9WHqC1LslhJk289e3KbiiMlUUtSlR5FgsSVHaWR4oq+9/Eb6F3lFTnJ2D8s67eCT5ScHKfLde3htOHLwZM1y8/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AeO2JDVY; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AeO2JDVY"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8f18d92172aso93701796d6.2
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 12:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576097; x=1785180897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xdEOlYqIeVdUG1DfkuvgY4asc0OjHWyQnI3tw1EXx60=;
        b=AeO2JDVYr4O4Zalcb0OS5SE9Jc10O2vFAgaj9xZdut8hoHmRchSeoKM0BvhpKROxAj
         TpuEQQHgBvlffX0b8VIu1nV8QGREocf9JjP9UxFZ9eQXVahhg1tRrUD9A4iLJnjqnU/D
         XIPoxcFJZpI2KVfzaHdaKMiYwn6HUcDzRSXafy0wt6fsDi7jgUlsm4Z+YkBdBlbXgULG
         RMbHG9yXaXWjXzjsV6CaTm5w4lwraNEUyE/0uyFHlQ3BQoNARJguOH8jZENaA3p2vTJw
         Yz9e0Q/xakbbN00AJ15b+UP3MeSow5DU3WquVLj2BDWd+eB4x1EcbXJLqt210bh7OWze
         Ik5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576097; x=1785180897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xdEOlYqIeVdUG1DfkuvgY4asc0OjHWyQnI3tw1EXx60=;
        b=GzJ+6AgcB7w3Axtza831BDwDBpvpmcSnow++ZBhVTsh0ZMi58HpevkO/K/REB2ScxZ
         1X4QdNhQBtJ8xndQnKnM9WkevZs0KTDYvGRHtkzGoJv2SyBWg+JXjRfe3r2Y0S5ypOE9
         ixdIGdJX2lBWYxqhzrwFxa3pKPUtAy3fjFU7wWib/ep3CrWYoHj6S0zU8kahAmm4f6zO
         zu2BJ7zVe09nblsFAvlBoiIkc+XndDIYbUMDES9IwIcu4Iq65D0Y3V6GeNTa58MDt4zP
         OBnk7mm5a+siH+XPivLMggUs/QRaT+ii7f2FD1KRQMxBa22sNkh+pBWjyR41tuYopzEd
         kI4A==
X-Forwarded-Encrypted: i=1; AHgh+RqLNXZR2Gis8/fDDhEZSThxbpfDdQfDPHcQHM3C8kNQSbK5jCD7urQLXb+UBKs7W9xKh5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQPy7EAO2kQ77MZRA8I2hDtzx2M84fN5GMzpYl8i5faUZA0p6U
	5rJ9fphr9QXDEt9JQjRdkKobvFBvO4YiECyQ8YeNSzi0tMi4Jw7bglwDj5SgdF0/Jfk=
X-Gm-Gg: AfdE7clFP2TM+oOWd0nmAxyW1t7GWWC8vsWKmQtyUgRPejrtyy/tM2YZZ6mNmgTbNZf
	7qtU6IQ9Jk7kZpoySu8kRrUzpYDSjK0OmSe/TbQLzjjK+1nIRcQCoa2YBwlF5EyEMmMlCGxUVKh
	XRdjc3gD5vvP8oiTT3nU9cia8hJsPS4DQXeuRyr3FJnqGhPbGLrSTAt2FNHOGEcNM8G+vyf0iwn
	A03MF725AHz9xl7fvJxePhtvSEdLsrseuv2CdzCUs6Qkgl89WHXxATNr8c4791RFJB2M+xqC1+x
	0lcQV/S8G71FFX/loFES3O4G9Hj1QN2j8Zk5XNFKpS1wgYEbS5Qm8cyMkXeDr4BxMsfiXmUMSpE
	o6rQ0E2Xyl2xtSk+Mzz7LS2t0mzvZWssXLz4FeOBtW0JG8i3W2kUYb1Fl6kquFe+1eVk7Y9XsgK
	WGU80h2YzJ3BJrMY4aTfkBc2bEng29jKy0L3FIhRHbVmcJS9YxZ6Zl8oxMIJFRhXQ=
X-Received: by 2002:a05:620a:a2c5:20b0:92f:196:209c with SMTP id af79cd13be357-930b41f9aa3mr1179416785a.71.1784576096734;
        Mon, 20 Jul 2026 12:34:56 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:34:56 -0700 (PDT)
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
Subject: [PATCH v5 07/36] mm/memory_hotplug: disallow migration-driven private node hotunplug
Date: Mon, 20 Jul 2026 15:34:01 -0400
Message-ID: <20260720193431.3841992-8-gourry@gourry.net>
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

By default, device-backed private node memory may not be safe to
migrate without coordination.

Do not attempt to hotunplug private node memory, instead fail the
hotunplug attempt, and require the owner to drain the folios
safely before allowing hotunplug to proceed.

Unlike transient / longterm pins causing failures, this is not a
transient condition - so we can break out of the hotunplug attempt
entirely instead of spinning forever on a failed migration attempt.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/memory_hotplug.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 226ab9cb078ad..2b9c0830821e6 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -34,6 +34,7 @@
 #include <linux/memblock.h>
 #include <linux/compaction.h>
 #include <linux/rmap.h>
+#include <linux/node_private.h>
 #include <linux/module.h>
 #include <linux/node.h>
 
@@ -1843,11 +1844,12 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 	return 0;
 }
 
-static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
+static int do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 {
 	struct folio *folio;
 	unsigned long pfn;
 	LIST_HEAD(source);
+	int err = 0;
 	static DEFINE_RATELIMIT_STATE(migrate_rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 
@@ -1884,6 +1886,15 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			goto put_folio;
 		}
 
+		/* Private node folios cannot migrate, fail outright */
+		if (folio_is_private_node(folio)) {
+			pr_info_ratelimited("memory offline refused: node %d pfn %lx\n",
+					    folio_nid(folio), pfn);
+			folio_put(folio);
+			err = -EBUSY;
+			break;
+		}
+
 		if (!isolate_folio_to_list(folio, &source)) {
 			if (__ratelimit(&migrate_rs)) {
 				pr_warn("failed to isolate pfn %lx\n",
@@ -1931,6 +1942,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			putback_movable_pages(&source);
 		}
 	}
+	return err;
 }
 
 static int __init cmdline_parse_movable_node(char *p)
@@ -2067,10 +2079,11 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 			ret = scan_movable_pages(pfn, end_pfn, &pfn);
 			if (!ret) {
 				/*
-				 * TODO: fatal migration failures should bail
-				 * out
+				 * A fatal migration failure (e.g. a folio on a
+				 * non-migratable private node) bails out; transient
+				 * failures leave ret zero and are retried below.
 				 */
-				do_migrate_range(pfn, end_pfn);
+				ret = do_migrate_range(pfn, end_pfn);
 			}
 		} while (!ret);
 
-- 
2.53.0-Meta

