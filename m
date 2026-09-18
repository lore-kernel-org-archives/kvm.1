Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5804ABBA4
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729841; cv=pass; b=nKYyWncS3ZP2A739WZGuTa2druCgYHjqltOANCVI4uv7A0I3JNLuQsPi2xVR1YlVXj5UyM+UXjPT6YPnYPx6hZO4RL0vQi7xVzx/BWAKugHgrqNxi1X156DkHvvdKimR06/ffiEMZ3B5SYm7JAvHSVvQ8oy+uOrv3DJNbd65D3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729841; c=relaxed/simple;
	bh=D8NQlMTkB0EOhznxgeBx1U32SLb3Dti876hh7jNPEbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ztk4Xf+mhPGpkL6eV3D8C3DO91RYQnVT/xJjXVQDCe0c9kd6fonkiMvUCAAy+Db1NCol1FmWh8B2wC0teQ0ElNi/ch+RtjF8lueQN4B8RT+5p18bkj7B12YcmHnJkVo8i8LA9pXk66tJuXQKzarj0kM6KaxxpF+xdzW7NCa47ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GKSzWx26; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKSzWx26"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a5f9b036f9so5126a12.1
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 04:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789729837; cv=none;
        d=google.com; s=arc-20260327;
        b=ZlavSk/Wyj0kfLyis+bTlR15P0LtjvtfHBUYcMYPvkwY56iy+D4VFq7vYoSvJNuJCB
         O+dF++icq306/J+cj/WhWM0oKtogIx7wFmz4pq673/A8SLurURz9ZEttdPx6Yv0DkBsB
         5s7Lh0PD0Zb3IsIpyLdYdUY8f9oMFVZeC/z10MilN8hS5lyxvyrx3q6D7SZqtJVs3ytH
         /hzg6CWjMhl+ast6f1IH8BmvcUBC7XHb0zOpoEKqFGvE9N6UfZob8LuEKZilV095pb9z
         iG8/mmAnkQYny4oGe6p/qnZSSQpz2ABi3rSdtWPd3Vbm8z5VbEEV4P+FKAx+DdiCIyvH
         kJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qq/2MH8S5nK6mySG3u3/RDyzhbqeFuAbCFn+abDQdoY=;
        fh=BcvtYIDW7P01MxcKxqA0PsjZX5la0pMoYLwM+uz3aW0=;
        b=dV51INlcZskMeOp/ID+afG2yYETJ/D88rLtI3f2osrdSu2ostXDXFjTlyy/HY0XpV/
         LGTH/Z/s5n4gayJsMzT7/A//c9RjpR55dj0fUJXQMzBrjsWbFUaECdJ3qt/PgYqNLqe7
         5qTb4qZgTeMg+K/TCdqAG57lLrdlljBsvIFHXWcEn8cVdaLrINBxDIdGil/zEVnuIWNC
         ohyb6/5xUZNeCA2xBAvh42Uuztl5bFN0DM8+xZj4C/NY8NOklKCli1N9LAc9ssNglCTy
         8pLaHLI9/L15OOuliNr98LlXu89paMGzQvIUb2pthHcRQDLZzAfZz35iW2hi3rGULEV/
         Mc8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789729837; x=1790334637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qq/2MH8S5nK6mySG3u3/RDyzhbqeFuAbCFn+abDQdoY=;
        b=GKSzWx26MRfk5eV66AXJq5XBRNsa/MC5hsTmlKaDDqaGzxoVdJMOkyawIKZhVNHD4V
         GjNsGlgsknooExv/i+bhqpvtdmSPDc2MC25KLBiUzlriaoFn1CNzXqEJhQiClFKQTL0P
         ERsk1mXPwe7mqvUZat8BPA+OTwTFdOdc6kxftXBJtGO0Is2X62Tcb9q9AWsrukPLKgx2
         Y7ugiNzTsCgD/GUwVFxR6tvsT1Pnh7Qt0WRquvdwCswNOio/KxNxG76YvmqHMcZCGMzL
         8+IAGFbfmhtOG+U1yyd98RYY+NVd3OOkhmrmmwPkd/N4VtbRt+FDzXMIYclSjLM5oqA8
         fFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789729837; x=1790334637;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qq/2MH8S5nK6mySG3u3/RDyzhbqeFuAbCFn+abDQdoY=;
        b=TPRk3lG69bKXkrqj4WZm9jpUbg5hQv7b7y+mIT4fsvgILEaRL6Vi/eTYi3/c/JGM8L
         0P56r+2XIWlVwNCz1MnS9D4jxLrY9RltrFkVaso7DdBieCx2a4DSdCR9gU42Xt2x+RF1
         kXN8bEAJRtnd5FkWkcPHTtMhZBZUrAAlLAVW5eq/ICHTL1HmjWEQTDg0AS4o3K0f2p0x
         zTh9Dvab1Q2ZHdqEN9Mh0fVuBFQyDTXbhYpBTc53BCkP2V+DlNYW46sfNeUfSrpwql2A
         wm0Qbpk7loVNBx5hRkfAtsRmmemwoqvS5qdn1lEWazdvG3Vg2n6xIx3pYkKNor1K9MWX
         OLUA==
X-Forwarded-Encrypted: i=1; AKwUvBxDgAjSfAddhivKuEzPE3ejoQCjwsRKVSORI9F2zwtlWH0uOVImKlUdS6Y8Ajv64/qMYvg=@vger.kernel.org
X-Gm-Message-State: AFuF++ksKqczhExVO4MiUM//lrbcKtg0rt0Hwy5b5HwZ3AgDH6TdnYnH
	wjg/f9Qcv7EMHHGEyqyoF4xaE8MwTvouZTOiF6qaUQ9JzSuI09E+xRj9q1JxvX3G/cm0U3sbdTA
	YpYZMXBtpXlFSkMr9hqcR4bmVZkd9iRLFtQ/CorVpaHMASIHssOybDP4oiPg=
X-Gm-Gg: AYBFou06UQ/oF+fgySaj1n8k3/Zts3ybg8l5Nt59QNmSnXEE0p1ZP+6ajQ2BMg2E3Ze
	iTnzg5yFr0kT1B40LN7tHW33bDTfX3xl2sB+GjwbeCj3qfv0DcTbDKVcyw9VI0f8SgZDiy0dH5e
	LBFOIIleVvtYPr29tpfXtotfbShQmW6/J57pkPd9hHEWezHQId4EMEsdvGIZnGTnVW4JDv77boT
	HDZblEDAJ9HXXClfoSuCv78oCFN7wwu8kKSXKNd9/GpNadlwNgGzDnUrw5lIARS/EQ/7TyblOdN
	xs6HPxtPAFG5XS03+nztSsTu2zgxKRiMLH9zLLxTYK6Qnl/6SLhH+xM=
X-Received: by 2002:aa7:d0c3:0:b0:6a9:d188:2374 with SMTP id
 4fb4d7f45d1cf-6aa5221e1a1mr19881a12.1.1789729836834; Fri, 18 Sep 2026
 04:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789721173.git.zhang_wei@open-hieco.net> <2d608f82681532f3010db14ff8d4293f57620514.1789721173.git.zhang_wei@open-hieco.net>
In-Reply-To: <2d608f82681532f3010db14ff8d4293f57620514.1789721173.git.zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 18 Sep 2026 04:10:24 -0700
X-Gm-Features: AcwNN1V-rgmx99EAasoSRH5nrhUVDqdiVaLr-XvIiqfmCZLZ0zQJlJ6-mPzgGz4
Message-ID: <CALMp9eQo1WZhtCEmPhsK=BoCkeSmMfwXh-JHsq6-E0HCkOunVQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] KVM: x86: Provide INVLPG linear address to
 intercept handlers
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 1:56=E2=80=AFAM Tina Zhang <zhang_wei@open-hieco.ne=
t> wrote:
>
> INVLPG's memory operand is decoded with NoAccess, and thus src_val does
> not contain the operand address.  Intercept handlers therefore cannot
> construct exit state that reports the linear address from the existing
> x86_instruction_info fields.
>
> Add get_invlpg_linear_addr() to compute the address through __linearize()=
,
> using the same flags as em_invlpg(), and pass the result through
> x86_instruction_info.
>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  arch/x86/kvm/emulate.c     | 23 +++++++++++++++++++++++
>  arch/x86/kvm/kvm_emulate.h |  1 +
>  2 files changed, 24 insertions(+)
>
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index c1b21282187f..2972a35b0ac0 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -411,6 +411,9 @@ static int em_salc(struct x86_emulate_ctxt *ctxt)
>         _fault ? X86EMUL_UNHANDLEABLE : X86EMUL_CONTINUE; \
>  })
>
> +static u64 get_invlpg_linear_addr(struct x86_emulate_ctxt *ctxt,
> +                                 enum x86_intercept intercept);
> +
>  static int emulator_check_intercept(struct x86_emulate_ctxt *ctxt,
>                                     enum x86_intercept intercept,
>                                     enum x86_intercept_stage stage)
> @@ -428,6 +431,7 @@ static int emulator_check_intercept(struct x86_emulat=
e_ctxt *ctxt,
>                 .src_type   =3D ctxt->src.type,
>                 .dst_type   =3D ctxt->dst.type,
>                 .ad_bytes   =3D ctxt->ad_bytes,
> +               .invlpg_linear_addr =3D get_invlpg_linear_addr(ctxt, inte=
rcept),
>                 .rip        =3D ctxt->eip,
>                 .next_rip   =3D ctxt->_eip,
>         };
> @@ -684,6 +688,25 @@ static __always_inline int __linearize(struct x86_em=
ulate_ctxt *ctxt,
>                 return emulate_gp(ctxt, 0);
>  }
>
> +static u64 get_invlpg_linear_addr(struct x86_emulate_ctxt *ctxt,
> +                                 enum x86_intercept intercept)
> +{
> +       unsigned int max_size;
> +       unsigned long linear =3D 0;
> +
> +       if (intercept !=3D x86_intercept_invlpg)
> +               return 0;
> +
> +       /*
> +        * Use the same address calculation as em_invlpg() for the addres=
s
> +        * reported to L1.  Ignore address-check failures, as __linearize=
()
> +        * sets linear before reporting a failure.
> +        */

That comment misses the main point. Perhaps something like:

        /*
         * Ignore faults, just as em_invlpg() does. Calling __linearize()
         * exactly as em_invlpg() does guarantees agreement with
         * em_invlpg() on the linear address.
         */

> +       __linearize(ctxt, ctxt->src.addr.mem, &max_size, 1, ctxt->mode,
> +                   &linear, X86EMUL_F_INVLPG);
> +       return linear;
> +}
> +
>  static int linearize(struct x86_emulate_ctxt *ctxt,
>                      struct segmented_address addr,
>                      unsigned size, bool write,
