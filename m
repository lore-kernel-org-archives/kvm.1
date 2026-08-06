Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED52471D12
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 14:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027222; cv=pass; b=cDLPNUpFycv2iB6gmR7KVrNtBynNuTp2jjS0mpmTpA3pvadTlU7OVgJWHM+bZPjRM+UUC8U4/KHZSrHTMT/us2HO2WakdxXCsPRX5pmzOOSMOQadBd74wEsJaUp+q7LfrbHBxPAKtFbazlmRdfUlN9LKH5A/HtSnIQZthSBfcy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027222; c=relaxed/simple;
	bh=gcjKawjwo26uLkajY4IH3jQHyOn7PT0OmTOcUrswS9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pj6d23MjUMdo1KTmHv9gTaUjMH4bg8QNn7BjEE8DmArWdeoYg7u33+uHo2Yh4nvxusHgRKuDfxUUky9BB/qJENhuHEFlI257kUA4bheVbaL1LYarrzcmHB1c6cA7BXSgrsQzqGHZYAbADLySm4A1l76ciaaNFNXE0xzZmDbtmvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alCl8suo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2xcF2p2; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alCl8suo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2xcF2p2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786027219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/p4TBvMBVw0EXOJptfY8mrIcbCKeY/alz7cq+D1eCSU=;
	b=alCl8suoolMoyncx/Loac02th4Vh6cPgJRiDXZ+59kHgehbEBYWy/l0WH54BTV8IXug4Wt
	ezeMhbArXe/yVJXtPBWjiQtRDIOtEJcKL2TMd8v7h/uOeXBP/71vYyDtNhFA10jT2yoIFv
	FjwVXDEDFhjZYov8E8umNjr9jSabdP0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-GwuAAdaZMpGl3zEl7Zt97A-1; Thu, 06 Aug 2026 10:40:18 -0400
X-MC-Unique: GwuAAdaZMpGl3zEl7Zt97A-1
X-Mimecast-MFC-AGG-ID: GwuAAdaZMpGl3zEl7Zt97A_1786027217
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc6dd43737so43422515ad.2
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 07:40:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786027217; cv=none;
        d=google.com; s=arc-20260327;
        b=REq4GFq0KrIEil1dnfSAlh4rSGjWqoLOn7AsiYw+emWLp6+JWS+dXlT7lY2WLjji3O
         BZ7VWjCMIErdriG45C5CaA+2QFQKqMyoYK6+wXbR8mkA+9rAyj7kdyFNc7tuyqEDUp4s
         pOBmlm1cPq5Bt3IqgejrC0yeLdlKiDmy7BxbGaZwykhP/LA3oDsWqUALA7s6SiLq7so7
         AGSavIIxt2D5mVainyQ84ls2ItHopkDZ/ZsN65FHJIDD8jB0kKKG0dkP2859uE5ZuCXX
         gqj1oYCUfhMOC6ujNEzcCfy/LVdQBeM20XE6LLTW+EQEwlIMsdfXpnY106Ub6yJjdCqs
         h3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/p4TBvMBVw0EXOJptfY8mrIcbCKeY/alz7cq+D1eCSU=;
        fh=IQs/z9mUL/NB5BDPJmiIYyfoH6oPz+mBEuN3/5frhOA=;
        b=HU22iROOns3kCYE+ORRlBXrnEzTOFk+e1IKlm7XZM0Y4r1yT3iX7IfYuSa8eGtuyR3
         v7df8yA3ROGiOxpHeq25UyeLH1Gn7fnw5uv/NJE6Ee1Dh/XcbIfMbJFUNV0jH7RDSjD+
         igBefOxy3lGw4zCjviRQW6FcrlcfyLGlzGghegl9O4diueVx6Ssy5KtSbdEtyrsz6HK0
         m5NZ/QekX0rulWo+pniPt+UZsaptwCIAevm/uuiQJhSkTpov2HDa/+/NdOYiTtzkKXTI
         S6sd6W6ci10dI8UakZ3/NioKAzdjNt8h3rolZlTVW/f1CEGPCH7Puy7YQe5BdDmvJV0D
         gy8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786027217; x=1786632017; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/p4TBvMBVw0EXOJptfY8mrIcbCKeY/alz7cq+D1eCSU=;
        b=d2xcF2p2N5zpPp3oHuuB64b4d+7+czSQ4HGu1O/rhsEA1xN4xgQJYow1eOnaDde/ir
         P8YgW1ahpu+wIBOlRjCtZbpEJY2fT+upAFVX3uTbrPWeDAyMiRIM75Jwhy8p2OW/9a8n
         q/l7hS73VXOQpB8aRlIEd3wxLPADgVO0hCai72/gQQNfGK870zfc4sGaNmk9H2WgIg/+
         T5SmaLYjnkg8vYet9oRi52dOaEGkMCV7i+HWJNYTTZU6XajOURJn4Peinv7S4Prsr849
         MvjM6unh59tw/009tAa2bJqicWiReb5uU8HcaWJDLPjKqgfKoDCouafPxUHPph+LP78V
         d1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786027217; x=1786632017;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/p4TBvMBVw0EXOJptfY8mrIcbCKeY/alz7cq+D1eCSU=;
        b=my1e8pfcvqH5A3FKlEdtXCDuZIEQ5CwagFWACn0TnF3ztG7Tv19BakYVfZDJqu1T93
         /yEJws5YGW0Jb/B54xHIL58NXV1LWnm3pBA49UHQc2HCbiHHxVf+H0Xoz4oy9KQaDe6Z
         VSYbquZg0uKkYqIklpapirVpTcq5yg/U4RQdXjj9D6FBOqotceOMoChcUv6oLDNEGH/F
         whj+HL/iIfX5PANHWQfLEyVRaMVYC3pHnwiRO8yZSJaTs3KrjSEy7yJQQydmNslEwTe8
         oWmv3zPpFTaJ1VqPU8cSTq5HmdEFXq/jzB3qeW/haSFS8yS/BYNyNMrS5GRhkNztu8c9
         +aeQ==
X-Forwarded-Encrypted: i=1; AHgh+RpVo5vjNKM6njnl8+5Hy1se8e2v7Y6dwG9ji5BfprGSaYSj12KYJNRdq34oDWoLYj9Btis=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjuzLtOfaWNgopSNQpQ/nWU+1f6RCqCY2OiEaeUne6HnbttM2C
	Kvslvn321vQ4I6snmeAGav4J/Sv3lGN11uKGjCnvKjwGOKgjTRkmHII6aZqnORk4mWFYP0vmW/h
	NlXNQyJqp9Pg8AvH5gBSoDX8altNnDBJOcIkxvUuNSYg5tr4ToOPNeUmTqBSVSQEf+DTD5E5gCq
	m+bHLPlEiXLD4pFI1HLGLabSumvsxG
X-Gm-Gg: AR+sD11s42A3+hB/Lev3Q22X75zDkekWaQ4EHf/6AyW+IGTWYjUXaLmiECO68gE7dZB
	7RAxZVsAK6FLQolbVcEHco7rIg5G9m87Nmac7FcyB02OkLJcP24W9l7R8Bu43oFUDAO6CSA+/5k
	UbWdn6qw2KqFRzSuCGTUiga0Gw+o6chB904eE5/nHnoL/tiVbBPHU9r74=
X-Received: by 2002:a17:90b:580b:b0:38e:9e9d:9209 with SMTP id 98e67ed59e1d1-3903c5c51cdmr15623468a91.17.1786027216717;
        Thu, 06 Aug 2026 07:40:16 -0700 (PDT)
X-Received: by 2002:a17:90b:580b:b0:38e:9e9d:9209 with SMTP id
 98e67ed59e1d1-3903c5c51cdmr15623360a91.17.1786027216105; Thu, 06 Aug 2026
 07:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723153310.745855-1-andrey.drobyshev@virtuozzo.com> <anSMBpQJ8x-vXYy2@sgarzare-redhat>
In-Reply-To: <anSMBpQJ8x-vXYy2@sgarzare-redhat>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 6 Aug 2026 16:40:04 +0200
X-Gm-Features: AUfX_mxXaE00zqmd2DiALac4VL3A9WWcVSqpkYeQGMWjXcfcP0SiHhV-7fpbPQU
Message-ID: <CAGxU2F4b7oy338gRSJyNko=Bnwyi+MCdzOKAtZSW2q_GJnT6=A@mail.gmail.com>
Subject: Re: [PATCH] vhost: clear vq->worker under vq->mutex when freeing workers
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, 
	stefanha@redhat.com, jasowangio@gmail.com, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Aug 2026 at 15:35, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, Jul 23, 2026 at 06:33:10PM +0300, Andrey Drobyshev wrote:
> >Every other update of vq->worker is done under vq->mutex - the worker
> >attach/swap ioctls and vhost_worker_killed().  vhost_workers_free() is
> >the sole exception: it clears vq->worker without holding the lock.
>
> mmm, vhost_dev_cleanup() updates vq->worker without the mutex too IIUC.
>
> >
> >The effect is harmless in practice, as this only happens while the
> >owning process (and thus the whole device) is dying, but the lockless
> >write is inconsistent with the rest of the code.  Clear vq->worker under
> >vq->mutex, like everyone else, so that all writers of vq->worker follow
> >the same locking rule.
> >
> >This issue was found by Sashiko AI review.
>
> Can you share a link to the review?
>
> I don't know if it's common or not, but having the link in the commit or
> after --- will help the reviewers.
>
> >
> >Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >---
> > drivers/vhost/vhost.c | 10 ++++++++--
> > 1 file changed, 8 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >index 4c525b3e16ea..dbb6cb5eccea 100644
> >--- a/drivers/vhost/vhost.c
> >+++ b/drivers/vhost/vhost.c
> >@@ -722,13 +722,19 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
> > static void vhost_workers_free(struct vhost_dev *dev)
> > {
> >       struct vhost_worker *worker;
> >+      struct vhost_virtqueue *vq;
> >       unsigned long i;
> >
> >       if (!dev->use_worker)
> >               return;
> >
> >-      for (i = 0; i < dev->nvqs; i++)
> >-              rcu_assign_pointer(dev->vqs[i]->worker, NULL);
> >+      for (i = 0; i < dev->nvqs; i++) {
> >+              vq = dev->vqs[i];
> >+
> >+              mutex_lock(&vq->mutex);
> >+              rcu_assign_pointer(vq->worker, NULL);
> >+              mutex_unlock(&vq->mutex);
> >+      }
>
> Pre-existing, but IIUC vhost_workers_free() is called only by
> vhost_dev_cleanup() at the bottom, after a loop calls vhost_vq_reset()
> on each virtqueue (without the mutex) where we already set `vq->worker`
> to NULL, so IMO at this point it's already NULL, no?

Oh, sashiko reported pretty much the same
https://sashiko.dev/#/patchset/20260723153310.745855-1-andrey.drobyshev@virtuozzo.com?part=1

So, yeah, I think it's a valid report we should fix.

Thanks,
Stefano

