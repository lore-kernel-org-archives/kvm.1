Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47343DEFF1
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862956; cv=none; b=buyHRoTlQpEBgCrwHLofzjk9B5t5OCACo6/hyS95nTuHZn56vyap8v0esypjojJP/HSwgZid/VWc169wlUWtBxb9NusgqCJ2e1v7tyt9+BERj2JClWqL7o9Q21iYXHeJYU3XwILjWqYjQYlmoAydhxaww85yt+Njk/PN+xwancM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862956; c=relaxed/simple;
	bh=mTHqKZdyVGIZLMhFJ87JytFjQaPWNezBghnsDlTRqW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Du909rCpmBQz1WiVRPuQ5aBQR/xN+E7jBgu+FFyNVPAFbDlgsEIHSbPvRmeEoM+MOLLWkLSy5cclDurCUYLHzxJra8DBTCmU/PI0AYsv7LMuOlTXA9QLQ0Hy58poQoMJDYa+PgFtPlLhOotw1olEB/FPvOaSK6ig+X+I966DaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q4jf9Smv; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q4jf9Smv"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so69655955e9.0
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862953; x=1777467753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1esNeOF5ufpO0cAxHdsE5rjzSjC5Q+4Ajm02teJ1954=;
        b=q4jf9SmvAPEJrTju23YN9Fqx4evv5ryWo6+v7oJSQxblHAfEHjMOnkLk+pV/eSSYjZ
         DgZaRK0tnGqMdHlg+pzHd1ksIlcQYfY+nu0kIgUfKAW88uEhBROC3/YnNnKxIgaRmYo5
         S8S5OqchnJuhYQIoA6KreYuf0iyFNsyYPyv+uyjGvtNCxGnQwYgROyakjq5r42tZ7V7F
         nunfRKL5WWlqWkCrs4eZa4atYxAsPtqclVQvNTgUG6Iabw1jesqFNHUMadWnOKkcYapx
         kbeIsFiQ9tySvf61dVutwATbzPSF71LFpEjTwZX3pNKP5rKnegee8ZsJEV/YdiW3GaYo
         RCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862953; x=1777467753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1esNeOF5ufpO0cAxHdsE5rjzSjC5Q+4Ajm02teJ1954=;
        b=d9pjviCz7lVk1loQjBHHc7LKDEs7iLrTuvX3wF2qG0OU45py2jWeMTjw9m6FZbfEN/
         uL+shw8YxImLUhjEgsbtUerLAecCxpDnrCPbQcl+QeYltaB2+atyYOy/T7z7gPmKWWYs
         vS4TjQzdsUxHLiDA2MmWPLbVDIjUEBV74jPXL8T0uTWlKt98feKwrp/iMunyRQ14SOh6
         dtR8lqD6NfcBOM7z/DlZQfSV6DbDOMnT31YuyDYZmp80KOcAH1Mx3cMPqMwG/ydvrPdt
         Isrp4RcCFomv3nMOij3QwCKl93RaodS+9I+Upgk0TJCTf7qhLlN9SfzWKUJdFRUAjiTH
         finQ==
X-Forwarded-Encrypted: i=1; AFNElJ+iFMDOvTK9I9DM4Wx6Bl5tEwMRAlO3HsamsUOtAZMOkiTA73OI2mCuWT/Z10rnKe/usiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzfmpX9TyNBHETJAPcyOpXNXZbukysA/qIT2GtceT8JbL0sPMN
	lOV2DPHykIbAJE6/LjfyMl4eSF393y9Ng8yQVOJoS1Gd5qBGPyLWhMzUBi60d91PBDO8RnlIvmI
	qarnx6fE=
X-Gm-Gg: AeBDietT2pCqe9KmxY0ZJAUXEOHYxI0iaE1qbuWh2Wvtk/jKip9Smgy3mo2V1ftZ4qQ
	92ip6KMM/BtU7ZnjodYZacng4QYpbFOvzhBT6MeoMCMJiuN74GacuY8hL9e5Ai09pITVpBqhUjc
	dRYwkcYSvcWFD1lpKpwcxzXAf5qR8vXttJQvJIQq+Ii3TLqEMc8aJYgaD5CWVIXzJdcXvpuoS7d
	iIfSjTbzTUonH5YDELsjciri/bb9RYLC34GgV2BIWlJwK+q+fZ16u+JmyU0DszIkGE1ZpCT3Q4T
	VOpU9ssaavMYFOApQ0FZtXt+twUQemrCthDMjbHf8FnzV6/xnRfleFntbIMSfV6IKsF+SANchAf
	avlljlgPpFNwNpEhOp+Actw/saXPEMVHD3Y+uk/dlqVY6+hzYSiv/Xo0NaN3Tyna0kzw3gXszep
	UIFD/R71OYjFS+Foo/vCWp2EZzuHC3sQBfYQ==
X-Received: by 2002:a05:600c:a108:b0:488:a82f:bbb4 with SMTP id 5b1f17b1804b1-488fb78a0famr276133055e9.26.1776862952883;
        Wed, 22 Apr 2026 06:02:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc10019bsm458543425e9.4.2026.04.22.06.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:02:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 64AB0611AD;
	Wed, 22 Apr 2026 13:52:52 +0100 (BST)
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
Subject: [PATCH v3 18/32] target/arm: make whpx use syndrome helpers for decode
Date: Wed, 22 Apr 2026 13:52:35 +0100
Message-ID: <20260422125250.1303100-19-alex.bennee@linaro.org>
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

Rather than open coding a bunch of shifts and masks we can use the
syndrome definitions. While we are at it assert it really is a
EC_DATAABORT.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/whpx/whpx-all.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index bbf0f6be961..4cfc7f99698 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -356,15 +356,16 @@ static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
 {
     uint64_t syndrome = ctx->Syndrome;
 
-    bool isv = syndrome & ARM_EL_ISV;
-    bool iswrite = (syndrome >> 6) & 1;
-    bool sse = (syndrome >> 21) & 1;
-    uint32_t sas = (syndrome >> 22) & 3;
+    bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
+    bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
+    bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
+    uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
     uint32_t len = 1 << sas;
-    uint32_t srt = (syndrome >> 16) & 0x1f;
-    uint32_t cm = (syndrome >> 8) & 0x1;
+    uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
+    uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
     uint64_t val = 0;
 
+    assert(syn_get_ec(syndrome) == EC_DATAABORT);
     assert(!cm);
     assert(isv);
 
-- 
2.47.3

