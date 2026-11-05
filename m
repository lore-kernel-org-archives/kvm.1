Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922455;
	b=EFkk1FL1WA1K1nGMW4ng2dyYVYkO6G7XEkCf5fQOWRj8mlSDYODZQdfNJukdj59N+Muf
	 /kIggM8mU5wPdaLEVJohluwHTJuZMmW2IEzqZhANk03RpSYU+v/FnjNi0MoofpGDy88Nf
	 EY5BOU4GhnFRCNcSxnrqMvE1fluT0OIe8ylGAyms7LObu7BfHMd26oNKtLR0nVVzWnzQo
	 p4FWqdOJ1QalDX7+E4Lnh2v6KLggPr/F6WvLXhYllTVW5MWDRV6AOb0w7rDwFQIGPciff
	 3SqHR9LD7UTuRflL3cdDnyYC9bKN/Kpa6uHvcHpM5jO8a2VaGQ78wdgsmu5b/cIPLLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-B4-Tracking:X-Change-Id:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=4aIF+yj3j//vBF0oy6QvQdl2aZOv/l2NGYKBKt4hzKU=;
	b=OO6jmVaVJCZjSsNvM4WKeOlaEg6YwpC/6dIYFEesyfvLcDpFByrJou5ydldJe4BYEER1
	 SMsrA7EVrwiDFopJXA2jNApixejAuyAfl1abV9gHiL+/FQzitQ+AMAksrHOfUcc8hm/21
	 UF3FdZHWeXfUHYoCQkwVmqPDmOfoDJg4q8PFc0fXbZ4Rxou827IiZz8D9qcswtHbthmlG
	 wyM/F6rwWaA8hweMBVp1kGGENe7JpwBjLTjfzSis8/cBVBNhLQIwyrdkqAK7XBjtzUk8M
	 l8dlevFn+0bpga67uTOTs+JsjWDT5Ug7BDhMzdTAr7/FTUXb61pwf5T9sNxAObdlwnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MzlIlccC;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E296A606A329
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E296A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MzlIlccC
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3aed37745bcso1087034a91.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793922453; x=1794527253; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4aIF+yj3j//vBF0oy6QvQdl2aZOv/l2NGYKBKt4hzKU=;
        b=MzlIlccCOHVgjBJwiHyAX5eoNS6twbNkp9OusNasX0MttOLWwDizWxzJ6TIsLxP4b6
         +5PoEIPtvyl9E/e2Pe51j7Nm/iK5XgxbOpnnEHmXAm3zyvyKGVu7yzf2z1LUHzjuBZb9
         QsRAeicoaytyKyCCv22ZfqwYiItDRjy7amnVEQpq5HRvy65vkLtWCEOc4pcEh+88XK7E
         FtYx47vS2MlDIiXEhvO2NrCyDVc9qfX7j2eA4iACkxfXiC52aHJJseBxXCsUMOf0YSUv
         aX+hIz+ecBqvXlMAAXJ+SIHVTIhiNXm+NfW+qyp5jQSQjmfkhJVVl9hiTYxP8yBccQWM
         NIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922453; x=1794527253;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4aIF+yj3j//vBF0oy6QvQdl2aZOv/l2NGYKBKt4hzKU=;
        b=NbQsM7ViwqPUMtDlBvylO+qIcOmIx/g9+DsBc/QZBkYMZk3orrrGyuHYBXNtBEgWUD
         cAprQD3mLBp7suqO6eMgLJLkMUJrEVA/hf/vzg0px3pekhVpgYSUphIeyDG6ghN8PjF9
         DwCR22FTQjb43prLOIrAN/ygHJLvNT2Efom/AOFPKzgtQpBddk3FR3ihK105cHY0uhPj
         /5CcY3lFWKBQERYDwJe8aaN5r8EG31OoTlU0rbU3Je3S1Vr/oDfe5V8ctfiJPXn9fvma
         z7mtu6bFDlI8X4GCqX4j3+9dvtAWPaEupiO/YGSTbdOPpDG5yAOyd/q3y19ASrPB22qc
         ZmAQ==
X-Forwarded-Encrypted: i=1; AKwUvByL46XS2o932AHPoeJJi/Da+GCDt8qWty+B8z3AYo5FDW996VRIyoeoSRkGAGYoSpQnGAM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/znpWERcMCisKmumL6ZIWy799x1YrHi/3uQUdcwHSBg0U0TgtT
	Hl7GbQC1m9lnZdMvK748KEo1HjGcbQhcHsVb6xAI8JNv7m8XR8cIl6rQSBe8VUI7lM+2RkHvV+L
	QuQYYvA==
X-Received: from pjbov7.prod.google.com ([2002:a17:90b:2587:b0:3ad:8fe3:ea05])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fc5:b0:3ac:928a:68ce
 with SMTP id 98e67ed59e1d1-3b0db6f9a9fmr367033a91.33.1793922452978; Thu, 05
 Nov 2026 15:47:32 -0800 (PST)
Date: Thu, 05 Nov 2026 23:46:44 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGQV7WoC/3XMQQrCMBQE0KuUrI0koT9pXXkPcRGT3zZQjeSHU
 im9u2kXgojLmWHewghTQGKnamEJp0AhPkqQ+lAxN9hHjzz4UjAllBZGKZ79zAnHLiNl4tJbgMa
 4TtSGlc8zYRfmHbxcSx4C5Zheuz/Jeqv/UWXmgkuwXkNtQfjbuY+xH/Ho4p1t2CThA0gh5A8AB TBOKwu+sW2rvoB1Xd+83r3I7wAAAA==
X-Change-Id: 20260722-tdx-selftests-1da5587cf047
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793922452; l=6241;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=cPw3DBclKWIRj17+7KiFRcMZS7Ey/83ts+0tCeZ/Sos=; b=0He8qiBKALIKPHW/NPN5cPI9Vlr2gKAf7QUUEVr5Yv25c2kbG8wxcEZRTEWbgDGM2ze3sRvZZ
 JFiT1d/LwS2DjGXTR0vQMB2VmT+1cExnONIKpV+C02zoGMA3FAFy4kn
X-Mailer: b4 0.14.3
Message-ID: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
Subject: [PATCH v16 00/20] TDX KVM selftests
From: Lisa Wang <wyihan@google.com>
To: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ira Weiny <iweiny@kernel.org>
Content-Type: text/plain; charset="utf-8"

This patch series focuses on setting up a TDX VM and adding all code
necessary to run a basic lifecycle test.

Unlike standard KVM selftests can set up the VM through guest registers,
TDX module protects TDs' register state from the host. This feature of
TDX causes problems on VM boot state initialization and the ucall
implementation.

In standard KVM selftests, the host directly initializes the guest state
by manipulating Special Registers (SREGs) and General Purpose Registers
(GPRs) via IOCTLs (KVM_SET_SREGS, etc.) before the first KVM_RUN.

To bypass direct register initialization by the host, we utilize the
standard x86 reset vector as the default entry point.

The mechanism works as follows:
1. The host places register values into a specific memory region and
   inserts boot code at the VM's default starting point.
2. When the VM starts, it executes this boot code to "pull" values from
   memory and manually set up its own SREGs and GPRs.
3. Once the environment is ready, the boot code jumps to the guest code.

The standard x86 ucall() implementation uses PIO, but it does not
actually transmit data through the 4-byte PIO data. Instead, it relies
on the host reading the ucall address directly from the guest's RDI
register.

TDX selftests cannot utilize the standard x86 ucall implementation
because the host is unable to access the guest's RDI register. Between
the two alternatives, TDVMCALL_MMIO and TDVMCALL_REPORT_FATAL_ERROR,
TDVMCALL_MMIO has fragility concerns and requires hardcoding a magic
address while ignoring mmio_gpa. Therefore, the Report Fatal Error
TDVMCALL is the cleanest and most efficient solution for TDX ucalls.

Main Changes from v15[1]:
1. Rebase onto kvm/next:
    - Replace vm_phy_pages_alloc() with ____vm_phy_pages_alloc(...,
      true, false) in tdx_vm_setup_boot_code_region() and
      tdx_vm_setup_boot_parameters_region() to allocate protected pages
      at fixed GPAs in custom memslots (TD_BOOT_CODE_SLOT and
      TD_BOOT_PARAMETERS_SLOT), as vm_phy_pages_alloc() now takes an
      enum kvm_mem_region_type.
    - Drop 3 patches.
2. Simplify tdx_init_vm() by dropping the intermediate CPUID allocation
   and clearing init_vm->cpuid.padding.
3. Move tdx_vcpu_init() to tdx_util.c, use PRIx64 for hw_error in
   tdx_vm_ioctl(), and align tdx_vcpu_ioctl() error formatting with
   tdx_vm_ioctl().
4. Decouple tdx_load_private_memory() from tdx_vm_finalize() and call
   both explicitly in kvm_arch_vm_finalize_vcpus().
5. Check 32-bit address bounds on idt, gdt, and esp_gva before assigning
   them to 32-bit boot parameter fields.
6. Refine comments, commit messages, and __tdvmcall().

Thanks for the reviews from Binbin and Xiaoyao!

Series is organized by:
Patches 1 - 3: Initialize the TDX VM
Patches 4 - 7: Add the TDX boot code
Patches 8 - 11: Set up the boot region
Patches 12 - 14: Set up the vCPU
Patches 15 - 16: Finalize the TDX VM
Patches 17 - 20: Implement the ucall and run the TDX test

[1]: https://lore.kernel.org/all/20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com/

Signed-off-by: Lisa Wang <wyihan@google.com>
---
Ackerley Tng (1):
      KVM: selftests: Add helpers to init TDX memory and finalize VM

Erdem Aktas (2):
      KVM: selftests: Add TDX boot code
      KVM: selftests: Add a helper to issue TDVMCALLs from the TDX vm

Isaku Yamahata (1):
      KVM: selftests: Update kvm_init_vm_address_properties() for TDX

Lisa Wang (1):
      KVM: selftests: Require guest_memfd for TDX VMs

Sagi Shahar (12):
      KVM: selftests: Initialize the TDX VM
      KVM: selftests: Expose segment definitions to assembly files
      tools: include: Add kbuild.h for assembly structure offsets
      KVM: selftests: Introduce structures for TDX guest boot parameters
      KVM: selftests: Expose functions to get default sregs values
      KVM: selftests: Set up TDX boot code region
      KVM: selftests: Set up TDX boot parameters region
      KVM: selftests: Call KVM_TDX_INIT_VCPU when creating a new TDX vcpu
      KVM: selftests: Load per-vCPU guest stack in TDX boot parameters
      KVM: selftests: Set entry point for TDX guest code
      KVM: selftests: Load private memory and finalize TDX VM in kvm_arch_vm_finalize_vcpus()
      KVM: selftests: Add TDX lifecycle test

Sean Christopherson (3):
      KVM: selftests: Add macros to simplify creating VM shapes for non-default types
      KVM: selftests: Add support for per-VM ucall ops on x86
      KVM: selftests: Add support for TDX ucalls, via TDVMCALL_REPORT_FATAL_ERROR

 tools/include/linux/kbuild.h                       |  11 +
 tools/testing/selftests/kvm/.gitignore             |   3 +-
 tools/testing/selftests/kvm/Makefile.kvm           |  33 ++-
 tools/testing/selftests/kvm/include/kvm_util.h     |  27 +-
 .../testing/selftests/kvm/include/x86/processor.h  |  42 +++
 .../selftests/kvm/include/x86/processor_asm.h      |  12 +
 tools/testing/selftests/kvm/include/x86/sev.h      |   2 -
 .../selftests/kvm/include/x86/tdx/td_boot.h        |  81 ++++++
 tools/testing/selftests/kvm/include/x86/tdx/tdx.h  |  16 ++
 .../selftests/kvm/include/x86/tdx/tdx_util.h       |  85 ++++++
 tools/testing/selftests/kvm/include/x86/ucall.h    |   6 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         |   2 +-
 tools/testing/selftests/kvm/lib/x86/processor.c    | 105 +++++---
 tools/testing/selftests/kvm/lib/x86/sev.c          |  16 --
 tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S  |  71 +++++
 .../selftests/kvm/lib/x86/tdx/td_boot_offsets.c    |  21 ++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.S      |  39 +++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 300 +++++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86/ucall.c        |  58 +++-
 tools/testing/selftests/kvm/x86/sev_dbg_test.c     |  13 +-
 tools/testing/selftests/kvm/x86/sev_smoke_test.c   |  40 +--
 tools/testing/selftests/kvm/x86/tdx_vm_test.c      |  33 +++
 22 files changed, 913 insertions(+), 103 deletions(-)
---
base-commit: 1689c80fca308978ea1c9f03d15a500f4e44e2e1
change-id: 20260722-tdx-selftests-1da5587cf047

Best regards,
-- 
Lisa Wang <wyihan@google.com>

