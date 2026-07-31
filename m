Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6737B3546F0
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 20:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528636; cv=none; b=dJPBsvlWZneOJAXk5yYPLItyGAoXkIRHlOv0iFNDVYk8cdcU5xPD3mGR3RcjAKfVMvLmV/uCG0ASArWApFpQUOFQ4N/2eb8p6y1FZuB6C/NfLeMNMIGE6xlCcUpWZdSPSKxMkL4d6ePbckEPPVrYWi7uHwaEfUbk/8FigLscKIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528636; c=relaxed/simple;
	bh=SVnTfczQzOhzH0y0LlZWFaQ09zpzlX4riUtSH+bq4wc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WzQorKEjYLF9bnrCIimmU8NiYveJB3V2eRKXofUPj2l+BLZn/QwSmm0wETLwi6505rrBznwja4CbiwoB4rx5bWtAkL1a+p4ggjN9imoOn2w7GVaDtL4Dn11xHjj3yCEj4Sr9uN88Ge2GtIQu00gPovSRsmmDUJjnvs+wrdpTGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vk0K/+x1; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vk0K/+x1"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc86a9ef97so23883465ad.3
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785528635; x=1786133435; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TBgNnD6aRn/2TcCAkCvX20HdpQ+UmnIXjam1WYJQA5Q=;
        b=vk0K/+x14JgJjgKiWzAsxbd2nyNLBFjz0/XsdPbLhTlvWMvzFvYOWiwB9KRmzA2xQc
         vj/yqzn2zyketv/fL02An9Qm6Rtw7J9BpOGZC3UYNC+YuVCRISdJxAAEIqS3VuT+DUT0
         dH692/tO8Q6nwtQ3j2aIGEnVpuPqEADsMYHX7czaXlLJvJFqkTHt+WiAZ/Xpj4CVeIji
         Z+ndKZmOAXSSe53CL0s0UoCzpPhA9W1I5IhM5aQIBFyucqaL4MkjlXXekn3zYKfjn/B/
         EqPBE2yY4Af9DoND1i5CC5iNiEwqoecFVB0MoSZQ3WI+N6yUzRJoK/u/wwgS2pHn5Odw
         B5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528635; x=1786133435;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TBgNnD6aRn/2TcCAkCvX20HdpQ+UmnIXjam1WYJQA5Q=;
        b=cvKkkeTMZSNw/RxK9fooMNA1mK+ZCj075ekoZbifKf0uU0GUBwXdO4Es9N0Ya6KMok
         TFjKqMQBbOYZ9NaXgLjPfi3ERUlGO4a6Ok6YCDtZnDnHHR8Bcr2ox6P1u/oWQWzRYBqK
         FLUiDZ9jDSvsolpcE3Y9e2BJlGMxQOwVQWTz5QAnYI9J/Sd8TE+vssDaVa5FMS6O47Ks
         bZTz76wlU8rFD7zkasU7QcPeRb9cT2AR0tMWZkKuxTNmE4nnjMvFFgN1fFaxT5hvY0vH
         B4q+EMmwK12y+A4wjIiZwb/JWkmvY/WRVcTr6ak/h4H7ieKuLLMuB1ES8ER29qGCR5/h
         yStQ==
X-Gm-Message-State: AOJu0Yy9bPUBU9ZHhroDzPAQmXcylVK5+LwCksvwsYbp3fcomYPz3FrU
	q/T2UVME/bOG8zehsJFD20vTBveuAvTj40Y0o/0+AIJI1j1GHZzRKZmRjeqXQQMWHEtBgDKnbZ0
	nIZKBNw==
X-Received: from plhn5.prod.google.com ([2002:a17:903:1105:b0:2ca:cdc4:8da])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c26:b0:2c9:97a7:3289
 with SMTP id d9443c01a7336-2d0524a43ffmr11615445ad.43.1785528634621; Fri, 31
 Jul 2026 13:10:34 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:09:50 -0700
In-Reply-To: <20260715090505.601174-1-kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260715090505.601174-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <178552856364.2715352.9297869306293103788.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Use KVM_X86_OP() for the .pi_update_irte() hook
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, Kai Huang <kai.huang@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 15 Jul 2026 21:05:05 +1200, Kai Huang wrote:
> Change to using KVM_X86_OP() instead of KVM_X86_OP_OPTIONAL() for the
> .pi_update_irte() hook in kvm-x86-ops.h since now both VMX and SVM have
> implemented it.
> 
> For the Fixes tag:
> 
> This hook was introduced for VMX posted-interrupt support.  SVM later
> added its implementation, but at this point KVM_X86_OP* had not been
> introduced yet.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Use KVM_X86_OP() for the .pi_update_irte() hook
      https://github.com/kvm-x86/linux/commit/9498f4d6edd3

--
https://github.com/kvm-x86/linux/tree/next
