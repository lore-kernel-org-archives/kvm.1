Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2B5283FDB
	for <kvm@vger.kernel.org>; Wed, 25 Feb 2026 01:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982478; cv=none; b=JPIQXAJnVRpzFdOSYNyVOpv4J3rm4oofYhwaWs+VpmnAh0y1R0YnaVuC7CoCcOipGDLnIdWuJ0h3ExcdZ81bQtX3KbkyvOFmdu4BE8i4M9r8UD7HNmw8w9n5eFk106wY1BHkEmCY0cyrgpuLUYLupPHweIJF9hx+a5iGlvwcTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982478; c=relaxed/simple;
	bh=Qy31+uRAyXc552YjYjFbiMoMOXbW3e9UP2BZgteKHMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QSxjpmL9A+jWNrmy0LiesOTaXrIYEVFIZoIOCiEQj5FrbwQUMaMCyiXsnhR5hMoDnCauOMIYLhRAPE9o1aK1MchTf5V46JJdYpCc//ebw3PV8pGC/uvE4cH4gDUMrO5KJinTjSqJ4EMGI8q36hM+AvfhvtJ7huXA6Ls048zBsQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zH1okmbq; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zH1okmbq"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c6e74e55d35so4068028a12.3
        for <kvm@vger.kernel.org>; Tue, 24 Feb 2026 17:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771982477; x=1772587277; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LC9/uqgNjMKR3Pk2VQH/jaz/lG7goMkRYlbLKdqdUyY=;
        b=zH1okmbqk7N039NOHaa7iZu7VCsU59eWPClkOHV62+tC+WvWTXksNXYyxMfvikYiVK
         N0UnKPFYdwmB4C+G408v4rAQJj/xXpC9XBFDs1CCbNcC4m/WFfWCpWpYlC6DrDANKXF+
         UE1FqGWpX3Sel3Ta8mk7Y3LqtndiPn/fM1NOPqW54l9woHTnu9ZS7q9/hHykGeyWXbwc
         AutQdKJRNvw4h4/bQ5YaX2vQQgOlRUlMnc7YMzVvL3jWSs5NqjIxAivCDKoytSWb+6EW
         LUah5xsfGVcTR+jEQ6F3wB1jQBNFzRY/bDC1mW3yCHOpdAew93EKY+XL4PJ9waPCiVo9
         NUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771982477; x=1772587277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LC9/uqgNjMKR3Pk2VQH/jaz/lG7goMkRYlbLKdqdUyY=;
        b=WaFft8xrF2LYybQne1TTEDN/O6li/S2hhToz/5GFGnTbPXTmDSL6NKPyqlnCcGz9Ki
         BgSmgDtqswMWt4kpmjULfVU6eUppNr6nzRWUvCGOnHEFp22pRd8p6XgG/g/llmx9CiMm
         w7mLDPBIi+33iXj6rykuH6iLBiKS+h+OpPlPNM2+TfI/+S1JsuPTbMpEDHFtj61Cws07
         b5DNuHj1l3N7EKMnqductNfpdsCvOAqoarxwXOvMoDTp2h5mE877PsA9HRxVXBVdTRtq
         5jW/V5FAiLNykr1THvNspn89gOt4GjqwGCXtGM9lxJVMWSsW5z11XWPiuSnrs2gAjYUC
         dtwA==
X-Gm-Message-State: AOJu0YxOkKTLXJc7EaUTc/Kl0g2CUOplyel+24av13hcq1yk3uaaHnOy
	iPj8AuQ+d2Q+nXRke2fC7zCtTuzBIFe+PgnbTr5h0kGyr3hX7DFO4v+uLlhkmOs591KdCXZK89t
	kqV8ZOQ==
X-Received: from pgbcz10.prod.google.com ([2002:a05:6a02:230a:b0:c6d:cb1b:286e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a04:b0:394:8455:d1a9
 with SMTP id adf61e73a8af0-39545e5081dmr10146147637.2.1771982476785; Tue, 24
 Feb 2026 17:21:16 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 24 Feb 2026 17:20:48 -0800
In-Reply-To: <20260225012049.920665-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225012049.920665-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225012049.920665-14-seanjc@google.com>
Subject: [PATCH 13/14] KVM: x86: Don't panic the kernel if completing
 userspace I/O / MMIO goes sideways
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yashu Zhang <zhangjiaji1@huawei.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"

Kill the VM instead of the host kernel if KVM botches I/O and/or MMIO
handling.  There is zero danger to the host or guest, i.e. panicking the
host isn't remotely justified.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f3e2ec7e1828..5376b370b4db 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9710,7 +9710,8 @@ static int complete_fast_pio_in(struct kvm_vcpu *vcpu)
 	unsigned long val;
 
 	/* We should only ever be called with arch.pio.count equal to 1 */
-	BUG_ON(vcpu->arch.pio.count != 1);
+	if (KVM_BUG_ON(vcpu->arch.pio.count != 1, vcpu->kvm))
+		return -EIO;
 
 	if (unlikely(!kvm_is_linear_rip(vcpu, vcpu->arch.cui_linear_rip))) {
 		vcpu->arch.pio.count = 0;
@@ -11820,7 +11821,8 @@ static inline int complete_emulated_io(struct kvm_vcpu *vcpu)
 
 static int complete_emulated_pio(struct kvm_vcpu *vcpu)
 {
-	BUG_ON(!vcpu->arch.pio.count);
+	if (KVM_BUG_ON(!vcpu->arch.pio.count, vcpu->kvm))
+		return -EIO;
 
 	return complete_emulated_io(vcpu);
 }
@@ -11849,7 +11851,8 @@ static int complete_emulated_mmio(struct kvm_vcpu *vcpu)
 	struct kvm_mmio_fragment *frag;
 	unsigned len;
 
-	BUG_ON(!vcpu->mmio_needed);
+	if (KVM_BUG_ON(!vcpu->mmio_needed, vcpu->kvm))
+		return -EIO;
 
 	/* Complete previous fragment */
 	frag = &vcpu->mmio_fragments[vcpu->mmio_cur_fragment];
@@ -14262,7 +14265,8 @@ static int complete_sev_es_emulated_mmio(struct kvm_vcpu *vcpu)
 	struct kvm_mmio_fragment *frag;
 	unsigned int len;
 
-	BUG_ON(!vcpu->mmio_needed);
+	if (KVM_BUG_ON(!vcpu->mmio_needed, vcpu->kvm))
+		return -EIO;
 
 	/* Complete previous fragment */
 	frag = &vcpu->mmio_fragments[vcpu->mmio_cur_fragment];
-- 
2.53.0.414.gf7e9f6c205-goog

