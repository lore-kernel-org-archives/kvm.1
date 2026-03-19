Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102483CBE60
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773919227; cv=none; b=dQQ953YOgT/QTkgJTU+chwOx7r+YFYQfT13/boNNxpT529+X6hPpMgXHJ2tYNBh5kEaQTX20H8sB9VsX1dvVnd6OgWWmawI3tGBqZtchZjItPTWzG+v9aB2vJi6u+JUSAaB1XMK2NXfwuLEnoiSHJ5vIVhof4sWbN6sxoiPICbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773919227; c=relaxed/simple;
	bh=9OzVPhS1AAwrSh7IRitXB4n8wBoFyDcVGSq8l7OwOKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QECwu6gTqDeApexuTWNJP1DO2NC4YXyVcjbORSSpMcOra7/AUByByGVJUbShdojpNqhOqPMzvBs0iIbcbyh1K1Xu08NUT+6DWrBYpZO93kBeqOOypgkWzZdkZhGHqNPT+tQd3pLok2KIx/qfxGeeFTsQQ5lAdszLRno7dvgZxdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lj3+Vp9R; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lj3+Vp9R"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so3186065e9.1
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773919224; x=1774524024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAiGye3fGjBysGoywQdBfxZN9m2vlKGDWnrT8pe3/go=;
        b=lj3+Vp9RP4rzJsWQPrQ+APffdpQSky+QC8j9kmeLheV7gcVy73YvQSbs7sxauwfnLJ
         146itdfpIf8MQN82z6UBDaIhP+tY2gvKXhyqWjXJDKJY1d5im7mpcGPSs4poBKimIMw4
         SybonYlWFmUo/LwVtBMJ1bOpveQ8W/WV2PmDjG956qqJVNhPhcMgs8LykM5QlSWl46OO
         pZfXzgRE8FcMNzNgMgacEDqJiD0XbN/I06xFOpCyjTiZAgBa/ZtuZ/gSQiHB+RcsxAsf
         vMuZ6LXcHGCh84wj7TghdaI66DX6dNr4WxlaNL5DcTSWhHLJEvpj+Gc8xw4lMMySj3w0
         M+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773919224; x=1774524024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JAiGye3fGjBysGoywQdBfxZN9m2vlKGDWnrT8pe3/go=;
        b=amdOF1yG/UWMaYCzzRDoDB/J2zOEJ3auzYc/aKHQYvA9dpaUVm6E9TEEjUv0vs2SHU
         QYsjtaS1irsVSx3/ugDCWVor+B1WHZXn0vjt1FSasv69mZzn4eIsuCuvb3EVtBzb7BAB
         AXW4hCDUj0VkPA6PwJ3wkTmg8RuDPXhH6u0qvmUhdbQkcs90RUE7n8FUkdOISpw97WHE
         66uKEGjJP+jzdWUwP+5b8coUKHltRmX+gZ14Gda5w5ht0NYUIPQDUOYbWL9NBVCc4vSF
         sAMS4W0ecSMtRag82JsDd2cMUO3eqLLcjVeTGV4mMigd3qzKkIuFjPgpHb+Nkqk1yMSi
         dF7A==
X-Forwarded-Encrypted: i=1; AJvYcCWRVjbRewPkI6TTEWoFgTQZ0obmL+MYiEcnCKhT+YfdQRlAE/VFdnLsr2hJ1gX93Uy9pVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwANnxKqvz7oJBLQYl5wbqNIoHRBO2RbtSxIJwGTw53sQdV7iBO
	/EfmVjx+56oyqBnlOt8AL8+rf3Uny/wo8agqlI7a5SY9xT6f6Toa9UqCp8vqv60ZG44=
X-Gm-Gg: ATEYQzxD7Ju2BE61AuTmQ7NVxCXVJDPis4HzIwvPLQT3Udcu8A0+GpgN+9QJ3L+ycG7
	3G3cFjqjFdfGQbE7Q0VFXM6pJC40ZRZUwWE/gzCQENKabui5U8Q2AcQGbkD6XZx7BOV7ulECFJd
	vyOSD+/AfSazRzzyc1NudRwALby8YSC1lup7o1Tmq+jPfw/aVDKDdEsKnmEQXXau2X4PJHDKlSr
	eIIzaSvDp3ecUJ+9D/qA9A+tE4yRFadziCaPRSeKEaQaK54jyeEOHoFcj68TbIzUGLpNY0CGdV3
	SLKyNNrIw7Di+PYIJz2GLFX9LKUdaGrS0SZI8D7rLweai6p+mzpqL1ZtjQO6FVBo2T79fwY1Shd
	iCPZqhd8YGJ2XC16N780SvHrOC4hQGZhrR2LyuqPpCheeFaEyysbK+/zGB9869ePQXrt7j/NZDu
	zG3bCMVcRGymlGf2BLrWegUBzzHZbzBEG6v0g50JJFTQcolB7SfpDQ2W724863m+y1XkdmTwcVp
	rmDRibIv3o=
X-Received: by 2002:a05:600c:c493:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-486f8b32877mr52941045e9.8.1773919224256;
        Thu, 19 Mar 2026 04:20:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fb6b85f3sm11600845e9.18.2026.03.19.04.20.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 04:20:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	BALATON Zoltan <balaton@eik.bme.hu>,
	Nicholas Piggin <npiggin@gmail.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	kvm@vger.kernel.org,
	qemu-ppc@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	Chinmay Rath <rathc@linux.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/8] hw/ppc/pegasos: Introduce rtas_ldl() / rtas_stl() helpers
Date: Thu, 19 Mar 2026 12:19:34 +0100
Message-ID: <20260319111936.68041-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319111936.68041-1-philmd@linaro.org>
References: <20260319111936.68041-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In preparation of replacing the ldl_be_phys() and stl_be_phys()
legacy calls in the next commit, introduce the rtas_ldl() and
rtas_stl() helpers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/pegasos.c | 66 ++++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index ac9fc5a6542..4217af25807 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -591,13 +591,23 @@ enum pegasos2_rtas_tokens {
     RTAS_SYSTEM_REBOOT = 20,
 };
 
+static uint32_t rtas_ldl(AddressSpace *as, hwaddr addr)
+{
+    return ldl_be_phys(as, addr);
+}
+
+static void rtas_stl(AddressSpace *as, hwaddr addr, uint32_t value)
+{
+    stl_be_phys(as, addr, value);
+}
+
 static target_ulong pegasos2_rtas(PowerPCCPU *cpu, PegasosMachineState *pm,
                                   target_ulong args_real)
 {
     AddressSpace *as = CPU(cpu)->as;
-    uint32_t token = ldl_be_phys(as, args_real);
-    uint32_t nargs = ldl_be_phys(as, args_real + 4);
-    uint32_t nrets = ldl_be_phys(as, args_real + 8);
+    uint32_t token = rtas_ldl(as, args_real);
+    uint32_t nargs = rtas_ldl(as, args_real + 4);
+    uint32_t nrets = rtas_ldl(as, args_real + 8);
     uint32_t args = args_real + 12;
     uint32_t rets = args_real + 12 + nargs * 4;
 
@@ -613,19 +623,19 @@ static target_ulong pegasos2_rtas(PowerPCCPU *cpu, PegasosMachineState *pm,
         QDict *qd = qobject_to(QDict, qo);
 
         if (nargs != 0 || nrets != 8 || !qd) {
-            stl_be_phys(as, rets, -1);
+            rtas_stl(as, rets, -1);
             qobject_unref(qo);
             return H_PARAMETER;
         }
 
-        stl_be_phys(as, rets, 0);
-        stl_be_phys(as, rets + 4, qdict_get_int(qd, "tm_year") + 1900);
-        stl_be_phys(as, rets + 8, qdict_get_int(qd, "tm_mon") + 1);
-        stl_be_phys(as, rets + 12, qdict_get_int(qd, "tm_mday"));
-        stl_be_phys(as, rets + 16, qdict_get_int(qd, "tm_hour"));
-        stl_be_phys(as, rets + 20, qdict_get_int(qd, "tm_min"));
-        stl_be_phys(as, rets + 24, qdict_get_int(qd, "tm_sec"));
-        stl_be_phys(as, rets + 28, 0);
+        rtas_stl(as, rets, 0);
+        rtas_stl(as, rets + 4, qdict_get_int(qd, "tm_year") + 1900);
+        rtas_stl(as, rets + 8, qdict_get_int(qd, "tm_mon") + 1);
+        rtas_stl(as, rets + 12, qdict_get_int(qd, "tm_mday"));
+        rtas_stl(as, rets + 16, qdict_get_int(qd, "tm_hour"));
+        rtas_stl(as, rets + 20, qdict_get_int(qd, "tm_min"));
+        rtas_stl(as, rets + 24, qdict_get_int(qd, "tm_sec"));
+        rtas_stl(as, rets + 28, 0);
         qobject_unref(qo);
         return H_SUCCESS;
     }
@@ -634,15 +644,15 @@ static target_ulong pegasos2_rtas(PowerPCCPU *cpu, PegasosMachineState *pm,
         uint32_t addr, len, val;
 
         if (nargs != 2 || nrets != 2) {
-            stl_be_phys(as, rets, -1);
+            rtas_stl(as, rets, -1);
             return H_PARAMETER;
         }
-        addr = ldl_be_phys(as, args);
-        len = ldl_be_phys(as, args + 4);
+        addr = rtas_ldl(as, args);
+        len = rtas_ldl(as, args + 4);
         val = pegasos2_pci_config_read(pm, !(addr >> 24),
                                        addr & 0x0fffffff, len);
-        stl_be_phys(as, rets, 0);
-        stl_be_phys(as, rets + 4, val);
+        rtas_stl(as, rets, 0);
+        rtas_stl(as, rets + 4, val);
         return H_SUCCESS;
     }
     case RTAS_WRITE_PCI_CONFIG:
@@ -650,39 +660,39 @@ static target_ulong pegasos2_rtas(PowerPCCPU *cpu, PegasosMachineState *pm,
         uint32_t addr, len, val;
 
         if (nargs != 3 || nrets != 1) {
-            stl_be_phys(as, rets, -1);
+            rtas_stl(as, rets, -1);
             return H_PARAMETER;
         }
-        addr = ldl_be_phys(as, args);
-        len = ldl_be_phys(as, args + 4);
-        val = ldl_be_phys(as, args + 8);
+        addr = rtas_ldl(as, args);
+        len = rtas_ldl(as, args + 4);
+        val = rtas_ldl(as, args + 8);
         pegasos2_pci_config_write(pm, !(addr >> 24),
                                   addr & 0x0fffffff, len, val);
-        stl_be_phys(as, rets, 0);
+        rtas_stl(as, rets, 0);
         return H_SUCCESS;
     }
     case RTAS_DISPLAY_CHARACTER:
         if (nargs != 1 || nrets != 1) {
-            stl_be_phys(as, rets, -1);
+            rtas_stl(as, rets, -1);
             return H_PARAMETER;
         }
-        qemu_log_mask(LOG_UNIMP, "%c", ldl_be_phys(as, args));
-        stl_be_phys(as, rets, 0);
+        qemu_log_mask(LOG_UNIMP, "%c", rtas_ldl(as, args));
+        rtas_stl(as, rets, 0);
         return H_SUCCESS;
     case RTAS_POWER_OFF:
     {
         if (nargs != 2 || nrets != 1) {
-            stl_be_phys(as, rets, -1);
+            rtas_stl(as, rets, -1);
             return H_PARAMETER;
         }
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-        stl_be_phys(as, rets, 0);
+        rtas_stl(as, rets, 0);
         return H_SUCCESS;
     }
     default:
         qemu_log_mask(LOG_UNIMP, "Unknown RTAS token %u (args=%u, rets=%u)\n",
                       token, nargs, nrets);
-        stl_be_phys(as, rets, 0);
+        rtas_stl(as, rets, 0);
         return H_SUCCESS;
     }
 }
-- 
2.53.0

