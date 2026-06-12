Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B183FAE0A
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305602; cv=none; b=uZ1YmTXPpx+otmhud9QpaS4jxNP4e0l0XhAdezyEg+VrnxEKkHvoyqewa+uGa5liPCw4sviwGau7JafQKVHN0nneO2D8hLGaGcafaGfIUUeEQCVM/c+owyZ7GMb6cXovbn/dNbSXeHAx/CY8ThMON+23musBBp1GNjjfu+qpjok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305602; c=relaxed/simple;
	bh=aR8aSM3blKEoYPh5VlsmJ3gSg4L4aDUcPmqNAKdGzYA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UTSBu0kNfg2hJub1RlGLM6r/V+cu9N2j4YvFYabRZE00JWJr8pTdZiFXjCTco0Mq1gpVw4Bb4Dz7RYFb6aEX109TcpMwhqm0tVk09hrCvzRUuEjzft3Fr3O8ohxOz5ujD7Z2wVDz8TYsS5p691rlx5sCXitl/XoFCTGqR6fRcVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7TujKIO; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7TujKIO"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84240b58211so1070855b3a.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781305600; x=1781910400; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=DVS1qeM4e/fq+IMjcgwSKvsqG9BdLxQ2xhFJGu2W9Ks=;
        b=S7TujKIOSFWuOLQxsF/w8Bc27csrRJyRSFeaTHgu0pOpZ55DVKj/Vj7crXClWPC3J8
         9xiRYLLR73Goo23UcL5QItzutCrqqLfTUOa6A98ZQOQrlaaFmH9SMzBXj7r+rUW5fZhi
         4x9tqFe272maAmclqdIrhkDf+kqdbbM0VxRt+slO2cAwpQIk7ojBndIk47gm1pmd3glO
         mCNPI9zz68LfPnu0KH3DU4GoDxOOSrvhG3gW7g8rGAtNtXr4vNwipTPGlu2BVrdCfZ6H
         vXYHNwVkuE/07gMJAvuGp5C7JSNJCI2900e8I/tYLlZ3zlHalcXkU1wE3D55yRhGNrD2
         6aOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305600; x=1781910400;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVS1qeM4e/fq+IMjcgwSKvsqG9BdLxQ2xhFJGu2W9Ks=;
        b=HgKPn5CaGk3LdtQzs8iODGKOuxBguy8zBQ+0UIAzLcFpqDUz6m0WvRCBybbM8SIULT
         PwgmQud375iYylthaxjzdHlS91cLk6Y46RVatiMmLgfUmlH8z9BtdyDQya61i7eCL7hj
         WXi4Z01zA6PAy1/FgLIwAgIZXta8gF+MBvO6XBe2TMMKp0xYLPtr3lG1KHW3z2PXeO4T
         WJP9tqEyZumqiEgqczTdFsQBnXgIQBsd5a7aJJ4WGoUNYEUjO5Db/FVoRH1Xpm62JEhV
         4p50Z8v6hnS/yEeJ9bwbAXUuCBn2Mb2UJ2kq/OqmghmMKsrGvNCSn2R4mvQVttoW7Wzz
         FCEQ==
X-Gm-Message-State: AOJu0YwlNe7P7mB1xWoVwheO2BulIAlyP4CV4Bf5PNHXWMYJWMI4BOXA
	Hes1fwA4lJUL7s6qTSUZ5Y3uS2ZgXwSgzhYIV8eCOl00WY71SKjrBQtJKFQetZQSPEMT7cY7j9v
	GSmbijw==
X-Received: from pgkb1.prod.google.com ([2002:a63:eb41:0:b0:c82:2d14:39c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:35c9:b0:3b4:b24e:27b4
 with SMTP id adf61e73a8af0-3b783b23756mr4266456637.1.1781305600106; Fri, 12
 Jun 2026 16:06:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 16:06:22 -0700
In-Reply-To: <20260612230622.687665-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230622.687665-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612230622.687665-9-seanjc@google.com>
Subject: [PATCH v2 8/8] KVM: x86/hyperv: Use {READ,WRITE}_ONCE for cross-task
 synic->active accesses
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

When activating Hyper-V's Synthetic Interrupt Controller (SynIC), mark it
active with WRITE_ONCE() and query it using READ_ONCE() in synic_get(),
the only known cross-task reader, to document that the flag is accessed
without holding the vCPU's mutex.

Note, there are no data dependencies on the SynIC being marked active,
e.g. the vector read by synic_set_irq() is set (usually in response to
guest activity) long after the SynIC is initially activated, and a false
negative on the SynIC being active would be benign (ignoring that such a
race is likely to be problematic for the guest irrespective of what KVM
does).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 7efe2907148f..63754a62dc87 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -219,7 +219,7 @@ static struct kvm_vcpu_hv_synic *synic_get(struct kvm *kvm, u32 vpidx)
 		return NULL;
 
 	synic = &hv_vcpu->synic;
-	return (synic->active) ? synic : NULL;
+	return READ_ONCE(synic->active) ? synic : NULL;
 }
 
 static void kvm_hv_notify_acked_sint(struct kvm_vcpu *vcpu, u32 sint)
@@ -1013,7 +1013,7 @@ int kvm_hv_activate_synic(struct kvm_vcpu *vcpu, bool dont_zero_synic_pages)
 
 	synic = to_hv_synic(vcpu);
 
-	synic->active = true;
+	WRITE_ONCE(synic->active, true);
 	synic->dont_zero_synic_pages = dont_zero_synic_pages;
 	synic->control = HV_SYNIC_CONTROL_ENABLE;
 	return 0;
-- 
2.54.0.1136.gdb2ca164c4-goog

