Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2613630A7
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093378; cv=none; b=R8IKh4yzPmyIPStxO/BwFqMfPYtMpCUbr7P1OovGnfrKL6pkHIcxzaNoGB3PMXNj8CHmTIrNwPL9pvA5fSlQaPOnRXAf4XDBKWD21mGBmaTYO4boPmWJY6c3XMvyoc+55R3lUK678b/gI07W5VoV1JfOb3iy9USFBClPEskAzcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093378; c=relaxed/simple;
	bh=7mIOAYDO5oSpz1HswBSG6LYqEatOLHW5qOqOaTlM01Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hOqDPGp7SzkJQTOFD6T3xQWAP9e548W/5/smYFxc6kwUiRRQ/o+ziR24dHXMTCS2Zr22Dbcj9SSZwAmAjSiUIJUMJhaSbTmk+vEeRoNyHvuEYEBkmLgZmYhgwoump0t9hL7xgVe+rWyFTFf3M3YzVth4Xm3G/odMCuz6rjeTjw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KQE68mFt; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KQE68mFt"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-365fc4636bbso27725384a91.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093373; x=1780698173; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jKofG2Hvtgv/l66zJ72qbyioy0cgxVopkyT0Bv1ocwE=;
        b=KQE68mFtJfvxiBmycb+hSiJsRsK8mD4hZH3AZZFQKxAerQrgXcSM946oMyN3HSCyYK
         byYvUxeVVmezKDecLfbhxe5RfYcoiVwbXmUYs73v8mD4ifKtuQaXQlqo0DKhJ7743P48
         V7/3khwfJ6jlGj7GpKUngvpnYyrgi3Kz24x+I+j8Re7r54ztKM8jY0Kh1o4aiQlAn/xY
         u3FrLovgXSvKuxNqfbVPTmKW/VoTKsIJMBz+IgnWd5BH3w1N2tYxtYkaZMndWpBGahp4
         d6FCT6qFJgwx1BuBIVh/HvAGy+f4NsE1BbeKCGLQju4j2peOV6f6VzWRoUVxQ2hE1cxd
         vLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093373; x=1780698173;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKofG2Hvtgv/l66zJ72qbyioy0cgxVopkyT0Bv1ocwE=;
        b=jrpmUVTjwQyZxxAOONTZ7lmBNyZfTNR4xAvpeSg6Kmk4WY9+U096U8u3mPdFoPAPaS
         jBjYWmjqb6uixlEGUPyy0V3yoGha8Be5RKIXnXoEdDMq311vJ/VoMjENTwgrXCNkPss1
         DngE1sHXp4TkmXUKdqsBotoVaUJloyMdfG3SGO1zS3N0zVEgWSwq1jvNoR4/g8EjbX7m
         5dAWIV0UPrMQpdXwS4OI7fRGqkNW8GD9OwgD5VZlB9iDvTNnkwjUeok32zqjw64CC2Yu
         0Ir4WTMjXyG+vzEONHROW/qEzJ4TS+pVi9W2Fb+4w7LmC0oP0DWUItQHwwC45loGOn3I
         iczQ==
X-Gm-Message-State: AOJu0Yw3huRlJbs8ry4S8JINJ+rFyyPqxBjWZHJRuYevuNCKHqgNnxNn
	NJmXqvABC1ikOuMvoIc9t/71u9Y+PngFaSudksQMEGUveV8PqqXL/HP6AhWdaQP6PD+D24QO5d/
	Bjq0HeQ==
X-Received: from pgig5.prod.google.com ([2002:a63:f405:0:b0:c80:2399:151])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6017:b0:39f:a42:9251
 with SMTP id adf61e73a8af0-3b427f2af2cmr1231557637.22.1780093373357; Fri, 29
 May 2026 15:22:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:21:52 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-10-seanjc@google.com>
Subject: [PATCH v3 09/40] KVM: x86: Drop non-raw kvm_<reg>_write() helpers
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Drop the non-raw, mode-aware kvm_<reg>_write() helpers as there is no
usage in KVM, and in all likelihood there will never be usage in KVM as
use of hardcoded registers in instructions is uncommon, and *modifying*
hardcoded registers is practically unheard of.  While there are a few
instructions that modify registers in mode-aware ways, e.g. REP string
and some ENCLS varieties, the odds of KVM needing to emulate such
instructions (outside of the fully emulator) are vanishingly small.

Drop kvm_<reg>_write() to prevent incorrect usage; _if_ a new instruction
comes along that needs to modify a hardcoded register, this can be
reverted.

No functional change intended.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/regs.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 12db5039aace..f22b3a8cd483 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -61,11 +61,6 @@ static __always_inline unsigned long kvm_##lname##_read(struct kvm_vcpu *vcpu)
 {											\
 	return vcpu->arch.regs[VCPU_REGS_##uname] & kvm_reg_mode_mask(vcpu);		\
 }											\
-static __always_inline void kvm_##lname##_write(struct kvm_vcpu *vcpu,			\
-						unsigned long val)			\
-{											\
-	vcpu->arch.regs[VCPU_REGS_##uname] = val & kvm_reg_mode_mask(vcpu);		\
-}											\
 static __always_inline unsigned long kvm_##lname##_read_raw(struct kvm_vcpu *vcpu)	\
 {											\
 	return vcpu->arch.regs[VCPU_REGS_##uname];					\
-- 
2.54.0.823.g6e5bcc1fc9-goog

