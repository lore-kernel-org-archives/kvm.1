Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D283DCD96
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972437; cv=none; b=IESVD+Fg836H9PpNEcImnirfWMs0RjQ+HDlmq/Pw92Rabn3fxToQ9nvpQfoMW9Yb11pq7AwPp/00ARlBJ7Tm/p2f2foNMrBPzXY7NfyVSHEPLgMOhkCWgixy2gmHDORiSnOoSW/C2gCp5jgykPfsH5tN/tza6NHae1VeUSnka1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972437; c=relaxed/simple;
	bh=+LGc70HNIMnKl5NsVsjb3A70511ElRRSURks1ddpdyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/3TUPPfGe4psffUMSLMQKwTtYnOFIeJVOwgL4lb4ekC4+JBDzpYyruBpAu0uvUCDmfObuch+RCUntu6r2j07qdkfEPcMMj6nVNGzXmlS+wBHkSa2eju5kYVISp0emyOudHdsQnQxxNRXmMKrK7ArxK3jD7HLUDc2vD+POJivWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hxml9w4h; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hxml9w4h"
Received: by mail-pj2-f39.google.com with SMTP id d9443c01a7336-2e2c7eb3b8cso22180755ad.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972436; x=1791577236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pv8AjqpFedPnz/9wNooZL8HFQWI5U3Sd/PQnYUOcCFQ=;
        b=Hxml9w4hgl0p6gJZR+pGm4k8W+EG0w3T4HhuaWl0g2GqfvHPJDAFT0tVzC7VwFvrG/
         8pDd8+dhDY4IsrcfepLGqVH9vsPzZDHS75zMzc1pTSakzT/b3lvS7SFwV3ElUSp4mlsi
         sY1IhX5u483DF6YTfzZax8DqSZdtK5MKJJ7FyU0PEo57cPDYovjofx+zU7CBhqXb3Ona
         XJ13oOTVaGbjqXm2AHmKJy12aSmocxM/GdsTeFvO6yw1USmpSdaOPW3VbAubAluzYJjI
         zmESsyQgKb61yVAyTEgPU1zeLK1OwuxZxtyY/lDcfJysW/lwApbLgfxo7hvNUtwDToJO
         q4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972436; x=1791577236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pv8AjqpFedPnz/9wNooZL8HFQWI5U3Sd/PQnYUOcCFQ=;
        b=kjIOpZ0oQW+Q4Pr2opgm0+LAfca/+RK6t6QEcz2G/R0KtTrtx9phf49xLxzD2t2k4S
         Fdq2xIi8GlXDEbEpbP3zTMlBrqGnQuPKWZK4TrRZw5/oJdGnz7pP9kJCQ5rvE5IBNpj3
         7cVM3wT7c+MHs35VQ09hwpnTEJ7rCnlZXKMmw2w/ayRPP0cRa3aWolLeR30rSFsnSGgw
         xX0f50k/5F2w/sjESCpOAi//6izI/Vl7C3z6MX9MLzAsFBxcGIERs04YuvoQBbyT2QpG
         w5hGqo0FIEowtANuIJ74ZL5G7w27y9yXoExc2G7BAdJ865tsmAbfYZ3dCJF0CDR0RBqG
         1vYg==
X-Forwarded-Encrypted: i=1; AKwUvByseppKUT9Wne/SVbpGohAnFfwJSmY17T6IDKwyOogLmqv4PF13OCh7N/ilM1x9N+WnW7E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgoEx4Ps7VSrO5kXgUlv5gtCOnyto6SwJKOCl7LhPGqdiu2OTU
	AEAG4GwR/PXyLKclFqF+qtk75bOEZ+aJ3+ZO9MbT/Ed4vODl8JDzxZnJTclHPwgqvxE=
X-Gm-Gg: AYBFou1klILROqSkTGuCH2dLNeEVZRjhrIPsK1gOwTT6ziLLP8gVDxOMezwzrQ/RG3m
	C7hGP71L3tgVTOQjAKxI/nHLv6Mj4YLBtvUonEzOfW/96OGK21j/UgrWuObUbZSedDcmnkrE4HM
	CJW+AdRdeaJOHJCGikbh05t1Wf58bMgr1BFlrrzCXY8x8sB1cDpgoM71tSObKGNcOFBk3UX3k/8
	D0mBzBbkDVgK71vXUmTQ5G+YWh0CChZQ9z0jVcdA0ius8ppDZfvHTHfkfPUTh4wz6U6thXqWpQg
	MhUmelltTJ2lpXK3567WsX4Vod25+sm3Xv1Myjqn8j15p7OLz85G3E8vCuoH9EZCqkRuAOBD9oX
	zX0kNj6seKR2sNxRJ0y326SjwjpYRWkW7HVFYd9w61HKs4ze/ed4yU4P1SAFb0AIrUE1RSys473
	hpngv7PVXzPk5f8yypTEeXr8DXTiYyovdaUKTczWK1mSBALyP7JRr8hwaJdb1LiC92GI6Du6vj/
	6BqJjLeKbzPD6/s8CTroOgI
X-Received: by 2002:a17:902:d4c6:b0:2df:5836:d1d0 with SMTP id d9443c01a7336-2e49b6add0cmr30968845ad.30.1790972435635;
        Fri, 02 Oct 2026 13:20:35 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:35 -0700 (PDT)
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
Subject: [RFC v5 04/22] target/arm/kvm: Split kvm_arch_get/put_registers
Date: Fri,  2 Oct 2026 14:20:08 -0600
Message-ID: <20261002202026.1204110-5-mathieu.poirier@linaro.org>
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

For a Realm, KVM is much more restrictive on the registers a VMM can
initialize.  To prepare for Realm VM initialization, split the get/put
register functions for a non-secure VM in their own function.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8b6f602ebe77..60272b8c040d 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2212,7 +2212,7 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+static int kvm_arm_put_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     uint32_t fpr;
@@ -2315,6 +2315,19 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
         return ret;
     }
 
+    return 0;
+}
+
+int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+{
+    int ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    ret = kvm_arm_put_core_regs(cs, errp);
+    if (ret) {
+        return ret;
+    }
+
     write_cpustate_to_list(cpu, true);
 
     if (!write_list_to_kvmstate(cpu, level)) {
@@ -2397,7 +2410,7 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs, Error **errp)
+static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     unsigned int el;
@@ -2500,6 +2513,19 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     }
     vfp_set_fpcr(env, fpr);
 
+    return 0;
+}
+
+int kvm_arch_get_registers(CPUState *cs, Error **errp)
+{
+    int ret;
+    ARMCPU *cpu = ARM_CPU(cs);
+
+    ret = kvm_arm_get_core_regs(cs, errp);
+    if (ret) {
+        return ret;
+    }
+
     ret = kvm_get_vcpu_events(cpu);
     if (ret) {
         return ret;
-- 
2.43.0

