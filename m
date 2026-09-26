Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4D03876A9
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406087; cv=none; b=dLfpDvBQPPz1dtIhnJraRxvWkSwvHT0XQUp50MDpMEY5u12FIeIG+8bm2pGCN3ivnOF5e2sGkZrLWxPizRHwZixeDbM4atdUtZe7GDI0KPdIvYwyn+uIbf5AWMtGgDXcc5Zy1lblPUYbJwlFVX4SWRLN8lalQD9Ov6ztTGrkSyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406087; c=relaxed/simple;
	bh=xMraC30nHz6yPPqmR+HKPWZ+bFHA9TC2zwLwl9vX/+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQKthflEzMl5OErv7tT6e9To7qnRr25NSCNsvZ5YSBR09njr51epFCaabCoz1atfx20Jf1ZX8Z//HN4jhL+vUuu1VfJCuoiSZzl2X0Ek5pI9EkqENqeEnQzE4pxPKwQ/yNOkhnijTmmnzjYFKt0wMQ6qOn9OdJ9wn4GMXnBHloM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hB9V+2fL; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hB9V+2fL"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664ef791so901928eec.3
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406085; x=1791010885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NOaZ4jAlSCyjxqIHA0N9ZQnaaf/7JpAiIPWzPNATCyQ=;
        b=hB9V+2fLwf1Z+br/WN85aiAUtKJ8nt8OR31bZ7xmyOHzwH/EBK18xh/MSYljAciHmX
         wu7J6BCXFkbhKA/HE5YU8E7FFPnVK5om9/HCPZ32aTV8y65evRcA315FcdTR4mbM7i9D
         DmqLVAH5/6V4YUbRXcue+izuUfDpjEA/EPN6ggSYXRgkucdx6ciFh9UuXRu7TTCuTtoB
         E91ZVJ4lgJ5prvAnKBOMBjx1MrrR13/fWqFIdMiIPSO/POywSZxI7xSjpKaDT6K9sXQ9
         QjOpzvs2Sdmx252QbRJt4CTOjnLrO/T2IDorJl/p2+LoiDMcBN3yep2W3GCTjgb9xZ82
         UReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406085; x=1791010885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NOaZ4jAlSCyjxqIHA0N9ZQnaaf/7JpAiIPWzPNATCyQ=;
        b=icaQFipN+a9YSjn4Hxi/YQFHs+BDH9vfImH0aFkNu+MXukc8Ruhu+yIsaXaP7iYFaG
         YCZxNbEDCov1zeavRaAO84t/29SgU7Ks4fRWsJXi+g3NwxhUIPRiyrQ1Dbh32K8Vhx+f
         SMoHF/r7pk9OBTTGISyidG4ws3nmdb4YpdvGXZS5KKSaSwOeCon749LA4B2/l64nnLEu
         A9Z8GomWpScjfX8eXbTRoIRBe0EUaPY3oZeF9/NQwkyR3tZBSZVCHsNowMgKmG1imEp9
         2me+4+GOmTrKhu0ykXhxsLxmtfnJW/zyAZ9ohBX2EgkCQexylRjnrdac53mYslLvLQZe
         6+Fw==
X-Forwarded-Encrypted: i=1; AKwUvBwEi5Aw6P2y8wNFb3A0ydN3JzZVjBri0Ohhb+j7A+X3hZtn8uI27mKzMo1t7/vkliBZ3jM=@vger.kernel.org
X-Gm-Message-State: AFuF++msS2jH58J32EcBOSM07Rz8RfRi9stqT8R0ZrQmu1BAahc13ZSp
	fPlIEszI5I3X+ht7pH/4cwjGBedjhQs1yF/ACrhfQoptAFEqGEAST/4v
X-Gm-Gg: AYBFou1omCNy/bg7l8BUzjGFeC2qiMTESYdE/C5u3TFid03hax4Vvt7xR0uR1/4Nf/o
	8XQfsEPDpKqntZjB1EGdgG1LTMj6avtBdLVtW7HYM3OVzEnxqbXIPuuDI37Kt3/HyGROIv92Z+M
	GTciqGcigV0Tb2qRwEthYg9zvTmy+m3TArAUoZfOtfXXfkwfoJx63lSNkKgLB7sc24B5DIgLuBq
	FVinBkweaeGgLmrgWo+/g6oS3eC0cjXEdOVcMkkWu3QwoVkl020eHfW96J7Fox+b1aA9O/vAFVh
	d0W7tNJRaSnUY0vd1tLtSDi0d7C+iH/rXe83frt1ZPFTzirNB4DoiBLaPpC+Ns3Mqy1JumMO5zl
	q3zX3PzqqJH7hnQdRadFwNo0XJP+4FgJWu9LZPxErb2QaTcQH3LRi4JpmBzFbOxnMA5Jm1MqCqc
	Rx4pRM8QW+N+Ghxqt/VBcPI2EjEOyhqMLz3X/CPWfp6TNQ3TTYOZh4eYXOwvYPZwLWeExRSmStn
	4cQff1HEoP4CfMvwzTWpdr89OLK/mIf
X-Received: by 2002:a05:7300:a986:b0:328:7033:9b8c with SMTP id 5a478bee46e88-342711ac458mr3353958eec.6.1790406085251;
        Sat, 26 Sep 2026 00:01:25 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:01:24 -0700 (PDT)
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
Subject: [PATCH v4 05/55] vl: parse early options before target-info init
Date: Sat, 26 Sep 2026 15:00:04 +0800
Message-ID: <20260926070057.1234-6-luoyonggang@gmail.com>
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

Move the first argv pass ahead of MODULE_INIT_TARGET_INFO so later
target-info selection can use command-line options before QOM init.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 system/vl.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 468a9fc247a..3efa4968a20 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2912,16 +2912,6 @@ void qemu_init(int argc, char **argv)
     error_init(argv[0]);
     qemu_init_exec_dir(argv[0]);
 
-    os_setup_limits();
-
-    module_call_init(MODULE_INIT_TARGET_INFO);
-    target_info_qom_set_target();
-
-    module_init_info(qemu_modinfo);
-    module_allow_arch(target_name());
-
-    qemu_init_subsystems();
-
     /* first pass of option parsing */
     optind = 1;
     while (optind < argc) {
@@ -2940,6 +2930,16 @@ void qemu_init(int argc, char **argv)
         }
     }
 
+    os_setup_limits();
+
+    module_call_init(MODULE_INIT_TARGET_INFO);
+    target_info_qom_set_target();
+
+    module_init_info(qemu_modinfo);
+    module_allow_arch(target_name());
+
+    qemu_init_subsystems();
+
     machine_opts_dict = qdict_new();
     if (userconfig) {
         qemu_read_default_config_file(&error_fatal);
-- 
2.52.0.windows.1

