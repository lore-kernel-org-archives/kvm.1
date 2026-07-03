Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E1C3563E1
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057621; cv=none; b=fI2CFSz+uD5yHviH+0CiblZKoB7XZfbs8t0QcEbvbLmD8DL8E+kJEvfpMNUO4PFB0HJQlGFjmSQPlVzOPoYpyTbYvykU8OenkMCXLn44ZAbRp13AP7zewb+Uk78JBkaz/SJVVAAP0+g+DIOCCf8EXUnSA5rEjRAFkpSFeSGjvPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057621; c=relaxed/simple;
	bh=0QIwFy8bP77AKijAc2rWm/vQXhRd9FL/+60FhfkdcVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=p4dKvBziZ/Er7909RhtKn6pSRs4Us405yVO4JdiJ/2jufUhTMHzaUnJyBtnV8g12Kuuut553OCVWraxv+HkQ2+58IKvqbIhfKPuJyDwPioQAiHFr03Q6FSGtBD9oPt3yHkfFrd03C1UG7YZMjVY34CmvKZ857bNUdWmjY+D4Pj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=EaQ5rD4Q reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="EaQ5rD4Q"
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6635jovc036784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 3 Jul 2026 14:46:05 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=AHPqD+tIyvCHf3qXm6SUnzMux+ljEiTqoyGn4fIigmE=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1783057565; v=1;
        b=EaQ5rD4QME4Y6T4PNn79HZe6/AMCFKkVexl82lrxW/xH2oIhzVEPuLDKsit3dfNA
         8NjNuVJN0G1CQXByhQqECRsnq6HjqrQ9N34bs146NLtyC7Q416tujnB6zlN1vpxS
         E6cZHoa1udTptlZyDTcDHHNbzkQWaHI+BXWXg/owslV4pWpLey43q202FCkwqn+6
         5GOVCyrHXHvr+PxqsYUahPc81bC8/8YkqQlEU4xuyam/8JCh+u/JrYuu/Orz63gg
         Oycn1yTbf1NwenkRjOcGNxHh715g/8/fKmyVDYRYalCQbBN6JClWnaxwa0VeYqOr
         aNC5THDiD/aKG9NFfOQsMw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 03 Jul 2026 14:45:34 +0900
Subject: [PATCH v5 3/8] qga: Use qemu_get_runtime_dir()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-run-v5-3-4521ac5a149e@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3665;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=0QIwFy8bP77AKijAc2rWm/vQXhRd9FL/+60FhfkdcVY=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5a7z5SraqZHZnpsvdvj9zrCZl+udcEWPQ/OjAO85SWyr
 R6WW6d0lLIwiHExyIopsqQU7ebWiK79VJgQ3wIzh5UJZAgDF6cATIT5D8P/3F/sL01XPAoKtu5f
 8D/hkXJorOzf2L1JWz9OuydbsFZVkeGf6hlPj8yF6stvVITfX2Wc8IalI/2D1CXlU3d9TgR/Pfi
 RDwA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C

qemu_get_runtime_dir() is used to construct the default state directory.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 docs/conf.py             | 2 ++
 docs/interop/qemu-ga.rst | 5 +++--
 docs/meson.build         | 6 +++++-
 qga/main.c               | 8 ++++----
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index 7e35d2158d30..cafe8fd37b59 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -169,9 +169,11 @@
 # environment variable is not set is for the benefit of readthedocs
 # style document building; our Makefile always sets the variable.
 confdir = os.getenv('CONFDIR', "/etc/qemu")
+localstatedir = os.getenv('LOCALSTATEDIR', "/var/local")
 
 vars = {
     "CONFDIR": confdir,
+    "LOCALSTATEDIR": localstatedir,
     "VER_MACHINE_DEPRECATION_VERSION": ver_machine_deprecation_version,
     "VER_MACHINE_DELETION_VERSION": ver_machine_deletion_version,
 }
diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
index d16cc1b9f078..c9b0a7b387f2 100644
--- a/docs/interop/qemu-ga.rst
+++ b/docs/interop/qemu-ga.rst
@@ -72,7 +72,8 @@ Options
 
 .. option:: -f, --pidfile=PATH
 
-  Specify pid file (default is ``/var/run/qemu-ga.pid``).
+  Specify pid file (default is ``$XDG_RUNTIME_DIR/qemu-ga.pid`` or
+  |LOCALSTATEDIR|\ ``/run/qemu-ga.pid``).
 
 .. option:: -F, --fsfreeze-hook=PATH
 
@@ -86,7 +87,7 @@ Options
 .. option:: -t, --statedir=PATH
 
   Specify the directory to store state information (absolute paths only,
-  default is ``/var/run``).
+  default is ``$XDG_RUNTIME_DIR`` or |LOCALSTATEDIR|\ ``/run``).
 
 .. option:: -v, --verbose
 
diff --git a/docs/meson.build b/docs/meson.build
index a8d893681ecd..89a707a77b8a 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -4,7 +4,11 @@ sphinx_build = find_program(fs.parent(python.full_path()) / 'sphinx-build',
 # Check if tools are available to build documentation.
 build_docs = false
 if sphinx_build.found()
-  SPHINX_ARGS = ['env', 'CONFDIR=' + qemu_confdir, sphinx_build, '-q', '-j', 'auto']
+  SPHINX_ARGS = [
+    'env',
+    'CONFDIR=' + qemu_confdir, 'LOCALSTATEDIR=' + get_option('localstatedir'),
+    sphinx_build, '-q', '-j', 'auto'
+  ]
   # If we're making warnings fatal, apply this to Sphinx runs as well
   if get_option('werror')
     SPHINX_ARGS += [ '-W', '-Dkerneldoc_werror=1' ]
diff --git a/qga/main.c b/qga/main.c
index fd19c7037db1..215541ee86c9 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -48,7 +48,7 @@
 #define QGA_VIRTIO_PATH_DEFAULT "/dev/virtio-ports/org.qemu.guest_agent.0"
 #endif /* CONFIG_BSD */
 #define QGA_SERIAL_PATH_DEFAULT "/dev/ttyS0"
-#define QGA_STATE_RELATIVE_DIR  "run"
+#define QGA_STATE_RELATIVE_DIR  ""
 #else
 #define QGA_VIRTIO_PATH_DEFAULT "\\\\.\\Global\\org.qemu.guest_agent.0"
 #define QGA_STATE_RELATIVE_DIR  "qemu-ga"
@@ -157,12 +157,12 @@ static void stop_agent(GAState *s, bool requested);
 static void
 init_dfl_pathnames(void)
 {
-    g_autofree char *state = qemu_get_local_state_dir();
+    g_autofree char *run = qemu_get_runtime_dir();
 
     g_assert(dfl_pathnames.state_dir == NULL);
     g_assert(dfl_pathnames.pidfile == NULL);
-    dfl_pathnames.state_dir = g_build_filename(state, QGA_STATE_RELATIVE_DIR, NULL);
-    dfl_pathnames.pidfile = g_build_filename(state, QGA_STATE_RELATIVE_DIR, "qemu-ga.pid", NULL);
+    dfl_pathnames.state_dir = g_build_filename(run, QGA_STATE_RELATIVE_DIR, NULL);
+    dfl_pathnames.pidfile = g_build_filename(run, QGA_STATE_RELATIVE_DIR, "qemu-ga.pid", NULL);
 }
 
 static void quit_handler(int sig)

-- 
2.54.0

