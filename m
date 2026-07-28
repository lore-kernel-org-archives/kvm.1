Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BF62192F9
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199437; cv=none; b=Uh89Mpp2+A1kQirtJf8cc2BkHTYw6Q+8ZgygEmFVZUb3Tu1jcIbYsrTRF01m5v0KfXMFwVtylZZ0d6hJIvyd6328QgcAPFUtEP8bT5IKt1zVnpHY8ezFCLTSbISaG6Y06a4GuUE6SYqXKVKgX8iAwFvu1dlp58S1VoQUVjma8ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199437; c=relaxed/simple;
	bh=LufD9LC1kKKPCpQl1k0wWWbduu+gLp/3xbjKEMdRutw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ue32wxsJyyn3baklgCty/zvQngZB/5Uxkec2dZA3npRDKt7DLHAWPoW5w5TLc8hkPsjqUcyJs6Cs8+EB959dWOCJjER8gyIM6xK5DMxxht5gQho3ngIMvvKaB+/sqrrpX9/5yiQM5DdaVWd/iP0U8geQ4IbqN1uquPo/AJxlLUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L51Gn4hr; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L51Gn4hr"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d004f13426so9129955ad.3
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785199435; x=1785804235; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t7bULcfoxNSRzWp6C1NwQeJ8xPeisIVrS9F2F9UXXtE=;
        b=L51Gn4hrl5z8OgatmLNZixeEb43MZqq1t6Sj6ppmRsUeqc5iUW6vwo3CVtBFXaezY3
         MVOcPhOX6bys2fkuj1+G0jvSpugFd0+swn6+bkYNyNd+blqy1HQIVSgRuKY2PM1P45v3
         oRUDUevqBRPu0Jg4p2cZiqFA8+IiWm9YbBRZXCgYClGDPuCqxRDrQxOuhlGuNn7TgIX0
         Jbjy5XGI18FklmS8i+T+Tjgux9yC6oatuLVEJCeQRwZspiiY7Hvm+CjsjxAxe0y6yMUN
         8tglKDkvCr2x0P587xR/TCWyvT4xgBFsPd+E4UmFwNeq0N5X66FnZHZNwqGZs+51sTPt
         Q+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785199435; x=1785804235;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t7bULcfoxNSRzWp6C1NwQeJ8xPeisIVrS9F2F9UXXtE=;
        b=bam7JEfDcdAVaOWnLfIe92cMyn5syS/VbrZwAqe2d1hhDgURhwLW3WgGI5H5oxgeuj
         KK4PM+flXv6aZfAIfJnm2Mo+owf1M33MAKvfOhIgLM6WMopR0ua6x0KPHwOM2dkDqoUN
         QD0X5w13gTI7vf98e0eOSwD0bh1+F3Tl47Jbolqfti0ghfqdTr36Pp+2yyZzco0aJP9q
         4SdaRz35GGxERTLhSTInNSWpJxqWgDoYt+ifPOliQ87WE1Wchv5kfY7NbOPEx1CjzX18
         1IocBsfdnXIi0on56zZUYJZyK2PHmTP072YtXf1K/Z9HC4XzFXSMpIvYZMH5JFk4+jHE
         /oGA==
X-Gm-Message-State: AOJu0YxSD+zEsGOl6FRKNVPuqjwqISRhkLqKh/yN/3xSaz++xfCTTu2f
	bh+mO9zig48tgrrrGIDTivEtQbaP8e0ABT4fJKvzqSBqHr94aCxWTl1l4lYcTEiFmWOWWgh3m2M
	4EB3uoQ==
X-Received: from plai17.prod.google.com ([2002:a17:902:c951:b0:2cc:97d3:e244])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a85:b0:2ca:ea56:7a58
 with SMTP id d9443c01a7336-2d015d95234mr1604685ad.37.1785199435180; Mon, 27
 Jul 2026 17:43:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 27 Jul 2026 17:43:47 -0700
In-Reply-To: <20260728004351.887076-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728004351.887076-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728004351.887076-3-seanjc@google.com>
Subject: [PATCH v4 2/6] KVM: nVMX: Synthesize SHUTDOWN on RSM if L2 requires emulation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hao Zhang <zhanghao1@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"

Synthesize SHUTDOWN (for L1) if L2 requires unhandleable emulation after
loading guest state from SMRAM during RSM to prevent a misbehaving L1 (or
userspace via L1) from tripping the sanity check that KVM doesn't try to
cancel a pending nested VM-Enter.  If SMRAM is modified such that RSM will
load what should be impossible state for L2, then KVM will detect that it
needs to emulate the current code stream and will abort VM-Entry to L2.
And because KVM (rightly) expects such a scenario to be impossible, KVM
WARNs and bugs the VM.

  __ret && !(vcpu->kvm)->vm_bugged
  WARNING: arch/x86/kvm/vmx/vmx.c:6741 at vmx_handle_exit+0x65/0x790 [kvm_intel], CPU#13: vmx_invalid_nes/2902
  Modules linked in: kvm_intel kvm irqbypass [last unloaded: kvm]
  CPU: 13 UID: 1000 PID: 2902 Comm: vmx_invalid_nes Tainted: G        W 7.2.0-rc2 #124 PREEMPT
  Tainted: [W]=WARN
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:vmx_handle_exit+0x65/0x790 [kvm_intel]
  Call Trace:
   <TASK>
   kvm_arch_vcpu_ioctl_run+0xdf8/0x1d00 [kvm]
   kvm_vcpu_ioctl+0x2d5/0x960 [kvm]
   __x64_sys_ioctl+0x8a/0xd0
   do_syscall_64+0xb7/0x570
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   </TASK>

Alternatively, KVM could suppress the WARN for the RSM case, but that would
still leave the vCPU in a "bad" state that KVM doesn't know how to handle
(which is also why KVM rejects attempts to do KVM_RUN when the vCPU is
loaded with invalid state).  And architecturally, the Intel SDM explicitly
states that RSM leads to shutdown if the CPU detects invalid state.

Fixes: 2bb8cafea80b ("KVM: vVMX: signal failure for nested VMEntry if emulation_required")
Reported-by: Hao Zhang <zhanghao1@kylinos.cn>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/smm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index a446487bdd5c..656a38dad7e7 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -649,6 +649,10 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 #endif
 		ret = rsm_load_state_32(ctxt, &smram.smram32);
 
+	if (ret == X86EMUL_CONTINUE &&
+	    kvm_x86_call(unhandleable_emulation_required)(vcpu))
+		ret = X86EMUL_UNHANDLEABLE;
+
 	/*
 	 * If RSM fails and triggers shutdown, architecturally the shutdown
 	 * occurs *before* the transition to guest mode.  But due to KVM's
-- 
2.55.0.229.g6434b31f56-goog

