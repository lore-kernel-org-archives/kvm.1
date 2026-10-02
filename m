Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BD651589D
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972447; cv=none; b=GN7DmD8pQ5nClyljwVu2ye8nhe/qdZrLO6QdTGDBn6+mQ84grh5PAZav15lGAdEG+xE7hZy18FUI8nElvcB89EARy51Mfe8uHvDzQZS06Flk0gos7uV3MkHRjEFn0ZNQgwulsCCoV+uyHhLtX7R/j85F0NgsfjRbssFgNsOwlLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972447; c=relaxed/simple;
	bh=VYEwVnjOiwds5/qewNNbEREqRmCEurgG0rsAlPyadvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRnD2jMtmY60cZrUc0imq5oPQ7RSpRPEsPoWs3HUTnCsu0E5GkoOicqEX9++OHYFR1TiEsTi0HNFvycxzvfa1zBFoNUGgjFmedFf2idJxwNaSwwfuJ1/w3cBjBuBJosrwQrSocBEYCqrSaYz61P1W9igylFRl2Ta1Dx8jblB1Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TDNZ+/6d; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDNZ+/6d"
Received: by mail-pj2-f40.google.com with SMTP id d9443c01a7336-2dfaf76605dso4505ad.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972445; x=1791577245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rc1hMaz4HVihHTfD+cBzgKL6/9ldS//SvnIMYsY26sA=;
        b=TDNZ+/6dWgxPAoxFUtMXKs+nNU79FfThnALdgDOQt1mEOfk6rodERK3VzAONslS56p
         amx0yC08ISXKgJ9f6EsmXTs0uhJw5BvLEtAKB+XU2vhm5bmfjXMe/REiyhVsbdEzPEdO
         rrY5+HJyj4LeaiIfkIzMjpYMlxaaqqZI4tawZPD62PkjowxU1wWwcJlNiCA2B9MHaydh
         Qj+GE4ZpJTcAUnBquAf7IofXMVfHpWXRjm+PPBwrpoTIL+rihUkinAAEoXTpkDIFgiaQ
         FvQarlzP3iNuFIjFO4moZ50EAU9HxWYvKj6uBV4h6ChkPTCgT7RiRGAD0Vf8TnuOiBZ2
         LKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972445; x=1791577245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rc1hMaz4HVihHTfD+cBzgKL6/9ldS//SvnIMYsY26sA=;
        b=2zXAuug3gEE0xBSqy7susqRMa7XY3gXLgWPs1jGLyIr7uTqn4wAo0xi9QW/3NEXoU+
         Vr1bVsVO9quSYXzhVSXmQW5JLjniZ3xGInhiT22IQuqBukX/+aVZMnh0g/oTp/fdi+NG
         /Nki7Qx0ZZxH/BB+X1F8a3CJe+xLWRV8T42015GnW/HfgQYAq/978yrFvAEp+0+u1e57
         QQ5X0wE0QE0tX4jQKqrSw4FtIfpZPyereDAF55x9xncChXD79VodIpLodDGJrcsmnXYO
         pEwfQ0URBWbnnGO/3Q5Ai9HGzxYf16J+u/bmp2rXgtIFQtSoxjQRuRl3Qtz9wjskGf4Q
         OapQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnHjh+ttCZ1JQWAkvZUB4HTVkJWwq7+XIPvqsEIcOzTLXM0A3iP7rm+qfeLKblGWEJMhU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKK7oZaUHFEIrRouWpGvILL/3bL/9b3h0xTz7VPyHgMYPX92lkg
	k+fLi91REdly8n+oUPLMXszLMrGVcUoRsWcQNAqOSvqTAqhwQJAIU9LFXGekrGFkfZ4=
X-Gm-Gg: AYBFou0arW0u7/qC/nm2PmI3+LUQyHFbob22lD9CXsjjraoQSL5zmAnglxkecezXTkO
	OBu2y0qn5x35QTmoBUYo6AP8HqPgbnVjTgRIkZ5issJnm06L3SGmA3LNxDRy+D+ZGC9hWbe88Kk
	jJKH+zt9HQSqMX9CHKKNaRSBsqPpQe3rrwujoHTD6SAc7umZNRKn7sINxolkcQY7Da9HeHtvAzj
	XrSzwVuQyd8cboHR1hWemb6Ggr1OquidOYvK54CI4gGAzyQ6vNyx0GeyfoPFqKtZWSJ3e7mcv1q
	DTfYww0N+et/0u/UVxfR+5RD09lWHuVzr3O8+eMDRxi+UMtqMjxr4QD9lJgAvUfFFheknuv8wYx
	1d9Kd6BMkqq46luGogfS3BE5kZWemHgJF6erfw2F7z5YnvaxnRpVW+0Ts5LXMmPhxOycV1p1qpj
	Njm4uXMqhj9zfWtmjc338pYU2unAun1XFOFK1uLCkhXOyrwN3GTJ5WtvuRIqT13MQhoQhkRsLGB
	PK5Ptezrs+46H70V8TTfxyt
X-Received: by 2002:a17:902:e802:b0:2df:35f1:8771 with SMTP id d9443c01a7336-2e49b6d0622mr33942355ad.54.1790972445148;
        Fri, 02 Oct 2026 13:20:45 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:44 -0700 (PDT)
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
Subject: [RFC v5 09/22] target/arm/kvm-rme: Populate Realm with runtime images
Date: Fri,  2 Oct 2026 14:20:13 -0600
Message-ID: <20261002202026.1204110-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
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
index b1fb8957f3de..22c8afe21505 100644
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
@@ -41,12 +42,87 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
 
 static RmeGuest *rme_guest;
 
+static int rme_populate_range(const RmeRamRegion *region, Error **errp)
+{
+    int ret;
+    void *buffer;
+    hwaddr size = region->size;
+    hwaddr base = region->base;
+    unsigned long page_size = qemu_real_host_page_size();
+    hwaddr start = QEMU_ALIGN_DOWN(base, page_size);
+    hwaddr end = QEMU_ALIGN_UP(base + size, page_size);
+    size_t aligned_size = end - start;
+    struct kvm_arm_rmi_populate populate_args;
+
+    if (!region->data) {
+        return -ENODEV;
+    }
+
+    ret = kvm_set_memory_attributes_private(start, aligned_size);
+    if (ret) {
+        error_report("RME: failed to configure initial"
+                     "private guest memory");
+        return ret;
+    }
+
+    /* Allocate page-aligned memory */
+    buffer = qemu_memalign(page_size, aligned_size);
+
+    if (!buffer) {
+        return -ENOMEM;
+    }
+
+    memset(buffer, 0, aligned_size);
+    memcpy(buffer + (base - start), region->data, region->size);
+
+    populate_args = (struct kvm_arm_rmi_populate) {
+        .base = start,
+        .size = aligned_size,
+        .source_uaddr = (uintptr_t)buffer,
+        .flags = KVM_ARM_RMI_POPULATE_FLAGS_MEASURE,
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
+    rme_populate_range(region, errp);
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

