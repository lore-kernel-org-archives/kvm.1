Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC3E40F8EB
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267299; cv=none; b=CGOZGUFUT+aUioRHizu32LLBAXfxPAXwaGL2rxW6KNihBErIm1nDYqqzNFZOUeEt9wawiZdpzHBl6507RN2w55HQQJXBd7P8KnB6hmYlalK6EmG7B9Gc7XsjKgk4Qg8YhIDM+C4vBAkKJzKVNwfjtTiGyrXADho7Q0evinhLGqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267299; c=relaxed/simple;
	bh=vxS9r7ns/8Y1qaL8c13ekRj1EXKPW2OBF6P+Owiwve0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QNHQCkpcEZkgTz16OW4M2rZhD2Az3qtICVGgW1ZKXUXkKYgYiUfibSN3WOcUG+VyG6jESReXMU9qcPMq9e7RxIi3IT96NtMA/IPR+88nkKfXVEfYvj/PiL0XOf8q+/LXdkgimaGcF4msjeaIIG6ueqV3+Zbd1g+0hsufAq0dPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pORQl4ix; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pORQl4ix"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca8aee88725so1585850a12.3
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790267297; x=1790872097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WrV2oD9ysXSWKPIuDJolj5Gx/FmyfPodKlXDZJqwi8A=;
        b=pORQl4ixdJ2+AL1yD6vlWa+jBv/GFK2+q+9lB7M9/iYFYo7/IxyUwdL5hWJogzMO4t
         PoD65TUSzQAKaKE4tTBFKPSvZo3Zt0rVeX0O6Biw1WRXF8T6awnqJMsqAB5yP2KMjlZs
         8XoCRTSZ8ODNbBuEQ36RyjKzyml/yVhlkZIKIoqT/qMurWGmgZv4lMuGg7SSUs+6K27J
         x1Mh+dEPjTvT6arRC0mfVSFWtUNjX0dIcO+oPs9IZ2Ne8A0LbYyrNCEjlcxNDErPk2HN
         vuU/77YRf766fuwRmBbDJB5q/9fCrRo2O1V9uR2LSrCmW2+9MG5gEQXHJvDbJud7ENl4
         qssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267297; x=1790872097;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WrV2oD9ysXSWKPIuDJolj5Gx/FmyfPodKlXDZJqwi8A=;
        b=OcU2JIg1LldyMuV7YEDExdGXdOVIoHOKp8ZpU57CJF74e/LhqJRiKpvSGUrTY+Zwtq
         jC/AP0W/xxrS6gA/oB+ljqPsFKOWwWxxQuVm+66CZ3nlc+cg9b1m8KT78BZIJkn8NzIB
         wG/yEKM6j9JNz8dVPBg5a7IHdUiYpnrtv6V4J0LoeIc6x2sHlW+H2EuuzdMXK3+M4apH
         CtM3AYr6I2J1XWTeFxWWYyttBStxZHwcXpGrYKFemOF1c3DppvZj9si3VLKWA10b+97j
         tkPahTI4xgMLlr53HdbxexeTknb5JJtFwzim3psHtovCsjDDp2mXXv1XBWinl1PhgnbW
         nXPw==
X-Forwarded-Encrypted: i=1; AKwUvBw+ByHyA8W+yOJ8fERnb1T+bJ3/s0wgpxBR6MdmLy0BGDbSh1OZrtFCuPWZHQwdd4do0QE=@vger.kernel.org
X-Gm-Message-State: AFuF++kWMQvCQW3sgb3iz5XBWTHrT+wgYNzAD2DYzoqZ7tbhHerHfgVy
	27f0DSKRX+snteoxQxvUg5/N2c0Zxut6zSZuefdiVZOxy3BWRp/dYPJcTEBiemxkfw/3siIzFZS
	GhB8WgQ==
X-Received: from plmc17.prod.google.com ([2002:a17:903:e91:b0:2dd:95e:8c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a70:b0:2de:834b:b594
 with SMTP id d9443c01a7336-2df7dd8dafcmr26948395ad.74.1790267296876; Thu, 24
 Sep 2026 09:28:16 -0700 (PDT)
Date: Thu, 24 Sep 2026 09:28:15 -0700
In-Reply-To: <3ae12b120c7aa2ca56e46bb9a5b2a7b7fc501131.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <56a61983c03806120e607dfd1e1b7c9046c1f54b.camel@intel.com>
 <aq048KmPN5WPQ4sQ@google.com> <7d40bcd97e01390a345ce1dbe26264e7b064a619.camel@intel.com>
 <aq2t5wJGLtsltMza@google.com> <arG3KvaVqWCDAyM9@intel.com>
 <12541025-6579-4baf-911d-dcf1453b3e27@intel.com> <CAGtprH8t2OAh59XeWGtBLUX4JXaJm_NDpPE1ZJeGTjppKWrSLA@mail.gmail.com>
 <CAGtprH8syQUQf9PjPe8o6rBFSg+01k=Hb4cvvn3TqED3uWb+yQ@mail.gmail.com>
 <arRsRkn1V8A3xUE5@google.com> <3ae12b120c7aa2ca56e46bb9a5b2a7b7fc501131.camel@intel.com>
Message-ID: <arVPn7HcMLd7VgTZ@google.com>
Subject: Re: TDG quote analysis
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Vishal Annapurve <vannapurve@google.com>, Yilun Xu <yilun.xu@intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Binbin Wu <binbin.wu@intel.com>, 
	Dave Hansen <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Peter Fang <peter.fang@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026, Rick P Edgecombe wrote:
> On Wed, 2026-09-23 at 17:18 -0700, Sean Christopherson wrote:
> > From an upstream perspective, I think we don't care?=C2=A0 Or rather, w=
e *shouldn't*
> > have to care beyond letting the admin flip a TDX Module switch.=C2=A0 I=
'm a-ok letting
> > end users opt-in to ultra-paranoid mode, with a pile of disclaimers aro=
und the
> > shortcomings and tradeoffs involved.=C2=A0 I.e. I don't really care how=
 the quote is
> > generated, I just don't want to carry any kernel/KVM code to make it le=
ss painful
> > (and it should absolutely be opt-in).
>=20
> I think the direction is to basically punt on Linux S3M design for the in=
itial
> upstream implementation. But based on today, I think we would have severa=
l
> options. This is good thing to do for now I think, because the TDX arch s=
ide of
> S3M based attestation is still fuzzy.

Ya, and what I'm saying is that one of the goals of the TDX Module should b=
e to
provide a common interface for signing quotes, regardless of what is doing =
the
actual signing.  I.e. beyond flipping a switch at boot time, we shouldn't n=
eed
to modify the host or guest kernels.  Host userspace and maybe guest usersp=
ace
will need to be aware of which signing implementation is being used, becaus=
e it
will significantly impact VM scheduling and behavior, but the kernel really
shouldn't have to care.
