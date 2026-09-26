Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CE05733E
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406278; cv=none; b=mPqovNFlcLpGSda7rMxUsMgc+zDGXgGy2UZo7Bm2cZrX69hgGB+P+95wvyhbBI0kn+TwcPuufXlMPGbDqnkBZeI4hVVl10oYPkplLLkiwNe6PORECPIe6d4sJ6p/WpNPdIlBKMeWw7ywR754ucw/YKcEJqW5bEKqno/7SSSnD7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406278; c=relaxed/simple;
	bh=a2o5DSkr9X6vJUf/fjcmJW5PzyoRa7CyMbnT204MLD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hgf7KDuYS/gNuR1ure42Ikt5iw1ZJx/ChbPEbH9/4cGGa5mFRVHuQAbWH7DnjKm6vJLHSYnPlKbZPO2b1ijCUgHEjJSMckroEtU+8nqPmz9K43tECxXrMMVODnuQZpAFX5jegHBx7xii4ymisNijYEisLezEo9JAuKe5RakDsP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oMhCoDwu; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMhCoDwu"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-34182b58d00so864491eec.2
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406276; x=1791011076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Q4keI4TP8YVH/qoyQSJo+GdMMgFJJFdW1/lFaTcTQw=;
        b=oMhCoDwuGgAnTpP0Qh3MqGXns4u4qYbjNNMh6SRX6QEtHwKmirlPPEEKorg3dtw49w
         YwrVVUEvKYVwTvjjIk6EG2NBk4RDqrS2tkRC6mEhWD5hjCJIDDrj0x2RYCS2bvY447u7
         8OGLQUu4Ji00V4PUxyWzx/Y9jP59f2vLsHznRNOUKQ2Go9tgwS/1vz/91wYnN161taMn
         QCN+4Wn1OXKaEnZmaBAvrWm5pUiyYIdGI6EoIcc//rMH4Po2OqCCKQbz39RWspghaTao
         yLLk4QEH0cSauWWHcxCymy9xbUj/W+e4glGRiMq7fVYgOqYAWmBOSg0JDQD11bn3NMSk
         1UPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406276; x=1791011076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Q4keI4TP8YVH/qoyQSJo+GdMMgFJJFdW1/lFaTcTQw=;
        b=Zxwf1Kbgh0CQ8Bfc7NSo1+jcrLL30CFBTG7enlvlk+shEhzOs7+l5IGQyHfdYDpr2a
         wO78gpK4BU+J0Vi3QYERm08SgP2Dl5CFQXe7QDNT2ct4ny2k5sm1xe1qzUwdt4ALKKGU
         kekEpc7HrK5y3WPKkGFMvOwmmqh6ya4WPff+P26dJWwVFuycYkMeCPsO6QzGw2ga0n6g
         227n1hBgMp2ug4Ojn8JMNLSTH8/SFCIJAWrSkGS/SKyeKAZsCbaaYg+45hYLgHxKIU8e
         YvTpr6YIOBgciTlZqxIpAFNBKaH6Z3BnjEe0uiMwjNlZSxGa7/Qn0htFRpROoSKUMcZU
         8Gcg==
X-Forwarded-Encrypted: i=1; AKwUvBxUDCPn6eMq2kfvbSEM4ZdrMigzd4a1YzaPnhQxuqtOxnyHmbShIcJyV/EMP4DxgNO6ugk=@vger.kernel.org
X-Gm-Message-State: AFuF++kLBkWqNxacWcKo8GGvswtLq8GMvEUgFtZ3YVueqKetle/8QlMs
	LustUfR3vEiBaDe/9fGuPQbicJbjR248s5CdwmeoB8VXV4Oo2IKlcRAU
X-Gm-Gg: AYBFou2ZT4ubDgP/b2WzPUKoefxtZmCA7/ECtcWIc63qTU0xKr8xqS23B56R5klBeJ3
	e6GQ1i6sT+vCja6tlMb80SJEp9nL4LUilPeI7gudIFLZIzzl/4WgIpf7vZXK1eNz9+II7xgSfq5
	9lwz4p8DUhiiXzdnZImj6W3Ly6OOlMOOf7sN7nEbYgCdhIJM2GIsxkNRPBHJ7Q488QKD05UyU9M
	SwGYrD6WqUrbGMq806a99V8auReFHGsD+LxuufsKiUXQFWRfL6mmD69PGxYOCJ8u395e+uPdck5
	EBHf0jyCFv16XE9UrDuiYGCI9t4EJEeEoJjRtPuRPDYXDRMYAAgxVrNGuKgLrgFn+6G7IUFYiCx
	1YEK/e8rtLM0jwDp7v/o9yAmmsW9vBLLMFKPvVxq5mV33sjVdEncOXK612X+ag0HFkJffQ+uuJs
	hgyO0Ge3b5JmRUJ6ssTDRENnPA88O3SzFaConDSVNDuUdVqjCKTkFfccxQpMF1PXcdlst5T0Nh4
	B+r75UB18Cut5Qz9934IBoI6yHDJEdkgr5VsX2rPg==
X-Received: by 2002:a05:693c:8807:20b0:33b:e264:362a with SMTP id 5a478bee46e88-3427169e0acmr2042711eec.13.1790406276353;
        Sat, 26 Sep 2026 00:04:36 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:04:35 -0700 (PDT)
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
Subject: [PATCH v4 54/55] hw/arm: set aarch64-only machine TypeInfo.is_available
Date: Sat, 26 Sep 2026 15:00:53 +0800
Message-ID: <20260926070057.1234-55-luoyonggang@gmail.com>
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

Set TypeInfo.is_available to target_is_aarch64 on sbsa-ref,
versal leaves, xlnx-zcu102, imx8mp-evk, npcm845, axiado-scm3003,
and ARM xen-pvh.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/arm/ax3000-evk.c       | 1 +
 hw/arm/imx8mp-evk.c       | 1 +
 hw/arm/npcm8xx_boards.c   | 1 +
 hw/arm/sbsa-ref.c         | 1 +
 hw/arm/xen-pvh.c          | 1 +
 hw/arm/xlnx-versal-virt.c | 2 ++
 hw/arm/xlnx-zcu102.c      | 1 +
 7 files changed, 8 insertions(+)

diff --git a/hw/arm/ax3000-evk.c b/hw/arm/ax3000-evk.c
index a1708488710..0c3e53e4e7d 100644
--- a/hw/arm/ax3000-evk.c
+++ b/hw/arm/ax3000-evk.c
@@ -21,6 +21,7 @@ static const TypeInfo ax3000_evk_types[] = {
         .name          = MACHINE_TYPE_NAME("axiado-scm3003"),
         .parent        = TYPE_AX3000_MACHINE,
         .class_init    = axiado_scm3003_class_init,
+        .is_available  = target_is_aarch64,
     }
 };
 
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 3f376f86d91..bac2f9cbedf 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -159,6 +159,7 @@ static const TypeInfo imx8mp_evk_machine_types[] = {
         .name = TYPE_IMX8MPEVK_MACHINE,
         .parent = TYPE_MACHINE,
         .class_init = imx8mp_evk_machine_class_init,
+        .is_available = target_is_aarch64,
         .instance_init = imx8mp_evk_machine_init,
         .instance_size = sizeof(FslImx8mpEvkState),
     },
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 4b3af165034..67b10843d88 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -248,6 +248,7 @@ static const TypeInfo npcm8xx_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("npcm845-evb"),
         .parent         = TYPE_NPCM8XX_MACHINE,
         .class_init     = npcm845_evb_machine_class_init,
+        .is_available   = target_is_aarch64,
     },
 };
 
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 158b461eb48..426fa914e80 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -945,6 +945,7 @@ static const TypeInfo sbsa_ref_info = {
     .instance_finalize = sbsa_ref_instance_finalize,
     .class_init    = sbsa_ref_class_init,
     .instance_size = sizeof(SBSAMachineState),
+    .is_available  = target_is_aarch64,
 };
 
 static void sbsa_ref_machine_init(void)
diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index f05956c1662..d9515f23e3b 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -95,6 +95,7 @@ static const TypeInfo xen_arm_machine_type = {
     .class_init = xen_arm_machine_class_init,
     .instance_size = sizeof(XenPVHMachineState),
     .instance_init = xen_arm_instance_init,
+    .is_available = target_is_aarch64,
 };
 
 static void xen_arm_machine_register_types(void)
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 4018f2bf7d1..c02aa011916 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -401,12 +401,14 @@ static const TypeInfo versal_virt_machine_init_typeinfo = {
     .name       = TYPE_XLNX_VERSAL_VIRT_MACHINE,
     .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
     .class_init = versal_virt_machine_class_init,
+    .is_available = target_is_aarch64,
 };
 
 static const TypeInfo versal2_virt_machine_init_typeinfo = {
     .name       = TYPE_XLNX_VERSAL2_VIRT_MACHINE,
     .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
     .class_init = versal2_virt_machine_class_init,
+    .is_available = target_is_aarch64,
 };
 
 static void versal_virt_machine_init_register_types(void)
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index bb596218540..03b03b8317c 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -302,6 +302,7 @@ static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
     .class_init = xlnx_zcu102_machine_class_init,
     .instance_init = xlnx_zcu102_machine_instance_init,
     .instance_size = sizeof(XlnxZCU102),
+    .is_available = target_is_aarch64,
 };
 
 static void xlnx_zcu102_machine_init_register_types(void)
-- 
2.52.0.windows.1

