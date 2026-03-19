Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461413C9EE2
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773919234; cv=none; b=TamM5OlmGN9Jujt+QwgiOhv4krV9kBKJ94jpjvB0icZ8wIsbShmRT2peJud/QsrmyM9H/4sacgA98il2ZO5kNI6kGNxPMjkbExp0+/fBN/IEavT2EIwtkv/cVerZ3UEl/aH10UviisUlU7r4gva6B+Zx94teCp4xexXG8/8CbaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773919234; c=relaxed/simple;
	bh=QhjsPk0h+/rlX3LM08n2nUs/O4p2mlzDV+Hf6aSRD7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXlvIAPwEuAiTPPjJx9l1JT/6gk+x798db5XXTtUmLxF/hCZlKM6ynsL6K2FjY7qq76WhlyqcAmDmJqr1H76ARFqQ2zkGkGDYJszKBSXVsOzxWDSCVcjd1BPO+v2lDe3xL8ZJIhKdWABe3w7ruk99/zc8BZBSRJLaRDEyJJ0l8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oM7jrEnT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oM7jrEnT"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b40fb7f95so720135f8f.3
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 04:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773919231; x=1774524031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wofAlcNimL3fKlS85Aya0QNm0cIokcBfl4ew1SrPm3w=;
        b=oM7jrEnTRnDl0BygZ2jGvs+aw4c3ENJASLlkizGE7Z6MLHD935OJGmLWBrfhHlGwBx
         TpgXKBw2IjM0HbUAP62kaK+ekhhrXrVNkVRcRX+K4aL4ANd6orvziHSU6nkrtq7rzjEA
         /jqQcJT3j2sBqbZVm87ub0gah8LA9FcVNFAVLOPL4XPWjlvDHtIdCdNO1IrtQy8BbVAj
         +CbBd3Noiq8VfqyJcn25w8mzQuQaFUOq+lTh89kXTi8DmauBki5dMFP9dyt/nCbCA/uf
         cRudNhePTrFIUlxxqqYI5dh0N46sNAbhhDZ0Kg1+h0xsBQir6+ipH7ps9tRl1qY8bKG5
         cZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773919231; x=1774524031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wofAlcNimL3fKlS85Aya0QNm0cIokcBfl4ew1SrPm3w=;
        b=jORMr9McN9u6aQXs8Kx1d9YSdesJhsPyBVodAOcjMJxWBLKMHwF1Efl2xDa4LklY0L
         V3jT/KyPc4cVYw7a7z25PJ+vtTd6fDlCwtKRYgjAvxbjdDpJE+77Q8OXx0BrX/aJbHYX
         unpNQngH4CysfOakBarMV5K8IOePQVuY0yUGEKIjjhnilfr8TlRLXFns7vopc/L5FXKM
         5ghP9jDf+0CDh2Q12pVqniH2G/OW08N8JL0pulWeVEGJDZrY6Vi1NWJInFOG+l1LhPSX
         2SjaJliAQ9aR9AUDOSG2pzUG50LZ5nehJzLbgG0fx36zswCGkzjhBoIXT0uM5RbUuf/H
         PoGA==
X-Forwarded-Encrypted: i=1; AJvYcCXzlE1gEDKlGo0OvDjUv3gU/XFDRhcmpl7cN5LLOnXHDWxmajILJsI2VkkypF5iA4tKRdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycuq0m/WnQYHbYRHyHke6DGHOTY9TIXVYFuyImhD0OVSY+zV+O
	wFBEG9r4cf824UQ7jwjG5k6nkz/F+l8CXT2Bgfr8hvIKCdo6GNgsF9dqXGUJdSzllec=
X-Gm-Gg: ATEYQzz47BrBR7hlSEVn/9jGkZl5033LjsZfwS5P+Ot5dj2xnd6l86mfUVODQVgmf+m
	8oB4xwAXTMnrpeM2FqeE/K9Q7bN089Yz1VQzCE25MUb08QJmBXfe8urAeJQWu92ylNoYb81i6HG
	r2r9EU3QX77eivalQkZH/NFHb0G8TZVqyPInYGcTkWa+p6vc5p4X6Rea9TqwTPB0C7+vwwd6P6Y
	KP8PzuU4S7bKhd3JXIKUIpwWmMQcevz2erz7jUrkdGtF4nCzhHxn/imOjHVVCb4aBjfFdL6ZCNz
	AQVRk1fX8FjnQpUqWkF1p0m5YhuKu3B1nq0LQS+6C1Dy9lRJGDe0X7Y2A4wHS8YzYZmXJDar7mD
	xp4WQ9VkLTtquEibkClHUY1YBZJ1r8UxnMVYUSiFgsImF5kHunrqRT7bacSQv8CksPnQ4hsmQzx
	ZyW8FftPtraJL7aW8o+gvzeYkUCexWnEOEeEL3iSpZrIK+1/k3ZRvmE954GV4HngMruQJKNINa
X-Received: by 2002:a5d:5887:0:b0:43b:4d25:959b with SMTP id ffacd0b85a97d-43b527a97a6mr12241121f8f.17.1773919231367;
        Thu, 19 Mar 2026 04:20:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b5184b8b9sm15749126f8f.1.2026.03.19.04.20.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 04:20:30 -0700 (PDT)
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
Subject: [PATCH 7/8] hw/ppc/pegasos: Replace legacy ld/st_phys() -> address_space_ld/st()
Date: Thu, 19 Mar 2026 12:19:35 +0100
Message-ID: <20260319111936.68041-8-philmd@linaro.org>
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

Prefer the address_space_ld/st API over the legacy ld_phys()
because it allow checking for bus access fault.

This code however doesn't check for fault, so we simply inline
the calls (not specifying any memory transaction attribute nor
expecting transation result) per the definition in
"system/memory_ldst_phys_endian.h.inc":

 27 static inline uint32_t LD_PHYS(l)(ARG1_DECL, hwaddr addr)
 28 {
 29     return ADDRESS_SPACE_LD(l)(ARG1, addr, MEMTXATTRS_UNSPECIFIED, NULL);
 30 }

 42 static inline void ST_PHYS(l)(ARG1_DECL, hwaddr addr, uint32_t val)
 43 {
 44     ADDRESS_SPACE_ST(l)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
 45 }

No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/pegasos.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 4217af25807..52e35949cc1 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -21,6 +21,7 @@
 #include "hw/ide/pci.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/core/qdev-properties.h"
+#include "system/memory.h"
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/qtest.h"
@@ -593,12 +594,12 @@ enum pegasos2_rtas_tokens {
 
 static uint32_t rtas_ldl(AddressSpace *as, hwaddr addr)
 {
-    return ldl_be_phys(as, addr);
+    return address_space_ldl(as, addr, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 static void rtas_stl(AddressSpace *as, hwaddr addr, uint32_t value)
 {
-    stl_be_phys(as, addr, value);
+    address_space_stl(as, addr, value, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 static target_ulong pegasos2_rtas(PowerPCCPU *cpu, PegasosMachineState *pm,
-- 
2.53.0

