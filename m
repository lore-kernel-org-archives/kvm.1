Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4C50C288
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464225; cv=none; b=nQNGHdf0aiOlzWbkKa1FuZRPq/+ImtsUNwURhnmu5A+P/u6+NEH4XOEsMKTB9gnTjAO4AlCIIP2Ig9VuO4yu7pTcR1e6bZgVZ3QL+S3F1ge3NEwXXewBzzGE2M7AVbIEr+JNarNsoxpwqy6783y+T3BgLLIQPcT0cFEF+3WXsPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464225; c=relaxed/simple;
	bh=3kjSulVQLNpdJGCnkM4enWU4K4Gl5SuK9lAIOWLiD0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbjZoeT6ziCzskRGMCvTj/sQb9+4gBm4b78vzEB2D5bffblhnccOa5quBGUx7e6wGwmoBdoUbY+tO0myUPG5M8zYwzuiUMzza76HvwsoUkn7C1EeyHaWcdQMQQuNZwTi1BA40R6E3rrsyw06tTcT0CFUgzHGrWyjHJRkrD7i7+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PjcpyoZk; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PjcpyoZk"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c96c92c0980so217450a12.3
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464204; x=1789069004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y7O2QFPzNWx332l2m0iFWMqO57jF7lDWROu5Spv39Uc=;
        b=PjcpyoZkU3OSGBICYdpGT3EgQfK4r2ahWUxxjdDdv8dZFG1p3VCqYs9sI/CxMuPIac
         Eo2ffJPPNT8bcEFdLgurRq5cHNEYC3rQwGymqdG4QBZ70YsXJXcVEHxp9TKxWdrLpq+B
         1mUv6ywITvwytM0mMhcjleBUrC+UlnTf/OL7rFDPDHo4yrLX+NojnWnX4mqKEmQ123Np
         JYFFGbZ0obuCiGRj5m7fbz2UdjqVU1BJtsmkh3rerw8I5tUftsRot9jD89LiK+am2OQ9
         mSh8X9dwg6VpBfN2qvsSbfHs6/wDQr3O091qrggZFNuxigPVwL8LZdqcCcCkkfDd+wqR
         Oy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464204; x=1789069004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y7O2QFPzNWx332l2m0iFWMqO57jF7lDWROu5Spv39Uc=;
        b=cj6GEdGoDhXGQSd6iraJcu8i+OOieWBlJGv9EwyqYJTT+xW6oiiyjxJfT4/+yrYpsu
         boD7UuYl2Qh5/byrYW60++Pl4V0qE89zckWAlUpjatBn3H8T6S+eAF/q+RT/VxEYmcmy
         W838Vh/WB3mZA4vdBXCJVAwoGsr8ovO/Cg492kQ9CCkszZm2fTIiCtoeEyMILvch9O80
         EcuT16uyt3lS4XxDgJTPzJOT3JNrdyAy9+smU7fl6ZAHe1q6yNFkU+KyVQe+2cDZf/WI
         /KXJSDjAjzZx117zm37hRWOvc21ME+5xJhzG7+QKKyy0TYEXXR2VRyWpLsnicBLPuFPv
         L/wA==
X-Forwarded-Encrypted: i=1; AKwUvByNXlDsLJqrMEORcLsIDiMqjRLB0w8ZKu7prm0W0HDJlcQ5q4s8KNzD9JNevYNt5EqhCuM=@vger.kernel.org
X-Gm-Message-State: AFuF++nTeRQmhplTxy9ALyBc9lhKDT2n7TZvVQAVKpAGF5E0f+9eXxZT
	AcxFg1nErgIR/M0X5KK+Qe6TxNY5+/uj4me1XSbmuxoaNH6LlC02n63yuxszwg4vaHU=
X-Gm-Gg: AYBFou0VijV7HEbjtz1idwd4SsWd95TxNRm1y4clgqSX1Kfx3iNHMTUBZbbcvoF4TNG
	rbwF0GwCRLSi4QeUslj8VK+ZBLKVb4Zsx/d7voua825Vgx51qn6Ob1cocC7Gj/R6gLb6zAfnKbv
	9w/TiR/vD9kaidVXAFBaMApQCjZL5kMZLwQ25VQryS4W5WBW3O4X6HZpD6oIIup2Wcw7ARbzoEc
	YcxXaPHQcv6ErFkDWdIsMNnNdp2YxL1c9CEg3kIAA3nTfQqZY0acpC1wPC/P0x6/o6yKj1gUgrp
	BlJGnAWzWP+L2QDwG4Xf9AecMqnBmqXsL7zsp5kh56xMk/hB70tmGYbSWQPtcrKo+OGyT6brS6C
	2yWoy7rrdQTGYBSOQuyIOW8i0kKflXP7PpRpV5ekOA5iOLvBdOfTh0rw8gZuAhYKr0qfL8OEZne
	7puyjeQHVLLMQzCRa9+rWorfckK7OArbCBlO1TphuaL0EiNJTOam3GeQL5YM5D9iyivVKOB8ps0
	oI58Qno4h22cf0=
X-Received: by 2002:a17:90b:274c:b0:398:9be9:ab92 with SMTP id 98e67ed59e1d1-39b2629b27fmr1266138a91.23.1788464203921;
        Thu, 03 Sep 2026 12:36:43 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:43 -0700 (PDT)
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
Subject: [RFC v4 17/24] hw/arm/virt: Reserve one bit of guest physical address for RME
Date: Thu,  3 Sep 2026 13:36:04 -0600
Message-ID: <20260903193611.1058589-18-mathieu.poirier@linaro.org>
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

When RME is enabled, the upper GPA bit is used to distinguish protected
from unprotected addresses. Reserve it when setting up the guest memory
map.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 61751aa31e0d..cf3a9320dc3a 100644
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

