Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4052E3EAC6D
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695284; cv=none; b=tzz5i7rLaBsPENsmKWyesmfozsACAa7Z6zjsLAFx1G9VozMQUXVAyZOgVXsLzOuFsadDPfhhf9FYM07iYuU53ygUtX8dDBoO3eO0gVJA13s5Sn1saJTx43MbyJAkP65AqN2huG8weoIz7gFtwNF+oq5F0RB9chMUheM/0DDHGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695284; c=relaxed/simple;
	bh=gpsAmgqRByBHn6t4d56IQvZvmYshNL2kFLHvFak0hiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1VyCLrdbEJx0YjwN4SG6oSHCbUwAehQ7Omap2KtpOriFboG7O/b4GTjJHn167X9pwiTzbLxKGoW5SroxWLNYyL88bvxAMwLYM3AI15hFNzJ1JEjSwdwU33M0ejaM/ZZRLYlS1igVHFe0VLiRH+nya7sXXIgZ/o/6J52yUqurZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SarMVWii; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SarMVWii"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso244253a12.0
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695282; x=1788300082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Yc9MuHh9PbC3Ytohig4KatF9izBef0JRQCyKKLS8VY=;
        b=SarMVWiiAJpS5abui/jPFHDpbiHdwFRdq2JvE745NmT1U11VZop1t4pEoEz+balVrq
         3PQMA/8WzDLnF2yDvT7GPKCG9X7f9e8QtB9ARi3uVRz8LEY7ySEd7+qwBNUOGUkhwSoC
         t87eTwWp6zIazZn5Uho88ViZnO374d+RNNHyKtVb5PLI8PGDLHuZjv5Xs9MxyU0y74MV
         3VnVrXlqMNT0MM2SK99mUBjmriKcZSsisypwcVyLAMPDm/ysvL0cfi018kLwo/cda6JO
         3X/Tof8oZYCEnjDBmsvNn64LBMwJo/BrQCPT3j90xntvGKKWSInGOR1EjRAgbHa8EJHH
         /KAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695282; x=1788300082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Yc9MuHh9PbC3Ytohig4KatF9izBef0JRQCyKKLS8VY=;
        b=C3kgD+cjt1DKu1GGIVo9d/PCw2uCMDEr+wNN61T+yXlpFYHrAq5AwK4uQbCQBUwwPb
         r9XGlNkum22ZWcfz4I7qL47CKTg6+ewu5wQCgXuUbzVtUmNsrb2xGdpVRjB04IKO8bxi
         Qd6+LrYTDULWLy7HL4Zmwe6zJfrc7K09FtU/MjF3dWDSXwmLu3Lmo/vuZuWnv0UKoZD9
         ClOoWSpV/bsD4aZyGPelCPf4JBzr/1d/xeMJmn6VvXFaOr9qJCR7OFq2BJrpmy8UtB5T
         ryuPXxmOfUli36yLdYXwjC46e2Kpz0pep6fmyQnrwgEuPiBO862G1Wwnk5C5gFQaJsrg
         eRZw==
X-Forwarded-Encrypted: i=1; AHgh+Rr8bCv6pjIo77CQXdsXmKnNvPfi3e/I3V90xAO+BpdaOKBihsvfa02348m27Bgv5AfYSN0=@vger.kernel.org
X-Gm-Message-State: AFuF++kdiI1xK1xXajVMBpoWsiophMVuGJCAmWpOfMOG+OAerie0/zj0
	2cbx+d+Da18ncvkcIPDK5LVAKIn/Wu6L0hC4Q/kHXEewYXSYkvoTXCvfXr9SZCl2kTE=
X-Gm-Gg: AR+sD11OeAnR64VELZXKD+DfSxPfoUNk27r7wqLlC6uvhu61TDS08vBpULvlbVw30R+
	ZhiR6cI/3SvjTb2Pizhyuvh9sAs1X0xMyjPGgwkQZ8IVaR0QZgpPX7Gu0LFO70NjFGuTFbKoZoK
	jkUUeKBTn6y9An21U/2Sm76QMmFycaXkVuK6rot9+mfJBDm2eqjmugjVApekPlUVy7Lr+CfVyaI
	iNiibqPahH+n/q7IXpvpYxkJDRoND5AJR8ysUVX0fAeJ+0jALupq8iCbEszLiOyn4OZSGRP6qUW
	DKqg9Si5AV7VuJu9hBVem8aEFPYAwBq8rXFc24Acpfxl+O5iwkHG0asaVAMUb7gUC6VUPeIlOUB
	cCNHoODW0LdjgFOynzKSpoFvUonIpZFJjCFi4Ei0105ZoyTlgE7bJX0HGeeAhxg0CD3PU9LHRPg
	BWmfc6wKzbYFA8TAuuh6GaEJzazihyAyTjYSnF8fQ0g+ndXVxP9ybLO0KXqwiLDmrkZwQ7QOeMo
	ckKir+bl0xn8yw=
X-Received: by 2002:a17:90b:4d88:b0:395:4de0:b78f with SMTP id 98e67ed59e1d1-3966d36e327mr4349485a91.1.1787695281998;
        Tue, 25 Aug 2026 15:01:21 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:21 -0700 (PDT)
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
Subject: [RFC v3 08/24] target/arm/kvm: Use kvm_vm_check_extension() where necessary
Date: Tue, 25 Aug 2026 16:00:45 -0600
Message-ID: <20260825220101.3443954-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
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
index 1acbd885bf4e..c02845486aa9 100644
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
 
@@ -1910,7 +1910,7 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
 
 void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
 {
-    bool has_steal_time = kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
+    bool has_steal_time = kvm_vm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
 
     if (cpu->kvm_steal_time == ON_OFF_AUTO_AUTO) {
         if (!has_steal_time || !arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-- 
2.43.0

