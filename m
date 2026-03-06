Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF98351C0A
	for <kvm@vger.kernel.org>; Fri,  6 Mar 2026 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772836857; cv=none; b=CKXmw8vq8hM5VJiED0k0oTNeCy85+CMBXCz4suh5oVJ/JW/Qndyp0TRtXTnP89XbzZT7lxCmPIeOFEuj1j1ASPk2+OXqIGTOOlz4EpfEE0DKMPpPZn5ABbfwx5jxOMPCw2A/5JQkdLFHCRcPGIOM50lS/hrIM4YAsvkQDG1pxdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772836857; c=relaxed/simple;
	bh=QTWvJ83lR8r+rsOkliYS7FhD+3BsaeEk4MJGT4C4c7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n0vPB2FWd5JTSbqfnuWtyBeicvN3yQyVcrR8hqwYOjjZXacfvFnjovCJahURwvHGxeVsCpLY+my2S2vE9dbXw5CNQvLyk0XchfdhKmgJrLFp1wvpNtBzDUw4Yz8KpikcxCyYrqXK6X9M6ANUU8owrnLBW013GM3N9AhI5MxO9+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rst3xUPO; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rst3xUPO"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae65d5cc57so183346555ad.2
        for <kvm@vger.kernel.org>; Fri, 06 Mar 2026 14:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772836855; x=1773441655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTWvJ83lR8r+rsOkliYS7FhD+3BsaeEk4MJGT4C4c7w=;
        b=rst3xUPO/yQCi2f+wWC1QHCzw2PMoMZ3S8J0uJcczsnJlWIu73LUftbiIKjfJ+Q7TM
         OBZU+PqtJ2N+wRakhjnxkw5bUwngAndZUU7WuIkR1N5ahU6vHelGh+Ra3Qw1sONfP+Rh
         eLP9NVFbPDb/eIa5WLk5tH0y0et5nemtJJzzn+PacH4JUI3CE0y7nxOmqdRVuUwlQK3W
         FKXlT/3p1g44ALraqc3sk/0P6QG+ylfQSWtAwMEuLWtb/T8FxV+FeyD1aSJb4n+BiU03
         3Z9Xb4ZQrV5G8GIywOuU69ypm6CZyQkhHke7Jb8Sx67w2+nZdNZgRpPB1jzSvainUKAK
         8i+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772836855; x=1773441655;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QTWvJ83lR8r+rsOkliYS7FhD+3BsaeEk4MJGT4C4c7w=;
        b=Uy7YwV7ycN6EXIEpFqhzWGQEZn/Tr99p+Fyc7oCcuHdjJ9+TXjSI+iVX344wIiS75Q
         5dmYpzDXfeyVhzeMRj3PEMy1AWhf1Xvdl1slbzZvw2hQBRAsnk0x384BlRsHt3s6JHcz
         hrl503OptzzSg3tdnP9K2eLVKI7baYG5lXzIIuD+jPKxW/uB8nEONbmIzTiPqAJrWeDU
         BO4ZAEMJOdZyEGVUsyVjIhGlOC1g5QLw9ypygbQDwU76XUSMMFALJwEHewUI7YD/zf3x
         Kj//Qg13d/UdObgJ4xPJfZKI1RvO6KWtRJdZ9bZM16v82I4BULTiskSAwKKT6U7C3c2e
         5ivw==
X-Forwarded-Encrypted: i=1; AJvYcCXVi4DWxCuqE56XQA3T0j6757lWwy3pyae2VJPGCeElIyyw3wuge0miQS8rPzAKMQIhe3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu22kVjpttGpv4h0pMYmkvPGtLgIEb4kwjlsGlO3kN9KKYablx
	eihnXvwxDJ1v3E2yL+JaBlgReJvDrGAifGKyMx5KcjDzgL78F48AQrXC59qEkfdw3BqteV4ojQx
	sRigmxg==
X-Received: from pliy14.prod.google.com ([2002:a17:903:3d0e:b0:2ae:47b3:acef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e843:b0:2ae:5745:f0e9
 with SMTP id d9443c01a7336-2ae823647f9mr42109075ad.3.1772836855320; Fri, 06
 Mar 2026 14:40:55 -0800 (PST)
Date: Fri, 6 Mar 2026 14:40:53 -0800
In-Reply-To: <CAO9r8zNb8Kvq=6e=pbCe6-T1wT5RcHRerDUAPq4yMvrMjRN8dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306002327.1225504-1-yosry@kernel.org> <aar-gDulqlXtVDhR@google.com>
 <CAO9r8zNb8Kvq=6e=pbCe6-T1wT5RcHRerDUAPq4yMvrMjRN8dw@mail.gmail.com>
Message-ID: <aatX9XJE3fvkVOGt@google.com>
Subject: Re: [PATCH] KVM: SVM: Propagate Translation Cache Extensions to the guest
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Venkatesh Srinivas <venkateshs@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Venkatesh Srinivas <venkateshs@chromium.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2026, Yosry Ahmed wrote:
> On Fri, Mar 6, 2026 at 8:19=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Fri, Mar 06, 2026, Yosry Ahmed wrote:
> > > From: Venkatesh Srinivas <venkateshs@chromium.org>
> > >
> > > TCE augments the behavior of TLB invalidating instructions (INVLPG,
> > > INVLPGB, and INVPCID) to only invalidate translations for relevant
> > > intermediate mappings to the address range, rather than ALL intermdia=
te
> > > translations.
> > >
> > > The Linux kernel has been setting EFER.TCE if supported by the CPU si=
nce
> > > commit 440a65b7d25f ("x86/mm: Enable AMD translation cache extensions=
"),
> > > as it may improve performance.
> > >
> > > KVM does not need to do anything to virtualize the feature,
> >
> > Please back this up with actual analysis.
>=20
> Something like this?
>=20
> If a TLB invalidating instruction is not intercepted, it will behave
> according to the guest's setting of EFER.TCE as the value will be
> loaded on VM-Enter. Otherwise, KVM's emulation may invalidate more TLB
> entries, which is perfectly fine as the CPU is allowed to invalidate
> more TLB entries that it strictly needs to.

Ya, LGTM.
