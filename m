Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263486;
	b=NVcPlVCX28nMXhAW9OvwafWiqya7SwM22bB9oaRmIxc9IWr83Cp8NKw3/zceVTKJR4Dd
	 HBKYK/xcZlpNtcWGTFEWa9s983Yl0JMpzD+VZ+lW32QJgeUPIwCXOzJnIaPPOVjma5zNq
	 +Ct9O4TVQs5MjTc9i4rq/JuvTGbczN5/+oVrp+bBoyAqWNnEUxUCHA35V9lO1fwFt8ldA
	 tDQ7kyy1Hr9LMroHOppsMIOAoLxt7FvYYIIoi8Cwc2MHaQ8DGVC9E4ITuURwNxgdI8omJ
	 dzOwrwFaapSLywrS9x5D1BVzyQ4agPHw42ekS+cwYPuplCRE549K/cr581kYEEdSsyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QabwaZ3QztE12fUnRQUDmJLjH3Q7qN4pzyHF5b0I4hg=;
	b=1OBj1TojJUx7jPbVbOncUQsbEZx9Lid0I27TUHPJicou4IQRpte0y6BAzpH14V5B5sDf
	 X1VcK3JFHmYpYX+X9IH7UzUAjTGTWSlxTTK+UJ4FPHybBCFHkYM8ffFHuC+jxC9ePlzKr
	 QZsqj2HOnt9/73RKl+/GxcUE0HVx9wLWK3bItjUhdT56yBuJwsnAygLr14isoTaSQmLkz
	 xPbOAkzxyCxGrF07PhF+ua5MfBGD0fExdmKXmaEgNN5Pi8nae35CrGNnCa7oYYi3NB+qh
	 aa/1vWe2r4TC4MVBO9saGb+FuTTyMfCstDrVnk3wnWIfQSBW32ibcBJLFfVt9epxBeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qyswAdQA;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05B6606A331
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C05B6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qyswAdQA
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b9c51097e2so496987b3a.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263485; x=1794868285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QabwaZ3QztE12fUnRQUDmJLjH3Q7qN4pzyHF5b0I4hg=;
        b=qyswAdQAuGpKGoGDEl7LmA4RGMQbQ3QhDAW93M02rg0SvKdZrtjDL4SFHxiahKs/EE
         8WWZD8YmGxotMFSYgaWLH02CSc1Lg0E0wjidvEoHy9fiUXqNl5iBYB7LtFx4N+2UYVBH
         asZexEIgzTPqZxjZOu2Us0hHIZbXHBhZTZiHPmpHAPuntk0JH3ghSF7oOd/699Z3i5xL
         oapfx3hG6+cBdioKrPI1VD0gkC4ynIRMO8FZigzJUhqTa39CVStRsuz3cZ5oimqQWlHX
         qOAT45cZCqQEmRxl4UfYxyLezXojkM4+oiDTKzd9zi4lTvvydztqKMts0KYhUKTfV+8z
         TW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263485; x=1794868285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QabwaZ3QztE12fUnRQUDmJLjH3Q7qN4pzyHF5b0I4hg=;
        b=jF/BlmvljWzHGf9TK4bwNqpxTQ71F14DZBDJHYMZ6MQtop48NGtwgaoJgiVkdh/S/Z
         BpaHRKJRuXNzsVBGmr4gCVNIgvZRByFtpHDWbRuMcleFcALF9d79/XtnJ0f5Hwc1P/sW
         a3dPBssxrgWiyeKp/KP81p2pVT3++kw2JHSue4Ztzl4gfrh575w14VJGhygZ629nU9kF
         7NdC4vUdICBYHxbkG2FGGSSFfkNK+ZsolmrmMfKIf5QPyQUqOie1H4og/jMlA1hGfafm
         mZHaRVM5rZrHyFKcSRHKmJ8Br6kUqAEqW3YbpoZWzsgdiNHEakh5MxqyQ4+83KSmtWUP
         bU+A==
X-Forwarded-Encrypted: i=1; AL+hErG5Pu5uFugI1agDti0XdGIY1mzwUY74uoy+vZgz62lEXwnf4XBTRF6rtXTd1F3JiTvajoY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CY6ylFP395UlnAs+gTvRneYJmDqcVyUKHjiSLW/yrcCl4vp1T
	HqnkNrct7N+3OQDRLDh3oQp/b+FefocYCDo1648bHomCNtoZinSpXcwyg7BNoMc6H+w=
X-Gm-Gg: AYBFou2KFNoYcceehF0/pWszLZrwb8JRY+JeCGqaMWBmRqUlhb9V5e7ZmY7aN2avE50
	7BWvQh/7mHMboYK+VZ+JwjlffQSrGZRcDF7xuQYjNm8qVXUf/YGl2SfrEvwSWs4SwtblbJoR5tT
	aeFPbgllRmnH6PXCYcG971TdgNqawUGqN4r9Mmn/kOlfjPoe0EcHuwduqKdU9Z+f6GC4k0YqjsR
	L3DSVIDV1jT2b9vD/tjfL7HwnpXNSQr2VQGxJ5gx3zW6/Pj68pw/PX4v//wgT5p7LXwOEIyyF4t
	/qq+5Ohb60ZfbRtAvcTOcxErVJrEXau6QJAaYlVRa4OOwR7xpmdDkhq7wuIHQrIZTEHVJUxwLiA
	WZrkfv+v3YjrUYNcyCmEpsRlwH48vRoql5dQh5uRXJzh3uK3I6xNi5gF6wj+CmOpoXXBtUCEPAI
	qky21xEqZxTTIOZQtYBIGepHxxPoPnyifP2IP726mNUWj0qZUozmQO2U7hgDyrDJtvrkhNoW49m
	mwft3HdX4qSJqHtne6n+pQ4X875Zj/rOAfPecOHXvrIy/albbCbALOPoY9ltWYh7tuyPMUiag43
	HiXNkGBK6rDsmJRu1zwgwcZvc4n0XPXNpCiA386SkP4pLnMt/Z2VkA==
X-Received: by 2002:a05:6a00:e0e:b0:886:73c9:89d7 with SMTP id d2e1a72fcca58-8ba85237216mr903536b3a.11.1794263485006;
        Mon, 09 Nov 2026 14:31:25 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:22 -0800 (PST)
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
Subject: [PATCH v6 05/23] target/arm/kvm-rme: Initialize vCPU
Date: Mon,  9 Nov 2026 16:30:52 -0600
Message-ID: <20261109223110.1619504-6-mathieu.poirier@linaro.org>
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

The target code calls kvm_arm_vcpu_init() to mark the vCPU as part of a
Realm. For a Realm vCPU, only x0-x7 can be set at runtime. Before boot,
the PC can also be set, and is ignored at runtime. KVM also accepts a
few system register changes during initial configuration, as returned by
KVM_GET_REG_LIST.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 5f40b665cb7d..941951a9bc05 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2257,6 +2257,29 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
+static int kvm_arm_rme_put_core_regs(CPUState *cs, Error **errp)
+{
+    int i, ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    /* The RME ABI only allows us to set 8 GPRs and the PC */
+    for (i = 0; i < 8; i++) {
+        ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
+                              &env->xregs[i]);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.pc), &env->pc);
+    if (ret) {
+        return ret;
+    }
+
+    return 0;
+}
+
 static int kvm_arm_put_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
@@ -2368,7 +2391,11 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
     int ret;
     ARMCPU *cpu = ARM_CPU(cs);
 
-    ret = kvm_arm_put_core_regs(cs, errp);
+    if (MACHINE(qdev_get_machine())->cgs) {
+        ret = kvm_arm_rme_put_core_regs(cs, errp);
+    } else {
+        ret = kvm_arm_put_core_regs(cs, errp);
+    }
     if (ret) {
         return ret;
     }
@@ -2455,6 +2482,23 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
+static int kvm_arm_rme_get_core_regs(CPUState *cs, Error **errp)
+{
+    int i, ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    for (i = 0; i < 8; i++) {
+        ret = kvm_get_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
+                              &env->xregs[i]);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
@@ -2566,7 +2610,11 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     int ret;
     ARMCPU *cpu = ARM_CPU(cs);
 
-    ret = kvm_arm_get_core_regs(cs, errp);
+    if (MACHINE(qdev_get_machine())->cgs) {
+        ret = kvm_arm_rme_get_core_regs(cs, errp);
+    } else {
+        ret = kvm_arm_get_core_regs(cs, errp);
+    }
     if (ret) {
         return ret;
     }
-- 
2.53.0

