Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03EA1A5B84
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775172079; cv=none; b=lk8MnaJ8IiMNt+/2pYvCrQCCfqejkR0RwBZabUg45oNaJ1EhShIFqWelTAa8ux/xtlB1p6PtHM0fDnK0uTjCsqk7conv7YDiBofl5hX1ViPCPTJPySzIHvMoyQLsMuZ72YGs38oMgD42+R6WKmzqKuhhpmxGmYbiVleaAfVSjQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775172079; c=relaxed/simple;
	bh=HZKn1/iZk8Yp0AQ+vpilGXEbk26OuOCFBIlDg5i8M/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nNzoPl3qpB6t6cqZF6TFb40xm3iZ/tcsgXkObImPwmptuaRqlmCXoTYmf7fXKb0kl3qYnKVBI1kukzMSphy+C6R77d2T3rWH9HaqCbp2C5m2hCzxYVoSUvUJQ9kGisZ/ElOEAfWwHENLuT6FV2vG6AhLLkocAzJ5Gnvy5waGdHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sY97++eJ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sY97++eJ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c709551ec08so2028172a12.3
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 16:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775172078; x=1775776878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8wYMUpk8miCEE7Vxr9WT773E0pmPesh1JyoxjfZa0E=;
        b=sY97++eJhwYeBgRq6AxmG2TmYVna9xiMq/ItohGfRdgva1IvCzFkFg++kvLEWbVllF
         Ss5B4gVPrJyUDzmn+kWqO6DA83h0DxdeI/LwH/YCy1yMuzE9VJBuE8uWhbfmqP36eoP3
         ZNg7ECtEpt2iyFVSaKgKUobi+zL1ta8RQnBIPrH9RC0a4RcjWop7CjjVw2JCQGns3aDY
         aPdpP5TnCog43LDzfov7GYTVycfITy/6e1LhiFScwXG0n6cMPC2xaetfItML4BsB5au5
         V2u/4pzbSAW//iVEsPku1iqxsDyNq+WTlb+SDVybnGB+Tkwn9x+s4WxPJDb7qYcOSxA0
         y9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775172078; x=1775776878;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v8wYMUpk8miCEE7Vxr9WT773E0pmPesh1JyoxjfZa0E=;
        b=ZACX5ny/p1ILJhSzusSYuO5SZZDdF+axe9liPz6egPPFj8ld9yohboz7kJ77bHJyWP
         0SKRnEBLXUl4VOl7YGElH6wRjzny5/J+KmrS0fpBHI8ydE/jc0Bk+KQrndKhFHERH7Cx
         3cqdj6+yEBc0vj7/A6K5XYHwqjgVZhUo+yOaSrDleHALXGWT0pn1CyBtF5lV9onNEF/c
         Qp/eNJvOuyFDH5rcOI0P5OJMQ8ZXMMRsPoZFALFGRtpbxEpchpd0p0ywlIqy5KRL+6Cf
         OFZREj3uvP+LuX/4zklb6L4grupZlu/895IZnAHFXQjpeB3XshLUasBxSiGXG0eNvsrH
         w55A==
X-Gm-Message-State: AOJu0YyBkXabwEYPo47tNzFWAXvAcRH9xjVEcLYd1PLX3HkyFwKjKpHc
	rFPXrxuVmusfh4INIuW1x7QnBvZyOpxloEuSDnzL0WirOuVatfpXbZOh1g5y1LOaJTypSSZCGeY
	z+ltv+w==
X-Received: from pfbji4.prod.google.com ([2002:a05:6a00:8f04:b0:829:9111:d582])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:124e:b0:82a:7758:1416
 with SMTP id d2e1a72fcca58-82d0da504d0mr838663b3a.12.1775172077817; Thu, 02
 Apr 2026 16:21:17 -0700 (PDT)
Date: Thu, 2 Apr 2026 16:21:16 -0700
In-Reply-To: <af52f6122e158c8804ff8661e979101079c4caab.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-8-rick.p.edgecombe@intel.com> <63caca29904f7d7d657ed54f71be1e066b422a9c.camel@intel.com>
 <af52f6122e158c8804ff8661e979101079c4caab.camel@intel.com>
Message-ID: <ac757FsJ47aOFIGQ@google.com>
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kas@kernel.org" <kas@kernel.org>, Kai Huang <kai.huang@intel.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	Dave Hansen <dave.hansen@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2026, Rick P Edgecombe wrote:
> On Tue, 2026-03-31 at 10:09 +0000, Huang, Kai wrote:
> > > @@ -1373,6 +1396,9 @@ static void kvm_tdp_mmu_age_spte(struct kvm *kv=
m,
> > > struct tdp_iter *iter)
> > > =C2=A0 {
> > > =C2=A0=C2=A0	u64 new_spte;
> > > =C2=A0=20
> > > +	if (WARN_ON_ONCE(is_mirror_sptep(iter->sptep)))
> > > +		return;
> > > +
> > > =C2=A0=C2=A0	if (spte_ad_enabled(iter->old_spte)) {
> > > =C2=A0=C2=A0		iter->old_spte =3D tdp_mmu_clear_spte_bits_atomic(iter-
> > > >sptep,
> > > =C2=A0=C2=A0								shadow_acce
> > > ssed_mask);
> >=20
> > AFAICT this chunk isn't related to "Centralize updates to present exter=
nal
> > PTEs"?=C2=A0 Should it be in a separate patch?
>=20
> It was because we lose warning coverage in this patch for the aging case.=
 Though
> the diff was from Sean. But my take was this just maintains coverage that
> already existed.

Yep, exactly.
