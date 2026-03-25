Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590DF3E1D09
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451884; cv=none; b=aTIAEEWd2FGE2S6LN5LEmeKyqS2im0MKBq+dxpdhFtlWKmoELlGexWx60wlzXHyDboVPNy+L6mIDW+88aRmNDjGYKRYqMTO0XxApguDSWTOH1OYpp4GeSYleOoIFq6qnVoxaW/yjmDQuSAnpj9gH/3FtDH0v+sIRSQEtXqxoL9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451884; c=relaxed/simple;
	bh=WEGLuv/WEPhxSI17BpeI8p2k+ukgfWldqRPbyNzQU4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcAmLrL9bTwMsbqM+iwNH9A0aO9m6r29rcpGn3W1/JPfIsF/u7bEeLWBMQlUsnww6FxL+6/Dp+hOaNq0qiBs7ULz/PwtaW/zDdbhlkk/nq26nGlhfDHnc4QusE9gV2ExDPqfDUddS6XZCkW5x5Hi4VHL93dvlvY1w9bFfXCOFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VmZW8gY0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmZW8gY0"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so30229325e9.1
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 08:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774451882; x=1775056682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxrAV8rmf30CF98liKz5B3rdomtAez5skkM9aGRME4I=;
        b=VmZW8gY0cyQMdQHEBuYQMi/8FwMe/1MbV1sSjeSkTwJp50dFt3/Ego4HGru/w/eoLv
         uwlpO0KH/IjyJjp0wwsBm8BE8hdFUeub/GNHxoM3vT9IIhIPcDdZrKozWYRiCguNoVyn
         sYdk61dEQbE7vS/ShAcuD+gOs/Ap4gEGXpO8Tny29cuij8yM1AFIygXFTxKGJfvN3/5d
         fffU49AQSA9Y2is/horgsf+kBq1jkeMHWoenF5uJ0xwSRfJi50JTZNOazSBItHec3MWk
         1/pC49Vlmotggxm3h3lkXKZ7g9MwMAS6iTOlO1+Bo95oFeIUKvKeGfWqzvkA4Wq3DhLy
         U4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451882; x=1775056682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QxrAV8rmf30CF98liKz5B3rdomtAez5skkM9aGRME4I=;
        b=hJPoxGPSHL5pP457DkwcogZIqNFt/oM9XNplYiAZk/ug4XFAG9T6m/S5/KbQJUTuR0
         KV212HtAMiOSl6FNSGsBP/YN+NQfClidZNZiH3wEewzdekulzGOeAWOLQ89Aw6V3NxDs
         FXM9F4uIPI3yp+wIxsXxc1QBHia735aEMfnnhx9ZYSwcRdXRB96rggpAbSlsIMClgyb8
         i3SD3wHf+vVbeOBpVqPx4tjtn+F+LFu99G2T90RdAM1Wp7OX6sANlkAL/2iZ8+1LmYIx
         a+nnq4n9EQb1BJILaVW9id+4dE1FBzRYPqRXghvLk/CL6RWY+Qtch/uGqaUXbK6OJOyf
         Lk9w==
X-Forwarded-Encrypted: i=1; AJvYcCXJjzwuErgx2Zm+YnwxyaM0jgDP9hRLxlx8KImHKnDIwLlBvLZtgee1RJ9METi8015YGmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzi3kFEKOgG+jNi9hJJmQ8Y7mfO3dSdKsx4xn2/u9LCUaHvAz4
	fSrPbxWE1OFa76ScGmHPA+q8Kz1W2+OjKQfOT5T1iymY8KCftBlik8SBVeA/rhzEZ0k=
X-Gm-Gg: ATEYQzyTbtoxbN3dA/U1E+p2zyjRxWOf2dLK2nNES+HEVl7Z7aiURFYWPhpcxeWzOic
	Y8HBu8RZs5A2Y5CfUZinHnrzciIVLU6L5wwrde+rLTRbnNkUO4g5GFc/mw8jW1cCtTpNsNa1VAy
	vPlfLzwwA10qXW2IasAkSG6yiTydkiwvXLA6gS4+Wjbk8FioJL08bd89I57/TpjCcb36d6m28yj
	T+fuyHR4OoOQzId2JyV17CRFcS9OyUMWsM+bVfEPUnQ01JQEeylqvZGCg32YEUmHknbG4zKvnCU
	NnQxdBcAl2MmldEpWpaRHFZmON+F+BLJW0M4nbtfm0E6i+psjotUyl0KpMU7yDgsykjAbTYYWqO
	FdIyxNLvheQvav0dtmp2XJX0S9eaFxFTVmIP6DcwpKYfsQuu044VjoF/LYlL1/nNWSuxNtXdJgl
	zeVYid2t2WfGhAm2cWzfzQfaZQ2EQaCNJUT9qjEw/sY9KDW9dAi4/VzR1PZzTl3ACj61zRv/HW
X-Received: by 2002:a05:600c:1e2a:b0:487:18c:7acf with SMTP id 5b1f17b1804b1-4871606d963mr61278415e9.25.1774451881686;
        Wed, 25 Mar 2026 08:18:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e265csm466393f8f.32.2026.03.25.08.17.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Mar 2026 08:18:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	kvm@vger.kernel.org,
	David Hildenbrand <david@kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Yanan Wang <wangyanan55@huawei.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH-for-11.0? 4/6] qom: Declare compat properties API in 'qom/compat-properties.h'
Date: Wed, 25 Mar 2026 16:17:26 +0100
Message-ID: <20260325151728.45378-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325151728.45378-1-philmd@linaro.org>
References: <20260325151728.45378-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While most of QEMU files use the QOM concept, few of them
use the compatibility properties API (mostly use in system
emulation). Move its prototype to a new "qom/compat-properties.h"
header, keeping "qom/object.h" for generic QOM.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qom/compat-properties.h | 8 ++++++++
 include/qom/object.h            | 8 --------
 accel/accel-system.c            | 1 +
 backends/hostmem.c              | 1 +
 hw/core/machine.c               | 1 +
 hw/core/qdev-properties.c       | 1 +
 hw/core/qdev.c                  | 1 +
 hw/i386/pc_q35.c                | 1 +
 system/rtc.c                    | 1 +
 system/vl.c                     | 1 +
 target/i386/sev.c               | 1 +
 ui/vdagent.c                    | 1 +
 12 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/qom/compat-properties.h b/include/qom/compat-properties.h
index 6e44aabc26b..90f8320adfd 100644
--- a/include/qom/compat-properties.h
+++ b/include/qom/compat-properties.h
@@ -29,4 +29,12 @@ typedef struct GlobalProperty {
     bool optional;
 } GlobalProperty;
 
+void object_set_machine_compat_props(GPtrArray *compat_props);
+void object_set_accelerator_compat_props(GPtrArray *compat_props);
+void object_register_sugar_prop(const char *driver, const char *prop,
+                                const char *value, bool optional);
+void object_apply_compat_props(Object *obj);
+bool object_apply_global_props(Object *obj, const GPtrArray *props,
+                               Error **errp);
+
 #endif
diff --git a/include/qom/object.h b/include/qom/object.h
index 26df6137b91..510885218ba 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -700,14 +700,6 @@ Object *object_new_with_propv(const char *typename,
                               Error **errp,
                               va_list vargs);
 
-bool object_apply_global_props(Object *obj, const GPtrArray *props,
-                               Error **errp);
-void object_set_machine_compat_props(GPtrArray *compat_props);
-void object_set_accelerator_compat_props(GPtrArray *compat_props);
-void object_register_sugar_prop(const char *driver, const char *prop,
-                                const char *value, bool optional);
-void object_apply_compat_props(Object *obj);
-
 /**
  * object_set_props:
  * @obj: the object instance to set properties on
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 150af05bf5b..9176665202d 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -25,6 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "qom/compat-properties.h"
 #include "qapi/qapi-commands-accelerator.h"
 #include "monitor/monitor.h"
 #include "hw/core/boards.h"
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 15d4365b697..cd2085fb3cd 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -18,6 +18,7 @@
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/visitor.h"
 #include "qemu/config-file.h"
+#include "qom/compat-properties.h"
 #include "qom/object_interfaces.h"
 #include "qemu/mmap-alloc.h"
 #include "qemu/madvise.h"
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6cf0e2f404e..6290b3556ee 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -21,6 +21,7 @@
 #include "qapi/qapi-visit-machine.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qemu/madvise.h"
+#include "qom/compat-properties.h"
 #include "qom/object_interfaces.h"
 #include "system/cpus.h"
 #include "system/system.h"
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index ba8461e9a42..73539c727b3 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -10,6 +10,7 @@
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qdev-prop-internal.h"
+#include "qom/compat-properties.h"
 #include "qom/qom-qobject.h"
 
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index e48616b2c6f..b36101f3a75 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -32,6 +32,7 @@
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
+#include "qom/compat-properties.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/boards.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index cb23322f5a4..6a0967ecd18 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -56,6 +56,7 @@
 #include "hw/usb/hcd-uhci.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qom/compat-properties.h"
 #include "system/numa.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
diff --git a/system/rtc.c b/system/rtc.c
index 56951288c40..f13dd392a76 100644
--- a/system/rtc.c
+++ b/system/rtc.c
@@ -28,6 +28,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/timer.h"
+#include "qom/compat-properties.h"
 #include "qom/object.h"
 #include "system/replay.h"
 #include "system/system.h"
diff --git a/system/vl.c b/system/vl.c
index 38d7b849e0a..ec31fd76c0d 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -119,6 +119,7 @@
 #include "qapi/string-input-visitor.h"
 #include "qapi/opts-visitor.h"
 #include "qapi/clone-visitor.h"
+#include "qom/compat-properties.h"
 #include "qom/object_interfaces.h"
 #include "semihosting/semihost.h"
 #include "crypto/init.h"
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 9dde972c118..261b6aaa37b 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -36,6 +36,7 @@
 #include "system/reset.h"
 #include "trace.h"
 #include "migration/blocker.h"
+#include "qom/compat-properties.h"
 #include "qom/object.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
diff --git a/ui/vdagent.c b/ui/vdagent.c
index bb0c4aa14ca..bb55cbefc9c 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -5,6 +5,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/units.h"
+#include "qom/compat-properties.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
 #include "migration/blocker.h"
-- 
2.53.0

