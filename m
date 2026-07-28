Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0901D4734FD
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266819; cv=none; b=RZlDVwp4+F0KPy4wYyHqOs5iQX/vQSNrsRN8MdBNxQbvbhc0LaR7dh+IVuyj4YEnW3ZheO31rNSQtlUm6MywK/sct0VvRsrUAdGulhxfgYLVoMcq1rkIP9DQ6sFwAaypcOq81xaWrNY6BMOrxtuBl4jdDSvP+RBZZDpryIEp0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266819; c=relaxed/simple;
	bh=tSj+RmhUP2F9F24HBXeVdtTH4iLnTs+vTkO6Pt4ilv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnepUH55Krm7s2aPs/LalfWN6xJlQEz2jkpl/kbynYG9WHKj27gmX/DFm0thmSZ0ZW2Y6tX2dIKAKk18V314KbP/o51sTcdhaDPFyN6GoXDLNr9gXumu1YZDLlSaZhrk+r7FzMUcKeWwY5imRtTVqZYhBKuo4rrlZsC4lWutnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dbsw6734; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dbsw6734"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso215756a91.2
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266817; x=1785871617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y9/pLOprN9xy/YNaMUPV2tlXHH+UzLYmz6W1kUG4LRc=;
        b=dbsw6734z9yKGACPmkb7n2WyrgWmNOL7iIOzDbYgkCcjSIcZw4OnE1OK3i7TZMpElY
         unbZoT2uPIxE6irI8MRFw+usJQVCP3FDPoP/x7/XTcm34EuzELMwZht0cMn/KpddSwUN
         AAB+8QG6kokqVmTXg0vX77/s0Bk409S4BpJhTpX4InLPB/RwIMOu5yjOGfn+NyAmkBrz
         JIGWrrXfoBAeyBtCVzPi/ods9eSjXpEDiE/KCM8coKuGR+LzNlTxOO0IFEnuKqSzZ6/V
         /WUyoNhrKEgDDt6ATLJxlyq8bnkRcaqwz3V1aheclL3SRZQoWDL+aF5AnmmIw9syQ/he
         Xpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266817; x=1785871617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y9/pLOprN9xy/YNaMUPV2tlXHH+UzLYmz6W1kUG4LRc=;
        b=I/sda/SdMjJmXklhlPrJ5SlHxWshuLoMSb98KYECwe+UUG+WQzQw7YdhEidSY2veJH
         g4y23+707TG1h7h7rFiemSc9wwHAojKLRV5VkLO2RvYfN0xU6nHRY4lx4hAso33Or2xo
         fs09LO+3l5//CBaQ4/qXZ+OTgC86xFD3JrlG9tDYIHMKlsdvNPKFr/MzjIHVm4aOTNjk
         xoy0pdPt64f0T/YZ8dTCACkmQi7+Og/OXuwRuIkY5G8bpycXiMLEzCoO04DsVWcusbxs
         kIfwnGS9Bh0f9bgvxduBvqe+ibeJ6+m9AV533XhWRvfD4vSJ13cIWrSBrmKg22G+ZgsW
         tIJg==
X-Forwarded-Encrypted: i=1; AHgh+RqnDBBUcBSHoL9Mccx1kwVQSI6tTVuM45ljzU2q1ZESFI/SSR6kpVNftw8K184rDL/e6uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbvKhWWKKxt3TsRFFvFDyjq18fMdpb+ey3fI1cyGNrfVI2LmFW
	pJRq4vrmwN7OHE3/wk0w/sbqqCDZaPkd6StSH4v0QKaPepvMpwn/8hDobmQAPdaK7pU=
X-Gm-Gg: AR+sD13mviADStJG22EGtfkrgt4sojvozvIc7IVYJUAnxG6kC+riyq1MPlS6wcD5NcO
	Pa9atqEt4IRzBEagMULdILIEJgUaW9ArH5LCirKpzyam5L+TlYOA1A/MSrLLuP/4v531Z4fWK41
	P/3pPNNbIavXiNnki4nxXRYovhngHdYIsEYmO2V0VfzKNkkCFYqLLyYhzOAeXmMA54TiLcEbB3r
	hSDmtDanba0GgSDk0wVO+GXn12qCpcr7vXmUV9nqXurAoD7ukCUp4fnTLr6arbwILMaoFlUGq16
	Jj/1sgWKSYLn92HsiB3ZJi0XmPOU548OS5MFqXQ3SuecL3/tZKYbqGwwXQtZiwCRE7iAABCmyvG
	e14sZki58QZCynHiUrKkFaVUMWDbJ76Q2M9tQ06thszxaVueqP2FZ7svoHwY6b9g30nOHz1zH+x
	aA5tjIBlb4pQVtLPc6d+m4Ttm17Pm0fDbAdd92ApuWITDbRU9oEr93EjfiBNjZI0TB5aAEjYkV5
	VkBfSKpZLOyQ3c=
X-Received: by 2002:a17:90b:4b50:b0:38e:659b:f366 with SMTP id 98e67ed59e1d1-38f6a27d798mr3746529a91.0.1785266817324;
        Tue, 28 Jul 2026 12:26:57 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:26:56 -0700 (PDT)
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
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 11/24] target/arm/kvm-rme: Populate Realm with runtime images
Date: Tue, 28 Jul 2026 13:26:17 -0600
Message-ID: <20260728192630.240375-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
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
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c | 56 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 10bca9a944ba..335ad60d0f3b 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -43,12 +43,68 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
 
 static RmeGuest *rme_guest;
 
+static int rme_populate_range(const RmeRamRegion *region, bool measure,
+                              Error **errp)
+{
+    int ret;
+    void *host_ua;
+    hwaddr size = region->size;
+    hwaddr base = region->base;
+    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
+    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
+    struct kvm_arm_rmi_populate populate_args;
+
+    host_ua = address_space_map(region->as, base, &size, false,
+                                MEMTXATTRS_UNSPECIFIED);
+
+    populate_args = (struct kvm_arm_rmi_populate) {
+        .base = start,
+        .size = end - start,
+        .source_uaddr = (uintptr_t)host_ua,
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
+    address_space_unmap(region->as, host_ua, size, false, 0);
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

