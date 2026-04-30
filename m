Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235313B3899
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777545882; cv=none; b=kadIT0zv5vkHJnbY7N+KLp8icJhRpEPl+mzJ350PKpzTWiZOiZMTTHLfH6U91yqw4SzmvxVUEjAG0Yg3hAncaRfGxn38i/wZntlGXJL/dKfIAM4siu1VGeIfvUbVHu5L9hxE4OiWXRTix1fJcqDUxRgE3SmUr7REP5u/hY6Bip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777545882; c=relaxed/simple;
	bh=0nqGd77fmybqjyWYUicu8dCWOm3zwiLR5xsVZh9y/kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQY2KZEzWv6+0db0uOBblWAgSSpqG6mxzpU9gtABgfx88M0wPwd4MrYqPQ4Y+OA7Qe9Cu/RHEKxCM55srI0jo0dq2y9AusyhyWisJrDevMaddWUnQZJ3qRfYZYA3fOCUMprjfr4EjjqsjaTe9ah/t1BwD2eKlkGqcwts6l/O4q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IJjWZrVB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJjWZrVB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891f625344so8408675e9.0
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 03:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777545880; x=1778150680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJ3nvH0CdgnQGuiZq72mX6EJh1rauF0iDM3crLBhnzQ=;
        b=IJjWZrVBq6qRrNKnWndz2gux2otU5/iSIg1TVtUq8FL/y8TzxaETg0jjVYlxOrk4Tw
         iADB+tkvm6v65d/q1QGy1BZ5WHZ6qgYv1DVTjHmY2T9Is5VI0AfwrbnE7BhhV0+pknoQ
         4m1gikyEh3bmV9eYBoaDIsxE76QzOR6wwAIiAawAeI4xhKE66h6J1ur6lsdL6eZG7/iK
         MGDs96u/PPHoFwNsUk4W8kXfYnVoOxu3XxTbd6LbZUxR7Kznx1DsxHndr/fmx3y2isBd
         sirC8sUFLZXBtC21YhssV9wr/gf3voUKEZGNa2gcNtxE9VnD2pabYWgNeyCkeug7ClHO
         qeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777545880; x=1778150680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SJ3nvH0CdgnQGuiZq72mX6EJh1rauF0iDM3crLBhnzQ=;
        b=dqameJjGCk/kPA9ZOB2dcNYEu4VJGq8dknfRv9B3xDOhwGIohD4C/mAnuUz64sCj++
         pCUl959aso6JZ6HodCHXm8qG++RS3aRUxGLmIESxiruM1HO6quu0y8Ww5s/XGpkIjM7y
         prSvEjxDyFB2yAD4Blv8AVnTVj9z2nvaP1QViss2ssTQWSNt/TNVydhExy9WGuo2J/09
         UsJfoTliojnw2GAgcJ6aFKfTLxuQa0pLQsgULW7XgFsBuNYV7ybh6AqP/tUhzKW7fFoG
         eZj0O79a47rsCQ2HL+3ryBj83xFEH+SF+3/ozn8Hh5NU7EsmoL7nAuu4ns4Pzld+q/v1
         lwSw==
X-Forwarded-Encrypted: i=1; AFNElJ+SHfO84VTh4w7ydD0f78Rpk6a+o42XlPJzwRCmAP+PWfUwvQTB9MZ318MfrBBAKsSz8Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2wePhhtFDaqgivPU1tpRSJZTwRsuH6TFfB7z5SJbxjK8ikdih
	gav/1eqfjrBkkL2SqvnCYdCDtGyQX7TSV2uL4yAsUZuKRX683e6aAVDY7REjPeTVlUM=
X-Gm-Gg: AeBDievbGptOFsvRlv0LofimPRxp5H2VL8v+P+dE2AiIoKQp7JzLdZhPsWkAufclBrR
	DbipIt0PIH8fgiLdQhOXMwfCi7xOdNbxBhGU17uwcxSXsTxpm0tsjIXIF0tX5TNoYGpy4LBKFP1
	A6kQv4iVyHtLabY6ZCX0QcGFiV9ie3cU7N0Yd3TpxqOctBd56yjj/YTewuxNOraR8v1JreGqAPH
	9BY5oZSCzyMv7l99Gc7BlmKZxmMu2vowWQFJulWGxSVyuqd9Rd4Geir1xQUZ7i+Hp2VdZDeTOqd
	1NFFEEDyBC/CGz5rPXWlRgTWUVMZf/SmIpWfIEvIz4aZ1XsaU+vDgObWRYRyCR9kOYMs9Sa5wsa
	jiwxopwCyx7mLXR8Rw2L+7noYZlQddSN7cScj/pnShGUH98betaD+CS6rUfunjvXqs12QWcHYB2
	jW1dBI8jsYacLapeTEHc8bfSsOMVeeTEnF9A==
X-Received: by 2002:a05:600c:8707:b0:489:1baf:8c03 with SMTP id 5b1f17b1804b1-48a86084573mr36555495e9.11.1777545879496;
        Thu, 30 Apr 2026 03:44:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c32afb0sm38448105e9.35.2026.04.30.03.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 03:44:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 127B05F936;
	Thu, 30 Apr 2026 11:44:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
	qemu-arm@nongnu.org,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Alexander Graf <agraf@csgraf.de>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 3/7] target/arm: ensure aarch64 DISAS_WFE will exit
Date: Thu, 30 Apr 2026 11:44:30 +0100
Message-ID: <20260430104434.1482407-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430104434.1482407-1-alex.bennee@linaro.org>
References: <20260430104434.1482407-1-alex.bennee@linaro.org>
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
index 9a27c4c6ec7..25f0a806512 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10916,25 +10916,25 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
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

