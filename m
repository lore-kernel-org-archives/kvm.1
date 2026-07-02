Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8828386C08
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783022967; cv=none; b=A85BhensWh64CTry8O0ihCyB98jV3FY2AVYvgrCZw6MGXf2EdhePMmrT5+fZCWfI7nZjqAfNdcIXgWJOTO+WXT3zrOOS5DLMob4Ovmg2DXGJcFyVYezwyaafLCRhWF1e6/xTu/Jt9yuN+riZfN0p/QcvrUXnjJLclQLLAfCSakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783022967; c=relaxed/simple;
	bh=13oD+YiL/3o0MEN6K6Y/bx7CKvJzT37nBrfnC/MzHFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rpvrl3Ga3uPsD9q/v37Ccbc/W9rG2VOas1EW+p3/ydrXc3UlnIqef5lbI1pw204YkU+F/DfJeDZgexbMvdL5IsN3m9tL+WB5CZpebtlp3wTunYpaZMzL4KR8CH84IHTomAJnnQPNFrEi09UmxF2pqFwz9R5pydCxXwtkzytHD7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYht2Prb; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYht2Prb"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6a190528769so921018eaf.0
        for <kvm@vger.kernel.org>; Thu, 02 Jul 2026 13:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783022965; x=1783627765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjQFRK3eyEfNEKRH/kJEfHrxEWDAZH2cdSABwq7lLiA=;
        b=qYht2Prb/gnqRafc370x8QL0AVhwNbkWYD7Mb0oEnS6BBC1/7zqQk4okOm+qy8WkGQ
         RxC4dqTCKz01d3diR6dB2/5uKwM8YFAPrXjCx646oRPimx2pQb0+QSMqzy5/ttykB3zo
         tiInWqtjwp7x2BlEhBNZ9UvRPSorkfoZSFL1Ts+hgBxNBzh41kxabF+GJSxtH3TgtrIk
         7bjozptJEY/oUZlHpoUIs2DKPTQ/Ar+ULai3UQ1k3whzj32T+2lzBGKODMkUxIp2ESkk
         Qtocv5xq1OwB5kxkbsoWaRMzaYj74+ddVix6bjxov7mWczXJPVfYTRRDp4sNwrq/6I06
         eXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783022965; x=1783627765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjQFRK3eyEfNEKRH/kJEfHrxEWDAZH2cdSABwq7lLiA=;
        b=IMY8L9yvVrPdL6Ualt5AGPaA0NF40sWpClUEJLmlaeiYzftSKHnXWU6Xyut1RPiUr4
         04kt4tguaWJa4aK812hNS6VjLgB9RkPAHyp0EZQMHR7KSNfz/JjX2Ew5knhkuwdTCA3x
         Bh212MvQy+Ws74TsqWiO9N/f+CIrozlbQqSj62QOOoF5fzQ3o2Ach8FRiFuGmlJfr51y
         TK6DQkNtX4kMvoM+veejk/eOclcp27NmFC95SVliLRMXit+onx2t0MnNka8aIF2WGD4B
         qj6cSkbY294TPZ8s1Kj7wHBUv9sWR0EfVsFrNi9+cOdFoCnc8Btj/U+Ug7YQwdH2l0dV
         xykA==
X-Forwarded-Encrypted: i=1; AFNElJ8P8PlDPWyk1CobN8z+gOnKGiKammBxPudm+9K8cN90E+6CxciJi0VyqkzJBQ9h50RsjwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznQcjnoF55OnvHUjPhkoMywxcR3PoqwNWIciVv6z0hy1+Gbu4c
	V+NNZOUN49Oe5BOxjziGrPVwyAaq91PHQq9ynWsKS4sft7vC3v8WrN1h
X-Gm-Gg: AfdE7ck4kbkzF2RIZT9B98TmnMOkjhtmwyCnBH4j2+9jk6IdsBXPjiX+U0nPIVTAy6m
	RmZwP5xUpxrXHXL4LOiGwmdz19XNTHaTV0ziuQ16BiqDRlo/I3ae0YnWJv49GlqYgumuz/HfvlW
	LqTLXAc3ZtL6tJUNZgtDGZr8BZR0dHlukpVyDzTGZmGpzQpuh2bOfR+yo/xlgvGQKHMH3E8KAYe
	dBjwdzK9y+zySQ7dCSJ9yHP4a27IaSJnQHLnAGergSiQcucU6UPSxMn41VENuBb9GRdkH/+LPAC
	jarCjGPy2LP4cvFhaM5KcuwE/Bx7hyNAl+Iz5JBev4CTEhjI9V3RKYfcszdjaLVxVCuEoJI7tP+
	Guss74+6sxgZvFOzhXyMl2D8qN4SzBlbPUg3Gpw6FPsn8WpNLR8Lk9JgHvAh+HvEGVlQgIXLkZ2
	gK3dibZyAlpkY7NuGCjvVmtxoM683SLkGG2g==
X-Received: by 2002:a05:6820:4cc3:b0:6a2:739a:ce95 with SMTP id 006d021491bc7-6a309929b99mr4607337eaf.4.1783022964709;
        Thu, 02 Jul 2026 13:09:24 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3662142fac.12.2026.07.02.13.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 13:09:23 -0700 (PDT)
Date: Thu, 2 Jul 2026 13:09:20 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org, Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <akbFcMHenseQW7mJ@devvm29614.prn0.facebook.com>
References: <20260626134823.206676-1-sgarzare@redhat.com>
 <20260626134823.206676-2-sgarzare@redhat.com>
 <akVBmydgSd0Eb46/@devvm29614.prn0.facebook.com>
 <akYl38_9Y4ydXuqE@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akYl38_9Y4ydXuqE@sgarzare-redhat>

On Thu, Jul 02, 2026 at 10:56:04AM +0200, Stefano Garzarella wrote:
> On Wed, Jul 01, 2026 at 09:34:35AM -0700, Bobby Eshleman wrote:
> > On Fri, Jun 26, 2026 at 03:48:22PM +0200, Stefano Garzarella wrote:
> 
> [...]
> 
> > > +out:
> > > +	if (new_skb)
> > > +		__skb_queue_tail(&new_queue, new_skb);
> > > +
> > > +	skb_queue_splice(&new_queue, &vvs->rx_queue);
> > 
> > I think the new skbs will also need skb_set_owner_sk_safe(skb, sk)
> > when adding to rx_queue?
> 
> IIRC we added it in the rx path, mainily for loopback to pass the ownership
> from the tx socket to the rx socket, but here we are already in the rx path,
> so the skb will never leave this socket.
> 

Ah that's right, I stand corrected. There is no sender to leak in this
case.

> Maybe it's necessary for the eBPF path?

Looking through sockmap, I don't think it depends on skb->sk being
non-null either (it reassigns owner to the redirect socket anyway using
skb_set_owner_r()).

Sorry for the false alarm. LGTM.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
