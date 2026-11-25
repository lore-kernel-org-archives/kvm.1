Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795584109;
	b=d5U784viNKuikLbGj9k8N6xZX2+cziiXpVn+Z4pJH/yN+i2smi1OECFAUAFJvvhCDKo/
	 qK7pp0ImxzVIwgwclQWHLgHyoKy8hsbSp4U39pY56nO7XNcb7hOdzRBxEK7rz/EUMwzjp
	 hiOexDgtdGgr01XBBpFXvAumJxZ4q48j3vRgJML3Lb81BfTIWtdKU9Kvin/PGY7JVmEUB
	 pl7dFjv4bX6Mlax8Zj+WhPqrPAydHGIKKc3tnnJ0YNV7BtcKeWWzodeyFnY60/6mnDN1q
	 n6H6GZC2Se08e9sxYCKgiYeiKnLF0tf+NhE/nkZEwAx80RQDn+Q4Iem5GHS7v3Kb20Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795584109;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=6RRPwyRDY3ZFd/1JP6q/vLcVe+jZU+U/2khQJLP8SlI=;
	b=vYTwnqL6xVxWY/nfO59f3gU+bMLMeAbmmp3KAMgIPW3SIgXmcf8M23Jf6Bwh8uh0ooiU
	 0gXQBW+3O/PKqxkywpAvCkkMHTd3xJBmZyUm6Y2AEd8ar7NieaJJBKl6DU0yag1iWFS5o
	 VJ9a0fYN9OmjnafARvabEh7DtIZkcb/5P0uc+gPFMoeeGXbMovw7BLoG6Qr2UuSp8SxFd
	 Lt54pyIRPlWDCDNv+vc8K477XWBqOCDh2zXVW8b3z5JLP9PUM/X56GafFBq8qPp2q9p+u
	 VVyvzR5m+AzO85eOP7IGDjd48LHZg29RKfhzEs+i8KXjMbSDe3YORcZHk7xO4dG2pFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UD7ftHQ4;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63564606A33C
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 05:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63564606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UD7ftHQ4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795584108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6RRPwyRDY3ZFd/1JP6q/vLcVe+jZU+U/2khQJLP8SlI=;
	b=UD7ftHQ4guwV16cU2f1nJ/mZ7Fp66Jm0Qew/iM0dBrBWaQEVbtc5GuIY/MchasEqPhBt/1
	i7Nc/zeUJt/7kW/F9cCXgMXV6vJDowPEN5w00pqfSKp5t5GzP5hpMJNaoRlkz4sjSWQ30+
	YAXAA6fWhU6PCL2Eg5spEXq+MmaYW2w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-xNV5kFW7NcuIU7zRyWCaiQ-1; Wed,
 25 Nov 2026 05:21:46 +0000
X-MC-Unique: xNV5kFW7NcuIU7zRyWCaiQ-1
X-Mimecast-MFC-AGG-ID: xNV5kFW7NcuIU7zRyWCaiQ_1795584105
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 429CE19560B4;
	Wed, 25 Nov 2026 05:21:45 +0000 (UTC)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 499FE1956088;
	Wed, 25 Nov 2026 05:21:44 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	x86@kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v4 3/5] KVM: x86: convert nested_guest_state into an atomic variable
Date: Wed, 25 Nov 2026 00:21:37 -0500
Message-ID: <20261125052139.362046-4-mlevitsk@redhat.com>
In-Reply-To: <20261125052139.362046-1-mlevitsk@redhat.com>
References: <20261125052139.362046-1-mlevitsk@redhat.com>
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

Convert nested_guest_state into an atomic variable, to prepare
to fix nested APICv delivery races.

No functional change expected.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/regs.h             | 7 ++++---
 arch/x86/kvm/x86.c              | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 226091feb44a..78fcc7fcece7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -759,7 +759,7 @@ struct kvm_vcpu_arch {
 
 #define KVM_NESTED_IN_GUEST	BIT(8)
 	/* Non zero when the guest is executing a nested guest */
-	u16 nested_guest_state;
+	atomic_t nested_guest_state;
 
 #ifdef CONFIG_KVM_SMM
 #define SMM_MASK		BIT(0)
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index ec9d4a8fbe15..b36254db1b8f 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -457,13 +457,13 @@ static inline unsigned long kvm_get_effective_dr7(struct kvm_vcpu *vcpu)
 
 static inline void enter_guest_mode(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.nested_guest_state = KVM_NESTED_IN_GUEST;
+	atomic_set(&vcpu->arch.nested_guest_state, KVM_NESTED_IN_GUEST);
 	vcpu->stat.guest_mode = 1;
 }
 
 static inline void leave_guest_mode(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.nested_guest_state = 0;
+	atomic_set(&vcpu->arch.nested_guest_state, 0);
 
 	if (vcpu->arch.load_eoi_exitmap_pending) {
 		vcpu->arch.load_eoi_exitmap_pending = false;
@@ -475,7 +475,8 @@ static inline void leave_guest_mode(struct kvm_vcpu *vcpu)
 
 static inline bool is_guest_mode(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.nested_guest_state & KVM_NESTED_IN_GUEST;
+	return atomic_read(&vcpu->arch.nested_guest_state) &
+			   KVM_NESTED_IN_GUEST;
 }
 
 static inline unsigned long kvm_get_segment_base(struct kvm_vcpu *vcpu, int seg)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0d8854bcbc4f..74c372906ac7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9557,7 +9557,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 #ifdef CONFIG_KVM_SMM
 	vcpu->arch.smm_mode = 0;
 #endif
-	vcpu->arch.nested_guest_state = 0;
+	atomic_set(&vcpu->arch.nested_guest_state, 0);
 
 	vcpu->arch.smi_pending = 0;
 	vcpu->arch.smi_count = 0;
-- 
2.56.1

