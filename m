Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FB21A6831
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777597109; cv=pass; b=JAkC12HTMf59RuuIAuBA28Zc+ceno1ElitDsUWI22GscfWa4YfEXTfkzxTP6TjJEZVEw/xBEt2tOK6IOtuEBqvidXWyZZG8BY8okO48IGtGOwJa37dQIe83Zy22D4up/lSuryk+DsAUaGP22pL++cWWZP3KbnyJmOpHBpujQ6MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777597109; c=relaxed/simple;
	bh=fqYlQShHSMRctvGEIU2QmFWw1GV/FMGu+gThhwXZyvQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=beP6ZDZsyN4MufwnQUY2V2xeAkMipKjmugKH9QQFzSL4q4xhj+PJjrZdqmj9+541P1yyDjR+V6AWYyKSUXpMp3Y2XqcXOzXsdqw7LvNKp7ka89KvWNTUT1j+orFl86ls81eBPK3piUGCEfSo6+SO0rQg6apEab76KU8n3+/NQUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iXtrKkZ6; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iXtrKkZ6"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56efdc96b05so923085e0c.1
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 17:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777597107; cv=none;
        d=google.com; s=arc-20240605;
        b=NV4BO80CyJbFBA1iokLJcPncNMilc+0knwDcNxvhGDo5jyIw6IXwgkanBP3UgLD+kJ
         9ME4qdlY1vraCNsFitR6x8MQthwyDdWsmtMU1UjDnyvzxU7zy1O80kecz21N2z5RDWFv
         B8FPLB9WlIvrEF6QLle96Ncs/zI8bvNr5Bl3BsxfUZeOX6r2dMlBZdyQEcU06CCBt9xd
         sAxPAvF0JyHFOsSwlaZ9UibXvR7M/AOGuwnQQihfTGvpzhXEtBjv/F/mqGRh7sVTzRi6
         GcK/YyX8nn3YLj7yFR97OW8day5e440xoSiieY6utqug7H5VUS5FUFU3K5zDCmBhrzaN
         +CaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=sH/8kc6iI1JLK2/3TZ78o+aqGZdALyItajE7z4O66hQ=;
        fh=+3cHobsrc4VfFfQ0gGPM+NxwTuqfFFHzkw2HI6qcj2s=;
        b=S7WAKsbMA/1U8nngA3Z+PbB0viTootebDIBD9x1gg+L+mQlKtWDEIlIjuDhUiqhks+
         h4I8Tr/h0KcQeKgsa5BJ140TDYwFCLg5EZOrYCHmFMCkqrjSaxFcPY38el5b2ROubEtD
         io5p3enYT+eA9bkPhz0UPTrEADMdjkBYAzZANr+AYewA+iHPq/VvKwtLBVOxYlVL1jVG
         XhybYo94nZ+w0MDvxlfmp8Swqrsuh4S4OI67ThilScC4UpiBFddJ2NeNDT+nKdkooLtp
         BYbYtsUPZZvTNoSltH5JQhZg8SA4KS7oOd/iRdXghitFnHP2iC/znpXIFVbWhYBfELOI
         oQSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777597107; x=1778201907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sH/8kc6iI1JLK2/3TZ78o+aqGZdALyItajE7z4O66hQ=;
        b=iXtrKkZ6QahBGJBzYtvjhxvOLttbebfX88GeehfPb4tuT2SLB3Y7DqnfA2zBty172a
         aBT034EHPe+4NnFmFfsZGSafVwgZPyUhe1DQCvfayp8xWDK/Kfdwjt1FxxhyPn9W80BW
         Esuxg3LPzyU31lykb1MJB1DMssIRxugbo9WG4pXKPimBvsneBtaDMjh1bb1RIPX8kUZy
         MSw6gU1wH4jp5VhVB9F/E887+I7qf4+kKfwSoX8hdC9f1QKkWUrSatMTlbeT65FpZGV9
         PqmjWVxiyTBMMZXNJWvO2C8jkjcVsAEDg3DhU+/64HEZ7O5S4WZY8IbgmADS151cyYSv
         BLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777597107; x=1778201907;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sH/8kc6iI1JLK2/3TZ78o+aqGZdALyItajE7z4O66hQ=;
        b=EjPifouucZPwnKo8UMaKXVl7oNQXvX6/ydxEhxvsn2fGRz6uptyCInSG5rLm0kwmgW
         EgYVx7yGp2oQ7IPN2N3QLJk0yt8Yrw7dV13NSKi7DPH35cteD1QtOxXacM6qKPKvMjJ0
         sBOwKNad2BtJz4z5XxGLIosgNvFrF8QsEJSqVSZwUkZwBg/CsL+PhrzsHZha+WX2Aq1u
         hIXcGi67lxWKIhilKOQaRNI6KMX6kJha17GYLVMGGSKvnvsXS3Gl8cilAN6tdvRDYUnC
         QONEZ7XofiSQDqFl/O39ZcKFd3d/OZbzvNEbVKpZoYafvpTCXHWI8J1w1V1JxEbTUGdP
         RA0A==
X-Forwarded-Encrypted: i=1; AFNElJ9NYxl/mI5YoALc5dfUAzSyLGIj1MWtL/Qz4TXx5gwiquA1tmnGJPtSSmyO1mUTIWyD3G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTGzWWTFT2i1/bJkH3+XX09y2KAsHBpv9K1Ap+nKqBT9vxxgT
	qrOdOJ/jjzY/ZF5dc+S66qYRBJrhgvgPZMDYxzFYzhLPLsQ8Ey87wb6ABKniogzBc+5ypZ0cy2P
	9BZD5CgbGrvYly+igWw0MKEShSTHFi/hw2LK587qS
X-Gm-Gg: AeBDiesd2KirncqqwsAUO0t0Jh4YUg1ppldvAaKKzlOg+zTNnskNY2jCat5FxHJp7gn
	n055fKgExS7pnPt5yGJkJrbOy9RLaghk2j9HBEXoJ4wRfpKV0iOwI6M5v9MSEtqEvuQM1JUl7ky
	V0h7OIMuh1dppDVEwDsCuL9CCCCZzM1CZKJTLI15tt32hYCKpUSYBuVijuUedQxm3WWsq29Htb1
	eidEVfhXrKPp3Iaz5/FuhALt8eTNBXsCiTrqc9FWh2iL1m0TOVizP/IUetSm5fdojhMK3JxMM4v
	Ug+i2E4jbsyxdgdMl2uOBmHnNHz5ilzRDGqu/JKx6Mhl/whHO9I9rVPmEnzW
X-Received: by 2002:a05:6122:2a56:b0:567:4e8a:fb13 with SMTP id
 71dfb90a1353d-574bea2b1eamr480295e0c.8.1777597106942; Thu, 30 Apr 2026
 17:58:26 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 17:58:26 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 17:58:26 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <231efd4e9267d3dbb8c63e57b3a43567c965e24a.camel@intel.com>
References: <20260430014852.24183-1-yan.y.zhao@intel.com> <20260430014948.24226-1-yan.y.zhao@intel.com>
 <CAEvNRgGsMaioFvTWaLhnDiLbdx3tunZpo3Qzxdm1xeb4ef0J9Q@mail.gmail.com> <231efd4e9267d3dbb8c63e57b3a43567c965e24a.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Apr 2026 17:58:26 -0700
X-Gm-Features: AVHnY4L-ucZ5s1_gFXeDk_hy8TeRQ49rUaAznyPNkwU0xPAMQzcyCgeetMPMl68
Message-ID: <CAEvNRgHuaztV3_FoRf1UVRDNP-JJ3PJPJgQKANoYOVvg8SjPJw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] x86/tdx: Use PFN directly for unmapping guest
 private memory
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"seanjc@google.com" <seanjc@google.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Cc: "Shahar, Sagi" <sagis@google.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, 
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Huang, Kai" <kai.huang@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"Annapurve, Vishal" <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> writes:

> On Thu, 2026-04-30 at 11:17 -0700, Ackerley Tng wrote:
>> Yan Zhao <yan.y.zhao@intel.com> writes:
>>
>> >
>> > [...snip...]
>> >
>> > diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
>> > index b24b81cea5ea..e5a37ea2d4a0 100644
>> > --- a/arch/x86/virt/vmx/tdx/tdx.c
>> > +++ b/arch/x86/virt/vmx/tdx/tdx.c
>> > @@ -710,7 +710,7 @@ static __init int tdmrs_set_up_pamt_all(struct tdm=
r_info_list *tdmr_list,
>> > =C2=A0=C2=A0 * to normal kernel memory. Systems with the X86_BUG_TDX_P=
W_MCE erratum need to
>> > =C2=A0=C2=A0 * do the conversion explicitly via MOVDIR64B.
>> > =C2=A0=C2=A0 */
>> > -static void tdx_quirk_reset_paddr(unsigned long base, unsigned long s=
ize)
>> > +void tdx_quirk_reset_paddr(unsigned long base, unsigned long size)
>>
>> Could this be updated to use phys_addr_t base and size_t size instead of
>> generic unsigned long?
>
> A type is a really good idea. It could look like a virtual address, despi=
te the
> paddr in the name.
>
> I added it to the cleanup list. But I would prefer to keep this series fo=
cused
> on resolving the critical controversy around the struct page/pfn type, ra=
ther
> than adding in more things to debate. If you don't mind.
>

No worries, please go ahead :)

>>
>> > =C2=A0 {
>> > =C2=A0=C2=A0	const void *zero_page =3D (const void *)page_address(ZERO=
_PAGE(0));
>> > =C2=A0=C2=A0	unsigned long phys, end;
>> > @@ -729,6 +729,7 @@ static void tdx_quirk_reset_paddr(unsigned long ba=
se, unsigned long size)
>> > =C2=A0=C2=A0	 */
>> > =C2=A0=C2=A0	mb();
>> > =C2=A0 }
>> > +EXPORT_SYMBOL_FOR_KVM(tdx_quirk_reset_paddr);
>> >
>> > =C2=A0 void tdx_quirk_reset_page(struct page *page)
>> > =C2=A0 {
>> > @@ -1920,17 +1921,17 @@ u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *=
td)
>> > =C2=A0 {
>> > =C2=A0=C2=A0	struct tdx_module_args args =3D {};
>> >
>> > -	args.rcx =3D mk_keyed_paddr(tdx_global_keyid, td->tdr_page);
>> > +	args.rcx =3D mk_keyed_paddr(tdx_global_keyid, page_to_pfn(td->tdr_pa=
ge));
>>
>> Should mk_keyed_paddr() be updated to have a return type of phys_addr_t?
>> I guess in this case since mk_keyed_paddr() is pretty much an internal
>> function, returning u64 also makes sense to indicate that it should only
>> be used to set 64 bit registers.
>
> Yea, this is used to construct u64 inputs for seamcall args. So I think i=
t
> should keep returning u64s. Maybe instead it would be better to have a fu=
nction
> name pattern that denotes that purpose. We have some more helpers like th=
is
> coming.
>
> But similarly, I'd like to not grow a snowballing cleanup series for this=
 one.

Makes sense, let's go :)
