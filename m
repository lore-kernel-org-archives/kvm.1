Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6346E509EEE
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464209; cv=none; b=bH0oI9/AP0dldezD0Pp1qQoj3Vjq763bmJkenklwHQU3uNtbrsGHZVVUas+6jPZj3Hoa+U05A3Cxhl9IxT81d209AdQMuUDJIM4+RmXvPL+DPBrR5Uq0YrrkIPVCCjuqHUk00FqaDnocv2GoChvOs/a9g9OqY8JCW/cSy3kNvlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464209; c=relaxed/simple;
	bh=HIie9zRSxUfifPTm8OKzv2vrLGE1zj0QYzXp6BFK6q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pT63xy4cjo0nPFB4RTSEpVrabTcYnn7AFI+VMq+xh/JlowrV75ACn9nz0QjGFJhSgf5Td+Gh07aPpNFM6B5RrZ7zF8m3oNq+XxWGQu0EDxr5iemQ40kYMCPqrWj2/idfJroVYZnlhmY5ytMoLxt+9wt5wQKXqD/bV2oLB7Yow98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mi4YMSfa; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mi4YMSfa"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-39927410578so272821a91.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464188; x=1789068988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WkBIOKR4nn6Cp90N68JmMr/qaQZgLTq2QO4yasLXKy0=;
        b=Mi4YMSfachMEV8m+blTMHQDKKmet0bYMZCO5UyiyBSjBJBnbVkDzCILLSBoNAGZdGQ
         MMxenb7brCZ5PGnDpU21XCQTvzOEbISRBUk11iPf8dvqhT7lzpgp7bXBIGTG0uwYfAbq
         G5xnA4DM48SNwIsN+ER1X8BdLw983EYoEBnwdL3W0dZLA8lfzrZ8E3MG8xDeTTGnak3U
         59ewmsUvJe6LgtmsswHw0ltSNwSKo5eLYNIQ9CExtdBJs1JJDtws9ecid8I3eVx8RqEl
         M7VhO5rB49pROXuOQbPbGo/3KPd4Nvz2ewhDproLCgoLjmbsw5qkmqZCDl+/QHfz97Nn
         BNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464188; x=1789068988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WkBIOKR4nn6Cp90N68JmMr/qaQZgLTq2QO4yasLXKy0=;
        b=Fup2PFjN9VL/Q5gTdRH4gJrdYHYkghzkpOq9VM/l6a+lUr/u7Y/YK7C9cAYeNlPTUq
         rANGUgKMS+OoWmLAC5aZUP0CSL2CQD0xGNqML0b1TKeRqhcCNGw+4XNkGET1wHtQzxMq
         94rkn5/WOdQcwNANP5UiVaMzCfyCr4VIN1Yd9EeJSgHhSGJePmYbTfcxQHrnQninvzn4
         /+YzesZ0+PFF2+OFKleKj9hG+5FQGdaaHLmirT/3vCY3jsFoFWHlC57e7raBLxZXptIJ
         MqUnBMR4W7vCoKdP1OO6mSl0X+4+SijnT70S+0CSzGD2wnmg/A1hsglr9UkKhxc3B69e
         Wnwg==
X-Forwarded-Encrypted: i=1; AKwUvBz62V5R7epOwbDcbFByYPIc8YlJEmrNbCbWI2fSAJEfwAEojANwQwfo7ksR2pSyhaT9zNU=@vger.kernel.org
X-Gm-Message-State: AFuF++kVSgwgE9ywG2oL9FEwagTl15Fmo9gF6uesGImurLZz+cJIa2nG
	M3ceHg9+EqbE/h6/V+nAwkGsHUgMPN5TABqpt3Mud+m+qJfaARsJnH2e6uzl2jWJgIY=
X-Gm-Gg: AYBFou0ANKXjm4sYRKFyErUuzVrtmfjoSenJXvvUceQQf1pnM9bCuxA0e+uzwYBY+xQ
	B6tv8oKQMZVC6LtXlsy0rBiMFh6uvmHszy9unE8z43KT6RzkZoFsPdYCQ9U3guf5nwz6KuLgJeP
	blek6fdpd35zOT7SUPBi9yNIKDvBdXASy2+Yx6yknznb/i4ukqqfXgqjZ5E/KobGQ3SjFYgp8e/
	+ybnTqSGYtEWWs8fiGuRdIE6XzqgS9sffHnV8oZzX6yowTq7dEyxWSBrGHJYsYjWYkduGKUwZA1
	7zekB5i7KYRIfgO01ehpzNa9yMLOpX3KNyBcOTf4thNEknlav0MOknDcthVLbvQgDFaHz1AgTt0
	pCBuOBnLpwpvemV47UvZGwcBjERIn19JHKLtAsmm4ukUV8p6iJzG4N755e/tl35oiDFgBWZfgLk
	9imSe7fhJLAaATbVKlUzNYXssh2hwJxf0xJOZQC38+C/5OPiJt5eun+1JMKM/7KqaD7c7JWaDG4
	A3qZnQ/M/O0PTIIG+5hkF1mNQ==
X-Received: by 2002:a17:90b:394a:b0:393:19a3:4f1 with SMTP id 98e67ed59e1d1-39b2613150amr1206644a91.6.1788464187787;
        Thu, 03 Sep 2026 12:36:27 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:27 -0700 (PDT)
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
Subject: [RFC v4 08/24] target/arm/kvm: Use kvm_vm_check_extension() where necessary
Date: Thu,  3 Sep 2026 13:35:55 -0600
Message-ID: <20260903193611.1058589-9-mathieu.poirier@linaro.org>
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

The Arm KVM code can return different values from KVM_CHECK_EXTENSION
depending on the VM type. Use kvm_vm_check_extension() where necessary
to ensure we get the right response from KVM.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d86e66e056b9..ca25b707a0a8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -331,7 +331,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                              1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
 
-    if (kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
+    if (kvm_vm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
         init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
         pmu_supported = true;
         features |= 1ULL << ARM_FEATURE_PMU;
@@ -636,7 +636,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return -EINVAL;
     }
 
-    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
+    if (kvm_vm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
         if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
             error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap");
         } else {
@@ -667,11 +667,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
 
@@ -1913,7 +1913,7 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
 
 void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
 {
-    bool has_steal_time = kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
+    bool has_steal_time = kvm_vm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
 
     if (cpu->kvm_steal_time == ON_OFF_AUTO_AUTO) {
         if (!has_steal_time || !arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-- 
2.43.0

