Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A67930EF89
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 00:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225285; cv=none; b=nOAdeIEXWhqXuHGjORcc4mb2Ipsas/TbbtGOhvv71/hZwK1IIZ6Qmvsl9IR6QGopAoDk8+KBiejfwN7JtlkF47DiyxzlxbUD8HvUK+Av7di9g6Mn7Z3G6s+VBMbDfYRLCeVATjxgaNGTvqkKthZbgjW5PtdWBt3mg3WpHAoHjIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225285; c=relaxed/simple;
	bh=S9SP720BugBCB/CLVMq1JTi5FDXTHGsWbav6q+BVDwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ecas6wvNII8PPCNo1uUh/NEGCFsS9zUQkNOlnRUqPGO8jaeCei508so91z0wdm60Deymu6YbJBsqZAQYOerT/wTkvaDCWHZKC6Kn486dU9uiItDr8sTuTlVlNzecXNW9TvSQPHTFiy4aixALJADpNbh/dreEpVPzl333Q/xVi2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UuFtSuzo; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UuFtSuzo"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c354050c34so3722285ad.3
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 17:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781225282; x=1781830082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcZ9nB0DDgvInHtcFX5oCKAFN+kEFcC9Ui6E2YgzztA=;
        b=UuFtSuzoV0AZIBRbrJB46ZbEfXxCtXftZ92vsq9hJ/GJyjxhwAS9TnH2LTs7ZC2T/5
         ws16psj4WUtmjZf8NHZKS+U/LWvbIfkAXd5sSo1m3pzhdh6e2UmTmOm6/3QI3pAMY+dY
         MRbKJkkMWmfFuQokzg9T62/mD8GmXade/ctKObWxTNXWeMpkN+ZYzrm7xYjEmf4cW7iv
         mkZxgPX01oI2h3qAHEXIVKrX1Y6hCPdtN0vcpHbt1fKSQEbw8aShQHc9U2btLO+IcPAZ
         x22EoxOB48Giyv4mXE5gyY37ExsdkuejKyrSQVlwzBhb2FjeaAOlwPMlLQefmTEyFV/+
         6Mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781225282; x=1781830082;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dcZ9nB0DDgvInHtcFX5oCKAFN+kEFcC9Ui6E2YgzztA=;
        b=NCLs/VJ8F/HWm0FbemA2DZ6KgzcTu45BYrGRB+yBoN41S3HlDwiYoBJkVaYwaHmRwr
         N87L45/kfcahqaZjzYzBCpK7CA0io/FVD/DMad4CZJLoBaNFsML7BeAZ2GjKwp9ZXQke
         Xhb8VoKIVBXbdsskGc+ESkHWzo8YfmXoLtgFxwGgOIlZolIeEUpSn//bJBd4lGMlF3eb
         hOsWNFk/e5iipL3CYzI4VZ4M3Muapmhfmkz+Gn/kKuBwT3eRFNLkT1ziFDfCunVhKi97
         l1/rrpUATfpdXdEW6DZQjlAomqiXQlkf/pkOmjQqZQxqYXsqylhE4D3IozT3jT+u2ssr
         SpbA==
X-Gm-Message-State: AOJu0YzGpCJtcX6hYpHYympVqttMhkrknxf8jrjlQxXLGFCHCNH08XOm
	MQ5/D1ovX8CIRN/H+rlDw5lGG5o8ymprWF0e7m6R20ibLRfLTm4pdeBrlrbdzSiATihWQcU/6Nn
	n9jrNCA==
X-Received: from plbmj15.prod.google.com ([2002:a17:903:2b8f:b0:2b0:aef9:a5a2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:38c4:b0:2be:fefc:d5b9
 with SMTP id d9443c01a7336-2c410ae2fb0mr8872385ad.5.1781225281577; Thu, 11
 Jun 2026 17:48:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 11 Jun 2026 17:47:48 -0700
In-Reply-To: <20260612004755.349925-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612004755.349925-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612004755.349925-4-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Misc changes for 7.2
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

By patch count, the register API cleanup dominates, but the most notable ch=
ange
here is the SNP and TDX hypercall return code handling from Vishal+Sagi.  T=
o
allow userspace to tell the guest to "retry", the changes interpret the ret=
urn
code from userspace as an errno value, and explicitly recognize only EAGAIN=
 and
EINVAL.  All other errnos are now reserved.  This is a change in uABI, but =
as
far as we know, it won't break any VMMs that support SNP or TDX

The following changes since commit b7fbe9a1bf9ee6c967ef77d366ca58c35fcf1887=
:

  Merge branch 'kvm-apx-prepare' into HEAD (2026-05-13 12:38:31 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-misc-7.2

for you to fetch changes up to 65aa483f32ec674f0506658329d43403cafe5eb0:

  Documentation: KVM: Synchronize x86 VM types (2026-06-08 09:20:19 -0700)

----------------------------------------------------------------
KVM misc x86 changes for 7.2

 - Handle EXIT_FASTPATH_EXIT_USERSPACE in vendor code to ensure vendor code
   gets a chance to handle things like reaping the PML buffer.

 - Ensure KVM's copy of CR0 and CR3 are up-to-date on SVM prior to invoking
   fastpath handlers.

 - Update KVM's view of PV async enabling if and only if the MSR write full=
y
   succeeds.

 - Fix a variety of issues where the emulator doesn't honor guest-debug sta=
te,
   and clean up related code along the way.

 - Synthesize EPT Violation and #NPF "error code" bits when injecting fault=
s
   into L1 that didn't originate in hardware (in which case the VMCS/VMCB
   doesn't hold relevant information).

 - Add support for virtualizing (well, emulating) AMD's flavor of CPL>0 CPU=
ID
   faulting.

 - Clean up the GPR APIs so that KVM's use of "raw" is consistent, and fix =
a
   variety of minor bugs along the way.

 - Fix an OOB memory access due to not checking the VP ID when handling a
   Hyper-V PV TLB flush for L2.

 - Fix a bug in the mediated PMU's handling of fixed counters that allowed =
the
   guest to bypass the PMU event filter.

 - Allow userspace to return EAGAIN when handling SNP and TDX hypercalls, s=
o
   the KVM can forward a "retry" status code to the guest, and reserve all
   unused error codes for future usage.

 - Misc fixes and cleanups.

----------------------------------------------------------------
Carlos L=C3=B3pez (2):
      KVM: x86: Take PIC lock on KVM_GET_IRQCHIP path
      Documentation: KVM: Synchronize x86 VM types

Ethan Yang (1):
      KVM: x86: Don't leave APF half-enabled on bad APF data GPA

Hou Wenlong (7):
      KVM: x86: Capture "struct x86_exception" in inject_emulated_exception=
()
      KVM: x86: Set guest DR6 by kvm_queue_exception_p() in instruction emu=
lation
      KVM: x86: Honor KVM_GUESTDBG_USE_HW_BP when emulating MOV DR (in emul=
ator)
      KVM: x86: Honor KVM_GUESTDBG_USE_HW_BP when checking for code breakpo=
ints in emulation
      KVM: x86: Move KVM_GUESTDBG_SINGLESTEP handling into kvm_inject_emula=
ted_db()
      KVM: selftests: Verify guest debug DR7.GD checking during instruction=
 emulation
      KVM: selftests: Verify VMX's GUEST_PENDING_DBG_EXCEPTIONS.BS Consiste=
ncy Check

Hyunwoo Kim (1):
      KVM: x86: hyper-v: Bound the bank index when querying sparse banks

Jim Mattson (4):
      KVM: x86: Prioritize CPUID faulting over CPUID VM-exits in nested VMX
      KVM: x86: Remove supports_cpuid_fault() helper
      KVM: x86: Virtualize AMD CPUID faulting
      KVM: selftests: Update hwcr_msr_test for CPUID faulting bit

Kai Huang (1):
      KVM: x86: Use <linux/lockdep.h> for lockdep header inclusion

Kevin Cheng (4):
      KVM: x86: Widen x86_exception's error_code to 64 bits
      KVM: SVM: Fix nested NPF injection of PFERR_GUEST_{PAGE,FINAL}_MASK b=
its
      KVM: VMX: Synthesize nested EPT violation GVA_IS_VALID/GVA_TRANSLATED=
 bits
      KVM: selftests: Add nested page fault injection test

Krzysztof Kozlowski (1):
      MAINTAINERS: KVM: Include maintainer profile

Li RongQing (3):
      KVM: x86: Fix wrong return value type in guest_cpuid_has()
      KVM: x86: Use fls() instead of ffs() for rmaps histogram bucketing
      KVM: x86: ioapic: Use old_dest_mode consistently in ioapic_write_indi=
rect()

Sagi Shahar (1):
      KVM: SEV: Restrict userspace return codes for KVM_HC_MAP_GPA_RANGE

Sean Christopherson (28):
      KVM: x86: Ensure vendor's exit handler runs before fastpath userspace=
 exits
      KVM: SVM: Refresh vcpu->arch.cr{0,3} prior to invoking fastpath handl=
er
      KVM: x86: Drop superfluous caching of KVM_ASYNC_PF_DELIVERY_AS_PF_VME=
XIT
      KVM: x86: Drop superfluous caching of KVM_ASYNC_PF_SEND_ALWAYS
      KVM: VMX: Refresh GUEST_PENDING_DBG_EXCEPTIONS.BS on all injected #DB=
s
      KVM: x86: Drop kvm_vcpu_do_singlestep() now that it's been gutted
      KVM: selftests: Add all (known) EFLAGS bit definitions
      KVM: x86: Remove unused X86EMUL_MODE_HOST define
      KVM: x86: Tell ->inject_page_fault() whether or a fault came from har=
dware
      KVM: x86: Consolidate CPUID fault handling for emulator and intercept=
ion logic
      KVM: SVM: Truncate INVLPGA address in compatibility mode
      KVM: x86/xen: Bug the VM if 32-bit KVM observes a 64-bit mode hyperca=
ll
      KVM: x86/xen: Don't truncate RAX when handling hypercall from protect=
ed guest
      KVM: VMX: Read 32-bit GPR values for ENCLS instructions outside of 64=
-bit mode
      KVM: x86: Trace hypercall register *after* truncating values for 32-b=
it
      KVM: x86: Rename kvm_cache_regs.h =3D> regs.h
      KVM: x86: Move inlined GPR, CR, and DR helpers from x86.h to regs.h
      KVM: x86: Add mode-aware versions of kvm_<reg>_{read,write}() helpers
      KVM: x86: Drop non-raw kvm_<reg>_write() helpers
      KVM: nSVM: Use kvm_rax_read() now that it's mode-aware
      Revert "KVM: VMX: Read 32-bit GPR values for ENCLS instructions outsi=
de of 64-bit mode"
      KVM: x86: Harden is_64_bit_hypercall() against bugs on 32-bit kernels
      KVM: x86: Move update_cr8_intercept() to lapic.c
      KVM: x86: Move async #PF helpers to x86.h (as inlines)
      KVM: x86: Drop defunct vcpu_tsc_khz() declaration
      KVM: x86: Remove defunct kvm_load_segment_descriptor() declaration.
      KVM: x86/pmu: Use hardware value when reprogramming for FIXED_CTR_CTR=
L changes
      KVM: selftests: Add regression test for mediated PMU fixed counter fi=
lter bug

Vishal Annapurve (2):
      KVM: x86: Treat KVM's virtual PMU as disabled for TDX VMs
      KVM: TDX: Allow userspace to return errors to guest for MAPGPA

 Documentation/virt/kvm/api.rst                     |   5 +
 MAINTAINERS                                        |   1 +
 arch/x86/include/asm/kvm_host.h                    |  27 +-
 arch/x86/include/asm/msr-index.h                   |   1 +
 arch/x86/kvm/cpuid.c                               |  21 +-
 arch/x86/kvm/cpuid.h                               |  20 +-
 arch/x86/kvm/debugfs.c                             |   2 +-
 arch/x86/kvm/emulate.c                             |  22 +-
 arch/x86/kvm/hyperv.c                              |  26 +-
 arch/x86/kvm/hyperv.h                              |   4 +-
 arch/x86/kvm/ioapic.c                              |   2 +-
 arch/x86/kvm/irq.c                                 |   4 +
 arch/x86/kvm/kvm_emulate.h                         |  17 +-
 arch/x86/kvm/lapic.c                               |  28 +-
 arch/x86/kvm/lapic.h                               |   1 +
 arch/x86/kvm/mmu.h                                 |   2 +-
 arch/x86/kvm/mmu/mmu.c                             |   2 +-
 arch/x86/kvm/mmu/paging_tmpl.h                     |  36 +-
 arch/x86/kvm/{kvm_cache_regs.h =3D> regs.h}          | 198 +++++++++--
 arch/x86/kvm/smm.c                                 |   2 +-
 arch/x86/kvm/svm/nested.c                          |  46 ++-
 arch/x86/kvm/svm/sev.c                             |  12 +-
 arch/x86/kvm/svm/svm.c                             |  34 +-
 arch/x86/kvm/svm/svm.h                             |   2 +-
 arch/x86/kvm/vmx/nested.c                          |  39 ++-
 arch/x86/kvm/vmx/nested.h                          |   2 +-
 arch/x86/kvm/vmx/pmu_intel.c                       |  10 +-
 arch/x86/kvm/vmx/sgx.c                             |   6 +-
 arch/x86/kvm/vmx/tdx.c                             |  52 ++-
 arch/x86/kvm/vmx/vmx.c                             |  40 ++-
 arch/x86/kvm/vmx/vmx.h                             |   2 +-
 arch/x86/kvm/x86.c                                 | 374 +++++++++--------=
----
 arch/x86/kvm/x86.h                                 | 134 ++------
 arch/x86/kvm/xen.c                                 |  39 ++-
 tools/testing/selftests/kvm/Makefile.kvm           |   1 +
 .../testing/selftests/kvm/include/x86/processor.h  |  29 +-
 tools/testing/selftests/kvm/lib/x86/processor.c    |   2 +-
 tools/testing/selftests/kvm/lib/x86/vmx.c          |   2 +-
 tools/testing/selftests/kvm/x86/debug_regs.c       |  88 ++++-
 tools/testing/selftests/kvm/x86/hwcr_msr_test.c    |   9 +-
 .../selftests/kvm/x86/nested_tdp_fault_test.c      | 313 +++++++++++++++++
 .../selftests/kvm/x86/pmu_event_filter_test.c      |   6 +
 42 files changed, 1116 insertions(+), 547 deletions(-)
 rename arch/x86/kvm/{kvm_cache_regs.h =3D> regs.h} (59%)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c
