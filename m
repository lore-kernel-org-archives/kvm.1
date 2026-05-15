Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B9A3F5BE4
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884004; cv=none; b=Dqoc9YPXkIRLuSIPCqaILL09Wl6sfW99JtjHSvfZjXuvDq6xB7LLNRA6NgRPQ5RUKPxbQ+Z+pXn7elJm51K9qM4iebAOpvxy7vr9jkF80gOWXN+95i34lawHO/EfUJKHJSvYvOVCbZNcQJz3PgCbfIZfSLwlQjgOjMZpNHyoO8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884004; c=relaxed/simple;
	bh=LxKzS03Gmqoo+/JLichPrjQtMYa7ehTDbRq6QGSRQ8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mUXZBsuFREZDNSlWW2sYH1ExEo7X2m7xnjNzjYiOAFC6lfv2Lca1ah6eWfMSkqPyIMf5PMbZIYYwy7Z8pHQPoyV21XOp54N8BR8++BcA0QvcaX4jlw6KJeMDsxt8LWFhyjEZQSz9epi7vwjD2qRKbm2l/qXRnZ4LMCbqV7oTt5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=arvnzYqY; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="arvnzYqY"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8397b14a689so272301b3a.2
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 15:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778884002; x=1779488802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=m6arFDkWWaTpsQxSj9hjRlvpz1Jnp6+Eh839mqAbYks=;
        b=arvnzYqYxtxcbXpkl0fL5ZzhMgIhDMW/82tvP/HIiOMzTwlWq4jha4gd1nMHN3GMCz
         i2OufE7Vr8MqAB5az/Xx4/DdW8+HiYuJ5CScMcFcQJvo6TLDP7gNB0/dM4X1xGcIBtCh
         slgmPkyF2eBKU73q2tjEEqZgta04kuhOcddkMxIIYP0uYbD+Aq5RaU0n69t3A6bfDfhQ
         lTw7rj41xHhOeCUrZTER86TWQ+k1cMzI+Nk2X4iUiq1RzZCXu/16xqzUEk/xidKD0YUQ
         TuZqtmogJLrdlt81+UBE//sk5ePhxW8S7tt2XIdR+RytXoNqBQQTLF+dzosFSa5CfW4v
         pbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884002; x=1779488802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6arFDkWWaTpsQxSj9hjRlvpz1Jnp6+Eh839mqAbYks=;
        b=FXLLOPT51uF+ZFuBqVUYh4hg708b2t53wSg5vqqk/X1wKw2n8FvG2vcdQU4ZBb8Ey5
         gJjKKFcwgmBObOe0MUK/ljxyH0JMmNWzHyG+lVCIBVGHfHRdqrIs+Pz6urdgNXArjOL9
         TcwsEUOWv5ZboWrgNG1OCOYPr0Z/otIc1UmDYy81iItGjK0t+IGyp9IaPtxb/Tpfslat
         lsHEHOiL+5PqH8YQ2G1bEkHjlFtuW/pE7QxZzwaujJCeWJraSin2FGLmKL+KsEJauOHL
         XsitVmrri2fKQR3FtOgWqfzs23yccSRnhHNdHT2kRwKc8nTcrRX/ExrKJ6MPLwdZdV68
         FsqA==
X-Gm-Message-State: AOJu0YxkkOU0FVcNwTRo6WNFLyToQoG9Y7D0YZrbfuszH6qXYhnQR/wu
	F3EUiJhe3g9WVMRTYDv7LRk6eZeHfaX+WW28vFZauIbaiLv145kjh57udp672YTbadsOWpi+wID
	DGZMbQg==
X-Received: from pfbgc1.prod.google.com ([2002:a05:6a00:62c1:b0:838:27b2:c77])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2908:b0:82c:e60c:f36d
 with SMTP id d2e1a72fcca58-83f33f1bafcmr6273754b3a.48.1778884001931; Fri, 15
 May 2026 15:26:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 15:26:30 -0700
In-Reply-To: <20260515222638.1949982-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515222638.1949982-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515222638.1949982-3-seanjc@google.com>
Subject: [PATCH v3 02/10] KVM: x86: Capture "struct x86_exception" in inject_emulated_exception()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

From: Hou Wenlong <houwenlong.hwl@antgroup.com>

As all callers in inject_emulated_exception() use "struct x86_exception"
directly, capture it locally instead of using the context.

No functional change intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 48f259015ce4..8ddb878934ed 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8978,15 +8978,14 @@ static void toggle_interruptibility(struct kvm_vcpu *vcpu, u32 mask)
 
 static void inject_emulated_exception(struct kvm_vcpu *vcpu)
 {
-	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+	struct x86_exception *ex = &vcpu->arch.emulate_ctxt->exception;
 
-	if (ctxt->exception.vector == PF_VECTOR)
-		kvm_inject_emulated_page_fault(vcpu, &ctxt->exception);
-	else if (ctxt->exception.error_code_valid)
-		kvm_queue_exception_e(vcpu, ctxt->exception.vector,
-				      ctxt->exception.error_code);
+	if (ex->vector == PF_VECTOR)
+		kvm_inject_emulated_page_fault(vcpu, ex);
+	else if (ex->error_code_valid)
+		kvm_queue_exception_e(vcpu, ex->vector, ex->error_code);
 	else
-		kvm_queue_exception(vcpu, ctxt->exception.vector);
+		kvm_queue_exception(vcpu, ex->vector);
 }
 
 static struct x86_emulate_ctxt *alloc_emulate_ctxt(struct kvm_vcpu *vcpu)
-- 
2.54.0.563.g4f69b47b94-goog

