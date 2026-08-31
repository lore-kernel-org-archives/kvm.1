Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806AF304BCB
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160440; cv=none; b=tvZCTEUmU9guIVLSAbo+Y4a2xLMnfsp+b/iQpNOu9JhNIbySTAYe9HxHIefaQBMIeT9EBshdSV1hVNQ2qzlSHRc7rGRjjcPYtb+0dzfXIxQmmSy8hW7QZCuygoXwinwXPFruOnCpeqwPAh+6mg+B8YCNdlKRKjQ+S/ufAGzUijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160440; c=relaxed/simple;
	bh=hgjYgXMom6dOJPQYB1gdFBoBNdw6IzURIsFxNf9Kr3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uuSKzr+H5fd/jSH0m7QQ9uvoLlU++k3e6TVnuX02QdVu5bT/E2dcVedKbbN6B2DxmKX9aoojv0NBUW92k6Y2D5FGxM+NoT1AsSLk7oNYKD+VSSclmDz4w3bsdBrAV3+Q93oIttKYeyCSE3PANWwtQ0go1iJABnutYFTKMBNLWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwXT/Ed3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwXT/Ed3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788160438; x=1819696438;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hgjYgXMom6dOJPQYB1gdFBoBNdw6IzURIsFxNf9Kr3A=;
  b=dwXT/Ed3l8qS7FPJXbGoaX0ToilI4ipzUHjz/olbsDMhnnt4/GpBAOB8
   g3qD/uLPiEh1WP42xQmDR9AZbeWiU10R6aGxDrOrbxwhs1jVXi4dhmTS/
   J6fysV6SsNYvu1iDLl9xSIBJCGTeM3qMjU0Vjx7hbIjrP2vVFpKlJqHKD
   au1YTech0ol17xpHE2sBS3l3wrPhKsu5453N1tywFjWvrTBdVddzscAdH
   yuaF+q4BjHm42GMlHHcJdcCQn34raaTpbI7MuSKj/qJkdwAp6Cv6PtALT
   q2FkZXxpL5Ulac/ncspt+T0TFFBg5TJeoColqaDwgoFVIBAl/oU72F23G
   w==;
X-CSE-ConnectionGUID: xzYntCEOQUmWoABSxXWZEw==
X-CSE-MsgGUID: +MeBzd74TeGhs5vVUj0V2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="99911272"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="99911272"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:13:54 -0700
X-CSE-ConnectionGUID: filmiI+dTQ6TbFOHu2kcjQ==
X-CSE-MsgGUID: ahrXvoVmSWu2MH103DyacA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="266909689"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.19])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:13:47 -0700
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Peter Xu <peterx@redhat.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Fabiano Rosas <farosas@suse.de>,
	Jon Grimm <Jon.Grimm@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>,
	Samuel Ortiz <sameo@rivosinc.com>,
	=?UTF-8?q?Jakub=20R=C5=AF=C5=BEi=C4=8Dka?= <jakub.ruzicka@matfyz.cz>,
	=?UTF-8?q?J=C3=B6rg=20R=C3=B6del=20?= <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	kvm@vger.kernel.org
Subject: [RFC PATCH v2 0/4] Add KVM API for confidential guest live migration
Date: Mon, 31 Aug 2026 10:13:00 +0300
Message-ID: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

As discussed in a recent PUCK call, Sean suggested we post what Intel is
using for the KVM live migration API for TDX as an example to see if we
can come up with APIs that are not vendor specific.

The goal of this patch series is to start a discussion about live migration
kernel APIs for CoCo guests.

Tom, since you mentioned that AMD SEV-SNP and Intel TDX live migration
sound similar, can you please take a look how the API might work for
SEV-SNP?

For CoCo VMs, the guest memory and vCPU states are not accessible to the
userspace or KVM for live migration. The memory and vCPU states need to be
extracted into encrypted blobs on the source, and decrypted on the
destination. Before live migration, an encryption key needs to be
negotiated between the source and destination.

The layer handling the encryption for live migration is implementation
specific. It can be the TDX module or Coconut-SVSM for example.

For CoCo VMs, the KVM_MEMORY_ENCRYPT_OP ioctl() has been used with vendor
specific sub-commands. Adding more vendor specific sub-commands is an
option also for live migration. However, depending on how similar the KVM
needs are, it may be possible to have a common API.

For TDX, we're using a group of ioctl()s that might be possible to adapt
also for other CoCo implementations.

Artem has put together a brief description below of the example API and the
migration flow:

Example API
===========

- KVM_CAP_LIVE_MIGRATION - if a VM supports live migration through this
  uAPI.
- KVM_MIGRATE_CMD - the main ioctl that drives the migration phases. Each
  command takes vendor-specific flags and a buffer for the blob that travels
  between the hosts.
  - KVM_MIGRATE_SETUP - establish the migration session and transfer the
    immutable VM state.
  - KVM_MIGRATE_ITERATION - close a memory copy round.
  - KVM_MIGRATE_STOP_AND_COPY - pause the VM and transfer the remaining VM
    state.
  - KVM_MIGRATE_END - complete the migration, or abort it.
- KVM_EXPORT_MEMORY - export memory pages on the source host.
- KVM_IMPORT_MEMORY - import memory pages on the destination host.
- KVM_EXPORT_VCPU - export vCPU state on the source host.
- KVM_IMPORT_VCPU - import vCPU state on the destination host.

Dirty page tracking does not add a new uAPI. Userspace keeps using
KVM_GET_DIRTY_LOG and KVM_CLEAR_DIRTY_LOG.

Migration flow
==============

 Source host                                      Destination host
 ===========                                      ================

 CMD(SETUP/SESSION)          <--- setup msgs ---> CMD(SETUP/SESSION)
       |    (repeated)                                  |
 CMD(SETUP/IMMUTABLE_STATE)  - immutable state -> CMD(SETUP/IMMUTABLE_STATE)
       |                                                |
 KVM_GET_DIRTY_LOG                                      |
 KVM_EXPORT_MEMORY           --- memory data ---> KVM_IMPORT_MEMORY
 CMD(ITERATION)              --- epoch token ---> CMD(ITERATION)
       |    (repeat until convergence)                  |
 CMD(STOP_AND_COPY/PAUSE)                               |
 CMD(STOP_AND_COPY/TD_STATE) --- VM state ------> CMD(STOP_AND_COPY/TD_STATE)
 KVM_EXPORT_VCPU             --- vCPU state ----> KVM_IMPORT_VCPU
 KVM_EXPORT_MEMORY           -- final memory ---> KVM_IMPORT_MEMORY
 CMD(ITERATION/DONE)         --- start token ---> CMD(ITERATION)
       |                                                |
 CMD(END)                                         CMD(END)

For the TDX implementation, the above map to the TDX module SEAMCALLs.

Regards,

Tony

Changes since v1 at [0] below:

- Drop KVM_MIGRATE_CMD sub-command PREPARE, SETUP sub-command has been
  enough for TDX at least

- Rename KVM_MIGRATE_CMD sub-command KVM_MIGRATE_TOKEN to
  KVM_MIGRATE_ITERATION

- Rename KVM_MIGRATE_CMD sub-command KVM_MIGRATE_SOURCE_BLACKOUT to
  KVM_MIGRATE_STOP_AND_COPY

- Add x86 ioctl handling

[0] https://lore.kernel.org/kvm/20251006113524.1573116-1-tony.lindgren@linux.intel.com/


Tony Lindgren (4):
  Documentation: KVM: Add live migration API for confidential guests
  KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION and KVM_MIGRATE_CMD
  KVM: x86: Add optional KVM_EXPORT_MEMORY and KVM_IMPORT_MEMORY
  KVM: x86: Add optional KVM_EXPORT_VCPU and KVM_IMPORT_VCPU

 Documentation/virt/kvm/api.rst     | 205 +++++++++++++++++++++++++++++
 arch/x86/include/asm/kvm-x86-ops.h |   6 +
 arch/x86/include/asm/kvm_host.h    |   6 +
 arch/x86/kvm/x86.c                 | 102 ++++++++++++++
 include/uapi/linux/kvm.h           |  43 ++++++
 5 files changed, 362 insertions(+)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.43.0

