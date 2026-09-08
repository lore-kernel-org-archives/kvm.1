Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1EB54DADD
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874154; cv=none; b=QZJlr5VO1ZEqVjTJ7BYkyAj1CoLA0vpUKNg0I0IjSG2BqSsZ9seKLJvksdtw/JsgBcDiIuudEuY0N6tqrsjVcA+xf2VDU+UdrfbiG24e4FD1wjLOJ8E9cVrjwWYBK8gtolRWADVArHIvKMDgP/bABZYXsMQOOzILhNV6rbCrlrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874154; c=relaxed/simple;
	bh=aJVEhPGkMTT1P48K01gpb3w3kby8nqqjTJra58+oIss=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Cx24wESnlY7xlva0YvQdizVDPVeC9hXabb7q4/7jIfBrGUtZvQIwCI2YwP5LRurDzjAL147aE38n74b/qxx+Qnx62koKWywC7orhkjowh12LbtJI8TqPGWT/+yXbJ3SsxFFm+UEu6r75fZM/1pk8jKgnn+ff5aB8QZXINhLlrDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nx/N6CrK; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nx/N6CrK"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398fe469aa0so7423962a91.2
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 06:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788874134; x=1789478934; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bWc79TE/cY5J3S3dbAxwEvcg/Sbb2k+6ttNtNE60y8o=;
        b=Nx/N6CrKQwreMZL77CQRjmDUzpPIS5AD96Q+gqECZ6y//oKxMYPHoejLhXXQMP9WbR
         HaYSB9WmZObePyKAlG71MTpHkeZ1xut8l09gtqzzL1xC2iwPiiTEiO5fEmiwlkzKL4lC
         eEGYKxPwYDzXRsQXyvS27b47TA2WkTe8XbJ6zcCLrq274lomAx09Jcus9PoQ3k4sY3Wj
         XTpHRITOFV+WGpMXwNXn+oOcdp3ljvhhE/pNXNUFs1pbAM+HB6beCFUq+Np0UYe3BPPw
         Iw3Nms43MWdu3os0J4fd7e1SmHoPC7dLL8L2PI3tm16r2hhEcOnnTV7nHuvhNaDeRZ/Y
         KDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788874134; x=1789478934;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bWc79TE/cY5J3S3dbAxwEvcg/Sbb2k+6ttNtNE60y8o=;
        b=pMjO2cBEj4gkQrUt0pPy54YxIXaUq+ngSW3vqRqnrSNBX8fqASoqrdGnjSIcEb23X9
         lxPgPFCxsx9oqKqZZPh6rd9+ZrLurLpob+aDvU7dU9w6kjgReYI4xUCg9r9kCOzykCkd
         PtnCCNkJC6W6w/X6TfBn/dTXL58/eNojraONnEY8nFHj9Hpzo4r7xKtMBiZC6wcuYVA7
         T8a6gAg4vBoP/vvbMg9tK6IVpMyA9Fqc39sgKrRIS8p/Y1qBq+U9BD7DwYKZgWP7+fct
         he2qbTbiAEf70ds+Q0lnmTnsLSItJYvP2CsFnPbhmSxqGeFNfwW3NUHm7jKYSQfK949P
         Q6CA==
X-Gm-Message-State: AFuF++kdCLxFH/lOh1JoqcROtNg/QWrrZKk8U9k2yHYfv6l6wwhCEpQT
	a7GIg2Y5OCiB9M/L146A29A7SaTno7sJc9ez94H9jB/ONeJJlzf4GxrHtg4as5ubAtI4I6rzLf8
	4p5APLXrRgMVbkg==
X-Received: from pjbnc12.prod.google.com ([2002:a17:90b:37cc:b0:39b:47ee:e30e])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4fcb:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-39b26100e5dmr41952708a91.4.1788874133755;
 Tue, 08 Sep 2026 06:28:53 -0700 (PDT)
Date: Tue,  8 Sep 2026 06:28:38 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908132838.2116068-1-jmattson@google.com>
Subject: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory during
 vCPU teardown
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Jim Mattson <jmattson@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a vCPU is destroyed while L2 is active, KVM synthesizes a nested
VM-Exit, which flushes the cached shadow VMCS12 back to guest memory:

  vmx_vcpu_free()
  |-> nested_vmx_free_vcpu()
      |-> vmx_leave_nested()
          |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
              |-> nested_flush_cached_shadow_vmcs12()
                  |-> kvm_write_guest_cached()
                      |-> __copy_to_user(ghc->hva, ...)

During process exit, do_exit() calls exit_mm() before closing file
descriptors, so vCPU destruction runs with current->mm == NULL on a
borrowed lazy TLB active_mm. If the borrowed address space has a writable
mapping at ghc->hva, __copy_to_user() corrupts an unrelated task's memory.

Skip the flush when KVM synthesizes a VM-exit with vm_exit_reason == -1
(e.g. during vCPU teardown or SMM entry). In these paths, KVM forces the
vCPU out of guest mode internally--no architectural VM-exit is delivered
to L1.

Fixes: 61ada7488ffd ("KVM: nVMX: Cache shadow vmcs12 on VMEntry and flush to memory on VMExit")
Cc: stable@vger.kernel.org
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/vmx/nested.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 151873407abd..33dc8a07019f 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5121,21 +5121,28 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	if (likely(!vmx->fail)) {
 		sync_vmcs02_to_vmcs12(vcpu, vmcs12);
 
-		if (vm_exit_reason != -1)
+		if (vm_exit_reason != -1) {
 			prepare_vmcs12(vcpu, vmcs12, vm_exit_reason,
 				       exit_intr_info, exit_qualification,
 				       exit_insn_len);
 
-		/*
-		 * Must happen outside of sync_vmcs02_to_vmcs12() as it will
-		 * also be used to capture vmcs12 cache as part of
-		 * capturing nVMX state for snapshot (migration).
-		 *
-		 * Otherwise, this flush will dirty guest memory at a
-		 * point it is already assumed by user-space to be
-		 * immutable.
-		 */
-		nested_flush_cached_shadow_vmcs12(vcpu, vmcs12);
+			/*
+			 * Must happen outside of sync_vmcs02_to_vmcs12() as it will
+			 * also be used to capture vmcs12 cache as part of
+			 * capturing nVMX state for snapshot (migration).
+			 *
+			 * Otherwise, this flush will dirty guest memory at a
+			 * point it is already assumed by user-space to be
+			 * immutable.
+			 *
+			 * Do not flush when vm_exit_reason == -1 (e.g. forced exit
+			 * on vCPU teardown or SMM entry). On teardown, KVM may run
+			 * with current->mm == NULL on a borrowed lazy TLB mm,
+			 * where writing guest memory would corrupt an unrelated
+			 * task. Nothing can observe the flush in that case anyway.
+			 */
+			nested_flush_cached_shadow_vmcs12(vcpu, vmcs12);
+		}
 	} else {
 		/*
 		 * The only expected VM-instruction error is "VM entry with

base-commit: 28924df2a08f440c73991b83028032c901de2ae4
-- 
2.55.0.979.g7e5102b832-goog

