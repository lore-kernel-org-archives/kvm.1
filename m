Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8B039CCEC
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719360; cv=none; b=FzTAt8MbFLWE0hxMMUdQhRwaoMvKpY40s1J/dOjcjeQgdHEoWuDZZ0/CTUISYVFaOPpjTch3/0a/P4Zq0Uxsn/V4LBAXh6P5oezORPyJcDYAqHf9dB8zE33UpSmKonyGDb9RO0groVeKDkFnmwZnUQtRoPJijE1i9xOCFKkXlOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719360; c=relaxed/simple;
	bh=zcNwGv45CExz7j/TVlzPBkHjSt0mpoZ14T1ighPkpqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rOsK02dK66qE7xkB/xIv9QyEXzriSPCsJwXm5EfgXu6rJ08zL5ipsqI1IyGyzqVdm9QbVf08arlKNYrnlsv+1JyaT+f6SPjJQCP6xsXNNxpzcWlZJrtfKFO6gDHNe9uKoAWAf82UbL6IqJvTbVIFkf6uZxhTcEaJXpg1zr0cPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/ILPn8Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/ILPn8Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789719352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/mcFx7CpqXrw9dX0AsthsvY4YVJ7zqnvie71XVwgx4=;
	b=Q/ILPn8YidCtGcqkec0yrFbNOr9gmNs3PiH5wPVbhObpPrMNxReq98ilomCSBvrV3A6ppS
	VO67rTHyOJzrvOTSQpQ/y5KgqJ8qqM9jstmNNhZGLx/sX6Za6WrWRi0ywTGJnqPeUBBgIU
	7SIqBLyrZh9cB2R4o1D7LHYx3b4ZkJM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-6kAO5bzdPCGg4RcQq4J4ew-1; Fri,
 18 Sep 2026 04:15:49 -0400
X-MC-Unique: 6kAO5bzdPCGg4RcQq4J4ew-1
X-Mimecast-MFC-AGG-ID: 6kAO5bzdPCGg4RcQq4J4ew_1789719348
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE864195396F;
	Fri, 18 Sep 2026 08:15:47 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4842D1800348;
	Fri, 18 Sep 2026 08:15:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH v2 04/28] KVM: apply nGPA->GPA translation to KVM_HC_CLOCK_PAIRING
Date: Fri, 18 Sep 2026 04:15:19 -0400
Message-ID: <20260918081543.139871-5-pbonzini@redhat.com>
In-Reply-To: <20260918081543.139871-1-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

KVM_HC_CLOCK_PAIRING writes to a guest physical addresses.  Treat it
as an L2 address when running nested, which is consistent with the
Hyper-V TLB flush hypercalls for example.

This is technically backwards incompatible, but it should be extremely
rare and thus we can treat it as a bugfix, I think.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4b3681796c75..2fbaa070f741 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7217,6 +7217,11 @@ static int kvm_pv_clock_pairing(struct kvm_vcpu *vcpu, gpa_t paddr,
 	clock_pairing.flags = 0;
 	memset(&clock_pairing.pad, 0, sizeof(clock_pairing.pad));
 
+	paddr = kvm_translate_gpa(vcpu, &vcpu->arch.gva_walk, paddr,
+				  PFERR_WRITE_MASK | PFERR_GUEST_FINAL_MASK, NULL, 0);
+	if (paddr == INVALID_GPA)
+		return -KVM_EFAULT;
+
 	ret = 0;
 	if (kvm_write_guest(vcpu->kvm, paddr, &clock_pairing,
 			    sizeof(struct kvm_clock_pairing)))
-- 
2.52.0


