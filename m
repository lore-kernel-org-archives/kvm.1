Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6073C1406
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093376; cv=none; b=HBEjXQ3ULn8J9aVyzPHsymXYQycVetTtEipc1Gq6joB8pwmBBcrXFVo/HKYv6cOW8PWgrAbuqgbSARqAWteNt1vnj8mZxRBd0AyRhkXSfZKjj+aVtxbM3+GgyjjPSjD2oDRLBoyY6IZRokRFaYEP/oJ/+xK45xcV/CuRFhnDYvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093376; c=relaxed/simple;
	bh=lwn3MA9KM8thDveYybS6qHk91YxwQNF6NdtAA1Sy97c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=if2QrO7SLzkwQzRAI5FV3lz2b2PTs/urTst4KvJuOtYxUXzDA68U0r3JqKiDXEQ7Kx2D0aJcHP7fg0bJfKkhz+uzIC5jLPZQj0d7MCnLrbrbmam71ZitBQNeZGIO4pC7Sp7OTbJYZtaO5NLsNrqxgjxh6a4pHFSZXetrQIDyBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bULHbIyK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bULHbIyK"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf32fb7cb2so4333135ad.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093369; x=1780698169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oUZ7pkbs+pCLPe3p8XbPZerSxi7aaVAC0nyW5XYMnDo=;
        b=bULHbIyK3h9GW/tzmxS3b/8SiDJa+O3vJo7ExMatUIj6icP4f+8KdmVfeJdu0saBqq
         KohALdQZjiCCs5fteLJt7a/80QwqZSKrW/HKxjiQDfOVX1JidN7mh81cpafb58A2Hwhq
         cy7qcWiUAbdfS5dxKxROzjvb2Jqc/qkcDU2lwBewBTVj5TOzJiHzCDQtE8ry3G8t7NZ0
         wTn4IuGfcefqRf1l7PlF0WdG2WgjQ38Xoh/6HQIb/5rMTKFfQ8PUBVEPAaWsx2PvsUOx
         wI/gF7yuP/P0h1gnJh5JMsBPE+gx06Yi2TirSYTJOoO9X0MNi78qjFcxaooc6OL6bLBP
         L6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093369; x=1780698169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUZ7pkbs+pCLPe3p8XbPZerSxi7aaVAC0nyW5XYMnDo=;
        b=cJbuIsEY7ESsnL25ZEw6YlaRrmQ5rpB0aYOn+xPdzvbP2yvK5M+z4Z1yVpm9H01wny
         RB3kl/thDLHntsCvxlbz0ENlwcf0QrJ6NGBX+GUG912Pfwv8nKSmTfTLNnruc7prnfyA
         YucbOlkKB27QPa7qLNO43sT0dYuhjAd8W5nV2iw9kULqm3MfwXoZrgaBXw2Kp0OCn7I8
         P/PvDpmYGbJJCcJfOF0XMbfqdtoxfVKafHS9X6Csd8s2rgaVCHnNfGS9Nn1TX5R2476W
         ymkB4qZZjRBWjExcjTLuZrx5qtKto0Z1q40ZvtDM3zE6/1wLDFkZh8sFtmmq7fDEEZ23
         JixA==
X-Gm-Message-State: AOJu0YzTlxhzo0H9hfi3oRQkVgyg/lHK/jJVTQKlpVxV7SBefA33yqiL
	xdcxxRxxpE6hOAgVRq93CSvqazcrb7GX93X8PPMpR9P+ECA2AzVlHo6AVl9bHhGwJ4SHx0Zs1az
	SPPf78w==
X-Received: from plbmn14.prod.google.com ([2002:a17:903:a4e:b0:2bf:b2c:fa1d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1cb:b0:2b0:6e6a:8504
 with SMTP id d9443c01a7336-2bf36845c9amr19204545ad.27.1780093368939; Fri, 29
 May 2026 15:22:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:21:48 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-6-seanjc@google.com>
Subject: [PATCH v3 05/40] KVM: x86: Trace hypercall register *after*
 truncating values for 32-bit
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

When tracing hypercalls, invoke the tracepoint *after* truncating the
register values for 32-bit guests so as not to record unused garbage (in
the extremely unlikely scenario that the guest left garbage in a register
after transitioning from 64-bit mode to 32-bit mode).

Fixes: 229456fc34b1 ("KVM: convert custom marker based tracing to event traces")
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e6f1dd84f22d..634a6d0197f6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10429,8 +10429,6 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
 
 	++vcpu->stat.hypercalls;
 
-	trace_kvm_hypercall(nr, a0, a1, a2, a3);
-
 	if (!op_64_bit) {
 		nr &= 0xFFFFFFFF;
 		a0 &= 0xFFFFFFFF;
@@ -10439,6 +10437,8 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
 		a3 &= 0xFFFFFFFF;
 	}
 
+	trace_kvm_hypercall(nr, a0, a1, a2, a3);
+
 	if (cpl) {
 		ret = -KVM_EPERM;
 		goto out;
-- 
2.54.0.823.g6e5bcc1fc9-goog

