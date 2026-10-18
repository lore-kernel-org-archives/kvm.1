Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7260D41A547
	for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359808; cv=none; b=TOX+1uzirqvl6lsRbCdJGPxZ/8nY0gMeYXZMzKusuTo77CiMwn+pnuovebu6QJLPr+tYePDv8fBg9HcymUOWEAvLQ19NoMNxYg3gwoEFKu8lNj7QJv6HHdxttVvM2mEs34Qgm5fz3Wc1KQ1DKQV73MRz7vQKWENRiIcfp9T4ZMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359808; c=relaxed/simple;
	bh=TMzR+utcD6ruredlhYW/mB7GgCGF9DnuMgw/+gVxnvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vsx5WJGz7jq5JGJ4CUqKthMq+wzuWi9rbZSqzhjJgweB01R7ggJRlhA/d0szZI+ZvaEbUycbXlbbhIlSElozIdFZ18Yx9RC8ZHjUheW34nGJVOCdAcWQ2MC3bC+kLcHQ9LoQlUaa95JosrQudrBG08GVld/Dyvf1vRuyxmfTVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bj9d7fSK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rjKaAMBF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bj9d7fSK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rjKaAMBF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792359806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JqsDUnOkotcWzQsS6kq2O+WN8oUkk4ukJhj46VjmH2Q=;
	b=Bj9d7fSKdFfVivhGffE9NMoRmGxy2thZ5E91cbComp+ScF6fcnXu6Ah4Jbf4pVB9/BgMI7
	wzOQZo6gguwv1VSs2MuthfdaBFMbmbmSzRZQFKuEkMLEh/fxiFY7UNbXS5Cb5ayHv404V4
	sl/W63I6ROuJXElx0gPC7AcsI+ZSXhE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-6a6Hl1zQPiqKS_uZHnWmpw-1; Sun, 18 Oct 2026 21:43:25 +0000
X-MC-Unique: 6a6Hl1zQPiqKS_uZHnWmpw-1
X-Mimecast-MFC-AGG-ID: 6a6Hl1zQPiqKS_uZHnWmpw_1792359804
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48dfaaea30cso965519f8f.0
        for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 14:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792359804; x=1792964604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JqsDUnOkotcWzQsS6kq2O+WN8oUkk4ukJhj46VjmH2Q=;
        b=rjKaAMBFj9BPFjdvSydSYkr/S8Om8rSn2ttMaO0E8vvw0tvmHzjQcwlNFEJ7XTjvVI
         URQaG5qpoLwV12qjR4xvboT8B9MsshtEI8DtKz8xtnmJTJra1sBiTgEfSZZm0l89nJIh
         okgal6Dl4EnhSziuV6bqGkFveG3GeezKLJJHvbJtVuu8UH+/vXYfGyicyOgjyqfGVRqz
         FQqbXZBTdmbI0bIyJcX8+Z/+8ZuKQXCN3Z5JeocQrTCqvcB5dE4rWvfUnMqPYdraHTRR
         NlU7Nlj4vDwOOPSRO2mXXUPlrKIT8eqXb3qC4ujsuQISwwHQYOG8xV6i/GBPZRoaovqC
         ge+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359804; x=1792964604;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JqsDUnOkotcWzQsS6kq2O+WN8oUkk4ukJhj46VjmH2Q=;
        b=xePLsrASA5rLe1KXPm0wPhCrnrKWT8tTnfb55G5REQSSW2qVVaIdpTE5xiqIpMXRvr
         ilJD3GuY9Arazgxqs1LWzdvSlRYOyliSUpO+UI2SrvrC688qXhzzGjbeB7/FwnSP01C6
         Ieq9+v+NiT1viZYZDwOCoHVLsmyBFC2IQVpB+XtOJDOFYbTQo116aVKhTbROt00ozMyE
         ArGyKiZJXl1g+Y3pPf8ywpGy8IsTi9ot1LgPl84T+lSklmb7Mer58+Fk7SGfHt/NSVXE
         qgTHIhMvOmsZrDYeQq6JGJGLAhvn65QPRtjCE7/K19Vd2tfdCtD8arhys/SzCrm2pf4E
         DFfQ==
X-Forwarded-Encrypted: i=1; AKwUvByPVYV1lxgZ/hRZxwLK0zSQGD30X5tf/XVXyP+vEcsRZnbRutc/vqRBEcel+6bFIUs9iYc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIk5+UmVE6jwMjPB2TRJQ1i0F7mo4ExQBeeJjTPJ1QDKoTqlmYE
	kjeHsIuIWY7tOwGpNjjAHpz5x+ES93qll9araMAJrhheyE0ne/iu7PocFhfM18SLOyEJ21mpARX
	OojJnxbpzCC2f9OUEbKm5ETMeXeZWZt6zOIMnaeBaSaZIEX1gkfzQmg==
X-Gm-Gg: AYBFou31c6R4nfirslvnYrHmeqkjHMjLEyTY7A9s7xgdK7mTSF9hZPYfrfxLgUJ7s7P
	ZZ5wMxLxtjjpbLtVrHFK7JuJZaRpn1uSfAQG9MQ5dSqnCaoJp7V9EzsGjdGJKyeKuZvRDUtLMGP
	gQIexD3UbmrtPv7hjwAR5/JfFSW9gCSj9+zPc6ugg0h0hWyT+3Sicb3AM5rNbOJvKucY9z9oAIX
	P3wkrf5AjrXLfkDOptC7GQK2jpS12d5Lp+sQODrVBKNjf+ZlKlLN2VXMaNCDOQZxjCbPkGiniK+
	6wojyhHfRf7zBBVWHAhCka4QW04/xGQVDHmBsWsFKGsc9bn+xrPx9XwBK3xAbsd7PpxEfA==
X-Received: by 2002:a05:6000:468d:b0:48d:fd4d:7fbf with SMTP id ffacd0b85a97d-48e07988954mr8057917f8f.4.1792359803754;
        Sun, 18 Oct 2026 14:43:23 -0700 (PDT)
X-Received: by 2002:a05:6000:468d:b0:48d:fd4d:7fbf with SMTP id ffacd0b85a97d-48e07988954mr8057906f8f.4.1792359803264;
        Sun, 18 Oct 2026 14:43:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfdcc0f20sm18573888f8f.11.2026.10.18.14.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:43:21 -0700 (PDT)
Date: Sun, 18 Oct 2026 17:43:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, eperezma@redhat.com,
	linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018174250-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>

On Sun, Oct 18, 2026 at 10:34:12AM -1000, Linus Torvalds wrote:
> On Sun, 18 Oct 2026 at 09:26, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > +               __virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> > +
> > +               if (!access_ok(uaddr, sizeof(*p)))
> > +                       return -EFAULT;
> > +               ret = __get_user(tmp, uaddr);
> 
> You should never use __get_user() in the first place. It is almost
> always just a bug.

Right, I was thinking of some other code. This one should just be
get_user.

> And __get_user() together with access_ok() is actively wrong and
> stupid. It's slower, bigger, and more bug-prone than just using
> "get_user()".
> 
> The *only* reason ever to use __get_user() is in very very iffy code
> that might use a kernel pointer and doesn't want the access_ok() code.
> 
> Or old legacy code from the last century when __get_user() was faster
> and was inlined.
> 
>                Linus

