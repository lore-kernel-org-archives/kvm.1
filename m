Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661009;
	b=N11DG4OI7S0sBf4OZuq1HK8KWVKOaDC+j5ToaYGg/IwLI7t6sPgOrcCPwKS1U19szr1r
	 EhzSiEv5L6sXmqQ/ceFky/KIFeS2YrJYTxPFF2d0n/CzqPS/vFrprtnLtnFiPExZ7RdAx
	 8aiDDWS0jj3FlKhuNQQKhKmwbRYU+4HmPjDLBQi5qpUa3ePMyzY6xdOUilTdrPPJFGy7s
	 xcPBUQIzTf0PT/NylCOpTMWV/PS2Y72dl1K8IQgQh3UeqOtiP7Zi/cR0KTZiit05lhYdY
	 5D7L1w0zJqg8EZvTTgfGQrWbjrNytZSHhLl97MKWXW/ADTmgUWyklg9/x+fnuo0xxTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661009;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=PLmzk2EAYnu/8wDyp2VG410DvcO1jx2BPELLQFlTulc=;
	b=VZytpyqDw1evfskjILjE1JFFnkgL9oU0Tne8XFTkbvU3BU1V/JdmLaRgWswknfRQHYg0
	 +PILFJosVkae8RVyEsEXfhIPXKE/aGLaZ9RaDn7XBxYrTxKAAVDfau3Z8fzMr1dPSKaKv
	 MP3SPCzgy2L3Lzt964c9JKHJpv7YAGJ5u2/psQrwZLFucwFWjJXdNLN4sjZ3RiktrGfAP
	 XasVb/sVf4VPdPg0kgzR4UzEZsWk4sHMSeQh21QuuwoDTMXgyE3rGfelQt61c8VwPZkzg
	 /fqDJR2VlniLA7z3pVGVPoZoMeGairxiXLRFv5VIMu93u1pfJII4vxpUdOT6G0fCMPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EIYV8G9r;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EE5606A326
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 23:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97EE5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EIYV8G9r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793661007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PLmzk2EAYnu/8wDyp2VG410DvcO1jx2BPELLQFlTulc=;
	b=EIYV8G9r8DuLpSI1IqQXV0JEahg8ktWziulpOPe1HLuG8sbzF00fBrgCeq8NM+gdaCHuZ4
	RCgpBtQqSNxz3QtcL4fo7HvSWfSnAyPNYu1tTgQmdim/KdvgSYdFFUKLw6lgObitctIvnj
	LROXvGy7wBR3aW1X6wSgC9BkSppI3cA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-IwvMzCBCPL-bJLufBbx5Rw-1; Mon,
 02 Nov 2026 18:10:04 -0500
X-MC-Unique: IwvMzCBCPL-bJLufBbx5Rw-1
X-Mimecast-MFC-AGG-ID: IwvMzCBCPL-bJLufBbx5Rw_1793661003
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3510F195605B;
	Mon,  2 Nov 2026 23:10:03 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0D8D7D5;
	Mon,  2 Nov 2026 23:10:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 7.4-rc2
Date: Mon,  2 Nov 2026 18:10:02 -0500
Message-ID: <20261102231002.13404-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Linus,

The following changes since commit 1689c80fca308978ea1c9f03d15a500f4e44e2e1:

  Merge tag 'kvmarm-fixes-7.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD (2026-10-28 19:01:07 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to d21eef2084a9af87ac2a783bc7c2b175ba114e4e:

  KVM: VMX: Add array_index_nospec() to evmcs_field_offset() (2026-11-02 13:15:45 -0500)

----------------------------------------------------------------
x86:

- Check validity of vmcb01 save area copied from SMRAM on RSM

- Conditionally resched when retrying gPTE walk on A/D update failure

- Conditionally resched when restarting REP string emulation

- Process each host MSR entry at most once when unwinding failed VM-Entry

- Cap number of parents of page table pages, to avoid quadratic teardown

- Unconditionally reset MMU context when emulating INIT

- Flush guest TLB when emulating a RESET to strictly honor the spec

- Add array_index_nospec() to evmcs_field_offset()

----------------------------------------------------------------
Amirmohammad Eftekhar (1):
      KVM: VMX: Add array_index_nospec() to evmcs_field_offset()

Sean Christopherson (7):
      KVM: nSVM: Check validity of vmcs01 save area copied from SMRAM on RSM
      KVM: x86/mmu: Conditionally resched when retrying gPTE walk on A/D update failure
      KVM: x86: Conditionally resched when restarting REP string emulation
      KVM: nVMX: Process each host MSR entry at most once when unwinding failed VM-Entry
      KVM: x86/mmu: Cap number of parent PTEs per SP at 1000 (the arbitrary rmap limit)
      KVM: x86: Unconditionally reset MMU context when emulating INIT
      KVM: x86: Flush guest TLB when emulating a RESET to strictly honor the spec

 arch/x86/kvm/mmu/mmu.c          | 10 +++++++++
 arch/x86/kvm/mmu/paging_tmpl.h  | 11 +++++++++-
 arch/x86/kvm/svm/nested.c       | 23 ++++++++++++++-------
 arch/x86/kvm/svm/svm.c          |  2 ++
 arch/x86/kvm/svm/svm.h          |  2 ++
 arch/x86/kvm/vmx/hyperv_evmcs.h |  2 ++
 arch/x86/kvm/vmx/nested.c       |  1 +
 arch/x86/kvm/x86.c              | 46 ++++++++++++++++++++++-------------------
 8 files changed, 68 insertions(+), 29 deletions(-)

