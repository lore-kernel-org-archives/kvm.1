Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF11A4734D0
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266833; cv=none; b=K6J8BQMSCYZ7QKr3Crg1MbNQSV/kaWimnLSkS4pTid/U+lN2wCSZqGMnvINULnNzIof4+Sd5BPau4lhLqjxrfZj0khV9/hpOIOrnNITthmUuX8jSkN7CFhOSf8OY1JLq4TVsDleymsohMO05sCwkfywW2ysVeRzcfQtDiu4qJFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266833; c=relaxed/simple;
	bh=2+KdYV5sda3Pjy4f606s+t9MhIBGXHcRYu0KIXtbkTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVkTqK2l97Qpxb9AZMJSlBTisOkJiXgrl1Ev6k3FV3sw8p4hNS4y1TmeF3vleBCLmcGEat6jjTRBu2hppyfNmWddxAfMVrncCEBfz5Jn7QYMBzNUjDKEt5yGef9xqk3wV3B8nZRw6d/t2VV+gHWdnorkMsLnMo5ULNorhxhhwY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jl2Yk93U; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jl2Yk93U"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-381b831d535so268940a91.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266832; x=1785871632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pK2tYb+uha0OTzKJ3jiWlIwpjnwXssFbFzC9Lye+Plw=;
        b=jl2Yk93U1wWpAzQGqMzeU67X6DK+OzKWU9GkVBMtRQubUUQvxIi99APpGSbwFoOs2k
         Y4CliR0nsNP6NJyeIjKpKJZBgQdtRcr/n50rvEmsY8ZAfMNzQ8K5d+5Mhv4lJIn/Rx2F
         eNdW1hsddtnJHEKnwUmxhQk7680Nfyxu/17wAlj8ZtRGXmWRtOi1+/+yIwDCR/dehcWG
         nwPyM5NYMK7GLykpugm4weDT+Nn1yQrOhzPKS5/vwx7gere1pVrGTgW83QsaBnWo9+vh
         oCYLCBl5bj/UcJSSib3+mrxCq9nwZ9UtF2XR+8Ix2wgYXw1T44C+WGm47sYO7GVxBJNz
         ivng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266832; x=1785871632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pK2tYb+uha0OTzKJ3jiWlIwpjnwXssFbFzC9Lye+Plw=;
        b=hUrQL1qG2Bt7t7S4GDSd9hFZGJbbn6sYcwibRdaPQkREy6ywJppDZ8XNDkizci0ths
         ILaY65aR5elhv0lHqMCXosFpLp89bb/nATWfF+uL+8qNOfKBglaeXNr6YQ8XLIEmIR9h
         FTDVd77g6pldUJOEfdfGab0DST4b/mdjmkqS0ZKCCvw3VALb1Z5b5AuzlUlPXu4EULKD
         fz2xfqurfbOi9zLwN0TGMDyb1VvPWcz6WjQ5JPUWNo8NuwSkjLcUWWfpdQS6FtHz/yi5
         V/SSvqG7AmJi48088ped+2VrddgGSt3126wxDx3suOBFVc5/oAzDV1HdkrKAQ2T0IFS7
         8VOg==
X-Forwarded-Encrypted: i=1; AHgh+RpZ8/RmDncbCYldrN44qzB5rourLbPXJErDZQqc2WS+h3IFsSAkLSDcy3j1HxhQqzYeu+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/YGO1pt1oTM5Td6KnRmy0sLCgTs9E5aDEmp1nBLffjDKkcls2
	XPgy5pBFkrzblaCMjYOIkKzRx/wkRc/a6IuEj4e9HeyVG5YP5zYC2qt4GYE0S0MAy2Q=
X-Gm-Gg: AR+sD11DL/tR7wxKykiG59WqkXevsTcZoJAtfY97woOHLeSEI7CC14hljhOr/KuwKKV
	imKvfYXWGuLhLJ08CX24Mo1klBmj/NZ8M8vahV+sDlZfqp4CC8IgMeTlYoasI0ku0nsLUSZb7zv
	L8be5OyjAf4aDFCjZXGOrtlquvcof8iIPnt5uQRdUykDdkoZ5jEPW/viGteTF4COFIuKZoThpFC
	BC2F4ULU6GrV57TeA7CFhYBLaFECNbthgiw5mAqE2pwZ0uY34q3oPP3l0/BKmMw8tD13dbptm63
	rQJOOoCPq+NQS+2xySnrMmcF/OQZPRQd3miW/nryte0NL/L5IE7zGRymJnJHo0KJBPU9sTHDty+
	Oe1D7NnYEZsAbLopv1aiOssa3XXhdxPvanZmMwzhhuTuPG1O467T9gGr30wZI7kNKPf5CUK9nPq
	Z1nTaG6dHh8bKTy5oF+KDHUBI0MJH2SMwhCO1ZyJ7uAAnahkvlP722O1TBXQ4yKBvd3uvSvi1Sr
	91R8rLQFL+c2Fc=
X-Received: by 2002:a17:90b:1d04:b0:38f:57d0:3a9 with SMTP id 98e67ed59e1d1-38f6a51c0b8mr3938868a91.36.1785266831998;
        Tue, 28 Jul 2026 12:27:11 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:27:11 -0700 (PDT)
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
Subject: [RFC v2 17/24] hw/arm/virt: Reserve one bit of guest physical address for RME
Date: Tue, 28 Jul 2026 13:26:23 -0600
Message-ID: <20260728192630.240375-18-mathieu.poirier@linaro.org>
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

When RME is enabled, the upper GPA bit is used to distinguish protected
from unprotected addresses. Reserve it when setting up the guest memory
map.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9123f46fae4a..fa6cd62a335c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4054,17 +4054,27 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int max_vm_pa_size, requested_pa_size;
+    int rme_reserve_bit = 0;
     bool fixed_ipa;
     int vm_type;
 
-    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
-
     vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
 
+    if (vm_type) {
+        /*
+         * With RME, the upper GPA bit differentiates Realm from NS memory.
+         * Reserve the upper bit to ensure that highmem devices will fit.
+         */
+        rme_reserve_bit = 1;
+    }
+
+    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa) -
+                     rme_reserve_bit;
+
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
 
-    requested_pa_size = 64 - clz64(vms->highest_gpa);
+    requested_pa_size = 64 - clz64(vms->highest_gpa) + rme_reserve_bit;
 
     /*
      * KVM requires the IPA size to be at least 32 bits.
@@ -4073,11 +4083,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
         requested_pa_size = 32;
     }
 
-    if (requested_pa_size > max_vm_pa_size) {
+    if (requested_pa_size > max_vm_pa_size + rme_reserve_bit) {
         error_report("-m and ,maxmem option values "
                      "require an IPA range (%d bits) larger than "
                      "the one supported by the host (%d bits)",
-                     requested_pa_size, max_vm_pa_size);
+                     requested_pa_size, max_vm_pa_size + rme_reserve_bit);
         return -1;
     }
     /*
-- 
2.43.0

