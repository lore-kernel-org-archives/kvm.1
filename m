Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBD954763
	for <kvm@vger.kernel.org>; Sun, 11 Oct 2026 00:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791677591; cv=none; b=alEKJhTOa8QFYC7QMXVaCE+bnJz+e+xixdOJycHlwTfH5QcOJuS2SCCYUHnRALeOoLS++dDihRJ5IbdTkKiJiqSvY7EtTy4eFdIDidGMca7N0OvHntZKTBGRu9YKIEuiLn+nA8oLI5D6zMdY19ksaXbSTcx/HcylC3rBa4NpVY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791677591; c=relaxed/simple;
	bh=rJr+PXEBRDn/U+unsqqULi2Y/GhllVK3moCQhP/m2ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dTbVGKozV1hN02d86K7dD1LzFqMM0b0ThR4X/F5TC1TT2dLJmPjc0w5bWnhmd0He9yYgh20Qf2+f1LyGRzlC56SeXjpdBEaPBJF691iJdhTuAzYFSxn8wBA/j2UtzkAthmhTlPaKIWd3jorLVdHQfM+fqLKRi8rgo+rOL5qTbZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yc+wzqm1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yc+wzqm1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791677588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+OnL34M5MuvxOT/P7cYaq5gvVk8RyqKI4iwPV87ogp8=;
	b=Yc+wzqm1dLIuzFJ/tS6uoQ2IOYkb+lLTbZmeC1hLK+Z/R+QxRiXteCMan0ZixYOmHNnp1E
	BbBZtPr1CJHms+kZgJ+QQT3CQ6lV+0QptR9hA6FlP/L7FVojKXt8p4B6Whz4n8ZJCS0kAY
	+feQYRkSwxr3LbE6Seb0o93TemIGm/E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-JDGDCOplNcuGPgomy-isHw-1; Sun,
 11 Oct 2026 00:13:07 +0000
X-MC-Unique: JDGDCOplNcuGPgomy-isHw-1
X-Mimecast-MFC-AGG-ID: JDGDCOplNcuGPgomy-isHw_1791677585
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7D731954237;
	Sun, 11 Oct 2026 00:13:05 +0000 (UTC)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 72E3B1800351;
	Sun, 11 Oct 2026 00:13:04 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v2 0/2] KVM: nVMX: fix nested APICv emulation for windows guests
Date: Sat, 10 Oct 2026 20:13:01 -0400
Message-ID: <20261011001303.723721-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix two problems that were recently discovered that cause nested APICv=0D
to malfunction on windows with hyperv enabled.=0D
=0D
The first problem is that unlike KVM, windows doesn't set PIR.ON when=0D
sending posted interrupts. X86 spec actually allows this.=0D
=0D
The second problem is that unlilke KVM, which mostly ignores them,=0D
windows depends on accurate delivery of the posted notification=0D
interrupts, and currently it is possible for a posted notification=0D
to get lost it it arrives at the same time as the nested VM exit.=0D
=0D
V2: to avoid spurious notification in L1, process the posted=0D
notification in L2, just before VM exit.=0D
=0D
PS: I am not 100% sure if I got the barriers right, plus I am not sure=0D
about what to do if vmx_complete_nested_posted_interrupt can't write=0D
to the nested PIR, in this it calls kvm_handle_memory_failure, and=0D
I don't know 100% its interactions with nested VM exit.=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (2):=0D
  KVM: nVMX: don't check PIR.ON when processing nested posted interrupts=0D
  KVM: nVMX: avoid losing the posted notification interrupt when exiting=0D
    L2=0D
=0D
 arch/x86/kvm/vmx/nested.c | 22 ++++++++++++++++++----=0D
 arch/x86/kvm/vmx/vmx.c    |  5 +++++=0D
 2 files changed, 23 insertions(+), 4 deletions(-)=0D
=0D
-- =0D
2.54.0=0D
=0D

