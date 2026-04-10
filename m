Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EBD37F01C
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850903; cv=none; b=tkhcAvKYgMs9baiICxEYx0iTLebpCBtgYgCsTiLlUydqZ/eODGXY5laCjw7P4ytZNJVzWcIAHQhRb9Hy9d7Vn1Lg/rLDiOzSlaQatnMnquuX6up/K99li2QRizBS4Fn5Rvs/GdOB82tpI08z/yffBY9g6QrBjIE2bGmmdOg2pEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850903; c=relaxed/simple;
	bh=2DEaDPh/o8OYueRwW+6qj5P5XNcpA6k4pSgUkes/5tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqbCfvz1ratyY3d94tDKCCTFf9C6C9mq3nFPV0aolGD7C9QLteQI6yu6DKV/M1D+vTGbeFYeDhiqPVEktd/ElgThPxXd5t8L95fUr3CYW5l2e7nuwDb2Ln3at8oBgEtkCG++t/SeMZQc0kPx7KWvOGkYHCps8MQp0+jU1PVZaZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ldVQbz/+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldVQbz/+"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488971db0fdso23955285e9.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850900; x=1776455700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQoGjEROfb1fZGcAyFP7wGDHaXz8m4JpMOdQttRvXaU=;
        b=ldVQbz/+CtN+yAdfa9OPVYtFAAaDJmJBhVSZ8v7ABNrVKlG2SG9h/MIwO39uaEqxSZ
         oKG9esdG2LqO79VCczJK0JLcjyaiYif3mFuDazYaAt47r0Hm2Py1b1Eca05XWI7iPZ+D
         j1z43E85vCeA2zTMR5oWzxHdqZPEUMmpZG/ngYYTpfMeG7Ira7phcFk9WM3TevdqM1bd
         84J+RjZJBRxhpjZzVb5yQDgXHbdFJl+iavhr/QZq4pBauTIJ8fzS/6rU2bAUN7LYgiNf
         YpIo94JcQ5gPyMUSa33ZUGSBjhetSBJXmXMqNJXAdzUK3ZEPXX2TkHnJNtzZV7aXKp7n
         OurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850900; x=1776455700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WQoGjEROfb1fZGcAyFP7wGDHaXz8m4JpMOdQttRvXaU=;
        b=PLGK8qawhsIaSZOQAwODOVgcIO76cL9LHihDRgFc0JCMvH2b/chakqDiZTUGRICip/
         yHOYyaniZZAasdV+A2wW7n5a74qPsupwHPIh7zf23Y/CxW6kZCJRqQDXsVhDtb5Eg2O0
         wikEcAYyPa3+6ZqbFIaTXoey+2TxhD9tJvjO2zVaVuNaCEqNdqFyai4YRIO8oUsBr+Ty
         8i7fbWaVLm2mbiPNcrnD46h1WNGY5UZz86O225ey/GQk2q/aFea1oPDAo28WpuAsvol9
         LXe3NZ0T8hhlLwf1Smo9/TaHreBTS+CU4M+OKP3AIg30gCRYF8g19b/t3f06KKmzvqZE
         Mk0g==
X-Forwarded-Encrypted: i=1; AJvYcCX8u6catM6W7Aevhsz+58x/5BrISuQhtouHh2kPNwTqC9YgNk+5rd2gRPIHwFVSFFTcpJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YztZx208UL6i39wViBU22RHIIbgoOi8OxFibPsrhFZ/whsq/OPC
	kjsUKcJL7J8Jdo77DjbwJdhH2ZxmrIch90juiLjAayiSok5GKCRsuKAStcMWUHCKSnQ=
X-Gm-Gg: AeBDietySI7bv5JgsyyoGiMnc0skerne0G807Mdwn1PXnPgPQg7WZ0L8VL8AaTnPGNo
	wRpI3rvsHjt2MXnHvmmd0zYTp4RwlMdNQZqgQYux944m8zv2cYONeZKzfd6cgYEXjTtXlPkBmfh
	z5gL8l6I37GkK+d7ex/CRd2iCsicCPtpe+CgpV7HM6MaoZWcs9yZ49K9g/mBLuP++dnvgqxYIjc
	71hnq1ydP7+0N/WDLs7tJqqXmlr7SX+fJUDd6c2RQHhFROqLo0r45+sONBkEVZVvKnUB5dLdFK6
	MJSveXiQAUl7uozwZoShlEIzt5294DYPs6JObcRULhfi85kaFKVrqoWh6GsjbVHg5WnlsygVXyc
	hPXZbSmd6AJEHKRfqjhATmODlxqjz/fcNxj3mlu88rz7uSwe1CPMpNv4z6RTmN00vXeI6o0pZXX
	TJEt3Hc6heGJupC1xfpMuB3380wLwlZI7sX1jmbjRfczdqAOQ96abzuSsJyR3GcxsS/Q/Rmgwx
X-Received: by 2002:a05:600c:c0c8:b0:488:8bdd:cfb9 with SMTP id 5b1f17b1804b1-488d67bbbf8mr42408135e9.1.1775850899858;
        Fri, 10 Apr 2026 12:54:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d592d606sm88600455e9.9.2026.04.10.12.54.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:54:59 -0700 (PDT)
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
Subject: [PATCH v2 13/27] monitor: Remove target_get_monitor_def()
Date: Fri, 10 Apr 2026 21:53:07 +0200
Message-ID: <20260410195323.17937-14-philmd@linaro.org>
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

target_get_monitor_def() is now only a dead stub. Remove as pointless.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp.h          |  2 --
 monitor/hmp.c                  |  7 +++----
 stubs/target-get-monitor-def.c | 29 -----------------------------
 stubs/meson.build              |  1 -
 4 files changed, 3 insertions(+), 36 deletions(-)
 delete mode 100644 stubs/target-get-monitor-def.c

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index cabb2c55f8e..b444095f684 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -23,8 +23,6 @@ struct MonitorDef {
     int64_t (*get_value)(Monitor *mon, const MonitorDef *md, int offset);
 };
 
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
-
 CPUArchState *mon_get_cpu_env(Monitor *mon);
 CPUState *mon_get_cpu(Monitor *mon);
 
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 799855f3f68..3b9e180c1ca 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1632,11 +1632,10 @@ static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
         }
     }
 
-    if (cs->cc->sysemu_ops->monitor_get_register) {
-        ret = cs->cc->sysemu_ops->monitor_get_register(cs, name, &tmp);
-    } else {
-        ret = target_get_monitor_def(cs, name, &tmp);
+    if (!cs->cc->sysemu_ops->monitor_get_register) {
+        return -1;
     }
+    ret = cs->cc->sysemu_ops->monitor_get_register(cs, name, &tmp);
     if (!ret) {
         *pval = target_long_bits() == 32 ? (int32_t)tmp : tmp;
     }
diff --git a/stubs/target-get-monitor-def.c b/stubs/target-get-monitor-def.c
deleted file mode 100644
index 394e0f9a7d2..00000000000
--- a/stubs/target-get-monitor-def.c
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- *  Stub for target_get_monitor_def.
- *
- *  Copyright IBM Corp., 2015
- *
- *  Author: Alexey Kardashevskiy <aik@ozlabs.ru>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License,
- *  or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
-
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
-{
-    return -1;
-}
diff --git a/stubs/meson.build b/stubs/meson.build
index 10eb68ab55e..85f9e3a4f23 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -74,7 +74,6 @@ if have_system
     stub_ss.add(files('igvm.c'))
   endif
   stub_ss.add(files('kvm.c'))
-  stub_ss.add(files('target-get-monitor-def.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
   stub_ss.add(files('monitor-arm-gic.c'))
-- 
2.53.0

