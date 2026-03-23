Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C8B3E63B1;
	Mon, 23 Mar 2026 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774299562; cv=none; b=XXOVQG4XPtTcOU283dK9t0BVm4ZY5a556NFEMWnpq4TJNi+SOIhPn0c8yMvt/cVD9W5hY/DFTyBC/Wtfj313VxO+rkfOxVkEwe1rRW2F3EyhphKS9FtJVudpaR1UR0ZaUKPAEB8t6eNoGeVQ4h0JnquH6oA/c27e7ir+PM4vQoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774299562; c=relaxed/simple;
	bh=13NpKMoBJ+FHJKpREai3gRyzjuVCf9u9LDtVyZ0kVkk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gKOC+tZtXm5kZIHDiynk9UWJVEMJvF1WvKe5ZSaKUANljVjjY6OGFsQk/Lcnq4PmgTdZlTGSPyLhgfx/XDuP/AoGXvfdRiji3SHuUUQMTq1jx0WdktZp1mcKHh+SzIOCoJ4EKyZsIbt4kJ//PvuZiYCPHxmYQlb2cjNysQShBwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kr0nnkUh; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kr0nnkUh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774299561; x=1805835561;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=13NpKMoBJ+FHJKpREai3gRyzjuVCf9u9LDtVyZ0kVkk=;
  b=Kr0nnkUh+Mv/PIs2IjZacY43Z+KACN/4Uxu5hkj7jrCJvoHdkEghJIsz
   8Lo/CVhPlY3Qzlbog6nlXF0iiPjyqiUlGX3SkYCT508T5A3a5u+c6dIS0
   LkjebcbXu85TmyjG4h969M3R4ea8wFuy+Px9D5gQ9bICku43xw5Rn0bia
   nkDqkZn4h2jYLs1kmRby3QhyQjO5xcR1IR7j5UVQalTfZyDDACpMai7b/
   0bWkn4VrpfN5+4c2HQuOuQd9QKBZchh0NkZjDPoHxlzKoPlpXAFvznauL
   0Xc/yB8qa1ngEcWoePTwyxXH4SpS+PMff0nMtzfNFuwDf4NolEYfSDOXR
   g==;
X-CSE-ConnectionGUID: ab4ricdwRmyQy1aFkGcjbw==
X-CSE-MsgGUID: pK8TDtDoSwu78ZCOoo7JoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="74491130"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="74491130"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 13:59:20 -0700
X-CSE-ConnectionGUID: 8Kyhv08cRz6OtWGSVSEgEg==
X-CSE-MsgGUID: sdPjfV4QRkSc74pvfy3wrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="224156851"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.124.221.51])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 13:59:19 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 0/5] Fuller TDX kexec support
Date: Mon, 23 Mar 2026 14:59:03 -0600
Message-Id: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02Nyw6DIBREf6VhXQj4AO2q/9E0RvCq1Be5YGNi/
 Pdiu+luTjJzZice0IInt8tOEN7W22WOkFwvxPT13AG1TWSS8ETyVCjaruMIWIVmqwbYwFR+dW7
 BQLVRpSwzqQoNJM4dQmu3r/rx/LFf9QtMOH1no8VloqFHqP8uuOKCp3nBClHKLKeCojUDcwyaD
 swyabjbOcDIYibH8QH1Xa61wQAAAA==
X-Change-ID: 20260317-fuller_tdx_kexec_support-bc79694678be
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>, 
 Kai Huang <kai.huang@intel.com>, Kiryl Shutsemau <kas@kernel.org>
X-Mailer: b4 0.16-dev-8c19c
X-Developer-Signature: v=1; a=openpgp-sha256; l=7369;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=13NpKMoBJ+FHJKpREai3gRyzjuVCf9u9LDtVyZ0kVkk=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDJkHVy6ccjDFKNO1NnJmzrrCMoHDv5h0L5gEJLxkuxLHl
 bC7sFC4o5SFQYyLQVZMkeXvno+Mx+S25/MEJjjCzGFlAhnCwMUpABPJ42JkODj74J51YbdO/aj8
 mPhyyXuRyzyWs49bXV3qccrv1A9LywJGhq037whaNLUYLZyxSfXG5dzrJb0x/fs03rfos9w6KRh
 Uwg4A
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

Hi,

This series adds a couple of cool things -
 1. Allow kexec and kdump on systems with the partial write errata
 2. Allow using TDX in the second (kexec'ed) kernel

It has been waiting for VMXON refactor to land because the implementation
is much cleaner on top of that.

KVM folks, just a few deletions on your side and the long discussed moving
of tdx_errno.h. Tip folks and reviewers, the changes here are pretty small.
Optimistically, I'm hoping we can iterate this quickly and see it off the
list in the next few weeks.

Background
==========
Some early TDX-capable platforms have an erratum where a partial write
to TDX private memory can cause a machine check on a subsequent read.
Currently, kexec and kdump are disabled on these platforms because the
new (or kdump) kernel may trip over these, causing a machine check.

Future TDX modules will support TDH.SYS.DISABLE SEAMCALL, which disables
the TDX module and reclaims all memory resources allocated to TDX, and
cleans up any poison. After this SEAMCALL succeeds, the new kernel
can also re-initialize the TDX module from scratch via the normal bring-up
sequence.

It is probably worth mentioning that this is a different kind of cleanup
than the WBINVD stuff that was the cause of all the fuss in the earlier
kexec enabling. The WBINVD is flushing private keyid cachelines so they
are not later written back over the new kernels memory. It needs to happen
after the last SEAMCALL that might have produced them. So this new
SEAMCALL is for something else, but also needs to be slotted with respect
to WBINVD.

Implementation
==============
The series adds:

 1. A pre-requisite patch to move TDX error code definitions to a
    shared location so that TDX_INTERRUPTED_RESUMABLE etc. are
    accessible from arch/x86/virt/vmx/tdx/. This comes from the Dynamic
    PAMT series [0], but is also needed by some other series, and can
    benefit them all from an early merge.

 2. A preparatory patch to move some straggling stuff into arch/x86 in the
    wake of the VMXON series.

 3. A tdx_sys_disable() helper that wraps calls TDH.SYS.DISABLE with a
    retry loop to handle TDX_INTERRUPTED_RESUMABLE.

 4. Integration into the kexec path: Remove the check for partial write
    errata platforms as this is addressed by the SEAMCALL clearing any
    poisoned memory locations. Call tdx_sys_disable() in tdx_shutdown
    which is called via syscore ops in the kexec path. Call
    tdx_sys_disable() in native_machine_crash_shutdown() to cover the
    crash (kdump) path.

 5. A patch to update (remove) the kexec section in TDX docs.

Testing
=======
The implementation is based on the draft TDX module spec available at
[1], and was smoke tested with an engineering build of the TDX module
that supports the new SEAMCALL. The new kernel was able to initialize
the TDX module successfully:

  kvm: exiting hardware virtualization
  kexec_core: Starting new kernel
  Linux version 7.0.0-rc2-g0077f702b21c...
  ...
  virt/tdx: 1034220 KB allocated for PAMT
  virt/tdx: TDX-Module initialized

All the other TDX CI tests pass, and some other scenarios that were
manually tested and also pass or behave as expected:
 - Running on a completely non-TDX system
 - Running on a TDX capable system with an old module
 - Running on a TDX capable system where the module hasn't been
   initialized

During development further testing was done by mocking up the new
SEAMCALL to introduce delays and exercise the retry loops, combined with
kexec, kdump, reboot and shutdown flows.

Base
====
This series is based on the vmxon branch Sean pushed to kvm_x86,
kvm-x86-vmxon-2026.03.05.

[0]: https://lore.kernel.org/kvm/20260129011517.3545883-11-seanjc@google.com/
[1]: https://cdrdv2.intel.com/v1/dl/getContent/871617

---
Changes in v2:
- Use patch 1 from the DPAMT series with other feedback (Kai)
- Fix commit message typo (s/adjust_/adjust /)
- In patch 2, drop "too late to be helpful" in favor of something more
  explicit (Kai)
- Fix commit message typo in patch 2 (s/both/bother/)
- In patch 2, add a bit about dropping the TDX specific WBINVD (Kai)
- Reword some commit logs to use the imperative mood (Chao)
- Kai raised offline that TDH.SYS.DISABLE can return TDX_SYS_BUSY too.
  In theory this could happen if another SEAMCALL happens concurrently,
  however that contention should be short lived. Update the loop to
  continue on a TDX_SYS_BUSY error code too. (Kai)
- Patch 3: Add a print for SEAMCALL errors reported by the TDX module
  (excluding SW errors like #UD and #GP) (Kiryl)
- Patch 3: Add a sentence to the log about skipping enumeration for the
  new SEAMCALL (Kiryl)
- Adjust the patch 4 subject (Chao)
- Add a new patch to update the docs (Chao)
- Smoke test with TDX module engineering build with the new SEAMCALL.

Kiryl Shutsemau (1):
      x86/tdx: Move all TDX error defines into <asm/shared/tdx_errno.h>

Rick Edgecombe (2):
      x86/virt/tdx: Pull kexec cache flush logic into arch/x86
      x86/virt/tdx: Remove kexec docs

Vishal Verma (2):
      x86/virt/tdx: Add SEAMCALL wrapper for TDH.SYS.DISABLE
      x86/tdx: Disable the TDX module during kexec and kdump

 Documentation/arch/x86/tdx.rst                       |  7 -------
 arch/x86/include/asm/shared/tdx.h                    |  1 +
 arch/x86/{kvm/vmx => include/asm/shared}/tdx_errno.h | 29 +++++++++++++++++++++++------
 arch/x86/include/asm/tdx.h                           | 30 +++---------------------------
 arch/x86/kvm/vmx/tdx.h                               |  1 -
 arch/x86/virt/vmx/tdx/tdx.h                          |  1 +
 arch/x86/kernel/crash.c                              |  2 ++
 arch/x86/kernel/machine_kexec_64.c                   | 16 ----------------
 arch/x86/kvm/vmx/tdx.c                               | 10 ----------
 arch/x86/virt/vmx/tdx/tdx.c                          | 54 ++++++++++++++++++++++++++++++++++++++++++------------
 10 files changed, 72 insertions(+), 79 deletions(-)

--
2.53.0

---
Kiryl Shutsemau (1):
      x86/tdx: Move all TDX error defines into <asm/shared/tdx_errno.h>

Rick Edgecombe (2):
      x86/virt/tdx: Pull kexec cache flush logic into arch/x86
      x86/virt/tdx: Remove kexec docs

Vishal Verma (2):
      x86/virt/tdx: Add SEAMCALL wrapper for TDH.SYS.DISABLE
      x86/tdx: Disable the TDX module during kexec and kdump

 Documentation/arch/x86/tdx.rst                     |  7 ---
 arch/x86/include/asm/shared/tdx.h                  |  1 +
 .../{kvm/vmx => include/asm/shared}/tdx_errno.h    | 29 +++++++++---
 arch/x86/include/asm/tdx.h                         | 30 ++----------
 arch/x86/kvm/vmx/tdx.h                             |  1 -
 arch/x86/virt/vmx/tdx/tdx.h                        |  1 +
 arch/x86/kernel/crash.c                            |  2 +
 arch/x86/kernel/machine_kexec_64.c                 | 16 -------
 arch/x86/kvm/vmx/tdx.c                             | 10 ----
 arch/x86/virt/vmx/tdx/tdx.c                        | 54 +++++++++++++++++-----
 10 files changed, 72 insertions(+), 79 deletions(-)
---
base-commit: f630de1f8d70d7e29e12bc25dc63f9c5f771dc59
change-id: 20260317-fuller_tdx_kexec_support-bc79694678be

Best regards,
--  
Vishal Verma <vishal.l.verma@intel.com>

