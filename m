Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B5B43C048
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836863; cv=none; b=kCmqtla5HiZ/Xmz181oWCqtV/cPGpTH9fxE4UZDtrG/Tnc53fsH5LA4KFUge7qScY24TjyU5gU63SX9K7nWjnWDdXT8uJJtOGQ9sxkC07gfKe0RdxnsQemJfjYhKyEDcDR9c5RPKR12dGSbx7zyBTj1ckGhGdgeAQ8yp1sieEdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836863; c=relaxed/simple;
	bh=kvhGlFT183z46f4prQv9UsB0406P5Y8xm81IA80kJuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0aUeAWhz25M9LuhnU0qP0ZhG8FIh4DQN7r4lY2LkBvnLhjrw/WInhL2Wm8rmMhEPadg9ZbJRXZmYfi7XPlOWJEZoLUvOfEpvPir028QPwVhdm5/sKfcovvw5n9vrC0/oSRMr6TYGSDrU8diepCC4agFwNaL/fMH7ndtz4Zo93U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jDshuLWC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QF5vXZf+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDshuLWC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QF5vXZf+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778836861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=coiGVgNORCz4Zh3xYVYNCYPRQwJYgr83BYwKKI9/FxM=;
	b=jDshuLWCYgeovocETe7K1d5CNSXX4zFfi6vhGDaUWNytuD40AC0vRCtg5+3rCA8gg/iN/Y
	AH9uth7JQEEWA1b9vFaSOBTXMiW4wcxsD0DNmKDgM8a2UFEvoAIJ+1128fwehUa0ECVMXy
	eaBE5zV6eyyfOLBchfIeZnREkOZQZRg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-iG83JZu9NMK9OC97SiULWw-1; Fri, 15 May 2026 05:21:00 -0400
X-MC-Unique: iG83JZu9NMK9OC97SiULWw-1
X-Mimecast-MFC-AGG-ID: iG83JZu9NMK9OC97SiULWw_1778836859
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44ffa15dc8cso5430157f8f.1
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778836859; x=1779441659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=coiGVgNORCz4Zh3xYVYNCYPRQwJYgr83BYwKKI9/FxM=;
        b=QF5vXZf+qj2rP1C8g15kd1q9ts1TniBoPkpIWgHDfe2tGZpUePCoqt7J0vumweTA6y
         4Ocjpi1Cj8DeC8ceqScBo3eNSGCSx/STJk+1I+hgJwlQpQp9mDCXUz+TCpbc44lNOodM
         B4Qg/Wm62qq0enr7oUiXq2h2vj/Mdqt6pQB9hnntiebNTIxKJBZDftJ0o8ZEX2Exi5/p
         FrSqpCQ+3SbsD6Ar1rH0uzuhmMZtbxfuHRUom0RIIV1OB/nm67tLwWcnhAb4Pm8xKXzC
         tXjBmoYkn968WbjdicGNgcfblb9Vs81pgGEMEq5NqrX/pib126OQfAUkTUQHtwc2n+C7
         bY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778836859; x=1779441659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coiGVgNORCz4Zh3xYVYNCYPRQwJYgr83BYwKKI9/FxM=;
        b=U9+S1FEAJziTw9BtiguB72DTVaKfL9BUObiolpTvgHOUeRFSgzS57rajdbmGPK2fT3
         SKhzrdjz2EloRgmkiqeAyVVKbuQCPellrXhU919X47mBn3Fv0ZDvtK9eTo5P4mXRKj07
         lT6X6n4dFC0AHpdc3BsXFbB5zV2omSoLmQhb4AynBD3Zf6nyKe19HM8mWEjhS6DZJtyX
         NEDth6aGZPeafWWLhDzcofvInaYW4ICysli0sEQJbbi/8GlNuErWomzZTt9+1N2lgsr/
         StfhPpoeDQLbbk5I6WZTBW0dxuOLGWDoqUYu9y+c5Oa7BedFPt292+KRhTk09gMHeEvs
         ++gA==
X-Forwarded-Encrypted: i=1; AFNElJ+OaFvtu3T3EfAqWQwT00sYZf5dGpyS+bFKLAUGkIwuF20jgNyGwGXWgmTG5d+z/J3tGvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO90/KOhk812N7BS3mA003qjPJEoy6LqAnMEAg92zoSRNT1uQq
	4y9NSt0xbSwYZk50E1Z6FGfdQvt6WZn0zNdCv9ftdWFxK5Ct3j8rLy2duMomWfIrAr5YrAXhLRm
	GprSmCoILBSWYCuEZPCyWNuWiWiCtTHDJlb63pJPtL24Y3Ck4A16X2Q==
X-Gm-Gg: Acq92OFwdaUEouKyi1ZGqVGSNF1uagFCbPEcIkzFrtIKqvjNOF735zPtU4buc7dwE98
	ZkDrKFNqMW4/VRU4RT9gNogtwYHzMf69jEj++onhucR2KpMBQnTV6aPDZudeN1UV6MpBeSN0ZF8
	pOXh9ea1xDTSofGM5iXRIGuyXODV9qLsw6qfTMGzLHv4PL+IonFD/2MnN5JS2q71jAz+nVP5hBT
	XzxRSFM42f/7JpIhTjVRDe5+r2uHiD4a6CuoleE2EGJ8ozUJ/MFEwRAalpYhXBCAyZWuSRJYIau
	mGGGmWlVN2uCnhY2CooQ32lt1R2jAH4kpahP0mrjGY+MIbqR3elktNS00BEaAqP5+v5mYpUJPn7
	clz2VviSTsGFxpWiwLZZoLSevlkr8crhmGBUELpE7SFrDF5DVg2U=
X-Received: by 2002:a05:6000:22c5:b0:43c:f5a0:4e56 with SMTP id ffacd0b85a97d-45e5c5f9d94mr3855115f8f.42.1778836858716;
        Fri, 15 May 2026 02:20:58 -0700 (PDT)
X-Received: by 2002:a05:6000:22c5:b0:43c:f5a0:4e56 with SMTP id ffacd0b85a97d-45e5c5f9d94mr3854928f8f.42.1778836856499;
        Fri, 15 May 2026 02:20:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39ff1sm13634930f8f.10.2026.05.15.02.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:20:56 -0700 (PDT)
Date: Fri, 15 May 2026 05:20:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving
 queue overflow
Message-ID: <20260515051829-mutt-send-email-mst@kernel.org>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-2-sgarzare@redhat.com>
 <agXh36gUe1K6__Bk@sgarzare-redhat>
 <20260514111513-mutt-send-email-mst@kernel.org>
 <CAGxU2F4qWcQTmXnH74V8xZKADLiEMUmCc0+ktW5fZOXdTP4Bdw@mail.gmail.com>
 <20260514134347-mutt-send-email-mst@kernel.org>
 <agbWNqhzvEHVBvC2@sgarzare-redhat>
 <20260515043940-mutt-send-email-mst@kernel.org>
 <agbg-pUhBRB89aEX@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agbg-pUhBRB89aEX@sgarzare-redhat>

On Fri, May 15, 2026 at 11:06:42AM +0200, Stefano Garzarella wrote:
> On Fri, May 15, 2026 at 04:57:41AM -0400, Michael S. Tsirkin wrote:
> > On Fri, May 15, 2026 at 10:29:55AM +0200, Stefano Garzarella wrote:
> > > On Thu, May 14, 2026 at 01:44:53PM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, May 14, 2026 at 06:45:00PM +0200, Stefano Garzarella wrote:
> > > > > On Thu, 14 May 2026 at 17:16, Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> [...]
> 
> > > > > >
> > > > > >
> > > > > > And so the bag of hacks grows. I feel this is energy not well spent.
> > > > > > Please, let us fix this properly *first*. And then worry about how to
> > > > > > backport.  Maybe it will not be so terrible to backport after all.
> > > > > >
> > > > >
> > > > > TBH I don't think this is an hack, but an issue we should fix in any case.
> > > > > Regarding the second patch, I see your point, but it's a big change
> > > > > that worries me. I'd like some more time to fix it properly without
> > > > > rushing. Staying calm without realizing that userspace is broken like
> > > > > we are now without this series :-(
> > > > >
> > > > > That said, evaluating further, I think we have a similar issue also
> > > > > with STREAM on the host side where the skb usually doesn't free space,
> > > > > so we need a merge strategy also there.
> > > > >
> > > > > So, I'd like to have time to fix both definitely. If you have time and
> > > > > want to go ahead, please do.
> > > > >
> > > > > Thanks,
> > > > > Stefano
> > > >
> > > > Well my patch was a start, we just need a strategy how to avoid copying
> > > > everything, right?
> > > 
> > > Yep, and then there's the question of how to handle EOM without a payload,
> > > but I think that's a special case. In theory, we don't support sending it,
> > > but I'm not sure if POSIX allows it or not.
> > 
> > It seems to, but given we didn't allow it in the past, we probably
> > should not start now without a good solution.
> 
> Agree.
> 
> > Really we should add a feature bit for EOM to steal a byte from
> > buf_alloc. Or several bytes)
> 
> Yes, I agree. At this point, though, could we define a new protocol that
> also takes overhead into account, or would it be too complicated to
> synchronize both?

Well isn't it just X bytes per EOM? The rest can be fixed with
merging?

> > 
> > > That said, is it okay if I send a v4 of this series?
> > > 
> > > (I'm not sure if I'll be able to work on the merging next week)
> > > 
> > > Stefano
> > 
> > 
> > I do worry we are piling up hacks and we'll end up with races
> > for all our troubles. That said, up to you.
> > 
> 
> I see it differently; Patch 1 should have been there from the start.
> Patch 2, unless we completely remove the overhead, we should keep it, or use
> it to trigger merging (e.g., when the overhead reaches a threshold that
> depends on `buf_alloc`).

I'm not sure we need to merge retroactively though. Maybe just start
merging new stuff when over a threshold. Should be simpler.


> I prefer to send a v4.
> 
> Thanks,
> Stefano

