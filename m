Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301BD47F795
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 16:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071986; cv=none; b=SYjVNWH4RpB950eIof4NfylzGBrrC8p3ZGNAXl0DABjIMVMGbzC2bDA0k7GPBoK1zhHqbDO0ZD2JnVbEAFlyYG/GrI2yBh+h9jZMT6Q3gZw3eDm32ix2y8a6uijexFecvszT2tC9CMQpfJ60gMA3QJUhy343UFB9r5+nKMdXzOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071986; c=relaxed/simple;
	bh=C1F8MSCXZdw2gSBdeTlrrshuMxPkam/SwwipguxvXO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m41hrOfpT3NQGB2+vITLj/UF760vIJHJFe6EoNqs0hSXBymsymbRgJcvorTzcg4jaZZAIhEMz9VK6Zy0o9TcSf5kbM6tMxqGr69WghYGUwKq5569F2fQa21jjHRVNBhDRltudLxNcautbkspvSaTn+aYjQlGNBbC9kdthANw8BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YpHFNsWV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpHFNsWV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787071983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qTNLqVgGi39GZ+CQDUB01Lka34UBMintTBhWx9EIAP8=;
	b=YpHFNsWVrgBGS0pZSnksr4WCW4ZxOLxY7KiDFAviD0iiVnJ/dOmV9UvydPdI0KJRdNCQGK
	izcvM6hmLaU74chlePxdnM5gLvekAeM5XX1/y9M/JwabstVC6FdHyHhXcvuQ1kbY1qf6sS
	eWC89rt9lIoDidS8Le7wx7E0yMCMoSc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-wQvz-JH6NWOR6Rxjq3-j8w-1; Tue,
 18 Aug 2026 12:53:02 -0400
X-MC-Unique: wQvz-JH6NWOR6Rxjq3-j8w-1
X-Mimecast-MFC-AGG-ID: wQvz-JH6NWOR6Rxjq3-j8w_1787071981
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C00F19560A2;
	Tue, 18 Aug 2026 16:53:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.151])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A065B3000239;
	Tue, 18 Aug 2026 16:52:59 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: f734222792@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] KVM: nVMX: Adjust VMPTRLD/VMPTRST behavior with active eVMCS
Date: Tue, 18 Aug 2026 18:52:54 +0200
Message-ID: <20260818165258.2613603-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Changes since v1:
- Fix build when !CONFIG_KVM_HYPERV [Sashiko]
- Drop now-unneeded evmcs_vmptrst() [Sashiko]
- Avoid hardcoding VMPTRLD insn length in hyperv_evmcs [Sashiko], use
  KVM_ASM_SAFE framework instead [Sean]

It was reported (https://bugzilla.kernel.org/show_bug.cgi?id=221841) that
KVM's emulation of VMPTRLD/VMPTRST instructions when Enlightened VMCS is
active is sub-optimal: returning '1' does not make the L1 guest skip the
instruction so a hang is likely to happen. While TLFS does not really
specify the expected behavior, genuine Hyper-V seems to return #UD for
VMPTRLD and eVMCS pointer for VMPTRST. Alter the behavior in KVM and check
it in selftests.

Note: this is not a security issue. Misbehaving L1 can only do self-harm
by doing VMPTRLD/VMPTRST when it also uses eVMCS.

Vitaly Kuznetsov (4):
  KVM: nVMX: Make VMPTRLD result in #UD when eVMCS is used
  KVM: nVMX: Make VMPTRST return eVMCS GPA when it is used
  KVM: selftests: Adapt to the updated VMPTRST behavior when eVMCS is
    used
  KVM: selftests: Check VMPTRLD with active eVMCS

 arch/x86/kvm/vmx/nested.c                     | 24 +++++++++-----
 .../testing/selftests/kvm/include/x86/evmcs.h |  8 -----
 tools/testing/selftests/kvm/include/x86/vmx.h | 22 +++++++++----
 .../testing/selftests/kvm/x86/hyperv_evmcs.c  | 31 ++++++++++++++-----
 4 files changed, 56 insertions(+), 29 deletions(-)

-- 
2.55.0

