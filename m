Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7E3ACF0F
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 04:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125881; cv=none; b=LI+4FiI0yR9sS+vGEiBV4jfKai2nkobz71vskiTLqoPa++jlRwy05kUXC8Imt4Xv+ZqSUdnpXUTtsq2HkRFEfqHX7Kur8PDpjXdrbN3S3ATqJHWN9qpMG30iePnIqXrtjgt58XtRlpUeSpt05VT29DdmhN0p/lWjkuzC2E4C/gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125881; c=relaxed/simple;
	bh=N/zyKDBYbTaROjGUjJQJpLjsJPGVUbqTygxcndr0gY8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TgRywSR8XOFQMJd0F6JRPw9AYu+3UscLKItOE1ScdlEqmwYB3mq71YKpoY0OCbpLJQ1ZOL5b4lblTEr9aqpINAvRgnfLdpNZzit1XX/a10KBnIiUhLftrEmq03DXsJBZpZT42r9ut5JJx8kS7ql3wQJjI1ChJVkUdyiX9USz9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L5V6fMQY; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L5V6fMQY"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3acd21ba24eso313013a91.3
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 21:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792125868; x=1792730668; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J6ua4ceef+z9qkFg9iIdQaLd9iwdp4d4+GrnHT0R7wU=;
        b=L5V6fMQYyjKLX8npwwck6RbD4UtzfievgA1p1DLmObmWyZSbFL2ZoRXp7PBewOHYqB
         Iy7F7nU25VYpKFMzlqQTrnAqLy7H8eR2Y/fhxf1mOciZghtP45Taze7N1rSAtkWVAlBV
         E36galItfeMSaJ3yuHD27+Y8ZpqDE5oZcUutMCupOJi6qiV9PtVXeMKNOkdyKyO6iZTo
         pVbX4xUKRcXZ/puSKYn/74Gs+fV9I1w3Vv/NOzGL6qVD0lLAVGkmJ51geH4cjmisqiMw
         d9QknGh7kDpglDPXI/bWgfUUMj2MA5pOiBd0Kp+hg1jDJKx+F09nvp96/PzsJE8vyZmb
         vRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125868; x=1792730668;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J6ua4ceef+z9qkFg9iIdQaLd9iwdp4d4+GrnHT0R7wU=;
        b=1Iy+8fM/mxF+LhBWigLPcYvwA1lZBkDNbTe68f/4iFavOfC6FYYxHRd3HiSSvZeSnl
         MTEd//LYuOG6SLSDROuaXWKoC6I8xf0/pIYjeqI+0tv1BP4++++pAbkb/gm0dWK0EemT
         aSMkWvx5BQ55WqSiaAdbP6L7m0IAkejNPe8kzPOgV7j4CtcCpbftNjTisiEEBoLd3tgw
         tsDzB1xsaqqGJ8+L8xakpC3jyDZlbGh8dca7Dt9UjXF/9ILlr9NQ4tslldYt1PUKcZY6
         FbV/noQSjN0dKFqQSktvEtbZ92fVtlN2+xsEUJe+u2vLkzjQ9YHJ6Y7hHeYBL1SROpnP
         KxqA==
X-Gm-Message-State: AFq9FYLZBT2EVfYmuE/cfElyPWbJ0LdH7LVWnFX5PsuNcpgQ0uuFv/Op
	PSeFhKCDV+mgsXipUI2dt7kQDjfjH7YvoUoogNeS+Hsh6ecQQqIMkyzdn76X1RaXt0QVLK9vXCW
	JIkbk2A==
X-Received: from pjbil8.prod.google.com ([2002:a17:90b:1648:b0:3a8:28d0:2510])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b:b0:3ab:2c2b:1030
 with SMTP id 98e67ed59e1d1-3ab3a747cfcmr16877204a91.22.1792125867131; Thu, 15
 Oct 2026 21:44:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 15 Oct 2026 21:44:13 -0700
In-Reply-To: <20261016044415.958618-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261016044415.958618-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261016044415.958618-9-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: VMX+TDX changes for 7.4
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Tag says "vmx", but this is almost entirely TDX focused.

The INIT_MEM_REGION fixes will conflict with the "coco" branch due to in-place
conversion allowing a null/0 source address:

diff --cc arch/x86/kvm/vmx/tdx.c
index b816331fcc98,2a3acf493cb5..ee1d412b0ee6
--- arch/x86/kvm/vmx/tdx.c
+++ arch/x86/kvm/vmx/tdx.c
@@@ -3233,12 -3274,14 +3272,15 @@@ static int tdx_vcpu_init_mem_region(str
        if (copy_from_user(&region, u64_to_user_ptr(cmd->data), sizeof(region)))
                return -EFAULT;
  
 -      if (!PAGE_ALIGNED(region.source_addr) || !region.source_addr ||
 +      if (!PAGE_ALIGNED(region.source_addr) ||
 +          (!gmem_in_place_conversion && !region.source_addr) ||
-           !PAGE_ALIGNED(region.gpa) || !region.nr_pages ||
-           region.gpa + (region.nr_pages << PAGE_SHIFT) <= region.gpa ||
+           !PAGE_ALIGNED(region.gpa) || !region.nr_pages)
+               return -EINVAL;
+ 
+       if (check_shl_overflow(region.nr_pages, PAGE_SHIFT, &nr_bytes) ||
+           check_add_overflow(region.gpa, nr_bytes - 1, &end_gpa) ||
            !vt_is_tdx_private_gpa(kvm, region.gpa) ||
-           !vt_is_tdx_private_gpa(kvm, region.gpa + (region.nr_pages << PAGE_SHIFT) - 1))
+           !vt_is_tdx_private_gpa(kvm, end_gpa))
                return -EINVAL;
  
        ret = 0;

The vmx=>vt renames will conflict with the "misc" branch because of a collision
with the change to track kvm_vcpu_arch.pending_ioapic_eoi as a u8 (four lines
of code in a function that's been touched _once_ since it was added in 2013,
and somehow I manage to create a conflict in a single release cycle, *sigh*).

diff --cc arch/x86/kvm/vmx/vmx.c
index 686e586f3290,cf32aee0aab7..b341af4c6057
--- arch/x86/kvm/vmx/vmx.c
+++ arch/x86/kvm/vmx/vmx.c
@@@ -5898,10 -5881,11 +5892,10 @@@ static int handle_apic_access(struct kv
  
  static int handle_apic_eoi_induced(struct kvm_vcpu *vcpu)
  {
-       unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
+       unsigned long exit_qualification = vt_get_exit_qual(vcpu);
 -      int vector = exit_qualification & 0xff;
  
        /* EOI-induced VM exit is trap-like and thus no need to adjust IP */
 -      kvm_apic_set_eoi_accelerated(vcpu, vector);
 +      kvm_apic_set_eoi_accelerated(vcpu, exit_qualification & 0xff);
        return 1;
  }
  
The following changes since commit d4b7fb647204f0c81dfeae2d1a708e4d858e0c94:

  Merge branch 'kvm-xen-longmode' into HEAD (2026-09-04 17:35:03 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-vmx-7.4

for you to fetch changes up to 883719f57f5d3898637b130d6db4742471cad618:

  KVM: x86: Clear hardware HLT state when userspace makes a vCPU not-halted (2026-09-28 16:20:35 -0700)

----------------------------------------------------------------
KVM VMX changes for 7.4

 - Enable Notify VM-Exits (now called Instruction Timeout in the SDM) and Bus
   Lock VM-Exits for TDX guests when they're enabled by userspace (KVM forgot
   to wire up the TDX Module knobs).

 - Move all common (between VMX and TDX) APIs/helpers to common.h/main.c, and
   change all namespace prefixes from "vmx" to "vt".

 - Fix a thankfully benign bug (due to other areas of KVM being hardened) where
   usersepace can bypass INIT_MEM_REGION's address wrap check by providing a
   nr_pages that will overflow a u64 when converted to bytes, and fix an also-
   benign off-by-one bug in the check (inclusive vs. exclusive).

 - Set the vmcs.GUEST_ACTIVITY_STATE back to ACTIVE when userspace sets KVM's
   mp_state to anything other than HALTED, e.g. so that a vCPU doesn't get
   stuck in HLT if userspace emulates RESET.

----------------------------------------------------------------
Haotian Jiang (1):
      KVM: TDX: Reject INIT_MEM_REGION if number of bytes would overflow a u64

Keqiang Duan (1):
      KVM: x86: Clear hardware HLT state when userspace makes a vCPU not-halted

Nikolay Borisov (1):
      KVM: TDX: Remove always true ifdef

Sean Christopherson (11):
      KVM: VMX: Formally define KVM's "0xdead" exit reason used for failed VM-Enter
      KVM: VMX: Disallow using to_vmx() in common VT code
      KVM: VMX: Move the shared "IRQs off" exit handler(s) to common code
      KVM: VMX: Move the shared NMI handler/trampoline to common code
      KVM: VMX: Rename posted interrupt prefixes from "vmx" to "vt"
      KVM: VMX: Rename EPT violation handler prefix from "vmx" to "vt"
      KVM: VMX: Use dummy pseudo-overlay struct for to_vt() and vt_to_vcpu()
      KVM: VMX: Move common VT getters/converters to common.h
      KVM: VMX: Rename common exit info getters prefixes from "vmx" to "vt"
      KVM: VMX: Move bus lock handler from main.c => common.h
      KVM: TDX: Fix a benign off-by-one bug on the end GPA for INIT_MEM_REGION

Xiaoyao Li (9):
      KVM: TDX: Enable Notify VM exit
      KVM: TDX: Check if there is valid exit infos based on vp_enter_ret
      KVM: TDX: Set bits 31:16 to 0 and use UNDEFINED when synthesizing exit reason
      KVM: TDX: Don't assume exit_reason[31:16] is all-0 in tdx_to_vmx_exit_reason()
      KVM: TDX: Stuff exit_reason with UNDEFINED on wait_for_sept_zap return
      KVM: VMX: Preserve negative return value in vmx_handle_exit() with bus lock detected
      KVM: VMX: Make handle_bus_lock_vmexit() a shared helper
      KVM: TDX: Enable Bus Lock VM exit
      KVM: VMX: Consolidate the exit handler for VMX and TDX

 arch/x86/include/asm/kvm-x86-ops.h |   1 +
 arch/x86/include/asm/kvm_host.h    |   7 ++
 arch/x86/include/asm/vmx.h         |   8 ++
 arch/x86/kvm/vmx/common.h          |  90 +++++++++++++++-
 arch/x86/kvm/vmx/main.c            | 145 +++++++++++++++++++++++---
 arch/x86/kvm/vmx/nested.c          |  36 +++----
 arch/x86/kvm/vmx/posted_intr.c     |  24 +++--
 arch/x86/kvm/vmx/posted_intr.h     |   8 +-
 arch/x86/kvm/vmx/tdx.c             | 112 +++++++++++++-------
 arch/x86/kvm/vmx/vmx.c             | 205 ++++++++-----------------------------
 arch/x86/kvm/vmx/vmx.h             |  37 -------
 arch/x86/kvm/vmx/x86_ops.h         |   2 +-
 arch/x86/kvm/x86.c                 |  13 +++
 13 files changed, 397 insertions(+), 291 deletions(-)
