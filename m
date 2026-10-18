Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7148D3CEB84
	for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359757; cv=none; b=GbtB0K4DTK5xxZmQiGUfUXzE1FQuOBWG8GKA/VesXloNl5R0shRg0oOqYu7N8/QTlSDJr2D+xyreoMBRy3UGiB/jG0orQeSFE/VYYVS9J3sQYkjxu42nDn7eP251oB58mgCgvUfWLiiBuJkrx6X4FP273NQXj/ukGWRLec4jqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359757; c=relaxed/simple;
	bh=a3AmrwR8v2jihgGq5kU4YfBXbpArfNYrMAioQAluXE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlHvGzvMoFaEnqNteqeg6OsCxefMArXz8jQakGJTV6NKo5dMtTEnuYpjpHxSP8i+yfkiAUKUvnJn47av2q7WO23zcuzTJxcMZ7chzIzLQ53Jnucggq9+ouSutWacQgtrUAYNs3TjXY9K+JFbEeaJBgNdA6TRdBxmk4PNfaDk9xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDvAhuUF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKI2lXZ/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDvAhuUF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKI2lXZ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792359755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l5kyv1GQkP0lF5khYckjfpPeq+O6vgVUGzl8O+44HLM=;
	b=ZDvAhuUF3AEuZ0JZXrKiPWXudF/gK1F5MWiEEA8SkwC+sbYOGbWYFd8M4SPyWCqBvhbHu5
	WNA5GhDGvMN3GrnTyD8OvRFRipylQRJay8c+g0cx6aAvhAe4lRlBOhewK1ny7/JsbmbMNM
	qtJwa8KWOVbWBdosU+Xp6O6JAw7o7z4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-sJim8LljMmG91-egsaXbgA-1; Sun, 18 Oct 2026 21:42:34 +0000
X-MC-Unique: sJim8LljMmG91-egsaXbgA-1
X-Mimecast-MFC-AGG-ID: sJim8LljMmG91-egsaXbgA_1792359753
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c427421f6so924330f8f.2
        for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792359753; x=1792964553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l5kyv1GQkP0lF5khYckjfpPeq+O6vgVUGzl8O+44HLM=;
        b=OKI2lXZ/F3By2sizfNp0kecR99IZCO3uiOxglct6RUkFwAEDmQU5R6FCA2zgzwY+Df
         NO6mFCmgyg/nsCPpDTX6a7aBbbwFulHDPWsiWB+lQPwyeF5+A8CKdhRZDUvprskxxiL8
         OEOURYfpupBNkzMYV6UpXbgX3ZPqwtml7uQQ0FnG89PPiXHV0bJMgT1lnKoh5tAZdBnE
         EpLumLQfEgP/kyVtXEnQlDWQbW30EZYO09qt+5CAVHfGTX6ZxWtmHse6+ckNpp8B3+Sn
         nofWAtQMLKuuQ0I99O2yydU8ronbovtSAHOLvsfooBTxlsevWOE3iDGk94PUEexzYloP
         Twmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359753; x=1792964553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l5kyv1GQkP0lF5khYckjfpPeq+O6vgVUGzl8O+44HLM=;
        b=Dj5CSCzg278MAApFOYZegAtDidZU5hWHgvGvNBjgl847zqrvA4qp4yFXpNb3tPmYtU
         ozda/pGGF/pPMwbmmBgqufIt/ciyxIhgid+j26E3dmzKApvh6RFNqUC991olpHjhpMNc
         oQWdW3kRkYEjHr6YQM6cR4QWxzboifEVsBqKCkL7OOqyEOuyJg+lDB2L4+1W/C3Iwjpy
         v0qvbsylEosylDPQc/yW+iFS6CAzwOix5+oft7VH73yZoNLZ4qGBVdsFdjZiEzKAgF8s
         JEPKA/kJA5SUyeSxQMSiv70M4oDTU592BgzfAGoEf3QwoYiqcfBbTfyU/cpAdQ2PWxj7
         uX9w==
X-Forwarded-Encrypted: i=1; AKwUvBx9+cMEj3AgX370lXnELsL/PBSxfY/PQjAw9ccHFxyA2NE8XIrHDSeKqhDYmmFFm3xuRkg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK26xq/aQjcxM2zQu/VffvydWA3Rmzadz7hdjqhQAzd5lbZmWg4
	6FCqmc9PHB2gLc4JXjVjaL4ZGvhlKwgA1qGI5qw5EK850WnIB54ZP4kNeEZirSzcV01RagKE622
	QswxAppCP9D7UyeIGkyYhyuYGFPPKq3PzMebGeUUTE05IEsnVOLUvhg==
X-Gm-Gg: AYBFou3AbD2cuuN37mJECrPOXMt9B2+BzhJfZ2da26xm96q3gd5JpbM55xIYw8E+bWd
	dvWffNOccduicft0VYuSyMmjjQ0mCpyHhzu/Ws+2hO+OiCwftb7VZlAkx42Ct4zYTEFGX9QMX2I
	T3G5hjnA5ePnaY4o3TF7v6c8snOl821w2Sy5GhR6vY05Sgj4ygismi62tQWoHAx83qENLB+99ch
	MUqN2bV3/UEJQLiEWWTEHiUJRVwE4LcTXeZDl/RkTi3xJM5eJ8/tLX801x03I9c29tp/hdg0HWv
	PIouSb2TpLqB3G0wpsnMXflNL2tOc9wpNTJcOFuk0i1Jw9osOw9pr02hFG+AlERk0hIIiQ==
X-Received: by 2002:a05:600c:6289:b0:4a1:dadf:9876 with SMTP id 5b1f17b1804b1-4a1dadf98d1mr105366575e9.23.1792359752780;
        Sun, 18 Oct 2026 14:42:32 -0700 (PDT)
X-Received: by 2002:a05:600c:6289:b0:4a1:dadf:9876 with SMTP id 5b1f17b1804b1-4a1dadf98d1mr105366305e9.23.1792359752289;
        Sun, 18 Oct 2026 14:42:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ae6d2esm226529615e9.6.2026.10.18.14.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:42:30 -0700 (PDT)
Date: Sun, 18 Oct 2026 17:42:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, eperezma@redhat.com,
	linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018174144-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <20261018204838.4080b238@pumpkin>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018204838.4080b238@pumpkin>

On Sun, Oct 18, 2026 at 08:48:38PM +0100, David Laight wrote:
> On Sun, 18 Oct 2026 15:24:41 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Oct 15, 2026 at 03:23:45PM +0800, Haoran Wang wrote:
> > > I'd like to report an issue in drivers/vhost/vringh.c:1216 (function
> > > getu16_iotlb), found via static analysis of Linux 7.0.11 and verified
> > > against the 7.2.10 source tree. I have reproduced the leak on an
> > > unmodified 7.2.10 kernel.  
> > 
> > 
> > This should fix it I think? Can you confirm pls?
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/vhost/vringh.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> > index 9066f9f12ba1..4b097170bd36 100644
> > --- a/drivers/vhost/vringh.c
> > +++ b/drivers/vhost/vringh.c
> > @@ -1213,7 +1213,11 @@ static inline int getu16_iotlb(const struct vringh *vrh,
> >  		return ret;
> >  
> >  	if (vrh->use_va) {
> > -		ret = __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> > +		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> > +
> > +		if (!access_ok(uaddr, sizeof(*p)))
> > +			return -EFAULT;
> > +		ret = __get_user(tmp, uaddr);
> 
> Can't that be a normal get_user() call?
> 
> David

Now that you mention it, yes. Thanks!

> >  		if (ret)
> >  			return ret;
> >  	} else {
> > @@ -1251,7 +1255,11 @@ static inline int putu16_iotlb(const struct vringh *vrh,
> >  	tmp = cpu_to_vringh16(vrh, val);
> >  
> >  	if (vrh->use_va) {
> > -		ret = __put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
> > +		__virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> > +
> > +		if (!access_ok(uaddr, sizeof(*p)))
> > +			return -EFAULT;
> > +		ret = __put_user(tmp, uaddr);
> >  		if (ret)
> >  			return ret;
> >  	} else {
> > 
> > 

