Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09063296BC1
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576827; cv=none; b=swKrCxeq2ybN29vrtWjfma06hFVjbS9/nWBMTy94pScRbh6CHPe2XZy9/wvQLcDl1jhwZk2hVo8zrAh1g0QUQuIhCRFZs0rp/DMUL7O7LVZM7wlZEonbXYIkWJB02A9KphJ1eXblGxM83HRus16SuJ/fxKGUNPV42YH3wziFfKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576827; c=relaxed/simple;
	bh=C5arWefFDNbRaIamaEMBQUvYBS9ckgNEZwVvFQkmtl0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EFdLVAjuc1H2bPiwrkJZSyBrhBPyjFFRCVNmmoPjBvK6SKG9MzqcEUQQpScmQV0R2JtGrxY9OoJriRGdzXF1LgLnqKfFbXJc+kC3ffD9WdxtpI34wvs3d1nEMmldJ5PszfR56y5LJU3wnNeVjbIA4CjOcWnUS+/PhEYOzAfD9hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ds31T6WG; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ds31T6WG"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fd55bf6cdso1017429b3a.3
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 12:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777576825; x=1778181625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7nmwj/xSYnHSSTZhkQ2oMM/1dWkKXj0aCEkeTcwXSY=;
        b=ds31T6WGW/k12zm6NeC0iM5tlwcv9PVabAyd0FmEchmdhLBqbtHUmX9RwT80lWtRn4
         FeK4XXcBMK57qlBNQjCtpljTFiZD+h3UUfIAxBjcjKi4ygqv0GfJhHzzbzrDs5d+AfM/
         f/u5fEjoYg7Rw7kST/QTazvCF57inpL1sDGvXvcRDnSklSxsFwqGf9fMjY3KwL+cXv+H
         yjacrl16J3mvcyHCEYOl3vfCoguX7u71FNgGoVsWVzxIG0Sbhn6eC5d9FJadcw+a4lQG
         mvH6SJtOCvx3B/XBfNfbUBduFNKTAgIwCbE6Wvg5Hzt05sPvE+QYqrS8OYOTNuWpV3BC
         QckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777576825; x=1778181625;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i7nmwj/xSYnHSSTZhkQ2oMM/1dWkKXj0aCEkeTcwXSY=;
        b=asXFqXIWIDhffuYatJza7tDFqwfOV879yLugUSupOS4mkgJqNJWhdvnPEBOIaYOf+S
         5CXl+pwALhtioWST9dKsQYE1wpeVt7JsvsTddRBIM6VH/ByrVru93uRpveIsks6ZujDK
         +nGkV6Jn+fDudvrvpk7YKxXM0QGByfZMWPdZXhy40f0MfOXgMQiXnAYVvj5SqFz4Db4D
         uVWKzL21Yq9fhMTs/GlSqAruL8vj3q9ymNt0APgkd3WiUJpvawIjFGoE+GNknEC/P5UT
         YNNT6ccwzEtOnyaCINPNupurAR3ReQPCeS0Wl0WgtWnX5eVPLL9ApEWe5uxK0HTbNlMr
         HjSg==
X-Forwarded-Encrypted: i=1; AFNElJ8guRV0Vm57fleDDEhxQDllbuC8Mo4zfzKNje/+0HIR+URTMqRZp9Hrqg2Bcjk8i+GGClc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz38qRW9X1A9vTrfvtNfBuWrrhZBs68VjNyCT4Mfh8Xg0Lp451
	aiCNv/t1685R48CvD/bRV7/6Zd2zVGs3KnjUbJ4PWQ5tA/knr7mz9PfDnh6D6wboH6LAjH30S4C
	ldFHNWw==
X-Received: from pfj1.prod.google.com ([2002:a05:6a00:a401:b0:82f:2a0d:b24c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:90a9:b0:834:e605:9927
 with SMTP id d2e1a72fcca58-834fdcb93b7mr4649065b3a.37.1777576825076; Thu, 30
 Apr 2026 12:20:25 -0700 (PDT)
Date: Thu, 30 Apr 2026 12:20:23 -0700
In-Reply-To: <231efd4e9267d3dbb8c63e57b3a43567c965e24a.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430014852.24183-1-yan.y.zhao@intel.com> <20260430014948.24226-1-yan.y.zhao@intel.com>
 <CAEvNRgGsMaioFvTWaLhnDiLbdx3tunZpo3Qzxdm1xeb4ef0J9Q@mail.gmail.com> <231efd4e9267d3dbb8c63e57b3a43567c965e24a.camel@intel.com>
Message-ID: <afOrd7JYkUfe7wcZ@google.com>
Subject: Re: [PATCH v2 2/4] x86/tdx: Use PFN directly for unmapping guest
 private memory
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	Yan Y Zhao <yan.y.zhao@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Sagi Shahar <sagis@google.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"kas@kernel.org" <kas@kernel.org>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kai Huang <kai.huang@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026, Rick P Edgecombe wrote:
> On Thu, 2026-04-30 at 11:17 -0700, Ackerley Tng wrote:
> > > =C2=A0 {
> > > =C2=A0=C2=A0	const void *zero_page =3D (const void *)page_address(ZER=
O_PAGE(0));
> > > =C2=A0=C2=A0	unsigned long phys, end;
> > > @@ -729,6 +729,7 @@ static void tdx_quirk_reset_paddr(unsigned long b=
ase, unsigned long size)
> > > =C2=A0=C2=A0	 */
> > > =C2=A0=C2=A0	mb();
> > > =C2=A0 }
> > > +EXPORT_SYMBOL_FOR_KVM(tdx_quirk_reset_paddr);
> > >=20
> > > =C2=A0 void tdx_quirk_reset_page(struct page *page)
> > > =C2=A0 {
> > > @@ -1920,17 +1921,17 @@ u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td =
*td)
> > > =C2=A0 {
> > > =C2=A0=C2=A0	struct tdx_module_args args =3D {};
> > >=20
> > > -	args.rcx =3D mk_keyed_paddr(tdx_global_keyid, td->tdr_page);
> > > +	args.rcx =3D mk_keyed_paddr(tdx_global_keyid, page_to_pfn(td->tdr_p=
age));
> >=20
> > Should mk_keyed_paddr() be updated to have a return type of phys_addr_t=
?
> > I guess in this case since mk_keyed_paddr() is pretty much an internal
> > function, returning u64 also makes sense to indicate that it should onl=
y
> > be used to set 64 bit registers.
>=20
> Yea, this is used to construct u64 inputs for seamcall args. So I think i=
t
> should keep returning u64s.

+1.  IMO, we should treat the TDX-Module as an extension of hardware and pa=
ss in
u64s where the spec says it takes a 64-bit value.

