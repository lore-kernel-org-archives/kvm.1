Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D3B374E76
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093365; cv=none; b=mf0gmwkgXG3Z0uqJ9U5ojUtqoRiobegoywU9R/nc39CmVX2d8NwcwjwxavArlgZN91jHWEsDEIudlqjGvIM6jJdtwpp2sU3yL+oybz1qorAzJrhB1lB0SBBLX0e2oBmbhXU9JuYxCrXQiXUSjNgTbJtd11fx/MC2WJ5tKy3Z2UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093365; c=relaxed/simple;
	bh=NX15UUL1ozd5ILFjbk8HKK1VbTSktUhpR9wCXkNjTBo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dXojpM5b7YG6IBtC0AwEAcnFBJum32Q6g2YPBxIvEBrDV64T2bKBrwEmlIUP3o+LiUSmaO3JqoXDuzIs79k31JBtI4b/VB79ikegJlmeV6NZUwHSv877v67t4Jzs6HEIYbQM/KLV+wsvdxq4kj1AQ8/L4PGihxWkEIZF7eDyAMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vhRVnBvE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhRVnBvE"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf1845bddfso16184665ad.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093363; x=1780698163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUo+M7WmjJ/6E8Ej5iToUwzNEsl6aARyl84OWfX4T2o=;
        b=vhRVnBvE7SWXfiCknwKgTSrRq94BhHCu/D+euZ5aVmPZ716e2F84wkpAYeBG3LSjG9
         A9RxCAbwInQvqQuTmDDeN2dDFequLTXc0iFN0wfbEnJFfeesfegs5b6hf8bWM4aBNqre
         GenCU8HK+7gbiC23IX6ij6DcOcelT3HBAbOUXaqDvITjsOiOFUro0/bZr+LBHOGhRhSa
         wzJexI0tQlOkfeAA58iVP9RRwLr5PAemHtuMJEushY5D5RmZnRkZzTr4v9dLloWahpCF
         vHhHn4uLw5Bn8l6r656bDl6S67mJ29En9dPL1zWMv6+/xUi2UzHhBx6ZVdsVOVCd6o5b
         12OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093363; x=1780698163;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUo+M7WmjJ/6E8Ej5iToUwzNEsl6aARyl84OWfX4T2o=;
        b=C2T0BTeOmjx7toVzj8hY/MfUaSC51sgDyVceK6rp9TtKR+/wYNg9T2HLvxg+EAjtGP
         r88Ih3dixye8a6fs5lL0R9uKyWrKK3bSupgfFrVk3HZKvoeQ5mnBaS7WdV7ezhRA9vNd
         oFbbwUwbM5l22iVw7nppqLDBdQGlN2YSGKXr3HRP5RYnlVgJTi/H5iqnlTX5KFz0/fX7
         L2YD7pP1dTbVoTqr6vjLB1DGJrbyTslUXRrzDoDXmlnOKcWoB+4DUzsj7WjNIlOMEgC/
         GuIVzl0alFVQL2IO5GmTzCTk7f8aaHTBmxBBsFbqlJvUXgzETwrC64iydsIng3eFebPZ
         9vjQ==
X-Gm-Message-State: AOJu0YxOe7w7aYCtGcMz1QptUYjJwwh7rwRRZRinvLVlbZJFlH6aofTM
	pjlu/9qaMa6ipgyiAeMx56MPL71O7d6zPdSZ83BWHSpu2HgcwgUZN9RoxhgDgiVXaokTCqoVqs9
	NlVh5DQ==
X-Received: from plte4.prod.google.com ([2002:a17:902:7444:b0:2bf:693:47b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1508:b0:2bd:bd27:e234
 with SMTP id d9443c01a7336-2bf368339afmr18882835ad.21.1780093362647; Fri, 29
 May 2026 15:22:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:21:43 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-1-seanjc@google.com>
Subject: [PATCH v3 00/40] KVM: x86: GPR accessors and x86.{c,h} spring cleaning
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

The first half of this series adds proper, explicit "raw" versions of
kvm_<reg>_{read,write}(), along with "e" versions (for hardcoded 32-bit
accesses), and converts the existing kvm_<reg>_{read,write}() APIs into
mode-aware variants.

At the end of that journey, introduce regs.{c,h} to avoid moving _more_ code
into x86.h, especially since the resulting code split would be super arbitrary.

The second half of the series runs with the regs.{c,h} changes and performs
spring cleaning on x86.{c,h} and asm/kvm_host.h (in case it wasn't already
obvious, I have poor impulse control when it comes to cleaning up code).

I'm most intersted in getting feedback on the file names (regs.{c,h} and
msrs.{c,h}.  I'm quite confident the actual code split is the way to go, and
pulling stuff out of asm/kvm_host.h has been on my wish/todo list for years.

I'll grab these fixes for 7.2 no matter what:

  KVM: x86: Trace hypercall register *after* truncating values for 32-bit
  KVM: VMX: Read 32-bit GPR values for ENCLS instructions outside of 64-bit mode
  KVM: x86/xen: Don't truncate RAX when handling hypercall from protected guest
  KVM: x86/xen: Bug the VM if 32-bit KVM observes a 64-bit mode hypercall

Depending on how people feel about the names and cleanups, I'll either send
the big cleanups as a separate pull request after the initial for-7.2 pull
requests (if there's overwhelming consensus on the names/splits), or wait for
7.3 (if more discussion is needed).

v3:
 - Collect more tags. [David, Binbin, Yosry]
 - Use kvm_run_sync_regs_{from,to}_user() instead of kvm_run_{g,s}et_regs().
   [Kai]
 - Fix a variety of typos. [Binbin]
 - Everything beyond patch 15...

v2:
 - https://lore.kernel.org/all/20260514215355.1648463-2-seanjc@google.com
 - Collect tags. [Yosry, Kai]
 - Fix some truly egregious goofs. [Binbin]
 - Rename kvm_cache_regs.h => regs.h, add regs.c. [Yosry, because he
   complained, not because he actually suggested this :-D ]
 - Drop superfluous casting/masking of e*x() usage. [Kai]

v1: https://lore.kernel.org/all/20260409235622.2052730-1-seanjc@google.com

Sean Christopherson (40):
  KVM: SVM: Truncate INVLPGA address in compatibility mode
  KVM: x86/xen: Bug the VM if 32-bit KVM observes a 64-bit mode
    hypercall
  KVM: x86/xen: Don't truncate RAX when handling hypercall from
    protected guest
  KVM: VMX: Read 32-bit GPR values for ENCLS instructions outside of
    64-bit mode
  KVM: x86: Trace hypercall register *after* truncating values for
    32-bit
  KVM: x86: Rename kvm_cache_regs.h => regs.h
  KVM: x86: Move inlined GPR, CR, and DR helpers from x86.h to regs.h
  KVM: x86: Add mode-aware versions of kvm_<reg>_{read,write}() helpers
  KVM: x86: Drop non-raw kvm_<reg>_write() helpers
  KVM: nSVM: Use kvm_rax_read() now that it's mode-aware
  Revert "KVM: VMX: Read 32-bit GPR values for ENCLS instructions
    outside of 64-bit mode"
  KVM: x86: Harden is_64_bit_hypercall() against bugs on 32-bit kernels
  KVM: x86: Move update_cr8_intercept() to lapic.c
  KVM: x86: Move async #PF helpers to x86.h (as inlines)
  KVM: x86: Move the bulk of register specific code from x86.c to regs.c
  KVM: x86: Move local APIC specific helpers out of asm/kvm_host.h
  KVM: x86: Drop defunct vcpu_tsc_khz() declaration
  KVM: x86: Move kvm_caps and kvm_host_values to asm/kvm_host.h
  KVM: x86: Swap the include order between x86.h and mmu.h
  KVM: x86: Move tdp_enabled from kvm_host.h to mmu.h
  KVM: x86: Move eager_page_split to mmu.{c,h}
  KVM: x86/hyperv: Eliminate an unnecessary include of x86.h in hyperv.h
  KVM: x86: Move kvm_{load,put}_guest_fpu() to fpu.h
  KVM: x86: Extract get/set MSR (list) ioctl logic to helpers
  KVM: x86: Expose several TSC helpers via x86.h for use by MSR code
  KVM: x86: Move the bulk of MSR specific code from x86.c to msrs.{c,h}
  KVM: x86: Move register helper declarations from kvm_host.h => regs.h
  KVM: x86: Move kvm_{g,s}et_segment() to inline helpers in regs.h
  KVM: x86: Remove defunct kvm_load_segment_descriptor() declaration.
  KVM: x86: Move MSR helper declarations from kvm_host.h => msrs.h
  KVM: x86: Move MMU helper declarations from kvm_host.h => mmu.h
  KVM: x86: Move LLDT assembly wrappers into VMX
  KVM: x86: Move kvm_cpu_get_apicid() from kvm_host.h => avic.c
  KVM: x86: Move misc "VALID MASK" defines from kvm_host.h => x86.c
  KVM: x86: Move __kvm_irq_line_state() from kvm_host.h => ioapic.h
  KVM: x86: Move IRQ-related helper declarations from kvm_host.h =>
    irq.h
  KVM: x86: Move kvm_pv_send_ipi() declaration from kvm_host.h =>
    lapic.h
  KVM: x86/mmu: Move kvm_arch_async_page_ready() below
    kvm_tdp_page_fault()
  KVM: x86/mmu: Move kvm_mmu_do_page_fault() from mmu_internal.h =>
    mmu.c
  KVM: x86: Move a pile of stuff from kvm_host.h => x86.h

 arch/x86/include/asm/kvm_host.h           |  452 +--
 arch/x86/kvm/Makefile                     |    4 +-
 arch/x86/kvm/cpuid.c                      |   13 +-
 arch/x86/kvm/emulate.c                    |    2 +-
 arch/x86/kvm/fpu.h                        |   26 +
 arch/x86/kvm/hyperv.c                     |   21 +-
 arch/x86/kvm/hyperv.h                     |    7 +-
 arch/x86/kvm/ioapic.c                     |    1 +
 arch/x86/kvm/ioapic.h                     |   12 +
 arch/x86/kvm/irq.c                        |    7 +
 arch/x86/kvm/irq.h                        |    6 +
 arch/x86/kvm/lapic.c                      |   28 +-
 arch/x86/kvm/lapic.h                      |    9 +
 arch/x86/kvm/mmu.h                        |   92 +-
 arch/x86/kvm/mmu/mmu.c                    |  134 +-
 arch/x86/kvm/mmu/mmu_internal.h           |   66 -
 arch/x86/kvm/msrs.c                       | 2732 +++++++++++++++
 arch/x86/kvm/msrs.h                       |  156 +
 arch/x86/kvm/mtrr.c                       |    1 +
 arch/x86/kvm/regs.c                       |  875 +++++
 arch/x86/kvm/{kvm_cache_regs.h => regs.h} |  258 +-
 arch/x86/kvm/smm.c                        |    2 +-
 arch/x86/kvm/svm/avic.c                   |    5 +
 arch/x86/kvm/svm/nested.c                 |    9 +-
 arch/x86/kvm/svm/svm.c                    |   19 +-
 arch/x86/kvm/svm/svm.h                    |    2 +-
 arch/x86/kvm/vmx/nested.c                 |    9 +-
 arch/x86/kvm/vmx/nested.h                 |    2 +-
 arch/x86/kvm/vmx/sgx.c                    |    6 +-
 arch/x86/kvm/vmx/tdx.c                    |   18 +-
 arch/x86/kvm/vmx/vmx.c                    |   14 +-
 arch/x86/kvm/vmx/vmx.h                    |    2 +-
 arch/x86/kvm/x86.c                        | 3789 +--------------------
 arch/x86/kvm/x86.h                        |  480 ++-
 arch/x86/kvm/xen.c                        |   39 +-
 35 files changed, 4722 insertions(+), 4576 deletions(-)
 create mode 100644 arch/x86/kvm/msrs.c
 create mode 100644 arch/x86/kvm/msrs.h
 create mode 100644 arch/x86/kvm/regs.c
 rename arch/x86/kvm/{kvm_cache_regs.h => regs.h} (50%)


base-commit: d1568b1332b6b3b36b222c2868fc102727c12a34
-- 
2.54.0.823.g6e5bcc1fc9-goog

