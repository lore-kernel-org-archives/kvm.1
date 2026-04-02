Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FF83DCD88
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149534; cv=none; b=Etuhk8s79WrS2bGX3A/KmsogQhPMeRzY4o0Vluj/ftXGrFZGKWDOwnwSvMISRlREtEG9EFsUJkJ//601v9NNmvURWD99KhlfflpJRi0Zqo+Dm5eoJKe0VCGFD+5OwIYx+i8eZ+JMAPcW+xoQCAPi80cO5LKbNxVMiiBzkNh84XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149534; c=relaxed/simple;
	bh=ZVlBx3jUF6dxoULLqnV2A29vKxFoZksTGD2x93xyva8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rakwY5bJo2Mhn74cJVwbzzEfsMckvcSti+YEamT5O8hR63XtiPKCpFnZJSDstnEOXXy9PtxWLjtbC5+8vWUvg6yc1FdAz4TtHw87UdhbTfUh16mfYUnM+slwxSje1aImFMPP6fyAEBfu9/1piF43cbvRQ9EcBSyrFMVb8Z7r9Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pRrB2Qt+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRrB2Qt+"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486507134e4so14954125e9.0
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775149522; x=1775754322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5um0Hkp4gUlr+ZAZ+thc8PXoevdikb9WS1n3IueTF8=;
        b=pRrB2Qt+dJUVMoJWvhapdPpSQmuw0lZFGzUg/h2hRRIGNapPILxZ8BWQ2NBQZmYouF
         ciA1VRKXYU/JhGyDtzf7s+R1B43LOVR9+r+7anQwA/yQcLvBQX4X711NQFPGP9FNg/gm
         tcgjNQr4uV2jWEQhxBOckeuVDyW5b0b+Y3hc4ECXWT8nlAa3/83JtbR/Q3GUJWajK9O9
         EPln5SbOMkacMlgCOYA+781P0aKjpxqosInHoczJeLAbs2LqQpJ2+O6Gqiblq6Y4EqhF
         /d3XgvCQuHG93G5uybyigEq9NW4j1uIpWfMB3aW0dIsBhuJx1xm+yrAeuZJ2dXuAedOv
         /Siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775149522; x=1775754322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G5um0Hkp4gUlr+ZAZ+thc8PXoevdikb9WS1n3IueTF8=;
        b=gl31dpRsYTtnQhPBaWCENQlI4hSYn4xnNYcO1wXyPYbWWu11XMG++dTmGbzKvTVjHZ
         MYqUhy2hLxDY0SxpKqbyipn8Pu/bJaawtrpEvdz6TNMJG/AaZVlu4x6s/Fg/oF8LtQWd
         LR/P7iERsjEEvWq5BAVeLS4FKBXPMD1cAO/kiYiW3/cbMISK3S9hDZYBq/iiDRP+FnBJ
         z94sHa7Z+X+IyLEHFXK3UQN2ICEco5YCXf4D4DJba0pUq+GLthtDV/j3TYmDTr0/Tz7T
         aTsGSlxb+KNd+AE0iLEY42EgnvwOpMTzm7Y8Njhc2CLWeIFqwBF0ar0vnjeVkRX1svTC
         kHMA==
X-Gm-Message-State: AOJu0Yx2OyyZPsaN8jfihCqwGBixyrtVxupqe2FNV0FT0sirmUVMCLv0
	GEERRRwrG8F3IP98jD3vfsFvF/a1ynyhYkAxPH9OquV6qGXGVgutevy9vMEQj0hK4OQ=
X-Gm-Gg: ATEYQzyglrdzgjxb0C/GVaoq87g40OAfudmnkoa3ofPfS5LLqmATvh503HCM0x1oUQh
	XtggzlDn2zUG6aLG8eRXaskzsaPoVtHw/cPZeDtgt796IE0hpgN7LkGUVrt+Bbxv7BYX6ZvEX77
	Nd8P1RTtWLEJC2VbmM2PjIg9aVbM/bOVYWVW9BnY4VOFdGgTBtV1cVT4Zp1bJz+3vBuscekjgjm
	hfLvvMbFVlabTP92HgSm8WMAJ3EQEeIJE1OlVtQTlHzVS/6+cFtirYX0qPjuRialMJJDSmktHy4
	pmUAvcwzEdsRwlgFuERC3J6FXJWLbkqq6jog78kFxNXhE9bKDz7jzkPXBknVmL4LdL0uOJYujAi
	xwJTuNE60CJYWwiuRvTM4ubvTvu9AYQ9aF7AePylLJgb6B2aiZ4Fu6YzwTXRAiLJGba12z8qXSQ
	TWcTEgUcp0SBV/ilnxO/D7c2vf7DgX7HdF1MLZQNUGJrBVm1AbhqX/H420h2hr8H5ZUk17WGCu
X-Received: by 2002:a05:600c:3515:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-4888359cee3mr152160325e9.16.1775149521759;
        Thu, 02 Apr 2026 10:05:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e832585sm385581555e9.6.2026.04.02.10.05.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 10:05:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	Anton Johansson <anjo@rev.ng>,
	qemu-s390x@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-riscv@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Alexander Graf <agraf@csgraf.de>
Subject: [PATCH-for-11.1 v2 6/9] target/arm: Remove target_ulong use in hvf_handle_psci_call()
Date: Thu,  2 Apr 2026 19:04:31 +0200
Message-ID: <20260402170434.94783-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402170434.94783-1-philmd@linaro.org>
References: <20260402170434.94783-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Similarly to commit 3580aa03547 ("target/arm/tcg/psci.c: make
compilation unit common") which replaced the target_ulong use in
arm_handle_psci_call(), replace the one in hvf_handle_psci_call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/hvf/hvf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd9..678afe5c8e1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1418,7 +1418,7 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
     bool target_aarch64 = true;
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
-    target_ulong entry;
+    uint64_t entry;
     int target_el = 1;
     int32_t ret = 0;
 
-- 
2.53.0

