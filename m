Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5593FF882
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 23:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406259; cv=none; b=UBmJ3qO3SUgwZBk+orM2HQ5Z4Yk2wAgJ2+Xa2qhcPWhv/1cSEkRLAFZVGrUpDxs0iwWTvtCc3c3MA5P4vihGmmDoFDHMyEu8l+G4Oq26h24EJGfEXgwBCDeyQ+Yi0m2aqekCqNbhvCNMzZ2pkxEw7tTFP+RGvvokCVltcwZc7YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406259; c=relaxed/simple;
	bh=4BupJwdVyL6umlPiGYOwer+ZhuGrupEyMF3dhJCrF+k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=otzJg7AdrmPRnJtnW1Dji+da9529q556Hg/JxisLgCt7E0/nyPqilUdPQBSMUjYcHtigon2yIgaFoFGqSxeWZlG/b9FcwVDY6aC29ZsGej5SPrRZ5xUBR49B8963rXKPBpRE/ujYGEt6XvLqQMdoAjd1Hzafge1n3hqD2X2JlH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GS3Snx1d; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GS3Snx1d"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so1690603a12.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 16:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786406258; x=1787011058; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PeZGsgiDsMXG6LZQ2iDpLtip3LMl/NmxKydR78skp+E=;
        b=GS3Snx1dsJqL2R28OlzooZaplJnTENZJaw02R8RzvToEHMYc3WOsXOxINxT/tDgeE7
         Wdqm/wyMr0l6aIkC8moFbTyh3iJWsWDXVzbWfyf2H2X/lzHVfOQ02W0czmIVD/BZdE+e
         dmifoc5KiUqz2H4mNdCcK0kHy4hBd9jwWL4mbCkh230PM+kvwGkrKw1OLpfAHxdaROCJ
         a7G39etvQhtaGSBsKcc0xUpEQm00j4sy6Jz+dbEpHi5I0LZ5555HylYPOz7AkzJ4iUAQ
         IR/U+6oxDkqAogt0UY4BXKysn1ucn2B2wHYcONP37CZhuIs7oN3w7hjY9R30UsP/8d/F
         FTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786406258; x=1787011058;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PeZGsgiDsMXG6LZQ2iDpLtip3LMl/NmxKydR78skp+E=;
        b=StRPbQClPBI9Pdlvo8nItLT1eGQ6ipLSxhbNVYcVqv5ucHlxWcdyn054eCR4F+Mkau
         NuK/rbXX9ToHN+7tvREa/+TfyvSh9KGf+c+NrCCtHBZtugaWm5D7XF0edPXHQMwQpdQv
         7Jr3n6yV0LTxRnbC0CLlxon9hp6h/HTvuz3h1yeikiZD+zIEU72xBC5umcGXJHhnvmP4
         FTbAq10XvzVvJwGOajg8hxtfalo5420c0OU7K4XzTXXP7Srsw7hnmrMrtCmJEM/nCR1Q
         PTBajV8QmozdiKf8BXuL8brfkLlCYqMdqtJraspUx4n1aBMhJIS77Q0DrvbwI4zs7VDM
         uSYw==
X-Forwarded-Encrypted: i=1; AHgh+RrN2ZOpdFA+94H+TIq5iFzEjRT/3g2l14+qF8pvbQxonLX0Y7RkqOp9YfrgPrigenPKV5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsSIsy12fsB5FwgbqYiJwh2ed4tiRSNO59t0nirg/lWixOlISZ
	La5zYF0FurnYhKkPsEWFE3QBcuPAipznpQh1kLP4uTwi4DmnGNIFGWFZSGCsF6TUb3t0Nmd9Xk+
	REKXhmA==
X-Received: from pgdi6.prod.google.com ([2002:a05:6a02:51e6:b0:c99:aff5:707d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e598:b0:3c3:93ce:663
 with SMTP id adf61e73a8af0-3cc1a35367cmr6912795637.26.1786406257898; Mon, 10
 Aug 2026 16:57:37 -0700 (PDT)
Date: Mon, 10 Aug 2026 16:57:37 -0700
In-Reply-To: <13ea6279-a342-493b-a0f8-15ac5b4c59ad@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
 <20260810112200.2326727-3-xiaoyao.li@intel.com> <20260810113924.4ACBE1F000E9@smtp.kernel.org>
 <13ea6279-a342-493b-a0f8-15ac5b4c59ad@intel.com>
Message-ID: <anplcWfYReCMeu1A@google.com>
Subject: Re: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 10, 2026, Xiaoyao Li wrote:
> On 8/10/2026 7:39 PM, sashiko-bot@kernel.org wrote:
> > > @@ -2147,7 +2156,7 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
> > >   	struct vcpu_tdx *tdx = to_tdx(vcpu);
> > >   	*reason = tdx->vt.exit_reason.full;
> > > -	if (*reason != -1u) {
> > > +	if (tdx->vt.exit_reason.basic != -1) {
> > [Severity: Medium]
> > Will this check always evaluate to true due to C integer promotion rules?
> > 
> > The basic field in union vmx_exit_reason is a 16-bit unsigned bitfield. When
> > comparing it to -1, the unsigned 16-bit value is promoted to a signed 32-bit
> > integer. If the value was set to -1 (65535), the comparison evaluates as
> > 65535 != -1, which is always true.
> > 
> 
> Well, how about something below on top of this patch?

No, we need to not rely on magic exit_reason.basic values.  Can't this be?

	if ((tdx->vp_enter_ret & TDX_SW_ERROR) != TDX_SW_ERROR) {
		<read values>
	} else {
		<zero values>
	}

We'd need to use the unsafe version if we go with my suggestion[*], but other
than that wrinkle, the above seems like the obviously correct fix (maybe too
obvious)?

[*] https://lore.kernel.org/all/anXxBzO41_5eaaOI@google.com
