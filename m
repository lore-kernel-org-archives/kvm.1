Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F903C3F6B
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 23:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784243380; cv=pass; b=nA2+C9x6TSmKHp47vJYqXLe91Xf4ZPhYUwnAuZcOm7ORrobLPNybGDwQ9+U8ZrDT89AuFxGoopPFiQA1lzRI72Ly2Pc/WP9ayp13rfszfjtdml6GivRxaS40SoK+8s4mVvmICEOFWjd50ue8GIjuXHkbWY+MMz9gmUEtzbVtOPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784243380; c=relaxed/simple;
	bh=/m74fZSKYZRSCKO0TtSZ1FVMpi9HG9O7odHPm9DFXUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvZmPU2LR+5eN+IWjcxIPoGa+dSIgw6Nk41l22WV3lQ8G447e+NtIVi1YzWFDI6h3/3EXTqbi4hLiWFCxyYoGSAvKU9DPdph5pkzoGZNY+TtqkW4pr1qnJJ+IhTdwYouAoJcwJyAEUC42Al/UT1K1T9ZohggUjgSmsLXQLwbLck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oBi90mHu; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oBi90mHu"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69a45011a92so7166a12.0
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 16:09:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784243376; cv=none;
        d=google.com; s=arc-20260327;
        b=ctActq6Q+rqNuaqEYyaqWGlxwSy2IjDRrup1jMvK/UJuL48pKi8TOuWQn6fV95v2U1
         qIJ82BWFbTyg1PhvBPxYEDiWT+IrFV33LEcIpEBpw9rjt4K5SCPhI6RKHAnRBg84H0oy
         mIX8b1MYW4hsctIVYUVpIfCDMGBNjGer5yK7lZN8WMaTlY+OM9pONj6oHn/d+GTBydB2
         5iMjpicvlEDV5+L1lfeTNQhOtT0MEKTGp/Rnx0ekYmb+bq/145HwjRYXc/09FsJwngw+
         mSEQQ5uAFQjeI/P40VhehFjXw0jWZwkotmIGzqXjTBrbTPjbxkAcqqJ4Dr2PJI4iGNZ+
         /9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=85AvBOgky1un8n97bJ4SXkKPP/3mc2+9ogMY6EldqKI=;
        fh=SXO9I065VEWEQCE7PAQvnuOw99Q3EZgMlCQwnXXd1Pg=;
        b=LN8R3qFA/WQ37p429VTtm4Y/0EjJ5eHMQMEbcIa9/d1TjpkHuCQNP/h//A4A65BCr4
         AGEb4w0EJR3i/EIUq7n4C0AKwDhAQxFrGaEafEYUA+IoZfTS5YDkJ839Tg3+9nGdYNqK
         hjT1O5xaSCqAE/977fdlS6bCjjf9oIZCCJTyFbvkc9IBantgDv4SfwAcHucNZtdnUdfB
         1bvI+LHDOvDbfXpnU/a6Pk6AG8iTbf6Jv+LtU0SV2ROftKeb9Q2QB5xhhjTDZDKYWi3c
         fCpqhFs+PoQSOaupd5Z1fOYJ0z6wYaZj1EFJHLBOjcZ5gl0W6W9WMRI8gN+Iyvb8Xa36
         yD9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784243376; x=1784848176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=85AvBOgky1un8n97bJ4SXkKPP/3mc2+9ogMY6EldqKI=;
        b=oBi90mHu/2cYrdRBSRZZDZvCzPTb5oieRgrxo/Nrh0jDg1LtUE/y2K7WUy3a8Hm4Qx
         AtHwyOB5pffRfwTp91JcT8akhb/OoZfQgH5dAp80NSSrKhu8gYC3hwiNgsLVwEtglQ12
         jS6u6+ZXYwDgyQvsGf8Cg6NvpX51n+sEI99iG7mJmdBn36MHvmchBI5PdjGRteGO2jv7
         xw0owt9k9slcNkHrHRmtH5d2gRW/Un/HzDxIbMWHKDtxj1+bSMEH6VPN8ZA6M6+TgW65
         ZaYcOw7rGhsvXyktTUwlSdHBRVIf2yTIYbZkG4af8jBLD72AtB+REhk0ohydAjk+alR4
         48rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784243376; x=1784848176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=85AvBOgky1un8n97bJ4SXkKPP/3mc2+9ogMY6EldqKI=;
        b=EA7L/eW6xrMEUbu0MSkX/V5l6obvfB1y/p5c063evdVP0ZgZYyPcwKPHkq0JZpSK09
         U2rppTmqSbOY+BrtXEMrWOxsk/yM0aZeFkgXA/njVoqGXvUzqpVcup2S4CJyNlQw6qy4
         cS9sSCHL6644/lDyujhk4Y65ksi83S69y2aeXCEA4D7IPLN8FyY7CLkxgTiXgjrAwq37
         glO6q4PEE3p6mGndblHbEOtImZL8Ch2/uLReKnc9XRQVD4WIK/9sXwSj6m+TcE9vCVyp
         NaOqqkQixNJiCQQ7pzQeJFE0zyimhvkUekw1f0tpRoAT6+31tNzzXe6kMXfUr716V90V
         5eqQ==
X-Forwarded-Encrypted: i=1; AHgh+RpYWhxO49pA5rbr/jeLLzrYLU+Lq3HP67o3uMm6CYct51oGm6H68UguBxPumc2EtjG3fu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxm8NKOyrB01f7j5z+WKxcNfpz97mcUfGizuCoHJvxG7KMj8bd
	UzeJrlXQOoteQvg2xBHq7FdxkOWcli8LmLPHMUcww3MomyXdLBgkvzWClbaex3U+3swbapduWTl
	6c18CN45MGO+j1hcmj7Pss0aLWjPlmutIjKZrhinG
X-Gm-Gg: AfdE7ckAkLq4IAXd74NO+FEftquzC1FOOh691va0PoAPVtZlujbMN8f47lcXrYSRdai
	smbPPBFeVNjGhBaUN3k6R6BYuIHGQmoz0mnGCoi6kXGYLXZYhdn1yZ+TQpnX+5HU7Op7DPeAW/Z
	8oQZB4Cg0vsQJViu8ALABysUUD7M+kfK/MiU2iVsC0YbYpkKhQrvxsFHpZYpuaZ7qB40aW1xyEG
	mI05R3NbLH3gzF0JqCKWK1pDiVrr6bf1I96SBTR1lchtp+v69H5EchjlzA7sg==
X-Received: by 2002:a05:6402:505:b0:67b:7d05:60b8 with SMTP id
 4fb4d7f45d1cf-69e5ff71678mr24640a12.10.1784243376158; Thu, 16 Jul 2026
 16:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-3-yosry@kernel.org>
 <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
 <CALMp9eT2W-oPtMpFdHZi1=F5MwVpx1YWKTh4n+O=STz7N=F_qg@mail.gmail.com>
 <CAO9r8zNso+8iKgiHc_VnCnTLKor-mGsFEV1U1N=RVLdn=FPNUQ@mail.gmail.com>
 <albJNb-akQJ97Yor@google.com> <CALMp9eRGx=K+UBp76A=dZ=bD_Txonq7j8pSn9HVczdtyyuAs3Q@mail.gmail.com>
 <CAO9r8zMYDn_zY47p5Fe-tbHk2Cij1eZJ8u5w8taGoZEusm2Gjg@mail.gmail.com>
 <CALMp9eQVeEdaaZGEeXJ3S7Ycmc+s35uQykMyirnMc=7hCogBqQ@mail.gmail.com> <CAO9r8zO-n+YHyvgCBBcAT4a_h7_zLLtyVuH3K=a9uXtaeLF3zg@mail.gmail.com>
In-Reply-To: <CAO9r8zO-n+YHyvgCBBcAT4a_h7_zLLtyVuH3K=a9uXtaeLF3zg@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 16 Jul 2026 16:09:24 -0700
X-Gm-Features: AUfX_mxTRi-w3oUADoE74OidCxllF0e-Aty1ZY3qX14u2ivBbQjwp_XdH8l1FSE
Message-ID: <CALMp9eR5Bk+Y9a6RiMjejzLdGBCpsgpyp78UviJ6cqEimee-oA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 12:12=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> On Wed, Jul 15, 2026 at 11:20=E2=80=AFAM Jim Mattson <jmattson@google.com=
> wrote:
> >
> > On Wed, Jul 15, 2026 at 10:45=E2=80=AFAM Yosry Ahmed <yosry@kernel.org>=
 wrote:
> > >
> > > On Tue, Jul 14, 2026 at 11:32=E2=80=AFPM Jim Mattson <jmattson@google=
.com> wrote:
> > > >
> > > > On Tue, Jul 14, 2026 at 4:41=E2=80=AFPM Sean Christopherson <seanjc=
@google.com> wrote:
> > > >
> > > > > What complications?  Advertise the lowest common feature set for =
the pool, just
> > > > > like userspace has to do for literally every other feature.
> > > >
> > > > The problem with passing through the number of host ASIDs to the gu=
est
> > > > is what to do when the combined host plus guest usage exceeds the
> > > > number of available ASIDs, particularly when FlushByASID is not
> > > > available.
> > >
> > > I think that particular scenario is fine because they are two separat=
e
> > > domains. KVM assigns 1 ASIDs per vCPU for L2 (in this series),
> > > regardless of what L1 assigns L2. We flush that ASID if L1 changes th=
e
> > > ASID it uses. We can use more than 1 ASID in the future, but I think
> > > KVM will still allocate a certain number of ASIDs per L2 and the
> > > domains will remain separate.
> >
> > IIRC, Hyper-V uses two ASIDs per vCPU--or, at least, it used to. It
> > might be worth checking to see if that is still the case.
> >
> > > If your concern is the fact that without FlushByASID KVM will do a lo=
t
> > > of full flushes, you are right, and this series aggressively falls
> > > back to full flushes when FlushByASID isn't available, rather than
> > > using a different ASID like the current approach. My assumption has
> > > been that we don't care about performance that much on these old CPUs=
.
> >
> > ...until someone complains? :)
>
> I am not sure how many people run VMs on pre-Bulldozer CPUs and care
> about performance, but practically it's only a problem if the full
> flush actually makes a difference. It is possible that the TLB is not
> big enough; flushing the ASID vs flushing the entire TLB makes a
> difference.

Well, the current implementation (one ASID per L2 per L1) already
flushes the entire TLB every time that L2 ASID is reused. Performance
can't get worse than that, I imagine.
