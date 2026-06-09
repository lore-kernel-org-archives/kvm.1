Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9088414ABE
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780964966; cv=none; b=A9n3/nVwSIdZjlcgT9da8l9sF6cTIiH4MZtkLNWjzBog150BB6vUAn3KB34T3WCKv/Bsv0uOdGOn835ZYQsNrXQ8bhduehSnE36Nv/3+cZvIro5X2P+k5IuacCKjUkd3MAEOmXPAGSepzK89ydgSD/Rr5nGKy24/1tTiAppzJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780964966; c=relaxed/simple;
	bh=okCLjjcx6Ed0kcVEOGQC7olTqLps3Bv3+utUO7Z5QBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lUjwlp1O38xk3UcduFZ/YrHc4ZQeyy2s1xLK+zr0dUJXvKwCzB78rIt1WS7HVxMK/F0bgfYqnqxy0SUYUzYJkbr2ZUh+h/l5+v9czj29y2Ib4im9R1+lAjb34QkK1+UGv2ZEy5g4RjxzoW+NUPPVtF9jUEyMiVJeV6NPKtywI0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DwyHuGox; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwyHuGox"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8428419982eso4163597b3a.3
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 17:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780964964; x=1781569764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7x3B1HPEV4Wpd1aCcBTxaYdKxkJL89lmWQlqj4XB55Y=;
        b=DwyHuGoxoP4V91Seaq3cQo9RaGlA4kh2ma+QPTeYHMJxcrNoA8bnlo6Lvnsc2f0Ly6
         rf9AYAszdcIBmXUHnEU+ac0+v7W7LzfRdKK74vEcH8uQX+7vpTpcvtVquMId47oCRIkL
         2iZgKQGivDJ/kq3gw8GPFCIK25Z0HwwXM/cZsK3xEKPtJo7gbaiBadg+Ei7VC5zOmSlw
         Qb8rNt/fMgKpTXJfMP1pscN4q41iNdusZ3ZNDSEXRlMNNF0MG1O2epH9y4UrUrNOXs06
         TJa9O3Ba0tit9HADdLVFNyFrxuINsVFjBIyafXCmOv3SZs3pTia1rXT6SfhjvGKfn640
         i+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780964964; x=1781569764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7x3B1HPEV4Wpd1aCcBTxaYdKxkJL89lmWQlqj4XB55Y=;
        b=JYAkYxSacAHAb54VVKntcLnPlEXlZp1vl9FpLhTdkZ7FPbm4T/Fsc09zBbgcyp2kgj
         YuayBA8q0BfBmklEQKtmL7gyFIqsMfS3+eYlksrCX1ZeWvEIaVqFKM12RiUe9F40w+TF
         VguGq1zxvo1856AyYxtJHXqB7Z36Rcv8kL79ZhwbKqVuPJQznx0j5lWXcSKI0fjP5kbG
         R2e39OboCksm8dWxsRfrfLWempAROQ0mSbwb98HP9JMDA5VWoyhesLvC9NB6u9R0pqF1
         SMv9OzESWQwdbcaUM4hxd3ZyiI8bFf85Sgz6+YUtSOjnX+OsOJPyrR5uot7JmSJyrDsR
         UfJA==
X-Gm-Message-State: AOJu0YyR9CHF8ORXAllDETSH9F0K6uFtATkfr4bWXGwMLgjEgAv02jQO
	MhZjEhsYSKphmfWPz1i/5JenjFN0c/6r3QDPZWNTlGOGIvUceqrxj9rvaYvf9QsVbJCwmYFcp8t
	up3SJtw==
X-Received: from pffy10.prod.google.com ([2002:aa7:93ca:0:b0:838:ec6d:449c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:90a7:b0:842:3aee:12c1
 with SMTP id d2e1a72fcca58-842b0e8312bmr17335107b3a.18.1780964963660; Mon, 08
 Jun 2026 17:29:23 -0700 (PDT)
Date: Mon, 8 Jun 2026 17:29:22 -0700
In-Reply-To: <20260530063531.D034A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-22-seanjc@google.com> <20260530063531.D034A1F00898@smtp.kernel.org>
Message-ID: <aideYkFmpELRfcX5@google.com>
Subject: Re: [PATCH v4 21/47] x86/xen: Obtain TSC frequency from CPUID if present
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, May 30, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
> > index 487ad838c4418..36d66abf53796 100644
> > --- a/arch/x86/xen/time.c
> > +++ b/arch/x86/xen/time.c
> > @@ -42,6 +42,17 @@ static unsigned int __init xen_tsc_khz(void)
> >  {
> >  	struct pvclock_vcpu_time_info *info =
> >  		&HYPERVISOR_shared_info->vcpu_info[0].time;
> > +	u32 base = xen_cpuid_base();
> > +	u32 eax, ebx, ecx, edx;
> > +
> > +	/*
> > +	 * If Xen provides the guest TSC frequency directly in CPUID
> > +	 * (leaf 3, sub-leaf 0, ECX), use that instead of reverse-
> > +	 * calculating from the pvclock mul/shift.
> > +	 */
> > +	cpuid_count(base + 3, 0, &eax, &ebx, &ecx, &edx);
> > +	if (ecx)
> > +		return ecx;
> 
> [Severity: High]
> Is it possible for the hypervisor to support a maximum leaf of base + 2,
> resulting in an out-of-bounds CPUID query here?
> 
> Looking at xen_cpuid_base(), it calls cpuid_base_hypervisor(XEN_SIGNATURE, 2)
> which only guarantees that the hypervisor supports up to leaf base + 2.
> 
> If the hypervisor does not support base + 3, this CPUID query could be out
> of bounds. Processors handling out-of-bounds CPUID requests typically return
> data from the maximum basic leaf.

Heh, depends on the hypervisor.  This quirk is specific to Intel CPUs, and so
KVM emulates this behavior only when the advertised vCPU vendor is Intel.

Anyways, AFAICT, Sashiko is right to be skeptical, I don't see anything obvious
that guarantees +3 will be supported.

David, can you send this as a standalone patch, and either address Sashiko's
concern or add a blurb/comment explaining why it's safe?  Unlike the KVM changes,
this won't conflict with any of the other changes in this series.  So while it's
themetatically very related to this series, in practice it can go in separately,
and I'd strongly prefer to let the Xen folks handle this one.
