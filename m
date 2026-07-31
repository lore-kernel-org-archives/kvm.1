Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E304644D696
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519228; cv=none; b=GSpaNkTF6G+faIHw1OFGdOFB8A9z8/lISX1JasoUvuExb4t+U7RvcudC59vnKDc9Ro+0IVAnz+2t7EaOJfn2oLW7AkDrvGriYTZFiPI8yQCUGZZyNug4vADgqPgEbctbYFecFXQwTpcdJM6SgTF/HYaqHyHZorpJUhAgQhka3Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519228; c=relaxed/simple;
	bh=pNM5n+IuCxl2iLTtunwdVdAAkFkP0yRDBV9fsMqYoTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bIqr5JVAdPMWqelyw7BhZr+5mPm/24p0w/T09qGjSK2YY62mDQZQDnXTRA8bSN/laR1ilhmXYXz1dqEsHpD5Sj/WJmVmJZT+YnW3ERVisBeE5WPUHiNwY8LbE3jlQHuAF6U3i0JHFqPY33MI6soGw0e4CtGkH6aQ1rX74aY1+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QrjUuv5y; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QrjUuv5y"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so1811719a91.3
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785519225; x=1786124025; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NPRf96ka6Bve5osy1MsMtUuS9Eza24x4seftdT78Sdg=;
        b=QrjUuv5yt43wD9axlDvAcvNp2L3y32oUxWl7ELnuAjoh80pnOZ5BClG1DhNmwELs0w
         S4wjmWQS6EUNHt11wnYxet06NVXK7FmZncPmFQoJG+erDuV7/5bsC+C+nv2xbTgXmRXv
         D+NrFcXNxXoPxzhBevbg9b1ujplWS2qX+YI33wkKv64bpDrFmALVM6N7RWreELwEdsNC
         4TVeqnZuZ4zcM05hKz8QMW/jy43P46vTHUcY0Cv7GhhetZ5b4oXMMTrnlBnEya3D69Bh
         3dkGrgwwFoNhB6nnBxiCCnYmyEzMh/JkR9B/r0xQE3/mYoDqTQwPyv6u8pLrdl6GxrB5
         B+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785519225; x=1786124025;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NPRf96ka6Bve5osy1MsMtUuS9Eza24x4seftdT78Sdg=;
        b=A0YJx99972EZtISSkfH+llnb85b6mU+eIj8pl2uSPcLBQVdC7ZSVKMM03Zzz1xZHu/
         smouLo5FYezg7kYnwGV1okQXxnnhSFHskYBfdx88jUPVJsibaEk5Vt2KqyqQo6KhrITO
         j48f5FpuO0Q85FBEXL/S7+rhPlvcc3rWeXzZItzvxSrJixtAVA82VuzjoBKy7q7OtXxz
         CuvQGWQ7WC1dRojHrXnJRTy9in3AY5BZEldJhmNcU8mdrlsvtRGf3BPIvzTTP1jhqdJg
         TiCckGyGRzau8is7pXiDDmhLG3cG8EJB4aND4AKMwgWDSKqDNFSzJVSWccPK+d2Eyyij
         TmsA==
X-Gm-Message-State: AOJu0Yyv3LZ3DP/5oxFa3v3HrG5nK0caqbUuJgirexuG7Z3m0yiHBwca
	WERDiABvNXQX4P5k+DrftwObSRayWB0VxAz3jyvsrUUemgQqXFtaS3e8Dx3tddM4EvO5L8ChJhZ
	7bmksGQ==
X-Received: from pjbbj3.prod.google.com ([2002:a17:90b:883:b0:380:6618:e058])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17c7:b0:38f:1dc:672f
 with SMTP id 98e67ed59e1d1-38fbc497f62mr587492a91.18.1785519224621; Fri, 31
 Jul 2026 10:33:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:33:36 -0700
In-Reply-To: <20260731173340.2644656-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731173340.2644656-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731173340.2644656-3-seanjc@google.com>
Subject: [PATCH v5 2/6] KVM: nVMX: Synthesize SHUTDOWN on RSM if L2 requires emulation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hao Zhang <zhanghao1@kylinos.cn>, Hao Zhang <hao_zhang_kdev@163.com>
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
2.55.0.508.g3f0d502094-goog

