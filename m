Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30C33B8BC6
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186532; cv=none; b=g1yQVRhnldkhpx6uZRy3fhPGAuBvCyhYYHxxZ6czepomieyjit20TXzIntieGZBMCSTxIaBA/ZJSyjSiJ7gXSAa6ED8HkhxjoLTKXBBFldUECSiW6UkytccgOF/9qCH+Z5vTgmCU1l5HdE60nDfJiODotRPuDTTjWyYzzKLLgB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186532; c=relaxed/simple;
	bh=EAXd6U23TOM0TNLsWbdxjSjEvAZh9Ps8RAlEBkf+Mr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E4AtAT7aIslFIeEivCnw4Za93p6dVlM6eXcVLajUC16GEjYI7Wm6QafhuH9K0FuUexniso3+ue/ma2RrO8vKvxvmpGd115Ywgoa30sQ/ZDGfkJyXbvPPxkaj+TIcxJcsXpYNNmu1yPf8P94iMMoaie4CUBSyLHhnDv7OxLIBGeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=olR06XDV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="olR06XDV"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae47b3adacso94154535ad.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186531; x=1773791331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=EuE4VxLPE3eeqbVSDrv7j4XL4cakaBn+k4JWu7FqMLU=;
        b=olR06XDV8Ybj6d0sp9Rrjz+WsTQf6puOSrVKGVxWLz/ADazuC1pOF93aOtmj770EOQ
         G7MqFtoPCwDpRuUeTDiQWJSqXSyjXKkIUQky56t9mOc+iggsCXOCZJBtMXsKJJoThZ6U
         taduqY1GMx2A1heVCB94/yxAfMVXxcoOPa0KQyX4zk793XpRf9OxzI9ztYzJe++0erlT
         OnAl/n6wYUMzEB5xY2sty7uCvkFqMsd9v0fx6bSvphal9/hRv2QVUdOnSrEpK+RsnbC8
         SyZwN0G7dQ9/quih2wEcRsrjnWnw++o8pAfY9SJsRanIeLaqTT0SUbYHeZg7/PWU/Ej/
         ijRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186531; x=1773791331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EuE4VxLPE3eeqbVSDrv7j4XL4cakaBn+k4JWu7FqMLU=;
        b=hgsxum8K7CduGQuDRHCoH1+er9AmqDdJjE7vlo7k+E6Fb+fEOt4w7t0t724goXNsjn
         rrp/1FTd0sZWCUGfI+DcfUdWpqWbk0t9XdLqAhtKEkm1cLvzelCIvLOMqaB4Dd16SlXL
         jnC6YAxuv7sQxGF/rYLZF0w0HNVyDYIgQHTVoWzAHEI55Pmd9iPCIpax1ktT0TNRe6Ye
         qMVacl+upTS/hBREJDdgCAFzwdiGPruZay8wrrosLEJ/Tf91VEOM34DiUsNcV4q5RDu+
         Q9QNRBXL5eLA/e0UgLXanjFNb8Mieyb+l6zjg/Mv+beoCJWVeJPb3Uyj5sM8p20wXw7F
         1lxw==
X-Gm-Message-State: AOJu0YzjfG7HeE89F4ALf1hN35LzgXjekjOKYBYvfsahrNalgLr1l61s
	rgAp0+ND+zEIfpS0QTbimgUy4G/d6yHIjh2xB8KM6TR42WPnyLY3sERguSUbW7LOC0qgNaXGa6k
	q4RFxwQ==
X-Received: from plbkm15.prod.google.com ([2002:a17:903:27cf:b0:2ae:4e8d:56b4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:238d:b0:2ae:4911:4a52
 with SMTP id d9443c01a7336-2aeae763046mr3121315ad.5.1773186530965; Tue, 10
 Mar 2026 16:48:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:17 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-10-seanjc@google.com>
Subject: [PATCH 09/21] KVM: SEV: Document the SEV-ES check when querying SMM
 support as "safe"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

Use the "unsafe" API to check for an SEV-ES+ guest when determining whether
or not SMBASE is a supported MSR, i.e. whether or not emulated SMM is
supported.  This will eventually allow adding lockdep assertings to the
APIs for detecting SEV+ VMs without triggering "real" false positives.

While svm_has_emulated_msr() doesn't hold kvm->lock, i.e. can get both
false positives *and* false negatives, both are completely fine, as the
only time the result isn't stable is when userspace is the sole consumer
of the result.  I.e. userspace can confuse itself, but that's it.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0a1acc21b133..bd0c497c6040 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4487,9 +4487,17 @@ static bool svm_has_emulated_msr(struct kvm *kvm, u32 index)
 	case MSR_IA32_SMBASE:
 		if (!IS_ENABLED(CONFIG_KVM_SMM))
 			return false;
-		/* SEV-ES guests do not support SMM, so report false */
-		if (kvm && sev_es_guest(kvm))
+
+#ifdef CONFIG_KVM_AMD_SEV
+		/*
+		 * KVM can't access register state to emulate SMM for SEV-ES
+		 * guests.  Conusming stale data here is "fine", as KVM only
+		 * checks for MSR_IA32_SMBASE support without a vCPU when
+		 * userspace is querying KVM_CAP_X86_SMM.
+		 */
+		if (kvm && ____sev_es_guest(kvm))
 			return false;
+#endif
 		break;
 	default:
 		break;
-- 
2.53.0.473.g4a7958ca14-goog

