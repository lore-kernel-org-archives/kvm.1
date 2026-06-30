Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253C53FA5D8
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823557; cv=none; b=MDm5vMsD7yvgjwSyv4Ff5lxIpl6q1aMTBgc76RO+mR7lHyDrvONiR+kmvNYU62d2SVSZ26RGZdpsERrzUVLg0bYPynXT8F3J+LTiV9m8/AcPp2EZE6loa8WiMa0NPTsXPIYG5dAlSsHZum1Dvw20ORzhoxDJJiarnq3BaIY27UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823557; c=relaxed/simple;
	bh=rnqTc9VcuxQmrucqXv/X4rxwWBjO4aintFdu4oYQwos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4Qje/I9OGhdUeL7qf0+GBzqwmjV0gwPnc056g8CFJpT+r6uHImaDCtK6FIF4Dxq/YS12M37WQBTjnPPECwfNMlAHh3sg75VTdpOfPOww5bRnyFaYxooxgisHhSYElzYZ75iOmHaZSz9B+KoKgVUgaKkOtYu2qiMIhe1WjuTdfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaPIdxH6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GjgA53JE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaPIdxH6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjgA53JE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782823555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9xE5wahl+eqalpRYfV0fnyzHdxALUWLBp0RetJPvoas=;
	b=JaPIdxH62TmbcFmcKDr3zI6riSzqBULhGp0rvTKjXe09gTN/fODNhzN+2pEZAVz+b9eniz
	REPoi1CaM5jW6e+NS8aTegZDLpUU1rTZXMnyQWa1cKt8lBmI4/Pn9xqByb2P11RP0jiV0N
	JekKZ6EfeSuawTqDHmxxMqvvJa1iCmQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-37bBlfX4PDaKWFGdEUXoKw-1; Tue, 30 Jun 2026 08:45:53 -0400
X-MC-Unique: 37bBlfX4PDaKWFGdEUXoKw-1
X-Mimecast-MFC-AGG-ID: 37bBlfX4PDaKWFGdEUXoKw_1782823553
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4924583c7baso50113815e9.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782823552; x=1783428352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9xE5wahl+eqalpRYfV0fnyzHdxALUWLBp0RetJPvoas=;
        b=GjgA53JEaOxRxXvEbWfsLIh911fN+VQiRIkSEYvjTE2X8Vj8w2T58/KUOigDNP3oV3
         1epjt84uggneblWryK+nNIagp+6pxuEjBRW9oqIJq9cZEmDozsvBT1g/m2iyc8tKuD3w
         m4lZ3QSK26RiNmXNjZhAFnPMarYsG1NzDG/vCfs9z8Q8Kkntbb5/TI3JJM08/mR8WCCB
         K8YIaaa7JYmLV62Ptqtdd5DtiZM1Rciu9A5C0JrxvsUTlJ7nzjPUuvkZJwinulqBkfAC
         bQ/pFvV25CNriBBN0xtBwmYlkWxUyrmg15OXoYDUnFymWhyM/J5JeKTT0RpTsQafJhss
         F9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823552; x=1783428352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xE5wahl+eqalpRYfV0fnyzHdxALUWLBp0RetJPvoas=;
        b=AxQKmdVSjCGN7iTPVdOd9b5FqcS+sgEAnuGYxV26n4+foHx1wF1151rcUdn9BX3N/Y
         JuHpKxSDonyTWTE/HkTBY6oYP8hH8KswQa0G5+tiUnPpe0eyMIvfhpq/LWM8vndpKE31
         z06Jp+0aaGCpfDKcMYx7OfMUUSgQNa0rQWn4V7/pYl0bLw4Ji1b8kDqR5qwiphhw2DDy
         Kkhf0ZV6hwmL59xkQy5smsoUrjflytKGmMCLbBrvi0A51Mvs3zlfbuTeN2HqbzcW566u
         AyIOZwsmpWxorR19xWDbrISjjyGldbfn+a9LtYx3BzjYjvsTeOafLX4enfWel55jpOVt
         vMEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/9hzM2BidyvZ1BTTMeF8edfDfr4ND1W2LKQxCevjGGotWQGaiuWSYWhr2IhoKaUqKOetU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAWuuEvv9Qd1O8e0aJhUHn6cbLmbR4PI2wRW2JJA8tXrMP3VwT
	pBOocvbrJ/EY+d9mju8ZruuLJXuSJnfKXJhV1KoM6lxWYVb3JVU4eEw/BKAF9WxTaOxVuKDHxT2
	sb006NMLaKG+mYQ9CbEwcAacmHSePXrzBSUgKshd71WudjKkO6Lr1Sg==
X-Gm-Gg: AfdE7clE/NlHH58C2FfzUs+Vpk5PdP6wBEBhBByXd+zFM2r/KsM+v46VKaNOIikPy/6
	LtpHKl6+NGhm78lnnK7R8JzdohmLv651KiUrJ1g0mQmRFEweef6fDD7UEEIJiTbnOtOTV73h9XN
	HqeRmqnuvbQnMsg7b+a79gTrgrmrB8jAq8NqMQsM7MdN+vacy7UG5m39zl4yovWPdYyurr7X9zn
	Ae74tC/SvkPAmjxJfRgeQcs+HMTz063uVZIoTUzxGodWqOrQJAjquPfgx0z3QsOT6glHzrA37Yb
	U/KutaA+LHLbWzLDObk6ml67o/lAy4S/gg3kg0I4E3FPYEWx0f3cKtZsy8kFFgnx44Q5n42cfto
	E+gQJEsoGHkWEYgYt8Vqk9inpOAoaGbiHfx3/mASZ0NHjo+batjsBB1I2Wenx
X-Received: by 2002:a05:600c:a086:b0:490:b0e0:3de2 with SMTP id 5b1f17b1804b1-493bda874famr6557605e9.33.1782823552456;
        Tue, 30 Jun 2026 05:45:52 -0700 (PDT)
X-Received: by 2002:a05:600c:a086:b0:490:b0e0:3de2 with SMTP id 5b1f17b1804b1-493bda874famr6556975e9.33.1782823551880;
        Tue, 30 Jun 2026 05:45:51 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bb1bf712sm30233055e9.2.2026.06.30.05.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 05:45:51 -0700 (PDT)
Date: Tue, 30 Jun 2026 14:45:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com, 
	mark.kanda@oracle.com, ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH v3 3/4] vhost/vsock: re-scan TX virtqueue on device start
Message-ID: <akO5DNoEsjukV5az@sgarzare-redhat>
References: <20260625155416.480669-1-andrey.drobyshev@virtuozzo.com>
 <20260625155416.480669-4-andrey.drobyshev@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260625155416.480669-4-andrey.drobyshev@virtuozzo.com>

On Thu, Jun 25, 2026 at 06:54:15PM +0300, Andrey Drobyshev wrote:
>During QEMU CPR live-update (and VHOST_RESET_OWNER in general) the guest
>keeps running while the host drops and later re-attaches vhost backends.
>If the guest adds a buffer to the TX virtqueue (guest->host) and kicks
>while the backend is temporarily NULL (between vhost_vsock_drop_backends()
>and the next vhost_vsock_start()), then the kick is delivered to the
>vhost worker, handle_tx_kick() sees a NULL backend and returns, and the
>kick signal is consumed.  The buffer is then left in the ring.
>
>Then upon device start vhost_vsock_start() only re-kicks the RX send
>worker, never the TX VQ, so the buffer is processed only if the guest
>happens to kick again.  But if the guest itself is now waiting for data
>from the host, it will never kick TX VQ again, and we end up in a
>deadlock.
>
>The issue itself is pre-existing, but it only manifests during a brief

Why "brief"? I mean, there's no limit, and the user process could stay
there forever, right?

>pause caused by VHOST_RESET_OWNER.  Namely, the deadlock is reproduced

Again, please make it clear that VHOST_RESET_OWNER support will come
later, so this is in prepartion for it.

>during active host->guest socat data transfer under multiple consecutive
>CPR live-update's.
>
>To fix this, in vhost_vsock_start(), after kicking the RX send worker, also
>queue the TX vq poll so any buffers the guest enqueued while we were paused
>get scanned.
>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>---
> drivers/vhost/vsock.c | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index bec6bcfd885f..81d4f7209719 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -646,6 +646,13 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
> 	 */
> 	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
>
>+	/*
>+	 * Some packets might've also been queued in TX VQ.  That is the case
>+	 * during the brief device pause caused by VHOST_RESET_OWNER.  Re-scan

Ditto about "brief", I don't think is adding anything.

BTW the code LGTM.

Thanks,
Stefano

>+	 * the TX VQ here, mirroring the RX send-worker kick above.
>+	 */
>+	vhost_poll_queue(&vsock->vqs[VSOCK_VQ_TX].poll);
>+
> 	mutex_unlock(&vsock->dev.mutex);
> 	return 0;
>
>-- 
>2.47.1
>

