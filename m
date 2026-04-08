Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A2B25CC79
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662282; cv=none; b=APol40ktcb4gIP7ZAnMSeKVxugrBY0cNMi+QJOXsKjIc7qnSzb2E/aFz975/N/0F6gq8u//cFLu/sUfLOUoAFTKSNxnC6BvCBDpb/IHL28WsXR5Qw+sS/YwGm25s9O1PrTQhLYFy/g2Teph17l3IHIBYrvfXxSxIXXMmyhvhIYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662282; c=relaxed/simple;
	bh=QMz7w9UlDj+LjzgtxcZGpJSP55mlyq1h/m3lZi4NBQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ml3DZvlmKWObDZPBlKULPLn5vht2RLyBw3Wyys7vKkCId/0KfvJqEnJMzMYpsbkALpQkTkTMb37oMxo2xMVWSVYAMYvVjklcjmz+dDsugFz/aSqFqNBc3uAo9A9c9Lu59mFbHaOIHM5cPtN0xrUfzT4f66r5Zd0zpGGrI6XOYFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdeccWlF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzecFXX8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdeccWlF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzecFXX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QMz7w9UlDj+LjzgtxcZGpJSP55mlyq1h/m3lZi4NBQM=;
	b=ZdeccWlFOYPzlgysN8/yHc0mUjgWZ2JCB44fmyRHH+K1n8trkzi0uPjhdPVv2aW+U1vfK8
	jfdtg3dUM3oq0CuNN3iSFWsUGHw6OEXDabWfaft4LIetXcEJSA9EtFCwz91J0wwLzf/0vw
	rV9ar+jJwr7ntRtSvhZ/y25dRherb94=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-bQGMfjp8N6W4Pb6pWdAitw-1; Wed, 08 Apr 2026 11:31:19 -0400
X-MC-Unique: bQGMfjp8N6W4Pb6pWdAitw-1
X-Mimecast-MFC-AGG-ID: bQGMfjp8N6W4Pb6pWdAitw_1775662278
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7aa1e8734d4so2273997b3.0
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 08:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775662278; x=1776267078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QMz7w9UlDj+LjzgtxcZGpJSP55mlyq1h/m3lZi4NBQM=;
        b=fzecFXX8y2zXugQR58HXuLHk7rt8X5YIO5l1AC2T2PpWhAcVKohNVX9/BqC4jZpGee
         qV7EIBJVbxzKRVN7HvEdG9UQWTOGqRIx6K5CPwBMTF3OyM1gqtiSCanusZW/Td458Pzd
         KTG2EYfXrsz0qfxXpldFRv1rhFLbk9oxkzYKkuyZuydfHe0OOZ41Vj5/HvbH9bU2fi8D
         XiCaFk4TorO8+U7lhSP71dMkDCO8VfRgTw31ZqvF3GxC6yZGP/1LyFRCdz7EC0I8mNvO
         JWNVPLuAmfTNumklVqbxzCoR+02yOG+Ag5dJgPpEzT2CgzeIoaZnSMmHp2XAmwhcDTeB
         RzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775662278; x=1776267078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMz7w9UlDj+LjzgtxcZGpJSP55mlyq1h/m3lZi4NBQM=;
        b=DgFsHm/CMoQJbwJoaWjY0jWD7VIZgxo3JLp+0fU8xjKYjumwfn3VGcu0LHwVon1IuO
         bDoEl+l9kfJODRp5oyvCbYpt4QPl6hWYDrR758yueZMKrU/EsT3C17QLFy00rZmuhpK2
         5/pF+prWxijhXn2zIzyelLh7820U86XZI60UKwyjPUQf39ECDWS/UM25hfgtJ27d33bs
         MChoYISOcpGGYhjV0hngP6Ao8pIZyYDzS4pKO97GwB5br5djZ+QfCPMh/RtyyHANsnhX
         WcfHzYemBwXCytbPdCKAnLsaBqBDrSjnKD/X+lCyzuTg11+LcbPy9MJOBeLuUPSf6IAF
         OOYw==
X-Forwarded-Encrypted: i=1; AJvYcCVJzGOcdC4pve4zK3QpbSoPVegracoCd1RQws/fTK8hUJ2Ry0vI62PyLIjy1M1hGEeQtxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyNj0n4B6NrM3zJLjFQFkRWL81i6uOFjsP5WpkYLaMIZlQIlD/
	rXPAVNaWxiW0Uku6nNPZAWVgABlxRurSLlM2V8+Z+Ufcr+sdIwUzvuBl41+5ytbJMsg+IalvZtv
	CtGWLMtQ0kdfCIJxh63SkVxFclxWpWuvf7jR1Y+SH1pVILyMhPuH60g==
X-Gm-Gg: AeBDiesc73Upl3tS2LRPkCAt9B8gJGb+hHWj/TkviIyruxNxA7ROLlfJ7BxhlenhrUG
	HFo9yRKWd/0Rsr1dL12B93X0tayBlep82YqvDwuIJHaNAlTSmjz9E+HKMoX30HPsjZGGziAcWNQ
	g5V2j1vxY5rWlF05jSdkPcQ6ZbZoa6a3OAwIBFvBX6X3Y4Ejt2/Ky9clwqgg+e6dRaVNNSbTY0g
	jS341YdHsKI7yb+Sw2crO7BZrfiSC4DLhm3modYURJ4SpLBHM7gW277F5exxpjWP6sHNmVRiYSt
	KgLlAlCxn15NOhgcKhCNrbxT56nVP6UKEjB13kBIYOPkTypv2bEuIF9zZIpE9lfNSUl0CyvkYyY
	24BuFZl3nfv+8XWvBqlDLc+4zIHdgbaSQqcoknaUHrP02ce7aPlXNw9VS3To+VSRrAQE/bReaXw
	==
X-Received: by 2002:a05:690c:338f:b0:79a:b0c8:da98 with SMTP id 00721157ae682-7a4d32e4846mr194747427b3.8.1775662278392;
        Wed, 08 Apr 2026 08:31:18 -0700 (PDT)
X-Received: by 2002:a05:690c:338f:b0:79a:b0c8:da98 with SMTP id 00721157ae682-7a4d32e4846mr194746647b3.8.1775662277684;
        Wed, 08 Apr 2026 08:31:17 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac4c10cb96sm49299076d6.39.2026.04.08.08.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:31:16 -0700 (PDT)
Date: Wed, 8 Apr 2026 17:31:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Message-ID: <adZ0pWsWQcbTAPEw@sgarzare-redhat>
References: <20260408-remove_parameter-v2-1-e00f31cf7a17@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260408-remove_parameter-v2-1-e00f31cf7a17@redhat.com>

On Wed, Apr 08, 2026 at 05:21:02PM +0200, Luigi Leonardi wrote:
>`virtio_transport_send_pkt_info` gets all the transport information
>from the parameter `t_ops`. There is no need to call
>`virtio_transport_get_ops()`.
>
>Remove it.
>
>Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>Changes in v2:
>- Removed Fixes tag.
>- Picked up RoBs
>- Rebased to latest net-next
>- Link to v1: https://lore.kernel.org/r/20260407-remove_parameter-v1-1-e9729360a2be@redhat.com
>---
> net/vmw_vsock/virtio_transport_common.c | 2 --
> 1 file changed, 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

