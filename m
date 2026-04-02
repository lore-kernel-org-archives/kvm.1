Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC772FD1A5;
	Thu,  2 Apr 2026 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111539; cv=none; b=K580D8qdQ3n8XSHjbz9p6Gp9Ia+ZCglcqsPd3sogSzWyGPSe6FTxp7KIwtxyUzSpyFsb4pDUAYDSQRWN3RgprKT49OP0isJFCXutKVQXGw0/QLoWlwAmdr6JSEFGiMVPEQeuEomLr4BjQwDmJK0tkdXEUWou3Qf+NdP/QF/MnQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111539; c=relaxed/simple;
	bh=sU8NdvYB4p/X7fUSQrVrKuq3xJYgUF+d7zRbuhI/TXo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LM/EE79kazWzEZcdZTIj0/J3AtSrp7nAKRuHTHD4yqzyYglGfUvfsoYo5UknTgkGUR/yw+BVoIl4WRri0fAzKF1CFcnrbpFL0f0XQgst/ZmJu+aXaiwvGvEgtmLM6FuNa+b/iQIibqit3p9Nsz+8LFMlEA7z2oopsyiC51S+AgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Si/WQyip; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Si/WQyip"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775111538; x=1806647538;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=sU8NdvYB4p/X7fUSQrVrKuq3xJYgUF+d7zRbuhI/TXo=;
  b=Si/WQyipzWgqpCCChKX1juAKPJKL3+Cwq0RqIFuEkdf9DrDRAn3IepGk
   DFmMgZkBGSmb9SIsN10FhweFijQdFQk/zDTbVp8mSHBweSxeeDF5IHztz
   /6pzfPOGqYYewi8l7Vtn+Mi8omS5z73/kCS8sxRPykgNCGNstV8U8U8oP
   WvauHstFAUNL/Q9oRABeUEgXJrLrelPWARkq/YxmrBq1xqjWNs6suR7AE
   0EeMbDRd10vxAM1qA5cCh9dI3G164H0AKLXYD40Ik/OipnpYX2KBU/qHG
   c0AIScfmvsN8ULcztG5+GISf6hBUEFqa//kcoyOgZHFx9Gps5yP5RPsl7
   g==;
X-CSE-ConnectionGUID: o0D3GYG/TZ6jQ5l9/ftL0g==
X-CSE-MsgGUID: 0bXVWd5fQOKjB+d17j+Uag==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="75884363"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="75884363"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 23:32:17 -0700
X-CSE-ConnectionGUID: T7OMjpdpRnuywTZ2HpIbrg==
X-CSE-MsgGUID: QcvLbLpVSKakejjBbE+TwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="222042373"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.124.223.130])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 23:32:16 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v3 0/5] Fuller TDX kexec support
Date: Thu, 02 Apr 2026 00:32:00 -0600
Message-Id: <20260402-fuller_tdx_kexec_support-v3-0-34438d7094bf@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WPyw6CMBBFf8V0bUkf0IIr/8MYAmWQKlIyLQRD+
 HcBXbhxNyeZOXfuTDygBU9Oh5kgjNZb160gjwdimqK7AbXVykQwoZjkmtZD2wLmoZryB0xgcj/
 0vcNAS6MzlcVKpyWQ9bxHqO20qy/XD/uhvIMJm2/bqNE9aWgQip8IphlnMkmjlGcqTiinaM0j6
 iOobmDcs4Sz7QK00Tpvksb64PC1FxjFFvYVCfn/11FQRlNdSBWzDFjCf5zXZVne5zvwHhcBAAA
 =
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
 Chao Gao <chao.gao@intel.com>, Kai Huang <kai.huang@intel.com>, 
 Kiryl Shutsemau <kas@kernel.org>
X-Mailer: b4 0.16-dev-ad80c
X-Developer-Signature: v=1; a=openpgp-sha256; l=8331;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=sU8NdvYB4p/X7fUSQrVrKuq3xJYgUF+d7zRbuhI/TXo=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDJnneDP31y3dmVN68uHmM2duVAuUTJc5oHgrkOWc7qVrz
 aemPE0R6ChlYRDjYpAVU2T5u+cj4zG57fk8gQmOMHNYmUCGMHBxCsBE+l4wMhztepbhHrZCZbrB
 zfhJa84pesgqn+LavGXqupMrPrGdu/GNkeH14lf1s9Pa4q5aLZ780LHr/JIfXzflsPbNLpI54pP
 JJscLAA==
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
    benefit them all from an early merge. This has now also been reduced
    to a simple header move, since the new additions in the original
    patch aren't needed here.

 2. A preparatory patch to move some straggling stuff into arch/x86 in the
    wake of the VMXON series. As noted in the discussion in v2, this
    may need coordination with Kai's patch [1] as they will cause a
    conflict depending on which is merged first.

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
[2], and was smoke tested with an engineering build of the TDX module
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
[1]: https://lore.kernel.org/lkml/20260312100009.924136-1-kai.huang@intel.com/
[2]: https://cdrdv2.intel.com/v1/dl/getContent/871617

---
Changes in v3:
- Various: Collect tags (Kai, Chao, Kiryl, Sean)
- Patch 1: Collapse to a simple header move, drop new defines, and
  non-architectural software defines. (Sean)
- Patch 2: Add WBINVD in the tdx_offline_cpu() path (Sean, Dave)
- Add a paragraph to the seamcall wrapper commit message talking about
  printed errors for seamcall failures (Rick)
- Patch 2: Reword comment in tdx_shutdown_cpu (Chao)
- Patch 3: Reword comment about the TDX_SYS_BUSY error case (Chao)
- Patch 3: Formatting fixes in comments (Kiryl)
- Link to v2: https://patch.msgid.link/20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com

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
      x86/tdx: Move TDX architectural error codes into <asm/shared/tdx_errno.h>

Rick Edgecombe (2):
      x86/virt/tdx: Pull kexec cache flush logic into arch/x86
      x86/virt/tdx: Remove kexec docs

Vishal Verma (2):
      x86/virt/tdx: Add SEAMCALL wrapper for TDH.SYS.DISABLE
      x86/tdx: Disable the TDX module during kexec and kdump

 Documentation/arch/x86/tdx.rst                       |  7 -------
 arch/x86/include/asm/shared/tdx.h                    |  1 +
 arch/x86/{kvm/vmx => include/asm/shared}/tdx_errno.h |  8 +++----
 arch/x86/include/asm/tdx.h                           |  9 +++-----
 arch/x86/kvm/vmx/tdx.h                               |  1 -
 arch/x86/virt/vmx/tdx/tdx.h                          |  1 +
 arch/x86/kernel/crash.c                              |  2 ++
 arch/x86/kernel/machine_kexec_64.c                   | 16 --------------
 arch/x86/kvm/vmx/tdx.c                               | 10 ---------
 arch/x86/virt/vmx/tdx/tdx.c                          | 64 +++++++++++++++++++++++++++++++++++++++++++++-----------
 10 files changed, 63 insertions(+), 56 deletions(-)

--
2.53.0

---
Kiryl Shutsemau (1):
      x86/tdx: Move TDX architectural error codes into <asm/shared/tdx_errno.h>

Rick Edgecombe (2):
      x86/virt/tdx: Pull kexec cache flush logic into arch/x86
      x86/virt/tdx: Remove kexec docs

Vishal Verma (2):
      x86/virt/tdx: Add SEAMCALL wrapper for TDH.SYS.DISABLE
      x86/tdx: Disable the TDX module during kexec and kdump

 Documentation/arch/x86/tdx.rst                     |  7 ---
 arch/x86/include/asm/shared/tdx.h                  |  1 +
 .../{kvm/vmx => include/asm/shared}/tdx_errno.h    |  8 +--
 arch/x86/include/asm/tdx.h                         |  9 +--
 arch/x86/kvm/vmx/tdx.h                             |  1 -
 arch/x86/virt/vmx/tdx/tdx.h                        |  1 +
 arch/x86/kernel/crash.c                            |  2 +
 arch/x86/kernel/machine_kexec_64.c                 | 16 ------
 arch/x86/kvm/vmx/tdx.c                             | 10 ----
 arch/x86/virt/vmx/tdx/tdx.c                        | 64 ++++++++++++++++++----
 10 files changed, 63 insertions(+), 56 deletions(-)
---
base-commit: f630de1f8d70d7e29e12bc25dc63f9c5f771dc59
change-id: 20260317-fuller_tdx_kexec_support-bc79694678be

Best regards,
--  
Vishal Verma <vishal.l.verma@intel.com>

