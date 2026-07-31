Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1108B3793BA
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785528663; cv=none; b=cZ2TbD033vzsTc+vbVFUzPeXeczH1woXu5RkCLwxcwfPBjIHDedbmS8dsMs23zbap+AtY6NR5pMzxUhiTVkxFJimEj4MtvmPRaBX3kOc9nxElco/i1gHfEYAXtMiduGd4N/jXej1zA0EjP/CXCpDFbTIRKZWyNa+9b9i4Dnr+50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785528663; c=relaxed/simple;
	bh=Uj8SmNrzZrIhvlxYtUrWznuFFfQpzPJVVMjYZQhVJWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tcSRGSs1FV3gn2k6Sgd3lutWbJLYfSccUbl6u81W9cnG+bOp4hPWhn3JaYYyLNYc6SpLaPHspil8RdHbBKqo0PtTX4bthKr6C0dudOc8drlSm9imE1Z0367K1JMO3kRCHPZ5YwyyvT7lt0800shJX7G50+em0CiFs1SlUwc7Gtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vrOQtyDC; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrOQtyDC"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cab041eced3so2019008a12.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 13:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785528660; x=1786133460; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nCwkrHoQw8GqZhR+kRNFmX+b1WOcdKZEDyMBbasgAHI=;
        b=vrOQtyDCt+pYfy3qOU+1CbFd+Y0GE7SDxWlR8ac0EAEQt/26uY/42G9XIlXR1cs20M
         SzP9FXpcnhJIsVXMszjZluWaiDEj3qdNwHeSQg9+mJAEIC5dHkwzygC7rVB6jppMs2aM
         38KFv3Bp2a90i8urOvG+fnPL8VQGlQryBvkknaQaRxi4NdzybSiZtW3dKC5BoZU7FfKp
         QGUbuEvKJTd2bOrNKIAnKMBkP8TIhQwOBbMfzdIHkLnM+MHHeVfnTdWH/RCsQ24OEztt
         16UYTLh3yGAljvHPvtXMr+BxnqofQHhxAcACsut28jhd4367N3Q9VIojewRMsEOoSL5S
         RZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528660; x=1786133460;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nCwkrHoQw8GqZhR+kRNFmX+b1WOcdKZEDyMBbasgAHI=;
        b=QtK91KdOvWdBKBmA6dwhU839+A4JItEkns5/8+Lu/9qtTiVQj3vdrjHj0Zn2vVQkBM
         Mg0ZORMtdlK3YoqWiwy/JXdd84TksLMrVIv2SHtF+KwcnP22mzW2jhEfUUzXXUhuGtm4
         VF184+XoEZi6N3NaQIwOipOs3maQBULjmUpNzmYIlB7BlfVNBsnyX0ARgUCUxX+6VFjM
         DyIvn7Cgpgve6IXF3EnG+lljsGubAlnH2aiYRFsFMaQ8CidLNX0cQgTdHdmLTVpTfdAv
         Edi0qFkTOC6hytD/XYFbx9WPbCLaS3abMqSwae6/BqiCSwSk9ndckGkSJcDqjYRCIyau
         z0Rg==
X-Forwarded-Encrypted: i=1; AHgh+RqON9p6lqU7Sn5WzGIod9uut4HU8CWdJP7yMqWpj2RJgggblNfN3evt2kxHiI+wMQw09F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWxCOgegQ9PexHrch4qCbNes2Xvd+SZAZvwmXwAO99wSSVqUzz
	jT8pNLR/EB/aA5dGGBTdsBkUCR3//V7I2YvktzARPmlYrF7kox5LPPfBmZzmRoh78/QPL3mAO6J
	ctOKAIA==
X-Received: from pgjs24.prod.google.com ([2002:a63:f058:0:b0:c9a:ffcc:19c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9cca:b0:3bf:6c08:fba7
 with SMTP id adf61e73a8af0-3c92a84ec9amr946941637.59.1785528660082; Fri, 31
 Jul 2026 13:11:00 -0700 (PDT)
Date: Fri, 31 Jul 2026 13:10:00 -0700
In-Reply-To: <20260713181020.2735367-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713181020.2735367-1-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <178552843072.2713482.13489119130019659719.b4-ty@google.com>
Subject: Re: [PATCH v3 0/5] KVM: x86: Fix EFER reserved bits initialization
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 13 Jul 2026 18:10:15 +0000, Yosry Ahmed wrote:
> v3 of fixing EFER reserved bits initialization on vendor module reload,
> and move them into kvm_caps. I reworked and reordered the patches such
> that we go straight to reinitializing the EFER reserved bits, instead of
> first re-reserving the bits on vendor init if nested=0.
> 
> The motivation for the previous approach was simpler backports, but
> practically the fixes don't apply cleanly anyway to most stable kernels
> due to EFER.LMSLE handling being introduced very recently.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/5] KVM: x86: Move enabling EFER.SVME and EFER.LMSLE to generic EFER setup
      https://github.com/kvm-x86/linux/commit/6ccc19d4c1eb
[2/5] KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported
      https://github.com/kvm-x86/linux/commit/e62392bf39eb
[3/5] KVM: x86: Always initialize EFER reserved bits on vendor initialization
      https://github.com/kvm-x86/linux/commit/a4b8acd428ba
[4/5] KVM: x86: Reverse the polarity of efer_reserved_bits
      https://github.com/kvm-x86/linux/commit/37352c4fbdd7
[5/5] KVM: x86: Move supported EFER bits to kvm_caps
      https://github.com/kvm-x86/linux/commit/92b2af2b6d2c

--
https://github.com/kvm-x86/linux/tree/next
