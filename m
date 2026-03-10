Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DE63F1653
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186539; cv=none; b=ZRAUMeZ8FAzJ6O5Minkgc4huwF+2n87zm40wEomF4elIsulIn+e+aW15Cg8UZwCbTHTA6wj0227EdOfs5jhleWfSCXZBB8D31KQPYgQ9/BKlmCI2UgS8jf4Q+YZbqTlztC0Y58W+oxhrjb1QHskCdf8R8mczGr9iPhQ+Wy3V+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186539; c=relaxed/simple;
	bh=ijcut67xN4CRBOz4C3fEZ3fWCluP+xATTUXzB3lsp0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T5RAZE04XAuaQHlUszSqxhBEOG6ZPhvHBh9HFklPO2DgSFUvLtGYYpKTIAxQO/zW3lx8yUeF6daX+3WSYeWKf2N6HHylSRUZs5hp3F7aHHx36ziQmSq9ZCNuX1ULBjISdmRc3kRc41piYbHkvE1IjswF3nny+8FBjxtSB62LAL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OsUl+jc1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OsUl+jc1"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae502a1dd9so122821665ad.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186536; x=1773791336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IkZbacKi2/io3/Px84Zc7YCbNlt1jj22ioCAhRfNNK4=;
        b=OsUl+jc1/bmL4GSWMnpdiG7pqpbEIyDU/BsSouSfwt0EhWZM2Lhp2RkMt7dn9MfDPR
         REi8TkKYBo2LLGWxOiHQx8QrsaWrDsZX6KhsowRcqLMyHtlwORVyF/Coseh4FbaBvZOY
         QErk8s8TTFEoTVRLrXaN+JaqCn3376e8L72PTBfP9r3MINAveyqT7hbv61APfcyj0Xaa
         fNtRbWelIgO4TYAYzJUjZxLhDW6xbwBie2il62v07LB3jb6fynJEuEYTxyz+DLtncKov
         dPNK5DBe4h61FhKpL4ygHQEwK2p10P3Hl8Zroyl3Ymj9TAAS10ettnswIegemhuT9m95
         Xk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186536; x=1773791336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkZbacKi2/io3/Px84Zc7YCbNlt1jj22ioCAhRfNNK4=;
        b=o61zu1wcxNPcvGRCL2rNYBDF7UBWYcw9O5xKdjUF+5t1INwyqnxNY2YXLex9wCR5Ji
         hRAUGTL9p+9uQga9Lpc9z8Ykb5rPwiYO6o3BkfZ6ctOvlAVoQuOrWkMzvooT4ddloSIx
         TsuaRxript8eMGDG+ocVDL2EqvCMZP2vnJ3KGMcFkjS4mkiwSocZ9OEQzJAmwcCvFA85
         67KG1+5cEYjyhLRcuapMFGw7y3075grIQAgXR+s4beshO+H2qS5CtPUyLN6NQu9U2/Zf
         /OS3mbfo+ELaBySSSfXgHaDwB78KtkXKvhX6iE/Du2nv0X5MWoKFS2/sBOVMZweUBhn8
         iWTg==
X-Gm-Message-State: AOJu0Yz8LH3B083w3Mv2YE+Yzv8gJ4aVPTTzp26yIK0Rn6fNeSHj6y9R
	ik7EFONI8ucYeP/8++TY+Oxxwiz+dyzVVYZTRMMX2svgnFT8JnYeBnvNj5utYrvcMlyk1qkZ/gT
	JCldnfQ==
X-Received: from plbv8.prod.google.com ([2002:a17:903:44c8:b0:2ae:aa88:59dd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d488:b0:2ae:5b64:12da
 with SMTP id d9443c01a7336-2aeae90b632mr4856785ad.45.1773186536084; Tue, 10
 Mar 2026 16:48:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:20 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-13-seanjc@google.com>
Subject: [PATCH 12/21] KVM: SEV: WARN on unhandled VM type when initializing VM
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

WARN if KVM encounters an unhandled VM type when setting up flags for SEV+
VMs, e.g. to guard against adding a new flavor of SEV without adding proper
recognition in sev_vm_init().

Practically speaking, no functional change intended (the new "default" case
should be unreachable).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e5dae76d2986..9a907bc057d0 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2930,17 +2930,24 @@ static int snp_decommission_context(struct kvm *kvm)
 
 void sev_vm_init(struct kvm *kvm)
 {
-	int type = kvm->arch.vm_type;
-
-	if (type == KVM_X86_DEFAULT_VM || type == KVM_X86_SW_PROTECTED_VM)
-		return;
-
-	kvm->arch.has_protected_state = (type == KVM_X86_SEV_ES_VM ||
-					 type == KVM_X86_SNP_VM);
-	to_kvm_sev_info(kvm)->need_init = true;
-
-	kvm->arch.has_private_mem = (type == KVM_X86_SNP_VM);
-	kvm->arch.pre_fault_allowed = !kvm->arch.has_private_mem;
+	switch (kvm->arch.vm_type) {
+	case KVM_X86_DEFAULT_VM:
+	case KVM_X86_SW_PROTECTED_VM:
+		break;
+	case KVM_X86_SNP_VM:
+		kvm->arch.has_private_mem = true;
+		fallthrough;
+	case KVM_X86_SEV_ES_VM:
+		kvm->arch.has_protected_state = true;
+		fallthrough;
+	case KVM_X86_SEV_VM:
+		kvm->arch.pre_fault_allowed = !kvm->arch.has_private_mem;
+		to_kvm_sev_info(kvm)->need_init = true;
+		break;
+	default:
+		WARN_ONCE(1, "Unsupported VM type %lu", kvm->arch.vm_type);
+		break;
+	}
 }
 
 void sev_vm_destroy(struct kvm *kvm)
-- 
2.53.0.473.g4a7958ca14-goog

