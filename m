Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211012C21E6
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561674; cv=none; b=CWvolf0+OVIR4D763o97Bdk2UxHarsnc9CBvSJyrAYIhjQajxfqDfchvOX2sYUBMhWfg70Z6+eyaAoTKUYoQTx/4Q9SIn8LC3qXKN3b4ZxdK2tL1l+i8M6EQFS31xV+3yvwUah9l4SuANcfUh3/dVGcNTVQIfejM7yRq72KKW9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561674; c=relaxed/simple;
	bh=NKfzEz5eh/DVff2wBeQgLuIoj2Xu9ad4B/iPUZG9zuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G1OGWtCRZUOek1sIPhOUQUGORPpGGRTcMBcc3tct7VpRJvGX7i3UMtlphLgV/SB1fn7HilCF1fqo+3lAhbvr6b8UHVFe8SwC/4vMcMKf3L1p2sFbVi2xI0n2bTUWXKE/l/btyY5AaDwhK977PhSNtVDcFgccBki9fl4iRh3yDOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LN84hBdC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LN84hBdC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777561672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XLWE5FG8IgoiHj6EYrliqHdaYICLsz2pS88JmEnCS+E=;
	b=LN84hBdCci9AISrJgmsdzwhCNOECHrgyeR2GaqNiidRpov6OT0hUwIaWWkTl2bA41eY/Dy
	FcVHW1DTPPgXz4p8dOt80tSisKw7mVhn+doltR5lg78yoIRYsQa+ly/Rl+675xbYkyJYZQ
	0cjCNI5RMSSnaAHaft7oW2d4CWs5vJA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-0bl-iImSPnmuXDNiY-xCKg-1; Thu,
 30 Apr 2026 11:07:50 -0400
X-MC-Unique: 0bl-iImSPnmuXDNiY-xCKg-1
X-Mimecast-MFC-AGG-ID: 0bl-iImSPnmuXDNiY-xCKg_1777561669
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17D9B195608D;
	Thu, 30 Apr 2026 15:07:49 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 44E3D1800906;
	Thu, 30 Apr 2026 15:07:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH v5 00/28] KVM: combined patchset for MBEC/GMET support
Date: Thu, 30 Apr 2026 11:07:19 -0400
Message-ID: <20260430150747.76749-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

I will once more send you to v3 (https://lore.kernel.org/kvm/20260408154217.458420-1-pbonzini@redhat.com/)
for the description of the series.

v4 incorrectly rebased onto 7.1 KVM and broke the case where L1 disables
NPT.  On top of that I made a few final touches on the patch split, and
opted to use the XU bit unconditionally in the MMU even if MBEC is disabled.
This is more consistent with the idea of reducing as much as possible
the differences between mbec=0 and mbec=1 modes.

Paolo

v4->v5:
- patches 8 and 9: swap to clarify use of ACC_USER_MASK to detect read faults
- patch 11: fix final argument to kvm_translate_gpa (using pte_access instead
  of walker->pte_access worked more or less accidentally, but it is incorrect
  because vmx_translate_nested_gpa uses ACC_* constants rather than PT_*)
- patches 13 and 15: revert to always setting shadow_xu_mask ==
  VMX_EPT_USER_EXECUTABLE_MASK, even if MBEC is disabled.  The MMU always
  operates as if MBEC is available, instead of complicating its life (and
  potentially introducing bugs) by mapping XU onto X; blocking incorrect
  configuration can be done at higher levels.  Add a comment on the design.
- patch 24: also block CR4.SMAP
- patches 26 and 28: fix rebase onto 7.1 KVM (fixes nested NPT disabled)

v3->v4:
- patch 15: clear enable_mbec = 0 if enable_ept == 0
- patches 23-27: adjust for rename of nested_ctl to misc_ctl
- patch 24: new
- patch 27: disable svm_get_cpl for SEV-ES/SEV-SNP
- patch 28: fix commit message reference to __nested_svm_check_controls 


Jon Kohler (5):
  KVM: TDX/VMX: rework EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
  KVM: x86/mmu: remove SPTE_PERM_MASK
  KVM: x86/mmu: free up bit 10 of PTEs in preparation for MBEC
  KVM: nVMX: advertise MBEC to nested guests
  KVM: nVMX: allow MBEC with EVMCS

Paolo Bonzini (23):
  KVM: x86/mmu: shuffle high bits of SPTEs in preparation for MBEC
  KVM: x86/mmu: remove SPTE_EPT_*
  KVM: x86/mmu: merge make_spte_{non,}executable
  KVM: x86/mmu: rename and clarify BYTE_MASK
  KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
  KVM: x86/mmu: introduce ACC_READ_MASK
  KVM: x86/mmu: pass PFERR_GUEST_PAGE/FINAL_MASK to kvm_translate_gpa
  KVM: x86/mmu: pass pte_access for final nGPA->GPA walk
  KVM: x86: make translate_nested_gpa vendor-specific
  KVM: x86/mmu: split XS/XU bits for EPT
  KVM: x86/mmu: move cr4_smep to base role
  KVM: VMX: enable use of MBEC
  KVM: nVMX: pass advanced EPT violation vmexit info to guest
  KVM: nVMX: pass PFERR_USER_MASK to MMU on EPT violations
  KVM: x86/mmu: add support for MBEC to EPT page table walks
  KVM: x86/mmu: propagate access mask from root pages down
  KVM: x86/mmu: introduce cpu_role bit for availability of PFEC.I/D
  KVM: SVM: add GMET bit definitions
  KVM: x86/mmu: hard code more bits in kvm_init_shadow_npt_mmu
  KVM: x86/mmu: add support for GMET to NPT page table walks
  KVM: SVM: enable GMET and set it in MMU role
  KVM: SVM: work around errata 1218
  KVM: nSVM: enable GMET for guests

 Documentation/virt/kvm/x86/mmu.rst |  10 +-
 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/kvm-x86-ops.h |   1 +
 arch/x86/include/asm/kvm_host.h    |  48 +++++---
 arch/x86/include/asm/svm.h         |   1 +
 arch/x86/include/asm/vmx.h         |  14 ++-
 arch/x86/kvm/hyperv.c              |   4 +-
 arch/x86/kvm/mmu.h                 |  30 +++--
 arch/x86/kvm/mmu/mmu.c             | 176 ++++++++++++++++++++---------
 arch/x86/kvm/mmu/mmutrace.h        |  19 ++--
 arch/x86/kvm/mmu/paging_tmpl.h     |  73 ++++++++----
 arch/x86/kvm/mmu/spte.c            |  92 +++++++++------
 arch/x86/kvm/mmu/spte.h            |  70 +++++++-----
 arch/x86/kvm/mmu/tdp_mmu.c         |   6 +-
 arch/x86/kvm/svm/nested.c          |  38 ++++++-
 arch/x86/kvm/svm/svm.c             |  31 +++++
 arch/x86/kvm/svm/svm.h             |   1 +
 arch/x86/kvm/vmx/capabilities.h    |  12 +-
 arch/x86/kvm/vmx/common.h          |  20 ++--
 arch/x86/kvm/vmx/hyperv_evmcs.h    |   1 +
 arch/x86/kvm/vmx/main.c            |   9 ++
 arch/x86/kvm/vmx/nested.c          |  46 +++++++-
 arch/x86/kvm/vmx/tdx.c             |   2 +-
 arch/x86/kvm/vmx/vmx.c             |  27 ++++-
 arch/x86/kvm/vmx/vmx.h             |   1 +
 arch/x86/kvm/vmx/x86_ops.h         |   1 +
 arch/x86/kvm/x86.c                 |  18 +--
 27 files changed, 529 insertions(+), 223 deletions(-)

-- 
2.52.0

