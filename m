Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C52A50EBF2
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464212; cv=none; b=jRUCAnZGxWdw/t1ipUeh4GR1FhyItLmGpUu2F2uy9K8W63PZOLlb8ICN/jAf31KTHC5dR4qVekh4uMOMAMDMELQCfUg11s0XafVD8Iy50VOIhyHVpBxVIIIL/23V64p+e+/4uQo/vyro5CAM0q+HQm5FS6guqcLIpiwQUI9BoYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464212; c=relaxed/simple;
	bh=HJHg0Je5bQPZY1G+VY8EBdt/1UJ39MVmNCTQL3dgFak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUUupmnQMeIiUSEMe0Nt3GjausUCMiay+WbE2J5KSRTxkFY5Lq1P9CRoKVVyx+Y4W8YqJIX9rp4Cq4Z/V4TC7vqIMbGZgQII8Gfztic6vNLpVU6TEssbLTDMlNBXaHE/Z9tQg7PtDGvKj8Fm0f4xMYhTqnTtd4jB3JH/Tc8kFC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kRuWgXE4; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kRuWgXE4"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc1c9879395so284008a12.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464193; x=1789068993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v/EbG9/3Hb8DCKZa1jZljaYOgVIsiNG77AyoF+zPvP4=;
        b=kRuWgXE48LEdCD1IPlEgbMQbFChbZRSL/g8po82kviKF9L8iYoSO1hdBQhi+/IQRZK
         b2Q2sf9A+GbxekDh2ZIM2urPhRz60OltRGnxTevcl9SSC9zpSYG90/9STZTKsQ5OHwhv
         sU+jrGt8fViAEiJOHTPHuV4bKjxaTFZiCpHfPjsqiuNeFnntjD2osOp9F48WdNIIzwqJ
         VdIIsBQwj+xwb3K0VgI+/aU0f6/GQZZbB+JbS3v9DQ16l/wb27SxzFvzh29YxebcOh/7
         95paorBQ90FOQc3WoR9SNncLYR/aZaQucoIol+CvU9FKj9BimNjiAxS3Z4bSYJAuZn3U
         putQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464193; x=1789068993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v/EbG9/3Hb8DCKZa1jZljaYOgVIsiNG77AyoF+zPvP4=;
        b=DaNQpunG6fo8uHN10Ftp0g5J65/NIZDA8vpVImboCAzw6DN48zt0B+5phqROTG3L9l
         4ANkjy2JucEWNAgwAUxqXJ9YL6wh/R1PSzCR+p+gNXQA2T4utkvDPUsFyGcG2wLcVaPS
         5Vx6Qe/W+KsGi8XA17cQ/VDz11MXAeo2QyWy9vB+uwbQyEXEfWOX/KRXxeeMl4QrRGQJ
         LqZbRft59u7p+k0vGuHR4dL6gcNiKl3B/cpyIflYgPqadpW4JoZ6MehbXDFcPubxBZXi
         Iwi5kryP2cepnqTyBNPMMN7qtmOxaZh9mqPDuDucptk4ZTBtNCU/AVMqQBvazT9THvOJ
         XHkQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4RDdIbcBKH/YrFoLb2xdbEFKt4xuStvYYYYfJ7fWFQMFP9t54RgPgcX5NM1IV9siQVZM=@vger.kernel.org
X-Gm-Message-State: AFuF++ltF6WquZQ1C+3H3FAd/BH9hMWOagO9ZNVbVYDBQrNZZ3LQYk/W
	oPyr8CMz+6bQfx06qX+AI9s1FNic+U/+vS8ibCochrk5CZUp5KdB16yS/8WbhM+7EbA=
X-Gm-Gg: AYBFou0b2pk5R0M+IMEVXN+j5e5CMVcVPfRD5o2GShYYrIoymo0JknS09b3AbvqelL+
	UecuERRW+yGlkkTIQvtISKtgm9odJjtE2HUzJ8FtdRbEUX5i6O9yeLmBxW7wSMaS64OBD+0QGWd
	McAZwd0Jpd7C2/DFEku4+f0p1HUPyJ4NLWutbWVI/jYdPH+ozQbP+t4wxZXmViLhsAS6NDe0NM0
	WaR/hw6Lw6y+B045S7jHylgLdgA+RcEHnrjpWyeFQcdQZXUQT8WZOZNatKPuX6JmpZ0e28cLhhb
	BrHmxCX3gUk/fBO6HSSVkU52IsuNu75yw9BhNz06s6S71cimoSM0p0KNkJDaz3uIk9L4fX72eHx
	ZwQ1ql+vYZgUyTVr9OD8UMxDSjw7RIhdUQCgA3vH5YgxWa5Rv41ZLitr5FqS4drzmUJz7QW/BBe
	YCc5QajWw4+rz38HMpUiJoGzmlB2DyxnQQ/ZpqpMd1xLzK7pD23lRFFjtymW3wnFrvebkNO01RO
	xdXpGS1lRx7srA=
X-Received: by 2002:a17:90b:3810:b0:398:9beb:5c18 with SMTP id 98e67ed59e1d1-39b26213a86mr1124061a91.19.1788464193150;
        Thu, 03 Sep 2026 12:36:33 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:32 -0700 (PDT)
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
Subject: [RFC v4 11/24] target/arm/kvm-rme: Populate Realm with runtime images
Date: Thu,  3 Sep 2026 13:35:58 -0600
Message-ID: <20260903193611.1058589-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Once the Realm descriptor has been created, tell KVM to transfer runtime
images (kernel, DT, and rootfs) from guest memory to Realm memory.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 9985f5daba89..c082a5d8f3d1 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -15,6 +15,7 @@
 #include "migration/blocker.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/memalign.h"
 #include "qom/object_interfaces.h"
 #include "system/confidential-guest-support.h"
 #include "system/kvm.h"
@@ -43,12 +44,87 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
 
 static RmeGuest *rme_guest;
 
+static int rme_populate_range(const RmeRamRegion *region, bool measure,
+                              Error **errp)
+{
+    int ret;
+    void *buffer;
+    hwaddr size = region->size;
+    hwaddr base = region->base;
+    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
+    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
+    struct kvm_arm_rmi_populate populate_args;
+    size_t aligned_size = ROUND_UP(region->size, qemu_real_host_page_size());
+
+    if (!region->data) {
+        return -ENODEV;
+    }
+
+    ret = kvm_set_memory_attributes_private(start, end - start);
+    if (ret) {
+        error_report("RME: failed to configure initial"
+                     "private guest memory");
+        return ret;
+    }
+
+    /* Allocate page-aligned memory */
+    buffer = qemu_memalign(qemu_real_host_page_size(), aligned_size);
+
+    if (!buffer) {
+        return -ENOMEM;
+    }
+
+    memset(buffer, 0, aligned_size);
+    memcpy(buffer, region->data, region->size);
+
+    populate_args = (struct kvm_arm_rmi_populate) {
+        .base = start,
+        .size = end - start,
+        .source_uaddr = (uintptr_t)buffer,
+        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
+    };
+
+    while (populate_args.size > 0) {
+        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
+        if (ret) {
+            error_setg_errno(errp, -ret,
+                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
+                start, end);
+            break;
+        }
+    }
+
+    qemu_vfree(buffer);
+
+    return ret;
+}
+
+static void rme_populate_ram_region(gpointer data, gpointer err)
+{
+    Error **errp = err;
+    const RmeRamRegion *region = data;
+
+    if (*errp) {
+        return;
+    }
+
+    rme_populate_range(region, /* measure */ true, errp);
+}
+
 static void rme_vm_state_change(void *opaque, bool running, RunState state)
 {
+    Error *errp = NULL;
+
     if (!running) {
         return;
     }
 
+    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
+    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
+    if (errp) {
+        return;
+    }
+
     kvm_mark_guest_state_protected();
 }
 
-- 
2.43.0

