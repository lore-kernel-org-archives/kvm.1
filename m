Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5692F344046
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406228; cv=none; b=U2dg7xx1yzpxmZ81keL6Qshtmg1pwWoQQRf649XJBBAj/9HSZxHHjYRuvWUgvbqbZni5q9k3QUk9YVtddKDV2iC50VExl1coO86xem9XrDaBEGvEk+mdmzEmtdpc/Ea9r5bM+XX/9eEgwcPA6nwIi1sE8826LfRPD7s3xGVO7eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406228; c=relaxed/simple;
	bh=Myu0h/oGGm71+d6MNG+PuRJLfAc6S8eo/jrG8Hpolyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIXKp6nXNFuzDjtlwyxHTNDc8oBOJ3HnKud/ndvwMtQXfilGQDn1Ez78AAyonWe2wEGNmIvUSRLGjvz6qJzNo1cD48nwADoZzT5TPUj92brtpiXLus2vizQKnujMk6i2rUXOgHSeJQzBxKUT5/bCmSfcU/9DgUhjJpx9ZdskSXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7Pira4Z; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7Pira4Z"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d0522b4dso1978282eec.1
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406226; x=1791011026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rabEc0gRpcSRWEsbtg5lwnY1j5Y5VrXCH6Smb/etghU=;
        b=Z7Pira4Z19v/cgz4krrcp9Y05ia6JuwS2G8kpBdQbHrgcMO8N1QGySL7EIlDuWLwjV
         wQXm1YS+0Quj91d7NsI1NhXk3V+34iIAoPgnoJ/5qhIgha6Ck6qZZxGgmITTE1NMzmpK
         V/tndZJbJp/Pk3bNZp3ViluruNmFZM/g/HjT1380QL5PGEC9KqF4QPRJkbGW2nzDMSuh
         nFjaJDQZxepvtoWudkBkcjECwvt1kE68YKBMq0toNjFlKX7KKYg/sNv8OwGKu6e3mhZ2
         kGQhUAZlGncbbrZduqStlFrfYeDm7QhRlPti7+4f8bTlxk3tp+Kcm+FxgsgUQeZ6gD97
         VMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406226; x=1791011026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rabEc0gRpcSRWEsbtg5lwnY1j5Y5VrXCH6Smb/etghU=;
        b=qZOwJgjJjnjU58sfCj7qvtyraXUVbWqdBgpJ1Zw16IK3CU4LJWvW2hZcHwo25oc0U9
         cQbltaKRiwk5ih6lTpsCdXU6uQazg5bKM3p5vDiQJHvCKux0of2QGL/ShOM86DxXY35t
         BDhUqlr/U99n0iz7qdxf1XOmsDS12G1Kdshg3zIfvs9oWTSInasHKHeCP2O8c3jxW1uq
         6ZuSrR5dzi4r+VP2QHgSB6KxKA7+1ZShujujbUUbsgwpw9OpbMKotZk4uJ56DEoQ3ra/
         SErwXEvqoUdEZwgC6LE5++3ifJ5cA3Lt4qmf13TwxGMxSKjlZEWd5zHLgnWKl83mIjk/
         iG4g==
X-Forwarded-Encrypted: i=1; AKwUvBwCSU7EBeyhXJGlCX7VDh703vMwORa2YYG8oX/kzPW5g+t27OhvhZFNSTe7Urr/SVQYc20=@vger.kernel.org
X-Gm-Message-State: AFuF++naRNe74AoRPqjeSw7bhf2UAaKX7sWJWyxz5Mz65nSlistlQ2V3
	YwHfYgctCc5Lq/ltzds5OfGPC6E+5RhtF5N3bQvGd4vyCSl2gpzvwR4W
X-Gm-Gg: AYBFou0NBRuNFq7JHeOY051AU+DKlq+upyXl7Pd8xfaQplpQ+xhQKy15BFKf7cIzUVg
	btw3Ja5jhyZBPFtw5hQENWXs3D9S9sneDodsVS7H0xNo4bEuD284PMxubhUsyr07gkDFoWfM5TJ
	jz2F/G4+ddzWfHo60SeFu8b00qIQNpNHrmNVjOVT/wiBtMvUTOsW7JH51OhiXVpb/oQgUSZyIGE
	QSmEFiFHfMhJn9m1VkWoga21IfNksgUtoUr45rfQOHvSeHCjQR3xhMivyYBqJ+mgnbnv8eMXV8f
	cpOuI8RRyEw846SSTiAjGBRP+Bj4+1w0mfcaMoZRXZ0dk0dO1UW7nt/ZN20HN9Dd68qt+jxGkON
	JGfXrAtggaPYAVMLmv2MY4Ounpfcw1+yUa9uli3mzUinPrlWAlwfJLPBt2DqMHvZ4TNbakGU/t6
	sEdv7PybXo1piNJRGySOyBTpVqK1u+AO+5Ig/sgs3HuPJYqh3rC9MOHbcJT1+w+UVj3rkhA6FOM
	ICEggZGPUJagijqTbmVQjsReR1eCP4=
X-Received: by 2002:a05:7300:d20c:b0:339:7b3b:236d with SMTP id 5a478bee46e88-34270ebf074mr2032360eec.15.1790406226335;
        Sat, 26 Sep 2026 00:03:46 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:03:45 -0700 (PDT)
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
Subject: [PATCH v4 41/55] target-info: add SysEmuTarget none
Date: Sat, 26 Sep 2026 15:00:40 +0800
Message-ID: <20260926070057.1234-42-luoyonggang@gmail.com>
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

Add a none target for when no TargetInfo is selected. It is last
so existing SYS_EMU_TARGET_* values stay put, and it is not a
qemu-system- executable name. target_is_none() and target_none()
report that state.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info.h | 15 +++++++++++++++
 qapi/machine.json          | 13 +++++++++----
 target-info.c              | 10 ++++++++++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index a5dcf60dd9e..812e4b04a7b 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -90,6 +90,21 @@ bool target_big_endian(void);
  */
 bool target_is_any(const TargetInfo *ti);
 
+/**
+ * target_is_none:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns whether @ti is SYS_EMU_TARGET_NONE.
+ */
+bool target_is_none(const TargetInfo *ti);
+
+/**
+ * target_none:
+ *
+ * Returns: %true if the current TargetInfo is SYS_EMU_TARGET_NONE.
+ */
+bool target_none(void);
+
 /**
  * target_is_base_arm:
  * @ti: TargetInfo to inspect
diff --git a/qapi/machine.json b/qapi/machine.json
index b1be5608b61..6aaa2af709a 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -22,6 +22,10 @@
 # The individual target constants are not documented here, for the
 # time being.
 #
+# @none: no TargetInfo selected.  Not a qemu-system- executable name.
+#     Last enumerator so existing SYS_EMU_TARGET_* values stay put.
+#     (since 11.2)
+#
 # @rx: since 5.0
 #
 # @avr: since 5.1
@@ -30,9 +34,10 @@
 #
 # @hexagon: since 11.0
 #
-# .. note:: The resulting QMP strings can be appended to the
-#    "qemu-system-" prefix to produce the corresponding QEMU
-#    executable name.  This is true even for "qemu-system-x86_64".
+# .. note:: Except for ``none``, the resulting QMP strings can be
+#    appended to the "qemu-system-" prefix to produce the
+#    corresponding QEMU executable name.  This is true even for
+#    "qemu-system-x86_64".
 #
 # Since: 3.0
 ##
@@ -42,7 +47,7 @@
              'mips64el', 'mipsel', 'or1k', 'ppc',
              'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
              'sh4eb', 'sparc', 'sparc64', 'tricore',
-             'x86_64', 'xtensa', 'xtensaeb' ] }
+             'x86_64', 'xtensa', 'xtensaeb', 'none' ] }
 
 ##
 # @S390CpuState:
diff --git a/target-info.c b/target-info.c
index 1bdf3869605..b25e2ada438 100644
--- a/target-info.c
+++ b/target-info.c
@@ -112,6 +112,16 @@ bool target_is_any(const TargetInfo *ti)
     return true;
 }
 
+bool target_is_none(const TargetInfo *ti)
+{
+    return ti->target_arch == SYS_EMU_TARGET_NONE;
+}
+
+bool target_none(void)
+{
+    return target_is_none(target_info());
+}
+
 bool target_is_base_arm(const TargetInfo *ti)
 {
     switch (ti->target_arch) {
-- 
2.52.0.windows.1

