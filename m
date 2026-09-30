Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A5551E441
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789862; cv=none; b=CHmIBqp8GPePQG0W3ntcVYmsVSMsSTL43nnjSZa1gi37HmmJCRJguu5/PYfNHBFp0c0CL0nDtPWsrbihgUS0BMdmqIYLRneoOddAeVAHvvNaw+2ghw/7t0rHO/8otUlWm/4w4yyKeG/aBnNyVrWdm44Kn3vX/dOAfC/X0i+063Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789862; c=relaxed/simple;
	bh=58f2QmNNQQdnN/JNPgV03bddp/nVFR8FI3bhho7WoiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pzt0f/KBwvbf9S/w2TgqecXXfy7onZRJluxEeysf7v6y7hYd8vB5G7TnFMD9+GV/f3WQVPWFb/YirR86dDUe36J27twqVfzWOHOW1oyFb2gmzncf0Lfm/abDHx5uRlvMueEa9/xGyebzijuuVEh/PaziCTw0fu7/ZhPn8BssT80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZG23e4B; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZG23e4B"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc7361c62b9so4055034a12.3
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790789860; x=1791394660; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a6B/yRwv8+Wh9zmaZqZxMYcgxNWMQzfJrOwGAe00Yf8=;
        b=UZG23e4BuaA1jrms0f8tybwCKSl8eh5I1i5FDbfsKguwIwq/tD/j1b2MDCEh5BlbFX
         2Rp/NJrJ6xanpYIGgeJCrVrNdBgRLrV1j3fdCjVqgmcZx/moPhDdB6mwsWFRnu4p6A/r
         +zcxG7MkvP1YGBm4MS6MLe6buRzjr6+oQxPAsZqHA3jKeW/gzstOq3xO/Kpu3Ur4BtM2
         UbRx1wJ7wivO1mc7Z+riKYa8xuU/PPEk4pqPXYBCsLYB13rYAQfVLbvAtAjE2n1ScdsL
         NsGd73sCv6rNTe7TyM7Nip8xmKCYPy2ELnMk4e0tPAx7GZyrWLl/CRuUhQFQpV/5AODj
         ELiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790789860; x=1791394660;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a6B/yRwv8+Wh9zmaZqZxMYcgxNWMQzfJrOwGAe00Yf8=;
        b=X88Q0L1eBRMnHRGfp69i3J1vUZK7zopZGUH4/1TnMZjoKTO9N/6ZUrSThd1JQNl1/2
         oF0ATIQ9mswSzl+POjLsu2zTtOEv+I2j5wBRUhbnF0xsp9ER2igWoJbblh2o4hvG/StK
         oaUEGS0uQiqe5hSYmRpG8taUcSjfG3G2fuEnomQ0a8HpjH/w1PRFFTL4OL2rtqqmfvDP
         ibsM9U6l8ZjaptSAJt5kplOP9tlzbRZ/xehJOTr4J57dALu64m0sdXLK2njTaXiJls4V
         DNkqLFZqsrhr8+jQ8g9IQ0u7d3hB6KQrCm5UX6PiBM7rGI33/7gaPScVN8QJxzPo+4Lu
         oZ0A==
X-Gm-Message-State: AFuF++kSWWB4uFEuRvf/8f94LpNSradhxPGgsTY400PPeTskOROtKAUx
	XfBiZLg1CzlTSoJFanIyoZLhICyiR0+5sBprCnoj6SATTewW3WoGCyWhB3+ijFmmVGxcQ0axRNu
	Yc9RDkA==
X-Received: from pgar16.prod.google.com ([2002:a05:6a02:2e90:b0:cc4:4327:bb52])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d8b:b0:3da:1e7b:ea27
 with SMTP id adf61e73a8af0-3de9e6e251emr2196880637.21.1790789859619; Wed, 30
 Sep 2026 10:37:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 10:36:16 -0700
In-Reply-To: <20260930173635.3362655-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930173635.3362655-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930173635.3362655-3-seanjc@google.com>
Subject: [PATCH v3 02/21] KVM: SVM: Fallback to the default TSC ratio if KVM
 tries to use a bad multiplier
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>, Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Explicitly WARN and fallback to the default TSC ratio, i.e. run the guest
at L0's TSC frequency, if KVM tries to program a bad multiplier value.  As
pointed out by Sashiko, leaving the MSR as-is bleeds state from the vCPU
that last ran on the pCPU into the likely-misbehaving current vCPU.

Leaking a vCPU's frequency isn't very interesting, and corrupting KVM's
cache isn't a big deal either since KVM would only refuse to try to write
the same bad value in the future, but falling back to the default value is
trivial, and explicitly WARNing ensures a KVM bug won't slip by silently.

E.g. because ex_handler_msr() only WARNs once for *all* WRMSRs, it's
possible for the potentially-fatal-to-the-guest issue to not exhibit any
visible symptoms in the host.

Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260722091414.E842B1F000E9@smtp.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0eb1623052c1..2b6888417bc0 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -533,6 +533,15 @@ static int svm_check_processor_compat(void)
 
 static void __svm_write_tsc_multiplier(u64 multiplier)
 {
+	/*
+	 * Fallback to the default ratio if KVM is buggy and tries to program
+	 * an unsupported scaling ratio, e.g. so that the guest has a chance of
+	 * surviving, so that the cache isn't stale/corrupted, and so that KVM
+	 * doesn't leak state across VMs.
+	 */
+	if (WARN_ON_ONCE(multiplier & SVM_TSC_RATIO_RSVD))
+		multiplier = SVM_TSC_RATIO_DEFAULT;
+
 	if (multiplier == __this_cpu_read(current_tsc_ratio))
 		return;
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

