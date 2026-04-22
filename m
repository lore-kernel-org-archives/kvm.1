Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167953CCFB7
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853050; cv=none; b=lkw0qs90q/fyggKMr1nl904Nyhx+V7yIC8qQiZ21fQZr4YZJyhbv8UPrQWZGrxE1McZuGe15Uqimx2TNk2kxPekC9eZHObpSBP0bU9++cBuDq0TlvDmkPCeiWNDfwvAm6PVNwFOkcitsoWQzTFxQHe73ZPU3LC2eM/LSI9HBmeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853050; c=relaxed/simple;
	bh=lyULEi3e+kfDY4pAOD/6uauE8RXFENVITu7ezFzC9Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g08UpVXa9NJp50W+xINicPQrTQolgek3Ek9ZBKaPOgAM9AVF3u2OcZbIUQ5qau2Q6q3l4CHJ0qaFVGzKFG/izJo8ONeW1J5rfFBpFXX1lLTASTqfA8gQicepBEPxPqz3HnM0gcODnP0sJs7Rpk8s/l7DeNWQ63Go6kcg60yWbm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OsvSMp8Z; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OsvSMp8Z"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d03db7f87so3571669f8f.3
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 03:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776853047; x=1777457847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UF2x3LQsFVeOwuh4smvXIT3vMnoh5OJHhwB45pzXnIE=;
        b=OsvSMp8Z3A61C6caLy/a5eT8DFSU/MQxjs7mgqeN/SqpK81GJiA3ziLHN3YxckN/YJ
         fs/jyquSU+Lwv1mFjkyYXXDW7JOeo3azEM6ObO7r/2AUi9IBub8J4YqxXOHmcsZygbv8
         8cJCYVPw8tCfhpexyHUkYQ3oaor5BgZh/Ig/oYWkIGHHScUOWnvw26cGITfBc3EjUAGG
         DT3RyLmgtueHnOz+gnGcv9KaPiIXB41x0ps2JUrm3g03Yfj+q9qhHzpUClvb0CbJtnUL
         1TeF4ZLSk57JDDDfNTy1L3BAX/i4UhRFdGr0jPR5+T2uLBV4QJI+/KjxGOSKBnfWm15r
         2kAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776853047; x=1777457847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UF2x3LQsFVeOwuh4smvXIT3vMnoh5OJHhwB45pzXnIE=;
        b=AK8kEbRuivRxugUjRjlSC0AKri4wc+BDVxkMv9QpZCt9aVayBrA9QJRzPDIaFj79WE
         Y+VUT5VCQbTGaVIjxgszpj2B6ceu1YY+U4cs/w25GPgl9bHnmDUOBWXCV4jjUcS7eo09
         IvL313Tve2bhOUVRXzb9xAXVUpDk/+9ZdfZi42uC0NvVLLSROqUbUCkAPsVxPTixUtoh
         ljhCxwvlGeiYB5+hZtwOZqsmkL9YA3fv4w1QbSkUXkr+gW6oNZo2JAiJZ57w52pf1OOO
         PdJD3+A4PQ7ikM1lieHYU4rqscpKT1IePsRLB2jKaZhRVJDqXKRHjgLnhp3ldVp0Aj2H
         3mMw==
X-Forwarded-Encrypted: i=1; AFNElJ+rUTLjlIwAqCK46Rpd/xAgOAODALn7qxqkzlCZinDO9vJR052zN/ltVeYxWUEBDHlu/n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzexetN6kQProSih6/0aeYjSo0K3cR9yiF245p5Tjr2y1AIe0ZV
	dp0Eui2IE68PRL3blVn9StvFXhJlyzeoDbro7jqW1GMJshAuj6IxtjIpfHevTynPiYA=
X-Gm-Gg: AeBDietkn9EuR/c71w8YekfuWzjv0kUNVaTCiU4ofwis3PvOBcnFPirin1XFitdPjs2
	yvsDEURFa6jvoZVnr8LZ2gF3CB4dm9XOacv9aWjyjA9AWPPz/YAmEV6/z6X+MqwUldXz+0RzNyU
	WoSY/bms5MMTe5uQL0o8ws54hwSJWUDFkkRZr6T65taNgT77a4txj11qlQItM7P+/wadanTC9nS
	YJjy93N1Jpc5SSBNaM6Di2P37FS/WDP5UxnNW1WcNKpkZh+3t4EEzxkr7plhyj2zcRNOUryS5WX
	a+NbTuTmNCKZW45KaNL6DuS9OhDzHMrYlT76YxjoFyw9INjjtJHFDEL1wtqbnEtCbe1nKgZZ50z
	Qr6Ci4ijxrEGjs7gE1KlN7tt88eExoyu/1/u6oaAtnashBQJknGFk2grhaokHKsdMglnpoQEwD3
	UqIgbsPqI72tdGfhom0udNjcCDCA1UzDO7Yv4KOmkTPXsC
X-Received: by 2002:a05:6000:24c8:b0:43d:70b3:7edf with SMTP id ffacd0b85a97d-43fe3dc5386mr35212015f8f.12.1776853047494;
        Wed, 22 Apr 2026 03:17:27 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d525sm42572233f8f.31.2026.04.22.03.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:17:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 2F18F614A7;
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
Subject: [PATCH v2 22/31] target/arm: remove old syndrome defines
Date: Wed, 22 Apr 2026 11:10:33 +0100
Message-ID: <20260422101043.1234229-23-alex.bennee@linaro.org>
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

Now everything is defined with registerfields we can drop the old
defines.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - remove stuff dropped earlier
---
 target/arm/syndrome.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index d4dfab8cd15..04a71eebcb5 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -106,15 +106,6 @@ typedef enum {
     GCS_IT_GCSPOPX = 9,
 } GCSInstructionType;
 
-#define ARM_EL_EC_LENGTH 6
-#define ARM_EL_IL_SHIFT 25
-#define ARM_EL_ISV_SHIFT 24
-#define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
-#define ARM_EL_ISV (1 << ARM_EL_ISV_SHIFT)
-
-/* In the Data Abort syndrome */
-#define ARM_EL_VNCR (1 << 13)
-
 static inline uint32_t syn_get_ec(uint32_t syn)
 {
     return FIELD_EX32(syn, SYNDROME, EC);
-- 
2.47.3

