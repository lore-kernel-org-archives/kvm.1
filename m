Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85C53AE19C
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043395; cv=none; b=Y0XMLG7RWC0nNVeGzkT+aZqmK569tB6YCkq+izD6LcpRlu+Zjot8AiYHZnyMVlSE8oa4BRiLUnE02MAlWh+lSDXEIZdTPB+9jcIzPHLARLnjkZUXi0glHBI020RPADDwy6psJg5GHgaieX23XIrfEf6zWkZbeeGnmk+YsfFS0l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043395; c=relaxed/simple;
	bh=8dhxb8bks3V5L6qoivpBRlNbSnSjj3PiVH/yNm8fV40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDMFQSUF8Us1wnITLUGCzfUxQOht2fAA/Ul0eicJgfYpYMrf9Snt2/8vhIbOQz4Tj4xwwU3QVDcmm64VEdNarL03UZuak6VnCj5uRE4aURR8weiRSZO3oCj++9RfWQEgukEyjThQZUIsKSh9yJakHTQPnVcU3jZ98ZUI51x2gjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sga4H18k; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sga4H18k"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so77500915e9.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 01:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780043392; x=1780648192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hbeufYVzoMG/wzzAjSBDrNtpV9A32DdB20M94ZA85Y=;
        b=Sga4H18kFErF1p2OX4mdhmdn7Ol8JZJSJZcBODiasbIqNJjc+T5isfnpylgYGzruQk
         mZ/EQCTACPH9zk0Y0O6Wm+Ckw4Z98dLBUgisrdRYmBEuE1BWwqnMQ94yEBut9Q2voFW0
         JhvKoz7hn/xxpeju3MmL81NYIPJBRPt2ojJ6GHJV/Io5VgZgUpZa5ORJfq0QvSMylAgB
         bm1x7ffLPsJUC41iJsXnanrCIclDTs97oEBhhTYA8m2MIUQDcdHRfJajcPLInxHAvltu
         wv5NWtP2/92t3mOLc4EqsqL5ezP3fPF7vuR4+6UcEPKXS7xVM+bKYdlVkEIbx/vMmPWX
         aDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780043392; x=1780648192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+hbeufYVzoMG/wzzAjSBDrNtpV9A32DdB20M94ZA85Y=;
        b=B3BQmzr3h26tIYMr6+br9ABBuIYzhF0+vScCbLl28ep9Uxxyd8hWHB10NjVAKyG4Kf
         +825YTjxQot267o3yzXBt0kBFZ4G94p3YFY93Y0q671g0neZT0xpiPHI8H2PFyjjITxL
         l7a9L5NIuvPQR5/CqEWOYv+nQcAe4ChSEW7Q1D41lIb75WV/e2sJP6DUXozOWO8gkd7p
         XJa+vEMpfuNH+mS2WW7YDbFHnmLhY5a0gxP3/+D1XXcBecDWT+GDkrg/T1t2z4l+AoVx
         aiS0vmRJ+o7z+AwYWmIXsP/vdoCpfjX/iVjYv/lQjIMS3/LyXhQln14xtDCxb3kY4mHA
         bMAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+hZ93COjLPXHOfXktWOsSKUZfewtGN88LeLvm+dLggL+7GhHfkwF5coK1Snc81mGArOnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ymf/XA0WCBXSLojaYMxsLqO5GzlAvL/w3vZWSU9b9gDveewT
	01CYBmaUWqf6Pr+IWY+4J6tsoJQ0aEOq6qHR/LfAP3PZEZYd4Q61Xrf0FaykLZludoI=
X-Gm-Gg: Acq92OHG4JBB80RHRZlKgbPdz+H25g6XTi17mpV1mdZjAcZUrs2FO5dqQRKpWjZvUhr
	bRd7LMU3zXnqqj9WgNEQHseZRKiaP3a4c+veMMJZ0ptLhz8xZO79B6FTsICPNqlcr4+iR2ueZws
	pFjkeR2xt8h/VaQW+93LhHVPxwuMN4aPuTPurgtw39oj77dfJfE5vFemifwbQ654exIVLugZ32E
	/I4q6tW5VcpvgDROAfQEwDuNfuxsXDFn8cen+cbC46fIqavrq/4l5qITy1iUacmtSRqTZq8n7r/
	14SHNEITbDZzCkNCUsoBfPa8GkIjuyGvw3wer/80ABLsCbxrKW6Z0rMqMMLYUdEJ+X6ZKpHcwPH
	84ckkL9uJJ5cmyi1PZ8SPKeHq+Qc5mweJcET3/4dGbr2Nj8ZobxJKhulkdTvPKUhLFhcBNePXaH
	lAWn+bXZ202dymQ/N+xjx2MdTpAMEh/NWqPA==
X-Received: by 2002:a05:600d:864a:20b0:490:6869:7d8b with SMTP id 5b1f17b1804b1-4909c089d9dmr24637905e9.15.1780043392032;
        Fri, 29 May 2026 01:29:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c6319ddsm31623155e9.0.2026.05.29.01.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:29:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 8A48060335;
	Fri, 29 May 2026 09:29:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Peter Maydell <peter.maydell@linaro.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 4/8] target/arm: ensure aarch64 DISAS_WFE will exit
Date: Fri, 29 May 2026 09:29:43 +0100
Message-ID: <20260529082948.363931-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529082948.363931-1-alex.bennee@linaro.org>
References: <20260529082948.363931-1-alex.bennee@linaro.org>
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
index 15b40090c0f..c20269b1501 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10939,25 +10939,25 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
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

