Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC111FC8
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406681; cv=none; b=DEHKiZWYyjARad/8rA4IGwrq+26cp/eoCBA7zQMFeVn4v713FCnun4GPeqzFTKUuDTdX6X+2lzGxPysyVg1X0yti0nIvKuns3YQEtyFR4mYneozk4+eCe7DBUd914xG/aJuOYXDOoaXRsyCc1GnUrYO7s9HQ5MzIaMx0rUip2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406681; c=relaxed/simple;
	bh=HJBF+TSSzQd86uwj6B1uJ2YU+Qpc/TVCzBSZ0dPrIdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dKy5SG8tbIWnPPpD3vdmSxvof7260HboVI8kdHoG1T1XZSvd/D41RJeBrvT+YQOEE/txZQuILpAT5OWZ9WNOEWdrbQGNnAdmGq0YsGsHOBSckDHCV8Pv6z1nZXGac4hUHImXkkQX2rOYypWsjgowYcNKkxiT3wpU/MHOsrh6yFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GFq54sVZ; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFq54sVZ"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2caf4173b1cso50996015ad.3
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 17:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786406677; x=1787011477; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TWP8fni2Pj7QL+D72A3UzmdRtAr58m5dr4TKd83QRDo=;
        b=GFq54sVZWH4Ledu3F1dclRiZt05WQTjHbNMIEI2O/LGJ5ZAp2Idw+F4I+GzMDSD3y1
         QUBbZPfBf8DytUNBPpAJ8oG9/E+XYjPxv/SDa02s+dKyIPfTyP33vuBoIfqxcgz1V6fS
         FR9LdyLYPJyCkTl+ETCLKbIMihRJ4DuNHsDsrBGEEDy/ygMWMiXV9Yvy2LBMpY5e74qZ
         klZV8prTfhjrC0LjuJrNEbyd5xVNCk6SeRM2J7I6Dotfe16Ag8JRObxxQ+WKKSq09jzE
         uUI7XgnELTngpld29cjgfjSlWdF+YlH3LmWxIoV2baIamFmUcyZRDEhLhE+pa/FjA+Sn
         s+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786406677; x=1787011477;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TWP8fni2Pj7QL+D72A3UzmdRtAr58m5dr4TKd83QRDo=;
        b=UQd5nzYa+Qn9mOk/V5oFKDFtNVS/b4Hj7RBdXVxBEMlodhH/es43M/J5MAtRqrm75I
         8P8JnIuxYznDYhcusKLKpKldZs2Q02SrjCE9+AXF6KVCpbD/3utJSmoH1ZnrSDFYqw7E
         D7u+qcQH+Er0Y5RIMHIrQgwcn31f1QHoKifI297E8dnqNvYue6cAKSSq4tnO1J1axSXt
         XLLdG1NG4lK6Yz+FSbZankcoaQT74QtecyYQAZT+IGm+AH4gXjxcb0mQ8lXY5lQwuOpM
         mmrf5PdNwcxntLMJ9Pu3d6eK0pr52pBmiYaFkVK+nb4uzNnsIoILT1IdZGGuoGq6mMIE
         EyVQ==
X-Forwarded-Encrypted: i=1; AHgh+RryLfYOJA4vs8t0HhguMl5oyzk0e5edmxQ3/wQ6it4UzinLPRBO0eLjRdGdz5zz866Vwb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHP9vHfFIB2GJeDOzKN9mdQpLD4J1NEku/cb587LLXHjlA7VXF
	quI4yWgPZBstDXx/r4XJGLbEhdslCFf8mVFQ25MMm+gnHvlhf+HjnieWhum2hHj63lcq2yq3Tj5
	JTBofug==
X-Received: from plcb3.prod.google.com ([2002:a17:902:d303:b0:2ce:d2e2:393])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b26:b0:2cf:ccc2:6088
 with SMTP id d9443c01a7336-2d294b29193mr358218035ad.4.1786406677170; Mon, 10
 Aug 2026 17:04:37 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:04:36 -0700
In-Reply-To: <anplcWfYReCMeu1A@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
 <20260810112200.2326727-3-xiaoyao.li@intel.com> <20260810113924.4ACBE1F000E9@smtp.kernel.org>
 <13ea6279-a342-493b-a0f8-15ac5b4c59ad@intel.com> <anplcWfYReCMeu1A@google.com>
Message-ID: <anpnFAK6EZToizbZ@google.com>
Subject: Re: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 10, 2026, Sean Christopherson wrote:
> On Mon, Aug 10, 2026, Xiaoyao Li wrote:
> > On 8/10/2026 7:39 PM, sashiko-bot@kernel.org wrote:
> > > > @@ -2147,7 +2156,7 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
> > > >   	struct vcpu_tdx *tdx = to_tdx(vcpu);
> > > >   	*reason = tdx->vt.exit_reason.full;
> > > > -	if (*reason != -1u) {
> > > > +	if (tdx->vt.exit_reason.basic != -1) {
> > > [Severity: Medium]
> > > Will this check always evaluate to true due to C integer promotion rules?
> > > 
> > > The basic field in union vmx_exit_reason is a 16-bit unsigned bitfield. When
> > > comparing it to -1, the unsigned 16-bit value is promoted to a signed 32-bit
> > > integer. If the value was set to -1 (65535), the comparison evaluates as
> > > 65535 != -1, which is always true.
> > > 
> > 
> > Well, how about something below on top of this patch?
> 
> No, we need to not rely on magic exit_reason.basic values.  Can't this be?
> 
> 	if ((tdx->vp_enter_ret & TDX_SW_ERROR) != TDX_SW_ERROR) {

This would arguably be a bug fix as well, because the "real" EXIT_REASON_EPT_MISCONFIG
path gets a false negative.  E.g. when getting information for an EPT Misconfig
for the tracepoint, KVM really should print all information, not zeros.

At a glance, this exact change can probably be a separate patch too.

> 		<read values>
> 	} else {
> 		<zero values>
> 	}
> 
> We'd need to use the unsafe version if we go with my suggestion[*], but other
> than that wrinkle, the above seems like the obviously correct fix (maybe too
> obvious)?
> 
> [*] https://lore.kernel.org/all/anXxBzO41_5eaaOI@google.com
