Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F43A3803
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381835; cv=none; b=CzmeNNKvUusT0zoinmyoBFOfABP0JHZ8Aq8gczF+mAOG6NDysCy7bUtvfWdIAGGo+kIJFlUEyLF3TaWy+9LMjkOFyjVsLdQW25WR7CPrvf8lN5nTU49FOIt3R5Hvyv5m5IVeUK73ymK6j/kV54aqA7ZO53fUDhvHw1BcMFHPKsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381835; c=relaxed/simple;
	bh=5y9MQzmnNdA8fG73zq4cTMXDW78U5CKZAEWBePI7SwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fN73NBGAxFQLxxfFJjjZT9PKdjZ4wLPs+zCINgcwtjn+nMpqtESZsy0EItXwtm9k6GklBzeyBYtclZdhHPDKFp7yNXnHAEgTB4KebBfEj10gvCW7/gguHMLDcEeoE1c9UapqaUjce4mb4t8JR3Wzmp81oc9yNEsnLU8OlK4zopg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PzwauzUp; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PzwauzUp"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82cf8dcd079so66588b3a.1
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 16:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776381829; x=1776986629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=I8i9cxkTxORgkUnwzKhG1n+FrAvtgU2d9BkG0Hg1zPQ=;
        b=PzwauzUpASwgA6Rj6RSH/q/ggEzXA3HKTbyVkWG1uAoF3sCfi5COqAqDYQLeCpn8GT
         NLwfGNqeffYtBy0zYjeWImLvN9NxX54tQNlmwiO/OTfwi3SDKtCaQnc6a8UlQqS+wTsS
         NVuxPsev8iFHCre7Z3bnpSpLY2Ch+GfV616PsqcIVojJPkI9dVlQpIJBgSJz91GOvwIs
         67AZbA+PcbdOZ1q0E0mGZL27mjX/AioEbWFK0zOrYJAoSBrck4SK8F5pljwHnlitY1LZ
         S81Mu3d3ToOI+eiXviqP8b6v9LLYUyWwWJqzrpiqDiDpPVES+JMxJ0iuG7hG1aImBmwi
         ZNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776381829; x=1776986629;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8i9cxkTxORgkUnwzKhG1n+FrAvtgU2d9BkG0Hg1zPQ=;
        b=py4A04Iifk/GKBZIu51komJOzltF9T7vWv6X8DG9oYuA9nlo490UsO+SeHo5IpgWFR
         oE+uAqS7QSWlfxhDNmg2h9/0RfioDz8DndCxRNH/uNaQ8eiKN/ajBR9A3IbsDfbmEFRq
         8LHE0Efatlbq1YWX4REPC4tI/MlYYCmsgywYLIJfnq/TA/n6BFBYRQ+hA5EmS7NOBypV
         YFV4Bxm0SXAnlLgqAxvExLzEujxyi7NI1G8FNJWtjdVNJR+Da0mWeqCxMwrn2GomjsYP
         TvJCHyQcLNeL0ooV4H5ad2EDxxgsvKVDf9pDKYX4KxGdDchSYIeOzIA1kyxYF3mUUG95
         F3/w==
X-Gm-Message-State: AOJu0Yw2/KT0+VrsKIoiezERDSW3zifh+3SAHYdoLeTlfOQYeKkESI0R
	TN3xZ3bBtGMJJdfmFAjW0MLyfXiFQzwWLQ8cOKBseB6+n2QridgNpF02++B6gCQ/X1n6+4ZWDDo
	I/SZtvg==
X-Received: from pfbdo20.prod.google.com ([2002:a05:6a00:4a14:b0:82f:120:fd71])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:928b:b0:82c:212a:a9b5
 with SMTP id d2e1a72fcca58-82f8c8df69fmr245291b3a.36.1776381829092; Thu, 16
 Apr 2026 16:23:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Apr 2026 16:23:28 -0700
In-Reply-To: <20260416232329.3408497-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416232329.3408497-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416232329.3408497-7-seanjc@google.com>
Subject: [PATCH v3 6/7] KVM: SEV: Don't advertise VM types that are disabled
 by firmware
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	John Allen <john.allen@amd.com>
Cc: kvm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	Tycho Andersen <tycho@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Tycho Andersen <tycho@kernel.org>

As called out in a footnote for a recent SNP vulnerability[1], it is
possible for a specific flavor of SEV+ to be disabled by the firmware even
when the flavor is fully supported by the CPU and platform:

  Applying mitigation CVE-2025-48514 will result in disabling SEV-ES when
  SEV-SNP is enabled.

Restrict KVM's set of supported VM types based on the VM types that are
fully supported by firmware to avoid over-reporting what KVM can actually
support.  Like KVM's handling of ASID space exhaustion, don't modify KVM's
CPUID capabilities, as the CPU/platform still supports the underlying
technology and clearing e.g. SEV_ES while advertising SEV_SNP would confuse
KVM and userspace.

Link: https://www.amd.com/en/resources/product-security/bulletin/amd-sb-3023.html [1]
Link: https://lore.kernel.org/all/aZyLIWtffvEnmtYh@google.com
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
[sean: rewrite changelog to provide details on why/how this can happen]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0971cf652b0b..ab386aa0c284 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3202,6 +3202,7 @@ void __init sev_hardware_setup(void)
 		vm_types |= BIT(KVM_X86_SEV_ES_VM);
 	if (sev_snp_supported)
 		vm_types |= BIT(KVM_X86_SNP_VM);
+	vm_types &= sev_firmware_supported_vm_types();
 
 	kvm_caps.supported_vm_types |= vm_types;
 
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

