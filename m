Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE893D1CB5
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778797898; cv=none; b=ShT005BQ+X6fGYrc8fxH1q3JwkWkA95vM7TBm/3cCIKpvdcOUGAmB2+PqCspwg4w1i+/h2bxhqoQx3QonraE9HcjaFTX8NRyNB/KEOMMzqGNL29nOf7wuRFsSVyN+ONWKePed5Gf6/yLVjFsrKjVm5hb3JmQOwZmcnqWXH2Q5EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778797898; c=relaxed/simple;
	bh=kYpL3KO6nhgGxbaCQUv495cG5madHk3ngqS80dVPgRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+cyujNJGYrIZCzjA7gz5qQLlKvXKdE9foLAUbkfdfjK5zRrTFHmR6RIxOTYhgoER9M/20gVYkTxUKF6hIGUfe5yDf2tPpcMPttbbe4m1Iip5ozpsRJWoUZ5j2SKeL8dARYXqSE7iJ15CQTB4UTXRSDqkEB98KE42pXMmYkX9ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2eVK/n6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2eVK/n6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80339C4AF0C
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 22:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778797898;
	bh=kYpL3KO6nhgGxbaCQUv495cG5madHk3ngqS80dVPgRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A2eVK/n6R1tYHdFhawtQgosqpzzpmws8s1xqiUOevSIExOIIFU/mHLogC3MF2Nqnz
	 KVnnSLrAkdeTXrW8/F33CO83DNPJgJw9kMw1nHAKiB6rWgvswWNoAOaTz4+oBZf8Rt
	 koFCHpqbVShQa32LpaeIRIzoG4BJosIFeRymjcYzI3Heb1Kstgfm29HEoKhvCZi5Z4
	 ODRC/wfCEpoOV9/xkFVyNFVAcPVuNYRA07dTN3afSl2bP6PT8eejXE4eEtHekKV+Nc
	 N+NRlKuRHekwpI30PYFhhaTzrjT37dv1jsIg6gxCfpUiVpNKow765dJR1xl5IjxTfl
	 9/uUr1suhlI3g==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bcc2b199c17so814028866b.3
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 15:31:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8iPlU8PK/8685Qgzmg30uY2yKwx+2gV7/Dn9rOXlDDkc9ck7O7wBXZ4s9Ro0YFxJClxco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmwF6+gPT8ssr1JkIws0A7N+NZorwf+MkZrZFltyWTU4vMJV9J
	O2goEjNOQUZGSwcQ/rl/5v3RPpCJH17Z3bdeAe+POG/XEglHc+HT68UwNmGMiYvSosdRlpavcbX
	8a1DI18FNI33ZqjVNvhF0Bq9hs6Mw/5E=
X-Received: by 2002:a17:907:6d01:b0:bd2:b983:96b with SMTP id
 a640c23a62f3a-bd5178652bdmr60705366b.20.1778797897454; Thu, 14 May 2026
 15:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com>
In-Reply-To: <20260514215355.1648463-1-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 14 May 2026 15:31:25 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPGgwH76o7QqzrO1qrDn52G+R2LCb2ivCNTSbffakpZdg@mail.gmail.com>
X-Gm-Features: AVHnY4JmoYbQLWYguYWzsi2Oufy2BIlerhJ-f8lbLjqtQn5MV-AXjynQUh5yMdM
Message-ID: <CAO9r8zPGgwH76o7QqzrO1qrDn52G+R2LCb2ivCNTSbffakpZdg@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] KVM: x86: Clean up kvm_<reg>_{read,write}() mess
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Kai Huang <kai.huang@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 2:54=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Add proper, explicit "raw" versions of kvm_<reg>_{read,write}(), along
> with "e" versions (for hardcoded 32-bit accesses), and convert the
> existing kvm_<reg>_{read,write}() APIs into mode-aware variants.
>
> This was prompted by commit 435741a4e766 ("KVM: SVM: Properly check RAX
> on #GP intercept of SVM instructions"), where using kvm_rax_read() to
> get EAX/RAX would have (*very* surprisingly) been wrong as it's actually
> a "raw" variant that doesn't truncate accesses when the guest is in 32-bi=
t
> mode.
>
> Aside from my dislike of inconsistent APIs, I really want to avoid carryi=
ng
> code that's subtly relying on using kvm_register_read(...) when accessing=
 a
> hardcoded register.
>
> Fix a handful of minor warts along the way.
>
> Oh, and introduce regs.{c,h}, which just a "minor" addendum.  Yosry point=
ed
> out that moving _more_ code into x86.h was rather gross (especially since=
 the
> code split was super arbitrary), and it turns out that create regs.{c,h} =
isn't
> all that hard.  In the future, I think we can also add msr.{c,h}, so I ve=
ry
> deliberately didn't include that functionality in regs.{c,h}.
>
> v2:
>  - Collect tags. [Yosry, Kai
>  - Fix some truly egregious goofs. [Binbin]
>  - Rename kvm_cache_regs.h =3D> regs.h, add regs.c. [Yosry, though he'll
>    probably yell at me for saying this was his suggestion :-) ]

This is kinda sorta the opposite of what I suggested, but sure :P
