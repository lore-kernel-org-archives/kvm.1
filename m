Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58B0356779
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695301; cv=none; b=WsmQG37JgQG0uz3LJt0A1pb7tYmoxegiv7c9d68J0JttU08E+dl09QaAJpzERErhIEsdwcNgsFBWMJ6J2c0VqQxLkcf2KgS6I0Sey0eieVjT5IsPey56fZN8YbDLUAguBzs6FRc+tRZAy7xuvRiSbD3GET0+GScI4GRNBeW8Hvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695301; c=relaxed/simple;
	bh=QAj/7FDHg+zRQVpTaCbzsNfbzQZlAjiyYWN5aqVDu+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDihb3ITNbX37borDes9ZeRtX1pRKS5GCZt0jJ4bdQAswwuXL+u1JckGSnzod68cMxVjA/D4qeZY3IGfTYUzdowvE0qeLeyEjdkNpG4KY60yyprP+OdHeUvRqhSQ148S0w80DZWLlk0v7xtUuFjwBStD1vjdAbggiNaEZLDkvho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G/2mYVB/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/2mYVB/"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so396073a91.2
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695299; x=1788300099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yoa1yXasHmwThxA/d6QCly7EHag7eD5zfWJ/qbBT6qc=;
        b=G/2mYVB/fJkTbJ+JEYApwi2YZ7attkzujP+tnaL9r08uaTYYNNsLrBUmYwFIXMjsPy
         Gn6wf+/N4UvdFFnwa3dDQFLLRx2ve49Q+U3Wbe0Dnqt1ecfIoAx9Nt8/a3CGGyOFquiv
         m7Bf7+u7nQd7qTQGuaV9PB5syxnuWIh+SDLUOfhSkzj5XnjHBSptr5JOkSXbykeS0U1Y
         WsgNJxg7pvokwUrRp4YGpSKFAzHovRyboibZPdXzNDpBTvTK5gbetNo2YmTUOGle5o8J
         TcUlxCnS5TDA2ADVps5KDb5RXCF81fDDL2tqpZ2CsfCdSFkf3jaiBMmZtmAI6eElVcQM
         B1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695299; x=1788300099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yoa1yXasHmwThxA/d6QCly7EHag7eD5zfWJ/qbBT6qc=;
        b=P9Tz42bxmMDPNohypTYh6ma4McJT2yRPj+t273p+692FBYdFdJp2GaHwwuhxhdo1Bw
         ZfEP9pmN4WmIZON9jW+a0H60YrsvvF2CbKzfeKWb1BKZWL5rblWrEnGhhOPtEckRsFrI
         rt2faUjrv7rsEKl8/9E4FAZH66UYPctq9TIYtFLTw9HtyMs8cnpnA1nIZItaFYO9dOYR
         AWGiTOcAxq/kPkVs6WXDmLqid726yaOyZvnCbK09+WQtlNlUVgg8s2s5+tbInQQEQXUc
         hEqNcMjrptxB2SvOCy6CSES2VSgNvRewZp34M3byKWtJ9s0dmsty5fyltDRHXvopmQvC
         0bwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqfn1tT5/tY2PnsVn9UsVj166ILTzZOXFaBhU9ThCBVO5/JtzczhBjt9S2BkLjYuVt6+Ng=@vger.kernel.org
X-Gm-Message-State: AFuF++nV2JJJuitZXrPimDf8VQxbG/lzNay5yCO7U+xHcvE9ms0OWBmp
	7mNat1Uo2tUefSxASwBja0Z67AZRumzjZC/r8IHQKfh9ZXJjGLuWVAHPoKzWMrBt7PE=
X-Gm-Gg: AR+sD11HdiXpKD+xWgxg6teKXgdKjKCTVYaDTtNfipMNNZq85pQxDLAiJDwP9wEbEz8
	dX/3Zu5iebkYj9cLeUBr9yaE3WStlQI09yXeWPMZzg1chN9XgNcCqHPidXIPWOFIf+NtBsxeapd
	TwC1mQ+eIcNcYDtvZT5fvrQoLXPsF4jAcfPxcl7JbJ8haL+3CSm5r4251xy4YuZ4VsVpPLznRs7
	Tro2sfdwWAKeaUMTOz7cC5i1oZwoat60Wjj7W9jHKzN3GMw4hTnQWqcg7jT/uXdv5TYakbUtPgs
	1UZbETAXSYzCs8EgsOu5vZWT3hFYz7QortKyV1vYWP/SyiGjn+RtK+/3Kjm8MLR9j4c51BRUyKo
	V1cDv4z8N8lf9UxLYXNAIWVKp3V6EwJB4AfPRLJM9dUo5rAxH0n9GkMHtxBXU8y9H8GkG5y+F1c
	vzgrQ9UGaSyxBIwIuYPgTEASYLQAZiEH8RxhtKB8VRW20lgwFSOxO8EVwM+ng04O4XwVOVajGOK
	mix5UHHpz8euRvP5jGCpXShQg==
X-Received: by 2002:a17:90b:3a05:b0:37f:fd1f:d30f with SMTP id 98e67ed59e1d1-3966d44312fmr4568138a91.12.1787695298971;
        Tue, 25 Aug 2026 15:01:38 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:38 -0700 (PDT)
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
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	mathieu.poirier@linaro.org
Subject: [RFC v3 16/24] hw/arm/virt: Embed Realm VM type with IPA address space
Date: Tue, 25 Aug 2026 16:00:53 -0600
Message-ID: <20260825220101.3443954-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Set the Ream VM bit in the IPA address space size when needed.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3418d75eccc4..fe195d145676 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -96,6 +96,8 @@
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
 
+#include <linux/kvm.h>
+
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
 };
@@ -3971,9 +3973,12 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int max_vm_pa_size, requested_pa_size;
     bool fixed_ipa;
+    int vm_type;
 
     max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
 
+    vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
+
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
 
@@ -3998,7 +4003,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
      * the implicit legacy 40b IPA setting, in which case the kvm_type
      * must be 0.
      */
-    return fixed_ipa ? 0 : requested_pa_size;
+    if (fixed_ipa) {
+        return 0;
+    }
+
+    return requested_pa_size | vm_type;
 }
 
 static int virt_get_physical_address_range(MachineState *ms,
-- 
2.43.0

