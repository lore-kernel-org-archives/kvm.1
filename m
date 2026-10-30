Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395650;
	b=wKLTMk3WTdJQ/LeKBJtj0y+5O4U9sJ0RT/BxO5NluaVsn92tGfwdtUpKU7KvjZXelqs3
	 84Z7VrSUKeHraIryIvXqhomkFezkjw2gQBJn1kjCr9iSOUN/QCuXlYI0VWKYLi+/SBnBO
	 W9emTS9hW9vqij5Ac7aDzC56XbuI2ZBsX86GR0MU7f5kmGpJEk2o8NGyqLKA/2/oFmLEb
	 3bdO6Cmmh7tZ5x1Pwo1uy1YFe5mq3hmSGwxauj0f7MWNOZdnDOWO2+p0ghlsHEssPXSS1
	 8YIJw+DdGxW/4B9fC/iuU/xI3qOAGt3eWe/uVeZZxqDgZl3ZxDk4xHqS76xvq4BAdqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=160XY00CCxZnuh51+mMuELrjVFZ7rrmLUQxaFTbVPWk=;
	b=JmV20fxvaIzq+9Bwo9RCLqkT9ppqS1FzcyLbyCr7Rjy/OnIRirjp7ZhuBoKlVWMcbhwg
	 eOSnLNjwWqo6ZB1xM2g4j5kGpEM3jhxZZbIbuIx+/alfJIiRyBR7fO+rVBMPuApAwdEC1
	 Z2ZU0yzl84e9UJOtoWit68DTVBLJoTY+nEwyFEDFFNSfBQY1v4BX4s9O5LCH9N4QapfwN
	 8D6Lu9oUK5ezuilLk+khIuVpPDrPsuUMYvon8pD+5RGuJuwSvHV7XR2Tm2FWZFYmxm6sH
	 u9lzhWixM0dsEUBbqIq2O1FVDBBB4wDEjp5LM6CRg8PcGbmiCNjyEwjLa5lSVQ/j2TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Cqco0/4q";
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9C860A3807
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A9C860A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Cqco0/4q
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ac77c3ff6aso1491707a91.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395649; x=1794000449; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=160XY00CCxZnuh51+mMuELrjVFZ7rrmLUQxaFTbVPWk=;
        b=Cqco0/4qYas9nZEOJqjA2xWoRyomkOUuWX+V1ebVFQefIbEP3MxAjhlwmD4hyLUVcH
         I/uTb5XBz2uveSB17b38BY7HXu7MLKq3HVYlCVJUJ/Xqw8M3fmdOdln7vYIlOfkURMa5
         n8WNVBaBCzNbpbMgeD9u9C/blNvKOVDqJWd5YrqFIJ/50xu1ymwl8TVX4jz+p+m5hEtt
         j2UtCfHrNSt7K89ijkqyALF76FgOE/L3QFa1OIq1pxw7/JnHSar4wPffEX39vvHuVcQp
         2BcjVuvloCQCL+Ab4OJ86NV8l97pCZCshjGIXCD+3odTVGzgms7ETvfZU6UJN1qQmVQ2
         lRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395649; x=1794000449;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=160XY00CCxZnuh51+mMuELrjVFZ7rrmLUQxaFTbVPWk=;
        b=s5Dl3E+FO61eUps7qLrxIqMXDuWP7rqJE32csJjQ/QRuDsAZbPHpJEfI4jvtyl/Gib
         ovSUnLR2UvjkGNn+NBaSdaDV8KlLxQNhVuuT4PxrTJJYvY4KfoczautYLIiquOrDs6FW
         al/miDIl3BsEi8zmMlpZqOogW7uEDIsgvuuqb3vqrzH1nqYhoeiI1pcug7VQo6OMgBGM
         357WIY0B4u2MkewyiQNWz6kdXOWDeyGmuz2RE2sH60eGiKxHmAlPXz96xPhEiNbhIIA+
         /W3ugjDzQ9VPkirx30Y3QmZUgDnd+yKy125EiQ0FKNhFLRPzfqC7kdfEKYzzmg1FZT+k
         9MPQ==
X-Gm-Message-State: AFq9FYKiq38UOSvbF/N9I/w8FWxedZGrsFiu7lxArBAw4atFNSoSLhKE
	52M7L0I3g9MTYMj4flEd1CKUPXpuezbOKTZ+hGO33jKhEx5k5srEHahvqo3w+KPWXVeWw265t+o
	7xY+/2g==
X-Received: from pjor2.prod.google.com ([2002:a17:90a:9402:b0:3a6:d839:55d1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:534b:b0:3ab:4f1:4f76
 with SMTP id 98e67ed59e1d1-3ae898127f4mr2812213a91.24.1793395648837; Fri, 30
 Oct 2026 14:27:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:27:19 -0700
In-Reply-To: <20261030212721.2606393-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212721.2606393-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212721.2606393-6-seanjc@google.com>
Subject: [PATCH v3 5/7] KVM: x86: Recompute EFER.LMA instead of inheriting the
 current value on EFER writes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Recompute EFER.LMA on bare writes to EFER (via WRMSR or KVM_SET_MSRS)
instead of carrying forward the current EFER.LMA.  While it _should_ be
impossible for EFER.LMA to end up in an inconsistent state on such a write,
KVM has had a rash of exactly those bugs, mostly because SVM is quite lax
when it comes to consistenty checks, which in turn bleeds into KVM's nested
SVM implementation.  Retaining the existing EFER is also rather confusing,
as understanding why keeping EFER.LMA is correct requires a lot of a priori
knowledge of both x86-64 and KVM.

Keep the core concept of the existing logic as a sanity check: WARN if the
computed EFER.LMA would be toggled, because as described above, that
_should_ be impossible.  Don't return an error if the sanity check fails,
e.g. don't inject a #GP, as setting EFER.LMA based on the current state
provides architecturally consistency.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/msrs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index c3cb1575fe66..c55402970a34 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -638,8 +638,17 @@ static int set_efer(struct kvm_vcpu *vcpu, u64 efer)
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
+	WARN_ON_ONCE((efer & EFER_LMA) != (vcpu->arch.efer & EFER_LMA));
 
 	r = kvm_x86_call(set_efer)(vcpu, efer);
 	if (r) {
-- 
2.56.0.385.gac671c819a-goog

