Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22112F90C9
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850881; cv=none; b=N4yOZeEgyQupu6HC4U69ptAghqm+80T40z5b2QVqOZaq30Ix5iqotRQlBbZbd5+vcH+dZcheMOBj9JSoxcGdP7A/q9aCvgeeeQVYssTDI+CTSUqV9OfTU9SkOT9uijYsJ+PW5cJyhquiRV1V7T3rjlxntl6w4DZmXX2aU+dckSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850881; c=relaxed/simple;
	bh=af1i0ZE/SSVc0UmKuBUrUVHb3clB/WneNIc7T2Ngm6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLboeSx3BGsLAFkuVplvghOGHFzwQsxW0Hy6dH9a3M+sOCRMuVj2O6BFS9zNR3V8JImLCejGcjZOADbRIhx6Su4Xuyf+XhMMIeEAdrZE3o5RuLDbJhP7KCi6V3XiSfrNy/QH8+supbIepmwWO7TcE0lZU/77yW0FXOUz7v09oJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zn6XpGJA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zn6XpGJA"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cfb723698so1829731f8f.3
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850878; x=1776455678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZ5l/yASQ24ZYUVrEW0W1fOfIxn1pYjbKa7VNjc5dpE=;
        b=zn6XpGJAk54T4Vwu7k3r2oICjvSHKTBvs4ui4qeR7x/RDlmghIB5DgD//wnrlGI+Ki
         rIz02hwedn0c+mgeCMvwpuit+rsLKQ40ctXeJNqG8sIKWZtYiL3VCor3hkkwjuICJkTN
         mqUMzeqABTESnrdR50JAucRr2GXEnhwcIbHr7ZcCkbB2g1gROOmg0/CtjGFKzrWqZjAr
         AP5ydZjEz5xCSjqGB6mQ4dRvZKgO9dDeF1VAEG1ymIlobHiO9yIis1GqLZSRWBSQwZyZ
         dfLkX8uWW9mS8EPcC9cIXOBTvH3zV835XFK638lN1Uv1tWn7pQdmW3UX9SdLi+trOkwU
         DkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850878; x=1776455678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZ5l/yASQ24ZYUVrEW0W1fOfIxn1pYjbKa7VNjc5dpE=;
        b=Zl3Vj38+n2ksfTz/UbP2Uzwswg3ySgKgSF3R3uI77k4kCGsxdlJnq0/95/Hi2R/XGi
         HaeXw5lF0zR/Am4wr5cZ8TTEqWoFZHSUBHbx8kUmO2KBz99bbB1M8Wc6xizTOdJgGhvs
         9Omo4y3kFnKaXzG42ahpxSu7CuBHvF1OVa8SL11XGfZhpc7TeVP6zOC3ax5eEJrboN5z
         FyaFnokWiq0yLsuT8mK7hdEq8DWBAe2Uvkj3uzig6Shr8V5F1zrl4rnqaekp0m/L9vU7
         A2T7A8mpdLlohD4NcBONWSZhsZbXtmfMXOCrH2oACY6eQrttMQuc6Da2ACZ+K7qj4eIo
         R6OA==
X-Forwarded-Encrypted: i=1; AJvYcCXGw8wxc3GgEuiqFDGPWcWISd9dXMKhLBC7+xaJXwLtpLD0RLwqF9Xhe3SV5LHVn71SrZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoexgZaqrlLKbnuuvRbkNw8yF9ti0YoqnJz/zWTPQXrfQMc2wA
	Jhusk36K3cR/pdP2+Vy+0EU90HzAaC90vEXRc4aeAUbiaSC3GEJCbDZIxAKDim7Kem0=
X-Gm-Gg: AeBDietLaWxIMoRD9AoYzDeOxY32CdkfQG3WdaIr7QNzyLBIALu3TEhQYt4Z/rUPeQe
	5OL8qjB3B69kIltb/TU2n4Q/IaXcAtB1dB/Et4BIzTj8YC18Cyt3iBpJihf8kvyrjERfu0ORbvh
	Fw4yyVy4f3W9EeFj8kMUvpdlUhmKD28C6HTEcMYOP/gWtHM/kUr7PEi1zG2dJ9cmcNkgkOzeEvv
	o5LdcJa5Szb58cVTMA9Wzbb/q5LKoBF+9jgYVihdpz6oZG8Dwv5G9Kll+myr/dx/aPWk3H4w1UI
	iimDKTFP6NIrZszdIl7yu74ro/Ff+Y17RA2Z9vLsbaJoNSYukIKyPYLa9APYnhqu6XjTeDt7D4S
	fsBYBQj0MBbE/DDzS9V5rehY6HYFj/PothHI6pl3B2V4P9l/dIaQy1aC6xlqfDKsmS0l0Az8Dey
	wV0sjY6Dz+HYy3c8nHorrsKTU9C7IOs37cHP16FwvK4wJ13/P8k7iba6WA+GlB5hyuAk4MVZGn
X-Received: by 2002:a5d:64c7:0:b0:43d:500a:1e5b with SMTP id ffacd0b85a97d-43d642da9e2mr7199206f8f.27.1775850878373;
        Fri, 10 Apr 2026 12:54:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a48sm10271471f8f.7.2026.04.10.12.54.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:54:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-riscv@nongnu.org,
	Markus Armbruster <armbru@redhat.com>,
	qemu-s390x@nongnu.org,
	kvm@vger.kernel.org,
	qemu-ppc@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 10/27] monitor: Remove target_monitor_defs()
Date: Fri, 10 Apr 2026 21:53:04 +0200
Message-ID: <20260410195323.17937-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

target_monitor_defs() is now only a dead stub. Remove as pointless.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp.h       | 1 -
 monitor/hmp.c               | 2 +-
 stubs/target-monitor-defs.c | 7 -------
 stubs/meson.build           | 1 -
 4 files changed, 1 insertion(+), 10 deletions(-)
 delete mode 100644 stubs/target-monitor-defs.c

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 516089eb5c6..cabb2c55f8e 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -23,7 +23,6 @@ struct MonitorDef {
     int64_t (*get_value)(Monitor *mon, const MonitorDef *md, int offset);
 };
 
-const MonitorDef *target_monitor_defs(void);
 int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
 
 CPUArchState *mon_get_cpu_env(Monitor *mon);
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 6cf2f3e65ff..3d812ea3068 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1613,7 +1613,7 @@ static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
     if (cs == NULL) {
         return -1;
     }
-    md = cs->cc->sysemu_ops->monitor_defs ?: target_monitor_defs();
+    md = cs->cc->sysemu_ops->monitor_defs;
     if (md == NULL) {
         return -1;
     }
diff --git a/stubs/target-monitor-defs.c b/stubs/target-monitor-defs.c
deleted file mode 100644
index 0dd4cdb34f6..00000000000
--- a/stubs/target-monitor-defs.c
+++ /dev/null
@@ -1,7 +0,0 @@
-#include "qemu/osdep.h"
-#include "monitor/hmp.h"
-
-const MonitorDef *target_monitor_defs(void)
-{
-    return NULL;
-}
diff --git a/stubs/meson.build b/stubs/meson.build
index 7189ff63ed5..10eb68ab55e 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -75,7 +75,6 @@ if have_system
   endif
   stub_ss.add(files('kvm.c'))
   stub_ss.add(files('target-get-monitor-def.c'))
-  stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
   stub_ss.add(files('monitor-arm-gic.c'))
-- 
2.53.0

