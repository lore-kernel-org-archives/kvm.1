Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741823502A9
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781808919; cv=none; b=b9z5E3AvuZi1h83V6YUwchGL0J3uvFhMAVnJAmC0bsY9zKcatAfNJLOdcfklbpXvC9y8NX7BeWFBdTANgLzPBdWcU/20rvc8V+fk284G2tIqgN1xZiDS5y9Kui8iz+0LLP7aSz3JhpSI4t3d5+rimGMLKI+AxMnVDKklZ9cV/74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781808919; c=relaxed/simple;
	bh=i8i11/nngs/dJUglrC+fQ2GVXgcr6LpNVf81KzGar1k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tU3Ez037BATbq15XFjV1e/TUznlx7e5F/xenrJJ4knmPsRl1xv04ZENgVJekt5OGmMimYOuJZTfwT3fFqa9EpF+GWs+ZNUxF61/3dzuiCCZ3BLuOBMwBHiCr7KoZ3rWkElh1K6c4rMlKVt5GJm46KreTV3MUmAv6EPdVXF2EFnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C0zLHQmk; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0zLHQmk"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c2c98c1be2so12211995ad.0
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 11:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781808917; x=1782413717; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djztpNcmYyO0c6LtUWKYgTT7dvEa12Fc6/4z0dDfxR4=;
        b=C0zLHQmkkmHPQte3JUyZH7WJ5umB80YnVcEGXBAh1FuSpp9wfhLndVxZvpIyO5yp2P
         tClHjO3PE1UMQA5YyEAbs5nvk26PLpjL9vYLxFHfnv0JMPXnOlK0a5o7tFrLzn38Ycul
         Cmbs6iTw4DkUu9niCKApc6rCoQ+nET4zFy/JzQWe4VgbNEfScFsFHTszgWRN1EJua9EV
         43pTCt0uKufbaH0/vdvQYzTRRjLz8toOCz1Dc8kc0g25mez6JpP9dikTqe6j/g02vCdu
         hWYb3EkvcwP4vIPCQHQVs53IT/eVUU7siiety5m1jxDh8Q8oMJ1IqC4VUvjPd9ye6EET
         7ZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781808917; x=1782413717;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djztpNcmYyO0c6LtUWKYgTT7dvEa12Fc6/4z0dDfxR4=;
        b=Im0vNlxojHuKHEpkyKw0vlQsjkWRXDZtfJKw9cipgmVn2aV3unHqM3wAtCDzFdX0Io
         Z9hmEG1whrODTbPQjsshe8+bbcUrksdgxLMrANOErLcUupvZjY5vvQD0WeJzAy6u7+Ky
         +3wl1gZX7tbPYOp3/+jVxslJ3BDnEyLaD9w7ywsx0pexMw2of5w/JOM1cAVyavt/lKAj
         QcsRcj/lS7ovYmL14TWI7g//Mzue+//sLEVBL01AcaXVJNY3oxKkwmJl7uGdBg1zO/Z4
         YM7gQzXqA3CYtZTdJQ7125XU05kWgKuJWJj+dR6j8VfEqZ9EzFHxtwN7kw+FYJrCJUcR
         RUHw==
X-Gm-Message-State: AOJu0YwPG1Vs9tZqIZPavTNojLoxZOmn1e8muMQ7NZjC1uS4k6/zg/3f
	SNF8C8IxVvGX1tYmoEKokWkgFY/WgHf50fYvtp/TvjuWcNzYzZiTJ0vqUKP01cHIUp4KyhgfHkb
	jU3eD2Q==
X-Received: from plhs15.prod.google.com ([2002:a17:903:320f:b0:2c6:bd76:8706])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54e:b0:2bf:7b62:a038
 with SMTP id d9443c01a7336-2c718ca5fcbmr5654385ad.9.1781808916536; Thu, 18
 Jun 2026 11:55:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Jun 2026 11:55:15 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260618185515.2021642-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Clamp the EOI vector if its OOB instead of bugging
 the kernel
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If KVM handles an I/O APIC EOI exit request with a bad vector, clamp the
vector to 255 and hope for the best instead of bugging the host.  In all
likelihood, a missed EOI is survivable for the guest, and it's most
definitely not remotely fatal to the host, i.e. potentially panicking the
host is completely unjustified.  Arbitrarily use 255 for the dummy vector,
the goal is purely to ensure the vector is covered by the bitmap.

Opportunistically ensure the EOI vector isn't negative, as it's a signed
integer, i.e. the "greater than 255" check won't guard against setting the
vector to a negative value (KVM uses -1 to say "no IRQ" in many flows).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d9d51803b7b2..fda09e03b960 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11212,7 +11212,10 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		if (kvm_check_request(KVM_REQ_NMI, vcpu))
 			process_nmi(vcpu);
 		if (kvm_check_request(KVM_REQ_IOAPIC_EOI_EXIT, vcpu)) {
-			BUG_ON(vcpu->arch.pending_ioapic_eoi > 255);
+			if (WARN_ON_ONCE(vcpu->arch.pending_ioapic_eoi < 0 ||
+					 vcpu->arch.pending_ioapic_eoi > 255))
+				vcpu->arch.pending_ioapic_eoi = 255;
+
 			if (test_bit(vcpu->arch.pending_ioapic_eoi,
 				     vcpu->arch.ioapic_handled_vectors)) {
 				vcpu->run->exit_reason = KVM_EXIT_IOAPIC_EOI;

base-commit: 9d4853b044beefa21c4ee3e18c40653601a64ced
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog

