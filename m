Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32E031618C
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784914868; cv=none; b=T6vI4kt11erCmpEcZCKs6rSBAKxUrXg7AKvUHhBjFkx8Us7p5hQGxiuPGf1Q3xkH7397Bah6BdSFDx9tenjp5vOM/XwkXAFAsuuOLMf+uGl4ZMbnQ3XtwDXTA6uH8VadMOVD66pNHrqin/g5wBXl70fcnFRCL+Wt8G7tASvMAG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784914868; c=relaxed/simple;
	bh=bJx48uGczDdcF1dDiYiEPcWZoUo/dKYaMr/ZzXQkl0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTlCqyiSPKU+AHlc0WJGJ0BCNSJHqU6429FNTEa6yblU1hVcNnWbS0CDycBZ4i03ApPGp5XmKcOpL2colKOTpm7gfdpqBJw1pBIAuCJ38IA19U3GhAI1hlr74pkftQCPHIdYgV5A9NLyFVI0ZolqmHVfWqNSmjSrwMYm0FivsgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5pM92/w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5pM92/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3321F00A3E
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 17:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784914867;
	bh=y3qXYPKiwaAroTm4p5ohz1evaBkHTlxXvCd7KWm8JXs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=j5pM92/wTq9vsY8PcK6JOSITNf+ff/T9jGP/88H6OpHCqoppr1clukYo97S1kTbxR
	 uecweWmI4ASNLzyYi6EESs4309T24SdUTASFCb40aKa1O/Pz8yFFDVyrkYnyauNumi
	 z8lVmZXc7yLVeAwTXTBM3uEYIpQoymFz8Ku81faM9VpeaV5BlGUrYcgZzNWZA7YQ/f
	 0lG3QYarkfEUTg3MNQSMYCn8y8ujbYQfLlEV7O3TH6LZFdXTm2e4qZi1d8aZY5xaKJ
	 Xx0qVm8VnzCzUsvLHMTrip3bWEfr4nhdxTicz8h6CnLNjgfjQSCD6PsbKHYCmz9R/8
	 9SHqhTzOxg0eQ==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92edb12cdf2so46143285a.3
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 10:41:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr+PfTAxpj+Q1aDp0RjAZceS/fmE3pWnHADh8pYdqMsSp8RIr5yPIOjrzjiWhfOCYUkudM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw8mssu+A61UW5Fgl+ylreXmUQ15XRBKJjPFs0kb63Y/wEKoqG
	+Ua++FQxWmf7roVE/SusI7k1EH8+aP14mCvHH1wU5+nsbP7m3owRhieeo/RNSCyk6DeyfWuJYPa
	4PX6wosNxIp1Iz/sZggAz+h/z7vCsboY=
X-Received: by 2002:a05:620a:3713:b0:92f:279:5953 with SMTP id
 af79cd13be357-931036049fbmr954421485a.27.1784914866743; Fri, 24 Jul 2026
 10:41:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-10-yosry@kernel.org>
 <amOi6HdZXL8C95AE@google.com>
In-Reply-To: <amOi6HdZXL8C95AE@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 24 Jul 2026 10:40:53 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPpuDfObSx+XPiemDzM85azaWy9KOiJ3CB9+nG-L=uA0w@mail.gmail.com>
X-Gm-Features: AUfX_mxd0wNou8MluSWnYgbkB6tDq-_yihdcCfJ3n9my2CHfe7Q2dusYkunYTS0
Message-ID: <CAO9r8zPpuDfObSx+XPiemDzM85azaWy9KOiJ3CB9+nG-L=uA0w@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] KVM: selftests: Support running stress
 save+restore and #PF test in L2
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 10:37=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Mon, Jun 29, 2026, Yosry Ahmed wrote:
> > +static bool parse_args_nested(int argc, char *argv[])
> > +{
> > +     bool nested =3D false;
> > +     int opt;
> > +
> > +     while ((opt =3D getopt(argc, argv, "n")) !=3D -1) {
>
> Since the test ends up taking args anyways, might as well have it take th=
e number
> of iterations too.
>
> But, why make it an either-or?  If nested is supported, run the test non-=
nested
> and then run it nested.  While I am sloooooowly working towards utilizing=
 Vipin's
> selftest runner, IMO this is still basic functionality that should be tes=
ted by
> default, i.e. shouldn't require fancy opt-in.

Good point, I will refactor all the logic in main() into
run_test(nested), then run the test by default for both nested and
non-nested.
