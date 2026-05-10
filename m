Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDC934CFDE
	for <kvm@vger.kernel.org>; Sun, 10 May 2026 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778427884; cv=none; b=W1fQX9HwtdHs/QrEPbl3HThWKSieuywdvq5JFIYNXrLz4ODPE9rxVFgAgRxCRlZYmaRmhWyeZoYlSNGgmU5zJg4DpgQGHrIPKgOpl88vK5l6ANE30xhPDJKg8zF7F9Vc7LutHpH7jE0yEND6ZeNA+FZ88scfw/oUub8h4ur8FEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778427884; c=relaxed/simple;
	bh=oCHlo1fqZatJDIDvyJ1SrB7bwf2coY5WCAjVkHb+KpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkzMZQdD5fDLyDh6oql/iaZ7XxEFrhFjAv5Z+Th7vga6tODIUVNFKB88GBDoUlTGuCp68nwAAmSPTOlT27/4nFnTF+v2Z8LceGUz6g19HELaIxC8knEOVHMXOajIWqt7u++/+rHYXy+mSGznX30V3jkenHebEJYu9U3Nowl55UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Osaur09W; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GuOB4b8p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Osaur09W";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GuOB4b8p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778427881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7jk9H54lMHadSFms9Swh2u6zzH7MNV3xP2hPzoWhQ7I=;
	b=Osaur09Wkrp8b6Nx7v9uIohNCqJl0IM4hXibwFYyWpgcATQ+V0CaUO2BpAnB72GDsaeA2b
	e9AqPaYVPcIEwnZR49zHWx2o8tj7B/J//MVlL2fapgTXESrX32LLMQ7+h9QVdxwUBCNqAF
	J4zCNwwAcbuE3DCKhCFcbHmZcg5B9gI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-ZW3X7BqMOkC8WJ5pBTEvQw-1; Sun, 10 May 2026 11:44:40 -0400
X-MC-Unique: ZW3X7BqMOkC8WJ5pBTEvQw-1
X-Mimecast-MFC-AGG-ID: ZW3X7BqMOkC8WJ5pBTEvQw_1778427879
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-3939de90af6so18585601fa.3
        for <kvm@vger.kernel.org>; Sun, 10 May 2026 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778427879; x=1779032679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7jk9H54lMHadSFms9Swh2u6zzH7MNV3xP2hPzoWhQ7I=;
        b=GuOB4b8p4LkJw+/mwuEKmvVdU0Y8qAhLOm5ictQv5WRJ13qxNDxJflu3zd034A4HFN
         uSzPSxjwFDWrLuHoaHsq+NgKNWCi6Ol0WlrpZwBPEmHAyHhiURjuKrQRPTYX8TRcryWG
         zJYzM3yTLkP1asSFichwSR0IWsJ3N0Eng+Rk93H/ttg90w3kcxXrG/kfMmk8NwMtGsd/
         huj87W1rbpT856F4aShWZgQw/bh6QCRsKLMseEQAvazGQ+m3IhwOyVov66wvh9G1OE+q
         E1Z4GwiuRXf+GexF2KPsBU5dBYFx804Tyr6CjJP21Qom2ghwNtE451laPluJQVkkdJGl
         p0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778427879; x=1779032679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jk9H54lMHadSFms9Swh2u6zzH7MNV3xP2hPzoWhQ7I=;
        b=OLcXbBm/v1CpQVaC2iZ98lh2AgwG70w/DYRXFjoEJdHJ5kfIyVWoNYPgfeIXFu27x+
         sWfBFCgSV3lqTfs1WwWO05ksVMR0WOtCD1sN6j+DI+Jvsfx633kNXwIYankN4ckmfPqN
         pB6EZF5C0ZNIDokz7QCz0mjtnI712DEn7W1ddXmCVLqGRgsHeFvYNJ/vD6vHw1wZBpPE
         DlU6s49/BBCzExLB4ZV5lwERcv4rUcY2cIkerjkq1cYCIkpXNl3n6LEhvlVLcXO7O8Y7
         2TcTaTCsPKpyRK0EgHF4Y5qE3wdflJfUUQk/VTsPOrks9RrUihdHFjFmOlcT78U55lq6
         YIrg==
X-Forwarded-Encrypted: i=1; AFNElJ9YqNeyzfaR3pD1zweg3JkRRsFMnEBhWGXsHwyPtUrG7eHzT4HQF4sFAbrWZxJQVpLKnZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnD+I38VDmKvCW36DFoiA1VUTBpqKLdMJzQjKRPvANX1LGuAB9
	PGLXl5CcXwLTmFYEt1ZHEtkhBgIZj7QniqNVMWhbQXLfahzXknRvFm88Ac4bdKKGK77tECiIr/1
	und70ftHsxDomRAkfWBy/qyjr9CvTfvgfi7tvag6PeuE8YZdSSZzg/g==
X-Gm-Gg: Acq92OHrAxFF8kFM13IPeBSyqFUKqUHU4QCmS4an7EXrxyZDAfmFke2RT/WIrSvqD1r
	l+jRVBeBnD7Q5U3zpoN30HNKYhp4mCdxURfL8dq0u7vtJjVO9cuCrOGyn73dSn66CLSlviTCRBt
	YrtftGKsOTUlJBkOZLQzwjSrqtlofL0vGl8SYZSfPerEWT2AvbvmN76f6TaLLLql3JBqz5yofPb
	l2hzUOMYuJPyfP7m8QdZaCJffMo9BB15TjnLOjL4V2jBNLBb/YakJoLfokxmw2FesEAF62GF892
	hgSGaMVzRVZvPxcyhgB3w1MRq6qzZS9c0Q5fTluH7Sea59SM/sirP8Rtw0vcW2f2iRgM6wSnPjo
	XcyFqO8mJwhx0sawV8ZPT2keIoaCLQXkLvRIExXnR
X-Received: by 2002:a05:651c:54e:b0:38e:e6fd:65b2 with SMTP id 38308e7fff4ca-39408132229mr19263501fa.21.1778427879015;
        Sun, 10 May 2026 08:44:39 -0700 (PDT)
X-Received: by 2002:a05:651c:54e:b0:38e:e6fd:65b2 with SMTP id 38308e7fff4ca-39408132229mr19263431fa.21.1778427878424;
        Sun, 10 May 2026 08:44:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f60db4f1sm19882511fa.27.2026.05.10.08.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 08:44:37 -0700 (PDT)
Date: Sun, 10 May 2026 11:44:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v11 1/4] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
Message-ID: <20260510114401-mutt-send-email-mst@kernel.org>
References: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
 <20260508151048.183125-2-simon.schippers@tu-dortmund.de>
 <dd0a3ef1-d623-4e09-a391-b56fa4bf95af@tu-dortmund.de>
 <20260509183518-mutt-send-email-mst@kernel.org>
 <a14b700a-94e8-44c0-bde0-d8307761c0f1@tu-dortmund.de>
 <9a4458fc-61f2-469b-8260-f144d3827b5d@tu-dortmund.de>
 <20260510094020-mutt-send-email-mst@kernel.org>
 <e5d69f44-4483-49f3-b7fc-aca2cdb24792@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d69f44-4483-49f3-b7fc-aca2cdb24792@tu-dortmund.de>

On Sun, May 10, 2026 at 04:01:39PM +0200, Simon Schippers wrote:
> On 5/10/26 15:40, Michael S. Tsirkin wrote:
> > On Sun, May 10, 2026 at 10:55:34AM +0200, Simon Schippers wrote:
> >> On 5/10/26 09:03, Simon Schippers wrote:
> >>> On 5/10/26 00:44, Michael S. Tsirkin wrote:
> >>>> On Sat, May 09, 2026 at 06:31:47PM +0200, Simon Schippers wrote:
> >>>>> On 5/8/26 17:10, Simon Schippers wrote:
> >>>>>> +static void tun_queue_purge(struct tun_struct *tun, struct tun_file *tfile)
> >>>>>>  {
> >>>>>>  	void *ptr;
> >>>>>>  
> >>>>>> -	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
> >>>>>> +	while ((ptr = tun_ring_consume(tun, tfile)) != NULL)
> >>>>>>  		tun_ptr_free(ptr);
> >>>>>>  
> >>>>>>  	skb_queue_purge(&tfile->sk.sk_write_queue);
> >>>>>
> >>>>> Sashiko is right once again. tun_ring_consume() in tun_queue_purge()
> >>>>> operates on a tfile that is being torn down. Its queue_index is no
> >>>>> longer valid. After the swap in __tun_detach(), it points to the
> >>>>> netdev subqueue of a different tfile.
> >>>>> --> We should not wake there.
> >>>>
> >>>> Does it not exactly point at ntfile which is what we want to wake?
> >>>>
> >>>
> >>> I see your point. But calling tun_ring_consume() as done here is
> >>> wrong, because it does not wake if the tx_ring of the tfile 
> >>> (that is currently torn down) is empty. We could change
> >>> tun_ring_consume() to call __tun_wake_queue()
> >>> with consumed=0 if !ptr but I think this would slow down the consumer
> >>> path.
> >>>
> >>
> >> My statement is wrong:
> >> There is no way that the tx_ring is empty and the queue is stopped
> >> at the same time. So we do not need to touch tun_ring_consume() and
> >> this works just fine.
> >>
> >>>>
> >>>>> I will swap tun_ring_consume() with ptr_ring_consume() again and
> >>>>> submit a v12 :)
> >>>>
> >>>> If so then maybe
> >>>> netif_tx_wake_queue(netdev_get_tx_queue(tun->dev, index));
> >>>>
> >>>
> >>> But we should only do this if there is space in the ntfile.
> >>> My approach:
> >>>
> >>> @@ -586,12 +588,18 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
> >>>  		BUG_ON(index >= tun->numqueues);
> >>>  
> >>>  		rcu_assign_pointer(tun->tfiles[index],
> >>>  				   tun->tfiles[tun->numqueues - 1]);
> >>>  		ntfile = rtnl_dereference(tun->tfiles[index]);
> >>> +		spin_lock(&ntfile->tx_ring.consumer_lock);
> >>>  		ntfile->queue_index = index;
> >>>  		ntfile->xdp_rxq.queue_index = index;
> >>> +		ntfile->cons_cnt = 0;
> >>> +		if (__ptr_ring_empty(&ntfile->tx_ring)) {
> >>> +			netif_wake_subqueue(tun->dev, index);
> >>> +		}
> >>> +		spin_unlock(&ntfile->tx_ring.consumer_lock);
> >>>  		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
> >>>  				   NULL);
> >>>
> >>> ntfile->cons_cnt is unvalid, because the new queue might not be stopped.
> >>> That is the reason why I reset it to 0.
> >>
> >> However, I still prefer this approach because the code is easier to
> >> understand.
> > 
> > 
> > So do you want me to finish review of this one and ack, or want to
> > post v12?
> > 
> 
> I will post a v12 with the proposed changes for patch 1.
> No other changes.
> 
> Thanks!

actually can you clarify? why only when ntfile ring is empty?

