Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DC37F33F
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695276; cv=none; b=gb72WvnyuhqxiqEDxWrU7y+2jHURlYks9bBZWzyPHqKCy5GYCKie6B5IxKq3T78wgRXrWfHqanIOcsR9pMWrAjsJv6/3tytih1J78LQOkGo27tvZG+NWWhqqN3acEbt1TB56CPXTq7uAM7O2t0AkyBbHTkd8OeK7hVaR3XMbyq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695276; c=relaxed/simple;
	bh=BG8lFbSTOlnJqSMhZepluhqqcfc4/OMcyCqU4JTIRVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QuKEWHPPOLHw5xHmPXQ5Iyo9Q1Zkm3xpwQqVYetdezKcPcSBPx81ym8hSmkvwGDtmJ2jgoazj+zmVJnX6qk9bk9hvno+DBoRA0LoaVUGgX45mMdSJLOxS4IuT0qyxpP2jF+B0PGnVpegzFFQxtKhooJTcoPxFKCHuMCrUeDkxJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GV/ujMdY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GV/ujMdY"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d560775ca2so3414095ad.1
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695274; x=1788300074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=flXrUG20aPexgqGmyi5LqrRx9IuZht6hYiik7BZP4Bg=;
        b=GV/ujMdY/VfpAb7APkOUP3lhR1JiC4X6G7InQbTA7xoYKxzLhb1amKuovgx8Zgc3NC
         aeO/X9kwnyH+CETnZ+KSgQd+qqLD6omFAxDwnBjvF08UlWg+9rHLlhe63n+p9ZzZ8ltP
         gk8sv0L9RSPlju+kY9+EPFKdUpzJRWfcVDD9ByRuElBxTCgos5ARFnRW83Yegd4qCkG5
         ap3C+qsbi8lHLa0ZzWksXVyo+kRvZzx/j12fX09hPOxmPFnS8RGlb1yaGSNy4Q51TEMC
         PONp2kDuhkvvPAi8txW09Omq7mKZ+YErxXw4rMlJQeaC8c/63QlUdAXsGbw58njGqyhN
         s2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695274; x=1788300074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=flXrUG20aPexgqGmyi5LqrRx9IuZht6hYiik7BZP4Bg=;
        b=oP7hpZ3WI7cqam/XBnYd175bxGC7hMgVr/OBDQrAOfiA6LXx7ZEyq+90YCF2cgFyh1
         ENR/vhTFMtwDzZLo+0JSE274LT29zawAeqCxqm1sJ7ekkoQWalr3oOSgi5QLyRAmO9Wm
         +0j89FmSlHHe+oXS22lcD2RMsbqKYCFLiYM9sWg34zPJqyovXG67gVBtn0h/kWaNKMF+
         SHSSwjrvm+FaspuuBAkQNfOQiyzKQnI9C2Z5CPbtnP4NrmLTuNtJCGaNrdcb+m3UBMAP
         63ESNzD6XeRMMja/zb+v4+5lw5Ajj8L/zKPwE1x+HHyJCRUOj0ErO2NaPEbrydlPM1xU
         qADw==
X-Forwarded-Encrypted: i=1; AHgh+RqEUlFgQYIbARSyzG9/0Nx51ykemHEvr7EB/GgFLBPEtZ43SrE3/vtkIHtPsZkmivIyLR8=@vger.kernel.org
X-Gm-Message-State: AFuF++l2n+uOFmqRZrtS/a5fkDaALI7jIoqNiZMb5TKsUO9ftkfMGIaI
	OEaeamYkGojwQjpa5h/Cp2JVkQwS79w8cx8lGwfq8MN3KDWsqdIhs6D3OwEQYA1iGL8=
X-Gm-Gg: AR+sD13scVR+viXZc0niOMlWrHBUGJtO5jCdeCzOITe0vTYmwXO2rNHb8B36Cx1JO7J
	2f20uWr98cxsdD4D8fQtJ/PCFYNYlYW8JLB9awlhLqBuzJTq0LwHaU5U6Gj4+ODiXEhYL0sjZmH
	nzf8mcP0+Jv75UHxXU+vi+3s6BIqIdRy0mO9g9eR39anDwPgZWb7ETAiSuUWlgJ/5GeuucL0IVv
	5y90Yzz33nJ5PI8Lh/Yix4zzaoDphy1loUFWjgtBURsveE2iDH9wl6JHInJNn4ED/a9+ydvSuCV
	l4+52u5hbcS3+HxqaQ2d9PXOMIF2xQ8qPhq+njeyKced37f6+cNmv+IdhCIxU3A+eTKvUfJvC4K
	DLFhiICT0IDZ8N37a/53NYsDYayAwdm9T0fUt75U2Mur/w957pJP2N14SBGhBoi81geWcorsj7L
	L8XvWa02R80+mpybJv061ze41SW4SBQbrw6AXJvwi2Zsm24xmyeeRU6ZnIdEuaJhSGZDUZRj0Cu
	gyRLafg2m9zH/bJVSJ4BGE1NQ==
X-Received: by 2002:a17:90b:2f8d:b0:396:4dfb:5890 with SMTP id 98e67ed59e1d1-3966d144197mr4659218a91.2.1787695274276;
        Tue, 25 Aug 2026 15:01:14 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:13 -0700 (PDT)
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
Subject: [RFC v3 05/24] target/arm/kvm: Split kvm_arch_get/put_registers
Date: Tue, 25 Aug 2026 16:00:42 -0600
Message-ID: <20260825220101.3443954-6-mathieu.poirier@linaro.org>
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

For a Realm, KVM is much more restrictive on the registers a VMM can
initialize.  To prepare for Realm VM initialization, split the get/put
register functions for a non-secure VM in their own function.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 0c853d17413e..33ac9528c45f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2166,7 +2166,7 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
+static int kvm_arm_put_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     uint32_t fpr;
@@ -2269,6 +2269,19 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
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
@@ -2351,7 +2364,7 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
     return 0;
 }
 
-int kvm_arch_get_registers(CPUState *cs, Error **errp)
+static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
 {
     uint64_t val;
     unsigned int el;
@@ -2454,6 +2467,19 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
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

