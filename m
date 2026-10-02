Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27662518127
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972443; cv=none; b=ZIZAOeqxUR59Hy5C03zYvlR8CqJErEYWheVHIqfKtbg1ZitsY8fvuqWUchIC3TMAq+MxJzWKADS6YC1tJSxcw/Y+u2VOISBNnqfkI3dl1Hc9D0WaoBFO3lP08wzGdZi7ZSVQ3aS1MCrGJkW5CA3x26HHaaJRe+0mX7kn/M069eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972443; c=relaxed/simple;
	bh=WUwRxM/PmYk0icPtXScy/LS6qMwi+3G/ymjLOD1FRQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZEJG42hP9rAZMRX4O1S4DI9ozQm8nGzlfVP8lG9BnvBeCVLOhQMpT4a8SA/krDJYkRdp2JbCQYRpNHLCHtOc8yP21NM5lgiscmNFAr3b++Bv373vvNW3JSe/LNo9K3QB8W3ZyfulCL+7yTmVKQOJhuNqZfFGvrYauQ8nbhft2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XngmQ775; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XngmQ775"
Received: by mail-pj2-f40.google.com with SMTP id d9443c01a7336-2dfaf76605dso4365ad.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972441; x=1791577241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EfHTpgqhpSdXDZKkZsFnRcwEmJHGyPGoGiJFvPu1kmg=;
        b=XngmQ775h7ba+AlFoX4SeIryVxKv0DCt9NCeFrIDyxQWgdVZM6ItP1AaW4o9DrML3X
         GIx9j+SjRExjok10TR274DQY7+JfxspACZfD4GyKgDFm1Ltut7am85dqbRbenIPghdmO
         pIDgu1TsCAxqzzHsFwxWeyetUc3phxRfs9nd2FLRyqevFf05rY82G8MZlwXl9oBJlbpz
         ovPJHyp5BBs8JjK5ba3Act+3V90sLfVOWHAC4BbCdV4PMBZL/S1e4cKSMhvyWYdV9pxE
         gq9ypUU5536aIJ6Av5DTOJmMCqI8arxewFFdJ+xrLFVJnmOCwbeatN7TIRFD/XSx1rrZ
         tfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972441; x=1791577241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EfHTpgqhpSdXDZKkZsFnRcwEmJHGyPGoGiJFvPu1kmg=;
        b=1tkets73HPolpQtLlYgOwUuGuiiti1GCpGTu2pmJ2CFtAJKwKizd5q+2zY3Z/iTuiB
         /8npxjeA6zFq7vMudyaWak8PQn+c7XZiO/j0qe1NBqiEXc5i31uUI9qmGHthsLwLUJM+
         xpGKY7kc7mJt8gSfD7cpYBchyrK36201uLVgPZL4/BVue4hF6lE4sIKbtVkovH8cF9ss
         qX1uRexAn9Phmrm9WIyNsUm6iRPMuOoEnn4jCggVEZfdpUvlDps4PbDIjYUBQtJCIe/L
         tQhUoWefyuugQIrlNk299CkK8KOpnp72VpKYaJx9Ninb1bYgA5ACLCv71lmAZlsQRufJ
         Uq5g==
X-Forwarded-Encrypted: i=1; AKwUvBzpbTUBRYuLBjNnEg/g3owxnWtvVPXjyizLKXzWQGuShinOMROaU0JyrrG7tk3oO4ID/44=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIEMl5wXlpHpnFnQx/JUMYf6hVInNkSMwW6uncwILRccQsQjPe
	afRjqNFN1MW7AmYir+EOfZbDe6Pd9tX280FWyZexpyBbFDUP4Kv64qTXyg/RWfpTY+I=
X-Gm-Gg: AYBFou17pYTw5Fxncfmz0dvjP9ErLOdZpfdxtb4c7G+Jiydm1mCh1X5Cidnc8xBNcoS
	y0SIiNmVd6BVNWp4QUqQK8jwbGbqhSL9Ld0LXkWIxpxC5CVl0I8mYzz1XDluP6VkOeRIAZcdzmW
	d/twZoeKBaXzyYSvKQL1jkdZltyL/SvesvMKPw9F83S0jQoq831nVUE+3q2J5WpNGdtuBfXVNUh
	sfEVODAl2FrCresxz1y/BYlQ1df1vhhk3nOTOKpmLmXJnqtOKyC6IAIbeeIb10s1/uZecwCBNWY
	dB4zaiMMleSB/4ntfNf3znF2uQC8wKJkEmy/mohF0RDMLMQZurExpfzjw6nAOQ1dK87d+oV8cC7
	/IH37wgR9NC8/ddZRG0DeSP3SrCxnseV2GLgIAElijubrO3k1gADl2qIvlJeP3t+v8ZEzZgHKkD
	JPjXLEGF0BbD4mFxf0T+fCyshvTYq0wOI+eUcZnbPf8g71oZsfFVlUl9ThfberV0LVpkIQZzU2L
	iXHjOjJiGPiqj4sEiUvN952
X-Received: by 2002:a17:902:d987:b0:2dd:c100:4b80 with SMTP id d9443c01a7336-2e49b6d9f9fmr32764805ad.55.1790972441200;
        Fri, 02 Oct 2026 13:20:41 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:40 -0700 (PDT)
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
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 07/22] target/arm/kvm: Use kvm_vm_check_extension() where necessary
Date: Fri,  2 Oct 2026 14:20:11 -0600
Message-ID: <20261002202026.1204110-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
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
index 8c74785998c2..10d911a56b0b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -370,7 +370,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                              1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
 
-    if (kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
+    if (kvm_vm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
         init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
         pmu_supported = true;
         features |= 1ULL << ARM_FEATURE_PMU;
@@ -679,7 +679,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return -EINVAL;
     }
 
-    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
+    if (kvm_vm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
         if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
             error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap");
         } else {
@@ -710,11 +710,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
 
@@ -1956,7 +1956,7 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
 
 void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
 {
-    bool has_steal_time = kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
+    bool has_steal_time = kvm_vm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
 
     if (cpu->kvm_steal_time == ON_OFF_AUTO_AUTO) {
         if (!has_steal_time || !arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-- 
2.43.0

