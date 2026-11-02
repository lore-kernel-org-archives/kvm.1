Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641528;
	b=z5WLJ+Z/mY39LyVgo0MHXyDTEmZcK11vePMXDEv+1uk9I6WQNBKylYqBPBQnFtpOrBYy
	 WSmkVUOsdL3IXPFk6Pk512dOyCRZIvLhe80wTEnktWh5QDVgfzfkRJCb8tPA5EsJm1LvG
	 stD+c5EkXd7Gx2sLuwzn+KxRRey1rk3N0PDGMwDr3Zt3AEBApGrRYUKr4mqgH4RR9ovw5
	 x4+/I7rttywbkpMWzqW2/IS1auS2fAANSjMa1ykBW51jdzs8yhxgbPd0nKQAn3Kv40SFJ
	 GQV5K3f7DfAjp/lCP3m3xNIlRGo2Tj14VVc5T0ZC51Yt/IWcoi4q+bv9bqFmuQWWGJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641528;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=eNiSWpnU8Lwgrp8cAZMrGw9BDm4Xqnl5gdC5H/nGJ6Y=;
	b=NHL4vph5039Jd4kJGURcY2qbLXBKiMYL8Yz+yJE+DpwVytvX3UoHimVM5fZ0+D6kA1wu
	 3aApXoHe6W2nOcW+so/q33ZKS2/pI+Azr5uReb2if2NKdPaCjZQDstvI19GZKCfgWxaJO
	 Bp5L+OTyMkYQ08P2aOLG6QUZLjORs8JteMCZhxFzKdw63ufddFPCSxvAMsD8iUy4BgXzq
	 xiPnYi/CiUEcwLY9gWnFMHOGQSv2l51pHB/BlCiL6jSXUqMXNQpU/FNFWZA18M/ygtkgS
	 TuuH0GDIPs1+CsCr3zJPC0SqfX1eJa2RRX95EqN7UuWqxLPy0ezrTeCadXe1wHWHHzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IMCA3G61;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6885F60A5BD4
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6885F60A5BD4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IMCA3G61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eNiSWpnU8Lwgrp8cAZMrGw9BDm4Xqnl5gdC5H/nGJ6Y=;
	b=IMCA3G611u73hU62WQp602S1/vst5u6hqw5v5XVd7/r0AcIQUj827bjscy0XFs+t9XErtt
	7FV4HI88k1beQC2e70OsKjaop6IsFWOAxWhDSpSq2epd7GLIZu2JgkeyF+jF8lHpMtzL5T
	ObazW21hyFOz00r9Daa0bSrK7AQIcFw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-Qtmpe5q4NPqN0vnZgNdZSg-1; Mon,
 02 Nov 2026 12:45:26 -0500
X-MC-Unique: Qtmpe5q4NPqN0vnZgNdZSg-1
X-Mimecast-MFC-AGG-ID: Qtmpe5q4NPqN0vnZgNdZSg_1793641524
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 637F91955F30;
	Mon,  2 Nov 2026 17:45:24 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E4520433;
	Mon,  2 Nov 2026 17:45:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 33/45] KVM: x86: Allow page fault fixup to return errors
Date: Mon,  2 Nov 2026 12:45:00 -0500
Message-ID: <20261102174512.8903-17-pbonzini@redhat.com>
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

kvm_fixup_and_inject_pf_error() reflects intercepted hardware page
faults into the guest, walking the guest page tables when necessary
to obtain an error code consistent with the guest's paging rules.
For example, a GPA that exceeds guest.MAXPHYADDR but fits within
host.MAXPHYADDR must cause a reserved-bit fault, even though hardware
does not report one.

Allow the function's callers to propagate memory attribute failures
from the page table walk; subsequent changes will return from
kvm_fixup_and_inject_pf_error() any error from the page-table walk.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 15 +++++++++++----
 arch/x86/kvm/x86.c     |  3 ++-
 arch/x86/kvm/x86.h     |  2 +-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 27cb0d64fb5c..c4511f83d59b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5418,10 +5418,14 @@ static int vmx_handle_page_fault(struct kvm_vcpu *vcpu, u32 error_code)
 		WARN_ON_ONCE(!IS_ENABLED(CONFIG_X86_SGX_KVM) ||
 			     !cpu_feature_enabled(X86_FEATURE_SGX2));
 
-		if (guest_cpu_cap_has(vcpu, X86_FEATURE_SGX2))
-			kvm_fixup_and_inject_pf_error(vcpu, cr2, error_code);
-		else
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_SGX2)) {
+			int r = kvm_fixup_and_inject_pf_error(vcpu, cr2, error_code);
+
+			if (r)
+				return r;
+		} else {
 			kvm_inject_gp(vcpu, 0);
+		}
 		return 1;
 	}
 
@@ -5431,7 +5435,10 @@ static int vmx_handle_page_fault(struct kvm_vcpu *vcpu, u32 error_code)
 	 * to the GPA being legal with respect to host.MAXPHYADDR).
 	 */
 	if (enable_ept) {
-		kvm_fixup_and_inject_pf_error(vcpu, cr2, error_code);
+		int r = kvm_fixup_and_inject_pf_error(vcpu, cr2, error_code);
+
+		if (r)
+			return r;
 		return 1;
 	}
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5818101d1d8a..bb36ca1106e5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10811,7 +10811,7 @@ void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range
 #endif
 #endif
 
-void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_code)
+int kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_code)
 {
 	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 	struct x86_exception fault;
@@ -10833,6 +10833,7 @@ void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_c
 		fault.async_page_fault = false;
 	}
 	gva_walk->inject_page_fault(vcpu, &fault, true);
+	return 0;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_fixup_and_inject_pf_error);
 
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index cfe96962a4e4..4239765629b0 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -368,7 +368,7 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu,
 				   struct kvm_queued_exception *ex);
 void kvm_handle_exception_payload_quirk(struct kvm_vcpu *vcpu);
 
-void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_code);
+int kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_code);
 int x86_decode_emulated_instruction(struct kvm_vcpu *vcpu, int emulation_type,
 				    void *insn, int insn_len);
 int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
-- 
2.52.0


