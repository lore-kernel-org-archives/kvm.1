Received: from mail-dy2-f39.google.com (mail-dy2-f39.google.com [74.125.229.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D1E24DD17
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169478; cv=none; b=uQZdNEZmRgZ6B2i0eJltsbvgpztu/jN0TICFqluplj9MhHgeay4HR1V992HC09RVLDImOivGlq2HAN131q8qvCO783Z7Zb2LC6H+cfgM7oRW0cquW8OQGP5aAxWweH9Uo129yQnjGfWTT1dO9L0xOdGv4LDkzJ8EbQyUtWGfcfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169478; c=relaxed/simple;
	bh=IdQoovfa6tQETuBnX/qoasXIF/hR4iVyKOkjFzhgIN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXz2ziQ6xZfcIzui/lN9yynkzwz71y9Y30akjCH1jkcP78kpZkSzMETGbSFVHwBfMbyit2s3y0vycfGhZ9bTj/IngRjjKBrJQNgUr3vqmOB3MuQ5OqdQxIvkz6mdGBXR5Dz6v4+KC4+GcawDAf9IAQdRek6hXv+/7Yii/LEI0vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qNWcqq1e; arc=none smtp.client-ip=74.125.229.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNWcqq1e"
Received: by mail-dy2-f39.google.com with SMTP id 5a478bee46e88-3346e75082eso421170eec.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169476; x=1790774276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sKNecRa3tzG6HeYVTRQDuQ00e5AIYSJOroCNurGi9rk=;
        b=qNWcqq1enV8D/JNirLZQ/Tk9KwBPswNBCWnCqhY5HY0sbOBiyEMIlDd5KQTD8PTpUV
         Ejs7EWTgJSejCXSbwdbfLHGKIKJ9Qr97kNBRtKxDQxu9DmzdkmMtVhBfeS1BRfRd58o0
         L0T2JdDYV/4c061XSgEL8OR5YAeiF0bnO79sacyyA2LuIQFLv0j0tdREIvlzK56+YE30
         SBXYvfC/9FYB10jFoVb8KUqG1UNItHTNekgB80WHn7qfqJpzza4hUSvEEZhyMZjy6diJ
         5VZrmtZvp0b5AxBHZrn3VRRpCq8/waGm/gJPL0e8evv/srBMzeX7eT7jsOd25IcgKc3f
         Wr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169476; x=1790774276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sKNecRa3tzG6HeYVTRQDuQ00e5AIYSJOroCNurGi9rk=;
        b=kqStH7yVQDciucODbApkBJf54VzbW9jU0BizEK5TJ2xRgY1YsaYdJiqkDX1+ZzR8p0
         6isHZE7wRGBpDQzcCjqlIkLiAtmqOoSVt5aBbC6LEiOpH1aDBDRbIUESwcPAVz4BDJMI
         jRPYUgga7Ts597aOn6ZpeEbzSL9fUOe8dSZ5U6PZmtozsHTCM/f/bJ5TihBWwPJnjAt1
         COw5MUDwhDwTah+MBfOtv72NDxJ4tlf9gtTT5UekZ5Z1Z0RvV4I/dhy2pu00B7L4mr0O
         JL1ZwHSIKER2Vr6g05+6HXdVHR5P0F8GVhdzjermoVtAlpRKcwyfF/y+DkrYB0TwmycX
         ZMtw==
X-Forwarded-Encrypted: i=1; AKwUvBzygZquP0xWe+ZRXTwcZ6gy324c2HaMF+ZVB6AlBXKCPT3o37Sa5C4+ye+/yiO5E8XB5fc=@vger.kernel.org
X-Gm-Message-State: AFuF++kgxAsaVzvFalJpI6DO4Kbk/L1ddyKbee4jYbECByTKHFC7RjtD
	1yr3Hb6QcUdhuzVdvcbQ311RdzI+9mznWw5+A7U6/W4Z2RBlbzczCR9l
X-Gm-Gg: AYBFou37xi3z+Fu703/aRuT70CkJntMkndAJURhxBda+/zgStuTXDtBetkyBrJzlTrW
	Ihfl8twTYcyl6CJAuWYkdvyZ/rmchl6Wutf5iLGC/1USSaoEmJcWN+j9aqmLK0reh4ozQ6Nv69W
	HKwGnhWAtUj3xZwDAEMnwpj6QfD9j2gDlotVZptKvCY9KfcHAV2mG7QwKT4zeP8SZHp+z8YJfvi
	Gw8Lhc0jl/MsWbznD+5HCeNWR8PWbmAbA3HxMS4GBTqrG5Ze4TOPmmcaqFhR59ipwgPdWt7Yywv
	vezNMCMQYLTGizMgPq8E4ABIWgJNLBSWO5uy3X3wm0IIrkIzEf1jTMWrb80vUOtcJYy2B9BKGeP
	ab0O73a5lfDXd5qHfCg1lU/wNhyDIvOOum7b8eoUXH+KhRZ8bTh0npBXMfu7q5O+QGV4BYt31U8
	r41e2GfRRz1seZgCQIMLCKVbH55Hg/bQ3aSekGO3qmv8g3iSarwTCFs452WezhWmiIVgt69Hucu
	yUjSq5mveG2y2lcIIxZ3oOOu2aRF7s=
X-Received: by 2002:a05:7301:db0c:b0:33b:96b8:3818 with SMTP id 5a478bee46e88-33e8ddbe14cmr1954620eec.32.1790169475447;
        Wed, 23 Sep 2026 06:17:55 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:17:52 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>,
	xen-devel@lists.xenproject.org,
	Chao Liu <chao.liu@processmission.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Fabiano Rosas <farosas@suse.de>,
	Xianglai Li <lixianglai@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	qemu-ppc@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bibo Mao <maobibo@loongson.cn>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	David Hildenbrand <david@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	qemu-riscv@nongnu.org,
	kvm@vger.kernel.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Song Gao <17746591750@163.com>,
	qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org,
	Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 007/114] vl: parse early options before target-info init
Date: Wed, 23 Sep 2026 21:14:41 +0800
Message-ID: <20260923131635.1894-8-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
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
index 0d52c5d0a46..dc883de8274 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2910,16 +2910,6 @@ void qemu_init(int argc, char **argv)
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
@@ -2938,6 +2928,16 @@ void qemu_init(int argc, char **argv)
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

