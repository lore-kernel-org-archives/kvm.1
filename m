Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B17D44F568
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883524; cv=none; b=A1VKU+O8mbTqvWAgbRatKI2fERysmTV8jAM92bMQODLKTenag+sZ8uO4NTJ0fXbcJmNh7A0jsaRV9MxO7CEJ5V0R07Iuvlk8W8vsJeQmW0rPrG9jJoGdAkAtcmojSKzCn7l7SpU+z3MTJh3oNfUljdB5VBCSe8FynF0rZxFS1qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883524; c=relaxed/simple;
	bh=X1iKfg+PR3aGtis6dzyOimEIL1qrv94z0dqqbBNo7SM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jz2MrpHrpt+SUjL3Ji90Ry1qyOTjMTiLsbipNK5u0jNA+suGxGiS2/tnCCO0wg8QAf5jKqq+V1ziyHJARc6JBZwjRAxpOYuLICwpX+2LONofTTfm1i3aZHgECT+6zpIpf+yZcZyqIQKNTvhaR3ZwlAi3hwfb8aUfu/cXQuHNquA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GgymDAnr; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GgymDAnr"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2df5a65671eso14424925ad.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790883522; x=1791488322; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lvIpe4THwU2429Vg5PUWauuEjS4O/VrneOOpXPs58Tg=;
        b=GgymDAnrmq7YI7uUistSCv/0iYqLVeWA0ALYEcTRF0WsYsL/fYdDC0k0aH606edW8I
         nMu8u+SdIMNgrCAau+zUEqaLbxfB79KQTgWGHQaS9TZ6T9aGwoIaMx4BjxyQQiDlHVXb
         2Es2TeOVHn4tmyUzShflZZ78aC6TJSoAUsm0kTJ5tZ1FE1jRwc/68g9S/dxxn2v1u0e6
         9Ssos7El2+EwqYhbXNjTehh4J10e48Pbxs+LBiXX4BmBNFWA/M16biISh5Y3itDaarun
         IhyRY22athgs3Wcw28f+TWg87wcHp0DxNcNbqWllTMnA/VgNgqZD5x5zUDPuq8cuODr4
         btYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883522; x=1791488322;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lvIpe4THwU2429Vg5PUWauuEjS4O/VrneOOpXPs58Tg=;
        b=b8sw0Wf3rBIHT1Pwg3vwKya4joeQFCaRY4c26RkpG7BTHSHa8P5ZJ2qzl3mF4LjlVl
         1Sl3q9hlb5hugcwqFWTEnGQe2UvZDQPLkVYiB14DNo/g+6H2LAVssHk8HewsmlwW/sSn
         6W/SjHt+EFY9dSPSZyvjQyU7TIo6o6G77pmyF1WLfP2uMv7ssNzakw8Hh743liiLxaum
         KLgClKSOlu3XP9r+VwlfdEKa0gEKBM0EfHpXnHtsiIC33VgXOgKI/lF77O96Dx4T4tXP
         H9FJENwRA7AGY1s/bGhXcbGY86a6xoQPVjkE3WOL4XyD65FDmvcpHj6tAruGCxFBtrpg
         GKVA==
X-Forwarded-Encrypted: i=1; AKwUvBzWN3ICFj0zM3Qm2fArvlhGslL382x0ZOVtk2VxVEpdAS1lUkrePqF6IzyD5AyA9qppsaM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcTTP0oep6PUWi/6ThViLGhQV99Lcq9Cb7Ub9pz6q192zQUX0K
	41GlB+m+sFWixb3g1+7V3Ju9q7NHI7YaxcBMbV8jCLQJd0yl9VbgaD0Sy5ZcazuP6iLYCJ9YiW8
	odjDEDw==
X-Received: from plae3.prod.google.com ([2002:a17:902:e0c3:b0:2e2:d9e8:ae73])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccd0:b0:2dd:c100:2518
 with SMTP id d9443c01a7336-2e49b6d1bb0mr2469165ad.33.1790883521992; Thu, 01
 Oct 2026 12:38:41 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:37:27 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHe2vmoC/3WMwQrDIBAFfyXsuRaVGEtP/Y+Qg9XVCGksroSU4
 L/X5t7jzOPNAYQ5IsG9OyDjFimmtYFQlw7sbNaALLomQHI5cC0lK25nhIsvSIWYcEapm7ae9xr a553Rx/0MjlPjOVJJ+XP2N9H/9L9UmxlnQhk3qN4o7p6PkFJY8GrTC6Za6xd5lZsorgAAAA==
X-Change-Id: 20260722-tdx-selftests-1da5587cf047
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790883521; l=5897;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=X1iKfg+PR3aGtis6dzyOimEIL1qrv94z0dqqbBNo7SM=; b=l/5GFGD72CM1/CgLtFPipw5V21iGFJJDaH5jiAH12gZUY6RpYUX6ZX7p0cdXJtdoaokQTFxHc
 Shyg2kgBxXyAWVeaAl2i2til3vbDZuxe+Yo3+hGcF0RRAJ4L59ynJBT
X-Mailer: b4 0.14.3
Message-ID: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
Subject: [PATCH v15 00/23] TDX KVM selftests
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

Main Changes from v14[1]:
1. Include patches from Sean to transition TDX ucalls from TDVMCALL_MMIO
   to TDVMCALL_REPORT_FATAL_ERROR, and update the rest of the series to
   support this change.
2. Rename TDCALL to TDVMCALL and leaf to fn.
3. Update the commit message to clarify workflow of CPUIDs.
4. Replace manual JMP rel8 offset calculations with an assembly
   trampoline.

Thanks review from Ackerley, Binbin, Peter, Rick, Sean and Xiaoyao !

Series is organized by:
1. Patches 1 - 3: Initialize the TDX VM
2. Patches 4 - 7: Add the TDX boot code
3. Patches 8 - 13: Set up the boot region
4. Patches 14 - 17: Set up the vCPU
5. Patches 18 - 19: Finalize the TDX VM
6. Patches 20 - 23: Implement the ucall and run the TDX test

[1]: https://lore.kernel.org/all/20260722-tdx-selftests-v14-0-15ad654a50db@google.com/

Signed-off-by: Lisa Wang <wyihan@google.com>
---
Ackerley Tng (1):
      KVM: selftests: Add helpers to init TDX memory and finalize VM

Erdem Aktas (2):
      KVM: selftests: Add TDX boot code
      KVM: selftests: Add a helper to issue TDVMCALLs from the TDX vm

Isaku Yamahata (1):
      KVM: selftests: Update kvm_init_vm_address_properties() for TDX

Lisa Wang (3):
      KVM: selftests: Set shared attributes for ucall guest_memfd pages
      KVM: selftests: Require guest_memfd for TDX VMs
      KVM: selftests: Support guest_memfd in-place conversion

Sagi Shahar (13):
      KVM: selftests: Initialize the TDX VM
      KVM: selftests: Expose segment definitions to assembly files
      tools: include: Add kbuild.h for assembly structure offsets
      KVM: selftests: Introduce structures for TDX guest boot parameters
      KVM: selftests: Expose functions to get default sregs values
      KVM: selftests: Set up TDX boot code region
      KVM: selftests: Set up TDX boot parameters region
      KVM: selftests: Expose function to allocate vCPU stack
      KVM: selftests: Call KVM_TDX_INIT_VCPU when creating a new TDX vcpu
      KVM: selftests: Load per-vCPU guest stack in TDX boot parameters
      KVM: selftests: Set entry point for TDX guest code
      KVM: selftests: Finalize TDX VM in kvm_arch_vm_finalize_vcpus()
      KVM: selftests: Add TDX lifecycle test

Sean Christopherson (3):
      KVM: selftests: Add macros to simplify creating VM shapes for non-default types
      KVM: selftests: Add support for per-VM ucall ops on x86
      KVM: selftests: Add support for TDX ucalls, via TDVMCALL_REPORT_FATAL_ERROR

 tools/include/linux/kbuild.h                       |  11 +
 tools/testing/selftests/kvm/.gitignore             |   3 +-
 tools/testing/selftests/kvm/Makefile.kvm           |  39 ++-
 tools/testing/selftests/kvm/include/kvm_util.h     |  27 +-
 .../testing/selftests/kvm/include/x86/processor.h  |  44 ++++
 .../selftests/kvm/include/x86/processor_asm.h      |  12 +
 tools/testing/selftests/kvm/include/x86/sev.h      |   2 -
 .../selftests/kvm/include/x86/tdx/td_boot.h        |  81 ++++++
 tools/testing/selftests/kvm/include/x86/tdx/tdx.h  |  16 ++
 .../selftests/kvm/include/x86/tdx/tdx_util.h       |  83 ++++++
 tools/testing/selftests/kvm/include/x86/ucall.h    |   6 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         |  22 +-
 tools/testing/selftests/kvm/lib/ucall_common.c     |   8 +
 tools/testing/selftests/kvm/lib/x86/processor.c    | 147 ++++++++---
 tools/testing/selftests/kvm/lib/x86/sev.c          |  16 --
 tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S  |  71 +++++
 .../selftests/kvm/lib/x86/tdx/td_boot_offsets.c    |  21 ++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.S      |  39 +++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 292 +++++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86/ucall.c        |  54 +++-
 tools/testing/selftests/kvm/x86/sev_dbg_test.c     |  13 +-
 tools/testing/selftests/kvm/x86/sev_smoke_test.c   |  40 +--
 tools/testing/selftests/kvm/x86/tdx_vm_test.c      |  33 +++
 23 files changed, 965 insertions(+), 115 deletions(-)
---
base-commit: 37e0791600e5f1e2837a270c885296a172f5825e
change-id: 20260722-tdx-selftests-1da5587cf047

Best regards,
-- 
Lisa Wang <wyihan@google.com>

