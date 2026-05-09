Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA673563C7
	for <kvm@vger.kernel.org>; Sat,  9 May 2026 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778355495; cv=none; b=JYXg3lj507cNZfSvxgTLRWllheVsbVQeUT464XyT33+fePqA4399msPmGme+ovKX3UF01JwC8aKSFFPKSMsdWzV40JdHhtK9AlDRiMZmyf/nMAZ5LfXosmrNEc0ZKH6C+VUq/UV98q3olmoL23t4v7syVpV0GADOjUT8nD2SidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778355495; c=relaxed/simple;
	bh=LJ8prTqaJOJKTib6YJYHS9vdeOjI1c4LQ/IGaYQNqtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=natlmx7rjDUFNVUIOmkRF9atMCrGkFNRXSOEAjk2IDqnRP8zb7U2ajiIg3Hmo3Y8Q0ECGVuo/PJ5TcjiYDGmqLwrXkDFhvCiD+EIrzM1Ghmk9PgOSyy78FWozy5FUAQsFrcMFHDWArto8Jc84UXsI0M0NjaNOS7JyC1ftJu+MV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hyLnaIOS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mXgzdtgB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyLnaIOS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mXgzdtgB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778355492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ANPZRIsHdOb2XjLaWGPcru90KA3pfrVWtS2xY3q4MU=;
	b=hyLnaIOS3sDEi0JTu1cKcJiKUpmIFJVB6/oCXbF6NINqOk+NLJpJcZLIm/RFLHQhlKlgsg
	69b/kVn8kLHKaLgXhtfF31YpwnJFydLinSZj7MGVIENesNNw+NTVBC/OikkT1eQ0eS/dZK
	yAutCo3fWgsMyoFD/9EY3ncCzlcq9Bo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-2xbK7dmOPkySgnloI6g7mw-1; Sat, 09 May 2026 15:38:10 -0400
X-MC-Unique: 2xbK7dmOPkySgnloI6g7mw-1
X-Mimecast-MFC-AGG-ID: 2xbK7dmOPkySgnloI6g7mw_1778355490
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48d0677b5f7so17360755e9.1
        for <kvm@vger.kernel.org>; Sat, 09 May 2026 12:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778355490; x=1778960290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ANPZRIsHdOb2XjLaWGPcru90KA3pfrVWtS2xY3q4MU=;
        b=mXgzdtgBOga7z50tShzYs/7rN/lCb0HwMI53jZM3JLWbW5zDRvExR6JGr1GAONIzon
         Ep9VtLE0pmu4YpbKzqkplbgLP+/XpS8QtybXLPeknJJ4KZzpGqQP8tsSdzsbHTaebmtA
         8GePYpwdziTypHhrOE9aJE6YZs/uFVqGcbltaPHdmkmdnKGLtyrNdeDXurvSnrDLOEKj
         pHwHnZP4Tl7mACXRbpKm+mnWoaRLM/3tcv+MmOzAuiA19rW8RsrnyPrT0d9Mv5WNx7Br
         pVAvhktBg2TmubXo1pZJgT/9s+WXz4DrMQtyKPlQXRQPDpkhnxvdVGUEyNtbiERFljao
         gumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778355490; x=1778960290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ANPZRIsHdOb2XjLaWGPcru90KA3pfrVWtS2xY3q4MU=;
        b=nfLrL1d0Hk/3hu+Mf9vEvnIPTKz8z/PV9Bn1YijwQjkSnZ3r/bUvAwuUphF+ra/oAN
         /AGT/kpbXrnyk5UJolqM/w1x5hYh8sEGCl+1aUBx3vPu2awJDs3J8hZxZh/ak3iCnFWU
         s2Rge13WE58iqM1PT8Hgus5h9bIChYxsZpYs9vhtLZGApkTK0PRJxB8O2dBqEiEcDD1S
         qzyDhdx0/HJ7ajWgjGsmsaVnXtWZ9XZrTjFhSBEK4909yZI0ctn8vuX7ws6zgx3GNvIG
         eaLEWVNEK8OHG7QpMFFlfiHzwKnrHrINfkIeKgbnhHwBRvg/vjvOybh/HJMtDt5b9XIv
         fvjw==
X-Forwarded-Encrypted: i=1; AFNElJ8jxdmRBPSNK2xDN5OHpNEAryZvm3lxh/qpKxMXescuMGKuFFAYb8kikAxSSavkPxaCXQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiFH8a8H709zLZXGsmaWy8ZHwOQ7L8ECPJBywHEHGv05xDd3K3
	EXe1Wu0MDJ86Jcw0boLGPbegcIDp7+Fz9Ny71V/jELfSD6HbxMmkETvGQ5Nt4P6PsIWt3YNVj0w
	E6nZMF/8tM8VZR6kPeow7SviiM9m2NJN+YWVWWE73AUr1ycpwVA3CCg==
X-Gm-Gg: Acq92OFLTnF3Q4bv427GEA/gBF5yCCsxWJ5KreUVMOoQOJRdiBQPPB6W9T503rOgSf5
	CFxcvSPGE380K0l5RXmmd7t0Au0EmzkTt5eLQ5T6BfVsVMgwKJrub/J0Fluhf53ZV+PCSTzzG6E
	vdsTUdPx6GHFqp1dqFYpLJ4Mo8bBFB+WrvpWRcHcOP+JhrlQFZLMyPdq0ImF3jOnM2qtTZPfgux
	zfOXJdSKCZzNI96Df+Xvdkcu87TRluVmSFhZopBmmJdF6PwWYlWfSmt5MJABAc0Gt6dor+D61+y
	B8qunVjJc4FQup/9VzMyTGIgdx2p3yTxaGqbOEgANpsBdFCNl5aRchPmL/HRpf4UJnJytGtCEc7
	bLL42U3X1ahAktcU5WhGmhJT7TD2F0oVUdlpPS7Ot
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-48e635a1b95mr165361465e9.2.1778355489631;
        Sat, 09 May 2026 12:38:09 -0700 (PDT)
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-48e635a1b95mr165360785e9.2.1778355489118;
        Sat, 09 May 2026 12:38:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db0fed0sm28105665e9.25.2026.05.09.12.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 12:38:07 -0700 (PDT)
Date: Sat, 9 May 2026 15:38:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Yiqi Sun <sunyiqixm@gmail.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net 0/2] vsock/virtio: fix vsockmon tap skb construction
Message-ID: <20260509153755-mutt-send-email-mst@kernel.org>
References: <20260508164411.261440-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508164411.261440-1-sgarzare@redhat.com>

On Fri, May 08, 2026 at 06:44:09PM +0200, Stefano Garzarella wrote:
> While reviewing the patch posted by Yiqi Sun [1] to fix an issue in
> virtio_transport_build_skb(), I discovered another issue related to
> the offset and length of the payload to be copied in the new skb.
> This was introduced when we did the skb conversion, and fixed by
> patch 1.
> 
> Patch 2 fixes the issue found by Yiqi Sun in a different way: using
> iov_iter_kvec() to properly initialize all the iov_iter fields and
> removing the linear vs non-linear split like we alredy do in
> vhost-vsock.
> 
> It could have been a single patch, but since there were two affected
> commits, I decided to keep the fixes separate.
> 
> [1] https://lore.kernel.org/netdev/20260430071110.380509-1-sunyiqixm@gmail.com/


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Stefano Garzarella (2):
>   vsock/virtio: fix length and offset in tap skb for split packets
>   vsock/virtio: fix empty payload in tap skb for non-linear buffers
> 
>  net/vmw_vsock/virtio_transport_common.c | 47 +++++++++----------------
>  1 file changed, 16 insertions(+), 31 deletions(-)
> 
> -- 
> 2.54.0

