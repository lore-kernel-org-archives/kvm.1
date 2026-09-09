Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C553D0AA
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952829; cv=none; b=p1Aqlcq775AtI6gJRYxP6E/wa5ioa/syiFwQfmSobFVHmXAFpNbAhplZwiccYi2+SsLsOrYt/zEd5sufqeLWya01kWbDPd3mdDtzwCX2upYoy7TWsydzDwvszDuz5xojBOamJyazUFg+juy4ZIJAntdo8ruq6boHTosz0X1SEGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952829; c=relaxed/simple;
	bh=5Q/vvAB3A+xmpW8PsWe81/gJjZnGlsRbfXtGXCimwXg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RR845RsFOjyTHsI8wuJqHakr82epoTM12HNLzrImPNkux1N226f5Pbh9h6H+7k97a08pPJv7bcv3cilvGOnkg/RhhRoutq5I/YihLTAXrXWjxvZHlnkhbaKbWk1ygjCFGGGcE5+RFTbSNW6e6DcQSom12fDBgucfvW8htpGAs04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQ/2S7GP; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQ/2S7GP"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c262204cc80so643611466b.3
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 04:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788952825; x=1789557625; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YBZKUSZ0VD01VN+cYqFceJjTBk/QFvaL2IDQDKE/sTw=;
        b=JQ/2S7GP+hDU3W66h2CAdtkGr58rwpW6rfeHqlwSQECgO2ecBbLgbS0BB+0oOZuWDF
         dmlqVz2c7GVFb2ZuBcY1kxhSrAimqNU1k9Nc6K1QcDaz/bhSao4eAUqhcu3l/aq4AeCh
         XRaHhJkwfD4Pc1PbCYJGp+vQQkHKEfkkZJRKyfej+PJClfSNTCnk/Bb4QAd4QvxG8VcM
         SG5SDD2w+MnErCwG3AIALF/eeZ3e5xOW0LoS1gik/grsma34TGwWohMuwC+cy3ISC2av
         +RAHVTLMG4v76FwQgCjdehPV526lYCbXXqXd0ObLMTYfTpZcvqBtz9X/BB1Kf4/IX48L
         7B7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788952825; x=1789557625;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YBZKUSZ0VD01VN+cYqFceJjTBk/QFvaL2IDQDKE/sTw=;
        b=TWZyMLFxPZEueWUs4XNbIH942Zk3G7hdNzNyDe9U/9NlZClYpc49WZgdi+k27umnMC
         9n5pZ+UwcE6inoP61hnyVvmnKcuNWXkCCK8KJm41tr1Xffg7MODrfRVar3UcYVYl8tzM
         LgBFIguxqQBPpmcPvwxa+FLTkWTmChKAlEmwTRiP8lMl6PasI5n8BFTTvMStM1lN34/4
         l6AnrbU7xC7khfhHQM00LXrgP2bbfwRd3/2wqZ9RGvJDrtZCDgB11c+xFdiYYLA2zEL7
         isPMyTePBQHl0M4UxMBprQGDIZG7EdYTJQVanFldhA+MsytFaEFiAAlFzHnjMA8sNfYr
         jAQQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvBHyR5cspl7CVf+tANprzR58a6Uwz8nBjia4uogAdQER3ZbNaodRLX8MMednx0dNLYbI=@vger.kernel.org
X-Gm-Message-State: AFuF++lpkwv0+ezW2lV30pIBjFY+VlgaDj/Y4AvF1n5Ud/TciLnINfiP
	VWp+ZD7sdz+871aibVb+BP7otlSAXp1t5JrzHzgbwCA9081gsQzGdM02
X-Gm-Gg: AYBFou2PoUfe5Fv4/ImWe9Ammdt7gaokh0/4KRogZRqU9o3xHtU5oW5WxgfLPp7zp0i
	bNZg8Sw0+5IaVgvk2KGloBi8sYICH16Tq0fFlvBTnHavy9TB0Tgi2GkbQqb60ntkQ8jdbu+VF9q
	6xDllPNoIYMP4RvZhwVn+Ck4y5hQUj5uVB5hjlo6IkKPVL6maDi0g/VkMGGNRmDBwo9g+AfzyHx
	HG+qVo4g8XaY0DtwJYkFkcJAnH0j++XzN1QiuuhX0spuBfCKQxJRNDjweydPcSC3kioZdiEOum0
	BBkUBWDbETcg6So5Ottu65x8UKUhHsNnyc43Ql2X4SYDDNCp9yjh1NaOEptQJ5mXy6MUWiZ/CGt
	phaiOJX1ZF+k/jqVej8ULHeh9rvOjJAwVu5pWjgOPsT3NtRJufY0uuIAjXLxJIkqV2SDtpR3nvU
	U3oM1SoQ3Rc+fU3ugK409KbxGXsXsU0pKXBSXhCTAfNYXTkxuKsSLhNLFOU1/K0Y7FL9EnHJu8M
	dRyvf9yZfDy
X-Received: by 2002:a17:907:c650:20b0:c29:386c:58df with SMTP id a640c23a62f3a-c29386c6021mr64783866b.30.1788952824981;
        Wed, 09 Sep 2026 04:20:24 -0700 (PDT)
Received: from [10.245.244.251] ([134.191.227.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d559364sm743480066b.35.2026.09.09.04.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 04:20:24 -0700 (PDT)
Message-ID: <b227e4b40c45b090eee627e6a4d8f314297996ff.camel@gmail.com>
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Binbin Wu <binbin.wu@linux.intel.com>, "Edgecombe, Rick P"	
 <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>
Cc: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com"
 <seanjc@google.com>,  "dave.hansen@linux.intel.com"	
 <dave.hansen@linux.intel.com>, "kas@kernel.org" <kas@kernel.org>, "Li,
 Xiaoyao"	 <xiaoyao.li@intel.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>,  "andrew.cooper3@citrix.com"	
 <andrew.cooper3@citrix.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>
Date: Wed, 09 Sep 2026 14:20:21 +0300
In-Reply-To: <473c5507-045f-454c-b6d1-76d2a390f413@linux.intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
	 <32b51faabf60f6e87d9fdebbf2c3fe5a45fbff1c.camel@gmail.com>
	 <58c185c82658819454a9950f37c6424226a098bb.camel@intel.com>
	 <5faff363852572d59e34c876173d73c93734bd3c.camel@gmail.com>
	 <473c5507-045f-454c-b6d1-76d2a390f413@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-09 at 16:48 +0800, Binbin Wu wrote:
> > VMX:
> >   VM entry =3D load guest state from guest-state area
> >   VM exit  =3D save guest state into guest-state area,
> >              load host state from host-state area
> >=20
> > TDX:
> >   SEAMCALL =3D save host state into SEAM VMCS guest-state area,
> >              load module state from SEAM VMCS host-state area
> >   SEAMRET  =3D restore host state from SEAM VMCS guest-state area
> >=20
> > I may be reading the SDM wrong, let me know.
>=20
> That's my understanding too.

Good, thanks for confirming.

> >=20
> > So there are differences, and I was hoping to:
> > - Be corrected if I misinterpret the SDM and how things work.
> > - Get comments on whether the proposal took this into account.
> > - Get comments on how this affects, or does not affect, the proposal.
>=20
> For host state clobbering behavior, we cares about the values of the host=
 (VMX
> root mode) after SEAMRET.
>=20
> When there is a control/field for "load host state from host-state area",=
 I
> think there are two cases:=20
> - If there is the corresponding control/field for "load guest state from
>   guest-state area", the TDX module could leverage it.
> - If there is no such corresponding control/field for "load guest state f=
rom
>   guest-state area", the TDX module could do it in software way to mimic =
it.
>=20
> So from the view of the VMM, it can have the aligned behavior on host sta=
te
> clobbering behavior.

Now I see what you mean: make msr_preservation.pdf follow the same rule
as the VMX host-state restore, and let the TDX module help where HW behaves
differently (call this SW restore vs HW restore via VMCS).

That sounds good to me.

My only doubt is whether it can be guaranteed in every case. A HW restore
happens after a SW restore.

E.g., IA32_DEBUGCTL - HW clears it on VM exit (SDM 30.5.1), so whatever
TDX module puts there on the exit path, will be overwritten. Not that this
is an issue today, just using this as an example.

But I'd guess there would be only few problematic cases (if any).

Then you wrote this:

<cite>
FRED is a useful concrete example.  Under VMX, the FRED host state in
IA32_FRED_CONFIG, IA32_FRED_STKLVLS, IA32_FRED_RSP1-3 and
IA32_FRED_SSP1-3 is covered by the VMCS host-state area, so the TDX module
is expected to restore these MSRs on TDH.VP.ENTER return.  IA32_FRED_RSP0
and IA32_PL0_SSP (a.k.a. IA32_FRED_SSP0) are handled by software, so the
TDX module is expected to clobber them on TDH.VP.ENTER return.
</cite>

That one reads as obviously right to me. If VMX and TDX differed in how
IA32_FRED_RSP0 and IA32_PL0_SSP are handled, that would be a red flag.

Did you go through all the MSRs and check that the VMX and TDX behavior
matches today?

Thanks!
