Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADBB44C65C;
	Tue, 28 Jul 2026 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785260564; cv=none; b=ju7NdKFLiAW4/IrwEdD0lRiSpArgsDtJttnRUG3PTm/xuRCnPtRaA3dAvTWICW/dxF2xM3ODJ4FYDspiRPnZzto0BQArqLBTKgZOFSHYUBRDTKNxVuR+pPCMWPVRitQYKolUNcDLIiCrlUh/gE7fHgHBsmaWqBsXJgZX0M19nac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785260564; c=relaxed/simple;
	bh=cvHAyC6XlnIsn1pfQ/KPnz+5bHZtTp8HKGW2k4W2BOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkWQ+kdoCrReYza8r8wIjYhxrb6AAZTyF4QGVmklc6EGSWZimVWiTBBI9BhTo/OfyWf0hm8jR7+AuEeDwNx7cHitEYx3gDKL7e/13ZXn2CMpM3djlngFIQxLytPmMkb8dMe7ZW7eUXmxVUlayGeqrZEJmaAkljjL9t+fEANU37c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrsFxxe9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrsFxxe9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BE21F00A3F;
	Tue, 28 Jul 2026 17:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260562;
	bh=Tntao2x5vqEUTftN8+6wk9k8GUA2aPWwi+H4Yv3eHMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LrsFxxe928Xfu8zQseXpznmCylifpfeCAj0Xdtz8+TTFP65mkeTZ0nBASqrdiMD+D
	 nHlI4WEFQa1wx0xC75r9mLQDvCYnvf6s38njWeNE4Nq2jINrDJtcpZuWf9jbMBB6Bj
	 6Xgq5MVRJfLVUJEga0YZ5JpHZfNF/R9mxYOM6pGbOICMGXO79oWgDinq/RGVbV4OiV
	 hiK/bO2VyqUBvr3vH4sxCNbEeJIumWxfRQITFpVzIsmor1k+MJ4SCAyAxiClg9GWHu
	 /MJh5Uh9M3NaR90x9UjqJuGGG/WQsGHSviTWVXQgNiYcCcn5xfpub05fzGjfl7klXL
	 sC62yBKxVxdBA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v5 09/13] KVM: selftests: Do not intercept #PF by default in nVMX tests
Date: Tue, 28 Jul 2026 17:42:28 +0000
Message-ID: <20260728174232.2423257-10-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
In-Reply-To: <20260728174232.2423257-1-yosry@kernel.org>
References: <20260728174232.2423257-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_vmcs_control_fields() sets PFEC_MASK and PFEC_MATCH so that they
never match, which reverses the meaning of the PF_VECTOR bit in
EXCEPTION_BITMAP (which is zeroed), effectively enabling #PF
interception by default.

The relevant part of the SDM describes this:
  When a page fault occurs, a processor consults (1) bit 14
  of the exception bitmap; (2) the error code produced with the page
  fault [PFEC]; (3) the page-fault error-code mask field [PFEC_MASK];
  and (4) the page-fault error-code match field [PFEC_MATCH]. It checks
  if PFEC & PFEC_MASK = PFEC_MATCH. If there is equality, the
  specification of bit 14 in the exception bitmap is followed (for
  example, a VM exit occurs if that bit is set). If there is inequality,
  the meaning of that bit is reversed (for example, a VM exit occurs if
  that bit is clear).

Clear PFEC_MATCH such that there is equality, and the #PF bit in the
exception bitmap is followed.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/lib/x86/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
index cd09c9de4485a..089e1a8af53fc 100644
--- a/tools/testing/selftests/kvm/lib/x86/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -232,7 +232,7 @@ static inline void init_vmcs_control_fields(struct vmx_pages *vmx)
 
 	vmwrite(EXCEPTION_BITMAP, 0);
 	vmwrite(PAGE_FAULT_ERROR_CODE_MASK, 0);
-	vmwrite(PAGE_FAULT_ERROR_CODE_MATCH, -1); /* Never match */
+	vmwrite(PAGE_FAULT_ERROR_CODE_MATCH, 0);
 	vmwrite(CR3_TARGET_COUNT, 0);
 	vmwrite(VM_EXIT_CONTROLS, rdmsr(MSR_IA32_VMX_EXIT_CTLS) |
 		VM_EXIT_HOST_ADDR_SPACE_SIZE);	  /* 64-bit host */
-- 
2.55.0.487.gaf234c4eb3-goog

