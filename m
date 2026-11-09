Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263489;
	b=eRm5Eg4II1Uw5PsVojLPS+tvG8s/dJpyTzlhu4UJrOiOw5AFOFNNvTn3wy76BCGA3T77
	 jpokonqptsarDo+1NIX6qG5xNNKCT1B+w9JsmwjIvp5o7vCupYNLT2fA8VvpZP92tqd2V
	 xq3ulGNP8T9Rd/vEmHJMv2hKVkKVhD42k9V3IthcZL1UyNZ3YbapLm8F/ABNar6Vx/KWS
	 jjxWZl0TxGdA62SDQCDLYY9/0XTDaR3GIUe/VHoa8zHEzgHdrI5F6YVyLsILZb8D1emGe
	 e2OywatK8v5T9CknHx4rjcpGYY6mR4ebZjV113JJS0SD3Aohxd8ne5VAmQuAjaV0G6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sQYbIzhYybqZKpHEFkom106KOJMNZUoms04H7LpX2sA=;
	b=Ilib9XS6a1SjPoty9eXs+yAH98uABVxWpzRxGvWnQrT7Ob3e5BAwF7jfmnAS+okVonOV
	 MRqLEm8cZPk97sOXONlkj8YmLM/7fZrv/rB69HAQxL83nywoB7DL4pigtpA74S6fxuN11
	 4JswD6HcaYT6IPNBubJzmVsBQ0NCQ+ENMu/LEmGAgQ6IdNwDjoRhKn+a+9EjsSnCj9wIQ
	 TTF/Qgou26jKHPiM2RxSR669EiQ5Zd/MVEom5BV4990KO4MC2UhryvTGuEsOBezJEv4SF
	 fxSK9iCp69JbzOnBTb9csOVFAi1oyzoR0yo+gACAjr/U+WwuVMM0YQEoH3cuZV/AUAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Rdn0+gj7;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB24606A33B
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BB24606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Rdn0+gj7
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a058315c79so696093b3a.3
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263489; x=1794868289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sQYbIzhYybqZKpHEFkom106KOJMNZUoms04H7LpX2sA=;
        b=Rdn0+gj7t6Dw9fvrgNfXEgvCn/Yy7ZmCPUuU3APnqa+fLhCWOXi4sJZ/kfS1NhkTKh
         bMv7DyAlSdFvd34VTqrOnvTWOoJ2vZEzaw16/oPMQW+B64oYHKPfNGv10egYrzXvnFtS
         jBxi3ctvv+wEFi2HF/VuzxowQMjDXfxgLdtcDi/B2Ep8DswE2cxcabJxB5EJPJ50xRLp
         MrBCTNUu0+z+Tpvs8sX8DWRPYhVLkOVal1HAS3HqJaOeI3T7aIeTwaud8+OIRGbIbkHu
         xLV2Hl8+KSLA3xbljnnAgTztjlgmsUC6A8OD0QzBfZlODIY6edDjjqkqqhDwHMgSJkTr
         8X7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263489; x=1794868289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sQYbIzhYybqZKpHEFkom106KOJMNZUoms04H7LpX2sA=;
        b=hkYbBhsqMM4njiUSiuyEUJL41MusD0SkscDKqViiAUdi/q+yrGc93f+es6eTq383O/
         WUgYYUrU0ebgCn4goC9KgbYNtDasSoBp7w1zMYWJ9Dv/l1vXbhvRKqCZ4YF7RH+Qlknd
         rEitoDw9nXFqMKkOIC8ud/NqHqadCCak0Fv2RxQ4dk1otmn4TMXWWlivs0ocH/SMdccc
         0LzzJHvGT5xmKyLihWZw8l3YEB+oyXwnlRtayfuPefj22VOC9fZ25XAYYXQWHvjqEiQe
         P0MPWLqwYfmJ0ZRBajmq5di45c1va1r13OzY1e07oqY2JfFoFfJN1st25TAKMk7zBrwq
         NHMA==
X-Forwarded-Encrypted: i=1; AL+hErEFEL81QYsoiWmULBoej08VuMEc8+U+YNv45Ly/RjsBRImknAoE+392rkOTVZp23y6cfUc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8i533MbmXqoVsGEL0rfHFCSGhGgrc36+H/wU/To931zXsgZc16
	Nnz6pWgED3eYcdZdXwXtbJuGd4j+0TGhswX+oVSydeBoq7rliNiEt0bNBi6AvKlgevQ=
X-Gm-Gg: AYBFou0hvoba2HYa8y4n62TaqsAZSgCYaA1xciDTfL7vd9z3UkUa6EyEh6f1f2MYnKj
	tS7UUIPBprOtG9IvcbWA7RFcSUlNVxN80ESt/PKMNKrDUOR6TXnvIp9oYse934oFWi1w3jNwii/
	9bPVVmeek/j4Ted2uRDvTK+SOslCv+WpI9ouGJlzd63hujELhUWMV3sp9NoMqyg95t/+mi/TB64
	vL0s4JOGjRV/oTtVgTf01X0jXPP4NRnHQB5OZiN1Uj7IKVh6T9fFEld3T0F+/h99g/vb1onaQBZ
	dENkdFEuoy8YzDzj5QYaZoeEuxKzPe+LkvoSdea7G6VV5NxxpvgP+GQE/cdBd6EiBqRaMKb181Y
	0NIvyoFKCn3rot9kpBhscj2M6gZIwowZIqVDXMam5n75dAlTYJVQPuFY8u7N6Tua33J2Q9MmbuG
	f5OYgyVwjGdJeWhUamO4l5C33I2PLC3xRyaevMtb4U4mKqMYQnFunJxKJ1yFJyXXl5Q8rvTBV1j
	3iJapEq/wp6th7I4dBNUhg2Y+6Zj4FppRfidc+E/Duvn10S+fvALhACwAJVjuKUX7XQy/J1BykP
	yY6h+ieHpvJlS/GIByAfXVb/ZWP6NkZYp/8rYV3brIWUu/k5cnsIbA==
X-Received: by 2002:a05:6a00:812:b0:886:cae0:fb6f with SMTP id d2e1a72fcca58-8ba852368abmr890817b3a.14.1794263488778;
        Mon, 09 Nov 2026 14:31:28 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:27 -0800 (PST)
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
	gshan@redhat.com,
	michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 07/23] target/arm/kvm: Use kvm_vm_check_extension() where necessary
Date: Mon,  9 Nov 2026 16:30:54 -0600
Message-ID: <20261109223110.1619504-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
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
index 63a3e78efd53..dc1004785cb0 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -384,7 +384,7 @@ static void kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf, Error **errp
                              1 << KVM_ARM_VCPU_PTRAUTH_GENERIC);
     }
 
-    if (kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
+    if (kvm_vm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3)) {
         init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
         pmu_supported = true;
         features |= 1ULL << ARM_FEATURE_PMU;
@@ -695,7 +695,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return -EINVAL;
     }
 
-    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
+    if (kvm_vm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
         if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
             error_report("Failed to enable KVM_CAP_ARM_NISV_TO_USER cap");
         } else {
@@ -726,11 +726,11 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
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
 
@@ -1978,7 +1978,7 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa)
 
 void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp)
 {
-    bool has_steal_time = kvm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
+    bool has_steal_time = kvm_vm_check_extension(kvm_state, KVM_CAP_STEAL_TIME);
 
     if (cpu->kvm_steal_time == ON_OFF_AUTO_AUTO) {
         if (!has_steal_time || !arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-- 
2.53.0

