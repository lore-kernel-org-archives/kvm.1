Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8651E1ACEDE
	for <kvm@vger.kernel.org>; Sun,  3 May 2026 20:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838952; cv=none; b=uVADFupOGqj8PY5n8XkF3zDnVloFjJcnRKfXahKmzmZ0fBzZtIK0SSgpGv8TPG1RYuK9h3r6P+X95V7QipPig2UAbIvzZIVeguBmE8fTha6EFSl1u6eoTjYOlRB8KDIP/hQHZW/wNBRjMvYZq1n9m9LVDi/0Cl0iiEJCrQuP5+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838952; c=relaxed/simple;
	bh=oOi3H+m0S3nG3y+tRC2W4XyeP4p8ekL5EgzM1Dix+vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ti5zKwpFLAnqiqgPA/2KdVmnZqXprWuGqt9xjW5c1Rvrumt1ZcelB5OezOrqeMdWc/0QiXOB4Nh5pLxOttBJTJGLoIX0yurtY7IV2EH930mMdwq4SoI68KUCCyMuijVHPyN22kALf4QgP2tbUfLo5bvRtw29Xv/n4z1RK6f8haw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1qXc8xX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jf+5DocZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1qXc8xX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jf+5DocZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777838949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2r5G2c1iaCHwo5jhUQua5IUe/K7Qy+faxKLRNRyePd4=;
	b=d1qXc8xXVPgpQwAHJQdt6Fc70UYdXzAHGysMKJs8Lp7TrUnvSO1y8IwXEcWa4WrTp68eTC
	0ye2BE3TuIXAL3rBodHnjWdOC08yur3lwJLUotRBrop40zWk6Wyzvc4ubVBW0OtzkXFfpB
	uV+TllAow5wNdRw/GMOwsa70kazUfeo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-AJ621Hc5N6moiGDFk1xDiQ-1; Sun, 03 May 2026 16:09:08 -0400
X-MC-Unique: AJ621Hc5N6moiGDFk1xDiQ-1
X-Mimecast-MFC-AGG-ID: AJ621Hc5N6moiGDFk1xDiQ_1777838947
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488c2a4e257so21644425e9.3
        for <kvm@vger.kernel.org>; Sun, 03 May 2026 13:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777838947; x=1778443747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2r5G2c1iaCHwo5jhUQua5IUe/K7Qy+faxKLRNRyePd4=;
        b=Jf+5DocZBKir2W67Mx4kvwn4uUheFsan1OOJ0Z4c6CKUYYRLNMC3O7vXgkamyXoQht
         Mj+36oi4gkaUpe1vy9yaPKCmZOBZFiEpfimeBoX8Jgk8tk0+THNBOSb5nO14ezL/xZ9f
         w5VQjHtIJuVM6Aky+B7SrVZd+TxRvkvEvqxd8Taf8cbL0aQF/k5lCqjhvEtGyP1+zdb1
         dUGaQgVS59g3gEIHFhiOBWE66QPOLa9qGwF8EhrwwpfKrYsmfLcoAvr1/PlUit4pERK7
         FW1lDKdVb6DV7ACPqglRo8LjC7aM5YqYe5y4MK+V5l0hck3iA+HcRoYRheUPyp+GIOuL
         lZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777838947; x=1778443747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2r5G2c1iaCHwo5jhUQua5IUe/K7Qy+faxKLRNRyePd4=;
        b=hRKzmq4x8XWH0vOHGswQmhJ4hPg1am/tZIhSi3SP3AKQL4+utB4Ttnpb3Q+9DHOcAn
         uPetx2yGytbtUy3p1UtYuZ80nt3vzFr7FBxkyUw3kx6YfBy+rIrDx1/Wqyf2nO21G7fr
         ulSeOMYHCrm1Qga21hI14biGij0IF2SsnOY7ziIB0ipSKVmp3+QQCNaB5ScRagTvq00B
         dZECsM4hQm3d31kpN/wE5lHyZi4dYsDv4iOy3yKwwC2nz1PdFJPZhK8nvOCJVU/Y4aoA
         QV/kekAEgJJWUGoO4w0oveMIpcJ4AxnkQwtPinb3oM3lDZHn5wDA8rjzyYZuxUZx/Xba
         1aVw==
X-Forwarded-Encrypted: i=1; AFNElJ/RSxWyHmBGWh8DsxCTWX1Et1ohgQvO6z1WqoSpxP9I2LrFFfMBEjMsJr0Xq5LDgTdDzmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8XSduZ4rZrInBy+TyUaSIa2ebyZaiFT7HQlcLZaEX2ZIi9tdf
	FbcM0u7Mc1otjTMDfmNSV81U8WKJqDemM2dqC7TXPS6kCSfMAq2y6OlBj51tcemfkVuQ49Cr2Oi
	mnf02wTvLQ8pGqGTK58Zqc6xAe1K5QUXQKRW2kzGz1pBsZwv2MMRX+g==
X-Gm-Gg: AeBDieujzoi2mT9avZiPDhwV+vtKU0a7Wdpk4+aaoGr4tNbg5+duiCEj9PRok9fHSaS
	TgvczPUx07rzWUGpbXfRoSJw4ik2eRM/mYlBnavRP7AKXj3QAgcpLUbZQEcjM6X0dwMu0HMB1Xf
	1kt98vO7/LHdnngKoYzP2sP09XPZDG04e3PQHnAlZuHyluRCNkp9G0tM2Qc9NQouIXDEMr4rbrh
	6N2eStkInDHHOEorwWJxlhtTscLHqOenGbo35T2AefJ6Xny1uLDn3Si+olFTfYKvvb4xMAj/8Pf
	siacUPfKyKr6dK8pSW5B44zZOq/ImBxlQSZS2R72qxexNF7ZDIfrGBBR9L7Sr+8FBG9L5RSxwza
	WafDPsGzckKhAoy+GHc5Wyc6LrjQtjZFfKrj89/amrQzCf37uCSei7VgSZxE2Txpdf4+kMuGn98
	69hrqM6Wha9ghUEHzKZD40kVIptJG0ssK9TMI=
X-Received: by 2002:a05:600c:348a:b0:488:c744:49b with SMTP id 5b1f17b1804b1-48a98637f79mr114920665e9.7.1777838947133;
        Sun, 03 May 2026 13:09:07 -0700 (PDT)
X-Received: by 2002:a05:600c:348a:b0:488:c744:49b with SMTP id 5b1f17b1804b1-48a98637f79mr114920505e9.7.1777838946767;
        Sun, 03 May 2026 13:09:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fef2a67sm86407655e9.5.2026.05.03.13.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 13:09:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: stable@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH] KVM: x86: check for nEPT/nNPT in slow flush hypercalls
Date: Sun,  3 May 2026 22:09:05 +0200
Message-ID: <20260503200905.106077-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checking is_guest_mode(vcpu) is incorrect, because translate_nested_gpa()
is only valid if an L2 guest is running *with nested EPT/NPT enabled*.
Instead use the same condition as translate_nested_gpa() itself.

Cc: stable@vger.kernel.org
Reviewed-by: Sean Christopherson <seanjc@google.com>
Fixed: 3e300570b42a ("KVM: x86: check for nEPT/nNPT in slow flush hypercalls", 2026-05-03)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 9b140bbdc1d8..4438ecac9a89 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2040,7 +2040,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 * flush).  Translate the address here so the memory can be uniformly
 	 * read with kvm_read_guest().
 	 */
-	if (!hc->fast && is_guest_mode(vcpu)) {
+	if (!hc->fast && mmu_is_nested(vcpu)) {
 		hc->ingpa = translate_nested_gpa(vcpu, hc->ingpa, 0, NULL);
 		if (unlikely(hc->ingpa == INVALID_GPA))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
-- 
2.54.0

