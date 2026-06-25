Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68850175A77
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782430216; cv=none; b=DJ/NbKJsijmfmCirEAPtR918/PvsM78aO/CYZLAPOGNj4sW6XEB+CMHcTt4hxpa0vsc2e0pDCuG6QVOu1rb2D/tJKky0Dy8IdkRrelmqDFmbS+G0UV3iWKgKheD+pxvweQGXPXXhWFKagZobOvmpkV0LDr5mPN4289NnjKCQF7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782430216; c=relaxed/simple;
	bh=IfEIqXCsLoXuFEdY+/Zoq37zzPSKcssM5p8qVcbSjI8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c4k4TsIBwWwMseJKdj2D15dLR+9O18I+8yLkaq+vaq7GaeIMQ4SJWz63ZeIFsRhAqhT+RDPQcKGhnxQuIpyQwrQefe3Mq0Vq34rLUQS7GOHs6n7e/l7en2ICDRJJRGqzPkt4YPSZeDdx6UCI2dNDNh2falOtLVnhBNWKWg5Om0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UBW8Qqw6; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UBW8Qqw6"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c6a20348ceso3382265ad.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 16:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782430214; x=1783035014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0iCbOfMxhRIrrW6aDycaUikl9zPdDsZys9Ta85uI08=;
        b=UBW8Qqw6AUWFgPKNUbyZ3Kl+EAKgGH4YXoeaE16IOdIc36zFh4CnGE60/dp/tE5YZm
         JszW5cLcWkei+19kBBAqv2zIIecG106TfRZ+Tg8lLUhtJKJ9CWfthnW4asyb4QIgeLJ1
         mptjXD5LTbmzgq3M1/oTVAglK3ue0LEWIANKj6s4tJJ9uwYDMr4C6k3war0yEaTOVwMy
         5qb4EK6kWZzHb2K6eBHCjRGN4C3TjZs0d8GouD2o87VTaIeznGxxfZ/+1+8RSNXiTIeo
         JRAWfzTwfmhZECXuvgsuoGPYYdll8nqSPLn019HPBzekRURy9vcFDtrT7cSRsUWYfsFk
         dSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782430214; x=1783035014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0iCbOfMxhRIrrW6aDycaUikl9zPdDsZys9Ta85uI08=;
        b=W8sGIN5/mT+8ustz2VEKWPcQ3mXF/RRvzGbai88NpB/wPKh/fR0106/vxsHfhnH0Sx
         GV9XJTlCQz9lwwdWlGJa/U7eoJd6SVwI1RLbSo+IL7DK1xjDKMv872oyav28vf39Og3r
         MQLYWAEnLMno6BunVBEXAh1Br0RI7dvVsTfM/rc1KYZDK1lWOGzgib3HkmgMFmEdlNVE
         Xl8Bn2KWGiSZ5CqDuJt0buWwJ8KcxxNc4b+9e6DvbV9GscNJlD6QsnCz3ANDLRfrtsct
         9r8UTpAUfSPZx4Bc+fVDyYmUKGlnPee/9GF+XQaLICgPae2Dki7vP8O02nGTjBotafJZ
         g59g==
X-Gm-Message-State: AOJu0YyoPxog83tk+GKL+DheIhXU8N+3JJ4DbYNvO1wI682qTf/fzMlQ
	7VonmEpG1ioKXZvXOn1bD2EHZVRTs4ayB2rLpXcFujDpcCdoGLPzq7AVMJtHEBEFt5/AOpmEVNz
	LdJWJcw==
X-Received: from pghq13.prod.google.com ([2002:a63:e20d:0:b0:c89:2a8b:ceb1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1811:b0:36a:4074:9aa6
 with SMTP id 98e67ed59e1d1-37dfa1bc635mr3987840a91.6.1782430214316; Thu, 25
 Jun 2026 16:30:14 -0700 (PDT)
Date: Thu, 25 Jun 2026 16:30:13 -0700
In-Reply-To: <20260625224325.BE8ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625223623.3376478-1-seanjc@google.com> <20260625223623.3376478-6-seanjc@google.com>
 <20260625224325.BE8ED1F000E9@smtp.kernel.org>
Message-ID: <aj26BTEWjOs7D1kB@google.com>
Subject: Re: [PATCH v3 05/10] KVM: x86/xen: Consolidate checks on Xen vCPU ID
 for singleshot timer hypercalls
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 25, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> > --- a/arch/x86/kvm/xen.c
> > +++ b/arch/x86/kvm/xen.c
> > @@ -1614,13 +1614,13 @@ static bool kvm_xen_hcall_vcpu_op(struct kvm_vcpu *vcpu, bool longmode, int cmd,
> >  	if (vcpu->arch.xen.vcpu_id == XEN_VCPU_ID_INVALID)
> >  		return false;
> >  
> > +	if (vcpu->arch.xen.vcpu_id != vcpu_id) {
> > +		*r = -EINVAL;
> > +		return true;
> > +	}
> > +
> 
> [Severity: High]
> Does hoisting this check unintentionally reject cross-vCPU commands that should
> be delegated to userspace?

Gah, I misread the "default" case.
