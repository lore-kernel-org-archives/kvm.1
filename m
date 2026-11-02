Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641299;
	b=oSJj4STYWxHExOn4BFE45/zPjWrHEOeEYWWk6jkxmkgb2eoxXSwbrwElXAOO3j3RvhTO
	 h/c1pEDoxUIjaj4RglmubUdl/Gy27ZYiBgns0TTwoQyitdyCB/dxhFa0kfNLxtkmIXVFY
	 22O50S3NQsZvjNT7+4vwa71SpMdycQdcN8bP82d63VMoXth6amutU8LcmE6gLHsxz63VS
	 8HPZNUO1yQa71/nEEZr7ilQTCaaR7f4AuL3H5DqZo8fn6jLyCuVZx99hYuaQGwrydcqmo
	 gpQ8Nmhsr5wAXZMKRi+DxYvk9ZsFoDFzKe560E76Q+2p9JaQ2POcsRu3pLqfa64VPfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641299;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=UMANxSC73tO0YEmg0ke+8t+NbPcvHz8AyBEapv8SX8c=;
	b=kIerWW6CSiFjIdpnjm49YjpAOUIstIS42NnegQ/k5mXSYs2juSqtYvX6C3UnzHaCRjie
	 VkoQaVEP15h8FSGyDd6h1mdOwpMoIviZc+lx/nrDBqoZUPuT4HtWCvc1Pjqi13CEV+u3D
	 yUvn1DD53XKkkbOJPFJWRpD0Wpyoh+xH+MCGZlYH+vwHhjgxsSj3JfoUMaOQLPfID8HMt
	 R92NEcNWZ96+le9AkjlZJ/BWesQVA2gOyPdMbgcJ2edMhNOiqEsEKNXFIcLCdV5iczsuJ
	 Pb3LaOxUyAorjvf5bYgEMtXZHWUil+/7AcERA4EfuJgtlv7zhbEBjfX/JZ8MAV5jQTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dCUNsWP+;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0486070CBC
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B0486070CBC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dCUNsWP+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMANxSC73tO0YEmg0ke+8t+NbPcvHz8AyBEapv8SX8c=;
	b=dCUNsWP+2U4p+xCP7HD5ZEWxPxfVS3D2f2fiyuw3kV1EcAEZEq7hYhrzpMykkKu8I3AYIw
	Qck5oxZ3rs6mhJZ2FQ+YhUqRX6A6bwvw86oFdLhP+yaPG+QRAsAXxKfr0cAaBT53o2lct0
	NwBtvIjF3cPaAy8umAfh0ZXfjFNPzI4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-jZD9R2wwOI-FZar1kA1WRg-1; Mon,
 02 Nov 2026 12:41:34 -0500
X-MC-Unique: jZD9R2wwOI-FZar1kA1WRg-1
X-Mimecast-MFC-AGG-ID: jZD9R2wwOI-FZar1kA1WRg_1793641293
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8515D195605A;
	Mon,  2 Nov 2026 17:41:33 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2666A30000E3;
	Mon,  2 Nov 2026 17:41:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 04/45] KVM: x86/emulate: Check TSS busy-bit writes during task switches
Date: Mon,  2 Nov 2026 12:40:48 -0500
Message-ID: <20261102174130.8779-5-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Task switching ignores failures when clearing the old TSS descriptor's
busy bit and setting the new descriptor's busy bit.  A memory attribute
restriction can therefore drop either write while the task switch
continues with inconsistent descriptor state.

Check both writes and stop the task switch on failure.  Memory attribute
faults reach the existing emulation-failure exit in kvm_task_switch().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/emulate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c1b21282187f..711794592c2c 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2925,7 +2925,9 @@ static int emulator_do_task_switch(struct x86_emulate_ctxt *ctxt,
 
 	if (reason == TASK_SWITCH_IRET || reason == TASK_SWITCH_JMP) {
 		curr_tss_desc.type &= ~(1 << 1); /* clear busy flag */
-		write_segment_descriptor(ctxt, old_tss_sel, &curr_tss_desc);
+		ret = write_segment_descriptor(ctxt, old_tss_sel, &curr_tss_desc);
+		if (ret != X86EMUL_CONTINUE)
+			return ret;
 	}
 
 	if (reason == TASK_SWITCH_IRET)
@@ -2949,7 +2951,9 @@ static int emulator_do_task_switch(struct x86_emulate_ctxt *ctxt,
 
 	if (reason != TASK_SWITCH_IRET) {
 		next_tss_desc.type |= (1 << 1); /* set busy flag */
-		write_segment_descriptor(ctxt, tss_selector, &next_tss_desc);
+		ret = write_segment_descriptor(ctxt, tss_selector, &next_tss_desc);
+		if (ret != X86EMUL_CONTINUE)
+			return ret;
 	}
 
 	ops->set_cr(ctxt, 0,  ops->get_cr(ctxt, 0) | X86_CR0_TS);
-- 
2.52.0


