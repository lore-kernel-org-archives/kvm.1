Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E83EAC68
	for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 20:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792355672; cv=none; b=XwOMRNwNh5dsWhC2aIb5fi8iNvaI4c+/XNEYVhIU58P4OxUS69Y8QDIgQSHAapKbl21rGY5GbyzVQc4j0k+JpLjvnwTPowAZMFODRa4b9ykmmnYBAyXIzoxVU3fhe4P9gVpR11Bvl9HXO0UJ6MtdjdRVAh0DCBaTF7iTFx1ZqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792355672; c=relaxed/simple;
	bh=mGtMxGvGMAPxZX+KuCd0vFb++3GQYItv+c8z4egM++c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmrHHPiFbmJwm4s6oE1MUTgU1IKtg7Xh7fFU2Ac+iwVQ+x4sv3DuAXHAcfNqTTQ2nrPHESDcdO1/uzbILF0xNmL/olP/1LlkXSbo/jnmvBoqXMe5eaxq/npa3qmQVnIERbX/MW54SZI17afSMtFhkqnrPZzCQ2rtp+sR0VhDsbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gqwLDKu5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gqwLDKu5"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b203527bceso1635534a12.0
        for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 13:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792355669; x=1792960469; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LcZudtVZGXqPCpJjVd+PjoGGou1YwE9FLeXdn5NeRV4=;
        b=gqwLDKu5s9gordUFCi6XC70nosY/hZjBZv6Qb8r48rLLHMiDWFg/swEdylGSGbWspM
         uU+2cPaD8Ciz9MwAuWxhkoE1LjLgrtgsp5EGEtw5FFerYl1WGfU5WBn2tvDkb8QkSGs5
         FjQRhQrl5cEPlT327Je2O5ZAphnx0itGXUk3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792355669; x=1792960469;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LcZudtVZGXqPCpJjVd+PjoGGou1YwE9FLeXdn5NeRV4=;
        b=jcD7tqOp4guIk+nirNfM1CWxd9brXQr/jdzvXF7Dqd5moAlCEBcYwWujTyKMiNNrMA
         kKU8g0917/dXOd8KDPYALcknfoci3D+WNvyKEw+oxGUKp7rXRUO9oFoHKEPnKmQ6B6UQ
         hLdR/DPXrQOul5mhFG9YilZiL1gkDNQdGl84hQMOjEiy3ZNYrTzXMc8OT+IMwnomaIKG
         lDDz6xSYn+WWurImCjjGoeBBLceNQ0+Laa4TcGoAOje3wZSogztebFxRk9lY/p62wq+D
         FthVXh2TfxY6IRqPOpG19YDV78r1qzgOk/9V767tY0AKBuxEVhC/LtR/QlYzH6pY4RCp
         EYlQ==
X-Forwarded-Encrypted: i=1; AKwUvBzc7lQ277WyHb8C+o/J0tUd4KPYUOolOjUb67OpH6gxU71maCNiyd/jITI3VzAZrLOfFsU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7eEUSKsPwlfAvyg6E5s7pdookG13vf2j7ysHYipUX+YwJHVur
	aq/fpl4TroYZwz63TpbyUoCNIX4IsevgpD5dNrGeCqn0Ro9R5Dw7Q9lzd8vJc7BwLuBzteGz/9I
	O3gzOnoc=
X-Gm-Gg: AYBFou27p1brhE0Myn4jJhrmaE4mv5Y8IafndaP4+JFonAT/J0PKkIES6VI7VR7simS
	M6GOyLbJLk3W3/wL7L1o1bYCoJGj8+6Rz1VlXXuv1UBH8/hXTaxIgCblVmPZRAwTiVrtmFc5iqA
	x1L0hWMMuIJHaLTSW+d1iZkAxqe+iLC8Lfe5I8y5+9meFKwqR9yIzond4hvOAWYMkAsC5bmlM+z
	jlZEqsy7Gykc6ENKO863FxUiF4WyxpVjiP6/1thP5/L/ewJno/i3s5ybsjyzFB5kAna1ud0joUz
	k+gvwvJwrB7DvScnorYyHyjHbpHbTYygsLxhgynQldKVzBPDQ93LCln9fKlSuLPqtWpIGJtgH2Q
	WaXCYzSh+xQjdYbNxWEXogOIPb8p0mw7Mzhs3macTn4xjPQ4UxCs9jHy4xCggO5Lk+co8YsyBnr
	C1hdCIGHlQEL8i7iTi7eGzFjxlG9uflYh2Z20bXxerk9/ZA0+dbHC+z933lucD38d3HnSET1LPS
	v2CtSZ0RAiWqqNLnA3usYV+R8Fy6beXE9CCv3jxCqT1syk=
X-Received: by 2002:a17:907:3f1f:b0:c2e:4e08:19ab with SMTP id a640c23a62f3a-c419df3e373mr393452066b.16.1792355669186;
        Sun, 18 Oct 2026 13:34:29 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919bcae3sm295062066b.57.2026.10.18.13.34.28
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 13:34:28 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2e8c710847so168431766b.0
        for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 13:34:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByArDhR4rITiwgnoR9fcC3rXiOdvPaKLjn58Wov6+VjvO5osad8yB2DAfWTpYHilmsJDWU=@vger.kernel.org
X-Received: by 2002:a17:907:6d0b:b0:c26:1649:47ad with SMTP id
 a640c23a62f3a-c419faf81bemr359351966b.35.1792355668398; Sun, 18 Oct 2026
 13:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com> <20261018152358-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261018152358-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sun, 18 Oct 2026 10:34:12 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
X-Gm-Features: AclHuK98aalKW5kTezoePJe0elXfnFi_e6X010Sl6ShLR7WlXp_TWSCo1UYtPLA
Message-ID: <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, eperezma@redhat.com, 
	linux-kernel@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Oct 2026 at 09:26, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> +               __virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> +
> +               if (!access_ok(uaddr, sizeof(*p)))
> +                       return -EFAULT;
> +               ret = __get_user(tmp, uaddr);

You should never use __get_user() in the first place. It is almost
always just a bug.

And __get_user() together with access_ok() is actively wrong and
stupid. It's slower, bigger, and more bug-prone than just using
"get_user()".

The *only* reason ever to use __get_user() is in very very iffy code
that might use a kernel pointer and doesn't want the access_ok() code.

Or old legacy code from the last century when __get_user() was faster
and was inlined.

               Linus
