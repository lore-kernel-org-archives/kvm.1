Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F1B24A047
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169780; cv=none; b=ZSigGXemQ/L2j6tiPNE7iE0KVGv0Uaf5opV59puTW2bQu8ULkS112Dyladr+LJPOMc7BIW+Z6Z2dflOKzaZToASCHNFfFyLOg3hBhLuzEOXp3I8G6Ct9dVKOis6oupgnFyDf+7c3bBmA4LzQ3PiCx0NsBILqJ9SDmXSUQ7JsqzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169780; c=relaxed/simple;
	bh=994PQl8V51agIcM8vtn6n3LVdhwP8HQHP/BLXq99pl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBq91CR8jvaO4JeGpAXEuGGqrXE5vbof8t3Q3ReEqULbnphxTnp3eAn94SMDFeCL6cEmeZ3KFOTZumtRVUHpDO6nwUh4H4qiMcjRuCgqSaRmLwkPc9C+ZZL1CKubTCoQT+03rm0nJK2tLfjghTNauIfhE4tpHwRG9eHqxtZUmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4g0jyhv; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4g0jyhv"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c24422d4dso1030811eec.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169777; x=1790774577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P+y3C9rGVvFAkdWFKio2TWsWiPkrJ96pOnUImryyekQ=;
        b=V4g0jyhvrb+FONj4BIsg4/B8fVgvfnQlOH1+kIw3rzv+Igxa4vOHmlwx7d4WGrwPGX
         QRqsQwhIpe2qruEHeVcqWtgrfHXsmQpOVGljM10Jiao0qgl7+PA+1PTk5Jhn+AWyLIzw
         nhSVrmbPmMkRxZeqg99pb/URKr732NwNRN2EcnM9c30fRRVowOOM1K5MhvaLV05KwmhF
         5Nk1Nq4U6iPgL571/TcMoa16UTdCvgmWjsJuCYSWvwryW55mT/Ik8FhdRMZP/cXawPLv
         Mcly/SJIonINLMKUdztjA4Xlb7PfjQTM3R6cD0Zuubhrx2LmjA4BnS4zaK5ryIm2Fepf
         hrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169777; x=1790774577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P+y3C9rGVvFAkdWFKio2TWsWiPkrJ96pOnUImryyekQ=;
        b=fC50cSkXdry9aFZIYetJjB5CKLRcwnrTw5sRsGma6Cb31Y4yf9EJkue2bstbZQEUwA
         CnqNteGY3qmPB/DooeZA0y5tMopDxG2cDb37blHFHXjhwdlO4JKBjOclE4ouumJAvvZr
         QRvp1r7Z6pRuGftCzQSAApqTGvjQUGoy+6kYvqXXQVmhKXKBYEFujoGfFaiQLSxPF4W4
         Od94z1keTiy8mw2l7QXHpE3+3xSpqWgiyqdh54U5UikkoE/+kCAJzG6DKyft3Ltr74HA
         vVwaGr9OqhmABDobgVKlJtqLE69sCCTYR33o+Go8NJxsi0iCF1OIOnwGCz+k6x8eeNa4
         9kbQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1vAxSpBQo7pwtdGp9cgjRdYGVZlQTpxBTNvCf6Aej9ubk6MR0X0GqDtKpti9VmpOIoLg=@vger.kernel.org
X-Gm-Message-State: AFuF++kE0NMP3SdFvY0kMdXpucUjRsmwK6OfiKjwZUcRjVuK5xbNUf8I
	uG8PaRTauVBWL06IwoepydcY+3QwZFDJoUBMwEMRE8cG5+muTnKjh4S4
X-Gm-Gg: AYBFou1vcGkaHZNu/B9sYDyXAp5YRsGBHHeXNLdCCBSLZiWNz0iAXVidn3hUB6DleO7
	avIjZv03fVKxcSe/UyyofEOi57JDfzXFheXZL1hGiAV8KBJYUveIpLwlFWnbwO/bfgmP6i5aNRM
	wwJ5XhqMLIbfb0mMeafUmQoIow4hB7KKo92F4F9Z9piPd/eudPuLKtbIXDuTbIkazndqyBQVgT+
	z5SIR9XF+bIlnnIxClR6N1XWibRaiBdB6R6QbNPB6lohGYFR82V97Fumkq/sO+JzFivCaitChs4
	VmZmdnEo0XXf2mFoKnLL++21MiMopyuk9THPfKUHDnc2wyyptOCqFZoLmcqb+LvXA4JzwMiv/s8
	I6NYIimnMfHeKNTryyT0L9FclAIDF0H6RFCqMZ6RLU8v3wEvqWqE0ZVxHh0VxmVw7PoGtJCX66x
	CQAnscJSzS2Xq1lvbGnrkrEy98Iwxro22Yv5y6wYsZJ9l3RLMr7+wVES1jxIQFAkKaKyUIw0sb9
	6VMUVWtN7SpL+An+MrSMxPVlH1rJLI=
X-Received: by 2002:a05:7300:311a:b0:339:7357:b225 with SMTP id 5a478bee46e88-33e905f47cbmr2532490eec.16.1790169776667;
        Wed, 23 Sep 2026 06:22:56 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:22:55 -0700 (PDT)
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
Subject: [PATCH v3 037/114] target/riscv: replace TARGET_* macros in CSR helpers
Date: Wed, 23 Sep 2026 21:15:11 +0800
Message-ID: <20260923131635.1894-38-luoyonggang@gmail.com>
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

- Use target_long_bits() instead of TARGET_LONG_BITS for the CSR
  write mask.
- Use target_riscv64() instead of TARGET_RISCV64 for MISA RV64 and
  the PMP address mask.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/tcg/csr.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 061bc9db77b..0b96fff6b96 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qemu/log.h"
 #include "qemu/timer.h"
 #include "cpu.h"
@@ -2143,17 +2144,18 @@ static RISCVException read_misa_i128(CPURISCVState *env, int csrno,
 static RISCVException read_misa(CPURISCVState *env, int csrno,
                                 target_ulong *val)
 {
-    target_ulong misa;
+    uint64_t misa;
 
     switch (env->misa_mxl) {
     case MXL_RV32:
-        misa = (target_ulong)MXL_RV32 << 30;
+        misa = (uint64_t)MXL_RV32 << 30;
         break;
-#ifdef TARGET_RISCV64
     case MXL_RV64:
-        misa = (target_ulong)MXL_RV64 << 62;
+        if (!target_riscv64()) {
+            g_assert_not_reached();
+        }
+        misa = (uint64_t)MXL_RV64 << 62;
         break;
-#endif
     default:
         g_assert_not_reached();
     }
@@ -5430,13 +5432,11 @@ static RISCVException read_pmpaddr(CPURISCVState *env, int csrno,
      * here to avoid complaints about masking bits 0-53
      * of a potential 32 bit target_ulong '*var'.
      */
-#ifdef TARGET_RISCV64
-    if (env->misa_mxl == MXL_RV64
+    if (target_riscv64() && env->misa_mxl == MXL_RV64
         && csrno >= CSR_PMPADDR0 && csrno <= CSR_PMPADDR63) {
-        target_ulong read_mask = MAKE_64BIT_MASK(0, 54);
+        uint64_t read_mask = MAKE_64BIT_MASK(0, 54);
         *val &= read_mask;
     }
-#endif
     return RISCV_EXCP_NONE;
 }
 
@@ -5755,7 +5755,7 @@ RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
 RISCVException riscv_csr_write_i64(CPURISCVState *env, int csrno, uint64_t val)
 {
     return riscv_csrrw(env, csrno, NULL, val,
-                       MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
+                       MAKE_64BIT_MASK(0, target_long_bits()), 0);
 }
 
 RISCVException riscv_csr_read_i64(CPURISCVState *env, int csrno, uint64_t *res)
-- 
2.52.0.windows.1

