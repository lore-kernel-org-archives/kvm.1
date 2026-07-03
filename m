Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5C43438BE
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 05:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057617; cv=none; b=dKccV5XgGA/MJkFpNeYxUYjimijZEejxd8UJIvESPrSxWTnlz04mOrp1qwpQl5vYqTWxG2En8bolBoIEs5RSQGXQlcZ2iz6e2wJk1G1lX7NG01bZz/D9mUdtfJTpHqYn3zOmtwmHRgJIPKTEnxlaIZag1OS1g6FSHXrOS3dvKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057617; c=relaxed/simple;
	bh=dMm50xffZzydEvZmAnq95wWWm43dv6hh+L1xlYY2L7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=glTS0cymjBvr64RLg3bWyYwLXv9Rsaf8YvT+9OwnuAs6ApYD3BZiOm9XbXOhowE14ppY78RK3SLY19JWqle6XowLOkfsAQ6SFALPo9vcxkCPKsDAJYrm6L3f1WGvM51hJLryvqlBavnGxpBs7b531OzAHmn+mWvf10siq8uA86A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=LX3PEIsr reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="LX3PEIsr"
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6635jovd036784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 3 Jul 2026 14:46:05 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=gyPlnHk7ZCfzpCSpANopo+J6AuVgQP9h8XedmCtcNnQ=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1783057565; v=1;
        b=LX3PEIsr3BpeOS3RXHyKoiPGOLqfD6NBpPCiVuR31XcFWWCbW5uUQpdegBKFqtgp
         lvEAjqiX/yyoOGl43Wr/ef/BXRsyUSvcOmKJi76P1iUgBbEMPquZRiYQLwUde2/K
         njBzVf2YWXqUMh7ZPiYpLN1Io6XCeC9PuVTVE0Po+qGzZqT/W8ExKjlE1WR7Zi30
         CrNTLqSj8fPXxzL6Fw4zj7Y5qp8jtgmRSwAWWnQdJTBlQeJH+FG97zyAPynMs74i
         QCd91hL3faEA00kzrNSo34GsbFAV5sYtZWDEEoaRv8AUGbrhMj6Wl+LbQu879mhK
         8NKEI9NsgPQGPFhGyIdtOA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 03 Jul 2026 14:45:35 +0900
Subject: [PATCH v5 4/8] scsi: Use qemu_get_runtime_dir()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-run-v5-4-4521ac5a149e@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=dMm50xffZzydEvZmAnq95wWWm43dv6hh+L1xlYY2L7U=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5a7z7T8BKva8CT/QL2ot1OWhn/mty3qt6nkm91ju61Aq
 XPj+tSOUhYGMS4GWTFFlpSi3dwa0bWfChPiW2DmsDKBDGHg4hSAibzVZWS4PGGxJc9TrXvmgduX
 i/6Yvefjy8m8d2ddvX3hrpqziKDzc0aGDme7LxsUNs6U3sHWWpzI/vJld29uFefplIPvDl7K9T/
 IAwA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C

qemu_get_runtime_dir() is used to construct the default paths.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 docs/tools/qemu-pr-helper.rst | 8 ++++----
 scsi/qemu-pr-helper.c         | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/docs/tools/qemu-pr-helper.rst b/docs/tools/qemu-pr-helper.rst
index c32867cfc611..f92e2463f10f 100644
--- a/docs/tools/qemu-pr-helper.rst
+++ b/docs/tools/qemu-pr-helper.rst
@@ -61,14 +61,14 @@ Options
 .. option:: -f, --pidfile=PATH
 
   PID file when running as a daemon. By default the PID file
-  is created in the system runtime state directory, for example
-  :file:`/var/run/qemu-pr-helper.pid`.
+  is created in ``$XDG_RUNTIME_DIR/qemu-pr-helper.pid`` or
+  |LOCALSTATEDIR|\ ``/run/qemu-pr-helper.pid``.
 
 .. option:: -k, --socket=PATH
 
   path to the socket. By default the socket is created in
-  the system runtime state directory, for example
-  :file:`/var/run/qemu-pr-helper.sock`.
+  ``$XDG_RUNTIME_DIR/qemu-pr-helper.sock`` or
+  |LOCALSTATEDIR|\ ``/run/qemu-pr-helper.sock``.
 
 .. option:: -T, --trace [[enable=]PATTERN][,events=FILE][,file=FILE]
 
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 9dcd3ec7111e..3412fa3abbd2 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -76,10 +76,10 @@ static int gid = -1;
 
 static void compute_default_paths(void)
 {
-    g_autofree char *state = qemu_get_local_state_dir();
+    g_autofree char *run = qemu_get_runtime_dir();
 
-    socket_path = g_build_filename(state, "run", "qemu-pr-helper.sock", NULL);
-    pidfile = g_build_filename(state, "run", "qemu-pr-helper.pid", NULL);
+    socket_path = g_build_filename(run, "qemu-pr-helper.sock", NULL);
+    pidfile = g_build_filename(run, "qemu-pr-helper.pid", NULL);
 }
 
 static void usage(const char *name)

-- 
2.54.0

