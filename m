Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC221496D5E
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590345; cv=none; b=EmeiLa/3iAr5K+KWCFv47JZs4Td7V4owVI7XE8CViUa9ew9zdOK17Lagu4q9DFLNUGqZxsRAIFMnLUDgT4Wh+RrP9VTLzQmiQBMLdVa3dW601CZ2UZC9ktpzQkVC5yvwET3PEAXltS4z19UXotIgFGPYdfO+vzsSrIuaebCgsLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590345; c=relaxed/simple;
	bh=D9WZtmamHXSciMAAtuCq/ma/hHGvwwedbpaf0bXn7zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTqTb73ieFNmdSyfGXdLbzauDTgXlfD16dZh2nF/EBlh9oW0J7/h8UPDtAJzh1Vk6VxuFHJ8zlv9NrBObAqyGzskeuEGjNapmz/ZfAGX5PygDfBaVkBOVVLcVHei9aFlrZbXdkyXjKAiNmTVCCLEQGGvnT0l4JZisilinZjeuuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbU1sgCW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9VtdMq3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbU1sgCW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9VtdMq3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790590342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9WZtmamHXSciMAAtuCq/ma/hHGvwwedbpaf0bXn7zE=;
	b=MbU1sgCWFx/DMvWxVd9W0y/NvxOESu/txFx+qy4fNLaduvqpThDjGO0QlUIPQkDRUO9Nnq
	txtvKnREwkPE9l1ss1M8NvrfYsW/k6xDZcOyzvPqxNMR6nY6+tMW9K7RTmWT35KnZ98Fy8
	INN174qjP6QitNTwFlDDv0Q/CTlaYMM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-IYzId9UHNC-GcRJHGViA2A-1; Mon, 28 Sep 2026 06:12:21 -0400
X-MC-Unique: IYzId9UHNC-GcRJHGViA2A-1
X-Mimecast-MFC-AGG-ID: IYzId9UHNC-GcRJHGViA2A_1790590340
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f6e8b5996so2620375f8f.2
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 03:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790590340; x=1791195140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D9WZtmamHXSciMAAtuCq/ma/hHGvwwedbpaf0bXn7zE=;
        b=R9VtdMq3bW/zo1qzDPtl3athhA2y6oB32PcYX+epo2p1OzunDtf0CqCA+A+ZoasXRb
         T/flNfWvqO2A03ubU0G/FDM3MhpO4i10VT4464m8Szdog8IpTFZq67fuATxT/n3n0BPA
         vAUTP2gLaKkIYTWPsGJ/cyeWo1CYhqkkj7Y9ry2p9o14LoNC3sBpAKdZNZ6BNvR13tB8
         IjfBvkjQrerPn0T3V9HojiHOUnRSZ6uiUZt7HnEWDmSd7VyoIVLQyYL99pmzBYRwSp2Z
         Qmqr8CFEnNWEu94i5acOxgy4zqHbsAL/bg7lRp70NaXjjFJLde25GpUmEgHjinVifZ3T
         +qUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790590340; x=1791195140;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D9WZtmamHXSciMAAtuCq/ma/hHGvwwedbpaf0bXn7zE=;
        b=G9hBJvRCjOrc6BZrLXyX68WMCYryIjEr3HjV90+ypxUBckqNo2SI0vZ8D55VII9eIW
         3fe4e8Ks8L0bEPKyLPPWxufxDWEUXSUmpbGEsYSygzqh0LnZ3Qpkc6LE/UojwKJd57d/
         V9sJt5GK+Kb3/4HwQhv6HjgmZPvGWqrgk64SgI833VEFZ77k0Ny//oNDo+wCvV0/4F08
         D0iIPFJ5vtW2vdvYkP7wrKCOi8IAKVwvIhO9drzv6L9vI1vnk++5D6Xp3FO8U3Idz4fc
         ubVVFfyPXrWXuibNtZnEsvwkZioIXDRRXmwtrXLqa50r+/fF8gSdJeihifqEd6E8vyHt
         uy2w==
X-Forwarded-Encrypted: i=1; AKwUvBy9V85BOyJm3Ma+BBwDlS2h0JA9ChT+PW2V68PVHlYgWosV/f/vJU0tY3VjrkFcNlxfmDE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMsCqLHd+NE3M46pjbOEibYgXG6fZeH7MyfT2gdBOV0RnjSpuK
	pyaVf+QAF+qc676p81jhv7MruSqqHeW6CxwxOJHTXpPvBBdX3DDrzIzwQk0GUF7RYJ+hzSpk32S
	uOjNAjAV6Hv/DF9rPibfM21o9AN4qNI9xVfAmE8xQfq/67vkRYJUs4g==
X-Gm-Gg: AYBFou1VKCaKDyinBBqE9d4vrJLQco4t0akQJAwaE2AoZtv5bDHq8mAMcpZ496K8LIT
	1HIYLAGYPifOL9Cr47V+9zti886P8hUouBvAa//siSgDIAvT0jd5gdDsADnSQj7Ct+76AbfI9Mw
	m45mnOf/WcS2XJohsry4BnFDshsgFe72YiAf8Tjo0/ll67L0+Z0oBFisPqUjnvSelKn4Xz/IvPB
	tSI6L0WJJzoAGXBrExZ2JRTI8/h4l/sRCLxbE2PsXrqD04Uhdwj8iD1qvr0oOU5JiqQsrxTGxrm
	D3IHtLEpxQxFfvlitw0IY9ZycEhAXXCySKmCO9fMBv/1pGYVyUq2AksmqFQ4UpLN1P1oq6YDtK2
	NS/g5afx3qfiDdDXPgtu/cyDeB6Sm/ovWPV4=
X-Received: by 2002:a05:6000:401f:b0:488:8111:6f56 with SMTP id ffacd0b85a97d-48881117121mr15322489f8f.8.1790590340180;
        Mon, 28 Sep 2026 03:12:20 -0700 (PDT)
X-Received: by 2002:a05:6000:401f:b0:488:8111:6f56 with SMTP id ffacd0b85a97d-48881117121mr15322447f8f.8.1790590339801;
        Mon, 28 Sep 2026 03:12:19 -0700 (PDT)
Received: from leonardi-redhat ([176.206.38.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm25765327f8f.9.2026.09.28.03.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:12:19 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:12:16 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/8] vsock: simplify error check condition
Message-ID: <aro9DiEB3GPIMnMu@leonardi-redhat>
References: <20260922-vsock-connect-reset-closing-v3-0-78907b8200d4@rbox.co>
 <20260922-vsock-connect-reset-closing-v3-2-78907b8200d4@rbox.co>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260922-vsock-connect-reset-closing-v3-2-78907b8200d4@rbox.co>

On Tue, Sep 22, 2026 at 03:14:56PM +0200, Michal Luczaj wrote:
>On success, vsock_assign_transport() ensures transport != NULL.
>Drop the redundant check.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>

LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Thanks,
Luigi

