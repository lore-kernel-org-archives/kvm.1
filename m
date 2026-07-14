Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A9D2F8E94
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062992; cv=none; b=COLgVRFA+e4wWJ6/4bx9U2rUskCZs4/GEipK7fcjEFE6W8gKPTnbxt/Y4Lk6JHeloTybRMqlq8A7glryZXyY2raGws8UdHEl+zgYTXim4LXm5oRcws77eZUQD1pSgvrR/6jG5wl9LAidYd9KUEGmAH8ItBP7YZHm0MFyaWawSNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062992; c=relaxed/simple;
	bh=E9Q25EH1qfBo/eL0z4Pz7D9YvAAJkCKUip7xGVPmNvk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O2dk0t4zggh4Sj8G9Yqw1/CiuSxsmn3fjTKz0X4jUyku4IAoC6ieiMHtLIzUVtB/1KsqIRoN9mCi7y8NpAZUTaOfDvyZfgWEi45geNphZUNZB4CFAo5JVTRerxLJ2MlFFIpzywlZv/SV5fjpu9PrH6hCkeiwhWvhEKD13dG2Kbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BCPMxniX; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BCPMxniX"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso5967282a91.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 14:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784062990; x=1784667790; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l48rpXoNeDe+QRm4OowSgCgiPqU3f58WDMRy7srF4IE=;
        b=BCPMxniXFb0nFnk9LNTLXXdGBTknNsYws53bxiMfp1Q79SKJSNOmy8A4v7xxSeSqvd
         kL8LfK9bySWLKWxAj78sNnbSGOjOw7gt0uyVzBa2EiPvRdXloe2VX5D/Tuw8KFYNZfmc
         3As/D/DzZzat99QyQP0Uco0He/68R+UL/HQpM50UiVHmMo8Dck4yA28Nc7GM/fYVhS67
         JruLaUQFQR6M770+utxHXy2HDMz52U5onxCT1Ni5fseQ37ko2HJT04LellT6BLuHwdL8
         17I/pqGoDNAbSSN8g0AfAXAcbGk5PRwYP88CJthciW5T93ZXbdaBPWgKTwL65WslUaZo
         GNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784062990; x=1784667790;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l48rpXoNeDe+QRm4OowSgCgiPqU3f58WDMRy7srF4IE=;
        b=Sv0RbAO/unMLpllAgIyU3t7d8ieU9uALK8DjM/tDb3s2DIoKLEA1nOB0k7jf/mYqUu
         Z2MA6rmoXkaiMKh+0BsOHT2/rzJfPtyLmLKJUtQxd3pk5D6TtBF2usrNkpq6NuehZKKZ
         5yiSxw0K+i2jZxS+tI4nD+AzVTN9rhhEJO9dpRbjAfNcXKR7zk67cawMMMgzXMhoSbgF
         ohXjA6dSEd9w+JB0ngpcU+jYcs6NbFP0w9lBXL/0f9/iecE2SDCpimirM82Be0d2eP4J
         rGyTNWMtVSia2ffC8U5bOMpbjHmgfFrqza90CStygE2NPNnT9QRqAmxgMOTj7hmsj1uO
         w+6A==
X-Gm-Message-State: AOJu0Yw3G4AuocpwLXE4ewGjPgRy+5n3SLChQZVfex2GqKbliQ4ohkb2
	nQuba2bhFPmk9hZtX78VUxiFHzvffiyxivJw3fjm7NAeGdEM/Lt1xCV+esNnEDZSAQE9HoAtxWd
	vGpUkOkPqT2o2P90srO/VMOe7i8WJXfvYunUcT1bxZ5ZT6j54qb5MAWYOXf0M5acZQ6YYSEFqIZ
	Vjw4XPgu+CrRLJif5QV6BbXs4VTMk0nNHBAJYS6C2xUEHcHx5PD+EI1g==
X-Received: from dycjx10.prod.google.com ([2002:a05:7300:fd0a:b0:313:f88c:98f8])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b8a:b0:37f:fb1d:63fa with SMTP id 98e67ed59e1d1-38e1ae2eee1mr3071786a91.15.1784062989876;
 Tue, 14 Jul 2026 14:03:09 -0700 (PDT)
Date: Tue, 14 Jul 2026 21:03:02 +0000
In-Reply-To: <20260714210303.3967981-1-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714210303.3967981-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714210303.3967981-2-aaronlewis@google.com>
Subject: [PATCH 1/2] vfio/type1: Periodically try rescheduling when unmapping
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Unmapping large DMA regions can be slow and cause a CPU core to be
unresponsive for a long period of time, leading to kernel scheduler
warnings.

For example:

[ 1404.810673] sched: CPU 19 need_resched set for > 100000026 ns (100 ticks) without schedule
[ 1404.810679] CPU: 19 UID: 0 PID: 34615 Comm: vfio_dma_mappin Kdump: loaded Not tainted 7.1.0-smp-DEV #2 PREEMPTLAZY
[ 1404.810682] Call trace:
[ 1404.810700]  resched_latency_warn+0x7c/0x88
[ 1404.810704]  sched_tick+0x18c/0x208
[ 1404.810708]  update_process_times+0xa8/0xd8
[ 1404.810711]  tick_nohz_handler+0x120/0x1c8
[ 1404.810713]  __hrtimer_run_queues+0x124/0x3a0
[ 1404.810716]  hrtimer_interrupt+0xdc/0x2c0
[ 1404.810718]  arch_timer_handler_phys+0x3c/0x58
[ 1404.810721]  handle_percpu_devid_irq+0x144/0x1b8
[ 1404.810723]  generic_handle_domain_irq+0x44/0x70
[ 1404.810725]  gic_handle_irq+0x1b8/0x320
[ 1404.810726]  call_on_irq_stack+0x30/0x48
[ 1404.810727]  do_interrupt_handler+0x54/0x80
[ 1404.810734]  __arm_lpae_iopte_walk+0x15c/0x1b8 (P)
[ 1404.810736]  arm_lpae_iova_to_phys+0x60/0xf0
[ 1404.810737]  arm_smmu_iova_to_phys+0x24/0x38
[ 1404.810739]  iommu_iova_to_phys+0x38/0x58
[ 1404.810752]  vfio_unmap_unpin+0x8/0x1c0
[ 1404.810753]  vfio_remove_dma+0x38/0x140
[ 1404.810757]  vfio_iommu_type1_ioctl+0x8/0xc80

Note that in order for this warning to fire, the kernel must be built
without preemption, or... for testing, the code around the for loop
can explicitly disable preemption.

This warning was produced on ARM using the VFIO selftest
vfio_dma_mapping_perf_test:

  ./vfio_dma_mapping_perf_test -p -b 256G -a "-v vfio_type1_iommu_anonymous_hugetlb_1gb"

To profile the unmap flow, bpftrace was used with the tooling
described at:
https://lore.kernel.org/kvm/20260630141152.3757722-2-aaronlewis@google.com/

To isolate parts of the runtime, two temporary helper functions were
added to vfio_unmap_unpin() during testing: vfio_try_unpin(), which
encapsulated the outer while loop, and vfio_get_largest_chunk(), which
encapsulated the inner for loop.  Doing this helped identify where the
latency issues were coming from and how the code flowed.

The results show:

  vfio_iommu_type1_unmap_dma, thread_time = 1124.85ms, count = 1
    vfio_unmap_unpin, thread_time = 1124.84ms, count = 1
      vfio_try_unpin, thread_time = 1124.80ms, count = 1
        vfio_get_largest_chunk, thread_time = 1124.79ms, count = 1

This shows that the execution time is spent entirely inside the
inner for loop. Furthermore, the loop is entered only once. Therefore,
To avoid the scheduler warning and allow the system to remain responsive,
add a cond_resched() to the inner for loop in vfio_unmap_unpin().
Also, limit the cond_resched() to once per 1GB to rate limit
it.

Additional context on what consumes time within the inner loop can be
seen in this sample profile from perf:

  24.13%  [vfio_dma_mapping_perf_test] ([vfio_dma_mapping_perf_test])
  24.12%  vfs_ioctl (ioctl.c) Inlined
  24.12%  vfio_fops_unl_ioctl (container.c)
  24.12%  vfio_iommu_type1_ioctl (vfio_iommu_type1.c)
  19.66%  vfio_iommu_type1_unmap_dma (vfio_iommu_type1.c) Inlined
  19.66%  vfio_dma_do_unmap (vfio_iommu_type1.c) Inlined
  19.66%  vfio_remove_dma (vfio_iommu_type1.c)
  19.66%  vfio_unmap_unpin (vfio_iommu_type1.c)
  19.65%  vfio_try_unpin (vfio_iommu_type1.c)
  19.10%  vfio_get_largest_chunk (vfio_iommu_type1.c)
  15.91%  iommu_iova_to_phys (iommu.c)
  15.18%  arm_smmu_iova_to_phys (arm-smmu-v3.c)
  14.09%  arm_lpae_iova_to_phys (io-pgtable-arm.c)
  11.59%  __arm_lpae_iopte_walk (io-pgtable-arm.c)
   8.51%  io_pgtable_visit (io-pgtable-arm.c) Inlined
   5.27%  __arm_lpae_iopte_walk (io-pgtable-arm.c)
   2.64%  io_pgtable_visit (io-pgtable-arm.c) Inlined

Signed-off-by: Aaron Lewis <aaronlewis@google.com>
---
 drivers/vfio/vfio_iommu_type1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c8151ba54de3..e78bc07d9b6e 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1153,6 +1153,7 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 	int unmapped_region_cnt = 0;
 	long unlocked = 0;
 	size_t pos = 0;
+	int i = 0;
 
 	if (!dma->size)
 		return 0;
@@ -1196,6 +1197,8 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 			next = iommu_iova_to_phys(domain->domain, iova + len);
 			if (next != phys + len)
 				break;
+			if ((++i % BIT(PUD_ORDER)) == 0)
+				cond_resched();
 		}
 
 		/*
-- 
2.55.0.141.g00534a21ce-goog

