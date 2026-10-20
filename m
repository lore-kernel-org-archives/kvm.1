Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792488220;
	b=rbDeXIuRIDRbIzHaxYAKYfH7htZ1mLnQxONFg8f4cYe/E8FPTrUbuKes5ohuVPEyWfQS
	 wASFdG3ddylEE1CMCDA5vsEh5WnJ283vxVsm30AzNXZdIzhc6LjrOTseTXBmNHpE2Nren
	 gfTnC8LX+ZiGRtE+XVeFo0Q1zdWpEDsxb5xYHFJkyv4qfaO8f6qdLtmZX3UFj795M50LP
	 0Sh4CTdyEhlgu8dEbaO6ZPRlzFoki8Q38iiElnVhhVCODHiMvbxSmZ7oEmuculLuDDkHk
	 +X7lMPuEXv1IdF8983bWxuiIP/Czxm6KoohZLSW+H8xfVeAUMpj1HKqhfM8ci1q00Iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488220;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=SHMt9246WTDFLEZePkrRxUyIIpSwpuVsNNwsVJXluYs=;
	b=E8njD35rwapmDiLTdsecQG9Y1PbTGqDQmxaCEG2Z7DPp4JEVovj01vgLevTdK4EfCmgO
	 68T9citB3aNsCFntz6nvSOR2+FHbD57uNQg6S5tz+6EK8LnfVLirQ8y2dRKByTlLTtYDB
	 ELcElVfyLINxJjVWH7oARVcOsLbFrJWUTTeEZ2Pb4wqv1Wza5WiT7Rxr6y3pQQPK20+qj
	 pjm65vTpL8fJwb+HbZQlMfIVBPBwyQQq4IJUCJTdztguUYqZQiEtWTKfOeu0FuvHn1JzK
	 fRXB9NYOi7Heh1SbCqySYa1qREMfMKWOeuYY74rcq7fan2gRmqD3OK0kSEKzi+nEoZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NfypJeRK;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hby2gAxc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB2B606A319
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 09:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FB2B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NfypJeRK;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hby2gAxc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792488218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHMt9246WTDFLEZePkrRxUyIIpSwpuVsNNwsVJXluYs=;
	b=NfypJeRKRqwFquvhsEq68Ko04X10FJe9akXqv9Cw/6TVq8Os91UDZc0hjOHkQ9pctkfk4j
	Gip1o/G3nuaifXgBFIHG0dCERaCSCtu168weusAWOT4RzHwPlLnIjg10usOqq8IbOEGMYB
	91uKhEY4Z2moI60gkOmmaWWwqDyyFnc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-CL693FjpMROFhnI5uk_k8A-1; Tue, 20 Oct 2026 05:23:36 -0400
X-MC-Unique: CL693FjpMROFhnI5uk_k8A-1
X-Mimecast-MFC-AGG-ID: CL693FjpMROFhnI5uk_k8A_1792488216
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b0da010661so36983037b3.3
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 02:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792488216; cv=none;
        d=google.com; s=arc-20260327;
        b=CH30I0mu+11MiW9QpgzvnrsKB6+2cSLwCY78ULPH9+pXhpbh70YVCb/IY56G+pR2g7
         0HMEym7jiFx/cvh6NSsCc6bcwSCwyggCXR9grtMhXKc/mDX9TPd7s4NsN2X41WtbADW2
         8NKxTnRm/j3xEbx64U/WkIwdyZ+mKITpj+R0B80LDQlmnztfV6rsoOz6QEHJZUG5rETL
         GVYIqdh9w9pp/bewDacZdIdIT9UkNQ0NlQUw7NYs5uff2atTkkQtL0NYDL57W9pw8TxX
         fxk+FA+KCiaBfXamJv292Kfl3RjSJseHhZcx3VpLvUlabfRsUx3bZD58aelPMTIlu9Xt
         UWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SHMt9246WTDFLEZePkrRxUyIIpSwpuVsNNwsVJXluYs=;
        fh=RJND1+z9lqWc2D6OqnnBMH/ydb5IC2C6fC/w6Z3pyb8=;
        b=LMPMVIktr5eB/WZ0airAQ1rLUJoQYdlcpMC7NQqTnQ1d/VvIvSOjWOfpd9wR/eDq1G
         RCRO8nH7olQmk+O18oiOzY6w9A+AlRIpRGX37TSDgasEbVi7+JvtEsnebsyIMATGxvaC
         t6qXToGdNtqa9nQyGgvmCvfluMCZIY80draCYfPCSGbLOH98gFrwVicCjIYpyuJDZxCP
         sIfeCpCEJPgyI8UaHU++EOfCwWbkSG+ky/n6wQzneP61Hmmqv682LEpEMrSWQJ8Sbjy4
         rRkJTosEj6AvCXaHCCaN3zrekH4kjhXdBtn8U3b27fmC84orJsSq3HJBNk3lPjfioUTg
         MbkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792488216; x=1793093016; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SHMt9246WTDFLEZePkrRxUyIIpSwpuVsNNwsVJXluYs=;
        b=hby2gAxcNdTWzdUqTNHbKoqPgYs9+RwdQYZCAT9uIZ+Jo8Pewur+omvwYgPXhn2utT
         oscV5hKctbK4ABDf64JM5NYQfaXRPDJSN+nCTqB/mrxnKl1MnTFr9HNDrpImWuALa8au
         XWQfHOnVVmlsRgTH3QjEGiTLCgIpR549YwUf0cFw/mQn9WMPAvlCepje6YYVbTzwfgOC
         fc06S+RXOtTUBlRnzP2NuZjz9JioD+1SMKDLJFdfNeIQTQzmACsanVk8CdnCjj7va7kC
         3nrrR32DwI5LAFZxc6XPbqN7foR1w0H8qfbRZqXwqTZ9zUDqqsL2wv/zoKZnXrgIcGzn
         sFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792488216; x=1793093016;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SHMt9246WTDFLEZePkrRxUyIIpSwpuVsNNwsVJXluYs=;
        b=aeFZ9DuNJvvw4sDS4Zbf2vpdBBIO14NxZ1O004EojH7j/QoaHPAp4maH4gQRqhJ9gV
         RpRD7RH/nvfY0tKIppbmA4PCJvcjGcZ5d/VlgE1bWM92lQVch4kGdoObJzNaOAwhjFbN
         o9ljjOiXk3xJAJqAGffgbLKF7RbU6Wa1DWowYMsd4eJlQSlgPDTb5FxbNyt62pSgv7ht
         ivtd48Pxc6srFtMQxuNgDKfNtsnzgGwagW9QIJi/HG98r8nLP4l0il596H1xMdBJ5LV/
         kJLg795aCZnWrU7ntvJoPiKoReXntVb+/Leg9Cv4L4b6LKmExbeA1ls1mjo9p2E/3Ld2
         svZg==
X-Forwarded-Encrypted: i=1; AKwUvBwjn00vUj98gVcb4kdNJZI0iOeZj5fa+wW3FzxQupu3rW3LuyzyHZYSvr9ouGnRAq57gjw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBSf/l9kcq2y7hp2CGl/Wwhza0WNDNFx8HQ/7K42h87C7SQoDH
	6qctC+jIkGmV59AX4K+Oy+02zg36pp5Dl7aWdqlr/w0fqDsAyK+vLVutWYeprKRU2/yzv/x0rHz
	x0gPugapWt+tUEAdeg+0LkZjpMjfhV+5BaQGSKK0P7uleJjm5CJZebapPIdsWQ/xdTSPkNe8mIt
	wVJrGL+f5g5W/Z/LARjYNk5A4S7nlk
X-Gm-Gg: AYBFou3MgQF4ttP2b/cklxFHzzL+5ePq1GJCtRMngXNO8BWtkyxa6A6DY+gJK0BqIIK
	eNUVsg2x1v9UYMDRSb31XWmkn50VlV2qLk/NOSsUHtI0Cddi5ogpumjohINyG3fHP933gaGbJIE
	ChhK9Yg5B2apFZNxbZvFgnpuWxFPR6do8fbxGXTnaMDaugb034bFYaoMt8pOA+bAJO3Nfo7fXcq
	NIdaT+K/Ml+WUkiRVEM6HGk3hhKg9923fHDOo4IsUBehqmaeQXxgBoZ8Kc=
X-Received: by 2002:a05:690c:7107:b0:8ab:41ed:c08a with SMTP id 00721157ae682-8b0f1f1a888mr37599677b3.0.1792488216202;
        Tue, 20 Oct 2026 02:23:36 -0700 (PDT)
X-Received: by 2002:a05:690c:7107:b0:8ab:41ed:c08a with SMTP id
 00721157ae682-8b0f1f1a888mr37599617b3.0.1792488215700; Tue, 20 Oct 2026
 02:23:35 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com> <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org> <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261020021924-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 20 Oct 2026 11:22:59 +0200
X-Gm-Features: AclHuK9FUCG_bUrdJCcSR0YUoQOz7ayN0KKtj2bVgQH1ECGQzQu04PmOJxsZwI8
Message-ID: <CAJaqyWfcg_K33c5hzSh83vgTvujn_M_8odcxFSTVzkcv6jQu9g@mail.gmail.com>
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wang Haoran <haoranwangsec@gmail.com>, torvalds@linuxfoundation.org, 
	jasowangio@gmail.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 8:31=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Oct 19, 2026 at 03:14:46PM +0800, Wang Haoran wrote:
> > Eugenio previously offered some additional suggestions in reply to
> > my patch email. Should these also be addressed?
>
> The following seems to work for me. Testing would be appreciated.
>
> From: Michael S. Tsirkin <mst@redhat.com>
> Subject: [PATCH v2] vringh: use get_user/put_user in the use_va path
>
> getu16_iotlb()/putu16_iotlb() pass the address produced by
> iotlb_translate() straight to __get_user()/__put_user(),
> without access_ok checked anywhere. Not good.
>
> Switch to get_user()/put_user(), which are always
> correct, and safer.
>
> But the fact is that accessing user memory like this
> will sometimes (rarely) race with page being swapped
> out, trigger EFAULT, and it should be retried
> from a worker, and vdpa_sim currently does not do this.
>
> Fixes: 42823a871fd4 ("vringh: support VA with iotlb")
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ---
>
> Notes (changelog):
> v1->v2:
>     Use get_user()/put_user() wrapped in pagefault_disable() instead of
>     access_ok() followed by __get_user()/__put_user(); the helpers are
>     reached from BH-disabled sections, and __get_user() is not a valid
>     way around that (David Laight, Linus Torvalds)
>
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 2 ++
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 2 ++
>  drivers/vhost/vringh.c               | 4 ++--
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_blk.c
> index 76dd5b0828d7..325ec8f0ab85 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -347,8 +347,10 @@ static void vdpasim_blk_work(struct vdpasim *vdpasim=
)
>                         smp_wmb();
>
>                         local_bh_disable();
> +                       pagefault_disable();
>                         if (vringh_need_notify_iotlb(&vq->vring) > 0)
>                                 vringh_notify(&vq->vring);
> +                       pagefault_enable();
>                         local_bh_enable();
>
>                         if (++reqs > 4) {
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_net.c
> index a6514b5ccd86..964cdf422467 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -77,8 +77,10 @@ static void vdpasim_net_complete(struct vdpasim_virtqu=
eue *vq, size_t len)
>         smp_wmb();
>
>         local_bh_disable();
> +       pagefault_disable();
>         if (vringh_need_notify_iotlb(&vq->vring) > 0)
>                 vringh_notify(&vq->vring);
> +       pagefault_enable();
>         local_bh_enable();
>  }
>

Why not move the pagefault disable_enable to wrap just the accesses?
Future vdpa drivers could use va and we might miss the call. Also, the
reverse is also true, vdpa_sim could be configured to not use it, even
if it is not a big waste.

> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 9066f9f12ba1..74836eb60c7a 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -1213,7 +1213,7 @@ static inline int getu16_iotlb(const struct vringh =
*vrh,
>                 return ret;
>
>         if (vrh->use_va) {
> -               ret =3D __get_user(tmp, (__virtio16 __user *)ivec.iov.iov=
ec[0].iov_base);
> +               ret =3D get_user(tmp, (__virtio16 __user *)ivec.iov.iovec=
[0].iov_base);
>                 if (ret)
>                         return ret;
>         } else {
> @@ -1251,7 +1251,7 @@ static inline int putu16_iotlb(const struct vringh =
*vrh,
>         tmp =3D cpu_to_vringh16(vrh, val);
>
>         if (vrh->use_va) {
> -               ret =3D __put_user(tmp, (__virtio16 __user *)ivec.iov.iov=
ec[0].iov_base);
> +               ret =3D put_user(tmp, (__virtio16 __user *)ivec.iov.iovec=
[0].iov_base);
>                 if (ret)
>                         return ret;
>         } else {
>

