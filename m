Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489295;
	b=JeqUvrk39mlJXdDP7cQZHaK0oMe4ZfDqyhvcKUd7DUdgI/51xVN98zX5wKqvkRJ0scTF
	 0Q41q754UYKVbpDbU0fgXX30BB8pSSk4Oair5ewdF9DJdxXdPbAC8fVYlKaKyX8SOfUMr
	 8a5qLRVfDlnSRatIBbI26otZaj0nO/kLXdTpYt2gvcZdpN8UubHPm/0xlt2RutUZFIKG5
	 Uys+L3cO0jZqVn4iqWGfT2dFaZ1Ep1DgHH3CzcY9k0xps6lM+XSEo4P8wQ7wXgWm57V/Q
	 TPR8/TtJqWTE1psMvuK52RRRPPkgwnGbPbiayuu0FNlcIWkUMgItG0xo32jWR6HEw9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489295;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=DruToGQJ8QxTgYnIiS8jfyW7h08d1jOiadZ2C/M4nnM=;
	b=s5G8xBXiPOzZcpeZ5RYkhgxAWWPhBKdXqW6hxqokFHdlUooOL9eq4GXYzQ+Sf0HmeUZe
	 46vEVYTUi1gEaDniyTjnrdl7fXAgadmy0gWbtswOqs+R5yArWCgCk9MjTexEkd5LmVn9q
	 h5RrJWCAKeMAFc5pVYNQh+fZois//FXHLe6JDp1uNNBP1U7/37zQksD3X5yDgx83C675e
	 0+L1yZJGMkgnKUsBqTHqgKBh+dk2mvI3EoS1t/69qOMB34TI/9Ii9qwOfhSS8y9tUhXKr
	 LJ6za/Qx5CjbnItYymoifp20Dk5ePBOcRcyhjS8Fmb4prqHFASp08vTPTtYpNwmKtXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="K/JJF7cn";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=thMXV7hS;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08AF60A4AF0
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 09:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C08AF60A4AF0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K/JJF7cn;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=thMXV7hS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792489293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DruToGQJ8QxTgYnIiS8jfyW7h08d1jOiadZ2C/M4nnM=;
	b=K/JJF7cn1b2v39EPXSI4LcmWuQRbWrADl1q8iTSWrSIltNdbR4rVMTKkdXGqJ64Y5n4uHk
	VUKDLUa4lYeTgz8sMAuv+ggQoO7SG2xPDossWKDWTbWefQwsrbkGR7IM/41QRhlMgRzBPz
	KSK1y8iBGhyWJZyf/B/VfMj3yKtNnJ4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-jwsTMZ5tM8-ddCSc8v0hiA-1; Tue, 20 Oct 2026 09:41:32 +0000
X-MC-Unique: jwsTMZ5tM8-ddCSc8v0hiA-1
X-Mimecast-MFC-AGG-ID: jwsTMZ5tM8-ddCSc8v0hiA_1792489291
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e0ef019a4so2247485f8f.3
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792489291; x=1793094091; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DruToGQJ8QxTgYnIiS8jfyW7h08d1jOiadZ2C/M4nnM=;
        b=thMXV7hSlArkty2E09MFqC8JiSmsxCNhX4jsyo4vaGhi9sjt/1MWEsimi2z0BvEqzR
         ZPk2y5DI132wHcgq14xsxNy24W2sezZ59Quuw6nzKEefP9HWZ/ADqVXbyhsOwdCfw04j
         7fhEXLdKAfdw+qV6GrRLGFnFW6e8LrnWxhnmJGq9T7AZTFDO7wYg30X+NgvGT6a/elaV
         chFFk7pMHY9zdWpFFmQR1YA8SSYE8YxykqfN9O/BG7IYyZyrj4peBGEzGCq7MGMq2ON8
         SDQGmEuvxHPcpRh5HQX6QHv+ydchkUOsfXxU6ECpifQd3XmwMWXzGRscsAhTL08egn/F
         7tQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792489291; x=1793094091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DruToGQJ8QxTgYnIiS8jfyW7h08d1jOiadZ2C/M4nnM=;
        b=ZGdGy9uFgCpm/Ai89qwcXEuCCcx3egXw2bfDjWwvEvZKyyqaZ5qJZ2zTgnVW5F/ddZ
         nWoJIklcxfXpR67DGRmdaHJAw13MYGStR+a7mn5N2A3ofXhSSFaCTocOoDC2bH6q9guc
         MLfTy5XBserZEFHpp7fONmUuYqXngY0uat9a4zgKKDz+GP3lpXnFarbYl5Wtsnc0qq6y
         CKOQZtLYhwfqfpitXuPvF26egukXOGyn9oWZTCB6xFeNlbHVm1mB8xGoIwwchv9R3cci
         WOiXkII2ALPZjeYwN6JuQKz+m3OYUyhGtAWznk9usystVUdD/UPpDtd/S4E9odAblRvn
         2lPA==
X-Forwarded-Encrypted: i=1; AKwUvBxgdKh+OdaibDjq379X7bQzSGRM5gy5WGg8vzC2bTO1530cX/yQogDwrWGcPmEWEP5jsk0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKH9ILsoEaaMf6hMFS5YMveUgFlKJM3RFx5cEW2Tv6H3NQZqbID
	1x5rQhQjQAzMCcHyzAQjS1Fi00blymC05wHcjeHq0hDTtMH6j2RurA6jOT7YDT/BGcVTsA7uGxb
	MqdsdPjTnlmD3MSDyOMlOlvV67oWb0jV0vnwZ7znkEezdYb2iW2RH5g==
X-Gm-Gg: AYBFou39I5Uf1KHHMsR5oVJNBd+KQdAJ/g0lax0aUapR731i8s9D1oyJn36SQD+kEb6
	DhVYNd7answ4fnTBWb6Du3uIGDOIKY+kY9TQywXrFXw+L/aU1MhqTzBsh0XYBrivU+G7b2UErg6
	CU/hq5wjQIgoCxzSWg97W+5TZ79TvoOpt1mqXGb8yaFpgb2MsjsHoOovgm/r9Dz0KYNtrrw7K+3
	nZ08Uq7qRVk07sMODA8wxLzVjGFgFIxuB5KwtzAAI2KMwqxNsBtbfnep9vBfrg3vqoZ1pC5n8Em
	gBHW5lRRzsob5oSuBmAs4bP2GIh7nsu7MIls2b6pypxnActCLUaOhh1kbER4a5fESokm5g==
X-Received: by 2002:a05:6000:4288:b0:48a:fbf7:15c9 with SMTP id ffacd0b85a97d-48e079888a1mr21624730f8f.1.1792489290982;
        Tue, 20 Oct 2026 02:41:30 -0700 (PDT)
X-Received: by 2002:a05:6000:4288:b0:48a:fbf7:15c9 with SMTP id ffacd0b85a97d-48e079888a1mr21624669f8f.1.1792489290347;
        Tue, 20 Oct 2026 02:41:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d82dec7sm4899460f8f.46.2026.10.20.02.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:41:29 -0700 (PDT)
Date: Tue, 20 Oct 2026 05:41:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Wang Haoran <haoranwangsec@gmail.com>, torvalds@linuxfoundation.org,
	jasowangio@gmail.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261020054100-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org>
 <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
 <CAJaqyWfcg_K33c5hzSh83vgTvujn_M_8odcxFSTVzkcv6jQu9g@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWfcg_K33c5hzSh83vgTvujn_M_8odcxFSTVzkcv6jQu9g@mail.gmail.com>

On Tue, Oct 20, 2026 at 11:22:59AM +0200, Eugenio Perez Martin wrote:
> On Tue, Oct 20, 2026 at 8:31 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Oct 19, 2026 at 03:14:46PM +0800, Wang Haoran wrote:
> > > Eugenio previously offered some additional suggestions in reply to
> > > my patch email. Should these also be addressed?
> >
> > The following seems to work for me. Testing would be appreciated.
> >
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Subject: [PATCH v2] vringh: use get_user/put_user in the use_va path
> >
> > getu16_iotlb()/putu16_iotlb() pass the address produced by
> > iotlb_translate() straight to __get_user()/__put_user(),
> > without access_ok checked anywhere. Not good.
> >
> > Switch to get_user()/put_user(), which are always
> > correct, and safer.
> >
> > But the fact is that accessing user memory like this
> > will sometimes (rarely) race with page being swapped
> > out, trigger EFAULT, and it should be retried
> > from a worker, and vdpa_sim currently does not do this.
> >
> > Fixes: 42823a871fd4 ("vringh: support VA with iotlb")
> > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ---
> >
> > Notes (changelog):
> > v1->v2:
> >     Use get_user()/put_user() wrapped in pagefault_disable() instead of
> >     access_ok() followed by __get_user()/__put_user(); the helpers are
> >     reached from BH-disabled sections, and __get_user() is not a valid
> >     way around that (David Laight, Linus Torvalds)
> >
> >  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 2 ++
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 2 ++
> >  drivers/vhost/vringh.c               | 4 ++--
> >  3 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > index 76dd5b0828d7..325ec8f0ab85 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > @@ -347,8 +347,10 @@ static void vdpasim_blk_work(struct vdpasim *vdpasim)
> >                         smp_wmb();
> >
> >                         local_bh_disable();
> > +                       pagefault_disable();
> >                         if (vringh_need_notify_iotlb(&vq->vring) > 0)
> >                                 vringh_notify(&vq->vring);
> > +                       pagefault_enable();
> >                         local_bh_enable();
> >
> >                         if (++reqs > 4) {
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > index a6514b5ccd86..964cdf422467 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -77,8 +77,10 @@ static void vdpasim_net_complete(struct vdpasim_virtqueue *vq, size_t len)
> >         smp_wmb();
> >
> >         local_bh_disable();
> > +       pagefault_disable();
> >         if (vringh_need_notify_iotlb(&vq->vring) > 0)
> >                 vringh_notify(&vq->vring);
> > +       pagefault_enable();
> >         local_bh_enable();
> >  }
> >
> 
> Why not move the pagefault disable_enable to wrap just the accesses?

We want most accessed with PF enabled, so memory can be faulted in.

> Future vdpa drivers could use va and we might miss the call. Also, the
> reverse is also true, vdpa_sim could be configured to not use it, even
> if it is not a big waste.
> 
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 9066f9f12ba1..74836eb60c7a 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -1213,7 +1213,7 @@ static inline int getu16_iotlb(const struct vringh *vrh,
> >                 return ret;
> >
> >         if (vrh->use_va) {
> > -               ret = __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> > +               ret = get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> >                 if (ret)
> >                         return ret;
> >         } else {
> > @@ -1251,7 +1251,7 @@ static inline int putu16_iotlb(const struct vringh *vrh,
> >         tmp = cpu_to_vringh16(vrh, val);
> >
> >         if (vrh->use_va) {
> > -               ret = __put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> > +               ret = put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> >                 if (ret)
> >                         return ret;
> >         } else {
> >

