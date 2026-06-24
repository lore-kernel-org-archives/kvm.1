Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C73C39A7EA
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336670; cv=none; b=lclJWoJdgJixOdSfN1rakfkV+tpLbkLqyJ5B7LqBI14A/g3BSr/57xydYrhucFtRrmhrR6SeJ8J7p/GnIBb3bY+8tVCQz3hBQXvVV6+4BoxL6bfJCKYC7eQK4trO0CpByD5Foj0wfsexDuF+teVpUDCelbI12t/VN30TBukLiaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336670; c=relaxed/simple;
	bh=hoj2JZ8ANxyvZMh1IlduPZxDlcRl3ynQEyTPdyjwb40=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n2hcsxdb67oPRUyF7dgy518hDUIVmTFimoQKj8OA8NjiY2v8EXyvSxTtiIGQGQJm9UAp7yJMLmWnvPncfLF53Ew3dO7hKwx+UMIMZbQUObmevcB7+haWu4E0PH2qzTHw/FBeAj+gQciLgaEl417jlqs/iXWddm/71TDqJHEE6AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Weu9UPLh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Weu9UPLh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782336668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DFyUpEjdItbwP2lOjrci45mM1a6/sazQPcz2dME116Q=;
	b=Weu9UPLh2wKzYfuKC15MdnT25PnZf18JZ7P++HP3z1gT5F3dEkA8MAhbQ1dP/eK3QLB2as
	Cp08uf49PlC8D6ui28flDzDyM2E75fit6P3N/TF2B6CdSr8kDNU/xnRzLQxWPmFzFW4R8v
	Dmgrgp3Bpz6CphEExmcSa+LzwIWywXE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-eyj1ABfxMhOC_T0-gnYk-Q-1; Wed,
 24 Jun 2026 17:31:05 -0400
X-MC-Unique: eyj1ABfxMhOC_T0-gnYk-Q-1
X-Mimecast-MFC-AGG-ID: eyj1ABfxMhOC_T0-gnYk-Q_1782336664
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13CBB1800663;
	Wed, 24 Jun 2026 21:31:04 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9AA8E1956041;
	Wed, 24 Jun 2026 21:31:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH v2 00/19] KVM: apply chainsaw to struct kvm_mmu
Date: Wed, 24 Jun 2026 17:30:43 -0400
Message-ID: <20260624213102.71082-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The kvm_mmu is a "god data structure" that includes three different
tasks: describing the guest page table's format, walking the guest
page tables and building the page tables.  This means that the
(already poorly named) nested_mmu is only used in part, since it
has no page tables to construct.

Furthermore, some parts are reused across guest and host page
tables (such as the reserved bits detector) but others are not;
for example permission_fault is replaced by simplified code such as
is_executable_pte().

This series cleans this up by splitting kvm_mmu in three parts:

- kvm_pagewalk is the page table walker.  There are two of them
  per vCPU, gva_walk and ngpa_walk.  walk_mmu is *always* replaced
  by a single gva_walk no matter if running an L1 or L2 guest,
  unlike in the current code that moves it between root_mmu and
  nested_mmu.

- kvm_mmu retains the page table building functionality.  It uses
  a page table walker to build shadow pages; that is always gva_walk
  for root_mmu or ngpa_walk for guest_mmu.

- kvm_page_format allows KVM to operate on PTEs that already exist,
  and merges the code around permission_mask() with the pre-existing
  struct rsvd_bits_validate.  Both kvm_pagewalk and kvm_mmu have their
  own kvm_page_format, just like struct kvm_mmu had two instances of
  struct rsvd_bits_validate for gPTE and SPTE reserved bit checks.

The cleanup alone already does something useful, which is to reduce
the confusion between guest_mmu and nested_mmu.  nested_mmu came to
exist long before the introduction of guest_mmu and stole the obvious
name, resulting in comments like "Exempt nested MMUs" where the code
actually exempts guest_mmu.  Renaming guest_mmu could be the next
step, though the RFC had multiple opinions about how to do this.

However, the last patch also shows the code reuse benefits can be used
for new features too.  By adapting the permission_fault() machinery and
using it to test SPTEs against struct kvm_page_fault, it makes it possible
to support SPTEs that have XS!=XU; these were not supported yet by KVM,
but could now be added via memory attributes.

Paolo

v1->v2:
- remove merged patches
- mask pfec in spte_permission_fault()
- swap patches 13 and 14 (18 and 19 in v1) to fix bisectability

Paolo Bonzini (19):
  KVM: x86/hyperv: remove unnecessary mmu_is_nested() check
  KVM: x86/mmu: introduce struct kvm_pagewalk
  KVM: x86/mmu: move get_guest_pgd to struct kvm_pagewalk
  KVM: x86/mmu: move gva_to_gpa to struct kvm_pagewalk
  KVM: x86/mmu: move get_pdptr to struct kvm_pagewalk
  KVM: x86/mmu: move inject_page_fault to struct kvm_pagewalk
  KVM: x86/mmu: move CPU-related fields to struct kvm_pagewalk
  KVM: x86/mmu: change CPU-role accessor fields to take struct
    kvm_pagewalk
  KVM: x86/mmu: move remaining permission fields to struct kvm_pagewalk
  KVM: x86/mmu: pass struct kvm_pagewalk to kvm_mmu_invalidate_addr
  KVM: x86/mmu: change walk_mmu to struct kvm_pagewalk
  KVM: x86/mmu: change nested_mmu.w to ngva_walk
  KVM: x86/mmu: pull struct kvm_pagewalk out of struct kvm_mmu
  KVM: x86/mmu: unify root_gva_walk and ngva_walk
  KVM: x86/mmu: cleanup functions that initialize shadow MMU
  KVM: x86/mmu: pull page format to a new struct
  KVM: x86/mmu: merge struct rsvd_bits_validate into struct
    kvm_page_format
  KVM: x86/mmu: parameterize update_permission_bitmask()
  KVM: x86/mmu: use kvm_page_format to test SPTEs

 arch/x86/include/asm/kvm_host.h |  70 +++---
 arch/x86/kvm/hyperv.c           |   7 +-
 arch/x86/kvm/mmu.h              |  33 +--
 arch/x86/kvm/mmu/mmu.c          | 411 +++++++++++++++-----------------
 arch/x86/kvm/mmu/paging_tmpl.h  |  88 +++----
 arch/x86/kvm/mmu/spte.c         |   4 +-
 arch/x86/kvm/mmu/spte.h         |  69 +++---
 arch/x86/kvm/mmu/tdp_mmu.c      |   3 +-
 arch/x86/kvm/regs.c             |   7 +-
 arch/x86/kvm/svm/nested.c       |  13 +-
 arch/x86/kvm/vmx/nested.c       |  15 +-
 arch/x86/kvm/vmx/vmx.c          |   2 +-
 arch/x86/kvm/x86.c              |  51 ++--
 13 files changed, 382 insertions(+), 391 deletions(-)

-- 
2.52.0

