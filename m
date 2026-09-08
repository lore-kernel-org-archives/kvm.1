Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B027511E94;
	Tue,  8 Sep 2026 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863626; cv=none; b=dTBMxTjJFJJDGbf4T1qofiGyhQaErqD5yziaaiE0B4b797V7nXLm5OidpGmIeBg9HS7NIrFBlEsVnxyWT6UGuNbhulK7A/QH++5GWi5uJr2tfJwRf1bE2d/T6RnuWqVdIQWLtBVGD/7Nw9iFNardnYCHNZBwY6COZq14h0Z7D9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863626; c=relaxed/simple;
	bh=TAR/+kHednxrxzylj9Ii7imx5KDUfn6/JXlxX+CWCs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=je5/UPTMvL7w/TdaTmYxMBuYgY2Zn35wp63/wgEBHLCwwMQS7oGjIPtXVRyRchb5c/XF+U3Yn8JU4jPmO+xu2aCN+ePNMYB2XIq5NgW0vprDGnipx3dcsKO4qjXExDjreDHSwiHVzWxeYIF26qTX0UTKNxcI3cKk0pM29OceHvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.fritz.box (p200300f6af085a00d84fb33a51badfd9.dip0.t-ipconnect.de [IPv6:2003:f6:af08:5a00:d84f:b33a:51ba:dfd9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D3CA72085C1;
	Tue,  8 Sep 2026 12:33:40 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Michael Roth <michael.roth@amd.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Ninad Naik <ninadnaik07@gmail.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	coconut-svsm@lists.linux.dev
Subject: [PATCH v2 0/8] KVM: SVM: Support direct setting of VMSA for SEV-SNP guests
Date: Tue,  8 Sep 2026 12:33:30 +0200
Message-ID: <20260908103338.427254-1-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

Hi,

here is the updated version of KVM-AMD changes to allow user-space to
directly set the boot VMSA (direct-vmsa) for an SEV-SNP virtual
machine.

The direct-vmsa support is required for stable launch measurements
when loading the initial SEV-SNP guest image from an IGVM file.
Without this support KVM measures a VMSA at a fixed GPA for every
VCPU, which makes the launch measurement dependent on the number of
VCPUs. Besides that the current KVM VMSA-allocation behavior poses
challenges for live migration of SEV-SNP VMs. The current behavior is
fully preserved when direct-vmsa is not used.

For a longer justification have a look at this email from the v1
thread:
	
	https://lore.kernel.org/kvm/aiqwjn2DVOumfr3T@8bytes.org/

One of the main concerns with the previous version was the user-space
API, which has changed significantly in v2. The API now consists of
three parts:

	- A new KVM_CAP_SNP_DIRECT_VMSA VM-level capability which can
	  be queried and enabled from user-space. When user-space
	  enabled the capability, KVM will no longer allocate VMSA
	  pages when creating VCPUs. This means that the capability
	  can only be enabled before any VCPUs are created.

	- Allow VMSA pages in SNP launch updates. This was already
	  present in the previous version, but has different semantics
	  now. In this version all it does is adding the VMSA pages to
	  the initial image and the launch measurement. 
	
	- A new per-VCPU MEM_ENC operation to get and set the VMSA and
	  GHCB addresses of a VCPU. User-space will use this operation
	  to set the GPA of the launch VMSA of the VCPUs, but can
	  also query and set the addresses during runtime. 

	  This operation is designed to support the requirements of
	  future live-migration support, which needs to be able to set
	  and get VMSA as well as GHCB addresses. Since this
	  functionality is a superset of the operation needed for
	  direct-vmsa support, it goes the extra mile and allows
	  import and export of all SEV-SNP specific VCPU state.

For v2 I heavily used AI (codex with gpt-5.6-sol medium) and countless
iterations with manual review and testing. All changes are reviewed by
me, tested with KVM selftests, and booting an SVSM (as far as it
gets without planes support). Lockdep was enabled during testing as
well.

Please review.

-Joerg

Joerg Roedel (8):
  KVM: SEV: Document SNP direct VMSA user-space ABI
  KVM: SVM: Implement GET_AP_APIC_IDS NAE event
  KVM: SVM: Hold SRCU while reloading guest-owned VMSAs
  KVM: SEV: Add direct VMSA capability
  KVM: SEV: Allow VMSA pages in SNP launch updates
  KVM: SEV: Add SNP vCPU state get and set commands
  KVM: selftests: Test the SNP APIC-ID-list GHCB request
  KVM: selftests: Test SNP vCPU state and direct VMSA launch

 .../virt/kvm/x86/amd-memory-encryption.rst    |  66 ++-
 arch/x86/include/asm/kvm-x86-ops.h            |   1 +
 arch/x86/include/asm/kvm_host.h               |   1 +
 arch/x86/include/asm/sev-common.h             |   1 +
 arch/x86/include/uapi/asm/kvm.h               |  13 +
 arch/x86/include/uapi/asm/svm.h               |   1 +
 arch/x86/kvm/svm/sev.c                        | 287 +++++++++++-
 arch/x86/kvm/svm/svm.c                        |  23 +
 arch/x86/kvm/svm/svm.h                        |   2 +
 arch/x86/kvm/x86.c                            |   6 +
 include/uapi/linux/kvm.h                      |   2 +
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +
 tools/testing/selftests/kvm/include/x86/sev.h |  49 ++
 .../selftests/kvm/x86/sev_snp_apic_id_test.c  | 180 ++++++++
 .../kvm/x86/sev_snp_direct_vmsa_test.c        | 421 ++++++++++++++++++
 15 files changed, 1039 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/sev_snp_apic_id_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/sev_snp_direct_vmsa_test.c


base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.53.0

