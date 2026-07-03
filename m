Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64153290D9
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 05:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057622; cv=none; b=TVcdtS84CdpS69p+GpgPCH4YPrueDDLoSj8rlQC0mPSMKmpOehgSt3Ok2XMSEnn5Zhr9iZ00BOh9EYKclyOhmXssGhntoa34jbIX7KqNVyNBP/jlgpnTI86hS3UlH6NGrpKvy/ujNlEkJ7EPqaD+fUNcH/rjnNGnnsMXKPMnpLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057622; c=relaxed/simple;
	bh=K0UJNUosHhV8leUj3w42aWRtcOxU75tjw8UPDyAhTPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=hpXZubFlM/17h8v/iES4R1KJ4hApxROjMGI4JCngE31TcSmx4dP9atjo9cDAMKTr674US+o26xLS4qUEMeXN4H9IXcF+0md2mKHZIUzu+kvqwG9h7yRuRYyPALggEpWYLtbf3Hpwb4jCBF/eURBDM1KtzHidG3FnwUR5ydpWWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=ol/yOEFX reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="ol/yOEFX"
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6635jovg036784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 3 Jul 2026 14:46:06 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=EqLrzd0wk4wQt8kZtdYvKx4Ux02VoKxLULvtV8vK5iI=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1783057566; v=1;
        b=ol/yOEFXkLqxZKT138XTi0RPqzGWeSdUAsXKXdg8GCzTlVKDN3rng6sex4AqrqaQ
         2hGk/cB8ScfhVDWi8QjLiRJWzcgWwEuxlrR3hKRwMFt6L1/4/2ZjB/I4ZXn2QjiY
         6QPwojJ/sPvsiByGAg2GaR1lQ5RekGPd1CDMwjvhJ2ngkwg0EHVkALJoLa3IO77a
         kzXNrLz1qD9FIqHTCFiiLa0hVhwS9FokETKVTp7RcRDjh2mH8JV3wvyfea2jMsrx
         EYjZ7xkgB5kKv1rQH6xrav7C7ecgmNPwna30gYBfR+Zon9p1whnmos6+9DTFJXnF
         tMKfokQ55sJGCH7ayy09FQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 03 Jul 2026 14:45:38 +0900
Subject: [PATCH v5 7/8] util: Remove qemu_get_local_state_dir()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-run-v5-7-4521ac5a149e@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=K0UJNUosHhV8leUj3w42aWRtcOxU75tjw8UPDyAhTPQ=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5a7z8xXT0L25769+ybs1lPvbx9nKl9pe3m8+sPfo5Vnv
 u7icUnL7ihlYRDjYpAVU2RJKdrNrRFd+6kwIb4FZg4rE8gQBi5OAZhI7TJGhoeNouIlgTc25R8q
 zph9K4jt9BIJXqbdYWK9ai9jz5U942FkmPQnM5jvFudNnecWPsamYXe4NpUfnyrFPft4w5zLsnE
 m7AA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C

There are no users of the function anymore.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/qemu/osdep.h |  8 --------
 util/oslib-posix.c   |  6 ------
 util/oslib-win32.c   | 10 ----------
 3 files changed, 24 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index d64cebdf5ec5..47436e0e027f 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -709,14 +709,6 @@ bool qemu_set_blocking(int fd, bool block, Error **errp);
  */
 void qemu_clear_cloexec(int fd);
 
-/* Return a dynamically allocated directory path that is appropriate for storing
- * local state.
- *
- * The caller is responsible for releasing the value returned with g_free()
- * after use.
- */
-char *qemu_get_local_state_dir(void);
-
 /**
  * qemu_get_runtime_dir:
  *
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index d03399063999..69db96ab9556 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -314,12 +314,6 @@ void qemu_clear_cloexec(int fd)
     assert(f != -1);
 }
 
-char *
-qemu_get_local_state_dir(void)
-{
-    return get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR);
-}
-
 char *
 qemu_get_runtime_dir(void)
 {
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 5887cea12aec..e052f3a9deb1 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -230,16 +230,6 @@ int qemu_get_thread_id(void)
     return GetCurrentThreadId();
 }
 
-char *
-qemu_get_local_state_dir(void)
-{
-    const char * const *data_dirs = g_get_system_data_dirs();
-
-    g_assert(data_dirs && data_dirs[0]);
-
-    return g_strdup(data_dirs[0]);
-}
-
 char *
 qemu_get_runtime_dir(void)
 {

-- 
2.54.0

