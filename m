Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9D337BB8
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860188; cv=none; b=mOrumQdG1Q1gGWWHmUEgRi3PYhRlAc3ZuxDVO2Zq+3tNShQO6D1OWgG4GlN8gcSaf8o7Vh7ck6USXwA0yK8K3Igvj6UJ7TliZTntHpZnukO1/Mfu1f8OpbebeyBvHblaXS/ddaEYVfTS1oIYR+39ERtSKibYVJosuVq1O6IUphY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860188; c=relaxed/simple;
	bh=bromhZmHN8ua+dIbZXBfeFpZJBDWbKLAEzj+DqK+PiU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eoxLe+ngJ8lWnQmVJKHxeCRWGROPH8SEJ0nXQpj+CL6P9uKJdUBimCh/M77i+clTRB8jYqG+qylxZWvhC5QNzroEsNc2FIen+hgq6VvWwXqwjENeK0Onw0n2lYKN/+I66cpsPDh6EjacV2mlmsgMRdRB/lYMqengap46bGHPJbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOwEmZ7v; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOwEmZ7v"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ca5d2474c7so948135ad.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782860185; x=1783464985; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=R2oAlCr5kdZkAlC8xVvYUA9OOvmORRpHt8rXM0IMIiw=;
        b=nOwEmZ7v0GVAc6oXTmnBMv8+szdwg0pt8f5Ad1zdwYQrzLWd5AmlqEv2xH8lNxxvMw
         ZjI4AVW3lp2/vhNpcqQj+0WxMhHMqbS6LoY4BtMUHTcZVwkhJ9h9ZK57DwL/rqHh4FnA
         I++o3SwfNxOw21UIyK3fBkvKI3sr7LxN8RKvSR6VIFwaSuWv+IgY8Y4devBwa8BFM+XL
         BA51+l9wl+rAeLPwMumqnvHaRIG+ss9Bprg+V6D4N/dABDa08QAp4fRUOad2LWv56W2c
         ctvY7CVYwpaLI+HhVcfQ1P+W7ySUdCuwxjOWsctP1Hjyy5OU3SzMYZ6GMPAJF82J7lA4
         rPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782860185; x=1783464985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2oAlCr5kdZkAlC8xVvYUA9OOvmORRpHt8rXM0IMIiw=;
        b=fJB8Tq3g3ndnweIs1NqHXFyradZdaGv9ZNRHDvXu4ZgP21cU9NnoMUyS+wLqVVxDSN
         PsqA3JwIx5YaF5X/oXDUwwEdd11E7z9padAWZ5q/+WXtWEugIJZxUjLHpZ1nn4VoN4i2
         oOQP2ea0MgU7aib7KAMvZxWKT4+cdJGPL8h4msosj27I8Vk4MiqYyXZRlspZpIrpPsZE
         X4Se5F44sOzxa5lztKXY752nKCS1fQlEwLmyF9aoRdzFNz0aag8d40UAVq2e2T1Q6uck
         66OL3oB2eeSDRjWgbVaksQTHmZ+4Gz8WzYaFVBwgFbb/MOmrGv9K2Klb5/qsikSHChwC
         fOMw==
X-Gm-Message-State: AOJu0YzsNnTBO6l468V4SBg3FGXZO9H73wLKogh3kwWxqjgE0ibrnSZ9
	l8qDO6bseG6qTe8NQW9ux9i1mxJtj8smMdjmoY2p6m8MVmE2eZeoSgaxx+tNehu6ugJ1TBWJcNL
	qzhh4Jg==
X-Received: from plho13.prod.google.com ([2002:a17:903:23cd:b0:2bf:1274:c8f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41d2:b0:2c9:c95e:5836
 with SMTP id d9443c01a7336-2ca2d52b599mr46329945ad.5.1782860185030; Tue, 30
 Jun 2026 15:56:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:56:11 -0700
In-Reply-To: <20260630225619.511632-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630225619.511632-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630225619.511632-5-seanjc@google.com>
Subject: [PATCH v4 04/11] KVM: x86/xen: Always route non-singleshot-timer vCPU
 hypercalls to userspace
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5b32c49cd8f005e65654@syzkaller.appspotmail.com, 
	syzbot+5d2b94b77112148d1744@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

When handling Xen vCPU hypercalls, explicitly route non-singleshot-timer
commands to userspace, *before* checking if in-kernel emulation of the Xen
timer is enabled.  Punting hypercalls that are never accelerated by KVM
because some other hypercall happens to be disabled is confusing and
actively dangerous, e.g. it's easy to miss that the only reason KVM can
bail early is because the timer-disabled case provides the same semantics
as the implicit "default" path in the switch-statement.

Opportunistically convert the switch-statement to an if-else-statement to
avoid having to carry code for an impossible "default" case.

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 694b31c1fcc9..3ed6686e0a1a 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1607,11 +1607,14 @@ static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, bool longmode, int cmd,
 	struct vcpu_set_singleshot_timer oneshot;
 	struct x86_exception e;
 
+	if (cmd != VCPUOP_set_singleshot_timer &&
+	    cmd != VCPUOP_stop_singleshot_timer)
+		return false;
+
 	if (!kvm_xen_timer_enabled(vcpu))
 		return false;
 
-	switch (cmd) {
-	case VCPUOP_set_singleshot_timer:
+	if (cmd == VCPUOP_set_singleshot_timer) {
 		if (vcpu->arch.xen.vcpu_id != vcpu_id) {
 			*r = -EINVAL;
 			return true;
@@ -1640,20 +1643,16 @@ static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, bool longmode, int cmd,
 		}
 
 		kvm_xen_start_timer(vcpu, oneshot.timeout_abs_ns, false);
-		*r = 0;
-		return true;
-
-	case VCPUOP_stop_singleshot_timer:
+	} else {
 		if (vcpu->arch.xen.vcpu_id != vcpu_id) {
 			*r = -EINVAL;
 			return true;
 		}
 		kvm_xen_stop_timer(vcpu);
-		*r = 0;
-		return true;
 	}
 
-	return false;
+	*r = 0;
+	return true;
 }
 
 static bool kvm_xen_hcall_set_timer_op(struct kvm_vcpu *vcpu, uint64_t timeout,
-- 
2.55.0.rc0.799.gd6f94ed593-goog

