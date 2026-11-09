Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263494;
	b=MtqJ+wpigorzZ2QbjqHX/+LwmPLH8bXy6QgTTCv7nlqU35V37G6A2GaRaKaI6/wDtmed
	 rOgynnTKSgHq4B1ZxzPN0WubaY1LluUIFSwTEduOo7nZ2oNBrQI1ccLsywfXjPL1LBOtB
	 zxoiuLqpxwWB0OIQxGK+tD4rmb64nr2DxW7u81i/e+CKKDSPkD7r35/bb3r3WievwAcv5
	 DRTq3hlHYkFZHXiI9U+ufpV/vcpp2AiwTsZW4HQFq7ivTlYBIwGVR7SWkwmiq8zb8Q43s
	 qEjUH7dvI89ZxDJ/VbDTzXfsrEZFVTaPg4B0W5Fco4XhDUUvPBhjDmxfDHp09UVBd6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=btUbetnuXJs/xXAN/qzDAKN55zdtCIUFJdsrBrK8sZE=;
	b=CoQLgpLxPLnd9SqveBghcFnrso9ZjRTlwOSCKLuzcpA/J/xcTGjn1NVBfO3f12/hwDB9
	 9+N/BuzDvkjohlgU2aNKxAVBn552kmH2LhUzy1lEUELLam2IoCBWv2h3bEtpX0AiJhAuF
	 1VfDcuU8krrNU4O6nUH2fRAa9qh4f6ibwcCE9iypIfz0WCLt+BGKJrI4ytQVSFAzDE2JO
	 MXtvRKIyD5lFQXm+hY5IyPpUMhRxo6a+AbSgeA6w+YKOfoEtSdeo36Xa4CSyc7qMIoIzO
	 J24v1vh84hww9Al0vhMgksBMrBP6Vq74okeA5nsgsxPKIvSRnc/v5GqJ9ezLehUCOAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VK4H1u7P;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C451606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C451606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VK4H1u7P
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so629306b3a.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263494; x=1794868294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=btUbetnuXJs/xXAN/qzDAKN55zdtCIUFJdsrBrK8sZE=;
        b=VK4H1u7PiE/2vI3XhxzKuX5tozi8wYRlkf7imF2xpRMamqTemihftmuuqluS0+HFMY
         zTIE8hI07sJm/QRfLQcEpPPeHP712ZenP6OjkVKMCVUTXiHgyBstwpBiT/6GE9y+spbw
         I0N+eyIBMxC6eugolKMNK+AKC6IWdWiXjcWM2LnRowiNnAENEZgeRHB51SyJmxI+Zgs3
         xUzTyOwAIjf/qBRSI9yv+3QrrkqURbz9LDMGXSsiZMU9g9rWlH2x80WZ7MnshGM1WaET
         FQji/isKeA73G7RstKaLHKR3Qpzkwz5zArDI50sLhhfxwEymnM75qVhypx5APM7cyqq0
         Ncxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263494; x=1794868294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=btUbetnuXJs/xXAN/qzDAKN55zdtCIUFJdsrBrK8sZE=;
        b=d8ASwQnhRwwHQ1GC4wCrqDbTeGKbkW1W0pAycbtltpPFkD+b4oc6WjjUgFG0CB2iir
         5CnQ1xE3NDOOr4h+ZD37EcUZO0bffZzqWpM0yHmUFr1DYBHYg9qh3+PsA19IOBo6k3cZ
         kjQMj9Mvh6AHP6lsXi/igrvQneVz9zeatXAay0kV2thE7p0daZcorNlzPOYrV5SKxzh6
         bY0LXHSiHAOhlXAfsCqhR/5Ou9UAMaTD7R+tmz7uSTJ1r4Ti1XOES7e7p8XaQeTQ2OlU
         ltADTNscpKg104jNi6drgGX420VCDSXz6iGQUfsJMaM91kUsZ8N3W7DKOOzZtHEgpLm1
         cmQw==
X-Forwarded-Encrypted: i=1; AL+hErEnbcftAFbORXvbmu14sGMSuZEcN3ahPCpcD6n6Yjt43fTnTA+Qn1TnjxYGsjv7dVXNL9M=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uMfV/EHxgD9HGaQauh45R5nEmi7L7AlbpS4wKk/VXjjkPLgGr
	t4lsEhlmnH7bijuIIgcJ3sJzmF03YM7VX9OEMWdY9xPOqo0ooHueI1FhyImMQJArykk=
X-Gm-Gg: AYBFou1ZwsckUZbaRvqJGK97+px6HMtO5mbTe3bw1wd8wk0aN3TMk0hQuga2m75Rn9q
	ta8ofowINYy5hx6qw/snSooY/l+MBBypbvo0BH0gjzeeea6p5/q7yU2xixz+dCfF88Q6JlSNCcQ
	OhATLHTkYOmIJSc0egoIIDlRCN9Z9fYI6I8xMtrihggG7m+HC7vLR0om2R/zNFCn8UJwg3xXxNP
	SYidyFXC6aPXvXu9EBEs4UdY/D0HWLo9OisCszrqNRxz/nrPrLALV3BjN11+cyzA8jaWzJwX5cv
	yb2K5Nj66joNq08A7462rf2N0KSG5d/ZFuvNzjg+3lUFt7GiYz/gvnsom9Z+pZVkDGM3o9Z9PwJ
	G8wC1hxfiTSROXCfYtfjphk2AlxRxiFkfr1oT2EpcHVDL0VL2uElgLRuysBB/Dr2BZBvF+rFRcD
	SPOC4ubUEq07hqnGBPHorm0AhvLYDO5H4MvQVzeK5+Z0HW89FZ+GjDgt2wEg7TYWzV2MyF3qMdx
	qj9NUPiMoDSbFibmE7vaNc1eVt/wHEOOpGiamy8WPnf8yj2GNOKWQBBbHC5/3FvVGjINeiTK2Fn
	xIdbMubGCLPXHZaOTi6eSva8ey4ThFTc6/wDs2NmlpOau2ta6/7EyWI=
X-Received: by 2002:a05:6a00:1885:b0:89e:9c7e:fd56 with SMTP id d2e1a72fcca58-8ba86d850cbmr871469b3a.33.1794263493533;
        Mon, 09 Nov 2026 14:31:33 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:33 -0800 (PST)
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
	gshan@redhat.com,
	michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 10/23] target/arm/kvm-rme: Populate Realm with runtime images
Date: Mon,  9 Nov 2026 16:30:57 -0600
Message-ID: <20261109223110.1619504-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once the Realm descriptor has been created, tell KVM to transfer runtime
images (kernel, DT, and rootfs) from guest memory to Realm memory.

This patch was originally authored by Jean-Philippe Brucker
<jean-philippe@linaro.org> and updated to account for guest-memfd
convert-in-place by Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>.
It was later completely refactored by the current author.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c | 166 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index ca90bf5af890..0996cddf0849 100644
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
@@ -29,18 +30,182 @@ struct RmeGuest {
     GSList *ram_regions;
 };
 
+typedef struct RmeAlignedSlab {
+    hwaddr aligned_start, aligned_end;
+    hwaddr end;
+    GList *region_list;
+} RmeAlignedSlab;
+
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
                                           CONFIDENTIAL_GUEST_SUPPORT,
                                           { TYPE_USER_CREATABLE }, { })
 
 static RmeGuest *rme_guest;
 
+static void rme_populate_slab(gpointer data, gpointer err)
+{
+    RmeAlignedSlab *slab = data;
+    hwaddr aligned_start = slab->aligned_start;
+    hwaddr aligned_end = slab->aligned_end;
+    unsigned long page_size = qemu_real_host_page_size();
+    size_t aligned_size = aligned_end - aligned_start;
+    struct kvm_arm_rmi_populate populate_args;
+    GList *list = slab->region_list;
+    Error **errp = err;
+    void *buffer;
+    int ret;
+
+    if (*errp) {
+        goto out;
+    }
+
+    ret = kvm_set_memory_attributes_private(aligned_start, aligned_size);
+    if (ret) {
+        error_setg_errno(errp, -ret, "RME: failed to configure initial"
+                         "private guest memory");
+        goto out;
+    }
+
+    /* Allocate page-aligned memory */
+    buffer = qemu_memalign(page_size, aligned_size);
+    if (!buffer) {
+        goto out;
+    }
+
+    memset(buffer, 0, aligned_size);
+
+    for (GList *elem = g_list_first(list); elem; elem = g_list_next(elem)) {
+        RomLoaderNotifyData *region = elem->data;
+        hwaddr offset = region->addr - aligned_start;
+        memcpy(buffer + offset, region->data, region->len);
+    }
+
+    populate_args = (struct kvm_arm_rmi_populate) {
+        .base = aligned_start,
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
+                aligned_start, aligned_end);
+            break;
+        }
+    }
+
+    qemu_vfree(buffer);
+out:
+    g_list_free_full(g_steal_pointer(&slab->region_list), g_free);
+}
+
+static RmeAlignedSlab *
+rme_init_aligned_slab(RomLoaderNotifyData *region)
+{
+    RmeAlignedSlab *slab = g_malloc0(sizeof(RmeAlignedSlab));
+    unsigned long page_size = qemu_real_host_page_size();
+    hwaddr base = region->addr;
+    hwaddr size = region->len;
+
+    slab->aligned_start = QEMU_ALIGN_DOWN(base, page_size);
+    slab->aligned_end = QEMU_ALIGN_UP(base + size, page_size);
+    slab->end = base + size;
+
+    slab->region_list = g_list_append(slab->region_list, region);
+
+    return slab;
+}
+
+static void rme_insert_in_aligned_slab(RmeAlignedSlab *slab,
+                                       RomLoaderNotifyData *region)
+{
+    slab->end = region->addr + region->len;
+    slab->region_list = g_list_append(slab->region_list, region);
+}
+
+static GList *rme_swizzle_memory_regions(void)
+{
+    GSList *tmp, *node = g_steal_pointer(&rme_guest->ram_regions);
+    GList *slab_list = NULL;
+    RomLoaderNotifyData *region;
+    RmeAlignedSlab *slab;
+
+    /* Memory regions, i.e @node, appear in ascending order */
+    while (node) {
+        region = (RomLoaderNotifyData *)node->data;
+        tmp = node;
+        node = g_slist_remove_link(node, tmp);
+        g_slist_free(tmp);
+
+        /*
+         * The slab list is empty, so simply create a slab based on the first
+         * entry we got from @rme_guest->ram_regions.  Since ->ram_regions are
+         * sorted, we are guaranteed to start with the lowest region.
+         */
+        if (!slab_list) {
+            slab = rme_init_aligned_slab(region);
+            slab_list = g_list_append(slab_list, slab);
+            continue;
+        }
+
+        /*
+         * Slabs and ->ram_regions are sorted, so we know the last slab in the
+         * list is always the current one.
+         */
+        slab = g_list_last(slab_list)->data;
+
+        /*
+         * TODO: Add support for memory region that straddle two pages if we
+         * think it is important.  Doing so may lead to large memory areas that
+         * may not be accommodated easily by qemu_memalign() in
+         * rme_populate_slab().
+         */
+        if (region->addr < slab->aligned_end &&
+            region->addr + region->len > slab->aligned_end) {
+            error_report("Memory region [0x%"HWADDR_PRIx", 0x%lx]"
+                         "straddles two pages",
+                         region->addr, region->len);
+            g_free(region);
+            continue;
+        }
+
+        /* Add the memory region in the current slab if it fits */
+        if (region->addr >= slab->end &&
+            region->addr + region->len <= slab->aligned_end) {
+            rme_insert_in_aligned_slab(slab, region);
+            continue;
+        }
+
+        /*
+         * Allocate a new page aligned slab if the region can't be fitted
+         * in the current slab.
+         */
+        slab = rme_init_aligned_slab(region);
+        slab_list = g_list_append(slab_list, slab);
+    }
+
+    return slab_list;
+}
+
 static void rme_vm_state_change(void *opaque, bool running, RunState state)
 {
+    Error *errp = NULL;
+    GList *slab_list;
+
     if (!running) {
         return;
     }
 
+    slab_list = rme_swizzle_memory_regions();
+    g_list_foreach(slab_list, rme_populate_slab, &errp);
+    g_list_free_full(slab_list, g_free);
+    if (errp) {
+        return;
+    }
+
     kvm_mark_guest_state_protected();
 }
 
@@ -55,6 +220,7 @@ static gint rme_compare_ram_regions(gconstpointer a, gconstpointer b)
 
 static void rme_rom_load_notify(Notifier *notifier, void *data)
 {
+    /* Each memory region is free'ed in rme_populate_slab() */
     RomLoaderNotifyData *region = g_memdup2(data,
                                             sizeof(struct RomLoaderNotifyData));
 
-- 
2.53.0

