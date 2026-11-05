Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793897153;
	b=B8FtJp/kgAxVnC0KwCMyRJxilViF+5NeSWy26ac+JH7YZHx5Biq7tWR/4cmqQgtIGEn6
	 KO7AsSDgLZmXRVM3ZPsUK30sMOgcQIOam/cRjQkiB/XBV4WECTaUAG8fcB5i45XpkgZnb
	 Y+egemQVgn9BLofs9rAYEcqo7Sl0WNo0AF/rn67QdYYIyfPol6h5gPM7fDFSTC+UB/30q
	 BSJOlLzsGSYT/CcDrEDjoLbTFf/PWcYVYnAqjaiaT5qtMcwyWl3+2xtR8Ax75uo0M39ge
	 cm1GFdsXhoTC/Asl4nLOql79w8tfPepZlQxBwlNvdl7FWn+k0YjCbmpqjt6wFcdc0ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897153;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=Tsvs5Btetkeg2XBEcp9aQr1tbtZtm0nAEQ211sW8+pI=;
	b=Ds9lxkMEX4gz5j+AZ3nDv4RT0ZuiC7fD+egeBDil5AmcUWWXJc46eF5rv7KO1MivLmVg
	 y5BBx62hMx7QNcxoy8B9ZxqmEmiL0dKePzyaeS0sjk5ePnfTQrpq7xDrhHpOMXj3R7EoF
	 1eSYOCf2dwbFqgtyTkr4+8rYImq9PsZ65toVbopx/fT5SP8ujTMk7+HEM92ObnbKbBZj4
	 ET8dbF51t+Ht8fo9ex67ve29Vfn0nka8O/ZRRbrZSGDqOBrJvQ0yBbGOsPBTKPObTicGn
	 JbYnBp6YiPJ1Y7kbeE3QYvDolxDcalWMcMpYwRl+0oaZ20tyPte/QtKupoFNuGUn3Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KSzTDlLA;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADAF606A335
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 16:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ADAF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KSzTDlLA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793897152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tsvs5Btetkeg2XBEcp9aQr1tbtZtm0nAEQ211sW8+pI=;
	b=KSzTDlLAlGLNzM6qDh4GSwQtxEJL7IMOe6kkaAv55nGbZx6SAMGS3QMWcCTAngf8LzZbp8
	1iX3DNbqD9GHvjHET3xS9P7TGJc6E/QFHEbedAM9QbDs8L9WZ8S7NsCVPBzC4tC4V2xnm6
	SSpwrIufIIHWNzG/1Lxi//mDkPV5EUs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-Aj1LUtqYPY2aIJ_-yXLjHA-1; Thu,
 05 Nov 2026 11:45:46 -0500
X-MC-Unique: Aj1LUtqYPY2aIJ_-yXLjHA-1
X-Mimecast-MFC-AGG-ID: Aj1LUtqYPY2aIJ_-yXLjHA_1793897145
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5008B18001F0;
	Thu,  5 Nov 2026 16:45:45 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 649A8195608A;
	Thu,  5 Nov 2026 16:45:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Hillf Danton <hdanton@sina.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Harry Yoo <harry@kernel.org>
Subject: [PATCH 4/5] KVM: x86: allow handle_exit_irqoff to return EXIT_FASTPATH_*
Date: Thu,  5 Nov 2026 17:45:30 +0100
Message-ID: <20261105164531.313849-5-pbonzini@redhat.com>
In-Reply-To: <20261105164531.313849-1-pbonzini@redhat.com>
References: <20261105164531.313849-1-pbonzini@redhat.com>
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

Let handle_exit_irqoff() pass what it did to vcpu_enter_guest() and/or
handle_exit().  This will be needed to trigger async page fault handling,
and to suppress reflection of APF #PF exceptions, once vcpu->arch
will no longer have a host_apf_flags field.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/svm/svm.c          | 4 +++-
 arch/x86/kvm/vmx/main.c         | 6 ++++--
 arch/x86/kvm/x86.c              | 3 ++-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3f096a0f3387..93170c70a17c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1681,7 +1681,7 @@ struct kvm_x86_ops {
 			       struct x86_instruction_info *info,
 			       enum x86_intercept_stage stage,
 			       struct x86_exception *exception);
-	void (*handle_exit_irqoff)(struct kvm_vcpu *vcpu);
+	fastpath_t (*handle_exit_irqoff)(struct kvm_vcpu *vcpu);
 
 	void (*update_cpu_dirty_logging)(struct kvm_vcpu *vcpu, bool enable);
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e0ff458761cf..b720c1ff7134 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5091,7 +5091,7 @@ static int svm_check_intercept(struct kvm_vcpu *vcpu,
 	return ret;
 }
 
-static void svm_handle_exit_irqoff(struct kvm_vcpu *vcpu)
+static fastpath_t svm_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 {
 	switch (to_svm(vcpu)->vmcb->control.exit_code) {
 	case SVM_EXIT_EXCP_BASE + MC_VECTOR:
@@ -5103,6 +5103,8 @@ static void svm_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 	default:
 		break;
 	}
+
+	return EXIT_FASTPATH_NONE;
 }
 
 static void svm_setup_mce(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index b46f8f60ce70..b742e2370dd6 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -941,10 +941,10 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu,
 	vcpu->arch.at_instruction_boundary = true;
 }
 
-static void vt_handle_exit_irqoff(struct kvm_vcpu *vcpu)
+static fastpath_t vt_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 {
 	if (to_vt(vcpu)->emulation_required)
-		return;
+		return EXIT_FASTPATH_NONE;
 
 	switch (vt_get_exit_reason(vcpu).basic) {
 	case EXIT_REASON_EXTERNAL_INTERRUPT:
@@ -959,6 +959,8 @@ static void vt_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 	default:
 		break;
 	}
+
+	return EXIT_FASTPATH_NONE;
 }
 
 static int vt_handle_exit(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba9..af8cdfd81180 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8504,7 +8504,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.xfd_no_write_intercept)
 		fpu_sync_guest_vmexit_xfd_state();
 
-	kvm_x86_call(handle_exit_irqoff)(vcpu);
+	if (exit_fastpath == EXIT_FASTPATH_NONE)
+		exit_fastpath = kvm_x86_call(handle_exit_irqoff)(vcpu);
 
 	if (vcpu->arch.guest_fpu.xfd_err)
 		wrmsrq(MSR_IA32_XFD_ERR, 0);
-- 
2.56.0


