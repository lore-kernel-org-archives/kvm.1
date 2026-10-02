Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C299C416856
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790976845; cv=none; b=jSTuw37mIaZlIXCnDmPVeovmQXOo6suebLyr/dD+b70Zx5zI1f2bOy6OkPqZEpDV0NGL6fDn3PWtdTfFq+2J1PCOXBWYw/wrVdEGXJ9YNJfvi39Nhy7THzNAucqidfkUHG0CtjoTpjjc5obb1Fo6mBzt89/WJ1msw8DQ0PWZSxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790976845; c=relaxed/simple;
	bh=KtGosJfddYAwoSjt+t/v6Wmy77qByIHLXhEvvJSbxZU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JBdtftK3go2bt0iKyu0TrfVwLa4qvPaqrQuvvULMn8mcfoiDP22j9nujFgGtr1XH3+rzvXWsow1R7FvRbe37PKUsRQBSb05TD+tlHrbtRd3qIDXehVUTT0j7aW94lyjn29K3y/JNPWN0rvUT0zLFtFXroVS80nSli52pllmGuXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qTu3ZsPX; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTu3ZsPX"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso296138a91.2
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790976843; x=1791581643; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rj4Ox5w5JNhyqVG7cubcpAmNAm1wO8qUFvi1UJFFaF0=;
        b=qTu3ZsPXDJZgjbKV0hiGLj6xkujLmeOjteXHpZISXHcAdu6Nvyi2wZFO2vCBK2IRAz
         PkivsW5CKdwp2px5qOe9jRo47hDfRz41atl4luSa1y2jdQcA+r9FWOEWr5agpIo+wUsx
         OmPjLMYepepzNhojSTa5Y0S6Vu08ndSnzmsog6OPJW4U9YBkaQQxMcmObR7IjL5jl2KP
         owXjdVmBIHiAwiFaHnby8z6YPweJuxWBWSrq0zrjuiBCL1CPxsnDNRns3hvpzCqCKR8U
         jnN4as0SFRIgzs8JkoLHUcFm+0NTdrvREjmyBvVXeetizbaQTysZPfFYvHkS1tSVehsg
         bvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790976843; x=1791581643;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Rj4Ox5w5JNhyqVG7cubcpAmNAm1wO8qUFvi1UJFFaF0=;
        b=zdfEaGW+/kEg3JC3OxxprQDvvlm46pNXH3cM3jpvMg785v3I+g2OntFy8NMCKoTb6S
         1V/hzujP7fbwQvj+7hBz/QMCI7ukStXX8VqIPF4rsJQAWFSdoKNOEKkWVZvH0NIOGORm
         5ATbSkaXz6ri551PEvPHvaoi7umwV50r53SrGDO8KMZ7XQrgVCLu0EGRufJ9kDSLF+yC
         R+6vcqCas3IHRGCxmfG7rIKqJOCmSxveqZ2YZAHFsuXVDvt13aGZARAXqKfa3Cxoz89U
         90jIaXNAV0Y3nDbuOapJ/tAF3G434+rYyKtVBtU4Tq9bVSc5yv0oZQogx6qXE7f1kZnR
         QQyw==
X-Gm-Message-State: AFq9FYJkEkO/JZ4PXaOahd5bwlzkRULS5FZSo40KaCoIEzNj0dp9FxMl
	kNT1caQZhIWUDuMLZUB6U/MLZ/4U8TMrFhLnLuCn9PRr9kIj9cpAK8kaWusl3h25PXQQEgf0xOM
	FuoS/ZQ==
X-Received: from pgho5.prod.google.com ([2002:a63:fb05:0:b0:cc7:aab6:f8a6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:39ac:b0:3a4:a7eb:1da7
 with SMTP id 98e67ed59e1d1-3a6ce7f8bcbmr3309606a91.42.1790976842739; Fri, 02
 Oct 2026 14:34:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Oct 2026 14:34:01 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002213401.4109199-1-seanjc@google.com>
Subject: [kvm-unit-tests GIT PULL] x86: Misc changes
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Please pull a random set of x86 changes.  This is basically the set of things
that I could quickly/easily review, and/or were causing problems in my test
setup.

Note, "x86/run: Use separate "-accel" option to configure the accelerator"
breaks the intel_iommu test if KUT is run with ACCEL="kvm,kernel-irqchip=on"
due to the test requiring a split-IRQCHIP via "-M q35,kernel-irqchip=split".
I'm pretty sure I'm the only person that does ACCEL="kvm,kernel-irqchip=on",
and I want to unblock running KUT with notify-vmexit enabled.

Thanks!

The following changes since commit 5a221342a025948fa7d84f0c404748f6ba57f3ad:

  svm: Add SMI handler for svm_intr_intercept_mix_smi test (2026-09-08 15:33:43 +0200)

are available in the Git repository at:

  https://github.com/kvm-x86/kvm-unit-tests.git tags/kvm-x86-2026.10.02

for you to fetch changes up to 1aaec1f90618ef3cb7a4661bbec2228456050f7f:

  x86/pmu: Relax overcounting checks to allow for 1 VM-Exit per 5000 nops (2026-10-02 09:22:08 -0700)

----------------------------------------------------------------
KVM-Unit-Tests x86 changes:

 - Disable virtual PMU support when running the MSR tests as newer versions of
   QEMU will log an error when trying to create a vPMU across vendors (the test
   runs with vendor=GenuineIntel to validate SYSENTER MSRs "fun").

 - Play nice with VMMs (or hardware) that strictly adhere to the PCI spec when
   handling 0xCF8/0xCFC accesses.

 - Add a PV IPI testcase to verify KVM can deliver PV IPIs to vCPUs with APIC
   ID 255.

 - Finally add better backtraces for leaf functions on x86.

 - Add a test to verify KVM correctly handles ICEBP+TASK_SWITCH.

 - Add a testcase to validate KVM's handling of DEBUGCTL on nVMX transitions.

 - Use "-accel" instead of "-machine" to set the accelerator.

 - Add test coverage for active-low DR6 bits, and for Bus Lock Detect #DBs.

 - Apply the "PMU instructions/branches overcount" errata to all AMD CPUs and
   massage the guardrails to get the tests passing on modern CPUs without
   completely sacrificing test coverage.

 - Misc cleanups and fixes.

----------------------------------------------------------------
Chenyi Qiang (2):
      nVMX: Remove the IA32_DEBUGCTLMSR access in debugctls test
      x86/vmx: (Re)Add a nVMX test to validate load/save of DEBUGCTL

Igor Mammedov (1):
      x86/svm: work around Virtual VMLOAD/VMSAVE bug on Naples and Rome

Irene Wang (1):
      x86: pci: Support unaligned register access in PCI config read/write

Jeremiah McReynolds (1):
      x86/msr: Disable PMU for MSR tests

Jim Mattson (5):
      x86/apic: Skip PV IPI test if feature is not supported
      lib: Hoist test selection logic to library for code reuse
      x86/apic: Support subtest selection via command line
      x86/apic: Introduce send_pv_ipi()
      x86/apic: Add a test for a PV IPI boundary condition

Mathias Krause (1):
      x86: Better backtraces for leaf functions

Paolo Bonzini (1):
      taskswitch: add test for ICEBP delivery via taskgate

Sandipan Das (1):
      x86/pmu: Check for PMIs irrespective of PMU version

Sean Christopherson (6):
      x86/debug: Set all active-low DR6 bits when resetting DR6
      x86/debug: Run the "debug" test with the host CPU model
      x86/debug: Verify that KVM correctly emulates DR6 active-low and fixed-1 semantics
      x86/debug: Add actual test coverage for Bus Lock Detect #DBs
      x86/pmu: Treat all AMD CPUs as having instruction/branch overcount errata
      x86/pmu: Relax overcounting checks to allow for 1 VM-Exit per 5000 nops

Xiaoyao Li (2):
      x86: Use "accel" to require KVM for "cet" and "lam" testcases
      x86/run: Use separate "-accel" option to configure the accelerator

Yexuan Yang (1):
      x86/lam: Allocate test page from AREA_LOW instead of AREA_NORMAL

 lib/argv.c          |  14 ++++
 lib/argv.h          |   3 +
 lib/x86/asm/pci.h   |  23 ++++--
 lib/x86/msr.h       |   1 +
 lib/x86/pmu.c       |   7 ++
 lib/x86/processor.h |   1 +
 x86/Makefile.common |  22 ++++++
 x86/apic.c          | 144 +++++++++++++++++++++++++++++--------
 x86/debug.c         | 162 ++++++++++++++++++++++++++++++++----------
 x86/lam.c           |   6 +-
 x86/pmu.c           |  26 ++++---
 x86/realmode.c      |   4 ++
 x86/run             |   2 +-
 x86/svm.c           |  26 +++++++
 x86/taskswitch.c    |  46 +++++++++++-
 x86/unittests.cfg   |  24 +++++--
 x86/vmexit.c        |  15 +---
 x86/vmx_tests.c     | 199 +++++++++++++++++++++++++++++++++++++++++++---------
 18 files changed, 580 insertions(+), 145 deletions(-)
