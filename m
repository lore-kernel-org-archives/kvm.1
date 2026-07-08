Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B662237701A
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518117; cv=none; b=jQVMPat2xdGgJRA2nw0CVa/tKL/gCVgOfTzLaFcNLkBy5j+vJWb3A7bIBOS9e7bkIyDerf6vJFMla74aIRKDHEN3UXd720nv+nLfiBMAk+7PWMsB2pgbp7LknQUNDxqnjdawewhjRotC2xYR2jvqi6riv1LhmZAJWMdlnqbQy+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518117; c=relaxed/simple;
	bh=v4OimKoQMC6oOglNZ8voWG87nN/+o+EzhSelCLXtNxM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kprl7dLSyZwwVwjtC1M0Wgd4uBinzF4AjKzTgYGouE8e2oIDZXjD5yn8xTivPV7fnDOXDL/Ox72ByZVfR7aMTotsv/84OlOGRV32f1X7LkpviXUiN5sZbG5otOzcDrtOalSClxOYnWo+BognukH+nejndO9Up4x6w/oAQk6ZOOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rvQjfMrj; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rvQjfMrj"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8479b45ad08so1135632b3a.3
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 06:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783518115; x=1784122915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9VFF+QYSSbZf5aoKsUY5fB3ixOBsp8MS27vKIfI2g9U=;
        b=rvQjfMrjCNOa08kxFRWIxeEjdchSRgTL3f+PwlrNSp1YrRu6mkTwzYY0uedCNAsTMJ
         Ud3B8x3GRp2Jrce6afjqHxLAc9ETatjYYFWSXwUF8sLoA6QzDj8uy7RGlzdqZgsVb8xf
         d5qXPVWrgY4kknSl2JDEzUFZhcxIqW2xruLyBunJ+7BvDvmTWhA9CIWw4UMdxdMQVZEc
         Cfaeq0u0/kR7Nidd+rtg0Cxo5HY8Sr5629O3TfrNjKnkIQlDu1/9BCyLuVo+wgNVPGzn
         JB1cTmV47kAU6wfLVv6ECySJ3AbP0lvYYjxDS5x0uKxjYGg/JfmOdyDXCVy/ZD7Xo4S8
         pthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783518115; x=1784122915;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9VFF+QYSSbZf5aoKsUY5fB3ixOBsp8MS27vKIfI2g9U=;
        b=jrf4eIxYxBctxnta23lw1ywZqebSzUO8gJC54qqJ39VvFqj8OkHYZR9/Z90lrCPlGZ
         eK6LyIhUGhMiryHkrV7ZT6KaGuQq5I1OMwLZkJhc2X/Y24Y6hjhJX9L35c/SHidMVIey
         H30HNlEQD/fM4m2oFairnXYRB1TT2O+9rsHci5cYzUsUHEW30ZnbAx6y366DeSGSw1c7
         Ktwyd7c+naDSn/WIzUtmevfTzxBhO+jG1Z6kdgiBdSTRoKdvk3NaWpiycQlQwfDVsRqq
         bleK95hEQJ2rWzpvtep6cquAhDLBBiE/NvV8PVg0+H2aOZmG9VdPrMtxdSVf6fues/UX
         hp6g==
X-Forwarded-Encrypted: i=1; AHgh+Ro1X3Se43eCCVHpcD2LAIQ46arBsVIdK1jC8fsQVh3jhlRg3yfUIk2xZ7q2o05w55cDpGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgQt9QCs1I/4CGRnHOJ9iFysbKrn3uD7I78d+Y2BgIrcgEpg5x
	xdCOBT6NhDoQ2MstEMLPMFpr0jIsYrfAt/vA1ucRNUIhRf+WPAxdQea5rty3uqSSGLUssRxAZ+k
	Bm5tx3g==
X-Received: from pfbkh18.prod.google.com ([2002:a05:6a00:9452:b0:847:8d4f:f2fe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:92a8:b0:848:2f73:8ffe
 with SMTP id d2e1a72fcca58-84843694154mr2600333b3a.71.1783518114855; Wed, 08
 Jul 2026 06:41:54 -0700 (PDT)
Date: Wed, 8 Jul 2026 06:41:54 -0700
In-Reply-To: <bceedaf195adf713db70a1dba743055fe4f20bc0.camel@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260706092021.3625908-2-twiederh@redhat.com> <akwrncCjosItvAeO@google.com>
 <bceedaf195adf713db70a1dba743055fe4f20bc0.camel@redhat.com>
Message-ID: <ak5TojZfR04SWWd-@google.com>
Subject: Re: [PATCH 0/4] KVM: x86: Document and enforce APIC base memory hole
From: Sean Christopherson <seanjc@google.com>
To: Tim Wiederhake <twiederh@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026, Tim Wiederhake wrote:
> On Mon, 2026-07-06 at 15:26 -0700, Sean Christopherson wrote:
> > On Mon, Jul 06, 2026, Tim Wiederhake wrote:
> > > When an in-kernel irqchip is enabled on x86, KVM installs a private
> > > memory slot at the default APIC base address (0xfee00000) during
> > > vcpu
> > > creation.=C2=A0 If user space has already mapped a memory region
> > > covering
> > > that address, vcpu creation fails with -EEXIST.=C2=A0 The same happen=
s
> > > in
> > > reverse: mapping memory over the APIC base after vcpu creation also
> > > fails with -EEXIST.
> > >=20
> > > None of this is documented, and the error is reported far from
> > > where
> > > the actual conflict is introduced.=C2=A0 A VMM developer hitting this
> > > has
> > > to trace through KVM internals to understand what went wrong.
> > >=20
> > > This series documents the two undocumented constraints (irqchip
> > > before
> > > vcpu, APIC base memory hole) and adds early checks so the error is
> > > reported at the ioctl that actually violates the constraint.
> > >=20
> > > Patches 1-2 are documentation only.=C2=A0 Patches 3-4 add early
> > > validation
> > > that turns a confusing -EEXIST at vcpu creation into an explicit
> > > error
> > > at the point where the conflict is introduced.
> >=20
> > I'm 100% in favor of documenting the behavior, but I'm not exactly
> > excited about
> > the enforcement.=C2=A0 It's not needed for KVM's safety, and while I
> > appreciate that
> > such a goof would be somewhat annoying to debug, I have a hard time
> > believing it's
> > a common failure.=C2=A0 I.e. I'm not convinced carrying the code is wor=
th
> > the marginal
> > benefits it provides.
>=20
> FWIW, I did run into this exact issue myself and debugging it was

What were you doing (or trying to do?) when you ran afoul of this?  I ask b=
ecause
maybe there's a way to help developers without impacting KVM's uABI.

> indeed quite a ride. The EEXIST from vcpu creation led me completely
> astray and I was very close to just giving up. If I had, I wouldn't
> have written this patch, and the failure would be perceived as even
> less common.
>=20
> I don't mind dropping patches 3 and 4 (the actual "enforcement"
> patches) for v2, the documentation is more important in my opinion.
> Still, if there is interest, I'd be more than happy to rework these
> patches for eventual inclusion.
>=20
> Thanks for the review,
> Tim
>=20
