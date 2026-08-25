Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DD037F33F
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695272; cv=none; b=FBO8DlzT0zhZZ6czS+mw5Yo834wstiabOMV7M88qmhYSVyoQvjHnaqWCz9Ijf1DrZVbcnXp0iU0EmjiXLYYlj3+kQdbUU/lAaMyR8p0Qmqmn+d2x8ylQ7q7OGDoFShvrf7cRy4QMdDP/kR/HaIz//TlU9a4rXp2IGaqFG1dCwGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695272; c=relaxed/simple;
	bh=NznjDrgSr2sKkZnG39sbRF4FepyHxRzrAQgptczbweA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/aFB/LKTVv87zogDSgyUjDhzfARn+9CnZSugoPkxki6GLw7UZfeB3ijj/qYYX6sWVT1QGwgdRoCNWBtO+BKCuzEpLkPfbMKr3UX5joDTyKR19/UIiiVZKnFJBaj0tKs8p+8hwzOmwwuYhI5ouonfLj6egLIUZcKMP8uqQbEbG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RDMX7xwK; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RDMX7xwK"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so418847a91.2
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695271; x=1788300071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uun+UuCnOruy+78T99P3n2q7fn+cAO6lGcRn4VnJwcI=;
        b=RDMX7xwKmwyL4Yv6qkYOFXJDA/v/i1wF6UMWTg98P/6369Dz344fwmw1H8gcVkKdl7
         WuoXaT1QehLfK/mFXjXq92qzp2K9LF0vTE7Yz6hpmIlLd9WUjrJbZbj3deDZ2y79/Ghf
         41kzm++D4mwixqGBa/P7KhfI+2UjLnqAh52+I8qqLU5IgxR9jk8gAKMYg/4YkBuVR3Re
         vz/J0fENR5hROsJ6KUKsOhFT+9IIGOO96YRw/M+U0vVMkYu/3osBgI1LbcY5WeMvnJQV
         SwiVTyb/p+CEsMDneeTVaYPafHFpSmJGoZK8Vq+t7ezKXWSp3OcuuOozWVTiI4C93GXF
         2JiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695271; x=1788300071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uun+UuCnOruy+78T99P3n2q7fn+cAO6lGcRn4VnJwcI=;
        b=K8c456lShM3AtIcgo4N7OJzGBfx2KyAY/ug0+bg+XPDLFs2faaZ8sBUY6P+aMoxB5Y
         lEbTtdhAmCeYY0aPIHe5DFqXeRQbRHRGaOsP9uLzpm6zU28E1vi+G6cYgXUVVp+vplCj
         yTD6tMlRFRdThSGgwGiKhWU3LWCpHs5C7T5QXJ4KodszUFkFJ0I3NyPbIVEU2y1NMqSm
         mDPBQb8usrTWXBgbEX8dBiNkryxBVSMCrXZDxg//3n7H+eyC9Kn0pkjNtXl8kbsFqYBe
         W+7mizRKK1bbb59dcC8CCDaE4dZWWFZIDfrnnCQDwpkqIDySlGD7etX4qCAMqs/s3vvT
         aGiQ==
X-Forwarded-Encrypted: i=1; AHgh+RovWcgePWpVU8WdJh0iYg5Cl0PxzW0smKwXSVUdy/2+597OwOtz+35gxGWVM3b6MzEo6gw=@vger.kernel.org
X-Gm-Message-State: AFuF++ki3EfBy0ZCN71ke30Obw/KMVJuB/oABmp8udkpIxe/kE5yMkAP
	f9D2mazoLnnOKYKK2/y+srzcp/woqxd5VXkMwbGxRxH4QOp6DO7tGA8VUEJx9I8tEZM=
X-Gm-Gg: AR+sD10diSbpH9O4o+6aDBNltp+zyKH/AaFMmBcRT4dSQspceekGNgE/jjlhNz/TaR8
	bOoFhpqGdUC2d6oyenHU7Rxi4WG9EzmFG7VmlFDIYaT/VvR/K6rRDvdHoK8wSCnJZWXMBfpA+5f
	Lba/qtTVZRGN5NQfsAT0Hmie4VWmVkoxHO1TiLifgt/4rsdOf88crybrAYANu/N6hXK7tQutbcm
	fzcucG84uiU9TFxK9HAKPkW7H7n3nALfEw/jL64qev7azLl92menKLI5yKvAiQUMTFWhuB90eMN
	bXCuLeL3jqGAO6uUbIzfpK1nlF0wqXIEJdMuf7W4sMr5l6Pwc1bRX3CKmP60ClsZP7TzKV9VfHJ
	GhHUd0z3ZwOqJIvN1MFQpDzhMky7bFFYkv4rfjVoNdR13hOUg5IfKwsyOjXtUfYMvI57Hw1m+hm
	nwfxN1B95LdfJmHFiYtsEt6RXsPxezp9OS9ULNqSUpR3AgNp5JHrdyu+REi9W+P/3pBAi/mN5A3
	8zxzVStdwDRBIzF
X-Received: by 2002:a17:90b:380b:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-3966d13a242mr4229936a91.1.1787695270354;
        Tue, 25 Aug 2026 15:01:10 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:09 -0700 (PDT)
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
	gshan@redhat.com,
	enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	mathieu.poirier@linaro.org
Subject: [RFC v3 03/24] target/arm: Add confidential guest support
Date: Tue, 25 Aug 2026 16:00:40 -0600
Message-ID: <20260825220101.3443954-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
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
index 037c07879986..edc902c88c36 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1216,6 +1216,17 @@
   'data': { '*cpu-affinity': ['uint16'],
             '*node-affinity': ['uint16'] } }
 
+##
+# @RmeGuestProperties:
+#
+# Properties for rme-guest objects.
+#
+# Since: 11.0
+##
+{ 'struct': 'RmeGuestProperties',
+  'base': 'ConfidentialGuestSupportProperties',
+  'data': {} }
+
 ##
 # @ObjectType:
 #
@@ -1272,6 +1283,7 @@
     { 'name': 'pr-manager-helper',
       'if': 'CONFIG_LINUX' },
     'qtest',
+    'rme-guest',
     'rng-builtin',
     'rng-egd',
     { 'name': 'rng-random',
@@ -1351,6 +1363,7 @@
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
index 4723f9f170ad..544df5c84d79 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -20,7 +20,10 @@ arm_common_ss.add(files(
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

