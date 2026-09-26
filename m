Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B09D5733E
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406107; cv=none; b=DO5rpfGmbget6zd2ZJxWFBoOpsRLxpLfxqgaW1YcKYFyZ3seGF9SMZpZSSAPizcwTxUNjkVd7NoYl+BPUlTO8/1jKn3w6EOEQfU0acHhHWW0idH3ejaQRk+f0XnR9vD6yOehqJqFjnQWujJo8EBPerug24PzBFj633dPhJVX2gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406107; c=relaxed/simple;
	bh=UHOOus6unlZNBSGqVDMr2IibQW3tyBknKeyLOD06cAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyNJ/yRdxnmckp91KoFPdxvZ7IKyD4SByJZFmGKwUzZ7qX4L1tkvgHsWy5KiGc8B/AWnR1zyKETTgL/9LHruE4KVbzWCtQJNX95T1hZxbnhHUhMtJxwVhBeDjV1P/7iyVfCRedZ1pc/rvxCich0CSIAofjHHnZ0eO1KgtZDTaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kqbvrhwj; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqbvrhwj"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bb1a50f6fso848843eec.2
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406105; x=1791010905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N4+ve3swbK5ctjr/uSx7Tqtz8Hqkt+vfSyLQiiwbXAQ=;
        b=KqbvrhwjtQ8sPllNMbicphpPOdTtAN7eO7fxftzV7eWv8j9olb8IFX3iVfSA71AXFb
         czt3Fih2y2AjYFpPK8qmeovNmTHHZM9Q/BoIyti691trentnFMOj2gs+OvSD4k1kgc8l
         Z5+zRlOYBt2tebjL2X8iFYYjk+6HdtfUr2rFjcu6wOOQa+xfWsINDQnq4MAn0yREJX55
         LqhKHrsaEK3eelmHGQ/8lILI0RlUoTrw+0hT6WxzZayiEL89SGUq1YjDyrjzwqjWpGk/
         W6RL70LGPgAKNV5wD9E9MKQ9LZxnbU+IvGwcQSrkOMjbzk2HwLwn+CYHgW5eyH4BQerA
         fEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406105; x=1791010905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N4+ve3swbK5ctjr/uSx7Tqtz8Hqkt+vfSyLQiiwbXAQ=;
        b=CfMYMrsaB6qt3U/O8Q+d4YMJ/0rewvkM0TubgaS3hUU+vQ8GrQ15y4BceJ71qH0L18
         VV2j+w+IHMnCAeYt7k/Ui6fI+LH7XGH4+2Mj1S/fOshGV4IPUNlERId4B2yPZGhcjp/q
         /oP4D6L+B30Uk2EILIIWRhL/teYXBedecJgiikfashFe3MCFyQA2zFXCAvLONQ0PbWLK
         d3imXXSu3eXD1Z5j15McKbaOPTOYn3jlat2Oiu3tU1HYK+P+uQq/EmBgiG9cFh/A/Fl6
         19pB5pjkbFTYRgVxFRwnqFmxtuHTj5cT1mGOZmxOjkx59kZDD+YnXe85AhV/XnpB/r/f
         t1Aw==
X-Forwarded-Encrypted: i=1; AKwUvBwiIop7BT+yWXYF1iHC1MVPSdeQA56nLod3K1KYqgdBkqIthdWNnrrCg94oC5a97kMtuTM=@vger.kernel.org
X-Gm-Message-State: AFuF++m13tztKcEl7Xd5oeoiRclLpAKUHLSBs85Fk+JHxD1HERJPoznY
	NL5WOad7ROCJsy+SOy5FJDhHIv/EP2A7/RMCGvJspOPmWkRdPHMgEyRr
X-Gm-Gg: AYBFou09SVj2wxx5zeb7xrkjZlhD3peWmyB8PrzXAz2tm6HVbGg8w2jZ57EVNORfGF/
	ztXos0yUgXz4RrD4CzG6ew5p1ZT+1tDqSvSIiBKAWPAE+Y1Q2v8Quiow0YihNYuE0i5Z1kxQTdN
	IC5P1T3E6uxbOA0lHUUdRQ0fWuChlp68MJplOaMapURicXuJ1GYlj/1G6yEiwVmvSykp8UWdU1Z
	22JBCHXFDhxj2m4L58tayJGEkUYiNhjT056moVz++8exNRfwntxtDYHcDRyGIfYFOz2dH7/I1At
	rJWVGFHmhBirJXgrl2q3rtnX7KPK3QU45vJmbu8E1uo4aYlskZXOUYclCy9KgoQB5FMzpYZM5up
	g4mqh/XrpvUelRH/Ms2meG2s776IPHCDZmDs2m6YcJs99ziXG8pXNA2tIdRj6JpyZFbX/5EnmJE
	iemb1CAUY08XL6neyyT3qUYH5UxQJeUTwCQZu3IoDGe4a3+uKjiiHb2Lbg29TSgv8gWsEkZX6nZ
	dKlX3KiMpWPd50zwk59DZI7g/g9pHI=
X-Received: by 2002:a05:7301:4301:b0:343:311a:372d with SMTP id 5a478bee46e88-343311a386amr799765eec.28.1790406104888;
        Sat, 26 Sep 2026 00:01:44 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:01:44 -0700 (PDT)
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
Subject: [PATCH v4 10/55] target-info: add TargetKconfig
Date: Sat, 26 Sep 2026 15:00:09 +0800
Message-ID: <20260926070057.1234-11-luoyonggang@gmail.com>
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

Add a packed TargetKconfig of device and accel CONFIG_* bits,
generated from the Kconfig tree, and attach it to TargetInfo.
target_kconfig() returns the current bits, and
target_has_kconfig_<name>() tests them. Initialize
target_info_stub.kconfig from CONFIG_DEVICES.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info-def.h       |   2 +
 include/qemu/target-kconfig-has.h    |   7 ++
 include/qemu/target-kconfig.h        |  34 ++++++
 meson.build                          |  14 +++
 scripts/gen-target-kconfig.py        | 162 +++++++++++++++++++++++++++
 target-info-def.c                    |   6 +
 target-kconfig.c                     |  20 ++++
 tests/unit/meson.build               |   1 +
 tests/unit/test-target-kconfig-has.c |  22 ++++
 9 files changed, 268 insertions(+)
 create mode 100644 include/qemu/target-kconfig-has.h
 create mode 100644 include/qemu/target-kconfig.h
 create mode 100644 scripts/gen-target-kconfig.py
 create mode 100644 target-kconfig.c
 create mode 100644 tests/unit/test-target-kconfig-has.c

diff --git a/include/qemu/target-info-def.h b/include/qemu/target-info-def.h
index 080e30a5b0e..ae6374583a7 100644
--- a/include/qemu/target-info-def.h
+++ b/include/qemu/target-info-def.h
@@ -13,6 +13,7 @@
 #include "qapi/qapi-types-machine.h"
 #include "qemu/queue.h"
 #include "qemu/target-info.h"
+#include "qemu/target-kconfig.h"
 
 struct TargetInfo {
     /* runtime equivalent of TARGET_NAME definition */
@@ -32,6 +33,7 @@ struct TargetInfo {
     unsigned page_bits_init;
     /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
     bool page_bits_vary;
+    TargetKconfig kconfig;
 };
 
 typedef struct TargetInfoNode TargetInfoNode;
diff --git a/include/qemu/target-kconfig-has.h b/include/qemu/target-kconfig-has.h
new file mode 100644
index 00000000000..6616f75845a
--- /dev/null
+++ b/include/qemu/target-kconfig-has.h
@@ -0,0 +1,7 @@
+/*
+ * QEMU target_has_kconfig_* helpers
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "target-kconfig-has-gen.h"
diff --git a/include/qemu/target-kconfig.h b/include/qemu/target-kconfig.h
new file mode 100644
index 00000000000..21b2ba576ec
--- /dev/null
+++ b/include/qemu/target-kconfig.h
@@ -0,0 +1,34 @@
+/*
+ * QEMU target kconfig API
+ *
+ *  Copyright (c) Yonggang Luo
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_TARGET_KCONFIG_H
+#define QEMU_TARGET_KCONFIG_H
+
+#include "qemu/compiler.h"
+
+/**
+ * struct TargetKconfig:
+ *
+ * Compile-time device and accel CONFIG_* bits. Not Kconfig.host
+ * or target/Kconfig. Target identity is TargetInfo, not these
+ * bits. Not kvm_enabled() etc. Fields and
+ * target_has_kconfig_<name>() are generated by
+ * scripts/gen-target-kconfig.py.
+ */
+typedef struct TargetKconfig {
+#include "target-kconfig-fields.h"
+} QEMU_PACKED TargetKconfig;
+
+/**
+ * target_kconfig:
+ *
+ * Returns: The current TargetKconfig (target_info()->kconfig).
+ */
+const TargetKconfig *target_kconfig(void);
+
+#endif
diff --git a/meson.build b/meson.build
index 93237429713..9485f4e97be 100644
--- a/meson.build
+++ b/meson.build
@@ -3444,6 +3444,19 @@ genh += custom_target('config-poison.h',
                       capture: true,
                       command: [find_program('scripts/make-config-poison.sh'),
                                 target_configs_h])
+genh += custom_target('target-kconfig',
+                      output: ['target-kconfig-fields.h',
+                               'target-kconfig-init.h',
+                               'target-kconfig-has-gen.h',
+                               'target-kconfig-has.c.inc'],
+                      depfile: 'target-kconfig.d',
+                      command: [python, files('scripts/gen-target-kconfig.py'),
+                                '--kconfig', meson.current_source_dir() / 'Kconfig',
+                                '--depfile', '@DEPFILE@',
+                                '--fields', '@OUTPUT0@',
+                                '--init', '@OUTPUT1@',
+                                '--has', '@OUTPUT2@',
+                                '--has-c', '@OUTPUT3@'])
 
 if fdt_required.length() > 0
   error('fdt disabled but required by targets ' + ', '.join(fdt_required))
@@ -3778,6 +3791,7 @@ endif
 
 qom_ss.add(files(
   'target-info.c',
+  'target-kconfig.c',
 ))
 qom_ss = qom_ss.apply({})
 libqom = static_library('qom', qom_ss.sources() + genh,
diff --git a/scripts/gen-target-kconfig.py b/scripts/gen-target-kconfig.py
new file mode 100644
index 00000000000..afeffc75ca0
--- /dev/null
+++ b/scripts/gen-target-kconfig.py
@@ -0,0 +1,162 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""Generate TargetKconfig CONFIG_* field, initializer, and has headers.
+
+The field list is every `config FOO` from the QEMU Kconfig tree,
+parsed with scripts/minikconf.py (including accel/Kconfig: KVM,
+XEN, HVF, TCG, ...). Host proxies in Kconfig.host and the
+target/Kconfig tree (arch tokens and TARGET_BIG_ENDIAN) are
+omitted. Target identity is TargetInfo, not TargetKconfig.
+
+Each field also gets target_has_kconfig_<name>(const TargetInfo *).
+"""
+
+import argparse
+import os
+import sys
+
+sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
+from minikconf import KconfigData, KconfigParser
+
+
+def field_name(config: str) -> str:
+    return config[len("CONFIG_"):].lower()
+
+
+def collect_from_kconfig(root: str) -> tuple[set[str], list[str]]:
+    data = KconfigData()
+    with open(root, "rt", encoding="utf-8") as fp:
+        KconfigParser.parse(fp, data)
+    names = {"CONFIG_" + name for name in data.defined_vars}
+    return names, list(data.previously_included)
+
+
+def collect_kconfig_names(path: str) -> set[str]:
+    data = KconfigData()
+    with open(path, "rt", encoding="utf-8") as fp:
+        KconfigParser.parse(fp, data)
+    return {"CONFIG_" + name for name in data.defined_vars}
+
+
+def collect_host_kconfig_names(kconfig_root: str) -> set[str]:
+    host = os.path.join(os.path.dirname(os.path.abspath(kconfig_root)),
+                        "Kconfig.host")
+    return collect_kconfig_names(host)
+
+
+def collect_target_kconfig_names(kconfig_root: str) -> set[str]:
+    target = os.path.join(os.path.dirname(os.path.abspath(kconfig_root)),
+                          "target", "Kconfig")
+    return collect_kconfig_names(target)
+
+
+def write_fields(path: str, configs: list[str]) -> None:
+    lines = [
+        "/* Generated by scripts/gen-target-kconfig.py. Do not edit. */",
+        "",
+    ]
+    for name in configs:
+        lines.append(f"    uint32_t {field_name(name)} : 1;")
+    lines.append("")
+    with open(path, "w", encoding="utf-8", newline="\n") as fh:
+        fh.write("\n".join(lines))
+
+
+def write_init(path: str, configs: list[str]) -> None:
+    lines = [
+        "/* Generated by scripts/gen-target-kconfig.py. Do not edit. */",
+        "",
+    ]
+    for name in configs:
+        field = field_name(name)
+        lines.append(f"#if defined({name})")
+        lines.append(f"    .{field} = true,")
+        lines.append("#endif")
+    lines.append("")
+    with open(path, "w", encoding="utf-8", newline="\n") as fh:
+        fh.write("\n".join(lines))
+
+
+def has_fn(config: str) -> str:
+    return "target_has_kconfig_" + field_name(config)
+
+
+def write_has_h(path: str, configs: list[str]) -> None:
+    lines = [
+        "/* Generated by scripts/gen-target-kconfig.py. Do not edit. */",
+        "",
+        "#ifndef TARGET_KCONFIG_HAS_GEN_H",
+        "#define TARGET_KCONFIG_HAS_GEN_H",
+        "",
+        "#include <stdbool.h>",
+        "",
+        "typedef struct TargetInfo TargetInfo;",
+        "",
+    ]
+    for name in configs:
+        lines.append(f"bool {has_fn(name)}(const TargetInfo *ti);")
+    lines.append("")
+    lines.append("#endif")
+    lines.append("")
+    with open(path, "w", encoding="utf-8", newline="\n") as fh:
+        fh.write("\n".join(lines))
+
+
+def write_has_c(path: str, configs: list[str]) -> None:
+    lines = [
+        "/* Generated by scripts/gen-target-kconfig.py. Do not edit. */",
+        "",
+    ]
+    for name in configs:
+        fn = has_fn(name)
+        field = field_name(name)
+        lines.append(f"bool {fn}(const TargetInfo *ti)")
+        lines.append("{")
+        lines.append(f"    return ti->kconfig.{field};")
+        lines.append("}")
+        lines.append("")
+    with open(path, "w", encoding="utf-8", newline="\n") as fh:
+        fh.write("\n".join(lines))
+
+
+def write_depfile(path: str, outputs: list[str], deps: list[str]) -> None:
+    lines = [" ".join(outputs) + ":" ]
+    for dep in deps:
+        lines.append(f"  {dep} \\")
+    if len(lines) > 1:
+        lines[-1] = lines[-1][:-2]
+    lines.append("")
+    with open(path, "w", encoding="utf-8", newline="\n") as fh:
+        fh.write("\n".join(lines))
+
+
+def main(argv: list[str]) -> int:
+    parser = argparse.ArgumentParser(
+        description="Generate TargetKconfig CONFIG_* include headers"
+    )
+    parser.add_argument("--fields", required=True, help="output fields header")
+    parser.add_argument("--init", required=True, help="output initializer header")
+    parser.add_argument("--has", required=True, help="output has-function header")
+    parser.add_argument("--has-c", required=True, help="output has-function bodies")
+    parser.add_argument("--kconfig", required=True, help="root Kconfig")
+    parser.add_argument("--depfile", help="ninja depfile of walked Kconfig files")
+    args = parser.parse_args(argv)
+
+    names, kconfig_files = collect_from_kconfig(args.kconfig)
+    names -= collect_host_kconfig_names(args.kconfig)
+    names -= collect_target_kconfig_names(args.kconfig)
+    configs = sorted(names)
+
+    write_fields(args.fields, configs)
+    write_init(args.init, configs)
+    write_has_h(args.has, configs)
+    write_has_c(args.has_c, configs)
+    if args.depfile:
+        write_depfile(args.depfile,
+                      [args.fields, args.init, args.has, args.has_c],
+                      kconfig_files)
+    return 0
+
+
+if __name__ == "__main__":
+    sys.exit(main(sys.argv[1:]))
diff --git a/target-info-def.c b/target-info-def.c
index 3041d64ccd2..c02d98e6875 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -7,6 +7,9 @@
  */
 
 #include "qemu/osdep.h"
+#ifdef CONFIG_DEVICES
+#include CONFIG_DEVICES
+#endif
 #include "qemu/target-info.h"
 #include "qemu/target-info-def.h"
 #include "hw/core/boards.h"
@@ -38,6 +41,9 @@ static const TargetInfo target_info_stub = {
     .page_bits_vary = false,
     .page_bits_init = TARGET_PAGE_BITS,
 #endif
+    .kconfig = {
+#include "target-kconfig-init.h"
+    },
 };
 
 target_info_init(target_info_stub)
diff --git a/target-kconfig.c b/target-kconfig.c
new file mode 100644
index 00000000000..078c0d8e7f3
--- /dev/null
+++ b/target-kconfig.c
@@ -0,0 +1,20 @@
+/*
+ * QEMU target kconfig helpers
+ *
+ *  Copyright (c) Yonggang Luo
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info.h"
+#include "qemu/target-info-def.h"
+#include "qemu/target-kconfig.h"
+#include "qemu/target-kconfig-has.h"
+
+const TargetKconfig *target_kconfig(void)
+{
+    return &target_info()->kconfig;
+}
+
+#include "target-kconfig-has.c.inc"
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index dc980a35955..c806dbc4ffa 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -47,6 +47,7 @@ tests = {
     objects: target_info_def_objects.values(),
     compile_args: ['-DTARGET_INFO_DEF_COUNT=@0@'.format(
       target_info_def_objects.values().length())])],
+  'test-target-kconfig-has': [qom],
   'test-qemu-opts': [],
   'test-keyval': [testqapi],
   'test-logging': [],
diff --git a/tests/unit/test-target-kconfig-has.c b/tests/unit/test-target-kconfig-has.c
new file mode 100644
index 00000000000..289ed89b854
--- /dev/null
+++ b/tests/unit/test-target-kconfig-has.c
@@ -0,0 +1,22 @@
+/*
+ * target-kconfig-has.h include path test
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-kconfig-has.h"
+
+static void test_include(void)
+{
+    bool (*fn)(const TargetInfo *ti) = target_has_kconfig_tcg;
+
+    g_assert_nonnull(fn);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/target-kconfig-has/include", test_include);
+    return g_test_run();
+}
-- 
2.52.0.windows.1

