Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3617F23E334
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719351; cv=none; b=QCOjewSQoOtAYqd/00TR1OQqlY34osEKhEODYS7ZCbFHSSGeyrdSyNAKVISSff9pJ8jP9TnLcmJjt2PUL/n3saoVbxsZsMItbpnv56GkVJst9Yi+qxNY+WprH20olE7R2oBC1VoFTCwxTcFsfdIQewmxHhVKbXkm+8Rf7KPnF+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719351; c=relaxed/simple;
	bh=5Aq73BWOFN4B/ivUfKmVZdwIvugxUNtoVw1D5AjNt1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t7qaI2cEt8b8jGVXOeg/IYqJ7pHsGetm6ya7999Un+wnzqP05UJvQvRJpd/4GdNqRLVqDF7Et+aLvcJO0CFer/1fRbi4yu98iBoup5+5ic5rpHq9SOuArlZ8FVkJzfLTu5pPUu2vSjAkWcTuJsiryXvKWrgGKnF2hCWxbY3RFwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUfN8dST; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUfN8dST"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789719349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Gf+lzvxbi1Zh3wBsxJVsPtZtBcbza/YT/ul3GdaSIiA=;
	b=CUfN8dSTpsxQkE1y3ax/tA6G6nIwn+xZEJEyFI+PqoCRolHpwHhdALhzxXC4KL6xeUF2Fm
	c1JnHOBTbSmXd27S2pQATcykOP3Zkx3ZhVz2eD4J8mrFtvF7kAq9Kq5MOBxTSpnrXlXatl
	TNpUGACu1qvEgMS9P+D4p2O5FltyV6g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-lL60C4iIPNalfAqfaHqYKQ-1; Fri,
 18 Sep 2026 04:15:45 -0400
X-MC-Unique: lL60C4iIPNalfAqfaHqYKQ-1
X-Mimecast-MFC-AGG-ID: lL60C4iIPNalfAqfaHqYKQ_1789719344
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 975921805A2B;
	Fri, 18 Sep 2026 08:15:44 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3F4D1800370;
	Fri, 18 Sep 2026 08:15:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH v2 00/28] KVM: x86: Introduce memory protection attributes
Date: Fri, 18 Sep 2026 04:15:15 -0400
Message-ID: <20260918081543.139871-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This series introduces a mechanism to let userspace block read,
write or execute access to individual GFNs via KVM's memory
attribute mechanism, and have them reported via KVM_EXIT_MEMORY_FAULT.
It is mostly the work of Nicolas Saenz Julienne, with my working
consisting in reorganization, code cleanup, and using the recently
revamped MMU code (ACC_* masks and kvm_page_format).

KVM needs to check the attributes anytime KVM takes GPAs as input for any
action initiated by the guest; if the memory attributes are incompatible
with such action, it should be stopped.  This means that there are quite
a lot of cases to handle.  While some families of functions can be
handled in one step, there are simply many places that do memory access.

Along the way, the patches fix some issues in the memory attributes code,
that surfaced due to having more than one attribute.

Paolo

v1->v2:
- fixed sashiko reports
- fixed and cleanup up test
- hypercall fault exit KVM_CAP not Hyper-V specific anymore
- completed/rewritten Hyper-V hypercall handling
- added KVM_HC_CLOCK_PAIRING handling
- use NX attribute for emulation
- properly split front/back halves of kvm_zap_all_fast

Anish Moorthy (1):
  KVM: Define and communicate KVM_EXIT_MEMORY_FAULT RWX flags to
    userspace

Nicolas Saenz Julienne (13):
  KVM: selftests: Take into account mixed memory fault flags
  KVM: x86/mmu: Init memslot hugepage information for non-private_mem
    VMs too
  KVM: Introduce NR/NW/NX memory attributes
  KVM: Include memory protections in result of gfn->hva conversion
  KVM: Take memory protections into account for memory read/write/fetch
  KVM: Encapsulate memattrs array into anonymous struct
  KVM: Introduce a generation number for memory attributes
  KVM: Take memory protections into account for accesses with cached
    gfn->hva
  KVM: pfncache: Fail to refresh if it contains memory protections
  KVM: x86/mmu: Take memory protection attributes into account during
    faults
  KVM: x86/mmu: Issue memory fault exit if walk failed due to memory
    attribute
  KVM: x86/mmu: Do not update accessed/dirty if guest PTE is read-only
  KVM: x86/mmu: Do not prefetch sptes on gfns backed by memory
    attributes

Paolo Bonzini (14):
  KVM: selftests: Test address translation for Hyper-V direct L2
    hypercalls
  KVM: apply nGPA->GPA translation to KVM_HC_CLOCK_PAIRING
  KVM: x86: Introduce memory fault on invalid hypercalls reads/writes
  KVM: selftests: test hypercall memory fault exits
  KVM: x86/mmu: intersect writability from __kvm_faultin_pfn with
    fault->map_writable
  KVM: x86/mmu: Extend map_writable to a full ACC_* mask
  KVM: pass kvm == NULL case to kvm_arch_has_private_mem
  KVM: adjust for presence of more than one attribute
  KVM: Introduce kvm_fetch_guest_page() and use it for x86
  KVM: Introduce kvm_check_gen()/kvm_memslots_check_gen()
  KVM: x86/mmu: Obsolete all roots if memattr contains gPTEs
  KVM: x86: selftests: Introduce memory protection attributes test
  KVM: x86: selftests: Introduce memory attributes PTE test
  KVM: x86: selftests: Introduce memory attributes side-channel tests

 Documentation/virt/kvm/api.rst                |  38 +-
 arch/x86/include/asm/kvm_host.h               |   4 +-
 arch/x86/kvm/Kconfig                          |   4 +-
 arch/x86/kvm/hyperv.c                         | 157 ++++--
 arch/x86/kvm/mmu/mmu.c                        | 169 +++++--
 arch/x86/kvm/mmu/mmu_internal.h               |  21 +-
 arch/x86/kvm/mmu/mmutrace.h                   |  36 ++
 arch/x86/kvm/mmu/paging_tmpl.h                |  25 +-
 arch/x86/kvm/mmu/spte.c                       |  12 +-
 arch/x86/kvm/mmu/spte.h                       |  13 +-
 arch/x86/kvm/mmu/tdp_mmu.c                    |   2 +-
 arch/x86/kvm/x86.c                            |  57 ++-
 include/linux/kvm_host.h                      | 128 ++++-
 include/linux/kvm_types.h                     |   6 +-
 include/trace/events/kvm.h                    |  14 +-
 include/uapi/linux/kvm.h                      |   7 +
 tools/include/uapi/linux/kvm.h                |   3 +
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +
 .../testing/selftests/kvm/include/kvm_util.h  |  32 +-
 .../selftests/kvm/include/x86/processor.h     |   1 +
 .../testing/selftests/kvm/lib/x86/processor.c |   5 +
 .../testing/selftests/kvm/memory_attributes.c | 453 ++++++++++++++++++
 tools/testing/selftests/kvm/x86/hcall_fault.c | 236 +++++++++
 .../testing/selftests/kvm/x86/hyperv_evmcs.c  |  17 +-
 .../selftests/kvm/x86/hyperv_svm_test.c       |  15 +-
 .../selftests/kvm/x86/memory_attributes.c     | 415 ++++++++++++++++
 .../kvm/x86/private_mem_kvm_exits_test.c      |   6 +-
 virt/kvm/kvm_main.c                           | 252 ++++++++--
 virt/kvm/pfncache.c                           |  30 +-
 29 files changed, 1973 insertions(+), 187 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/memory_attributes.c
 create mode 100644 tools/testing/selftests/kvm/x86/hcall_fault.c
 create mode 100644 tools/testing/selftests/kvm/x86/memory_attributes.c

-- 
2.52.0

