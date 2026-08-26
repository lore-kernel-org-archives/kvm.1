Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C9344D01D
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779994; cv=none; b=pXjsQH3i8WpfeRhgLiQwWMnAoX9XSLFqQVsXj4QiJigQybiW0WMAVNblIBtWePCDojMd8F1uTxWJ2wcM9czp657A6Vc1TthIfWvJAaYDiudLy4T1Ym7SVCPImMOfTmp4H81RzZ6mpjQXBo1ZatW9xdRBSRYQrrwmnrr/PlT1maM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779994; c=relaxed/simple;
	bh=s/He0eEBW5Ev317ZMBHjcSg4n8ESITAF3VdnBqEq3iI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RLXqpbLTxZ/UVa/pad0wlLtNc3Cti3MnItIR6ijmV08txhWeAytJEHErzphCf7JL/rbRan7OzfgtU34W3aoubrf3zykDYfqrc5FTP/LeTo4D+tOCz3tpCEg0C0o+LVKfX6VTN2MUkGWX0URV/lE8niVaDDCdlC7Oc+SsxrOdSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QzlfsQaZ; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QzlfsQaZ"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6fed0652bso20300905ad.2
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787779990; x=1788384790; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WzUUpK1X/Ek66AY89fN993ev5uItccqjWdSjYLSij3I=;
        b=QzlfsQaZnhz1FpmUlOTl6zz4HjG/VZi/Z5nLrMMO/XfVuWec0TMcMSu6LI9WlaTqsv
         4BHprFXGgQCeRb57xRCL71cDPDEATMT2vUnT9I8CfURvzJsv1bhBlzMhLUG7QtpBQE+w
         yBjN3Z7KiBaB/9sA8pr8cf0Lly+YUgF/Y1d04xVIu5GlkSqfXv3zDQxl3vzH6EXaMCye
         tfE7wdf/s8D2DDDVGRIXKnrUJ8B1TWaywmPAnYlmJFi55bROVSmrCpGBTQZqnUHcMwQi
         hkT9H0mnkCzbPsDgUwf39GdVXt+o/evrAXz09PRlIGZO1Xv7vpT8RJuPcJ/2gs6SUlP+
         4GWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787779990; x=1788384790;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WzUUpK1X/Ek66AY89fN993ev5uItccqjWdSjYLSij3I=;
        b=Z4Yfltk2q/C8ubJbsxoPoAjE/DxP4jl7sdY69pyDnLfyck5YCxi449hJBfmEV7jtDA
         av/aFZGTaXwXhHmhAPFIKJZKAfKVdDtvolSpmzFnFAgMDbU72zRswfZIFpSAZNYvmZfw
         4FAfQCFX7RjQhGaKzGBAqcQoAzvREBfUJIGykA1I2e/qYOfh1yMKsE98MSN+egbJ13jw
         q/t2jIWFJ9sySRlordF3BRxz6nhzDcDzOse1uooIvu0OntsG3Im7sCjal43vLlAUyzMk
         H4dReoPtxq/ickkuzDYe5taYRgtLA7etqdjOLaYgx1N1i7EZW8TkPDqzErt3qQfnlh0c
         fO2g==
X-Gm-Message-State: AFuF++lChxByJKmsMXFfPlvz0o4xK84qmKCtvD13NHEC3Owad7RmmEUK
	PN51er1BQenBlZnY/k/R/sc2VlcswvFRIxH8H1WyXNzLpOtVf5Cl/KPJndKrtjxp2rYxTbK4Fhi
	xViKVxA==
X-Received: from plblc14.prod.google.com ([2002:a17:902:fa8e:b0:2d5:62cd:db79])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c3:b0:2d0:cc92:f7a9
 with SMTP id d9443c01a7336-2d707a9f435mr158585745ad.4.1787779990340; Wed, 26
 Aug 2026 14:33:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:32:45 -0700
In-Reply-To: <20260826213303.914988-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826213303.914988-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826213303.914988-6-seanjc@google.com>
Subject: [PATCH v10 05/21] KVM: x86: Compute kvmclock base without pvclock_gtod_data
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

get_kvmclock_base_ns() needs CLOCK_MONOTONIC_RAW + offs_boot. Compute
this directly rather than reading offs_boot from the pvclock_gtod_data
private copy. offs_boot only changes at suspend/resume so does not
need to be atomically paired with the raw clock read.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.6-1m
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4ab0a41eee7b..46c2c2ea64fe 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -930,7 +930,7 @@ static void update_pvclock_gtod(struct timekeeper *tk)
 static s64 get_kvmclock_base_ns(void)
 {
 	/* Count up from boot time, but with the frequency of the raw clock.  */
-	return ktime_to_ns(ktime_add(ktime_get_raw(), pvclock_gtod_data.offs_boot));
+	return ktime_to_ns(ktime_mono_to_any(ktime_get_raw(), TK_OFFS_BOOT));
 }
 #else
 static s64 get_kvmclock_base_ns(void)
-- 
2.55.0.887.g758fc8c411-goog

