Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05DD4582C5
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762058; cv=none; b=JwWVEYByyr10Hh5fN+gjxZWT5oN3QizRCPSz/6CEUMuuqWWywKr2+N8WPV8/57nnTSZcl0bvJlMhYRJ4+wUR3Gx8RHkDjvn6+1t0utODMXtHG+GCh52Aon1CPpaQAciJvI4lW9b33+3XSqEwqOdvsyCIUkyuBGexFMlD7zCNXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762058; c=relaxed/simple;
	bh=7HIV+3fHpl4kdc8gFiSJABRx56th9p7yjpshKj2Wa5I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bnBjW8714BJKvWx5xLtfrOi1IX5L9QSr3wPd3KJVRSRxeCNq+T8d+aZEgsS+z29mw1eTcSr5MJ2NUqRKHGw0XUFdqlLtvcbfAHA/ju+G4JQNJjDJHkw0U77qRNlk+2NjdqH5wICTQ1jPcomzh+EZ4NXXAIiyVSCsBOgaBSmO8Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ax3udoOn; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ax3udoOn"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8487eb67173so23092b3a.2
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784762056; x=1785366856; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P+klJPR9+I3NtXYh+vSCCr8HtTVr+DNz+MjtC0fTmdQ=;
        b=ax3udoOnWx2hj1N3csrlzft9QojStfOtwaoICaxQh6k12hKUh632vjGEtAxVYzNXXP
         B8CgoDmK5UyziNiFX8ZS/zDl82Z2j8B/WwEnaXGEAB3N5/D4G5KqBtWXPvupEoxSHKGD
         GsKH/Jat2MREgqy0P8Gvt7mopG3rzQ4aVyCwM69GWEArtMrdioHaNTDVGENoBu30ZVlL
         1I4ssdFyjOn4g/oOSNSxFsE5ABkgUeYAlADIQO+t9IjeNBBKIjYtzp+aPoXXPEc8bWrV
         V0Vj1BCWm25k12Ok4PRVTQSmIDOHvuBBvh2LTO1i+Rd0/JbQKbhYhOk/ubmmMWvGxZDt
         BPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762056; x=1785366856;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+klJPR9+I3NtXYh+vSCCr8HtTVr+DNz+MjtC0fTmdQ=;
        b=d09EU6m37iWRKttrUBKZRIdQfL4VjFd29kghw124cDDcGcOwn+BLX262fa4bsUTubF
         aXltwwGyU8D1eVYRhrpdBwIeUge+hsLzfKmSnRLNAgijHd1xwjwVNqqIwclLEsH1ky1w
         zxwesXCe7M6IJ6f9Zf1ffuMRU7KDATfbL8Fmc1iP5vvGQZU2Cjqhyi4vAHCCAp89SHX7
         I5Krkj4fKdJwMyTYSoqDoGlgHiZmO3wPOVXSDOwLQAefei8M+hXt9h8KeFdhXzpfL45v
         grlBrKsDmZXYVtul18wiSKClYmuwH9u3Pp518rl1j/zgFmDxBymkO3xMn3A/mdzZPhIH
         OEVw==
X-Forwarded-Encrypted: i=1; AHgh+Rp586BA8Ft2yNPivwP1DPoQND38o+7MuovhmzCpXxf+P2pcPClulnOkq2ojlcqx6xbfxI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx52PVMKHmuMffQBEz16xDOtiNRiDxP5E9g6XpPujKEVtr1rpsT
	9nxC5GnDS3C2ukgGwu1x8HZPRt1OUt1fAUepKdqCNv5mvYaXgQq40AdhqBxLTWpxFkHh7Op1GAg
	dWZ9R8w==
X-Received: from pfblw5.prod.google.com ([2002:a05:6a00:7505:b0:848:2e05:6161])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a20f:b0:84e:1a9d:d879
 with SMTP id d2e1a72fcca58-84e2bc69cdbmr1016549b3a.28.1784762055790; Wed, 22
 Jul 2026 16:14:15 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:13:05 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIFOYWoC/x2MQQqAIBAAvyJ7TjDJjL4SHULXWogKV0IQ/550n
 IGZAoyRkGEWBSK+xHRfDfqhE+CO7dpRkm8CtNKjslrL5LNkPENCTix7vxkzWRfUYKE1T8RA+R8 ua60f+SA8MmAAAAA=
X-Change-Id: 20260722-tdx-selftests-1da5587cf047
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784762054; l=5919;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=7HIV+3fHpl4kdc8gFiSJABRx56th9p7yjpshKj2Wa5I=; b=35hxqDyVYOoWigPq3JCWHxzcg53ekafGh2UPBfDigXOEa8G8ueSkYnrNgu6/uRL5/uL8OrADC
 jtQU6j8TvtaB4KWXXw5Yg4lLwHvSTfIkwsTjccw3uO+Oe8ajkAJnI6V
X-Mailer: b4 0.14.3
Message-ID: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
Subject: [PATCH v14 00/22] TDX KVM selftests
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
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
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
this restriction, we used TDCALL with an 8-byte MMIO data to implement
ucall. This method is the cleanest and efficient implementation for the
overall ucall architecture.

v14 revision for TDX KVM selftests based on kvm/next and guest_memfd:
In-place conversion support[1]. This series needs some changes from
in-place conversion v9. For ease of testing, an extra hack commit has
been added. The complete code is available at:
https://github.com/googleprodkernel/linux-cc/commits/tdx-selftests-v14

Changes from v13[2]:
1. Fixed some bugs, including typo and commit messages.
2. Outlined TDCALL from tdx.c to tdx.S.
3. Used HPET(0xfed00000) for ucall GPA address.
4. Supported guest_memfd w/wo in-place conversion support.

Thanks review from Ackerley, Binbin, Chenyi, Sean and Xiaoyao!

Series is organized by:
1. Patches 1 - 4: Initialize the TDX VM
2. Patches 5 - 8: Add the TDX boot code
3. Patches 9 - 13: Set up the boot region
4. Patches 14 - 17: Set up the vCPU
5. Patches 18 - 19: Finalize the TDX VM
6. Patches 20 - 22: Implement the ucall and run the TDX test

[1]: https://lore.kernel.org/all/20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com/T/
[2]: https://lore.kernel.org/all/20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com/

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
      KVM: selftests: Finalize TD memory as part of kvm_arch_vm_finalize_vcpus
      KVM: selftests: Add TDX lifecycle test

Sean Christopherson (1):
      KVM: selftests: Add macros to simplify creating VM shapes for non-default types

 tools/include/linux/kbuild.h                       |  11 +
 tools/testing/selftests/kvm/.gitignore             |   3 +-
 tools/testing/selftests/kvm/Makefile.kvm           |  33 ++-
 tools/testing/selftests/kvm/include/kvm_util.h     |  27 +-
 .../testing/selftests/kvm/include/x86/processor.h  |  44 +++
 .../selftests/kvm/include/x86/processor_asm.h      |  12 +
 tools/testing/selftests/kvm/include/x86/sev.h      |   2 -
 .../selftests/kvm/include/x86/tdx/td_boot.h        |  82 ++++++
 tools/testing/selftests/kvm/include/x86/tdx/tdx.h  |  17 ++
 .../selftests/kvm/include/x86/tdx/tdx_util.h       |  82 ++++++
 tools/testing/selftests/kvm/include/x86/ucall.h    |   6 -
 tools/testing/selftests/kvm/lib/kvm_util.c         |  22 +-
 tools/testing/selftests/kvm/lib/ucall_common.c     |   8 +
 tools/testing/selftests/kvm/lib/x86/processor.c    | 125 +++++---
 tools/testing/selftests/kvm/lib/x86/sev.c          |  16 --
 tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S  |  61 ++++
 .../selftests/kvm/lib/x86/tdx/td_boot_offsets.c    |  21 ++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.S      |  37 +++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 316 +++++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86/ucall.c        |  33 +++
 tools/testing/selftests/kvm/x86/sev_smoke_test.c   |  40 +--
 tools/testing/selftests/kvm/x86/tdx_vm_test.c      |  33 +++
 22 files changed, 927 insertions(+), 104 deletions(-)
---
base-commit: 2145a419fb2a4cdc8eefc8497425d2827f46e660
change-id: 20260722-tdx-selftests-1da5587cf047

Best regards,
-- 
Lisa Wang <wyihan@google.com>

