Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DDC14ABE
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406101; cv=none; b=SHchIm9HcM/zC5YmTEC5Dzlla4qkiOLr9ekZQEirxT+l9iYWDWwydlma7fXCHYPmP2gwN/nT8jWk215+3x8A3mIPKF+fH2WLxClYBgGm2FBYJw2ixLj+zwNDO+q4amk67gNzHhJOhulrCeuXj2o4yPY4j5HoqzjtnVd+5ItRrBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406101; c=relaxed/simple;
	bh=bhMI6oWGvzUPhSiE29Zo93jLyULShjCh5TLhiXMWz+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5jm6RrwS6P+nj6aIQqDn2Sm22AFvlXJdxFXInpmZJsPDybxNjdrzpqsHYEsop8uJEKC4/B+6hOexFONQxyS/ZrNnsJqluuZHlR6/eQmGHKcnxb2sHL631c1R6g6ONgAZFAaVO4peA9Xcrrhlh5ZsiyluXHWftNvJgTmJXN+rgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSJk+4iV; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSJk+4iV"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664e061cso1769190eec.2
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406098; x=1791010898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ign1E0+b6xltdUS4MWB1vKIjsNRvcSjRc2WeM4/+WU=;
        b=jSJk+4iVW/WyITl9b1prDau3i6cwqwZzYvJdmF57MpF11l7/zj9rq8q9Xn0STrvVhn
         4mnmhBgQe45z8uZcw5az3Ku3/UnNIhwG7qn3Pu6yU326ONSaROWIesJZtQngIRah5HH4
         mXr2dQaUU6dSM3ooVv0RT0WHEeO9sgHj+OP9HbZQZG2pqQrNcSkBVp+Q17v+V7WbOcA8
         5/Ub8Wot4i0YNIM0L0YAdsJeoNxMj6ugshcQ2XpZ1vTQz09BZRNuVBJxWmnTNCX/Yx8j
         q8DZm/A9SeLpofeIp4blPn1Faxu1naNfx8XSHU0Mpomis+Bjw1Swp6fPZuWvMAps1H8/
         5xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406098; x=1791010898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ign1E0+b6xltdUS4MWB1vKIjsNRvcSjRc2WeM4/+WU=;
        b=NjiNutTT/Z7sQzBLGwkkTvgErzsjDK5uQGXKJ6+u9swKvXUIuoiCgW1nhb8XO8nfDy
         fbdC2vqyY9fkv5cIyK9XW3NY6z9MriS16YK2b7CAl04vQ0z6bOCgWtWA6mgoByXu///4
         Tt6xwD02eGRDQhgE+Bl1ldwbBmBmeGKxg+bDYUZQdyMCh+Xev0Bo2fsLAS6MPih+zoff
         3+zj4vfnlnccby3N01VeA50v4oMeqyMwUcVMZ0RfaLRL/jpJKPGSOaaz3wNkuXkuDnUP
         ebbP4in2VBs8XhHdH4yqMsBVfQ9ZAjoTdCoreOhbF5McVNEPN7b8g6CafoxCfKUTimNK
         C4wg==
X-Forwarded-Encrypted: i=1; AKwUvBwH+KNnZrFpMT1TqvlcPw5fWlm4vLHpy2hNh+vA5JiltfBZQeFIxweU5r147PrlwcFXCrg=@vger.kernel.org
X-Gm-Message-State: AFuF++nY4eETVTAMnuw6Zd41n8ViHfz+0NkdTgTEsmxLFwgRf1AUIHbm
	PVsfBQurBAiq5yUEKQI7UuwFSEfSbzX8kBLANxFf1s8afpfN+mcMxEDo
X-Gm-Gg: AYBFou1Ouw0RGucUtpFrYaE+QkKxEQw9MW4Nz6ZkKi6aCrQa0aPHsxFDISXngjPZ+C+
	+Tqj/EuIFWxiT6nXqr7cGhLwUfeaBhN2KLMcjJwbpOjrvNMWMUZh6wkxBJspqiLSo0gMRLRk2lW
	8Rd14ki8IXcV/lthZzzcXrwLgc9h2FwN9byMOydp+Saho0Yo7w5eO6Cv2H1HPrBE8+Ryigiwfoa
	dhasDY+x1zIYpDSfwZFgf2aiy9BJTPhuTjIvm4pkyDcl+FRd21RgS/Rh6ipboyScDQTs+WW7iSo
	ofZgP6SMEbhF809pL+OqonW2MRNvJwLhuqdS2Ka8vcqxCBxR1xsvitZU1JlnHdQpn7oiIki7Jb3
	BrDkZUtZXlMIC1b6PMsLi5dqxof3lXTRk5oKilUTHCn65epFBwEJPk4bQS1tuG85MqEkUc9D9h6
	M8jziXLCjbWcqFz36lVv+AXu5RKo/dJkkutbC1HiHnZCW5fFKvtDct4zF/Gq1TV7FBWqrKQ9+gt
	b+3qjmlmgwS4B/2ifnfm8ycJaYpEJw=
X-Received: by 2002:a05:7301:12a:b0:33f:f57:c516 with SMTP id 5a478bee46e88-34270ac0463mr2217178eec.10.1790406097223;
        Sat, 26 Sep 2026 00:01:37 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:01:36 -0700 (PDT)
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
Subject: [PATCH v4 08/55] tests/qtest: prepare machine-list-test for combined qemu-system
Date: Sat, 26 Sep 2026 15:00:07 +0800
Message-ID: <20260926070057.1234-9-luoyonggang@gmail.com>
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

Each built qemu-system target checks its query-target arch and
query-machines names, including the none machine and omitting the
abstract pegasos parent. xen, vmapple, nitro, and x-remote appear
only when that host build has them. The lists in
machine-list-test.inc.h are shared for a later combined
qemu-system test.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/qtest/machine-list-test.c     |  94 +++
 tests/qtest/machine-list-test.inc.h | 876 ++++++++++++++++++++++++++++
 tests/qtest/meson.build             |   1 +
 3 files changed, 971 insertions(+)
 create mode 100644 tests/qtest/machine-list-test.c
 create mode 100644 tests/qtest/machine-list-test.inc.h

diff --git a/tests/qtest/machine-list-test.c b/tests/qtest/machine-list-test.c
new file mode 100644
index 00000000000..35fb365197d
--- /dev/null
+++ b/tests/qtest/machine-list-test.c
@@ -0,0 +1,94 @@
+/*
+ * Per-target machine list tests.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "libqtest.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
+
+/* query-target "arch" is SysEmuTarget, not always TARGET_NAME. */
+static const char *query_arch_for_target(const char *target_info)
+{
+    static const struct {
+        const char *target_name;
+        const char *arch;
+    } map[] = {
+        { "armeb", "arm" },
+        { "microblazeel", "microblaze" },
+        { "mips64el", "mips64" },
+        { "mipsel", "mips" },
+        { "ppc64le", "ppc64" },
+        { "sh4eb", "sh4" },
+        { "xtensaeb", "xtensa" },
+    };
+    size_t i;
+
+    for (i = 0; i < G_N_ELEMENTS(map); i++) {
+        if (!strcmp(target_info, map[i].target_name)) {
+            return map[i].arch;
+        }
+    }
+    return target_info;
+}
+
+#include "machine-list-test.inc.h"
+
+static QList *query_machine_names(QTestState *qts)
+{
+    QDict *resp;
+    QList *machines;
+    QList *names;
+    const QListEntry *e;
+
+    resp = qtest_qmp(qts, "{'execute': 'query-machines'}");
+    g_assert(qdict_haskey(resp, "return"));
+    machines = qdict_get_qlist(resp, "return");
+    g_assert_nonnull(machines);
+    names = qlist_new();
+    for (e = qlist_first(machines); e; e = qlist_next(e)) {
+        QDict *m = qobject_to(QDict, qlist_entry_obj(e));
+        const char *name;
+
+        g_assert_nonnull(m);
+        name = qdict_get_str(m, "name");
+        qlist_append_str(names, name);
+    }
+    qobject_unref(resp);
+    return names;
+}
+
+static void test_historic_machine_list(void)
+{
+    const char *target = qtest_get_arch();
+    const struct ShippedTarget *t = lookup_shipped_target(target);
+    QTestState *qts;
+    QDict *resp;
+    QDict *ret;
+    g_autoptr(QList) names = NULL;
+
+    qts = qtest_init("-nodefaults -M none");
+    read_accel_flags(qts);
+    resp = qtest_qmp(qts, "{'execute': 'query-target'}");
+    g_assert(qdict_haskey(resp, "return"));
+    ret = qdict_get_qdict(resp, "return");
+    g_assert_cmpstr(qdict_get_str(ret, "arch"), ==,
+                    query_arch_for_target(target));
+    qobject_unref(resp);
+    names = query_machine_names(qts);
+    if (t) {
+        assert_name_list(names, t->name, t->machines, t->n_machines);
+    }
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("machine-list", test_historic_machine_list);
+    return g_test_run();
+}
diff --git a/tests/qtest/machine-list-test.inc.h b/tests/qtest/machine-list-test.inc.h
new file mode 100644
index 00000000000..e6e6f3ea7cd
--- /dev/null
+++ b/tests/qtest/machine-list-test.inc.h
@@ -0,0 +1,876 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* Normal machine lists for every softmmu target. */
+/* Xen, vmapple, nitro, and x-remote stay in special_machine_map. */
+
+static const char * const aarch64_machines[] = {
+    "amd-versal-virt",
+    "amd-versal2-virt",
+    "anacapa-bmc",
+    "ast1030-evb",
+    "ast1040-evb",
+    "ast1060-evb",
+    "ast2500-evb",
+    "ast2600-evb",
+    "ast2700a1-evb",
+    "ast2700a2-evb",
+    "ast2700fc",
+    "axiado-scm3003",
+    "b-l475e-iot01a",
+    "bletchley-bmc",
+    "bpim2u",
+    "canon-a1100",
+    "catalina-bmc",
+    "collie",
+    "cubieboard",
+    "emcraft-sf2",
+    "fby35-bmc",
+    "fuji-bmc",
+    "g220a-bmc",
+    "gb200nvl-bmc",
+    "imx25-pdk",
+    "imx8mm-evk",
+    "imx8mp-evk",
+    "integratorcp",
+    "kudo-bmc",
+    "kzm",
+    "lm3s6965evb",
+    "lm3s811evb",
+    "max78000fthr",
+    "mcimx6ul-evk",
+    "mcimx7d-sabre",
+    "microbit",
+    "mori-bmc",
+    "mps2-an385",
+    "mps2-an386",
+    "mps2-an500",
+    "mps2-an505",
+    "mps2-an511",
+    "mps2-an521",
+    "mps3-an524",
+    "mps3-an536",
+    "mps3-an547",
+    "mps3-an555",
+    "musca-a",
+    "musca-b1",
+    "netduino2",
+    "netduinoplus2",
+    "none",
+    "npcm750-evb",
+    "npcm845-evb",
+    "nuri",
+    "olimex-stm32-h405",
+    "orangepi-pc",
+    "palmetto-bmc",
+    "quanta-gbs-bmc",
+    "quanta-gsj",
+    "quanta-q71l-bmc",
+    "rainier-bmc",
+    "raspi0",
+    "raspi1ap",
+    "raspi2b",
+    "raspi3ap",
+    "raspi3b",
+    "raspi4b",
+    "realview-eb",
+    "realview-eb-mpcore",
+    "realview-pb-a8",
+    "realview-pbx-a9",
+    "romulus-bmc",
+    "sabrelite",
+    "sanmiguel-bmc",
+    "sbsa-ref",
+    "smdkc210",
+    "stm32vldiscovery",
+    "supermicro-x11spi-bmc",
+    "supermicrox11-bmc",
+    "sx1",
+    "sx1-v1",
+    "tiogapass-bmc",
+    "versatileab",
+    "versatilepb",
+    "vexpress-a15",
+    "vexpress-a9",
+    "virt-10.0",
+    "virt-10.1",
+    "virt-10.2",
+    "virt-11.0",
+    "virt-11.1",
+    "virt-11.2",
+    "virt-6.0",
+    "virt-6.1",
+    "virt-6.2",
+    "virt-7.0",
+    "virt-7.1",
+    "virt-7.2",
+    "virt-8.0",
+    "virt-8.1",
+    "virt-8.2",
+    "virt-9.0",
+    "virt-9.1",
+    "virt-9.2",
+    "witherspoon-bmc",
+    "xilinx-zynq-a9",
+    "xlnx-zcu102",
+    "yosemitev2-bmc",
+};
+
+static const char * const alpha_machines[] = {
+    "clipper",
+    "none",
+};
+
+static const char * const arm_machines[] = {
+    "anacapa-bmc",
+    "ast1030-evb",
+    "ast1040-evb",
+    "ast1060-evb",
+    "ast2500-evb",
+    "ast2600-evb",
+    "b-l475e-iot01a",
+    "bletchley-bmc",
+    "bpim2u",
+    "canon-a1100",
+    "catalina-bmc",
+    "collie",
+    "cubieboard",
+    "emcraft-sf2",
+    "fby35-bmc",
+    "fuji-bmc",
+    "g220a-bmc",
+    "gb200nvl-bmc",
+    "imx25-pdk",
+    "integratorcp",
+    "kudo-bmc",
+    "kzm",
+    "lm3s6965evb",
+    "lm3s811evb",
+    "max78000fthr",
+    "mcimx6ul-evk",
+    "mcimx7d-sabre",
+    "microbit",
+    "mori-bmc",
+    "mps2-an385",
+    "mps2-an386",
+    "mps2-an500",
+    "mps2-an505",
+    "mps2-an511",
+    "mps2-an521",
+    "mps3-an524",
+    "mps3-an536",
+    "mps3-an547",
+    "mps3-an555",
+    "musca-a",
+    "musca-b1",
+    "netduino2",
+    "netduinoplus2",
+    "none",
+    "npcm750-evb",
+    "nuri",
+    "olimex-stm32-h405",
+    "orangepi-pc",
+    "palmetto-bmc",
+    "quanta-gbs-bmc",
+    "quanta-gsj",
+    "quanta-q71l-bmc",
+    "rainier-bmc",
+    "raspi0",
+    "raspi1ap",
+    "raspi2b",
+    "realview-eb",
+    "realview-eb-mpcore",
+    "realview-pb-a8",
+    "realview-pbx-a9",
+    "romulus-bmc",
+    "sabrelite",
+    "sanmiguel-bmc",
+    "smdkc210",
+    "stm32vldiscovery",
+    "supermicro-x11spi-bmc",
+    "supermicrox11-bmc",
+    "sx1",
+    "sx1-v1",
+    "tiogapass-bmc",
+    "versatileab",
+    "versatilepb",
+    "vexpress-a15",
+    "vexpress-a9",
+    "virt-10.0",
+    "virt-10.1",
+    "virt-10.2",
+    "virt-11.0",
+    "virt-11.1",
+    "virt-11.2",
+    "virt-6.0",
+    "virt-6.1",
+    "virt-6.2",
+    "virt-7.0",
+    "virt-7.1",
+    "virt-7.2",
+    "virt-8.0",
+    "virt-8.1",
+    "virt-8.2",
+    "virt-9.0",
+    "virt-9.1",
+    "virt-9.2",
+    "witherspoon-bmc",
+    "xilinx-zynq-a9",
+    "yosemitev2-bmc",
+};
+
+static const char * const avr_machines[] = {
+    "arduino-duemilanove",
+    "arduino-mega",
+    "arduino-mega-2560-v3",
+    "arduino-uno",
+    "none",
+};
+
+static const char * const hexagon_machines[] = {
+    "V66G_1024",
+    "V68N_1024",
+    "V81DGB_1",
+    "V81QA_1",
+    "none",
+    "virt",
+};
+
+static const char * const hppa_machines[] = {
+    "715",
+    "A400",
+    "B160L",
+    "C3700",
+    "none",
+};
+
+static const char * const i386_machines[] = {
+    "isapc",
+    "microvm",
+    "none",
+    "pc-i440fx-10.0",
+    "pc-i440fx-10.1",
+    "pc-i440fx-10.2",
+    "pc-i440fx-11.0",
+    "pc-i440fx-11.1",
+    "pc-i440fx-11.2",
+    "pc-i440fx-6.0",
+    "pc-i440fx-6.1",
+    "pc-i440fx-6.2",
+    "pc-i440fx-7.0",
+    "pc-i440fx-7.1",
+    "pc-i440fx-7.2",
+    "pc-i440fx-8.0",
+    "pc-i440fx-8.1",
+    "pc-i440fx-8.2",
+    "pc-i440fx-9.0",
+    "pc-i440fx-9.1",
+    "pc-i440fx-9.2",
+    "pc-q35-10.0",
+    "pc-q35-10.1",
+    "pc-q35-10.2",
+    "pc-q35-11.0",
+    "pc-q35-11.1",
+    "pc-q35-11.2",
+    "pc-q35-6.0",
+    "pc-q35-6.1",
+    "pc-q35-6.2",
+    "pc-q35-7.0",
+    "pc-q35-7.1",
+    "pc-q35-7.2",
+    "pc-q35-8.0",
+    "pc-q35-8.1",
+    "pc-q35-8.2",
+    "pc-q35-9.0",
+    "pc-q35-9.1",
+    "pc-q35-9.2",
+};
+
+static const char * const loongarch64_machines[] = {
+    "none",
+    "virt-11.1",
+    "virt-11.2",
+};
+
+static const char * const m68k_machines[] = {
+    "an5206",
+    "mcf5208evb",
+    "next-cube",
+    "none",
+    "q800",
+    "virt-10.0",
+    "virt-10.1",
+    "virt-10.2",
+    "virt-11.0",
+    "virt-11.1",
+    "virt-11.2",
+    "virt-6.0",
+    "virt-6.1",
+    "virt-6.2",
+    "virt-7.0",
+    "virt-7.1",
+    "virt-7.2",
+    "virt-8.0",
+    "virt-8.1",
+    "virt-8.2",
+    "virt-9.0",
+    "virt-9.1",
+    "virt-9.2",
+};
+
+static const char * const microblaze_machines[] = {
+    "none",
+    "petalogix-ml605",
+    "petalogix-s3adsp1800",
+    "xlnx-zynqmp-pmu",
+};
+
+static const char * const mips_machines[] = {
+    "malta",
+    "none",
+};
+
+static const char * const mips64_machines[] = {
+    "magnum",
+    "malta",
+    "none",
+    "pica61",
+};
+
+static const char * const mips64el_machines[] = {
+    "boston",
+    "fuloong2e",
+    "loongson3-virt",
+    "magnum",
+    "malta",
+    "none",
+    "pica61",
+};
+
+static const char * const mipsel_machines[] = {
+    "malta",
+    "none",
+};
+
+static const char * const or1k_machines[] = {
+    "none",
+    "or1k-sim",
+    "virt",
+};
+
+static const char * const ppc_machines[] = {
+    "40p",
+    "amigaone",
+    "bamboo",
+    "g3beige",
+    "mac99",
+    "mpc8544ds",
+    "none",
+    "pegasos1",
+    "pegasos2",
+    "ppce500",
+    "ppe42_machine",
+    "sam460ex",
+    "virtex-ml507",
+};
+
+static const char * const ppc64_machines[] = {
+    "40p",
+    "amigaone",
+    "bamboo",
+    "g3beige",
+    "mac99",
+    "mpc8544ds",
+    "none",
+    "pegasos1",
+    "pegasos2",
+    "powernv10",
+    "powernv10-rainier",
+    "powernv11",
+    "powernv8",
+    "powernv9",
+    "ppce500",
+    "ppe42_machine",
+    "pseries-10.0",
+    "pseries-10.1",
+    "pseries-10.2",
+    "pseries-11.0",
+    "pseries-11.1",
+    "pseries-11.2",
+    "pseries-6.0",
+    "pseries-6.1",
+    "pseries-6.2",
+    "pseries-7.0",
+    "pseries-7.1",
+    "pseries-7.2",
+    "pseries-8.0",
+    "pseries-8.1",
+    "pseries-8.2",
+    "pseries-9.0",
+    "pseries-9.1",
+    "pseries-9.2",
+    "sam460ex",
+    "virtex-ml507",
+};
+
+static const char * const riscv32_machines[] = {
+    "amd-microblaze-v-generic",
+    "none",
+    "opentitan",
+    "sifive_e",
+    "sifive_u",
+    "spike",
+    "virt",
+};
+
+static const char * const riscv64_machines[] = {
+    "amd-microblaze-v-generic",
+    "boston-aia",
+    "k230",
+    "microchip-icicle-kit",
+    "none",
+    "shakti_c",
+    "sifive_e",
+    "sifive_u",
+    "spike",
+    "tt-atlantis",
+    "virt",
+    "xiangshan-kunminghu",
+};
+
+static const char * const rx_machines[] = {
+    "gdbsim-r5f562n7",
+    "gdbsim-r5f562n8",
+    "none",
+};
+
+static const char * const s390x_machines[] = {
+    "none",
+    "s390-ccw-virtio-10.0",
+    "s390-ccw-virtio-10.1",
+    "s390-ccw-virtio-10.2",
+    "s390-ccw-virtio-11.0",
+    "s390-ccw-virtio-11.1",
+    "s390-ccw-virtio-11.2",
+    "s390-ccw-virtio-6.0",
+    "s390-ccw-virtio-6.1",
+    "s390-ccw-virtio-6.2",
+    "s390-ccw-virtio-7.0",
+    "s390-ccw-virtio-7.1",
+    "s390-ccw-virtio-7.2",
+    "s390-ccw-virtio-8.0",
+    "s390-ccw-virtio-8.1",
+    "s390-ccw-virtio-8.2",
+    "s390-ccw-virtio-9.0",
+    "s390-ccw-virtio-9.1",
+    "s390-ccw-virtio-9.2",
+};
+
+static const char * const sh4_machines[] = {
+    "none",
+    "r2d",
+};
+
+static const char * const sh4eb_machines[] = {
+    "none",
+    "r2d",
+};
+
+static const char * const sparc_machines[] = {
+    "LX",
+    "SPARCClassic",
+    "SPARCbook",
+    "SS-10",
+    "SS-20",
+    "SS-4",
+    "SS-5",
+    "SS-600MP",
+    "Voyager",
+    "leon3_generic",
+    "none",
+};
+
+static const char * const sparc64_machines[] = {
+    "niagara",
+    "none",
+    "sun4u",
+    "sun4v",
+};
+
+static const char * const tricore_machines[] = {
+    "KIT_AURIX_TC277_TRB",
+    "none",
+    "tricore_testboard",
+};
+
+static const char * const x86_64_machines[] = {
+    "isapc",
+    "microvm",
+    "none",
+    "pc-i440fx-10.0",
+    "pc-i440fx-10.1",
+    "pc-i440fx-10.2",
+    "pc-i440fx-11.0",
+    "pc-i440fx-11.1",
+    "pc-i440fx-11.2",
+    "pc-i440fx-6.0",
+    "pc-i440fx-6.1",
+    "pc-i440fx-6.2",
+    "pc-i440fx-7.0",
+    "pc-i440fx-7.1",
+    "pc-i440fx-7.2",
+    "pc-i440fx-8.0",
+    "pc-i440fx-8.1",
+    "pc-i440fx-8.2",
+    "pc-i440fx-9.0",
+    "pc-i440fx-9.1",
+    "pc-i440fx-9.2",
+    "pc-q35-10.0",
+    "pc-q35-10.1",
+    "pc-q35-10.2",
+    "pc-q35-11.0",
+    "pc-q35-11.1",
+    "pc-q35-11.2",
+    "pc-q35-6.0",
+    "pc-q35-6.1",
+    "pc-q35-6.2",
+    "pc-q35-7.0",
+    "pc-q35-7.1",
+    "pc-q35-7.2",
+    "pc-q35-8.0",
+    "pc-q35-8.1",
+    "pc-q35-8.2",
+    "pc-q35-9.0",
+    "pc-q35-9.1",
+    "pc-q35-9.2",
+};
+
+static const char * const xtensa_machines[] = {
+    "kc705",
+    "kc705-nommu",
+    "lx200",
+    "lx200-nommu",
+    "lx60",
+    "lx60-nommu",
+    "ml605",
+    "ml605-nommu",
+    "none",
+    "sim",
+    "virt",
+};
+
+static const char * const xtensaeb_machines[] = {
+    "kc705",
+    "kc705-nommu",
+    "lx200",
+    "lx200-nommu",
+    "lx60",
+    "lx60-nommu",
+    "ml605",
+    "ml605-nommu",
+    "none",
+    "sim",
+    "virt",
+};
+
+static const struct ShippedTarget {
+    const char *name;
+    const char *arch;
+    const char *endianness;
+    const char * const *machines;
+    size_t n_machines;
+} shipped_targets[] = {
+    { "aarch64", "aarch64", "little",
+      aarch64_machines, G_N_ELEMENTS(aarch64_machines) },
+    { "alpha", "alpha", "little",
+      alpha_machines, G_N_ELEMENTS(alpha_machines) },
+    { "arm", "arm", "little",
+      arm_machines, G_N_ELEMENTS(arm_machines) },
+    { "avr", "avr", "little",
+      avr_machines, G_N_ELEMENTS(avr_machines) },
+    { "hexagon", "hexagon", "little",
+      hexagon_machines, G_N_ELEMENTS(hexagon_machines) },
+    { "hppa", "hppa", "big",
+      hppa_machines, G_N_ELEMENTS(hppa_machines) },
+    { "i386", "i386", "little",
+      i386_machines, G_N_ELEMENTS(i386_machines) },
+    { "loongarch64", "loongarch64", "little",
+      loongarch64_machines, G_N_ELEMENTS(loongarch64_machines) },
+    { "m68k", "m68k", "big",
+      m68k_machines, G_N_ELEMENTS(m68k_machines) },
+    { "microblaze", "microblaze", "big",
+      microblaze_machines, G_N_ELEMENTS(microblaze_machines) },
+    { "mips", "mips", "big",
+      mips_machines, G_N_ELEMENTS(mips_machines) },
+    { "mips64", "mips64", "big",
+      mips64_machines, G_N_ELEMENTS(mips64_machines) },
+    { "mips64el", "mips64", "little",
+      mips64el_machines, G_N_ELEMENTS(mips64el_machines) },
+    { "mipsel", "mips", "little",
+      mipsel_machines, G_N_ELEMENTS(mipsel_machines) },
+    { "or1k", "or1k", "big",
+      or1k_machines, G_N_ELEMENTS(or1k_machines) },
+    { "ppc", "ppc", "big",
+      ppc_machines, G_N_ELEMENTS(ppc_machines) },
+    { "ppc64", "ppc64", "big",
+      ppc64_machines, G_N_ELEMENTS(ppc64_machines) },
+    { "riscv32", "riscv32", "little",
+      riscv32_machines, G_N_ELEMENTS(riscv32_machines) },
+    { "riscv64", "riscv64", "little",
+      riscv64_machines, G_N_ELEMENTS(riscv64_machines) },
+    { "rx", "rx", "little",
+      rx_machines, G_N_ELEMENTS(rx_machines) },
+    { "s390x", "s390x", "big",
+      s390x_machines, G_N_ELEMENTS(s390x_machines) },
+    { "sh4", "sh4", "little",
+      sh4_machines, G_N_ELEMENTS(sh4_machines) },
+    { "sh4eb", "sh4", "big",
+      sh4eb_machines, G_N_ELEMENTS(sh4eb_machines) },
+    { "sparc", "sparc", "big",
+      sparc_machines, G_N_ELEMENTS(sparc_machines) },
+    { "sparc64", "sparc64", "big",
+      sparc64_machines, G_N_ELEMENTS(sparc64_machines) },
+    { "tricore", "tricore", "little",
+      tricore_machines, G_N_ELEMENTS(tricore_machines) },
+    { "x86_64", "x86_64", "little",
+      x86_64_machines, G_N_ELEMENTS(x86_64_machines) },
+    { "xtensa", "xtensa", "little",
+      xtensa_machines, G_N_ELEMENTS(xtensa_machines) },
+    { "xtensaeb", "xtensa", "big",
+      xtensaeb_machines, G_N_ELEMENTS(xtensaeb_machines) },
+};
+
+/*
+ * Machines omitted from the normal lists. Merged in when @accel is
+ * present (NULL means no accel check) and the host matches (NULL
+ * host_os or host_cpu means any). xenfv is an alias of xenfv-4.2.
+ * aarch64 HVF (vmapple) is built only on an aarch64 Darwin host.
+ * nitro is Linux-only, on x86_64-softmmu for an x86_64 host and
+ * aarch64-softmmu for an aarch64 host. x-remote follows KVM on Linux
+ * when host_cpu is the host that builds KVM for that target.
+ */
+static const char * const xen_pc_machines[] = {
+    "xenpv",
+    "xenpvh",
+    "xenfv-4.2",
+};
+
+static const char * const xen_aarch64_machines[] = {
+    "xenpvh",
+};
+
+static const char * const hvf_aarch64_machines[] = {
+    "vmapple",
+};
+
+static const char * const nitro_machines[] = {
+    "nitro",
+};
+
+static const char * const x_remote_machines[] = {
+    "x-remote",
+};
+
+static const struct SpecialMachineMap {
+    const char *target;
+    const char *accel;
+    const char *host_os;
+    const char *host_cpu;
+    const char * const *machines;
+    size_t n_machines;
+} special_machine_map[] = {
+    { "i386", "xen", NULL, "x86_64",
+      xen_pc_machines, G_N_ELEMENTS(xen_pc_machines) },
+    { "i386", "xen", NULL, "aarch64",
+      xen_pc_machines, G_N_ELEMENTS(xen_pc_machines) },
+    { "x86_64", "xen", NULL, "x86_64",
+      xen_pc_machines, G_N_ELEMENTS(xen_pc_machines) },
+    { "x86_64", "xen", NULL, "aarch64",
+      xen_pc_machines, G_N_ELEMENTS(xen_pc_machines) },
+    { "aarch64", "xen", NULL, "aarch64",
+      xen_aarch64_machines, G_N_ELEMENTS(xen_aarch64_machines) },
+    { "aarch64", "hvf", "darwin", "aarch64",
+      hvf_aarch64_machines, G_N_ELEMENTS(hvf_aarch64_machines) },
+    { "x86_64", NULL, "linux", "x86_64",
+      nitro_machines, G_N_ELEMENTS(nitro_machines) },
+    { "aarch64", NULL, "linux", "aarch64",
+      nitro_machines, G_N_ELEMENTS(nitro_machines) },
+    { "i386", "kvm", "linux", "x86_64",
+      x_remote_machines, G_N_ELEMENTS(x_remote_machines) },
+    { "x86_64", "kvm", "linux", "x86_64",
+      x_remote_machines, G_N_ELEMENTS(x_remote_machines) },
+    { "aarch64", "kvm", "linux", "aarch64",
+      x_remote_machines, G_N_ELEMENTS(x_remote_machines) },
+    { "ppc", "kvm", "linux", "ppc64",
+      x_remote_machines, G_N_ELEMENTS(x_remote_machines) },
+    { "ppc64", "kvm", "linux", "ppc64",
+      x_remote_machines, G_N_ELEMENTS(x_remote_machines) },
+    { "s390x", "kvm", "linux", "s390x",
+      x_remote_machines, G_N_ELEMENTS(x_remote_machines) },
+    { "riscv64", "kvm", "linux", "riscv64",
+      x_remote_machines, G_N_ELEMENTS(x_remote_machines) },
+    { "loongarch64", "kvm", "linux", "loongarch64",
+      x_remote_machines, G_N_ELEMENTS(x_remote_machines) },
+};
+
+static const struct ShippedTarget *lookup_shipped_target(const char *name)
+{
+    size_t i;
+
+    for (i = 0; i < G_N_ELEMENTS(shipped_targets); i++) {
+        if (!strcmp(shipped_targets[i].name, name)) {
+            return &shipped_targets[i];
+        }
+    }
+    return NULL;
+}
+
+static bool have_xen;
+static bool have_hvf;
+static bool have_kvm;
+
+static const char *host_cpu(void)
+{
+#if defined(__aarch64__) || defined(_M_ARM64)
+    return "aarch64";
+#elif defined(__x86_64__) || defined(_M_X64)
+    return "x86_64";
+#elif defined(__powerpc64__)
+    return "ppc64";
+#elif defined(__s390x__)
+    return "s390x";
+#elif defined(__riscv) && __riscv_xlen == 64
+    return "riscv64";
+#elif defined(__loongarch64)
+    return "loongarch64";
+#else
+    return "other";
+#endif
+}
+
+static bool host_os_matches(const char *host_os)
+{
+    if (!host_os) {
+        return true;
+    }
+#if defined(CONFIG_LINUX)
+    return !strcmp(host_os, "linux");
+#elif defined(CONFIG_DARWIN)
+    return !strcmp(host_os, "darwin");
+#else
+    return false;
+#endif
+}
+
+static bool accel_present(const char *accel)
+{
+    if (!accel) {
+        return true;
+    }
+    if (!strcmp(accel, "xen")) {
+        return have_xen;
+    }
+    if (!strcmp(accel, "hvf")) {
+        return have_hvf;
+    }
+    if (!strcmp(accel, "kvm")) {
+        return have_kvm;
+    }
+    return false;
+}
+
+static bool host_cpu_matches(const char *want)
+{
+    if (!want) {
+        return true;
+    }
+    return !strcmp(want, host_cpu());
+}
+
+static bool special_applies(const struct SpecialMachineMap *s,
+                            const char *target)
+{
+    return !strcmp(s->target, target) &&
+           accel_present(s->accel) &&
+           host_os_matches(s->host_os) &&
+           host_cpu_matches(s->host_cpu);
+}
+
+static void assert_name_list(QList *names, const char *target,
+                             const char * const *expect, size_t n_expect)
+{
+    GHashTable *got = g_hash_table_new(g_str_hash, g_str_equal);
+    GHashTable *want = g_hash_table_new(g_str_hash, g_str_equal);
+    const QListEntry *e;
+    GHashTableIter iter;
+    gpointer key;
+    size_t i;
+
+    g_assert_nonnull(names);
+    for (e = qlist_first(names); e; e = qlist_next(e)) {
+        QString *qs = qobject_to(QString, qlist_entry_obj(e));
+
+        g_assert_nonnull(qs);
+        g_hash_table_add(got, (gpointer)qstring_get_str(qs));
+    }
+    for (i = 0; i < n_expect; i++) {
+        g_hash_table_add(want, (gpointer)expect[i]);
+    }
+    for (i = 0; i < G_N_ELEMENTS(special_machine_map); i++) {
+        const struct SpecialMachineMap *s = &special_machine_map[i];
+        size_t j;
+
+        if (!special_applies(s, target)) {
+            continue;
+        }
+        for (j = 0; j < s->n_machines; j++) {
+            g_hash_table_add(want, (gpointer)s->machines[j]);
+        }
+    }
+    g_hash_table_iter_init(&iter, got);
+    while (g_hash_table_iter_next(&iter, &key, NULL)) {
+        if (!g_hash_table_contains(want, key)) {
+            g_printerr("unexpected machine: %s\n", (const char *)key);
+        }
+    }
+    g_hash_table_iter_init(&iter, want);
+    while (g_hash_table_iter_next(&iter, &key, NULL)) {
+        if (!g_hash_table_contains(got, key)) {
+            g_printerr("missing machine: %s\n", (const char *)key);
+        }
+    }
+    g_assert_cmpuint(g_hash_table_size(got), ==, g_hash_table_size(want));
+    g_hash_table_unref(got);
+    g_hash_table_unref(want);
+}
+
+static void read_accel_flags(QTestState *qts)
+{
+    QDict *resp;
+    QDict *ret;
+    QList *present;
+    const QListEntry *e;
+
+    have_xen = false;
+    have_hvf = false;
+    have_kvm = false;
+    resp = qtest_qmp(qts, "{'execute': 'query-accelerators'}");
+    g_assert(qdict_haskey(resp, "return"));
+    ret = qdict_get_qdict(resp, "return");
+    present = qdict_get_qlist(ret, "present");
+    g_assert_nonnull(present);
+    for (e = qlist_first(present); e; e = qlist_next(e)) {
+        QString *qs = qobject_to(QString, qlist_entry_obj(e));
+        const char *name;
+
+        g_assert_nonnull(qs);
+        name = qstring_get_str(qs);
+        if (!strcmp(name, "xen")) {
+            have_xen = true;
+        } else if (!strcmp(name, "hvf")) {
+            have_hvf = true;
+        } else if (!strcmp(name, "kvm")) {
+            have_kvm = true;
+        }
+    }
+    qobject_unref(resp);
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 33f58b0e95c..8c53bb2e30e 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -23,6 +23,7 @@ qtests_generic = [
   'cdrom-test',
   'device-introspect-test',
   'machine-none-test',
+  'machine-list-test',
   'qmp-test',
   'qmp-cmd-test',
   'qom-test',
-- 
2.52.0.windows.1

