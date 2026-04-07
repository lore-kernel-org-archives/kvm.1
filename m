Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CA639479B
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578599; cv=none; b=Ke2ZEfu78AQWT73P8kBx/IjR4d1xhJMNUDMygt4Tx160DOe5XrNWIaNwox+c+TlotOUTd8Z4U6rydI55qb7Qns4edBVzurPzI0IMMKQXUeth/bLbDg+cA9npAzlWt7xPx3UrTnHt1yoI0r8Zfi5H8AvCvZ5ZuEqFAWghXlrmM70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578599; c=relaxed/simple;
	bh=L+U1IJoCmuLYVZDQUIYQpJvdtwxVa0fGgDt4MVAjdeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9uM6jFLtqmYPJToX6eeeg66VD4KrdjcZ27dGdnKNZ9GBfQm/sXoTeWNkOuNoYbnx0xQhzuivcMLy/tCfVVJLq3xZcF7mP2fQBy64GDDxIqBNoZuMH+x3Bj2u62rJgPSDpS6rMz2RDCvkEnCftffvGMo35YIFxdhkmbC+wJiVyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhezOtSr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gifZbrMU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhezOtSr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gifZbrMU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775578596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAYf1W4xKvTyUMVZp1+fGH+3Vreaw6Q1Qt75LyHMYiA=;
	b=RhezOtSrJiybNxx4u4uuyfmL9nEA0PCdtT/SwUjWlI53of9Dj3c3anoO+xarQnR9aA07Yx
	QhPRJO3iXGfPl6gb5+z384jNkcIrbECtEkrEmbi8qJp6E1tnnxAC+OpS6n1tWWGIIeh/rn
	9iaKvagf+0qYIRoatuGW9stBPkM9Hms=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-hvIn0VZANAy0h8bKwbz0tg-1; Tue, 07 Apr 2026 12:16:35 -0400
X-MC-Unique: hvIn0VZANAy0h8bKwbz0tg-1
X-Mimecast-MFC-AGG-ID: hvIn0VZANAy0h8bKwbz0tg_1775578595
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b4987c698so1518651cf.0
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 09:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775578594; x=1776183394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qAYf1W4xKvTyUMVZp1+fGH+3Vreaw6Q1Qt75LyHMYiA=;
        b=gifZbrMUU76ialZ7ebAWbbWP4+NZEvSG8VkbyDZMwRIRDTepZmnJ+Vfgnc5cnN2VtZ
         pFpjlAfyQfvgGizhnskoSw3Nhu/SEazYamNvVxY3ktl6aauyX0GpxcxYmLXXh6HqUrEp
         Xvk+7PwjWBv9wkaPpRm+H6xE2DW3ZaguGglkKwrHdEi6xBhBEVgq1nC49tamNcH9LTao
         n9Gv/xhuQjnJdt+3sFkd2Ru8JAz2Fzgq/xPJwjSQwlerjgH2Jj2ENuC6m6A7aK6fpvNR
         GqUZw4LcH6lxpqTx3TpRBWsObRmcaugAijXw4ZRfiXw3sm8hXN5WRk2lE8bc17u4OVH0
         t2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578594; x=1776183394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAYf1W4xKvTyUMVZp1+fGH+3Vreaw6Q1Qt75LyHMYiA=;
        b=QU8P3nvSUbDdTsGKceyLqruCvQtD4K+LpWxJysHVIIBWxcto+uq5Z5vTSI9+FB6wiM
         0HeCsmiPhbaYRs+Xjmpcxm9LfrD+fF9edL0lLpic96jC2STZE8kk0EW0A0zpH0ugxnUY
         LsfiFHnzY+imOFHM/XTEYnDeuutxubFxS8JM8HDpbtLWaopru3SGaBrEvSxCeC2sA9LJ
         1Bu3DUPbWozJLQMsiOqSyMsNhBkaCZpLvEMrCCp719kZY83J1jQHYuPE4xS8P+1o5CQ/
         gdr2zPx9xiU86ycMu6TsS2TsgS9W5obXvkAj2+y4lIy/76tO6W1ABGT77wa9CdZ4p4ZP
         Qp0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWO8R3T8e2bw4S/NVCTCfR7VOkgQXJptwElNIRCV0vb1WQp7+2fwV7KsNDY3mHb3KBBi9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ3OLiqg2xlnj+mVtf9p7/Wbfa93ydQuLGulEjk/yTJGvskM/Y
	hkU+r024KfXMPZpWCex01cUfNS+WTgvHSGovzWWp+RWwlrTY3cLuX1QsC+RcolefPh+NgnyoDi1
	JQgH/SP6QuAEGR6sKYI7QzVoQ7S2I0asv7sy2SCXsH5XNrvp+XeoN9A==
X-Gm-Gg: AeBDiev5eJKyLktT8fuFbzu8r6LDjMFBo0WFwRk5OFKxS5O2oLguBGTkPDmZn6rLpAs
	u3foeXYsZgYzGDX0sNUOwWQHFDdqOCNr4syP+wrb522sffJiPVz4eyR5QVrYX9jEmkxeNNq+2s2
	3D8RycolxKtOfYgSeEgwZ/v1td0TYKzynCHPdaO+AM71JpvTJte2rwxNRanaJ0QEVZndgo8HBsN
	lcj+UH11aNZ/z7J2eFtjZiRN1jU9Ocy51eBo0WFx3qVL1QglRrcS5jKG77TnQowUyCbMh7TIonw
	BbqSJJ5XNL+j2uLmneudEWPG9PBMEwGaaeE8CvfKr7vxnn2KO1VXrgfKBLMlSaURaeLGWzYVE1E
	wc3EyF96yb1Xy
X-Received: by 2002:a05:622a:1e12:b0:50d:7ca3:379a with SMTP id d75a77b69052e-50d7ca33e59mr167476291cf.3.1775578594439;
        Tue, 07 Apr 2026 09:16:34 -0700 (PDT)
X-Received: by 2002:a05:622a:1e12:b0:50d:7ca3:379a with SMTP id d75a77b69052e-50d7ca33e59mr167475651cf.3.1775578593759;
        Tue, 07 Apr 2026 09:16:33 -0700 (PDT)
Received: from redhat.com ([37.19.196.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d9d449f79sm33302871cf.18.2026.04.07.09.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:16:33 -0700 (PDT)
Date: Tue, 7 Apr 2026 12:16:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Message-ID: <20260407121515-mutt-send-email-mst@kernel.org>
References: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>

On Tue, Apr 07, 2026 at 04:31:56PM +0200, Luigi Leonardi wrote:
> `virtio_transport_send_pkt_info` gets all the transport information
> from the parameter `t_ops`. There is no need to call
> `virtio_transport_get_ops()`.
> 
> Remove it.
> 
> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

but I think we should drop the Fixes tag.


> ---
> I marked this as net-next material, but honsetly I'm not sure if I
> should have targeted net. It's not a bug after all, it's just a cleanup.
> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 8a9fb23c6e85..a152a9e208d0 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -60,8 +60,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>  		return false;
>  
>  	/* Check that transport can send data in zerocopy mode. */
> -	t_ops = virtio_transport_get_ops(info->vsk);
> -
>  	if (t_ops->can_msgzerocopy) {
>  		int pages_to_send = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
>  
> 
> ---
> base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
> change-id: 20260407-remove_parameter-f61a3e40cf90
> 
> Best regards,
> -- 
> Luigi Leonardi <leonardi@redhat.com>

