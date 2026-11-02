Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619731;
	b=Ql2pO450s2kxZBqdRabREvfVfOJCkG5o5lhDskaxbaHraxu0gCoYMaRpRy5Fegju2vSV
	 1i4trVcoOWCKk6ovMdWFGBVEskLCrWu4DuKKSMaPhlgKsEOQHpl1b6lpshYXTrzR0ebJH
	 zDeW5D1QXKXh1APDIvDwUj1eN8Rq61NMEM4MFVosDO6Vkd6bRiUsHVINHPd1pMGHV595z
	 rwAIgKMOgOxFzYMt1zN10RaKLTPD6sEdsa1zCz2RolnzMO3WeMfCecLj1wZipCf1SuXxz
	 /vOTp4Nt24QC8bYmOCpKGCIn9O70vHvTbwQxGRCu48gH595UEoPzdrG65/rJdU6TgQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619731;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cEKO6AbTEkaEMYPPPS77a1ICtNzJ6R+npNeQZ3VAiX8=;
	b=mYq/SZgD9F4j378dyDutzUcwaPm46+fe2/M16pb97ij8XzwL1KintC7J1YiG+ncHwqEl
	 TPSMZFWCiY5WVZTQOdvtGvvrIkGvwNgDDb5ATq8H5pPAhtd7B+F9Os+mrH6K/MPpX6h7k
	 KlDUIbyvAan0TbPzdN9+ZHYfZg04lK1S7ntRQAkgIB+ISsbjLM1DQV0Wn0opFw9EI+tNv
	 nuCTGpTftWpQNijehmKV/icDNXnTKjBIGPqkNr3zzVjpusIvfcDKBA8RO8ENkwjIosmX4
	 v03gYE00aEejM/1b4A2dljdyB9MMFC2jBo9ZJMKkQosRxohYVD2cRxQMwK0GEqj1tzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F5A606A335;
	Mon,  2 Nov 2026 11:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8F5A606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.fritz.box (p200300f6af404a0027ad06761c59e6b3.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:27ad:676:1c59:e6b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D649A243AC4;
	Mon,  2 Nov 2026 12:42:03 +0100 (CET)
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
	coconut-svsm@lists.linux.dev,
	joro@8bytes.org
Subject: [PATCH v3 0/8] KVM: SVM: Support direct setting of VMSA for SEV-SNP guests
Date: Mon,  2 Nov 2026 12:41:29 +0100
Message-ID: <20261102114137.1198982-1-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
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

The user-space API remains unchanged since v2 of the series and
consists of three parts:

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

The changes are rebased to v7.4-rc1 and tested with lockdep enabled.

Please review.

-Joerg

Joerg Roedel (8):
  KVM: SEV: Document SNP direct VMSA userspace ABI
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
 arch/x86/kvm/svm/sev.c                        | 290 +++++++++++-
 arch/x86/kvm/svm/svm.c                        |  23 +
 arch/x86/kvm/svm/svm.h                        |   2 +
 arch/x86/kvm/x86.c                            |   6 +
 include/uapi/linux/kvm.h                      |   2 +
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +
 tools/testing/selftests/kvm/include/x86/sev.h |  49 ++
 .../selftests/kvm/x86/sev_snp_apic_id_test.c  | 180 ++++++++
 .../kvm/x86/sev_snp_direct_vmsa_test.c        | 421 ++++++++++++++++++
 15 files changed, 1042 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/sev_snp_apic_id_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/sev_snp_direct_vmsa_test.c

-- 
2.53.0

