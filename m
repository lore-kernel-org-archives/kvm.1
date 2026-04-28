Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1132F3CCFC4
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 20:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777406964; cv=pass; b=nd57AJmdOTB7zlDuSK1ZXKVNsi9pg59EUR8PDHlsX4rMk7I9k9Lpk7oE02nMHMv6g2WPsB42JVCKLquw9JjFsuFz9iUM6u9R3zEdDOyvhQ0SiJ7WKfNf2B6wZnW1QpHQ2B89T/3TF/huP6iXttfY80soep2kFGl2e54q9NscvcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777406964; c=relaxed/simple;
	bh=0W6NRYFjQGnhyQglFSLJFfyHW1vF/d8gwkB3LP9mXno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOX+If3yuzwv+3HTcIrKx33m6h+NqAgVtMwOs/rtWf26j/LTgoupnzFzw8bYUTVzytk6JiVs6znPNHgUfGeE0YwCi/nT04DCPk4OOxRB+7UmLqMdmuqRdt3LeZk+fdv5JMDkRGkClcN2NnLGiSTd41sGhi6Yo5dv+H8i36h+6Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p/9Z+PpQ; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/9Z+PpQ"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38e7d984096so131670961fa.2
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 13:09:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777406961; cv=none;
        d=google.com; s=arc-20240605;
        b=TMzyiIKBLdkoW6xPWDVEXOli9+AjtkDxW6n+mf+JZ+aMBXE2T2xu0OIFELKhOLXPFh
         p67rNun6u0J6hxLWzjIAYyG2vdCf2boUL6j3v0Nic5DHb2X0aczQoyweDHqHaTDbHLuU
         9VLe0cv5QvXzPAO6n//3xoqOGdpWVKxBdUzkl89YFkreTgBCTmkLahspgJUCniCqz6aC
         vTtIyVjivTrxTGaR0H7ev/z/4YnyAmqB//IUsM4EywQQCM4u/Pwwt6IInSTwb43GvPRa
         xjibIjQQVDQ4WPG46+kEC14g1/+FVNAmtGcjqyUBrb5LNIvNnA6O4JE92GtLwtMONv4K
         /cMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lQv0iUQ29KVuQJDvZZSr4tHq4TPvwEiTETZj+a1BiUI=;
        fh=x+Sg7hC2wlhFKcHRIKVGMKHLYpds7G6w5LN4shihBTs=;
        b=jzJHZDjB60DLNwuZscuYj7smraqVmdqfAz5ZzrxCkqQrSmvdX5rloDdmgQZH+7s7eF
         HvP6YgRVlpZepJMqVexYXJ0jKh3xqrFg7nVFhooNvcCniW+ijPTEuUUDKQgGsCOxyeDU
         FROgdlV0uP7pRydCisa2isH29cSLFVyJ+X20zeFnH0cZV9OVCxplhLgQ4W8XB+8IXsRP
         M6CFT2v5quS0qy+4OWvW79Lqh8sn8uIyggtzsH9WfPnRZUu5bi1LBkiLe6Na6labVhmK
         6Q8ZYOY+rKj/IEXTxZ1ik+YPqiekyr5ykOFdwS2iiBWFX0ekEcO+fN9rwXXA7DxzwEPn
         oJVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777406961; x=1778011761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQv0iUQ29KVuQJDvZZSr4tHq4TPvwEiTETZj+a1BiUI=;
        b=p/9Z+PpQ6yrec7JBO4KfT753E6HJLYXDQTROSVCBj4s0HbZMvex2kPUAb63EtAb+Wq
         XON4GGDsaabic25sThJdy+jMtBDP6quOg+NI5OBvYR1y79xdoq4qpqt979WT1E3wi3xg
         bTkXhhpsgGanrJiSOmu4G6KBagliVgxTIiHFSn8gIO/FYI1QJftGysSyvDDDV3LXsEDe
         Ilwatop/XICQh4qH7o4ilvGXwS1eJG1xIOccUUzwpqxoUmrFUU6Ear+O+3QWWAeMRo1c
         XgRfrFMH5eYU0W0d2IwFYtX0c0IbGVM/TjoDGp5212nkulrSUbqGEq6IGAPbT69oio6N
         iTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777406961; x=1778011761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQv0iUQ29KVuQJDvZZSr4tHq4TPvwEiTETZj+a1BiUI=;
        b=mDJvI384JIspltTgFPPKKIxha1N5+vKbKWeFRe2GjpEKYoMbtCKAfmGiL9/Go2mF7X
         KiNWQmCg51j/beKJEb7CWwF4i8PT1B0rtt2j6rKVYuKgEaO2isQ3elvOoyz2xdEIl6X1
         ezZqcFZl+N8zMlNpdudiN4Y02SaVCU423CTed/bmxjRa4633zXfuf7BOfexe7N59TL9E
         sBtr26dO9AAknMSU4Yj00MCt9O2HxBXKcaHWF/1KFq5UTnUddVJCjM8ZOyJEFuAPKQL1
         3UNNVGE95yUC/+JzXXUKaeYqCEBhXbEev3j76UCDfNzznb3Q0s+qdqykiHNf9Tak7IKT
         mx7w==
X-Forwarded-Encrypted: i=1; AFNElJ8HAdPRIlXhi20HCxofjFZEBmamNK9V77aBkAPwFMcUKDYOQMYpO78ZK+RVYPHYPQG/HkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3DeCBZnp68oz03aXVKSgp1IRj7NHlw4vvux1FRRaHUMata6nZ
	UJURdH9KMmzyuOkQIaCZG2jwqT6lgrAEhauRSHKNAaCvgLGbNeyPnAaiBiStU49KFxfmKph3ss2
	6eZ//HgkoBAsdiVz+/vDbteQbss1baFibetYPxBeXfU/HrpL3/x1IsMmN
X-Gm-Gg: AeBDiesv7SchqXEI/JcFqEG0ZUmDYTGd5wMPSo+FODMQasjd/mYy2b7e0CshKxjI1zx
	Q/2dhZgkqrg8bWXRvUUi8W9c++uqD6TuaeZ12V57IDX/hMRmwBgye6qbZbEtRwJgTpMW7HU1XSJ
	ImuAUGIARwu3YK3qJ1Y5XLUn65FtnddKXCHP71GuWfM3AvTYm3IQPqlJk6Saxx9xMAnl/tG/zFn
	hMZDHmMo7EPE8nFfAFlC2WrHYKCsPFIUOFJYo387B1Udq0eErg4ihVkC1UKXL8m1ZbvL5ewfZQA
	1myUZKCkdHV2cQbygPvwgEoupD2lEA==
X-Received: by 2002:a05:651c:1613:b0:38a:2f02:e153 with SMTP id
 38308e7fff4ca-392411fe4b2mr16497141fa.31.1777406960911; Tue, 28 Apr 2026
 13:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202-vfio-selftest-only-64bit-v2-1-9c3ebb37f0f4@fb.com>
 <e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com> <20260427231217.GA1670652@nvidia.com>
 <afATrrjqt8zj2plL@google.com> <afEEN_4ufBcQld0q@google.com> <afEQDT_nv0kdlaBU@google.com>
In-Reply-To: <afEQDT_nv0kdlaBU@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 28 Apr 2026 13:08:51 -0700
X-Gm-Features: AVHnY4JHVYEqeuMXhTnemoCMQimOvdWxg_oIU9vE-6Z88zRvGZF-15lHQeMKZio
Message-ID: <CALzav=ecmNh6bE88oCHdmjSKK_Zpd96b84HbtmkaiDNRcotYfw@mail.gmail.com>
Subject: Re: [PATCH v2] vfio: selftests: only build tests on arm64 and x86_64
To: Sean Christopherson <seanjc@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Matt Evans <mattev@meta.com>, Ted Logan <tedlogan@fb.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 12:52=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Tue, Apr 28, 2026, David Matlack wrote:
> > On 2026-04-27 06:55 PM, Sean Christopherson wrote:
> > > On Mon, Apr 27, 2026, Jason Gunthorpe wrote:
> > > > Even though this is a 64 bit build.
> > >
> > > Heh, it's much funnier when it's happening to someone else.  :-)
> > >
> > > KVM selftests went through these exact pains.  I'm pretty sure these =
are the
> > > relevant commits (the empty targets one may or may not apply to VFIO)=
.
> > >
> > > 9af04539d474dda4984ff4909d4568e6123c8cba KVM: selftests: Override ARC=
H for x86_64 instead of using ARCH_DIR
> > > 67730e6c53d70fb31618230f81c4acee9f72eaa3 KVM: selftests: Use canonica=
l $(ARCH) paths for KVM selftests directories
> > > 43fbd8cd389faa9760c5152b1c58e893c812953b KVM: selftests: Provide empt=
y 'all' and 'clean' targets for unsupported ARCHs
> >
> > KVM selftests don't prevent 32-bit x86 builds though,
>
> Yes they do?  x86 is an alias for x86_64 (or vice versa), and so the i386=
 target
> gets binned into the empty target provided by tools/testing/selftests/kvm=
/Makefile.
> And KVM selftests most definitely don't play nice with 32-bit.

Are you sure that x86 is an alias for x86_64? If it is then we don't
even need the __LP64__ stuff I posted.

But when I look at the top-level Makefile and imagine running make
without setting ARCH on the command line on a 32-bit x86 host, ARCH
will be set to SUBARCH, which will be x86.
