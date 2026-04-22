Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B9A3C278A
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853054; cv=none; b=knha/ZrseZ5pXFDbdWFZTp9p7xcRA3BFNartgC367t/Cjph3ImBBZw8JPIPg60giixY+ts/gmmY7CDgIrQQ2MM8bTfyOYsEfbzcnR2seRJvN9KnaiZotE8clN6r+a43WjXAIOrxBUKbN3GftcYd1BMGq5tTRKlTSAWPSvakXvpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853054; c=relaxed/simple;
	bh=72X5t8gqBOH7lR1VhdtCDVZUqxU/OT5J3VUOYEz18xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMn9n5aj67hcKO4X7On6LsSEpGt65Pgz4NvcKA/10w4I4/0d8RKUJqemBgXc/TOK6OSti674G7bCxKxeqS0GTNk6L07ljAiVCfiPeWG6rzVdjPEPVPajsSlz48llotnhQR1gLh9wVmxgfM+rP5OSdeydcIN0R0ZjNIrmSlzARzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rmSDXW5Z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rmSDXW5Z"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so65974255e9.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776853052; x=1777457852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/Vl2py7bAr3MMXnnVGwEiFMxjfl+Vi5CKcG3JxQvlI=;
        b=rmSDXW5Z33VBFa7xbUjTDrE9/4gRCc/EDWfvP3BFHsyuq6HvQu519ychZYtFm9VHCp
         QQaLJpJI45s0Xv9CmvFFsD8pPGUDjzMseIycMSsWBVhDTjuxCw+eQojtZk20k6XjeC6V
         7LRTyCcIsj3WN7YWocfvOBxzDULc0LTTjqZYvKok6yBJbotXNbVZnELLxzu7bWagz1n8
         FOM82oe+pBKSXVv6RlEpaRPKCJXtFJUkPe88PlY/gXQ7lSqaRMacE+SOcqqoqOmi7n2+
         f8EUJsAIuKv4SkIRu340P7L7duAvn4lXoDId5jKsU6j6Hvy5qRMM5MhG1JZX9kJCiiIV
         akTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776853052; x=1777457852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p/Vl2py7bAr3MMXnnVGwEiFMxjfl+Vi5CKcG3JxQvlI=;
        b=qHYfsDTGCMZiVqLdNW3eF+fGVmTsfbaQLEky726YgevW91rv6rQcfJoTnZ52MNRE0X
         CYDz3X/icllkJPDwrbs8DyhM4wF5NGj1UpxdceFmCxJwoOzYbz5XhmYXdPqqxCH4mLD/
         qEWv7VaG23zpfEO2E6veV+dUufDe3l/Gv79vhrZGFWBGjHCZzQuqaWERevQalwVM/0nB
         sLaNbov6XE3Ec3h9ycNtrpm/cmvUbGlTPCYE64dnKwJpDeQ5ZXBVjp1eBzu/NgqI02kM
         f8ZCBiwHGode/5Qjnc+CdyeSsZzEq+6RoPetAnpxc8X5eqiqwafpiJbSspccmMRhAN3L
         vnTg==
X-Forwarded-Encrypted: i=1; AFNElJ+RMlRVm9RtRG0aXM6G5vrwGPmpPLW1OCGJY6ucAetZce7lZR9cwmX9NQLNUJpRIV01lGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWXduYdDFBoa0sawOZHBe+Yqab+Q8nDkbsNJuDfQvWEGIjskxl
	/ektRQnGijJgiaLNr+Mb9zn4zyFklKdHn8WgAoFhQAZVzKztt4cFGiaxhM1C77+wwNM=
X-Gm-Gg: AeBDieusB1cfMIMzMAXn1hZobNBI7PrcZXL2L3WnwTp+Xtcr6rn7XP8BjkjBxYWyjRS
	3z2DqJCFDSj6XYDFFjgkAuPg7Dd3FPdJ2AF8T5Lkiv68UcUBibQJIJlQ/Bn/dt3SWD+z6CTa6Xz
	3t/gyfK86cc2vfRy2M+kZKkc9P7T3/4Z3dAI9fF9KbyPrjH2K9RBDf6CsbZsnvMlVIxe9iimbJl
	Z23+OWsiaMrlWyRKDrW2loJTLBOMDc5PvMbFmWp7FL7wfDgk9xDvBfgr/Hvz8YpWm8NZFaFfDfX
	xGqFqZFcwbuwwiPHOGWDbPkO4NCJX3wipdD+Djvs+j5zM2LOGGzl8QT6FP55k3pV5dwlqdMCBij
	yHc5kDwusuovFvk9JfvOsGwZN72dIan9nar11YVbFZHaByq+zZ3mVDxFsJOl1Yq4tszw+y2gJha
	s1wq6xZimbnfxvWI06LrO9/1nejpdGQToFkhAIEBZzQoGd
X-Received: by 2002:a05:600c:1e09:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48a592ce7c2mr51094795e9.17.1776853051719;
        Wed, 22 Apr 2026 03:17:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55b8baaesm181142385e9.10.2026.04.22.03.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:17:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id B68F65F941;
	Wed, 22 Apr 2026 11:10:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
	qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 28/31] target/arm: hoist event broadcast code into a helper
Date: Wed, 22 Apr 2026 11:10:39 +0100
Message-ID: <20260422101043.1234229-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We will shortly call it from more places.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/internals.h     | 19 +++++++++++++++++++
 target/arm/tcg/op_helper.c |  9 +--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index dc593f1fec8..089f679ac0a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -682,6 +682,25 @@ bool arm_is_psci_call(ARMCPU *cpu, int excp_type);
 /* Actually handle a PSCI call */
 void arm_handle_psci_call(ARMCPU *cpu);
 
+/**
+ * arm_broadcast_event: set the event_register for all PEs
+ *
+ * This kicks all PEs which will up which are waiting on the event
+ * register.
+ */
+static inline void arm_broadcast_event(void)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        ARMCPU *target_cpu = ARM_CPU(cs);
+        target_cpu->env.event_register = true;
+        if (!qemu_cpu_is_self(cs)) {
+            qemu_cpu_kick(cs);
+        }
+    }
+}
+
 /**
  * arm_clear_exclusive: clear the exclusive monitor
  * @env: CPU env
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 655e3f96e78..6a2be85fcaa 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -474,14 +474,7 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
 
 void HELPER(sev)(CPUARMState *env)
 {
-    CPUState *cs = env_cpu(env);
-    CPU_FOREACH(cs) {
-        ARMCPU *target_cpu = ARM_CPU(cs);
-        target_cpu->env.event_register = true;
-        if (!qemu_cpu_is_self(cs)) {
-            qemu_cpu_kick(cs);
-        }
-    }
+    arm_broadcast_event();
 }
 
 void HELPER(wfe)(CPUARMState *env)
-- 
2.47.3

