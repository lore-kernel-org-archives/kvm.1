Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734E23E315C
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000349; cv=none; b=CqVw56SMqPSg5XMKnEiSr2d0szZFo+7BKkkrXmVRr+8dEUV52yDWF7InmTsxV/7gROgYqs0rnxcmvv/C6/fEkrIG9fZ1GOjXRIqH/ImiWPYENzrRrujN8GlihCpvhVNvKqWXhZJG7zl+71q+zOgXrykfd5us6TxeLHtxA5PHH48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000349; c=relaxed/simple;
	bh=Hp1aaN6m9SLOJ9Ba77XKxslIFjByDCCJrJMUB87/J7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxxxXaLy/Q7zvfuZCUNV4Cj85hdptulckxxdtTsfJp8oCmNQgOzg0OowQJ1dBvvLoU6G8g/IwEifB8an+MWCDF7sCrBOxzdI7VmfZSUXBA+/J1oo0+SZCAr1FUC5rMp9jHlPlXEWufC05h6jzIqKGDH/ORlrFkgRq0iSJfZmwX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=h28rVdGL; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="h28rVdGL"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so1553155f8f.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790000345; x=1790605145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X9iJStx8k76O9mNNIa9n25MiOt6w1A7vHpXQesRkijU=;
        b=h28rVdGLNenqmI8RqjzxFu/RJSKbLRv+7ymn3gTJw47/ANWN+0HrOaUKmYmX7nU8Br
         GJKG4unSf/4uwU1vOeMkMKJ5416sM9iCusXrhaae6d4/C4r3FqoPxzE1PAMU9HmZgMhu
         JHn9FwGyJ1kdWyyhKheCP97wQjswxYDY18RN6NlbeJOh6N2J21EbZkZJ3jTlBFXfZFEc
         FTt7/EcXFY48wCNeXQxEbt2ZF1vIsjK3R77INN6YBckf7jlmApgzKNLrEBgTznc9+vYR
         2KucigoDm9smNQT3TVdYgB2ul5/Tksht4XzB/pr8NfUtgAvky9tOgHbdlzsfsldJG6cH
         s6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790000345; x=1790605145;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X9iJStx8k76O9mNNIa9n25MiOt6w1A7vHpXQesRkijU=;
        b=bwIGKhawbEEXHNVELir6ukJLkgxc2146NoIC1K+4OxtRhZvxDHA8ldECihQk/NBWrT
         0A9R34XOui4uPUUhU4JyhXzEp3IgwYWgj395CGwSVAwihwb3wGneMgoolW+mgZ2ZRN2y
         DmEV/RGbgP+4kCY4HjuczWEMm2+jn6L6t7Mku2nr27/ppdq0K9gDEpcbatDrBbuy29M1
         fFnIwD0D10/aaJZCDHHDrP4uhnjxapaCIPVFlIGzPTphgey5tFSGJIioNulNT6cry51j
         gIviR7p/mczJbn18oSdF4NzJPo4d+XO4bicPNdNRBOuo1DZaJK8lSPi+rv06ckWuK2fv
         MSnw==
X-Forwarded-Encrypted: i=1; AKwUvBzxwgnus7BIwWeunsXwRje/gmG4coFZY8VFRYzLFDbq9f962Ro3ae1TEDWnSgkJxwj92ys=@vger.kernel.org
X-Gm-Message-State: AFuF++lG2MZwmNQFkYhExDtGARLgDm42C85DjycvW4XoMbuUpN73KfNO
	XH18Ov/UCetwvt7fTCQlZMnvek4eZ7aByYjZysIu6akQ0a+YRH9U5HziZih9BvEGs6g=
X-Gm-Gg: AYBFou2Qf+qi7olfiIDuuajVdwX8Yn+z6GJVpRRx59BpEosCvwy/4SnXaOR6MC40Fu3
	pfL+dYTjRI/EsSN1gQc8wbw+i9EU1k4UQMSVbXZEMIrYOPJ9ZyxnfcuBQNNITcNB3CgSM+w7BkI
	iLWWOR2qVGntnhb3o7WyxPyfq6n9j2/9Fb3OM8kPVUhCA/HXcnTvOwYhuIcvnO+EEjfNunkrQKV
	Oo3sqNmhFHZG4AVfzxXBzIHLTcgwRDL5jvmaBrZeuELXcZzF5NQWpRYGo9shQYHU4B3SxyY1ZbZ
	DFewsdKH2fCx5UzvrGfEz0tbEt+jD/+r+foXorYA59zzPhBJ0BBzgwYZSSvNMe0KlxDmyKUHiyJ
	kKiU2+JhlzbQBl5+4qkmepXrP9dkDRiLiPj8GHI6yq6tRsoGuUwp0VQhXqFfvrzSPei8URKKZ5w
	x3DKZj/42YS6/rZNMvHCvJQJRhCD3FOEV2/w8ioScI8NbX4oS6Fr0bcZ/Qz2Ag5XADNWLRD6mRZ
	Sc+5Bzhtsdt8du+RANRNukYZv0oWKlWgmmvYlTyrUJa197zRPaWfYunPfQtVQ==
X-Received: by 2002:a05:6000:310c:b0:485:ae8d:1e07 with SMTP id ffacd0b85a97d-4871e37dee2mr15597411f8f.56.1790000345490;
        Mon, 21 Sep 2026 07:19:05 -0700 (PDT)
Received: from localhost (p200300f65f19a904d4f76eed31f2ef79.dip0.t-ipconnect.de. [2003:f6:5f19:a904:d4f7:6eed:31f2:ef79])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48724422790sm22134362f8f.5.2026.09.21.07.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:19:04 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Raag Jadav <raag.jadav@intel.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Alexey Gladkov <legion@kernel.org>,
	Hasan Basbunar <basbunarhasan@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	Armin Wolf <W_Armin@gmx.de>
Cc: WANG Xuerui <kernel@xen0n.name>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>
Subject: [PATCH v1 1/3] Move struct cpu_feature to <linux/cpufeature.h>
Date: Mon, 21 Sep 2026 16:18:49 +0200
Message-ID:  <ef103a4b9e1cd7477fa52ee347c4ec301354fba9.1789988540.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
In-Reply-To: <cover.1789988540.git.u.kleine-koenig@baylibre.com>
References: <cover.1789988540.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3330; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Hp1aaN6m9SLOJ9Ba77XKxslIFjByDCCJrJMUB87/J7I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqsTzLZ9D4hpytjwv31lXxPvfXsBlJnDYJz+Jiq Ckg1/ZdTzmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCarE8ywAKCRCPgPtYfRL+ Tr7BB/9RxyUkC8S2GB8h2AOL5R1cm+BhY9DSagwLwPGj7JLlQCNJn+1BpMEj/D6VFQC+nz70qG2 yPyA2QQ1bUxHWk/yXqQHc2aLOAwfVbWII5ziFW40g/6GvU6wvz8WcEyRDE31WY34MEQ7U7jcb6C lV32wGb66HTpO1a/WqGnaIiLw+93l6IkcuGzKf3aCqRjjMDVAl2id/bwVPjVAI4krEK2MsAhXb1 WpGCfUDDGDfmsMF3khnktkeHgFidAC6iBymdXOg9yODHQcbhPhE2c31y8H93SOIWisLa86oVmgb aT/QWYPEJ2u+WdNcbeKYiBJxYkR/MuOmC2K6dh+rQ1fbEPw8
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

struct cpu_feature used to be defined in <linux/mod_devicetable.h>. It's
much better located in <linux/cpufeature.h>. The only downside is that
modpost and devicetable-offsets.h need the definition and thus
<linux/cpufeature.h> must be included explicitly there.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 arch/loongarch/kvm/main.c         |  2 +-
 include/linux/cpufeature.h        | 12 +++++++++++-
 include/linux/mod_devicetable.h   | 13 -------------
 scripts/mod/devicetable-offsets.c |  1 +
 scripts/mod/file2alias.c          |  1 +
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 236523d2449d..d082dae61971 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -5,7 +5,7 @@
 
 #include <linux/err.h>
 #include <linux/module.h>
-#include <linux/mod_devicetable.h>
+#include <linux/cpufeature.h>
 #include <linux/kvm_host.h>
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
diff --git a/include/linux/cpufeature.h b/include/linux/cpufeature.h
index 6aff540ee9e5..93c1da38aaf6 100644
--- a/include/linux/cpufeature.h
+++ b/include/linux/cpufeature.h
@@ -6,10 +6,20 @@
 #ifndef __LINUX_CPUFEATURE_H
 #define __LINUX_CPUFEATURE_H
 
+#include <linux/types.h>
+
+/*
+ * Generic table type for matching CPU features.
+ * @feature:	the bit number of the feature (0 - 65535)
+ */
+
+struct cpu_feature {
+	__u16	feature;
+};
+
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 
 #include <linux/init.h>
-#include <linux/mod_devicetable.h>
 #include <asm/cpufeature.h>
 
 /*
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index a397213bedac..9ce2429b455f 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -8,10 +8,6 @@
 #ifndef LINUX_MOD_DEVICETABLE_H
 #define LINUX_MOD_DEVICETABLE_H
 
-#ifdef __KERNEL__
-#include <linux/types.h>
-#endif
-
 #include "device-id/acpi.h"
 #include "device-id/amba.h"
 #include "device-id/ap.h"
@@ -69,13 +65,4 @@
 #include "device-id/x86_cpu.h"
 #include "device-id/zorro.h"
 
-/*
- * Generic table type for matching CPU features.
- * @feature:	the bit number of the feature (0 - 65535)
- */
-
-struct cpu_feature {
-	__u16	feature;
-};
-
 #endif /* LINUX_MOD_DEVICETABLE_H */
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index b4178c42d08f..b57dbbef8777 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define COMPILE_OFFSETS
+#include <linux/cpufeature.h>
 #include <linux/kbuild.h>
 #include <linux/mod_devicetable.h>
 
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 8d36c74dec2d..88bff3207277 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -121,6 +121,7 @@ typedef struct {
 /* Big exception to the "don't include kernel headers into userspace, which
  * even potentially has different endianness and word sizes, since
  * we handle those differences explicitly below */
+#include "../../include/linux/cpufeature.h"
 #include "../../include/linux/mod_devicetable.h"
 
 struct devtable {
-- 
2.56.0.rc1

