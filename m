Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D346D3A1A22
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406078; cv=none; b=IEYWRiyp1IxXfI3xmmlowki8mlr/OhwuvkOJqlhWxBK4bzB27IUizCZg+FymXI2lxFeixXx3480d6EzF/rpG5fnyNfevGjhIsMHoUxQl1cUT6kUG6xDMO8lOyCF2nlU9ESfhPoitmAfD7W5H/InfsLlypemp6ny4TBQhmyCIGyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406078; c=relaxed/simple;
	bh=rTwO79fhd0h2DwWWaU4MrTzO7s4MJYQVbCkwSlkESq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S93qf+9eU9EM/DKZUP4tJtJdgCMTpCc8Ob91awRHjIsqmTzKm7/L0iULTn/0vBjWaBh0NWiX9YM3hti3ga5ZRAYo3DsPEaI/F4rv8UnVo5TyUB++NjZHtdmOTgGGelVfBR9yCl6KYGygc8e3eIoj6QgUm+c0olWts7Jt9M3KPK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSBya+Hs; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSBya+Hs"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a15703so1347798eec.0
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406074; x=1791010874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uuwRl4ClI+53kQRmwmmbWdvUO8JCv7PNWaf6z+9UVak=;
        b=CSBya+HsYVbpzjmk0UJnDaUzmDEuLqcqXAtV0e78IU7ags8lO9jqRgWr0PQG9FIz8O
         XuL+cI6LwepCUmBKtHjbiMctPNdRNWAgOGOWFxVnlTx1CfXwWMxrjIZR0/5GcvH8+DkV
         gdjRTPKqkgvdtxMiK+Mkg2S7wiDqs8caQiWyjhANkcQwPpG7tLDea3y94MWUQo1xsIlL
         xUdZYKCnaLOMh7LOpjNNZPMjYJN8eSIV23AzzJVKRg9O1Lcv6JdUFXgDJErdCJGTPVZP
         moEnmB9QQ9ccR+UdE6vt78q0CuQw4vJlvG94JshPirJzfAhWsaKrthyHFhkBkjOzkk2P
         alhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406074; x=1791010874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uuwRl4ClI+53kQRmwmmbWdvUO8JCv7PNWaf6z+9UVak=;
        b=QPrZsuOnfmi0hlcaEJL86B2LAld5rLn9QjpNH/boAVyEmbcluoeqDkHs9bv7E7OLY7
         4Egpe3Nb6R5njjGf+8KGb+/4tEn16Q1p2T9YC78zl2Tc7m+Mbrdl6sMSdUbkDI9bHyi7
         GoXW6cQNInDhqYYo4EyvzSGySSiOrZhgDwk28rucPMeePJ5tyU6RegHUfgVTuUSk8j8J
         uNfpYGXFmGUMy9lXxG6c8skLlIwj8WlTRs3HcD6swuKitRfpTOQ3Kgrkvd3mQZeo/CsV
         +N1ut25SUuvWg8YoDWSIXx2HeuvQA89+mhnH9I3bA5sm2707BpJKZliIh8I1ZrKvxGHT
         iz/w==
X-Forwarded-Encrypted: i=1; AKwUvBzthWlGwsRs8YgXSSAqohfH0/Bg/LMSkV6t6m3n2aBmH4u1JHmhj90bp4KGfLCRMKvcFIc=@vger.kernel.org
X-Gm-Message-State: AFuF++nTs8u5VdyflQUg09J8xh36Z8c1rVbFYzZY9mQ2NyC2TWRYjKST
	cTz2kLsadUbzkIUCFW4QLbUBjZOlsk7wKxr9Dd/3EUymioJlYpuXKGA+
X-Gm-Gg: AYBFou1HIR5QmywyNzkALnSUjAiShOLFkskQpHX8CykGAKFqg5I/DuwoJAYAXh0YQK9
	ZeQuCmuu63rXEyE5GwozzIX7pqadqc0t6lnelhm1nste86nvNjJWKGnVLaiT6s4t9cZghpEIvd0
	lvxZjk8I4unCMydFROHLHksxHnGrNnwl4SE0HlrFr99ukhHz9WvdtbdvaP/4ICM1ipsybgHG+2J
	EmkEnBdPjrjZLWxU64hWFsIjK9D+nt3gNFEISnAQaOsQJUnS/1THkT5ce/awTM4Z31LF+Hs9OVq
	r6qZCZdt2y6xK8VtulnpsCa0tAcYsJ8K1pe54xdGSnsxdr/EUcuw6TCAHMzsr5mcEYBkKM/kQfi
	Cjqx8xheec5FLG3FYZGikmgRYTW1FBbvW5krmxZ8vNDD8BpwTC/+XIWuwRmkVcvNZ661qh6vCH5
	TSa+oejSo7GmACpipljEn5RNMko83O0mayleIoNBi+GaXGurdEIR9uyk06jKg6nxcUxlAGv3X35
	EtZ9rQCPSTvWnk7hldmBaHT3FUwEDM=
X-Received: by 2002:a05:7300:e11c:b0:339:85bf:dd89 with SMTP id 5a478bee46e88-34272b3c01emr2505009eec.35.1790406073689;
        Sat, 26 Sep 2026 00:01:13 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:01:12 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 02/55] configs/targets: remove target info definitions
Date: Sat, 26 Sep 2026 15:00:01 +0800
Message-ID: <20260926070057.1234-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Now that we remove machine_typename, we don't need to keep duplicated
file per target anymore. So we can just rely on target-info-stub.c.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configs/targets/aarch64-softmmu.c | 25 -------------------------
 configs/targets/arm-softmmu.c     | 25 -------------------------
 configs/targets/meson.build       |  6 ------
 configs/targets/riscv32-softmmu.c | 24 ------------------------
 configs/targets/riscv64-softmmu.c | 24 ------------------------
 meson.build                       |  7 +------
 6 files changed, 1 insertion(+), 110 deletions(-)
 delete mode 100644 configs/targets/aarch64-softmmu.c
 delete mode 100644 configs/targets/arm-softmmu.c
 delete mode 100644 configs/targets/meson.build
 delete mode 100644 configs/targets/riscv32-softmmu.c
 delete mode 100644 configs/targets/riscv64-softmmu.c

diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
deleted file mode 100644
index fdebdcc3582..00000000000
--- a/configs/targets/aarch64-softmmu.c
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * QEMU binary/target API (qemu-system-aarch64)
- *
- *  Copyright (c) Linaro
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
-#include "qemu/target-info-init.h"
-#include "target/arm/cpu-qom.h"
-#include "target/arm/cpu-param.h"
-
-static const TargetInfo target_info_aarch64_system = {
-    .target_name = "aarch64",
-    .target_arch = SYS_EMU_TARGET_AARCH64,
-    .long_bits = 64,
-    .cpu_type = TYPE_ARM_CPU,
-    .endianness = ENDIAN_MODE_LITTLE,
-    .page_bits_vary = true,
-    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
-};
-
-target_info_init(target_info_aarch64_system)
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
deleted file mode 100644
index 2b98f65a0f8..00000000000
--- a/configs/targets/arm-softmmu.c
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * QEMU binary/target API (qemu-system-arm)
- *
- *  Copyright (c) Linaro
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
-#include "qemu/target-info-init.h"
-#include "target/arm/cpu-qom.h"
-#include "target/arm/cpu-param.h"
-
-static const TargetInfo target_info_arm_system = {
-    .target_name = "arm",
-    .target_arch = SYS_EMU_TARGET_ARM,
-    .long_bits = 32,
-    .cpu_type = TYPE_ARM_CPU,
-    .endianness = ENDIAN_MODE_LITTLE,
-    .page_bits_vary = true,
-    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
-};
-
-target_info_init(target_info_arm_system)
diff --git a/configs/targets/meson.build b/configs/targets/meson.build
deleted file mode 100644
index 2ab4d27eaf5..00000000000
--- a/configs/targets/meson.build
+++ /dev/null
@@ -1,6 +0,0 @@
-foreach target : [
-      'arm-softmmu', 'aarch64-softmmu',
-      'riscv32-softmmu', 'riscv64-softmmu'
-  ]
-  config_target_info += {target : files(target + '.c')}
-endforeach
diff --git a/configs/targets/riscv32-softmmu.c b/configs/targets/riscv32-softmmu.c
deleted file mode 100644
index 0829ab84de5..00000000000
--- a/configs/targets/riscv32-softmmu.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * QEMU binary/target API (qemu-system-riscv32)
- *
- *  Copyright (c) rev.ng Labs Srl.
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
-#include "qemu/target-info-init.h"
-#include "target/riscv/cpu-qom.h"
-#include "target/riscv/cpu-param.h"
-
-static const TargetInfo target_info_riscv32_system = {
-    .target_name = "riscv32",
-    .target_arch = SYS_EMU_TARGET_RISCV32,
-    .long_bits = 32,
-    .cpu_type = TYPE_RISCV_CPU,
-    .endianness = ENDIAN_MODE_LITTLE,
-    .page_bits_init = TARGET_PAGE_BITS,
-};
-
-target_info_init(target_info_riscv32_system)
diff --git a/configs/targets/riscv64-softmmu.c b/configs/targets/riscv64-softmmu.c
deleted file mode 100644
index 553bd1f75fe..00000000000
--- a/configs/targets/riscv64-softmmu.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * QEMU binary/target API (qemu-system-riscv64)
- *
- *  Copyright (c) rev.ng Labs Srl.
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
-#include "qemu/target-info-init.h"
-#include "target/riscv/cpu-qom.h"
-#include "target/riscv/cpu-param.h"
-
-static const TargetInfo target_info_riscv64_system = {
-    .target_name = "riscv64",
-    .target_arch = SYS_EMU_TARGET_RISCV64,
-    .long_bits = 64,
-    .cpu_type = TYPE_RISCV_CPU,
-    .endianness = ENDIAN_MODE_LITTLE,
-    .page_bits_init = TARGET_PAGE_BITS,
-};
-
-target_info_init(target_info_riscv64_system)
diff --git a/meson.build b/meson.build
index cfac634cf13..732f0a885ba 100644
--- a/meson.build
+++ b/meson.build
@@ -3754,7 +3754,6 @@ subdir('dump')
 subdir('accel')
 
 subdir('backends')
-subdir('configs/targets')
 subdir('disas')
 subdir('migration')
 subdir('monitor')
@@ -4331,11 +4330,7 @@ foreach target : target_dirs
     endif
   endif
 
-  if target in config_target_info
-    arch_srcs += config_target_info[target]
-  else
-    arch_srcs += files('target-info-stub.c')
-  endif
+  arch_srcs += files('target-info-stub.c')
 
   if target_base_arch in target_arch
     t = target_arch[target_base_arch].apply(config_target, strict: false)
-- 
2.52.0.windows.1

