Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA2B317174
	for <kvm@vger.kernel.org>; Sat,  6 Jun 2026 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780744318; cv=none; b=q/0gdk7ahDLfZSt90zsYUX/LK8dTmo1AvGx4Y2utlaX0zd4fQkl9TwToqhKqgfSMDMWojwUV9ppawONJSNU20SjRuyib9TblLWZU/k+uX1Jhvxs9Y76IzY3vVoo/ObJeEsKumvNQ0AjJ4qBNVmGjzaDn02jZpDMpJ10FGMC7ZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780744318; c=relaxed/simple;
	bh=dvnRGdrRFnRuhci5wez75UUJUTbmRrm2qIUBlXHLVfg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=siyeq3lURMiCZsXK8FBTeXnvocQEw+DFrwuNgLhd/6nkhNq7TOtOaQHLfQWZEL/s97Ejdfw4fY/H1LLa4M0qTYwdBM2gKoFKE/s9uvub7cEEgDszMozzWYpdEDlOb28pKSm3q3ixG+oeD8fN72J5lPoqZcD/JALRJchH5QFLpHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkBSva64; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkBSva64"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-46015dc517aso2272503f8f.2
        for <kvm@vger.kernel.org>; Sat, 06 Jun 2026 04:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780744315; x=1781349115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93u+GJ/ci/dwDHALLFM8eJXF4CRQlugF6cy8CKPz+sU=;
        b=AkBSva64Obou3QlErdOXcZK8+0ufX+yEIvJWqhXHEsPULXa5j57mpJsBOempeDODfZ
         B6wwl10BFe/l1Oz0IVzLyE3Lf2Nyelws4NzObllVXGQhZLkgmc36lnigg0Mv7jZ49iGL
         rnr6zW6JHg/3XfB5pPjrkiN589nK+V9tjKxUQculasv7fbKyjPJS9CfFJVWz/hroe1y6
         gjYprr8lIqlEEEM9/CinEXVWJ//zfcqavNUeTEAUUjaIrXG98TezLu8iHvimIkFUCcu6
         Sz7iS1+svv9yj5t4ywYShN2nm2H7gwFmrBqvAdxrMHsP0AwFYwI+KHlYJssjsWB2/e6m
         DPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780744315; x=1781349115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=93u+GJ/ci/dwDHALLFM8eJXF4CRQlugF6cy8CKPz+sU=;
        b=RQiYTmVi943qZ3uXUFmep8rm6npIVV2wV/SROpBjok5huQOvegAj9eZA1Z1tWJPu8C
         zOrMO531WKiReLSl11AbUQEeUC9nH5FWnYXXjCPiFp6AIam8ILWA+xDTh0DZ7360djGZ
         6N5tcJ7JLXSTeZ93beqHjBm8qlGJnxTePUKLWcHabJbV63lZH7Cw4RFCoDaNtRQl0tiu
         xdCKRjhnRw49Je8j6y+brOMqpdhBG073HaEkYXEf5SLTJOp/UIy/Eea4bJd42tx+7OW2
         Lzg/1vnfvP1lSJiT+RFf31YZCAKmAJy4UZ3vhhdL0/+Nf4FoS/Lo8jmoNHL9I8Ygn+4p
         YHWA==
X-Forwarded-Encrypted: i=1; AFNElJ9t1qY4DcYVSVG6GNRPPjE4CE2pMT+uU/qv5Dt/FtCbJaYkxKpXoVwvWbTZS5Bo6PUHjTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa2xTpqBjqByuCJt36bsYHP+xUwNtD/XLNFxsKsfuAkqzzYfD+
	YDnuKiaswkqoFWNXHPKWqjCasQbILop8DNQRwK0fi6rc69s95QzVgKx5
X-Gm-Gg: Acq92OG/8yWuoVBIvq2isUjGoRFh3afrzYhgeoK6LsroAxN2o/vAdFJ9AoOb8nkv5g8
	/dgi/i4JuJ8Q2RtSPi+79PK7xNPpxoa29ieRWVFs2AWSH8UCOQ8LIfSln9oergYBw/9ejQIJiO0
	7/6fj9E3/sTmvNLHYWtBTodZbETnmt8j8YtSOk4V9YFKBapiZgX5DuJ0fCjE5mkefC/Rx5nFAhx
	0el7YcdkeocoGQ4pYJ275fCUvT2Bqrns5AcJZaTXK/VcOIZmmr0SKSgsc1H8PXUH+TjOl1AS+Cf
	SrMdxOpTiMbYP2ReYEVAouy19kaKOxFwE65tiHnfumMVI1qTjajiELoQ+ol9+XbbwFeU5hSgwnZ
	oTRB/iC4m3dAmp8WFYsQXbma2OITY0Pp4CNINwAFuEbf3sRLW3NPM3UHN5BD8mzEGtXSyjCdAve
	iu8IT/4FX37gLO83j97Tu9RJj+c813dVk9E7t1b2ODkuhQM/wmNlmmP7dMNTDgdenyUxbWUXM=
X-Received: by 2002:adf:f88c:0:b0:45a:e3dd:586b with SMTP id ffacd0b85a97d-4603063a9e2mr10245115f8f.18.1780744314001;
        Sat, 06 Jun 2026 04:11:54 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344541sm31542831f8f.22.2026.06.06.04.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 04:11:53 -0700 (PDT)
Date: Sat, 6 Jun 2026 12:11:52 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>, Paul Durrant <paul@xen.org>,
 Hyunwoo Kim <imv4bel@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] KVM: x86/xen: Introduce kvm_xen_has_64bit_shinfo()
 macro
Message-ID: <20260606121152.5ab6bf09@pumpkin>
In-Reply-To: <63c77cb3e7fb8b9b1ee0baa006760d494f16ce54.camel@infradead.org>
References: <20260605143034.3603-1-dwmw2@infradead.org>
	<20260605143034.3603-3-dwmw2@infradead.org>
	<20260606103043.0d9a4baf@pumpkin>
	<63c77cb3e7fb8b9b1ee0baa006760d494f16ce54.camel@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 06 Jun 2026 10:35:45 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> On Sat, 2026-06-06 at 10:30 +0100, David Laight wrote:
> > On Fri,=C2=A0 5 Jun 2026 15:17:27 +0100
> > David Woodhouse <dwmw2@infradead.org> wrote:
> >  =20
> > > From: David Woodhouse <dwmw@amazon.co.uk>
> > >=20
> > > Add a kvm_xen_has_64bit_shinfo() helper macro to replace the repeated
> > > pattern of 'IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode'
> > > throughout the Xen emulation code. The macro uses READ_ONCE() to
> > > ensure a consistent snapshot of the flag, which can be changed by
> > > another vCPU at any time. =20
> >=20
> > If another vCPU changes the flag then isn't it all broken?
> > The code seems to need the value to be stable. =20
>=20
> Do you believe the explanation in patch 4 to be insufficient?

(I read patch 2 first...)
Changing the same lines twice is s bit excessive.

There is this bit in #4:

 Even with this fix, the same corruption can occur if 64-bit mode is
 latched and the guest switches to 32-bit mode immediately afterward.

which, I think, means it is all hopeless really.

If the structure layout doesn't depend on 32/64 bit then why check
(or compile-time check).

But if the layout differs and the the mode can change dynamically
then you need some kind of locking (or similar).

-- David
