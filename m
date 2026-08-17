Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8873B3911DC
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977621; cv=none; b=rsLR9Z64VolNZsm0m5KEi3Eypef1dHx8E0/MMGJbBt+O9VYugfjFQi0iFKvl63cTLWPrGjzkTduw5HrGj8FL2spU0vzYzVEgDI3fn/fMWJY7cl7ZR2n1SrQJ+F/MVTu9L1IhziwOKzBRm6jD+aIFnf8r7AOF0AxtzmlPeJ/qBao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977621; c=relaxed/simple;
	bh=BKbAteaIvoUnCSXoPLUI9QcirR61Y1LXiKKwgIeZhGo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WEKtwwYgua/XqFTxpI0dyAK43vCT/Xn+kPc/OmyiHtTlnB6b/mg4i0lD+aseUItXNcMJsMSGLcUvAcZBAfFtPAmiErFeaPrMHV7tNb23Vimfc2dMxDzlqiA/P7Lm9j7F51jbHcsg2eCOVN6/W/AMXnAKRt8WYq+AQ9bBMjsKI9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eeaFQp2f; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eeaFQp2f"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbedc1899f7so2117947a12.2
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 07:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786977620; x=1787582420; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9IH0lo1bFdHzW2syXivjvclsZvDFjSreF20fjNdSZC4=;
        b=eeaFQp2fvSKr/oL30f62FC5g9471K3fBmkdv3aRsnexg3BZsnJZ1TqcyI3T7K2bYxE
         966h8zxHeCqdAD4gF4nXxoeTJ2AE33GWqy/9DLft+S3Nc6fDLHODrlQReNhWFW2wG7k9
         HDJ31CIm07ZILgi8d1rrLYT57g0uaup3PHG53CAoK4vRUlm1gBlFzNURAE7aGHL6QELe
         AFOzM26fk+OSS15uQUlKE16jUKaEJW85qCxhIvjB6YsPk+gLpNeAhKTbmE8iEwxg1X1b
         5G4pTGHeTgEBVOwMcOa0wQg5qJ0rNyoOlJTuDrAAzCYAW+1Px00dfTF1odCkOCNn0+xR
         lwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786977620; x=1787582420;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9IH0lo1bFdHzW2syXivjvclsZvDFjSreF20fjNdSZC4=;
        b=p/VcmHKM1PZ0HWaISrthWrHGiZRROCRkkNHw4i388T/mafdyBfabICtkQjEnKXz6Zh
         xZJGdnbqEoTCHje8Dp13CSZFPMnz0lcx+bcPXC01fxZ3NfB9FPQEt4dfeNMhqFUB7MNO
         F0QJ37aukCQ9iOwXqqrbZq/5scxlIKcr/nj7g9YDGuIlAGc7XtFGXc+nwfCX5yLii76j
         xW61NJPGTENqnGA4PISJKay5rPfcMBFttn+VJttB2UCIP2bXecUksc2vFs2BXW0yOgOK
         mKmTdklB1kFxbIN5pPsCcEsx7ufA1nh2toHnvlM2cNcOJhrJe5rH2Y2LQgR5AmmboxbG
         fivA==
X-Forwarded-Encrypted: i=1; AHgh+RpW1fALyE+7wFs8OkUNEx7Gy0n+NRNBaNupjJ78g/mG9VDklTYidv2LWR1he/iVUc6r6Es=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGarcOfs0N15ilF1yDH0eUodngW9RLrc7jtLOnNWigxfe65MOl
	/P8+NPOkyMkXMWTqUPa8poHG+7QXpNScB2nDs35foVrXUZ5c4+ZbqDWp1lEbf0B/St9jBsa0SPP
	6Dq2PKA==
X-Received: from plri4.prod.google.com ([2002:a17:903:32c4:b0:2bc:838b:f23e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da84:b0:2c9:b8b7:5d27
 with SMTP id d9443c01a7336-2d3b0d78697mr246855035ad.1.1786977619599; Mon, 17
 Aug 2026 07:40:19 -0700 (PDT)
Date: Mon, 17 Aug 2026 07:40:18 -0700
In-Reply-To: <d28ebb09666f7188d0390fb7f877c5584991ef3c.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812213206.1564354-1-seanjc@google.com> <2c501584d34eea17016d39c9a5f78ca3d60861b4.camel@infradead.org>
 <CABgObfanoHLfdfNshuLCHkWgtsP5Km9G5WsdwfGBcLsJ_LKD8A@mail.gmail.com> <d28ebb09666f7188d0390fb7f877c5584991ef3c.camel@infradead.org>
Message-ID: <aoMdUlCCvYqdw91B@google.com>
Subject: Re: [GIT PULL] KVM: x86 pull requests for 7.3
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm <kvm@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 15, 2026, David Woodhouse wrote:
> On Sat, 2026-08-15 at 09:55 +0200, Paolo Bonzini wrote:
> > Il ven 14 ago 2026, 21:25 David Woodhouse <dwmw2@infradead.org> ha scritto:
> > > 
> > > This was intended as the safe stable bugfix part, split out from all
> > > the RCU and rwlock RT fun that can come later:
> > > 
> > > https://lore.kernel.org/all/20260811094829.98794-1-dwmw2@infradead.org/
> > 
> > Ok, I will take a look.
> 
> Thanks. Although that nudge was directed more at Sean than you.
> 
> I wouldn't necessarily want it to go forward *without* Sean's ack, but
> those commits were deliberately split out as the ones I genuinely
> believe to be simple uncontroversial fixes, with the fun stuff held
> back for later. A couple of these ones are even actually Sean's.

Those changes are very much on my radar, the latest version simply came in too
late for 7.3.
