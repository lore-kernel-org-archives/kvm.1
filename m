Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D029935F600
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149494; cv=none; b=m8404IGOFHyvbNI3nSTMCw1i9ku3lIAAvAjt2ijbyk1VheSgu9edWfe55hrRETbjStcjDETh2iZH46ORiddEePbuX6FPr7IuumNYpY85BqhNZjRBN6NClcePu1fjd3Bzr3w9A0vAJOuwVYiuUCA7RxDrFjP5gPDkK9CYjf27ZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149494; c=relaxed/simple;
	bh=3o4VgDnfNaFXxqn4Nz62e9pf85l7PncTpGINsBMeziA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0057D4lxce4LaOuUTG6hqutxkksVIo+qeVC+qH/VSjW7aY3d8h81fP7PgtKsCKwnihHizelityhkqD4wNVWwdCZQUDrW2q4Wt0JseA0bKLW9IeULkyb0oWUXKEVb7jpB6jI9S5NdNSwEWVIjtMJII0rLjqjFGjEfXXC53T/d0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wFKASwPy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wFKASwPy"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-482f454be5bso24160855e9.0
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775149484; x=1775754284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGFFrfbr36AmEzkh74oOA4hg7tq9vtm73qaYZR3gMNw=;
        b=wFKASwPyuGkQHG9J8S/y0LHqn+3Jotn63Q5T36bDU89+vLsGzpx3wBiyf23DMlD0Fx
         qHcBjOoYah7bmHkYy+8Cu77viPO+80PigXEDidJqVb+2o1SAZiiBZGFwOQUF7ByKq3b6
         Mjp9VQYj78ziPDfq16djmT7LfIXd4TCn4yb/tFzODH+JKizoOP1lqcc2O/3dIl46i0jq
         fUijqt5lB6OiWlB75xbrK/Eq33vy3bWXH+E/WRfYktsrUZRg/t5qmii9ubp9aMHiE8d7
         lO5zQciqaB38Rac5jp71CqOf6t41s8ab5q+nYUw+R9Cb6e1vnWxH+EC04C8D6CWB9Dqv
         1ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775149484; x=1775754284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KGFFrfbr36AmEzkh74oOA4hg7tq9vtm73qaYZR3gMNw=;
        b=Yh+Iuxie3jCVFyt+T0cqm88laOLtnp/xenZwLaS2TdXFsPiaGL8kEiqvG5jmE6PAff
         KiL/O6VUFzq/dkYpBnXf5xcdy2dc/uv5Y2aSqK9g0fc177mXHy+Bq3WwLFTuFXvqtP+U
         i8tMl01RUu3M+ydy8zKa63AhmUKPBD+wrzh/6y4QwWnLi4XUaIbcT2NeMFFycyhGBSL0
         Ndi61Q5qJlkiufU0R0doq0jIruAHRqBLWfpgC6wAXoWwYkPbEHMZSdAY/4zJD8ANb7dG
         3azRo3+VFTfXH9tPF/0u9Oqgw92OyUuQq6bFPcuSQu+P+QKMoe+IBb0b7lF1HfwpLTAz
         f8CA==
X-Gm-Message-State: AOJu0Yyo6xMQFyu76ePsKncoDCbiqtnbXbkrbAjFfVK+pCOGo52g+g3g
	SkA5KBItFbo5SKnJBxttuxuPrM+o+Z9xaNT0Yg8tFkjyCH4ar0wBkDkQzp+t+XV9n338YI2dH3s
	XFh7mo+8=
X-Gm-Gg: ATEYQzzmFUbQlEAkKYWlJGVONuJ/Wwqh8i5Jy5JxrzLqHeT6z0LE/CWOIyknMlW3RNy
	mWnZaE4QEAYGlxsOHhA+gRR3jVJmCUpIF6croJ/1uigSQ9dX9cQK+356dsl5QR8reI7EQFRwXJT
	NhksLm/dUjen+TloEWnnJIaKXwD4gV/H44Hu2U10m0P56bWaaEVNDZLXmklmRL8xbLb4v7gZoOD
	hxxHQS2IS9LzFQjn/HCHKl2VKw+dT9bYcmZsf4O38odZ8wNfYaqJRPm0rnNzZdvMWLPHq363VB0
	Ae3KOBQWAX10GOfwb4ZkP2d05lnjJxKG5pujWzoUZa4gJITjSRbW3hlBTc//j0ZAVOIpgsvcsCj
	n3ZLU2fCxarlbYeJO8gxjOBZZuqN+7ykG7vzhcdn6OENauiu+NVDQjxwB2Adaf1bywlQVCdLIcY
	BPT8DJQvN8yr3GasqXM+fR48a/Ij0zpSQeDuxFXrVGIzAXhF0mvqZtc7YQHgE1h3RhWpWBe9QY8
	Nkd4BakgQs=
X-Received: by 2002:a05:600c:3b0a:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-4888e09ba82mr46452805e9.10.1775149484030;
        Thu, 02 Apr 2026 10:04:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a7165aasm104469075e9.14.2026.04.02.10.04.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 10:04:43 -0700 (PDT)
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
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v2 1/9] accel/kvm: Include missing 'exec/cpu-common.h' header
Date: Thu,  2 Apr 2026 19:04:26 +0200
Message-ID: <20260402170434.94783-2-philmd@linaro.org>
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

kvm-all.c uses EXCP_INTERRUPT and EXCP_HLT, defined in the
"exec/cpu-common.h" header:

 17 #define EXCP_INTERRUPT  0x10000 /* async interruption */
 18 #define EXCP_HLT        0x10001 /* hlt instruction reached */

This header is indirectly included via "system/kvm.h" -> "cpu.h".
Since we want to remove the latter inclusion, include it here in
order to avoid otherwise:

  accel/kvm/kvm-all.c: In function 'kvm_handle_internal_error':
  accel/kvm/kvm-all.c:3147:20: error: 'EXCP_INTERRUPT' undeclared (first use in this function); did you mean 'SA_INTERRUPT'?
   3147 |             return EXCP_INTERRUPT;
        |                    ^~~~~~~~~~~~~~
  accel/kvm/kvm-all.c: In function 'kvm_cpu_exec':
  accel/kvm/kvm-all.c:3436:16: error: 'EXCP_HLT' undeclared (first use in this function)
   3436 |         return EXCP_HLT;
        |                ^~~~~~~~
  accel/kvm/kvm-all.c:3490:23: error: 'EXCP_INTERRUPT' undeclared (first use in this function); did you mean 'SA_INTERRUPT'?
   3490 |                 ret = EXCP_INTERRUPT;
        |                       ^~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/kvm/kvm-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 774499d34f8..5df3fb90d88 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -36,6 +36,7 @@
 #include "system/ramblock.h"
 #include "accel/accel-ops.h"
 #include "qemu/bswap.h"
+#include "exec/cpu-common.h"
 #include "exec/tswap.h"
 #include "exec/target_page.h"
 #include "system/memory.h"
-- 
2.53.0

