Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641527;
	b=2GupQLNEC+CB8P0sCtN6ZI/lPGz5fIvO7g2VXwo414nUIcGlPA8Y38Btgt2ywGs2csq9
	 z8mSWUBR+Cogd9IrlCeAUjEEeo7hQRolKHA3LyIY6MIWCVx3+hsdUNLersyNxmMelLqs2
	 R76TEBWOWzQyLCtkSvrByT85nVpomC17GXFCnxH2qW2vcQ4BWk8R1doIF3JamuG7GnG/R
	 0igiehIHHdaGd1A0vx2rWJAR7najjikebW/ya1Wm60JFae3EuKhUbQCCKqP+sEx0I87AZ
	 jPyUuULA9R9qTV4C232ltD3Lap+fSoCrTC1a4TJuxkqLVaf0JTH/kPakOSy8h48Q70A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641527;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=UeLjFIfQ/Fub/E94KkiAYMUwzM6W8KKuUeT8uPryoIE=;
	b=RtbwLUlhHhJI0EVzkImnrjRlTLtxOJQfRiBvMRYwUaxS604swb1KcTDT1w3bgYtYi1kq
	 95lOKCY3hLnQ5KVpcj6anIjU2LUQeNiTPYdofJ4SM3+i5y1X9TtSWg4gDzTWKsqvakvMd
	 3U9D+bmC8BpEftPBvDOsQpnyOHTUCF4yNksB5HnYsaLpjLruHxb4jvRtCJ0QiEVSUaIap
	 DGHxjYaaQ8zgWVtXoEdg7SdTs4KvulyXkzZrHgG30ojesTLOBN6cmyGEZRaXYL4VZ7wvu
	 svhnOqhDjMy4fc3K9Y/NUnH4TePDTt4SD+bdGieLYlVAXRXFoE1t5PUUDJbciFsz0Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=InWoEqDk;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E16160A3830
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E16160A3830
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=InWoEqDk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeLjFIfQ/Fub/E94KkiAYMUwzM6W8KKuUeT8uPryoIE=;
	b=InWoEqDk3Rz9m3n0O93UYbhjEoIyQ03VN9aQWN0mgV2RKHQZo8UXXvP5PebnE/mVJrh7Dz
	1fmQod2OlJccpRW4DQtV9apJIyKu88TxnU8wotuJQu8Mlxmg2K7jQJyG4tX0HjgSQf/n6j
	4DRYPBSZ4iyAykmRWrLq5QWHPXz3xUE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-oD3rhcuyPsGQ9k0TsLzR-Q-1; Mon,
 02 Nov 2026 12:45:25 -0500
X-MC-Unique: oD3rhcuyPsGQ9k0TsLzR-Q-1
X-Mimecast-MFC-AGG-ID: oD3rhcuyPsGQ9k0TsLzR-Q_1793641523
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24A12195605A;
	Mon,  2 Nov 2026 17:45:23 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A64E47E1;
	Mon,  2 Nov 2026 17:45:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 31/45] KVM: x86: "Handle" failed decode when skipping instructions
Date: Mon,  2 Nov 2026 12:44:58 -0500
Message-ID: <20261102174512.8903-15-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

When calling into the emulator to skip an instruction, the caller has
already performed the side effects of the instruction and cannot
propagate -EFAULT.  Mark the VM dead.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c |  9 +++++++--
 arch/x86/kvm/vmx/vmx.c | 10 +++++++---
 arch/x86/kvm/x86.c     |  4 ++--
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 205d8783aa13..2601f8359137 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -304,6 +304,7 @@ static int __svm_skip_emulated_instruction(struct kvm_vcpu *vcpu,
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	unsigned long old_rflags;
+	int r;
 
 	/*
 	 * SEV-ES does not expose the next RIP. The RIP update is controlled by
@@ -321,7 +322,10 @@ static int __svm_skip_emulated_instruction(struct kvm_vcpu *vcpu,
 		if (unlikely(!commit_side_effects))
 			old_rflags = svm->vmcb->save.rflags;
 
-		if (!kvm_emulate_instruction(vcpu, emul_type))
+		r = kvm_emulate_instruction(vcpu, emul_type);
+		if (r < 0)
+			kvm_vm_dead(vcpu->kvm);
+		if (r <= 0)
 			return 0;
 
 		if (unlikely(!commit_side_effects))
@@ -2128,7 +2132,8 @@ static int icebp_interception(struct kvm_vcpu *vcpu)
 	 * instead of after it (and SVM doesn't provide enough information for
 	 * KVM to detect and manually advance the pre-#DB RIP).
 	 */
-	svm_skip_emulated_instruction(vcpu);
+	if (!svm_skip_emulated_instruction(vcpu))
+		return 0;
 	kvm_queue_exception(vcpu, DB_VECTOR);
 	return 1;
 }
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 80dfb3c6268b..27cb0d64fb5c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1809,6 +1809,7 @@ static int skip_emulated_instruction(struct kvm_vcpu *vcpu)
 	union vmx_exit_reason exit_reason = vt_get_exit_reason(vcpu);
 	unsigned long rip, orig_rip;
 	u32 instr_len;
+	int r;
 
 	/*
 	 * Using VMCS.VM_EXIT_INSTRUCTION_LEN on EPT misconfig depends on
@@ -1857,7 +1858,10 @@ static int skip_emulated_instruction(struct kvm_vcpu *vcpu)
 #endif
 		kvm_rip_write(vcpu, rip);
 	} else {
-		if (!kvm_emulate_instruction(vcpu, EMULTYPE_SKIP))
+		r = kvm_emulate_instruction(vcpu, EMULTYPE_SKIP);
+		if (r < 0)
+			kvm_vm_dead(vcpu->kvm);
+		if (r <= 0)
 			return 0;
 	}
 
@@ -5538,8 +5542,8 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 			 * higher priority.  Note, skipping ICEBP still clears
 			 * STI and MOVSS blocking.
 			 */
-			if (is_icebp(intr_info))
-				WARN_ON(!skip_emulated_instruction(vcpu));
+			if (is_icebp(intr_info) && !skip_emulated_instruction(vcpu))
+				return 0;
 
 			kvm_queue_exception_p(vcpu, DB_VECTOR, dr6);
 			return 1;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5f7f87ff4d17..5818101d1d8a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6235,8 +6235,8 @@ int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 	int r;
 
 	r = kvm_x86_call(skip_emulated_instruction)(vcpu);
-	if (unlikely(!r))
-		return 0;
+	if (unlikely(r <= 0))
+		return r;
 
 	kvm_pmu_instruction_retired(vcpu);
 
-- 
2.52.0


