Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DC03D8121
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464202; cv=none; b=dJQcunMwU+Le+vCgX1dfxFF5gWGpJs8k7/Oo5tvV9BjwrC+JMVM7/l6VKIJqUtRN3REiFqEUcorH+xw52jhmo+zfnG9GqD9XkIKso6UggqEdxaoCbHCxnYsIcyRVciap0akTy3nlbwqB6Njm7FQtuq+BwlvS/T2GUzWPtiJf7Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464202; c=relaxed/simple;
	bh=UyGC8Lw1NPbkfJ9pvCJmyGXwrfp0XNX8syQx79Xqhno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/rS4v4uBB2d+7dBjzej2Z7hRzWP43pAqt0P+uJ2sLunSS6CHW7cidWNkK/YeSBbra6m1YebzzIMsw9on1Hq4xVjKvrmOneDUS64hTCgzOth0juX6rRJXWsc7vlAvRyTBzbvkEuZQig+mkZ490rtYU8VOgsPhp2W7//zqNB/tkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zj86JWVw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zj86JWVw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cace7da66eso1001755ad.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464200; x=1784069000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LPqEyUzT++gNY9WDAWkbqlVC0xxiLcUKrinmqOFE5ZQ=;
        b=Zj86JWVwVSkPE4XaK2eft+x8hunXzIQYsaHQj1GEFEdFy7GlYM7ay+OMwdHzCPifhh
         WEUaJ40lSCy8xTgzHQgLKwFcGGw2uv0DTN1KdfnGys6VtgruyYldmuiwuD3/DcIlWKQj
         TRgK6oQLUefq4c7cDjMK9EtADim+zfXJ8vOmYgjXcG/pP+ciAp4NxJpOsF/s9ogYrB+s
         mxGgWCYacnoptlVMV57DXNYeWvKtePjA3BvznUGsq0Dlte1PetwIYJz0PWxpPFM6xqAQ
         8IytgC86mWxtgA4J3b6bRkIQHdNZzSuFyOQWLcB8rmuJqwnNQqAUQxAOSBU+Npl4e30L
         /FjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464200; x=1784069000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LPqEyUzT++gNY9WDAWkbqlVC0xxiLcUKrinmqOFE5ZQ=;
        b=oiFni5v13QE4oi0K9hEFGs6zh5BxC+WnJdl2g3y5cDrnm+oM0sgc0OG3LTa6qtbbyK
         PI3SV7idugaR46IUOudjFkyFv5BjnoSeuJOnEJWBloJ/eIIQZcAGjFqAbWizbH4XKEYG
         JVZeTXQv359UkC/2Nxk5qkT1tzYdCICrNa2bO8tg9heddNYsQXmLIPT/OSxYffohxN8R
         43Y3n97z0P8YX+rOE1FSx6/l5+S1buWD4Dy1qWBaPgdzWzk3gOTjQzqDaFAflJe1Ida5
         6Q1EzsJlfKHNnYfz2EpKHFfWOAXB00zI0l9zG6grkHkxMoS/vHVYW2A3WqvcI15q6yHk
         mQew==
X-Forwarded-Encrypted: i=1; AHgh+RqCZPTSvaovjXhNa+Ps+ACHdbSikVFKfhggTvksSZ+lchvVGBoEmoymQkM/p4BKnQ5KDHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVpkf3oKd4n3oL7DJwvGrH7zdAq3J8l+nIGMhop4d4Kful0Bmg
	qPGzW4ITDE/s8jInAZB7NVOZ8f2imC4yGtpQ8cLvYMNeminVC3UrFIdexMqqbvVaiPg=
X-Gm-Gg: AfdE7ck9Kf6SkDEJrTrBVUcF0DmexbCeoYpjv9PPTgBgGxiiMpMHnhHUiAQqUcyFUjo
	yY4Q93NoG4p/Q2jCMTIVE3GeYeyE9kXW0TdHHzMmgdXpK7D+W2dTOpbjtZDaLYjwVIWsB7SRy1v
	Vci4mkZTqlE9bIPERdm66MJsdi+W0Rnx2mYUsnBR2KQf9561O0pP25O/4V1QUguLKlDw5Z+Dmhy
	y+oiR71CzGmDbFK9jvLnnMOzwFWZmAU/ESoLp2IF9zpLpTPhKUKpSOw1YUpuGxILEmM7hMoigcY
	cb9AyekMC6fq7Sx5d5ZnEifBiptYWpwzJSLT5pKVII1XCcdcXku0YQnSND3XioJqH4HCYasMDtl
	q1pXKbTSbIOR9fAgF1aOi5QhsdMMPeDKHYo0qG/VcFPju5qpYpP9dFPb1x8HxJCYCux6dtD94zm
	m2oar5Q/Yb0LfWWGyY+WCKUAu7WIolWKxJfhgVgvU=
X-Received: by 2002:a17:902:d4c7:b0:2ca:ce91:f027 with SMTP id d9443c01a7336-2ccbf08784fmr61937065ad.36.1783464200536;
        Tue, 07 Jul 2026 15:43:20 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:20 -0700 (PDT)
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
Subject: [RFC v1 05/25] target/arm/kvm: Split kvm_arch_get/put_registers
Date: Tue,  7 Jul 2026 16:42:46 -0600
Message-ID: <20260707224306.1202330-6-mathieu.poirier@linaro.org>
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

For a Realm, KVM is much more restrictive on the registers a VMM can
initialize.  To prepare for Realm VM initialization, split the get/put
register functions for a non-secure VM in their own function.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 28d5643d6779..b609f29c11c6 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2163,7 +2163,7 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+static int kvm_arm_put_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     uint32_t fpr;
@@ -2266,6 +2266,19 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
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
@@ -2348,7 +2361,7 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs, Error **errp)
+static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     unsigned int el;
@@ -2451,6 +2464,19 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
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

