Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3021C34E766
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406095; cv=none; b=QXmAfY9cgfXeapUoC6oe4eNCGQpfvvKpEfk3NfSQp0Wi6sbfimP/VEuqwVKieLEQJfSBW1Bgekn8w/5meH7AIbtbqLg0YolEH1wqA9oyFfwJGGt/WLwMb8j7RUPRshhMqph7ri5gYXpm59JeJEcgdDaOcDKSKIVet+HK5M51aKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406095; c=relaxed/simple;
	bh=S0jdz59eAGjGSUYrEPgJyhWzHZrdTq0uaC1xHoj5TIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCUsvzYkh2IJUPg4tgLV58W82R+74IHlW1GV5GYTyDfZU9Q6r2uTS6gPkZIyiDFq3HtyrhI3LtCYImepAxncS6mnWYZrLBe+tVUID89ENw/u9f+F+LuXd3cnnWJ7E9/M88/5/jkdGfmJfmH/JPB0FLcO2CLUbnXDrejbY+2KG0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBb5oAfd; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBb5oAfd"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-3396cec93b6so1845897eec.3
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406093; x=1791010893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TZMKrJ9OTgOVuSw0xuj4IN8VaH3KKEmXiPudtyfK+aY=;
        b=HBb5oAfdHmiigP/SP8g/Vb2QfOlba9YelOg9iX1r5BTOBXijWfdPw8P/JTNMFtueoY
         0ZY+Pt89EkR0AiC3Fga2Xc8WHEKIeq7bCDKat1Mq1uU5JhwHqbVGExzde62rEMiDHroi
         yCzC8qHc9BDaH+mWI8G4qzSDuVvoakR/4CmRbvcBvx/TTNNWE/Z77cxhwMeysuj7R+12
         sqPdN4UHN41YhGPdi7usdLw+oYUbI+1AVTNHt0wQe41kHHUa4sZYyxEDGyweB/TxBPVQ
         3zFE4v640Gv0xD8dEBA0kyIZD7qmcA8SkbBXypCqebTQmdkz2JMNsZmNfRn9rd07vYgk
         tcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406093; x=1791010893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TZMKrJ9OTgOVuSw0xuj4IN8VaH3KKEmXiPudtyfK+aY=;
        b=Z9mmvBePgtVZ37OLj7ugGYtquw6xnZsVu4KCbYj6XQPLbb97zuJohwDTI7HyP7CW9A
         CDKr85NdHe4yFaIYpJOrzDByG1Zr4GD1TwnL4pekmbwt3U8yTHZfpzXKpsvsaLik8Nn8
         Alphk9cUYHKHSoCJ12Nwsqesx88kNqbzWNibsNos7nFVaH5esiM8vCXFOFT9EFtnpUI9
         FqeuOH9HQHGFgAILXR2My4do84skGpc2RnOB3m9EDN29e84BgydQSQ7bfkBKhGtv3WFL
         psVQ73wQPfB4X40Yrvu4uLktfOypbUBsFrBs0jmrv4k0/3TC8ngsHxidcUiTjjGhAvMW
         D5sg==
X-Forwarded-Encrypted: i=1; AKwUvBwMDV/eB7vr1Sqdn9aSDADCUZIESoJJ4bY3/QhQYgu7pV+mR3/cvYm+KG5badz1udzj8SA=@vger.kernel.org
X-Gm-Message-State: AFuF++nbwPbeXKogYGhk8QpJgEuEwxsd0w9sntDHlIEHiZtCWao2HzIp
	tfj0PNHAlzjr+UYYJttlmxO8Hk5s5Cvu8W7YkrajYYw6fCbaXENath7I
X-Gm-Gg: AYBFou1w5tj6C8kzUzR0wrGvN5P/uRLNPZvsw5nxAy3KO7NkMAmwXhxND+Wu5TYSDs3
	sHTgxEvEhbxX+eL8Kme5R6UXyRovsIiHTxhufhKXmaB7zn8Hb4NwrN6QAVDiYZOcowe3+eeh8TJ
	ULb9VkXfGMaR6VEUQrATqTzVud+cuM0UmHpwnLknRLyy7K5oeAjpoCPnWDaHp2IYnggf2LNX8NH
	wvGWRgDPWkUceRxncIj9+/Nrjh4ytl2dBV/ZzO8OFg8azhToslBx4ysB9DmKIQYEpzHeCGKKbvr
	HWrKS7oxXS6LAzmgSOd7uzYHbYwlkY8fK/yZEe/SUK/upq/ugPoimWWjmjkP69xMx1BSo7zk9/v
	sDUQtknwbrs9DXPC4V024/CEyGrg3PTU2cdEdz12YKpZ7TdfO6UthDawuZSsdN58myRBTasOSJF
	ZJVyQe9lZ1Ka56SzxmywNFFQC0y8nCEhB5uMbWImWqhMkpkgO3EpFMVjqo3QT6P8DGi9mug4U6B
	V9/XnO+g2xP9qIyXccBgnDkjyqgpYE=
X-Received: by 2002:a05:693c:26c2:b0:33e:3f5b:3ffa with SMTP id 5a478bee46e88-342700c4766mr2065592eec.10.1790406093187;
        Sat, 26 Sep 2026 00:01:33 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:01:32 -0700 (PDT)
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
Subject: [PATCH v4 07/55] tests/unit: add test-target-info
Date: Sat, 26 Sep 2026 15:00:06 +0800
Message-ID: <20260926070057.1234-8-luoyonggang@gmail.com>
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
index c404d222d9f..93237429713 100644
--- a/meson.build
+++ b/meson.build
@@ -4259,6 +4259,8 @@ endif
 
 traceable = []
 emulators = {}
+target_info_def = files('target-info-def.c')
+target_info_def_objects = {}
 foreach target : target_dirs
   config_target = config_target_mak[target]
   target_name = config_target['TARGET_NAME']
@@ -4330,7 +4332,7 @@ foreach target : target_dirs
     endif
   endif
 
-  arch_srcs += files('target-info-def.c')
+  arch_srcs += target_info_def
 
   if target_base_arch in target_arch
     t = target_arch[target_base_arch].apply(config_target, strict: false)
@@ -4408,6 +4410,8 @@ foreach target : target_dirs
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

