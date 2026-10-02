Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771AC515992
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972462; cv=none; b=LvmcUAU/Ztq1AizciIhBsCjicY4XvQmM4sCsGAPZi1NO9Z6Yla50sCCaXW43PSaEUGtVdEw8lJkMehcKpD7FsX8DmGU/Jybs2LlgRAoGHzs/9Oj0LWu1Gh5x0+EhBTx8MwlXw8Kkm6pkv3t9hp8BLq6N3dLeKTNCyviz+xVbkBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972462; c=relaxed/simple;
	bh=mVgChnpXyKD4df73Yh0PFeZ0Pe/JOQk/mrcPfj3BK+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5CCWQUBZWBGloT9F+R3r7+joYRCrReYDj35ThDFilEY5YsQWshFt3DgNvu63o0ghp2A0jVfTg2coa5BR9ul4fI9L6lMPVr88/AeJ+jgp3pPBTXWSNEy3nxWug8OyPqSG/4UDzH4qm4ROpt/ROh8HYIwkdG6tBxBYz6Zz8SU2Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NWrVAofO; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NWrVAofO"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed9866so55391125ad.2
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972461; x=1791577261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lpj0IMfahKj4TBxv92N1eLG7yRPCpkT9qnzra+mUktE=;
        b=NWrVAofOsE/GAvWw6IW9BTLGH4hNA11tf9JcaB3/McYkjeYns+P3tlEPS1RVT1d63t
         p4lrR5pNxi/NLzHBRfII/jCN6k1WyJf+2AuMc8bcM9hMv/Lk/p3A8l5ASltKw/My4YA8
         BzV3u87DRZOhrSnw0JGB7bb7HVNqnEIEmQsPCTFvsnreFIp00HJSiFQWF+bCUVmsC1kO
         ZOAounGWAgCHDxJmscYnCb1pHLOoT36LpDGWmQUw9xwbBLvtCl3hipEuRJbazHy8ypn0
         c1V5uksC/XZV/7x81xbgBrZ7wb3MXe+/osv4llL/kZiEpKy2k2jNSc4SjYEle1U4oBoi
         E6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972461; x=1791577261;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lpj0IMfahKj4TBxv92N1eLG7yRPCpkT9qnzra+mUktE=;
        b=m/B7176/Vujo1yo/M10i21f061v8MPdYWCuFlqtzjhgVpmj616R+yM8ZquBV1ZtRAQ
         P8KMewl+ZuSawblfFxu39oKbfmTVNbBQ4T5injrgkI3QoAHCvu4/BcqeDPOQYMpgAeCS
         z2esTEjzbA31MGrF2AnwjmK5vE0Qyxcq3CfT3EuVL2ly9DtKl+pv6BlKWE5aF52OlfTa
         ziv9toicL4s1uxEf74hoGHnn6VgfRf9CpbBYOIUBP+velhD8VSpozRVs/GMiTj4h+Tly
         nOSQ2aiAxOv9aALi93v37o/8kOF95HKcncn2VIzUmvmcQ6RBsrjJWi8R8PS1yE2OIYdC
         edxg==
X-Forwarded-Encrypted: i=1; AKwUvBwbxXnrqy/NnAHAVM47O2Ww0DIMSD+6zqwAeMOH2+/Zjp3o6X/bsL1AYc6l9A7yEnxHEjo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIMLjuhb7P5zazi7qZ71+eLOKLRiL5tW9aG31ceeJFJ2zNt0ZIF
	xxYqMxB8KAfZjkHn6Lgq0TCdBT5mxw83u+AAbMtoGTrT6l6HjQDBVrnndI8Wsvsaa4U=
X-Gm-Gg: AYBFou0OfdGT04decXsAqp+Vk8OGWEGPB82t7ScPQ7oP/78L8gNIbMHAO0SyZHBd9r5
	xHbcgCiU9jAQ+jl1QmRGmEiCwGg9FJhTNPsJe6pREMOPPQ+kJV410ozxPFsCkg9xYQDIiV2HBZx
	zqnImyh3JV3bIyc+exAF/I0vAhgDwWJrzbKBjLtYJPeV08pMjb595q94GpEt6D5Q+gmjj6+QTCe
	1QIdgYTxSssDSlz6yN+oYgn2S+KiXMXCGxa0hBMpS3irf5TroUh9grESgN+mwAYuUNkwrAhXUyu
	QRkGxrUaH0YTWV5bzE87D7TYDEwRN+9Hw7S+LRvIuc2xQBHyY6yulwWKRJd/rcZWfjvnxHyXp6b
	toQRt/92cQVnV6lD3tb06L0angzVPC59ZzAbvK51+gjzS/SA/+67Qmt1V1syldtGYAxugoGV7NL
	D1DcF3/1E/9UaAQDRQmpEpYy13KjMg2QKrVwbksNEjUk7TQZVJdIKZLAQb9MyLvMvDl0rrPHUzH
	y6HxFQ5mGsZ01C9PUWkkchd
X-Received: by 2002:a17:902:d98c:b0:2e1:2f69:b6d4 with SMTP id d9443c01a7336-2e49b4e71c0mr35497965ad.15.1790972460656;
        Fri, 02 Oct 2026 13:21:00 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:59 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	enju.kohei@fujitsu.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 17/22] hw/arm/virt: Move virt_flash_create() to machvirt_init()
Date: Fri,  2 Oct 2026 14:20:21 -0600
Message-ID: <20261002202026.1204110-18-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

For confidential VMs we'll want to skip flash device creation.
Unfortunately, in virt_instance_init() the machine->cgs member has not
yet been initialized, so we cannot check whether confidential guest is
enabled. Move virt_flash_create() to machvirt_init(), where we can
access the machine->cgs member.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 35e76951dafd..886ea7a97ea0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2904,6 +2904,8 @@ static void machvirt_init(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
 
+    virt_flash_create(vms);
+
     possible_cpus = mc->possible_cpu_arch_ids(machine);
 
     /*
@@ -4429,8 +4431,6 @@ static void virt_instance_init(Object *obj)
 
     vms->virtio_transports = NUM_VIRTIO_TRANSPORTS;
 
-    virt_flash_create(vms);
-
     vms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
     vms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     cxl_machine_init(obj, &vms->cxl_devices_state);
-- 
2.43.0

