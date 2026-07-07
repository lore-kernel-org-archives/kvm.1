Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7233090C1
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416476; cv=none; b=eSc/o94fIvzl0ORSjQzxDtimST/XERRHwcdROrV5eea/DtR4SMVM5G2Ghr1xMSsaFZBWZLPJRm8MNMBxUx8z+QUEJt/xOuF0gLqJWhE5xM9fgB2iTGwp6Wfv3sXY5fU6R83i1+TUzOEnVV30d0b8uQSKPY9pCMLvuMTldVKKolw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416476; c=relaxed/simple;
	bh=3bYECwpBfkTcXe9Xf4qgJEYNbyztdqohJjIZZ7uI0/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOGLa4g6TsbDpx3R0ZP1kRJhdIf5Ln7Z8TGrbquqAJsdkxEj2mkiauSxlhsFgqzKNLRxyLLV5sGlPveaezVL5/EiGhiMXvVrgjBeMsHI24gn9rZVmmwQe8dk60OU8zT56FcUH7Dai6KBVKixWNMxGWbSrUwZvMWxSkHGsmIL/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aU6xEIv5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EgRcJsUM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aU6xEIv5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EgRcJsUM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783416474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dWXC2U5pS/sHIFMNKjcnHZ2j56kpHPifAM+RlNplU0Q=;
	b=aU6xEIv5GCjhsSKNRdzG9RpiStMs+glGmXSjsshuXZAi2pBsxP6nRFA3TXx6lVjgeC7kcM
	lW0kbn5EJzfXk7i/edh3z6T7b8BEh15YZjYfbfxh3RKm/XmWu5sRs3ZYr+E7QevEElJWMq
	UY8JwrWyaZYj8M8fyD4ksVvvmvdMT9I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-lyh80X2EMLWkAHWGmFQD5Q-1; Tue, 07 Jul 2026 05:27:53 -0400
X-MC-Unique: lyh80X2EMLWkAHWGmFQD5Q-1
X-Mimecast-MFC-AGG-ID: lyh80X2EMLWkAHWGmFQD5Q_1783416472
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493b0a5e636so38195245e9.3
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 02:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783416472; x=1784021272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dWXC2U5pS/sHIFMNKjcnHZ2j56kpHPifAM+RlNplU0Q=;
        b=EgRcJsUMwNTfmjcjtTEh0B3qY8pZ2jTTl4RMibEsP2AC6oPkcA1m9ed8kO3wmfmciW
         XgFCGvYzbmiVCC1ESidbypkqxh/Px2k4Wnl7ckZlV5uoXSdKREqljgNJ6Y4d5NcJCUAH
         RPvwbPonvKQhsya0Xq+zx8i0HrVp5hTwxRMjr32/hqG0M7t/i1haIHHH+5YZJJFFUatC
         SrO/2WMMwcbsu/2ei/zknM/dpS7cUqt9Z2njY8CgcAcUaD4audPIfGXOkNzdSc0O6EXA
         VHS5VTYq2sqfyuSGP2Sgcclm0jabmKiMSEgjBJFbmvSusV5mgBmCtBHOTY2w7Aq0rt2g
         K2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783416472; x=1784021272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWXC2U5pS/sHIFMNKjcnHZ2j56kpHPifAM+RlNplU0Q=;
        b=naklnwo7Ma3+/k5RaWtx9EiVbczvWKg6B2IYLk2NAOaUAKKQ3lgx3WK6QX/PZSYhMu
         PH8KnH+HPs629Mx0Ay5I/pGgEzm8gnNnxO6ptnNmJUbiP8+szVrVD5/GGhRGywYk0pMP
         cp6JQDPo8s1d1WN76vKM9CTUrPmLIwQ4m0sX44JJ546LH/BGbfYZ5SUMR9zl35xTX2Qu
         Ri96POnLGUvaqhcOb54Ad6VJzIJJw4zEGOMkBhXCqb+fAbGd2ZZ7sNtyb03AFwGtUY5+
         XPqnyjPURm8vI7sjlDJ+f5/sTo9fgMBtANscxN82/P37a/dnODTPDfmRIS742LLhuvP5
         A6jQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7o8VBccYEu5l8WVhHiNYAda79Bct0tIEnZtey3QIiskJnckEuu7GznprdlweF0mZ6iyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEhRYH9uvWHmNMVCz0GoAL8R89TOb7be7zXOz08Ab3zd5iuo0V
	eDQUmyBZ7jH07pL2JH7K29TH/qJxSAVFTuVxV3sgIr+9lY8FnhYsMf1woBUziuo36QIygzRoU4o
	5Hyjh85VE+iysQUVVRNmBE9LL0RfiXAZ0NokboqsH54GcweskLCRx4A==
X-Gm-Gg: AfdE7ckHFuTDUraEkBPHBwSyf3Wv4iIGoYJ7X5m/XGh2EYlp/XJiE3DHFrp66NZL1p+
	a/toJAPjXqG5abgssyOMHhC1TpC6sGewawy4YLZdjRZaefV6kE/+03UITf4vmaU0MT7c/Pb3y70
	uo6IKUfHCluqUFNgT/zAH1FzqEiPWym8RHErkjmGX4QkGzswTrjMcz5Ffln52KlasSisM8jD/r8
	lY5K8+4vIrX394FOd0q9aOrd78966IuLGqwPIhoRZoFq9jfDpHvdIW4zfW7n6H3N/bFdBy1Jysc
	Gz8+kABNEAtqpA9SIE5iZQTrz6IQjpUA94SsGPa4koG+h/bbawmydn6dNoHy6k4t5QJiFZBTXb3
	mSHqRie7aVBrjCvnEOf42936QoC96snS0b+KeHoRk5VseKhuH2nBfCOM5h64T
X-Received: by 2002:a05:600c:6ad0:b0:493:c2cc:aecb with SMTP id 5b1f17b1804b1-493df0a08ffmr34351485e9.38.1783416471685;
        Tue, 07 Jul 2026 02:27:51 -0700 (PDT)
X-Received: by 2002:a05:600c:6ad0:b0:493:c2cc:aecb with SMTP id 5b1f17b1804b1-493df0a08ffmr34351085e9.38.1783416471154;
        Tue, 07 Jul 2026 02:27:51 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f4e3afsm48240745e9.7.2026.07.07.02.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:27:50 -0700 (PDT)
Date: Tue, 7 Jul 2026 11:27:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, stable@vger.kernel.org, Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <akzGUvB9g3smaXO6@sgarzare-redhat>
References: <20260626134823.206676-1-sgarzare@redhat.com>
 <20260626134823.206676-2-sgarzare@redhat.com>
 <akVBmydgSd0Eb46/@devvm29614.prn0.facebook.com>
 <akYl38_9Y4ydXuqE@sgarzare-redhat>
 <akbFcMHenseQW7mJ@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <akbFcMHenseQW7mJ@devvm29614.prn0.facebook.com>

On Thu, Jul 02, 2026 at 01:09:20PM -0700, Bobby Eshleman wrote:
>On Thu, Jul 02, 2026 at 10:56:04AM +0200, Stefano Garzarella wrote:
>> On Wed, Jul 01, 2026 at 09:34:35AM -0700, Bobby Eshleman wrote:
>> > On Fri, Jun 26, 2026 at 03:48:22PM +0200, Stefano Garzarella wrote:
>>
>> [...]
>>
>> > > +out:
>> > > +	if (new_skb)
>> > > +		__skb_queue_tail(&new_queue, new_skb);
>> > > +
>> > > +	skb_queue_splice(&new_queue, &vvs->rx_queue);
>> >
>> > I think the new skbs will also need skb_set_owner_sk_safe(skb, sk)
>> > when adding to rx_queue?
>>
>> IIRC we added it in the rx path, mainily for loopback to pass the ownership
>> from the tx socket to the rx socket, but here we are already in the rx path,
>> so the skb will never leave this socket.
>>
>
>Ah that's right, I stand corrected. There is no sender to leak in this
>case.
>
>> Maybe it's necessary for the eBPF path?
>
>Looking through sockmap, I don't think it depends on skb->sk being
>non-null either (it reassigns owner to the redirect socket anyway using
>skb_set_owner_r()).
>
>Sorry for the false alarm. LGTM.

Thanks for checking!

>
>Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
>

I'm going to add a threashold as Paolo suggested. Do you prefer to look 
at v2 or should I carry your R-b ?

Thanks,
Stefano

