Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD653939D3;
	Wed, 20 May 2026 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284403; cv=none; b=acV1Hcmpv+vehEZvW+cpOnKXQZA+ggCUWoWDtyrzDA8u0akbWnK6/PzxPq4P6jSNXGO7lGJzkCBkF7np/PKo3NBOn5iZmWu9000cguf9lRbg3onoFLm0y9OlVjoC/YGueS0WyNODZdXqwm35A/b3Gd69c4FIR5f9rI234MHB+/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284403; c=relaxed/simple;
	bh=dXVJCYiRNSrIl+CsMGlCg6SEHWTv7WIhbFUV55zOKis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tRsDxY5TGQ/Zj7ywgS4/IGwwh/w+wlT5sei/l2f59fx5XYQd5AoUiE9b5eMaAnMuosoxKSQIj7TocQUN25mxjPjJ2pk6HUEK0P2IkgQqmA1yByvKS+rC8XtMU7qRYoy1KzsB/82aF0b0C3P9clySCUtbI/fLNs8XOqGugxA6Jqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a0Jw6YNa; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0Jw6YNa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284400; x=1810820400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dXVJCYiRNSrIl+CsMGlCg6SEHWTv7WIhbFUV55zOKis=;
  b=a0Jw6YNaof2unUGBnXrT1Wm8xhPHGX+KCyuLIEo5LxRymSyIFvBVKfr5
   01ppD0z0qrAXoyl6/9crp6+KhOwTKHUttLl0cGmAlgFq1LiLhWfpj9S5q
   kIJxtm0xHOwhitf1T8AiJK69GCvuQW5jb9d0HVXb1YPHWbUSOlCB2chMl
   kj0Og0pRUeJ27d/0wnywg+oNsd7at0J6rvXDJXM+Fc69ZHGN03RF6+kIf
   F0wun/JJqI/98iZVDT+EbnILmHlOoFzq2CZpbBUKM/BOkVjAv2WiS82Sy
   egzzR2jww+iIunmSc3Fk/9/p9vkiU0/nz8Q+TUEB3N3u8mL822htIU33z
   A==;
X-CSE-ConnectionGUID: J93K7ut6QvSfAGD/cnf3KA==
X-CSE-MsgGUID: 46inCz2/TYuZnRSWAkWfQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146374"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146374"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:39:59 -0700
X-CSE-ConnectionGUID: BYUlZQlfTQSZSmgpFMvQbQ==
X-CSE-MsgGUID: hi9162oxTLC+b7cpBarEEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235923592"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:39:58 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	dave.hansen@linux.intel.com,
	djbw@kernel.org,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	kas@kernel.org,
	nik.borisov@suse.com,
	paulmck@kernel.org,
	pbonzini@redhat.com,
	reinette.chatre@intel.com,
	rick.p.edgecombe@intel.com,
	sagis@google.com,
	seanjc@google.com,
	tony.lindgren@linux.intel.com,
	vannapurve@google.com,
	vishal.l.verma@intel.com,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v10 00/25] Runtime TDX module update support
Date: Wed, 20 May 2026 06:38:03 -0700
Message-ID: <20260520133909.409394-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Dave & Rick,

Thanks for your thorough review of v9. This v10 addresses the issues you
pointed out. The main changes in this version are polishing changelogs
and variable renames to improve readability. Specifically:
 
   - Patches 1-2 (new): Split the original "Consolidate TDX global
     initialization states" into two steps — first move the statics to
     file scope, then clarify the result-caching logic in
     try_init_module_global().
   - Patch 6: Removed user-facing Kconfig help text for TDX_HOST_SERVICES
     (now a silent tristate auto-selected by INTEL_TDX_HOST).
   - Patch 13: Renamed "size" to "data_len" in seamldr_install_module()
     and init_seamldr_params(); renamed "HEADER_SIZE" to
     "TDX_IMAGE_HEADER_SIZE"; renamed "primary" to "is_lead_cpu" in the
     update state machine.
   - Patch 13: Added early data_len validation and explicit bounds checks
     on sigstruct_nr_pages/module_nr_pages against SEAMLDR_MAX_NR_*
     limits, removing the implicit clamping in populate_pa_list().
   - Patch 22: Fixed BIT(16) -> BIT_ULL(16) for
     TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE.
   - Patch 22: Removed unused TDX_FEATURES0_UPDATE_COMPAT definition.
   - Various patches: Shortened sysfs ABI descriptions, tightened
     comments across seamldr.h and seamldr.c, and minor style fixes
     (return 0 -> return false, unfolded conditionals)

Please take a look at this new version. I hope it can still be merged
for 7.2.
---

(For transparency, note that I used AI tools to help proofread this
cover-letter and commit messages)

This series adds support for runtime TDX module updates that preserve
running TDX guests. It is also available at:

  https://github.com/gaochaointel/linux-dev/commits/tdx-module-updates-v10/

== Background ==

Intel TDX isolates Trusted Domains (TDs), or confidential guests, from the
host. A key component of Intel TDX is the TDX module, which enforces
security policies to protect the memory and CPU states of TDs from the
host. However, the TDX module is software that requires updates.

== Problems ==

Currently, the TDX module is loaded by the BIOS at boot time, and the only
way to update it is through a reboot, which results in significant system
downtime. Users expect the TDX module to be updatable at runtime without
disrupting TDX guests.

== Solution ==

On TDX platforms, P-SEAMLDR[1] is a component within the protected SEAM
range. It is loaded by the BIOS and provides the host with functions to
install a TDX module at runtime.

This series implements runtime TDX module updates through the fw_upload
mechanism. That interface is a good fit because TDX module selection is not
a simple "load a known file from disk" problem. The update image to load
depends on module versioning, compatibility rules. fw_upload lets userspace
choose the module explicitly while the kernel provides the update
mechanism.

This design intentionally keeps most update validation/policy in userspace.
The kernel exposes the information userspace needs, such as TDX module
version and P-SEAMLDR information, but userspace is responsible for
understanding TDX module's versioning and compatibility rules and for
choosing an appropriate update image (see "TDX module versioning" below).

The kernel still enforces the pieces that must be handled in-kernel:

1. Validate the tdx_blob header fields that are not passed through tothe
TDX module. Just the standard overflow and reserved bits defensive ABI stuff.

2. Make sure no non-update SEAMCALLs are called during the update.

3. Make sure SEAMCALLs are on the right CPU, for any the user has made
available to the kernel.

4. Handle the race between updates and concurrent TD builds by
returning -EBUSY to userspace.

Everything else remains a userspace responsibility.

In the unlikely event the update fails, for example userspace picks an
incompatible update image, or the image is otherwise corrupted, all TDs
will experience SEAMCALL failures and be killed. The recovery of TD
operation from that event requires a reboot.

Given there is no mechanism to quiesce SEAMCALLs, the TDs themselves must
pause execution over an update. The most straightforward way to meet the
'pause TDs while update executes' constraint is to run the update in
stop_machine() context. All other evaluated solutions export more
complexity to KVM, or exports more fragility to userspace.

== How to test this series ==

NOTE: This v10 uses a new tdx_blob format. The scripts and module blobs in
https://github.com/intel/tdx-module-binaries have not yet been updated
to match this version. Those updates will be done separately later.

== Other information relevant to Runtime TDX module updates ==

=== TDX module versioning ===

Each TDX module is assigned a version number x.y.z, where x represents the
"major" version, y the "minor" version, and z the "update" version.

Runtime TDX module updates are restricted to Z-stream releases.

Note that Z-stream releases do not necessarily guarantee compatibility. A
new release may not be compatible with all previous versions. To address this,
Intel provides a separate file containing compatibility information, which
specifies the minimum module version required for a particular update. This
information is referenced by the tool to determine if two modules are
compatible.

=== TCB Stability ===

Updates change the TCB as viewed by attestation reports. In TDX there is
a distinction between "launch-time" version and "current" version where
runtime TDX module updates cause that "current" version number to change,
subject to Z-stream constraints.

The concern that a malicious host may attack confidential VMs by loading
insecure updates was addressed by Alex in [3]. Similarly, the scenario
where some "theoretical paranoid tenant" in the cloud wants to audit
updates and stop trusting the host after updates until audit completion
was also addressed in [4]. Users not in the cloud control the host machine
and can manage updates themselves, so they don't have these concerns.

See more about the implications of current TCB version changes in
attestation as summarized by Dave in [5].

=== TDX module Distribution Model ===

At a high level, Intel publishes all TDX modules on the github [2], along
with a mapping_file.json which documents the compatibility information
about each TDX module and a userspace tool to install the TDX module. OS
vendors can package these modules and distribute them. Administrators
install the package and use the tool to select the appropriate TDX module
and install it via the interfaces exposed by this series.

[1]: https://cdrdv2.intel.com/v1/dl/getContent/733584
[2]: https://github.com/intel/tdx-module-binaries
[3]: https://lore.kernel.org/all/665c5ae0-4b7c-4852-8995-255adf7b3a2f@amazon.com/
[4]: https://lore.kernel.org/all/5d1da767-491b-4077-b472-2cc3d73246d6@amazon.com/
[5]: https://lore.kernel.org/all/94d6047e-3b7c-4bc1-819c-85c16ff85abf@intel.com/



Chao Gao (24):
  x86/virt/tdx: Clarify try_init_module_global() result caching
  x86/virt/tdx: Move TDX global initialization states to file scope
  x86/virt/tdx: Consolidate TDX global initialization states
  x86/virt/tdx: Move TDX_FEATURES0 bits to asm/tdx.h
  coco/tdx-host: Introduce a "tdx_host" device
  coco/tdx-host: Expose TDX module version
  x86/virt/seamldr: Introduce a wrapper for P-SEAMLDR SEAMCALLs
  x86/virt/seamldr: Add a helper to retrieve P-SEAMLDR information
  coco/tdx-host: Expose P-SEAMLDR information via sysfs
  coco/tdx-host: Don't expose P-SEAMLDR information on CPUs with erratum
  coco/tdx-host: Implement firmware upload sysfs ABI for TDX module
    updates
  x86/virt/seamldr: Allocate and populate a module update request
  x86/virt/seamldr: Introduce skeleton for TDX module updates
  x86/virt/seamldr: Abort updates after a failed step
  x86/virt/seamldr: Shut down the current TDX module
  x86/virt/tdx: Reset software states during TDX module shutdown
  x86/virt/seamldr: Install a new TDX module
  x86/virt/seamldr: Do TDX global and per-CPU init after module
    installation
  x86/virt/tdx: Restore TDX module state
  x86/virt/tdx: Refresh TDX module version after update
  x86/virt/tdx: Reject updates during compatibility-sensitive operations
  x86/virt/tdx: Enable TDX module runtime updates
  coco/tdx-host: Document TDX module update compatibility criteria
  x86/virt/tdx: Document TDX module update

Kai Huang (1):
  x86/virt/tdx: Move low level SEAMCALL helpers out of <asm/tdx.h>

 .../ABI/testing/sysfs-devices-faux-tdx-host   |  66 ++++
 Documentation/arch/x86/tdx.rst                |  34 ++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/seamldr.h                |  36 ++
 arch/x86/include/asm/tdx.h                    |  66 +---
 arch/x86/include/asm/tdx_global_metadata.h    |   4 +
 arch/x86/include/asm/vmx.h                    |   1 +
 arch/x86/virt/vmx/tdx/Makefile                |   2 +-
 arch/x86/virt/vmx/tdx/seamcall_internal.h     | 109 ++++++
 arch/x86/virt/vmx/tdx/seamldr.c               | 324 ++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.c                   | 169 +++++----
 arch/x86/virt/vmx/tdx/tdx.h                   |   8 +-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c   |  17 +-
 drivers/virt/coco/Kconfig                     |   2 +
 drivers/virt/coco/Makefile                    |   1 +
 drivers/virt/coco/tdx-host/Kconfig            |   6 +
 drivers/virt/coco/tdx-host/Makefile           |   1 +
 drivers/virt/coco/tdx-host/tdx-host.c         | 231 +++++++++++++
 18 files changed, 965 insertions(+), 113 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-faux-tdx-host
 create mode 100644 arch/x86/include/asm/seamldr.h
 create mode 100644 arch/x86/virt/vmx/tdx/seamcall_internal.h
 create mode 100644 arch/x86/virt/vmx/tdx/seamldr.c
 create mode 100644 drivers/virt/coco/tdx-host/Kconfig
 create mode 100644 drivers/virt/coco/tdx-host/Makefile
 create mode 100644 drivers/virt/coco/tdx-host/tdx-host.c


base-commit: 5209e5bfe5cab593476c3e7754e42c5e47ce36de
-- 
2.52.0

