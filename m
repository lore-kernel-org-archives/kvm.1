Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945553542E5
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853051; cv=none; b=KJZrsxoo5NR99vcD68Tt1MDzRVQKxWo7KzOwmX44hpJ7gjmzMOnPO0r9/NQm5V4f0yFy8bo1nVvfHJUAvmYjooE3M39gXFMY388iqq/u5g/RZJOanSI9vla2QtUwv1xdyoUnDDcxA9og9zEp+lQfjzKf9ztraQE/OOc4OsSDbu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853051; c=relaxed/simple;
	bh=njaaxVkDTZ7V3g2mtdEiQS9uYW4hol4xRhNOHh6yxVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVYNTI/CPJ2N6qQTatoYnEitIaC25S2cADTgTvxshageKaNQE9eanb7CeUBJijTXnz2U03KUREsPpuXeqUOYW2SOyDuAIjfsAQgvM9mZUriMYVgMtB95EO9SxSWFelKtwg7FG8ypZ/FRPQ66SW4IuhE/RYIrKLPEfRUqWmzmgBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IyMJaawI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IyMJaawI"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b150559bso41662325e9.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776853048; x=1777457848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHt/fkh4CQTgDK0U2IQzNp32v6ZUUxM/zBvWXPy5kqQ=;
        b=IyMJaawIbsjNT9qsRxeFZ3uaStSTCgbVq6JGSc0q+/q4aiG8ATexqhuTXIzEbVu+7I
         lVK5ru/G4UGqgy3tGM/SjGQm7CD1FnTw0JavomsGbftjCPi+3PsBBUrBcWW8v7pTwJTm
         2P9EtDNayZ3PPSMXC6NiX/Va2QUg/4CQwGQ+Rmy7J47qnTaF8TV4LBnyZ9LIKqCP0zz/
         +BGjgp+HDemdjoUpAw/BloWx0dakL5rzFdBgTUAJFIxkhfSSE0pkj7p0gDYoyX96uSbh
         59lS/ctAXERF3ArQdUCY5CmqyOnTuX9tDsRRkVHay97w4GTjv+M1aQo/3eYTbOeofYPg
         d92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776853048; x=1777457848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LHt/fkh4CQTgDK0U2IQzNp32v6ZUUxM/zBvWXPy5kqQ=;
        b=NCz2vyWMQ7jBiMVUvF+Bb4OlyWwUap8h9hTx6tHQJlVxtJEv5lmZfvSNu2s5qkmSm/
         S/pg9bkT8WLeXLejnwA1BeUw0bWa6XR1+zGri6Qrke39KKuR/Qhhr+ql5anF3ghChODw
         PIFUiZyaZU5cJIR2LkqWkbTnHwIfxcivHNu42DQ4evJfy/Zz14qJYuS0wERf8x2/px37
         6pZ1CQNjZaQE3MaR5p/h1NeUbDFHJQ5d6yd/IISq2bj93HJ/DbPOl0lK9YPxUGGUH2Dt
         9ByXADs+dLSVjGYtAUSP2lNhAYnLXxEbgvmCgMpxcNIXfnrDDXwMpxjl+gQ79DaoOGNi
         N0LA==
X-Forwarded-Encrypted: i=1; AFNElJ+N1QG/NnT/q9CHYbiW8NV6sp+NFOTqZj0PtUx91uSUHVPPSIWBTBzNnfQypjwQ9/Fx2Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGVLUIm9t4eObnYZ3bmVwzx5ULreZHbuo0c8ZOcvLrSarcqOwD
	f5rJ5bIT1y9eJDTzfOYZ/GmLAwGEcLYFG6c/l/CNXUOLDYX8vVvrtKEMaZeqghj8L44=
X-Gm-Gg: AeBDies2CJ/flGH3FtzJQkne2LjXIWMY8ufgi+fsAHa/oyw6lqZnmfQvFy9WUMhU+OV
	TaTOtmg++Xjhd9JAWsAOFV37IbBSUvZn45fRuENRcYtjQkQIAT9sDCemcUBAG2Y6oFkld9jy9NK
	HjTo//3tye81k/KQRc6wU8BZo7UUBwmQD9jxlsu7gqQM8QZK8ranaStFFA03QKPS17veENZNxiN
	/FQKTHttUewPIYj0uT93WVnXSw3hUQq0vUgBuCIhtR70X90QMPq7a1gA8fEfxCHX2qQZxnLAD1G
	xPq+Oh4IXyvPTt5wQCbzUxXf3x8LYOq+5KwcV6fU/af+DQvlWwIsm6AldhAAlNzLe4qOXiZbILV
	6BM4hVCVX+sORwJCzYn9+9RUXxbEaBpBWiPCitlgtPNO1zApSjfCRjsYM6d0407IPRGTF6SdCHk
	BKxMqp9CL6mY/4O+/CCNGZGb5i/tO1c0Zu8A==
X-Received: by 2002:a05:600c:3216:b0:489:1ff1:74d3 with SMTP id 5b1f17b1804b1-4891ff17521mr88617735e9.20.1776853047996;
        Wed, 22 Apr 2026 03:17:27 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891cdfcd50sm84551615e9.9.2026.04.22.03.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:17:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 863CD61667;
	Wed, 22 Apr 2026 11:10:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
	qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 26/31] target/arm: ensure aarch64 DISAS_WFE will exit
Date: Wed, 22 Apr 2026 11:10:37 +0100
Message-ID: <20260422101043.1234229-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This mirrors the logic for DISAS_WFE in 32 bit world.

Fixes: 252ec405768 (target-arm: implement WFE/YIELD as a yield for AArch64)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/translate-a64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 073454b9195..d79c8ab431b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10917,6 +10917,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_WFE:
             gen_a64_update_pc(dc, 4);
             gen_helper_wfe(tcg_env);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_YIELD:
             gen_a64_update_pc(dc, 4);
-- 
2.47.3

