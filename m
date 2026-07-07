Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C72E442120
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464209; cv=none; b=OaBEWUGPuhEjWsvA/5N/L4DulSl9zEgYMF3HUtFeQ9pbybrv7e6ktPhssBhIkFi5BMIbb6D4IKWqAsAZjKqzOwPFI+pBXHw4pNJKY2K3kulm9tt8Tjd6XNd3z8Z3R8/Ibmbv2B6/f1/dG/otQloWvMKh9JOPClvijmPvB2KZzd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464209; c=relaxed/simple;
	bh=DWOVy29ZfI8CUCXt9osXNqCLxCUmmUluPBKJVXgn9kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0xA406cbcY9WEo2Z4X+SwanMOCrgAG/KkPf+QV2O3KkhG1KCnmGYo4znKn19KjN8IkV/0EIXdDz3QWh36rnZQLBJyJTbsQOz26JAiKWoSVs600KHbq3wljXhYG1frsxXY0m8lA6XSQjyAxFZul1CbCNXikWl0gLHZ6uQApzHqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LSofYB31; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSofYB31"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc61541f8cso16772925ad.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464208; x=1784069008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFExSdxFK8RfkshviK2HeeDzgoNR/sUY6pTQO70u6q8=;
        b=LSofYB31wFGEhPbX1Ll1WuFnrAW52IzrJd+tCOTsq8IZNCVnvN+LMxP74XnRN2bD/N
         zrkSrCy3cyk7nfMBJWwf3N5GznU7v4WM3c46s3i/j/TaxHwoJoJdnRxzqtfuKVFarkQI
         zZcw/m4ryWB5NCU0xICJukcpy92jLn8fYpa/0tqFX1/rGrpcznvdlOXHL5dxjbu5y7mz
         nGL731EPWkrOpCa4FfoibYEJAukgqzSspl9PtJJkII+OyOxLwBa6pXdXl5MMW1fnI8Gh
         MFmLz5gfhTIZRi3dlG5aI3ey/U1WFGC/a7KhWl0h9kEC8TjKsf6zcHFMbkjz9ufDLS2T
         93Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464208; x=1784069008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eFExSdxFK8RfkshviK2HeeDzgoNR/sUY6pTQO70u6q8=;
        b=mY6+oGBopb1qlDvx9uY3siuqPk+hOjyGDJPXX9ZYIZk6tzqG2S23sro9gq8wuF7kc9
         /MH8XEHt05GI/kRhqfitU0SZPP0IZSM1zYtzSx7WRQUvrDI0pZzWwATXrZMBmd5R8BEx
         2oz3sQkwuplAcNQTWcGduZTGPdLjqOhMQIYtaQQdvTePFQmrsum36iALGUfjjL5wRPDx
         xJoZlbItApAfdghjcLPS687EMpJwxuyMe3ozJoLQrmp3JLSxuKwGxkjS1kjYR9pCGV4y
         MFqo7Vw/HP2cpDbUUSDuZH0QGiHumZtIgHtuHLvZGlZV+ZfOE2ZX2TMnHjOuZSR5Y/mM
         V9gA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5jpGkPYM9IdE7lbKqvZkDkt6rbyXnN4FGzR+qwwI2R8okD8stLPFmOFKgi5mL7s7gsP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXzY7s++wusdfV3PEFJJn7nT5nPtbRjnmqVuI1XyFnAvCX7Sok
	0i3E/SN3HqPaEJp5btiOzJwKcFYhLDuWyF70DR7b3hO38KbigifAGwyQWE3+00aN+JI=
X-Gm-Gg: AfdE7clC3pU6YoCq9i9BnCCMAghO2DI4I0Z0rxTix23FIJ3y2ED+IJ2XNQFwM/qzk85
	T3DZBBx2Sj2vgeg/vwjf3YOUrmBZgZHZJUZZm6cawsXjJgsbAzSzO8M4Au621TQv4mJfmChcbbG
	nH3BiEe7tFcJHPw/xubinYw+X0W0J976rtxtAAgYafiA00YiVyyii48gzlOP1tFAy8lLwO9eZB0
	qfAYsnVS0Rj7duhusZrLapl4fJ4Phm3A0/1lzo3TdDYDg9AfD5E5nEgXS+WlfD3MRySkGb/5nY/
	va3h7Zo0u2pLC3TXtUmKcPQB+i12sXepb7lwAhblOSai/0zXIPo9t3ncIMDi9rtKTM2vAf1ZRim
	dnMpKlYj7zEKKtq7aQabmZI2zo1SQZinZNl03QjuqUDQFwAXnxUt8aJydYWpMAECoCIelQbInKb
	TWZWBN/JmPLlXbJmREvWKSxqcY2961G4REr3rOk2k=
X-Received: by 2002:a17:902:f791:b0:2ca:5023:f983 with SMTP id d9443c01a7336-2cccaf31b0amr41495705ad.29.1783464207883;
        Tue, 07 Jul 2026 15:43:27 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:27 -0700 (PDT)
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
Subject: [RFC v1 09/25] target/arm/kvm-rme: Initialise Realm Initial Address space
Date: Tue,  7 Jul 2026 16:42:50 -0600
Message-ID: <20260707224306.1202330-10-mathieu.poirier@linaro.org>
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

Initialise the Realm's initial physical address space based on
the VM's configuration.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/boot.c         |  4 ++++
 target/arm/kvm-rme.c  | 18 ++++++++++++++++++
 target/arm/kvm-stub.c |  4 ++++
 target/arm/kvm_arm.h  | 10 ++++++++++
 4 files changed, 36 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 9b7553dde5e1..bcab21d349b4 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -32,6 +32,7 @@
 #include "qemu/option.h"
 #include "qemu/units.h"
 #include "qemu/bswap.h"
+#include "kvm_arm.h"
 
 /* Kernel boot protocol is specified in the kernel docs
  * Documentation/arm/Booting and Documentation/arm64/booting.txt
@@ -1210,6 +1211,9 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
     /* We assume the CPU passed as argument is the primary CPU.  */
     info->primary_cpu = cpu;
 
+    /* Mark all Realm memory as RAM */
+    kvm_arm_rme_init_guest_ram(info->loader_start, info->ram_size);
+
     /* Load the kernel.  */
     if (!info->kernel_filename || info->firmware_loaded) {
         arm_setup_firmware_boot(cpu, info);
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index f763d5ed6199..697e7d507f0d 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -22,8 +22,16 @@
 #define TYPE_RME_GUEST "rme-guest"
 OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
+#define RME_PAGE_SIZE qemu_real_host_page_size()
+
+typedef struct {
+    hwaddr base;
+    hwaddr size;
+} RmeRamRegion;
+
 struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
+    RmeRamRegion init_ram;
 };
 
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
@@ -91,6 +99,16 @@ int kvm_arm_rme_init(MachineState *ms, KVMState *s)
     return 0;
 }
 
+void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
+{
+    if (!rme_guest) {
+        return;
+    }
+
+    rme_guest->init_ram.base = base;
+    rme_guest->init_ram.size = size;
+}
+
 void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
 {
     if (!rme_guest) {
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 6d52f172c5df..790e1940fd8a 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -42,6 +42,10 @@ bool kvm_arm_el2_supported(void)
     return false;
 }
 
+void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
+{
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 65ec1b970606..c7dc45595159 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -267,4 +267,14 @@ void kvm_arm_rme_vcpu_init(ARMCPU *cpu);
  */
 int kvm_arm_rme_vm_type(void);
 
+/*
+ * kvm_arm_rme_init_guest_ram
+ * @base: base address of RAM
+ * @size: size of RAM
+ *
+ * If the user requested a Realm, set the base and size of guest RAM, in order
+ * to initialize the Realm IPA space.
+ */
+void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size);
+
 #endif
-- 
2.43.0

