Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A293DD50D
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064737; cv=none; b=iAxaaqbVJKM/H43Gt4FFYlP+CeUOqmmyqYXjSdtl+cqOlZom8pdkLB8UwBs0vnskZ1XcW09K9nfz1ncjLN69Q3m6hTMJXyPH8bBNG8Wa66VIkQOszaGb7F8iW004eXondWwUfORqKr7czGhl8dCRvFZRNTLD74NeHqJ1ptnr/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064737; c=relaxed/simple;
	bh=AWsEFFEuvkpdyRCq1dIK/cdO0HBk0pjW37gAZMo8lJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQ5i3SL8gT0GbDoLdy7uI3OVkidlw7J07SZskD1qlpzr+yc2arTc+tXYlaUPNWNKdxZReyDZWYaoRS34iLcPPTbHbZLWeP1BEgB3c3YxCyaH4ffNck9zArzjGDt0AYQUjrb7pWc+RzcKYDLj/RBqDt4cpm0kLMMOADHVxvJfVDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fyx09p7s; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fyx09p7s"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44a74032ff8so10481268f8f.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780064735; x=1780669535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1nU19JBZL4OEtH8maExRk6vLACT0H2OM9tp9sLLgYM=;
        b=fyx09p7sptMSSoIwcEPvFP8rnTcKVvJ0v4EqTEx/FoiyuowMJpriciKIRLI6/6ffGS
         mZc7BjmDvGaO9jov8XOQA7ke3kF7SWFl7Bt9HuULpdBXRIMXZbn+hOas06CvCnO0tSp5
         GZoTbXE4MYqvhcTzTUviUdTZK8WYTNUyyDrupo/S4WNLQZKYgsT0sjquJvxvv2xOEpHZ
         llwx9LUN+3x3mA2xIarA4e+fupdBqJzrlLZLQlz8QIRzgrbaS43B7WRvb1HLFtdir7Fg
         VT4VB63+uEsr7kPVk26J1thD9lOm0Ei8XKdB0EHncmZK0duPEYX0Kp14zck+d0vDgU8D
         0S/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064735; x=1780669535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j1nU19JBZL4OEtH8maExRk6vLACT0H2OM9tp9sLLgYM=;
        b=gU/M5c87Do4mcXXWUEaRb4SHgkW/jVO+vLc4VYlIbgGapBrb7B6wNMYOoviGNo9wdr
         JbZp6/hSKOUL7767nElX5YKKouMB+dLpyLGWXjsD+LfYU/LK//MbwT5/SLdsI05vOkmE
         y7I8KgrgdIqYmhYqmPhRlwqAquXr595jrxoBX25hvTutHhyLS9oajsTVxaQsS+5hAuAu
         gAUWjLlLaUtVHEMMU+S8BEmVy5lvd47M2AVkXYuOAz53/cyxQHLRZFXbEgnRyv2ADuYq
         fEOD3cCiwmC/BCwJ3biY9kimKDBw8tCusk7yufl7+VPWPtRm3kKrAIVRh99LB5s09uk7
         R5tQ==
X-Forwarded-Encrypted: i=1; AFNElJ+o8Y3BTnFpmHkjhrvZXS0goUWtiQ8GKoqblhxar/R4mlw9ejrPmCQrAZ1V5HXjLYXnFlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4V/PaBgbQs2NEDLe9neT9YBuPGkEeW6pkg2MRniHTYRKmDKqQ
	SSsTen4R5J6V9pZSXe/26FOT9ZrgmgUoHyE5QYA3UyTHMlNjy6kaO8Y8irZofPqulDk=
X-Gm-Gg: Acq92OGquCIC6ghb/HXfqAWU3jAjmqtF8GvL8qX9WT8sZfUoqVG/llwlZ9T5pZ7Rsp1
	CUk9CCyI57qj85i0Gtsbdy8KQAG9RqzsH6wl6IfjwNOMabLdV0W6eQUMPlcsNzID4XO2DEq1oJO
	uL1+GNxG+eSSs2oltzreyNA/lQGohHwHeQDXADpPPIGZpxoHtSHKyqAR5VOSQRIPy0B0JZLWqeU
	WI1E1/bW/myL1aaKJaCJcEq2mbbuVhABn5HvzJCNn162TbUtjEylfxdEzh3JUg/6Ytzuf1e112U
	VJkouhJ+yfszGdF5DGxUJzrCXuGQ6RRx+uLZfbp/7aCZT0XK/91EUNpuDYos+ZLArOnmGoHC6SX
	iJsIvHTepgAt549ZQ/SADvGpUiOBFTtQ5Jc64hL30UWiymIgDL6YIamhtTi9oMxcWHFNzRR/CEg
	FYfOpYQTkd3K202rdKWdJ1zALr6UkInBdLZ1V64LwoTg/V6oQ6WY1YJ5ze7GErErU6Eg==
X-Received: by 2002:a05:6000:b12:b0:45e:9421:4ca8 with SMTP id ffacd0b85a97d-45ef6b5f4b8mr51023f8f.28.1780064734740;
        Fri, 29 May 2026 07:25:34 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35598e5sm3749122f8f.27.2026.05.29.07.25.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 07:25:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	qemu-arm@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Anton Johansson <anjo@rev.ng>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Song Gao <gaosong@loongson.cn>,
	qemu-riscv@nongnu.org,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Alistair Francis <alistair.francis@wdc.com>,
	qemu-ppc@nongnu.org,
	Weiwei Li <liwei1518@gmail.com>,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	kvm@vger.kernel.org,
	Claudio Fontana <cfontana@suse.de>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/17] accel/whpx: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
Date: Fri, 29 May 2026 16:24:23 +0200
Message-ID: <20260529142434.87880-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529142434.87880-1-philmd@linaro.org>
References: <20260529142434.87880-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Register the new AccelOpsClass::cpu_instance_init hook.

ACCEL_CPU_NAME("whpx") TypeInfo is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/whpx/whpx-accel-ops.c |  2 ++
 accel/whpx/whpx-common.c    | 17 -----------------
 target/arm/whpx/whpx-all.c  |  1 -
 target/i386/whpx/whpx-all.c |  1 -
 4 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/accel/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
index b8f41544cbe..099e8ef6da3 100644
--- a/accel/whpx/whpx-accel-ops.c
+++ b/accel/whpx/whpx-accel-ops.c
@@ -98,6 +98,8 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->handle_interrupt = generic_handle_interrupt;
     ops->supports_guest_debug = whpx_supports_guest_debug;
 
+    ops->cpu_instance_init = whpx_cpu_instance_init;
+
     ops->synchronize_post_reset = whpx_cpu_synchronize_post_reset;
     ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
     ops->synchronize_state = whpx_cpu_synchronize_state;
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 247e12db812..25c5d84fd30 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -24,7 +24,6 @@
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
 #include "migration/blocker.h"
-#include "accel/accel-cpu-target.h"
 #include <winerror.h>
 
 #include "system/whpx-internal.h"
@@ -505,21 +504,6 @@ static void whpx_set_hyperv(Object *obj, Visitor *v,
     }
 }
 
-static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-    acc->cpu_instance_init = whpx_cpu_instance_init;
-}
-
-static const TypeInfo whpx_cpu_accel_type = {
-    .name = ACCEL_CPU_NAME("whpx"),
-
-    .parent = TYPE_ACCEL_CPU,
-    .class_init = whpx_cpu_accel_class_init,
-    .abstract = true,
-};
-
 static void whpx_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -569,7 +553,6 @@ static const TypeInfo whpx_accel_type = {
 static void whpx_type_init(void)
 {
     type_register_static(&whpx_accel_type);
-    type_register_static(&whpx_cpu_accel_type);
 }
 
 bool init_whp_dispatch(void)
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 3079c6293c8..16040f102a3 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -23,7 +23,6 @@
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
 #include "migration/blocker.h"
-#include "accel/accel-cpu-target.h"
 #include <winerror.h>
 
 #include "syndrome.h"
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e626acef2f0..1b68f13a7dd 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -33,7 +33,6 @@
 #include "qapi/qapi-visit-common.h"
 #include "migration/blocker.h"
 #include "host-cpu.h"
-#include "accel/accel-cpu-target.h"
 #include <winerror.h>
 
 #include "system/whpx-internal.h"
-- 
2.53.0

