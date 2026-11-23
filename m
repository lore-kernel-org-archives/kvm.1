Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409402;
	b=AJHZ/oYtq6I/YqRiSNd2W375k8R3KYe+W/wbc2eEahHFHhEE1NPzoXmJtEjQeGuGQRCQ
	 bsTLn3TFLH0FwFR6HTb0vDTTzR/8XNsYs2/oUMKzVwba7B69BClCPT3cJJaCXicl/BSEM
	 mId0qaizQAs5iSWChUoVKjbftjKZbWkyKulWLUGZeyt2j+wjIGmilDsVSQuezFGOpdn3+
	 OfJOWph2FFD6J2FmySnRwpDMRWzVC7zOQoqkl7cT4gGyJIqwhrNXo3S7HS0Qq68k4gwgc
	 9HOA87njdvQLHKx81H25xk6GCzeKakdcnhhe3lHZle4I8JPmijzGwvZhPQxYGga3Pig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=6MNIHKKL1TyoX4SD1X7Fi8nLR6k5WbA5DIiwx/onbm8=;
	b=OQeS3+VSHBlzODBx8t+zrhYD5b7Y01mp/mtbFVwr4vZw7VpibG7b3llxZzG2mA5WewQy
	 H/nd7Ggz7o+PNJYALJEqNUuw+SfyevXB1rzcCiYO20YQRkaPmCGLzRMwVplO/xDh4ML+J
	 8ibt66qYMmgc2TGsWFawbmw3/CBilrWsrxbG+AoTLS5NnIhhSDAcaPwpxz38881M3g7oZ
	 s7n3OBdGtZtVlCPVZJf+oxhcZ/8r7APl9vB97lt3XwdC7z2ASf5kdVsrxH6PXGfBMUFOW
	 VytrNScNOI3/y+dRxImlUWZCVCvuHoPpPPTKs0WBNf131f65nJiNYg9XxoKLFkuwRig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vs0H0DIP;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01675606A6A9
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 04:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01675606A6A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vs0H0DIP
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdb45b4ed6bso2483604a12.3
        for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 20:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795409400; x=1796014200; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6MNIHKKL1TyoX4SD1X7Fi8nLR6k5WbA5DIiwx/onbm8=;
        b=Vs0H0DIPyy4AEnzecTHnp6UBjOlGDzHMN2cAUP5J7RvfJnt0AERF2SSsqfsfeRNkBX
         nqXYKcxp/wZGXkI5ab7TLuFsge+4HX+bfSpjlujkw8g06nd901qI0Gb0DRXGQMpoEL4N
         nb3K3/BEIRpVxGAeETe/Du4Ptkz4wFjt04C4Ek3Da6SSEQNz0sTdl4g8KtGbRr7RI6uA
         ulzLzAwAF4GcVBhf2WwpVtQ+mOdI0CRetavK31N+KwOxrnRoF/jreirB0b7Oenle4Vy3
         ICxHqUrMcROQ4m4wa7OY2PdLKddzOMBkXlmlrMTrH0CV1PLkzX354xzaoA7UmeIq9NvX
         BY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409400; x=1796014200;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6MNIHKKL1TyoX4SD1X7Fi8nLR6k5WbA5DIiwx/onbm8=;
        b=BF6pGTk6ieAvXAr4+IrzK24AQBZCXn6e1RHiEqLKA5GDi8Eps+8ilEu0MHS3pI0k0s
         F66b1aavWPLDtoiA25hBl/Qnf7NFYmWYhMKLYbRFubLwSrynvzs0HOfv1sTbCtlb4yGH
         gNsCQCKTmLUY6RWiR+BUFVLWfnVHCIwFP4Uahncofln3joKk16PcTR8QiRo/h7axT11j
         wDPmIk9xqMFiPk6IT2tPJo/RX1MrNnwch4AV0L3bGnR6JpxrMcx6BkF8HU2lrZvv+2+G
         FkTVAhlvYPBCfwdpUJuWpCEnBFs29Fa4HFfViRP/Fb3gGgDAhlEh7wBigPed9I9bHsTh
         SPlA==
X-Forwarded-Encrypted: i=1; AL+hErFbD1502tbGmwvOMyZ6zYzM5sIBe1mtI+cnT7id9RKASgiOiSsIbKmE/J2X/4fKEOQQhEw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+GqWpewhfxHomWGmSGp5DRcBH8VAOLYOWcV80CNwcONqot3JL
	VUDsKe0c0zJeps/Y6jTNljDiC6d4gOmFKdmRa+bwLKxVnuK2scdmbuf7PW5SerGwf6aB1/jDQSQ
	2XPI0VMTeeWYLhw==
X-Received: from plho3.prod.google.com ([2002:a17:903:23c3:b0:2ef:a836:c1be])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2f87:b0:2ec:ff7f:6f8 with SMTP id d9443c01a7336-2f03f268843mr97692615ad.57.1795409400082;
 Sun, 22 Nov 2026 20:50:00 -0800 (PST)
Date: Mon, 23 Nov 2026 04:49:41 +0000
In-Reply-To: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123044949.3610702-11-skhawaja@google.com>
Subject: [PATCH v8 10/18] iommu/vt-d: Combine disable_dmar_iommu() and free_dmar_iommu()
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
2.56.1.809.ga0b61035b5-goog

