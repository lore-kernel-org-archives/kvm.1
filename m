Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B4A51812E
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972434; cv=none; b=qr2XhFXQB8pRZSZvQOl0VTwHnsQWmG7kJiwh2iqTpBL4tq1+xv7aPwuhgyqijArunSyq8OfRbdNcvsSUC42Zk6VeS06vuRgazCPLqOjnq33M9MpUidNBWHb/lJX9i8ADVaa4UpD3+WESEiP+aZyv75FunAlEMFeYOKlwaDwb9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972434; c=relaxed/simple;
	bh=3kMMbTrZwlHEnR8wUmQyI1QemVW0Y4eLncus4OTsheg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDEpdgsA3ym+THOR45HA+UYz1XE9zHKwmcfBTk51ndM+Thhrr6r99VU1KoA9XDRdfp8QlK8uYRnbutbFUEECvCuHMihFLy7hNncfOulcAjvj/c+8Eb7L4lz+n/wcFirrE81ueVFtZKzupPG1PnrHESzZIazC1PPC5XUkOGM0RR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SW5PKW55; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SW5PKW55"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e2e064b932so4255ad.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972432; x=1791577232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bm2R9pn3B+qOLBch30fsk6rbf6WKwHzxx8w/KoQ0W+A=;
        b=SW5PKW55KHJk731sLGvA6k6fyhEC2IumPJxIZqUud7rldtqhtmi7VVaSD0rJKY3lIJ
         16IC7R4w3hHBIqlChumWCqaNNSWozecQf3M9WWD6zzNeSQP1Tm0wnas3pmOfRCiHsdn0
         81JV6BrA6FAH5O8VxUdjSRiuMmpDai5/zSmvJB6BSMyrrBQ5kdgJBq+asaKCBCJzre0J
         D77hsYJ8TAb1SlXQmmd3+8tGck/RkrIDajQz7ZdIJocnEVEw3f7u8QF56GRWalFsImSk
         dxuLEa9frpD9eVElaVIIzyV/mJKjTmLkiLwczGhNH7MYSKSgfyFOUR0fMP1KWHlkf9qX
         4ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972432; x=1791577232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bm2R9pn3B+qOLBch30fsk6rbf6WKwHzxx8w/KoQ0W+A=;
        b=xpZqSDzhbjosa8qLBV+MDMcnAKsRrtVuHXs9BjIlC9qv83lZXrOQSBMn2SfBqrvt5L
         MJ428t5Bti1Vhacs00HKxj5MBneqIM+uvtDIAow+/EnvYupTBDxUklijGJuqz3K3PU/y
         vKbBE4sJRRMgzVgOmfmU0S3M47YZpUZtAEDxII6FtzvWDxSBhmLXECggHn42FeEcBvUo
         oZ1mY5aR8lY+wRVT23mzb8wKNsa8UpXC9vxSHMq0CV1V+xvdgUFTHG+a8ARDnGuIQ61C
         XqhGJaBxd880456WLfx2bt18fdFFw62ksvbpWxYQubCtN+aS+p29myCTrBvK090klJHi
         oXiQ==
X-Forwarded-Encrypted: i=1; AKwUvByj2ooUx1J6NGALE3MiofHcy86FTAr1zNw0V0cnRloCUmfuQDhmCw9AwmOTBCYLv0+KyCI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqd3x5V5E36+zebV43qtkQ1r5wfWMkRwyq+8vVbVfh5/CKFTJP
	oZYxEtUeBPRlF3MMpk6DbR7VtSg/cuh3CeTreXTwd9ale7IlsRlnhLfCV3vY15RCGsk=
X-Gm-Gg: AYBFou3jc6UjuvUQ3BFqHPcGxLoXq6tFoCJE8aaw0RsvkYCbHrSbreTk6e4he9Q+xH7
	AOROuE5gWz9mtiCNEWWBZ9iKSXWzCVgVRX8ECa0ZcgCHETXGM5xRGE8SEwbRdO3JTRtyZISjXEH
	yruclIKkg1rfRjR2r+mT2Bi4r/hPiQse3+IyG1LW7A0ewlNgE3f6n2IIotWOUXucVBwCLC25MEc
	yDVZizf5o8L7v/ndvr2/p3haqQXoc+fVH/NOsQ+zF+JzJxsAVVOMBihppw8I0wfsPI022f3zQsu
	lrLcHiA+hh50x3byzA/QRmVxYZFP65nf4slA1PMKPTveWhbgh0PrEaf73DUwX2l7ofty4l0JnuS
	FhXwTemHwI3txWuZtxEHfX/xWvEg8Xl2HieGFLFXIxtK3Rd02V5yAtOmGO1Hn70o/Tg5gkGci/I
	OxXthHAMLxyUbN2orjkRXY+TNrDQXAUKEDsywfKH1UojxkRQXtZkMwaJ0vo7L/gfeTI5PA2DXIf
	F7vTo7Mkyaz5n0F6xBtN4XR
X-Received: by 2002:a17:902:f541:b0:2df:89d3:1b6c with SMTP id d9443c01a7336-2e4e9c28c59mr5729955ad.5.1790972432088;
        Fri, 02 Oct 2026 13:20:32 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:31 -0700 (PDT)
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
	enju.kohei@fujitsu.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 02/22] target/arm: Add confidential guest support
Date: Fri,  2 Oct 2026 14:20:06 -0600
Message-ID: <20261002202026.1204110-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
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
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 docs/system/confidential-guest-support.rst |  1 +
 qapi/qom.json                              | 13 +++++++
 target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
 target/arm/meson.build                     |  5 ++-
 4 files changed, 60 insertions(+), 1 deletion(-)
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
index 54495d4fb6f1..5f04264d02fc 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1289,6 +1289,17 @@
   'data': { '*pretty': 'bool',
             '*close-action': 'MonitorQMPCloseAction' } }
 
+##
+# @RmeGuestProperties:
+#
+# Properties for rme-guest objects.
+#
+# Since: 11.2
+##
+{ 'struct': 'RmeGuestProperties',
+  'base': 'ConfidentialGuestSupportProperties',
+  'data': {} }
+
 ##
 # @ObjectType:
 #
@@ -1345,6 +1356,7 @@
     { 'name': 'pr-manager-helper',
       'if': 'CONFIG_LINUX' },
     'qtest',
+    'rme-guest',
     'rng-builtin',
     'rng-egd',
     { 'name': 'rng-random',
@@ -1424,6 +1436,7 @@
       'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
                                       'if': 'CONFIG_LINUX' },
       'qtest':                      'QtestProperties',
+      'rme-guest':                  'RmeGuestProperties',
       'rng-builtin':                'RngProperties',
       'rng-egd':                    'RngEgdProperties',
       'rng-random':                 { 'type': 'RngRandomProperties',
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
index 0369f96b4cc6..9d322a7aad28 100644
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

