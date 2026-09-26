Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EEF36167F
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406085; cv=none; b=YzKLfUc+i/s/SmkfUh5IWo1vH0oC+RjBeo23UsfbmjtGfrGYmuVurvZ3G+nS/dZF6mvIFQpYvKjUpFUUqHymyGwipHKahG1qEKWFbn3ReJP2HVqqZ5S0b+fbzFd6ZQcPuu92yLOVi7IUvmZZ2M/1hpl2Lmg9F6YH9jIXoMr7jQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406085; c=relaxed/simple;
	bh=bd8mgaG+qvquP+2clWMKiUl2nXg5ZFJBVTRodzsU0bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmMGrF8fy4Wo67Gx4I/a++x47DyCJ848YLq+PKeaLab30fZAsPP7yHFnonlFXepoF4NrH1Eq/t2sSHPTPEvDm/Vx4C9leRgIwj6nNltMEL9jfGHmJATztVpppUGFSslllCrB5RFc0mArE+poqisKSTAkyXgeecdutZurCNeBHnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDsT7ltM; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDsT7ltM"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3411e0ace19so778306eec.3
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406082; x=1791010882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qkiRWh0yDSkP2OT8vLUxuaEaTt8B1WJVNLebJyYrgq0=;
        b=BDsT7ltM+GucRX5GDU1+8LadesZE3MXxU9/f5X9S0X6TPETBIGvzDrO1yxigCtTCDl
         UkcI5L5XhIIer6A2EZoQYDeUIF2+Jk/ckFSLMSfBTsudrLv1o78UwYbnka26Wnb+yPYL
         VxUBWeBsI3GHN+1F9n8nGbHNXU0i7Wt/au/nJLsvRxhl61PDI3g9DKivIUFgc8sa7Js4
         ejlOI7DJhw43lWKOOIzc2g57wKy52CW2k/B30NIZywWhtl5oY275JUV/gCsiAUspYB0J
         1aFhxjJyo8u1SR+tUadE+LjMic9yeMLtcH8i8oPuFI2BVfaHWn4FnaAn3/U/soa64b+0
         BCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406082; x=1791010882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qkiRWh0yDSkP2OT8vLUxuaEaTt8B1WJVNLebJyYrgq0=;
        b=RbeHpUU0Y8xI8d1JybKZRQQJq5XH1+qrhJL8MHEeo1JHiVP/F31MeRJF0hvx7rZEpu
         gAx+iTdYGUJ0TB4EVL1OjXAJi73n6y+3q4j6s1csqS8tNoBayQCPAtV1z5bZYsTY9yAc
         IC1bT+yNoLtviHNf2vkYzlnu6ANRu5+VEr5Yf5s6A9bbvIjslVcMATwC7hWYc7gc7hOH
         6qY3hafrT0PXjT0F9f3/UFZ8G8qAnty//gDcyh9Tu/auiZ/JOAwKtqoEZAMeWJIfNSfC
         7+ebMOQAmHPFn78lQLHo4ylzmf8CiZ7EehNSeL3aoRM3J7d7lHKzRNbRypvjdp0Vv8Bc
         2BWA==
X-Forwarded-Encrypted: i=1; AKwUvBzt2XJPpLbgywKSE7CvvOsDo6utAcyllGDUbG1b8FS5GYEvlAzk8eQyMEYfGgA3X4Z4/8k=@vger.kernel.org
X-Gm-Message-State: AFuF++nARj03IZD8SpaAlk97O25PrdLLNGt7ZiIhFx5MRtun5kZyYEOK
	5IlU+QIIt5lGsuT2KrQoLypnlfUZvMSicQ95k/xt5ccQey1L7yaffTx0
X-Gm-Gg: AYBFou2h8AJBK7GPWwg2BEDRiQwJJPJtpTffvvNFUrdWVvaIX2L1RwLHjDnTKXqU1Nn
	3tCRGrOphkFXmn8kL3qSqgaf8Tt/d8nXndXFjVm2DAqTztrC0CCiu0m/nP0pN3JOLuzYOD61o6X
	poQlHiwNdHY4sl/JYr03f9GL8KExWeH2pV8k48G8ZWR38rN+ePt45grMGUwQbciRLZs/WJvHS5C
	gz8TyhikSepyVMdSdYxvwGw5+Nt6Olmc4LTtBxuk3QrsromIMcto7SLO8z8rscTKx8KuLGb4eIR
	AFoTlNLQpJ8MeMPlFHQXt6oPhOpeWzOlgT+T1Qr9v/Jjrs71oAggyh5Mx+7nH3lYcY3JhA0yxmm
	VR3ZQdExtDaUB6SikCGj75tUNFT/jTHvJP7OhJ5YequO9PHJXAJPZ7kd/dZb/E8wxubdMiXvv+L
	DR3FOwcoBSAU/slyRges+BPFjudkvhxCGiCoLs3tW2YulP44w1X+R7UMccWdIE6CL0l9aZUJ8zM
	5BbHMVsiRzeP6LHxr5045NDxRf6WsY=
X-Received: by 2002:a05:7300:7313:b0:341:3ca2:de2d with SMTP id 5a478bee46e88-342700bdf94mr2923658eec.6.1790406081403;
        Sat, 26 Sep 2026 00:01:21 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:01:20 -0700 (PDT)
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
Subject: [PATCH v4 04/55] target-info: rename target-info-impl.h to target-info-def.h
Date: Sat, 26 Sep 2026 15:00:03 +0800
Message-ID: <20260926070057.1234-5-luoyonggang@gmail.com>
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

Rename the TargetInfo structure header and its include guard.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/{target-info-impl.h => target-info-def.h} | 4 ++--
 include/qemu/target-info-qom.h                         | 2 +-
 page-vary-common.c                                     | 2 +-
 page-vary-system.c                                     | 2 +-
 target-info-def.c                                      | 2 +-
 target-info-qom.c                                      | 2 +-
 target-info.c                                          | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)
 rename include/qemu/{target-info-impl.h => target-info-def.h} (94%)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-def.h
similarity index 94%
rename from include/qemu/target-info-impl.h
rename to include/qemu/target-info-def.h
index cf42aabbc8b..8019d2c7196 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-def.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef QEMU_TARGET_INFO_IMPL_H
-#define QEMU_TARGET_INFO_IMPL_H
+#ifndef QEMU_TARGET_INFO_DEF_H
+#define QEMU_TARGET_INFO_DEF_H
 
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-types-machine.h"
diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index 91be415ed33..0f6772e65c3 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -9,7 +9,7 @@
 #ifndef QEMU_TARGET_INFO_QOM_H
 #define QEMU_TARGET_INFO_QOM_H
 
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "qom/object.h"
 
 #define TYPE_TARGET_INFO "target-info"
diff --git a/page-vary-common.c b/page-vary-common.c
index ddd08633788..5a4654725a8 100644
--- a/page-vary-common.c
+++ b/page-vary-common.c
@@ -20,7 +20,7 @@
 #define IN_PAGE_VARY 1
 
 #include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "exec/page-vary.h"
 
 /* WARNING: This file must *not* be complied with -flto. */
diff --git a/page-vary-system.c b/page-vary-system.c
index 6c49c10e23b..9773685dc16 100644
--- a/page-vary-system.c
+++ b/page-vary-system.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "exec/page-vary.h"
 #include "exec/tlb-flags.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 
 QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & ((1u < TARGET_PAGE_BITS_MIN) - 1));
 
diff --git a/target-info-def.c b/target-info-def.c
index d121b8c0170..fa19cabc55f 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "qemu/target-info-init.h"
 #include "hw/core/boards.h"
 #include "cpu.h"
diff --git a/target-info-qom.c b/target-info-qom.c
index 6965e4d1169..2b38673a3f8 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qom/object.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "qemu/target-info-init.h"
 #include "qemu/target-info-qom.h"
 
diff --git a/target-info.c b/target-info.c
index bba4503151a..9abe72b1f55 100644
--- a/target-info.c
+++ b/target-info.c
@@ -9,7 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-qapi.h"
-#include "qemu/target-info-impl.h"
+#include "qemu/target-info-def.h"
 #include "qapi/error.h"
 
 const char *target_name(void)
-- 
2.52.0.windows.1

