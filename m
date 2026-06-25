Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886DD3E1225
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782390212; cv=none; b=bJtwHh29LSAt4/pO6zNVmK5sp6x6udrMQsjy0CTt9MIPrSiuw19NHDw4cLPn0V/durSI5N/HzCZy3eUM1ta9TrwsefUa1fPZdY/McKiDBQi+ruKEg+wUZi6G0A58LpI7isQqQUmsuP5+od4X9nqXBpZSTtvhldT47cr0WFcAp8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782390212; c=relaxed/simple;
	bh=LOacUdHBPfHdh/tCEZfBrQQZbnHG2QnCpCFPi1p0ENg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ag1AVCchl3moX+wYghzIJ4socrobK0bQ2GUNgspA52dSxvKwpCoRJ+DOCjkcxte7//MtPAizxnDIRsJykePmh2J1JwS+nTXIjNjKfxwxGCDiv91FzWM+TdJYp7hSyMtOuktUPHs1mHMlWs/Qu5+sUTGfT/Lp9sOsmQwKJIU0x2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYvcX2ZQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYvcX2ZQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782390210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/orPOCkuDR6uutUSWzOu/KudvBKU8ZQe3t31U8NojQo=;
	b=UYvcX2ZQfaFGmantssNN9+4RCqLm20lR5O+yBr7vdCEbj1rOc1auVmz9tDJqGpmOuilD17
	Ul8688VjyIk1huyPoQQaaxqIJkB+933XcB5pMNfz5RzihdOIFXRJSu9JYgZq2sTxCPFUsg
	UiiEfGgCNU/59Xffw68Pwe2EjpuFMCo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-FXYnBli7PpKs3SMTenm3Fw-1; Thu,
 25 Jun 2026 08:23:27 -0400
X-MC-Unique: FXYnBli7PpKs3SMTenm3Fw-1
X-Mimecast-MFC-AGG-ID: FXYnBli7PpKs3SMTenm3Fw_1782390206
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41603186BF02;
	Thu, 25 Jun 2026 12:23:26 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C47AC1956086;
	Thu, 25 Jun 2026 12:23:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 7.2-rc1
Date: Thu, 25 Jun 2026 08:23:23 -0400
Message-ID: <20260625122325.100485-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Linus,

The following changes since commit ef057cbf825e03b63f6edf5980f96abf3c53089d:

  KVM: x86/mmu: Ensure hugepage is in by slot before checking max mapping level (2026-06-16 00:39:57 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 098e32cba334da0f3fa8cfd4e022ae7c72341400:

  x86/apic: KVM: Use cpu_physical_id() to get APIC ID of running vCPU for AVIC (2026-06-24 07:52:24 -0400)

----------------------------------------------------------------
s390:

* Fix S390_USER_OPEREXEC so it can now be enabled regardless of other
  unrelated capabilities

* Fix handling of the _PAGE_UNUSED pte bit that could lead to guest
  memory corruption in some scenarios

* A bunch of misc gmap fixes (locking, behaviour under memory pressure)

* Fix CMMA dirty tracking

x86:

* Tidy up some WARN_ON() and BUG_ON(), replacing them with WARN_ON_ONCE()
  or KVM_BUG_ON().  All of these have obviously never triggered, or
  somebody would have been annoyed earlier, but still.

* Fix missing interrupt due to stale CR8 intercept

* Add a statistic that can come in handy to debug leaks as well as the
  vulnerability to a class of recently-discovered issues.

* Do not ask arch/x86/kernel to export default_cpu_present_to_apicid()
  just for KVM.

----------------------------------------------------------------
Carlos López (1):
      KVM: x86: Unconditionally recompute CR8 intercept on PPR update

Claudio Imbrenda (9):
      s390/mm: Fix handling of _PAGE_UNUSED pte bit
      KVM: s390: Fix dat_peek_cmma() overflow
      KVM: s390: Do not set special large pages dirty
      KVM: s390: Fix code typo in gmap_protect_asce_top_level()
      KVM: s390: Fix handle_{sske,pfmf} under memory pressure
      KVM: s390: Fix locking in kvm_s390_set_mem_control()
      KVM: s390: Fix cmma dirty tracking
      KVM: s390: selftests: Fix cmma selftest
      KVM: s390: Return failure in case of failure in kvm_s390_set_cmma_bits()

Eric Farman (3):
      KVM: s390: Fix S390_USER_OPEREXEC enablement without STFLE 74
      KVM: s390: selftests: Extended user_operexec tests
      KVM: s390: Fix typo in UCONTROL documentation

Paolo Bonzini (1):
      Merge tag 'kvm-s390-next-7.2-2' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD

Sean Christopherson (9):
      KVM: Replace guest-triggerable BUG_ON() in ioeventfd datamatch with get_unaligned()
      KVM: x86: Replace BUG_ON() with WARN_ON_ONCE() on "bad" nested GPA translation
      KVM: x86/mmu: Bug the VM, not the host kernel, if KVM write-protects upper SPTEs
      KVM: x86: Bug the VM, not the kernel, if the ISR count {under,over}flows
      KVM: x86: WARN and fail kvm_set_irq() if a PIC or I/O APIC vector is invalid
      KVM: x86: WARN (once) if RTC pending EOI tracking goes off the rails
      KVM: VMX: Grab vmcs12 on CR8 interception update iff vCPU is in guest mode
      KVM: x86/mmu: Expose number of shadow MMU shadow pages as a stat
      x86/apic: KVM: Use cpu_physical_id() to get APIC ID of running vCPU for AVIC

 Documentation/virt/kvm/api.rst                     |   2 +-
 arch/s390/include/asm/pgtable.h                    |   4 +-
 arch/s390/kvm/dat.c                                |   5 +-
 arch/s390/kvm/gmap.c                               |  37 +++++--
 arch/s390/kvm/gmap.h                               |  12 ++-
 arch/s390/kvm/kvm-s390.c                           |  71 ++++++++-----
 arch/s390/kvm/priv.c                               |  10 +-
 arch/s390/mm/gmap_helpers.c                        |   3 +-
 arch/x86/include/asm/kvm_host.h                    |  12 +--
 arch/x86/kernel/apic/apic_common.c                 |   1 -
 arch/x86/kvm/i8259.c                               |   3 +-
 arch/x86/kvm/ioapic.c                              |   7 +-
 arch/x86/kvm/lapic.c                               |   6 +-
 arch/x86/kvm/mmu/mmu.c                             |  14 +--
 arch/x86/kvm/mmu/mmutrace.h                        |   2 +-
 arch/x86/kvm/mmu/tdp_mmu.c                         |   8 +-
 arch/x86/kvm/svm/avic.c                            |   6 +-
 arch/x86/kvm/svm/nested.c                          |   3 +-
 arch/x86/kvm/vmx/nested.c                          |   3 +-
 arch/x86/kvm/vmx/vmx.c                             |   3 +-
 arch/x86/kvm/x86.c                                 |   6 +-
 .../testing/selftests/kvm/include/s390/facility.h  |   6 ++
 tools/testing/selftests/kvm/s390/cmma_test.c       |   6 ++
 tools/testing/selftests/kvm/s390/user_operexec.c   | 110 +++++++++++++++++++++
 virt/kvm/eventfd.c                                 |  12 +--
 25 files changed, 266 insertions(+), 86 deletions(-)

