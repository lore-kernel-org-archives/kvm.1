Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FD5386573
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980021; cv=none; b=TbA3SpHjUnd6YhjckEiIM4CWgEEEJin3cO6RJb1MsUI/HecIUdYvVmx1hTW6crwfk2ti0TJfMeo4+dnC3czm3YJGpy6/UroFP5PqoDBSQ/cxGJlj0sfywjd/mY2Vh/w+9ED4sP2a3uZBkMwyfsfI5KfKSPB3RdTBaKHzuB/h7PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980021; c=relaxed/simple;
	bh=0nqGd77fmybqjyWYUicu8dCWOm3zwiLR5xsVZh9y/kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCoZx0olqT44t4Z6LLBEzbY9ft5RTXuJ7dWIXwVJTbfjwC7xCjkY+GA4JBB5eX2ugMgLMU8UJauE5UwulyYTPkC/de48ot1y0RqZyAUXMGxvjQR7RdFNfvf8ZOy5gAmv5kgZ++sScXhxeGyDzniTrwYbXUjLRockhZXg4NpbgNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GIq+rpZA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GIq+rpZA"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44a74032ff8so2728302f8f.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777980018; x=1778584818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJ3nvH0CdgnQGuiZq72mX6EJh1rauF0iDM3crLBhnzQ=;
        b=GIq+rpZAlM2pJX8SZhouPtL+bpYLKM/Vg9FbVfcWJywphSmqF63wohrqxhJLirpMd5
         DdPidoRNR6iz3NE0M3/8DkpSdg0sUfzVysJ/1qkqXJveCgTJ/l+iJ5pXAQ9373PsggmP
         J6Gf6rfE2sYeZSuAlTkika3nmKOi8xpfHPXSEndbjT6AC2o0dJR4KV4zMXa6EJWVf00R
         /jLXJN9sgnB5wY8sphKoLyMFvPEgDLNGQoxQudpv/zOQ6FEq0Zr31jJKmIm25w4eP60w
         eMoVrZh5fFHGUCfu1aA3GVnmxQ2yX1fjGbAJAjV7QiC61zMCAPoqiUwz8N7ICr2hAI+W
         A9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777980018; x=1778584818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SJ3nvH0CdgnQGuiZq72mX6EJh1rauF0iDM3crLBhnzQ=;
        b=nzjv+AA3ulb+5Ezsuh8iFA1fkek51jTAu9qasGadTKeAfJ1PL5aohK+pPwNliRQj7d
         VKd4ooWSOUdULChDVmhAe26B0QTPeP0fPz+6HUcr27ALLLJG6ZLUy9K+ajj6UeCRwaDU
         qF4xuj3O263aZlBIfr02C8+1IrjmO5sqiqi+jpVYJvcOSqZfCX2KL6eVM97HQw8AvKmt
         9WYB/j+GW31+r+pLHavXSPEbZzU1IzIQa/NEJkvD46O5uq5EtvTDSvlgYnrDyUHyv/vb
         7d+ZhBq77WbAfeywUE90T3tmX8ZGZASfNEnDpwpp+VUbcFkL0s5uXpg72vBifDzlNkwP
         AQDg==
X-Forwarded-Encrypted: i=1; AFNElJ+NcO7i3jGq2n0S6NaRTaY4wkw6AFVoC9Z8cxZv/dXctZbxLInh4TAlbLjqH+gpDnSjsLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkFc8fq07FVUeaDlFXnI6sF4s3/QtmO3xtcF4unFPWUs3UF4p
	CJtPdCN762swYh5JfRD9J9phlli6GPAR1vnBVR74Omd9Cqn9dDtGLVrrFWXvJveEJWU=
X-Gm-Gg: AeBDietBsU8E3AeQsavNu0nVOck8rK8qvaVSf7z0HhwXGfigV3MvAv1m3g9kMnGMZMb
	UGC+Y8/2nSSnqB9YjpzIqrRwB31+w729Q2tXE60veGGAG1UTj/sM8VR09/3V1URiSEWV/v8KdMp
	3wBW57HjgWf38IwPEzrED4zMiGDOXtobjzHVmkDBIYcKJFiuXrIfaKN/HzBEmh6R4kUdl6UT7Z+
	xEQFxV8JYco/UUQdL16BOTqGFMxyw4sPXh1ic6rgXf7+6Y2U1miNWafb/+LvsV9aCHX2GhUCfJS
	qN/2xBGA/FITBefD0zXLtWnKNbOF6GxAoW3LQAZf2GaLOo0MBnEmghoAautBhUZk7k7dvIze9BM
	QgHXn/0fpqpKzF1EBkJ5ly8tKNdpw+mOOiUr4oIfYVXBc8tH/m9ZS+SjDpdbPS4q52L8FWvQ2BG
	XS5xC7DjFlBMuleCadK5OZ7nIYXkJ8Gy/zOg==
X-Received: by 2002:a5d:5f87:0:b0:44f:f8f2:665a with SMTP id ffacd0b85a97d-44ff8f26672mr5117226f8f.10.1777980017867;
        Tue, 05 May 2026 04:20:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b03d59sm3787813f8f.20.2026.05.05.04.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 04:20:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 92A0C5F9CD;
	Tue, 05 May 2026 12:20:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	kvm@vger.kernel.org,
	Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 3/7] target/arm: ensure aarch64 DISAS_WFE will exit
Date: Tue,  5 May 2026 12:20:09 +0100
Message-ID: <20260505112014.102993-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505112014.102993-1-alex.bennee@linaro.org>
References: <20260505112014.102993-1-alex.bennee@linaro.org>
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

