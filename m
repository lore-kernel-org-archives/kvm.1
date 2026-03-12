Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279EB3A6B6B
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773321453; cv=pass; b=lAAjbiWdpHaszRVyfZQpzUfwg0/WLChk9igmelAy3pzm2jEo+yKjau+eq4kgypYs3O3SBKZLX78INgj1XaVzaB8CDEXs18R6D/n8izvvLV9xey2lgkcoNwgTFJGxpkxWGvp4Rfr7nqMwvJMtK9cSxg7oCmRFvNSFwJ3yf9iHiZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773321453; c=relaxed/simple;
	bh=2CVfKLzEaWzJ6SOlRajph962S9thoJpcyvo/tNIs4cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJCfzow78n3N3G7RR3KtTVglcwZNGMaWDgIAHn1W3HD0cAPy046YHQxdRFNd7NCd5izZrgYV4MKD017XOUiw2TvSnDajchHXR0T54lgFNtZ6gzeN9DC8GgQsHBLZIW+zr4jMcLHx5pbcV8ptse8oDYEvxWvZGWUfWJFSVenPztM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MVNQwuIO; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVNQwuIO"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506251815a3so8796791cf.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 06:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773321449; cv=none;
        d=google.com; s=arc-20240605;
        b=ZGrLC4eKAokuqqcJUYvo6XOgUBi+aprF5tPm6a4gsCgIDoY4tXtH326Xq02yCVmMS0
         MI26XPJMH3xzeml5N0PzvqXpfJSGKtO6OQyqcSzoeLOJNzKXwRINt/OmDzr0PSMaI74s
         KMWIpBa6f3HIS9+uLvjJmM9D6tmA6z3JBNYJJVEZu9lZgYR889frR58XG8iyb/emDGO4
         71gnHTxI+1Nhtpk/oOK9+Y+KkyfALN9tAMfJfBsd0OqbVHG2cxxBoXPURJQp+L5zmtO6
         /mgjooTR9AZ7cjZHJ5Z7BHMj9FAQlu5OepvH4OrpuBX1GDDdKZhtk4g6RPzGqMb/yM4l
         vzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FPswTUN7MLesfdnks6XcGWJl+3PmdW/bBkNaMAxhxH8=;
        fh=qzY2FwzKCQwGfcxZoTQQWHFWKCZWex1gAx/V/ACygkg=;
        b=aqwtRXmMe8QB4O1NOq+cq7d5OVOiqVpeMR9qmhfp9hcVVfeKoIBoLoiPeJL1LGDrev
         kwUA05tnKZYk7wxOP9NrLS5AYazIaneDBcKW/hvP8R8QfTEWxJDpaOGt4Q8AmJwPuBIe
         NiXfoBmQlksJfXRAiONvEED3mFcIAU3NkEV47EEZOgfpuf2Udf5MDhjQS/4ss5ybuphN
         XjS+YjZjqMcEUxmxywyXzC0Q/2cG2eyO3HY9FL39dZolC1BWHQQrqmKo26wY0rS2TZkq
         XmWhXzmVVn1LdRRlZj9LkeABz7h71He133xin99Y5zK2QTkLYMsxq3WsA6seqGsQFuDn
         gtzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773321449; x=1773926249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPswTUN7MLesfdnks6XcGWJl+3PmdW/bBkNaMAxhxH8=;
        b=MVNQwuIOTIvL8HDnk/IjtGZ9/7DMvkoiQTiRUZuh29mp5C6025kOAhGKjls1lg5OKo
         BZElZvzX/SedmCaYlWxzgefe+fggSpvl566BWYlKWaS0x0v1DdrVPBxkvEnVXImAvZDU
         jnTCVSUDZRMfuIeOel7aotv1ldnM36CS9yJ8XC2weRrXLx29SQUYkHYWbWDRAqPwPa/Q
         4FLOJ5yFzbBP2bwbeKYwPg00hSqgLljaqcWmXqIdWYPIDAske1bSnDAZBSvqA4nU4quJ
         v5nr6FTL5EH7fXa5y6suuJZOOmmrZRGxOOwk2Y4CrM1amb1j08hLvDXA53RQ6mVUjGX+
         3pAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773321449; x=1773926249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FPswTUN7MLesfdnks6XcGWJl+3PmdW/bBkNaMAxhxH8=;
        b=N1+ethq56R7ghjYVeiIMi1fVL3cCYXGOURo6dzN3acKG6XF1nLLv1YHdKjlabLjJwA
         nYFRuz4CjlURu7CqPGzjIQ9SHuJy2yW76oZsSq33uV+iuBor6EM7jy+vFI7E03ZauxJl
         XFK6I6PCotZsMMcM1Wp15lcfLubEUoZ/A5ZuXqyEQglNE8o0w+sJsblyRSIty4Orgm52
         Tqj5DYzH8JnDh47CMrYUWOlK23IqGC4LYo3csTXgxkbHSKEdklIuPXaiqCty6mIMcQ0i
         Y/XbIgMjlpID7j3Vz9WuKNDu48xLSEEC6giNDwON056OMtb9FyClF2Iyuau/usq2woKh
         JWZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxvsT+w3Ceet6iJC2kYVGJudoVDH89AGf1Ea0Aeq48PghzQawge06IrY6eTpvo8orH7VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDjAvhD6wH0KWVsrxukrDewBvd2JHTHGCs8g1amo3wj4z+Yhvp
	aI9u0M3VFm1M0QaYEoORbBvGR1lO83+waijDurO63aaUiKNwyT+pS9v/ONMjSguv4W5HRKJ26NG
	cgH6fe2kCwU5kjTaHBj/GakK3/dhIn/ovSYUM8z2f
X-Gm-Gg: ATEYQzyWrIVZ74/27WidRc/k3D0VSH5bNihAyngOo+HHMglGtGsNApCSt7g1e78tWGz
	FNKpbXAhHwEWMfitYHJhalki3jmhUbuauDjl+sAlnkmXsh7dQHjEVDvogjDhJnsNgy39X5X29jy
	NK6Ua/+N9PfTjXEHm5vHVqS7ofa5uigygtCCAjtY7w0sYIzQtCOczNM11NZevaAaZLoENPpQNpl
	83uiizay+Ja4h6Xv2mrpSs9OGR4PzOvkfvNwCqrJdKtMNhpfChO6U7zitnAPdIghUe0Lim+Y4xu
	od1MkfPI
X-Received: by 2002:a05:622a:20a:b0:509:1ee2:69e4 with SMTP id
 d75a77b69052e-50939f83b2emr83671071cf.11.1773321448260; Thu, 12 Mar 2026
 06:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de> <20260312130639.138988-4-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260312130639.138988-4-simon.schippers@tu-dortmund.de>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Mar 2026 14:17:16 +0100
X-Gm-Features: AaiRm50cn_rRH55eJvQqDxobMz7O5_lfuBZOF6UtHjJez3Nx18K8yQR7QqLR9ME
Message-ID: <CANn89i+tWCtSAAH5i=FDDqRe0jm3XZS-_Ce3kHvZQpkedRqoFQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 3/4] ptr_ring: move free-space check into
 separate helper
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 2:06=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> This patch moves the check for available free space for a new entry into
> a separate function. As a result, __ptr_ring_produce() remains logically
> unchanged, while the new helper allows callers to determine in advance
> whether subsequent __ptr_ring_produce() calls will succeed. This
> information can, for example, be used to temporarily stop producing until
> __ptr_ring_peek() indicates that space is available again.
>
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  include/linux/ptr_ring.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 534531807d95..a5a3fa4916d3 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -96,6 +96,14 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r=
)
>         return ret;
>  }
>
> +static inline int __ptr_ring_produce_peek(struct ptr_ring *r)
> +{
> +       if (unlikely(!r->size) || r->queue[r->producer])

I think this should be

       if (unlikely(!r->size) || READ_ONCE(r->queue[r->producer]))

And of course:

@@ -194,7 +194,7 @@ static inline void *__ptr_ring_peek(struct ptr_ring *r)
 static inline bool __ptr_ring_empty(struct ptr_ring *r)
 {
        if (likely(r->size))
-               return !r->queue[READ_ONCE(r->consumer_head)];
+               return !READ_ONCE(r->queue[READ_ONCE(r->consumer_head)]);
        return true;
 }

@@ -256,7 +256,7 @@ static inline void __ptr_ring_zero_tail(struct
ptr_ring *r, int consumer_head)
         * besides the first one until we write out all entries.
         */
        while (likely(head > r->consumer_tail))
-               r->queue[--head] =3D NULL;
+               WRITE_ONCE(r->queue[--head], NULL);

        r->consumer_tail =3D consumer_head;
 }


Presumably we should fix this in net tree first.
