Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641304;
	b=H0i5gWDg9jAgL/qIAMSLwgCgIA9QPjq5lSQSzt1Fl8XqMeBt6WaZpi2tYb3M2u3xw/HQ
	 rk8+ACX5JfHZPLhtDGR2vNXJob6TUy0LyPqIdvHYvUmLZ4DlULr5pEXs1TULx+zA/Zjo0
	 Y7rli433W+WQxcr47FBJul6eiza7DmYme95RkMMjvghdBgcFfFfT3SOrck0BAj+KabHna
	 jPVB2qjaybfowAsLHsFIvHQd0L/eUNaBStyMjpQMy3LIA+Jxhcj2qCPLmsqzdZAgnxwVh
	 aFQKLzlwqsaYmm7juEoZiesYBu4z3mWhxX9YLAcLgtunU40a1oEUzN+WvE7GdLYewfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641304;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=EqxyoET/vrXjZknrR8NjGDfGHRmxTCNSAyAL413nJJg=;
	b=2L8R4hNWFwce9BPgRgynh0wMY/zuxE28gJrqE4l7mfx6ikgi7TSj8oacHR0d5oik912G
	 V0klcYYMZOt//cKnbM3FvRkg3nNgXwnq1sKPtigsNbhhMKQ811sYQbnLCxTWbp/CyyKoN
	 usC5kDOJQsh4InGeYkYrHXdYjdBbWZd2NOdzJMkhq15v+Tu+lSYb6ge1rSQ/lR3iCzstO
	 Sd5vqNbZTzeGMPiZbByJkgT3dA7KzY2FMsEpn5GuS9JRLw0tgCpdAN8GZa9CHyTkcd6+z
	 sbMktAlJSMLLDbYwJSJk2KLSdCPqyn+LdcgMr4qW4+VsQv6+jKudSQ/qbeF5lVQRKOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b1zpXm7V;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11A6072C4C
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F11A6072C4C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b1zpXm7V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EqxyoET/vrXjZknrR8NjGDfGHRmxTCNSAyAL413nJJg=;
	b=b1zpXm7VufAP42AkcQjHcn/SdzoEfyKjQVyOvEAnijqhkEK4X739dkUTwJJAEnCH2CzigD
	VAUF6usK871VskI/s2qZwg8aOSJatqEJ+9b9XpRvAZapLbRBZOLYBkRtcygTRX3UolwkZu
	QIugO4F1DXr9l4wEEjKxBKFSyBnFZuc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-CcUz92dqNeWJWhy9uKjt6A-1; Mon,
 02 Nov 2026 12:41:41 -0500
X-MC-Unique: CcUz92dqNeWJWhy9uKjt6A-1
X-Mimecast-MFC-AGG-ID: CcUz92dqNeWJWhy9uKjt6A_1793641300
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 874151802661;
	Mon,  2 Nov 2026 17:41:40 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0EA681800586;
	Mon,  2 Nov 2026 17:41:39 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 15/45] KVM: VMX: return error from kvm_set_cr*
Date: Mon,  2 Nov 2026 12:40:59 -0500
Message-ID: <20261102174130.8779-16-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This is already done by svm.c, copy it over to vmx.c so
that kvm_complete_insn_gp() can return -EFAULT on PDPTR
loads.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 12 ++++++++----
 arch/x86/kvm/x86.c     |  2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b341af4c6057..fe43718b751b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5630,6 +5630,7 @@ static int handle_set_cr0(struct kvm_vcpu *vcpu, unsigned long val)
 	if (is_guest_mode(vcpu)) {
 		struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 		unsigned long orig_val = val;
+		int r;
 
 		/*
 		 * We get here when L2 changed cr0 in a way that did not change
@@ -5642,8 +5643,9 @@ static int handle_set_cr0(struct kvm_vcpu *vcpu, unsigned long val)
 		val = (val & ~vmcs12->cr0_guest_host_mask) |
 			(vmcs12->guest_cr0 & vmcs12->cr0_guest_host_mask);
 
-		if (kvm_set_cr0(vcpu, val))
-			return 1;
+		r = kvm_set_cr0(vcpu, val);
+		if (r)
+			return r;
 		vmcs_writel(CR0_READ_SHADOW, orig_val);
 		return 0;
 	} else {
@@ -5656,12 +5658,14 @@ static int handle_set_cr4(struct kvm_vcpu *vcpu, unsigned long val)
 	if (is_guest_mode(vcpu)) {
 		struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 		unsigned long orig_val = val;
+		int r;
 
 		/* analogously to handle_set_cr0 */
 		val = (val & ~vmcs12->cr4_guest_host_mask) |
 			(vmcs12->guest_cr4 & vmcs12->cr4_guest_host_mask);
-		if (kvm_set_cr4(vcpu, val))
-			return 1;
+		r = kvm_set_cr4(vcpu, val);
+		if (r)
+			return r;
 		vmcs_writel(CR4_READ_SHADOW, orig_val);
 		return 0;
 	} else
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1fcef4a8ac22..c7970bcfdc24 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -580,6 +580,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_requeue_exception);
 
 int kvm_complete_insn_gp(struct kvm_vcpu *vcpu, int err)
 {
+	if (err < 0)
+		return err;
 	if (err)
 		kvm_inject_gp(vcpu, 0);
 	else
-- 
2.52.0


