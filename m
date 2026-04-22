Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14693E9F8A
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862383; cv=none; b=BXG0+7dLlwGj5QUEa4C7VHNaZdznQ5H+DE9wtL8+slIcB6SkB8Om/ps8ZowrjYDOeoulcX4q8skcXQOtDMppjCPydGWoxICHgbbE8XjFcSEyUYumZnjelKvxiJMeYGZ81VjiD6kXRj3bmRzEgTVAn20mzuKo3U+IruhEbFrpX3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862383; c=relaxed/simple;
	bh=Oa1/TK5EJ72eVFCDyAhGMHj2lLuVlBIFPfZf0dIV7mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4HJoq/SEbgJTfmaVOHZwL7/EKI0TmIS9KX8k+4QI6embBqkiOwy1JKwQtEy86s00Q8uR8x/mwFvWzTy3R8si1bb731IFwtU759mxE9sq19I3sqYX0dFfXGvC+n6tWsq38/1gx1ZfrTP/CiGVFkrzprJO/IgqzL9jLbxe4FNXFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RcJAKv6Y; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RcJAKv6Y"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d03db7f87so3703008f8f.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862380; x=1777467180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUXCf79/aCPWP+oojaJHciitYmV1hJJUoyGLuPcbhOc=;
        b=RcJAKv6Y2t7YBVwu1bvajJZgYAfKsYGzC5ADJr02tpFr4wOeDUG6pTdDSMxcGVrZO1
         YyzT5fc/3YtLdFiu+JzQ6nch891pvNEbGkWFdC2Rk/7T518N+AwxoZ7m5/oFf35G8Bkk
         SIJFH1jAX0AzMC4rDfiAlh2wlI/ZI5frK46m1Ffv992b+jWK7jmKXcSSAWSb8ZPgcLdZ
         lqQCsisqOxVr0OuL6X34jOW6Hs62ugrJFUeK3fiAJ8RqC9ipK5ltQ+XyVxp8AHYSBpmc
         T1M2060diCJyIj+0t01HqBpaYbMo4G2MT5QwMzEYufeO27pe+xJHJFscDuQfmZ6gWVHo
         MJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862380; x=1777467180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rUXCf79/aCPWP+oojaJHciitYmV1hJJUoyGLuPcbhOc=;
        b=Fg7uKVhMB6INch/mDoa5ydThfwsd1wWAml+9Gt6x60o0Gw8r6b6+G6i9dre7doK4Vp
         RXszWOLSK/7kQYU+dTYLcAyjVN02qTsJmIWqbF8n+zOcH6tSRG9HHb0acGEYE67rLQuF
         YGmMaiiNgnzHm2yJqFBMOSlH6LzZkwFhnjfTkPo0kNXYIcvg0fd4LlEcz4QJABAirsre
         9Qo8ZwQemPPPLPHnXroVylet0N8hOo16KBb5R/zlpGyBfcPuO1Q6EtWhUDaYQI3lzIVD
         HcLpMyCoaRPRrZ+xzqBLKdXJfGUC6jozp+ev8jnAkz+Affwy9zSAmdKrtbJzjIlc6fzF
         pvmA==
X-Forwarded-Encrypted: i=1; AFNElJ/IGJibCCfbyk7gmhyuOjr5cB0Fg6Cwfd983jXyAvhK7YlQvgzUlrS8LzDsCciHZEwFqck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx4TgwhJsB7UTmwiTu1KepRNAiqkxRn3aXAtwYUv5qWWYbrM8Z
	bI8uUw3DDFLYVuLCUVblA1NxlMd+xH/c6sru8uQM/8FtLIGUsnF3wKebaGcHL8skxhg=
X-Gm-Gg: AeBDieuRpK1CQMCwApAVIV2zPvlKBsuxSYJmLypqrjWzVl5XsAZN8gI/UUNRySQ9a4O
	nLJGRHnQbvNysQIpxwbr47g5BSh7D0tbdiVv8ArYzF/t9+Ff4YLO+YYgin4d+LTLclw9QTQg+f+
	V+vn/wM4csZhxN3oB3lNpcBKpjf1hJcVzpjda4ZkVERUZ2fKDw6eEGmftpqOP4ZmYqmgY328bO9
	xMA3nXvNPrTPGFdHwIaWKsrx81VnM8Yiiig7F/sMKt67kqMU5pwABfOwrl9n06deXYzf2hdwDCR
	CSxXhu2uqVstU+46GCYB6xTd6xj2TcF7iE/UEtbmHfQ7OIWQtL7Gggo/0bDxcB1g3hsjD1VPTq4
	RE+CNCuw2iau3GAjKazU+xdnMtFFxVIW+Ps6lbC2+glU+kddLYp5dqwsPXOFIUMyMZ6wUUlDLfa
	nBslmLnk/9pXZMbHCyrV5zCOemwx4E8zqyOflY10iASMg4
X-Received: by 2002:a05:6000:1788:b0:43d:1c39:593c with SMTP id ffacd0b85a97d-43fe3dfbcb8mr35169488f8f.30.1776862380024;
        Wed, 22 Apr 2026 05:53:00 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a18csm51870727f8f.20.2026.04.22.05.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 05:52:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 58FDF60342;
	Wed, 22 Apr 2026 13:52:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 05/32] target/arm: migrate SME trap syndromes to registerfields
Date: Wed, 22 Apr 2026 13:52:22 +0100
Message-ID: <20260422125250.1303100-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use !is_16bit directly
---
 target/arm/syndrome.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 63c8e66ea91..61053475984 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -384,10 +384,18 @@ static inline uint32_t syn_erettrap(int eret_op)
     return res;
 }
 
+/*
+ * ISS encoding for an exception due to SME functionality
+ */
+FIELD(SME_ISS, SMTC, 0, 2)
+
 static inline uint32_t syn_smetrap(SMEExceptionType etype, bool is_16bit)
 {
-    return (EC_SMETRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL) | etype;
+    uint32_t res = syn_set_ec(0, EC_SMETRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+    res = FIELD_DP32(res, SME_ISS, SMTC, etype);
+
+    return res;
 }
 
 static inline uint32_t syn_pacfail(bool data, int keynumber)
-- 
2.47.3

