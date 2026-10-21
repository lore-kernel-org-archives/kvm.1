Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.117.225.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614984;
	b=lLk/8G8Uo5Pok1lVtpvfVcj2ajMApj5Is78doI6yF7yoHhqR3YtVM6Sl4lcXPpqy3Bux
	 MZtCR4O/axTlVJggsqvv48QUo5wOc8u8qTrT+aFVL6XuNwl/kruD7QNKHT5ZpckvuxAOP
	 7bBG+d6a6HKgEgpF0Ay46iho5GdCYNiNL4F3l6yPQcJlIAkTgYxzot+dhVRQGC5rVhwg+
	 7wD+R3Jnc1qecN8L3ttk2ZxJ+jQ338dv0IhzwkFB1j4ZtU9gBH2eclnusAdd3w6D3c2F9
	 Lr/3fswb1KfsRTwOz+T7g2CHQjw/75pBejqfLaut9Eyh6GzRRozie09Dteq6WGbqwGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614984;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=tbceIaRF0sAuckuiO6cyxQdP9/vX0G/uVvpCY2YPfrc=;
	b=D+SAFNoDSfh0S3Lr/uGrmvcDzDeGC0Sf/BI4Bnzv5MlkcD91j7aBY71pkk9QiCWYldHr
	 vSwuh/NKU+PVcvv6G/DTo4qaG9tXjXev60oUf+EGyyyNmRvnCsH7XaZ5O5otylFaF3RiG
	 qP7O2/TRYj4qysMz+ZauPDN/HmlXvp3DSd/tbM6GSQ4nzb5N+abe+YSrBIhgYLDGvvj0Q
	 zGLE2faHIbnqSbw3GwTxNl01xXNFQ5ypooXWK60h3beVQdEKqOInBQl40F7a4xK7XHbNS
	 0XUiYHZHN7kN1z5+bdHeb66U80LrLn0dA1L/evM/kInEIfgYSuc7c1yVXBJFbOeK4jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=ShpT2mht;
	arc=none smtp.remote-ip=130.117.225.111
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AEB606A31F;
	Wed, 21 Oct 2026 20:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53AEB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=ShpT2mht
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=tbceIaRF0sAuckuiO6cyxQdP9/vX0G/uVvpCY2YPfrc=; b=ShpT2mhtcIjao9HMfss
	jXF7S4rKU1qxrdXq/oerjb+AA9xKx86xQW4rVJcpTdwN6GZi3Ko03fok6bTdeQmb9HLFJhC/LurPW
	1vQvll05taTdW0NaVp8f8eYgYZe+1epvUyhyliWeJsPezDRk3ikw09d6PCLoOfsOIvbJnLtepWDc7
	770hBdGBt5KnoFXUorGIvPN4bqx6So+zy2P1wOKtrmnLIHwIBZjXTG8O3dnlK/61VVFjzmJad2pU6
	uuZzEx1oTR8I+jU8m2RTFniKH0ugGCrSddrm0qHfJ1vCBbLSvq8/mQ5Qr0H1zCbcujPoWNMgHY7+g
	nBKgoTqn5gaSY7w==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xJcz4-00D9zC-2y;
	Wed, 21 Oct 2026 22:36:09 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Wed, 21 Oct 2026 22:36:00 +0200
Subject: [PATCH v4 1/4] mm/rmap: duplicate a PMD mapping as one in
 folio_dup_file_rmap_pmd()
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-1-66f00b7a564c@virtuozzo.com>
References: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
In-Reply-To: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1546;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=zhntYNSyNOhAa1ZPHwaiFUV3wOk6ing6WAMJ8CgrgUQ=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBq2SI3kTt0eGcvGYVZkf1nokMQHDfejBZY7fajV
 0TyI+y7YxiJAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCatkiNwAKCRBRlgpH+WFc
 KgnAD/4ojtuF4NBnUvfl/Psk86uzqUN1kVtoLEKMaMThvlqW1s3hK5DewNJbbtEf8Kazy+pGsy7
 2MNBKYRUNiZDEhZn/2DHUE1gt+A1tVbizNXBa/MWAiM0mHN4ngFsKzIt8G4YzVFPRIiFTv47n4W
 UzZ9V4zYqU+0s0nv2SkSdgabyHn+IOd37dsdB1FOWbqkMfFafvXpi338tn8jdGLrv9NurDGPBXa
 JZN7A4rUTj1hDfc6KXc2+NthJvKbdfaeHECDDIrCgp96JMX4YtV1Oq6Vo4PNsA+spLXB6gm22vs
 bt8zKJcN2+rdAim5R+CHKro0V0Fp0XAZp4Xj82XaDXiCzDfPcKc8FDuP9RDDvxj6RzW+X2RIO0E
 612Fj+ImIt3/D5SW82Dj9MLXESvv7BYtG4DMGFZ7XcgRqlHZpzwiWRnWvsGrxcJKt2wKFFMBlJH
 cuLulc+7fr3I4ndV99zx4sbup7C77YzhIsIspwXhd6cDjs9nPaznCZrSIcs5vKegskyHFrqx+Db
 rqe+t05922C0eCwL1UxqL2hupnKSl4lwMd1mwvKy9yhaHtuSKLRavqalIHyXq5zh+tUCFdTvAP+
 kEDIzV2/fARqYVLPRiGeTeSch5+t8I9q8grSh7VIqydeFZPMIov/cihVtwGD8oOVUOK0w5eQsBw
 F++lxfRANMnnNdQ==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A

folio_dup_file_rmap_pmd() passes PGTABLE_LEVEL_PTE to
__folio_dup_file_rmap() for HPAGE_PMD_NR pages, so it adds HPAGE_PMD_NR
PTE mappings to the folio instead of one PMD mapping. Each unmap of the
PMD removes one PMD mapping:

- the folio's mapcount never returns to zero, and removing the folio
  from the page cache reports "Bad page cache", or hits a VM_BUG_ON
  with CONFIG_DEBUG_VM;
- the first unmap already counts as the last one and drops the
  PMD-mapped statistics while the other mm still maps the folio;
- the second one drives the entire mapcount below zero and drops them
  again.

The helper has no caller yet, the next patch adds the first one. Pass
PGTABLE_LEVEL_PMD, as folio_try_dup_anon_rmap_pmd() does.

Fixes: d8ef5e311d7b ("mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()")
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 include/linux/rmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 0b332770abeed..7562017416094 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -558,7 +558,7 @@ static inline void folio_dup_file_rmap_pmd(struct folio *folio,
 		struct page *page, struct vm_area_struct *dst_vma)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	__folio_dup_file_rmap(folio, page, HPAGE_PMD_NR, dst_vma, PGTABLE_LEVEL_PTE);
+	__folio_dup_file_rmap(folio, page, HPAGE_PMD_NR, dst_vma, PGTABLE_LEVEL_PMD);
 #else
 	WARN_ON_ONCE(true);
 #endif

-- 
2.43.0

