Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C568A288C96
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361990; cv=none; b=YL0bKGlpgZQQuyj8fxVioS3qtmIzibdbUstlyu/14c9OKAKk0b1oRmrLi6WJe5UFrwZbKaWN9Ft9yHuHua5gaE81Gfvzv67sRhZRrX2RTd3HoaR0SiMtzRnyVN3QK1b9MsGHmGJQ6VAfQ0xn3PNHPZVXt1LcT7dSAhPZr/ZKwdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361990; c=relaxed/simple;
	bh=ugj8UDoOW98hDBU9yiqY9dU7o/bzNnqLvw5mzSYorEs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c/7hIfLB058RhqBIzKXuK99F9feV2JS+DaKM6J8lb6r2UIWhLyIz0fr4XIV8pik6yPsPdErP3mPlWaCpldfQKDpXrI4p8reNdRbAB8sM5ps6BssopRurif+lmO4pcuHcw2XMUTm9TERjYXtRguzf3KlX2J05qSboPBew3MJqFbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dm78ReDp; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dm78ReDp"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c737ced4036so948462a12.1
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 17:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773361988; x=1773966788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JDd4PhY9bJhpZgSv4RiGr3oEGXZFNbQJpQq76MQNlqg=;
        b=Dm78ReDpKfXORPZgTQymJB47AZpkva6Qnet9d+OBF4Jgs8MiAVLvIngpP24qDoRkAP
         wju35QjXqrsy5swtKbt6gvyo9KDAoEuvRWm+qfbWO0zYb95KSF4t85zB2dbwuXblIB24
         zb9AhfawFwavK+S2SqTX8fqNQ7KBRHHFFCGCOrGwmYKJj/Jm4grSKunejNy1zU6M6TK3
         Ipoe2FSUww0ztJP6U8yTtpnr5+8QXme7laOvdlJpJpvR3yEKG09yHcCed25WNlkfmbUS
         6PlhA40mbbPxlxRoS9RdQLKwF1uT5vbKdgOqMXKPI8sN1JJVK+eRlZz5ofZpYZy325uO
         K1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773361988; x=1773966788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDd4PhY9bJhpZgSv4RiGr3oEGXZFNbQJpQq76MQNlqg=;
        b=fOqjQM9jqjrhE1Ah/98Nm8iUpKFTypjtrSuxAw8Hw4flAz+ujXADKlKfNsntZ0/WCM
         e52sFTypzOlK7gqAy9NlN3qHo6pAXKX1YaW1eCqtOJM/sOGdoVN2z6lKQyjyJ4sO1Bw3
         8Q515ew6fRkFXTsW7bjlSBWIg6b0jhdemYNqpqqK7dUkTiB54Eoduc73oii3znWb4TFW
         vWow/Yh7ofLzy0nuly+knm2TSWlQBCOxcz+5e/bZICXVpaFnQ/P3/SccPL6v5x6gOD4A
         UaK4N+r1e+1Aryy2tzbXH0PPcnzPUD+HJrFRqJTlGMkjxVOXpqLTiHqWDAsHFnPh4LyM
         2sWw==
X-Gm-Message-State: AOJu0YxvYacnSxaoVOagYgvHlM5NaOSMAVCUyqU9whLEO/oICW3WdgjI
	gll/9OzC5CH2JTSVm+9uhd5WW8v1JBQY0Z1lbAQE6GM25wQTFn5xraAtliK5fRGG7eGtg2+/k33
	K/DLbDA==
X-Received: from pgmj24.prod.google.com ([2002:a63:5958:0:b0:c6e:3f59:895e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3981:b0:398:9c2b:c92c
 with SMTP id adf61e73a8af0-398ecadefdbmr972992637.27.1773361987985; Thu, 12
 Mar 2026 17:33:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 12 Mar 2026 17:32:59 -0700
In-Reply-To: <20260313003302.3136111-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313003302.3136111-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260313003302.3136111-3-seanjc@google.com>
Subject: [PATCH 2/5] KVM: SEV: Drop useless sanity checks in sev_mem_enc_register_region()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Liam Merwick <liam.merwick@oracle.com>
Content-Type: text/plain; charset="UTF-8"

Drop sev_mem_enc_register_region()'s sanity checks on the incoming address
and size, as SEV is 64-bit only, making ULONG_MAX a 64-bit, all-ones value,
and thus making it impossible for kvm_enc_region.{addr,size} to be greater
than ULONG_MAX.

Note, sev_pin_memory() verifies the incoming address is non-NULL (which
isn't strictly required, but whatever), and that addr+size don't wrap to
zero (which _is_ needed and what really needs to be guarded against).

Note #2, pin_user_pages_fast() guards against the end address walking into
kernel address space, so lack of an access_ok() check is also safe (maybe
not ideal, but safe).

No functional change intended (the generated code is literally the same,
i.e. the compiler was smart enough to know the checks were useless).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 23a383f2e43d..857771586f16 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2711,9 +2711,6 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 	if (is_mirroring_enc_context(kvm))
 		return -EINVAL;
 
-	if (range->addr > ULONG_MAX || range->size > ULONG_MAX)
-		return -EINVAL;
-
 	region = kzalloc_obj(*region, GFP_KERNEL_ACCOUNT);
 	if (!region)
 		return -ENOMEM;
-- 
2.53.0.851.ga537e3e6e9-goog

