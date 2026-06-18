Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47B034D382
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781804731; cv=none; b=rSdKVG5ZRDCtYQYKGqST4tMTckrSIi4yzn8k+vGEZA/bT+AbufsWjTU6V0++mliufwvYlo5IcY4HAQg+92XoJQb08O+ihsvtCKhEsA3GhVPvXwPvaWgE80n8LHnwIjpGuhe+b/2mOnJ13EV9EYxnYTNV/OTgYu+kgtqteC2NRpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781804731; c=relaxed/simple;
	bh=m5pvj+8tGIMz3iLaE/UwxVOqQKpK/b8xO4m+OH37j/c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UG0eBqphCXQ7R4JDHuI/ov6FTRnezcywIZZqYnmH2Y+D4jLW5nMoy8xxJTA9nbVvsoIVg5N7OSf7cn1kM/qXnpmSWS+vSdaX4dxopiCKdzQrFbxAdoQAtIPh64DF/WFlkPTID44lcRukV4cacMCMxo8HYPj/0fV8ia7ZI+l3Y18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PJZKoxXb; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PJZKoxXb"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8514f8ed5dso832337a12.3
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 10:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781804729; x=1782409529; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+p6AYO/O72iLrHaDg8Gif1AlfgwEyWPAis8nfEYO7c=;
        b=PJZKoxXbEZ70npiJS7Msy1g65Gr8AkE7ood0TngxTHimtY6N42EFo27zLz/0aROr/z
         h6tNfIFpJroTlTRDrl7f/8zCnMyE6P99hXGGV8t31rnDMU50mPr0r+jXb5E4JXVcKJY9
         ay6MnJtBu0pQeYszw+Gr82VbwSayKqKiYgxoFdcuaU4eUR6TPpqQtPgI6IvPiZRYBjFD
         df5w4L8zVMw+YeogouVZDbV4D2ZxMpFr7fRKlxzRfLZkCGLorpOWOHIlCSnBv/gCxBER
         y9WEvj1bnwDDJWyaD3TEae0R6HyO5cZM58EJi6U8L5fU2/EpEi/3INUAGowhRCR/uX03
         hGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781804729; x=1782409529;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+p6AYO/O72iLrHaDg8Gif1AlfgwEyWPAis8nfEYO7c=;
        b=s+IfZPo+WIYNlVNQ53PdSJSjp8zlH2Lknnm7xJMNJH5M/k38te4V9yLiKJhPgTNjpc
         F6K8UGUgeMkh+R0260/dwD4HfRvwpE6jJRgG08gCMpCxtqhnDrvcZJUI78woBTvbdUZi
         wvprgNveB3VTJIcvB2L2tnr8Xq0dIuT1Vq28mr5hoRZz0yW3xbkw5hhjtUrWT/iHAbaH
         0JkhBZrgvLZExFibFnePHuQ+aQCTGh1cx5L2O9ZfSA5JOGBi2gnolRbcz//QjosrQnQ8
         4g7Aqu8MqyNkhHGhZZ8fIosbtL+r3vUatHNmNOUESdtw3PR3QRfGbQntvgBTb3qNp3Gf
         ro4g==
X-Gm-Message-State: AOJu0YxkEE1soGW0zLpBlDZaI8CkvE50kQD/HwPQSPwNOGOpZmiSgD20
	Th2PchqI2DrpkSKHtHhwpVT4HDIuxX+/yqe84+6i7Smft0nY3Fb+gv2M3+XbtYbjS0bUBG6NYKl
	5hHs35Q==
X-Received: from pgcv2.prod.google.com ([2002:a05:6a02:5302:b0:c89:a67b:d71f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d82:b0:3ba:cd5b:3dc8
 with SMTP id adf61e73a8af0-3bb3564395cmr15159637.31.1781804728707; Thu, 18
 Jun 2026 10:45:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Jun 2026 10:45:27 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260618174527.1982333-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: WARN (once) if RTC pending EOI tracking goes off
 the rails
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

WARN once if KVM's tracking for pending EOIs for Real-Time Clock IRQs goes
off the rails, as there's no reason to bug the host or risk a DoS due to
spamming dmesg with endless WARNs.  Absolute worst case scenario, guest
time will go awry.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/ioapic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index f3f4a483ca15..34be1f0c76b3 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -84,7 +84,7 @@ static void kvm_rtc_eoi_tracking_restore_all(struct kvm_ioapic *ioapic);
 
 static void rtc_status_pending_eoi_check_valid(struct kvm_ioapic *ioapic)
 {
-	if (WARN_ON(ioapic->rtc_status.pending_eoi < 0))
+	if (WARN_ON_ONCE(ioapic->rtc_status.pending_eoi < 0))
 		kvm_rtc_eoi_tracking_restore_all(ioapic);
 }
 
@@ -484,7 +484,7 @@ static int ioapic_service(struct kvm_ioapic *ioapic, int irq, bool line_status)
 		 * ensures that it is only called if it is >= zero, namely
 		 * if rtc_irq_check_coalesced returns false).
 		 */
-		BUG_ON(ioapic->rtc_status.pending_eoi != 0);
+		WARN_ON_ONCE(ioapic->rtc_status.pending_eoi);
 		ret = __kvm_irq_delivery_to_apic(ioapic->kvm, NULL, &irqe,
 						 &ioapic->rtc_status);
 		ioapic->rtc_status.pending_eoi = (ret < 0 ? 0 : ret);

base-commit: 9d4853b044beefa21c4ee3e18c40653601a64ced
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog

