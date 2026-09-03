Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FABC50C2A6
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464187; cv=none; b=r13/XbDeJ6Bcjqdw+6B4xxLEv+h89/KDrKy++ZY50pZ6lSRcs42+dHKFAvsodci+7vJjPyQxrLJjvYI7OYU/NWXcFQKbtpDRm4dyyFFHUswXZSkfe7AgEibiN43zZYpUtzvD8CaRtixLa0xinGk+vJaCFvqvKEOlVjfv8MWvw6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464187; c=relaxed/simple;
	bh=6mSUswM3qTyWI5+JIYh/DIvhlDeClbTRtkFDWcQqDQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZL4D83n8tI/SJMflGOqC1MUxE/FYKtdtfZgp9m6vx0/nawSsZ0jtaZEQvWAr6yWStb1UdVOlbzotoexPh8HvmgSpbIHgv3kd8pJ7RCodD3svc5R38rInDTxVzjSvmr91Nw74hWaBIMW1DYnH1qu5KIDuqK0v5eIL9q3mRCP6JG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WzciQrDT; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WzciQrDT"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38511175ad3so161021a91.2
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464179; x=1789068979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5FLJuLA46SDmJixQDc3xXINwsQvKq769fvjo0KX4+Uw=;
        b=WzciQrDTsxxzX9qWeO7GW7l0TvDcZxgTqZ2kTfhdR/fdRNE3JYSWNjlM39EbbiQNEU
         vnu1/YUFgpvDMLnDeTwsGEoUD3nPAWSY33qtowJJy5NeUtcFrenjDXtbnAohsif5YOQZ
         7Fp5s3rHhKwXaT+HVrSSWvOy+Ghp7yySv4cTDXOdpZqQhLV8jh4AG8idbSY+mN83FwSw
         Ht0YOd9XpMHbsylf/v0m7NgWmuEdjN2Vrb6qziRFRvpxMy0bz24+TA5FbC3vvonl2FyF
         ZS9K6clGh2G8wzVqbDOyWOvKIwPxUA2tnKPCgIRGuWiHqiwIEKCxUoolLgdimq6cbhXS
         8Mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464179; x=1789068979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5FLJuLA46SDmJixQDc3xXINwsQvKq769fvjo0KX4+Uw=;
        b=HmZy8AsMDExXwAk7EKzj1RY6ui/FRxII3rEGd7wEg9nR/cVfsGWzH4tdqlGr10qWgQ
         L541o9j5F1zLSACt+IZ7MuPkcNahGjyepaBVHyufeUWL51YguN1QLJMu7LC6T9pOYQvc
         L8nWunIbg6CbvGrDUsD7F77C6QSsXr0Oy584Y9mk4heohL3XXLy0Satq58JmNo8bpTr+
         H2XbBflwS4bk6YuDpBJ6oJ3ECxybLKYne8UtMws6SGoyMKugXbZjaVcmuzUJGnpufK6L
         ptHLc4WbxIBjR2hDe54ZF7QHDzLyskwmePic8hIaJiOOlj9a2tOhshk107IDnM5P06iY
         Nl6g==
X-Forwarded-Encrypted: i=1; AKwUvByXUFPVeEaWkVM/zc7DjwDsOrSF8jBRfGeX5Iht7rQcQYEOnIkXvjLEbEPTM9+reO95y7c=@vger.kernel.org
X-Gm-Message-State: AFuF++kIMFo9cIAMZg5rNLkIwMd9GoenRijctcjLZUb3LtZ9LWsOCLwS
	REpg16fAY9XGo265L5KdcesflddYIRKCxK5/TqxJSOdDXdv2SJTh6NphMKTtd7xGn98=
X-Gm-Gg: AYBFou2R4I0pl01tDBhfmtDwNh0u6k3rpBr46nOLi9BDlMn6GKIVuFr8idPfzbdIifO
	lnvTJNymAPhwViT2XgL5+rrj9XACqZ2MHhX6h0pxu46GPjbrDkWP4dAKH7FPCQnPS/KI7GYHMeD
	o7kdKB1dw7y6v70Y/bIL7lvsXgSAOy4LrB6UuLBDgxMFM1tCafKJoLPC+a3Zc65+MpM+J7E3EZV
	iCrXlaJOGJSSr+qJ957zh+68IUxunt0njGeouug3tduvzOJeYy5YBE8XXyIUuwEhOyoF6rY1BKU
	nbmQosqUpFbpkNIC13HcaI1incTwRkwyFRdnH5JvYsmc6Q7O+6Dq4iGAa3mXO9I4p2lthbnHJKA
	If4gQRYqbVyl2jWKx3XZt/xYcbdgIMaMnW9uvK56jX0s8Tak4Uhb7v3VZ7fnxVaEfklrB9KJMK6
	LBZq6C4fdbzXuoDM0ZMBmTtBhzYLXEOAO1JkbRcGke/VJ0z+slsy8VZbnpPGI7WEd/zK7xI5poc
	0/5TlsSd69biPCQdWn9iVSsMRA=
X-Received: by 2002:a17:90b:4ad1:b0:396:635a:9b10 with SMTP id 98e67ed59e1d1-39b2616ef8amr1085128a91.11.1788464178684;
        Thu, 03 Sep 2026 12:36:18 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:18 -0700 (PDT)
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
Subject: [RFC v4 03/24] target/arm: Add confidential guest support
Date: Thu,  3 Sep 2026 13:35:50 -0600
Message-ID: <20260903193611.1058589-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
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
index 776b13027fd8..52997c29a32d 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1288,6 +1288,17 @@
   'data': { '*pretty': 'bool',
             '*close-action': 'MonitorQMPCloseAction' } }
 
+##
+# @RmeGuestProperties:
+#
+# Properties for rme-guest objects.
+#
+# Since: 11.1
+##
+{ 'struct': 'RmeGuestProperties',
+  'base': 'ConfidentialGuestSupportProperties',
+  'data': {} }
+
 ##
 # @ObjectType:
 #
@@ -1346,6 +1357,7 @@
     { 'name': 'pr-manager-helper',
       'if': 'CONFIG_LINUX' },
     'qtest',
+    'rme-guest',
     'rng-builtin',
     'rng-egd',
     { 'name': 'rng-random',
@@ -1427,6 +1439,7 @@
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

