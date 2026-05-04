Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57003603E1
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777930837; cv=pass; b=oXLAJMIuQINcogjD3KtjNM1PjiEqeDugnqEXEZJyyZVFRSqEZwP87foZnuJLiJKNOQi0QdSdJ7NBdIXZru4NRmiLMDNoxllwrZPI47QORcaBkQUFSrTjv/xP7EcE3dpSPrCk47DTsIb5dLTovJ344ROdIu1FgQo44bSp7Pr+pUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777930837; c=relaxed/simple;
	bh=Ld/LlEcorrolam1YE/IxVJLvik1dqmhrK0l7FZfLbwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kp/nXlbgzOpAhRzRaGWsNpTIXFdCRN0bh9OPDNBUybBYqi0NxrbrtHENyahw/y/LUOYt5e9w6Cvg5Cz5uvVGKT6+v6Butijn7uce/QH1CIZRlVmmfdDVAJMB54EhuRfsOC1wtixdCbQSIOFEf9OsNxKnf5JPvzcEp5Zquaaq4+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0A0LL7E; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0A0LL7E"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7dcc9b506d9so4470378a34.1
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 14:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777930835; cv=none;
        d=google.com; s=arc-20240605;
        b=YqcpwRJEepPwqwVdR8pxTezdHR3ai00QlVRvyMfoeQuyyKToFsj5gChBBLpalSaijF
         Mn1vy4BhKcFusnEWb8w9bv+7jO6z/wwkY290ECWgx2N4tRGa9hzu9A0ULXNwShm1SaWd
         xpJRDuwJV+RTH0AssR2MBaPX4pUZZVax/cmzUzyXcHwLbGvCQPTRDHSswZbOjp3N6OJ2
         x1icEFU9/fJ0y0+gQ7jfLX+h2jUjz6Hmi561xwyGdfZCfLlJLLQEfqRzQ0MVrORpk8BE
         vq+yNAD4DTTQ+wxkdLkHb8s7+EvYZ47XMjoCUFJTEfCIQTOBaBImpHlgscR2/Hlmy0sL
         M46g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O6+fBRwmn91m7bKwrvqg/u2DaVnZzqIZNZQkz4P/IjY=;
        fh=LXNRnmNfv3V41mmX0K/qQ1eFe5GArTQU8I4mEOU3MyI=;
        b=jsbbiWUYO0tLT8wusFd3Tr/UcYE/9LdWELBjLuKhrhqykAX6beRE3cT8YE59veP9du
         b29XMnAA8qdVxy4nnVJ0bizXDl+dYXUUy6lfQGd52wdAWU9b/rG0t4quYwa/7vbDmKDi
         ws9I7XqH4Z+B6VbIdSUQurXglpBGs4fAdWSvceaQREe3Mo5RnQ/4g2/BAmLB8g8WtBqf
         eLpEXAk2oFRHqxpCeHM3KkQ+36PuiwJ2gYpfBs/hhbsayDiViUVqsScJaJNwagdb+K3M
         rpYVB+rCUoINZi1N1wFU7mo4FoLjBMP9O49TpjbJmxs9JcCDC1qrF8UjyGNk2PogBGWp
         HPAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777930835; x=1778535635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6+fBRwmn91m7bKwrvqg/u2DaVnZzqIZNZQkz4P/IjY=;
        b=I0A0LL7EWimP7llsOGkQMq0EYBNcedqFUHQzEzUXOjaoS1OlCxUJnbO0TdvpbYkT6Q
         5O+NjJKNZzctpfRYoDl/GcZ5YyQLWCtfv7wZqzhHd1aOShOR8lsCJuDRpKcaNYQP+W+C
         ftZDKoWXonjrYywKxJ6eNTv6wOBFTpjj5rPYKWY/PeJrRIVnahHqXeXqCdeEjCm8iue7
         ebVzQ1i4mPwsvflM/giocfPh/wMQfl2+9iQ3ZcZLqy0DvzdrGu/L1VONvwQzbVVYI1iX
         1HsvUB4slHnRQZmI3jQPQpB8Eta8SsgylMjKa88RX674v14XVh2eI9G7HGgvaQxeL+tW
         HEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777930835; x=1778535635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O6+fBRwmn91m7bKwrvqg/u2DaVnZzqIZNZQkz4P/IjY=;
        b=rya5CAoGrL4CKGAE/xMx02DBv42WGt8pyRkTQMabZcFyTk5rfR/wU2duIEIbsH1OI+
         mTdYI7kuYiKO6wQ8MgYjOtwQUDGPaM/HB+ffE75obTcgIN7z+zNWn002mhJPRA/0FonD
         gJyqbPNLgVZo37QV3winrBZ4HovdQlVDOn7QsBQoa2j8B5NznK0OpeDvPE1hEW10JpdA
         TWUb1UF1r66TNrA+LJjw6Y9WD5vQapyJ3XwTyu17l8B2aKFafqwmOJ/+BqbvNfpnA5Lh
         3wPhhwfhPeh49C5XiV2nePP/EjY0trtZP9ZX6tbfB/pj7Ulz5yPC4LFafXyNSZax3xik
         pQOA==
X-Forwarded-Encrypted: i=1; AFNElJ+fFdy9fjqUvb7zxBR7rWYbE7x0CHJoRpN941nVivwLZx0zGQ8OZfeVpw7UPGsKjjyPRDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSpwKXSEVh5j+H2bhFI7j9DW0IaZcFgizdB/e5ERoyrOSrZww/
	El4DJGYd2XvkdbMp5ebzUDqtL84WUn25KKiJhD7rUB4JdsHVz+8gmJQSmqWFGbEwXJSK1hjT19T
	JVEa9qMpAePWky4pMKk+2OgDkhw9itHU=
X-Gm-Gg: AeBDietJm/lAORytZO/vdXd580Bu1Rz8DFefwt8EZlOh7mp/hR5fK5kzjOA7KnFOxi9
	CilmMtQKhrfDd/qCxfYNkQGpHuaEEMn3jhcZebug4kYcJemudj9DFVf+4NdtVs1ndu0KYxqHzHS
	B50Sv2rMiVVshtomaeB/hPrXmquQnxBXK/YFWbgrqeKZPxQr+WTsuoZlXjp4fb0jDqkMOj3BOBj
	Ipb3vtLIgOxIGjQJUyoSDunuMUT6Qi6L/MGGHiCGB6/79JJlU24Gx/bzjeSD2z+N6/xSRCEqbWD
	NIaLQFZFn3N3reYF9ENf
X-Received: by 2002:a05:6830:2785:b0:7dc:d951:977f with SMTP id
 46e09a7af769-7dee126e036mr6225714a34.7.1777930835645; Mon, 04 May 2026
 14:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503174534.45699-1-mikhail.v.gavrilov@gmail.com>
 <afjcCBGzuZU2iON9@google.com> <CABXGCsPTbCdfrwWAtXOb7wOMUOgtL=hpsYYXXQrosoUjj_WkYw@mail.gmail.com>
In-Reply-To: <CABXGCsPTbCdfrwWAtXOb7wOMUOgtL=hpsYYXXQrosoUjj_WkYw@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 5 May 2026 02:40:24 +0500
X-Gm-Features: AVHnY4Jugm6GIYUL3mjnI9SYGJLDXas3QDiAq6lrNI2LPx4RdXL8Ywk9x3vNxtI
Message-ID: <CABXGCsO5RCdgE0rhY_NXOmvKCDX0q=sifNryMK3qYwUuDze5AQ@mail.gmail.com>
Subject: Re: [PATCH] x86/virt: Fix RCU lockdep splat in emergency virt
 callback path
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Dan Williams <djbw@kernel.org>, Chao Gao <chao.gao@intel.com>, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 11:50=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> What direction would you prefer? I'm happy to spin v2 as needed.
>

After looking at how other places in the kernel handle this =E2=80=94 kerne=
l/notifier.c,
kernel/cgroup/cgroup.c, kernel/fork.c, kernel/sched/fair.c all use
rcu_dereference_raw() when the caller has context-specific knowledge that
makes lockdep checks inappropriate.

I'll send v2 using rcu_dereference_raw() with a comment explaining the
panic-context reasoning. The diff would look like:

  /*
   * The crashing CPU may be outside RCU's watching set in panic context.
   * Use rcu_dereference_raw() to avoid lockdep complaints =E2=80=94 the wr=
iters
   * (KVM module load/unload) cannot run during emergency virt callback
   * invocation, so the pointer is effectively stable here.
   */
  kvm_callback =3D rcu_dereference_raw(kvm_emergency_callback);

Let me know if you'd prefer a different approach (option (b) from my
previous mail =E2=80=94 converting away from RCU entirely =E2=80=94 is a bi=
gger change
but I can do that instead).

--=20
Best Regards,
Mike Gavrilov.
