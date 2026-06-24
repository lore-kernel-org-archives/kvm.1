Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B183E5EE1
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337345; cv=none; b=t1A/KvQ7nHuNapPVeLOQkvfK/RqodMK2QAPNVah4h9IOJ6be+CMRfzSFH/G629XdzfQneMbmKWRMwwAc3uCaoDdTbnQu04vdTnDoMstsMcBzeJ26C1X6E45Wni8Qu1TdhbOA0kwZ9Z/aYHqMyMQldIc+y0pE41+sCI8MrO5nqtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337345; c=relaxed/simple;
	bh=E4Ehy9dNOOQU8yQmBRGbmAhK928Bws8MPIirPAuH40w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eoFl7lVyvdaoHTqDtoMzS0LR4a0TYXIo4vhAbaipJbSOD59YjcW+OMxXbowMGbgcJzi6vTtS1E8c/U3QoOzks3MnY3TZgvBhcVwjHojwDukUAHupNpAnpcxhyuK5NhtD5oAE5sEG45YyeXFjd7/8PPKT/zSWlgCKOuxIoRWw3K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AmpIelhn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmpIelhn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782337341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tVoXy41jyuhdNP7TFRpfdnwd9ePJiil+Vo6QBlTewG0=;
	b=AmpIelhnTsDaO+oih7EYptzgMSM/C2g20ektw+8LWN8VFi6kgqfZKKH9AHKZJ/1gdFnyYI
	4IeRBHgYS9ZdiBKwd1hKpBsSyXxykqCwlBC8GoTy5DNbusXaL0YD4BuMT0Tajolpf19Zkw
	b3GGyDGyS6LRq+KF5vrmqpUp7YZaGOo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-Z4FGYoHcPHuSkjpC2Klenw-1; Wed,
 24 Jun 2026 17:42:20 -0400
X-MC-Unique: Z4FGYoHcPHuSkjpC2Klenw-1
X-Mimecast-MFC-AGG-ID: Z4FGYoHcPHuSkjpC2Klenw_1782337339
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68B7D1955F7D;
	Wed, 24 Jun 2026 21:42:19 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 025CF1686;
	Wed, 24 Jun 2026 21:42:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH v2 7.2-based 00/19] KVM: apply chainsaw to struct kvm_mmu
Date: Wed, 24 Jun 2026 17:41:59 -0400
Message-ID: <20260624214218.73796-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

This is the same as what I have just posted at
https://lore.kernel.org/kvm/20260624213102.71082-1-pbonzini@redhat.com/,
just on a 7.2 base (i.e. without Sean's spring cleaning series
https://lore.kernel.org/kvm/20260613000329.732085-1-seanjc@google.com/),
so as to trigger Sashiko's review.

The code is exactly the same, other than some functions (mostly
load_pdptrs) and prototypes having moved from x86.c to regs.c,
or out of kvm_host.h.

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

 arch/x86/include/asm/kvm_host.h |  72 +++---
 arch/x86/kvm/hyperv.c           |   7 +-
 arch/x86/kvm/mmu.h              |  31 +--
 arch/x86/kvm/mmu/mmu.c          | 411 +++++++++++++++-----------------
 arch/x86/kvm/mmu/paging_tmpl.h  |  88 +++----
 arch/x86/kvm/mmu/spte.c         |   4 +-
 arch/x86/kvm/mmu/spte.h         |  69 +++---
 arch/x86/kvm/mmu/tdp_mmu.c      |   3 +-
 arch/x86/kvm/svm/nested.c       |  13 +-
 arch/x86/kvm/vmx/nested.c       |  15 +-
 arch/x86/kvm/vmx/vmx.c          |   2 +-
 arch/x86/kvm/x86.c              |  58 ++---
 12 files changed, 382 insertions(+), 391 deletions(-)

-- 
2.52.0

