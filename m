Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135893812DA
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817211; cv=none; b=dYSn6weQpizYVdnmtUYDRK2tOXOu52kV8R8iaGNSe/yUDu63w4Q8mGdBDAUwyY3N7nxpk+Vp2UA8sbydoKEX5Vumu4JjgFjq+DkmAYy/PZ7acwJMsAQs4Ataevw8wbc6+6a0u7WqawoZbLWE8lr2VDOHI63i0Ku7yA+boqIax90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817211; c=relaxed/simple;
	bh=WK5jWQltk5vyR1Cu/cdEG/Z6ilUkGdamhWepcLq/Ixs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+QqsVAcRlbaBXWvFz1Jc8w9UxSCMx7pg+40ROLtHwzDOdgbt5H8P+Pu9BJBYWerydCADw0tnHmw1Bf7yxKsCGP0nJMvf12cz/tEGwRwqUVf2jiGZKdboEFiOcTo2/opxXWckm6D19o8Rj8W9uZAPEU8ZEnCHnUaCeZCD3GVB4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmCrMWl7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JpM6mKNM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmCrMWl7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpM6mKNM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788817208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAXKQ4OOcdQjAB+UG0/5rt4pMsYCjaJqcNAWj/elvSU=;
	b=UmCrMWl75zDb34TvsNOYOM/cat0+pV8qnO1QAlkhMXC9JnwpWMIvpeldc9Du14E5flX74y
	EQTxraWbQQFGBJ2u8ZW8x9v+jzq+EOBKvkEfvSkcHg/ybKW8+GLeD5dgZ9yVfUU5nWYHwc
	yLvdiur9Ae5ZZrfQTdcy9vAvp2KT9v0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-HdmqH5pPPOiAoIV3ZxXgdw-1; Mon, 07 Sep 2026 17:40:06 -0400
X-MC-Unique: HdmqH5pPPOiAoIV3ZxXgdw-1
X-Mimecast-MFC-AGG-ID: HdmqH5pPPOiAoIV3ZxXgdw_1788817206
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4859233a9a4so1628967f8f.1
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788817205; x=1789422005; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YAXKQ4OOcdQjAB+UG0/5rt4pMsYCjaJqcNAWj/elvSU=;
        b=JpM6mKNMfUHh4el5LbJ/VNZqYfZxtDOTQ+LN6jNqbcc74lDBbme3uelGllm9rIVN3O
         v9CWhpAj1tsPuUbQY1hIWreAa1qXOF+OrrW/8NKjHKzHuzU0uN427ah45EFhnkVpPbfY
         yS3iy9eqBFOk3mwByvITrWiYTJ/PzZIaGktXuYeyAgdRCotavF8eucUIhs43PHMWHrGt
         6spIRDI53k5dL/cGDN3DLQ6kdEXAlwt44ERYonbEe1xrtwTMpPJsOOvCbDA/w/53qNXc
         ibjXoybppTbfZUyjLF/l4b1rqN1fg7Z90pJemBS1OTJSWntBfg0/z7/Un/2PrGI21tkl
         5Ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788817205; x=1789422005;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YAXKQ4OOcdQjAB+UG0/5rt4pMsYCjaJqcNAWj/elvSU=;
        b=J78ETQ4YZRr4B1onVE0FSto2S3W2wpgMZUp4ql4QXWQV/RskH9ot92vzW1xdY2hCXw
         zE94+1tIOqHQ99Y62GJBXWGvqnk3gLP8YuWY9CQRAkhKP8xdo5aDsyC4nMO6RtP7QpFl
         QU9CJgED7LteVTKihbj+VF7zyMM3VK/j0GOjy4UdsJgJfJUrgBlgZJhu7e5St35Awl3g
         HEDpDh5jW5mK8A97aHQ8HtfVf9lTgtGYbia9u8nH3NTEmVeql6hXYloi7jeKgv/rqd5V
         H2YhpO22Gu1ggO0ext9Xh/cJJhMR6QA2t75W6jk8VouxxXbUFapkQYHjrBGR2wcE9F+t
         PUgQ==
X-Forwarded-Encrypted: i=1; AKwUvByexiCBvKBL7s+it2ntfk+LHJ2HvG17Kz+q5K0M/h7BG2HST1zyxVYyLiv4nUfvtcO6qBw=@vger.kernel.org
X-Gm-Message-State: AFuF++lreQR9oqIzUne8F8umfN5ozIjaEPZnvV80pdVGfj5KZ6GEwxzd
	urQhbwp97dNtqslLeTWFVUjUy/wyBe1OvllV3vsQ5zdqzkY11R/cK78SML6Qn5P0th5+yM5ultt
	6jXrW8IHyr2c0OXenKpq7v/16Fl+d7/sCL0ZzjkQoCmZ5FgdDD2TnAg==
X-Gm-Gg: AYBFou3880JDB9niU2uPnBzRsLt1j5sYWE7YIrOkM8cAPJXiWRz/kP40h7LjGGS7Qo9
	ptz9HH5i/WqNXrQE+pP/RswPBTHcnSKroHhHZH/ox61GouNoZHudeTzJKzbpeffrSTp6YCz/RJc
	9zEtMcMD4zGIt/5pP1RFazdTD17ZH2Qzb2JIeNPKdgTAI8Fy6t8qktYD4K0DABXgrKm4fbZ7l6P
	+M00z+XCA1z/kDO1b25IEHLliMJtodd0RKyZUKZ5iLrax2KJpKeKXFSc+rH0vY/ogxmHo5hG8zm
	/ethkKlo8aKO1v6AJfNn/QzQ1Oq0NTpcBUgfFKg9VRw3JxDMvA/1agQtQdtETo4hSnDNBts/c2J
	NpFBzTnGtgz7of7dqpi47AWo=
X-Received: by 2002:a05:6000:178e:b0:484:3200:b7a1 with SMTP id ffacd0b85a97d-4858708c88amr44620575f8f.13.1788817205504;
        Mon, 07 Sep 2026 14:40:05 -0700 (PDT)
X-Received: by 2002:a05:6000:178e:b0:484:3200:b7a1 with SMTP id ffacd0b85a97d-4858708c88amr44620539f8f.13.1788817205058;
        Mon, 07 Sep 2026 14:40:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d312ca0sm31768111f8f.4.2026.09.07.14.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:40:04 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:40:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yu Zhang <yuz08559@gmail.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] vhost-vdpa: drop the parent's vq callback before the
 call fd is released
Message-ID: <20260907173931-mutt-send-email-mst@kernel.org>
References: <20260806150323.2154-1-yuz08559@gmail.com>
 <20260807150405.53F5B1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260807150405.53F5B1F00A3E@smtp.kernel.org>

On Fri, Aug 07, 2026 at 03:04:04PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] Torn read causing NULL pointer dereference and incomplete UAF fix for hardware VDPA drivers.
> --
> 
> --- Patch [1]: [PATCH] vhost-vdpa: drop the parent's vq callback before the call fd is released ---
> commit 59fc02f21fdc99bd2ce2389a383eab4badff2c47
> Author: Yu Zhang <yuz08559@gmail.com>
> 
> vhost-vdpa: drop the parent's vq callback before the call fd is released
> 
> This commit clears the vdpa callback pointers before vhost_vring_ioctl()
> releases the eventfd to prevent a use-after-free regression with VDUSE. It
> aims to ensure the parent driver drops references to the callback context
> before it is destroyed.
> 
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index c3d913bd7cac7..63ffa94bb4793 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -721,13 +721,34 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
> >  			if (ops->get_status(vdpa) &
> >  			    VIRTIO_CONFIG_S_DRIVER_OK)
> >  				vhost_vdpa_unsetup_vq_irq(v, idx);
> > +			/*
> > +			 * The parent caches call_ctx.ctx in cb.trigger without
> > +			 * holding a reference, so it has to stop using it
> > +			 * before vhost_vring_ioctl() drops the last one.
> > +			 */
> > +			cb.callback = NULL;
> > +			cb.private = NULL;
> > +			cb.trigger = NULL;
> > +			ops->set_vq_cb(vdpa, idx, &cb);
> 
> [Severity: Critical]
> Can this non-atomic update cause a NULL pointer dereference for hardware
> drivers?
> 
> For hardware drivers like vp_vdpa, the interrupt handler reads the callback
> struct without locks. If a concurrent interrupt occurs during ops->set_vq_cb(),
> could it read a torn state where it sees the old valid cb.callback but the
> new NULL cb.private?
> 
> drivers/vdpa/virtio_pci/vp_vdpa.c:vp_vdpa_vq_handler() {
>     ...
> 	if (vring->cb.callback)
> 		return vring->cb.callback(vring->cb.private);
>     ...
> }
> 
> If this happens, it would call vhost_vdpa_virtqueue_cb() with a NULL pointer,
> causing a panic when attempting to dereference it.
> 
> Additionally, since there is no synchronize_irq() here, could an
> already-executing hardware interrupt handler still race with the subsequent
> vhost_vring_ioctl() freeing the eventfd, leaving the original use-after-free
> unfixed for hardware drivers?

Yu Zhang any plans to address these concerns? Seem legit.


> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260806150323.2154-1-yuz08559@gmail.com?part=1
> 

