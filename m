Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1106C25F98B
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 05:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057615; cv=none; b=LRVo9gfcqJOEpnFqMG6dvlocKiT/eEX11AzcvAUDw3mu1CRYc7gA6NjEMVKmElynstzDZXKfVlyViRZA/dF8M8O5NfDrrvgjU2XkDJK6jJ83gX3dmlw9yn1fFwN/iO5HEt59IpbM83Q1NonkaHh1cNP72jC/+SiRzJJn7fh1fAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057615; c=relaxed/simple;
	bh=yO+U2c7zRXebZJzvW3yCcCzOsc5WOosru64nAuxYfww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=hK/uxZZyfUVr7kkBgdtSUbQAzQZwwVv2Pd38xoZnWg2qC7IUJ3ti36Rv+bSR5qBq1kLVELYf4t0LE0ForJwQU8GPag7xnokWovu6L9uRfNisGdN6qA4Lonf3eyoKO2Gd6+YwhYTNDLyffVaX7PMcwrYseI3r1PKe3cgLjoQARpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=jtxf5DgE reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="jtxf5DgE"
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6635jovh036784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 3 Jul 2026 14:46:06 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=pf6Se3sLDfz0Xq2tO+kn72qyQWuqHruYyof/nnnUeQs=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1783057566; v=1;
        b=jtxf5DgEI/nrPr6cez8FWXdAApcO9poYnBW/XsCEeYbbrawyBgHmzEtk+b5Oa21Y
         lenWwZkqJ1HNBoJTyNAyaUn9CgUEcz9NPVBcKxZ0YhP0Ofh0YIZmv2OvbVaUrw3R
         4eo5wqXIm9Vwy5RgXwluxM5wBD5m5xFV7KUAwkXO1j2NvZXDqVp2nLD855RZuOK1
         RPdHKlXOdyihq/PthUaLPKYzGA0GRR2bXb/G6x5ursdAPyn9+iMdDhXnzsTw74RH
         QqsuTk7hMkldrFZaVZ0pFccHEsDIYkeUq4h39C1RcCEary0koMslZ6wWXu2NypQb
         469UyCEyVXGAiMqgW2L2cA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 03 Jul 2026 14:45:39 +0900
Subject: [PATCH v5 8/8] spice-app: Use qemu_get_runtime_dir()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-run-v5-8-4521ac5a149e@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=942;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=yO+U2c7zRXebZJzvW3yCcCzOsc5WOosru64nAuxYfww=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5a7z6wdZ66r2joYpOz7xnuLqa1cPH+R5MUfh77e/Lz05
 YpLkitPdZSyMIhxMciKKbKkFO3m1oiu/VSYEN8CM4eVCWQIAxenAExk01dGhpkNG79NW5p3aq7G
 S075KCMe/eK3h2ddFtyu8PjMeqUrU3Yz/I/+zHaM2Uh8yeqE2XPzl5suMdHn7b51X9/swdHp71S
 3p3ECAA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C

qemu_get_runtime_dir() provides QEMU-specific fallback of runtime
directory.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/spice-app.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/spice-app.c b/ui/spice-app.c
index 0df7325e6792..4bc00961b58f 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -149,8 +149,8 @@ static void spice_app_display_early_init(DisplayOptions *opts)
     atexit(spice_app_atexit);
 
     if (qemu_name) {
-        app_dir = g_build_filename(g_get_user_runtime_dir(),
-                                   "qemu", qemu_name, NULL);
+        g_autofree char *run = qemu_get_runtime_dir();
+        app_dir = g_build_filename(run, "qemu", qemu_name, NULL);
         if (g_mkdir_with_parents(app_dir, S_IRWXU) < 0) {
             error_report("Failed to create directory %s: %s",
                          app_dir, strerror(errno));

-- 
2.54.0

