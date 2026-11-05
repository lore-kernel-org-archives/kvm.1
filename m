Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897146;
	b=fLYZ+jvYCqjjLM1yQdGt9nU9EPQ8XAW8qKIe6MrnDVPm1yq+RKURnVBN1F9S5VQO1LRe
	 /0wIMGNLeP8LErtwrXLeX9Vvm/BhHuITH5M6WTe6iTzqoK8ME47+fHpote6Eyfd6pdUMr
	 bP3gz5MDl9UXZ87ZpGOPezelMvEMrRBS1Zl3y/qQ/T8K+t+3gdJPXcLSsVZ7cZv2vLXQ+
	 t4iBaYPHsqciI69RAlJIAYZFgUKufRYgmDopVuBlUVq64RvU7pm5hH1ptGtqSqfL3zC21
	 l+6ewQR7xfi0+1HCtXAUehnTpgl0Ff7dAxhXbDraxC+vnL2o4qwq1+4woa6dwhnPAmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897146;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=zx5u9VN24sYUcmtlUelBRA8tzuXsBqsvfiKHKwuBQTk=;
	b=5JbQCv03G9CO+ngW5O/1w3CBGhv5ayXGBMl0D1flX1Z5meq8OrNnTTwsuZYWKRuVUIw1
	 tMKGrLVz0Cq0NNyOZupIwAIdl8ZjhS7FBiu7JChC/Ynw8wxMuHLAQ7T02wY8n7WQmDY7q
	 v706MhrNTnrQCgDyiegzwq5Thc6UXYtZcXD+lFgKLdxhj3y49V+cDBpgP8CsJ8XxLkm1f
	 egJ5A9vgHiI3XSUUKQsbnsJ5GhqS2Ym/nPNEoUGNvEDHqbvJgx2TzWVcO5WCneT70sGgV
	 GWD1clGzCZCEQLhFNHLvxx8Sajdw0PAyfTRoWZuZbsvdfNNmFlCA0TijFw3sfw1z5uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V9m3KZ4f;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D97C606A326
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 16:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D97C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V9m3KZ4f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793897144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zx5u9VN24sYUcmtlUelBRA8tzuXsBqsvfiKHKwuBQTk=;
	b=V9m3KZ4fpZ5jUpq18AXxpF3rskcNF319UEycnrQWh7501h7BjZCj6VpwN0KPXBzEUrahOA
	cVeBEqw9P9JZqgt58ZtMs4R/zdhpU9CijfDq8a06r7ORLg/12GbJJ22LG7MxvjeO9MNcuk
	u1y42Zx6SR7OGiXHkMdwFIdTm7RCxRc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-XaKuiKlfN-K6MD2zdsaerg-1; Thu,
 05 Nov 2026 11:45:38 -0500
X-MC-Unique: XaKuiKlfN-K6MD2zdsaerg-1
X-Mimecast-MFC-AGG-ID: XaKuiKlfN-K6MD2zdsaerg_1793897137
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72937180063B;
	Thu,  5 Nov 2026 16:45:35 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46BEB195608A;
	Thu,  5 Nov 2026 16:45:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Hillf Danton <hdanton@sina.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Harry Yoo <harry@kernel.org>
Subject: [PATCH v2 0/5] KVM: remove the dummy allocation case from async page fault handling
Date: Thu,  5 Nov 2026 17:45:26 +0100
Message-ID: <20261105164531.313849-1-pbonzini@redhat.com>
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

On top of this I have rebased Sean's attempt at moving asynchronous
page fault handling to vcpu_enter_guest(), rebased on top of the new
code that splits registration for wait.

Paolo Bonzini (5):
  x86: KVM: take b->lock around wait
  KVM: x86: register asynchronous page fault waits with interrupts disabled
  x86: KVM: remove the dummy allocation case from async page fault handling
  KVM: x86: allow handle_exit_irqoff to return EXIT_FASTPATH_*
  KVM: x86: move asynchronous page fault handling to vcpu_enter_guest()

 arch/x86/include/asm/kvm_host.h |   5 +-
 arch/x86/include/asm/kvm_para.h |  20 ++++++-
 arch/x86/kernel/kvm.c           | 103 ++++++++++----------------------
 arch/x86/kvm/mmu.h              |  17 ++++++
 arch/x86/kvm/mmu/mmu.c          |  19 +-----
 arch/x86/kvm/svm/nested.c       |   4 --
 arch/x86/kvm/svm/svm.c          |  17 +++---
 arch/x86/kvm/vmx/main.c         |  24 ++++----
 arch/x86/kvm/vmx/nested.c       |   3 +-
 arch/x86/kvm/vmx/vmx.c          |   6 +-
 arch/x86/kvm/x86.c              |  18 +++++-
 11 files changed, 114 insertions(+), 122 deletions(-)

-- 
2.56.0

