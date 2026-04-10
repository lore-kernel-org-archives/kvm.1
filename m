Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5020237F8AB
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850852; cv=none; b=IyAVNpkvdyhluxSbs2c4v+8du4k49k/j+WK7rLS4b6pwqiLylvXos2c7zCHSgRn/M2aX9jhprgsugzTyKt9+o+XA9z3RxYBo7zoL7mME1WE0r+qIx/kzDA943vTIGE7c+bX+BHqlHIl5M5n1ATSxAwKFk870RdQq0EIUEayUhrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850852; c=relaxed/simple;
	bh=HAxn6eQ0dnLHFSpCYOCb8hzzro1Pd1U2eycH08Fv9dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RV5YI9xBQC0KHfv8Dm1k1Mp46vcFpYKa1UwYyluIEAwCTI1cAsNw1xweZF6D2pQv3RnQhJ/vZQiYB4gymUuBusSlvRGZ6zeayfAwZ9C2DWl+Az8gV48xlEBM89uPp59BU6CoveW3pNueQdaUQjzi069/dW+ALabhTtYTTI7NNXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o6ea3eXE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o6ea3eXE"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cf8fe9c2aso1606241f8f.2
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850850; x=1776455650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eA3XKlB2Issg1dkYmP2jSa4cjzBFSxxUi2nhDXWoMo=;
        b=o6ea3eXEu9T6kQO6SBfMd1brSshMUzwjuyj+MReKXY5IyIGApHYm/kB2OrJUdFNWUd
         Utl4zcPKyNAy4TAP63vPsRjK2kweMrggSbJAXrcfBSmBqSJVw4hu/HRMZw8TQUl+SbcH
         vxPH7y1mDvcavv1xInHMJMnO2W9JcO/rqw5QbTCdeZpcnI6Lx9F9/zjWt27dXYwn+cJC
         Rd7TIEMgKlBRNnA9Xufc2++IfJiWBjNW4RfK+jGKpy16OnsmnAVdFNKnppQBsOwkOw0M
         7S2G/R893cNExnmi6WUC3R8Yxds6yL2n0FGOjetOWS2kYht/OE9w03brjetGsbDnmIyN
         04ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850850; x=1776455650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1eA3XKlB2Issg1dkYmP2jSa4cjzBFSxxUi2nhDXWoMo=;
        b=YkXtjF6lXLqQQ/ZKTllwvrxHNq5KNWfglXVGgW5Kc8p22ovufwW/rXqQAlntCQQP8y
         bEDChu3S1j1R9pleXVx0xxkjg1xVZ+AUbkRbkhWWdxrfxBoD4G+zIhYj3YHBmvbhMzRa
         vSBiJaoM1VCb3VAzghLbk3ITfFL61B4VpgQWKyqAyiB4nAYa6fnJ8YB3linOO1XYpufB
         JNe/PmH6mUFVwcMHRBHTXVoYGDZW8F8FgjaMiSNl3VzpWjRnxQjkCZ+SHsFCssKYP4H0
         eX/P/sHZqW/0iapk43UW5VwK7NxydETmc5HBp7AWQDqFzACnz+DhvO8CejQ8HJUZfygt
         khXA==
X-Forwarded-Encrypted: i=1; AJvYcCVl3l7rwLuiaHJhzxgGEE6DeU5B9kaO7TkC0plHd/c9bmohJmsIywJtAUQLc1rI8N829cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvCmKQvN6s4+HvCenqdjsTPzrAgF5zFogBk+X97VgYrt4AMpqt
	hvKEFfYczJl9jIVIS13bu5BRFdjX/47mjFIVf1cZ9ANCq4ft9JH5nGTADiRNkEfr7us=
X-Gm-Gg: AeBDievia1Nl9eXM8H2DzWHCWDIah3l6yF9fcbilK3EoAXE43s85jrniNf1xEIOhNwz
	aBZ+ru6YRxnowAa2YOLHPAEczKtyYyPNhZRMSjT0T3H8iTPMA4zABONmCYuk1nfkAtI8MvHgvIh
	iyVxyjrzUm60BHuIUGiBK0eCne2zjput+764OhYkfwb5/2d2/cpvYJp1gEzdXMRXhJ0arV85tz/
	vrbZ/8c4n7UIEcI1nZHlrshT7cDJPbtAtdxfFlUjYVotXbrgdfT5Dk7Y9BNJvuVtSM/lBM5odjQ
	igle9mWY/vhWURf8ett8K846jriI/vXnp8US5OaH3FZUa9ZZavyZ9iQA6NdyvENhnvt0tAE2/Ck
	omZPziezbLzNlUGxnPwuPbtmpEMM0P8daUi+lhwsyIMgm1k3HvTLglH/yaBmHOwqPttm7x2MnmA
	l9pGSSdFhbX5A7Rp74OtUy+lwjoLsTCjHYN1G6XOA9vJRKNyjQkJ2V+ah4MKyNM9cA2AsbYtjq
X-Received: by 2002:a05:6000:220b:b0:43c:fdd:ea96 with SMTP id ffacd0b85a97d-43d642b6e75mr6383617f8f.26.1775850849621;
        Fri, 10 Apr 2026 12:54:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec28asm10125307f8f.15.2026.04.10.12.54.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:54:09 -0700 (PDT)
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
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/27] cpus: Introduce SysemuCPUOps::monitor_defs hook
Date: Fri, 10 Apr 2026 21:53:00 +0200
Message-ID: <20260410195323.17937-7-philmd@linaro.org>
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

Allow targets to register their legacy target_monitor_defs()
in SysemuCPUOps; check it first in get_monitor_def() otherwise
fall back to previous per-target helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h | 5 +++++
 monitor/hmp.c                    | 9 +++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 7b2d2d2610f..a96f4907d05 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -85,6 +85,11 @@ typedef struct SysemuCPUOps {
      */
     bool (*internal_is_big_endian)(CPUState *cpu);
 
+    /**
+     * @monitor_defs: Array of MonitorDef entries. This field is legacy,
+     *                use @gdb_core_xml_file to dump registers instead.
+     */
+    const MonitorDef *monitor_defs;
     /**
      * @legacy_vmsd: Legacy state for migration.
      *               Do not use in new targets, use #DeviceClass::vmsd instead.
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 983048db1b9..6cf2f3e65ff 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include <dirent.h>
 #include "hw/core/qdev.h"
+#include "hw/core/sysemu-cpu-ops.h"
 #include "monitor-internal.h"
 #include "monitor/hmp.h"
 #include "qobject/qdict.h"
@@ -1603,13 +1604,17 @@ void monitor_register_hmp_info_hrt(const char *name,
  */
 static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
 {
-    const MonitorDef *md = target_monitor_defs();
     CPUState *cs = mon_get_cpu(mon);
+    const MonitorDef *md;
     void *ptr;
     uint64_t tmp = 0;
     int ret;
 
-    if (cs == NULL || md == NULL) {
+    if (cs == NULL) {
+        return -1;
+    }
+    md = cs->cc->sysemu_ops->monitor_defs ?: target_monitor_defs();
+    if (md == NULL) {
         return -1;
     }
 
-- 
2.53.0

