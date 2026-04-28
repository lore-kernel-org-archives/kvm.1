Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A3E3D3304
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374597; cv=none; b=jDoeB3WlVt3r2o6moK97/GJCqKiczSJ7xoN8n8nhu5PZammrQQ1IfkQdkns6Jnd/Qfyq/KRwqG6J/bgpEcTJE8uYGy1x9xW92E8w8cMZSGm9r1j0EjqPwtBO/2De4Yb9CzFxpNkN1ACgta3EcML6P3gFxRw0S5Pk8ib3QSjHE/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374597; c=relaxed/simple;
	bh=EXd7PO5M3ILt2PnOI4q7V5f5DA6QPyuPAItWlSeQ1k4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q7BCsgcZATCplt5F7cJq74r2E4+1gISSysc8xcl6iNNg73qzN4k0Jt2yk8Ef0013Lr+qQBL+RN1acvLaDO3Loif23AqGxlN1wRgpEpj3kmwZXzMIHuJa2AXGQjV9DYh3pZCyMcAbvuksFIv9o4it39t68d5KT9ggAhwf2ydozbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PIuMOvqK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIuMOvqK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5qRvW04OL6Vzf/cphkanFzbzjd3Q97RMD5bRsHR9GB8=;
	b=PIuMOvqKBNgAQ+68ojxGI8KR6jtX/RpmSRPUFp4jSEP3YAnS6l74gwvl5SN0p3VffZliA5
	LKdbD3sQ9DoCUBGEeRdGVLqjUfA71ZsTACVzeoolhIXEiT2SPBbHuZN9pGopms0Wn3VdBx
	g11nlKT7d2MjWU7hDpqn+KU9z71h70o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-ZA4yE0zSPACJb_XP9GiHIw-1; Tue,
 28 Apr 2026 07:09:48 -0400
X-MC-Unique: ZA4yE0zSPACJb_XP9GiHIw-1
X-Mimecast-MFC-AGG-ID: ZA4yE0zSPACJb_XP9GiHIw_1777374587
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9712C1800370;
	Tue, 28 Apr 2026 11:09:47 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D7A3D3000C22;
	Tue, 28 Apr 2026 11:09:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	d.riley@proxmox.com
Subject: [PATCH v4 00/28] KVM: combined patchset for MBEC/GMET support
Date: Tue, 28 Apr 2026 07:09:18 -0400
Message-ID: <20260428110946.11466-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

I will send you to v3 (https://lore.kernel.org/kvm/20260408154217.458420-1-pbonzini@redhat.com/)
for the description of the series, and leave a short list of changes:

- patch 15: clear enable_mbec = 0 if enable_ept == 0
- patches 23-27: adjust for rename of nested_ctl to misc_ctl
- patch 24: new
- patch 27: disable svm_get_cpl for SEV-ES/SEV-SNP
- patch 28: fix commit message reference to __nested_svm_check_controls 

(patch 24 is the only major bugfix).

Thanks,

Paolo

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
  KVM: x86/mmu: introduce ACC_READ_MASK
  KVM: x86/mmu: separate more EPT/non-EPT permission_fault()
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
  KVM: x86/mmu: set CR0.WP=1 for shadow NPT MMU
  KVM: x86/mmu: add support for GMET to NPT page table walks
  KVM: SVM: enable GMET and set it in MMU role
  KVM: SVM: work around errata 1218
  KVM: nSVM: enable GMET for guests

 Documentation/virt/kvm/x86/mmu.rst |  10 +-
 arch/x86/include/asm/cpufeatures.h |   1 +
 arch/x86/include/asm/kvm-x86-ops.h |   1 +
 arch/x86/include/asm/kvm_host.h    |  48 ++++++---
 arch/x86/include/asm/svm.h         |   1 +
 arch/x86/include/asm/vmx.h         |  14 ++-
 arch/x86/kvm/hyperv.c              |   4 +-
 arch/x86/kvm/mmu.h                 |  30 ++++--
 arch/x86/kvm/mmu/mmu.c             | 168 ++++++++++++++++++++---------
 arch/x86/kvm/mmu/mmutrace.h        |  19 ++--
 arch/x86/kvm/mmu/paging_tmpl.h     |  73 ++++++++-----
 arch/x86/kvm/mmu/spte.c            |  74 +++++++------
 arch/x86/kvm/mmu/spte.h            |  70 ++++++------
 arch/x86/kvm/mmu/tdp_mmu.c         |   6 +-
 arch/x86/kvm/svm/nested.c          |  37 ++++++-
 arch/x86/kvm/svm/svm.c             |  31 ++++++
 arch/x86/kvm/svm/svm.h             |   1 +
 arch/x86/kvm/vmx/capabilities.h    |  12 ++-
 arch/x86/kvm/vmx/common.h          |  20 ++--
 arch/x86/kvm/vmx/hyperv_evmcs.h    |   1 +
 arch/x86/kvm/vmx/main.c            |   9 ++
 arch/x86/kvm/vmx/nested.c          |  46 +++++++-
 arch/x86/kvm/vmx/tdx.c             |   2 +-
 arch/x86/kvm/vmx/vmx.c             |  27 ++++-
 arch/x86/kvm/vmx/vmx.h             |   1 +
 arch/x86/kvm/vmx/x86_ops.h         |   1 +
 arch/x86/kvm/x86.c                 |  18 +---
 27 files changed, 505 insertions(+), 220 deletions(-)

-- 
2.52.0

