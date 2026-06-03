Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46385407592
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484301; cv=none; b=bs7I4Gv9s0KQpcx9msR5D2J+9+snsUo6EZuF0aZQN4NOThqTarb0AGhX/hXHqc/h0026EGeJxqgd8uS8qF+1Xi96pbsp4zYtF0nHyfdFebfWPFm8YnowGKaIGjWctXkSxFYZo5YOEwoGTxpLOJPIWHfXGRt7O6UyGW+3rqa5g34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484301; c=relaxed/simple;
	bh=ajZkn4WsIBj5ZzDh96OQgaDahZCkowzGKwFVjAVCKZY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EiQ8mSN3SDPqdP3y1zmqmwKwOtT2LpSYZhUqZjy/QEqxl9Bhb4LCv91pWLuliQippb/l94VW2jYpG5uq7wVLRH54yMz68WTqMd8dTo8Zm06D9hEtlDZ0HvCE8EJqhSKtG5z4mi3R3vkKFG4b52bvDn0h/ZCD3dsMPCy55yNRu+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c5WVKYIM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5WVKYIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780484299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pblq4zImexT7wYUzCopqvQo16/aEcdK3Tk31BSwIOTw=;
	b=c5WVKYIMmD+c4qT9WjvsJQVHGHsbMSWQJf/4uqt5mGXlAkZjMqYGMUINgvzTqO075UrKTG
	i1N5aeXTz6yHHXAq5F5wL1+O867XzoFcYYQVY2jW7KlR5T/xBA1Cl8PrEV/XpTtXDyruke
	Bq+yIgTpGVsFdea7m8d5rRPcZZk6R2A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-ZtoFO1nWM_Si75OSdfSXpQ-1; Wed,
 03 Jun 2026 06:58:16 -0400
X-MC-Unique: ZtoFO1nWM_Si75OSdfSXpQ-1
X-Mimecast-MFC-AGG-ID: ZtoFO1nWM_Si75OSdfSXpQ_1780484295
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87CF618004A9;
	Wed,  3 Jun 2026 10:58:15 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21F71404;
	Wed,  3 Jun 2026 10:58:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 00/24] KVM: apply chainsaw to struct kvm_mmu
Date: Wed,  3 Jun 2026 06:57:50 -0400
Message-ID: <20260603105814.10236-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

The RFC for this series only had minor comments on the naming;
probably, everybody liked the idea of doing it and nobody liked
the idea of reviewing it front to back.  So here it is without the
RFC tag.

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

The first five patches are a repost of
https://lore.kernel.org/kvm/20260530165545.25599-1-pbonzini@redhat.com/T/
because sashiko does not yet support Based-on tags or similar.

Paolo

RFC->v1:
- replaced first four patches with "KVM: x86: small MMU-adjacent cleanups"
- renamed cpu_walk and tdp_walk to gva_walk and ngpa_walk (as well as
  the temporary nested_cpu_walk to ngva_walk)

Paolo Bonzini (24):
  KVM: x86: remove nested_mmu from mmu_is_nested()
  KVM: nVMX: remove unnecessary code in prepare_vmcs02_rare
  KVM: nSVM: invalidate cached PDPTRs across nested NPT transitions
  KVM: x86: check that kvm_handle_invpcid is only invoked with shadow paging
  KVM: x86/mmu: move pdptrs out of the MMU
  KVM: x86/hyperv: remove unnecessary mmu_is_nested() check
  KVM: x86/mmu: introduce struct kvm_pagewalk
  KVM: x86/mmu: move get_guest_pgd to struct kvm_pagewalk
  KVM: x86/mmu: move gva_to_gpa to struct kvm_pagewalk
  KVM: x86/mmu: move get_pdptr to struct kvm_pagewalk
  KVM: x86/mmu: move inject_page_fault to struct kvm_pagewalk
  KVM: x86/mmu: move CPU-related fields to struct kvm_pagewalk
  KVM: x86/mmu: change CPU-role accessor fields to take struct kvm_pagewalk
  KVM: x86/mmu: move remaining permission fields to struct kvm_pagewalk
  KVM: x86/mmu: pass struct kvm_pagewalk to kvm_mmu_invalidate_addr
  KVM: x86/mmu: change walk_mmu to struct kvm_pagewalk
  KVM: x86/mmu: change nested_mmu.w to ngva_walk
  KVM: x86/mmu: make gva_walk a value
  KVM: x86/mmu: pull struct kvm_pagewalk out of struct kvm_mmu
  KVM: x86/mmu: cleanup functions that initialize shadow MMU
  KVM: x86/mmu: pull page format to a new struct
  KVM: x86/mmu: merge struct rsvd_bits_validate into struct
    kvm_page_format
  KVM: x86/mmu: parameterize update_permission_bitmask()
  KVM: x86/mmu: use kvm_page_format to test SPTEs

 arch/x86/include/asm/kvm_host.h |  75 +++---
 arch/x86/kvm/hyperv.c           |   7 +-
 arch/x86/kvm/kvm_cache_regs.h   |  12 +-
 arch/x86/kvm/mmu.h              |  31 +--
 arch/x86/kvm/mmu/mmu.c          | 411 +++++++++++++++-----------------
 arch/x86/kvm/mmu/paging_tmpl.h  |  88 +++----
 arch/x86/kvm/mmu/spte.c         |   4 +-
 arch/x86/kvm/mmu/spte.h         |  64 ++---
 arch/x86/kvm/mmu/tdp_mmu.c      |   3 +-
 arch/x86/kvm/svm/nested.c       |  40 ++--
 arch/x86/kvm/svm/svm.c          |   2 +-
 arch/x86/kvm/vmx/nested.c       |  26 +-
 arch/x86/kvm/vmx/vmx.c          |  22 +-
 arch/x86/kvm/x86.c              |  67 +++---
 arch/x86/kvm/x86.h              |   2 +-
 15 files changed, 422 insertions(+), 432 deletions(-)

-- 
2.52.0

