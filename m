Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395647;
	b=KyO7fmLd5NYunf+52Ljm5PNr71Beg4qfUcVg1hb0dsZtDzxP+z8Cip9NX2R3rjkOjqxF
	 R+p3GbB8BDurOhit3dmsk9YUTb7Losp78+6PiQeWE1k9Um+nSs2uuutgA+hUlzydO0DxS
	 rTIyVUeUldd4RZk/NuvQ0p2C/2/gE2dPVMDlXR9Z8bZgyTixj/jiGrmHZd1JQ5ch+JxM5
	 C0L5VQG1ppDsIvthRd5NcrAFl2pXj9kzyEoz34UcE4f3PVtlbjVor3i7PP990sTpwqLNW
	 UTxxVfKk5/ztCQWJPYKasJaP2K9T1XABP+tyj0+pA89UQmCaqX8B2O22SeKuxk9eV8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=G8AaUzWd+RntU6ZruI0f6pIRIF5esO/31qYJFDLLq7g=;
	b=Jsn7q6TcxwRzIwxvRcEx8YSITI818/Rg+CDuNJO1ZwCk5F+sxBCkTMU+D3m1qfPDdoJe
	 7ELVnOn/MbG41HMloe8IdWwv9AkhB9qW87C7Y+7AiNlmimTcRNeBbnYpKmhuKe1+jncZg
	 RCzkajTYzgrdmfZW2lWz8H2Urh8BWv9FiEPRmGsGt9OFdeYjb56hfFGrTy+8nHRSQ44gO
	 CKNxtdOE3UmAB4uxrxlDRMc+lc4CK1c8sIcLgRuYyd4ezazbX7JwsHSbx+iXva/lSWM54
	 Hrn9JQs6U0c0BrR1Vq6Q7qdck6aQ6xTX1De+pM8JJVGyKNLY+0f/PWyYuogfUq8njTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LgjvSJNd;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4073060A2620
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4073060A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LgjvSJNd
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ae7faf4ff7so1623935a91.3
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395646; x=1794000446; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G8AaUzWd+RntU6ZruI0f6pIRIF5esO/31qYJFDLLq7g=;
        b=LgjvSJNdEoUQbY2y//TLdv3+r3Vhu73F63BlTLvHievYa5EcuNSQ4Ms8pqUwVKGX0j
         STGmmCfGIvW55+VauoLxfRrQiXtR7Xth0e/KGk5Khg81pMrAqqx+BcUE+TcUUUvsr/Mf
         GujRm532izCh2N5WXGxrsjvLGTX2BuEeeI8qh+8V/84JueWWeSUn3D4lcgPZ8veRafUO
         +DNRY7eo3UcWMYfxoibzSntyDN+E5Csr3RVR8Pg1kHQO0mFnTVS4tEyzy552HrBt/5X/
         FvUZdQSyEKxOksHYiPKvma1P8LwKaHvBhqMnh2RZQSjqLFfTHKtZrdNoDtcOsHyN5OZW
         BEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395646; x=1794000446;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G8AaUzWd+RntU6ZruI0f6pIRIF5esO/31qYJFDLLq7g=;
        b=PJOiT4q3/iOwNnk3h65ZrfPehmxlIgS0+MfFFjlxspU1MGqK7YDZnlkGKk83GmJMB3
         065eNQHdJ4a8/rGFyRatlq5kwrQHvPqMV0Pd1ru4GaUP2df0I25SeWkg/l+3fsa/XfYr
         286zNEc5HJtGVZz6piPlO0wl1qNDHeLVrHx1JWp7hLKLQiV0v4Leqfx7OAqjNR+Vgwp7
         XYM6jdEo7mbDWQ9OlqOsKzHcTsi8GMBcrfwafsHzWzvp16BDT8+3CqJL7vbWq0jP1svO
         DeT/ZVg7kLVoRRS3xjqGF0T/guM287xN5CZUKl5/7l7VukuVjpwY4ZltZTeO8ITvjKRV
         2MHQ==
X-Gm-Message-State: AFq9FYJ5bfid9S5Z+YwHsEwzI4QckQfu05hhiSAe1JAmUkKidEF3neoR
	3fWgUT8a74eIBpQhx73Es97sZpw8CJ5Y8eacoUOPwKj/OVVc+ddfqsWWlzAf+f2tXTtW4/u+k9N
	K4J/RIQ==
X-Received: from pjbfz24.prod.google.com ([2002:a17:90b:258:b0:3a6:f777:b24c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:268d:b0:3a5:147a:3b63
 with SMTP id 98e67ed59e1d1-3ae895a5bdemr2713871a91.8.1793395646388; Fri, 30
 Oct 2026 14:27:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:27:17 -0700
In-Reply-To: <20261030212721.2606393-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212721.2606393-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212721.2606393-4-seanjc@google.com>
Subject: [PATCH v3 3/7] KVM: x86: Reject clearing EFER.SVME via
 KVM_SYNC_X86_SREGS if L2 is active
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Disallow clearing EFER.SVME via KVM_SYNC_X86_SREGS if L2 is active so that
svm_set_efer() can treat yanking the vCPU out of L2 during KVM_RUN as a KVM
bug.  Ideally, kvm_is_valid_sregs() itself would reject attempts to clear
SVME while L2 is active, but the risk of breaking userspace, e.g. across
save/restore, is too high.

On the other hand, yanking the vCPU out of L2 via KVM_SYNC_X86_SREGS is
already "broken" as doing so would queue a triple fault for L1 (because
"wants_to_run" will be true).

Link: https://lore.kernel.org/all/sashiko-outbox-182127@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/regs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 3621f1a47d37..e53496fdeb82 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -738,6 +738,10 @@ int kvm_run_sync_regs_from_user(struct kvm_vcpu *vcpu)
 	if (vcpu->run->kvm_dirty_regs & KVM_SYNC_X86_SREGS) {
 		struct kvm_sregs sregs = vcpu->run->s.regs.sregs;
 
+		if (is_guest_mode(vcpu) &&
+		    (vcpu->arch.efer & EFER_SVME) && !(sregs.efer & EFER_SVME))
+			return -EINVAL;
+
 		if (__set_sregs(vcpu, &sregs))
 			return -EINVAL;
 
-- 
2.56.0.385.gac671c819a-goog

