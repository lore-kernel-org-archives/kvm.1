Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C78248986B
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786724562; cv=none; b=VrKP4GQe/D8Y0PNDTYwcF2p2pASc6yHE7eRiL9IFq8wMe/quF9C6Luwi5SKzv1+B8FMbLieI3LYTSkGZUuXmqW8AbEL/Djlo6kD7NuNtd1E58yHh0k2/kuwhhfDOt8X8W2nf57pnxZLCbflNTtSHm6zHbLkQSrrVFIMJt+2uZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786724562; c=relaxed/simple;
	bh=vjsvimg+UZg7jmSYzW9/QZeVGKNQK1R8FqFtL5IDmBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTzdQvtQo+3m7FWE34XszvR2WYeaSz4XeNmwd9HnuD8L1N/ZCd2oqnPmsbfxBo+dltHfPYhtDqKzg+DW4ey17Yw2PTGum3FyjdYSSUfw+ecpxkP9dKdWytexTsrt4b7Nktk/34uRIyX+P9rt3LNbv2V/BQ52bs9Dx+fPwahcXmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zhw0pRZU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zhw0pRZU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786724559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PpeDr30TrQyKrAUaIAR21FEKOI9dU4xsJ2hFkXOUhfE=;
	b=Zhw0pRZUQ5+IF3Yl6yNenxHJqTZ7d3e4tHMICq8CCishg8iu2m0nUBxYIuv5EmrCgrkV0I
	8Nm71vmaosCIW8xPHt437JYrtiblv2e8nRbu4KUDJ3e7na2koR2fov6L7gy1jPIK61YZA/
	UYBbscdUO8Wt1YLCanFpAbTUaKDldYQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-D4gEATPPP5qwcZodsnnUbA-1; Fri,
 14 Aug 2026 12:22:35 -0400
X-MC-Unique: D4gEATPPP5qwcZodsnnUbA-1
X-Mimecast-MFC-AGG-ID: D4gEATPPP5qwcZodsnnUbA_1786724553
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0B3819560AD;
	Fri, 14 Aug 2026 16:22:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.234])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F0BB7422;
	Fri, 14 Aug 2026 16:22:31 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: f734222792@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] KVM: selftests: Check VMPTRLD with active eVMCS
Date: Fri, 14 Aug 2026 18:22:21 +0200
Message-ID: <20260814162221.2144473-5-vkuznets@redhat.com>
In-Reply-To: <20260814162221.2144473-1-vkuznets@redhat.com>
References: <20260814162221.2144473-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Check that VMPTRLD when eVMCS is active results in #UD. This matches
genuine Hyper-V's behavior.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/include/x86/vmx.h  |  3 ---
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c | 13 +++++++++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 047d02aa9688..e2178a6683ca 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -325,9 +325,6 @@ static inline int vmptrld(u64 vmcs_pa)
 {
 	u8 ret;
 
-	if (enable_evmcs)
-		return -1;
-
 	__asm__ __volatile__ ("vmptrld %[pa]; setna %[ret]"
 		: [ret]"=rm"(ret)
 		: [pa]"m"(vmcs_pa)
diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
index 88262ddf7fcb..6a6d940a7891 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
@@ -18,12 +18,16 @@
 #include "hyperv.h"
 #include "vmx.h"
 
+#define VMLAUNCH_INSN_SIZE 3
+#define VMPTRLD_INSN_SIZE 5
+
 static int ud_count;
+static int ud_insn_skip_size;
 
 static void guest_ud_handler(struct ex_regs *regs)
 {
 	ud_count++;
-	regs->rip += 3; /* VMLAUNCH */
+	regs->rip += ud_insn_skip_size;
 }
 
 static void guest_nmi_handler(struct ex_regs *regs)
@@ -182,10 +186,15 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
 	GUEST_SYNC(11);
 
+	ud_insn_skip_size = VMPTRLD_INSN_SIZE;
+	vmptrld(hv_pages->enlightened_vmcs_gpa);
+	GUEST_ASSERT(ud_count == 1);
+
 	/* Try enlightened vmptrld with an incorrect GPA */
+	ud_insn_skip_size = VMLAUNCH_INSN_SIZE;
 	evmcs_vmptrld(0xdeadbeef, hv_pages->enlightened_vmcs);
 	GUEST_ASSERT(vmlaunch());
-	GUEST_ASSERT(ud_count == 1);
+	GUEST_ASSERT(ud_count == 2);
 	GUEST_DONE();
 }
 
-- 
2.55.0

