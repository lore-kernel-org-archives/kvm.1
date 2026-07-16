Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4033A7F6D
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 10:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196116; cv=pass; b=YJT9BpOm+kUTPwwXJNCWIbOei0v6ufopfjv7Tsbs4ioQrxKm9nWY7PBnh16rCPuTeHj7P2nr5UvqCdP11pcHfTatoGQLsF97OIQxvfIln8b7L7dxXDfp15DeoW2q+1ZxsUXvFvOuGvNY0G5CvahU/0svaP2Xuq2ONBiygG5KZdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196116; c=relaxed/simple;
	bh=4J+LRl1E31ETdtySJs91tQOjUybYz/e/7NrIdVDeAbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Js+0iDaP/qoZ2dJel2RRVfJsa0QHLaPUUkO+jypOiWVm82w2rcOcmYB4rKnFGuOhuYkyT1BCCLHTrl3yPw5H37/TlEe9ubQFKUvT2cWRfW4F5WanEURAavRsUzeYX7MoYdCzUMqiBJUMkEgNk3vIMffqzuUNF8Tdcp4cD7ZR8Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AtLmSLiS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ix9Hf/1U; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtLmSLiS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ix9Hf/1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784196113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kte+O5lQxSAWFzdWKKSzuAvAp1/LhbKZS7adJyPOIok=;
	b=AtLmSLiSBfTA3Ojh2HsjnDHOfApmvP7u8zfKbHbWC3wIwtaaKZUbRhW5ubSA0jq0408wJl
	6AV7u1uE8JB5qb0aVeqxi3cEeDLDcQShDZGl/Lvc3gZF+kQbWrabNmytDLsSIE7P3uKPZP
	F56HL5Vxgx0xgFU6DWWqothCf/NlU9U=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-GTmr_SVzN5m4tu-9GEVxdw-1; Thu, 16 Jul 2026 06:01:52 -0400
X-MC-Unique: GTmr_SVzN5m4tu-9GEVxdw-1
X-Mimecast-MFC-AGG-ID: GTmr_SVzN5m4tu-9GEVxdw_1784196112
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-81e7b95cd84so57271267b3.0
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 03:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784196112; cv=none;
        d=google.com; s=arc-20260327;
        b=CWYNYUcsozCQuf3OLxRwhcjijweS8wXyxWqhk8b3D+LToCPmqNaD6W9Wlf2pxNTFJp
         bfFwhMfx3Zo72AXmbtcIzd5OhcPGDBuT4Eo5ZFNBe7ZWzGPRd7RUNIKXSbW5jwuOGAil
         U/Ja9QyUBbRyY/LvHpv8N/mKZpFUYPMT0JGufVPmu8TcygnAP3C09/6+8Fvp3SRTGKgv
         818c6NQb9matQzanFDNl2erQgpdjjU+qEOgRmlhFjT4yNeQ/GOkrWW61xo2lN0jU2GjM
         4KCpZLk7Wob/M2KCG0f9kYytePP++7YJiifbDy3z3UrJ10Kygp+dpRrq9/YzNDgftL6o
         Iz2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kte+O5lQxSAWFzdWKKSzuAvAp1/LhbKZS7adJyPOIok=;
        fh=UrpRtR8Eio0vuNNEj0bq6GOqNEgkTp/uRc7zoXLE6JA=;
        b=RbG471QmZVA6tN09eF+9BUmq+EqxNqsVjyM0xmcHVO2Uuk0k0J+YuXO8zdaxlo9gco
         t2XlOJOWBPpTWPOSHWN0KXPNfDGkCWWzHdG4yRn+QiChV/7iIJ2Wnmyo8qunYZN3keLS
         3Y9vOZOIoxDYJ2M9+XWpHN/sWEFDTXoQSVOrFSo6CG4Q3tNEvmU2tRtt3Cw8UdeNAKwV
         mgE6Co4AhsXX9MVmTfkcHfjrUydCQi97iVuE6S0BSdYX5xbqC54/YBfENcr68v9Y+8ZG
         KkvcdDQzBnoANlYCKgXu7B4zMhehybfcInWilbr1u2s7Rx2vLquuSM1z3mV9LdERvU8y
         k1Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784196112; x=1784800912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kte+O5lQxSAWFzdWKKSzuAvAp1/LhbKZS7adJyPOIok=;
        b=ix9Hf/1UuOAF8ud546+CZVv5zm/H7K3j7rweKXg3qdeyIPxxEXANTfSSRTUKWfMyaV
         wadJuoZsIVhnZpJR6xVvZQXQh35YDov2iDHYORTq1h5SWbVVqTDCOA9EhBNlErCnF8qC
         +g1kMOO6V+HgzwaDi0TadfG8S/mmsNE6JDzHfRuRK/b5eirEWzXldOvfzIQOVwoDpZVm
         z0d0zlLDSwWKWJBBO99Sf0n5jSl1hS37k2CQLx7VMWVHOjkm373gQykb5chcJfAjgx/o
         W6brgoWOxQ39kZanuo+H6D7Yaw4No6rZgNZuHMSpy+MIfW6/mN+7zFLfGV4euEQZmBiL
         deXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784196112; x=1784800912;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kte+O5lQxSAWFzdWKKSzuAvAp1/LhbKZS7adJyPOIok=;
        b=W/T415oAunrVBHLO4k1GAQIv+tL0LPOi9cYLWAJTE26jK/2QGwFWhsHE4s1dDraJQ2
         70F1avvetDfm5+DHeeD0Sd0RmAuLj9/EQwugrlo2qg/92/yPxf8jUw4t09pDQFhPwbEY
         coot/mOg5tUlujwwCdNkYz0v74uoJtmuSRQ6BN+rbI5opKry20io0haaTen8rkIwBiIn
         LznS96/mY390FM9inTNir57igaDqFW3yBEgRr8vCvY2t6G2iU+P04rRwwwpRMKpy34Ng
         z0quIj0ob1KrD/UnIs3JUUIBxFOKagI4Z2GrSwWuEAqo1ZypelDMIrVXhyMIfTxGDvUg
         afYg==
X-Forwarded-Encrypted: i=1; AHgh+RovmK2tcOoBFsNM00lCVJVyIJgleFwkvQP1Pvd/j/3rub/OuUYvUsGlEiHQx+X92fQgy2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPeYtoOrHMJvV238RT3vTR34AfGkoe9JEze2R8p/OnGiu5aqHm
	Haw29XbbX64NgGHpeIAEf09n7g4h5Vpo3FDi94W6LqD7QrERCs8Y37CcWTGPx5TF6wygZ7w06Tv
	Ma/tmEYUFc2vjdBnIQQ8no30XAI9c+FF4OjoU7JUxTSsClzuf1+g83SxkDo6+M9JSJ2zDXn9BT0
	eY2efcZgxQBqfyTrq+VRnoCWbc8/xa
X-Gm-Gg: AfdE7cnGW6mNf7KpDokIfHVDYeWK/dzTiMKHtYAraGxHB8BwpqlAIIwg/rPGK/FZH8P
	KtLOSCuUlHC6AWpojflQ1ZngvABUHh7nmo5013KrsqK7Xjt40Yq/QghILdBl81fKfgqByyCds6y
	GufgACLCQXeQk7mSBBGQD+ieEhEtHl4F3N1ZBmHbiDaQb8XtUMxxK5xD1/lhWbG54taJvYtoqln
	2AxRtF2PcQVWmVDO0svjujoEO+SQOdDaEdHTdH9rTY0f8M0lTWqgsLPdQX0j8HT1DDirT9HQMPv
	Jv6DGl1mYZdxpY0=
X-Received: by 2002:a05:690c:e212:20b0:81e:c5ba:b052 with SMTP id 00721157ae682-81ec5bab97emr51788267b3.39.1784196111573;
        Thu, 16 Jul 2026 03:01:51 -0700 (PDT)
X-Received: by 2002:a05:690c:e212:20b0:81e:c5ba:b052 with SMTP id
 00721157ae682-81ec5bab97emr51787967b3.39.1784196111105; Thu, 16 Jul 2026
 03:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716030242.124455-1-xiongwm2026@163.com>
In-Reply-To: <20260716030242.124455-1-xiongwm2026@163.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 16 Jul 2026 12:01:14 +0200
X-Gm-Features: AUfX_mx1UNEXbgfju8J4YPpG9wOazGi-4uMhtWJ0TvC5HjB07XmtqFhXc3IuHh0
Message-ID: <CAJaqyWeNJwVNUihL8MAEH+-a5OsoaDGsgaPnP0BqQd6YH4ZhYg@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: propagate set_map error to caller
To: Weimin Xiong <xiongwm2026@163.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowangio@gmail.com, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	xiongweimin <xiongweimin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 5:02=E2=80=AFAM Weimin Xiong <xiongwm2026@163.com> =
wrote:
>
> From: xiongweimin <xiongweimin@kylinos.cn>
>
> The return value of ops->set_map() is currently ignored when handling
> VHOST_IOTLB_BATCH_END. If the backend fails to program the IOTLB,
> the VMM incorrectly believes the operation succeeded and may continue
> with stale or incorrect mappings.
>
> Save and propagate the error from ops->set_map() in BATCH_END.
>
> Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
> ---
>  drivers/vhost/vdpa.c | 6 +++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bb96b1aa5..ffbb10a92 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1297,8 +1297,10 @@ static int vhost_vdpa_process_iotlb_msg(struct vho=
st_dev *dev, u32 asid,
>                 v->in_batch =3D true;
>                 break;
>         case VHOST_IOTLB_BATCH_END:
> -               if (v->in_batch && ops->set_map)
> -                       ops->set_map(vdpa, asid, iotlb);
> +               if (v->in_batch && ops->set_map) {
> +                       r =3D ops->set_map(vdpa, asid, iotlb);
> +                       break;
> +               }
>                 v->in_batch =3D false;

Maybe this needs to be discussed, but v->in_batch should be set to
false even in failure case.

>                 break;
>         default:
> --
> 2.39.3
>

