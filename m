Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED139B951
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464217; cv=none; b=tjwuLJkYA+ZUfqLJrhA05YMfaID4NX2cE9HMtQiLAUHpgzJ6kHRlyNDez9xxK7xEbBRhDeCQmlO3cE0Ie30tvUQgs+u/G8qgYMIHN61mDbbrhcKEubfmYjSj46KXrTa9OpOHPNjkt2E9tHP1PuR6bbfuZckYnKbe8J3HQLeWGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464217; c=relaxed/simple;
	bh=fpplIAyi6bWFS4AEE5YyB7nMqlvQ5irj75qRSsMsa3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+Ccl1ofyw7NS/creMWxKJG2MRObH9knvsIRku8+UOp8sT2a4Ssw95zLaH2Dr2c+mldXhVF2lyC3ohhnECHy6t/vFkaE5bIQh80REPuZUFUf+fBNxEpcNZb+fEllbHBpKd0dXkTzKs/BPLAngivKqhrk+C9AV7Rjid7EGuQeOEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sHJO9im1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sHJO9im1"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc84e77e78so766135ad.2
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464215; x=1784069015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sdhTsW4I+bhY4ihV01HmgTW3Yi5b9306awX7r7PmOk0=;
        b=sHJO9im1WhOMCBK/bTc9HaiedKZUPzJWVvAq+DBcCRhvw1cQBobJh5hGZGL3+RfJLO
         qtayZxXGulIYCPCVYA8enYGHFkhrg+5dh8asZ9VczFglGpc9/ngUeM4dSVXto4NVzwxj
         zLkFwHRuaMZd8i3RdBMSaizIUSqbUkC9Xzw++adNSNk07HzIqGBHCWibfJaRyPfcjcln
         dWCyHMuPC/rl65IQT8ft5wJPpNpDJTHpGD3f3elB/1hWPKziUMtm6THmGGbuSNie2C91
         emrAcI/BGWuz3rHcAzknDQ5r58S5x0Y1jornfzEFDWmbNQhtYLR8Kp2y1FK7QG4UxOa+
         j/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464215; x=1784069015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sdhTsW4I+bhY4ihV01HmgTW3Yi5b9306awX7r7PmOk0=;
        b=BMzabBoWAS6Pw8OLXhEcjYJ7wAYwCgSgEBwfjYbTdoRLS6yQKm76kyduncikvKmV9U
         LBWOfHHC3kljChthuExNiuZqtrHXsRuztu5XkmrSzsELOIk8Tqxv5xpvF28sg9cd4FOq
         Ernwi/czpRYjSr1ErPcx9HMZwMcMrujVgseTXGmPzS0qtQx72Zip88AUHJex8nPmnsyE
         Vtr5XrwLoJbap+DDoMicBJuQAcEXHZ0vB7ZV23Ff0cso8jVH5vRCGzMEf96/T6ubqsfd
         ZlL/N5p5MGutXAJdKbK5WMoSjDmLz6qSpzowNjJiGPqVL/cvnQyExdQmUKCihO5TGmmM
         9zxw==
X-Forwarded-Encrypted: i=1; AHgh+RqRfREX20TytMjrvAhv7nIl5jtKCI+YiXei2R17QHo8ZXnBTAIqxYd0hQp/blIYHCKcbRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1QNZ63qrfRUNEGoHvQ/hE7+7kbR408n2enQvlzvXwrqN+1I8D
	jEAI+f0NxmC0Mr5jhNC0hDnBBSUm617mRcVcRrTTeOkMVfyzr0YPJPz3XBcOzO0Er8s=
X-Gm-Gg: AfdE7ckiKQICabnRbATiwHbMDhq32sCvvmELGEXtx5guC+A7mJrYzkUFDtWZhNHw2jG
	axcCbH++VZ3urS8Utbn6rYCsvlPp9eir/61iFzUb70Pfcsbt+U1HFWkMH9krTmx5e90ZjPDxCka
	+hy4/AVsonYErYWIsf6acm6fXnIjaSlhF1p6f7FGiAWm2Yu7NN7djgQFQ9ddwM9y3qVcv5Oi8ZI
	8GyKIKAut3PDSkuAGAlJ976SZL9cqLg2Qt/JbJruKxjXESD98uTYcCLbVerI3I2cOT0tq5LUuxC
	ofItM37q9+K9+K27gOWAK2CccpKPiobHwS8yKpJY6Ct4if3mcgLBLm+zeyBEqReKYmaMdaAKE4P
	Rx8K6/1c94l7lOb9ClY2u82srhJCDM8ugJm4khi+H3mBqq0pe4j7BxCl4vQAbdJSFuC5J5saZd9
	2inb8qeYQ0LvRAY7ZNORoXL3VEve8An3XwVxI+9Eh5DlfZ6ozY8Q==
X-Received: by 2002:a17:902:ff8e:b0:2c0:db23:4c4 with SMTP id d9443c01a7336-2ccbe628ac2mr67463975ad.16.1783464215210;
        Tue, 07 Jul 2026 15:43:35 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:34 -0700 (PDT)
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
	jpb@kernel.org,
	lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 12/25] target/arm/kvm-rme: Populate Realm with runtime images
Date: Tue,  7 Jul 2026 16:42:53 -0600
Message-ID: <20260707224306.1202330-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
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
index 97ec7c8934c9..58669f4a50f1 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -44,12 +44,68 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
 
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

