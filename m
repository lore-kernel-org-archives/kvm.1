Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C192E7185
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512018; cv=none; b=mSikgGS0xtVToIgpB1seC3JabC2ytKdrdIFI5yLu+dweKKlM//lZ3U8HLN0hghvRZAPNRQK+3dot4VHI+YpRmP+6UgnJqvCQ+ywVXPfgcvAZT88rYGdkMT0LYZZNrtGzasGejuyuJzmvCQ0WYt057AZ6JCncPEJwYVvuQN6GdpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512018; c=relaxed/simple;
	bh=bkj7ntkPucvDPAQyeVKb4vHyVWPVB0fSJv/LqVdtwGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JAeomqux0Cm+RPD9lcBhN0IX5n+AQvjh92eTIDnqdbp/M4gPhKiuP+WGcPVn+hrhuLi2ookQlu/zORdKyK1aS4glguLzheyAqE8mza3ts6kjqIHsOPEU+r9iKzORUP6Gd3wcyvEQ2xvT0qNJjcmOCx+y7VQqkIiJFjVJL6zuANU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UFp8+GZF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFp8+GZF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778512016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y1x2YQ2RxWS7LfyqNfXWtWwHBHkLwsSWdjaUFoxzGaM=;
	b=UFp8+GZFoVJdsW17RaX6Qo+zzi1Rh+aJfnjS/mBRo0dc0mRCe7UNN49g0f0dfVA5f+Sdjt
	xVlCbQwFxYSvDHtrQs6hegPtyTZateHyyvqrhLu7XxEPg4LrcTWJ5tKg05K1Ljgqk83rlt
	norpRy4vQMXXwFwG/WdAbtAH8sN7DEY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-HPPBJ7-kMi-BaJDyd1Hp3Q-1; Mon,
 11 May 2026 11:06:51 -0400
X-MC-Unique: HPPBJ7-kMi-BaJDyd1Hp3Q-1
X-Mimecast-MFC-AGG-ID: HPPBJ7-kMi-BaJDyd1Hp3Q_1778512010
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0017518002CB;
	Mon, 11 May 2026 15:06:50 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6DD2F1800465;
	Mon, 11 May 2026 15:06:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	mtosatti@redhat.com
Subject: [RFC PATCH 00/22] KVM: apply chainsaw to struct kvm_mmu
Date: Mon, 11 May 2026 11:06:26 -0400
Message-ID: <20260511150648.685374-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
  per vCPU, cpu_walk and tdp_walk.  walk_mmu is *always* replaced
  by cpu_walk no matter if running an L1 or L2 guest, unlike in the
  current code that moves it between root_mmu and nested_mmu.

- kvm_mmu retains the page table building functionality.  It uses
  a page table walker to build shadow pages; that is always cpu_walk
  for root_mmu or tdp_walk for guest_mmu.

- kvm_page_format allows KVM to operate on PTEs that already exist.
  Both kvm_pagewalk and kvm_mmu have their own kvm_page_format, though
  at least for now kvm_mmu only uses it for reserved bit checks.

This is in general an interesting cleanup, not least because it reduces
the confusion between guest_mmu and nested_mmu.  See for example the
comment "Exempt nested MMUs" which actually exempts guest_mmu.  While I'm
not going as far as renaming guest_mmu, there is indeed less confusion
due nested_mmu coming before the introduction of guest_mmu and stealing
the obvious name.  However, the last patch also shows the code reuse
benefits can be used for new features too.

By adapting the permission_fault() machinery and using it to test SPTEs
against struct kvm_page_fault, it makes it possible to support SPTEs
that have XS!=XU; these were not supported yet by KVM, but could now be
added via memory attributes.

I'm posting this as RFC to give an early preview of this, while trying
to sort out David's reported issue with MBEC.  It's tested very lightly;
in particular, right now npt=0 seems broken for Linux guests and I also
have not tried Intel or 32-bit hosts at all.

Paolo

ps: part of the work was done with help from AI, especially for the more
    mechanical patches.  However all the planning of each commit was
    done by me and I used the LLM essentially as a "natural language
    Coccinelle" (e.g., "move gva_to_gpa from struct kvm_mmu to struct
    kvm_pagewalk.  if the function that calls it has a variable of
    type kvm_pagewalk, use it instead of mmu->w").  Since there's
    really just one way to do the work given the prompts that I used,
    I still consider even the individual patches to be assisted by LLMs
    and not generated.  Alas, the patches were created prior to
    the introduction of Documentation/process/coding-assistants.rst;
    if required, I can go back and try to figure out which of the
    refactoring patches were done this way.


Paolo Bonzini (22):
  KVM: x86: remove nested_mmu from mmu_is_nested()
  KVM: x86: move pdptrs out of the MMU
  KVM: x86: check that kvm_handle_invpcid is only invoked with shadow
    paging
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
  KVM: x86/mmu: change nested_mmu.w to nested_cpu_walk
  KVM: x86/mmu: make cpu_walk a value
  KVM: x86/mmu: pull struct kvm_pagewalk out of struct kvm_mmu
  KVM: x86/mmu: cleanup functions that initialize shadow MMU
  KVM: x86/mmu: pull page format to a new struct
  KVM: x86/mmu: merge struct rsvd_bits_validate into struct
    kvm_page_format
  KVM: x86/mmu: parameterize update_permission_bitmask()
  KVM: x86/mmu: use kvm_page_format to test SPTEs

 arch/x86/include/asm/kvm_host.h |  75 +++---
 arch/x86/kvm/hyperv.c           |   7 +-
 arch/x86/kvm/kvm_cache_regs.h   |   4 +-
 arch/x86/kvm/mmu.h              |  31 +--
 arch/x86/kvm/mmu/mmu.c          | 411 +++++++++++++++-----------------
 arch/x86/kvm/mmu/paging_tmpl.h  |  88 +++----
 arch/x86/kvm/mmu/spte.c         |   4 +-
 arch/x86/kvm/mmu/spte.h         |  64 ++---
 arch/x86/kvm/mmu/tdp_mmu.c      |   3 +-
 arch/x86/kvm/svm/nested.c       |  22 +-
 arch/x86/kvm/svm/svm.c          |   2 +-
 arch/x86/kvm/vmx/nested.c       |  29 ++-
 arch/x86/kvm/vmx/vmx.c          |  22 +-
 arch/x86/kvm/x86.c              |  67 +++---
 arch/x86/kvm/x86.h              |   2 +-
 15 files changed, 411 insertions(+), 420 deletions(-)

-- 
2.52.0

