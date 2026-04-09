Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9003A759C
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775779000; cv=none; b=cqlDmmC015GuXZ220QM7kyeljY1IntsCajzGY3S3qV4CjNAo56NayCxNtRmjQ13jx2KUWrHGIU7wj7tTav8ZRNl+2M+KatVvYWnJ4Kx6Mi5+PlDkYI2ZynWNVESOH7/+vt5ab5K/aZGTl0YV8WUhWP/oVdP96RafYEU+wVnpU40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775779000; c=relaxed/simple;
	bh=DYr12vLfExXRMWPWKvGZY5DxUYvnsl8thA9aDxIwhL8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aSovvkt1uWLfefCuRbk3PqWtf4AvVvs4D7ddtlq951mrfPLdNX9D2tIQJro89R07PCAk4Frfdt1lhFjHG9IOmXT6vDxpKXH5yH8TpMzE+ga8dvzjPArdfzMycsym24IFWq1Qx4LQS93MNHZwnjYVur9BF+9oY6hR5AU1HgBNOMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iQ6DS6pq; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iQ6DS6pq"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bce224720d8so950892a12.1
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 16:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775778998; x=1776383798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MY6cHx08IW2xR2d+249NoYIhXN7g9YeiGpAZRuys1QY=;
        b=iQ6DS6pqNMi2wT0RffS9dMEpGBB87lAhyKIOOhA+GXc1sYEeY4aui1KmauVxD+pNqz
         ylpqWHS/xhrsdcGMSe6z56YSrTElZk5w53WawsZj7RZt//UoYHBT8WbuHzAH09epzc/l
         B1Roi//ad69m2A9oE3vOI7C3sudUkavPTJs993EcY2vZj5dO/8cPXfYd3Ar7l5kwsBcY
         +RlOYBQZftkmD9loIgqfbJSpcncoo6vU01Bcd6+6Nwxkw4gdt9qCFT6v69143qsNnPQ4
         1FvHw+h0Rx/ctqOfxhxcnN+zGGB4wAEcwSuWf5O56xYVSXomCRoeUKO39q+CrJkPfsKC
         xhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775778998; x=1776383798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MY6cHx08IW2xR2d+249NoYIhXN7g9YeiGpAZRuys1QY=;
        b=gujnS4vBg8JfO7ystwkJa7vnS7EU/4RnKioZSmB64xZuf1tnvat0A2H8foTH3yxxE4
         32/h9weAjEVIVYzFyorF6a2ZmrvTg7yn/68YodXN4jDc5MNbqNvG7Zmg8AOq8xNcTAul
         ZtDCce3wP2LS058bu+iYVE2h9C6BL4H/CVYZlnh7SRpC4HADMEeVIhanrbBG2MdspdET
         zAFZ+VJF4i3WXpd0HItQ/47snG6a9nyZZsZEcyxegArHckkkEgeHlguv/189sWgnBQZP
         ViDjmR9NBcqB2V3q5QUdrr679Eylc3pEDwflZc94xC/I0KFnz40jbVTLHh0eb4nMpoPH
         rDhg==
X-Gm-Message-State: AOJu0YywT93lyCKs4Oyv4P/nz3J8qqPt6geqd8ZURujFyxmMEOxeR1vb
	z8qOhVrgfHMadCVHliIEP7MA/2DVxjzkTY/lBXQ5iJAASs5idOxg8vl8LirmAXqTZJhzADyluHG
	yWkmFQg==
X-Received: from pfbfe20.prod.google.com ([2002:a05:6a00:2f14:b0:82c:6ce1:4e6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:f0a:b0:81f:4884:4fed
 with SMTP id d2e1a72fcca58-82f0c24e21emr1046257b3a.7.1775778997441; Thu, 09
 Apr 2026 16:56:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 16:56:16 -0700
In-Reply-To: <20260409235622.2052730-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409235622.2052730-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409235622.2052730-6-seanjc@google.com>
Subject: [PATCH 05/11] KVM: x86: Trace hypercall register *after* truncating
 values for 32-bit
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When tracing hypercalls, invoke the tracepoint *after* truncating the
register values for 32-bit guests so as not to record unused garbage (in
the extremely unlikely scenario that the guest left garbage in a register
after transitioning from 64-bit mode to 32-bit mode).

Fixes: 229456fc34b1 ("KVM: convert custom marker based tracing to event traces")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..34ee79c1cbf3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10438,8 +10438,6 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
 
 	++vcpu->stat.hypercalls;
 
-	trace_kvm_hypercall(nr, a0, a1, a2, a3);
-
 	if (!op_64_bit) {
 		nr &= 0xFFFFFFFF;
 		a0 &= 0xFFFFFFFF;
@@ -10448,6 +10446,8 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
 		a3 &= 0xFFFFFFFF;
 	}
 
+	trace_kvm_hypercall(nr, a0, a1, a2, a3);
+
 	if (cpl) {
 		ret = -KVM_EPERM;
 		goto out;
-- 
2.53.0.1213.gd9a14994de-goog

