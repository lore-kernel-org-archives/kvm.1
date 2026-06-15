Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED25240DFC4
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781541077; cv=none; b=F2PRBYvN+y+6FOMMAVXmaZgLFMC0vD2EmWqns8vTNZ57vaHN/GbQp6Q4Qm2Z+Q8rBdNXUBsruLVGmsPJP6wiokPcBfw39y0fh1INuyHoF+1Ca29O6UYnr+QfXRLqXWWLvssB6JCLihCLLrxBdAosvuKKF0rQWNWSJEt1puKAR6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781541077; c=relaxed/simple;
	bh=bqpHpy3q7aSGVukZ5Yxvyrpqx0Tziizql2pNoSPcBi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sM3b3xgB4XQPvFCylOv+lv+NVNy7N13zlBMU17L1EThmmyky1nadtdveaC4uSid05/hvJf+4EqXKElChqBUYvCCmYhr4UVnaSS09aTG5qGMixeiC8xWEpF8/8P3uRE+7DaTB6nHpGWBU3u2VH9kCYolPQt1CLlgWhO448gpNvl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BxI2yqLW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BxI2yqLW"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0532a6588so33085105ad.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 09:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781541075; x=1782145875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kUkeRQ5xIJYqSZwyNIq6ysdGtV+0SA4evYZT4zsGKoM=;
        b=BxI2yqLWaWpw31Yi/nIv/2m+adsfRDeqgTFxFMXRdeWCwzhS8ls3Qscs154ovyS8ta
         LDWpuOzxoDojqiIeBrCgoCxzGu1MImxrcHcYdaHoBf7noMnxgtc5S5PRMrp/C79+aX0o
         BhjWI1Q3/fpQZxtf67NXuof7jirNIx8sZavgoGFk6eRqq6WWdcA9NjhoU7FR50rc/Nuv
         Hf5/02YK1LeB6LAlEulgXwc5I2C8epHpwRCiX2/CtgOFXidq785mCyZBb5oUT7R/Ildh
         5Bnoja2t/6xMu9sqI5yXQQsobPi7xp+ZeTjdEqU+qtrY0CUuG+RSwwXgKUM4ZeYGZsGA
         UcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781541075; x=1782145875;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUkeRQ5xIJYqSZwyNIq6ysdGtV+0SA4evYZT4zsGKoM=;
        b=lQJA5ZVXhwdmpJV5UO4F+IlW1RUymhCHALKlyaEiLt3Cwrbr4K6JkV/0pav/d9KJ+n
         UlBbDMncS7Wtn5sUKIj+J9/iIpZV1kME0wdnsuVcuvcg5PtKcq+9y8zAqP2wCQe0qfG6
         NImpKSXtJSQcrO/biJD6XilIXZhaanmhhsiJIitTNGykK0xua6h9wBlSB/uZmjEv6fin
         cIFTuySvWhQ2jq2IntkjmfSrIHrC7BV6QYlQ0DlYeRZeWd/n3q3obUDT7IgrA02TUqqT
         b0Qso9kU+gQT9LHP8BxREsYoQil7V9d7kAYR+H7arNhedO3Z/CJVYHGEsOwZCugcqowK
         IIiw==
X-Forwarded-Encrypted: i=1; AFNElJ+rU9rD/6XMsZqkhDHcMQQY8PfbCMGWZTzPBEoYezdTZ2+m0vOHAWk0RbT7RRSJ4l+aiXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQF5OE+WNz76gZFwK4iNlROK7FEmvix+9ikgG7S2EQb5CtxHu5
	7qYRspKf307TTG1NTrDutgGMVx0my4JN1wE/GCfy9wGY1huQTfEBNOuvbiatvR7rWq/HKmonrqX
	cMi4gig==
X-Received: from plv2.prod.google.com ([2002:a17:903:bc2:b0:2b2:4611:5de2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f792:b0:2bd:606d:b342
 with SMTP id d9443c01a7336-2c664290a31mr139852995ad.26.1781541075181; Mon, 15
 Jun 2026 09:31:15 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:31:14 -0700
In-Reply-To: <5c7f27d4-9561-4ad8-9cd8-de8af5ebba5b@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <20260613000329.732085-12-seanjc@google.com>
 <5c7f27d4-9561-4ad8-9cd8-de8af5ebba5b@linux.intel.com>
Message-ID: <ajAo0k2kAOFai4xg@google.com>
Subject: Re: [PATCH v4 11/30] KVM: x86: Move kvm_{load,put}_guest_fpu() to fpu.h
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 15, 2026, Binbin Wu wrote:
> On 6/13/2026 8:03 AM, Sean Christopherson wrote:
> > Move the kvm_{load,put}_guest_fpu() helpers to fpu.h in anticipation of
> > moving the bulk of KVM's register specific code out of x86.c.
> 
> Nit:
> I think patch 4 did the moving, so it's not "in anticipation of" anymore?

Oh, nice catch.  It's a typo, it should be MSR, not register.  I'll change to
this:

  Move the kvm_{load,put}_guest_fpu() helpers to fpu.h in anticipation of
  moving the bulk of KVM's MSR specific code out of x86.c (KVM needs to load
  and put the FPU when accessing MSRs that are managed via XSTATE, a.k.a. the
  so called "FPU").
