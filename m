Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832553AC0E9
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579060; cv=none; b=lr4uzirSe8sxWWy5oFxCeG7VZfxSIBWwLsAicTLuiE+aqfFA1lpUGO+5jyHadegx2A3W+/MtkxkC8GE1ZwWGBbc5a6xhX0CB/BFXyfM7d2zBm0XYItlS2qpd6t1FN3FH441VRrai3tR1tTrYoFAeHJOlFuQjjrpj41CV82hPhwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579060; c=relaxed/simple;
	bh=s+B0zQq1Nw9f5HnC7IN8XejNsibwFPs8kWwZliQ5+0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bixG7V0GlFKiFvkcT1MplLkyRAzIHpi9zSN7SRNC+jUAF1wzpWGM+KdiOdBVNhO95Zrx4gDgE5E/uhyHF/6BVU/Zv3S/ic1pokw4lpcqCMwabsvJIEZiO0sr1wEKlEnTygGfr12z4N+erJZzHelxRnReNaQrJPu2/flcW/tXRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYdFIy24; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0dOqWa6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYdFIy24";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0dOqWa6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775579058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s+B0zQq1Nw9f5HnC7IN8XejNsibwFPs8kWwZliQ5+0Q=;
	b=eYdFIy24/D3FtkWPAceEji9riLNJgNtUqhVHpdE/4E4MCWlW8cfWLQG86/k93SeD9VTjSq
	qoRTuO1Rbu0Dr4ZA7yY8f70IixtTeJ0lNVBWgJjrecM9RiES2pHJHmlDpKj+IlTSZli8iP
	t0/axC7lyp+ilOvKxQufzSNKdQ9NKz8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-ViAqDYCrNE238_QTbfFGfw-1; Tue, 07 Apr 2026 12:24:16 -0400
X-MC-Unique: ViAqDYCrNE238_QTbfFGfw-1
X-Mimecast-MFC-AGG-ID: ViAqDYCrNE238_QTbfFGfw_1775579055
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488a8738d96so12113845e9.2
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 09:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775579054; x=1776183854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s+B0zQq1Nw9f5HnC7IN8XejNsibwFPs8kWwZliQ5+0Q=;
        b=F0dOqWa68hvq1b6GqGUJspT/UnsoKX2qPPWMDnrnlgDu5G0klSecMReVPwXzUKOPlh
         dB2Zdg0wkFXPXnLUTxxNleX5afsLmfgxBHOvvzEEIaOAhJYfDY5zbgkUyoWy2sqD7b0M
         DMXegUSEM6tWtQiUe4EMmww68irm3gy8TRrTXgFLwNkeaW/9idBSEtHOQW6Ou5oosG9x
         rJcApJH3OiEjaSb8MfPREadtKNNOpnTLYTrX6qXuvKJF1cCj4VB2wOU9zlcc0rs7o+qe
         48DwO1fgjw26eqvN3Nvs4D/5OYFCWBvlvZnf7SRSvqrGQaCKSZQr5tImRegA6gE+YN2H
         3Tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775579054; x=1776183854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+B0zQq1Nw9f5HnC7IN8XejNsibwFPs8kWwZliQ5+0Q=;
        b=YE1IbpZ6zMwVZnL1vMse00GpHo5n9DGWUHabzAmLY5rCHZPbZp0XSM/nvuX7Ha/vsj
         RR1r9HsjlpvX8t23DPEpfMshOmRKDMHpJNo+qVwfrN7wfJngIjit4bv0XKywrJpvkEPw
         tH0A0jj1UFcLJ3P9PAe9iePtl+KTFDM8x7H4KCQ/fm0WzYERZdiiD0EQSm994u/+9nvA
         3Irzt2+JexnwYmGviDVTCrAuPyMN+GZMQ/RSOdgVvNfsqbpknBb8kkYpECjJpnKh+rIZ
         c25EPJh6b6k3XVitZjhEkOaDdvPEF3U1UHkmJPZfKbeHUqAfMKIiB+EcY2z81t5r/lqk
         pYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2ELJ3axO+F3LsmaiOXvPEHVdOKWpZ0OuXixxjkz5Cuhs8iDsHHxcaIn20i50Ou8es5dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOSzj26I/A3J8IOkBKVYzO9uSWTKVyeT/5b9xgfkFe7vs+VwRP
	lyab8oDHOWs2ywXPDxVUdw1ZuvgnUM+jbJinjiMgWMK+L44OUIUvuDFdFUag5a91r7uSj+k9ACM
	g3N9ZSIxCcKSpl7cBvJlTAib2PeTxLPB5rOSh6Wp3iGWbCMkqU3k17RlEPRCHpw==
X-Gm-Gg: AeBDietKUNn0M0HDZQ7Ix5DjBskSTuDNOzC9aNgU6wEJtqZdQV4VQXDMVzD7cDRrK2z
	1tdaaxLcr0UvIGalM1J4nCiZVcO6rU/4DZVUaxkdVzfAkcdtug/vyAAj9pQEOVyE8NLzK/os0BQ
	DFYGgOFqCA32+O+7Xxbrw/2y2aJuLUtyessxJ560syFVlWhb86upTm9mg7nfnKwDVVcciXye4Ki
	fomFfMp4hPV3DJ3Mscm9XCEzhlWJBgjJZn2/dmykoxs6nf0Zy92IMVUlq77qMLlQSp1k6cBzJ5j
	oPCtNLqaJs/2wzw80E+5UtzviQwRPi2nHqU7eBU+k5tGvhMvHtZO9GfvpwEwlAfxSqye0E9PIFq
	cJRN6bBqf+hoq906hC0JT9C7EDQU=
X-Received: by 2002:a05:600c:1e1c:b0:487:1fc:14f9 with SMTP id 5b1f17b1804b1-4889978da83mr251016185e9.15.1775579054549;
        Tue, 07 Apr 2026 09:24:14 -0700 (PDT)
X-Received: by 2002:a05:600c:1e1c:b0:487:1fc:14f9 with SMTP id 5b1f17b1804b1-4889978da83mr251015655e9.15.1775579054035;
        Tue, 07 Apr 2026 09:24:14 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a616sm1043018385e9.2.2026.04.07.09.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:24:13 -0700 (PDT)
Date: Tue, 7 Apr 2026 18:24:09 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Message-ID: <adUvaIOLFcmC7tgt@leonardi-redhat>
References: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
 <a236c546-3a0f-4690-8ff7-ff8934db0539@salutedevices.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a236c546-3a0f-4690-8ff7-ff8934db0539@salutedevices.com>

On Tue, Apr 07, 2026 at 07:16:24PM +0300, Arseniy Krasnov wrote:
>
>
>07.04.2026 17:31, Luigi Leonardi wrote:
>
>> `virtio_transport_send_pkt_info` gets all the transport information
>> from the parameter `t_ops`. There is no need to call
>> `virtio_transport_get_ops()`.
>
>Hm, one more suggestion, but not in this patch: may be we can also remove 'struct vsock_sock *vsk' argument
>from 'virtio_transport_send_pkt_info()', because it is also included in 'virtio_vsock_pkt_info *info' ?
>

Yep, good catch!

Thanks,
Luigi

