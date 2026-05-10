Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28747358373
	for <kvm@vger.kernel.org>; Sun, 10 May 2026 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420458; cv=none; b=dKCGwp2oNXXbFKArxUmKxDs3PdE0t12XZG0mHhVUvtOSfups7lJGfOl1KV1CcbvS5i0Ohjt6hMHqQTkqclXwvL4LeKGh091EEki2kVQ3ut7uok4PmX5XE2sR4K86qDddydtD5MAuuR0kw8LfGBniWCFfH9c1UtRC1nKyNAb9quo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420458; c=relaxed/simple;
	bh=pN3+xf+lvplk/XSDKnk1tzXRm+HoHaTy2CDzov5pZOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qx3eQ77yk3Y5d82vv+V2rBZydSgr0V/vegMf+qNhBpbjXlX+4icyzfj3UsxWoI4D7btjj5latCwJbvDMVStwrXV5AIa9GzYi+DFycRMyFIPgMkmpHb5I/S5vykVOW31Phg7lPy4PiIt3BbfF1VmawU5uth0RN/FfIZpE0qWHoSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ckIxGIhy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVCzyMsj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckIxGIhy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVCzyMsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778420455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L7Q24s236I9i1NyfkoKYidKcVPTH3QXz7TWxO8KOigQ=;
	b=ckIxGIhyimV7gcBE7y2xX625HiGY0TqfEd6eOsVHEFTPHj5xM+rUr/+pXd2KNIrte3zcAI
	sEjG2cHs18T2JtpesjhBk3h8haoW9yem5v5xBtyKPHxYqtj5v/bN138QN1I/pn2uXPlLcE
	tRpqM43TijYGHfKWQAovS6cYCPMl5TE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-cqPKt-mEM-KllOX-Ege_jA-1; Sun, 10 May 2026 09:40:53 -0400
X-MC-Unique: cqPKt-mEM-KllOX-Ege_jA-1
X-Mimecast-MFC-AGG-ID: cqPKt-mEM-KllOX-Ege_jA_1778420453
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a589c7879so34625445e9.1
        for <kvm@vger.kernel.org>; Sun, 10 May 2026 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778420452; x=1779025252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7Q24s236I9i1NyfkoKYidKcVPTH3QXz7TWxO8KOigQ=;
        b=MVCzyMsjaRUpnOWOVrTez10IdJrYUvxIwVmLyZdQLEKhu7Yx6gPCF9A9evE9yvAEmK
         2DHbGkjGA1+QaJsCs66x6+EhCOrmd+N2Xie/ASvqRGn8VhAPdMK13TXPLKy2HsvtHLSH
         HLMYcsIMudOGLPTIcWVjb6RE02M/JpXAH8Wq3/lU+hvHstaVTe6bK1R1G2iQwsT8Q7vr
         qKd1bUmABWDKGPHE+5pUAFfmAWao409iC0PRWa4uDFsaPA+B/Z8i80fNL7Xxd4zMgdSs
         UNUGM0PbRiF5L9+a9npG8q8RzYUHDMxFXoO+ICJvG0k1IaOSv0WfoTST/1ddWuPl2V9d
         enCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778420452; x=1779025252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7Q24s236I9i1NyfkoKYidKcVPTH3QXz7TWxO8KOigQ=;
        b=Ab9GmNb0ffMBo9bpbERsnXlthr6/Gvqk6GQ5ABPRN7PveuLYeyg7glSqM/jjPym4FD
         kkowqi2rmynC6f+OJ7IgJrwUMLQPOhF+eo/63sJLQ+85SxMMW1EAYrq3mTuiVkGX1EzA
         EtRiebM2vSmfHqznxW+eOihJ8CQYGclAIHwh6emt83vf6H2wYPjJNcpS6b3qYwFS602h
         lEtr/wgIeraUCQnbnH7mlDC+fK1MxM/MOzlkCel+MKF5hOR4s316p0lhlxQzf1LRhcEB
         CQYosMRen3xNWCTbGrFzVPkwz56zvGyNtpAtRymS4PROCFLhm2ANrqzIskT35eO18vLH
         Rosg==
X-Forwarded-Encrypted: i=1; AFNElJ9IlhX+WkrtMK1AeGSEUoKtfsVP2K72CWDSWUtuAk9XH63WewjrzxkQYG2K0mViE2Cv/Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTpaMRXroHBJzgi7RHxtwXmfn0mn3wSw+qAhqHjjl8QPL6Ygg0
	C5WNH7boSlc15qqm18/SPZViBjo1ApgkEw83GsQD5oQ3ZMhhUTFZoLCjABZv5dnqTs/opu+kqk2
	clISGlvJVwe7U6JPrniRbAQGquJq69oLJX40NnDsie8JiMd2lnBw58Q==
X-Gm-Gg: Acq92OGIOadWkcVA3j5O0kqj0zfsZvvFs7A+h0DIUAsPdSdnuoG2aYS7wESbg3+9W7D
	J/kUkC5qrwGOzxPDUTU5uN9zdR54W6tRUyV3ntMLhPX8bvPBD6028XEkegFaWwgk9PYIqI8FfwD
	CaIffDL4KF9BGae4z8RrIyx7LSqv5sKwJH/nWPbtD+QICI8Qm7hP2Dmv/8YaTsupJHlYMes1BpE
	fUghSarnG4Z1KBFQrv1DTOuq4+zZ/sq5ILdGduhcKRFdi/W48ke7nWdth6YXxUk36DfPDRzgKqb
	5vEedrniVm1KBVrKZSb3MI/POKVGKDWGhb++d8uD0lhdpkYkrMsPlTrDtJAySLzgNAU1LP3Cbuy
	tbXCF4R4SuTbwmJf86XQO8EEmLT+zt3p32hFUtnf4
X-Received: by 2002:a05:600c:638e:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-48e5e00c1b9mr231940925e9.14.1778420452518;
        Sun, 10 May 2026 06:40:52 -0700 (PDT)
X-Received: by 2002:a05:600c:638e:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-48e5e00c1b9mr231940315e9.14.1778420451950;
        Sun, 10 May 2026 06:40:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d8e4ce1sm43533835e9.9.2026.05.10.06.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 06:40:51 -0700 (PDT)
Date: Sun, 10 May 2026 09:40:47 -0400
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
Message-ID: <20260510094020-mutt-send-email-mst@kernel.org>
References: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
 <20260508151048.183125-2-simon.schippers@tu-dortmund.de>
 <dd0a3ef1-d623-4e09-a391-b56fa4bf95af@tu-dortmund.de>
 <20260509183518-mutt-send-email-mst@kernel.org>
 <a14b700a-94e8-44c0-bde0-d8307761c0f1@tu-dortmund.de>
 <9a4458fc-61f2-469b-8260-f144d3827b5d@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a4458fc-61f2-469b-8260-f144d3827b5d@tu-dortmund.de>

On Sun, May 10, 2026 at 10:55:34AM +0200, Simon Schippers wrote:
> On 5/10/26 09:03, Simon Schippers wrote:
> > On 5/10/26 00:44, Michael S. Tsirkin wrote:
> >> On Sat, May 09, 2026 at 06:31:47PM +0200, Simon Schippers wrote:
> >>> On 5/8/26 17:10, Simon Schippers wrote:
> >>>> +static void tun_queue_purge(struct tun_struct *tun, struct tun_file *tfile)
> >>>>  {
> >>>>  	void *ptr;
> >>>>  
> >>>> -	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
> >>>> +	while ((ptr = tun_ring_consume(tun, tfile)) != NULL)
> >>>>  		tun_ptr_free(ptr);
> >>>>  
> >>>>  	skb_queue_purge(&tfile->sk.sk_write_queue);
> >>>
> >>> Sashiko is right once again. tun_ring_consume() in tun_queue_purge()
> >>> operates on a tfile that is being torn down. Its queue_index is no
> >>> longer valid. After the swap in __tun_detach(), it points to the
> >>> netdev subqueue of a different tfile.
> >>> --> We should not wake there.
> >>
> >> Does it not exactly point at ntfile which is what we want to wake?
> >>
> > 
> > I see your point. But calling tun_ring_consume() as done here is
> > wrong, because it does not wake if the tx_ring of the tfile 
> > (that is currently torn down) is empty. We could change
> > tun_ring_consume() to call __tun_wake_queue()
> > with consumed=0 if !ptr but I think this would slow down the consumer
> > path.
> >
> 
> My statement is wrong:
> There is no way that the tx_ring is empty and the queue is stopped
> at the same time. So we do not need to touch tun_ring_consume() and
> this works just fine.
> 
> >>
> >>> I will swap tun_ring_consume() with ptr_ring_consume() again and
> >>> submit a v12 :)
> >>
> >> If so then maybe
> >> netif_tx_wake_queue(netdev_get_tx_queue(tun->dev, index));
> >>
> > 
> > But we should only do this if there is space in the ntfile.
> > My approach:
> > 
> > @@ -586,12 +588,18 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
> >  		BUG_ON(index >= tun->numqueues);
> >  
> >  		rcu_assign_pointer(tun->tfiles[index],
> >  				   tun->tfiles[tun->numqueues - 1]);
> >  		ntfile = rtnl_dereference(tun->tfiles[index]);
> > +		spin_lock(&ntfile->tx_ring.consumer_lock);
> >  		ntfile->queue_index = index;
> >  		ntfile->xdp_rxq.queue_index = index;
> > +		ntfile->cons_cnt = 0;
> > +		if (__ptr_ring_empty(&ntfile->tx_ring)) {
> > +			netif_wake_subqueue(tun->dev, index);
> > +		}
> > +		spin_unlock(&ntfile->tx_ring.consumer_lock);
> >  		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
> >  				   NULL);
> > 
> > ntfile->cons_cnt is unvalid, because the new queue might not be stopped.
> > That is the reason why I reset it to 0.
> 
> However, I still prefer this approach because the code is easier to
> understand.


So do you want me to finish review of this one and ack, or want to
post v12?

