Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B29C1E98E3
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570557; cv=none; b=gI0q30G0cjYxgvJMoDx2TrJZp27bX1j3FMe4kdyoyQhCnOlGFowNTU/IX3R/E6M8Rpz5oaD9lrBPrNz7OBw2kaKzlbDYEx4iwEs5EKqqKwR5Nfg/PovXXMk546tvzmapNYkhubbz5Z6HE7Qy28IefdLaP/NsWRoFaiaXV/9mXHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570557; c=relaxed/simple;
	bh=7PDVjOFFBvB62jh1T+5fxxeccqZf3wobQfN0ejWBl+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONYr+P5yF7gJhcnJqgKa5MSxushuup0Y72qaTxSxHULMSQxyUY3v6xut4BMSO03IuL2cf+HwopEFDATzad1H22EbvIMkjFYcBgMPRMbkX2f6HG31L/8QF2cqEHJfmzckFuGzd6URwezz4nyx4+Q09tiblODdS87RefF66zr2uWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6WlenL/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MI9EvFI5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6WlenL/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MI9EvFI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780570554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wklQVRsViMBNiTmJy4yFl6j2hWwlYVgd/9iVl7uSjw=;
	b=W6WlenL/M7oHVRp9ZoquNNBSuLbQToiMFOhiyTatrKopA+IYkHoOmPbvXWAK00fXxdRKYA
	S3WTy1PWVUJP+nvTcKOUKreU8kRvYv89fWeIVgqemYBxOc8e8uKNYczm6C5UV2RXf6ZID5
	chZNYLFvbaG7BP1UZsBFhFl6WlaaEN4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-NsPo2h8SNFaQwZl_UV4jJw-1; Thu, 04 Jun 2026 06:55:53 -0400
X-MC-Unique: NsPo2h8SNFaQwZl_UV4jJw-1
X-Mimecast-MFC-AGG-ID: NsPo2h8SNFaQwZl_UV4jJw_1780570552
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45efa2f7009so366255f8f.3
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 03:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780570552; x=1781175352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7wklQVRsViMBNiTmJy4yFl6j2hWwlYVgd/9iVl7uSjw=;
        b=MI9EvFI5CC492CNU1fnOZp0eV9EwEJ3muBcXeBfSLBLuG7XJFSapj1Za9v8hw6SiVZ
         bFoTynRh2bExwPgVOiOic52NPaeBITTOJsOJs9F+T0mSuI5LYPAbetIBCcAcXyZHlTYE
         2iM6zJwUYnPVOPtRnx2w1afksrn1P/NAe70hyHoEml68K5ap0j1aObZHaje9LViTQq/h
         Gcb8UeA2YppKS+vRg8w2PGfVmwwSSk4vbpZ3z03JquRN2rl/yeYZFjVSknUajYrdMGrh
         8PJzYqfbYcT6ZgbajW2ChvKV9os/h2XAvI/6hbLR9DGIJW4m0pYsz1nbO0VklJoDAxfN
         3UQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780570552; x=1781175352;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wklQVRsViMBNiTmJy4yFl6j2hWwlYVgd/9iVl7uSjw=;
        b=AqRyGYxzT7IhjHhQ6NfwKWh7N9BNidyNBvhptRxh7o1/uMIE59gVEmUnl15VB1gemU
         xionYWvFY61bfWv5u2EMniJu9XEBcWXnQeSp6UH6OGE4j2Vay321soXGQgrDv+bRo0P1
         HpaWxcZztNNObnAq9ZkD/gHRZneKyUJUmkRWYDkFNH5AnAEXwriHFjPfy+gO8Oc7xPjn
         lnODrWOJreKKafq19LITQjmUaueN9osiaJm/rtrqzxKmsWuhem1BXL9JPvUQpIVAI8Sw
         qb/acB7bBsU+dZhRwazKtSafawbObcpQePyFSiDMtgjKpIt6NLUyRgBHCYYipmFRoTZ3
         Ga4A==
X-Forwarded-Encrypted: i=1; AFNElJ/uGcLqxDAV+oJvIk3MujGZ41TwWSaWMZO4kh7qjxRBozuds+/IYz4ze9OOLXJoSdgOODQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuOOTdd4VWsCJS+k2Jf0WWRq179tEVIH2lJp+VeDszzJ0d7Xr4
	EPeH/RIjHzO/vCMyfDd/QHDd4CLMuQ8pdzcfyGGa7c+k5kFuBVMP12ITP6FOfnIgek7b4JO2G90
	tuNEL52WpPuwlUfjIJlh3zwjZk1KyvyTaCplpsJ5AgOyGtSqv2pqKzA==
X-Gm-Gg: Acq92OHGSREo1gV8Jwp8UmaK3w9YqrY6AjNaQcdqFNiWqIJozUnkq+BI0IPj20ePiGg
	jlavaIYQlrz039ReWbxoZdY1A9vO0XLYNMEQdkPqbgSSB8+spawZmkOUaR5XCVAscgM8lD8ZMP4
	PZR7kxcne0XRrhgyfy3hACuyuUCQcdH0xRu0+lAtzenGIN+g3ylwus+y08u/l6Flq+u2N7qIbz7
	I2DrKSa/Jp6fBi7whBDo12tQ1Is71t3qXIhw6RmmtHGY+4lyYaJf7+kwPSQsYnCkvPw4WJX/Wyj
	6AbPQBOazCAnSyEuiDeUjx+2pDO+Jc6gkQJ1QfOvJfmRBgHMlb5yijlNw6gatx9snOkPbwEA/zS
	MjycFCeCWoVuI9xNcAqgwlfFNY4lM9nh5bv2pBZVRXlZ2mfy6GAFlGgFxiEtypnLzfc0=
X-Received: by 2002:adf:fb85:0:b0:45e:fa38:c899 with SMTP id ffacd0b85a97d-46021783cecmr8984903f8f.4.1780570551758;
        Thu, 04 Jun 2026 03:55:51 -0700 (PDT)
X-Received: by 2002:adf:fb85:0:b0:45e:fa38:c899 with SMTP id ffacd0b85a97d-46021783cecmr8984861f8f.4.1780570551302;
        Thu, 04 Jun 2026 03:55:51 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm15330789f8f.28.2026.06.04.03.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 03:55:50 -0700 (PDT)
Message-ID: <b6182472-503c-43e9-a850-87cd40f86aa8@redhat.com>
Date: Thu, 4 Jun 2026 12:55:49 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vhost/net: complete zerocopy ubufs only once
To: Qing Ming <a0yami@mailbox.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Shirley <xma@us.ibm.com>, "David S. Miller" <davem@davemloft.net>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260601104300.197210-1-a0yami@mailbox.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260601104300.197210-1-a0yami@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/26 12:43 PM, Qing Ming wrote:
> vhost-net initializes one ubuf_info per outstanding zerocopy TX
> descriptor and hands it to the backend socket.  The networking stack may
> then clone a zerocopy skb before all skb references are released.  For
> example, batman-adv fragmentation reaches skb_split(), which calls
> skb_zerocopy_clone() and increments the same ubuf_info refcount.
> 
> vhost_zerocopy_complete() currently treats every ubuf callback as a
> completed vhost descriptor.  It dereferences ubuf->ctx, writes the
> descriptor completion state, and drops the vhost_net_ubuf_ref even when
> the callback only releases a cloned skb reference.  A backend reset can
> therefore wait for and free the vhost_net_ubuf_ref while another cloned
> skb still carries the same ubuf_info.  A later completion then
> dereferences the freed ubufs pointer.
> 
> KASAN reports the stale completion as:
> 
>   BUG: KASAN: slab-use-after-free in vhost_zerocopy_complete+0x1d7/0x1f0
>   BUG: KASAN: slab-use-after-free in vhost_zerocopy_complete+0x101/0x1f0
>   vhost_zerocopy_complete
>   skb_copy_ubufs
>   __dev_forward_skb2
>   veth_xmit
> 
> The freed object was allocated from vhost_net_ioctl() while setting the
> backend and freed through kfree_rcu()/kvfree_rcu_bulk after backend
> removal, while delayed skb completion still reached
> vhost_zerocopy_complete().
> 
> Honor the generic ubuf_info refcount before touching vhost state, and run
> the vhost descriptor completion only for the final ubuf reference.  This
> matches the msg_zerocopy_complete() ownership rule for cloned zerocopy
> skbs.
> 
> Fixes: bab632d69ee4 ("vhost: vhost TX zero-copy support")
> Signed-off-by: Qing Ming <a0yami@mailbox.org>

The patch LGTM.

@Michael: to you want to take it via your tree?

/P

