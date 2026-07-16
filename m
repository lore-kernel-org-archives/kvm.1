Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30C437AA9A
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225708; cv=none; b=O+HsymssSqxtOQHuh51L30TwZXsBoXSmpATwMjOuJU4ExX4x96209fe7oFe4gQX2JBq0u8sRBuYPUOlJqB1uD0/wcl/UIwcWWKIVJPaSU/ZgvEJtsE4Cf9dI0P6wdhDwObOsDDQeBgnkljFabRZ9bjeaWz2gb9wfbMkYEXWv1o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225708; c=relaxed/simple;
	bh=hhYTI2Fc0BA/Ui+kcRbTi/4ttU6Lhi1lXME/XKpqeLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vAE4F4HBotXyqeNkYnrt52qTl+I80RKocuoGNmkVcHjV043EzycpVsKRuiyk3zc9oYYDMWvXlU/3zv1VHFC6bAWkYVcSrDbwv1YNkFs3I5JVBF2wDjq5sjc/w6mX1YK2sFvMEstvyko2eBBvpc+cuTHLRlPJBl6YvQaMdfSqxPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gv0fPjFr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gv0fPjFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NuJb8hTVuknt1LZWYn4OXGbusPjlf7ZsjcLQrYJnma4=;
	b=Gv0fPjFruEIUOPoBBVqbBc8FktP8OHanqeu3QIrpyGO/c52IW9sZY95NZ4sWheRXKmXcPq
	9p+beLOR8706lxZ1Jspv/wqLldadiSvP+5gw46g8wB+idWcvVGf7YrBOuW31EXpEqUvMm1
	QifvKvaFkKDuQ2+BlxRxQw/v1Of6Uw8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496--2gpJx4BMWOvdplVUkWFkg-1; Thu,
 16 Jul 2026 14:14:58 -0400
X-MC-Unique: -2gpJx4BMWOvdplVUkWFkg-1
X-Mimecast-MFC-AGG-ID: -2gpJx4BMWOvdplVUkWFkg_1784225698
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE1901800656;
	Thu, 16 Jul 2026 18:14:57 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6BD96195604E;
	Thu, 16 Jul 2026 18:14:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [RFC PATCH 00/24] KVM: x86: Introduce memory protection attributes
Date: Thu, 16 Jul 2026 14:14:32 -0400
Message-ID: <20260716181456.402786-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This series introduces a mechanism to let userspace block read,
write or execute access to individual GFNs via KVM's memory
attribute mechanism, and have them reported via KVM_EXIT_MEMORY_FAULT.
It is mostly the work of Nicolas Saenz Julienne, with a bit of patch
reorganization and code cleanup on my side (and especially using the
revamped ACC_* mask in Linux 7.2).

The reason why it's so large is because  KVM needs to should check the
attributes anytime KVM takes GPAs as input for any action initiated by
the guest; if the memory attributes are incompatible with such action,
it should be stopped.  For more information see
https://lore.kernel.org/kvm/D3MJJCTNY7OM.WOB5W8AVBH9G@amazon.com/.

There are several bits missing:

- hypercall handling for non-HyperV hypercalls is untested.  Xen
  hypercalls are not a big deal (at least for me...) because userspace
  can always avoid using this feature together with Xen emulation,
  but KVM_HC_CLOCK_PAIRING can write to memory.  It should at least
  be tested!

- nested virtualization is untested and there is a known hole
  in patch 21

- MBEC/GMET support should be added too, I have taken it into account
  when rebasing Nicolas's work but haven't written the code yet

- the split between arch-independent and arch-dependent code in
  the tests can be improved.

- the pvclock test fails

The original idea for posting this was to let Sashiko loose on it.
Unfortunately, it probably won't be able to apply the patches :(
because they are based on kvm/next, so here it is in all its glory
for humans only.

Paolo

Anish Moorthy (1):
  KVM: Define and communicate KVM_EXIT_MEMORY_FAULT RWX flags to
    userspace

Nicolas Saenz Julienne (19):
  KVM: selftests: Take into account mixed memory fault flags
  KVM: x86: hyperv: Introduce memory fault on hcalls with bad ingpas
  KVM: x86: Avoid warning when installing non-private memory attributes
  KVM: x86/mmu: Init memslot hugepage information for non-private_mem VMs too
  KVM: Introduce NR/NW/NX memory attributes
  KVM: Include memory protections in result of gfn->hva conversion
  KVM: Take memory protections into account in kvm_read/write_guest()
  KVM: Encapsulate memattrs array into anonymous struct
  KVM: Introduce a generation number for memory attributes
  KVM: Take memory protections into account for accesses with cached gfn->hva
  KVM: pfncache: Fail to refresh if it contains memory protections
  KVM: x86/mmu: Take memory protection attributes into account during faults
  KVM: x86/mmu: Issue memory fault exit if walk failed due to memory attribute
  KVM: x86/mmu: Do not update accessed/dirty if guest PTE is read-only
  KVM: x86/mmu: Do not prefetch sptes on gfns backed by memory attributes
  KVM: x86/mmu: Obsolete all roots if memattr contains gPTEs
  KVM: x86: selftests: Introduce memory attributes test
  KVM: x86: selftests: Introduce memory attributes PTE test
  KVM: x86: selftests: Introduce memory attributes side-channel tests

Paolo Bonzini (4):
  KVM: x86/mmu: intersect writability from __kvm_faultin_pfn with
    fault->map_writable
  KVM: x86/mmu: Extend map_writable to a full ACC_* mask
  KVM: pass kvm == NULL case to kvm_arch_has_private_mem
  KVM: Introduce kvm_check_gen()/kvm_memslots_check_gen()

 Documentation/virt/kvm/api.rst                |  19 +-
 arch/x86/include/asm/kvm_host.h               |   4 +-
 arch/x86/kvm/Kconfig                          |   4 +-
 arch/x86/kvm/hyperv.c                         |  32 ++
 arch/x86/kvm/mmu/mmu.c                        | 193 ++++++--
 arch/x86/kvm/mmu/mmu_internal.h               |  21 +-
 arch/x86/kvm/mmu/mmutrace.h                   |  29 ++
 arch/x86/kvm/mmu/paging_tmpl.h                |  25 +-
 arch/x86/kvm/mmu/spte.c                       |  12 +-
 arch/x86/kvm/mmu/spte.h                       |  13 +-
 arch/x86/kvm/mmu/tdp_mmu.c                    |   2 +-
 arch/x86/kvm/x86.c                            |  19 +-
 include/linux/kvm_host.h                      | 124 ++++-
 include/linux/kvm_types.h                     |   6 +-
 include/trace/events/kvm.h                    |  14 +-
 include/uapi/linux/kvm.h                      |   7 +
 tools/include/uapi/linux/kvm.h                |   3 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |  33 +-
 .../selftests/kvm/include/x86/processor.h     |   1 +
 .../testing/selftests/kvm/lib/x86/processor.c |   5 +
 .../testing/selftests/kvm/memory_attributes.c | 457 ++++++++++++++++++
 .../selftests/kvm/x86/memory_attributes.c     | 385 +++++++++++++++
 .../kvm/x86/private_mem_kvm_exits_test.c      |   6 +-
 virt/kvm/kvm_main.c                           | 224 +++++++--
 virt/kvm/pfncache.c                           |  30 +-
 26 files changed, 1529 insertions(+), 140 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/memory_attributes.c
 create mode 100644 tools/testing/selftests/kvm/x86/memory_attributes.c

-- 
2.52.0

