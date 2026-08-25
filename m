Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D565226ED46
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695291; cv=none; b=rx0l5ppdfZPeTau+a9YmuCx3MXnKJ5xo6NeJ3PqcMa98R2M7aYp7JslfZMhLYjLBz+YbFX+x98aEfr+Dffk0MDIspV8FRdAN/cVCM35RLC6t/McHI7Urr83kzrISPbIBGiFIF9VDTcdBOSD/s/WJkOI8YA3oV+H2qWQQ3Qqt4xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695291; c=relaxed/simple;
	bh=HJHg0Je5bQPZY1G+VY8EBdt/1UJ39MVmNCTQL3dgFak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dM8ey6Qa/gP2L+C8KNN/tjsirnLfheyqbW2nI9t9KNAd+qjciRxQl4Rb4hz0YHqm0wYWNVOdGrzOibbR1hYAKL/lPheVoGew/NowkZkiAjUca8diGgPHwaUOzuzpAVQqrHhUtnJcuX1tdRvwEJ5B5uS7jBBNWHH+dlQEvkVAcJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zyIhRvH0; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zyIhRvH0"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so641788a91.0
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695289; x=1788300089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v/EbG9/3Hb8DCKZa1jZljaYOgVIsiNG77AyoF+zPvP4=;
        b=zyIhRvH0qD5A73qzw4mqiJRkb9Lm0URMGy9KHOb94DKJuiU4qc2YL65TFyp7zsSKp5
         W64yB7jL9ZDLWGjZkYgxZDturKK/HexWC8CnBq3w92oo6ygoswaA3rzb6gqYuzJljNnh
         pLWzcJt4L0EX4dIIapUjApZmDnl82UdoHVDa+x/hwzpQOOEATtyNcfyRVs+CMfW8U8Mx
         WvaYZOPA4bwTw3TOLXsUhsEIpaap74aSca9FIhjKy1AG19B2IUu9h0bbbcq8jpa3sLKY
         RVQ897CGk30DOwK9EDsltXlphKwUD09G+/KQbj14lM2fi7j/P+Sfl9wP5f9Jch9Uj7F8
         IlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695289; x=1788300089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v/EbG9/3Hb8DCKZa1jZljaYOgVIsiNG77AyoF+zPvP4=;
        b=f4zBNOw7TmxretDhh8WYUIGjwRAG5qTr7G2Zbhbk9K86GcL79qaTfsWB46DZmlA+PY
         mcJI0gU47wnGGydC2LKJoxX8rOFYZTvCQ2zP804df5ANilx3EpBSChiggcs4GgMuFhuX
         cxGhwdCu/tSQ2uLFB8QO90bL2JxUibBNqQWcNFZG8L0ZyTMHvraeEchWADRoW0P7hrko
         td1UK2KwFcpIx4Z2ibOeqDLp7l2g/hY8sgE15KPkzyTrx2P2O7KtAh7OhR+en064oKuc
         /Fx3cVeC1LNRfX9ZlH+kt1q3O9SYTvd+OS1m8FtCCOEsZZBTb9G84vl28LagCh0dwCaS
         VzGQ==
X-Forwarded-Encrypted: i=1; AHgh+RqwU8UZ/XOKktdKtPcG7JhB+A2dmFmoZ4vC7IGnfyU/7EmCcCqziHQ9flJGY2+CjV40naA=@vger.kernel.org
X-Gm-Message-State: AFuF++nmA2E5wYdnAYv5OZfZyxxCWXbEknCcHwPqrtJx91wzB3O0yi4i
	NLa6iYnlppasW0NQs0XN+2D0KCVraDet71ColAV/tLy3f0Iqzg2FqNhRvOO1Ckmzyf4=
X-Gm-Gg: AR+sD10yyNch3X8WkLRLIkhEuMT/LwWSGZYsanxI5E6edifqnZ8QbpkHbN4YXto8Gnd
	v807GCxF6Wvwme/GaV1k+jmmF5XbR+1fbX7uAbmXQCJ4V8jvcyaQ57a3fkoh+LVIv/MMsHUJVjW
	QN7ZhCpOrv4P4y8JeaC76lJ4td6bF3UsP0e4brmKznGJCUWWz2aYlJVJtdrnYvg5kWEbIGGOGGQ
	ieI99ecoz3T28SrLQk6aexHlRd3X3kJKefg76TwDoG9YwRpUPMopHCaRxfJtsAzXLMFd/1oYvnD
	a/Y7rImSCj660w1FlC/NjN81BFrBEkW/uBrRfSS1solOghJoOzrEgNSfd4zV6I1IrVuV5CcNCh3
	rJNPgjG9zGSy2lWVP9E7aJBJNUUvSxpKeli+IB8F0yKrmrv8tJw5ccUuywcqa3rsdgeMhcDdEVO
	epEHp9S9Q2tj6uFWgwOgkYEFujyFgDLOHb6L9Rei7Ot0FvYRbJ8XBYspehaCaXbYEvJ9r9RWPpN
	rX5BJfCf1vcXhYlUhmOXuuKNQ==
X-Received: by 2002:a17:90b:1641:b0:38e:2524:724f with SMTP id 98e67ed59e1d1-3966d421936mr3799826a91.12.1787695288928;
        Tue, 25 Aug 2026 15:01:28 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:27 -0700 (PDT)
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
Subject: [RFC v3 11/24] target/arm/kvm-rme: Populate Realm with runtime images
Date: Tue, 25 Aug 2026 16:00:48 -0600
Message-ID: <20260825220101.3443954-12-mathieu.poirier@linaro.org>
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

