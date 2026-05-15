Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334AD3F0ABC
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837623; cv=none; b=Beh4jnqXsAyhMliuoQcjWnAlUQJeQ0gDEDEbtQUxW/1eovIudvpQrsC0L4T0eB4AeRUaE1iEsRSWeVhgQWgNHdAPhvfH36ifpfPM/4t+9aOFFWWxCS8JQ2Et4vqlmaXtiYenAR5nhaEsuPqR2u/02IsZbuGWyeGfE5ZCDp4zDG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837623; c=relaxed/simple;
	bh=HzcXf6Wv0llfWEbLwfcl50s7dD+w0VdR0+2YgR8e0cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVxgaBACan/P7rwb9tOM1SPJdCvtfJ9cwF+6EkG6ej8bxKQu9rEj9Y21wLXHwa9VfFV/S8650OuJwFJXsZN9FXri0buXfDj6nqXSqmdTz714rlopCO3nCVXYJ+eXLpW15WhQo9agLDoI9cKtGdBS012SX3vJnQmDnaFjJxhL5DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9eLH8OM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICnBetIE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9eLH8OM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICnBetIE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778837620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZ42ILoPPEodEg6ZEuswA8B5A9RnneHFtROSVsVKJFY=;
	b=O9eLH8OMtPd06H9dH+j67sCh92vV5/u0vVyi7EOsjRZaHKub7AWF/XCb7VZirBdFsblIUX
	uiFH3KiWa1GxD/B3Mlrgi6WeFe6YgrAJ9yaLjEqQbBLeRfBiDhgKnHSTxudMz8N2QQXguk
	dNcdUpOLg0S1MQfdNW4MB+0ZT36XPbk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-u6IJqh9hOya0yFTi4ftU7w-1; Fri, 15 May 2026 05:33:38 -0400
X-MC-Unique: u6IJqh9hOya0yFTi4ftU7w-1
X-Mimecast-MFC-AGG-ID: u6IJqh9hOya0yFTi4ftU7w_1778837617
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44bf1ac8893so7728728f8f.0
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 02:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778837617; x=1779442417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ42ILoPPEodEg6ZEuswA8B5A9RnneHFtROSVsVKJFY=;
        b=ICnBetIEcsdH3ztEsUar6b0l4Qf/HCIccRrik2R+qjZtiKe7sQUo/l1/HzqtprsPFp
         AEZ7CoZD7mxKrk4mHHN4xux5MOecNMn8wkZkB+IkCozFohG1QytK6zfq6/SNNr0UlZYQ
         Pa1vG2GBmhX/yIuWVdOlWljJjAMD3W1xJGoScq6yaBCPthOjDC/3ZI5nIjMM79d7PeuS
         XugF5T912i/caFWq3PfHNzoJNs6bLhAR8syRHJ1iKYESMDaKHBreg+OdcFtO8UwxMxmM
         aMrzCZt7X7xcEooWSqyKeLyGJEkozi8fsR+F5AbtLPQM0x91V6W2eyIcYihoktRUnYog
         PBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778837617; x=1779442417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZ42ILoPPEodEg6ZEuswA8B5A9RnneHFtROSVsVKJFY=;
        b=OWjHO1aOrrZ3fzGkimHoacrRFwuG9R17kuTG0JCf7vIbB26mxgkOVlgQ3tPDJ6DcWy
         prB0KPl3i/SRbdPyBu2SoF6zQJx0+phQHOw7aygfvtnL/C3NAdJoKpyZ897ikc4h9zRG
         mxBQ2NYXvnXgUIEgSX77XaJ5t+zYUWpT53n7HylHugcMcLIEFUCaXNlszoo/05DRe3Ie
         IK7oy8I/TPtVtHMnXL9FHtMnKHbFVgAQicjWIHGCExlQKzBZE4QxN5StC7T5UkXos8mO
         zr9LxEdwg7uXRJjrfAQK3zHwdqQuloy5UdkaDjOI0DBHVpPDbDlFI3gJaq2kkAnf+iEW
         /UAA==
X-Forwarded-Encrypted: i=1; AFNElJ9EUD3glUEDYZoMK2V2waYK7ZzvvYfy+uoAHnmuYuFh/ZYMnNZpdPn1vdAvQq8xsXYfnt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsbZ3gGSg/r8WatIKBrQ5RGcb3Fg4DHlMLYRq+hlv/KRvbrNkI
	DVOUVIZZdMyQueaOKGmzisJsUGxkPdw3D/mUI37+b3Bx93nXdd2CVLVGkeO/eGpOYT57Swj1i64
	KB8yALxZKm34FeYhgjETelFtRBvQpDB8fSjxx30GGcyuYlVajZYDIdw==
X-Gm-Gg: Acq92OGyJIHadLxreMPEQ/ZfQ7HmZMxY210Tb2lNf3EBRAnuwhxpmI8itC4uxFQWsBk
	orjm/ipj0LPZyhe6a72JQetoOv95vMdbUSYTRQAC2C4/1azoLraIPNXTQ0ur4xcMqAVq3yOOIIe
	GsZjaPSZCLLWTOkgRxc3lVgOzAxu88u7mBj4um+Ca5vqXfZCpG9S9xdTo1wd+rBlq2XJw0WwYrq
	XKhtkhRWdE4LvxUByQ28xxrxhNZDx7ZGmWPdY7BOmdKGN2JTFlJ94uDGJxU4O9PmrAmWFrDz/kD
	YkH6NigNQcnR9DS5CZcD+3KPhymqC8jnd2+pfbrsXmqfdg51jV+aI3/u9IJFWqMXP8K5ksf9gCS
	q7gqhXpH7JHeYyg7pa0zvGRNbaXDqRCdxbsCBPbQmFePJdCcJJpEO2fSQ7dtmO2DdEGOCeWIXMQ
	==
X-Received: by 2002:a05:6000:2288:b0:45d:4532:5d98 with SMTP id ffacd0b85a97d-45e5c57d2f2mr3913459f8f.8.1778837616863;
        Fri, 15 May 2026 02:33:36 -0700 (PDT)
X-Received: by 2002:a05:6000:2288:b0:45d:4532:5d98 with SMTP id ffacd0b85a97d-45e5c57d2f2mr3913404f8f.8.1778837616358;
        Fri, 15 May 2026 02:33:36 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768bcesm14392867f8f.4.2026.05.15.02.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:33:35 -0700 (PDT)
Date: Fri, 15 May 2026 11:33:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Polina Vishneva <polina.vishneva@virtuozzo.com>, mst@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Denis V . Lunev" <den@openvz.org>
Subject: Re: [PATCH v2] vhost/vsock: Refuse the connection immediately when
 guest isn't ready
Message-ID: <agbn_R2XtH8K7aH1@sgarzare-redhat>
References: <20260513145842.809404-1-polina.vishneva@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260513145842.809404-1-polina.vishneva@virtuozzo.com>

On Wed, May 13, 2026 at 04:50:04PM +0200, Polina Vishneva wrote:
>From: "Denis V. Lunev" <den@openvz.org>
>
>When the host initiates an AF_VSOCK connect() to a guest that has not
>yet loaded the virtio-vsock transport (i.e. still booting), the caller
>blocks for VSOCK_DEFAULT_CONNECT_TIMEOUT.
>
>A caller that wants to know if the guest is up yet instead of waiting
>could theoretically tune SO_VM_SOCKETS_CONNECT_TIMEOUT, but it's tricky
>to find the right timeout, if not impossible: there's no way to
>distinguish "guest won't reply because it's not up yet" vs "guest is up
>and tried to reply, but was too slow".
>
>Furthermore, this delay is pointless:
>- If the guest doesn't initialize within this timeout, connect()
>  returns ETIMEDOUT.
>- If the guest **does** initialize, it'll reply with RST immediately,
>  because there won't be a listener on the port yet; connect() returns
>  ECONNRESET.
>
>That's also inconsistent with the behavior at other initialization
>stages: if a connection is attempted when the guest driver is already
>loaded, but nothing is listening yet, we return ECONNRESET immediately
>without waiting.
>
>Fix this by checking the RX virtqueue backend in
>vhost_transport_send_pkt() before queuing. If it's NULL, return
>-EHOSTUNREACH immediately.
>
>Callers that used to get ETIMEDOUT will now usually get EHOSTUNREACH.
>
>Signed-off-by: Denis V. Lunev <den@openvz.org>
>Co-developed-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>---
>v2:
>- ECONNREFUSED -> EHOSTUNREACH.
>- Use vhost_transport_do_send_pkt() instead of raw .private_data access.
>- Removed READ_ONCE().
>- Wrapped the condition with unlikely().
>- Updated the comment and the commit message.
>
>v1: https://lore.kernel.org/netdev/20260511145610.413210-1-polina.vishneva@virtuozzo.com
>
> drivers/vhost/vsock.c | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

@Michael I think this can go with your tree, right?

(I don't see it in https://patchwork.kernel.org/project/netdevbpf/list/)

Thanks,
Stefano

