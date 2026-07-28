Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4088472F6E
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266802; cv=none; b=t6X2isF6sCx/sEghcTeZCNhAYNA6jOUUmLOb/CNwHVQLJod6NaPT4GqDSD6X7dT3wzbkeKR8OfFmiCNE1PnBxU9o/z7ioZ0Am7pDrL79j+hYta+H255rr2BaWtdM5m+8OGAETc3by/DgsxSGTbowIleLU2/yPiQ/A6ODubn8M9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266802; c=relaxed/simple;
	bh=FtK10M5nzmfWllzpkljxJ3lJXejxqJ/DTecpU2waPSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCnialIV7OtOslk1nwLeLqgtMlumDk34WFNrb/b4nQZa7lbpOJX+lmV0rRRTgj/MYY8dybH2EEowMpF2Q+TUbFaPi0RpAqSEnAxJ86Lp/Z4AtKwMSRTlbCQroAI5i90A2h/uaIeSUGoEUqA++w4S9aKQSWj8/MlUJyH0j30B+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AgoMwE9A; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AgoMwE9A"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-381b831d535so268520a91.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266800; x=1785871600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+snw93O5L4IikZGAmaWl2HAz0eSkR4e2CEsA4s4dMC8=;
        b=AgoMwE9AtnTcqjUBVtV2DIa0TqT9lkHcaqPTiEDM8b872YHPKlm+6HOwVZmThL7nIQ
         jQ3hgT7J/O9NZVNoRh0Nh2XxlITgSAxKm6XGEeFhiJ96AsVJhj8R6DI/AcCdh2tqFiDL
         or1KlkvmUzJtviPe5GIYn/aSP3bWhNKgk8FPxeSWzUgogxRtMEhmZK76x1VfYUBnjXRJ
         yimwDXkNjp0j36LvMBsEZSuHLNMJMAY+JCS19KrBsigMcf/tp40yPkh7Ko/sz8bFY8mu
         g0lvbNKeHyhL1eaUEyZyqTEGExHa4SUSCh22UbbeyqUVBHYDEs/Afd9Gf1a6QGdiP8BV
         j74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266800; x=1785871600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+snw93O5L4IikZGAmaWl2HAz0eSkR4e2CEsA4s4dMC8=;
        b=qfK0o2W6nQ7vJF7lvpyJDVJn1hbzlndbk0SSCXDFtYPsEYvyCI4KgcOxdO5fAoqgCF
         NthT/X3YtZLOzg7satujnz4S9Xll1Rz2ZJCw7MUwDFD30Ls11IIjb6ilPy0qSQHWmXoC
         p+a+654DJJJxV8S0RLiuelJAeZNDDu0WSTxP+qUW3uWcDp0MK5LnfBzMaDHv3U0fPZRi
         N3VduWIGL58DEQr2aU/nLJUCCeTSjfKkrtFsx7LAmUeN5iugQ2YLqx8/IvQHZozFN3Yy
         YYvARwZ0+/tG5x1N+7UbwfFViMsndAbZdPIGwQq9bU1NZHKD13+ZmvwSzt5pvuSK72Pb
         bgOw==
X-Forwarded-Encrypted: i=1; AHgh+Ro3/iBhBuGlb5znTclsz7TXIsVlV6no+KUNh5nsrDpxyd/NenXKfuhIFeCOJ1xkkizjHBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkw5c0WU8wIdfTIicckpu/7mhkx6hpRx0EH2h6meCXUueGO973
	1vENQHdCUJJGSx2op10UKmozJkg+7WeEz/D/vEkoywPox+WiLJ0WgVhGVU6VybrHgck=
X-Gm-Gg: AR+sD11dcWFH4E4h5OlbP42XPgT9vNEvH/vI6wFw00j/EriaQm3KS3Q+8bRdg3ykFWY
	DJii9vL6KxC8twhkxXWvLUAftnZD3iWmR/4KdTq2W4Ny2q9hqpTqmm7iHVIUeZUrtYByL1gK8lF
	RWzPJCaRzry7RzKi20Wm6GuNfatLKCc0aXBVqCCA2OoYVYUq/TzPlQSm+0A2b98GH0zIAaKgdPU
	TecNmOQPuAQ6D8S5ovxl22oJuoZWHTnNO/fbbfiJHAK1WIBqrOgzttd/hASspA3dwNh6fwf3mey
	s/zkPj757ZSrcVXQ9U7obG+NoftoCMHvxhzlXH06PvCEclpA01pKg8Fpsem8HoEh9nBSSGUKaXN
	z1pGIHKNAwTaIb0gjj4S6bzSGYGMRv7IbXrEgSbx7L+kMHZv21BlPs4ENZS2M/Pl3oiFJSms8vy
	QkIFyTo63NPXS9ejOlilR/OFxR26UZQfovmdiaAHo=
X-Received: by 2002:a17:90b:582e:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-38f6a3d55f4mr3991157a91.1.1785266799926;
        Tue, 28 Jul 2026 12:26:39 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:26:39 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 03/24] target/arm: Add confidential guest support
Date: Tue, 28 Jul 2026 13:26:09 -0600
Message-ID: <20260728192630.240375-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
support the Arm Realm Management Extension (RME). It is instantiated by
passing on the command-line:

  -M virt,confidential-guest-support=<id>
  -object rme-guest,id=<id>

This is only the skeleton. Support will be added in following patches.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 docs/system/confidential-guest-support.rst |  1 +
 qapi/qom.json                              |  1 +
 target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
 target/arm/meson.build                     |  5 ++-
 4 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 target/arm/kvm-rme.c

diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
index 562a7c3c2852..abb56923ad13 100644
--- a/docs/system/confidential-guest-support.rst
+++ b/docs/system/confidential-guest-support.rst
@@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
 * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
 * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
 * AWS Nitro Enclaves (see :doc:`nitro`)
+* Arm Realm Management Extension (RME)
 
 Other mechanisms may be supported in future.
diff --git a/qapi/qom.json b/qapi/qom.json
index c55776af7d35..68de12c37c01 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1302,6 +1302,7 @@
     { 'name': 'pr-manager-helper',
       'if': 'CONFIG_LINUX' },
     'qtest',
+    'rme-guest',
     'rng-builtin',
     'rng-egd',
     { 'name': 'rng-random',
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
new file mode 100644
index 000000000000..42e1d1e7b859
--- /dev/null
+++ b/target/arm/kvm-rme.c
@@ -0,0 +1,42 @@
+/*
+ * QEMU Arm RME support
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright Linaro 2026
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/core/boards.h"
+#include "hw/core/cpu.h"
+#include "kvm_arm.h"
+#include "migration/blocker.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "system/confidential-guest-support.h"
+#include "system/kvm.h"
+#include "system/runstate.h"
+
+#define TYPE_RME_GUEST "rme-guest"
+OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
+
+struct RmeGuest {
+    ConfidentialGuestSupport parent_obj;
+};
+
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
+                                          CONFIDENTIAL_GUEST_SUPPORT,
+                                          { TYPE_USER_CREATABLE }, { })
+
+static void rme_guest_class_init(ObjectClass *oc, const void *data)
+{
+}
+
+static void rme_guest_init(Object *obj)
+{
+}
+
+static void rme_guest_finalize(Object *obj)
+{
+}
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 4412fde065f2..aff52a3f6eeb 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -31,7 +31,10 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_common_system_ss.add(files(
   'arm-qmp-cmds.c',
 ))
-arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
+arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
+  'hyp_gdbstub.c',
+  'kvm.c',
+  'kvm-rme.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss.add(files('cpu.c'))
-- 
2.43.0

