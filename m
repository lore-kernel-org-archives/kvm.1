Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF76741B351
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464208; cv=none; b=hNBsnV+6g/t2wgNGXrdOAAxhkmBmmBlbjqf/5a7u0hthRA9WUjbzlrDHDe5N/BVvwWl1LNfd1lBsHgZ62275z6k/0BIOpAxesFuwvJE1KP7h2BMrOGnEr6cZSwes62ZRKqdcUbLAhGNKiH0AbAI43VLqf0XJVQOIXzVo6XPZkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464208; c=relaxed/simple;
	bh=8be8IuxsmREnYgJjkPI7Htwu0aicNKTCPwCHVyJtVJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMRlk5dStPSHUYDSMaE5OVOyZ/f0MgLBXtHuuQfn8BshvXUUjKffAY+VxSU8OyvDYDnnd+B6po/diJWLxHef2c8m0ydbyItgV9XGAGkbL3u00pQkdlJ9hse8sY++g1NSRy1cRT7QwPB+y8Tkx2ok0D8B4saB2Px9eDFTEkYGP1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DAsyFJIm; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAsyFJIm"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-380cda7f00cso65575a91.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464206; x=1784069006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Hja6qHGPQODpxQ8LqX3XJ4cmNcTjvVv4dMZ2DbbCzg=;
        b=DAsyFJImB4U0J4EVrunQSpV9iQ0qpXWPtNAXLlF29sTuEiuGNNTOVd2wdMxsVBpTmi
         qn8ISulbSnMjlaaDhbSNutXovxvkhb8PxtihnJ8qsH5lXcq6ioubXYdrk431MuhJG8/8
         YXYF+zy+x8mkeFxvDm1TxWhRgBiEXzTllA6xW4P7l+Slqs2kBV5hQwz4y+Rvxq0/nf5P
         qhwVCXSI3kSW8YP0Lk+4ARNn67iB40JtQOw/waeFRzfODgmt/w5nOxxYi5oxiA5LVviG
         584CRURc7pHdzIWxtzXe1uNNhXHAxThZ5h1Ar7k6DPO6LjntdCbezfTXDOrPSl1FMXG+
         OEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464206; x=1784069006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Hja6qHGPQODpxQ8LqX3XJ4cmNcTjvVv4dMZ2DbbCzg=;
        b=KhTJsQpYfOaUmociDLCG8tElEf5IL3pFS0i1V5lH4kfncNX5Htjn01C04bYJwzhZfB
         0X0Mp/i3cQpxe9M/hqC1IDO2NeUwK7tRAVkCv3fi+eiuUaN8YjvdyPOdF2RTSpvyxcKr
         5JziMlEdNCDwox0ieekBNQlABW0qyf0Cn+7uBVZalz72phm5Y6YZr9oaFBdHjjjNmfW/
         54Sh6wdZI5NjFYuNRAgL/vQ3RuV9mAAn1IEFsS0U348ck4+2VmHx0s0r4+X9fa8Wj1Hc
         nqM5gjmO/5kt3FcVbyQWKufmKvh9Ph31Dim1lnNIWBl0eh0W/cjcP0phUPQOIgJV7H5X
         XB8Q==
X-Forwarded-Encrypted: i=1; AHgh+RqTjUTmNdfGLRlJmXWz4ZIzBSUZEMo4bL9gbF43I8mlJsBj0m0QnmKVXyUGo3xLVixU+2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpbRZtYVyTjMXn2fgjY9eBd5KiCAylTC1v+7qINKoFkSH/TPni
	zX4loXtemTcpVygR4gRsIPB+tWYSb1sLACFi2ji9kSw/ktDhT/eCbF5rXRpgTUjeq0M=
X-Gm-Gg: AfdE7cn5oqGEpWI6HTuzR14qAWMxTXAEw8Vv1h71UH3YkHukvbGPgUycnpHMsyWKnRN
	KUC22vnM8fSZI6Gp91ZxdtVBdLhAkvky0YMlYhiTFddvd7ZteLRfem0e97WnG124CNYC03lqxUb
	kfy1MbgW8GeAsDHTRRPOtLxfkYMKLe78/tpFnz+Ncjz3lewzE438F2YFLdegXfAwGmjIbj6yatY
	WUpA1Yv+8875tuCqQhuXVViHTkzgeLcoDP9nE+TNaKOEM/pyYH3MLTNIDuuvQXb1XHA7uDNBoL2
	eMQ7EWqn/3ocAnOJMGdbYAnpp14tIh/26u+0ToQu8r38UxI2FzMcms80arVo+peGrxNOyAE67q3
	L/bnRY8N5GQ+qOJEhYOR4Nlrv8CSqNcJDr9nKpJmJsCSkP6ywBCBO4KJaOzXxRN6cRAzmvOPjuf
	ZZN//FqldvdQFD5ui9U0/0xBeWfnrkZawSmHGlkFcdStMFglW/Sg==
X-Received: by 2002:a17:90b:3808:b0:37f:9cdf:f037 with SMTP id 98e67ed59e1d1-387572b3d9fmr6146459a91.26.1783464206246;
        Tue, 07 Jul 2026 15:43:26 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:25 -0700 (PDT)
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
Subject: [RFC v1 08/25] target/arm/kvm: Use kvm_vm_check_extension() where necessary
Date: Tue,  7 Jul 2026 16:42:49 -0600
Message-ID: <20260707224306.1202330-9-mathieu.poirier@linaro.org>
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

The Arm KVM code can return different values from KVM_CHECK_EXTENSION
depending on the VM type. Use kvm_vm_check_extension() where necessary
to ensure we get the right response from KVM.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 6aa1cd04e484..c69b5310c184 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -328,7 +328,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                              1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
 
-    if (kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
+    if (kvm_vm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
         init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
         pmu_supported = true;
         features |= 1ULL << ARM_FEATURE_PMU;
@@ -654,11 +654,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
-    max_hw_wps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
+    max_hw_wps = kvm_vm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_WPS);
     hw_watchpoints = g_array_sized_new(true, true,
                                        sizeof(HWWatchpoint), max_hw_wps);
 
-    max_hw_bps = kvm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
+    max_hw_bps = kvm_vm_check_extension(s, KVM_CAP_GUEST_DEBUG_HW_BPS);
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
@@ -1905,7 +1905,7 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
 
 void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
 {
-    bool has_steal_time = kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
+    bool has_steal_time = kvm_vm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
 
     if (cpu->kvm_steal_time == ON_OFF_AUTO_AUTO) {
         if (!has_steal_time || !arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-- 
2.43.0

