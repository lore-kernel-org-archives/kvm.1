Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935CC35E1A3
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 05:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057625; cv=none; b=hrdyJBCfCPrRa2axv4lvppH3xwULP+UNmtiBZvMSp2WUCGaLiR2qvVyrKJvbAzmH3xjmRPGjtNpW6q4GEdusJ8pV7aqcyiuiUwXlL+zjMhxjVmV+6O5kw9s9vsL1E8HScDb+KJHOx+piNcEFYHgVROFplAIUKULMbb1aUIQtQ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057625; c=relaxed/simple;
	bh=oeQZYiyhgFq2eVkoVeT1tGWrYZPG4NXl4cvC4qX3el8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=uyxlvKvX2xVuXmZLamDc4sMvazUuCsnubKZfGJF05Yqt0Gq1RP9hKSM1vARkaZ0tfpx7fjbBYWD4kCK4ACK5U2ZyFy+JVk3VPs5W0HHkwjhBfyXmvLyWH6i/zoqwf9nT30VxuAWGC4k6rfAzP12D0mmqC/t/yrAalyEdw5VCNZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=i78UPtYw reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="i78UPtYw"
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6635jove036784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 3 Jul 2026 14:46:05 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=851A/JXMMn6GwDOP12xrolOCWBX0QezLyRGo803/850=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1783057565; v=1;
        b=i78UPtYwoS8Yl2fhpzn5PGis683FaDaDFL+PekDANPIsFDBXeNKmJm3CiVouZctI
         G8kU/47ZeUOzatPzTDiHrlTeuynTeg4teCLQ7+IoksB68eJYyY/yj0tbnXwMQwjZ
         CqjktQeTrrw1oqaWFmhOsYMRQaJIWuoFcxAprCNtF4RW3/x6dul+SLbvm+m0zvh8
         U4JOAax+WHaJ5ysagNzNRfq0/ky6RXiGo3kL0XaZFcKoasQw1RC+korUrf7eLb6A
         NmSo+EONd2Ir5jk+NaQXY2P25tPw5wL6rB0pzgI00l/xKOLv2OtPLw04KIv4JqCv
         vp4pTUj4Y0e9+TW0ArdieA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 03 Jul 2026 14:45:36 +0900
Subject: [PATCH v5 5/8] i386/vmsr: Stop using qemu_get_local_state_dir()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-run-v5-5-4521ac5a149e@rsg.ci.i.u-tokyo.ac.jp>
References: <20260703-run-v5-0-4521ac5a149e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260703-run-v5-0-4521ac5a149e@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org,
        Yuval Shaia <yuval.shaia.ml@gmail.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Konstantin Kostiuk <kkostiuk@redhat.com>,
        Michael Roth <michael.roth@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
        Yan Vugenfirer <yan@daynix.com>, John Snow <jsnow@redhat.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
        kvm@vger.kernel.org,
        =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=3018;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=oeQZYiyhgFq2eVkoVeT1tGWrYZPG4NXl4cvC4qX3el8=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5a7z/SPswPmTuRUqrTceF/M1s37Tp3cx/XFCndf+P/wm
 MWg01HZUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMJGiSEaG3Yfnq8bqXVumcPF6
 5+WFdWtvfL9+8ujy1148yv6Fb+uP6zMyrNpm1Lzr4ZPp70Us9VY1CD/vsOVg2P5324aZ0w3+n1h
 9mAkA
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C

The qemu_get_local_state_dir() users only need the QEMU "run" directory,
but the Windows implementation is not suitable for that. It calls
g_get_system_data_dirs(), which in turn is documented as follows:

> On Windows it follows XDG Base Directory Specification if
> `XDG_DATA_DIRS` is defined.
> If `XDG_DATA_DIRS` is undefined,
> the first elements in the list are the Application Data
> and Documents folders for All Users. (These can be determined only
> on Windows 2000 or later and are not present in the list on other
> Windows versions.) See documentation for FOLDERID_ProgramData and
> FOLDERID_PublicDocuments.
>
> Then follows the "share" subfolder in the installation folder for
> the package containing the DLL that calls this function, if it can
> be determined.
>
> Finally the list contains the "share" subfolder in the installation
> folder for GLib, and in the installation folder for the package the
> application's .exe file belongs to.

Use get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run") for the vmsr
helper paths to allow removing it.

qemu_get_runtime_dir() is not appropriate here because it points to a
user-specific runtime directory, while the vmsr helper and QEMU are
typically run by different users and need to agree on the socket path.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 target/i386/kvm/vmsr_energy.c | 6 +++---
 tools/i386/qemu-vmsr-helper.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
index d24e827a214a..77f39ed12b98 100644
--- a/target/i386/kvm/vmsr_energy.c
+++ b/target/i386/kvm/vmsr_energy.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "vmsr_energy.h"
 #include "io/channel.h"
@@ -22,9 +23,8 @@
 
 char *vmsr_compute_default_paths(void)
 {
-    g_autofree char *state = qemu_get_local_state_dir();
-
-    return g_build_filename(state, "run", "qemu-vmsr-helper.sock", NULL);
+    return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR
+                              "/run/qemu-vmsr-helper.sock");
 }
 
 int is_rapl_enabled(void)
diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
index f12fd3c3e816..7c507695f571 100644
--- a/tools/i386/qemu-vmsr-helper.c
+++ b/tools/i386/qemu-vmsr-helper.c
@@ -62,10 +62,10 @@ static int gid = -1;
 
 static void compute_default_paths(void)
 {
-    g_autofree char *state = qemu_get_local_state_dir();
+    g_autofree char *run = get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run");
 
-    socket_path = g_build_filename(state, "run", "qemu-vmsr-helper.sock", NULL);
-    pidfile = g_build_filename(state, "run", "qemu-vmsr-helper.pid", NULL);
+    socket_path = g_build_filename(run, "qemu-vmsr-helper.sock", NULL);
+    pidfile = g_build_filename(run, "qemu-vmsr-helper.pid", NULL);
 }
 
 static int is_intel_processor(void)

-- 
2.54.0

