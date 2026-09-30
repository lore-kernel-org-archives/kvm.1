Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D653515C5
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730809; cv=none; b=qLpPRaBP45Q0gxxhHiMSsVgCGRE3SVbnmsfn321DoSjfzc848VJaEDGpeRWiwmpOYP53u2BbjGu0tPv8CphB+hQDLGSUEYt/mpleIg08F8J5tLsVxbSug7TiVtLmKPVLbuVF5Av9w+zLvIovLUU1DyFkzpZqtUMF+vkaOybCLqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730809; c=relaxed/simple;
	bh=ElgxEW6lOhjTcQ0sPGPYJIl4XkjO88C2Pm126cID8VQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nwSocnlVPMUQFPw/OWnr22CySEzoY/MWsZ0I8EilMUBji60VTnKKumdvH0g3NhjPsSp8X+N1nadL1fNzv0ACtRWX9aaUT0OlqaVQSky8eTPW0LOlPpqSZhL2QDfNc/nhssnGoADdSCzU2ipjYisRl2ctZODK9DkRXXVox1ykFXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UjQDYe17; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjQDYe17"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1a439db36so2879250a12.2
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 18:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790730800; x=1791335600; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gsm0Z8tsp+/USWWrr0ezp3yOKKjCMmloBgzjcNPK3i8=;
        b=UjQDYe17MC66TtMEAIoKCRXWbAjIrl8cMk5d4inCx+16LbpXsGRoUTtLa+s6e7IVOe
         SCUpohY1V7S9Hw2weiQk60Od857gC1JVZBvfKPYikqkAqtj3FXoA9d7pLQpAdiwoE8sz
         cENe+CZrpcoz+JntoF/Y3i6QeUFuC4HSDHLGdxmO+jY38HxAvqPTAGpNBBQpmVNfin+j
         Z6yWQuut/mt347t3lgkc41cRlmQiQu5i7BHmxjpea8v51j2ERaJk3qAQZdeGBI55sgAA
         2Sg8BEJFfwDG+KTLqPw7bW1WKHclHeuXRwUtewEVngOr5h0XmwbAOkW/Du5PY3qntHiA
         jxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790730800; x=1791335600;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gsm0Z8tsp+/USWWrr0ezp3yOKKjCMmloBgzjcNPK3i8=;
        b=Z7/OdO4Auf/ja3Vex/NL5yy+d49q9AQn8hHzEJhXe3ymcwUrmycOiQBzxC7H5/XzRp
         kfT3mi4fdHfoVcAhBEU4tNYUIMQUbEJ9rj2Q/oiwGtg5bsTJ/y2SH5vo/cJjOrV4hi7n
         iR56UYQykiesNfsB7qYzmardV8rRW0MpjLtWM71IOMcu7Xxrrl7ZwaaaD7xAP5yZAwR9
         tdwNM1RBRmU7m3mJZAzAuO5gvHrwkz8enKEpoueVpom3ibALH3TcPu0u4Rn5MX6cdw8R
         v3Hu4hkbF9vmKkPwt0K8ksF+WTTd2StGC/UAWbzKQWiNcKFtJbGf9iaawUV/7WfsTR8N
         GhTQ==
X-Gm-Message-State: AFuF++mEG9MyqR3uSaUoIVt0UFFPQm8EQW7uKGMt4EV1Y8hhElZPxmiy
	jYdQESpN2I56B5+yeFl9cRNFHtlxtmhxkD9QlFUwzl/oanCnj4wTQj/laytaft1MSHxlMw278Fb
	RNpxR3g==
X-Received: from pgbcs5.prod.google.com ([2002:a05:6a02:4185:b0:cc7:b455:d230])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4391:b0:3da:80a1:f2f
 with SMTP id adf61e73a8af0-3de950dd8c3mr740035637.14.1790730799934; Tue, 29
 Sep 2026 18:13:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Sep 2026 18:13:05 -0700
In-Reply-To: <20260930011313.3197688-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930011313.3197688-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930011313.3197688-5-seanjc@google.com>
Subject: [PATCH v5 04/12] KVM: x86: Force fixed-1 bits in DR6 after
 synchronizing with hardware
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Set all fixed-1 bits in KVM's version of DR6 after synchronizing with
hardware to paper over as much of the virtualization hole as possible.
Because KVM dynamically disables DR interception, a guest can write any
DR6 bit that isn't fixed in bare metal, even if the bit is supposed to be
fixed from the guest's perspective.

In addition to providing some amount of consistency in KVM, this will allow
adding sanity checks that KVM never ends up with fixed-1 bits clear in its
version of DR6.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/regs.c | 2 +-
 arch/x86/kvm/regs.h | 1 +
 arch/x86/kvm/x86.c  | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index f74a29621661..db43ade8ceb1 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -772,7 +772,7 @@ void kvm_update_dr7(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_update_dr7);
 
-static unsigned long kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu)
+unsigned long kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu)
 {
 	unsigned long fixed = DR6_FIXED_1;
 
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 447f0ec3e63e..3ca5cd8a8d95 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -62,6 +62,7 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
 int kvm_set_cr8(struct kvm_vcpu *vcpu, unsigned long cr8);
 int kvm_set_dr(struct kvm_vcpu *vcpu, int dr, unsigned long val);
 unsigned long kvm_get_dr(struct kvm_vcpu *vcpu, int dr);
+unsigned long kvm_get_dr6_fixed_1(struct kvm_vcpu *vcpu);
 unsigned long kvm_get_cr8(struct kvm_vcpu *vcpu);
 void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
 int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ea1406c3b260..99518e3265b4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8417,6 +8417,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		WARN_ON(vcpu->arch.switch_db_regs & KVM_DEBUGREG_AUTO_SWITCH);
 		kvm_x86_call(sync_dirty_debug_regs)(vcpu);
 		kvm_update_dr0123(vcpu);
+		vcpu->arch.dr6 |= kvm_get_dr6_fixed_1(vcpu);
 		kvm_update_dr7(vcpu);
 	}
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

