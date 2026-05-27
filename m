Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2780F3FBB46
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779882212; cv=none; b=K+071MgBaYpRAiQuQcs6uSL5/TRWqZ0eaDVUr4ivC41Bu4Z9Oq81W6lsKW7dvJZ7lup7//C/2O/DjdIfz+Y3dzIzUbaqxVPFnYob4+FkFcYwLCIpdgmdHYGJOBijg8OgEVUkRXT48Wg0VYKBA8nrZHL9LtQCafJqR6idNT9jP78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779882212; c=relaxed/simple;
	bh=NYmu56YsQAClMPDKQZHaQ46XvPECUSZnxoZS8at4tZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6N2saRlUuX8hN/0j5FLEsknXSU/N18LX3Z7kGHOWWc32T7106m1Wkts3LbmlnwPWacDqI+5QwPTR/2EacbLJwvMlRC4AiAV+zr0KOpja5J6KUP+MB16Xo0pWtqShFvLiHM/B4yrgYY8BbGGJK90h59f6+1hE6wlSnuKpmpAWio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oCzN9qwj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oCzN9qwj"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so53438215e9.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 04:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779882204; x=1780487004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJonqsC661AicUoZ3WXf5dOPD/EyukyFdYhNbfWENfY=;
        b=oCzN9qwj95+oop1+9PW4rX/GjoM9tfsik8VQLmD39IUyZCglMsvSMwhjp4DGKv2ZNh
         kbWnX2jr5HygLm72CCCdy73fvgr/D/mUyoTDVBs+jwzjl66uvkyW9b/LUIvRYsZ+WKwg
         e8uT7odhNX//A9TplKf2Tgy0ly6GPU6F3OmoqyElg2h/yGmlMDCkYIcyhapshFGBhxDJ
         upyqeuHC4Be4NXvRoK7thSG4ZekgotYybL/FT3YUMMNV/XejGkh194ZitS/wNC1APDMU
         NlKUsFrw15rTaZhUiLjGvLF/BeNr8YTC12KLSQSVMReB2/IbNt5628q2gQOIxPsLHIq9
         DLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779882204; x=1780487004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AJonqsC661AicUoZ3WXf5dOPD/EyukyFdYhNbfWENfY=;
        b=jDwL6DT3IlulVExBn7BKZx5qVhlmS7cHPZy77irWhqdNZVrRkSj1iayAhrh4YsFNs0
         n29MJvErbwZY5y/k1QlfO69xo6XjT2N52Szk9zmb32F3g7u10IHrKROodgsqxXOoRNRv
         fA4yE50cQaT3aeljUWxY98lT6jKXDlWkBnd6qiROF/X3hAHk1PlXGHPrvtS1T0/q7S1R
         jOzJPC9zLi3DLN0FmT2DqNRbvXxZv7Uqa/4huWYoIx2AsFENuWepEfDnRsdZYlVGUzA3
         r1z/hKQI6AVC5oQ2DuODGqwvyPLZcPHQYlvw79rtqv7ZH0RRq6sDX7bd0ZaaH/mMF+1m
         xncQ==
X-Forwarded-Encrypted: i=1; AFNElJ+HslXfJF0uDqKuKEU3dBjp5Wh7o0fgZKHbgpYXu/afmCaav9GCXvJURY62xfT2cqgjhfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9x7r8nwQ5jmyJDFYnVZN7NgwanQ7qM8mMMUXAduIAY0q5JIy0
	F0vpxlfOEtPuSDBNaCIHNN7+cSsgSkFQchL9HPBlmkwqy8TUXnmkriK9nXOImS6d0xw=
X-Gm-Gg: Acq92OEAzgER3dcqtjpDTigDTW5Vhejk8Y8SIWV6g3FjRik9zx1N88fCnK7v/BHnMdi
	kuR3FhH0bB54Mi0yHqlYnLivpds5v4QhSa6rEri9rRiXz1q2jPiI2KWS5sFYgzz8H/XHcMTg74e
	F5HqwvSJz23XOfV3s1VAdK5f/ehfNdDesiZromJBTm2tHsXOhIWoJweqG5Z0mku1A4opUaB67Et
	otpQRxyEv7GZJhfLx+n4tUcH3v5BrOY3pU590aMOpd/aD6zJLlPHdzDN4uKvHjfim429cI7shf4
	c8ofoTekhoTTQIzu1Kt77GGSmEJ/0MOp3JrjNaRLyiClIF3uDlf+WBO+zT1Op8gDjyudrQVyEiw
	qdl7CI2BzSEEmTzvVC1NkJwqRrhsZjVL8CuOtBRj0qTypz5KO2XdesdhXJXQoByRt2lD/mjVPl+
	xEvFV25pR/NrzBdP+h5dy/mcw=
X-Received: by 2002:a05:600c:45ce:b0:490:59cc:998e with SMTP id 5b1f17b1804b1-49059cc99famr238489835e9.3.1779882204321;
        Wed, 27 May 2026 04:43:24 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb557679sm9410757f8f.10.2026.05.27.04.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 04:43:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 396A95FBBF;
	Wed, 27 May 2026 12:43:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 4/8] target/arm: ensure aarch64 DISAS_WFE will exit
Date: Wed, 27 May 2026 12:43:16 +0100
Message-ID: <20260527114320.1581552-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527114320.1581552-1-alex.bennee@linaro.org>
References: <20260527114320.1581552-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This mirrors the logic for DISAS_WFE in 32 bit world. As the WFE/WFI
have similar behaviours shuffle the case statements around a little
and update the commentary to cover both.

Fixes: 252ec405768 (target-arm: implement WFE/YIELD as a yield for AArch64)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - shuffle case statements, unify the comments.
---
 target/arm/tcg/translate-a64.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3e3971db3fb..d057241e9df 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10913,25 +10913,25 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_NORETURN:
         case DISAS_SWI:
             break;
-        case DISAS_WFE:
-            gen_a64_update_pc(dc, 4);
-            gen_helper_wfe(tcg_env);
-            break;
         case DISAS_YIELD:
             gen_a64_update_pc(dc, 4);
             gen_helper_yield(tcg_env);
             break;
+        /*
+         * Both WFE/WFI can cause exceptions or exit the loop to
+         * halt so we have to make sure we have rectified the PC.
+         * However they can also return directly if they don't
+         * enter a wait state so we must add an exit block so we exit
+         * the loop and check for interrupts.
+         */
+        case DISAS_WFE:
+            gen_a64_update_pc(dc, 4);
+            gen_helper_wfe(tcg_env);
+            tcg_gen_exit_tb(NULL, 0);
+            break;
         case DISAS_WFI:
-            /*
-             * This is a special case because we don't want to just halt
-             * the CPU if trying to debug across a WFI.
-             */
             gen_a64_update_pc(dc, 4);
             gen_helper_wfi(tcg_env, tcg_constant_i32(4));
-            /*
-             * The helper doesn't necessarily throw an exception, but we
-             * must go back to the main loop to check for interrupts anyway.
-             */
             tcg_gen_exit_tb(NULL, 0);
             break;
         }
-- 
2.47.3

