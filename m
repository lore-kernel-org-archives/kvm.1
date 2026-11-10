Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283723;
	b=NDWFiG/VeFG605c2wHFu55lzPgPwNAVkZD1nvo53buqe10W82EJolB+EayUdDUAE4qoK
	 9OYoynb+YXsgLJJd5XuxJvWM1zGXEltfPvhxLNVnhnu23G6HJpEVOFBOKBA1bIy1vyiAI
	 qUaeKiWjQdvm6MPgWpIHo/J14pz40abWyoxD+ECDGw+6PODle+dnq0u+Q8GJWssud8gIb
	 bclWowTRk9Kewu4bKCyTYvTAW5zkmXygixu6NioH9LVB+IjG/sfPDbVRM6ToNZON6MzWL
	 QgNcmVua12v2FyM342c94p+DK63zkKtOOzfFqak0SvpWQ8IYhZ4XJU3K6RZ9mfbfoiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=FuJECyUteBIYhk4zt7IpaezKNFcH3wE4eNPgkjkn+yw=;
	b=3IucIa0ISSWBBf5i3lUV+DAxC9maidbWGgNXEm+s7xgJBjWCgFWnYDFN2eYof3IvuvlN
	 iREer6alqEVdrW0jA1ZUn/ucyhXyOcjm0ziXhA+lckD2qXna4E4kH6sQ/ZNVFVWd4LtDE
	 oSyQwWnvSdBfu8w12Gtio0Qau1z8fhcPmx9rQ2b1qEMiri2UGZueGowX6FsoA5RGYLxfr
	 gnxip47BERNbq1Od50XMUl+zuQ3egNj/1KGcIFtDNjfp8cJuxxjOBOZss7/VOQCNPVhjo
	 Y+d95BOe67SqV6SVGhlQshKt7elgqc17E3N3nXnj935ywoxXWjS/tNGTNpBkxEtmiAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bPuTVKkb;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A0260A6F46
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 04:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95A0260A6F46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bPuTVKkb
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdb45b4ed6bso1524926a12.3
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 20:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283722; x=1794888522; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuJECyUteBIYhk4zt7IpaezKNFcH3wE4eNPgkjkn+yw=;
        b=bPuTVKkbZYnpKl3IShg+yxB1pZv+Kt4aaW8st+LyEzRAbsGZMfb51PKmVr19+xj/2h
         P048pgJraK6Z0yEuCBdIkEq6AiEnCNhf/8gTS4a8WQaVSyP6hCOEVuFYVakRwoH5mWgC
         exCs2jTP55AyYdHrg7qY0mpYosQqDXzWdGQ8U+IcpRnuHBeMa5W93H09XTZAQSVMSxAg
         Y0kn63i2T7fILuEcWiYCNtDlIMzsBAWesfj1gxih+9Y/9W2KrILAIHNMmX7Nvwd5kxiw
         ersOuXHOaRqQsU9GEl9NDpuqlS8uaInI4bz3ZII7HdGPANQ5nh9bCFesc7tziU5XIOdY
         6t/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283722; x=1794888522;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FuJECyUteBIYhk4zt7IpaezKNFcH3wE4eNPgkjkn+yw=;
        b=UphCubwPIqpj31HmWP1jwEoRp5Nz8AZnMhdBJtwrV4jsjglGM1oN6hOhIYGlOxcKf4
         LViJZ212Bg4XIg3+Ju6lZfT5Mn4sYvsuyIqRimkjKijfy/HN+hU/0HaEMlAkIqkE6jwr
         TZy210fm2FeMF+MUvzFCL4OsuWK/xF30PG1gvXNqgv1x/vRamc75MRHK9vamhEeKeDQ3
         zUC39j0vZ8IeUtWb1IbZEyjRyLVMjFmFRhLStJoDXbqYRfkwFUjSDvlG1uzHy/tWg6DO
         cd/PyOD/vHh9XBF+B5juS/X/REuvUZ+92WqeVUu3bjE3f2wUXZJ3Kj/9jN/PNIJ6w4Iz
         xoYQ==
X-Forwarded-Encrypted: i=1; AL+hErErYP2suIqL5eZXhXc3t53C0Iuze+gSbPb+HOKFyf16pETWGV3s/K4OegX8lXnDNDIsKBI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xf7Mz1gK/vXxzVwef5CJmD00gPFRcRqiYf6ndC63ISE4n9/sx
	ZQHhTgvLh+GKx6PSD9VBRym9EwxeazHP6CB5UHUyyBubhAZ/OxpKIGN5kZZP50SFoMe0wIxHHY/
	TM7yHAHRRjtZZQA==
X-Received: from pgmn6.prod.google.com ([2002:a63:5c46:0:b0:cdb:91f4:387b])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3b46:b0:3e2:a849:64bc with SMTP id adf61e73a8af0-3f18c1166aemr1076569637.9.1794283721794;
 Mon, 09 Nov 2026 20:08:41 -0800 (PST)
Date: Tue, 10 Nov 2026 04:08:15 +0000
In-Reply-To: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110040828.1774343-10-skhawaja@google.com>
Subject: [PATCH v7 09/18] iommu/vt-d: Combine disable_dmar_iommu() and free_dmar_iommu()
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

Every caller of disable_dmar_iommu() immediately follows it with a call
to free_dmar_iommu(). Combine the two helpers into release_dmar_iommu()
and simplify the teardown and error paths in init_dmars(),
intel_iommu_add(), and dmar_iommu_hotplug().

Also drop the early return when
WARN_ON(!ida_is_empty(&iommu->domain_ida)) triggers so translation is
still disabled before freeing the IOMMU resources.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d31d2d5845e6..6c86c155d12b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -985,21 +985,17 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
-static void disable_dmar_iommu(struct intel_iommu *iommu)
+static void release_dmar_iommu(struct intel_iommu *iommu)
 {
 	/*
 	 * All iommu domains must have been detached from the devices,
 	 * hence there should be no domain IDs in use.
 	 */
-	if (WARN_ON(!ida_is_empty(&iommu->domain_ida)))
-		return;
+	WARN_ON(!ida_is_empty(&iommu->domain_ida));
 
 	if (iommu->gcmd & DMA_GCMD_TE)
 		iommu_disable_translation(iommu);
-}
 
-static void free_dmar_iommu(struct intel_iommu *iommu)
-{
 	if (iommu->copied_tables) {
 		bitmap_free(iommu->copied_tables);
 		iommu->copied_tables = NULL;
@@ -1867,10 +1863,8 @@ static int __init init_dmars(void)
 	return 0;
 
 free_iommu:
-	for_each_active_iommu(iommu, drhd) {
-		disable_dmar_iommu(iommu);
-		free_dmar_iommu(iommu);
-	}
+	for_each_active_iommu(iommu, drhd)
+		release_dmar_iommu(iommu);
 
 	return ret;
 }
@@ -2280,12 +2274,12 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	if (ecap_prs(iommu->ecap)) {
 		ret = intel_iommu_enable_prq(iommu);
 		if (ret)
-			goto disable_iommu;
+			goto out;
 	}
 
 	ret = dmar_set_interrupt(iommu);
 	if (ret)
-		goto disable_iommu;
+		goto out;
 
 	iommu_set_root_entry(iommu);
 	iommu_enable_translation(iommu);
@@ -2293,10 +2287,8 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	iommu_disable_protect_mem_regions(iommu);
 	return 0;
 
-disable_iommu:
-	disable_dmar_iommu(iommu);
 out:
-	free_dmar_iommu(iommu);
+	release_dmar_iommu(iommu);
 	return ret;
 }
 
@@ -2310,12 +2302,10 @@ int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 	if (iommu == NULL)
 		return -EINVAL;
 
-	if (insert) {
+	if (insert)
 		ret = intel_iommu_add(dmaru);
-	} else {
-		disable_dmar_iommu(iommu);
-		free_dmar_iommu(iommu);
-	}
+	else
+		release_dmar_iommu(iommu);
 
 	return ret;
 }
-- 
2.56.0.506.g506a7eabc5-goog

