Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512BB53E0B;
	Mon, 27 Apr 2026 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303796; cv=none; b=Zvzqb3Zy4l9ZoWHrXDAe0CKV/PZTIkI1XH5mba4sKr2jg76bHEcP57lpUPbA7jYJSNngr5K2p0GC1D69qmuLTCGukPbQfcY05tAgxsL0EzQ0UUSbdWkaC2xGoRcPb9qThmXaaiK3Uvud/Kpe6+pVkqDEsYcAZ4k4bOlniRM16PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303796; c=relaxed/simple;
	bh=2qHTZAAEVoFT0sqVhae3VU4n2S3snDozBk1Ul02dRms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OYsoe1MC0X1omgITnGuZvBsUGBpdMXH7Z7nBxWOJXtQ/gOLCfY7m2SXOqklsL6lnWqHM77ApGBpvk0Xl7V6GU5mrWzr9sWmXC4a+Ff11gejXccyrmYjT8hUs2fM/3Wm53r8hZY8D+M6oxj7ri4P4SY4Oa1NC0WU7gBDFfWJSgfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZtgCGQTE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZtgCGQTE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777303793; x=1808839793;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2qHTZAAEVoFT0sqVhae3VU4n2S3snDozBk1Ul02dRms=;
  b=ZtgCGQTEfEqCqo8y25UZy0Re5G5zmEQ+fbn41575ZDT1L/1ntGJZFBKH
   j6cYN5EuM/TkTJ5MER20/kzg1Y/FV7xSSjroRAMAsRMuKO0ITgbW9Pj14
   5HIPFgA66xYXs+14j+C75o9KCuVOMbBJbsIwUHE7uc6NtB0+QSdQJfKlV
   JpkF2eavhnLYbIpQdo5aGGB2A3SQyAxoZNXwXKcn7Jh7SXJdEQsGULwrg
   /iy1IswWbMnMlXgSu4MDEXYdBiIaBPVE2p1fglg4J4/CF7aL5zVNo7TDy
   rpgK/JmUbBMrX1o0po9mnCIXwS4ZRp78LEICQbmuG3a06LHIY4z6wRqbD
   Q==;
X-CSE-ConnectionGUID: b0X7Ef9QQt2U16A9AboPJQ==
X-CSE-MsgGUID: ztNYtldTSImpOa0M7orqoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77900620"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77900620"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:29:53 -0700
X-CSE-ConnectionGUID: jmP0XnWES9KMqyIpf34WYw==
X-CSE-MsgGUID: /nzgOp57Sc6cWCZffaP3jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="232673186"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:29:53 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
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
Subject: [PATCH v8 00/21] Runtime TDX module update support
Date: Mon, 27 Apr 2026 08:27:54 -0700
Message-ID: <20260427152854.101171-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reviewers,

This v8 mainly addresses issues raised by Rick and collects his Reviewed-by
tags.

The most notable changes are removing pieces that are not strictly needed
for the basic runtime update support and tightening several commit messages
to make them more direct and to the point. In particular, patches 08 and 15
were substantially rewritten, and commit messages for patches 16 and 17 were
reworked, so those would benefit from another review. The rest of the
series has only minor changes. I'm hoping this series can be merged for 7.2.

Changelog:
v7->v8:
- rebase onto v7.1-rc1 to resolve conflicts with the merged VMXON series
- flatten the P-SEAMLDR sysfs ABI by exposing seamldr_version and
  num_remaining_updates directly under /sys/devices/faux/tdx_host/,
  and clarify when they are visible
- don't preemptively handle "PAGE_SIZE != 4KB" case
- tighten the fw_upload ABI: return FW_UPLOAD_ERR_BUSY for TD-build
  contention and collapse other update failures to firmware-invalid
- consolidate tdx_blob validation in a separate function and clarify
  what is validated by the kernel vs. P-SEAMLDR
- rework the changelog of aborting updates on any failure; always use
  READ_ONCE()/WRITE_ONCE() for the shared "failed" flag access
- rewrite the changelog of handling the race between updates and TD
  builds; always pass the compat flag to TDH.SYS.SHUTDOWN
- refresh only the TDX module update_version after a successful update;
  drop the broader post-update metadata/feature checks
- explain the kernel's role and responsibilities in TDX module updates
  in the cover letter
- collect new review/ack tags
- minor typo and wording fixes
- v7: https://lore.kernel.org/kvm/20260331124214.117808-1-chao.gao@intel.com/

(For transparency, note that I used AI tools to help proofread this
cover-letter and commit messages)

This series adds support for runtime TDX module updates that preserve
running TDX guests. It is also available at:

  https://github.com/gaochaointel/linux-dev/commits/tdx-module-updates-v8/

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

Use the userspace tool below to select the appropriate TDX module and
install it via the interfaces exposed by this series:

 # git clone https://github.com/intel/tdx-module-binaries
 # cd tdx-module-binaries
 # python version_select_and_load.py --update

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
a distinction between launch-time version and current version where
runtime TDX module updates cause that latter version number to change,
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


Chao Gao (20):
  coco/tdx-host: Introduce a "tdx_host" device
  coco/tdx-host: Expose TDX module version
  x86/virt/seamldr: Introduce a wrapper for P-SEAMLDR SEAMCALLs
  x86/virt/seamldr: Add a helper to retrieve P-SEAMLDR information
  coco/tdx-host: Expose P-SEAMLDR information via sysfs
  coco/tdx-host: Implement firmware upload sysfs ABI for TDX module
    updates
  x86/virt/seamldr: Allocate and populate a module update request
  x86/virt/seamldr: Introduce skeleton for TDX module updates
  x86/virt/seamldr: Shut down the current TDX module
  x86/virt/tdx: Reset software states during TDX module shutdown
  x86/virt/seamldr: Install a new TDX module
  x86/virt/seamldr: Do TDX per-CPU initialization after module
    installation
  x86/virt/tdx: Restore TDX module state
  x86/virt/tdx: Refresh TDX module version after update
  x86/virt/tdx: Reject updates during concurrent TD build
  x86/virt/seamldr: Abort updates on failure
  coco/tdx-host: Don't expose P-SEAMLDR features on CPUs with erratum
  x86/virt/tdx: Enable TDX module runtime updates
  coco/tdx-host: Document TDX module update compatibility criteria
  x86/virt/tdx: Document TDX module update

Kai Huang (1):
  x86/virt/tdx: Move low level SEAMCALL helpers out of <asm/tdx.h>

 .../ABI/testing/sysfs-devices-faux-tdx-host   |  67 ++++
 Documentation/arch/x86/tdx.rst                |  36 ++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/seamldr.h                |  37 ++
 arch/x86/include/asm/tdx.h                    |  69 ++--
 arch/x86/include/asm/tdx_global_metadata.h    |   4 +
 arch/x86/include/asm/vmx.h                    |   1 +
 arch/x86/kvm/vmx/tdx_errno.h                  |   2 -
 arch/x86/virt/vmx/tdx/Makefile                |   2 +-
 arch/x86/virt/vmx/tdx/seamcall_internal.h     | 109 ++++++
 arch/x86/virt/vmx/tdx/seamldr.c               | 330 ++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.c                   | 157 ++++++---
 arch/x86/virt/vmx/tdx/tdx.h                   |   9 +-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c   |  17 +-
 drivers/virt/coco/Kconfig                     |   2 +
 drivers/virt/coco/Makefile                    |   1 +
 drivers/virt/coco/tdx-host/Kconfig            |  12 +
 drivers/virt/coco/tdx-host/Makefile           |   1 +
 drivers/virt/coco/tdx-host/tdx-host.c         | 221 ++++++++++++
 19 files changed, 970 insertions(+), 108 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-faux-tdx-host
 create mode 100644 arch/x86/include/asm/seamldr.h
 create mode 100644 arch/x86/virt/vmx/tdx/seamcall_internal.h
 create mode 100644 arch/x86/virt/vmx/tdx/seamldr.c
 create mode 100644 drivers/virt/coco/tdx-host/Kconfig
 create mode 100644 drivers/virt/coco/tdx-host/Makefile
 create mode 100644 drivers/virt/coco/tdx-host/tdx-host.c


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.1

