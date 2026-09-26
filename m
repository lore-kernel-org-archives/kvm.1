Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBC7344046
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406240; cv=none; b=JUUZZGVpgrx/fel99CxEOQUgTqlQBHUjV3EVFgr1smkYSa9xOk8Aj/EUPf+8Czv7H1y5750JS+morzwPz1qXvMtOWSH8aFH+s6cxcMKssNcxUbH1LtO64EUXBzU3EJy/6BaSaApP59lQJGK1OhZ1u/y3a6068K0nj8sO+Wx4cks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406240; c=relaxed/simple;
	bh=DqY7GypdtmRBkgMxvb3G4GAtNv+nmrv2qe98ryGgktg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQjkhX4rA6Upt20c3mJyDVzj8pMT80ySyK9SunHBb9HRKzYnZozjZz2lMUPTv36Vi1Qm+RmNY19xlR4k3YzLt4t6CMaxxzl35jAjpHUGPxASqnOaME3eMfnCHxlUkIYM+O2XjO2eEUKUgrBfz4Cq28/m94j0caoY0ap5wFCaT8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYQFWDSd; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYQFWDSd"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-3396cec93b6so1847221eec.3
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406238; x=1791011038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qCXIFUQwlVnS7FqE0wXM3scWpVNsZr5+GJNgga1dkVI=;
        b=bYQFWDSdQ63bU6IPmA3+ID65SDc0/mr4B1C+d3Tu2etIOT+rfgcpw9qxx+KO63bQzi
         4gqJfF89fweuYrS98powXR4EoBnAXU93NkTZ6OY8iQmx5arHVs7BMIZfre63jvNbxqI6
         g29Df4/4KLe0qOEF1GmmZ9y0HbCgdD8Ng5kQ9ftXXm4HKNOxCZWGTHdKQ8kltLoQIya6
         gyGQLNGigveKeVSeHGSvYfzeiBm64ZW6abPyEeR7yZyXssm3vfxqAMETNP26BJcviMO5
         Ndr6KxDZ/B2EHlgD+24VYRRqEs2esMhic5zkxEtrUVV4vyr9sWfAnTuViXTemEh7HOMp
         SErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406238; x=1791011038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qCXIFUQwlVnS7FqE0wXM3scWpVNsZr5+GJNgga1dkVI=;
        b=ymBDo6ZsXTJd1OGso/IbjTCeXzZAl/LGxcRPY9XYvEsdDsB74uy0st114io5Dpd9F+
         9S9UfCIlhFowfh9+x3TKl8a54R2mOXwwjbXMrgAf7Vx1KdjoxQb9lLZHinA02+qey38f
         fOTl0K5ac6+BR0CyorD2o/7pPj0CoTgcAlgzwiXOw2Hf+FhxV0Ytb0vPni8fon/KFLAZ
         1ylevbRcMazXgSWiOvtcsdXIDPOlOZmoS5730GQigTPVIvF/pyFSsmb+ChWk1iQgAMP8
         2ozuIjv2gu1agiWQutxsJczMs+zJzZmbZxW0plYce/5L+tHYukWqilXMLbWYyfvb4Upt
         qsLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVs0kS0QoDbwfP9gRoPhQPXREACGbDTswqryQdPMBl7y0k4ydBHhyEKoVH1v+k3vl3WaQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kjecHzADVT2pT3VaDab8hg8Ez5j5PNXNSUu8+RA+9Q9IM/u43Q
	x7TDeXpjqchousKezxK2slJB9xMIM2cVQd1aN7Gn0raP9PPfdsvZ02hM0lraose0
X-Gm-Gg: AYBFou25JJ0yuX801taK6hS5kyluycLgkKH5Kh6i9g0PT1DyWO6qTWk7dEwJ/tsvFqd
	k0Fdo0audSGNHmCutaWpS+egmnWgLFHk3W8mbHIQLs/KQLlim0j0TD0Vr4u15NcHZTmVp6vxwJN
	n/Qz+n4dbCwl2nIQS9Wcas96NZoPDxlLQOFgpoYea87fo04Fkg0Uo8yMUOh0qiShNT3eTI3LbtD
	w9+diOirjqnKrrFQG2t3wQf4fk91yOmFaMaChXyoAoP6nxbSadlz8fpVFc+dlOljcFBMyMTWPkl
	n1I9xB8xGKM+8RiJLVNBZDLHMCP8mZeWaz7BnvlilNT2y7H0BfnJ9OTwxrC7fCZMX22aHKR1Okd
	LuSsXyEnWw2MpAtFbAGRJYxcV8dmGTnyVrYlBpcbAUQPfgZqFOG22ABUSnb8tRk+Ddc0sQj8i5j
	I7uHx6pHeY9ZCjEUvJxykzW1PriyGlN1WnXGXAcaPjPsal6/Eu1U2u5OeYm/jyDJboydKXt16wv
	j5i/ujJLakPfYvGt/p84MyxMoF3C9w=
X-Received: by 2002:a05:7300:d0a7:b0:33b:dab1:d6b5 with SMTP id 5a478bee46e88-342705aee26mr2037757eec.11.1790406237841;
        Sat, 26 Sep 2026 00:03:57 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:03:57 -0700 (PDT)
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
Subject: [PATCH v4 44/55] target-info: select combined qemu-system target by name
Date: Sat, 26 Sep 2026 15:00:43 +0800
Message-ID: <20260926070057.1234-45-luoyonggang@gmail.com>
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

The combined qemu-system binary can select a registered target by
name, or stay on SYS_EMU_TARGET_NONE. A single-target binary does
not switch target.

The none entry is the same target-info-def.c stub as other targets,
compiled with TARGET_BASE_ARCH NONE. target/none/cpu.h supplies
ArchCPU for that stub, and cpu-param.h sets
TARGET_VIRT_ADDR_SPACE_BITS. TYPE_NONE_CPU is NULL because there is
no none CPU QOM type.

type_register_internal() keeps types on the combined binary and
filters them with TypeInfo.is_available. A single-target binary
still omits types that cannot run.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info-select.h | 24 +++++++++++++++++++++
 meson.build                       | 35 +++++++++++++++++++++++++++++++
 qom/object.c                      |  8 ++++++-
 stubs/meson.build                 |  1 +
 stubs/target-info-select.c        | 14 +++++++++++++
 system/target-info-select.c       | 26 +++++++++++++++++++++++
 target/none/cpu-param.h           |  7 +++++++
 target/none/cpu-qom.h             |  6 ++++++
 target/none/cpu.h                 | 18 ++++++++++++++++
 9 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 include/qemu/target-info-select.h
 create mode 100644 stubs/target-info-select.c
 create mode 100644 system/target-info-select.c
 create mode 100644 target/none/cpu-param.h
 create mode 100644 target/none/cpu-qom.h
 create mode 100644 target/none/cpu.h

diff --git a/include/qemu/target-info-select.h b/include/qemu/target-info-select.h
new file mode 100644
index 00000000000..0659bb47567
--- /dev/null
+++ b/include/qemu/target-info-select.h
@@ -0,0 +1,24 @@
+#ifndef QEMU_TARGET_INFO_SELECT_H
+#define QEMU_TARGET_INFO_SELECT_H
+
+/**
+ * target_combined_binary:
+ *
+ * Returns: %true if this is the combined qemu-system binary.
+ */
+bool target_combined_binary(void);
+
+typedef struct Error Error;
+
+/**
+ * target_info_select_by_name:
+ * @name: target_name to select, or NULL
+ * @errp: error location
+ *
+ * Combined qemu-system only. NULL selects "none". Every name, including
+ * "none", is looked up in target_info_list(). The stub is a no-op on
+ * single-target binaries.
+ */
+void target_info_select_by_name(const char *name, Error **errp);
+
+#endif
diff --git a/meson.build b/meson.build
index 7ab5c7971a8..96f493cb746 100644
--- a/meson.build
+++ b/meson.build
@@ -4618,6 +4618,41 @@ if single_binary_available
   endforeach
   single_binary_objects += single_binary_target_info_objects
 
+  none_config_target_data = configuration_data()
+  none_config_target_data.set_quoted('TARGET_NAME', 'none')
+  none_config_target_data.set('TARGET_ARCH', 'NONE')
+  none_config_target_data.set('TARGET_BASE_ARCH', 'NONE')
+  none_config_target_data.set('TARGET_LONG_BITS', 64)
+  none_config_target_data.set('TARGET_BIG_ENDIAN', 0)
+  none_config_target_h = configure_file(output: 'none-config-target.h',
+                                        configuration: none_config_target_data)
+  none_config_devices_data = configuration_data()
+  foreach k, v : single_binary_config
+    if v == 'y'
+      none_config_devices_data.set(k, 1)
+    endif
+  endforeach
+  none_config_devices_h = configure_file(output: 'none-config-devices.h',
+                                         configuration: none_config_devices_data)
+  qemu_none_ss = ss.source_set()
+  qemu_none_ss.add(files('system/target-info-select.c'))
+  qemu_none_ss.add(target_info_def)
+  qemu_none_src = qemu_none_ss.apply(single_binary_config, strict: false)
+  qemu_none = static_library('qemu-none',
+                             sources: qemu_none_src.sources() + genh +
+                                      [none_config_target_h,
+                                       none_config_devices_h],
+                             dependencies: qemu_none_src.dependencies(),
+                             include_directories: include_directories(
+                               'target' / 'none'),
+                             c_args: [
+                               '-DCOMPILING_PER_TARGET',
+                               '-DCONFIG_TARGET="none-config-target.h"',
+                               '-DCONFIG_DEVICES="none-config-devices.h"',
+                             ],
+                             build_by_default: false)
+  single_binary_objects += qemu_none.extract_objects(qemu_none_src.sources())
+
   single_binary_link_args = emulator_link_args
   single_binary_link_args += enable_modules ? ['@block.syms', '@qemu.syms'] : []
   qemu_system_name = 'qemu-system'
diff --git a/qom/object.c b/qom/object.c
index 76b0b0806b3..2ce6c369df5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -16,6 +16,7 @@
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
 #include "qemu/target-info-qapi.h"
+#include "qemu/target-info-select.h"
 #include "qemu/cutils.h"
 #include "qemu/memalign.h"
 #include "qapi/visitor.h"
@@ -171,7 +172,12 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
         abort();
     }
 
-    if (info->is_available && !info->is_available(target_info())) {
+    /*
+     * Single-target binaries omit types that cannot run. The combined
+     * binary keeps them and filters with is_available per target.
+     */
+    if (!target_combined_binary() && info->is_available &&
+        !info->is_available(target_info())) {
         return NULL;
     }
 
diff --git a/stubs/meson.build b/stubs/meson.build
index 29b6644b254..3765537778d 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -3,6 +3,7 @@
 # below, so that it is clear who needs the stubbed functionality.
 
 stub_ss.add(files('cpu-get-clock.c'))
+stub_ss.add(files('target-info-select.c'))
 stub_ss.add(files('fdset.c'))
 stub_ss.add(files('iothread-lock.c'))
 stub_ss.add(files('is-daemonized.c'))
diff --git a/stubs/target-info-select.c b/stubs/target-info-select.c
new file mode 100644
index 00000000000..5c9e8dc6e19
--- /dev/null
+++ b/stubs/target-info-select.c
@@ -0,0 +1,14 @@
+#include "qemu/osdep.h"
+#include "qemu/target-info-select.h"
+#include "qapi/error.h"
+
+bool target_combined_binary(void)
+{
+    return false;
+}
+
+void target_info_select_by_name(const char *name, Error **errp)
+{
+    (void)name;
+    (void)errp;
+}
diff --git a/system/target-info-select.c b/system/target-info-select.c
new file mode 100644
index 00000000000..4b4a9fdf256
--- /dev/null
+++ b/system/target-info-select.c
@@ -0,0 +1,26 @@
+#include "qemu/osdep.h"
+#include "qemu/target-info-def.h"
+#include "qemu/target-info-select.h"
+#include "qapi/error.h"
+
+bool target_combined_binary(void)
+{
+    return true;
+}
+
+void target_info_select_by_name(const char *name, Error **errp)
+{
+    TargetInfoNode *node;
+
+    if (!name) {
+        name = "none";
+    }
+
+    QLIST_FOREACH(node, target_info_list(), next) {
+        if (!strcmp(name, node->info->target_name)) {
+            target_info_select(node->info);
+            return;
+        }
+    }
+    error_setg(errp, "target '%s' is not available", name);
+}
diff --git a/target/none/cpu-param.h b/target/none/cpu-param.h
new file mode 100644
index 00000000000..3c0818a2f02
--- /dev/null
+++ b/target/none/cpu-param.h
@@ -0,0 +1,7 @@
+#ifndef NONE_CPU_PARAM_H
+#define NONE_CPU_PARAM_H
+
+#define TARGET_PAGE_BITS 9
+#define TARGET_VIRT_ADDR_SPACE_BITS 64
+
+#endif
diff --git a/target/none/cpu-qom.h b/target/none/cpu-qom.h
new file mode 100644
index 00000000000..114faa8077a
--- /dev/null
+++ b/target/none/cpu-qom.h
@@ -0,0 +1,6 @@
+#ifndef QEMU_NONE_CPU_QOM_H
+#define QEMU_NONE_CPU_QOM_H
+
+#define TYPE_NONE_CPU NULL
+
+#endif
diff --git a/target/none/cpu.h b/target/none/cpu.h
new file mode 100644
index 00000000000..ffb9a0d28dc
--- /dev/null
+++ b/target/none/cpu.h
@@ -0,0 +1,18 @@
+#ifndef QEMU_NONE_CPU_H
+#define QEMU_NONE_CPU_H
+
+#include "cpu-qom.h"
+#include "hw/core/cpu.h"
+
+#define CPU_RESOLVING_TYPE TYPE_NONE_CPU
+
+typedef struct CPUArchState {
+    uint64_t unused;
+} CPUArchState;
+
+struct ArchCPU {
+    CPUState parent_obj;
+    CPUArchState env;
+};
+
+#endif
-- 
2.52.0.windows.1

