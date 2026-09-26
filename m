Received: from mail-dy2-f29.google.com (mail-dy2-f29.google.com [74.125.229.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6009234DB41
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406266; cv=none; b=OQ9ayM8aeKLRo8mUX5aZsE++YLIkh7M0WN1QFo5UT9yPaNU6NbZWncOpf2oj5pf0GxvMbJ5/kYzOxXeAY1oVeuxJvoavqf/F0z2K0vg3Y0LZe0A1xf8x6+Xh/TjallMu8ozY2MMWxZDGytmX6yHQmWC6F+R6ic0z03tRoS1YgAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406266; c=relaxed/simple;
	bh=Pk7USaznz2qmZGOY4XXIneKytEwGMiHqsL6qEJLtUVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vByJbLmx+ukYdZJjhSIYINhW29cob5Q0Iq9wkS8grc3ouwtOgR0oLTFOLn1MICr4X6ypHKB44EGDgQTEDl/tZSWZlOwzNPtrI1ZZjR3cen4LUcWAjPHQ8RGwVyk1gUQohkO4wibaTgfoeEtqpst7/NWMbRvJxHzUBWAY30IwEDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/6KUCim; arc=none smtp.client-ip=74.125.229.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/6KUCim"
Received: by mail-dy2-f29.google.com with SMTP id 5a478bee46e88-3427493501eso504231eec.1
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406264; x=1791011064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xBSqXEkr1ev4UBbYnYTwgul/tvqRWOfBQ9ClBL2I6+g=;
        b=Y/6KUCimiJ8rGvu0KhXNlFayH7bQtMjoPTadkkM46xrfembf9ETzVdAwDfiZjazwg9
         dPA7SBJ7n3We4XsyNoVvjZcwJs/rr2PNJRBeKLWJs/koKyozG2mgHixbSNzuaWm7YS9U
         /ZHNsyBSM8cjZWbyL95q3lgZ7d0RDU35eJInp2ccxi2oBy0kwoeS3U7gug9Zb6wzL+yu
         JPc1wceuxmzxDzBkDF0YGznIsnAUPQAEW5IeyL1oDNrtjRk8aTdUf7DLQ+ykqd4ykWzP
         mXrp5eAkVA8aMZLkbGXj4qYk8RzB6FCCZSUbUPgx0mOdHFvDGYk8kHTiKDHKJqCuDsxh
         jKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406264; x=1791011064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xBSqXEkr1ev4UBbYnYTwgul/tvqRWOfBQ9ClBL2I6+g=;
        b=eiR4IANXYxR8SgnMh6G/iNMMp3e0VZSl6ovRqYPIbIemCF5BLEn9IpENwmbfiQaMRu
         QPmX8rtHZuE+NDtiLAX/JoncMi09+55m5NrVYeRjGJJwkTtL630xBzDgf3OCoCwLt3Dd
         Fynxe3CqXsRHkzZtaNs1U+l9fJFPO9KilztjEqGXOMhxfN/hJ1do7ZO2fO2QxFo5En8Y
         oZmLKLfgA/crJQChJatP5XEvKHiNmDOXWqjMbFyCCJuWkcbf1JM9mO37oguV1oeCveZw
         fq4GS+nuPyb5e6BG34buGDOKr0HWZBNbTvkgK1RkoGd0D9THDw+VWzwuVp3Xjv0o//Ka
         UDjA==
X-Forwarded-Encrypted: i=1; AKwUvByLVQ3ZvnZOhYBhfYY9XXxItU/H2xhlboiwHLsb9IT8lFmGsozFB+EXmRB0wsPVCeagh9c=@vger.kernel.org
X-Gm-Message-State: AFuF++l671duepgiDpEozbTZ3TgF9prcLemw4nFb7rJnXPiMcttl7AO9
	uFjyVV84tT8A2RlY5Xk4bmHuUGxFvrqTYynGEyOMutlOaK4WIXQrH0QR
X-Gm-Gg: AYBFou1z1/sMpDWZJdAoTAiN+UHVu/ZnEMt8s3gAbykFgmorYkdHW+BQ9NxT8AcNyuK
	zl6+ZQAJySdrcB0TtsOEYGFuyQ3r5TDVtIHpsIlAIyN0pQ/DF6TTkriozkuqmmG/kUEgXqhRash
	GEkApH2mMDOmLcJ3uo+L5D8O6Cj1FlSj9rtYvyJbySbcrW1el3I76y7RP43j3VMmldGj02Wc8NQ
	A5LqtZ5Mgvd29pHdW2xdVTyKSl0Dkao7d6JzK3zkZVg0d2+Gcx1R8cXMoXfl/WQj8hUQqmWz3mi
	qUY9NIDaq4Ow/8vtL2VmYbUflVK0/PSQ/rhS4KO3hm91nSSTchPRMwbe5A3sguKZuOtm8NMWll4
	H1hdo6jhMRJEYA08esKnu2dQNFH5fqwNMJjnDEDBy0eNBoXtJ3lkCK4hWyLZHtxkn+IrhYxNfd5
	IrDBauChwx2trn705MPZtEIjLdHDpGMJWwyKz3tPIYieOBVXJ4DMBjjsl7McwnpOXNHieAhIJOu
	YBEyRO0jXsfxU+bOcc6z6Zm534rBeiyqdA/23mJcg==
X-Received: by 2002:a05:7300:7fa7:b0:341:85c0:91ca with SMTP id 5a478bee46e88-3427217a1d7mr3157912eec.22.1790406264285;
        Sat, 26 Sep 2026 00:04:24 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:04:23 -0700 (PDT)
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
Subject: [PATCH v4 51/55] hw/arm: expand imx8mm-evk DEFINE_MACHINE to TypeInfo
Date: Sat, 26 Sep 2026 15:00:50 +0800
Message-ID: <20260926070057.1234-52-luoyonggang@gmail.com>
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

Replace DEFINE_MACHINE_EXTENDED with a TypeInfo, rename
imx8mm_evk_machine_init to imx8mm_evk_machine_class_init, and set
is_available to target_is_aarch64.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/arm/imx8mm-evk.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index c3215b11cb9..5dfd8250459 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "system/address-spaces.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/fsl-imx8mm.h"
@@ -122,8 +123,10 @@ static const char *imx8mm_evk_get_default_cpu_type(const MachineState *ms)
     return ARM_CPU_TYPE_NAME("cortex-a53");
 }
 
-static void imx8mm_evk_machine_init(MachineClass *mc)
+static void imx8mm_evk_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "NXP i.MX 8MM EVK Board";
     mc->init = imx8mm_evk_init;
     mc->max_cpus = FSL_IMX8MM_NUM_CPUS;
@@ -133,6 +136,18 @@ static void imx8mm_evk_machine_init(MachineClass *mc)
     mc->get_default_cpu_type = imx8mm_evk_get_default_cpu_type;
 }
 
-DEFINE_MACHINE_EXTENDED("imx8mm-evk", MACHINE, Imx8mmEvkMachineState,
-                        imx8mm_evk_machine_init, false, false,
-                        NULL)
+static const TypeInfo imx8mm_evk_machine_class_init_typeinfo = {
+    .name          = TYPE_IMX8MM_EVK_MACHINE,
+    .parent        = TYPE_MACHINE,
+    .class_init    = imx8mm_evk_machine_class_init,
+    .instance_size = sizeof(Imx8mmEvkMachineState),
+    .abstract      = false,
+    .is_available  = target_is_aarch64,
+};
+
+static void imx8mm_evk_machine_class_init_register_types(void)
+{
+    type_register_static(&imx8mm_evk_machine_class_init_typeinfo);
+}
+
+type_init(imx8mm_evk_machine_class_init_register_types)
-- 
2.52.0.windows.1

