Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2847643C061
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769515; cv=none; b=MCCGQ9sJDBNeSZX6UuzzUIwRzYOzAgmhqH+qrpNGdGhq7ywJ2yy202tYRUK3C9eCk2sVCJfPW6Svsq8jCM47eNrsdWHWPhNJb8E+RArC8fskG6YcpsOzs6OQHw0u/w0CgLXyu4O7KyCgPp0C/4H3wHLhzbbOZm+cvOUzMihrkz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769515; c=relaxed/simple;
	bh=vLfznco5gDgs29HBkuk6g4sKUBP9AD9WYgLJyybzCXk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DBOvnD0vMvQnGs8EkMOIXz2sJZ2cjEQhsaG1o7pRMm+YsUCeNvAb/m9a45U37uQlijwZShh6tfZFJVH9c2g4Xm9z0X5tFQumGCk9CFCpiP2WHignh6aRytkt8kzRZnH2MpBAFEiRFhnWEqczY5F7jkIsTxZZX4/SeHnQ/Zk/A2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UKMOXhzW; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UKMOXhzW"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cec4226c70so16852595ad.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 11:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787769503; x=1788374303; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C1t+srGUYqUnv7fl4EGsK1emSikJui6QHHfx1hD3meA=;
        b=UKMOXhzWd/Zh6LIuh/b+5l3eSzNzq6kob2LS0T4PWUgtUUHamiqAxtg/i3rOIOCHpe
         PUnbKhTXnoKCAHzrRNlyHU6bYhzjuwj0CYZPI6dDykNFZ1+SqHlhqBHwZwnVCQI8G/+n
         gbJshjbgaooSgqA2FDCcdJ8+r7pYs8kbtIESG9UUMyStAzV02lqZJfuNfnsHxj466UnP
         Z00YSU8dpzI3sJA7xMiHZRtyQnKfy8UJsZxMTHljN9kgiU3b85cvr1vlKdGCzr3jUEw5
         PfFmOUtTtbDBRFBXkK3Zi34pKaTHqfJaddajRZSEsEj5sdZej5IA65bjoM00m+cZcIzO
         uofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787769503; x=1788374303;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C1t+srGUYqUnv7fl4EGsK1emSikJui6QHHfx1hD3meA=;
        b=Mhsw9yuEInjTvvQLeFF1dCoxsiEYfl2YmJDbKpU5eDqB1O0NLYo6rpLNxl0OVgqVDh
         6zFi9v6KBwHDBIgdZK+rxZuhLS2Z/u0kGuqVtEuJZmEWOTZgW3liAVNgNtE0NeapazAn
         vtsZZG9f22gIZvDDkm2cvBp0ro+neZo4lLsj+iNgPkCXh+jTLc/shx8v5t63xqJkjkeM
         xhzrDmchxH9EXJiJhg7wdrJaERr4BBAYfd1YdKrFNv8uHNleyNSGA5ch1jhqGAcI6WwS
         c8rn2eMmyvqqB11JeyElabA51MRvNEotfGPdI4CwoD3XP6ObcliVOIUZSuk86oCRaFHh
         CHIA==
X-Gm-Message-State: AFuF++kwFsDsz2Jts87AAQgKaAtg5Bd+PeeIxTQEXCKaF1vXuivYh7ni
	ApZXNbs7OqkdOY5dDELNyGVkkdpfnO4TYtwiGj4nTLIMJqnhWn6JZvp68IEBU9Hx6KAQrNfPcWm
	RMdtfDQ==
X-Received: from pghp22.prod.google.com ([2002:a63:fe16:0:b0:c8a:3e7c:1e5d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d8d:b0:3cd:9f0b:f7a2
 with SMTP id adf61e73a8af0-3cf84444964mr16293253637.11.1787769502521; Wed, 26
 Aug 2026 11:38:22 -0700 (PDT)
Date: Wed, 26 Aug 2026 11:38:21 -0700
In-Reply-To: <20260826172227.7246A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826171246.777729-1-seanjc@google.com> <20260826171246.777729-5-seanjc@google.com>
 <20260826172227.7246A1F000E9@smtp.kernel.org>
Message-ID: <ao8ynQ8OfJFhF-sR@google.com>
Subject: Re: [PATCH v2 4/8] KVM: VMX: Rename posted interrupt prefixes from
 "vmx" to "vt"
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 26, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Incomplete refactoring: The common helper function `vmx_needs_pi_wakeup` was not renamed to `vt_needs_pi_wakeup`.
> --
> 
> commit 3f6ac2d22873c9d6eb23bb3aab8ab0ad05bd4863
> Author: Sean Christopherson <seanjc@google.com>
> 
> KVM: VMX: Rename posted interrupt prefixes from "vmx" to "vt"
> 
> This commit renames posted interrupt APIs that are shared between VMX and TDX
> to use the "vt" prefix instead of "vmx". This is a non-functional change.
> 
> > diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
> > index 24221ba553be1..359ef3e6ebbe4 100644
> > --- a/arch/x86/kvm/vmx/posted_intr.c
> > +++ b/arch/x86/kvm/vmx/posted_intr.c
> [ ... ]
> > @@ -219,10 +219,10 @@ static bool vmx_needs_pi_wakeup(struct kvm_vcpu *vcpu)
> >  	 * back to the pi_wakeup_handler() function.
> >  	 */
> >  	return (vmx_can_use_ipiv(vcpu) && !is_td_vcpu(vcpu)) ||
> > -		vmx_can_use_vtd_pi(vcpu->kvm);
> > +		vt_can_use_vtd_pi(vcpu->kvm);
> >  }
> 
> [Severity: Low]
> This isn't a bug, but does vmx_needs_pi_wakeup() also need to be renamed to
> vt_needs_pi_wakeup()?

Doh, yes.  I meant to change it, but got distracted by vmx_can_use_ipiv(), which
_is_ VMX specific, and forgot to revisit vmx_needs_pi_wakeup().

If there are no other issues in the series, I'll just fix this one up when
applying.
