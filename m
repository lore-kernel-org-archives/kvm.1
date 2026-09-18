Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E5C4FC8E6
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739440; cv=none; b=tMAxjf8OiJ6Yt2QyG264/Nbz8srXlNET1e8BOH30dAXIwXXlJFNZvRHb1FdI8tPCNMjeNAmWON/dVG/UEyKMS5CNxH5mBKXMHhjna2g7Esp9RxXlaVprIpEv6Sa/wxbicx9czonlAjAoatX0iF7pk2772jKPStYypNX0cPFa2Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739440; c=relaxed/simple;
	bh=yeA0gQmTaAuYpajrtvTGseh20/Xy3BB3TIyf/xMB5sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lLFjYanvzwfwsWH9BWnYB9oMh/DRJXSCRT1bgvQRjaa4pYoJ6xihWB5bklwRbhjPQuU9i/ZqBAFgLZbp1E9uqE6intBzhvZnM4LF8YwxdihU56kIzjeZlOB7rosQ7pIOKrS94nAtDZQRs0LfpsTDQg2qL5XWs/mUapUkujDcuBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g3lK4U4S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3lK4U4S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789739436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pz9Sxg8ozqUvccPFhu1ryUP6q1eLt28qLP3NX3nTRqY=;
	b=g3lK4U4SfjdRyA8rB48e4R/arR2dMKiNDzaWTJBPdynKUP8OGaQ+fmOmY+gmMEG/xBkupS
	KhRSrOEqjo3OtnWXbr32PhcCwE0khugv1007/eJCnLCUApnGDrFy+aUgwtjVTByw4xMDM5
	A6/wVaNhOI3jtopIu4hCuSTgBq4954U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-sIa9j6G3O7GCyWSslKYexg-1; Fri,
 18 Sep 2026 09:50:33 -0400
X-MC-Unique: sIa9j6G3O7GCyWSslKYexg-1
X-Mimecast-MFC-AGG-ID: sIa9j6G3O7GCyWSslKYexg_1789739432
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F4DE196CDD0;
	Fri, 18 Sep 2026 13:50:32 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6DA79195604B;
	Fri, 18 Sep 2026 13:50:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH v3 00/28] KVM: x86: Introduce memory protection attributes
Date: Fri, 18 Sep 2026 09:49:59 -0400
Message-ID: <20260918135030.171564-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

[cover letter copied from v2 - sorry for the very quick turnaround
but it's pointless to ask for reviews with the issues reported by
sashiko]

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

v2->v3 is just a bunch of sashiko fixes:
- new patch "KVM: x86/hyperv: do not overwrite hc->ingpa for slow
  SIGNAL_EVENT hypercall"
- rewritten "KVM: apply nGPA->GPA translation to KVM_HC_CLOCK_PAIRING"
  to handle cross-patch accesses
- rewrite choice of KVM_FILTER_SHARED/KVM_FILTER_PRIVATE prior to
  setting memory attributes; even though the previous version worked,
  it relied on not having any attribute at all for has_private_mem VMs
- fix WARN_ON_ONCE/WARN_ONCE confusion
- fix loongarch compilation
- new (not really satisfactory_ patch "KVM: Take memory protections into
  account for __kvm_vcpu_map"
- fix incorrect NOT in "KVM: x86/mmu: Do not prefetch sptes on gfns backed
  by memory attributes"
- do not use kvm_mmu_prepare_memory_fault_exit() for attribute exits on
  PTEs
- new patch "KVM: let kvm_arch_post_set_memory_attributes drop mmu_lock"
- testcase fixes

Anish Moorthy (1):
  KVM: Define and communicate KVM_EXIT_MEMORY_FAULT RWX flags to
    userspace

Nicolas Saenz Julienne (12):
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
  KVM: x86/mmu: Do not prefetch sptes on gfns backed by memory
    attributes
  KVM: x86/mmu: Take memory protection attributes into account during
    faults
  KVM: x86/mmu: Issue memory fault exit if walk failed due to memory
    attribute

Paolo Bonzini (18):
  KVM: x86/hyperv: do not overwrite hc->ingpa for slow SIGNAL_EVENT
    hypercall
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
  KVM: Take memory protections into account for __kvm_vcpu_map
  KVM: loongarch: do full validity check on the gfn-to-hva cache
  KVM: Introduce kvm_check_gen()/kvm_memslots_check_gen()
  KVM: let kvm_arch_post_set_memory_attributes drop mmu_lock
  KVM: x86/mmu: Obsolete all roots if memattr contains gPTEs
  KVM: x86: selftests: Introduce memory protection attributes test
  KVM: x86: selftests: Introduce memory attributes PTE test
  KVM: x86: selftests: Introduce memory attributes side-channel tests

 Documentation/virt/kvm/api.rst                |  38 +-
 arch/loongarch/kvm/vcpu.c                     |  12 +-
 arch/x86/include/asm/kvm_host.h               |   4 +-
 arch/x86/kvm/Kconfig                          |   4 +-
 arch/x86/kvm/hyperv.c                         | 172 +++++--
 arch/x86/kvm/mmu/mmu.c                        | 183 +++++--
 arch/x86/kvm/mmu/mmu_internal.h               |  21 +-
 arch/x86/kvm/mmu/mmutrace.h                   |  36 ++
 arch/x86/kvm/mmu/paging_tmpl.h                |  25 +-
 arch/x86/kvm/mmu/spte.c                       |  12 +-
 arch/x86/kvm/mmu/spte.h                       |  13 +-
 arch/x86/kvm/mmu/tdp_mmu.c                    |   2 +-
 arch/x86/kvm/x86.c                            |  66 ++-
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
 tools/testing/selftests/kvm/x86/hcall_fault.c | 246 ++++++++++
 .../testing/selftests/kvm/x86/hyperv_evmcs.c  |  16 +-
 .../selftests/kvm/x86/hyperv_svm_test.c       |  15 +-
 .../selftests/kvm/x86/memory_attributes.c     | 415 ++++++++++++++++
 .../kvm/x86/private_mem_kvm_exits_test.c      |   6 +-
 virt/kvm/kvm_main.c                           | 271 +++++++++--
 virt/kvm/pfncache.c                           |  30 +-
 30 files changed, 2027 insertions(+), 211 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/memory_attributes.c
 create mode 100644 tools/testing/selftests/kvm/x86/hcall_fault.c
 create mode 100644 tools/testing/selftests/kvm/x86/memory_attributes.c

-- 
2.52.0

