Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7576480340
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576122; cv=none; b=KYFS2npt2Jty2YYVlXipKOZR7mpqTRFMaGQiQPQsqHCRUEXDlNuOVyR5HlgBetc6M03HH/Q6JRuMOty7mGM+V/D2l2EAUVrffaiuhK/6YiRrwixLo6At8e1HBX++oTRjRVNxSI9VucHcI38Bz6FOLrcz4Bgno+Vhfz5E8DMcUUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576122; c=relaxed/simple;
	bh=wTYQxiwnnNn1fQlaf49KQEuG8RjOnNBI3U36p9hX2rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXwI5Um3kQWh6zdbCyxPEwu3D0cx084ESt7kSlaaEL1m/a7tY3t8sqznA8mIBev4mwbnlLiBwPNhMMCL3X0knOFSVIi/0KnhU1sUhKA3Ebs9nvoBsdJJs6bGhZY1coaS0pksF93AxAgw72o+I4b9OekGJQBXF9jerlmiVPqEllU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=vLMs9sBk; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="vLMs9sBk"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e6c4a867cso465776385a.0
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 12:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784576118; x=1785180918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HgkUnnQve0Rn/Pvs0Z/0q3yFfFJ0c7Ckz6K5pdtr6eU=;
        b=vLMs9sBkiBOQ7nWM2/JvINrnxvZuXiHaXQoiMxPSr9eLnxFZ+Jzubfq8+Y765V6jXH
         Qn8sZ2I2RIRe0s69fsIAccrMwJQGCsw8WCY05tISAT99hWL7opQyW484byM6FeBWNaka
         m8yYTUY6rBYH1WE5qrmHC8lRhBH3osqitPluMLWB2m5jHl/iIAHL4mhmjmPkqlZ6M4n3
         6kxnHP7O1qeE8JGHbnySHwQdHdAcGUIsO8lJmjhLJSppROXwONURxUzeicmaHtBoahjW
         kfzSqFvXdhsznzyA2nTDknEFEDy98eJefQV3l5V0+vjf0VGjoLjx3uEklcDvL4B5rIL0
         HlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576118; x=1785180918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HgkUnnQve0Rn/Pvs0Z/0q3yFfFJ0c7Ckz6K5pdtr6eU=;
        b=M8ts/x1to3/zhtdZat0MYo242XzRRIxcBdMx5PYEcAWgzR9XFkYjVq3uxujjxN7pwg
         oppC3EPvIopo3iKLYiEjKUbUZgZPLf4js4ivAxkwdTm30xa1/3/mNFrt5Smff8Z4uOVw
         pegQ5miQyCcQfLpS4fdRHXMsRW4hOSLKpbR9okgvMGT8fQvFi1ON0TQsyUgentS4VSSf
         QaVih8+PRfEOo1e9TXoL9ace29EWSG5tpT9cJhSgvp4k7T1tsQl2LXNT09MA+J5G4ldR
         CvXsz5qf0DvRP02fhyN2OGVT/C3oofOo7BDhUvpNxewtvQMDrKnZgof9yuJ0boREI33x
         AtNg==
X-Forwarded-Encrypted: i=1; AHgh+RpEEbLn3e6O4Z4IOZ0ipOqgZRYfpyEtb95MYf1uR0nRMmrF3lVLdx9rb7IQWZo5ve861wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKwdGvjaJc0MQIO3ZXtEJj49MDY8Pu0GbiYOxXu/s+YSYk9MH2
	4yOfdS7CwbODt1XN93Polf1sjA56xbmNGTnlbWZHjlphCi9+JNLsWfR0OyFMmmMijk4=
X-Gm-Gg: AfdE7cnm+7Sum90PGd1eHeJqFMLarMT0IdF+pr9aqOtap/KlKSm7C1jNgpH/BsIdJFW
	OMP1Lx3aXk+26GOc5OwDhFJ+z1ZkW7kQxM9UqygbhFJgFisB4i3kKVfWxWOTlVu0SXU+D1sSn5S
	Y7kcPncJaUYRuE51j5+dWngVnlt2YOwAb66EDgFFrQhLclbDoLl9atZ4UuajptO6hoQhY3keF5B
	+Z8pSdPh+XLJgriv3o5OHZy5d3B8jhKSEr0AOFPvwiIIPJ2lPs9EBPHEY6gqJVBZVQivJ9GqFYV
	dV4W2d/dArsSrZ8ukeGGRJdxWMEj2uFn1rHTqHmcZNqTqj2JrPrPfjyDk/OxYf71gAiGkeYvXPE
	teFqN9z37WldojAg37WzCQFzpE9jnAJnEdrZApM7ayhiEY6cakCy9ha0HMubdoRERycKLl7POin
	fNp2KxJDpPNNQQvJtWdjYLFgMbNq45ZRPyj+640wh7BrzCcu3H+mPvLoodm1/2b1w=
X-Received: by 2002:a05:620a:4007:b0:92e:c116:bef9 with SMTP id af79cd13be357-930b4315599mr1572701485a.86.1784576117793;
        Mon, 20 Jul 2026 12:35:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e47bsm957792285a.35.2026.07.20.12.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:35:17 -0700 (PDT)
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
Subject: [PATCH v5 15/36] mm/ksm: skip KSM for managed-memory folios
Date: Mon, 20 Jul 2026 15:34:09 -0400
Message-ID: <20260720193431.3841992-16-gourry@gourry.net>
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

Since private memory is intended for explicit placement, allowing
KSM to operate on it by default would completely defeat the purpose.

Skip KSM merge and scan operations for private node folios using
the same filter location as zone_device folios.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/ksm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 47006f494fcb1..dcc5c46a29eac 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -827,7 +827,7 @@ static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 
 	folio = folio_walk_start(&fw, vma, addr, 0);
 	if (folio) {
-		if (!folio_is_zone_device(folio) &&
+		if (!folio_is_private_managed(folio) &&
 		    folio_test_anon(folio)) {
 			folio_get(folio);
 			page = fw.page;
@@ -2558,7 +2558,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 				goto not_found_unlock;
 			folio = page_folio(page);
 
-			if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+			if (unlikely(folio_is_private_managed(folio)) ||
+			    !folio_test_anon(folio))
 				goto not_found_unlock;
 
 			page += ((addr & (PMD_SIZE - 1)) >> PAGE_SHIFT);
@@ -2582,7 +2583,8 @@ static int ksm_next_page_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned lon
 			continue;
 		folio = page_folio(page);
 
-		if (folio_is_zone_device(folio) || !folio_test_anon(folio))
+		if (unlikely(folio_is_private_managed(folio)) ||
+		    !folio_test_anon(folio))
 			continue;
 		goto found_unlock;
 	}
-- 
2.53.0-Meta

