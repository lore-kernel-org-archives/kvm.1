Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16653946C
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850994; cv=none; b=bN+LqMSq03Y8lmbsPgdW9oCd9ebRa+nplf2JM8tWvoKerHM5KVRsUdH9qoZrb4h9bWlYysrD/KUW926I3NGiv0e95VBr8tUUroSqLVtx7KheqdbCdLIIPgFdQ459p8JjYc7/D74xFBmnk0YVW7yo2zShXSpXBe0HMcppmAOHzKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850994; c=relaxed/simple;
	bh=+njxPFOQ6jW5jqFkcHjMc3ibnHqs32Y5+sD+YNsvla8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GE0q+V6T4GSyGd7xodZIDbUOrJCfceB31T5vKi1XxXQluHPSOLyxJVtV+1+hPWGxGc2XF09xZVoPGaX76Al9UBHLPQtSSGLq5Re3Hj6YnX4pGlFmSjriww6LBqManopf5vZ2gj5FNAlGvkNFSdqlpy/ePZypkM9H5EnWT0N9lBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NJLuhEbM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJLuhEbM"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d04fc3bf2so1441801f8f.3
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850991; x=1776455791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHk1fkmZMPSQJTPZJGYUyFHdUWj/VJJojjesXRowi+8=;
        b=NJLuhEbMmf2J265oKhVX6xrsM2t8G+n+7JFuqT8ankkRYR6LfIg1aAnsDGE3n0Ks0A
         18vwAYdKu0ZFB8Bbo5NSktUglNJ/gZ9cL40VUPaRaw40pzpkiPwpopzuWe4w5Pj1c/9B
         /bKPnJzYMxrQU58wqFgXjFrL3zWC4lZHGEYOH7UzPH9nQcYhsFKYl0PHkAYJx/o+Yb2Y
         gWLLV7KBVB8Zmt0fRniPW3WnGkXKoh1phLEmo4Smz0HFkVqHrSPF/oc78CcCbmCIOAWz
         cWDrNvnibkso219HtXoyHlJr2e9+eBqoZBjp1GM6Jrk7Sjl/8LR1L/NtCH5jxvdspuvJ
         Qw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850991; x=1776455791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iHk1fkmZMPSQJTPZJGYUyFHdUWj/VJJojjesXRowi+8=;
        b=GIDzoYMHiI/eKh7mJlOgxGLVIw2O470vGsEGySi5T153gS3+k9gUaZAxlmJekBoxur
         7NZJZSZG92AXzBHXm9bV+dZ1lRIBE2CqdzLeERSUZ6lq/NoRxbA45fOevhZhW80/nVeU
         KmFvfckyjxo+piAOekd8XTBYd/2A4y+PdIGDC29437hFar8euEz2+m9VEUAIV6IeGMKO
         TnzvCNrvs80i7TsCJHmtERRHRc+oNydetFShVIG4x9RiWz2Fgv7/n+SAk+4GQw6PqjxZ
         LbZZ3/tRL2Bawdz6RzpdClX6Jso87/wGTjQ+gF+OfBcRAOPmlX2/gk1ge74X2De9fnKK
         Vl5g==
X-Forwarded-Encrypted: i=1; AJvYcCX0zdGMReY+8YT0JSZc7cG5KhFtcN2dj5QSXhpjImRxdsOh16k7niv9y+BJcBNd7akViUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUh0zTuuqxG4wjsMBX6PzkPoHDeq5z9F7GpnxEFtmefS3YagCy
	msMAX2qq2+EKu6rFDVsfH6eUEQAuCElHMo6TsAdfqVMCavnD/Cs97wqHuiTDJ4JdxVM=
X-Gm-Gg: AeBDievvB+KjDYyLEIRgyfK+asX5eK/uNVoRI9JvI17wZxe9p08p3fmu7/dvTvEMv/i
	YCGWQg2g7LAzyO0iMCTAaGbejQbEZ7/SPVcOGQ8y/piopyEMWMkDr3JezcHbptr4UO9MxORcqjG
	ZDCegbVcQydwwGH3MTkqpDqM8Rg3qAbFKvywgqO2y5Ys3Dacy2EeShzbWJVIb3RVzFfIOgs+eF9
	l0ztxtV8J1oF+UjgflYd3HhhK2wvH6sZA3Cj+szzuBw5O+GOojuFShJVIcxsRD+iKJe1VBj8FTA
	fJBe8Sx3101+qNTCz9iF8fQ/f/lN1BS6PEroQRCShrEXFCX9jK02WO/41H2/KeBVEYAn1Lq1r3b
	+PZYUFWzqTnCeUlg4mtgIGfVhuEtnfg9gBwwGUlN5Svvs/A+URxwJ6FMpecW4iXCqJumKqUAemP
	xOHyetZHJv2dNGJlRPbpFkcs+iEcwdNiY9EaVNLhjgQwCMMYr3Rs1WpSA+o5A6S471gico85zk
X-Received: by 2002:a05:6000:40df:b0:43d:4b00:9ee9 with SMTP id ffacd0b85a97d-43d642ca07cmr7372748f8f.43.1775850991514;
        Fri, 10 Apr 2026 12:56:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e469ddsm9751293f8f.17.2026.04.10.12.56.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:56:30 -0700 (PDT)
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
Subject: [PATCH v2 26/27] monitor: Do not check multiple TARGET_* to build 'info tlb' command
Date: Fri, 10 Apr 2026 21:53:20 +0200
Message-ID: <20260410195323.17937-27-philmd@linaro.org>
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

This command is filtered at build-time for a selection of binaries.
By using the recently introduced HMPCommand::arch_bitmask flag we
can filter them at runtime, making it possible to compile
hmp-commands-info.hx once.

Since the method depends on a pair of distinct targets,
define it in its own stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 stubs/hmp-cmd-info_tlb.c | 12 ++++++++++++
 hmp-commands-info.hx     |  5 ++---
 stubs/meson.build        |  1 +
 3 files changed, 15 insertions(+), 3 deletions(-)
 create mode 100644 stubs/hmp-cmd-info_tlb.c

diff --git a/stubs/hmp-cmd-info_tlb.c b/stubs/hmp-cmd-info_tlb.c
new file mode 100644
index 00000000000..a144e68c1c7
--- /dev/null
+++ b/stubs/hmp-cmd-info_tlb.c
@@ -0,0 +1,12 @@
+/*
+ * Human Monitor 'info tlb' stub
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+
+HMP_STUB(info_tlb)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 2d0a8f7d48f..0898221a486 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -193,16 +193,15 @@ SRST
     Show PCI information.
 ERST
 
-#if defined(TARGET_I386) || defined(TARGET_SH4) || defined(TARGET_SPARC) || \
-    defined(TARGET_PPC) || defined(TARGET_XTENSA) || defined(TARGET_M68K)
     {
         .name       = "tlb",
         .args_type  = "",
         .params     = "",
         .help       = "show virtual to physical memory mappings",
         .cmd        = hmp_info_tlb,
+        .arch_bitmask = QEMU_ARCH_I386 | QEMU_ARCH_SH4 | QEMU_ARCH_SPARC \
+                        | QEMU_ARCH_PPC | QEMU_ARCH_XTENSA | QEMU_ARCH_M68K,
     },
-#endif
 
 SRST
   ``info tlb``
diff --git a/stubs/meson.build b/stubs/meson.build
index ed7ca54ae06..3c6d0032e93 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -86,6 +86,7 @@ if have_system
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
   stub_ss.add(files('hmp-cmd-info_mem.c'))
   stub_ss.add(files('hmp-cmd-info_sev.c'))
+  stub_ss.add(files('hmp-cmd-info_tlb.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
   stub_ss.add(files('hmp-cmds-target-i386.c'))
 endif
-- 
2.53.0

