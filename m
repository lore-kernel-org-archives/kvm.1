Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695D30594F
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405443; cv=none; b=rPeyQNKrPEqjvXsjKPll0emHaBg1M85UIUkbh92ZnRSx+MKwl+WoF/gyZ9RmKmduwJ3Q119ZDIzO4jEEzjdkXpzeMCkzsViJlmP9i+2ibI3oZbrGjIkIw2lJe1a2CE/FiFK977oVmpT+/+5PM/HBEhbDG9Ijnnae3qygb1PWBqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405443; c=relaxed/simple;
	bh=xohEyJSjao+0f4zXcTkZNxW1s1ON51E/Gofi7RSpk5A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HlMzSsVbK0nUzp9aLiMY9XHOhwabr62CwqH+8fsZ1SWRr8M0ibfvD1qGC2MmdhUJJ8SUETOmHSIHh4RfiJuBHyqzD+DurWDHOCGCnfdlMvbL97/t3in2mXsYkAmrCLyOEmIk7QGdHjN9wdBoafcgd1hS/ToTLlyDdAQuz7TnaT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=urtlyWd5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="urtlyWd5"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-837c4eb3bdfso4078720b3a.2
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779405441; x=1780010241; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3bkSrIDTbT5aF0NcYWR4v4f3pXIdZzjbSf5buGjzZO0=;
        b=urtlyWd5T7IoIOUtCBG/0d+APqQJ3zO5Z2S97EzmdbIREd5HWo4zvgOjWf0AwON5CX
         vCagWvRrch2Ka2gbJb0rpiXeg6IlbTP6pT4NGHEmJVBEnd0wppQyjr8elcnbCvcSJKBD
         f46lzSpv/DhEqu12jbgsPTfx/y9z+wIyyPicKeDUvvlm5KsugfgPn007xx8vhUSub8Wg
         f7OXRE91z06hG2HOpm6V/ao5jS3guP5uw1Lq3iIHUHCRQZBvVHMo16Qc/+uFkT+ihPDw
         G2ar7WpdgCqt+nDNJk5GE7RKuilZPSN/2Tjljsv0AXQ5x6tA1FZcjN4iQcyQTPsEY+1Z
         Bf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405441; x=1780010241;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3bkSrIDTbT5aF0NcYWR4v4f3pXIdZzjbSf5buGjzZO0=;
        b=E+/VL3WyihUITfiHvcbfKLQGsOrHbdUZkqhZIEqKHjawY4h7WYls1S7Kw6D+9Mg1Vw
         NHEZuZlSXe/xurGFg6cUyH/5PPvmyDWoZ7xGcttC/1ZueAtCGC2W4z9/iFkH84URVlEo
         qU08cxmbQDzezVGzixzTUfQI110YKI45oV2OMzVliYH53bsCIUhodODcDEBRlDdjmMNY
         KFNf3NKnHoXwtv5eehGhdllNCh2OkDC3Qv5ifqThY7fciOWjNNTEu3fmpmOrje0aJZ9b
         /SINMUcS0hsEYeXH+1Vp5bavuseo4j/E7JcVxEx98yaluJPC5XrftJEQP9vm8EHU8K1k
         1+cQ==
X-Forwarded-Encrypted: i=1; AFNElJ+y+AHktuHNyswpQ1+5DhcP46u04yp8YFuqwjv213mTC46j7V0EmJ12ueyNqg+vffbovok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkrafD55n6kIPy7Kvv+SGAK6hzQ5LG3pvBRo+AVTFrRkBh8vwE
	nYEioOnG7RJYkQLfCYO5FqWOjnrl4h3r08gdyYYMRTceDqRvPImGRXpBkrKReWlr8jKRRdECXqs
	HEVFd1g==
X-Received: from pfblx5.prod.google.com ([2002:a05:6a00:7545:b0:82f:c34b:9799])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a0b:b0:83a:4846:90bc
 with SMTP id d2e1a72fcca58-8415f3c291emr1146364b3a.48.1779405440728; Thu, 21
 May 2026 16:17:20 -0700 (PDT)
Date: Thu, 21 May 2026 23:16:41 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFmSD2oC/x2MQQqAMAzAviI9W6gbivgV8eC2Tguisg4RxL87P
 CaQPKCchBWG6oHEl6gce4HG1hX4dd4XRglFgCHTUUs95nCj8hYza1a8GosuEs2BvOsjQ+nOxFH ufzoCTO/7AYd3BiJmAAAA
X-Change-Id: 20260508-tdx-selftests-v13-bf00ad0cb8fe
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779405439; l=8037;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=xohEyJSjao+0f4zXcTkZNxW1s1ON51E/Gofi7RSpk5A=; b=r1ctI7BkzWLkv7GY+9pssqPBHrJSjtAq0rC7HCjPLdke5+p0RpzOYvncBFAn53Bus1m7WGrA+
 PV8NHhNW1Q6DdcIdHFXBi+DS9q8d6aAQxMAR9MiFiRh4pPrEMfdEw0f
X-Mailer: b4 0.14.3
Message-ID: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
Subject: [PATCH v13 00/22] TDX KVM selftests
From: Lisa Wang <wyihan@google.com>
To: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>
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

TDX selftests cannot utilize the standard x86 ucall implementation,
because the host is unable to access the guest's RDI register. Based on
this restriction, we considered these potential solutions for the TDX
ucall implementation.

1. TDCALL PIO with RCX-bits Passthrough
We first considered passing the RDI value through RCX bits to bypass the
hardware's register protection, which could be the closest approach to
the non-TDX implementation as per Sean's suggestion[1]. However, this
approach is blocked by the software-side implementation: KVM_GET_REGS
currently does not support TDX VMs and returns -EINVAL. To make this
work, the KVM ioctl would need a test-only hack.

2. TDCALL PIO with buffer indexing
To keep a PIO-based approach and unify the get_ucall implementation for
both TDX and non-TDX VMs, we considered TDCALL PIO with buffer indexing.
Since the ucall buffer is initialized prior to execution, the VM could
just pass a buffer index rather than an 8-byte ucall address to fit
within the 4-byte PIO data limit. The host, already knowing the ucall
buffer's base address, could then resolve the ucall content via this
index. We abandoned this solution because it would require changes to
the common ucall structure and impact other non-x86 architectures.

3. TDCALL MMIO (Selected solution)
We ultimately selected TDCALL with an 8-byte MMIO data. This method only
requires initializing an MMIO GPA and adding TDCALL MMIO implementation
for TDX under the original x86 ucall path. While this diverges from the
non-TDX PIO, it provides the cleanest implementation with minimal
disruption to the overall ucall architecture.

4. A note on #VE and x86 ucall simplification
It is worth noting that the use of a Virtualization Exception (#VE)
is orthogonal to the PIO vs. MMIO discussion; rather, it is a question
of how much we want to simplify the x86 ucall implementation. A #VE
handler is one option to allow VMs use PIO/MMIO identical to the
non-TDX case. Alternatively, having an MMIO_WRITE wrapper macro, as Sean
suggested[2], is another option. Either way, discussion for this is
likely a premature optimization right now, since the PIO/MMIO call is
only used under ucall_arch_do_ucall(), and standard and TDX VMs use
different ones now. We should optimize this in the future, but for now,
invoking TDCALL directly is more robust and concise.

v13 revision for TDX KVM selftests based on kvm/next and guest_memfd:
In-place conversion support[3]. For ease of testing, this series is also
available at: https://github.com/googleprodkernel/linux-cc/commits/tdx-selftests-v13

Changes from v12[4]:
1. Fixed some bugs, including typo, commit order and commit messages.
2. Inlined the TDCALL to tdx.c file.
3. Refactored the Makefile to use pattern rules for generic source
   compilation while ensuring build artifacts are directed to the target
   output directory.

Series is organized by:
1. Patches 1 - 4: Initialize the TDX VM
2. Patches 5 - 8: Add the TDX boot code
3. Patches 9 - 13: Set up the boot region
4. Patches 14 - 17: Set up the vCPU
5. Patches 18 - 19: Finalize the TDX VM
6. Patches 20 - 22: Implement the ucall and run the TDX test

[1]: https://lore.kernel.org/kvm/aQTcDH9LRezI30dm@google.com/
[2]: https://lore.kernel.org/kvm/aQTSdk3JtFu1qOMj@google.com/
[3]: https://lore.kernel.org/all/20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com/T/
[4]: https://lore.kernel.org/kvm/20251028212052.200523-1-sagis@google.com/

Signed-off-by: Lisa Wang <wyihan@google.com>
---
Ackerley Tng (2):
      KVM: selftests: Add helpers to init TDX memory and finalize VM
      KVM: selftests: Add ucall support for TDX

Erdem Aktas (2):
      KVM: selftests: Add TDX boot code
      KVM: selftests: Implement MMIO WRITE for the TDX VM

Isaku Yamahata (2):
      KVM: selftests: Update kvm_init_vm_address_properties() for TDX
      KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to validate TDs' attribute configuration

Lisa Wang (2):
      KVM: selftests: Back the first memory region with guest_memfd for TDX
      KVM: selftests: Set first memory region as shared if guest_memfd

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
      KVM: selftests: Finalize TD memory as part of kvm_arch_vm_finalize_vcpus
      KVM: selftests: Add TDX lifecycle test

Sean Christopherson (1):
      KVM: selftests: Add macros to simplify creating VM shapes for non-default types

 tools/include/linux/kbuild.h                       |  11 +
 tools/testing/selftests/kvm/.gitignore             |   3 +-
 tools/testing/selftests/kvm/Makefile.kvm           |  33 +-
 tools/testing/selftests/kvm/include/kvm_util.h     |  13 +
 .../testing/selftests/kvm/include/x86/processor.h  |  40 +++
 .../selftests/kvm/include/x86/processor_asm.h      |  12 +
 tools/testing/selftests/kvm/include/x86/sev.h      |   2 -
 .../selftests/kvm/include/x86/tdx/td_boot.h        |  74 +++++
 .../selftests/kvm/include/x86/tdx/td_boot_asm.h    |  16 +
 tools/testing/selftests/kvm/include/x86/tdx/tdx.h  |  16 +
 .../selftests/kvm/include/x86/tdx/tdx_util.h       |  80 +++++
 tools/testing/selftests/kvm/include/x86/ucall.h    |   6 -
 tools/testing/selftests/kvm/lib/kvm_util.c         |  18 +-
 tools/testing/selftests/kvm/lib/x86/processor.c    | 107 ++++---
 tools/testing/selftests/kvm/lib/x86/sev.c          |  16 -
 tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S  |  60 ++++
 .../selftests/kvm/lib/x86/tdx/td_boot_offsets.c    |  21 ++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c      |  30 ++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 334 +++++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86/ucall.c        |  30 ++
 tools/testing/selftests/kvm/x86/sev_smoke_test.c   |  40 +--
 tools/testing/selftests/kvm/x86/tdx_vm_test.c      |  33 ++
 22 files changed, 907 insertions(+), 88 deletions(-)
---
base-commit: cd1b71113e3f70f0a1a3d61550cf89f1eed379c4
change-id: 20260508-tdx-selftests-v13-bf00ad0cb8fe

Best regards,
-- 
Lisa Wang <wyihan@google.com>

