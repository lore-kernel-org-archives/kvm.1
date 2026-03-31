Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A3C175A6C
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774916330; cv=pass; b=uPbzu8zURwZHwbdwykbQdSvUk2kR8T0+O53IO6mUmEVv7Mc7APB3T5cB+Py+bC86KFXd+GEkh7y6Au5Z/nn20pm+U0a6XwlyOdQ4bi0Xc6RmGqzK/AA6S3LC5MBUuFAJEhUiDEUxOiUZK5wSkT7WZHTx7r9uD8J6iI8oQiDAIUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774916330; c=relaxed/simple;
	bh=7RaN9qNmZD8w81PNEK6wj4TA72Y+HDMEXcjQqjMp2ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lALAfLPIaxdRpbz3c3Sll1zw9uc5gQOe8Z5UjnjvZkkSRLVMPTCaoOZ2uf+6gNnLpuSECRm5uBB23ztOjUkhDUO3Zo8bu3MeXJ3tbAJEWZvHbtYeYAF2gAn1Nc5/Hz7XephbN603Y8fbcVvAvor6jaOt8in3zLuNq2vNv1fVIFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXe0fOmo; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXe0fOmo"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66c24b42efbso1183975a12.2
        for <kvm@vger.kernel.org>; Mon, 30 Mar 2026 17:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774916328; cv=none;
        d=google.com; s=arc-20240605;
        b=PG7OQdBbjXprsmIH2/xb/l0EzMqZRLgzjtE14KSQcql0wp75OyVkzFKjKtyOVpM2sb
         KxJmkTOmGTIsm3XQUgYIq+RbnhwY0sqZEPZ9eD9F3l4+JheoGp8RdXay+LS7WwaC3CYj
         wCBdg9J0lBplIAhxyANH21nxrrV920f8+hG3pNhDmSlyRiEsgl7Iiy7OGR8PhGMpikrL
         WbapsBeXTtZ8MacKfQkDIUdnjmH0lyi71U3MnMUTnWyl3/NTIRuNZ6Y9EsmucghhPQbg
         nfHpXA9O6uWxp1ln5qGIZixOpR/Sc4VHDu03HeitjWUiXyWjAvcFBf9d6LOh4E3LNLcr
         JFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NPx0UKhp6L9irwnUG6E0gP3VYCDhzREJ2tJuZubyGeg=;
        fh=PEyCDZMqENrNE1PnNCHqnk3GMtNaxIuVS1t5Jg63PhA=;
        b=fXEvpHny/T0VKtQOhQkRXrLFRozuwZzLcF2w9XZb7yl1A6h1Ns826iCq2sYb677R98
         FyLic2qtJGTANy/Ynj6gJkcX4tovijOzTuHXw1jJlrZhQh3jePakSe0hJO50c5BhFR4K
         seRHtnIqn1cU9syO6ESWNEE1i9o3XB8fCeE4UI7pMq4PhMQckaS5d205+2RfPU4pYUT0
         42rwBOJo9t02lcPWfgixoJ+3e+CzCprcTcs8FSIYRIRyP7apvaBzG64ncepUOqAufwlZ
         5fY4XhNx5PQks2rSmlSI0z2p8mtf4OptBlMPE9UYITKoQoxE4oXipoqXl+nJr33oNh/k
         IXWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774916328; x=1775521128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPx0UKhp6L9irwnUG6E0gP3VYCDhzREJ2tJuZubyGeg=;
        b=fXe0fOmoIxuH7EOmbAZKwUtsvdWBFUfjGnWRvFdnqMuxWm+Yoke0OBLQu+8prcwqiU
         TqN3lAcG8t5hL6xV4CBOso912yfgpcg3GV8OUgijBucgh1xUTLOh/n9Jtbk2ofsg32Pr
         EEIEycGQlOt/f/I0LNfg5JlxvK1FNpdhduQ9lbcAz1dRdkEXznc9hIpMUIr0nPonbSvQ
         OuoKbnflwEaL5rN44BkLdebFyI7AaNDkiO0mIjoXO8IyWOhGyVXsMSy9jhUlGDD3D+Y8
         pr9KE2njWm5X4qiUG9HdDFkRU2kR+cyFdWhBRWzUhUmXkNLQ69mg/1PNBACvZn+v9W8y
         bQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774916328; x=1775521128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NPx0UKhp6L9irwnUG6E0gP3VYCDhzREJ2tJuZubyGeg=;
        b=Qlb9D0cS69IAxpDMM3p2YMxlL3PTgY0cuq+xe9Vapm1HiqxLKHCoAx3oA3TGyAZRQo
         A8gjwK0HD3KFr3sbBdsFq2jzaViy37SgvqALGaxwu/FdkiL7R0Ld/jTOSBq6dN5FUp6Y
         hyBPJaulpp0HAAk/ozXbjLKtN8Lt6gzA1UpVcIhM7V8/baKm5ValXjv62Z9VIp7a6SBy
         d2MnAoIiZizs6xA446f25Z/v5fXdLHKnzv5LQ7mDi0bPJiTlBhh0L0YloyhZCb+ChGty
         3Rnt2uPIjG6M9HE4KRku5cM0X872pSihlaijzkqYqusgLPBA0Zrxd1XPxIBu9dnz0ayX
         G4GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgpQytELD9siPCbuZdQ1XpDzo4S7A/EucBjd4wZ/jih3cnbw5BgeXLZ+VH6XOzfJdZzlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwckU4YhKN1UbftEYe1vVdBvtKQ7IrqPi0zoY1PPPmuicmrGTca
	sqvKzOjgYdM+DasTSxTOEx1BFpUUwCHsIc5UuOUBLvuNjAxkQX/9Y7RpI+j/5Mc6qEhYzy23QHd
	M6Z7uePOseeVKMIv/+FIJyOWAFMyQd5M=
X-Gm-Gg: ATEYQzxa+NJ26ZjiRGdV+44fdsdbCJG9uSDhcrKuCNeWDb6prKro+zDrQkXz0OISF3j
	Wf2uZm18wm9ZUlZpTHb9hCr0dqoO/72jOHlQ/CtiRTYJFm3RnWcIZFuYANmIPjKav5/bzKzZ/zS
	YbK12rO/RXjO8xAc+JF8lIqzeS0Up1NnICMlRF1+xlk3Ah+R6AzWYbv27SHS4sNINhXPTVldJVt
	7733AZeETxNVmADw2tHu622BS3yldIp9x/STi94Vgcw7RMDnlGYsCwqarGkpmjXx4gYZC/oSdNH
	t0vmBLxCYDmuNy6h+t6cwwdygvITe42W51aQwZa781nT9fCCRa37C9Z9WUKlEognaf/Y7Lzj3Ek
	XKmbh5w==
X-Received: by 2002:a05:6402:254b:b0:66c:3447:5b9c with SMTP id
 4fb4d7f45d1cf-66c34475c4bmr725787a12.7.1774916327803; Mon, 30 Mar 2026
 17:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326023747.54485-1-rosenp@gmail.com> <20260330161933.6471d473@shazbot.org>
 <CAKxU2N8rpaLXXsD7sUvw3ffMe8JUREGc9ru_HX0r4Uw4RT_q1g@mail.gmail.com> <37378f49-437f-438b-ad6c-d60480feb306@embeddedor.com>
In-Reply-To: <37378f49-437f-438b-ad6c-d60480feb306@embeddedor.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 30 Mar 2026 17:18:35 -0700
X-Gm-Features: AQROBzBKRQYSFXx9_6h0avqLn1ZFhu4Xxz9aDa6KCEykyNNN8CWHNZ4gO0PhEXI
Message-ID: <CAKxU2N_o=x=wSjiQqyB68VvhxP_ZoGoSyQagKm=0BdKkgrmPnw@mail.gmail.com>
Subject: Re: [PATCH] vfio: pci: use kzalloc_flex
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 4:47=E2=80=AFPM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 3/30/26 17:24, Rosen Penev wrote:
> > On Mon, Mar 30, 2026 at 4:16=E2=80=AFPM Alex Williamson <alex@shazbot.o=
rg> wrote:
> >>
> >> [Cc +Leon]
> >>
> >> On Wed, 25 Mar 2026 19:37:47 -0700
> >> Rosen Penev <rosenp@gmail.com> wrote:
> >>
> >>> Simplify allocation by using a flexible array member and kzalloc_flex=
.
> >>> Less memory management needed.
> >>>
> >>> Use __counted_by for extra runtime analysis. Move assignment to after
> >>> allocation as required by __counted_by.
> >>
> >> I don't understand this statement, nr_ranges was previously set after
> >> the allocation of phys_vec.  The only reordering was relative to
> >> setting vdev, but that appears arbitrary.
> > Yes that one. My understanding is __counted_by mandates immediate
> > assignment after allocation. Otherwise UBSAN complains.
>
> Not true. However, it's best practice.
>
> The requirement is that the _counter_ must be initialized before
> the first reference to the flexible-array member.
OTOH kzalloc_flex automatically sets it for GCC15 and above. Useful to
keep it right after for an eventual coccinelle script...
>
> -Gustavo
