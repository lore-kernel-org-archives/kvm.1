Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F50435838E
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862950; cv=none; b=U4UlCVHMV/IziziZfQnxJ2LLL57OrkXAfz48XWdgAG4JAtGIOjqpzougMNHOP7FXFSI8TLmI7mi/Hl8OmWXVnKeKfV3+NKCJ+jqhcmMwHK+mQFarH/3E2zVssA9gren2F9Ld+naqWxlw/sqauCpk2OAO5iR2cdHF6FyTeMh/wAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862950; c=relaxed/simple;
	bh=MVRJ11iQlKTt9wTFYKhVcZXh3f8OHh+FpmXp5qiYkuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5HB7r3uvtrV4WzOIQerPyXCzypPfuC4llQIsT6T4MHUQGgQNfSOn6HItWKc1NayjWOGMliHzxxAe1Ko+o5fmw2oS7UZc0GzcxSN4WB8bCCrn1AlDwdEAY6DQmllNyLEfwYepzfNXZfe7n5NwL9kLfpgz8alT+R+RZDl8wXUCao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZBvIRYK5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBvIRYK5"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d73352cf2so4471016f8f.1
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 06:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776862948; x=1777467748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLzSB9spY+gJhXJ81HA2xrXzxJ07lupyVRDFchBeQ6c=;
        b=ZBvIRYK5RY/tNV2Ena+sZkYoLy9jL4W3EJWHRqPGuB+h37pCfAXf63G+9Xl6GY0pqc
         BJ9EIxlEanLOk7auGQeqNnRQ6zYinqm29FACgknNGasu0zAui3p6TZrWoHsUZsv5XU+y
         OVxLPnzVVkaPu6uQ1RhonAwZII3hkAQtN3Ks7rTkOb41DZbVMEPk3dbW6QvtXysPIly+
         oRxUuyOn3tBog0QddEwY7NjEO/LWRy5m412OFM6jwOhkXo6lMdJOLZI+obQGsGklY5a7
         mFGvpWibyBej/fFjmum5j+IrEfumTx0tn/ULw2430BK/lGykB2/nK52Anwhxz+Ay5dbf
         VDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862948; x=1777467748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SLzSB9spY+gJhXJ81HA2xrXzxJ07lupyVRDFchBeQ6c=;
        b=qXVRCAP2lXr892XG9VxRwyaRlNNzvE0akMgzGYdTTxWOgMrfUVqlPUgydaMbcE6mHT
         werfBT49V5eqEKlVmfNFvefnEN9prs3bXIJeubsKsPikb+ENccDHvpQRgrvK1lIpmyuH
         EmGW9wQj5mYWSw+JXslRtgM8FQnRxn/xe+PVW9bz9WLV7MAA1rzZyIMXexq4OTOAYM+w
         rbJgyC27YGxvNKUMUyrRmTKVD2pRURP9vHJ55KAQM/9KBu2c0f7r/3jr8lg55KcgB3hM
         qDkCd9YtkebafRqFbcmUiWBYxKaR7+SXMYc5WhAqzlaNvcHSfSdVMjJiJE1ynoFvd5Wm
         HJXg==
X-Forwarded-Encrypted: i=1; AFNElJ8F6CxAXjLcFdmoNDupXCx+CX5fKYEZun+nG72ewh7dhVmavRrV+bnUkMvH3rn1U00KLTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhvAHEbP4GCkMc4qmdcldWDwgGPUkVhfOnbzyjEy4gHl21ONuS
	2SPCw1hyGT9hBlG2haOaTRAFrF4jaTUEiY08ENpDjeOYx2C97d/Yvc7e3ZOjYokq+/Y=
X-Gm-Gg: AeBDies5qOtbqvfuaFCl4AcW0xnFVBhrufhxKYtqm+D6Ld8mRvwx+KcZO5wl6BDREZP
	ND6+PLSdk/whD9EaLQfzJM60nnstKDZYUxbTdnqPo8rgoSJttE5LJKIZa/0RxtwI8ty0wy2yg/d
	36T5hi3FqsOo1yBerSPC6S/FPkXSzXlhc/FTmUMUe2+Sm0QUTiV/TgusFKYOBlWz2rFahad6xjl
	xOwmj1dheGmOzdyTHKWP9d3Zxv+BJxeYEWFBUpLy9l0lAqq9dyxYt97DVTRc+t7DFlBYbFGhid/
	MZHhgsO+80Lk9NOthIyL4YlW/FsDp4+vXkceh/JUwvlQEk7htDkeuto01Ov6QCUjRj/UxcNvpOR
	Z+/uSRoTIamXrD3RXeBYGN08xrWnNuzrJ45IfXT3a8i5W9nMJTOJgzLd+ozWpEf5RHEhjjNaO1b
	U0vteqHV3YhSEv7kLFSI4dzeDqd0XZDIJQ8A==
X-Received: by 2002:a05:6000:420a:b0:43d:773d:78ff with SMTP id ffacd0b85a97d-43fe3e0b61bmr35815340f8f.27.1776862947410;
        Wed, 22 Apr 2026 06:02:27 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb13a0sm45667079f8f.8.2026.04.22.06.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:02:25 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 50DED611A5;
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
Subject: [PATCH v3 17/32] target/arm: use syndrome helpers to set SAME_EL EC bit
Date: Wed, 22 Apr 2026 13:52:34 +0100
Message-ID: <20260422125250.1303100-18-alex.bennee@linaro.org>
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

This removes the last use of ARM_EL_EC_SHIFT.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - drop ARM_EL_EC_SHIFT at this point
---
 target/arm/syndrome.h  | 1 -
 target/arm/tcg/debug.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 53137394e28..d4dfab8cd15 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -107,7 +107,6 @@ typedef enum {
 } GCSInstructionType;
 
 #define ARM_EL_EC_LENGTH 6
-#define ARM_EL_EC_SHIFT 26
 #define ARM_EL_IL_SHIFT 25
 #define ARM_EL_ISV_SHIFT 24
 #define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 5214e3c08a8..07a52643e71 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -56,7 +56,7 @@ raise_exception_debug(CPUARMState *env, uint32_t excp, uint32_t syndrome)
      * Similarly for watchpoint and breakpoint matches.
      */
     assert(debug_el >= cur_el);
-    syndrome |= (debug_el == cur_el) << ARM_EL_EC_SHIFT;
+    syndrome |= (debug_el == cur_el) << R_SYNDROME_EC_SHIFT;
     raise_exception(env, excp, syndrome, debug_el);
 }
 
-- 
2.47.3

