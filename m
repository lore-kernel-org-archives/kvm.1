Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3DC3C2787
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160444; cv=none; b=GVgwTAVdtldaRYsQijg65r1l5qUsPEmkxyO8CUr+3efmG3Ogbn8htM+nIqm1n6juLRj8sAfnlfeF4papNxaOMhTdICcTp1Hsz2pZM9JBiNUKqBx/OOvz6fTpeJ1ZBTP1ZMF8pP+5ZfwmOCKxNK7EsEUZzJxE2khGpwk9ccfa/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160444; c=relaxed/simple;
	bh=xwDnxx0UeKAHBSyUT+CPixcUtReTWl8pkJFhLY4fKAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Syp4bK3L4WBLVOjwK3fdWx2P43lOMHzJ0Fx5Z/HYMuTrlUe0ieaZYbOo5M7EtidmgYOYR1xb+0CNf7zOvxNqqEP7v6VptiLCrD3sUobRAUkCe6xDa8GhqoRdQAXRXFikIipNN4EXJ1hTAuoi0vgUqeo+14cFIesPhZIYqLlUA3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jn729bQr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jn729bQr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788160442; x=1819696442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xwDnxx0UeKAHBSyUT+CPixcUtReTWl8pkJFhLY4fKAw=;
  b=Jn729bQr09IlVgizYjyAZlpyCB1IAg8O+Db1mYI7yAEJV9eoSSFwEcCd
   K8L/89LqjmL4HhShveZ/9AT4PvgCEPLo4mpj/R5Dtp/84UWH+2wwrXaGL
   xoaXQy6UpAcSmopW9hAogf1Qs2q5/HmRI8Uy1s3gTKLNLM5WUlXgTC6Hk
   eTLmTsKMbQ2rh5qdBgKAIxTTae6Gi5rJgHOt4R0VLbVDcCxwJOsKy7xPV
   k4MzxdgtHRKLnfq7MlIz3bNkFR9YdwgjHmrEecuNu59LAPfSQVg0BWFaH
   SDuO+aRyi7buLlSBsF1FQU2jkIoFEhbDtAqOc5glRXujeiR2hNhcSAfnL
   g==;
X-CSE-ConnectionGUID: YHdvSNNfRPajew9TEUzAjw==
X-CSE-MsgGUID: TsvEoCUaTGKZNBdXoON11w==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="99911295"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="99911295"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:14:01 -0700
X-CSE-ConnectionGUID: /cIuLaBBSfqY/v65NF9S8w==
X-CSE-MsgGUID: 6rG4vz6tScyDi/mSeoFjmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="266909711"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.19])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:13:54 -0700
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
Subject: [RFC PATCH v2 1/4] Documentation: KVM: Add live migration API for confidential guests
Date: Mon, 31 Aug 2026 10:13:01 +0300
Message-ID: <20260831071304.762939-2-tony.lindgren@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For CoCo VMs, the guest memory and vCPU states are not accessible to the
userspace or KVM for live migration. The memory and vCPU states need to be
extracted into encrypted blobs on the source, and decrypted on the
destination. Before live migration, an encryption key needs to be
negotiated between the source and destination.

KVM help is needed to talk to the layer exporting and importing the
encrypted state. Document the KVM live migration API for confidential
guests.

Co-developed-by: Kishen Maloor <kishen.maloor@intel.com>
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
 Documentation/virt/kvm/api.rst | 205 +++++++++++++++++++++++++++++++++
 1 file changed, 205 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index a5f9ee92f43e8..9d546d288af5f 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6566,6 +6566,200 @@ KVM_S390_KEYOP_SSKE
   Sets the storage key for the guest address ``guest_addr`` to the key
   specified in ``key``, returning the previous value in ``key``.
 
+.. _KVM_MIGRATE_CMD:
+
+4.145 KVM_MIGRATE_CMD
+---------------------
+
+:Capability: KVM_CAP_LIVE_MIGRATION
+:Architectures: x86
+:Type: vm ioctl
+:Parameters: struct kvm_migrate_cmd (in/out)
+:Returns: 0 on success, < 0 on error
+
+Allows userspace to send live migration related commands to KVM for vendor
+specific handling.
+
+For confidential computing, live migration related commands may be needed.
+The commands typically use encrypted data that needs to be passed between the
+source and destination hosts. The hosts may also require specific coordination
+steps during migration that must be triggered at precise points in the
+migration process.
+
+The vendor specific implementation handles locking and checks the valid flags
+bits. If KVM_CAP_LIVE_MIGRATION is not available for the VM, -ENOTTY is
+returned.
+
+The KVM_MIGRATE_CMD subcommand passed in struct kvm_migrate_cmd is one of::
+
+  #define KVM_MIGRATE_SETUP		0
+  #define KVM_MIGRATE_ITERATION		1
+  #define KVM_MIGRATE_STOP_AND_COPY	2
+  #define KVM_MIGRATE_ABORT		3
+  #define KVM_MIGRATE_END		4
+
+The kvm_transfer_buffer is::
+
+  /**
+   * @address: Userspace buffer address
+   * @size: Size of the userspace buffer
+   * @reserved: Reserved for future use
+   */
+  struct kvm_transfer_buffer {
+	__u64 address;
+	__u32 size;
+	__u32 reserved;
+  };
+
+The kvm_migrate_cmd is::
+
+  /**
+   * @command: One of the defined KVM_MIGRATE commands
+   * @flags: Hardware specific flags
+   * @reserved: Reserved for future use
+   * @buf: Userspace buffer for hardware specific data
+   */
+  struct kvm_migrate_cmd {
+	__u16 command;
+	__u16 flags;
+	__u32 reserved;
+	struct kvm_transfer_buffer buf;
+  };
+
+.. _KVM_EXPORT_MEMORY:
+
+4.146 KVM_EXPORT_MEMORY
+-----------------------
+
+:Capability: KVM_CAP_LIVE_MIGRATION
+:Architectures: x86
+:Type: vm ioctl
+:Parameters: struct kvm_memory_transfer (in/out)
+:Returns: 0 on success, < 0 on error
+
+Allows userspace to request the host to export an array of memory pages to a
+userspace buffer.
+
+The private memory may not be accessible to KVM because of encryption. For
+confidential computing, the guest memory is encrypted and only accessible to
+the guest.
+
+If KVM_CAP_LIVE_MIGRATION is not available for the VM, -ENOTTY is returned.
+
+The vendor specific ID is used at least for TDX for the migration thread
+index.
+
+The kvm_memory_transfer is::
+
+  /**
+   * @gfns: Userspace address of an array of nr_gfns __u64 GFNs to export
+   * @nr_gfns: Number of GFNs in the @gfns array
+   * @id: Optional vendor specific transfer ID
+   * @flags: Vendor specific flags
+   * @reserved: Reserved for future use
+   * @buf: Userspace buffer to export memory to
+   */
+  struct kvm_memory_transfer {
+       __u64 gfns;
+       __u32 nr_gfns;
+       __u16 id;
+       __u16 flags;
+       __u64 reserved;
+       struct kvm_transfer_buffer buf;
+  };
+
+The transfer buffer size is vendor specific.
+
+For the transfer buffer, seeo :ref:`KVM_MIGRATE_CMD <KVM_MIGRATE_CMD>`.
+
+For memory import, see also :ref:`KVM_IMPORT_MEMORY <KVM_IMPORT_MEMORY>`.
+
+
+.. _KVM_IMPORT_MEMORY:
+
+4.147 KVM_IMPORT_MEMORY
+-----------------------
+
+:Capability: KVM_CAP_LIVE_MIGRATION
+:Architectures: x86
+:Type: vm ioctl
+:Parameters: struct kvm_memory_transfer (in/out)
+:Returns: 0 on success, < 0 on error
+
+Allows userspace to request the host to import an array of memory pages from a
+userspace buffer.
+
+The private memory may not be accessible to KVM because of encryption. For
+confidential computing, the guest memory is encrypted and only accessible to
+the guest.
+
+If KVM_CAP_LIVE_MIGRATION is not available for the VM, -ENOTTY is returned.
+
+The vendor specific ID is used at least for TDX for the migration thread
+index.
+
+The transfer buffer size is vendor specific.
+
+For kvm_memory_transfer, see :ref:`KVM_EXPORT_MEMORY <KVM_EXPORT_MEMORY>`.
+
+For the transfer buffer, seeo :ref:`KVM_MIGRATE_CMD <KVM_MIGRATE_CMD>`.
+
+.. _KVM_EXPORT_VCPU:
+
+4.149 KVM_EXPORT_VCPU
+---------------------
+:Capability: KVM_CAP_LIVE_MIGRATION
+:Architectures: arm64, x86
+:Type: vcpu ioctl
+:Parameters: struct kvm_vcpu_transfer (in/out)
+:Returns: 0 on success, < 0 on error
+
+Allows userspace to request the host to export a VCPU state to a userspace
+buffer.
+
+The VCPU state may not be directly accessible to KVM because of encryption. For
+confidential computing, the VCPU state is encrypted and only accessible to the
+guest.
+
+The vcpu_transfer is::
+
+  /**
+   * @flags: Hardware specific flags
+   * @reserved: Reserved for future use
+   * @buf: Userspace buffer to export VCPU state to
+   */
+  struct kvm_vcpu_transfer {
+        __u32 flags;
+        __u32 reserved;
+	struct kvm_transfer_buffer buf;
+  };
+
+For the transfer buffer, see :ref:`KVM_MIGRATE_CMD <KVM_MIGRATE_CMD>`.
+
+For vCPU import, see also :ref:`KVM_IMPORT_VCPU <KVM_IMPORT_VCPU>`.
+
+.. _KVM_IMPORT_VCPU:
+
+4.148 KVM_IMPORT_VCPU
+---------------------
+
+:Capability: KVM_CAP_LIVE_MIGRATION
+:Architectures: arm64, x86
+:Type: vcpu ioctl
+:Parameters: struct kvm_vcpu_transfer (in/out)
+:Returns: 0 on success, < 0 on error
+
+Allows userspace to request the host to import a VCPU state from a userspace
+buffer.
+
+The VCPU state may not be directly accessible to KVM because of encryption. For
+confidential computing, the VCPU state is encrypted and only accessible to the
+guest.
+
+For vcpu_transfer and vCPU import, see :ref:`KVM_IMPORT_VCPU <KVM_IMPORT_VCPU>`.
+
+For the transfer buffer, see also :ref:`KVM_MIGRATE_CMD <KVM_MIGRATE_CMD>`.
+
 .. _kvm_run:
 
 5. The kvm_run structure
@@ -9493,6 +9687,17 @@ take care to differentiate between these cases.
 The presence of this capability indicates that the nested KVM guest can
 start in ESA mode.
 
+8.48 KVM_CAP_LIVE_MIGRATION
+---------------------------
+
+:Architectures: x86
+:Target: VM
+:Parameters: None
+
+Indicates that the VM needs to use KVM calls for live migration, and that the
+KVM_MIGRATE_CMD ioctl and the KVM_EXPORT_MEMORY, KVM_IMPORT_MEMORY,
+KVM_EXPORT_VCPU and KVM_IMPORT_VCPU ioctls are available.
+
 9. Known KVM API problems
 =========================
 
-- 
2.43.0

