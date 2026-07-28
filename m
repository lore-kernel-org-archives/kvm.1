Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FAF4734DC
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266816; cv=none; b=XDsE2mOlYGHS1z4Ow3SCckD5gTNNcQwQY3FJHgyiXw2O/zU2JP4Y0L+UMSnCj/uB+XI+p2tevcczEVj0oJWHv+uRLYXFuttfh8/CeE+HEDDIfEgV751u12tyV+5lxQ93kDg8g2fFjCx8KCrS90pNc483mZbeAE+ps1QlMotEGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266816; c=relaxed/simple;
	bh=WMyOuzAuc/tjESApaFsagWSlloHjl2CQ74DdH54Iwhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHKuY1GKGjSJwkgL9LcGVXBS7akKA5EvNyrrgc8kMxC5xda8Wg1UB3j9/r6gGQoXdNkHIHwympoukSwu90teHSN2tUZPX2lmhiQR3TyVA0Paq7kw+BTTACuQ94/ebNPPosuFQPLu/dF1rc7/FqI0YkHD7qK/kwg42b3sXv5kbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UKq/A6mX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKq/A6mX"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso190978a91.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266811; x=1785871611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mFQLzsllffyN31O2DXNS30O6LLhjzrmI1+U27crjJrU=;
        b=UKq/A6mXHEhpzWMR0Y7PELpjOa/VGJ8vPeeuqS1tsoIoQ2VizMx7hLE8iIpCxT+SYy
         FX+HJ19nU0r6tyTWoEx4IvbFtNLiG6jJWy8lpJAIH6LWyYcKk+w1PHzN2pavkwYSKC2u
         Perzcb+FakTdrA1Pgdk2f381e+Jx1u0Ogx1ezk+UUoJ7BGbxhPuMIpzR2U/uf7Wqn0kG
         9M6zUID/BSLnNX1hXAV5o01XSwXkttrd1c05QpWTVQM7snVLOquYaZpfMvl0N7FwGbSj
         qsH+gKLltnq0yrp9Z0qhWh6BHFpWTbDPtLU+e9ItHkDLosBulq9WFyibO9FUwS0LQKVj
         FfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266811; x=1785871611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mFQLzsllffyN31O2DXNS30O6LLhjzrmI1+U27crjJrU=;
        b=cJxjFyFKU3uK92b4pf0s5MCFENyTYpv+73AMTLqU2hXvvNfDpNFeu7pdTC5vxtNDAf
         FzVaW+Xw67HYmZ+Wl34qyeVEjJnfqdLGE/yHacp90WNSobfdksJSXtkF/oBLbish3xwv
         kXPWKzKlnhOElm9gaUZ/yNCeoKtpfq7RAj2yMHtwkdH4rsZ+up1tIDOFB77tZM+dZugL
         3fmKKweZhDrzdTdMdmX0R1mMGjHnOC+/BRQFCS3vyu9yk8elb8Gf6P8WTbHNCdYFJS4e
         QCRxayhCeNoR3Bei+486wKGtEh7Z+B1z9/mnn9p2AIaGoCkj6p9kI0Qul3MbfEJKxqEs
         LiiA==
X-Forwarded-Encrypted: i=1; AHgh+RoG4IawKPtScCS0liO70MHAbOC4cv0yPMLgURXKoGz1AeBkxFk38PMtnRuYhG66ZYzdpq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8GKMTpQzOBTmfqLICCtkBFLdI0efR8s7rk9n8ep054QCJsCaj
	padzKOtperapbjhjKX38nyVEE3EhIf86WUbF3cL7LLiXZvx2tRYN5+cSodvlFBk/SQM=
X-Gm-Gg: AR+sD10jUicWnOp2AXPoK8xBqDA3zccje95S5BvOxXt8xOP4stLMdEPxqnXFXBwc5aX
	bII4TD/8SyKyg71GHXYjvuuyIgkDgh928XLd/PwFJhrzyInKeChBVyFLMPTORps8RjDNAetPUkD
	e66zoR45BjRBXJCJPPkUOJ9maw4EHVSsUnqbM4jj4DRANl6ZUaFTbtail/5gGkAVSByCCvkIV7d
	Txn43cZDmDseLczNx68PY5Vt6AiMuZCth8SPjFZ5losqKt1lkvoEaYwLm5MNyfhavTr3J7uAq5R
	4AFa1+ifAcnz8TcduZKdM+qwOwC/NOgShJHGj5KkFdCXmH6o8ISx1o+lhSMXg5JSWlmwGa/0Irf
	K3ZD+QuQT8/vZzsXfaV1rCTJFPo7s1kdD4bPDmBjPKX3M9rXs6PiibOSWNbA+MjPlVRiC5T47A0
	F+OgshzupqeBv8xwsr8BGgRhzRz4YQ
X-Received: by 2002:a17:90b:582d:b0:37d:a52a:ff12 with SMTP id 98e67ed59e1d1-38f6a30c7ddmr3585247a91.10.1785266811540;
        Tue, 28 Jul 2026 12:26:51 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:26:49 -0700 (PDT)
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
Subject: [RFC v2 08/24] target/arm/kvm: Use kvm_vm_check_extension() where necessary
Date: Tue, 28 Jul 2026 13:26:14 -0600
Message-ID: <20260728192630.240375-9-mathieu.poirier@linaro.org>
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

The Arm KVM code can return different values from KVM_CHECK_EXTENSION
depending on the VM type. Use kvm_vm_check_extension() where necessary
to ensure we get the right response from KVM.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
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

