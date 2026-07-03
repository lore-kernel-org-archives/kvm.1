Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8D332913
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 05:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057623; cv=none; b=f40G1SfgpNor4sdr8bbH5tREDxdE5JhnwoF4OZobHo68KaBxPXPYelQKCQAQBHPmyX9Uq1aAUM+r6as+g3XwgV8fX0pnqKUEGJACAaVFQ83DGuRZEf5ZaSIvePu76ukxIrvtRGb60izxpuCYE2S+L8qA/oF1nqdT+0kUvsJEpko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057623; c=relaxed/simple;
	bh=4d8cXS9YftrwQFC8xCGeMmjDzLSKcWSgalJtbZonIDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=n2mGLxihBpeKi90yn9kQNuBTo09eLX5b2eHDwmnQ9wRIvuiAdkTdCddp/0G/UFUcG8MIvX+QjmtXfQY+ym5spRWQbR8ADRsXubCPz6etK0NmOOTYGLfV6vH4RguaIUiv1XOCW/4DvlNgMZLT+kip4lUJlPIiEsKOiKnGVqE/GoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=GsmHVyj4 reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="GsmHVyj4"
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6635jova036784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 3 Jul 2026 14:46:04 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=QKsWJTVxPAFdG2x8XAo/TkAAjK3FW3F4furqsjUadh8=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1783057564; v=1;
        b=GsmHVyj4XiMOUDAKs17CAxbJ9g86xmyL7iJxzsEDWgyi2h7VpuoNwKVYK2eJyvtT
         nwLRWX0PKvuX3VXmNkYQQXsUuDb11+znK8y6DLNJzwP/XhOsnLzLampS9t+S1C1B
         CRivdrjNyuK6ZQj73valPteBJC+XznAWaF9SvxPlFIzZ1ogUUSD1gEiB5NhJwnoU
         WxNM4TINHPpGZul2SsGEhktOrbCjGs6/GXF5nS/JDf3J6/MSX9xMSQNadLQZzuT6
         FKok0CJgNFsHUpOHS8Tv4zbR48US6grdpgqx7x1PLcOgZj1s2nmSyiwkuH6Xkanx
         IPI6+WLOlQEOGdwn/kkoiA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 03 Jul 2026 14:45:32 +0900
Subject: [PATCH v5 1/8] util: Introduce qemu_get_runtime_dir()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-run-v5-1-4521ac5a149e@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4378;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=4d8cXS9YftrwQFC8xCGeMmjDzLSKcWSgalJtbZonIDA=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5a7z6RzVgrrSqSz42/FbViv+z9iXWTCVV9RQUGV37dOR
 p7nuKPTUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMJHdfIwMW8sVi+PX35o2zYVZ
 Y/4Z5g1XZbKO7b0q+cZ8MTvnVqlMAYY//JWzzuZX7z360K0oad38kmdbPKda7G/50Hf0YviH4Nz
 njAA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C

qemu_get_runtime_dir() returns a dynamically allocated directory path
that is appropriate for storing runtime files. It corresponds to "run"
directory in Unix.

With a tree-wide search, it was found that there are several cases
where such a functionality is implemented so let's have one as a common
utility function.

This function tries to resolve the following in order:
- $XDG_RUNTIME_DIR
- The "LocalAppData" folder on Windows
- get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")

$XDG_RUNTIME_DIR may be useful even for executables that require root
privileges since they may run in a Linux namespace created by a normal
user who cannot write the system runtime directory.

This function does not use qemu_get_local_state_dir() or its logic
for Windows. Actually the implementation of qemu_get_local_state_dir()
for Windows seems not right as it calls g_get_system_data_dirs(),
which checks $XDG_DATA_DIRS. In Unix terminology, it is basically
"/usr/share", not "/var", which qemu_get_local_state_dir() is intended
to provide.

This function does not use g_get_user_runtime_dir() either.
g_get_user_runtime_dir() falls back to g_get_user_cache_dir(), which
has different semantics. Instead of silently using a cache directory,
qemu_get_runtime_dir() eventually falls back to the system runtime
directory. This also naturally lets system users use the system runtime
directory. A user who wants to use a user-specific directory has to
set $XDG_RUNTIME_DIR or continue to supply application-specific command
line options.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/qemu/osdep.h | 12 ++++++++++++
 util/oslib-posix.c   | 11 +++++++++++
 util/oslib-win32.c   | 28 ++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 1ec5b42230be..d64cebdf5ec5 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -717,6 +717,18 @@ void qemu_clear_cloexec(int fd);
  */
 char *qemu_get_local_state_dir(void);
 
+/**
+ * qemu_get_runtime_dir:
+ *
+ * Return a dynamically allocated directory path that is appropriate for storing
+ * runtime files. It corresponds to "run" directory in Unix, and uses
+ * $XDG_RUNTIME_DIR if available.
+ *
+ * The caller is responsible for releasing the value returned with g_free()
+ * after use.
+ */
+char *qemu_get_runtime_dir(void);
+
 /**
  * qemu_getauxval:
  * @type: the auxiliary vector key to lookup
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index dc001da66dd4..d03399063999 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -320,6 +320,17 @@ qemu_get_local_state_dir(void)
     return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR);
 }
 
+char *
+qemu_get_runtime_dir(void)
+{
+    char *env = getenv("XDG_RUNTIME_DIR");
+    if (env) {
+        return g_strdup(env);
+    }
+
+    return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run");
+}
+
 void qemu_set_tty_echo(int fd, bool echo)
 {
     struct termios tty;
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 5f3e8f4d9801..5887cea12aec 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -27,6 +27,8 @@
  */
 
 #include "qemu/osdep.h"
+#include <shlobj.h>
+#include <wchar.h>
 #include <windows.h>
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
@@ -238,6 +240,32 @@ qemu_get_local_state_dir(void)
     return g_strdup(data_dirs[0]);
 }
 
+char *
+qemu_get_runtime_dir(void)
+{
+    PWSTR wpath;
+    const wchar_t *cwpath;
+    size_t size = GetEnvironmentVariableA("XDG_RUNTIME_DIR", NULL, 0);
+
+    if (size) {
+        char *env = g_malloc(size);
+        GetEnvironmentVariableA("XDG_RUNTIME_DIR", env, size);
+        return env;
+    }
+
+    if (!SHGetKnownFolderPath(&FOLDERID_LocalAppData, KF_FLAG_DEFAULT, NULL,
+                              &wpath)) {
+        cwpath = wpath;
+        size = wcsrtombs(NULL, &cwpath, 0, &(mbstate_t){0}) + 1;
+        char *path = g_malloc(size);
+        wcsrtombs(path, &cwpath, size, &(mbstate_t){0});
+        CoTaskMemFree(wpath);
+        return path;
+    }
+
+    return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run");
+}
+
 void qemu_set_tty_echo(int fd, bool echo)
 {
     HANDLE handle = (HANDLE)_get_osfhandle(fd);

-- 
2.54.0

