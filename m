Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7495733E
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406247; cv=none; b=ek93Fuk4cM0elC61o71GEeTzXztUMbuLJsDd0uJ+EGvU4lpLk/kODy9S0YtinWJMub3HxfvO+Bp9oLT/N0p8nEjOHaNYdypxbTmVZgxNsb+Z65/Ae/qHJNyZ9hYKAbGHDdjS7Q4N+WBkjsPYjRCez9kwwBJHIJkpm3qUXevIL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406247; c=relaxed/simple;
	bh=m7YnrIwBHZIXlSaxV2tKrEoA+mBBjGA9xf1y9TgzDho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xs128RSRUo4h7pBkxhpMhjDDPWItfNt7rzKowkUVYsRM2VcVH5e9ou24aVD3ynBDhmXJqX8dDXUSb2K9LvCGF7UN5yjyLACDqPhJ7x2kWw4XiWO1wGafnKQlKbSIZVJZaiajfendNghz8aNAOde5reNoZFAh19t5y4KH9Hv/0QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FO6n3Snd; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO6n3Snd"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c11ef641aso1880785eec.1
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406245; x=1791011045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HQgaQ3pRlQZWTe+kZSuEPjW/N+yjSW5+B1zpZJSKnLc=;
        b=FO6n3SndnmEudiH4qh1ge+laMcZ+/lcrMjxyPJgbeBhGyBgqO5Pwo0/4B6gOQyZ5jh
         EuH4/111R3hoAmwk1HztCSjTf8rUOWk9B0JC964bOBLy+RwdsOOVdzCn0O1ZKRe6+J57
         9JctWsuEm+mcj7YceXjVylVK/bS/lHRXkR7J8OdseKSkRrPlfi/vv2Pdps7BxfwCfEPj
         fndbFS/tGi1jcYEhT/95dlcivIbmKD/TAp3ziGfv4s9z8mPeK3jJQXdA54qQ2+qxwVCX
         2PZXPLVDo7obJIgFPfjdaSR3FT47/eV1TjqhCYyvuLR0QNRikEdiZWiVFcfPhV4tPdv6
         mfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406245; x=1791011045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HQgaQ3pRlQZWTe+kZSuEPjW/N+yjSW5+B1zpZJSKnLc=;
        b=ZfpG/+uzRkOx0vEpAEBjisX5NqBQrQ/9aYEe5dKoi9fbXd+A+LR5Cuv92GDnR6QlZX
         R0Z0p/HLjqhRxVRTAmbddN4bS/eFGTRkJt4GwJpYt0wZqb9eUOxXtPT51pmoQzc0nOg5
         O2IyKK8rtvu7bEQlO3nyWiur8fWjhL/3dAEHjwxLEAP4VpinRT32si58bUUAKAk9vcXL
         3p5RKtkO4vW0YdaDMjUytSYzdnw8+iR7f5qDCc6CprLy+7AsARPeaLit9Poi9SvMMiV9
         KrAJtq98RcHX0Pd0bLHaOj3xjSV4hQU/r5+r0mBChXRZWkyRnbMWdfni/vVmWjm8YHtT
         FH+Q==
X-Forwarded-Encrypted: i=1; AKwUvByVeve66rlKfq4vxTt+0jT9B5whxSPX1lhc+ZgJSqn39W9HEOyxnzgDdzqZFdmfXoqdtsM=@vger.kernel.org
X-Gm-Message-State: AFuF++kFKamEtsdQAkKmHH7AKp/fvYT6433pg36OQr1w/KM5WesSB1rm
	nNXIA/ZAUgh2hM++EtiV/MFTRnxfZ2zh73Mt2jSF0KMH3a0SWIKj6aC4
X-Gm-Gg: AYBFou2Yo0RaNKLZYRrVV1Pp6a/kmn1G+qEK8awMrIC1gUIyOtxdwgfdlZZYXlE4qsZ
	abn3uDhJ2LEgyzsnLUx0yuAxibPbiJHpSt6D8L46V00kPpL1YBXAASX5BQ5dPJ6YZak+hMW3GZx
	DQDu37dtJL1OKTTi5k7vZ6WqAGJESZ7hGpNffCYvgH9dseWyfy7jMqmXWQAQqmmEMlRcfsZta5b
	NS3OVm9pLgtPfdBA5eOv4yCnSpx1ZyZpt/e7h+QDF/djO+RzbdqJuxK/IvGYqj7Gz13yBrTIC/k
	/VFKeZZ3+nJxmhkWAtMg/Rjhba4cM6RsMi6FyheN2I1jbJiiOkjsvSXjOYoxOM2065Ax0Y0MLWc
	M4CtrHK6+AbTr+8BYwpiPG0aiOtwegr3Y43lyUWen0fqf9b9AaRFxA72kf9iLgHKKcEcslYYCej
	AmIYRRBfDEqIaIpCEr6vqC7GWM/+mQv9GsEamoDK53VMJtdAjlDhwurRh9nrTlvRayGiP6ymZAj
	MYtsS8vaS+D2EYPs9J+Ha1tZPB0t74=
X-Received: by 2002:a05:7301:7191:b0:33c:35ec:c2b4 with SMTP id 5a478bee46e88-34271a9026dmr2161927eec.24.1790406245422;
        Sat, 26 Sep 2026 00:04:05 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:04:04 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 46/55] qapi: add query-targets
Date: Sat, 26 Sep 2026 15:00:45 +0800
Message-ID: <20260926070057.1234-47-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

query-targets lists each linked target, including none, with its
arch, endianness, and the machines that target accepts.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++
 qapi/machine.json          | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 9c08b17510a..c7b73efa31d 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -21,6 +21,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
+#include "qemu/target-info-def.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-qapi.h"
 #include "qom/qom-qobject.h"
@@ -173,6 +174,35 @@ QemuTargetInfo *qmp_query_target(Error **errp)
     return info;
 }
 
+TargetMachinesList *qmp_query_targets(Error **errp)
+{
+    TargetMachinesList *head = NULL;
+    TargetMachinesList **tail = &head;
+    GSList *machines, *el;
+    TargetInfoNode *node;
+
+    machines = object_class_get_list(TYPE_MACHINE, false);
+    QLIST_FOREACH(node, target_info_list(), next) {
+        const TargetInfo *ti = node->info;
+        TargetMachines *row = g_new0(TargetMachines, 1);
+        strList **names = &row->machines;
+
+        row->arch = ti->target_arch;
+        row->endianness = ti->endianness;
+        for (el = machines; el; el = el->next) {
+            MachineClass *mc = el->data;
+
+            if (!object_class_get_is_available(OBJECT_CLASS(mc))(ti)) {
+                continue;
+            }
+            QAPI_LIST_APPEND(names, g_strdup(mc->name));
+        }
+        QAPI_LIST_APPEND(tail, row);
+    }
+    g_slist_free(machines);
+    return head;
+}
+
 HotpluggableCPUList *qmp_query_hotpluggable_cpus(Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
diff --git a/qapi/machine.json b/qapi/machine.json
index 6aaa2af709a..d8cdea6203e 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -307,6 +307,41 @@
 ##
 { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
 
+##
+# @TargetMachines:
+#
+# One registered system target and the machines that can run on it.
+#
+# @arch: the target architecture
+#
+# @endianness: the target endianness
+#
+# @machines: machine type names, not aliases
+#
+# Since: 11.2
+##
+{ 'struct': 'TargetMachines',
+  'data': { 'arch': 'SysEmuTarget',
+            'endianness': 'EndianMode',
+            'machines': ['str'] } }
+
+##
+# @query-targets:
+#
+# Return each target linked into this QEMU binary and the machines
+# whose availability check accepts that target.
+#
+# Since: 11.2
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-targets" }
+#     <- { "return": [ { "arch": "aarch64", "endianness": "little",
+#                        "machines": [ "virt" ] } ] }
+##
+{ 'command': 'query-targets',
+  'returns': ['TargetMachines'] }
+
 ##
 # @UuidInfo:
 #
-- 
2.52.0.windows.1

