Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792567808;
	b=jF6j1D7hY5jSbSai1gvcLosfJGR7l928aMCeC60ePojqLBCnibtoZ25An2zx/ByqsBvh
	 VqWx5sl4iQUGjO90CA40d46gKMFawcgonU711ypq5h/dCmPVJtGQ2UO8E5jfyaA2UPbHG
	 wg0oSIU3eJTZavS/sU6BHJuh+d5grL8rI7MteQf64ez+hYTC4u/7+6hl4pYBey+gdXrW2
	 1u4L3z3nyxEplEb539OQEid4rTzY5UFjQPfPFvlzprM6NNg9+4ycYUzJKv8ZL8ub+Q1BR
	 6nCYtDjt8zhBZomwigRo1LNNhxkWcl2LYYj1ij7xkI4PbEvdT5Y5OnlKTtNnImb4pzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567808;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=ruNbPegljZ2HSbDe2VgJL7losQAaVxHulyE93NG9OdQ=;
	b=s79T8BOeDd1H3m4I7842AtlCKRAGLsfEZCzdz6Ea0wJcqn3AP97bm/V5/yTrRtYgNDv7
	 Qq3SE8VmvfGuAUJUkiOsd+bFjxhPlZiiPxXUJNzm3YODBoz1ziSc4eamy0lrsbbJf5oj9
	 /Z37VzKBxIEo51Pswbn3rEfqd1ITSEjwWkZmTdOTf0VTo/IUjeOM/EHCQU5jy9tkE7C0k
	 mpEted1AwcJ50CZAV8GRaCXRql1Xbg3QkjlwsPZDKCgB6xsjOyYG/GSG7fcJV20mHTZ7y
	 CvSLFBvTvHhMHPbj+wMWeJ4VdNXg6LRP6SyCSXEjcHqWwEsDvNiay7coZY4TLimPk5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MEo0p6wi;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iPKj99OK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F5C606A31E
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 07:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78F5C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MEo0p6wi;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iPKj99OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792567801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ruNbPegljZ2HSbDe2VgJL7losQAaVxHulyE93NG9OdQ=;
	b=MEo0p6wiV0/R/3nHv0Agn6BGUrhqJa+uywYRPZFlq/M0cClJEonQ+FFpq6WLkNWGVgpWdb
	S2FnjkfHj2uAcqsUlCXxqr7bIOLV9xlDVAnLeP6MuVE4dGRbuB6elm8N5ogmYrALCYSi0o
	ucKS4A/+IfSTynEDj0VRe5X2a+ffBpc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-yoq_jJCdOs6fEdUxk8D4Hw-1; Wed, 21 Oct 2026 07:29:59 +0000
X-MC-Unique: yoq_jJCdOs6fEdUxk8D4Hw-1
X-Mimecast-MFC-AGG-ID: yoq_jJCdOs6fEdUxk8D4Hw_1792567799
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-869553205a7so7297137b3.1
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 00:29:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792567799; cv=none;
        d=google.com; s=arc-20260327;
        b=nA8NPo5UUm5u6tCE6q+InSzDRviRToCSvAJFzztKGktIbrTpcAdj0MlnXx0DwVLcdK
         yC1hQkYdINorgtOo8yDaE83K9XFFQr4qLPe0HAH9LbkkswAqm2e/8mkPeGM/lpw3hHL6
         yOcQCtMbQvV/5f5DXJwKbYkXTCpUcbA/VE7s+JMGT//hvFq1sQ6aiQezQ3s1m4zmqTwQ
         +VJVXesBTiUoWktSQxkiuNYcd87NEjPMDZMTFEuZaJ9TOoNXFVcKTTr7IFizjUZM++7B
         w9aCzLPYT+3ViB2zGLqDmml2EApieB82ZUWuo0nBEO0cgM1cwnu7oO2xZoRgjremryIU
         3lnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ruNbPegljZ2HSbDe2VgJL7losQAaVxHulyE93NG9OdQ=;
        fh=5f8sQ6cdK0D6tOT1xSf908J0m9PzBhzHXVihpdRkPCc=;
        b=SbKbligxSHT+qjvQTsxj1n7mum+zIO/+YBHhHJ2Veaq0GT5Ov2V/SZT+g4nNv7MeC+
         6QuGqinncNgrlpG3rV8KlweT7QUEnxWapFXkJNbMcSXWR037gKQnrAOeLSHAB2AupwOc
         P40D6kvAHq7b05dxW/zgBLF2zsAz6S7y6KyHlVB54CWUtPnbV9bst9oqoMKHrVT+BrMR
         Z4Kkb4hLCqeAOEOEO5gKazq3wS9MICSetZVNWq4xoQ+etnfO07uxuqbEaDUZwDyxPZ90
         FeYRXsYFT+OvT0tgnyNQ5G8r5Q5o5yBohKftzCFrSpULyjUlrZs9qDMKY3mn44vY7/oO
         7MjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792567799; x=1793172599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ruNbPegljZ2HSbDe2VgJL7losQAaVxHulyE93NG9OdQ=;
        b=iPKj99OKCYBLxKoFRZQf2Hg6XfmZny80yGZlMAmrHp5kx5XGo0TgWwOm1D8U1+QkFs
         UERYQore2pDeV1iNLK/bRlznsPf785W4T+NrHK/BAf18mYAiDfpZM/nVmxT27tawAbFd
         XsQVcFDBnTpT0wR8MAtQ9B/oS0eK085+i7rMB0YbRIyFnv7lD6qH+ZNDHWZeuKxmXnri
         EboiCCaMxHi9C1T91+RZpQUHX2EfDuCBuWDo7KFZ7OLZdbcK5IpbHsC4PpR5r5GXnYzx
         rT1z5IzF+foNu4wQnWwAjH9ek8D/VK41l8kXhSuAsNfYzEv/SS3IVpywD7hRuiA9z/rL
         AJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792567799; x=1793172599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ruNbPegljZ2HSbDe2VgJL7losQAaVxHulyE93NG9OdQ=;
        b=c0N3ZwYP6pDODM4lVGQaTR9rND/j8f2jhH6KxCSqojzgjHyi+DbnlIarAVn/57WfcJ
         IBkiqjfc/6LUO3T1Z3Y/M735JN3Al0jGvyP18+h0MKE2ey7jW7g0xWq/Sjdfe804nTgN
         Y8PLpNCMcU6Ok/r72sX+HYMgmBGi/ugqz4gVSKyTijto/jPUUo13mnJS/edUc7RIC6j3
         JQuSL7vmK9vvSq0gbVGeqbvxot4r92EeYFqnsAe629c+vkGs+lkwAsKljf4YMb08ashr
         kLtRXyLQYTRrxanuRaeLWkmeaitLwR9oB4hznOu0bYOJbeGxNbpszexAV7obE6BtqLzp
         uXjA==
X-Forwarded-Encrypted: i=1; AKwUvBzFc8VzqYkWhRhfXLMWgiZ/kEv64w0Plnf/Sk0Gpd4bOp3hmDdTVFdA2f7MM6WsqJ7UBaw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgM4g2ieZ+c9zIgMvGJLbewXu724ON+ZX8qL9/twyT9/TT6pCZ
	bbaffjitH1A+iffFFUYqpu4CAqfuQkT0yN/n2SmWJvrFD04PsIT56Byum03l/Ve2wyNXobdo4hS
	b9sp7YZWCtuej/zzqkT0QKbjfho1x35elHYZ/9RqWJP69oJcdoq7WKwqNLw4z0PIFaRZyny8UUY
	2/mYMXms5fDykf2nVtfWikZsD7Qs6D
X-Gm-Gg: AYBFou3wFRiXHrGGfZ4/4xCa4+X5EsuPEvmFRlukeiDHO7nyGiK44i5U6NT5J6Xshz3
	VYSkZUPlKq/HkvwnEd4HcbaD1E+7qAMhwGm8FgOv9jvLXj29LgLg70WHcXjSYeGrJhgCn8JC8LE
	u5Onzh6WauBC2W0i9vevXJ7avzUeOdxBsAd2Y+ZxY5Ruij9KFNfp0LqefLjaZI9DSA2zKXNqp4d
	x4w+0bDe1fcubrXdALdY5n9DaY7SWRDZs0+A3GSP9nj0MpvV8BSdPO8T5A=
X-Received: by 2002:a05:690c:a909:10b0:8b0:e238:2719 with SMTP id 00721157ae682-8b133fff1d6mr5006397b3.31.1792567798914;
        Wed, 21 Oct 2026 00:29:58 -0700 (PDT)
X-Received: by 2002:a05:690c:a909:10b0:8b0:e238:2719 with SMTP id
 00721157ae682-8b133fff1d6mr5006297b3.31.1792567798485; Wed, 21 Oct 2026
 00:29:58 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020232956.99970-1-fangxy@xiaopeng.com>
In-Reply-To: <20261020232956.99970-1-fangxy@xiaopeng.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 21 Oct 2026 09:29:21 +0200
X-Gm-Features: AclHuK-PqFWCN8ST8zFxglfpmVJtYh8ceAExLMaLATIvJ8UfZfghlr_8jg8ahUM
Message-ID: <CAJaqyWdoQXHiWEh6aCGt7T+U4U4S8Z79hhp5=QYzzkODeDVyOw@mail.gmail.com>
Subject: Re: [PATCH] vhost: fix used ring index wrap in vhost_add_used_n_in_order
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@redhat.com>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Weibin Liu <liuwb@xiaopeng.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 1:30=E2=80=AFAM Fang Xieyan <fangxy@xiaopeng.com> w=
rote:
>
> vhost_add_used_n_in_order() advances start by nheads[i] but wraps it
> with a single subtraction.  If start + nheads[i] >=3D 2 * vq->num, start
> can remain outside the ring.
>
> With used-ring logging enabled, start > vq->num makes (vq->num - start)
> underflow.  log_write() then sets bits beyond the dirty-log bitmap,
> potentially corrupting adjacent userspace memory.  This is reachable on
> the vhost-net TX path with VIRTIO_F_IN_ORDER: done_idx can reach
> VHOST_NET_BATCH (64), triggering the issue with a 32-entry ring.
>
> Wrap start with a mask to keep it within the ring.  VHOST_SET_VRING_NUM
> enforces a nonzero power-of-two ring size, allowing start to be wrapped
> using & (vq->num - 1).
>
> Fixes: 67a873df0c41 ("vhost: basic in order support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
> ---
> Reproducer (verified on a kernel containing commit 67a873df0c41 with a
> temporary WARN_ON_ONCE probe in log_used(); the probe is not part of
> this patch):
>
> With VIRTIO_F_IN_ORDER, num=3D32, and used-ring dirty logging enabled, th=
e
> TX batch reaches done_idx=3D64.

Can you send the reproducer? I'm very curious about how vhost_net
reaches to done_idx=3D64. It seems some bound needs to be added there
too, isn't it?

The patch itself looks good to me, even if we will need to modify it
for packed vqs, so

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

>  In the observed run, the initial index is
> 3, so the single subtraction leaves start=3D35.  The resulting length
> calculation wraps to 34359738344 bytes, as confirmed by the log_used()
> probe.
>
> A 64-byte canary immediately after the 512-byte log bitmap changes from
> 0xA5 to 0xFF, confirming the out-of-bounds write.  The used-ring canary
> remains intact because vhost_put_used() runs before start is advanced;
> the demonstrated corruption is in the dirty-log bitmap.
>
>  drivers/vhost/vhost.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 44cac11b68d2..0226c4c59709 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -3172,8 +3172,7 @@ static int vhost_add_used_n_in_order(struct vhost_v=
irtqueue *vq,
>                 }
>                 start +=3D nheads[i];
>                 new +=3D nheads[i];
> -               if (start >=3D vq->num)
> -                       start -=3D vq->num;
> +               start &=3D vq->num - 1;
>         }
>
>         if (unlikely(vq->log_used)) {
> --
> 2.50.1
>

