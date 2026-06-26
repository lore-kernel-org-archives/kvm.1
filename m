Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BD63F2117
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473560; cv=pass; b=MaK7278cldAcunYrlreuPH2zWVyEqR5QQ1YkX+XwSi8Dhj1TRFlBaaBqpqsh99HioOOu6tCdDg2Zr2PZqDwWQLI51MeKQ/lcDxZW9HEc7A8C3MGXWiW13KTqN5cXkwGQI7xG32hxV9pQIwZq3m7MbPtwIbg5ztRvrkkmfjK+txI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473560; c=relaxed/simple;
	bh=wvBn6e2zZVZyJRVO6FTn9idn63IqtNcAsXkmlHdOuOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OS0cdn/mty5RZHoCUh5V0QXhRPRp7dnAU52nTYF263YP9DLL4SKXqAODA0buAeoZeSvuzMKNKl2KMjhzzPnfJ6JhmA/suj6QVVizYyoLy+Is046E76TQcCKaikGqgNK6LEW1T37TRR7MACd6sFmIsCNh+kr1inoQPAXcuUs9v0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8o5giQv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVZ4D2He; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8o5giQv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVZ4D2He"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0EJPxRCKvpa0CeGLyfZNMZptfraA2jDAIIX6v5L/+o=;
	b=R8o5giQv/Htf3lm5YZtxwFzDqOh6e+heJsTuvl8uSh/4B50909nXO4qEaUitRxCIwOyBQ1
	vUR6AWyBqhjP13I90s7EwLf1DOooyOjKIudpzSVf97Hd7urU4FwPY2SV70QU12ufovv+MJ
	fH9Qzz/KSb0hzfNjM51+CJ2WWZfTuJk=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-rcxDcG5NNWOKG9gi0y8uZg-1; Fri, 26 Jun 2026 07:32:34 -0400
X-MC-Unique: rcxDcG5NNWOKG9gi0y8uZg-1
X-Mimecast-MFC-AGG-ID: rcxDcG5NNWOKG9gi0y8uZg_1782473554
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-662f741fe3bso1138609d50.2
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 04:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782473554; cv=none;
        d=google.com; s=arc-20260327;
        b=lD6K0aiq9pbs/DYEmbdGRGE0r2VT8WiSEZ4gIXc5RSASWrhzxzh5L51+DBk/ZWkPFM
         FnN8UN9Us50wjZGA6oMyjVRboIgr2fZKVX7hz9XPaDEhQh45uDlXkf7NK6WEtl/FqWh0
         860huB2WUJICzfG0pI3yqbvQ0xGZR5o98/TIj5Jy3o77CyyXPa0GNJgRUE0UEip2nLoL
         A1YiVqkCjR2RPBHzWOV2R1gt0IRQj5jmmJaxCgOIGupZMlhTII2rZ5w3XYjP5osXNr0n
         dFY8SCIMn0Aa/YL+51kQlyEAqm2+lRI0fdVNDLgw6xRiU7aizLo6RUrNV9Q2vUOdcgag
         APWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S0EJPxRCKvpa0CeGLyfZNMZptfraA2jDAIIX6v5L/+o=;
        fh=kFzXk5OwcUesn27kfuzyOmIEaAfdtS/mdpX8ksPMQ9U=;
        b=aDWOMlRaDM/u2fo2UivRMVAJtvAi7aMJSxO0ckfuUPurrqCzxasEnbq7qnxevsMelk
         EYFVvJaZdh4/11L9V2CJ0TqQnxYgTaVWFVgOCPYhHj7sJxBB9H2EIb6X4vkzc3rz3XIt
         O4DmIwVnhuPhaNMJ5i2Fekvf8iF3zmyR769/1w9e/uPd1UY3CZTf5Q2wi/pVd7uXXYQm
         aQX4plwpEwTUu7GIC/FfrcP71MpMGJ/qxYFz5jgeyCX10WtZO/F8Pfn7XabMZ2FUDSfV
         VJ5roo76bBGJHpDEFEHJd9krpTy8hBwyjDOGldVV6S5HQGsSEF1+OjkpaTQjYmFe56X8
         RY1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473554; x=1783078354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0EJPxRCKvpa0CeGLyfZNMZptfraA2jDAIIX6v5L/+o=;
        b=eVZ4D2HeGGtE1hozOY1Th66jqjaHLABdESFBGK2Wjh9bbJjmPv6ciRjidUSP4pYhnL
         j9dhtlcgzBcqlMS9gJOSvsWLTqQuAQ82P+v25nt8uYkGHke8JcexLMWHf96KmWzT6RWA
         pEbQsr5ZrCQsJ+PLTWNV70aua814VtUIJefeFZhvmf7gubQ7Jc0SWX32D0MCE993jwZ5
         k/G4niaBttIrCLzgqlvGmE7LSNCggCaChxyRCkZ4FGFNaYaDqSy9AkGFXYSW0ZEO2Igm
         hytFbhJlNX1QvAmTDTO08+Mb0atdXZLmOAYYh34PrUmY93npLKWhzTvuGiCMmF3DZu3d
         w3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473554; x=1783078354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S0EJPxRCKvpa0CeGLyfZNMZptfraA2jDAIIX6v5L/+o=;
        b=jmYHG7N2VPLxNgYSHg/zi/8yTvECTEABDKtJGhXvL0fz9SQ6RbfXgYOsZVd/KidVXV
         phidJ+Iwhti4/iOytLpOrxoNTBhY0A1peAbFy08h3y4eDRdnGJy+/a1exlpdPdmA4GNf
         wEJnLDk1RNYkUrvErlUlGMb2sOlROwb8XjEgEl+0CXC9Yy7crWu0tL9s+IU7Gv+TOWJn
         zEvEE+XplVLLhkWADHh+ViRPR9JSB84zNAtGF95bZ1Fb29/cA8wslvctledh8Gmy48yr
         ug/vZ072hmJbl5nxxhJXuxxit2FNePAlJG3WvQcaWwIaJbafbYJW6tyyT+FFjZVkk9SY
         y8nQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro0h01fnMQtxE4SmI0XlbGt8rsRmym4M28dgJZHBymPhMidDf0bPI4DCj2yK7WhjL3mkaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgAdc5RNg2zDcC5dcny652qVM2Hyoph/mLl0x3IL8sQbHIpxrO
	CzAmXs8t5pI692ChNbA0SVFajelKmO0gS2dB0A16d0Ykv4fSy/lRtZx+vJqlfsirBbXaPk1geyl
	kLRHA06jNUer9RY457+yeFuEM3niSAgB9bZycWz9pFHitMs7E2aXqEY9oEN6ZePKGTIgChvCPDr
	n1OpTABe0cXYVMOPZsPRqdbj6Bu11O
X-Gm-Gg: AfdE7ckrvso0PPotN+8bMAa3EascjAr9mP/z3D+O8yAhTrbUbJfqGTxlA2rLXpuEjXR
	WXBPfnCb2nNtCwyIQe36Wdp6YJtO+J3Xmoc8amziAOY2PaMVBrwKq6RgaOna1uLd0mjC2Qm8+gb
	tQIwfHuEfeQlNEV0ZJASMeKbOFg7dRCj7MOhoonYUVWt8h7Z/OCTLvS2i4e6yRHeYu1GY=
X-Received: by 2002:a05:690e:14c4:b0:663:2329:be0a with SMTP id 956f58d0204a3-66488344efbmr5117679d50.60.1782473553788;
        Fri, 26 Jun 2026 04:32:33 -0700 (PDT)
X-Received: by 2002:a05:690e:14c4:b0:663:2329:be0a with SMTP id
 956f58d0204a3-66488344efbmr5117666d50.60.1782473553142; Fri, 26 Jun 2026
 04:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626070438.59149-1-r4o5m6e8o@163.com>
In-Reply-To: <20260626070438.59149-1-r4o5m6e8o@163.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 26 Jun 2026 13:31:55 +0200
X-Gm-Features: AVVi8CdX7YAE0vZmUHYTRxuB_yZ_qwok6xv6BtZ9RLd4G6r_QlmLWG0P771exiQ
Message-ID: <CAJaqyWfP7j5_PvOP0JiHuAQ8appGnoJDS3OB-qK7riBpZ_d_tQ@mail.gmail.com>
Subject: Re: [PATCH v2] vhost/net: fix clear_user start address in VHOST_GET_FEATURES_ARRAY
To: "rom.wang" <r4o5m6e8o@163.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yufeng Wang <wangyufeng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 9:05=E2=80=AFAM rom.wang <r4o5m6e8o@163.com> wrote:
>
> From: Yufeng Wang <wangyufeng@kylinos.cn>
>
> The clear_user() call in VHOST_GET_FEATURES_ARRAY incorrectly starts
> at argp, which is the beginning of the features array, overwriting the
> data just written by copy_to_user(). It should start after the copied
> elements at argp + copied * sizeof(u64) to only zero the trailing
> unused space.
>
> Use size_mul() for both the offset and length calculations so the
> arithmetic stays consistent with the surrounding code and remains
> overflow-safe.
>
> Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
> Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
>
> ---
> Changes in v2:
> - Use size_mul() for the offset calculation as well, per review feedback.
>
> Link to v1: https://lore.kernel.org/all/20260526080336.61296-1-r4o5m6e8o@=
163.com/
>
> Note:
> Thank you for your review and suggestions.
>
> I tried to add a switch in tools/virtio/vhost_net_test.c.
> The switch is meant to use VHOST_GET_FEATURES_ARRAY and
> VHOST_SET_FEATURES_ARRAY instead of the legacy versions.
>
> However, when I ran `make virtio` in the tools directory,
> the build failed with an error: missing asm/percpu_types.h.
> I fixed that error, but then another error appeared.
>
> Would it be acceptable to postpone the submission of
> this test case until I have sorted out all the build
> errors?
> ---
>  drivers/vhost/net.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 77b59f49bddb..4b963dafa233 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1784,7 +1784,8 @@ static long vhost_net_ioctl(struct file *f, unsigne=
d int ioctl,
>                         return -EFAULT;
>
>                 /* Zero the trailing space provided by user-space, if any=
 */
> -               if (clear_user(argp, size_mul(count - copied, sizeof(u64)=
)))
> +               if (clear_user(argp + size_mul(copied, sizeof(u64)),
> +                              size_mul(count - copied, sizeof(u64))))

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

>                         return -EFAULT;
>                 return 0;
>         case VHOST_SET_FEATURES_ARRAY:
> --
> 2.34.1
>

