Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661273;
	b=o+u5B+3HWg0r0C7pNOQdgxMYkVAdfJxjZQZPFCz5cqFZdxdPwBremTZ1gVGUxeOuwBs7
	 EcsrxG4npwkT47BgD2gA8BpGokjFnXrXlCxJAjZ52HtyzjcGADuEs4HIAINruQI/bxMjm
	 E8hv50BnDuj4f6fB/P+oWunkepFnSTL01we3DCOTetUWe9lcB4kgFNc5mSHP5eBlXOhT0
	 PkJt680FkZYFsGMEPy609FY5ode3x+nlIqMTC/Syt7SNri/Uue7sc6pk0gvZaKYucqVFF
	 VmV4gzprtO1cJ+VMMY2I5X3rJ7fYBXi98oZNWqiTy53Sypol/i7dkUFmgKVaO5NJrXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661273;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=VFOpiJBU0+gSWaqRBXnhqnKbhLh4U3kkAdTn+n8aSUQ=;
	b=gH+EWqKTtSQqunG1qgsz2/pB90ut13C7+KHEBciBY43+zHT2PWW8oWiazuqLKfxeHRqK
	 YR82EZ7YZVmJZ2igJRDmQBA0upLMEqv1NYfsESZfIsngLMmK4CXgV4wQIhBkiG1uKAKqQ
	 cv74biMsro4J6qGZO3q0EjZCaHlmBIneVx3lqllK1KMyliiJJZz3zv1OsaWDKj9rHbI7j
	 0E5fw5tBXCEztSk164G4QNMkJ+xmldpLdosXAo6HmzYXB1pjHjUqN0owQ2Im99SEliVgU
	 BiaPVMvT0PtkUoT8bWIFQ2fmK+N+SQDY6im6WE0pUBeAi+C9Faq6kjmtkqa1ZuPj3tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WFca89Cw;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87A606A326
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 23:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E87A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WFca89Cw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793661272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VFOpiJBU0+gSWaqRBXnhqnKbhLh4U3kkAdTn+n8aSUQ=;
	b=WFca89Cw6KnPLeoEhdfh8KMlWA44fvcgGjRtjQfXNj2Iz7T425bPTV9O2mYq/dkYqmLwav
	q2gYWFnuohoaHT657eaI/G8zVD8eVff8NyEOXqBBfFahVE79eeH6pND5S+KGkZNKwiBqxR
	K0Gg0NVYYyYUbYFDl8FDH4958eQWGug=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-0zvIUFlMNxaztrUkky_fLA-1; Mon,
 02 Nov 2026 18:14:30 -0500
X-MC-Unique: 0zvIUFlMNxaztrUkky_fLA-1
X-Mimecast-MFC-AGG-ID: 0zvIUFlMNxaztrUkky_fLA_1793661269
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF6A518001EF;
	Mon,  2 Nov 2026 23:14:29 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A64A7D5;
	Mon,  2 Nov 2026 23:14:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 0/7] KVM: a bunch of fixes
Date: Mon,  2 Nov 2026 18:14:21 -0500
Message-ID: <20261102231428.13523-1-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Seven fixes ranging from performance issues to missing checks and potential
use of a stale role.  All except the last one are Cc'd to stable, and all
of them are already on their way to Linus.

Paolo

Sean Christopherson (7):
  KVM: nSVM: Check validity of vmcs01 save area copied from SMRAM on RSM
  KVM: x86/mmu: Conditionally resched when retrying gPTE walk on A/D
    update failure
  KVM: x86: Conditionally resched when restarting REP string emulation
  KVM: nVMX: Process each host MSR entry at most once when unwinding
    failed VM-Entry
  KVM: x86/mmu: Cap number of parent PTEs per SP at 1000 (the arbitrary
    rmap limit)
  KVM: x86: Unconditionally reset MMU context when emulating INIT
  KVM: x86: Flush guest TLB when emulating a RESET to strictly honor the
    spec

 arch/x86/kvm/mmu/mmu.c         | 10 ++++++++
 arch/x86/kvm/mmu/paging_tmpl.h | 11 +++++++-
 arch/x86/kvm/svm/nested.c      | 23 +++++++++++------
 arch/x86/kvm/svm/svm.c         |  2 ++
 arch/x86/kvm/svm/svm.h         |  2 ++
 arch/x86/kvm/vmx/nested.c      |  1 +
 arch/x86/kvm/x86.c             | 46 ++++++++++++++++++----------------
 7 files changed, 66 insertions(+), 29 deletions(-)

-- 
2.52.0

