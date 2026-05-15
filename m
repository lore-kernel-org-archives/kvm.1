Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D94E380FDD
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864786; cv=pass; b=lM2zTWFr1/7PVyQBIPXTA9+YZrgtyD7oOOL9uFv7efHY8M2FTjIR4iQqlm+7DfgHwQmXiCqJB2S0+/CIOZHGTjxbLTboJKfEd7Pw/m015fkTNmpRs8XwxRjclSmvFgJ0ZI0HtAgpixTMr2dANqoXw8/xMR64COhrMQEfxsSmtzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864786; c=relaxed/simple;
	bh=lqUqDVLjxlyvI4+IYr/wIjm6iDGhMzEfuVsVuO+6rh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGO8alb5eOuZcQn2BWfJzGVz7wx2zgZS/w4HH791Bc9MjmYd8vJG+chPEoYpXwjzZqWOJRgkFCvy2EeWans5OkUggRp2QbivMQqzyEk9R3yvUpzEj4vESrgYuIPUSW5DI5sHdDr78q2jVvGnpJAt48z0n38QxpZsR53K76j2ODo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWKUzibl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdCy40V1; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWKUzibl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdCy40V1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778864784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVoN6gZjiPtoPMWPDHhoDBkPrb0CWAvlW8FRBzCBYkk=;
	b=hWKUzibleiBwVVf1DMncTWrfQTfPRBgUODvidfQ11NNnzXfIGH1VAE1VaZFykhzitKDx3a
	HWGMZy6Ec/51Cygr+beDdi9u+ymMILGKBBtQegusuWy4/nVen6LjU5plP/mA3YT2EY9p4J
	pc0+LlF2R02iBxNiH8WpTxOoVNXK9lI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-AnNKzEmIOJCbVsmH4pqJTg-1; Fri, 15 May 2026 13:06:22 -0400
X-MC-Unique: AnNKzEmIOJCbVsmH4pqJTg-1
X-Mimecast-MFC-AGG-ID: AnNKzEmIOJCbVsmH4pqJTg_1778864781
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d789cebcfso774529f8f.1
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 10:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778864781; cv=none;
        d=google.com; s=arc-20240605;
        b=IUyV4hlQjx/BhCL9/WzGl3WtNNWsXKQ3Ss0ut6giumxKchQ7gcLyrk/pKKISqEU9m2
         vrU3XjgojHwUnCjXFwmOPvKmmvXnFAlC7scpi4eWZDLHGi19Z5FdsTW7m7p3VsQsG/rm
         EbKLb6xnO9gH7G3Gz/dgmbIrPtX5vx39i1HzCXl/Tsg8vEjoP2XrZB4SB6jVNhgr4FnN
         a9iI5l4F2onq8zxcD7B7C06TyHtzI8PM7HXeovx6R+/D3k2FmaVXkBY9nhelFBpXsq/l
         dTbAScJMOLgQRW+Z2L9PUBMTmKhlwUErtDXCfeh6Yn/MJ+ZAxsQS1JSw12RT9wKYnuIx
         TV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iVoN6gZjiPtoPMWPDHhoDBkPrb0CWAvlW8FRBzCBYkk=;
        fh=by5amsj26I+1TOCyiIl3lgYnL/ljkwhqLVmILn7eya8=;
        b=MoCbc/cQhrbyT/OtvSQqPfAdTs6NCvT2eGyVs0i887G2UVPQtoX39fKvQU2q8tYOxa
         /iQBUx+LVcRH5XaMhwCDR92M+EyaCNFsVgCaj4QbUTflmElRUffoTBdwcwz/ICSWA0nu
         3+I9O6CWpo9L2IrCrrEFHuhvqVJF3DPuWc1+l5VDd3PjDsNzYOmRiu2N7xdPN4jakNTC
         b+pTF/0UQiOLWdiR50hJ/9baF9oJ6oJzYCj2BlA45v/N/7h8zVweOOk28GSIRMPPWp8m
         yhwJXz+yPEnFXTsG3ZlK7t/h3DMSl2VZIm0MRcsIIl+QIOo8ouK0hHJFgkx/kgWUWnJg
         kv9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778864781; x=1779469581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVoN6gZjiPtoPMWPDHhoDBkPrb0CWAvlW8FRBzCBYkk=;
        b=BdCy40V1YyDK6ojPH1tzENj0xO/s5JKi4xzuxzNnPTJ50x42MRjWAw/mvHivdSvBHR
         CZE389lK/D90E9kFwyG7k6ccRw1aP0ByeAdRCzo77S/774SjOz6HvUc++M5dWUAPLCMu
         r8Lps3QfUFjO4mIlqQLEcmEB+zExfnmICYJZq1CU9kO+LSsy2BSFYAggtMg2wHVAuNNI
         FoUF2yr4COH0mSH1I+dBJKi1cC4O5Uy3yW+WECUHfqWmc9C5pMdfZpXpKhCP5XMd4n0C
         rkeWZGWDuuCOsi5aHL/0a+cpXY1quMOIqptoYJzBIBedWhwVzHy2TXaaltNMDx13hHpH
         SEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778864781; x=1779469581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iVoN6gZjiPtoPMWPDHhoDBkPrb0CWAvlW8FRBzCBYkk=;
        b=AsPuUStwoXOO9HEjKU+AP3yf0o8TpqALM+C5Wf36c6kVj6K+L0+08GuRqLpKY80QFO
         GchNk5JzarmrUWUHV4GHOWuk/XhiQDGUi0mHxDszEDvc98EPTbqQkDXdANzA0OKScOkH
         W8ZWAJLLRcQ7LUfHCk6djwiGtE47gBFdwvqtnSWNe/pL0idZK6BmgLc4DHOlD2Ckh49K
         2WcxGVNTlzYA/AQbADKhynIJYWMyMmgAewVQmoBp7WjHSz/TWDGMintzyBP/VZC95Q2+
         1GbOuUEKb5DmIeWC+abnm+jzY9DwatYwfL0gp/ujI7icDuRO+/cpQ9AWiA27tHhBtzZK
         zj4w==
X-Forwarded-Encrypted: i=1; AFNElJ9dr6txe8pq0P9ThetL3ohKDztlF09/uo7Ks2NxDoa09obfvQpBSXGUfWyEfR6qOL6hGYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHpU1JPTlM+7hESjLsPM8FTe0rjA/nwKl3nAlEQ/2+EK3HKwiN
	eDXR2nY1bZxuWcE28DYdDXxZ3b3JU7WX5YIkO2IbfDQ+gz1uYOPHzstNb7zMmHBGxJpp1IEj9c3
	D1m77HC68JiK9rjOZr17hIQDywPR7ZK/EQxNkNqWGAlkVknbd8kXgML1Y0jLdlqysWPp0vV92Iw
	ODRzRZ2IXtTFliBBWQ3HgOtLP4e62S
X-Gm-Gg: Acq92OHAeZBl4aPIod0pO+Dm/cRZH21lA5jmfhbSy8mxf3JBeKvivxwUo3YSGxvOF5B
	HMJvsLubDj3h6jylIlc5hQfaEthMhOCO5POhDWcSD7Yp3ZVieyCEiczDiN45jQY0hNbcqkhyT3W
	wNePDl9ZQJgn77R0Hioso7mZcZXMJ4w9ULnx7t1KuSTRn77bGbG8am9C0AGYEDeIacy0TyY/1is
	P2PYbgYj+IfezjWIf/Qq82g2ZrAdDcDqy4j1mj0/pol5xuCKu72mYakuXbgxqqswqlbzaQfoggV
	wn5oNGOH
X-Received: by 2002:a05:600c:570a:b0:48f:c649:e6fa with SMTP id 5b1f17b1804b1-48fd636a2f4mr92612245e9.15.1778864781015;
        Fri, 15 May 2026 10:06:21 -0700 (PDT)
X-Received: by 2002:a05:600c:570a:b0:48f:c649:e6fa with SMTP id
 5b1f17b1804b1-48fd636a2f4mr92611925e9.15.1778864780572; Fri, 15 May 2026
 10:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513174948.726812-1-pbonzini@redhat.com> <20260513174948.726812-2-pbonzini@redhat.com>
 <agYi2Lc7UbGiw_zL@google.com>
In-Reply-To: <agYi2Lc7UbGiw_zL@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 15 May 2026 19:06:09 +0200
X-Gm-Features: AVHnY4JIx06im2uj2tehz4wrt_yn17jb6nWdM9LHLcU-NhmELFsRS4h7mRzeRoQ
Message-ID: <CABgObfZk5mx1SLf-WgehYckSAoFvnCdWL=Xpt_fHFJu2jVVj6A@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: VMX: Macrofy GPR swapping in __vmx_vcpu_run()
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	chang.seok.bae@intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 9:30=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, May 13, 2026, Paolo Bonzini wrote:
> > From: "Chang S. Bae" <chang.seok.bae@intel.com>
> >
> > Convert the repeated register save/restore sequences into macros to
> > simplify the VM entry code.
>
> This is not simpler.  Maybe it ends up being less verbose, but I don't se=
e how
> anyone can claim this is simpler.

Right - it is not simpler but it is (a lot) more compact and
especially less error prone.

BTW, this part:

> > +#ifdef CONFIG_X86_64
> > +     .ifc \r32,%r8d
> > +     \opd =3D 8
> > +     .endif
> > +     .ifc \r32,%r9d
> > +     \opd =3D 9
> > +     .endif
> > +     .ifc \r32,%r10d
> > +     \opd =3D 10
> > +     .endif
> > +     .ifc \r32,%r11d
> > +     \opd =3D 11
> > +     .endif
> > +     .ifc \r32,%r12d
> > +     \opd =3D 12
> > +     .endif
> > +     .ifc \r32,%r13d
> > +     \opd =3D 13
> > +     .endif
> > +     .ifc \r32,%r14d
> > +     \opd =3D 14
> > +     .endif
> > +     .ifc \r32,%r15d
> > +     \opd =3D 15
> > +     .endif
> > +#endif

is dead and can be removed.

Paolo

