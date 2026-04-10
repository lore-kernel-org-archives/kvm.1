Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF173803C3
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850924; cv=none; b=PrA92nlNJB0VKSgMU+DUCvyddiu2Gqt11zQdlZSeKhbeA7+l9lvAUGcIqsxRBPOItDBWQD3pNtqwfNmDB7ma8sagzCJbf1RIipXyFYpCtLek/xS3TuIfvj23owXLCDmmC02WTTzE9uSenMnRetyg6BJPNLXk6i2RL8E0O8IrsII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850924; c=relaxed/simple;
	bh=kINEKYdz+oEtFKJ8apyaZXC0gA9C1vP6F/mUUMOidb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vk2w/p6gUF+nv1dsm8ghHydWGdhSFhHg2gyGdpu1NFF4NOyJMZXU0EUaxwsZUxfIg8s3PmAkSmfsOMXLfFtK1X6xUWUocQtiat0g7PRKYeI8FkSyYjZOPExXw7GRedLn1BFzR5v0lUGZjxUt+R1mqaCXva+xpAVS1VWRNr4OoL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uw4EZqgm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uw4EZqgm"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so17414155e9.3
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850921; x=1776455721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7DYNcbBqYRxENhIeovRDLogIedruZzNw+qepAaR4ak=;
        b=Uw4EZqgmGI3PwPp2+Y2PwXb6bVZYHzEBPa93OWDzu7fdsJdQIdEv+m6zvwU74otKuI
         28xTh7zI6kPZsRK0KQ5hYwXA7ybPmQNZ5bhL5WbVrBx58zwoo8sddhhL1AREuMbkdSRl
         VtNAOMknkDRVaFr2M70Xcj7qdkl4MWiTMZhh2rVA5Fy0narHEbz6aZx9YVgyCSRDhguv
         a9FJFyi/PMrU4z5RndH6dj3WYw8AAtT91HF4XOLoGnH83LRJZFKNySKkXKNqRXVLRfn4
         N3N59G4qAs3eYBqd2qVvd3BBfZxji9JOgrA11WQGYy0dufqhEBd5EINyiK12BtxGngQU
         kvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850921; x=1776455721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P7DYNcbBqYRxENhIeovRDLogIedruZzNw+qepAaR4ak=;
        b=ZFUMfFQ+6h3p9sfMtkuTWu5rojdW/tTO4+k4w62L4KCpJnA+dNY6YdaXa37dQJuhIV
         eVJg7F1+K+AQ8ugsImsCLlM4KYmsAxhgWZ/2k2n5L7mU/+/EC3PUF0t8GG4QjhknAECW
         8GlP5Z8NRBKdzAZT4tYHjpl2LbOGz6FHxIAOASJPlxiIwba0WajcsdVbq6xY1L65lLah
         CCko1CLR4G3jexKEt864iDY/wW8eiB9iFSVToUj3ypRk4iLR740FQnK4mJYl6D446JEq
         jB3AvUh3enk+uwDyuxGWYq5cCBYOQn1Zr3mQ5q7w7JzY4H1D2kry30pkQI6TjU1KttE3
         D3AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWJx9xNVgzJtOJvHRswonesSWQp4gjKb+ynV4wuo1mjkJ9BepLkiY0KjANrbpjDKjdzSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMBHLv1Vgl+4fVkA9B3GbKfln1ddUNP7wxc7O0j118jQ5VNhdP
	htqh0ISQ1HMSpCwBGeP3Vf849BFRdIJYtBkVblspJMX0qNC7RGFFYQ9nZ3qG+IrJw/0=
X-Gm-Gg: AeBDietONeVasyt/IFV9EeSVu5eI0Dt37ZQc/DEKGLIh6szPDkHPakxghQ9lSS7Ngv1
	2vH8WWROiK8LemHOrl0J4Ht0e4FAZj7BSICfHq///f1/QDgf9qrFShJx55jDrctpWrjJS1zfshr
	FxxlZBFmc3TahgWFLwGpoHp8R68QGeR9C7748pAKP8D7f8pnBQoDucVvvq/LW1+eOQiYnEfsmwR
	RmLEILOV0IvUX5T6WGwSBGQ2vbsHAyVUCX+5lAIPWv768gAoi9RDSf4jiXOs6apzFv/XXwOuEM/
	7R3wIGSPHz6AUGUzPeduvf3DIFDVA1dlxSl+GUbuW88FXE7cX3+twPC/TwyoIdWIc3526ZzEo0M
	bXss7duBRD9NssCWrBaukt7HMtgX8MjwzDexWM8xjqEeZMgq8h668Pc6YzPuAiDuH27o5YeCY2e
	Zax5mxv3mw0ieMmxgbjzfrXQ8qm9e81lFNBWPqzdmp9qgD8ZCFUzhaHRJBl6SQPtNzQAcesWww1
	F2zdnehfgg=
X-Received: by 2002:a05:600c:4e4d:b0:485:3193:6ddb with SMTP id 5b1f17b1804b1-488d6808507mr60392295e9.3.1775850921143;
        Fri, 10 Apr 2026 12:55:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d80bafsm29705155e9.5.2026.04.10.12.55.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:55:20 -0700 (PDT)
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
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v2 16/27] monitor: Make 'info via' a generic command
Date: Fri, 10 Apr 2026 21:53:10 +0200
Message-ID: <20260410195323.17937-17-philmd@linaro.org>
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

In order to build hmp-commands-info.hx once we need to stop
using device target-specific check. Use the generic pattern
to make the command available on all targets, providing a
stub with kind error message when the device is not available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS            |  2 +-
 hw/misc/mos6522-stub.c | 16 ++++++++++++++++
 hmp-commands-info.hx   |  2 --
 hw/misc/meson.build    |  1 +
 4 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100644 hw/misc/mos6522-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 932d6aee507..1810625eb1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1558,7 +1558,7 @@ F: hw/ppc/mac_newworld.c
 F: hw/pci-host/uninorth.c
 F: hw/pci-bridge/dec.[hc]
 F: hw/misc/macio/
-F: hw/misc/mos6522.c
+F: hw/misc/mos6522*.c
 F: hw/nvram/mac_nvram.c
 F: hw/ppc/fw_cfg.c
 F: hw/input/adb*
diff --git a/hw/misc/mos6522-stub.c b/hw/misc/mos6522-stub.c
new file mode 100644
index 00000000000..85eb0ee36ee
--- /dev/null
+++ b/hw/misc/mos6522-stub.c
@@ -0,0 +1,16 @@
+/*
+ * QEMU MOS6522 VIA stubs
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp.h"
+
+void hmp_info_via(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "MOS6522 VIA is not available in this QEMU\n");
+}
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 74c741f80e2..463038c302a 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -885,7 +885,6 @@ SRST
     Show intel SGX information.
 ERST
 
-#if defined(CONFIG_MOS6522)
     {
         .name         = "via",
         .args_type    = "",
@@ -893,7 +892,6 @@ ERST
         .help         = "show guest mos6522 VIA devices",
         .cmd          = hmp_info_via,
     },
-#endif
 
 SRST
   ``info via``
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 245ab9b98cc..d7e97a4a32f 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -20,6 +20,7 @@ system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 
 # Mac devices
 system_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
+stub_ss.add(files('mos6522-stub.c'))
 system_ss.add(when: 'CONFIG_DJMEMC', if_true: files('djmemc.c'))
 system_ss.add(when: 'CONFIG_IOSB', if_true: files('iosb.c'))
 
-- 
2.53.0

