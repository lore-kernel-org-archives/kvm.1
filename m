Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00F626980F
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 01:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730809; cv=none; b=II+UZJOOY4ZtjcxieVP5CqQyhFD0xAJbO9Zd8mNZJK+JmJGjIvkryMbSdIj1N91ORyWPl7+F0PV5OIFdu0J/bbHj1kXo77E617oIGbS3wuhaKVm9ArZv02C9pjawzD1Hi0v/3yxSNCMrlpLELU/RZjFdwqAAsLgiYdimPz/npY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730809; c=relaxed/simple;
	bh=WJS4SSOV19T6Dt7ROA/A7jK4hLXZXWPr57+NbXRProQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CkgsTxeDmiJjNUtsSk9JXid0Whzz0aT0mJo6rX7GIeUt+qGGpz1fWvRUiR60xRSFtM9k8LdycAX0WLnaDFbUddtPSHpsbyFBztYL0YMIur3ZMBm0McabXoZp5oEtxte9aDhQQ7kzZ507fk4uiocD/hhQZw38+j0dhuYf7m/a0HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+MFe/jc; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+MFe/jc"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d02df2bf09so33913635ad.0
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 18:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790730801; x=1791335601; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aGX1aS7+VbzdnFj570TKAEc3vWnkvcXC0Vr+dYTn8FA=;
        b=Y+MFe/jcAn0KQjq3QsApAHzXslTOfTVmkNABntEMzZbqzkhrs9JrGFYrrebDvfM1cp
         1kb0M4kmGJYVjI3y9eXwkHV3zqoR/2z6KFr2rFCLg3BDA4Z0GE3n7wnAIUgW/HaPhpZn
         Q7rW+EBTxPGqcU2SBa0gQHDhMu86xvd+GOoBwUgHwkDOtDfF+XRi7brDPenDmqlRyi6x
         Kb6a/7OTPd7hzqgkjCcUU0jCdUWCO9mDE0rRiDsZXkqxOf0Mbq+cWw5jr5DXFuz+vr2f
         cTXBQbbMnAES1EdFQLuBHgqv4n1DzkP6dQX2qoV3bBrZIE+V/fp2GZntPLkm37q7AHBi
         gtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790730801; x=1791335601;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aGX1aS7+VbzdnFj570TKAEc3vWnkvcXC0Vr+dYTn8FA=;
        b=yxPhFT1XSxyWn0X0CAlWKUCarrV8s6hIFiPfWLZaTsC2Tgbm9ARNwFWw/nkSBV32Zb
         oL706CgKemxQ2x8W9UvaX8n/KiE2y/p1rcolnGZi/Z+4gWoYo6JWEOKk6uHSS+NdlugN
         RHRSDdKORp0AVKdsQY23prSoVtUsEo5Ulwvn1s7dEwNGVg0gsd8uwOX5hbQvZFQesDlp
         18O3QQ/yJQFx4zYFwPg8WdgXl6iWbQmOvkiHG0B9u5qYMMHfN11kZ+yiEDj6ivnhj2oK
         tWTJGBb5j5JP5sLVAVdT/tXWmp5i1dgkFQQFJEF8pQIRolGPtMjYSqeuC5cEvCOdAxua
         FhCQ==
X-Gm-Message-State: AFq9FYLEylOLmpURkcCJZiF5TAe9I6TLsEq12o1KwDaogy7RXvk0640r
	a/dLojcUEL6659ISDcV2snBoYenuixXO8+fNXuTOuS0BFgF7jePaypg9KHPosReWccbS3muI26M
	TcPaRPQ==
X-Received: from plbg20.prod.google.com ([2002:a17:902:d1d4:b0:2dd:6c51:6e21])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc87:b0:2db:5f8c:b81c
 with SMTP id d9443c01a7336-2e2de52d09fmr6371215ad.19.1790730801141; Tue, 29
 Sep 2026 18:13:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Sep 2026 18:13:06 -0700
In-Reply-To: <20260930011313.3197688-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930011313.3197688-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930011313.3197688-6-seanjc@google.com>
Subject: [PATCH v5 05/12] KVM: x86: WARN if fixed-1 DR6 bits aren't already
 set when delivering payload
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

WARN if the fixed-1 bits in DR6 aren't already set when delivering a #DB
payload, as (stating the obvious) KVM should never clear fixed-1 bits.

Opportunistically switch to kvm_get_dr6_fixed_1() instead using the more
conservative DR6_FIXED_1, to ensure that bits that are fixed-1 from the
guest's perspective are indeed '1'.  In practice, this aspect should be a
glorified nop specifically because fixed-1 bits should already be set.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 99518e3265b4..5b3918a4ed52 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -399,7 +399,9 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu,
 		return;
 
 	switch (ex->vector) {
-	case DB_VECTOR:
+	case DB_VECTOR: {
+		unsigned long dr6_fixed_1 = kvm_get_dr6_fixed_1(vcpu);
+
 		/*
 		 * DR6 is a mess.  Reserved/unused bits are fixed-to-1, and so
 		 * to maintain backwards compatibility with existing software,
@@ -426,7 +428,7 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu,
 		 *  2. Clear active-low bits that are present in the payload.
 		 *  3. Set active-high bits that are present in the payload.
 		 *  4. Clear fixed-0 bits.
-		 *  5. Set fixed-1 bits.
+		 *  5. Sanity check (and set, if necessary) fixed-1 bits.
 		 */
 		vcpu->arch.dr6 &= ~DR_TRAP_BITS;
 		vcpu->arch.dr6 |= DR6_RTM;
@@ -440,8 +442,10 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu,
 		 * breakpoint), it is reserved and must be zero in DR6.
 		 */
 		vcpu->arch.dr6 &= ~BIT(12);
-		vcpu->arch.dr6 |= DR6_FIXED_1;
+		if (WARN_ON_ONCE((vcpu->arch.dr6 & dr6_fixed_1) != dr6_fixed_1))
+			vcpu->arch.dr6 |= dr6_fixed_1;
 		break;
+	}
 	case PF_VECTOR:
 		vcpu->arch.cr2 = ex->payload;
 		break;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

