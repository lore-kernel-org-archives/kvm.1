Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F142BFC85
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416813; cv=pass; b=U8rzjxV/qxH3DJe4DVkRlPWHr5T6uJCQdCcnY26smEGM4z8OnfxtllV94z+wNQkCI0O4VVjqCSPAXIWbl4gmHRkkRo2z0Ig9gRUWLwXEaHBM158zrndiaLll+YtPMfprjRSJ/o2l8RYX1U2gzvlKQsdQoUiXHZObzNYhI48cqBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416813; c=relaxed/simple;
	bh=/mZiLUYMjIePv3dqlxqei0TgnsDjFK+hjpawZr8xajE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Px/qX9PBOgVA3f9cHPveZYzqNgaud3pg5fO7i70jiIzJsTtoFQyanBq4+2bUcL3mB194POLm2BRJRIo0g9t5hsB/W1FHIhioHt7pz6IXY3l2yCiBhfcVpxIROAo+hsSbQIn0cvxZ0eWSFq+ilCdDW1TyIvo/b448EJbDvXZdnEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JlWCZp9H; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JlWCZp9H"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38ddd8d3b7fso92635051fa.3
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 15:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777416810; cv=none;
        d=google.com; s=arc-20240605;
        b=Tz6nwt95gBRo2Ol8V5MYaINUFKyZ8mPTuAkd9GuDpE04eyTRopKS7llsEfV8R6XsZm
         8LfT3vxCluMUqTRg1VI1ClzbYrLBOokA8ie7WfUM9B4vY8KI6BPIIzX3noUSWwAj0X2E
         0vNJ0qKS/SYHc1R/fbN2JW4Tk2/98W8JDm/ac5jQJy7eQY2molMSQ1Oak592Dh6Rtehx
         zp0a2ujtFSgPo720vs/LYhNUMCyx8eNA4HuOIVB2gx3sXbT8Q4gGjoK+rRj9Xup49YS2
         LIHvi4nrlBOjHOh/MHFKyU7q2Jb4Eg0LaCdaevwJWlv9OxR0RvGMFPT4w0OOUxA+ZoSm
         P5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gCMoPkPIjy6kiY/a1DllffhMFIvPwXuiq9EBnYCEpV4=;
        fh=wWebJEhW+UKokYdaXOXRRBYGTIjzg/2Fd1EnbcPa1B0=;
        b=AvB5eDeQ/mp3t+Er7zS6TAuaIwtvFhB1F8PqTiKLmZ6U6AZq7i44aqWrRrFfe7Pmnh
         Ma3pvsgm8VrFLz1gmb8Q+VTodLX4NJvqYS/nCpzmky2/1i9Jh0s/27CKAtxSFIGSU4KW
         sVbL5cVXIDBDqjmOfgKNjD+mMdgwjXwxH9O5fjmqJ69xbfBYOhr9qskjzAzqu7gGz+7y
         RMwfVtdt3JlN5mpeyM7Y2StRfCeQcaEwQMWRN0rbOUmhQunjONMpL8ObqDCsruRPnaXl
         2xOwUX4v2QKtES75s1RpOb1Kh5rb+kK1Wtixjc3Y995HNnb5lN+rBz8iG0m4xgCd9142
         TW/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777416810; x=1778021610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCMoPkPIjy6kiY/a1DllffhMFIvPwXuiq9EBnYCEpV4=;
        b=JlWCZp9HLU63dA+gLbdvehv5mgqeUB3ggJqAvkVYNRdib5pan21hmTGBt+PVIviiON
         /zpkvLYY3YuiGVGurwPAFuP44yJXMpQIzKNeAqSG/33g9JijdFJbMBsrDfiCYRrU5hOM
         GJOZOiMED9fCmUatmKhWZtAeCJcjWg+ogzReJ3EcJ9v5jrMpMkznnIFP+UyNCetwMT6p
         q4I5R4IJSy8846infjU8i/SoW7TO88Nz0y7onqabRKLo2YWNvXKA/VbuPS5ZVCZUsEcP
         oSjIo0Rr/zHMPv8jHl7Zt8LYxmurzr7mZXWZ6+vZ1B9vc9SzZUpBL9jPoVzFZbqgiJeg
         ej9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416810; x=1778021610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gCMoPkPIjy6kiY/a1DllffhMFIvPwXuiq9EBnYCEpV4=;
        b=MQEIgnQSaeNk8CmZ1UCU1svFr+G62+evFJ+hwym17zs8HMkLBNdm2DjpqxlRPkQ4yq
         wLIsuuxx+w6iEcYKcFRcWap5mo+qQAiCoYc/FU4hQm/bk5bQxMjQdNlqZVmyzDfbzCA/
         DN0nj5X27rJZYMIZaEaCV/FO8v4RNh/pWILBtwbu43y+VsQJ86TFgNguOfh8ZiHQiW7H
         e8VDuEonDT/4wPijQnxaKo3BqeEtBWU92PfCBWc5692tZrGOQx+ECr1EWHmx44rRBINQ
         H1K5gP53EPyfVXcrfQgyZQV1fd99b7/ZXX978pabh41OEQ/3cNx7vEOszMMpVXQwsom5
         2h3A==
X-Forwarded-Encrypted: i=1; AFNElJ9YhH/8aOY0RCJgWFudAQy1Sm7OZQE20EdU1zeCYPYt3Yclj9IJGZxnuClHkSn+AT8hqaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGo7E1b5tuqufBuj1aYIw+FDdbRmPqhGlaDk+DgfccoqM97/5
	WNd7hIsn3wVqK9NuiKtzcSRmNEJ2SGcd7/I8N/FRR3jBKdihgLRDr/vIx89Is+mkqXXalzCn+8U
	49pKAB9oZtb100XOfLCy8t81ubAuXe/0sLANN3z/3
X-Gm-Gg: AeBDievHf8WZgQq36wxkgaZPXa/v9nZSTjwClSjUQVNjrDU3Dn6Cqlj5mbGV7wmaD63
	9HApYOl1V9Nv6QrtMmiKQsFN4Jdl1b/EVhYWOQreRnrcmVPXiLMEzic+/WipbKi5II6oQWfcU9i
	3p4jI89hBH/O+hHC4DAzEOa9nUgs6bqBKnwmG6HH4NOTKIPA5kPe8q2Dp3FEhItTtVntvXma1DB
	TbA7un5Iodf4BuFY76bxZPhLP1bOqaxmr1pCDC+TtdP53i+4c0PWcLx4TAjKjuDS8ynjxrnHJ5F
	gwtQGd+9JJAwSrEGAulc1VxNe4VF4w==
X-Received: by 2002:a05:6512:a90:b0:5a4:10ff:4e0d with SMTP id
 2adb3069b0e04-5a746407d4emr1588789e87.8.1777416809842; Tue, 28 Apr 2026
 15:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202-vfio-selftest-only-64bit-v2-1-9c3ebb37f0f4@fb.com>
 <e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com> <20260427231217.GA1670652@nvidia.com>
 <afATrrjqt8zj2plL@google.com> <afEEN_4ufBcQld0q@google.com>
 <afEQDT_nv0kdlaBU@google.com> <CALzav=ecmNh6bE88oCHdmjSKK_Zpd96b84HbtmkaiDNRcotYfw@mail.gmail.com>
 <afEusUxXDpFtZvV0@google.com>
In-Reply-To: <afEusUxXDpFtZvV0@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 28 Apr 2026 15:53:01 -0700
X-Gm-Features: AVHnY4KROHtcyZ8U_dHsYJqSV2d56G01Fv3HTYG7tHEcHveDjakYQKdw1QYHfig
Message-ID: <CALzav=e08+Kh60daAM=A7rAwRU-SFs8m7k2JqSb6v+=T9RZGSQ@mail.gmail.com>
Subject: Re: [PATCH v2] vfio: selftests: only build tests on arm64 and x86_64
To: Sean Christopherson <seanjc@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Matt Evans <mattev@meta.com>, Ted Logan <tedlogan@fb.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 3:03=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Apr 28, 2026, David Matlack wrote:
> > On Tue, Apr 28, 2026 at 12:52=E2=80=AFPM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > >
> > > On Tue, Apr 28, 2026, David Matlack wrote:
> > > > On 2026-04-27 06:55 PM, Sean Christopherson wrote:
> > > > > On Mon, Apr 27, 2026, Jason Gunthorpe wrote:
> > > > > > Even though this is a 64 bit build.
> > > > >
> > > > > Heh, it's much funnier when it's happening to someone else.  :-)
> > > > >
> > > > > KVM selftests went through these exact pains.  I'm pretty sure th=
ese are the
> > > > > relevant commits (the empty targets one may or may not apply to V=
FIO).
> > > > >
> > > > > 9af04539d474dda4984ff4909d4568e6123c8cba KVM: selftests: Override=
 ARCH for x86_64 instead of using ARCH_DIR
> > > > > 67730e6c53d70fb31618230f81c4acee9f72eaa3 KVM: selftests: Use cano=
nical $(ARCH) paths for KVM selftests directories
> > > > > 43fbd8cd389faa9760c5152b1c58e893c812953b KVM: selftests: Provide =
empty 'all' and 'clean' targets for unsupported ARCHs
> > > >
> > > > KVM selftests don't prevent 32-bit x86 builds though,
> > >
> > > Yes they do?  x86 is an alias for x86_64 (or vice versa), and so the =
i386 target
> > > gets binned into the empty target provided by tools/testing/selftests=
/kvm/Makefile.
> > > And KVM selftests most definitely don't play nice with 32-bit.
> >
> > Are you sure that x86 is an alias for x86_64?
>
> Well, I was quite sure :-)   But scripts/subarch.include disagrees:
>
>   SUBARCH :=3D $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
>
> as does attempting to build KVM selftests on a 32-bit host.

Yeah that's what I was seeing as well. With that cleared up I'll send
a fix for VFIO selftests to allow ARCH=3Dx86 if __LP64__ is defined,
which will fix Jason's issue.

> > If it is then we don't even need the __LP64__ stuff I posted.
> >
> > But when I look at the top-level Makefile and imagine running make
> > without setting ARCH on the command line on a 32-bit x86 host, ARCH
> > will be set to SUBARCH, which will be x86.
>
> Yep.  So the big question is, why doesn't anyone complain about KVM selft=
ests not
> building on 32-bit?  Because they most definitely don't build.

I guess no one's building on 32-bit hosts anymore? :)
