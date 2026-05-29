Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691E323395E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084329; cv=none; b=PG94vKsIJbX/zF0ameU0QQ3F/8A9CrqxfnmzG6OvQQ1IC9WfLMD4NKqU52iFY23vMcJ/cjweBnTnxkJhg6Qm0VqLAEaSxg7Y2TrLs6Y5tcT7F/qnrMihKYfpplSvNaVhY2L2F9DLShDJnXupDC1yd8GT+GuCO0HtMCBfGXEorNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084329; c=relaxed/simple;
	bh=+dJ243gsmVeZXKLRcKiA65nqcMZ7H/zwLBXxL2z8al0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnGSTDbZ+FdOqEbN+GgQ+Nt5z0XLFXSsfPIfdctprT/7GWEXrMDjTk9seJiQDggImIneg1pw8ZVoQ3Z9RopMHBcsEJWEAxjhZubwz8e2p8vswOsWZfBelx94Lrhbl48nwQq39cU7wO63sW2o36txgl0f3eNXgzKhfFu65jxJQEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bqujE7j5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqujE7j5"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45eea4c0649so1745818f8f.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780084327; x=1780689127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Je8q/HCAd0aP2wgv5J5zrln6ORTrwi01jkqwR3v8AHc=;
        b=bqujE7j5Zb1Zw/d6UC/Rusd4AG9opAkw1wan6rh3edUY2erlu6Z+MARvAlP+msriY+
         VNHyHaUyJ67DF3dIYar5Z3OK1I8V4YOKIRbu1cxH7wtsN/cUaiKncrtFKhz5J2sqyzIO
         /c5NWHG2ofyOMWj6Odgc7fQEO0H6TFpeFkcAwYR0ThZIHLdgHVZGTLcmSvDlKCM/sXbK
         av0J+6lIwQhoiMiD8sACzpyctoh3NCTSifHvEcgynaNFYkqVUyhRayPIkANvRlmGxGoV
         Lrz3kcm49D42Q257gdK8YTYPh6pTW9r1Ib/RnyjhYNhx2OzlIJDA3a16XdAlRbYD0oNi
         VSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084327; x=1780689127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Je8q/HCAd0aP2wgv5J5zrln6ORTrwi01jkqwR3v8AHc=;
        b=ZfJZLpXVCG9Z3hgqyjnbxxu94yVkAFUyrzP2zOFRbja3INe+u+Zf2tGRApkQJXn2wG
         o075m5g6BNWqdOPseSeJZaJYHkjeBRZQvieMvQJvp2w62GGbFjCsYVMKQrPj0Fdx7b+i
         TOHa167zDelXwSHHSJzQvWUdKn5ek5gxOraI09ijJWMOC64bDMauqpt0ImeVkf16upv8
         VdI4NPXYs0vuZcfQ8ReQkBaPr+adOsDu5CjGzUG7EsABT7mPObzR56OabEoolmnoeSaV
         FjIaUXBXHsD9BomQnOq+wS1ho5IVdJoygfF5zsoAg3QLredar4PxjzOChYqoelkAGaHh
         Lt+A==
X-Forwarded-Encrypted: i=1; AFNElJ8mk+r9eeyCjCaowtwRh8G2dZEboKyM7tuSlKJFiC6/nRWgz3kS2hOO6gFwq9WHkA5RXB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlPWwplc8/9GTm1CZX5vHf+rFD92CS0A2rZpxeDwLZJ2SThWJC
	1D5uPmPBNYv9hlPRCbragxonzdkM5J3PmBsIucdf5KQylFx3VEnwhKRVBzeGReNO0h4=
X-Gm-Gg: Acq92OF3FrV/GKs8okN4Hc7JpHZnQuL25XLQRs4+KtHKeNiwpvfy9m5HcODYRKNPv3S
	BbGiatOS58sJfgV0SqGiltaRh7v6vxMsTxySLl8lLRwsCXOrS3vx7PJJdIXTTEcLBUYJb3uGA4G
	DM3vJw4lzs3gHBHQYLLeyscuMEaAnOoMzaGHHi8cP2AUdpyGm5g/Qo8trZpAelN/C3Ewk6t57+y
	UytfJXODeH0jzKtxK3mgtMBBOtk0D9sE8pYp2Ba5CvJblfjNuvFmSrOME2uUsA6rzIQ4A5308QK
	fY2jzyDTklJQSDJoassA5cvF+tK94EKq9k3wBQex9u2qkOi8tMzmmyGi3UUx0CNj8JdjVfi9Zd2
	Qy6xU6DngRB8NMHtWTfH9AvhxOjRa06knnVjCWlSHGtsuARZj6TnFnf0ERvb7Cynhf6dZ1aYLr6
	ua7nijZg9P920qR57cKx8XV614j0esfz2NIDqXXtma8sMrWuQMsmD+nyRN+I/tJkfB9g==
X-Received: by 2002:adf:f089:0:b0:43d:77c6:be78 with SMTP id ffacd0b85a97d-45ef6ba1425mr1556824f8f.39.1780084326851;
        Fri, 29 May 2026 12:52:06 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34bd896sm5336956f8f.14.2026.05.29.12.52.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 12:52:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	kvm@vger.kernel.org,
	qemu-s390x@nongnu.org,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Song Gao <gaosong@loongson.cn>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anton Johansson <anjo@rev.ng>,
	Claudio Fontana <cfontana@suse.de>,
	Eric Farman <farman@linux.ibm.com>,
	Alexander Graf <agraf@csgraf.de>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	qemu-riscv@nongnu.org,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Reinoud Zandijk <reinoud@netbsd.org>,
	Halil Pasic <pasic@linux.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 17/17] accel: Remove AccelCPUClass and 'accel/accel-cpu-target.h'
Date: Fri, 29 May 2026 21:49:39 +0200
Message-ID: <20260529194940.97143-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
References: <20260529194940.97143-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

AccelCPUClass is now an empty class. We removed all uses of
the TYPE_ACCEL_CPU definition. Remove as dead code, along with
register_accel_target_type().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/accel/accel-cpu-target.h | 31 -------------------------------
 include/accel/accel-cpu.h        | 19 -------------------
 accel/accel-common.c             | 16 ----------------
 3 files changed, 66 deletions(-)
 delete mode 100644 include/accel/accel-cpu-target.h
 delete mode 100644 include/accel/accel-cpu.h

diff --git a/include/accel/accel-cpu-target.h b/include/accel/accel-cpu-target.h
deleted file mode 100644
index 6feb344e29b..00000000000
--- a/include/accel/accel-cpu-target.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * Accelerator interface, specializes CPUClass
- * This header is used only by target-specific code.
- *
- * Copyright 2021 SUSE LLC
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef ACCEL_CPU_TARGET_H
-#define ACCEL_CPU_TARGET_H
-
-/*
- * This header is used to define new accelerator-specific target-specific
- * accelerator cpu subclasses.
- * It uses CPU_RESOLVING_TYPE, so this is clearly target-specific.
- *
- * Do not try to use for any other purpose than the implementation of new
- * subclasses in target/, or the accel implementation itself in accel/
- */
-
-#include "qom/object.h"
-#include "accel/accel-cpu.h"
-#include "cpu.h"
-
-#define TYPE_ACCEL_CPU "accel-" CPU_RESOLVING_TYPE
-#define ACCEL_CPU_NAME(name) (name "-" TYPE_ACCEL_CPU)
-DECLARE_CLASS_CHECKERS(AccelCPUClass, ACCEL_CPU, TYPE_ACCEL_CPU)
-
-#endif /* ACCEL_CPU_H */
diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
deleted file mode 100644
index d7ea45ada2e..00000000000
--- a/include/accel/accel-cpu.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * Accelerator interface, specializes CPUClass
- *
- * Copyright 2021 SUSE LLC
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef ACCEL_CPU_H
-#define ACCEL_CPU_H
-
-#include "qom/object.h"
-#include "hw/core/cpu.h"
-
-typedef struct AccelCPUClass {
-    ObjectClass parent_class;
-} AccelCPUClass;
-
-#endif /* ACCEL_CPU_H */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index d8ee6d62667..4fe15349012 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -11,7 +11,6 @@
 #include "qemu/accel.h"
 #include "qemu/target-info.h"
 #include "accel/accel-ops.h"
-#include "accel/accel-cpu.h"
 #include "accel/accel-cpu-ops.h"
 #include "accel-internal.h"
 
@@ -98,18 +97,3 @@ static const TypeInfo accel_types[] = {
 };
 
 DEFINE_TYPES(accel_types)
-
-static void register_accel_target_type(void)
-{
-    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
-    const TypeInfo accel_cpu_type = {
-        .name = name,
-        .parent = TYPE_OBJECT,
-        .abstract = true,
-        .class_size = sizeof(AccelCPUClass),
-    };
-
-    type_register_static(&accel_cpu_type);
-}
-
-type_init(register_accel_target_type);
-- 
2.53.0

