Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9894220459A
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 21:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062994; cv=none; b=SiIDi5QyBTmgRQnNpmMVNdos3m/0P/ATaTzZGBd8FugTrxWuRXRcNqTKF9fUtAMG/Uqm5dLruFz4s9xnAaBwkTanO/iqdi8yw6etvgjAdtO2vsyUsZUzOIoIvzmpiRYKU+vPl7bYFHl9bEUYdO6hMXa61uado2jfCqh6ua4T4gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062994; c=relaxed/simple;
	bh=YL40fODZmYHcDpm/JMVPckuIUdAD/Hhim4uHYp49D4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=owQUrhjbnNZyV/oJvso97Ny+kcM53Y/Sf5LCS7JKxyRpbXoy77ss6EF361986gaS7VCBSBNjoPQPUEszEuC8thSOFZijX/Hpjjs06IsfO8JGZrUzjlvaVXV1/+O4RDqOn3y54uICQ9CBVkAEuZZMiVGK3T2nSCJMJIXZzHXYBI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lm5WGgXS; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lm5WGgXS"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c89704da8c7so6996788a12.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 14:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784062992; x=1784667792; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P86bkrXTV1bs2mXuNasauUOM+d3gbgQQEyUkpHKw8fA=;
        b=lm5WGgXStTk2mE5zf6QIsDDE0V2XZyQ0Xw/X95wUV0xjPw87P3W2pS9lAuhYWHyxKo
         6S1Zqxn8vpqFLcrs8slXKGl6Bc5/shW6hwkSizLcAOyLgwsH2EvboTIZPy7yMnH0GLTm
         GQ9DiZ+/pPjf1jAlpET5Bd9Bb9Na6kF2C+6GK96l87xlYvzvDLFHlii5LNuTTtdE6E1j
         aUNv/sQ+otaPL2sq+a6WPwxPXQ2cCSjt/Y/4JrM04Gg2sRabvreO6wJy/+ZG3mlgXBZX
         xDsZ5nL/87Ra/ZCH2/RDPfvp/amZ8ohdR1E7YcMrOUERyNoNYF+WewdeL56JavJbT0PE
         x5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784062992; x=1784667792;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P86bkrXTV1bs2mXuNasauUOM+d3gbgQQEyUkpHKw8fA=;
        b=D2uUFhQshYYZkX8myGzCj1hgUq27FBPC8JLnOmUt34M2Pq2PLDq6qcvYREcIRRuBFU
         4dKAo1DoZO2gIgoRenT/lUrkZN7O1I4C9y5qHiw/y16e2df7afKeb5yMTGHuummhf6zv
         GICHYqJjVHLY68IJchlwaXhPaJP08Y9bn4VK+xJR1DZ/ct0nqPr2++VkGVBWRPlgEyns
         A1KLFZQ7G+LB8df2xllSMdOtGpEPcesG9Hf8xjUestDutmDg8j7QFB0cRfquKFCFOCwk
         M9yzYaULMWmthfYJOGTjdxWA9CB8D2AdvGXEtTYBTrPfI+yl8o19G7V2bUv4dwqIXh5f
         ESOQ==
X-Gm-Message-State: AOJu0YykMVAnfldQFBY+YmrZXBLauj1oyu+ohY+BnMotdS89Z/hS2Eae
	hC4CpMrQCciPTzELdnAI4LpqaE9hnZlOFZZcLm/N+L9D71ozKU8PGmFHiStClVqclPoRXDcdvOp
	VjOxE2KixNZA4FEpSwq5kp4N17GZxlGWPLRDtyOlrrWyJvhoQNhUa0MFIv5mddPYW1MDevqQrAa
	8OVmWJeh+NUj16nS5qIN7hwNjPr45sK25SUCDwoMEe+VGg8QhjT9vWiA==
X-Received: from dlad14.prod.google.com ([2002:a05:701b:220e:b0:139:c8ec:c97d])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:330b:b0:3bf:6c08:fba4 with SMTP id adf61e73a8af0-3c357637bc4mr4837617637.56.1784062991683;
 Tue, 14 Jul 2026 14:03:11 -0700 (PDT)
Date: Tue, 14 Jul 2026 21:03:03 +0000
In-Reply-To: <20260714210303.3967981-1-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714210303.3967981-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714210303.3967981-3-aaronlewis@google.com>
Subject: [PATCH 2/2] iommufd: Periodically reschedule when unmapping
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Unmapping large DMA regions can be slow and cause a CPU core to be
unresponsive for a long period of time, leading to kernel scheduler
warnings.

For example:

[ 1389.148910] vfio-pci 0007:01:01.3: resetting
[ 1389.252814] vfio-pci 0007:01:01.3: reset done
[ 1392.943771] sched: CPU 49 need_resched set for > 100000053 ns (100 ticks) without schedule
[ 1392.943776] CPU: 49 UID: 0 PID: 32912 Comm: vfio_dma_mappin Kdump: loaded Not tainted 7.1.0-smp-DEV #1 PREEMPTLAZY
[ 1392.943780] Call trace:
[ 1392.943796]  resched_latency_warn+0x7c/0x88
[ 1392.943800]  sched_tick+0x18c/0x208
[ 1392.943804]  update_process_times+0xa8/0xd8
[ 1392.943808]  tick_nohz_handler+0x120/0x1c8
[ 1392.943810]  __hrtimer_run_queues+0x124/0x3a0
[ 1392.943833]  arm_lpae_iova_to_phys+0x80/0xf0 (P)
[ 1392.943835]  arm_smmu_iova_to_phys+0x24/0x38
[ 1392.943837]  iommu_iova_to_phys+0x38/0x58
[ 1392.943839]  batch_from_domain+0x16c/0x218
[ 1392.943840]  __iopt_area_unfill_domain+0x2f0/0x5d8
[ 1392.943841]  iopt_area_unfill_domains+0x9c/0x1c8
[ 1392.943842]  iopt_unmap_iova_range+0xec/0x218
[ 1392.943844]  iopt_unmap_iova+0x38/0x50
[ 1392.943846]  iommufd_ioas_unmap+0xac/0x1f8
[ 1392.943847]  iommufd_fops_ioctl+0x200/0x348

Note that in order for this warning to fire, the kernel must be built
without preemption, or... for testing, the code in batch_from_domain()
can explicitly disable preemption.

This warning was produced on ARM using the VFIO selftest
vfio_dma_mapping_perf_test:

  ./vfio_dma_mapping_perf_test -p -b 256G -a "-v iommufd_anonymous_hugetlb_1gb"

To profile the unmap flow, bpftrace was used with the tooling
described at:
https://lore.kernel.org/kvm/20260630141152.3757722-2-aaronlewis@google.com/

The results show:

  iommufd_ioas_unmap, thread_time = 1086.52ms, count = 1
    __iopt_area_unfill_domain, thread_time = 1086.51ms, count = 1
      batch_from_domain, thread_time = 1086.48ms, count = 1

This shows that the execution time is spent entirely inside
batch_from_domain(). Furthermore, the function is entered only once.
Therefore, to avoid the scheduler warning and allow the core to remain
responsive, add a cond_resched() call to the loop in
batch_from_domain(). Also, limit the cond_resched() call to once
per 1GB to rate limit it.

Additional context on what consumes time within the inner loop can be
seen in this sample perf profile:

  22.96%  [vfio_dma_mapping_perf_test] ([vfio_dma_mapping_perf_test])
  22.96%  vfs_ioctl (ioctl.c) Inlined
  22.96%  iommufd_fops_ioctl (main.c)
  19.38%  iommufd_ioas_unmap (ioas.c)
  19.38%  iopt_unmap_iova (io_pagetable.c)
  19.38%  iopt_unmap_iova_range (io_pagetable.c)
  19.38%  iopt_area_unfill_domains (pages.c)
  19.38%  iopt_area_unfill_domain (pages.c) Inlined
  19.38%  __iopt_area_unfill_domain (pages.c)
  19.38%  iopt_area_unpin_domain (pages.c) Inlined
  18.84%  batch_from_domain (pages.c)
  15.06%  iommu_iova_to_phys (iommu.c)
  14.27%  arm_smmu_iova_to_phys (arm-smmu-v3.c)
  13.29%  arm_lpae_iova_to_phys (io-pgtable-arm.c)
  10.60%  __arm_lpae_iopte_walk (io-pgtable-arm.c)
   7.70%  io_pgtable_visit (io-pgtable-arm.c) Inlined
   4.71%  __arm_lpae_iopte_walk (io-pgtable-arm.c)
   2.31%  io_pgtable_visit (io-pgtable-arm.c) Inlined

Signed-off-by: Aaron Lewis <aaronlewis@google.com>
---
 drivers/iommu/iommufd/pages.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 9bdb2945afe1..e478771c0ccf 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -412,6 +412,7 @@ static void batch_from_domain(struct pfn_batch *batch,
 	unsigned int page_offset = 0;
 	unsigned long iova;
 	phys_addr_t phys;
+	int i = 0;
 
 	iova = iopt_area_index_to_iova(area, start_index);
 	if (start_index == iopt_area_index(area))
@@ -428,6 +429,9 @@ static void batch_from_domain(struct pfn_batch *batch,
 		iova += PAGE_SIZE - page_offset;
 		page_offset = 0;
 		start_index++;
+
+		if ((++i % BIT(PUD_ORDER)) == 0)
+			cond_resched();
 	}
 }
 
-- 
2.55.0.141.g00534a21ce-goog

