Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5772D3DA7FC
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866063; cv=none; b=h3E4hZs5VsHq9dpD3JZq1H2SJhYzbSItYixA1pwtOP5e5+ZULZfVlFFD6HJ4is2dvN4KjiXGeIlz13w4HFIWZk/yBDNi8EP/czYC9lqn2C91bVGGC6FWdrOWpeQ/R5LbyRpxKICmx81D7jGZzBAYBRUB34x2t1ZSFgcRAEWpA0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866063; c=relaxed/simple;
	bh=/3iHUapJvWn61p6DQJDxJ17dJ3h002p3tatqXia+mUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RYT3HSWRExr3fEtsLpL59MeYPe43EB6kRfaA7Ey+qiQS4lyp4cGW/L68TfjUMnn9ut2fp+yCZyMv6zxTVtt/sya7JKTx2FsWKfGtAQCgEFtXm3R1/2Zg+rnAHJKsufUzf9nzYurwOu+MoX4In0ao/sHL3cjeDeXYhpx9OshjJSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBBP2dV1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBBP2dV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778866061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PF2iRi/KlSWZ9i+kjBhBpDki8b5kFb+LIiunlQS+7Vc=;
	b=LBBP2dV1WryMaAPnrCyRPKJeNSP7S1JEN0RWEZKhdYFSlddIHgFIdJ7cgQLF68XDygSGU0
	Rgadiqo8Ok12RALgYczgRnhS1XyT1IRVicJbnhDHBmz6PwMbLkgVRpKf1ZWprf38ZvXRq+
	GwoyXB7WLgSMwlxNJcvxaYgfRs5Kl4o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-DUKNSCQXOwm0ub9sSuJePg-1; Fri,
 15 May 2026 13:27:38 -0400
X-MC-Unique: DUKNSCQXOwm0ub9sSuJePg-1
X-Mimecast-MFC-AGG-ID: DUKNSCQXOwm0ub9sSuJePg_1778866056
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01DE718002C7;
	Fri, 15 May 2026 17:27:36 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4420D30001A2;
	Fri, 15 May 2026 17:27:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH v2 0/3] KVM: Macrofy GPR swapping in assembly code
Date: Fri, 15 May 2026 13:27:31 -0400
Message-ID: <20260515172734.745763-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

A small change to Chang's patches from the APX series.
The main change is keeping __VCPU_REGS_* constants to avoid
relying on the ordering of constants in kvm_host.h, but I also
cleaned up the macros a bit to reduce the line code count
and clarify what is going on.

Paolo

v1->v2: remove unused r8d-r15d cases, clarify commit message,
	add comment, centralize .error usage in kvm_vcpu_regs.h



Chang S. Bae (3):
  KVM: VMX: Macrofy GPR swapping in __vmx_vcpu_run()
  KVM: SVM: Macrofy GPR swapping in __svm_vcpu_run()
  KVM: SEV: Macrofy GPR swapping in __svm_sev_es_vcpu_run()

 arch/x86/include/asm/kvm_host.h      |  16 ++--
 arch/x86/include/asm/kvm_vcpu_regs.h | 109 +++++++++++++++++++++++++--
 arch/x86/kvm/svm/vmenter.S           | 107 ++++++--------------------
 arch/x86/kvm/vmenter.h               |  31 ++++++++
 arch/x86/kvm/vmx/vmenter.S           |  89 +++++-----------------
 5 files changed, 181 insertions(+), 171 deletions(-)

-- 
2.52.0

