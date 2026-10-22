Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695934;
	b=12rHB5JteIC4Gkhw39PkPShv3aa9RPQB/0su8KeCI69Aijo5FWlwbrvg90FftwuBhGkq
	 QpeOozP0d2QNxqnUL17XZZqlmhDt//Exngq6wBlM1dcyzI80mYdJEo2pjYnq+NiELGFZu
	 4YDmRqymCK7BStTnt62GmMATBAGL1z3aDlK/eBPSOtKWgifmkfmgJYMiVL/Sul8qW5qnp
	 g1DzKCwyeX1zrV53ImHYJPqTA1wxBJ9FcMtfPJbhdjH3jM4d7z5v/uzvIFcS8MpZLb7rl
	 NGKSoy05ewvnsDVI7LoU+RQ9O+RmLM4BCTAkZUXEPX5rnqVF8xb+LEozLYWNKWa6KAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=HI5bj/CT8BNjrOfJnlU9KPDI14WhtY98QrvHbQMLSnU=;
	b=DHH3RzbZO5rEWEi8Y+F/Sfd6b3PcD9yI4HVtNYwcy65Uq8IYXgkDtwGP6P6X330cwIZG
	 VgS2iTwattq2A61bQDWc69oE7B5MnWoaz7T5vt/D9DArw2CQCfVDZRvkr8Gi9tuo2kuk6
	 osS/7NCtho67aQKH+zsJ6xZ5X7tkFkHPNT9ryBhHotRic8cJ5Zr4HAyt8efCu3tfDQt7n
	 FIJhwXn2qX45TVRuU6EXJmmZKsPJJE4jxhI6btPutA5AMlvw2yZSi60E9m+IWn6Hun/9H
	 gnOgqiiLAxkGZAOqgvc0Y8UNc+dmrLwMSfepQbsdG2WCw7GtQ8XpkE9CWszjlQGQI3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=N+eynmAr;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B2C606A31B
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 19:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4B2C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=N+eynmAr
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ab1e771632so1004389a91.1
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 12:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792695933; x=1793300733; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HI5bj/CT8BNjrOfJnlU9KPDI14WhtY98QrvHbQMLSnU=;
        b=N+eynmArlpCT8942ZX9jT27KkDsXcGNWmTlMDu9o7+WYNhDbMT7422ZcLT8ehQBtmz
         1JSDOAqd6us5qpw+0XNhxlB3bezFtrA2ppfm0vlMkZhCX6zGA75HLUsfvMvlt0jUQbCQ
         nF9yR9hIzbFc02upHkpyk8Rt9yyo858x4fMOwEgyDhueJ9AK3TFKauyaFZyyMt0bOWHX
         Y/rAvlugX4HQ+W/RRekkuBlRSo3GwJ5NLC+8jFT9BRgYh7hVCmJI3z4glUtdSj2fotWq
         B9w5u9oLhr9Jx+WXkJ47b8v8Xsa+qzuZBhMBybifToaevy0PSEnefK4g6jMlPruN5iIq
         s5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792695933; x=1793300733;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HI5bj/CT8BNjrOfJnlU9KPDI14WhtY98QrvHbQMLSnU=;
        b=YDJ03ny/RRPkj6HZe/juuMAQ0WfNhwLkz1O/LqfDi9+lW2NIYMqAm2FUNRxss0TnH/
         59VPApfp4tqN1zpIw5q5zwNi4iCDqr/UedDz1MTMFUIhX2Z0a+cxP1jQ2tD5b7BPZ9/Y
         d9nvS9FIPcMmGc2LkXhIu2R9tewAd42ln2RdTnb4Js1nfWQx0MCkZkBNcF2qiucIowh7
         mw6/pchaLNkm5mNChC9RkKyA/5GV1cUG8eqhTu/1uzz7qaofP3fnTg3bLyEKYEuBuSBM
         S2Uut3xrU1oUSgQq1cEYflF/d8UU11jeG4y2NLqBI39vIiR3/zqEkWPVuANaVk2HpD2j
         j3DQ==
X-Gm-Message-State: AFq9FYLU3FGIAdqE/EzAgkDsXMRSWp3dDq6PgxUMopZBfD5QSOFPl0Qz
	tI+/Danxxi9vtzAQKWGzQ74oMu72fO7Pk7yv9sBRqe7gxhi9+sQCb0OG2oHaKSlKHw3kpMsVAeg
	5Q6Rrtw==
X-Received: from pjvd24.prod.google.com ([2002:a17:90a:d998:b0:3ad:49c6:fc96])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a48:b0:3ac:8b67:185b
 with SMTP id 98e67ed59e1d1-3ada6c8dfb6mr1826375a91.26.1792695933001; Thu, 22
 Oct 2026 12:05:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Oct 2026 12:05:29 -0700
In-Reply-To: <20261022190530.541789-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022190530.541789-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022190530.541789-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: VMX: Clear vmx->fail before exiting to userspace on
 failed VM-Enter
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, syzbot@google.com
Content-Type: text/plain; charset="UTF-8"

Clear vmx->fail before existing to userspace to report a failed VM-Enter
when trying to run L1 so that KVM doesn't consume what is effectively stale
information if userspace continues to utilize the vCPU, e.g. instead of
terminating the VM.

Specifically, if userspace forces the vCPU into L2 via KVM_SET_NESTED_STATE
without ever doing KVM_RUN again, the stale vmx->fail will trip the sanity
checks in the nested VM-Exit path that KVM didn't botch its consistency
checks and/or configuration of vmcs02.

Note, reworking nested_vmx_free_vcpu() to not abuse the nested VM-Exit path
would NOT fix this issue (even though that's highly desirable and necessary
for other reasons).  E.g. the reproducer just happened to let the VM die
after setting up the problematic scenario, it could just as easily have
forced the vCPU L2 out of L2 via any number of ioctls that flow through
vmx_leave_nested().

  WARNING: arch/x86/kvm/vmx/nested.c:5139 at __nested_vmx_vmexit+0x86a/0x890 [kvm_intel], CPU#76: repro/21553
  Modules linked in: kvm_intel kvm irqbypass vfat fat sha3 libsha3 gq(O) spidev cdc_acm xhci_pci xhci_hcd [last unloaded: kvm]
  CPU: 76 UID: 0 PID: 21553 Comm: repro Tainted: G S      W  O        7.3.0-smp--0767452329c33-seanjc-sink #5 PREEMPT
  Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN, [O]=OOT_MODULE
  Hardware name: Google LLC Indus/Indus_QC_03, BIOS 30.128.2 07/15/2026
  RIP: 0010:__nested_vmx_vmexit+0x86a/0x890 [kvm_intel]
  Call Trace:
   <TASK>
   nested_vmx_free_vcpu+0x36/0x50 [kvm_intel]
   vmx_vcpu_free+0x73/0x130 [kvm_intel]
   kvm_arch_vcpu_destroy+0x81/0x1a0 [kvm]
   kvm_destroy_vcpus+0x9d/0x160 [kvm]
   kvm_arch_destroy_vm+0x25/0x90 [kvm]
   kvm_put_kvm+0x342/0x460 [kvm]
   kvm_vm_release+0x29/0x30 [kvm]
   __fput+0xfe/0x280
   task_work_run+0x83/0xa0
   do_exit+0x23f/0x970
   do_group_exit+0xa3/0xb0
   __x64_sys_exit_group+0x17/0x20
   x64_sys_call+0x18c6/0x18d0
   do_syscall_64+0xfe/0x460
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   </TASK>

  WARNING: arch/x86/kvm/vmx/nested.c:5142 at __nested_vmx_vmexit+0x6c6/0x890 [kvm_intel], CPU#28: repro/21553
  Modules linked in: kvm_intel kvm irqbypass vfat fat sha3 libsha3 gq(O) spidev cdc_acm xhci_pci xhci_hcd [last unloaded: kvm]
  CPU: 28 UID: 0 PID: 21553 Comm: repro Tainted: G S      W  O        7.3.0-smp--0767452329c33-seanjc-sink #5 PREEMPT
  Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN, [O]=OOT_MODULE
  Hardware name: Google LLC Indus/Indus_QC_03, BIOS 30.128.2 07/15/2026
  RIP: 0010:__nested_vmx_vmexit+0x6c6/0x890 [kvm_intel]
  Call Trace:
   <TASK>
   nested_vmx_free_vcpu+0x36/0x50 [kvm_intel]
   vmx_vcpu_free+0x73/0x130 [kvm_intel]
   kvm_arch_vcpu_destroy+0x81/0x1a0 [kvm]
   kvm_destroy_vcpus+0x9d/0x160 [kvm]
   kvm_arch_destroy_vm+0x25/0x90 [kvm]
   kvm_put_kvm+0x342/0x460 [kvm]
   kvm_vm_release+0x29/0x30 [kvm]
   __fput+0xfe/0x280
   task_work_run+0x83/0xa0
   do_exit+0x23f/0x970
   do_group_exit+0xa3/0xb0
   __x64_sys_exit_group+0x17/0x20
   x64_sys_call+0x18c6/0x18d0
   do_syscall_64+0xfe/0x460
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
   </TASK>

Reported-by: syzbot@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b341af4c6057..29aa93cea963 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6756,6 +6756,7 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 		vcpu->run->fail_entry.hardware_entry_failure_reason
 			= vmcs_read32(VM_INSTRUCTION_ERROR);
 		vcpu->run->fail_entry.cpu = vcpu->arch.last_vmentry_cpu;
+		vmx->fail = 0;
 		return 0;
 	}
 
-- 
2.56.0.257.gf7497c7d27-goog

