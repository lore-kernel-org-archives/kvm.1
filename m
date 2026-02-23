Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3135B3EBF1F
	for <kvm@vger.kernel.org>; Mon, 23 Feb 2026 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885159; cv=none; b=S+LRzzqxtbWH4MB2Kh2TTaR6NnZbcTRw1S5tuHj9BT4qBLB5Ti2rQqLbMhYdCw64M5MRMoKYzYBj3aTzD1sC0t0/pmdT2GpKRIEHOj/1u3ahvOzLQzuo8rg88iU8xtHrv+0p3TlcSPF/Mb/KPgotFVRqhtbXDEm0b2YO8IyMz7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885159; c=relaxed/simple;
	bh=Z8+EKUmRekXnjv42iKO2Z13YRJlg38AEUap4gCkPGSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oYuMs6X5Losn8B/xh+LE8uguiPWR5Tur/GAC8c8vZdVyt42X+LTEUCK6bmNoOZRLMg3RSSpTNLaALY5pmDFG9XPU4x51UlPxtLZoSfpdxdCVa7tgJnufTrs6LaqJAleGpEuokSQEwbp5PzID9oKImNhgnOI/FAcKExkxJNTcN2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsRZKckb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsRZKckb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771885157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DrxxrqBVYKc8B0xIp7sy3PR0C7uqzmLMHDNVqq2QdHs=;
	b=gsRZKckb6/htuLLvHkAQhQY7OkS1xgpTpRxuguO1rC9hUQO9/9CqBoIBsCdBGsXs38z6X4
	qfxhVojr0P0L//TZZ2RRRXHGpOtHjDnbncIlXO6kUykqU1Z9aCs5AVd9p2VG6CY/c1IfQN
	qw8qOW5P2bsraZiNhsARP/mulllt9IQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-PWs3y4LPOO2ON-HM__iNVg-1; Mon,
 23 Feb 2026 17:19:12 -0500
X-MC-Unique: PWs3y4LPOO2ON-HM__iNVg-1
X-Mimecast-MFC-AGG-ID: PWs3y4LPOO2ON-HM__iNVg_1771885151
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D36E1956094;
	Mon, 23 Feb 2026 22:19:11 +0000 (UTC)
Received: from intellaptop.lan (unknown [10.22.65.168])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 834771955F43;
	Mon, 23 Feb 2026 22:19:09 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH] accel/kvm: Don't clear pending #SMI in kvm_get_vcpu_events
Date: Mon, 23 Feb 2026 17:19:08 -0500
Message-ID: <20260223221908.361456-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The kvm_get_vcpu_events propogates the state of the pending smi
from the kernel to the cpu->interrupt_request, with the intention
of having un up to date migration state.

Later the opposite is done, the kvm_put_vcpu_events restores the state
of the pending #SMI from the 'cs->interrupt_request'

The only problem is that kvm_get_vcpu_events also resets the SMI
in cpu->interrupt_request when there is no pending #SMI indicated by the kernel,
and that is wrong as the SMI might be still raised by qemu.

While at it, also fix a similar but more theoretical bug with regard to a
latched #INIT while in SMM.

A simple reproducer for this bug is to read an EFI variable in a loop
from within a guest, while at the same time run 'info registers' on
the qemu HMP monitor.

The reads will, once in a while, fail with an 'Invalid argument' error.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 target/i386/kvm/kvm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9f1a4d4cbb26..bed7768c28d7 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5502,8 +5502,6 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
         }
         if (events.smi.pending) {
             cpu_interrupt(CPU(cpu), CPU_INTERRUPT_SMI);
-        } else {
-            cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_SMI);
         }
         if (events.smi.smm_inside_nmi) {
             env->hflags2 |= HF2_SMM_INSIDE_NMI_MASK;
@@ -5512,8 +5510,6 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
         }
         if (events.smi.latched_init) {
             cpu_interrupt(CPU(cpu), CPU_INTERRUPT_INIT);
-        } else {
-            cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_INIT);
         }
     }
 
-- 
2.49.0

