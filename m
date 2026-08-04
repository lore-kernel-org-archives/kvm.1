Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EEB3ABD8D
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876913; cv=none; b=fdjEvG8kXxUu8xNsOrLDzWPx1U3GipIJtCFhGONzHrrWOHAgxwDKstmkMtp4xD2of483pC1WOWq5DOMjcrbADMpiFRf0dlhtvRYLtWYpDMYrqdkHQadawRRLZH6eCpOQmLp8mMUBjjXugDJrKj6KJPt/FpEHf0OHPx64n375jV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876913; c=relaxed/simple;
	bh=g+o8gB7pMI21jaPeXrS5CXSa4aCqgg+hPP/Bv4AMgBw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=knLtsWWuOqwr+GpQkfxlRZTs9APzXRsmrj+n6UyQSKHL6n6NigewxrcxYZZ3LHDB5sU886prTBPwQrnwCUNVIpJndPOMJGABMpzhrIfykj50UgEXsr+LrQhIg4VTBKJzmmVEYMpG2Hg+1RmKpdkimk7dnryGP3SXjredlm+yKzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gg1IsN6o; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gg1IsN6o"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso208978a91.3
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785876909; x=1786481709; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dMa1RhwjCziAD/afQGYLdZAGyHsDiMpWCqqVOHipENs=;
        b=gg1IsN6ocT45DhllYyFhZSTwnLJhS5fqmr3PFo2R9Z2fpcoT/UddwlAWiInKr44t2l
         HK8z7EJa6Oqd9Oyja1Pgy5KmHPxHTFfobQTUSYhJs/ZmZ9eSgItzD3SjKLXqIUrNMhqU
         BaXdrRovxoieT1tkdLR0vr6RM3lI7aD4fvIBHdoPUanlfbMXyQne3Rr74zzCr2Me+f5j
         0O+pUlRywdZ3Ifm5o1M0fdZ03/lNhRHEG4uaHGwf+Ty9OEYKFPQI+vlpz28N61XAnjfe
         BTG8A5fx+hmj2l+RJ9FxWO0h6UDuZQz/St0uihwMxktdVTToVzS+bfHRna78y5oY9/Sq
         O52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785876909; x=1786481709;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dMa1RhwjCziAD/afQGYLdZAGyHsDiMpWCqqVOHipENs=;
        b=Hh7SDBaOZ0GXgDNl+M6mM9+gdl742nm8YyDrtj79Eer0sS9FpFkZB1R9UyBoeVo/NL
         GFmaSAuRRQkmQjv9OBrsTzNUHKOs/YGl+E6QOnTVhZn4gStc0/81RdaLAVjUB8CNpzW3
         /ryf43ndoSctvPgA4boyvCQfUpJUNNVPR3OBUHlFI6VRR1vgiMvxrq1qdXw8kV8pCFJ0
         UeA2jboD311CKaA3PhWAZwLBNqVjU/2cQMMLfvgB9EWLqJMiWZ9FEspCduQ+tQ+n1j0h
         Soca/e6LF0r8bScFnGYqZnsrWm3ADzh1PBrEdEHAR5zdLQPtlbpSNwxbemJo+/KJpGJY
         FO8A==
X-Gm-Message-State: AOJu0Yxobnre4T9RdL88xanE6lfpdo35gfJSE6u5ULc8ThIGgQEHiGjY
	6MUcpGw4alzGVRKrfhTpcZDIljOX4cyzoVKApNnyKEDdCReLYTY5u4JHKe4/29qOOJ8Pj/03Dq7
	/navuXA==
X-Received: from pjboe8.prod.google.com ([2002:a17:90b:3948:b0:36b:7f07:6fcd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e53:b0:37f:a915:1c29
 with SMTP id 98e67ed59e1d1-3903c5f34c9mr1155260a91.19.1785876908942; Tue, 04
 Aug 2026 13:55:08 -0700 (PDT)
Date: Tue, 4 Aug 2026 13:55:08 -0700
In-Reply-To: <20260804205304.550701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804204048.3401810-1-seanjc@google.com> <20260804204048.3401810-3-seanjc@google.com>
 <20260804205304.550701F000E9@smtp.kernel.org>
Message-ID: <anJRrDb-gCfoNh_e@google.com>
Subject: Re: [PATCH v2 2/2] KVM: selftests: Create one VM with many vCPUs for
 each major PMU counters test
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 04, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> > +static struct kvm_vm *pmu_vm_create_with_vcpus(u32 nr_vcpus, void *guest_code,
> > +					       u8 pmu_version,
> > +					       u64 perf_capabilities,
> > +					       struct kvm_vcpu **__vcpus[])
> >  {
> > +	struct kvm_vcpu **vcpus = calloc(nr_vcpus, sizeof(struct kvm_vcpu));
> 
> [Severity: Low]
> Does this calloc() call allocate too much memory?

And I managed to send the v1 patches again, *sigh*.  At least Sashiko is consitent?
