Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB3039BFF6
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 23:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865542; cv=none; b=p0spSWhhn30Sgqga5GMCt7tMV4rm7Mg6GE8+eSF6r8zK0ZJxpUiwhtrXqQYyKCqJLyfVW84yJYBURQ/F95ZE4DX6NycGdhDLndgdqCqBZljeEKMKWDpROJg2RWF0qeIy9ey73kVJe7yoSlvPElv8Be7lFqNqnxLiHKKjbruX/d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865542; c=relaxed/simple;
	bh=+IsqoVuscZNsnrLcki7cP1m4LhzE8OZN97A1VCGIzcc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i7G78sKSEtBnnywu6GIt5lVq8aM3S3OeTtgfW2KVnE4AmJIcLyYJ7Y6oQoqOHmCkQvTd7epxgAI79O3NowTNSTEOKEZNhjF/4w919xN0mBQEOoMvBtl11GWY9AHngCQU7P3V0bI6tcPinJ6i92lNUwAGaiwMy4tVqSVnAxMN+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HyOHYhN1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HyOHYhN1"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f07078ff0so1204618b3a.1
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 16:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775865539; x=1776470339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0J9CvDIMhI4nS1IuNIFWQW/C5yF/puLDk9fVH1k+AgM=;
        b=HyOHYhN1RZKthagWXaG6bVU06/54rOGZ8+asw9lVzZcx3ZRdyJrmjpHaRSSJatX0IF
         OW+nph45XhLTFWQgF/3rAVPn+fyFYhE2NBgfLE4adZORLBMmPe3sLf78O4KXJeTqaMSt
         xMldPEXd9OnDLO/0QsrWSj6DFNpGo8eX0g18zx61F29pGK9PqJ/u+JEp3ZVlrhYADaXR
         xOi0N3ABwMe69yCN9YPQxtdCXqFtrc0kVpQfVamH399UHFDLWGfpD8BcL0n0BuIo/y+q
         AhWl4UFBtgvKvVt216PrFjkKQG6q+R6xduWEufnhaat7fA/ugnO3Nj3lMlf6MJJvJQdt
         V7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775865539; x=1776470339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0J9CvDIMhI4nS1IuNIFWQW/C5yF/puLDk9fVH1k+AgM=;
        b=P1YPv+Bg66uIw2b8cjYKgRJ6yaSDZeSqQp0XZSCwpols2hYq5WZPw1sIZ7uouf52fM
         EupcZjDvPU0fR3ubp/RSZGFFGsh7ZBfAWI8amhObJt30cJFB/R7nsadRUy5FQhITca/O
         Qip8YrDrMouJQFVwm+YVN6Eni4k+pb0FWFYsftCD+81jjZrV9GImGyFpbCFnEJqRgqMm
         fSr+y8VCc2cByK1J2mgwZOTZvdp5n2PhAf7mpu08V2kdjvz90DbHczGhZqHJ5hDdCqJi
         fmywKlc8XsrACv5smmmmukNhu220c5/3FqzNTXi5Eki8BdA5JpTjtwNs87UVk/I9tcim
         Ej5w==
X-Gm-Message-State: AOJu0YzmyWehStMtkjNluo5u8sIMTCPBm6XA0K3njV+FEHljXwXVcp74
	4NRCYNUvlypDibUnuWI6xBgWY10/8uYMm1jnLjq+OXX6tgAZO8WvnaAwpy/JlL79GSKl42C/eaD
	vthvU6A==
X-Received: from pfcg3.prod.google.com ([2002:a05:6a00:23c3:b0:829:8b7d:2b76])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14c7:b0:82c:9fe1:aa4d
 with SMTP id d2e1a72fcca58-82f0c28d49amr5470873b3a.13.1775865539095; Fri, 10
 Apr 2026 16:58:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 10 Apr 2026 16:58:30 -0700
In-Reply-To: <20260410235832.2312342-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410235832.2312342-12-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: VMXON and EFER.SVME extraction for 7.1
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Move VMXON and EFER.SVME handling out of KVM and into the core kernel so that
core TDX code can do SEAMCALLs without needing to ensure KVM is loaded.

As noted in the full "svm" PULL request, there's a superficial conflict with
the OSVW changes.

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-vmxon-7.1

for you to fetch changes up to e30aa03d032df0f3ee5efb1995a7a2fe662177be:

  x86/virt: Treat SVM as unsupported when running as an SEV+ guest (2026-04-09 12:21:53 -0700)

----------------------------------------------------------------
KVM x86 VMXON and EFER.SVME extraction for 7.1

Move _only_ VMXON+VMXOFF and EFER.SVME toggling out of KVM (versus all of VMX
and SVM enabling) out of KVM and into the core kernel so that non-KVM TDX
enabling, e.g. for trusted I/O, can make SEAMCALLs without needing to ensure
KVM is fully loaded.

TDX isn't a hypervisor, and isn't trying to be a hypervisor. Specifically, TDX
should _never_ have it's own VMCSes (that are visible to the host; the
TDX-Module has it's own VMCSes to do SEAMCALL/SEAMRET), and so there is simply
no reason to move that functionality out of KVM.

With that out of the way, dealing with VMXON/VMXOFF and EFER.SVME is a fairly
simple refcounting game.

----------------------------------------------------------------
Chao Gao (1):
      x86/virt/tdx: KVM: Consolidate TDX CPU hotplug handling

Sean Christopherson (16):
      KVM: x86: Move kvm_rebooting to x86
      KVM: VMX: Move architectural "vmcs" and "vmcs_hdr" structures to public vmx.h
      KVM: x86: Move "kvm_rebooting" to kernel as "virt_rebooting"
      KVM: VMX: Unconditionally allocate root VMCSes during boot CPU bringup
      x86/virt: Force-clear X86_FEATURE_VMX if configuring root VMCS fails
      KVM: VMX: Move core VMXON enablement to kernel
      KVM: SVM: Move core EFER.SVME enablement to kernel
      KVM: x86: Move bulk of emergency virtualizaton logic to virt subsystem
      x86/virt: Add refcounting of VMX/SVM usage to support multiple in-kernel users
      x86/virt/tdx: Drop the outdated requirement that TDX be enabled in IRQ context
      KVM: x86/tdx: Do VMXON and TDX-Module initialization during subsys init
      x86/virt/tdx: Tag a pile of functions as __init, and globals as __ro_after_init
      x86/virt/tdx: Use ida_is_empty() to detect if any TDs may be running
      KVM: Bury kvm_{en,dis}able_virtualization() in kvm_main.c once more
      KVM: TDX: Fold tdx_bringup() into tdx_hardware_setup()
      x86/virt: Treat SVM as unsupported when running as an SEV+ guest

 Documentation/arch/x86/tdx.rst              |  36 +--
 arch/x86/events/intel/pt.c                  |   1 -
 arch/x86/include/asm/kvm_host.h             |   3 +-
 arch/x86/include/asm/reboot.h               |  11 -
 arch/x86/include/asm/tdx.h                  |   4 -
 arch/x86/include/asm/virt.h                 |  26 ++
 arch/x86/include/asm/vmx.h                  |  11 +
 arch/x86/kernel/cpu/common.c                |   2 +
 arch/x86/kernel/crash.c                     |   3 +-
 arch/x86/kernel/reboot.c                    |  63 +----
 arch/x86/kernel/smp.c                       |   5 +-
 arch/x86/kvm/svm/svm.c                      |  35 +--
 arch/x86/kvm/svm/vmenter.S                  |  10 +-
 arch/x86/kvm/vmx/main.c                     |  19 +-
 arch/x86/kvm/vmx/tdx.c                      | 210 ++--------------
 arch/x86/kvm/vmx/tdx.h                      |   8 +-
 arch/x86/kvm/vmx/vmcs.h                     |  11 -
 arch/x86/kvm/vmx/vmenter.S                  |   2 +-
 arch/x86/kvm/vmx/vmx.c                      | 138 +----------
 arch/x86/kvm/x86.c                          |  29 ++-
 arch/x86/virt/Makefile                      |   2 +
 arch/x86/virt/hw.c                          | 360 ++++++++++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.c                 | 326 ++++++++++++++-----------
 arch/x86/virt/vmx/tdx/tdx.h                 |   8 -
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  10 +-
 include/linux/kvm_host.h                    |  16 +-
 virt/kvm/kvm_main.c                         |  31 ++-
 27 files changed, 720 insertions(+), 660 deletions(-)
 create mode 100644 arch/x86/include/asm/virt.h
 create mode 100644 arch/x86/virt/hw.c
