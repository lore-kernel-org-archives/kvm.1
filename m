Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB564372B24
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782425382; cv=none; b=UReO/q0rstXgYCKBprrlzs388eHJFCqUQDkBPUk0xg07H62fVf5PbB9eF/8BWb2rIOud0uDHcn9Z4blH8eU+tif+ZusRE567QtLntjuOJcGLs7wm8S9jHaFgl+onoJWwawDSUo6wiAQlIrmv+Hfddua0dBHQ0iTZ+lB3B36+3NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782425382; c=relaxed/simple;
	bh=UoNy5A+0AU3H3mn0Sz+47bqP7sM059Oz71kNP4+Pkp0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VOGtIaw+2Kmx26P4Nf+qHNzScpdt6MOXuXP7mRvYcFNkc1EoUO1hftfnJ8XDa5qavHIDqr1ylZmEW2xCVEUi2a6p/ipScpcqsOYbaIzLQhJAdA0tc2fdGhlGYz6qRj3P8uc0cg3HsG1mUZQcXrj0XOOAG3LSZ3lM3E4rwMmtqBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=To79hx+v; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="To79hx+v"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37e0c8fe92fso259453a91.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782425378; x=1783030178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qOxiAYyUM90uatCPWI+k8fqb5xJIj1++J9vmz1inYek=;
        b=To79hx+vYMD+kxO6SbWHSqj43QQqYVKeorQ1HznaCkziM8KdVWjF8S7qcddhaFhbfI
         RsWdiNmnQLmzNA6IxE4jmueBiUUtrUW3kWGAGqIfJeSHEpTsSFCK/NOVyln+CEsSJzn4
         xHQdpNuk0jDh/5QdoXkQHhY+q1Qx2mjcELZYslzay00ZsDXQzlij+X82nngLmnZ6tNJx
         nGMVI1gHvlq04WcbjTeFb8Ir881g5Bx1vaAVsrCfRAEhjKrYiUXDCjVIC6ohEfNaqFJI
         jDEYBwQqtDZpM7niW8ncdJ2WvHuV/TDuJ5ZoNVRASDvWtN7Hx7MoVvJ7mSNEBsbtxL2A
         G+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782425378; x=1783030178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOxiAYyUM90uatCPWI+k8fqb5xJIj1++J9vmz1inYek=;
        b=YyG5suJ66/jO/4b7LhtuCJZQDsTz7zs79hPYUOC6mZfFg2kEGEVzrHnYOxzbC4ab/Y
         Ktf0yp7AiROoWWKe+WrCQ9QKBKcnhP7pPcwpfZBoRnmQe1Pz+uaUfOmqtD71nVHIRrYk
         WY8rMjVqIKVatYAZKnXGAtKjwGQtlbow54gLL5IBIwfIvNuo9m06WAi5kgq3ogBZ64dB
         hWQePDOU8zQKtHYsyZjmIe8EvscE1NV8G9z3yHMiE+wq/xTs37giW/W+txt4KiOim8BE
         vWVZkXTF/GLe6sBSMLpOJkzyrlTRfRU3QR7fhgtfMP9Yo6I5CK0qDrC1q0SnAO7Rq3sZ
         7+pA==
X-Gm-Message-State: AOJu0Yz/D9xAiUYL4Bi9uutdUQlxZQ6CIge0o+uj7vATbMAdgyPTOWUD
	vMieqydc55UEcVM0HkxNpbyMbHLdRoFYBgAIwm6KlRBdLGAHwtPGlzwdwh/16fgSzuYIQ67ccZM
	Lp5E++Q==
X-Received: from pgah18.prod.google.com ([2002:a05:6a02:4e92:b0:c93:ce81:ce78])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5446:b0:36b:9798:4f68
 with SMTP id 98e67ed59e1d1-37dcd701bc8mr12366060a91.9.1782425377717; Thu, 25
 Jun 2026 15:09:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:09:33 -0700
In-Reply-To: <20260625220933.3357733-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625220933.3357733-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625220933.3357733-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: SVM: Drop unnecessary avic_vm_destroy() call on init failure
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Don't bother calling avic_vm_destroy() when allocating the logical ID table
fails, as there is nothing to clean up now that the physical ID table is
allocated later, on-demand at first vCPU creation.

For all intents and purposes, no functional change intended, as calling
avic_vm_destroy() is a big nop in this case.

Fixes: 54ffe74cc4ab ("KVM: SVM: Move AVIC Physical ID table allocation to vcpu_precreate()")
Cc: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 6b100fb014a6..cd1761744e1d 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -336,7 +336,6 @@ void avic_vm_destroy(struct kvm *kvm)
 int avic_vm_init(struct kvm *kvm)
 {
 	unsigned long flags;
-	int err = -ENOMEM;
 	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
 	struct kvm_svm *k2;
 	u32 vm_id;
@@ -346,7 +345,7 @@ int avic_vm_init(struct kvm *kvm)
 
 	kvm_svm->avic_logical_id_table = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
 	if (!kvm_svm->avic_logical_id_table)
-		goto free_avic;
+		return -ENOMEM;
 
 	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
  again:
@@ -367,10 +366,6 @@ int avic_vm_init(struct kvm *kvm)
 	spin_unlock_irqrestore(&svm_vm_data_hash_lock, flags);
 
 	return 0;
-
-free_avic:
-	avic_vm_destroy(kvm);
-	return err;
 }
 
 static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
-- 
2.55.0.rc0.799.gd6f94ed593-goog

