Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641295;
	b=nTUuQZKWgWHF/b/AT5qffcx+wrBwdU+5rYvCvEtGjS02a7OSH/p1n1lmAbQ1RACjL4M9
	 VWr9zu6OiiVGmKCnAlRdxj2mYCeB8tLbnjBMMKrJfHK0cMeD0yelX1SPUN0Ybf6Zw5D/7
	 xBhUknoz5E7X+awBEUMaSG16pcDtjGsVEL+wW8IqfcuUKLHNGjewXWmZ0Fwk4KGCZP2wE
	 1skHF8kx4ZCu3tqsA8BE3P7QL5h92NlmrMFXXhddoMoxygugALr5vtqvMGrkwdYoPVCUr
	 2CHzD8pgz3Oewm+F2aLnGQv6D0VcN7aM+6hFjngCHfoGEEogW7SGAOKH0EfosoVX0DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641295;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=xpVf0GisYiooIupLoMQqPECRdo7eVWxHU83ROCqRz1k=;
	b=Obi1fCs0PMuteos4iZWNG0on8mzXaxdSZNvAq1ulsoHGByy9wmGjK/e9MHxuOzsbhjoN
	 NbKSOdbN59okZvRbo7cBWBQSIkLewUzjFGUNYDAMd8JS+/9sTjX84MhXyB9SfcIpAZTSl
	 3CrEWuoHvnAhOKfRvLbtq0bMe5Me/J5KUudKFesdxYUsyS8aQQ0OYyLu+jXHnnotqhGHP
	 LsuhaVSp2yU9nhdNyyomZsU8a9Seqa28k4a4GKaiip5mVT27itESfmcBsqlsoguvEh7Qs
	 /9Kt7DWGmCSKrpNJd0iSkI+bzlWbWRPrXiCJaKt0OQwczGUK+DqtNRQFBuH7kPD3BWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NSGvhRBs;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8083E606BA45
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8083E606BA45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NSGvhRBs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xpVf0GisYiooIupLoMQqPECRdo7eVWxHU83ROCqRz1k=;
	b=NSGvhRBsOA+NhdpXpQTIVAJmBr6vVErMbn5TxoWyDdD2Pj0D2duFdl3wTPfVfseH1C8Yz8
	+yQxU3ZOIoExTOeAD0LyHcnBV0LSI17UMrqbNQDhaLc/KRRWHrcAMt06bofQjPUo8M7RGC
	6k6Ng5YWHB/7/RUjdtsNUxhQrmroEV8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-XmERt2bwPHG4AC8aYgaGyA-1; Mon,
 02 Nov 2026 12:41:32 -0500
X-MC-Unique: XmERt2bwPHG4AC8aYgaGyA-1
X-Mimecast-MFC-AGG-ID: XmERt2bwPHG4AC8aYgaGyA_1793641291
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 375CB18009B9;
	Mon,  2 Nov 2026 17:41:31 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C747030001A2;
	Mon,  2 Nov 2026 17:41:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 00/45] KVM: x86: Introduce memory protection attributes
Date: Mon,  2 Nov 2026 12:40:44 -0500
Message-ID: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This series introduces a mechanism to let userspace block read,
write or execute access to individual GFNs via KVM's memory
attribute mechanism, and have them reported via KVM_EXIT_MEMORY_FAULT.

KVM needs to check the attributes anytime KVM takes GPAs as input for any
action initiated by the guest; if the memory attributes are incompatible
with such action, it should be stopped.  This means that there are quite
a lot of cases to handle, and while in most cases they occur before
committing to the execution of an instructions (for example, page walks),
there are other cases where a full implementation of attributes would
basically require an implementation of transactional memory accesses:
notably (from inevitable to where I finally drew the line) nested
virtualization, emulation, SMM switch, task switch.  In the worst case,
the processor might have executed the instruction before issuing a
trap-like vmexit - and if the instruction length is not provided and
the instruction is not accessible, there's no practical alternative
to returning -EIO and marking the VM as dead.

For this reason, documentation now clarifies that invalid accesses may not be
recoverable and may be reported in the same way as MMIO.

Along the way, the patches fix some issues in the memory attributes code,
that surfaced due to having more than one attribute.  Still, no matter
how careful I tried to be, I'm ready for the absolute massacre that
Sashiko will make of this stuff.

Paolo

v3->v4:
- New patch "KVM: nVMX/nSVM: check unconditionally whether CR3 is valid"
- New patch "KVM: x86/emulate: Check TSS busy-bit writes during task switches"
- Rebase on top of new VM memory attributes code
- Use kvm_check_gen in Longarch
- New patches to surface memory faults from the emulator and from nested
  GPA translation (15, 29-36, 38-39)
- Clarify in the docs that memory faults in some cases may not be recoverable

Anish Moorthy (1):
  KVM: Define and communicate KVM_EXIT_MEMORY_FAULT RWX flags to
    userspace

Nicolas Saenz Julienne (11):
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

Paolo Bonzini (33):
  KVM: nVMX/nSVM: check unconditionally whether CR3 is valid
  KVM: x86/hyperv: do not overwrite hc->ingpa for SIGNAL_EVENT hypercall
  KVM: x86: apply nGPA->GPA translation to KVM_HC_CLOCK_PAIRING
  KVM: x86/emulate: Check TSS busy-bit writes during task switches
  KVM: loongarch: do full validity check on the gfn-to-hva cache
  KVM: selftests: Test address translation for Hyper-V direct L2
    hypercalls
  selftests: kvm: drop TEST_ASSERT_SUPPORTED_ATTRIBUTES
  KVM: x86: Introduce memory fault on invalid hypercalls reads/writes
  KVM: selftests: test hypercall memory fault exits
  KVM: x86/mmu: intersect writability from __kvm_faultin_pfn with
    fault->map_writable
  KVM: x86/mmu: Extend map_writable to a full ACC_* mask
  KVM: VMX: return error from kvm_set_cr*
  KVM: adjust for presence of more than one attribute
  KVM: Introduce kvm_fetch_guest_page() and use it for x86
  KVM: Take memory protections into account for __kvm_vcpu_map
  KVM: Introduce kvm_check_gen()/kvm_memslots_check_gen()
  KVM: x86/emulate: change return value of emulator_io_permitted to int
  KVM: x86/emulate: Propagate memory faults to userspace
  KVM: x86: "Handle" failed decode when skipping instructions
  KVM: vmx/sgx: make return value of sgx_gva_to_gpa consistent with its
    callers
  KVM: x86: Allow page fault fixup to return errors
  KVM: x86/mmu: Adjust gva_to_gpa to allow returning an error
  KVM: x86/mmu: Propagate errors from nested GPA translation
  KVM: x86: Propagate memory faults through load_pdptrs()
  KVM: x86/mmu: Issue memory fault exit if walk failed due to memory
    attribute
  KVM: x86: mark VM as dead after KVM_SET_SREGS fails to load PDPTRs
  KVM: VMX: mark VM dead on shadow VMCS or eVMCS access failures
  KVM: let kvm_arch_post_set_memory_attributes drop mmu_lock
  KVM: x86/mmu: Obsolete all roots if memattr contains gPTEs
  KVM: x86: selftests: Introduce memory protection attributes test
  KVM: x86: selftests: Introduce memory attributes PTE test
  KVM: x86: selftests: Introduce memory attributes side-channel tests
  KVM: x86: split out parts of load_pdptrs

 Documentation/virt/kvm/api.rst                |  57 ++-
 arch/loongarch/kvm/vcpu.c                     |  12 +-
 arch/x86/include/asm/kvm_host.h               |  18 +-
 arch/x86/kvm/Kconfig                          |   2 +-
 arch/x86/kvm/emulate.c                        |  82 +++-
 arch/x86/kvm/hyperv.c                         | 174 +++++--
 arch/x86/kvm/kvm_emulate.h                    |   3 +
 arch/x86/kvm/mmu.h                            |  28 +-
 arch/x86/kvm/mmu/mmu.c                        | 200 +++++++--
 arch/x86/kvm/mmu/mmu_internal.h               |  21 +-
 arch/x86/kvm/mmu/mmutrace.h                   |  36 ++
 arch/x86/kvm/mmu/paging_tmpl.h                |  63 ++-
 arch/x86/kvm/mmu/spte.c                       |  12 +-
 arch/x86/kvm/mmu/spte.h                       |  13 +-
 arch/x86/kvm/mmu/tdp_mmu.c                    |   2 +-
 arch/x86/kvm/regs.c                           | 103 +++--
 arch/x86/kvm/regs.h                           |   9 +
 arch/x86/kvm/svm/nested.c                     |  51 +--
 arch/x86/kvm/svm/svm.c                        |  19 +-
 arch/x86/kvm/vmx/hyperv.c                     |   7 +-
 arch/x86/kvm/vmx/nested.c                     |  53 ++-
 arch/x86/kvm/vmx/sgx.c                        |  35 +-
 arch/x86/kvm/vmx/vmx.c                        |  59 ++-
 arch/x86/kvm/x86.c                            | 204 ++++++---
 arch/x86/kvm/x86.h                            |   2 +-
 include/linux/kvm_host.h                      | 133 +++++-
 include/linux/kvm_types.h                     |   6 +-
 include/trace/events/kvm.h                    |  14 +-
 include/uapi/linux/kvm.h                      |   7 +
 tools/include/uapi/linux/kvm.h                |   3 +
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +
 .../testing/selftests/kvm/include/kvm_util.h  |  37 +-
 .../selftests/kvm/include/x86/processor.h     |   1 +
 .../testing/selftests/kvm/lib/x86/processor.c |   5 +
 .../testing/selftests/kvm/memory_attributes.c | 424 ++++++++++++++++++
 tools/testing/selftests/kvm/x86/hcall_fault.c | 246 ++++++++++
 .../testing/selftests/kvm/x86/hyperv_evmcs.c  |  16 +-
 .../selftests/kvm/x86/hyperv_svm_test.c       |  15 +-
 .../selftests/kvm/x86/memory_attributes.c     | 415 +++++++++++++++++
 .../kvm/x86/private_mem_kvm_exits_test.c      |   5 +-
 virt/kvm/kvm_main.c                           | 315 +++++++++++--
 virt/kvm/pfncache.c                           |  30 +-
 42 files changed, 2498 insertions(+), 441 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/memory_attributes.c
 create mode 100644 tools/testing/selftests/kvm/x86/hcall_fault.c
 create mode 100644 tools/testing/selftests/kvm/x86/memory_attributes.c

-- 
2.52.0

