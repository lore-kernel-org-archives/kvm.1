Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0F7530E06
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169507; cv=none; b=mN+1WF6hifbWeMuHVRXLFbT/NyCBqd3eblKuyUSBYCcAg4ZoKanyXxDT0rMnxpYRp8HuZp2U93HuiSjz6W84WcsSYfmhvZB720Xr+UGjC9hNPO+lKDmXElsFFBvZ7uKQ+O7TrzoPGNp6BNaMKUGnFbXCBQnsRqaO0MFDd0B3FsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169507; c=relaxed/simple;
	bh=xckM10wVc2GbtG1v2N6qzeBngK/KMiuGatYtUFaQsyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVvzggf7ruDYo3+QXjpMmTvoN/F9+R1areXMIROEiOzOSVbE0tnz3dfYPQnRlfVwxuSMl3PWV6VwtguCnyYQ0zuq7oebl0KYYykqi82iX8FHm5KQYWGElpQFr2PYGBGzBJStlhHMGwzaCMrkrSTPr4G59YrPET1q3dFjd9qX6go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMOVGIfP; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMOVGIfP"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04edb5so1431135c88.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169502; x=1790774302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yqkLIHs8nht5THiWcj2P453LN93rHp/TnF9wI3rp1V4=;
        b=fMOVGIfP3v5VNsujGE/inHCGj1WllsLY1d4B3xi3sIvpGzbdXOpAtEHmoM82n62RKj
         eseD9iTk06oUJCuSdbiERKjjP55r/GGUvvr/YDTjXZ7dQzdkZ29EWiS9Z+5dTcxrHnCg
         fEpjzHLthje6hMfbRRpk0H9ylz0+edyxVsK6BAHpD6rTGVd/SBDn5ScLAx1sOKITE4ef
         SmwBlFxM/n9P3ZKGzoowBtUkZzY0FgJtoejV3utPCWH1Z5yOL6eXf1X/MPXLyZvAzEUO
         Lf22Z/PqllZo4LvidL4EgDV4sMGgqwozDnRRVaV42WYENPm3WE1rVUKqN5Sv66gKpCJZ
         aYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169502; x=1790774302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yqkLIHs8nht5THiWcj2P453LN93rHp/TnF9wI3rp1V4=;
        b=0wiTWJcj8HN4WOSkQ8EIZaf4FgR4+ZtAabLDEwhBf3zyAjjZWBkyfB1wFvlSNEe9lg
         /+8oWeCutcMpq5jGRfcKw767yY7TBVMBlu9upJ6F4RzeGppC1JB7ZRibUmRZ70TiZzBI
         B/fCeNEssfa4W/R0p4jRcBNpjj633zs5JCTf5QZE+VgQ1/mi+zxCIlDqPG+XSTRODzPj
         vo2UgUnS2E+Qr3uY50dFZ3PkvOH/VGcDeMDr9NG4D4zRpGXMqa6twScEfPQJfk2NOV3o
         PYgnrLS9QbSG1nE14z3gnHNNsvP20d7ergcrK8HC58U337+KdrN/s0Z1BKpGR8OEP2fg
         W3Rg==
X-Forwarded-Encrypted: i=1; AKwUvByGhZwUzSEl+SOl/C/tqsgo0WjIKWl80NbVZwOpeZogOzrzka64hawh6t+jy9t0FxDNI9Y=@vger.kernel.org
X-Gm-Message-State: AFuF++n6SBr+DwtlTujlCL4gj8zviYuGS6pOlBRjHdcv1a/PFzr5f0R1
	Wv1zVwt0fRm/sbeV/YQppUKFNePmoWormkRYm1xybrBDHpymgbjvQJU8
X-Gm-Gg: AYBFou0gl5j6PxBLgPYEQcixCG0FcrlDOS1Ic8e/2IOrmdRrxQIF+KOcS8UQWN1rbbr
	DChO8+6fkcNTc3dgC44lKBypd092MFHP09L9+CUovS4C1Hmg+tpneK9e7b9bJltc5ETjjFReGOI
	Zf7o3xewAImMOlF6cYYXBIpLRtTlaBKeb+WzsbOiqtNuR8LBUCwF3UmNYLrerWSrexY2exewzsp
	/N3BtfX+CAYPPh2m0wabP2YUlzalcwvxwC/V/O57TO+v4Q1zhMTfs/hUaiiGMIXL0MPjs9/Ixhf
	xJKGy+AaHLnQIS5GOgm8TYPzbKfsrbEylNvkyX7IHaXQG1mGIyyW7d8yg/A7BSXwOTQJn3UW7Bj
	pM+kQKQsc2Gf6yRbqK2IsGs0dVaeNrr0oBuFcJC7bqseiuWyaV5ph1qW/btAsXwSa989Dd3f4a8
	3zVhN0bugPCXpFDeYIR7+Ttk8CjDEjjk2kj+HEgf6sg1urpFOxRQVBHxQVvj52e4SnCQJ46Yt75
	hXcXgh9uKwHSAtLT5B4/9SBhMWfN/d0YNh0c0sfig==
X-Received: by 2002:a05:7022:fa9:b0:143:2719:a501 with SMTP id a92af1059eb24-144f9173969mr4195539c88.40.1790169493859;
        Wed, 23 Sep 2026 06:18:13 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:18:12 -0700 (PDT)
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
Subject: [PATCH v3 009/114] tests/unit: add test-target-info
Date: Wed, 23 Sep 2026 21:14:43 +0800
Message-ID: <20260923131635.1894-10-luoyonggang@gmail.com>
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

Collect each target-info-def.c object in target_info_def_objects,
keyed by target dir. Link every value so constructors fill the
list. Assert target_info() is not NULL and target_info_list() has
one entry per linked object.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build                   |  6 +++++-
 tests/unit/meson.build        |  4 ++++
 tests/unit/test-target-info.c | 38 +++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)
 create mode 100644 tests/unit/test-target-info.c

diff --git a/meson.build b/meson.build
index 9a6a80fd0c8..776d38c5afd 100644
--- a/meson.build
+++ b/meson.build
@@ -4260,6 +4260,8 @@ endif
 
 traceable = []
 emulators = {}
+target_info_def = files('target-info-def.c')
+target_info_def_objects = {}
 foreach target : target_dirs
   config_target = config_target_mak[target]
   target_name = config_target['TARGET_NAME']
@@ -4331,7 +4333,7 @@ foreach target : target_dirs
     endif
   endif
 
-  arch_srcs += files('target-info-def.c')
+  arch_srcs += target_info_def
 
   if target_base_arch in target_arch
     t = target_arch[target_base_arch].apply(config_target, strict: false)
@@ -4409,6 +4411,8 @@ foreach target : target_dirs
                  c_args: c_args,
                  build_by_default: false)
 
+  target_info_def_objects += {target: lib.extract_objects(target_info_def)}
+
   if target.endswith('-softmmu')
     execs = [{
       'name': 'qemu-system-' + target_name,
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index e47bc7225ab..dc980a35955 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -43,6 +43,10 @@ tests = {
   'test-qgraph': ['../qtest/libqos/qgraph.c'],
   'check-qom-interface': [qom],
   'check-qom-proplist': [qom],
+  'test-target-info': [qom, declare_dependency(
+    objects: target_info_def_objects.values(),
+    compile_args: ['-DTARGET_INFO_DEF_COUNT=@0@'.format(
+      target_info_def_objects.values().length())])],
   'test-qemu-opts': [],
   'test-keyval': [testqapi],
   'test-logging': [],
diff --git a/tests/unit/test-target-info.c b/tests/unit/test-target-info.c
new file mode 100644
index 00000000000..e6de9b259e8
--- /dev/null
+++ b/tests/unit/test-target-info.c
@@ -0,0 +1,38 @@
+/*
+ * TargetInfo unit tests
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info.h"
+#include "qemu/target-info-def.h"
+
+static int target_info_list_count(void)
+{
+    TargetInfoNode *node;
+    int n = 0;
+
+    QLIST_FOREACH(node, target_info_list(), next) {
+        n++;
+    }
+    return n;
+}
+
+static void test_target_info_not_null(void)
+{
+    g_assert_nonnull(target_info());
+}
+
+static void test_target_info_list_count(void)
+{
+    g_assert_cmpint(target_info_list_count(), ==, TARGET_INFO_DEF_COUNT);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/target-info/not-null", test_target_info_not_null);
+    g_test_add_func("/target-info/list-count", test_target_info_list_count);
+    return g_test_run();
+}
-- 
2.52.0.windows.1

