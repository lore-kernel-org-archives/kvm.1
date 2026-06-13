Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB9171AF
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309014; cv=none; b=EfBIkzi6wghw39Bjatk7jUvWOHYUPN1DnuOLW2WOjhINswbbvgGIY8tyDTckFOzzYISCLB1PGgkPVZtOdUd8rnE6p2gGB1HJWZ1HqVkG3uT2s7xxe1GGc+rRz0D3glKxwMLRj1B6KF/Akb1L192tSJcqeNcYH0Isuh8AuLuTikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309014; c=relaxed/simple;
	bh=krEZGAI4sVUtp8XlVPkpVni9/Zjp1O171b+4WJ7bHWU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nOVNBg8TRkfUP/wdOO9S+oouCm4uGxZzmlP03ry1/E4WaOjgSmHd/tZyknIFUo9Q2HbZlxv3MwaldVw3/wOCuNTgk003wO0Af1C9W6ghitZlXXMyLIMPkSTE47coJoPYNF7QvVfMOBbXllW7pdGM+JKrzeMxQwKIX/8peSZjt6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EUhaEdv9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EUhaEdv9"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423970cb30so1063771b3a.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309012; x=1781913812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuNl+V1MCPk3zpY3m1G0KMJzplIIs/9wcDgpczY7Qv8=;
        b=EUhaEdv9xIzzOu8SoA7UpWAmu958USqrHBH3O4ntkRqzF/mVYf1PxO82vXl+GphMnV
         3YCy0SJQN5VCLbBhMavH/hYe4d/WKSs1U+7iPxxVZe96CFNkUpWWW0ghEdEHR1tBY//7
         GEGjvlT21oYxf3VNQH4lOopZf8b48ps7FmR2bG0et60ZPxTkIslFd50UcDCEVSEHNiID
         Xtdm05GZgQkMe+qJi5lLQYUOwvop4cz34d0jScLLawdSXA9ZDOENBnt+WC3/Hw0KLU/W
         zkexSQ8gwdSMC8ZzmGwLwRWAwA8eSA7bPfSbGRTDmpdwrCEK6sJf99H1c5XjDAxExqfe
         WNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309012; x=1781913812;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CuNl+V1MCPk3zpY3m1G0KMJzplIIs/9wcDgpczY7Qv8=;
        b=hDqdpskAtO3Rw5ZJwHKKSGVj7v6tecDmrVzopAPl1dUyvDRtz70qEVyjLJAyKgl3uc
         zDdMmL74B//bTWQOc38RxjACbbq3dHE3EbfdjgVBym67M2CdcqukqSh68B1ipDb1ASd2
         cSZSa3Re/XgG6qnOY1hdDDpZIFxJI1N9icqXg6uY9kGED7DgchclH6P12xqqP91IFxfl
         BVXn8S54/SLU1bb1MoSeLNIUdcFLf/3vD6LALu2RY9YF7qy0lJytZWm6yVELnEeofRxr
         VbcgImOKiVCiehaYlCye0IgpUaNYX3qShK3UiX++lrr4UBpaCsO8o58kBKo1OlHrK/Iy
         bMCw==
X-Gm-Message-State: AOJu0YxNCF1bPSB6d/4Z2XAoxr2s5LmbcmB3KuwCNOotgwwHfLL6Jtys
	yFFpqPSRiGEInB9m5SL63k+EaYMXb+c004hr/F8UC+0Xyc4ZiBRu1WRHCV/aM/xZSOQfP+AqZwO
	BR8ETVA==
X-Received: from pfbbk25.prod.google.com ([2002:aa7:8319:0:b0:842:4878:6a38])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3498:b0:842:3ea1:5dd1
 with SMTP id d2e1a72fcca58-844e19663fdmr1569570b3a.14.1781309011905; Fri, 12
 Jun 2026 17:03:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:02:59 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-1-seanjc@google.com>
Subject: [PATCH v4 00/30] KVM: x86: x86.{c,h} spring cleaning
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

It's still technically spring!

Perform spring cleaning on x86.{c,h} and asm/kvm_host.h, by adding regs.c
(the kvm_cache_regs.h => regs.h is already applied) and msrs.{c,h}, and moving
relevant code out of x86.c.

v4:
 - Drop the GPR API cleanups (already applied).
 - Collect more tags. [Yosry, Kai
 - Chunked the x86.c => regs.c code movement into several patches, so that the
   bulk move is as close to a pure move as is reasonably possible. [Yosry]
 - Drop a redundant BUILD_BUG_ON() from store_regs().
 - Fix various changelog goofs. [Kai]
 - Fix alignment goofs in kvm_get_{,feature_}msr_index_list(). [Kai]
 - Drop the defunct x86.h include from mtrr.c. [Kai]
 - Fix whitespace goofs. [Kai]
 - Rewrite the changelog for the bulk regs.c move to better explain why only a
   tiny amount of EFER code is moved. [Yosry]
 - Move "struct kvm_x86_msr_filter" and "struct kvm_x86_pmu_event_filter" to
   msrs.c and pmu.c respectively. [Kai]
 - Rename LDT helpers to vmx_{load,store}_ldt(), and call out that they will
   hopefully be replaced by kernel helpers in the near future. [Kai]
 - Drop the kvm_cpu_get_apicid() code movement (sent a separate patch to kill
   it off entirely). [Kai]
 - Add more detail to explain why using VALID_MASK defines outside of x86.c is
   dangerous. [Yosry, Kai]
 - Bury kvm_arch_interrupt_allowed() in x86.c as kvm_is_interrupt_allowed(). [Kai]
 - Move kvm_find_async_pf_gfn() prototype to x86.h. [Sashiko]

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

Sean Christopherson (30):
  KVM: x86: Extract REGS and SREGS runtime sync code to helpers
  KVM: x86: Move get_segment_base() to regs.h, as kvm_get_segment_base()
  KVM: x86: Rename __{g,s}et_sregs2() =>
    kvm_x86_vcpu_ioctl_{g,s}et_sregs2()
  KVM: x86: Move the bulk of register specific code from x86.c to regs.c
  KVM: x86: Move local APIC specific helpers out of asm/kvm_host.h
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
  KVM: x86: Move MSR helper declarations from kvm_host.h => msrs.h
  KVM: x86: Move "struct kvm_x86_msr_filter" definition to msrs.c
  KVM: x86/pmu: Move "struct kvm_x86_pmu_event_filter" definition to
    pmu.c
  KVM: x86: Move MMU helper declarations from kvm_host.h => mmu.h
  KVM: x86: Move LLDT assembly wrappers into VMX
  KVM: x86: Move misc "VALID MASK" defines from kvm_host.h => x86.c
  KVM: x86: Move __kvm_irq_line_state() from kvm_host.h => ioapic.h
  KVM: x86: Move IRQ-related helper declarations from kvm_host.h =>
    irq.h
  KVM: x86: Move kvm_pv_send_ipi() declaration from kvm_host.h =>
    lapic.h
  KVM: x86: Don't treat interrupts as allowed just because a nested run
    is pending
  KVM: x86: Rework kvm_arch_interrupt_allowed() into
    kvm_is_interrupt_allowed()
  KVM: x86/mmu: Move kvm_arch_async_page_ready() below
    kvm_tdp_page_fault()
  KVM: x86/mmu: Move kvm_mmu_do_page_fault() from mmu_internal.h =>
    mmu.c
  KVM: x86: Move a pile of stuff from kvm_host.h => x86.h

 arch/x86/include/asm/kvm_host.h |  470 +---
 arch/x86/kvm/Makefile           |    4 +-
 arch/x86/kvm/cpuid.c            |    1 +
 arch/x86/kvm/fpu.h              |   26 +
 arch/x86/kvm/hyperv.h           |    3 +-
 arch/x86/kvm/ioapic.c           |    1 +
 arch/x86/kvm/ioapic.h           |   12 +
 arch/x86/kvm/irq.c              |    7 +
 arch/x86/kvm/irq.h              |    6 +
 arch/x86/kvm/lapic.h            |    8 +
 arch/x86/kvm/mmu.h              |   90 +-
 arch/x86/kvm/mmu/mmu.c          |  132 +-
 arch/x86/kvm/mmu/mmu_internal.h |   66 -
 arch/x86/kvm/msrs.c             | 2745 +++++++++++++++++++++++
 arch/x86/kvm/msrs.h             |  156 ++
 arch/x86/kvm/mtrr.c             |    2 +-
 arch/x86/kvm/pmu.c              |   12 +
 arch/x86/kvm/regs.c             |  875 ++++++++
 arch/x86/kvm/regs.h             |   60 +
 arch/x86/kvm/svm/nested.c       |    1 +
 arch/x86/kvm/svm/svm.c          |    6 +-
 arch/x86/kvm/vmx/nested.c       |    1 +
 arch/x86/kvm/vmx/vmx.c          |   23 +-
 arch/x86/kvm/x86.c              | 3709 +------------------------------
 arch/x86/kvm/x86.h              |  354 +--
 25 files changed, 4457 insertions(+), 4313 deletions(-)
 create mode 100644 arch/x86/kvm/msrs.c
 create mode 100644 arch/x86/kvm/msrs.h
 create mode 100644 arch/x86/kvm/regs.c


base-commit: c1f7303302927f9cbf4efedf70f0512cde168c65
-- 
2.54.0.1136.gdb2ca164c4-goog

