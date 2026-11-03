Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710180;
	b=wMhF73s0vfLvq7xRMwL1WSdCJN2QsDykr0O4np9D/f3Z2PftLJHzPkXhHOuWfzKldkzz
	 7rmzZbvJ92vFkcQWOVCpTDqTAEHWQHCN5dM6PvvJaiRm2Yk0KCkFBalqhzHDlO16SdKqz
	 2rxtCUeXCkRKXZfeuaFqiaY5xa1DZNXsoCcDoLSMj/24IaItWot5PjnBRKNGbImylCYfe
	 YWgwa7zSsaH/dTJmrT2rm4n2UpWZJJo900Jvms1dT/D1Bu07LLT/DSirdfuS2M8Pp0EDr
	 8Incw/aFUmrdOluhjdPWD141ysPJt+MVg2kBeW+SN9XaZCv6HGkqPq2M0NvLkIdcOCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710180;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=a0Lm1vXPbpXrZZMrNcubolRKf55hgxzUId1YVKIzCUk=;
	b=4p0CVxce9WdlzbMUN1xPIOXGkW54MY0xyynDo0A406X6honl7qPHmnHbJuwrwYb6RCLn
	 hH+ByCautNucdygjQkHyfN7crvidhM1x9eqCOqkKFPSnJ4Y1CL4i4lUiZpozOW8eH3VLA
	 aDNHDfF2c+VZjoN6DKEL611iBKWkJY1+jmIYtg5TtMaVJbzJGkpm6MQ14HTohW0a8y40x
	 tyYZpSr6Mdt2t9sCwZc+M39aLk1bdUmve13jRKOxafl6FPiUX/t7Obc8OJwIxVHcEtald
	 a3bBC641u/QTLqkp5CYniFUAvv7S2ZUaM05EULb0L3SHMnOkLaKqN61mvIzz6sXA0NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GZ+S4ruF;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F0A606A326
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 12:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05F0A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GZ+S4ruF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793710178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a0Lm1vXPbpXrZZMrNcubolRKf55hgxzUId1YVKIzCUk=;
	b=GZ+S4ruF0T42UIZGKV/fVgVmlElSPDguXnYfjwOnrFBqjO8Iaqjm3V6B4ogzPJIUJPkfVl
	6WqSrgJuLO+j1NZQLFF/jJ03A7Lp5h0+y6NYaFHtf5bRbAVC23c7ZynRL28FbVbolLDvhf
	zsHBLHOmIylc8lo+QDEah30P0YO9SAg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-IqaLT1HiMjmdCfHLKqsn8Q-1; Tue,
 03 Nov 2026 07:49:35 -0500
X-MC-Unique: IqaLT1HiMjmdCfHLKqsn8Q-1
X-Mimecast-MFC-AGG-ID: IqaLT1HiMjmdCfHLKqsn8Q_1793710174
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEF571955D95;
	Tue,  3 Nov 2026 12:49:33 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A66271956087;
	Tue,  3 Nov 2026 12:49:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Hillf Danton <hdanton@sina.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Harry Yoo <harry@kernel.org>
Subject: [PATCH 0/2] KVM: remove the dummy allocation case from async page fault handling
Date: Tue,  3 Nov 2026 13:49:28 +0100
Message-ID: <20261103124930.2278671-1-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Asynchronous page fault handling is supposedly able to detect page
ready notifications that are sent before the waiter is registered,
but this code is broken for PREEMPT_RT because it tries to allocate in
hardirq-disabled context.

This code however is almost dead, because page ready notification will
happen on the same vCPU as the waiter and not until after the waiter
enables interrupts.  Outside guest mode, interrupts are only enabled once
the waiter has registered itself, and this guarantees that an outstanding
(non-spurious) waiter will always be found.  This unfortunately is not
the case for asynchronous page faults that are delivered while in guest
mode, but that can be fixed and the dubious code removed.

Paolo

Paolo Bonzini (2):
  KVM: register asynchronous page fault waits with interrupts disabled
  x86: KVM: remove the dummy allocation case from async page fault
    handling

 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/include/asm/kvm_para.h | 20 ++++++-
 arch/x86/kernel/kvm.c           | 97 +++++++++------------------------
 arch/x86/kvm/mmu.h              | 14 +++++
 arch/x86/kvm/mmu/mmu.c          |  4 +-
 arch/x86/kvm/svm/svm.c          |  3 +-
 arch/x86/kvm/vmx/main.c         |  2 +-
 7 files changed, 65 insertions(+), 76 deletions(-)

-- 
2.56.0

