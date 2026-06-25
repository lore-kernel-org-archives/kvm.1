Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BFF3E717C
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398825; cv=none; b=X3o1rGV+04PHy6gaxaf/WvLrDp0RbjhOGLM0Mw6UF0ekcMD+v+hovbGN8U9BZPvzxUHYMPVOU4YzhBDwsl7hKOz4HPT9dXbKTvFTcytyrFRTENtgNhx83GoXeomjOPpZDgIv0DzFs3bZRE3nVLVTU73geO/yugmDD2G3DKjLkRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398825; c=relaxed/simple;
	bh=S3+dkh2AAJ6V4XkIrQrgR8TKF7PKZWqSNP4fIsdZR1M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hRPDaL3LYUh3SpKQ2w7DTDCwJYEQtTaEcWZrjNMnd1RblCT+nU67DhX6ZjO87g2HFxuM64XMlJZlKhmOMNffYQLtWWCmSis2zFrKER2FUdJv8Nbz1gpm5gV/0rIm8yontC+vWqUsWUCZVHIcZIjNkuAU5tRkiJD9JO6sKVL/4oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KgxALouB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KgxALouB"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c7f4d28c66so10247315ad.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 07:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782398822; x=1783003622; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5FjTW/9czr0/KEcw1u4AJo3uHAihN7mDKo0VNDm2rhM=;
        b=KgxALouB3jPtDbHSxQhr4Zntv/M5xctm69/pX85wgATVrolEdP4HdCG/HdAUuhtP96
         dv8lNVEjkF6A1yaZNegNZ3DthNRsg8ogteLqHH2fTNZKX/XpZIj18jR1Unf1obSzoU5f
         1Ln5wycGygBCCcpFpsfhOSF6kharfAHAN5LlMuGyJ3xoPk5WAU6RPvC17xKj7oy33r+/
         finUTUQ/Y6x/qGafUurspIo3/Lw0nI9A//gD/rp0KtRX9SckuMJ1d8+DQN90mw7YBjQg
         FKXv4Fxwa7NUt1iftwiCYOSVhoTH+QOZEhvnmbQO/CTnGZVu84hMfdEgEtVYcX0Gf1Wn
         fjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782398822; x=1783003622;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5FjTW/9czr0/KEcw1u4AJo3uHAihN7mDKo0VNDm2rhM=;
        b=YuYJG+gyYKBEcS96x3Km7FitC97ZE/eoA0UzdNjETTZSzinlAVNzg40IBC3RebJnvU
         2IWvkI6iZVmXWaOrJV58oADNtUzADs8MnhyWAH5jqbfirV/osqFzyiF31JC7wyRFApY9
         1TY8x7CF3VZr0MhFNlnp0DDBZg/Yut1uxdOQ3LeSjgDH1m6Ghhcpg4vt/KIEeLHpohKK
         OPMo7SfF5v+aw5G7jHno16NOYCNjEf/CTLycBXpL8MO1GV68LDh1t3CgO8YPDS0ANixH
         pY8HI4G005vrkS/O9wUl+wPLoDiMODHIFKpCEfWqIt9wYqDZth6ajx41TU6e3Fqnzahs
         0t+g==
X-Forwarded-Encrypted: i=1; AHgh+RpoQJYGdAkJHGlhHN+ph/x3RJO4RRk+kR+LY10BCKAmb48NDrlvgMgqYokUfO7FHuJwJ9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCnXfWjH15RzOKaemIzJQLcv4VvKlGHIuWZjCWOxUSeNNXlls2
	vq4fCCU7uY4mAGeKbS4ENgwYbNHT5QiW2lNKij1u3t7hDDrBEKE2XU0yJh0NhlxmmXFQqFgchKC
	iUvl1fw==
X-Received: from plrd20.prod.google.com ([2002:a17:902:aa94:b0:2c7:9ba8:5327])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:320a:b0:2bf:2ea3:af30
 with SMTP id d9443c01a7336-2c7c3d2ad10mr124561455ad.4.1782398821740; Thu, 25
 Jun 2026 07:47:01 -0700 (PDT)
Date: Thu, 25 Jun 2026 07:47:01 -0700
In-Reply-To: <20260625095846.EF9271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625094047.255954-1-suryasaimadhu369@gmail.com> <20260625095846.EF9271F000E9@smtp.kernel.org>
Message-ID: <aj0_ZWALxEcvlUIy@google.com>
Subject: Re: [PATCH] KVM: SVM: handle wraparound of asid_generation
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: suryasaimadhu <suryasaimadhu369@gmail.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 25, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch claims to fix a 64-bit ASID generation wraparound, but provides an incomplete solution that only shifts the theoretical ABA vulnerability from generation 0 to generation 1, and fails to remove the corresponding FIXME comment.
> --
> 
> commit ecd299cb836eda8be32eeffedf37f3e076185761
> Author: suryasaimadhu <suryasaimadhu369@gmail.com>
> 
> KVM: SVM: handle wraparound of asid_generation
> 
> If asid_generation wraps around to 0, it matches the initial
> value of svm->current_vmcb->asid_generation (0), causing KVM
> to skip calling new_asid() and potentially reuse stale ASIDs.
> 
> Fix this by skipping 0 when incrementing asid_generation.
> 
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 24d59ccfa40d9..cfb9952f7c1f6 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -1794,7 +1794,8 @@ static void svm_update_exception_bitmap(struct kvm_vcpu *vcpu)
> >  static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
> >  {
> >  	if (sd->next_asid > sd->max_asid) {
> > -		++sd->asid_generation;
> > +		if (!++sd->asid_generation)
> > +			sd->asid_generation = 1;
> 
> [Severity: Medium]
> Does skipping generation 0 fully resolve the wraparound issue, or does it
> merely shift the theoretical ABA vulnerability to generation 1?
> 
> If a VMCB happens to sleep for an entire 2^64 generation cycle and wakes up
> when the generation counter reaches 1 again, wouldn't it incorrectly match
> the wrapped generation 1 and reuse a stale ASID?

Yeah, properly "fixing" this would require poking every vCPU in the system.

I don't see any value in trying to make this bit of code less ugly.  In practice,
the generation is never going to wrap.  Even if the CPU were able to increment
the generation every *cycle*, a CPU running at 6ghz would only overflow after
~97 years.

And Yosry's nSVM TLB flushing series completely eliminates the generation scheme:
https://lore.kernel.org/all/20260616004155.1435766-10-yosry@kernel.org
