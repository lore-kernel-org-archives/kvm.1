Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.245.243.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509993;
	b=KMwpSSAYhskgBHLwTCOTg7i+LJmxacba3VRhglxeAj/jIMtpb6ShCTuUQcVtOukmVk9z
	 n8JgEGZHJ4FgV5b/J8lqsmbx10qK0dSdz8UbwIDK7qDA3z0Hyef2hUclqQjv4QUsUCDaU
	 0UKyMgxHB23NXqmwOJXeYeitShH9BHTo+DgvdvcpziAdhKfhzic7vh82/gsTG4RqEx4KN
	 5WNUY0lNlgsB1xJK/VtO/GUTPQBsNVS6y5w7kVlcShDZVpk5UCkZkVzbEK+ea3WidDMkL
	 qvdFOjoONvX5Tuwgzw3iLujmZpNx3++xhaEjRiSyLwfFxlrMrAI2jyRLODL+gocVa/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509993;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=W8r0smYz4HEryz1ZLoU5iRBXbrV3Eao6Txq7Uf61yT4=;
	b=Oh5ahrUnlAgwbE1n9WEr1Z+ulSWp3SgX+FMc5vhs3fp70UAjTo8wn5t5w7rc6AWnX1j6
	 0luaH0hIl6MdG152AuuvldgruTggpg0x5rIPTRi1oIDFAqzbgqPMkX62SfqViMXzKFsqx
	 +54DHiTwuNUp/W4ZwqcJGniSdMaBhn/2/T3bn+gS1RcDS9M439Vcu7Yk7/yiuilCnj3AN
	 7Qk5GmvfTXvhnEwjGidkjD4hsyLpjjejcyuZxW3npFStmfRm1+f4ejM4I/wu5fstA61SF
	 EFGXYdE6wQ5IV6xh+bkSifbYBdOB1HTxie/2fzQW/s1DyzctIsgD927pf0/qU2EU4aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=dRByhA0L;
	arc=none smtp.remote-ip=44.245.243.92
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADD2606A320
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 15:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ADD2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=dRByhA0L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1792509992; x=1824045992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W8r0smYz4HEryz1ZLoU5iRBXbrV3Eao6Txq7Uf61yT4=;
  b=dRByhA0LE7fnwsqteSpd+dXxMbYHppxoqhNlQimOlbth92P9FVyJcT0g
   h2+5efqxyppH2tcEa2ZyL2LyvKhFq6nfcVAfFWD8udc2OrKEQ9RFuheNl
   DB4/g/c+5PBDPDpaVQ890p3oiImOgoZjbzSDpbzsEtcYvHc0SWvpT5Qku
   U3Zn0Ga6kFo/KD3gHy8Jtey6RgkgIZaHx/Eyvm9KAw5g+PPuZXNTIH8in
   g0FxAV9xPL7xGo+Y2yON58+A/CEF+/0a0u7QBEHzMBvm2VqMap4XbK0Ex
   4YDtb0SD0gX/LdFnk9uu5Y+IjgM+3up+kXdE1TrrFK/C35Hsgxp8BBvU2
   Q==;
X-CSE-ConnectionGUID: lZ5mil7nT5KLN8YLcv758w==
X-CSE-MsgGUID: Z4465O6nQ36PBrF1l12zrg==
X-IronPort-AV: E=Sophos;i="6.27,168,1787011200"; 
   d="scan'208";a="31264057"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 15:26:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:30309]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.190:2525] with esmtp (Farcaster)
 id bc19818a-93fa-4b76-a4e2-eb23fb1be7f6; Tue, 20 Oct 2026 15:26:31 +0000 (UTC)
X-Farcaster-Flow-ID: bc19818a-93fa-4b76-a4e2-eb23fb1be7f6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 20 Oct 2026 15:26:31 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 20 Oct 2026 15:26:30 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: Giacomo Mazzola <gmazz@amazon.de>
Subject: [kvm-unit-tests PATCH v2 2/8] x86: fix EFI memory allocator to clamp regions to 4 GiB
Date: Tue, 20 Oct 2026 15:25:19 +0000
Message-ID: <20261020152525.57694-3-gmazz@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020152525.57694-1-gmazz@amazon.de>
References: <20261020152525.57694-1-gmazz@amazon.de>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

setup_page_table() creates an identity map covering only the first
4 GiB (4 PDPT entries × 512 PDE entries × 2 MiB pages).  However,
setup_memory_allocator() picks the largest EFI_CONVENTIONAL_MEMORY
region without regard to this limit.

On machines with more than 4 GiB of RAM, the largest conventional
memory region often starts below 4 GiB but extends well above it,
or resides entirely above 4 GiB.  When the allocator selects such a
region, any access to memory beyond the mapped range triggers a page
fault, crashing the test before it can run.

Fix this by clamping every candidate region to the 4 GiB boundary:
skip regions that start at or above 4 GiB entirely, and truncate
regions that straddle the boundary so only the mapped portion is
considered.  The allocator then picks the largest usable region that
is fully covered by the identity map.

Signed-off-by: Giacomo Mazzola <gmazz@amazon.de>
---
 lib/x86/setup.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/lib/x86/setup.c b/lib/x86/setup.c
index c2f1c6d0..09241b33 100644
--- a/lib/x86/setup.c
+++ b/lib/x86/setup.c
@@ -215,6 +215,7 @@ static efi_status_t setup_memory_allocator(efi_bootinfo_t *efi_bootinfo)
 	struct efi_boot_memmap *map = &(efi_bootinfo->mem_map);
 	efi_memory_desc_t *buffer = *map->map;
 	efi_memory_desc_t *d = NULL;
+	unsigned long max_addr = 1UL << 32;
 
 	/*
 	 * The 'buffer' contains multiple descriptors that describe memory
@@ -222,13 +223,26 @@ static efi_status_t setup_memory_allocator(efi_bootinfo_t *efi_bootinfo)
 	 * EFI_CONVENTIONAL_MEMORY region which will be used to set up the
 	 * memory allocator, so that the memory allocator can work in the
 	 * largest free continuous memory region.
+	 *
+	 * Regions are clamped to the first 4 GiB because the EFI page
+	 * tables set up by setup_page_table() only map that range.
 	 */
 	for (i = 0; i < *(map->map_size); i += *(map->desc_size)) {
 		d = (efi_memory_desc_t *)(&((u8 *)buffer)[i]);
 		if (d->type == EFI_CONVENTIONAL_MEMORY) {
-			if (free_mem_pages < d->num_pages) {
-				free_mem_pages = d->num_pages;
-				free_mem_start = d->phys_addr;
+			unsigned long start = d->phys_addr;
+			unsigned long end = start + (d->num_pages << EFI_PAGE_SHIFT);
+			unsigned long pages;
+
+			if (start >= max_addr)
+				continue;
+			if (end > max_addr)
+				end = max_addr;
+			pages = (end - start) >> EFI_PAGE_SHIFT;
+
+			if (free_mem_pages < pages) {
+				free_mem_pages = pages;
+				free_mem_start = start;
 			}
 		}
 	}
-- 
2.47.3

