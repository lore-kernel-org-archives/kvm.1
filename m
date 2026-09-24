Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFEF36B93F
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244407; cv=none; b=Wy/EY/QNaQ0XvHZWWhA0c+Iun7xU53sLlXY4w0O+B2knkrObN8AZCobw8pNwWzU9+iB8Uaz6ba3c3Rg3D8/5a37+kmkQgKv04QXnAQK9wLWmnE3FM1iKqTaBQjZGWo2yw16xzrtDU57vTyFyrz6E5vYV32gl31RquV+UTRhujkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244407; c=relaxed/simple;
	bh=GFNtRpwPhMu+eKoRMyqSl+twdGE03Nm5JynpYuuyiKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJbLytHTjmH9UZEl+CmfnhhsjvkBBhVm+Khr9Ujs0B76as3FDqUIJ3Fe9vrkK0bT9m/TzaNV98wxYzQrs6gU+Z6PqF03tgyOPfZYhYoFVTOQOvbi+k6ENGd4G/yJYghao5Red8Co8V+WW7UsBC3nrLfGXUoSItvkqNqhEDWUZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUxElnsw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YKkmMapT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUxElnsw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKkmMapT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790244397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1Visdhzs5DmNU4T37TUFkaK4VZvm9Ag2DOzaMeHKOM=;
	b=XUxElnswCdpXfgtBDEhkIkS/NaODd5XannVh+QvFq2XuIr/kLb2t5qLqEkgKpT2hlanesH
	9wo9/X5r4jQCAMuXGzUBJKDlJ63WQ0zjqjO9IX24yrhc7lNpb8w82wZirPnnqb2ZWy5Lka
	rmTkbvoCpDF3x5p0E41bCz5oS1NFxl0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-o6W3VWZ5PcWrq6ZTJerlug-1; Thu, 24 Sep 2026 06:06:35 -0400
X-MC-Unique: o6W3VWZ5PcWrq6ZTJerlug-1
X-Mimecast-MFC-AGG-ID: o6W3VWZ5PcWrq6ZTJerlug_1790244394
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49ccfbe060aso13381755e9.0
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790244394; x=1790849194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z1Visdhzs5DmNU4T37TUFkaK4VZvm9Ag2DOzaMeHKOM=;
        b=YKkmMapTB+dkt6KqQT8YZ4bBiNOnHyRvrI8xjmar5ZHoqdt7fvs+ur4ZOOtvkOGcQY
         uU3sHE9ev71+3oqUqeBsZlGzxnfd8o5QH3V2cAs1X5C1quXkRHlsq+XYich7Io1Aqwov
         f3XxQS+5Gh3h22QFJAgoq/PQWiakaNTRDJCQgz6+WkuzUztFmZFRN2tn7fT3X1Ge2160
         178dBL+/PDeyQMrKXsXF2XuJBDl0P0f+cpyAi/AjhMRw9lLDQt2qjDEJdb0xAJLGUUrw
         FkvFtuVKSTp/3pohRufOJd5vHVIdiRqZF5d1cikKXncb7/QyHO4a6hH/eKbJmr25sGWv
         +GNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244394; x=1790849194;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z1Visdhzs5DmNU4T37TUFkaK4VZvm9Ag2DOzaMeHKOM=;
        b=UCOxSbvXMwGSiydMO1xzgCU8XB3hi84mrwqY2q1K3qzhkhID9e9v5B07HKXvHJmF+G
         QQQbtrKrwmNnZv7uzPv5dx4IeDK+KiSMj9f4P4WK2p1o/khU6JvfSh/Gkhku/88CObdD
         KMbAPajk1YYRhQ2GVT9g0VoCH+ge8hayRsu6lVhuffWoVL1NMU1HWUQtexSe/jHZEEdK
         ADMKCQsrO8Eaik1RFUrv0K6TX6E4zJhf9baKjJG8dkInUJ/XAul0WaRcX3t+jTBej9cZ
         gPWdwlGCxMs+PSWwCnQNazseGSYouDNtzFaRaAtDApUbWtRsmaHn2VjOE/IX4dl1L8NW
         Uw0A==
X-Forwarded-Encrypted: i=1; AKwUvBze3c0Tzfin/jvD3Yq+yb/t153h+7ZxH+WETfS8BBcANcPZvuCc2g3+jLLykzF6k9GgLpw=@vger.kernel.org
X-Gm-Message-State: AFuF++mQIq8Xl1r2MeBJkp28n/Zht0vJTdb85GbYU+79SMxFzmIHnjDX
	re+jtqS8LkivfCeRBzkfzjJGf/GYJAf96g0IQHJwImh7PObeHS9CWz8xZ1n84KuBWNTlNpseVxa
	O14zJ5uBRJA3nLCFkChhRQ5zabtIRH2eGTsP0wTK+NBun4Vl3DXO98g==
X-Gm-Gg: AYBFou3xlM0/PvVKxDdX1NuyIDtYFXVAJPwxhV/t2nHRL3psXG6MtaDCo1isrieFf25
	3IKXExkgcQPCzvPnBipRyxjWAKpcdEVAkEGemmyP1EaKUMCco5rcMwvIw+gzu3aswj688CWn+HZ
	QX0RNrIN9q/A0aDV339nvoATC0HP6xH+QehhfCWxsCYNTQyJgrLoZA1MoEHP2+91ACgn6fF7KkS
	dhXOY+7YW/WhMIP5tydsIKpnLd8cIc+BCT5X/o9U/JoOT/gxfILhhpDT1MqzQXzj5rIbI4VETKc
	1r+OqSdx0Yt1eDc35/LCox1TxsXFQSepHs2xthdAVjC86Cp1LiwjQhLPnXP4+RKwWZOpWj0Z7Dg
	RgWi0qJ0KhqcUEZnI1jE9v4yrcr+18ZwDKFFK7Bd0E0cpzfa1MB8=
X-Received: by 2002:a05:600c:4689:b0:49f:bc8a:b103 with SMTP id 5b1f17b1804b1-49fe66841f8mr32855045e9.0.1790244394272;
        Thu, 24 Sep 2026 03:06:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4689:b0:49f:bc8a:b103 with SMTP id 5b1f17b1804b1-49fe66841f8mr32854435e9.0.1790244393834;
        Thu, 24 Sep 2026 03:06:33 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-131.retail.telecomitalia.it. [82.53.134.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48867b49661sm13003456f8f.0.2026.09.24.03.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:06:33 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:06:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Asias He <asias@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/5] vsock/virtio: Streamline socket reset on
 transport/PM event
Message-ID: <arTwyyLVU3jM5fTA@sgarzare-redhat>
References: <20260915-vsock-connect-reset-closing-v2-0-a1d9abb472f7@rbox.co>
 <20260915-vsock-connect-reset-closing-v2-2-a1d9abb472f7@rbox.co>
 <aqp3Po7OcubJboM_@sgarzare-redhat>
 <3cbeb82a-60ff-4129-b630-5404df1f689e@rbox.co>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3cbeb82a-60ff-4129-b630-5404df1f689e@rbox.co>

On Tue, Sep 22, 2026 at 03:17:30PM +0200, Michal Luczaj wrote:
>On 9/16/26 14:30, Stefano Garzarella wrote:
>> On Tue, Sep 15, 2026 at 03:15:13PM +0200, Michal Luczaj wrote:
>>> Follow vhost's vhost_vsock_reset_orphans() and VMCI's
>>> vmci_transport_handle_detach(): set SHUTDOWN_MASK, which will come handy
>>> later in the series.
>>
>> IMO it would be better to include the reason here as well. Every commit
>> should explain why doing a change.
>
>Sure, will do.
>
>>> static void virtio_vsock_reset_sock(struct sock *sk)
>>> {
>>> +	struct vsock_sock *vsk = vsock_sk(sk);
>>> +
>>> 	/* vmci_transport.c doesn't take sk_lock here either.  At least we're
>>> 	 * under vsock_table_lock so the sock cannot disappear while we're
>>> 	 * executing.
>>> 	 */
>>>
>>> +	vsk->peer_shutdown = SHUTDOWN_MASK;
>>
>> In all other places we use WRITE_ONCE/READ_ONCE on vsk->peer_shutdown,
>> should we do the same here?
>
>Right, we should. Isn't this also the case for sk_state and sk_err?

Are those read without the sk_lock?

Thanks,
Stefano

