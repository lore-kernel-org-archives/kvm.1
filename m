Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEA4478859
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093400; cv=none; b=nHOe1+hUJ+6M4yMgiCz5YMY2U3d2uUPyd5/pXx17E9GEFqS5/+FPovSmxAsDhEFgMWcSJAqqhZzIeOJt+49WOk9mpc5xIcR8QEeDtvCWsWUx3Y2lqDiy6R0qB8Xz8k96tcVxrPvoWEZRTp0rgVFCdkCf/DFKpdHYPtKl4fNr7a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093400; c=relaxed/simple;
	bh=C0TPGUq872+vTHaWb23bDYJo5eC/8eQ3y1jYm66lwjA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RrSfftKPCvdIKSQQ2Z6av4I9DtTnIJ0r9nMMO8/+AUnUz1s7jSiAOSP88gqkkbRDJVRkXEjEH209e/NkXDsvL3yvCJNtBkLK1C6Wr5K1Q8yF48JtZTAwpulyNigvH5pAZ8VVTCOYe1gLYXK/0zE6rQ8rS5L9doXPDxPXG7YbiwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rtoLwhD8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtoLwhD8"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2baf7378ad0so156258905ad.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093398; x=1780698198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi5uBfbWTd8F8248YP0/y/lIMSNaZw4vTpSUB9flOag=;
        b=rtoLwhD8H3Z+Q7T+FR8+tfrNuABCeTsU2BSLZ0KYo0Zd+o3+FOS30mUvr21L/DOyFe
         pz/kzUc50/w6MOSrh+VpdU3j5tFJZ8U0xGAUTJkOQGn9kN8gGm/VSa6tUiHHRS4lb4V0
         BbTVsDALEpiJMg5vTbzMd5zecxfOveUHOAmM8VBtlfuYcUoPt7bmj8WpKdNF6B5jepdy
         +K8wfXQo118jboAaR3QIDals5tCZbOw/X/j9/hTjxvlCcAvqPbD8awCfiZIta0xyQyKm
         nzOPcEUfC1n+brsmoGnoRaW/+rseZ1fE5Pa126IePxyD964xre7UNYBXTtXV0dJmakxF
         v+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093398; x=1780698198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pi5uBfbWTd8F8248YP0/y/lIMSNaZw4vTpSUB9flOag=;
        b=akGLvn7y5KpEh/FUJjAbkxsg7RZSEb58JTN63DWdafGouS9wepfEk2ta0g0c20q7F1
         RE3cynx6Yz3XZpwJv64nB9nlrux6AoPLfgOokVuQxCx5CF+aZdMqxMuezon0elBqIph6
         oFbNJ0XW6eiyT+tFMNlcNDBsWMBglOye60cklV7zITzEvwy3+AJm8eeqKnrMGDT5cVzJ
         UP+hq5nkBIcFuXoV2i7otPiv3qgAe05ctkHN0AkaQEGZQFR9NHLdWLTEeHLd4koY6rI8
         /ZRUcXr6YvlbESb6Y03sMgq+TGoGtv2sLy2v5Ngouso44fIDyEHU8tUwoKglrlVClvIF
         ydDQ==
X-Gm-Message-State: AOJu0YyIRC+q4irqT0UjRY5ZIuIsjA5pR0k3lDmr/1Ua3OAEy9NZ53B9
	n80MA/8MEPejstL4bMJ6F7VTSpVnRE416OoMCh8XCP6PoheUvTzNWilf8D+4Et7QnS1gTXAG9qf
	QTYUS9Q==
X-Received: from pgut6.prod.google.com ([2002:a65:6086:0:b0:c85:87db:a5c6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e552:b0:2be:fcca:31fe
 with SMTP id d9443c01a7336-2bf3682bafdmr19810605ad.23.1780093398378; Fri, 29
 May 2026 15:23:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:22:12 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-30-seanjc@google.com>
Subject: [PATCH v3 29/40] KVM: x86: Remove defunct kvm_load_segment_descriptor()
 declaration.
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Remove a dead kvm_load_segment_descriptor() declaration, no functional
change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ca2e69c80a8d..a861c0d70be0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2303,7 +2303,6 @@ int kvm_emulate_halt_noskip(struct kvm_vcpu *vcpu);
 int kvm_emulate_ap_reset_hold(struct kvm_vcpu *vcpu);
 int kvm_emulate_wbinvd(struct kvm_vcpu *vcpu);
 
-int kvm_load_segment_descriptor(struct kvm_vcpu *vcpu, u16 selector, int seg);
 void kvm_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
 
 int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
-- 
2.54.0.823.g6e5bcc1fc9-goog

