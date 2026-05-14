Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA7A3CF69C
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792723; cv=none; b=Ylj/MmEKsbWpoWMxcHaZBIb/pbubcxH8qog9oo0hI7QgqxhqIJOXzeSWAIv55MfEaIHoYnraJCyHDLh4R6KKUvxnBB/J0M2nSWK1gAN3knan/+0F/2x25y89m3kMwLay/Auj7NA/Z7vVgSp9iLsldSr/S0sFfjitBkSTLvB06Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792723; c=relaxed/simple;
	bh=OYekk1EH5NcmtvUhqTFSEum3+N2bK0MfWVLEvq36g0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CxvifWG0mGd7e3Sr/pEgULZSeoUZIuWYoueTY/s9ZumCoZizQ9r4azHUlveB/x2cXDz6xos7NNtfcm+KaG2OE68fSxh0RpAHGKna0uiBsqaBnjF5kjGunk9WFZ0FKsezN/trdDA1hSClcvTo4Fi7G8A3MIBysjbxHC6jrsPv288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nbz/5ewQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbz/5ewQ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b9b8137828so89952895ad.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792721; x=1779397521; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ksRWCd9wVpXXedmzgp+8zq/d+VDqKQBk5H/4tem2ZDI=;
        b=nbz/5ewQu2MuEDtc4Q+bc1PAZZ6Eg+xumZSJt8M+hOiX+SMWnooWFdS87dO7Rwf7N2
         R8CeVM8f5UZKVlM0QGpZCEXYyo3pGvEbttdLQhVtmXUEGmDP2T15d+6UbQf2SPPC4DXJ
         hKyk/ig4TCZVrHKM5PBrLJ/jxa6FupbofEqX3J308ijpJL6fBecvP6peps2GBXFOS7Ht
         svbaujWmyOcVL7G1QRDj0vDfm9eI4x7XN+n61yQunYDqNqUCs6lM78UZFhPWOHSIjddy
         YCLVbZM0ZMOUb/dhQNTJ4spviHVmWh8MyHViLfcuzBZgfWQXXvuxNgrzUkPpCJD299xk
         F94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792721; x=1779397521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksRWCd9wVpXXedmzgp+8zq/d+VDqKQBk5H/4tem2ZDI=;
        b=mPzZnFmImjUIgXqOtvLofQ36KoKLLBTYwSJ6zaO4wBSp6/sxdQYnoF3BThBuQm/FIO
         2HJ1le4bFx8k7sl6eHSDFvXUdpLbdi/DWr/AE6dZ4uCQwpCO9PPFEfCxrAkbn/mvgpdn
         aWe7PK4/gtpPYYVyjPpgPFUtYyS+SmhA8kD5rL8tBN9f2sqZo+W0pSgzrlaQW1zGueOU
         sPGTmkNociWcra4Zw1NzUrDGlnAHhkbCfs4x//JIjWqMyuUNnJRWuMszIpBGwKo9Ah4v
         cR7+/Sw8gvW+1Czr02cUgszvt7YusJDYELBkX7c7RS8T71oK82c8vAMuLeRKHTYNhRMK
         QfGw==
X-Gm-Message-State: AOJu0YxcK0Nfi8VcRYA8ucGLWY0DjBjZRdSC7pllbIocMA6KdER3HPaG
	iNjX+KQihYAsrIzlQKS909EonpkVVsFRNhVP+gbGpYg2vFnz+mJ+yJ2xERV/5S+lnRo2OUavWue
	hU5FX3Q==
X-Received: from plbb3.prod.google.com ([2002:a17:903:c03:b0:2bd:508b:a806])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fae:b0:2bd:a5f:1d04
 with SMTP id d9443c01a7336-2bd7e8aad34mr11686145ad.9.1778792721105; Thu, 14
 May 2026 14:05:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:56 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-17-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 16/20] x86/vmx: Tag "struct vmx_msr_entry"
 as needing to be 16-byte aligned
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Mark "struct vmx_msr_entry" as 16-byte aligned so that it can be used in
static definitions without generating random VM-Entry failures due to an
unaligned MSR load/store list.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/vmx_tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 6161f451..31c7672c 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -1973,7 +1973,7 @@ struct vmx_msr_entry {
 	u32 index;
 	u32 reserved;
 	u64 value;
-} __attribute__((packed));
+} __attribute__((packed)) __attribute__((aligned(16)));
 
 #define MSR_MAGIC 0x31415926
 struct vmx_msr_entry *exit_msr_store, *entry_msr_load, *exit_msr_load;
-- 
2.54.0.563.g4f69b47b94-goog

