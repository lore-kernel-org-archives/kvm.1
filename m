Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139135;
	b=ZKAlQeMul1FshgTwe6DNUyO8fZvWAHTwSCjlIHRUyEcyVpkmceS15xt64VLiitoXpqef
	 gfeg7OfA+tg5kTD1DrKDUiLyb2T+Fx/3pTCZqPxjIj3m1mNJ8GYz4OQy7vZwpS1a7mgtB
	 quermigtYIMboQCR/MMC7N++mkBCP9AjbkImW5LOTC2Xis3SoY29Wxlm8CowbBmXWaHai
	 QlcY2o2Tjz+ezD0GSwoRrY5xvaxQlByXh9ni4GGGkA7R/X7KhuyrpN4X0wao8PpVmnTa5
	 BHLS4XvsTjthlCunGiMDknypmY7l9WirFDwnRlhyMRsB3qoskNgz5p0xGSWfuwFcwCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=4+wo0Hnq368mIoBgSKtnd7+wHbHIcDQRZtxGt/eUG9s=;
	b=Tfr1il0oxvY0Y1um/ZX1rM3QgD79UK896tZUFS7i7idXqPnvpTOEFIXErFxKTETF25Kp
	 jOjvunQrZLqXTFwdPEJT2eidR8NZQV+uUkQ8hx9SbSoIA2LXTaO7XZSm2S79TDZa57+zS
	 HytlLQ8hWlZsKkM56kYn/vrbEypUFYn7NUA25Yccc7uMmvChfFQ6fhISWtJdaZiGzuSzX
	 NWVeINu94WWyRTgjrMBPU6wXUbMtx8CYdNcyi1kbAjUrmMR0ukJw5CvyX04IUP/smY1op
	 2P/ZfUvnmtT6VLkCBe1XsCVzmuiZvJeg+mJZN655DicXDkCC1AJDpQy4TzevW2F11qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J2SuGckM;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DF2606A32D
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0DF2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J2SuGckM
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e9572e892dso2012365ad.1
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139134; x=1793743934; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4+wo0Hnq368mIoBgSKtnd7+wHbHIcDQRZtxGt/eUG9s=;
        b=J2SuGckMEea6+N7uGSEKo7pSzH3SEPkJfVgT/TxTooWozy6PkCcqJ40AV8sPipP7lI
         WOO1ylny7xZWxEtWgh8xhHbO+fvCdHLsmTj/A5+aJisxnUklHEuxqRQrbTlgutbXOt6N
         pPAbj0+XoLo9DrhQTcPvQHGdA/F4AKc5E3W2akZHCpm+/xBwW2H2081QpRbSgRSk5q5J
         aBicYmk+XpN3YhK89kypo5t8RyaIVPIPeHbb8eC+axo9JpY/mrcks0u6KRoBWAEgqwXR
         uk70HunxhpzV9315Xulpbf6yspq4FJndswmETStyMa4vCMOn1rjVE4X6VlCPUNr+MarZ
         LuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139134; x=1793743934;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4+wo0Hnq368mIoBgSKtnd7+wHbHIcDQRZtxGt/eUG9s=;
        b=0w9EnB+e0NDfGl3FjXiI7a3uaIc2TaJYl4XZsCTY91CUZoCbFGU3omAgeNKxtnA7mL
         QwVnhC9wiBLu2VeLgsbjtTzlJ6/ijuv3Y0klL7/frMX7Q3dChls5uId9Lw755oN0GZ4j
         noBg6RT6V8seXK4Vul7xYSetNr0Li87XTQgHhoke3FIJ1Bgbi1CyHffkvhNU8RSYUI46
         10fHMzY00raMyyvOJos7eLQyzeGuaeMagD7DNO9FHQz1EGZt3BDSXfa+YHW7lFoGsC8p
         R4zsL6zzP9mY/evsSrtix45mYpgTNSoY/PhbqcgU2TeSGoI5HwWIkIl5EddPE1KqObyb
         FjTA==
X-Forwarded-Encrypted: i=1; AKwUvByIyyipFSYZxXigk/0FeB3fYiUXsnSqzPXmvOS+bvSg7rU/70Xltqaa1Ao4AzVLB3Z07Zo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6mgq5z/ynICilOU31RvmxcCbl5AF0Nto3+0CjaCdBMrPLVX3B
	LxAfZ98x5h6Gqqz6MbQ4YFmAMoHm04yHu1PvYSrW1AnmlQDCQRUd7FzaKEQfs9UxBb4KHH+BoHr
	+/1FJlw==
X-Received: from pjzj16.prod.google.com ([2002:a17:90a:eb10:b0:3aa:dfda:ecdb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:582e:b0:398:e96a:8999
 with SMTP id 98e67ed59e1d1-3ae57f637c3mr292276a91.16.1793139133835; Tue, 27
 Oct 2026 15:12:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:11:55 -0700
In-Reply-To: <20261027221209.1560865-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027221209.1560865-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027221209.1560865-3-seanjc@google.com>
Subject: [PATCH v3 02/15] KVM: nVMX: Don't force a full nested VM-Exit when
 destroying a vCPU
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

For all intents and purposes, revert commit b4b65b5642d6 ("KVM: x86: cleanup
freeing of nested state") and go back to manually tearing down nested state
when freeing a vCPU.

When a vCPU is destroyed while L2 is active, KVM synthesizes a nested
VM-Exit, which flushes the cached shadow VMCS12 back to guest memory:

  vmx_vcpu_free()
  |-> nested_vmx_free_vcpu()
      |-> vmx_leave_nested()
          |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
              |-> nested_flush_cached_shadow_vmcs12()
                  |-> kvm_write_guest_cached()
                      |-> __copy_to_user(ghc->hva, ...)

Accessing user memory via a memslot during VM destruction is broken, as
there are no guarantees that current->mm == kvm->mm when the VM is dying,
because the last reference to the VM can be put from a different process
than the original creating processes.

And even if the original process does put the final reference, during
process exit, do_exit() calls exit_mm() before closing file descriptors, so
vCPU destruction runs with current->mm == NULL on a borrowed lazy TLB
active_mm.  If the borrowed address space has a writable mapping at the
to-be-written userspace address, KVM will corrupt an unrelated task's
memory since uaccess APIs, including __copy_to_user(), don't sanity check
current->mm (and *can't* sanity perform KVM's current->mm == kvm->mm check
since that is firmly a KVM-only concept).

Furthermore, the shadow VMCS flaw is only the tip of the iceberg, as the
MSR load/store lists mean that emulating a nested VM-Exit can read or write
an arbitrary set of MSRs, e.g. if MSR_KVM_SYSTEM_TIME_NEW is in L1's MSR
load list:

      kvm_arch_vcpu_destroy()
        kvmclock_reset() - takes pv_time off kvm->gpc_list
        vmx_vcpu_free()
          nested_vmx_free_vcpu()
            vmx_leave_nested()
              nested_vmx_vmexit()
                __nested_vmx_vmexit()
                  load_vmcs12_host_state()
                    nested_vmx_load_msr() - writes the MSRs that L1 listed
                  kvm_cpu_has_injectable_intr() - reads Xen's vcpu_info
        kvm_xen_destroy_vcpu() - deactivates the vcpu_info cache

processing the MSR write puts the "pv_time" cache back on kvm->gpc_list,
and the next list_del() writes into the freed vCPU.  And as effectively
pointed out by syzbot[*], attempting to fix each case individually is a
losing game of whack-a-mole.

Deliberately leave "nested_run_pending" as-is, because even though doing so
creates potentitally inconsistent state, KVM should *never* consume said
state while freeing a vCPU.  I.e. if leaving nested_run_pending set trips a
sanity check or bug, then that just means there's more fixing to be done.

Open code only the "free vCPU" path, i.e. keep emulating a nested VM-Exit
when forcing a vCPU out of L2 via vmx_leave_nested(), as there are a number
of updates buried in the nested VM-Exit flow that are needed if the vCPU is
going to run in L1, e.g. clearing pending exceptions and MTF traps, setting
the TSC offset+scale information back to L1, and so on and so forth.  Note,
this means svm_leave_nested() is all but guaranteed to be buggy, but that's
basically an open secret at this point and at least any bugs "only" break
L1, i.e. don't corrupt host state as is the case for abusing nested VM-Exit
when freeing a vCPU.

Link: https://lore.kernel.org/all/6ac0145f.34119e79.2f92f3.0003.GAE@google.com [*]
Fixes: b4b65b5642d6 ("KVM: x86: cleanup freeing of nested state")
Cc: stable@vger.kernel.org
Co-developed-by: Chris Mason <mason@kernel.org>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f854c..49c4529901c5 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -385,8 +385,15 @@ static void free_nested(struct kvm_vcpu *vcpu)
  */
 void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
 	vcpu_load(vcpu);
-	vmx_leave_nested(vcpu);
+	if (is_guest_mode(vcpu)) {
+		hrtimer_cancel(&vmx->nested.preemption_timer);
+		leave_guest_mode(vcpu);
+		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
+	}
+	free_nested(vcpu);
 	vcpu_put(vcpu);
 }
 
-- 
2.56.0.307.g5fe7bd680c-goog

