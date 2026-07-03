Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B258D3009D6
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057621; cv=none; b=M1kDtggkwj0mcsl2lCXPMr3hsIir/rNCE5pw+MqcwSB2vlWadYh142ABUU/HeFMUb6f4NU6xCpgXI3uklzyEqEdGM5M9a+26dTBgVJ5g7s+BDHVSPz21yWWJ/IMxo/cw2c2hcWKOTqzKdK1E0dTmp+H6t9Mw95F+eKVojVY52Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057621; c=relaxed/simple;
	bh=4PXnR6ZdLkaqz4pRFi//hI5Zh2wnip4Hz54KkyfWdsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=kyTCkjFwD3xZs4Up6DkSFN6eQ2ACjht864/TD57MadD1u23tX6mXhKJaarwBq2QlWtLuiVCs2KF5TuVyxhQ86kaCmEMhXkivOlN2ODfQAkE8v4mPzRmCnlm6OZqwS6WRZk9k2qGkZx0P4Rw3IR3n8IbzL9IXAL0XPRxL7Mdm9O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=ENHPtltn reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="ENHPtltn"
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6635jovf036784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 3 Jul 2026 14:46:06 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=8TGlRMXNgJkY6XRsWpl74qtD3NJg9sImsPCOCPuebGs=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1783057566; v=1;
        b=ENHPtltnRWQYbx7zoo3CzMmmOph0ygdocL8AZsLvd0IU6BW/+KxVQpF4qcjnWrVs
         oR8/sZeb4rcXR3sXpTIHjuW9J45pNc46V8mbrDqPYXcz/s7CTqpadn41OBOoDAUS
         yjo/StrN5DmYKJiQURcLupGbBqaNQrRVmxi1mfVHUJPhZGnP2vkAGQM8D1VpfdCg
         8fp+ZpfoUoUapZ2sFS+MqeMn/ijX9m7RiUYgV5aV8lg+xRyOXpqNFmD0+fHLc2ja
         bmowknJ398HSySysooyHB5UTO5jtfvpSEkEWKlsmM6aWFClLBmQc3Rr0j0CSUTA2
         FK3lTezkfrW3IpB4qgY46Q==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 03 Jul 2026 14:45:37 +0900
Subject: [PATCH v5 6/8] module: Use qemu_get_runtime_dir()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-run-v5-6-4521ac5a149e@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1463;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=4PXnR6ZdLkaqz4pRFi//hI5Zh2wnip4Hz54KkyfWdsk=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5a7zwzpir8bLjUYX5R8L/pYrzBw6+mFnALODF997DsSd
 Pq+3YnvKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmMjiDob/JUcN5I9KS2alVt7Y
 u+O768nMxk8mAZFXGWPmFDNKbw+sZGQ4Fz5h5nr9hP7V66+WCMZWrCzfuG3yn6xtwsLfFd+z+qj
 zAwA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C

qemu_get_runtime_dir() is used to construct the path to module upgrades.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/qemu/module.h | 2 +-
 util/module.c         | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index fccf017bf9e8..a22755c6f026 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -76,7 +76,7 @@ void module_call_init(module_init_type type);
  * directories searched are:
  * - getenv("QEMU_MODULE_DIR")
  * - get_relocated_path(CONFIG_QEMU_MODDIR);
- * - /var/run/qemu/${version_dir}
+ * - ${qemu_get_runtime_dir()}/qemu/${version_dir}
  *
  * prefix:         a subsystem prefix, or the empty string ("ui-", ..., "")
  * name:           name of the module
diff --git a/util/module.c b/util/module.c
index 09dc43f51eb3..eff64fa7ab0a 100644
--- a/util/module.c
+++ b/util/module.c
@@ -242,7 +242,8 @@ int module_load(const char *prefix, const char *name, Error **errp)
     version_dir = g_strcanon(g_strdup(QEMU_PKGVERSION),
                              G_CSET_A_2_Z G_CSET_a_2_z G_CSET_DIGITS "+-.~",
                              '_');
-    dirs[n_dirs++] = g_strdup_printf("/var/run/qemu/%s", version_dir);
+    g_autofree char *run = qemu_get_runtime_dir();
+    dirs[n_dirs++] = g_build_filename(run, "qemu", version_dir, NULL);
 #endif
     assert(n_dirs <= ARRAY_SIZE(dirs));
 

-- 
2.54.0

