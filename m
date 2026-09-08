Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CED33B27C7
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855274; cv=none; b=EXeR5JQ2/DfHXIht3M8663qdsYXoglOw3nUCJHRfkv4Lbo7W1X3QGkbUw2sVv9edr+/1MWZfLwg+2vZGdrEtq/tkfdf4pdTH81Ukf6bKs4jqciel6ziwtgrINWJHS1e7ua336tVhpg5jBwSPM6/+Mc3EqO7U45HzI0A5ynme/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855274; c=relaxed/simple;
	bh=p0hrqdChiW+STst7BxkT07ROO3GuAhUQ7F3vjs7ZfoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzCdDg8NaVJ/gxPRNiJMnQpgtUABz/f0RbyozGTFqUY2Qo3sUzb0i8ZwdRXX7H/b/MYKLgARBy8cvwWJie/jQc1b5l6gWcX7JcXSJ8zGgdU7UVb125YZRRs6xxCCFkPNID5RvipMhxtNbWhP5CEdk7GlG7zZqX9ZHwGCwfdWX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=US2RD10N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tIkOpaQA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="US2RD10N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tIkOpaQA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788855271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACV6/WKaVrWxyqCJOW8h61Ofi+NiZkidjU4efmY89RE=;
	b=US2RD10NfJiVcig9CjDIZn7gC7Jk7Bi8IpC7raPuFpNgkfbx40xUH4wYQiimO6fXsTAmdH
	F7GAYqGguxsO8YHem4Hfc8TCEL3HsWjF1DUnrd9zpl6tntamHQXZKrcStwMzovhcW5B206
	g+zFHDBOYPF6xWNyAerjYTgBZLi+euU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-7qYA4_ViP4aN4BNww0autw-1; Tue, 08 Sep 2026 04:14:29 -0400
X-MC-Unique: 7qYA4_ViP4aN4BNww0autw-1
X-Mimecast-MFC-AGG-ID: 7qYA4_ViP4aN4BNww0autw_1788855268
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-482f2b8a116so3832052f8f.1
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 01:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788855268; x=1789460068; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ACV6/WKaVrWxyqCJOW8h61Ofi+NiZkidjU4efmY89RE=;
        b=tIkOpaQA4bpiwesQcqIMgAEcODWW9jUXf/chPYhRzMff8k2gNT3/EpT7ubGZR4GuVJ
         BBb802Rm0Z4fFItBjK3nbILtOQTstCpJUls5R04RYvTX8y5SMTXC0T6IeQ3pcAnfXC/U
         rKSacXQDymF8H9SFD+pOp2S+N1gCrSav0O8n+ivOvyNC2H4f0gaNRqU5+1DOcYAiYBkE
         85qdCepjD47XePVAd+DuRDX1RiMaFxkErpXrYsfGBlTkerQ44U2Sk3IMV5wz6PFDbhEq
         /M+YegBLeH8OCZa10sBMN0wGLo1D2P7lVTAKPJClhbwRHauLanDzflIcslDBGAb/ngZ9
         9k6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788855268; x=1789460068;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ACV6/WKaVrWxyqCJOW8h61Ofi+NiZkidjU4efmY89RE=;
        b=Wc7+qvy+weWa2qQBzdVKu+2Oc6TueQFv9iHoBLgyccoAluGMnw+xVtUHjrLJTEqMY4
         nhly+TmRWJgJu8hICGY5seOEBdzihO/2OVR4RXkXlO1f41LnWpvj8wNCp7vU5HJsh+R3
         1pfrvJ+D4pakNJAoiLOSLoz+VkN6QV2DdwkzMJThFXIrIuChadK72WGzz3vLyAUBuayG
         f0ws5iA4e5hIxYYoJm2blCXzYahj6O3Csw4X2k0a5NuM7SLAE7g8/Dv0neadmPbesgyM
         8+VGEin+DWGISCDKF1Y/JF0g1njc3rXxgFkyM0tUbUxVDUJQEQ1ABFOAAmZt5nOeUn12
         JVkg==
X-Forwarded-Encrypted: i=1; AKwUvByOY+53Gvg/gBp/A9H+xiJ1Rxl6S13tY8k8+5GnLfjXIPMKfAizQFLB5YMKXceTHivL2eg=@vger.kernel.org
X-Gm-Message-State: AFuF++lPFY9ybRLML72+2A89mcZEYN9SRJf9gnNxS2vzbIdRNcmN77UA
	pXbMVAggqApAs5BhcExrQ/k6auYxG1X8LWy8MA1JN319hfkydju24vYCwpmt/mT+QqWdXm33hUN
	oGy32/WlGTkNBK7ZR0/LwkyxKkHcrmeleovXZaBYpMRASPaNEOdSD9w==
X-Gm-Gg: AYBFou0gQRqAd4Y8L3ojLWstP6a+oRGWTwrm6fm+wiTy0dHRL/6ke499OBgT8bwfRZi
	UhSeWapbdu2Ur9tVPN9IbRdprN05J30MksRqlsZvpEtnPcvczYyzZxZ0J3pLzd4AxPAXdsTPDxq
	HoVjFRgkEmgha3mj2Pbd4R/RV2TS7jkNiA0RJfORiDRxLUdh9tMsXY2xWEWBEZkwYU95tBjXgb8
	tbneru5lOYnyDbhQjb8QYj6gNi7lYQ4jxSnNdU2bXTAfGLU0xEwlgpmwHuClyhgEs72UsZ/BEAp
	zDMv4xotZISv2vqIrqaNH6dl50j1FdHj78FNw0TxeACc1goKPJXreekFP6hMBTzoS6AFo/P3WfQ
	3kM1WKHSedGO5gVR5P6lLLSE=
X-Received: by 2002:a05:6000:1e4b:b0:485:85ed:4911 with SMTP id ffacd0b85a97d-48587291427mr22863837f8f.25.1788855268366;
        Tue, 08 Sep 2026 01:14:28 -0700 (PDT)
X-Received: by 2002:a05:6000:1e4b:b0:485:85ed:4911 with SMTP id ffacd0b85a97d-48587291427mr22863786f8f.25.1788855267857;
        Tue, 08 Sep 2026 01:14:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9234sm34253540f8f.14.2026.09.08.01.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 01:14:27 -0700 (PDT)
Date: Tue, 8 Sep 2026 04:14:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>, dmitry.torokhov@gmail.com,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	kvm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v3 2/6] virtio_ccw: always take irq_lock in the classic
 interrupt handler
Message-ID: <20260908041323-mutt-send-email-mst@kernel.org>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
 <20260908053817.26065-3-kmehltretter@gmail.com>
 <20260908055148.B600D1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908055148.B600D1F00A3F@smtp.kernel.org>

On Tue, Sep 08, 2026 at 05:51:48AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The virtio interrupt handlers pass retrieved virtqueue pointers directly to `vring_interrupt()` without a NULL check. A malicious or buggy host can trigger a kernel panic by providing an invalid indicator or interrupt vector.

Buggy host crashing guest is not something we worry about.
Host denying guest service at will is exactly how cloud providers get paid.

> - [High] Lost configuration change notifications due to clearing the indicator bit after processing.
> --
> 
> commit 40545ed73d4381a07a7934fddf3ac60ecd1f90d7
> Author: Karl Mehltretter <kmehltretter@gmail.com>
> Subject: virtio_ccw: always take irq_lock in the classic interrupt handler
> 
> This commit unconditionally takes the read lock on vcdev->irq_lock in 
> virtio_ccw_int_handler() so the write side can properly synchronize with
> the callbacks even when notification hardening is disabled.
> 
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index b90299205698b..552d779980129 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -1204,13 +1204,11 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> 
> [ ... ]
> 
> >  	for_each_set_bit(i, indicators(vcdev),
> >  			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> >  		/* The bit clear must happen before the vring kick. */
> > @@ -1219,9 +1217,7 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >  		vq = virtio_ccw_vq_by_ind(vcdev, i);
> >  		vring_interrupt(0, vq);
> 
> [Severity: High]
> This is a pre-existing issue, but is it possible for virtio_ccw_vq_by_ind()
> to return a NULL virtqueue pointer if a malicious or buggy host provides an
> invalid indicator?
> 
> Passing an unvalidated NULL pointer directly to vring_interrupt() can cause a
> kernel panic when it is dereferenced inside more_used():
> 
> drivers/virtio/virtio_ring.c:vring_interrupt() {
>     ...
>     if (!more_used(vq)) {
>         pr_debug("virtqueue interrupt with no work for %p\n", vq);
>     ...
> }
> 
> Similarly, in virtio_airq_handler(), airq_iv_get_ptr() can return NULL which
> is unconditionally passed to vring_interrupt().
> 
> Could we add a NULL check before calling the interrupt handler?
> 
> >  	}
> > -#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >  	read_unlock(&vcdev->irq_lock);
> > -#endif
> >  	if (test_bit(0, indicators2(vcdev))) {
> >  		virtio_config_changed(&vcdev->vdev);
> >  		clear_bit(0, indicators2(vcdev));
> >  	}
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but could this sequence lead to
> lost configuration change notifications?
> 
> Because indicators2 is shared DMA memory updated by the host, if the host
> triggers another configuration change in the window between test_bit() and
> clear_bit(), it sets the bit in memory and raises a new interrupt.
> 
> However, the guest will then blindly execute clear_bit() and wipe out the
> newly set notification flag. When the newly queued interrupt handler runs,
> it will find the bit cleared and do nothing, permanently losing the event.
> 
> Would using test_and_clear_bit() before calling virtio_config_changed()
> close this race window?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260908053817.26065-1-kmehltretter@gmail.com?part=2

