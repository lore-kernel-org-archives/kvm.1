Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A707E3BED63
	for <kvm@vger.kernel.org>; Sat,  9 May 2026 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366701; cv=none; b=buC/8g0qk2TOqQEZ5mn6VqzFU1SXk74wRUwJQAGpUQ+zGiWnB1IEZsSpT3kCI770Audkb8A1pW1YCJI4pbZT/iIM6YgfJrq1VmENQtb90RkYaNkKg8I+uuY1v2eyXvXu2vIAaBTn9k17iYMr+Z2wmrCtYCioNvPMx4rcqP3YeUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366701; c=relaxed/simple;
	bh=I1uaCfP7MUFzA0C5hMsAjutKxQqou3ouWa1Ws0Uyyh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk9Hv3pZpLGU5x+Qwcuw9/x4xBh/eK1h+wSwsI8K1yNvd8Gh8rGQ1D1QHomTGFAD4dOSVwETzvvn0pI1osD3MQKdwlgUvQpp0JySgwfpvGZDTPXQCSoQrQId/CMDKwZUr76vsy04NMunOcj82vRgebrhGuq1e0UhTVfvKlVqxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icDk8l7h; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rdMwsFFC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icDk8l7h";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rdMwsFFC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778366698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RMLC0/7OpZlfwin12rT49rU9O67TrMCpNs0CyOiqETU=;
	b=icDk8l7h68RejWheeD+g0aFYJIrCKMwIiNdTqPW1b2mTWwwTiq8xLLmilDf0g3aqdf4W3m
	qF7M2S7WmboAxUh6FqW89t9HyqWDIg6o0GXS9W/f1rFWhMSCuFed5DAKMsMTNFZ+g4wCmG
	cYPeaflLnpAbfV+qKlo8ihmE9UbZ3jU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-aK-ZkqdMOo2a1ViwzDfNkQ-1; Sat, 09 May 2026 18:44:57 -0400
X-MC-Unique: aK-ZkqdMOo2a1ViwzDfNkQ-1
X-Mimecast-MFC-AGG-ID: aK-ZkqdMOo2a1ViwzDfNkQ_1778366696
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48906aa28cbso30341895e9.0
        for <kvm@vger.kernel.org>; Sat, 09 May 2026 15:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778366696; x=1778971496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RMLC0/7OpZlfwin12rT49rU9O67TrMCpNs0CyOiqETU=;
        b=rdMwsFFCMLqxUIVI83E5KrN74A3fDianVDy9zf4Yo+Sd4zBICG4qH8ccoPW7sBI1Dk
         XvsRMRLWSThPFmT63h2BM3447EOyN4dBcpMMUIvFMDqU+MFl1Mc2eeBW/GkMLjspy6LB
         Gb261fRxrmqxeU82bYVaEfFvVFWHDKSzn3rYXG8MynTrTdLGmK1gEdb13Dc7y1Zyjo5W
         YCJpETqNE47OGlo130iML9CVnYqdHPzeF66ftiREoW99Qk1n+mTvgVSkyjikmjbp1qQQ
         CBOomKPSYNwZOo/mJIiE4pqowNjEZHcRA+Rvswi8hXjAI2n5xhFX64Cx+0pgPCE6aBrQ
         n3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778366696; x=1778971496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMLC0/7OpZlfwin12rT49rU9O67TrMCpNs0CyOiqETU=;
        b=NKFOEbo8NStW82fKmL51vHQV5gYPgIx7723LHymJRYQYBfBCnL3GhrU49C+BDTcXii
         gVVyg+SXuKCXd07C6Gl7EpD1omnwPucY2sQPIK7U/yknlnixWA5abmQIBmCW44Le7EPJ
         XC2PyIZtaFBAH8tCOhqiCvjajom610eclCW4JNReKlsTu5iS9TUba3qp2qvvwkJVyeXk
         q+VrhLl3XRqc7Q4PSldD7ODdNxeLdFOJ71Z998bw5UpWW5THav21AM5oez9R1IlLGdEX
         TScJ916GEL5fEX9eMQjYSaYqvRYK63zOVVgFJajtSiOj18xfxbIIuTFI9/bytoCiA24Z
         n+Ow==
X-Forwarded-Encrypted: i=1; AFNElJ/tCUPzgCDcnKr8L+7qfVC0MfpjX0xODjg5NGKxcKKz+zpYSXM9rUvcj1P+RIqkx3GtjeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp8TUIM9GlDr6GbusLg6GerMrgBicY14DQto7UxjucX1J/Xdbm
	3JoTtfAnWrD1H1poSf2dinOFxhDspQBhZhHDgH/RqkFtJfGFjrJA/ii2Zq74bEOEYIe6Di13fHy
	WTCMx0n3AE0obKqVAgceW22f+Lmo6sSDZ7JWiK0Ams19ugI5jme6e0g==
X-Gm-Gg: Acq92OEUi2iW5j8kfAL9hHrKaFbycKRTHOpmILUUKF02EIa0HzWwojxhQSZY4HXOVdV
	gjKUA3r1kWIUKSeJYMMTL/HqjLZNLcafkoZdCSr+1I4h1EDNMamylbpTdmhbiJVb64mFsy6hS/e
	mYjSsUm16077CoVvG2qKtWH91r1zj/tIAhkhFCE4uKrq8b8WYvWBe7+lNSn+blHTTUuTpOJW27c
	PfSyoTDBoDV69mEnGF10A4BtTpc5N0YJORHfYAbOXtFhYcrOMkKMcuBsAQXEqrgghtH3V3kl1+o
	BYb1+AwCQAsebxs3m9UHXCagusRzZ2l5+2jJbcAm9p/KCzl8bar0+pnCIKqpa5U515NpgVNuJXd
	MUBSxn2pm0zIae4UdANLpGy5MZWe5iA8wOiQeu8P3
X-Received: by 2002:a05:600c:3b8f:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-48e642deefamr148087285e9.7.1778366695915;
        Sat, 09 May 2026 15:44:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3b8f:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-48e642deefamr148086915e9.7.1778366695323;
        Sat, 09 May 2026 15:44:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6dafa6c2sm42673165e9.5.2026.05.09.15.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 15:44:54 -0700 (PDT)
Date: Sat, 9 May 2026 18:44:49 -0400
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
Message-ID: <20260509183518-mutt-send-email-mst@kernel.org>
References: <20260508151048.183125-1-simon.schippers@tu-dortmund.de>
 <20260508151048.183125-2-simon.schippers@tu-dortmund.de>
 <dd0a3ef1-d623-4e09-a391-b56fa4bf95af@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd0a3ef1-d623-4e09-a391-b56fa4bf95af@tu-dortmund.de>

On Sat, May 09, 2026 at 06:31:47PM +0200, Simon Schippers wrote:
> On 5/8/26 17:10, Simon Schippers wrote:
> > +static void tun_queue_purge(struct tun_struct *tun, struct tun_file *tfile)
> >  {
> >  	void *ptr;
> >  
> > -	while ((ptr = ptr_ring_consume(&tfile->tx_ring)) != NULL)
> > +	while ((ptr = tun_ring_consume(tun, tfile)) != NULL)
> >  		tun_ptr_free(ptr);
> >  
> >  	skb_queue_purge(&tfile->sk.sk_write_queue);
> 
> Sashiko is right once again. tun_ring_consume() in tun_queue_purge()
> operates on a tfile that is being torn down. Its queue_index is no
> longer valid. After the swap in __tun_detach(), it points to the
> netdev subqueue of a different tfile.
> --> We should not wake there.

Does it not exactly point at ntfile which is what we want to wake?


> I will swap tun_ring_consume() with ptr_ring_consume() again and
> submit a v12 :)

If so then maybe
netif_tx_wake_queue(netdev_get_tx_queue(tun->dev, index));



-- 
MST

