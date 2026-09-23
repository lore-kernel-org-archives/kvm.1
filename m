Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA98530DEF
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169545; cv=none; b=R3mDgXXnGWeQTncvsffK+3W6lYYnYB/WYz47+PbRwDQiSoI6nU3i71bLTcxbNb/1wud6Q8Mhw8oMCpI885miuQ892ur2sKnxoArqdEWey1GajHkhYkZSw04e3Re8I33e+4jYgqhKwaCFMR374KfFjPLXFopW+5Ujp+mllQva7DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169545; c=relaxed/simple;
	bh=c8MFbDnqrvIZmuw5n2X3uesngOlZIXVMj8BN1mcW2AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHsuAdkIZcUjlhEOv50aMY0j9Nvq0DVSfAqkd6XpFhBWXlwofl1CZeTvrUX7p8kT/Wquh3NuIprShMA3+oU/Is5diVVo5JE3kajQhVDdpV+3Lo8vH7/LC3zH/fXqKcZC59X7CbCcE7CY0VkU3bHJ0tU959Fb8EZAuV+ajjtHdmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyX1ooWK; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyX1ooWK"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664ef791so585145eec.3
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169531; x=1790774331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LmGgEVLgs7KsvhNFrBIpJWDBtYOselCCUrcKIvn6Xxs=;
        b=NyX1ooWKekemVfcGj3EhPyciPcP5fRjfdSoQLqCEUB9SD4gwewcyyksahp2/chF++X
         ewjaaU6TkYriHEr4xX/tFoqE3Cvl58IGDFqGRf8ZTPk1n+jddzwZGrrqQ/M6Y7JCW5hY
         H8IDK98Zztkbnre+K9gW54V04DBSW7vTAMgS2FiLfTv5F9h/kvZTtiT0Pkh8MR3wY2AS
         GBA+Hx2hou94hVxeUJ4wGKT2YS3xtQLrokzSJt1xkezL7gSa/hpg4mdA+obClaXZrI0T
         tDClkc2iOZZRxHsWc8Pyidh4NbgcmUxcZTFV1wL2bnYTu0jz3YHusrIjj/h25iaQikBR
         Qrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169531; x=1790774331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LmGgEVLgs7KsvhNFrBIpJWDBtYOselCCUrcKIvn6Xxs=;
        b=wMF28yUDU6Y7nM/kxJKG/l4s109xQ0GtZkKnIx4N5/uXNUzlf3U1mOcHt8xW3ve0n0
         bMhqtaZRFSmS9MGI1son1ceSCE+W1XQSutxtZxWxK68UIZ1SbC1kB6Eyi/IUzxS+Is52
         nA1vwRQ9BtOaf8U+epkiXaCTI+CWjNAKwcNS9X6l4B4fXsosZ2AaYycCvf74usB7pe3l
         WfL8iVYhm1YVeCWkwxUqTGCTmVs3i3BhBawYdR7JA+y4SpmHAMHLzYO+GOljPTDAqdGp
         b1Xx3q9hHvMmdiyTcQxmsSEXIPi6JTesW7hhMzGYqK3GCidXNTXgknPTvy8ronE6qspa
         LScQ==
X-Forwarded-Encrypted: i=1; AKwUvBxHUvl9pfk19cD2Qq+JTFvjTNk1OdY6Him+W/Ij+gOXtSinT9qrGk8/ih3ApnCJnM1IXfc=@vger.kernel.org
X-Gm-Message-State: AFuF++noK7Ceo6mbvmAvE7QOxKuovCnYdgce2YRATnh/6IoC/kDVlkfh
	EE1fzbDGPXoAPF3yzuQQI4M96oiYe11lDxJvxj0O3IaNKx02ToH3RFoA
X-Gm-Gg: AYBFou24QndW35YM1aCxKDBm41gn5fCXHEyOzSBls3H7Wujv1fivqvqJAXT9cFpyPKh
	dwQbDFDbeC9WtanecZcJDjr5GiIMinCfVHbDKV+6uTve9K1M02ne350dQv/B51NfVvQ5uIk/iea
	gEmeBkeE3BP+0gO8/Zli8LOxBzjPThFRaVu7HdKYJB7MHRJjg2+rjDwCRn8xae1TDPa3xZVnlcZ
	QaszRerHWx4f6+z4G2m6EKKLil8Fc9Fi6SubHg+3mLfSXR0ddSHGenp5kTqQs3ajNL7OZ5jlzml
	WH0IRpp8ADtYbHODiTsdaxDRTz5n7trRTdqIxUkRJiwuGhyCaWFdMW1c7tOHsGipaCywrmHG8pl
	d6QY1j37UFhPgg/yqxhZNHiGmsvIOMm2Auswz5mpoirS6KU4Aqsv7u7hAH7tX1OU+wxV9LWESme
	5VE5YKSC8rgMI6x/C7zYCekV/nwUQHI4JqfRuwQZzk2r2pVXNtIuxZ8uka0SLCTH/Y43LPU6q1p
	1leJU/OJFCfsl5ipHvakx6acUtaHUI=
X-Received: by 2002:a05:7300:dd05:b0:33b:eea2:cbfe with SMTP id 5a478bee46e88-33e8dec5b02mr2369589eec.32.1790169531303;
        Wed, 23 Sep 2026 06:18:51 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:18:49 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>,
	xen-devel@lists.xenproject.org,
	Chao Liu <chao.liu@processmission.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Fabiano Rosas <farosas@suse.de>,
	Xianglai Li <lixianglai@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	qemu-ppc@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bibo Mao <maobibo@loongson.cn>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	David Hildenbrand <david@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	qemu-riscv@nongnu.org,
	kvm@vger.kernel.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Song Gao <17746591750@163.com>,
	qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org,
	Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 012/114] target-info: add TargetKconfig
Date: Wed, 23 Sep 2026 21:14:46 +0800
Message-ID: <20260923131635.1894-13-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
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
index 25dc7c508d3..615596ed468 100644
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
index 776d38c5afd..8a017faaa74 100644
--- a/meson.build
+++ b/meson.build
@@ -3445,6 +3445,19 @@ genh += custom_target('config-poison.h',
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
@@ -3779,6 +3792,7 @@ endif
 
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
index 954298b56d0..44d153cefbc 100644
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
 #include "cpu-qom.h"
@@ -33,6 +36,9 @@ static const TargetInfo target_info_stub = {
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

