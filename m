Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466F134CFC2
	for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 02:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789870772; cv=pass; b=Rw/QkptkSpJubocICxhq768QsK8aocAsuGEuiXQcUEvkSzF5ZcKQ/KXg/fURmXRrqOtUSs8Sq4tLLZKb84WRENrBBzgPTALs+95c/5yrWVUB/sAJYuuvw5dCi7NdWjLb+EdHfLs5BYPTn40S4YbXuBcG4mwprqYPcGg2tD9kIWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789870772; c=relaxed/simple;
	bh=Oj5sg9PCyDUl3TeOjKEQSeMqK8FhKnxaUFXuz/wNJ/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMCjRqozKPlbZHj/VqXKmKo47zh1zh0JXIFnqUKaD7sCB2ynsC0NLhzWu7sZ5YG5M+NQIkShM2lARl5+Fh0OPkCwJd9Rfr9KW06s7p5RyZtFALhAbM85JiZ28mmap65litCoSjBN4qOx27HVqXqJmUtGgYFfsbJkKnV/DHzd5o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdY/aojF; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdY/aojF"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93a2dea320fso204634285a.2
        for <kvm@vger.kernel.org>; Sat, 19 Sep 2026 19:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789870770; cv=none;
        d=google.com; s=arc-20260327;
        b=Mpkb8MKFCBYHuNz/9jeSOgbD9TI06ohtlIH8UTt4KJCObslYNEUtgRqleX40mIjqlf
         sxuDdLLWi5Ffatrh3NEf3brntWuLAf9B57RN20pA7gB76UA0P/qJLjM4cWDMfC73D5rt
         9yq+7Cy/2p6FsIhU19ufZd1nlSgdfvnFYJkBys8dQ1EYPS4ziG8Q6rjXKMC0d0Mx3iZW
         R99n250OLxGw4lERpJF972RArMThhkzXhcCm6yqG+JulGPEfdITPsn+GYBWIvU4Ot27U
         cx6sDI9IEV8SpmhGUcBeJzMRdGPmIwp3TRdY83yGzviLOCc2OLTrnjWBu2B6lE/RsEaN
         jNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=t1jf+n9Y/HXbw9hy+wSRUxXx+QGd/8tyjA6GiwXlHUQ=;
        fh=a1kmkMLMDBjZrLy3Qt1pdpy/eNe/5Ri1XQNWDrEMcpA=;
        b=Ke2FMQzl6cwlw26qkl+aSoIhCiXdyl/N5DPSeOLlvsmq0i7nQO17fCFxGvGzlc5xdA
         qHnYW4nJmxFsUSP5eqAEBZBH6twN8woQVkuDGlQoSBLhCd3mvxGk7uhX6e12L8dRHHFk
         RqiEv404wzOWLyuzvlUQD9c2RluP5nmW22gFshLuTR3nztV75neer37mYNHNvBKV2ted
         935nkZolN/gY48pJumxky5P9u+nXczIwEVN091RT6krXmSQ8DUSPCjkZLG09yw4l134C
         s7H7oYi8n/kZZvsCzlwCdbGNOheLpg4/vPNv6Nin1c/SKrkKCyE5eMeTk6nXPI4fwQ3Y
         UJ+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789870770; x=1790475570; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t1jf+n9Y/HXbw9hy+wSRUxXx+QGd/8tyjA6GiwXlHUQ=;
        b=ZdY/aojFRC54Cf2Uxg5kJI2s7ovE/rCSqWRmZqYsrhcX5FrMmwETLowV9bl+QBfGAG
         V9RTkGu0hepuCs2TIYuIo0FoCh9W7o42lN8okRXyHvq3fTJkX6+n219g/55KehYaH0Fz
         dih1Zl7u75NLe16cg/EUIJ8cqYY32pjeZX5MGVcWaH40cnuxooGTG6UBikVes5UYSiiu
         rMt9SFFV2v8p/XqreluP5GuSnFx/JOAyanhSvajdHH4QSM/kcsNMdrs2/n3bNwnZQ2uW
         zdNXuKpO1WZOxwD01u+BtOFvRSKVeBHejKDE6kM+t9wieGv/Bfb0UeYMEyYi5doSxGLc
         NBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789870770; x=1790475570;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t1jf+n9Y/HXbw9hy+wSRUxXx+QGd/8tyjA6GiwXlHUQ=;
        b=SGUvej1tYonSl6pQoCMMH7Zb5xIol+SxL2P8M/j8kno4vTMeaBwcxyR4Y+G5zdt335
         V63bbBOrjj1Bed8vv/FORXebC5cIuBu/KUc8tIJpzULdDIm1uaUg6LltzxW17YhNBanc
         H371LFezfwm2tW5BrWlu40A0nXhxYysZ3SexLuSwIn5rPqajXGg9VI7kTlvwv+LhJCxO
         923xniDU03sqxmlogI3QoJqgfRLbV4B7CA1BDSmlZdTW8yJ+WdVd345rFJX7+v9Gw9Pm
         vKY+vQJJCWeh0A+C8ELg0AjbAo1pHHh2k6c9D5nySuJbstUE8K8PAx07Zo0K4qEY5ELX
         PS4w==
X-Forwarded-Encrypted: i=1; AKwUvBx6QSyZ6HeJVolw/lEj2JiAEpGBRaZpgikAf0gLp5nYNgnUonEb0wUg1OK7V7U9ny+kwJk=@vger.kernel.org
X-Gm-Message-State: AFuF++mcJEppnHeN7PX4GqgxQadJRfpPeHLzt6TQAWXIoEsLqGrysi9r
	mYc7ckH1wyhJ0OIC+aNuLb0ztA7RXcb1jXeocIWVYPr1yUgrcm2HDI3W+rYPzPybiHqrDvwoZL9
	ZEzo5t6bj4fy7dXYNoo2ZM7xMyPQpN/Q=
X-Gm-Gg: AYBFou2M2z0tZEDcaIc94pT2Yhbxqr1MGg26lMR5izYlqvPkATNuEHWlpendijYAkBN
	EL1qzS5p33s3HXjTK3IYUxrzEFSnq2Z18/GebR05EWAJ7P894b7d1PWjSPyZ/+f/mZOlF68HmLA
	SuY4adiMlBPPEknoSUn/uduj8vtKvtCOTsL3eEVy9c6gU9OhGLSxJXBi1B9CYFwgk3sdjUlNyH5
	r3cVym/YfzLSsV+/9fq5szP6c3bPvDCcJjCOmt+LENqWdkAjYMsnIPp1s+OM1V3+WBDSJA/RyQg
	1ipMoAcDFJ4Pil649/ynxga0k1c0rSQYGiDQbWkLYDDZK288Ooj7Mccr
X-Received: by 2002:a05:620a:a0ce:10b0:93b:d58f:4fab with SMTP id
 af79cd13be357-93bf5595417mr270410785a.25.1789870770127; Sat, 19 Sep 2026
 19:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919131744.131030-1-physicalmtea@gmail.com> <20260919152336-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260919152336-mutt-send-email-mst@kernel.org>
From: Jia Jia <physicalmtea@gmail.com>
Date: Sun, 20 Sep 2026 10:18:53 +0800
X-Gm-Features: AcwNN1VkMN-0syiFYPeuWa4rISLvm99vUAZPB8bHXDefFB9Y34rSJVqTJuxGaqo
Message-ID: <CAJwVaM+BmE_HoN_hSYL28nhZh1ZStqH9Od3pizAb_fyTZAS+5g@mail.gmail.com>
Subject: Re: [PATCH] vhost: keep vring addresses stable while the backend is attached
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Nicholas Bellinger <nab@linux-iscsi.org>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sat, Sep 19, 2026 at 09:17:44PM +0800, Jia Jia wrote:
> > vhost-scsi keeps the response and bounce-buffer iovecs until the backend
> > completes the command.  If userspace changes the vring addresses while the
> > command is in flight, the completion data is copied through the old iovecs
> > while vhost_add_used() updates the new used ring.  The guest then no longer
> > sees the completion.
>
> I do not get what all this is trying to say. if you break it you get to
> keep both pieces. when is this a real problem?
>

Before running the test, I checked the virtio spec and vhost UAPI and
did not find an explicit rule
prohibiting changes to vring addresses while a backend is attached.
That is why I ran the directed test.
I see what you mean now. I'll drop this patch.

> >
> > Reject changes to the vring addresses while a backend is attached to the
> > queue.  Keep accepting the current addresses so userspace can update
> > VHOST_VRING_F_LOG or log_guest_addr without stopping the backend.  Queues
> > that have not been attached retain the existing setup behavior; userspace
> > must detach the backend before changing their addresses.
> >
> > Fixes: 057cbf49a1f0 ("tcm_vhost: Initial merge for vhost level target fabric driver")
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  drivers/vhost/vhost.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 44cac11b68d2..074590838de5 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2150,6 +2150,17 @@ static long vhost_vring_set_addr(struct vhost_dev *d,
> >                               a.flags & (0x1 << VHOST_VRING_F_LOG),
> >                               a.log_guest_addr))
> >                       return -EINVAL;
> > +
> > +             /*
> > +              * Commands may retain iovecs derived from the current ring
> > +              * addresses.  Keep the addresses unchanged while the backend
> > +              * is attached.
> > +              */
> > +             if ((vq->desc || vq->avail || vq->used) &&
> > +                 (vq->desc != (void __user *)(unsigned long)a.desc_user_addr ||
> > +                  vq->avail != (void __user *)(unsigned long)a.avail_user_addr ||
> > +                  vq->used != (void __user *)(unsigned long)a.used_user_addr))
> > +                     return -EBUSY;
> >       }
> >
> >       vq->log_used = !!(a.flags & (0x1 << VHOST_VRING_F_LOG));
>
