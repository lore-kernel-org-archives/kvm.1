Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99D361672
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850931; cv=none; b=bKdBtXJYphx3nofkPbACSKN3TKdbDn7kLbKHzdM1jl1Y70wow6PyUUSmH3IWHNGPVAa0QIZxhag1Hsi6r1Krjqzcu++GIKoSjra/OA4hKU7q8X/vJAr73gCR3agHQmgR7VWut0e6O8IyjFO/dc7YHWY30XdABB1DlYYff6fE59c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850931; c=relaxed/simple;
	bh=lU1pkk6lJH1sI8Y/p85F+OQ1JwUDr+AhLiCUK408Vp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieR0VW97+fpn9e6/tmkhu1EHJOinT2ALY/CWxztzOvv++k7VKtbgki2PBikkPJobqBzPsTt881a9BIQcSm7IfX99k/6rRsFzqjt9e+poY7vPELWN0IiVFQqO/mPHgMQCDoBL9UixrsRiIRCtUUMvuEbNbqZXlPOvmLVA0hpWNt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X9dyBzHj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9dyBzHj"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso38628215e9.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850928; x=1776455728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCjDcmgJjEnwXjW08r4omEzNwMlkd/NuRbLQA1eGzug=;
        b=X9dyBzHjEOjD6cBltUn9GD0QoNbHuVIPVWJ+UQlB3so6ZAbmX2rcThx0vj4qjZj4wJ
         MdWADrN5qhyB1vzY1HDKoSb7lKm0D2tgu61xCmgU0C3aMnWfB475QpGqcHh2ZnIrRypI
         UOiNc9u51eGHWqxYjIz1Xdk/oFd2RJfKlEYh7Dlbbejs4j8grzsvNnj4ktrQKAz21+wV
         L+hPn7YryEOVHNld4JsadY5Jr730kRFLeUuv5MGEMoWNLnmUOgxG8Z7if5nSYGXeZnwc
         PihjQV8gOWfLjjvxNT/vRMorSWeuTkjGjsHz2SCX6E0PMhw4Mk3pW/oUZW7rLtGw3Duy
         gswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850928; x=1776455728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TCjDcmgJjEnwXjW08r4omEzNwMlkd/NuRbLQA1eGzug=;
        b=LHxEtU2Eyf/dg3zpbgzN3w3lJaO25P6QCiAo0dcENvRXGLWARZMGFHjsoBiwEesQRo
         xMMS1xRNPYurPIw6FzikEziyiz64/DwmGuHbvZOxAqItKkhIB1I90AZ9K1aAkSjTZFzh
         FjNquCZgyVV4nTgkdAfJ2ZCUFy/sG1x6dOWAwN2vZH+q5h85pITOw5tCwQh0TA/+tonh
         cNqRq62L/oLxUMaBeFrYXPeIQ79eMbobnUvoFyU8qcLDGoel2JrVGLGG9ln2fh0NvH9u
         RfcuHRuq7k5M6TQbFg4aKbLZMGb3vAHP5YMlOJX43qwhlnpTxWlkF4qoWr/8DSGkXPBr
         e9lA==
X-Forwarded-Encrypted: i=1; AJvYcCU6ND+1r7fEQECiILZwyC7DZe2QgSnlMS4nEetHzKkO/vdS0Dfue2ko/2j7lWv53pzMGpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfbx58HY69ebaofgWyrke6ejF2HZmRBgUe9Xte+uGJ3ZDF/w9d
	E/2hw0JIuFyymyJxVcRlrbYqUwhhRpsbZJvByW6xhcDPEXZ520x23iGYdcMo2V4fgOo=
X-Gm-Gg: AeBDieudy+vKz9TGVLch3XUzW6J/4J2eWyG3nqHDE85RxagqW/DwDK07CvEOZMbs+B+
	4+Z+AKmR1rmwglZlgwqZlT0j1CDGbPZBSV0ki0l+YLSHqWASEfjnbvHBzCSWEmztQhK+Bw6254/
	MklRyTEjyEdhrVyqkb8c+MBTyUBsu78loteXQ/aSttR6EKyNoT2VnpD1RA+dvo30gBd8xBl365y
	1qqTbO/BbSIayA9kDIxk+C5IwmeUsWaD7Ny4a3Le2v3Omsjb6rqLXVbPmDDm1JCAASJEFEYVA7e
	yM136zxdNrh07cwJPjxVmvG63m6GX9+5YhMgSCuTJxJGcX82W9+NHNv0rZy0rjDSXNhlNd6VYHm
	yrcPGhSnh/yjtBlWMzpsVUGfUgtXVfI4pM5KSjNlO86AwnoN3U4JT2h+CG3TJbWx2BN5lS6lSvj
	OH8I9d3xCQfp5/BKEi8431jYzvpqJoQvnaA+BBCrxuQfhZGge9tM7F+Go4wIkaLVuH6HKtcQGk
X-Received: by 2002:a05:600c:c088:b0:488:a639:b772 with SMTP id 5b1f17b1804b1-488d67dbd80mr44469335e9.7.1775850928231;
        Fri, 10 Apr 2026 12:55:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5888c12sm109907875e9.3.2026.04.10.12.55.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:55:27 -0700 (PDT)
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
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 17/27] monitor: Make Xen emulation commands generic ones
Date: Fri, 10 Apr 2026 21:53:11 +0200
Message-ID: <20260410195323.17937-18-philmd@linaro.org>
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

In order to build hmp-commands.hx once we need to stop using
device target-specific check. Use the generic pattern to make
the command available on all targets, providing a stub with
kind error message when the feature is not available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/kvm/xen-stubs.c | 12 ++++++++++++
 hmp-commands.hx         |  2 --
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/i386/kvm/xen-stubs.c b/hw/i386/kvm/xen-stubs.c
index ce73119ee7a..bf6ac28bef4 100644
--- a/hw/i386/kvm/xen-stubs.c
+++ b/hw/i386/kvm/xen-stubs.c
@@ -12,6 +12,8 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp.h"
 
 #include "xen_evtchn.h"
 #include "xen_primary_console.h"
@@ -37,3 +39,13 @@ void xen_primary_console_create(void)
 void xen_primary_console_set_be_port(uint16_t port)
 {
 }
+
+void hmp_xen_event_list(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "XEN emulation is not available in this QEMU\n");
+}
+
+void hmp_xen_event_inject(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "XEN emulation is not available in this QEMU\n");
+}
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 5cc4788f12d..06d7b17bf25 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1839,7 +1839,6 @@ SRST
 ERST
 #endif
 
-#if defined(CONFIG_XEN_EMU)
     {
         .name       = "xen-event-inject",
         .args_type  = "port:i",
@@ -1866,4 +1865,3 @@ SRST
 ``xen-event-list``
   List event channels in the guest
 ERST
-#endif
-- 
2.53.0

