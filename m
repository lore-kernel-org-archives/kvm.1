Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9951A9FA0
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064817; cv=none; b=dKXgsDctrK9vKvPEQLijVQwGyGTA5VUBEysb2EHMyjXnxA1D8p8/KO/+I+3DtIV8aRmdbQuDD4EuQh8KeNmU/qxirgGiKKNwh2LojgMRYOYQ3jR1aXnhlMLVGlZ/OzaF/bazD8fMVI79PmN34doVz6uEh+NTvmHGIjqcQnzuiPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064817; c=relaxed/simple;
	bh=+lr99Vpr9LnwQxmrH2mQDduESQshdCF4stU5pl627Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0lqw77OotQG++c22bdeEMyHZ70sxZLIb1CBKtx4RZm7N3DHSyD+In/gwW1s+jaFOXC0ynAySw8e2du19lkJDgTsEosZVDGeA8YXz4sq6yPvaygCMv2lMt/p9smUx4QaF3Kc0KRX3Mj6thtGRtSFxLeq6R38vWY872++Hn0DdXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=COq+fk7m; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="COq+fk7m"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49041e84237so64283505e9.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780064814; x=1780669614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIu8PCygzL9wHkP8hkt7uxJi7hvxrUL4lU7Ro6etspM=;
        b=COq+fk7mr6ZLA2nLt5Skc4hs4rwy9ngBhWdVjNBogScgl3hQ3gL7GFwelAt9dVxZ0D
         Qg3KX4XUMEVDussFCgX3U0iV0ceYwHXLAWBlVaby/1gtDS8XH4uS/0zlelrHJLnSX1sl
         ULpo79Ia6KlMfsOGTQI39ZXqVqblsZCAvUfpWYP7SR2wdLMur/zmfTDKOwZfWYsFfTs6
         Mu9eAH8ZdYD4ua9YOFr4Z13WOyKOeoTKENopeN/haOrcz2t5nw7PT9pQwjEQ8m7R9E8p
         tSyolrF1yU3nY1C8QJHpYca96mkR2F5XqsXpzMseQv6DOHnqf3wcPgBA3maA6j6r7Wj8
         DBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064814; x=1780669614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JIu8PCygzL9wHkP8hkt7uxJi7hvxrUL4lU7Ro6etspM=;
        b=cM+p4QGcZPTdKYAlsJVBw8y3gnX4dlofBWKJ3ZMI89l0xl9xnBnhF5iPYzUviCKrzl
         pm7wVsfvgZff2/bWokKWrpoP7I7LFLXJKpDkxJ7q78wItgtgye1Dxm/M2eUiRL2FZKwL
         wqtDDYB2DUVYMMOegB9SE8RkDoFywFx+aN+bb2kplZeTQLnNMxWRAGuEVQ73+KGRsp/K
         AuE9aOFzb/6CXSPVhvhbjVcv7iiNRzynf4PdkAC4miUks57BdQWma/ClZGpOPCr5XpRP
         0mDzmJhMPw3aS9+aik8FZ6sKVnzqT4kP8/tGYzCBuzInXwcoc4ci9atsoIv2qDDsPhNH
         YuOA==
X-Forwarded-Encrypted: i=1; AFNElJ+sxOWdNeqvKfRmr/rIbtIkN13v7bDNUIB3BmvbavIPxh68fybFXnN5dz27wtVKsOS205c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNxJ4UBNdIEV0gcDbhMpR8NL+udLLQWFWPkokPzdAx5eCpSR/W
	bIFf3qZksDqyzgkvJcL0H6BetC7mXquosIZdKLZLaCScXX5RhUXt+/GYyLHc9Qdn+SA=
X-Gm-Gg: Acq92OGbngHcIR5swz/X0scea8DJoNDJMFeLMwxwvU46d4NnDOKqBBY/qgX6FFQxlKt
	Gq9E2JQxLYiCeqR0B2E7gPzrVQFgn+unNQ5hB3042ls5YAgdfKqtKzBzHCul74W9JF8SUmJ6u2g
	hli02u5k4ElnbEsMgRloWtuusS6OIhIp7Ppd1e34aFxrn6oUJZpebHzyAnNuBLMS/9+nV7UiWaf
	08yhBrNZfIcNB12/u/qdne4MFpQmoQjxovKMSj8adWmmJxZJall5V8jNKjFVfGpRF81V9Y+9Hek
	nuYFm9L/0ni3qygdQAv606Ko9FW6ApFIUeingJkAkLW0HXDsN5Wih8FZe58VX2ICAH9I/rkvETX
	30cIewrsQkyc0ro7S+jctvE9cu9s1riil/jhW8jq3c+IzSvDuEFN1bQW2qM3I/cYmbuTcgkeKlz
	WuaDFX7+e0y1e4RuH3gudlrbTRcsnipzsXHjr0u9UTcrTsMOysA71F93TqRtBjxuhZk+GTVlnE4
	Vx/
X-Received: by 2002:a05:600c:a30f:b0:490:4b89:5372 with SMTP id 5b1f17b1804b1-4909c62603cmr36489245e9.11.1780064814109;
        Fri, 29 May 2026 07:26:54 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6a0e42sm43781075e9.8.2026.05.29.07.26.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 07:26:53 -0700 (PDT)
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
Subject: [PATCH 17/17] accel: Remove AccelCPUClass and 'accel/accel-cpu-target.h'
Date: Fri, 29 May 2026 16:24:33 +0200
Message-ID: <20260529142434.87880-18-philmd@linaro.org>
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

AccelCPUClass is now an empty class. We removed all uses of
the TYPE_ACCEL_CPU definition. Remove as dead code, along with
register_accel_target_type().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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

