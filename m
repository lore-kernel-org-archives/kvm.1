Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF403D567E
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464197; cv=none; b=S8XlExKaIiWctct/myGLWGh8Qu64UIxcKSDt2QHkxYtQkXu9xpPc0mWbMANCQaH5OZUIUZhh8Uok1d1u5H37tYGW4Lc4OCQn/BL6hGJGRh+037xcwl9PdNScJARiq8cAOTx8tDrWb6NMc2kFV4Of1NdH3gQA6ngNbIxPj1D++Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464197; c=relaxed/simple;
	bh=orGNoIfXNDc6htpChHMXe/alTEwc4Ok6XlE8l3qFEcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5oZnz2TGT1FJAHPO99HL6wY6+sIrJ0eZWzhH+HfLmkMK7swt5O5egXyGSYRWTPW/kWahXdWZyGsBlM/qefKh4HEQnGQEKvTskNB671sv2dz25yf+jpacJzOj9Vjg8a6qZuOKfxvxLb1Sdhf5MlDWPlNsCdGdxK3Z9E+PSPOm9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ihYXFkH5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ihYXFkH5"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c9b1edf2bdso1108215ad.1
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464196; x=1784068996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/EtuxP6qUgKAfe4TZdc89W+i3osoTftywciSv3aaq0s=;
        b=ihYXFkH5fJilPaLVwrg7RGD78PNLpuUw9RKQwHFvolp8n/eyrDgvPERkEIFgPC8Eg+
         uRDqRGOdnpWXaeJgZAzeUWRCEb76uzBhjX2a6zx9Wzp2QCB/pW1ZBdV01zK6dIfj+0tJ
         Ra1fwrTfFcO3ImC4t4nywzVVgeMxojKd9Eb5zdnYJuFYfy1sO9/YSRU9OU1WbfH6bug1
         aYwo6uip2M4w3qWayVYhyDl+2GEeRPA7HB02b6gCEy03KvVpLB0az9t6LY9SYRAgiymo
         RusUF4fYemzGJ4tC5hKiaqaXUuDx+jvfEWM23/MeJXuk4E6TU+1z3UfeuUZhMmF3Ov/+
         CWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464196; x=1784068996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/EtuxP6qUgKAfe4TZdc89W+i3osoTftywciSv3aaq0s=;
        b=dS36xrgVl+1n8UzNyKVSv1mu1BF9PRRqtQsH8S6wmNXzeKVHWnhZCOSDe6GUrzoYFp
         ksK3nO35gP9lDi06G43V5+txITKGt/QUvQIeDzUoauEHa35n+ijx0NvXiaia9mLvU4Uk
         a/qTHrZqlQEj+epvfYa2aD3QjyyoP8jwMVJMSPo/81Z00DqQ9s6J10cOmyUNWhpQ9XTc
         /Ge5QLxGHr53rfWR0LnvGCvwDy41vTtA90pRg+B44bIWbyuxpOyxIr+TvlGBmp905ALj
         s3wyAfkWStXaVUHdm7YL2aE0Zn9gokxwRhFPq+Rc1lEJUeEeeMf8PJbvINpO16J455Ji
         bGSg==
X-Forwarded-Encrypted: i=1; AHgh+RrTs8dyzOtzTSAoGawahsEFrZhYat5OI49APtFw8DZht4bdDo7xsYpiGf27Yk7rY8val8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/OnV3GUhXIA7TGZlU7XgAMmNYYGRVsvPFoIIpgPhFDvBuHQI
	s9EvAXDZKHmKZBSNuXNoko9RjLIjcXHganYa813VjZshLoU36xM1Tp+hTT5hOpFAMwQ=
X-Gm-Gg: AfdE7ckURIjNLHvfEwQcAxSfH2Wo6ZqgSr9sGx7KkwOru8dLoa/n7iDDVPml+NM7mLM
	F2OWgETKDVgHQxED0YDNRwzFy00PnDHvXWkgRwJk6/4mLQPTI+6AwDA+ArOjZ5pSOd5PRIml8+a
	/gezml6mjfBd9EkSX4OZh1b5NCx7fyPm/6euY3gmfri2DoUyTGgcLbDuzhn8+DDta1OEAxkyNAr
	5QHfj3srTgMNpER4waZwvA7EzT78GvWFiVOfpmcXrmrOCjgXrTz96SD0aWLD7dVjjzuORbCvJxo
	8UMr7js19JnATjS7oMGO5pSxo9gaQrT6ZTweZkoPDTT4T0+A5uTOVMlbkw4fo0QkbNetXVMv1L4
	5piNY8GO3dptf/aPn6c8IVThMcwbH9/Aa5khAy6MnOdUzmVwWPxENN0m3zdKLcy3e1QEMirAjb/
	haxuk3W7UHquJqXPXiHjd9gsE95XabvN3gA7lhDG4=
X-Received: by 2002:a17:903:384c:b0:2cc:90aa:8787 with SMTP id d9443c01a7336-2ccbe724a21mr71744795ad.6.1783464195895;
        Tue, 07 Jul 2026 15:43:15 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:15 -0700 (PDT)
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
	jpb@kernel.org,
	lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 03/25] target/arm: Add confidential guest support
Date: Tue,  7 Jul 2026 16:42:44 -0600
Message-ID: <20260707224306.1202330-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
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
  -object rme-guest,id=<id>[,options...]

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
index dd45ac1087c3..285d32c2cce3 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1241,6 +1241,7 @@
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

