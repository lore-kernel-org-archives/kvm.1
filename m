Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708258;
	b=gaYep2+fu2iZwMTX0Xu9QqhUkRXQ5anoXsPCJf5DKQXl3jbIHhwGYUIIC9k2YC1Upd5e
	 R4/Mdevb+jBOXHSrJjmAZzSrXVCgBpI299kEHWRGohOe6T7253Qs0xRMLI8sKLLsssQKb
	 TQiibX1hofam93YU2+nJ5GQjJVLb9XqwweqY/TO/FHT/hZVj8ms4EEwBx6bYuWA8/oJ7n
	 U+QKjpoUR55FWHlOCyeagtQPe2HeYeMVB7q8RxItH0p3Mk1YaqxM9K5JXz9xgVaWsi1j9
	 o0rxAN9HbPGTyMiChCJoS+mZ4+7gSsWlR1cIcQk9F1zU2RrKBUxfsepFpEWIrlC9f6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=2bQnvowAK96XJBMT+TQureQmj260BxIC7J5qxK72Tvk=;
	b=i++s2Kw4yQcyK2VN1bxPf0Ac3l3o2TwYaXrlqwVU1xgJizebfOYzM11y2YBzypkHrDHm
	 U6Ml+ylLerZbgZBrFxfi1oRFP6YnmI7a3wvj8aQTXrzX8wgtNwC+NK3dfbj9oetw1q2qL
	 XzrVivHSiUXoFQKe7w1kqBMKx7KGULWQJjXPAas1JLFC5NELwwWoo/Q1BNH7KZbOcULul
	 cclJ3/o+j7TUjP6+9bhn+j0T8FFUgQP0J6UWyDGndQYm3JFdnoENS/woIs4H1VxJ46Y6x
	 fa4pppE5yT7Rpgbw/t9Icfid4KUd8nhogsy5OZ2foC3r5mGsOgmwh9dKg2HcZbQvwGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="v8j/GZ+M";
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EEE606A332
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 22:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33EEE606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=v8j/GZ+M
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ab67ff8ec3so205753a91.0
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 15:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792708257; x=1793313057; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2bQnvowAK96XJBMT+TQureQmj260BxIC7J5qxK72Tvk=;
        b=v8j/GZ+MorZsPWvTTNc/7/V5m6ckYN0RwurfQT8/YttzOLCPH9nSpPrVgdwQD6FNrt
         QZCQliYDhb+uil8J38NwyLuXyWbtTnYuWe69c6YDdybpsU6/JEw5KXF2/OsUoSeYryfZ
         KW6hXmwBui00LvCD0czdDF2gC4T96nRT8iTm8LJbz1dq0lAwyut2CXuK6ZSP/wrcs0SX
         /Y6g0LlMpYAlQbzlMx9XVd8MVbWZkhpfyFhnkhnlEzFgScwn+Qqa/ywIWChKe6AGMHvR
         USqjApM7ecazVWsOwH8tL6XEZaLVLh27nrr13A2ujK+GRk0yln+gy5zVKQ2GiOXKx9m6
         5zOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792708257; x=1793313057;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2bQnvowAK96XJBMT+TQureQmj260BxIC7J5qxK72Tvk=;
        b=Gim7l8+A3fO62gEfP+kwMvpqOS6aOZpu4gJNcQuvtA2Ka/Y8pJcoMe6mxPbwbSBAGI
         YEAwa26LFm0UGSJ/+8do19eHRYJmWUmE9DgZNhiO1LciBcJ+KE2AsZ6e1DDQ8AnLydqr
         lvXR/r3iDdynJpGwbmkP3YK1CLDkVkHh9LZRziKOkxDylwzR6rjNERLmWiGHuwUi8kB3
         9YqmVZARJAx4HX1Q7HoKkRFDuKvkW9hT2YSykX5lOSmyxv+1tIX+xjxaguU+tmYZzr1J
         WKIeK1sZoN5bIemWVHwxXdSIjPycva4AA13FdyruxFouJNQE//Iv3b0xdbOd2FSJdKoi
         qq5w==
X-Gm-Message-State: AFq9FYL8zHQoBW/2vEBAYEkdkjl9xGpm8I+chxkKTpHxw/5kdQ3BOefo
	JXzSRnLP7k+3jJbcDbicEed9Vn20EY0dGHU0iYKos8fvoSA6fDotl6DRguiGrGZY2A2nUfiAkm4
	xMsWK6w==
X-Received: from pjbcp7.prod.google.com ([2002:a17:90a:fb87:b0:3a8:837d:95c7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3810:b0:3ac:80dc:f40a
 with SMTP id 98e67ed59e1d1-3adce5ebc38mr195879a91.16.1792708257349; Thu, 22
 Oct 2026 15:30:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Oct 2026 15:30:51 -0700
In-Reply-To: <20261022223052.646891-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022223052.646891-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022223052.646891-4-seanjc@google.com>
Subject: [PATCH 3/4] KVM: x86: Recompute EFER.LMA instead of inheriting the
 current value on EFER writes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Recompute EFER.LMA on bare writes to EFER (via WRMSR or KVM_SET_MSRS)
instead of carrying forward the current EFER.LMA.  While it _should_ be
impossible for EFER.LMA to end up in an inconsistent state on such a write,
KVM has had a rash of exactly those bugs, mostly because SVM is quite lax
when it comes to consistenty checks, which in turn bleeds into KVM's nested
SVM implementation.  Retaining the existing EFER is also rather confusing,
as understanding why keeping EFER.LMA is correct requires a lot of a priori
knowledge of both x86-64 and KVM.

Keep the core concept of the existing logic as a sanity check: WARN and
reject the write if the computed EFER.LMA would be toggled, because as
described above, that _should_ be impossible.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/msrs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index c3cb1575fe66..41f3ec6eb286 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -638,8 +638,18 @@ static int set_efer(struct kvm_vcpu *vcpu, u64 efer)
 	    (vcpu->arch.efer & EFER_SVME) && !(efer & EFER_SVME))
 		return 1;
 
-	efer &= ~EFER_LMA;
-	efer |= vcpu->arch.efer & EFER_LMA;
+	if ((efer & EFER_LME) && is_paging(vcpu) && is_pae(vcpu))
+		efer |= EFER_LMA;
+	else
+		efer &= ~EFER_LMA;
+
+	/*
+	 * Toggling EFER.LMA on a bare write to EFER should be impossible, as
+	 * it means KVM allowed architecturally invalid state at some point in
+	 * the past, i.e. allowed EFER.LMA=1 && (!CR0.PG || !CR4.PAE).
+	 */
+	if (WARN_ON_ONCE((efer & EFER_LMA) != (vcpu->arch.efer & EFER_LMA)))
+		return 1;
 
 	r = kvm_x86_call(set_efer)(vcpu, efer);
 	if (r) {
-- 
2.56.0.257.gf7497c7d27-goog

