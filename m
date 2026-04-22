Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CC73E9F9E
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862958; cv=none; b=iSHAAA3CiDJiJxz1q04Wc9pC/VFCwFsb+mbOp4Ap31SgXzxbGjynVX3Fo/fgZXOmwE4o0vhUHMfeXcachIbG40GyIx52JYY7DRhflq+HjQX74b1Q2q+4FVLFYg9ume68O568EQps4sQGUghtkpJpkST7my40LQZzWgXmUr59D34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862958; c=relaxed/simple;
	bh=72X5t8gqBOH7lR1VhdtCDVZUqxU/OT5J3VUOYEz18xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXrIVb58gnzyooWz2KFEG1ZDTjLyZHK4CPYcpNIt7I4aa9bYKJZBd2laaJF3czMpt6qO9I5mP1jKSqfqMVOG2dodgsRjdkLT6hFq/rffoIh0LIKuy4boOZBPnu9jA25RM3g00OC2EfdDeFRfftZm5VpqwATCYdkpnurP0Np++qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hXpRhpf0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hXpRhpf0"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d03db7f87so3712759f8f.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862956; x=1777467756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/Vl2py7bAr3MMXnnVGwEiFMxjfl+Vi5CKcG3JxQvlI=;
        b=hXpRhpf0UEH5MhQLY+ZIMq5Fp8DupuTpi497FaNR1P14UFsvpCAbGS4HmVR4Me7COx
         lHCBq/xf/z5toYGx2GMrn2eEz5/ZdaJGev7thFPDwuYt3v52TDckdMmOh6sz12AyWQps
         jrEN15ZP7mkt+bS4NFUEHgOZ/vlDzNN2mbrYjExLHBBosZgQqponSmUgwZKf+5lfUrNW
         kX2Cd08PBzAZ46JH6+sn9kBU1t2m2oDUgKzpDdZkd+vDUnPpigSBLZChfmXxVW4XXHuv
         vJyQrgDBLkjtlQ0q1ScWMfoLbDsakWdwrl9+R2GYb1qMv9aBM6FJV/d2m0TkBPb63sHk
         TA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862956; x=1777467756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p/Vl2py7bAr3MMXnnVGwEiFMxjfl+Vi5CKcG3JxQvlI=;
        b=S3I8QJFHb8e8yXQBZgeM8YIg2OwLM/IKmTU0OCajd4dSaZk+qdrugMkS3Mc0b7ECNW
         +osVUaY4OxS0BrTPCBATOmPLH60UcysBzcQIwqF0yBOOSb2JsVP75Mo2zY7I/kTlt2Qx
         Uc7QyBiqZ7fn0QJpak1REMjgPNrtirwyOksuDpunjXSXCG7S6ir2YUyEZR+QWAPmeSo6
         +xMXwpfeteZNjVX3Z4C4jIv43us7rwbkY23FR4akxdTMQvuY6lo7YlEfqer5MOMUU0iE
         /Y2tooiRiZPCaKnP1ntdv9HITLoTE4VYS8wt5g2PyRrthutCLFHAVD6xihGhVoqK6aMm
         vq1w==
X-Forwarded-Encrypted: i=1; AFNElJ9xkO3lenA4dACmBz+ZKfOGHqGATPcGPypG8VUZmDwXAk35/jfL5hmtlIEifjVNsV5vS58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIEN+F4gcs2OOVUCiMGpVrWev/gNvO6W/bhxTyk9emIynFQP+/
	1NIBl1iVvXMY7GrQASXs0JQwqqeKLEmf8LQ+F863UWBmQux08mVq1cuB8cnf9bC4qRU=
X-Gm-Gg: AeBDiet9XKJ18gI2tYNP+0QC0TXIoY4Ln6ygLwxpS2PcoFqc+TEn4aI5T9G64cxBV57
	4KrlFNKGDMy7OUIaNI1wAQMem/7mxY8QWqTkL7dsyQtmkuBq8/nuccVKCss8/U70EDzVWoIy5hX
	z75FmP43bJfgtPXD6sS42vy1V78q6hqW71tY5HpvfRXnsrdnR6ja9ekKI8dz1QwjcAWRKCAkMeh
	p4gn56nYSspYEGkXSTwtsB2ZoxB639utaeHnxLrYeWMlpN2sN5udcOIa4Jg75rASehJTXQjPPjR
	+pVWVXnGyfpmShOx1OjxFJHbn8b8VKCLh9yHS8dfGbRA+a8fYhb///6ChyzL6RnwAa71HFY6Gan
	lLlYHa6kgdb8s7YsVgLjVuWNRKOl6zSeTaozYs9B8bbt3Uvp23NZA1tHfTOkaAU0DfzZNzaJ36i
	4EfJCe5NuZAREsEu9IEz8IAuOZlTrIZkLN4MbnVHHiLR0l
X-Received: by 2002:a05:6000:1a8d:b0:43b:40ef:5d1a with SMTP id ffacd0b85a97d-43fe3db3c24mr34177692f8f.5.1776862955514;
        Wed, 22 Apr 2026 06:02:35 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a174sm50153175f8f.18.2026.04.22.06.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:02:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 4906061668;
	Wed, 22 Apr 2026 13:52:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 28/32] target/arm: hoist event broadcast code into a helper
Date: Wed, 22 Apr 2026 13:52:45 +0100
Message-ID: <20260422125250.1303100-29-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
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

