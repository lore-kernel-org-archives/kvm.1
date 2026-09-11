Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2712C440A3E;
	Fri, 11 Sep 2026 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162792; cv=none; b=DD3VA15epkWMuO7sX1OPjlpp3RL2gt1xZucvuHqigkH23fHZ4mT9kzt+ExI3Bsxs0QIrgd1HiaIAJgIsVoHQbIok2WaZlci/WVHhzlUBPvhsQnw1QTv+OqXncUJv6xqE3+1Aa8ji1hj3WXvBHsKsbD65vQ5gqMtdRqzzslrqPa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162792; c=relaxed/simple;
	bh=u5Uj/sLhFrwSk/XRCfsg5XAVHW8FyIsbp8MqrEGZe+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cIotsI/CrHTYkHGhrKQXUFLiFEu41l5pPP1yLFdKk4XsP5VjOmd8WGQyxwJogzJjXhBeZn0HQanBvjCz05UQHZPtjjpSi07uLTFiAQGkJIJF8Fgn4B1DLH6JC6P0QDvm3BXumsOf2KOpwLhcFB8gfst80C97PbPYj2ym/v12mR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bmCE7f6E; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmCE7f6E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162789; x=1820698789;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u5Uj/sLhFrwSk/XRCfsg5XAVHW8FyIsbp8MqrEGZe+I=;
  b=bmCE7f6Eo/WFUqg/mDlSue++VbQTXG9J2jJ3fojDilwX6SgPfFhLOLl3
   hCEQwYy5R76VKd+78lh68TsDZOtWJbO5kJ27vregUq4p0U85CicMfFNSz
   0cOG4ZsMvm2i5LIAVPrvWnug01LtNNs2KUaB59ihE8DnksuUkt4HdMsyD
   F0VXPz+gJ5rKrs4GAsLp0SbC0uvmajaBMiouxdx4SeiZJkQURaJiZMwXr
   ux32b/PgC8tK48oAAmUdCcLGOOTXkAMO4EbtnDNPl8YhlmpSEBRymP/lz
   fH3Mr/J1kA2dkhd53v5JG3xBQapGY6W/+qnZIyDECRIRHYopLKQb1Gr3+
   Q==;
X-CSE-ConnectionGUID: p5N3UVV5RIKin55wtg2NcQ==
X-CSE-MsgGUID: oQvvNjabSQ6i68vX/41qpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572354"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572354"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:39:48 -0700
X-CSE-ConnectionGUID: ZoYoFS37QSmEvU5iKwRx9A==
X-CSE-MsgGUID: SJanofLLSLisP5/rH+MmjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272003892"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:39:47 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v10 00/28] KVM: Enable FRED support with KVM VMX
Date: Fri, 11 Sep 2026 14:36:30 -0700
Message-ID: <20260911213659.2025974-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series enables Intel flexible return and event delivery (FRED) with
KVM VMX to allow guests to utilize FRED.

Change of personnel
-------------------
The patches are being posted after a while. Xin asked me to post the
patches on his behalf but almost all the work in v10 has been done by
him. Many thanks!

I mainly rebased the patches to the latest kvm-x86/next branch and fixed
a handful of issues reported during internal testing and basic AI
reviews. I've avoided making any major code changes or commit message
updates as this is the first iteration that I am posting. 

Going forward, based on the feedback, I'll rework the patches as needed.
I've listed a few opens below that need additional discussion or
clarification. I'm relatively new to the KVM subsystem, so please feel
free to provide suggestions on the series structure, code organization
as well as commit log clarity to smoothen the review process.

FRED Background
---------------
The FRED architecture defines simple new transitions that change
privilege level (ring transitions), designed with two goals:

1) Improve overall performance and response time by replacing event
   delivery through the interrupt descriptor table (IDT event delivery)
   and event return by the IRET instruction with lower latency
   transitions.

2) Improve software robustness by ensuring that event delivery
   establishes the full supervisor context and that event return
   establishes the full user context.

FRED event delivery can effect a transition from ring 3 to ring 0, but it
is used also to deliver events incident to ring 0. One FRED instruction
(ERETU) effects a return from ring 0 to ring 3, while the other (ERETS)
returns while remaining in ring 0.

Intel VMX is extended to run FRED guests, and the major changes are:

1) New VMCS fields for FRED context management: two new event data VMCS
   fields, eight new guest FRED context VMCS fields and eight new host
   FRED context VMCS fields.

2) VMX nested-exception support for proper virtualization of the stack
   levels introduced with the FRED architecture.

For details refer the latest Intel FRED specification which was released
in June 2025 as version 9.0.

Patch structure
---------------
Patches   1-6: Enable the VMX controls and export the host stacks
Patches  7-19: Virtualize the FRED context and advertise it to userspace
Patches 20-25: Extend FRED virtualization to nested VMX
Patches 26-28: Some basic selftests

These patches are also available at:
  https://github.com/sohilmeh/linux-dev/tree/fred-kvm-v10

Main changes in v10
-------------------
 - New patches:
    Emulator CR4 write mask (patch 15)
    CR4.FRED handling on RSM (patch 17)
    Three selftests (patches 26-28)
 - Folded the FRED MSRs into a struct with read/write helpers, and filter all
   nine of them in the nested MSR bitmap instead of just RSP0
 - Improved event data handling including save/restore of the event data
   via KVM_{GET,SET}_VCPU_EVENTS
 - Restructured the nested interruption-information checks as a switch on
   interruption type, and reject bit 13 for non-hardware exceptions
 - Cleared FRED in svm_set_cpu_caps()
 - Reject vmcs12 secondary VM-exit controls KVM doesn't advertise to L1
 - Added MSR_IA32_VMX_EXIT_CTLS2 to the emulated MSR list
 - Updated the author field from Xin's Intel email address to the new one.
 - Removed the old Tested-by tags as the base KVM code and FRED patches
   have changed significantly.

The per-patch changes are listed under each patch.

Testing
-------
Internal testing covered the following on real hardware:
 - Basic guest boot and nested boot to verify FRED was exposed correctly
 - KVM and x86 selftests on L0 and L1 guest
 - KVM unit tests including the FRED ones listed below
 - Guest live migration with FRED

The included selftests in this series are the ones I received from Xin.
There are additional selftests that I am putting together from multiple
sources. However, those are not ready for upstream review yet. The
in-progress selftests are located at:
https://github.com/sohilmeh/linux-dev/commits/fred-kvm-next

Xin posted a set of FRED KVM unit tests for review at:
https://lore.kernel.org/all/20260702065039.3434909-1-xin@zytor.com/ 

There are a couple of known issues worth mentioning: 
 - The x86 selftest sysret_rip asserts failure on FRED hosts as well as
   guest. The issue has been reported upstream [1] but AFAIU hasn't been
   resolved yet.

 - The int1_fred_test KVM selftest from David mentioned below asserts
   failure with the wrong event type with FRED.

Intel Panther Lake systems with FRED support are now available off the
shelf. Clearwater Forest and Diamond Rapids are some of the other Intel
platforms that are expected to have FRED support.

Opens
-----
INT1 event type: David Woodhouse shared a selftest which shows [2] KVM
re-injects an intercepted ICEBP (INT1) #DB as a hardware exception, so a
FRED guest reads event type 3 instead of 5. IIUC, the issue is not FRED
specific but it becomes visible due to FRED. Is that understanding
correct? Also, I am unsure of where the fix should reside or if a
generic fix is already in the works. Any insights here would be helpful.

uAPI: There was some resistance about adding exception event data to the
uAPI [3], suggesting KVM reuse the exception payload and skip updating
register state on re-injection. Xin said that he tried deriving event
data from (vector, payload), but the solution was a bit messy. As
exception_is_nested is needed either way, adding event data to the uAPI
seemed cleaner. Please let me know if the other approach is still
preferable.

Nested virtualization: Both CET and FRED can potentially leave L1
running with L2's state after a failed nested VM-entry. Zhao initiated a
thread for CET [4] which is under active discussion. This series
implements a solution that might need to be revised based on whatever
gets settled there.

Hardware fidelity: I am unsure of the level of fidelity KVM tries to
maintain with respect to the hardware. There are places (such as patch
24, nested_vmx_check_guest_state()) where KVM lets the hardware check
some state instead of performing the checks itself, and cases where it
may fail differently for unusual vmcs12 configurations. I would
appreciate some extra eyes on that.

AMD compatibility: The SVM enabling [5] builds on the same common
plumbing but I haven't had a chance to look at the series yet. Shivansh,
please let me know if there are any incompatibilities. I assume most of
the opens apply to SVM as well so resolutions would help both vendors.

Series split-up: With additional selftests, the number of patches in
this series would exceed 30. Would it be preferable to split the
selftests in to a separate series for easier review? I am inclined to
keep the nested support together to let sashiko review the patches. But,
please let me know if it would be preferable to split that out as well.

Links
-----
[1]: https://lore.kernel.org/lkml/20260326094423.711724-1-yi1.lai@intel.com/
[2]: https://lore.kernel.org/lkml/7f93eb25874ddd13a1ad6e3c75785f11041c8b7f.camel@infradead.org/
[3]: https://lore.kernel.org/all/aahg_PgO5mwjArZ6@google.com/
[4]: https://lore.kernel.org/all/20260904023105.1167376-1-zhao1.liu@intel.com/
[5]: https://lore.kernel.org/all/20260402184240.1939480-1-shivansh.dhiman@amd.com/

Previous versions
-----------------
v9: https://lore.kernel.org/lkml/20251026201911.505204-1-xin@zytor.com/
v8: https://lore.kernel.org/lkml/20251014010950.1568389-1-xin@zytor.com/
v7: https://lore.kernel.org/lkml/20250829153149.2871901-1-xin@zytor.com/
v6: https://lore.kernel.org/lkml/20250821223630.984383-1-xin@zytor.com/
v5: https://lore.kernel.org/lkml/20250723175341.1284463-1-xin@zytor.com/
v4: https://lore.kernel.org/lkml/20250328171205.2029296-1-xin@zytor.com/
v3: https://lore.kernel.org/lkml/20241001050110.3643764-1-xin@zytor.com/
v2: https://lore.kernel.org/lkml/20240207172646.3981-1-xin3.li@intel.com/
v1: https://lore.kernel.org/lkml/20231108183003.5981-1-xin3.li@intel.com/


Sohil Mehta (1):
  KVM: x86: Handle CR4.FRED when emulating RSM

Xin Li (4):
  KVM: x86: Add a new save/restore flag for FRED metadata
  KVM: x86: Include CR4.FRED in the emulator CR4 write mask
  KVM: nVMX: Restrict event data VMCS fields to FRED-supported hosts
  KVM: selftests: Add FRED MSRs to msrs_test

Xin Li (Intel) (23):
  KVM: VMX: Enable support for secondary VM exit controls
  KVM: VMX: Initialize VM entry/exit FRED controls in vmcs_config
  KVM: VMX: Disable FRED if FRED consistency checks fail
  x86/cea: Prefix event stack names with ESTACK_
  x86/cea: Use array indexing to simplify exception stack access
  x86/fred: Export this_cpu_fred_rsp() for KVM usage
  KVM: VMX: Initialize VMCS FRED fields
  KVM: VMX: Set FRED MSR intercepts
  KVM: VMX: Save/restore guest FRED RSP0
  KVM: VMX: Add support for saving and restoring FRED MSRs
  KVM: x86: Add a helper to detect if FRED is enabled for a vCPU
  KVM: VMX: Virtualize FRED nested exception tracking
  KVM: VMX: Virtualize FRED event_data
  KVM: x86: Mark CR4.FRED as not reserved
  KVM: VMX: Dump FRED context in dump_vmcs()
  KVM: x86: Advertise support for FRED
  KVM: nVMX: Enable support for secondary VM exit controls
  KVM: nVMX: Handle FRED VMCS fields in nested VMX context
  KVM: nVMX: Shadow ORIGINAL_EVENT_DATA and INJECTED_EVENT_DATA fields
  KVM: nVMX: Validate FRED-related VMCS fields
  KVM: nVMX: Enable VMX FRED controls
  KVM: selftests: Add a new VM guest mode to run user level code
  KVM: selftests: Add fred exception tests

 Documentation/virt/kvm/api.rst                |  22 ++
 arch/x86/coco/sev/noinstr.c                   |   4 +-
 arch/x86/coco/sev/vc-handle.c                 |   2 +-
 arch/x86/include/asm/cpu_entry_area.h         |  70 ++--
 arch/x86/include/asm/fred.h                   |  10 +
 arch/x86/include/asm/kvm_host.h               |  11 +
 arch/x86/include/asm/msr-index.h              |   3 +
 arch/x86/include/asm/vmx.h                    |  48 ++-
 arch/x86/include/uapi/asm/kvm.h               |   7 +-
 arch/x86/kernel/cpu/common.c                  |  10 +-
 arch/x86/kernel/dumpstack_64.c                |  18 +-
 arch/x86/kernel/fred.c                        |  24 +-
 arch/x86/kernel/traps.c                       |   2 +-
 arch/x86/kvm/cpuid.c                          |   1 +
 arch/x86/kvm/msrs.c                           |  90 +++++-
 arch/x86/kvm/msrs.h                           |   2 +-
 arch/x86/kvm/regs.c                           |   7 +
 arch/x86/kvm/regs.h                           |  21 +-
 arch/x86/kvm/smm.c                            |  18 +-
 arch/x86/kvm/svm/svm.c                        |   5 +-
 arch/x86/kvm/vmx/capabilities.h               |  20 +-
 arch/x86/kvm/vmx/nested.c                     | 253 +++++++++++++--
 arch/x86/kvm/vmx/nested.h                     |  27 ++
 arch/x86/kvm/vmx/vmcs.h                       |  12 +
 arch/x86/kvm/vmx/vmcs12.c                     |  22 ++
 arch/x86/kvm/vmx/vmcs12.h                     |  42 ++-
 arch/x86/kvm/vmx/vmcs_shadow_fields.h         |   4 +
 arch/x86/kvm/vmx/vmx.c                        | 302 +++++++++++++++++-
 arch/x86/kvm/vmx/vmx.h                        |  36 ++-
 arch/x86/kvm/x86.c                            |  69 +++-
 arch/x86/kvm/x86.h                            |   5 +-
 arch/x86/mm/cpu_entry_area.c                  |  34 +-
 arch/x86/mm/fault.c                           |   2 +-
 include/uapi/linux/kvm.h                      |   1 +
 tools/arch/x86/include/asm/msr-index.h        |   2 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |   1 +
 .../selftests/kvm/include/x86/processor.h     |  34 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    |   5 +-
 .../testing/selftests/kvm/lib/x86/processor.c |  16 +-
 tools/testing/selftests/kvm/x86/fred_test.c   | 291 +++++++++++++++++
 tools/testing/selftests/kvm/x86/msrs_test.c   |  52 ++-
 42 files changed, 1471 insertions(+), 135 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/fred_test.c


base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.43.0

