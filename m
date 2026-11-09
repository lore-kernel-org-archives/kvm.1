Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263478;
	b=dRuAZ7qAYmz0s0FR/Cujb/4kX1B2mpH1S1K2fhTXwWMBYNJrKK8NnNtp/ZFh0C6dpvAb
	 45LagxE/RWU1t9ifIeull8X/YHGRMix/SbuePR6N4ZW8Md9NBAtWrfzwzgLq9tI/1YDUJ
	 BTy6BwC52ytoCiYpFOiaQT/mjPSRRr9iAhJ9I3twSS7sWZr6/A56I1HsX1Tty+AI6AdsN
	 rRb29gQSUkOkdFcRT3TF6oB1TzQMJSnNL5PNqk3gZ3ePdAXe1n1FKZMH0P3891eAPSbbY
	 nl3n7f8/48B3HXGE1yOJEVfbJcP9hM5DifRpvTFgZBqgknBUOSl6F3fjexb2eslWrsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263478;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=b1idv5Llys8jErTecMkb9GaJ9uep/EhQy4rAz/RX7Cg=;
	b=D8/AVge4qfNvqUgeXRrg3Jti/OENjIE0Ayhbx+LbUXM4LBW83P5kFJik3dXhG8DyD27m
	 laaD2Er5K90Oqvm8KmG7Hc6ntu9mt+/8Hv9p0veUXsPK2gfkZ8mYbKFjI5DyjgDA9tVVb
	 RqfZj8HGDtLQL8GfD67cA0iGGExmP3JV6byvhYnXG9QFR5MPx1Rd1UrXkIXIsbGvAcD0L
	 P85eTLSku7T+BW+VenlfdzhhVxpqbiuV/req1YZjNNapFxGuRHiZQ8zi90aV0V5qZDspS
	 mZHhz1nZNK6NcwpHXLEtK8CtISdm1X3dk1FyIzxBb+C7YzeThmlQrZgapGqGdKy4O8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=shut6pRR;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA12B606A326
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA12B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=shut6pRR
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so586117b3a.2
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263477; x=1794868277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1idv5Llys8jErTecMkb9GaJ9uep/EhQy4rAz/RX7Cg=;
        b=shut6pRRV2iBzi4Y+EmEkl4e81JxPzmh3AHQrEnhlcENvfE3FQ5tLwr+a3sCKw0OHB
         5nDNHPZUT9IC48kl8FvGcV0Z4c6/gcGma+9Lg/wqP4unwHbh0AnFLA7LXBrBs0MmJ/Ei
         xJnITmVvJUVGdZh77hrYArOs6ZjcxsSKFugYKU1FvAeE3BkEDzzkxCVBMgWEpg6PKASY
         fYXN3koAB5mNKMY8isVtITejoiyxSHpoeQA3Mu1RGjTM5rlM7TWbaHjkrEswUOPPDA4W
         TNJsZVNq1ftKiqPY57Q89BsAN2VoYRA6PbEqh3FFDZQq97sUk2lZbfbOw+mBKGAKjSWY
         US/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263477; x=1794868277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b1idv5Llys8jErTecMkb9GaJ9uep/EhQy4rAz/RX7Cg=;
        b=yBPysni3b6qLOvkeLCNilTIE58FyprzHjyWpWeV01yZ1OelY4UrRvuG4NEWqee7dJh
         X58KdgGxL3FZjFLt4W5RGLbaNCl4jbhtvXf4Fa53xHNwzcRkZazWkCrKvC9y7YtUW7T8
         xMh40z9RkOEtqwHbMTkBy/sNia/XRg9S8whxF7UpiFc0kugxp/3ABTQvU2gCrpp0kOIE
         k2WjD8tsgbmtCRB5sFpwGwg8MHt4RM/Suhde8WwLhk2so/iqnPZxMigMbbuxzjORV190
         tcqSTnFJHCpdPCWw6wBcbvTyxX1eONgZqsXohRijqV+JY9Ke3x1gmrEVPNZHv/6cM3MW
         ijXQ==
X-Forwarded-Encrypted: i=1; AL+hErHrv1l4APFCnI3e66rD8K9Hcj4CtVSiC3SC7BRHuOkSDCAwYO68ftSchnawQIjlbBDvCV0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yJ8SKPELFsLlMyren3mNGk3xEUQ/MVKx2lY1aW53CS14vONA0
	qoYmYdvidCrkTEU+WBeeOcCj5koY0WmoAiCY6elk49Ku/4pcOEdFyfVdGBr463KWk85wYC8vs+P
	XQdqh
X-Gm-Gg: AYBFou1PFyknRbOMP6be+0EM2WzAm8Fex5ueUbmlyDh5t6VCKR0v66LifSpsTYoVK2b
	Xe5MitHxU2apQYTHqlE2UDKa+icQwI81CJ+5crfVOeRpzR9ae2sug2XfZhDMZ/nU13AAg6NbcQ1
	BqrhRO33Dce4mfS1Sff/NZHof/PmeIY0hQmu6yrGTsnSVajKXQ/HtFCLPGJbEtGxSbtXmZRMkIO
	o75fuJOmKoh7aKmP1FMG7EYf5PWOlONtGBnHd7FDzCHVoW2mkft7yBxb5ULa+xoMRrIDU+dnMqk
	ZRnD4GE6CDt/yqR2GO6pXEWmuWpcEV54sFJBln3ud6/MCPkpoPRjAIprj6/Mg4AkaTiSFdQjJiY
	5cukglFazlAYKxRlYhd0mFq7S2dLtoILMipdZAjSbDGqzBUgTC/m//GJp+V0Ed24iojSk++5KRO
	dDm21vk2PqAkyYdw/zR9oXHPyoGK8rC+NRk5C7pBvQL4p7h6j9iwrQ99A47A7JaFtsqntqRj/wF
	Fg2CPoX4HqXyC6+jKAkVPJ1raAAR7WLjj3+bQplAO4dSGJyNkKIsFApuv7SPelNlMFC7PBty8/V
	byjewahQIlnrVC1IOUWBcIgd9huL+O8MryMnZjZwmpK/ZIpxQOIbbg==
X-Received: by 2002:a05:6a00:4f87:b0:8b6:4eec:f501 with SMTP id d2e1a72fcca58-8ba885c7a7dmr901188b3a.14.1794263477020;
        Mon, 09 Nov 2026 14:31:17 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:15 -0800 (PST)
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
	gshan@redhat.com,
	michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 02/23] target/arm: Add confidential guest support
Date: Mon,  9 Nov 2026 16:30:49 -0600
Message-ID: <20261109223110.1619504-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
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
index 58732d658f95..2d0b5c1b2654 100644
--- a/docs/system/confidential-guest-support.rst
+++ b/docs/system/confidential-guest-support.rst
@@ -44,5 +44,6 @@ Currently supported confidential guest mechanisms are:
 * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
 * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
 * AWS Nitro Enclaves (see :doc:`nitro`)
+* Arm Realm Management Extension (RME)
 
 Other mechanisms may be supported in future.
diff --git a/qapi/qom.json b/qapi/qom.json
index 7fffc949d3c7..18c1d88b4cc4 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1298,6 +1298,7 @@
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
2.53.0

