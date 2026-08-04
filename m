Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FBC3EA94A
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 03:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813780; cv=none; b=SU1It3anfLIfG1Zh32CYMLCDytQoUmEQcdruaQzKvf3wl3A5LerHZXEO7SqZe9wyJXc4DcMMRW7wwWK8Cdj92YCSnK7x/eSm2XmkL/VhDULtOHckQkLGq1h8XIum5fJpxhyLsH+DaW1e0zTMyANGJxuIRlQI9/SlO0iMA/yKtZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813780; c=relaxed/simple;
	bh=69QDEITHOpPOWzQ3L59hQQJy9vD1zUTDGKiwsGWVBos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=micQm3LOqsHfl6LuOcefs67ywbXr+NAbKj5dZYPGR9cuHrWcyITinJjAfmZruwf87vYCrsVTrMy8Kzxy05ECZexyI5qzJPyY5KlAPChxq3BBPNHvJJ3+UbsUCRZdO/ShKn1l5+MqNXtjnJVU8LRNq67aEKpdCpdkUXIcbAS/NWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hg+uMTeZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lvBkXxFQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hg+uMTeZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lvBkXxFQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785813777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L3UKhKneDgKdYIrEhObF1uoqht+Qy/GPjJ3FBr2XU/w=;
	b=hg+uMTeZnX1iUYIW3KLQFrcraEyrN5vDTEzYRkQ9xuzL55mYtOnkVXM6kYvSFjZ/yVApDa
	Xj2+WVvLJRXmKuG0jdLa9MRlav4WmcuKRJ1VLSRMVaA252v8hf+BTqbJvInWAZYbPnh77j
	qZi/TnN/YGaWlYFOHKHNnkQtJKKEBeo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-BE5bpbcWPr2kwYuJj5RDFg-1; Mon, 03 Aug 2026 23:22:56 -0400
X-MC-Unique: BE5bpbcWPr2kwYuJj5RDFg-1
X-Mimecast-MFC-AGG-ID: BE5bpbcWPr2kwYuJj5RDFg_1785813775
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15ceb17a28so331278966b.3
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 20:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785813775; x=1786418575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L3UKhKneDgKdYIrEhObF1uoqht+Qy/GPjJ3FBr2XU/w=;
        b=lvBkXxFQWKc6BcIP63br9ltd46RUCCBGpSfSj951lfX23mi5sORCth3c84bLtcN8Mx
         hhZ5dI1TK0tXYA8EjGNk2AzRNjnQlvBoAD66bFzfYWXLZFddFR3vQ+oEUXvCcPVIngqW
         e68ZweorhY1noMi6jfR6HxAQ8INNau2KBGsz0enuFWDCXU0EfW3+tPIlJiXUq4adVHVg
         HAZOqyFRtyuHYJbo/6rG7SH5RiS+fsQHFthqFBdc2sMzqM7UybSfhePUpPzuoTQZ3NmO
         4dBTxIzTrGhFzUFC6cBqWYof7oYQG+hAtoe+BduZAf7HHZQLOTiznH90vBugoNUETNcU
         v6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785813775; x=1786418575;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L3UKhKneDgKdYIrEhObF1uoqht+Qy/GPjJ3FBr2XU/w=;
        b=HVNwLZrv1ezMu7/j3Fjsszb3r5DBMkZhO8Bgd+mIU/sG4p6NMRYmRZO2ADUuEMlUfz
         dQ8wAgX/hxxcykrdrJXvoMe5EeeyJIprRxJT12GnALMXCV5x+EECFtisOFtKWnVDkk9x
         vJzJy0ESqL2N/+s8dDfmytq/f/GEs3oaeipuqAFLe8LLWaemHRuxvnNhPGI8PoEGlBLX
         3C0+K6A0xHPrNdH10TjQ498iOQB8WoAQMnFhFrLsd24uyANzj4FdGyLhJzJRCjoHHTO9
         FaI6MIQ8JujfxqnE7gN/IyJp5u3PyB0lu1MnfV1lx0ridaivd5z71gzvy8jp7XltTQ5j
         3VnQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKpePpMRUTrWfFBXamXeo92LmS7dmN8JXlZvsQgfsqCzXDAkEKoHgRE8kSKRVyUEk/TJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSdbHrSE68cVMGhGS5397ewJ4TNrsdVOWMk1CWc0T2N+OnIjGs
	6eFALCC5458DOfi224fMpViFXVxLKBS9ROd9n/al+wqFLVO+wkLHHB/Xm9GxzFZigJ4nW75F9d2
	NFZxsd+PvNTK1zDAg1KvMHsyB6nTSTBwqTU8JyGCNUhZYUjqFJbkv0A==
X-Gm-Gg: AR+sD10xGZuyo/T/S7QiBAQolZWRJQM3uppatGixvojVLQ9BE7EhnnmkJRdVq8gCbBR
	oAFjLUUhZmRdfxaAkg6ghWXkvK/KoBEHLK5LQXv1umgy0sNVV5g3fcv9SsUWfIgTwibBzqze6dH
	degYxD0MmMSfiOvMcePRACuH4z7tM5IkCwFeVCJOM4hhS1zjhx5jrrnzO+88FgzF/Tjhwp4uC2+
	K6Qyqdf4SItN8KEY41BBHprC3SJYB/TCTYwy6Nb/R0qglQ7LFjRo9rQP/5orNlR/mkcXu0qFLrc
	XeySLg35oK4Fea/jq6rtDPF2XJtpXoAp9Zp+Qjuby07v4oXcppZOH9IlHYl3YPw6fAw+
X-Received: by 2002:a17:906:6d54:b0:c15:deea:a178 with SMTP id a640c23a62f3a-c1fe80cad0dmr826568066b.25.1785813774969;
        Mon, 03 Aug 2026 20:22:54 -0700 (PDT)
X-Received: by 2002:a17:906:6d54:b0:c15:deea:a178 with SMTP id a640c23a62f3a-c1fe80cad0dmr826566666b.25.1785813774501;
        Mon, 03 Aug 2026 20:22:54 -0700 (PDT)
Received: from redhat.com ([186.247.166.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c5b387sm596422666b.2.2026.08.03.20.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 20:22:52 -0700 (PDT)
Date: Mon, 3 Aug 2026 23:22:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: michael.christie@oracle.com, jasowangio@gmail.com, pbonzini@redhat.com,
	stefanha@redhat.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v2] vhost-scsi: flush backend after device ioctls
Message-ID: <20260803232144-mutt-send-email-mst@kernel.org>
References: <20260721073639.1532488-1-physicalmtea@gmail.com>
 <20260724060919.1569170-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724060919.1569170-1-physicalmtea@gmail.com>

On Fri, Jul 24, 2026 at 02:09:19PM +0800, Jia Jia wrote:
> vhost-scsi translates guest response descriptors into userspace iovecs
> when commands are submitted.  Target-core completes those commands
> asynchronously, so VHOST_SET_MEM_TABLE can replace the memory table while
> an in-flight command still retains response iovecs translated through the
> old table.
> 
> If the old mapping is reused after VHOST_SET_MEM_TABLE returns, command
> completion can write the response to an unrelated userspace object.
> 
> Flush the vhost-scsi backend after vhost_dev_ioctl() handles a device
> ioctl.  This waits for in-flight commands that can still use the old
> response iovecs before the ioctl returns.
> 
> Changes in v2:
> - Shorten the changelog and remove investigation details.

fyi changelog should go after ---


can you pls answer mike's question on v1?
Also pls do not post v2 as response to v1

> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  drivers/vhost/scsi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 9a1253b9d8c5..c3e8f1a0b2d4 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -2424,10 +2424,11 @@ vhost_scsi_ioctl(struct file *f, unsigned int ioctl, unsigned long arg)
>  	default:
>  		mutex_lock(&vs->dev.mutex);
>  		r = vhost_dev_ioctl(&vs->dev, ioctl, argp);
> -		/* TODO: flush backend after dev ioctl. */
>  		if (r == -ENOIOCTLCMD)
>  			r = vhost_vring_ioctl(&vs->dev, ioctl, argp);
> +		else
> +			vhost_scsi_flush(vs);
>  		mutex_unlock(&vs->dev.mutex);
>  		return r;
>  	}
>  }
> -- 
> 2.43.0

