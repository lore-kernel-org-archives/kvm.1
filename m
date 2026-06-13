Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9771C01
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309014; cv=none; b=G/q5i+4NnPMz/89aksEbPEaNgTSDVpqCb8mgT4xCWG8jwGhhIjZB/zWeX3UDkrbebe7FXBBSgrr08m2plXCyk7HcXKl52jDJOv3XUoSdZtlDQs/Kh4GLIk8ea9bpf7AJR6+gqpl7fcGvwZJodZibhwYbUT3xXK6+8Qy9Wnsvbg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309014; c=relaxed/simple;
	bh=cNPlB7pwwxiLgJgB4oaW+H9DnFOrhBUWWzE+mi91ql4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DqaQX9F/RxTkTtJVL1flxLXaCJjGDLatYnKU7e/gszolkyQCDkYodlK1H6LK2btVIx6PXq+1agCNK/POtWTacTKzafsXle3sbRR0OcoeSSwDtMGT4NWXM7ccyhMGF79ZaWDbmybMSZZsLEZsi6+vTFJcFjJKCASjgcbLkvyVYO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L981S5lT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L981S5lT"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423f3e4728so1058477b3a.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309013; x=1781913813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UuZsimMOlbBIbQGikRbVUz8v6Nz7u3z1RSfZkr5Y1z0=;
        b=L981S5lTEjuenHwkQgV8ybORCoqvPmHPiCN/eDwCo7pkzQvW8b3oGsVGQlXtS8zY0k
         GDh9018493fe9XB46102QG0RfBeiGWacwVStQk2b21ntlHTDiz4Jb47X6xTvGEkVeuC+
         jCWCgB9q9giOpgEsSnIoxrXNBmmN31ouWINOEmihA8r5xVXH618F/jqamPPhmHey1LX3
         UApNATOnq0SolpGKMOkZnLSPfsVcRhUG8SIJ2JPj/WOIP5v4zf7JlX94dvO3asRVp2Yc
         ydepMXqSXbzvewFyOljSH2NkQn0Yr69QsMbCnd2YXNc/2PV73eWCEAudCq/jA4S+FrUo
         zc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309013; x=1781913813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UuZsimMOlbBIbQGikRbVUz8v6Nz7u3z1RSfZkr5Y1z0=;
        b=c318URj4UIHPI1iiwDlUkC8nzsT8VIzyt4rbfmzOmGaheVuWNwzjpkT2qXcQEUmoga
         ZDHibuhRKywgMPK4UCkCEII9uL/oEjE/7oXmKuTwvdJ1Ys8C7VSucoR5AhU+34nRZKMX
         XrotjbYhT+88Zfim34I+HzuzGSgTcxwog531KDw19tmwQPwCDRrpy8ZdA1nG7k3N/GLM
         FgtibM+B0IxymvXXLm5aLa7tDjsR3928MkwsNYfB9AjBqMJRljHJkQzZ1dWk9h9qufoR
         lPxG7kscBN/08e0K7UG6qLPXK30sMOkpelPCl9TiytXRBzbKTtFx8v6k4G15HGjYM7rT
         M8Gg==
X-Gm-Message-State: AOJu0Yx2B/xiNOvB+AMhYTJBf/QdPcvfQwKkvGN8q6kwBlQJAk+I86xs
	1mlirsgdE4GoeLSeyqV8w1m6Dk/Zt2q7k27fuySPdcseZdl9Ig1q78BFq1BM7tdel4HoiQDcXwK
	dkUFiTg==
X-Received: from pfbho5.prod.google.com ([2002:a05:6a00:8805:b0:842:7548:51e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a16:b0:842:33f3:da68
 with SMTP id d2e1a72fcca58-8434cd0b4d2mr5393414b3a.8.1781309013046; Fri, 12
 Jun 2026 17:03:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:00 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-2-seanjc@google.com>
Subject: [PATCH v4 01/30] KVM: x86: Extract REGS and SREGS runtime sync code
 to helpers
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Extract the REGS and SREGS portions of {store,sync}_regs() into separate
helpers in anticipation of moving the register specific code out of x86.c
and into regs.c.

No functional change intended.

Cc: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cf122b8c3210..74b8f98dcb24 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12687,7 +12687,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	return 0;
 }
 
-static void store_regs(struct kvm_vcpu *vcpu)
+static void kvm_run_sync_regs_to_user(struct kvm_vcpu *vcpu)
 {
 	BUILD_BUG_ON(sizeof(struct kvm_sync_regs) > SYNC_REGS_SIZE_BYTES);
 
@@ -12696,13 +12696,18 @@ static void store_regs(struct kvm_vcpu *vcpu)
 
 	if (vcpu->run->kvm_valid_regs & KVM_SYNC_X86_SREGS)
 		__get_sregs(vcpu, &vcpu->run->s.regs.sregs);
+}
+
+static void store_regs(struct kvm_vcpu *vcpu)
+{
+	kvm_run_sync_regs_to_user(vcpu);
 
 	if (vcpu->run->kvm_valid_regs & KVM_SYNC_X86_EVENTS)
 		kvm_vcpu_ioctl_x86_get_vcpu_events(
 				vcpu, &vcpu->run->s.regs.events);
 }
 
-static int sync_regs(struct kvm_vcpu *vcpu)
+static int kvm_run_sync_regs_from_user(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->run->kvm_dirty_regs & KVM_SYNC_X86_REGS) {
 		__set_regs(vcpu, &vcpu->run->s.regs.regs);
@@ -12718,6 +12723,14 @@ static int sync_regs(struct kvm_vcpu *vcpu)
 		vcpu->run->kvm_dirty_regs &= ~KVM_SYNC_X86_SREGS;
 	}
 
+	return 0;
+}
+
+static int sync_regs(struct kvm_vcpu *vcpu)
+{
+	if (kvm_run_sync_regs_from_user(vcpu))
+		return -EINVAL;
+
 	if (vcpu->run->kvm_dirty_regs & KVM_SYNC_X86_EVENTS) {
 		struct kvm_vcpu_events events = vcpu->run->s.regs.events;
 
-- 
2.54.0.1136.gdb2ca164c4-goog

