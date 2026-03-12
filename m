Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66642C17A0
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345895; cv=none; b=J9sTsDQ0TUgnyVPWGIh1M4TL4+ahdhsFgcJdD87/itg6z/TYajkkCt56645mY7c90PXQ+KXdeEVGC99u1kZWuUu3E90Xb8PdAuGkOI7FwiTQF7fyskxuP23WjSEgby8jLUV3Js6J36HsjX1x1eXnxwKSRCpB92Ca4ev22+uNrJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345895; c=relaxed/simple;
	bh=Q2Dz5/OEh6DH4pX3NgP0K3CGI0lXwl2eOSeT06eOFH4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ul8T/kkeZ2bBOHeQPNEP69i4P7rCmTGTsGkzlHOEdIpxsIWMvM8HMubv9VNF6wi+d+EHy1hCMfLS5gZs+z0yKmACyzwoFKnfL+exJonkEU672mLCkJDMnxTEmWnb4tmGTPsdQuvUpOeoB0QOF6Hq+8sgdyLl8IqIIlgq3tHJUAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qS4O+BzF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qS4O+BzF"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae3e462daeso9529845ad.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 13:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773345893; x=1773950693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mquuBhH5mEBbGKF1zjKCYUJkvskIC0Bertlw5dm983s=;
        b=qS4O+BzFHSVoxn0NOz01fRbXJYI8xiDIUFNINNAaLM3JjeDpJPsGPXjDeplIgDkGex
         SIAiUbrvNFpY83Mi+AUl5xXMS/2pw9nkGE9hnOZavHjtojp3Sj0Pt+YZSWOnpLDaHi8p
         uQkJT/VU5zJ2+DbN+lMQeQA80bLPvQjoI2x1vPX793FJkJHHzkPG0XadXZzA2KV4TNpL
         4HqMW3rOfsOGHDbBBEGroMOWa8KZTj/0fnpB8PJia+XzlBs3N2oNns2/TzWqpHxN3MOw
         5eHUNDQr4rXUByN/naaEKIDBxkG4bxkpp+yiG3OAeR+rV+4+BNsDKl3ylBCnYJDC2KTP
         XhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773345893; x=1773950693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mquuBhH5mEBbGKF1zjKCYUJkvskIC0Bertlw5dm983s=;
        b=e0fAJDAsODRi8yfch/wHF8NgL3wKXAshZnSSNjfgM+0O4XEVJutMSNZi7ZsuWFsvj7
         fIHMS389HlGj8SVsDjsTNFJX+Q95bFy4kgMv3GspOW6uHFpUQEQZEROhVEMOaVqxA9Vg
         yZQGsxOORNAjkdrP66+Ah26w6diejv4zuy1c+q09tWGVUkNJ0p4mjCGJfMnqDvs7TsO4
         yZwBcTndJjRnReW7QZw4tx+HKaM2Eer9qKA0q02CH1fM011yolqxbyy3eU65Apf6Cd7H
         Yz07HMcqP91io/xb4mL/4Pg6yRzfAvMVp7EQ8HP/RIWW17LcUHov2WgIp7o6EVvoJiCR
         zeew==
X-Forwarded-Encrypted: i=1; AJvYcCWmx6b5LjLwlX2hA/jVUjKC9QkN+KG3PYEU1ftFCJC7QfUFMeer//j6RX2/t6ta47effJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpYy4ADo5UFQsUaulVMN55WW1Q3O0gX/AGawC4f33gcpcvdSEK
	UfoXszUyGICQRxT0HreOBhEklNO4CFT7PSJXMpcV9N14vQA6s53gLsnCBTZ2LE4YNYKOR8icnqL
	ORJpJIw==
X-Received: from plcf13.prod.google.com ([2002:a17:903:104d:b0:2ae:c5aa:fcd7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d485:b0:2ae:5228:e0ff
 with SMTP id d9443c01a7336-2aecaacf65cmr5648905ad.29.1773345892982; Thu, 12
 Mar 2026 13:04:52 -0700 (PDT)
Date: Thu, 12 Mar 2026 13:04:51 -0700
In-Reply-To: <20260303191509.1565629-1-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303191509.1565629-1-tycho@kernel.org>
Message-ID: <abMcYw1wMin6cqY8@google.com>
Subject: Re: [PATCH 0/5] Revoke supported SEV VM types
From: Sean Christopherson <seanjc@google.com>
To: Tycho Andersen <tycho@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Shuah Khan <shuah@kernel.org>, Kim Phillips <kim.phillips@amd.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 03, 2026, Tycho Andersen wrote:
> From: "Tycho Andersen (AMD)" <tycho@kernel.org>
> 
> Recent SEV firmware [1] does not support SEV-ES VMs when SNP is enabled.
> Sean suggested [2] adding an API so that userspace can check for this
> condition, so do that. Also introduce and use SNP_VERIFY_MITIGATION to
> determine whether it is present or not.
> 
> [1]: https://www.amd.com/en/resources/product-security/bulletin/amd-sb-3023.html
> [2]: https://lore.kernel.org/all/aZyLIWtffvEnmtYh@google.com/
> 
> Tycho Andersen (AMD) (5):
>   kvm/sev: don't expose unusable VM types
>   crypto/ccp: introduce SNP_VERIFY_MITIGATION
>   crypto/ccp: export firmware supported vm types
>   kvm/sev: mask off firmware unsupported vm types
>   selftests/kvm: teach sev_*_test about revoking VM types
> 
>  arch/x86/kvm/svm/sev.c                        | 16 +++-
>  drivers/crypto/ccp/sev-dev.c                  | 84 +++++++++++++++++++
>  include/linux/psp-sev.h                       | 56 +++++++++++++
>  .../selftests/kvm/x86/sev_init2_tests.c       | 14 ++--
>  .../selftests/kvm/x86/sev_migrate_tests.c     |  2 +-
>  .../selftests/kvm/x86/sev_smoke_test.c        |  4 +-
>  6 files changed, 162 insertions(+), 14 deletions(-)

Other than a few nits, this LGTM.  Even though the sev-dev.c changes are far more
extensive, I would prefer to take the KVM changes through kvm-x86 due to the
effective change in KVM's ABI.  I'd be happy to carry the whole thing, or use a
stable topic branch as a base (patch 1 can easily become patch 3). 
