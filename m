Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF46F453A2F
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335708; cv=none; b=ibeEwAas6es4oxKlr5MMmKd3WCTriRWToqMcp5AXO9gHmsR+fPf3vhqwmLswCLaaq+0zKPnWdFWRwA1kc/pVvLWe0n+V0zqM7O7UziUVNwkfT0XdLMZtBRE18jKRwzttXvFHnuwlDYjSDe4RyksNVAifXQsMr0nsby0hV13J5sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335708; c=relaxed/simple;
	bh=SlZlOtiUOQpo9MMuW+eMoQMK5d2TR+4KRpZxX0D10wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQij4V4JLBSElsCQt14dB7oHw1nMscTXyvK+imis5rXO9S2iVmk1buU6rrDBueqQtkXVuQMiRnNZN6vprrAHZobc6bKAMxxkHcIEwkb9sKMWHZWVSN9YSp80QT8Uz663xgqXXxzo4WMKWwH63a00a901UM1qg3dE2aHH3on5Zj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NOkro5pg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DP5x7aDo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOkro5pg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DP5x7aDo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785335705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBurJzX00gU8Pu9J5xt+dnrFDqgGyoXEsd3dJoQPNZY=;
	b=NOkro5pg4X5p/K5y2DtqzgQVP2Gq7Y7WEnM2wrcUip4u9pqnB4VCYhBFi9ukeYowd4B4JB
	Ltv25bS2YOKk7FeGkGhtVeGP8o4eVDtGnJs8qfmRF6ElUjsj080WHbECNVEI9w6mBLH0Jx
	YXm+bO/NOL932cYJfQr7icjraKS6f7M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-JCY-HGTsPieIuG_hJ-M02g-1; Wed, 29 Jul 2026 10:35:03 -0400
X-MC-Unique: JCY-HGTsPieIuG_hJ-M02g-1
X-Mimecast-MFC-AGG-ID: JCY-HGTsPieIuG_hJ-M02g_1785335702
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495529a93f9so9743225e9.3
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 07:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785335702; x=1785940502; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TBurJzX00gU8Pu9J5xt+dnrFDqgGyoXEsd3dJoQPNZY=;
        b=DP5x7aDol9a4JX5QN6toSpRc34w38pyzsgQVhKICk9QKyBVnrPc/QrQvlRNmz8Pocl
         AK8dCYTqiT1Ai+yx82Ck77MLyWxJPol+r5FnEfCpsx3Zs7ZXSDSXGUlaO/wKvSakvz6F
         l+7mvTxcER73NnxX7GpYrvdNucW8jP2/Fm1dppffB4rqw4eUuUlyxEv1IduyxUcJXz7s
         RhUBEV+Op/TZX9tMa+B5Y5p6Z3REf64TTMs5ByYD3D3NfHnOMIV0kzEOF2rtkz8yk4Js
         hZgMX86v2KBoObR/h4uXxC0UAkaNTViJlICZEAYke0mQ2zGhawp1b+DFTWpAVfRqidGP
         qGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785335702; x=1785940502;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TBurJzX00gU8Pu9J5xt+dnrFDqgGyoXEsd3dJoQPNZY=;
        b=NZx9pn+imIdWsgmYqXjk3Cg+JOMQf8FjMZ1CQdA2eFH+37ETt2G7N+49W7dao0SNH/
         MbgWzyQGa9vwTQjqrEYlq4PLUuizsXHrecpcRVkYY8PDd/H/l8CBTgevua8yH/A/DTWK
         dDWEr16k2mIiTm7PfGKH0Q673/l5+Z817mggMX+AsG7kaJs1KSTH4UwOTL2qo5xdiQJV
         gwctJyAkQ2rzqbv27XYZVoEz7NFIFplnj8FsBYjLxftEAT38RT/Wzjyf1v3DXOUuetsr
         eWQ5wMnZmDyMND1qCwGBSDK2FlWiYwLHuFxl/ZcEEfDQilu+G0CNaAVIq8MONaC+uPg4
         MP2Q==
X-Forwarded-Encrypted: i=1; AHgh+RraJj1UcdDg/c4WYkxuKJL/SkzY1nCsBllQPbDyzI3oJ4U9LHYPcA0vr9TLLiYXZAyqLB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1kVmR1WRo5a0SnXh2+l/m0jqVG1SlRdGWewcRTIifTbNixZEi
	N4FwAFwvqym+TJlmswjURn0NXh+z+v8apI2cN44KTF/9J5eqJldOZgqFBmDT/0byhkjUY3I7dW4
	0Eb14o7U/n2QBsdm6A8cbuQduceqzZFFzRxQtwSq88u1AtqeDlTtwP9eS1eJUGg==
X-Gm-Gg: AR+sD13xJidaKapp8mbzKPOO1rfHJpWnlOfwynY9VZSxlXm+qKdRZRX8qDuv3c+mUBH
	FbXH4JkAoXEgv2yC5r1FNiSKI7bXvq0EO8xIV83vH7NMM+PYC2H3FfhsM89KnQLyl2QC4RoBHht
	+BONzZsuzgGyaBrEM1ivpaaNdOWYRHIgJBGaQHJ9nIfVca0w0CB0Gb14ZvQbFG+d1LU/LVqGgot
	yYXYQsyh4+Ld6yLb3iXBaOsM7JiSL6dhkeLII/ZdHbbz4rd28lR8IasXuDPmDfOkTHTm/vgyu07
	vKL0vYINhji8o4+DOEgOZZSxPzgoZrQH70PoXzIXvSrtoR704i3ipO8PhWduPnWrbT2VrCZTnj9
	vo82sGWrfkifHTgkbgaT8if4Lxsh+sBtj1qSeloalzHU=
X-Received: by 2002:a05:600c:820a:b0:495:409e:bc80 with SMTP id 5b1f17b1804b1-496c6586d21mr75447675e9.37.1785335702359;
        Wed, 29 Jul 2026 07:35:02 -0700 (PDT)
X-Received: by 2002:a05:600c:820a:b0:495:409e:bc80 with SMTP id 5b1f17b1804b1-496c6586d21mr75447205e9.37.1785335701766;
        Wed, 29 Jul 2026 07:35:01 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c4443396sm176233775e9.0.2026.07.29.07.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:35:01 -0700 (PDT)
Date: Wed, 29 Jul 2026 16:34:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: Weiming Shi <bestswngs@gmail.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: prevent workers from using deleted
 virtqueues
Message-ID: <amoNWGhKa78r3Kzo@sgarzare-redhat>
References: <20260727035804.1860862-1-bestswngs@gmail.com>
 <20260728035823.AFC051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728035823.AFC051F000E9@smtp.kernel.org>

On Tue, Jul 28, 2026 at 03:58:23AM +0000, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
>Pre-existing issues:
>- [High] Incorrect flush_work() ordering in virtio_vsock_remove() allows rx_work to be queued by a delayed send_pkt_work after rx_work has already been flushed, leading to a use-after-free when vsock is destroyed.
>--
>
>--- Patch [1]: [PATCH] vsock/virtio: prevent workers from using deleted virtqueues ---
>commit fac9b600b273994b7593c604a6d3d0352d8dbee3
>Author: Weiming Shi <bestswngs@gmail.com>
>
>vsock/virtio: prevent workers from using deleted virtqueues
>
>The RX, TX and event workers read their virtqueue pointers before taking
>the mutex that protects the queue and its run flag. This patch reads each
>worker's virtqueue under its mutex after confirming the queue is running,
>preventing use-after-free of deleted virtqueues.
>
>Cc: stable@vger.kernel.org
>
>> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>> index 57f2d6ec3ffc6..79cf19f589439 100644
>> --- a/net/vmw_vsock/virtio_transport.c
>> +++ b/net/vmw_vsock/virtio_transport.c
>[ ... ]
>> @@ -689,7 +690,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
>>  	} while (!virtqueue_enable_cb(vq));
>>
>>  out:
>> -	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
>> +	if (vsock->rx_run &&
>> +	    vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
>>  		virtio_vsock_rx_fill(vsock);
>>  	mutex_unlock(&vsock->rx_lock);
>>  }
>
>[Severity: High]
>This is a pre-existing issue, but is there a use-after-free risk in
>virtio_vsock_remove() due to the flush_work() ordering?
>
>In virtio_vsock_remove(), the flush sequence drains rx_work before
>send_pkt_work:
>
>    flush_work(&vsock->rx_work);
>    flush_work(&vsock->tx_work);
>    flush_work(&vsock->event_work);
>    flush_work(&vsock->send_pkt_work);
>    ...
>    kfree(vsock);
>
>Meanwhile, virtio_transport_send_pkt_work() can queue rx_work outside
>the tx_lock:
>
>out:
>    mutex_unlock(&vsock->tx_lock);
>
>    if (restart_rx)
>        queue_work(virtio_vsock_workqueue, &vsock->rx_work);
>
>If virtio_vsock_remove() flushes rx_work (which returns immediately if it
>has not been queued yet), and then blocks waiting on send_pkt_work to finish,
>could send_pkt_work queue rx_work just before completing?
>
>This would leave rx_work pending in the workqueue after virtio_vsock_remove()
>frees the vsock object, leading to memory corruption when the work executes.

This seems a real issue, would you like to fix it?
In a separate patch, since it's pre-existing.

Thanks,
Stefano

>
>-- 
>Sashiko AI review · https://sashiko.dev/#/patchset/20260727035804.1860862-1-bestswngs@gmail.com?part=1
>

