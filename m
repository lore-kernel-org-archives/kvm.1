Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395276;
	b=u4imACQzyQvUA/LQUm5+AZJAQgoiJ6POM2nxUXvAn56O98zMFq0MZ5Q4YY4CjKVDaCcq
	 qvCVsFwwuLIbhaX8rd9HG2S4aPqYq4Bqger9lJpYY0VueHMEgx/zEw7cNyBlKT6cd2D6f
	 4SFbMrWuK0xavuPicuNE+cqq0Da5u609jkXfINIMZCc43V297XtEKGD/6/nuqGimW4MpG
	 NDSPxE1PlEHfHv4gb3zvpywghg7buS1eDqGH69uLEu1GRBkuh/KYmOvnT1jtWIw/Bdskd
	 8woIJFt7PTG1Dlc+HcrTZWx8ct4LF9wYKh3ZBvozqHw7L4iQ89TQblKgOd+zVueBVEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=GVfrMv/JwLPpbAn4FrjFqU3DE6u8ipaxUY48dYc7+h0=;
	b=FEArOfECuuPVAQK5Xj2NMtEQqgwUalDhOqJw7kvef8kdNGZEb9HAimPrMUJaQPjV2io4
	 1mU4OKppuPD5ylXXC++KwJ3WTqX4B14E2U562CiIjAUu+udPnhFC6S8PkDqIcKYXIJOmj
	 jJ0yIxhI8tEKnTn0wBY1SVJ5RXt+YhgbG+fAxkFvoxCDS23yf1CpJYUmoEmPXE0CnV5mK
	 CqyvHUHyl/zxZflua0wr/XIzYtFLfSMNPHR+8mKVxaP20MaS3M60p4azAUBaVUM/PIx5O
	 yY0o7JDrIAaBuB77nLy3dj7xgrsAlhY9k5UcD6T5sYBb5aodx4M8+lwQQckPvRXS8iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Tuh4TM7o;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D6C606B79A
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87D6C606B79A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Tuh4TM7o
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e9d52f684fso11707725ad.2
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395276; x=1794000076; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GVfrMv/JwLPpbAn4FrjFqU3DE6u8ipaxUY48dYc7+h0=;
        b=Tuh4TM7oSQ5uc31/tj0In4W/mmQosgiHfmEnO8V5wmXtc43tZ4JxyAJCEDxd4DmrW7
         9CJaCj8qIlrQw239S+bTeNURo+78+tkkts807CDGXazpAbLSvWz6iQyFBCzScAkbqtnx
         jZCFyAoE+ygfuDiq+NAraXnkIDK8CMq+R+4PIHPTgtj79y+oge7GQtJOyqMmHFHp/lQ5
         bgrWK6cyz8NgnVb1/PygMhQIEex4LuU/YQHGVuxnErULyltbYuc96ajn8Blzd609IRYO
         lmQuX8pZxFu/CzJnLLckZs5O142gvdHQLJiQn0YelFSOgREnxgHvWiEaVkniMgNevuoG
         Ja5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395276; x=1794000076;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GVfrMv/JwLPpbAn4FrjFqU3DE6u8ipaxUY48dYc7+h0=;
        b=hjRzkfE25KLV8OXteeYhGhrK4VtYWx0lZ/P0QE9jJ+JONtNZ6dd+9fQB0jH0SDnqgU
         F4DKbhsQuCkKq4sEY9/0n+2RPWNb7ZSK/O/uWZHPh6OCkPd8ZR0Q9/9qhp8SE1Cfw5OJ
         XXTKhlSv38ubpT3Ds6hOkann9lzAAbX+ra+eDeEoUpU63gmhkvvm7mhYkP6fMVX8cRFO
         KmIvulZxTrbi7zs7uRWpKxf1EINZdA+2KZZzMYdTJx/tgzDmMOVhjZPA7UXcoOfI56lF
         jc6nSO9DW/CLOCD0jk7lrGkSZOczXcJydDlfSDdslDJUQtYztHgsurHut991vRjXW3Pf
         MF1Q==
X-Forwarded-Encrypted: i=1; AKwUvByN0XeqN7Ri972TsAdkMR4ZNU8DYDHk9PdISy6Xm7YVa3D+9B1B5YBnkOOHCPX3GGfY54s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7ZUH9uXxOiga7HSETIaPqHNJ6bJWb8NbydtDqa1QYklu5Tycg
	qsCWKEQrbx5ZNEumyMkr/rKiMlUtbheCoLG+YVfYGmS1NWDUhJYRTcwujm1JbF1sUW6sYS4l8oZ
	wUVWN9A==
X-Received: from plbme3.prod.google.com ([2002:a17:902:fc43:b0:2ea:884b:e7df])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec4:b0:2e9:851a:7188
 with SMTP id d9443c01a7336-2eb3649c631mr36367485ad.23.1793395275725; Fri, 30
 Oct 2026 14:21:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:50 -0700
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-3-seanjc@google.com>
Subject: [PATCH v4 02/23] KVM: nVMX: Don't force a full nested VM-Exit when
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
2.56.0.385.gac671c819a-goog

