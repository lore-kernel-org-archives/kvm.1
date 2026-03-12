Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE203B6362
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 17:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337031; cv=none; b=Trhzmku4jvn9xDkmAkt2hZFiNUM5mDh4aR6vWGrcn04wUwMy+W5I90hFnQqq2pspMHPj6MwjGOaGCNgrrFO9zoE9ieVcoOyl96zE6QnEe1m6R/JeR5EMDeH5176VDhVusP5W65nAspgjA98SkQXaYBfyMDkinSLLKQTB8Q9pY5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337031; c=relaxed/simple;
	bh=3Abr+WwTWTzFACf/7XxDWz63aOIZn2oqnpHtNH9Enwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLNorV/52+vC1HFPrsSp7FZF539k0yeThpE8CaxJim2tJA8QGGkamh4bZ0+VMmktg1sEgD+Z4GxfIsI+IA+Rd+zeMqFmRt7E3Uhb8bE9HqWkguhLRfLxC8c587X8lW89VP35xWOOyfDI09AQxI9ze9wn6HSacAqxXzoq+WVomTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bw5zO86w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DC7EidL2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bw5zO86w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC7EidL2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773337029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4YGz1PzNTV5svw/kY2fmlXERyhL1KdwfJy37eX2e4H4=;
	b=bw5zO86wgJxuCtMyAfLf2b+sef0Ykha2hm7G1nbmt/uiInVf1JDrKWEYfeiQMni12p37Yq
	NeMCaZY+1xX35yUoXtDlRq6nUxibLd29he9EVSi1qgTjtRC8mCU4QUhMGrDR3QqJ1xzvkU
	bXakvCvXCUnJMCifxzwTgkgJDX4E/aE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-q3FJfytwNCyfx52DUSh6sw-1; Thu, 12 Mar 2026 13:37:08 -0400
X-MC-Unique: q3FJfytwNCyfx52DUSh6sw-1
X-Mimecast-MFC-AGG-ID: q3FJfytwNCyfx52DUSh6sw_1773337027
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-509219f94b0so112501711cf.3
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 10:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773337027; x=1773941827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4YGz1PzNTV5svw/kY2fmlXERyhL1KdwfJy37eX2e4H4=;
        b=DC7EidL2RIF8EPWKmaV9AYwAWlnKoflEm8GzhwKQZamLwHR6l+pqvG5EUCbW51AA78
         5Yk01eEIslQvTgAZ9QNM92TjCbb5LZanW6ZFO2+ibjXvFqR4pYkMQrKFQDR7hEeaaPnC
         z21AaZAS63hG5YAE58e/+qZPQ6sALW2P0CGkmamrHXPF9s9XMNhBy1v6THSFHHdYjTGh
         x2iRCMWiWHfyJFQtxmeM7VjjaFWhCdwdlzYiAVWxFa0bA70r8r6CSXheoCW9Z7rm5Our
         BYw9WwB7W/0gAmeuimBRb4hdB0v8f2LLqY4TT7Dij5MyF9KjsCi6KJGY0BNFKn9Ct9gh
         ESnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773337027; x=1773941827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YGz1PzNTV5svw/kY2fmlXERyhL1KdwfJy37eX2e4H4=;
        b=VVG0xHvSi2tDH6A5WfpblkxW4ZgiHvPobfsa3eu2CcaIwseARFXlTyRxpOsLFWdBaL
         0qOOkV0cuJqqVyEHtkw9In+lE2tLOcoA5KqE4Mlsnx1/f0dQdvGa4BwahZnDW0abnKKx
         3/YYqSSVdv7ksNvtfbsjFohL04EQm3r4aqZH4n+Syi8AMxDEbzdmro5wMki8A9REBQba
         xGMqNHg2xRrnuA8cld4m8heg18orFgtFakIZasVHeOMhAY8N23JGCGLcXIUE9qq5j3kE
         0Sz8dZrd2G4AXEO/BBz7mruyYNTuXlbRK5PHZqXLfeXG5FZMv5K72Rb+QyILootCx53g
         izYw==
X-Forwarded-Encrypted: i=1; AJvYcCXdWZI+ia8yXwzI0GCqUMgH2SCLeGtcjdy0/zxqxgAfZoKdER5w/yZJUogtPQ972T2Ru+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPGnlj3TOs/+54G3cZs2H/uYLVl7vqA9RTTmToNcKLpOoplBEC
	TB4+x0t759lD9bcwafwvbDP4iqwyLuz57gWfsdbkzXexd+JsE7hUdv1m2w8Df0eboo8epvA0OnW
	eiB4zNbT+pTSKOSPt9g1Qc2QRGHVzEcuyKrKYyajpbVqa0BiRn7I7EQ==
X-Gm-Gg: ATEYQzywQ/iga3AWn2Sm2xHiBeCkwapFvywxPuqQTk5JE9OUSygBIAG3tNu78pCYVFT
	6y6BbseUJqzN/mwTEGBnJo79NeHe6mYdhX3F5BCiIfyUYO2CgltQpAwJQxakYMQRKMUS73rvwgA
	OVLoK+s8Um5aYaH0tvDt1CMujdK8TcaBb7D2nKsHcXEUUdFmkGVHQKLTLGE/leDRfGrST+O7xNC
	FhHOoN9qgETFNUdP59uCHF4WjYJw78knuyl1TAY+grO69yz6ewTFcbmVEFQI+81Zu9OOsG9HACW
	nklgsbPiGrsCuwtMd+U7y0VisSH2A9eKqVysaVkvxeBpzsaRlHng9zxQ/rO56vfdXznjlmmp4Da
	KAazVZcaLXrjb5w==
X-Received: by 2002:a05:622a:2c3:b0:509:d76:fe5f with SMTP id d75a77b69052e-50957cccbe8mr4234601cf.17.1773337027452;
        Thu, 12 Mar 2026 10:37:07 -0700 (PDT)
X-Received: by 2002:a05:622a:2c3:b0:509:d76:fe5f with SMTP id d75a77b69052e-50957cccbe8mr4233921cf.17.1773337026816;
        Thu, 12 Mar 2026 10:37:06 -0700 (PDT)
Received: from x1.local ([142.189.10.167])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50939f02adesm37983521cf.15.2026.03.12.10.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:37:06 -0700 (PDT)
Date: Thu, 12 Mar 2026 13:37:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: alex@shazbot.org, jgg@nvidia.com, kvm@vger.kernel.org,
	kevin.tian@intel.com, joao.m.martins@oracle.com, leonro@nvidia.com,
	maorg@nvidia.com, avihaih@nvidia.com, clg@redhat.com,
	liulongfang@huawei.com, giovanni.cabiddu@intel.com,
	kwankhede@nvidia.com
Subject: Re: [PATCH V1 vfio 6/6] vfio/mlx5: Add REINIT support to
 VFIO_MIG_GET_PRECOPY_INFO
Message-ID: <abL5wKfPGzi88iBy@x1.local>
References: <20260310164006.4020-1-yishaih@nvidia.com>
 <20260310164006.4020-7-yishaih@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310164006.4020-7-yishaih@nvidia.com>

Hi, Yishai,

Please feel free to treat my comments as pure questions only.

On Tue, Mar 10, 2026 at 06:40:06PM +0200, Yishai Hadas wrote:
> When userspace opts into VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2, the
> driver may report the VFIO_PRECOPY_INFO_REINIT output flag in response
> to the VFIO_MIG_GET_PRECOPY_INFO ioctl, along with a new initial_bytes
> value.

Does it also mean that VFIO_PRECOPY_INFO_REINIT is almost only a hint that
can be deduced by the userspace too, if it remembers the last time fetch of
initial_bytes?

It definitely sounds a bit weird when some initial_* data can actually
change, because it's not "initial_" anymore.

Another question is, if initial_bytes reached zero, could it be boosted
again to be non-zero?

I don't see what stops it from happening, if the "we get some fresh new
critical data" seem to be able to happen anytime..  but if so, I wonder if
it's a problem to QEMU: when initial_bytes reported to 0 at least _once_ it
means it's possible src QEMU decides to switchover.  Then looks like it
beats the purpose of "don't switchover until we flush the critical data"
whole idea.

Is there a way the HW can report and confidentally say no further critical
data will be generated?

> 
> The presence of the VFIO_PRECOPY_INFO_REINIT flag indicates to the
> caller that new initial data is available in the migration stream.
> 
> If the firmware reports a new initial-data chunk, any previously dirty
> bytes in memory are treated as initial bytes, since the caller must read
> both sets before reaching the end of the initial-data region.

This is unfortunate.  I believe it's a limtation because of the current
single fd streaming protocol, so HW can only append things because it's
kind of a pipeline.

One thing to mention is, I recall VFIO migration suffers from a major
bottleneck on read() of the VFIO FD, it means this streaming whole design
is also causing other perf issues.

Have you or anyone thought about making it not a stream anymore?  Take
example of RAM blocks: it is pagesize accessible, with that we can do a lot
more, e.g. we don't need to streamline pages, we can send pages in whatever
order.  Meanwhile, we can send pages concurrently because they're not
streamlined too.

I wonder if VFIO FDs can provide something like that too, as a start it
doesn't need to be as fine granule, maybe at least instead of using one
stream it can provide two streams, one for initial_bytes (or, I really
think this should be called "critical data" or something similar, if it
represents that rather than "some initial states", not anymore), another
one for dirty.  Then at least when you attach new critical data you don't
need to flush dirty queue too.

If to extend it a bit more, then we can also make e.g. dirty queue to be
multiple FDs, so that userspace can read() in multiple threads, speeding up
the switchover phase.

I had a vague memory that there's sometimes kernel big locks to block it,
but from interfacing POV it sounds always better to avoid using one fd to
stream everything.

Thanks,

> 
> In this case, the driver issues a new SAVE command to fetch the data and
> prepare it for a subsequent read() from userspace.

-- 
Peter Xu

