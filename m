Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371D33242B2
	for <kvm@vger.kernel.org>; Sat, 19 Sep 2026 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789845884; cv=none; b=lbTC2mtcBJGomwl2qV+bZcDJyVEQ7d5G3elbzCcz0Ecvq1bg2ru77mRUJmTZBT6NA6JvgfveCur1VRyDZUerOBLq+H2HE/M3sDnTAFnDv4WAYVnUsHmVMxXyHSj8gjz4sHhh3RtF3ZaNYV5zertLgnZVXk09HL16EdSEfxWeuFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789845884; c=relaxed/simple;
	bh=NeHshQNFCGwJF2ysi+RWsWuwph5Ge0ieMHHyeUv2SS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4LdD4kocMNIDifRVyi1SJybZPpkwg6EAE6etf9e2nLt0L9luLzzpuO21HFlBopjeAVWVLtenShkmk8snwcfSgXRw1lt/JFjO2Bp9olApby4PHH0kePUfpIiEE2S8be8W5cb1Heq+LMdlSwi1TQszRUzGWWwWiOPfqlRs8j31UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGzD+gLl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YD5FrD8L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGzD+gLl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YD5FrD8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789845882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kjyUSthyZu35KpQeM9B/0jd7CF9c0bVVky2/qXbbeS4=;
	b=VGzD+gLlsQrMifF3+CMMRFj6AhU9LHFoULnB0WVC6DkdNAAilC57HBfz/M3b7/4ea449qV
	eTu2ubozrffDgvbJ5ZVP4hem0peLofHY5AaxfAnZZdSH1hSMaPMBF4l9w0xN3M2k4ws1m0
	pFcGiKatmM92Gfb22eiWpO7YEHJvcio=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-R8vv6eoTNL2pDq0hTQaSVg-1; Sat, 19 Sep 2026 15:24:40 -0400
X-MC-Unique: R8vv6eoTNL2pDq0hTQaSVg-1
X-Mimecast-MFC-AGG-ID: R8vv6eoTNL2pDq0hTQaSVg_1789845880
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e65f2f1baso21207225e9.3
        for <kvm@vger.kernel.org>; Sat, 19 Sep 2026 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789845879; x=1790450679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kjyUSthyZu35KpQeM9B/0jd7CF9c0bVVky2/qXbbeS4=;
        b=YD5FrD8L8ro6jkww6Zaehi5NslkKMNn5fdErK2+YRYDdiZGDijDXGu2dWZQbpOnf6L
         l6vFvEUCbL9tXggZRuinaZKPr/0AcEZWwD71mcOZzlfBxirqyPXBAMWrbLG0sfj/zn0l
         U5dcgZlX1dzIo6EHiKSNRSBTR9taTopsHkCgVCOKfUngynr7+Uj4+PaRNeCZAA7VQO2v
         Fw7VBCFNwa2mDatKaWOgGBkv6w8WNBziNrSwqV4kTrHS2I61iZwieu+LFgMvw8+4uUAY
         YK0BvW56/M+lH/vt6HBqJl1yrRNawiaJpunUl6VfHvxeJZC9OzVKPXAXYThBPY6XOO/7
         iNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789845879; x=1790450679;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kjyUSthyZu35KpQeM9B/0jd7CF9c0bVVky2/qXbbeS4=;
        b=pHbv/DZySjhlM1tevJMDZ8UOM+qutXJMScAs7Wk4OsaxMRRu5bZTvoOTVYBkluHdV/
         CgBySpgjvNVEoPdM7Qr6/Eof+n8Bu0JE9vc7sf+k4vp0z4Q1n61BGz7THz/V2tF8ItQt
         nqXhYZ2q/PJV1Fm1o1Vm+DtKcxxzUUYjOMl7CcSsgqdVjsvNP8/ADgie3rBT031p0P5P
         4w6qbBXoMnSwaWwL3qSOOsThLYDLD8bv5BbW6CjAICm332pUb1TI0DL9nw6+QejsPagq
         vutYwpuHghLZ8OO+yvxd9gBpqyAJzkERe9SuPcoCqhxnRIDCozXXWYw+Q0KRJKX+euDr
         DNkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpZH1WZcy1jjE9AgIkZ+hqqYCxMe8EYRf8DqzOnGphW9kUrw3+6bUO3Xn+K2X9OISt+1I=@vger.kernel.org
X-Gm-Message-State: AFuF++ma1G5gcb/RUHmW2wSxKwwZlcRHAmtusUIhQXF3u80/5TZtt7RH
	42H7p2jVj3f8zlClbLdkcw5Azv0hbodyi6+6rzlV3ujqbGdXyp7coM0KiTDwtmolQAT2j0AHg50
	cYtab6XaDppxwlA70gGMdubCSAHwBtBZmq1HWwdiQhp/KoC0NCKIqKg==
X-Gm-Gg: AYBFou25q+5INN2vewLZPFp6drqiZEA73bviVzRTBB+vsnq6Kl9vQwPnCXadWkDrEMf
	u2sHsCAl7E+QQfDVAYPjKicEUCDB2KX7+hHoxrzOvlQgq3aOfoD7fmlJHaP+twJZkgdkhWzBX/O
	9xkttrM2lLPlfOW054xAkxRV6HWQn+OijL6Xqocm6MSs3NDD12nfhyYZHtPOGi67YMO8RRdPCtV
	JDuOyeHAEVJf/Lz61x23oqwQOEFLb2l6BBYEK9HkrDfsBDJL8S8fqVlkjWWfxIqtOAfsFiOUnv5
	k24+7H/azJQQSofUQ3rDknxK41QRHxn6X0S0+uPv+sjywby7qa/D7JMkj84HxeQRx0+zn1ZqdH4
	R+uDQ280QYk0mwlk5ZvZ/IyU=
X-Received: by 2002:a05:600c:5251:b0:49c:fa20:cc00 with SMTP id 5b1f17b1804b1-49fc5736898mr78443185e9.23.1789845879501;
        Sat, 19 Sep 2026 12:24:39 -0700 (PDT)
X-Received: by 2002:a05:600c:5251:b0:49c:fa20:cc00 with SMTP id 5b1f17b1804b1-49fc5736898mr78442915e9.23.1789845879068;
        Sat, 19 Sep 2026 12:24:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0874c3sm138399065e9.14.2026.09.19.12.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 12:24:38 -0700 (PDT)
Date: Sat, 19 Sep 2026 15:24:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: keep vring addresses stable while the backend is
 attached
Message-ID: <20260919152336-mutt-send-email-mst@kernel.org>
References: <20260919131744.131030-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919131744.131030-1-physicalmtea@gmail.com>

On Sat, Sep 19, 2026 at 09:17:44PM +0800, Jia Jia wrote:
> vhost-scsi keeps the response and bounce-buffer iovecs until the backend
> completes the command.  If userspace changes the vring addresses while the
> command is in flight, the completion data is copied through the old iovecs
> while vhost_add_used() updates the new used ring.  The guest then no longer
> sees the completion.

I do not get what all this is trying to say. if you break it you get to
keep both pieces. when is this a real problem?

> 
> Reject changes to the vring addresses while a backend is attached to the
> queue.  Keep accepting the current addresses so userspace can update
> VHOST_VRING_F_LOG or log_guest_addr without stopping the backend.  Queues
> that have not been attached retain the existing setup behavior; userspace
> must detach the backend before changing their addresses.
> 
> Fixes: 057cbf49a1f0 ("tcm_vhost: Initial merge for vhost level target fabric driver")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  drivers/vhost/vhost.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 44cac11b68d2..074590838de5 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2150,6 +2150,17 @@ static long vhost_vring_set_addr(struct vhost_dev *d,
>  				a.flags & (0x1 << VHOST_VRING_F_LOG),
>  				a.log_guest_addr))
>  			return -EINVAL;
> +
> +		/*
> +		 * Commands may retain iovecs derived from the current ring
> +		 * addresses.  Keep the addresses unchanged while the backend
> +		 * is attached.
> +		 */
> +		if ((vq->desc || vq->avail || vq->used) &&
> +		    (vq->desc != (void __user *)(unsigned long)a.desc_user_addr ||
> +		     vq->avail != (void __user *)(unsigned long)a.avail_user_addr ||
> +		     vq->used != (void __user *)(unsigned long)a.used_user_addr))
> +			return -EBUSY;
>  	}
>  
>  	vq->log_used = !!(a.flags & (0x1 << VHOST_VRING_F_LOG));

