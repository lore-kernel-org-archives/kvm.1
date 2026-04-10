Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2781B1D0DEE
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850938; cv=none; b=RFnLC4N+q6NZUbiYL8Pkckw2rXN74Y4dvrQ89AygtMXLpTevxspu5Qj1wuCPEo2HD2n+FY2pdIatuHFPwrKbatFQ4WBrjLHTcuTD5PQHG+HxsQeYZ/LhT4F/DLJYSoz7qfbsY7nGdyGo9SxFt1OBk3WX4OlRDXkAcpTruNYDdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850938; c=relaxed/simple;
	bh=Sb6uELvONLYYgh2Vw7XBKF0EYoIQRwToe7PuVXA7Y30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxnH9sQSX6k/Mt/UqPcSeXzI2CWOaf/5T7t32K0Z5OgShHUvXYVgY1xZyC1wP07/AQOvl69L8jb/w5S1dhB4YoYMM40E2G5afHMv8zyYAWi/GZFi5tnVV7DIzD9zBPWf2T1lsWjQ1UpvYjmhoHMDnEKSBMkIa5rMffDZI6unZU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nyOYSJKv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nyOYSJKv"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso27733365e9.3
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850935; x=1776455735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=px/O9JgpOPO/Ufbv2ZpzWXAnxI26EBsW5Ud+Y2G0TJ8=;
        b=nyOYSJKvaiw15BeEQ2jc7HnKekGzSFCUjeCisG3wr1alw/lS+3flIuVSt2VUDJsIZ0
         EchxIJIVh1gzjWPGS+LJoJXks0f+nQfHguXsTcMLTa4YtgPlchLyOJmNKL3cPaYAEEFw
         Ktq9vhiLeTn7LrMU4PYOTLXx12vHqBVSdIimf0F5RCxAiPZPp1Q3SkcmitHlNHeOUBlt
         fWXGtxLKryua9g5vRfD67dDsJyUrJVr5MdIZi5NSxCUM9ngvCTzcxPcf2BriCXj+3vAe
         5x2RGKmkjsA2UEXrPziTt7HOpbsKvQ+CEI9hp6Dk1T24Fdv6YOFLubzH4secCDrrPqd6
         +xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850935; x=1776455735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=px/O9JgpOPO/Ufbv2ZpzWXAnxI26EBsW5Ud+Y2G0TJ8=;
        b=E5Aph/LedamuDwI/0XOsbwn9CHXfBLl5N1aXkeCPUNLNsDMFHTa3gzBfvmwkD4TXbj
         452qcFwkqTGR3d0M5w5CpQMFRcBKnuCR3B/YHw+rbdcTWhE6KMAUBjJ2OhRoDrDsZUms
         /2NjEvoGS8503/3dqqbDWnwCYnphJ6PY/TlIgfq8XAsD9idmiq240R+frXFgzs63qai1
         u6O2ghHFyrzOe0Wt9rO7wTox5+r51DybZh8MJ8qpD6pktnVr8IgJNBmJ/9dbrAAEKbT6
         OT+D3YXcJV1GXH0sUf8Le7+tu9C6v/ZFfbJD5eRplDpVQXQlrFLQf2iGdl9okYzfhgrD
         mWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg1nC7CP/OHqvEYqKEQLdwOtVvjz5ezDa/SawqUqOsd0oDPmoMBHDAQYBzA1gSOpVGHUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+f0MHXC78PhJfakGxcV1Fg5QSQadgbDw65k24QvR9jd7BeXN3
	F6hnv4M58VtdPxx4laKWDcYjgSnuGymrVjS5oEMN6UUaHWXMBQT0l8jUfx/ZpRRrQ3o=
X-Gm-Gg: AeBDies6H6nwMZluR5mukcdce0U0V0nWNO5m4YNnGwn6twEujg4JXqy7b2gDIt4Cib3
	mZuBCpzE9GyYDifU2I7aOwIUq9UN/znVE7fDC8DQfv/l0P64lHSqxF2XZD3drxVgvznjYgBVvHi
	MukKC6YS4So6I/0QG5aC79jrkBUxSovOeiceciX0YT+9+RFQbdrKIeZoChLS7DXDY9B39X1OHPe
	ex434KG2pvfDv5KTHpXX+q7ewIAVrOTKn0jeIlb/rGHgmtIU0h60J4+sFnxHkfG2N3mX3fZzCJg
	d/Gu307YvL7HA2dhDHLmI+XdTC8/piFzArb2VlFNBkcEKXq+cY0pw0Bcjwccum3b3U2M6mi1XjQ
	WA7r0GiY+4BdnSTHax7BM6jpRR5IunVz74ISp+0dvF52CzEXcvonrOPjfKvlBG3MxvOCbhEje8a
	WhoR0E6hoodTZhw6TgKDeNl0oaDSAtYCe+Fy9w4Ugmmdy4oJ/Ff1m2fF1aWanwGOnTLNPYnbbY
X-Received: by 2002:a05:600c:5298:b0:488:c014:34da with SMTP id 5b1f17b1804b1-488d688687cmr63654455e9.26.1775850935538;
        Fri, 10 Apr 2026 12:55:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d681ea59sm28066985e9.14.2026.04.10.12.55.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:55:35 -0700 (PDT)
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
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 18/27] system: Expose 'arch_init.h' as 'qemu/target-arch-defs.h'
Date: Fri, 10 Apr 2026 21:53:12 +0200
Message-ID: <20260410195323.17937-19-philmd@linaro.org>
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

We already have a file unit outside of the local system'
folder which include "system/arch_init.h". We want more files
to use it, so make it official it is a generic header by moving
it under include. Rename as "qemu/base-arch-defs.h" which is
more descriptive.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/arch_init.h => include/qemu/base-arch-defs.h | 10 ++++++++--
 hw/pci/pci.c                                        |  2 +-
 system/arch_init.c                                  |  2 +-
 system/qdev-monitor.c                               |  2 +-
 system/vl.c                                         |  2 +-
 5 files changed, 12 insertions(+), 6 deletions(-)
 rename system/arch_init.h => include/qemu/base-arch-defs.h (92%)

diff --git a/system/arch_init.h b/include/qemu/base-arch-defs.h
similarity index 92%
rename from system/arch_init.h
rename to include/qemu/base-arch-defs.h
index 0c2b1f3a5d0..f33465738c9 100644
--- a/system/arch_init.h
+++ b/include/qemu/base-arch-defs.h
@@ -1,5 +1,11 @@
-#ifndef QEMU_ARCH_INIT_H
-#define QEMU_ARCH_INIT_H
+/*
+ * QEMU base architecture bit definitions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_BASE_ARCH_DEFS_H
+#define QEMU_BASE_ARCH_DEFS_H
 
 #include "qapi/qapi-types-machine.h"
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2c3657d00de..a38dffd4899 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -36,7 +36,7 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
-#include "system/arch_init.h"
+#include "qemu/base-arch-defs.h"
 #include "system/numa.h"
 #include "system/runstate.h"
 #include "system/system.h"
diff --git a/system/arch_init.c b/system/arch_init.c
index 604d5909ed0..1ad2f3d6f78 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "system/arch_init.h"
+#include "qemu/base-arch-defs.h"
 #include "qemu/bitops.h"
 #include "qemu/target-info-qapi.h"
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 2ed95e83602..2e9dbb9b5c2 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -23,7 +23,7 @@
 #include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "monitor/qdev.h"
-#include "system/arch_init.h"
+#include "qemu/base-arch-defs.h"
 #include "system/runstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
diff --git a/system/vl.c b/system/vl.c
index 246623b3196..23f1da66369 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -112,7 +112,7 @@
 #include "trace/control.h"
 #include "qemu/plugin.h"
 #include "qemu/queue.h"
-#include "system/arch_init.h"
+#include "qemu/base-arch-defs.h"
 #include "system/confidential-guest-support.h"
 
 #include "ui/qemu-spice.h"
-- 
2.53.0

