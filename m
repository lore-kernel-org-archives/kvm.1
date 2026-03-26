Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424123750C9;
	Thu, 26 Mar 2026 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514735; cv=none; b=n2o2GFLhc42iRLgS/GVjQS8Yjc7QzC0+wcx9I5lrpuagvHGfdU6apxG+egNqAaTldGkgQwHXRiYZ2mu/DEp/0tnMdBJV8I1m75jZRfKnsIXJtUZ/nG7FtPJ852GS+1BmZIQjdf/qc/BAKSLFDLJkH92k4RFiBUrsSbRW+pAx9TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514735; c=relaxed/simple;
	bh=MZXqAQ4zdN0f57LW1dQvAf0WZXspZu5jCd0wgZsCdgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KxoGPdp+WgQN6YWymR7WQ0WZYagNfxncU4m/EZM+PWtpjtGByNd0lo9ruId0OMtv+6FVn1NdUtsW+oRYc8a14L74Dv8Q5eMo4CytWpm0yCdWdSg/p5adalflw9udNdc9kUh5xek38qVwvINsDo5nfeVjZnxTNcj/vwKZ9upBPy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EwsdCVkP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EwsdCVkP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774514734; x=1806050734;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MZXqAQ4zdN0f57LW1dQvAf0WZXspZu5jCd0wgZsCdgo=;
  b=EwsdCVkPl7vKpE/R4aashuVyUaa1/vGsKiJkgvMNjkCr5lLhm9NbVYSx
   jvuWSPydzTzrWK8z/7+0Hhle01Rety3uzhmPB5z0trsS0Fb9ge8qmynxG
   rS5gPg3N+Is1fuc5VWpDv95F2q/xez+TnBlqzQYHCjYFkeY5YmBoxRNpM
   QwN/dxIw0zTFnzB5B3jMGBmvmajroiNw4b2tvcENakPt3fIMXEuetMGnK
   gl4ASaTvakp1LrS6h4msX/H8JM5wx1JRZCeXAvkgnJfG4RcuoLVpYFPZT
   w5petoINT69HLGjOt++eStOLboO2biA+hzqO/oxD+wKoIiCDQS8g5f7kO
   A==;
X-CSE-ConnectionGUID: IgwegF/TRXmKpit9uSM0ww==
X-CSE-MsgGUID: 9vyEHQcsTOqQs18rPkqXvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86644588"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="86644588"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:19 -0700
X-CSE-ConnectionGUID: KrjmwmSpR3ClGl/AM/ULPw==
X-CSE-MsgGUID: 175/2mEpQ8iqKRCH2ivF6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224967090"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:14 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	x86@kernel.org
Cc: binbin.wu@linux.intel.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
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
	Borislav Petkov <bp@alien8.de>,
	Clark Williams <clrkwllms@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH v6 00/22] Runtime TDX module update support
Date: Thu, 26 Mar 2026 01:43:51 -0700
Message-ID: <20260326084448.29947-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reviewers,

Please review patches 6 and 17; others already have 2+ RB tags.

Patch 6 was reworked to use is_visible() for attribute visibility (which is
the standard practice), so previous RB tags were dropped. Patch 17 has
fewer reviews so far and needs another look.

I believe this series is quite mature and also self-contained (no impact to
the rest of kernel unless an update is triggered through the dedicated
sysfs ABIs). I'm hoping it can be merged for 7.1.

Changelog:
v5->v6:
 - use TDX_VERSION_FMT macro [Dave/Kiryl]
 - use is_visible() to control seamldr attribute visibility [Yilun]
 - drop revision/chapter numbers when referring to a spec [Kiryl/Xiaoyao]
 - change update failure indicator from int to boolean [Kiryl]
 - reset tdx_lp_initialized for offlined CPUs [Kai]
 - add a wrapper for seamldr_call(P_SEAMLDR_INSTALL..) [Kiryl]
 - clarify the "do nothing" choice when collision detection isn't
   supported [Kai/Kiryl]
 - other minor code changes, changelog improvements and typo fixes [Kiryl/Kai/Xiaoyao]
 - collect review tags from Kiryl/Kai
 - v5: https://lore.kernel.org/kvm/20260315135920.354657-1-chao.gao@intel.com/

(For transparency, note that I used AI tools to help proofread this
cover-letter and commit messages)

This series adds support for runtime TDX module updates that preserve
running TDX guests. It is also available at:

  https://github.com/gaochaointel/linux-dev/commits/tdx-module-updates-v6/

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

Implement a TDX module update facility via the fw_upload mechanism. Given
that there is variability in which module update to load based on features,
fix levels, and potentially reloading the same version for error recovery
scenarios, the explicit userspace chosen payload flexibility of fw_upload
is attractive.

This design allows the kernel to accept a bitstream instead of loading a
named file from the filesystem, as the module selection and policy
enforcement for TDX modules are quite complex (see patch "coco/tdx-host:
Implement firmware upload sysfs ABI for TDX module updates"). By doing
so, much of this complexity is shifted out of the kernel. The kernel
needs to expose information, such as the TDX module version, to
userspace.  Userspace must understand the TDX module versioning scheme
and update policy to select the appropriate TDX module (see "TDX module
Versioning" below).

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

First, load kvm-intel.ko and tdx-host.ko if they haven't been loaded:

 # modprobe -r kvm_intel
 # modprobe kvm_intel tdx=1
 # modprobe tdx-host

Then, use the userspace tool below to select the appropriate TDX module and
install it via the interfaces exposed by this series:

 # git clone https://github.com/intel/tdx-module-binaries
 # cd tdx-module-binaries
 # python version_select_and_load.py --update

this version changes the firmware directory name from seamldr_upload to
tdx_module, so, below change should be applied to version_select_and_load.py:

diff --git a/version_select_and_load.py b/version_select_and_load.py
index 2193bd8..6a3b604 100644
--- a/version_select_and_load.py
+++ b/version_select_and_load.py
@@ -38,7 +38,7 @@ except ImportError:
     print("Error: cpuid module is not installed. Please install it using 'pip install cpuid'")
     sys.exit(1)

-FIRMWARE_PATH = "/sys/class/firmware/seamldr_upload"
+FIRMWARE_PATH = "/sys/class/firmware/tdx_module"
 MODULE_PATH = "/sys/devices/faux/tdx_host"
 SEAMLDR_PATH = "/sys/devices/faux/tdx_host/seamldr"
 allow_debug = False


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



Chao Gao (21):
  coco/tdx-host: Introduce a "tdx_host" device
  coco/tdx-host: Expose TDX module version
  x86/virt/seamldr: Introduce a wrapper for P-SEAMLDR SEAMCALLs
  x86/virt/seamldr: Add a helper to retrieve P-SEAMLDR information
  coco/tdx-host: Expose P-SEAMLDR information via sysfs
  coco/tdx-host: Implement firmware upload sysfs ABI for TDX module
    updates
  x86/virt/seamldr: Allocate and populate a module update request
  x86/virt/seamldr: Introduce skeleton for TDX module updates
  x86/virt/seamldr: Abort updates if errors occurred midway
  x86/virt/seamldr: Shut down the current TDX module
  x86/virt/tdx: Reset software states during TDX module shutdown
  x86/virt/seamldr: Install a new TDX module
  x86/virt/seamldr: Do TDX per-CPU initialization after updates
  x86/virt/tdx: Restore TDX module state
  x86/virt/tdx: Update tdx_sysinfo and check features post-update
  x86/virt/tdx: Avoid updates during update-sensitive operations
  coco/tdx-host: Don't expose P-SEAMLDR features on CPUs with erratum
  x86/virt/tdx: Enable TDX module runtime updates
  coco/tdx-host: Document TDX module update compatibility criteria
  x86/virt/tdx: Document TDX module update
  x86/virt/seamldr: Log TDX module update failures

Kai Huang (1):
  x86/virt/tdx: Move low level SEAMCALL helpers out of <asm/tdx.h>

 .../ABI/testing/sysfs-devices-faux-tdx-host   |  75 ++++
 Documentation/arch/x86/tdx.rst                |  36 ++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/seamldr.h                |  37 ++
 arch/x86/include/asm/tdx.h                    |  64 +---
 arch/x86/include/asm/tdx_global_metadata.h    |   5 +
 arch/x86/include/asm/vmx.h                    |   1 +
 arch/x86/kvm/vmx/tdx_errno.h                  |   2 -
 arch/x86/virt/vmx/tdx/Makefile                |   2 +-
 arch/x86/virt/vmx/tdx/seamcall_internal.h     | 109 ++++++
 arch/x86/virt/vmx/tdx/seamldr.c               | 335 ++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.c                   | 166 ++++++---
 arch/x86/virt/vmx/tdx/tdx.h                   |  11 +-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c   |  20 ++
 drivers/virt/coco/Kconfig                     |   2 +
 drivers/virt/coco/Makefile                    |   1 +
 drivers/virt/coco/tdx-host/Kconfig            |  12 +
 drivers/virt/coco/tdx-host/Makefile           |   1 +
 drivers/virt/coco/tdx-host/tdx-host.c         | 250 +++++++++++++
 19 files changed, 1027 insertions(+), 103 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-faux-tdx-host
 create mode 100644 arch/x86/include/asm/seamldr.h
 create mode 100644 arch/x86/virt/vmx/tdx/seamcall_internal.h
 create mode 100644 arch/x86/virt/vmx/tdx/seamldr.c
 create mode 100644 drivers/virt/coco/tdx-host/Kconfig
 create mode 100644 drivers/virt/coco/tdx-host/Makefile
 create mode 100644 drivers/virt/coco/tdx-host/tdx-host.c


base-commit: 0f409eaea53e49932cf92a761de66345c9a4b4be
-- 
2.47.3

