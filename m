Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D321340260
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703080; cv=none; b=P7csz/SGd2/rQwAE/YdpUzW4aIfuq8XkB8meQQkxNaJubUCVF7Y9ghMLKD5ZmVKN679bBPjW98OrMxnMs5KNcXwdyAcP9RAi4tS8vbYl7FzI+cOXPK1f+idYMzmYuAJGkb7uaQE61Q9qz3ZVAk4vY0d0rHNu2CRz6YECtLU8/VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703080; c=relaxed/simple;
	bh=uK/vt7eLnOx5l8lJnbIVpEjTM2YvSAf8nXV0EaVRzsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsoKt2wic86kpxGouUZ3BzX9s/GN7+xGM/fyNRhmMx25V5HFFcoPEfkBtWj+R8l+sHCncjXEA9t3Q2q+fSM8dRHj7krPhmaiKOJ+1jR04PgOtcrCYzSA5DmiMLhuJmXy2tXnE4FvPkAomRupW9JviIBna9lHUBEVOnovxAfgWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXJCNFrU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tF/2NOxH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXJCNFrU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tF/2NOxH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779703078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c1gLqb9yQcrxGhMm5dozqHasfJujBtBwy62H+RJqRdg=;
	b=SXJCNFrUzM75Ukyy0U7laPw9r1EylOZ1JvO+ft+KLWGKJgUUXpNjAaSCwCts+Pt4P6roK+
	HmQJTgzM3L2MUQq4AVNOR3SD1nfawWwA/BcG35pumkPslHoELFOCp7kpzoXbuIDaAB9op6
	VbsnDZwKh0yw2V/+6ax3DdpKkE0mHFY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-kEt4E2BpMfCjmzHEG9rSFQ-1; Mon, 25 May 2026 05:57:56 -0400
X-MC-Unique: kEt4E2BpMfCjmzHEG9rSFQ-1
X-Mimecast-MFC-AGG-ID: kEt4E2BpMfCjmzHEG9rSFQ_1779703075
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fd233d1e2so8676135e9.1
        for <kvm@vger.kernel.org>; Mon, 25 May 2026 02:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779703075; x=1780307875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1gLqb9yQcrxGhMm5dozqHasfJujBtBwy62H+RJqRdg=;
        b=tF/2NOxHNQKgMBzqI4DH3UjknadLJPd/cS7dAoETtafHRBI/ldH5IsvB+dzWp72SDe
         4IfWp1vP/9pzTAF+yM56ckNwRXwZzZFW3eFxDVodxDqdxAqN+t74rJXLFER+IGUGtvzD
         sg1S/8drAws4E0nzlp4K8A77f5jpzgnhKXthYjSVVGGETenbKUAz4lEJG7tUqIQT2ebE
         aM2VjHX21qRp2Ndpfw40COzYoyeBvx/u2pl2t5SzoS6QmNrj5GPZsAdxS7PjttqtoIOK
         M4sye+pD0X/NVOae9sxBmH4KeQM9heHcEuP8qtbpXHuZBJT/0GjzmfC8f36pf9gdCsC3
         4/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779703075; x=1780307875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1gLqb9yQcrxGhMm5dozqHasfJujBtBwy62H+RJqRdg=;
        b=BsH2iP+u9UNfjduz+6/Pbaeb+5fG1nTNgZ00NQJmOMnzx7asUC9iKy5vD16GztGC01
         yw19UjbA1sj3Muhis7f6LevM1x3OVMMXLkSpxi2PCljpeQQRFo6PNbHuYLqsNkFW7Vew
         YZQ1wynLPHlNvzYe7XadbQYh2JBfl4XemVWVwUIKT7fX6ujWxDTf56v4WwBUifAdGRxI
         1uRn1D3VRQh2DfbFMc2ID7ihyiz1TFbu9yjrPB8TYyzCgtOsBCBEFzK0e4J/Fz5VfKdx
         eOlocWthl0rkWA3bSNOrxa8jvm7rXtQy4K0JOq0BNHvT+OJI5sQ4/kLHSe3yVHM+pt5A
         0IOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bYLdzKjRPOECqs+AUvMdt2au3cFvGjutlUFw/q4GbL+RIKP5+7hbhWvlmTrkDazAg94A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0QBchUeGMh9/9vuIP6JsmZdi/OG4zdcvzVclD51/1rug4uQ68
	ixU6/W/Wru7n5zvGcNb6+bM4vVfFAHIfBNSshwvDCOXcAB5YobNAZLcBGG+rrHyrV0uNuLTa8sK
	+k4s730X6uIm6v99ggpTnYF6/Al6TzcxERO95I+xp4zjhVl3egT7WQw==
X-Gm-Gg: Acq92OHuxSa2GM48hkfWqmu11IHDPr+6xsCX7jYWe3ds+XyzQZLJOh3NQRXPBMR9c8z
	9fVVkc0oE+kRDsYFBntKi5KDkgll8FOiiXucV/w1DcsgtsUzwjoAwLHKK7lWoXfo70h/KaPma8T
	pzHtu3zRsFIs6P1nx3DYSkwUDFGx3HC4ETvZGuXPJ8K4LvspuKkCsYC6RtFmAOko5DM0HhKD8RN
	osLbMqYV0/cNsRMzpDQXa4ps+CYyAhlY44A8J/h4Nos6MgD7O4rdpPFDxKgsKjUIycTf9Qy5lVh
	+ZNJyxvIDV56wM+AnAERqjkJTY501ixH+hAQZ2j66m0rprYuyHutdKWFAbBAeOhpvJg1o6F9I5/
	wuI4WowBJa9RTFA7V5uq/oQTWRapXOAh93Qx49VJTXHmye47ECDrHOmuqKbaxMjx3FB7dUGuEjU
	HY3BEhrQ==
X-Received: by 2002:a05:600c:6995:b0:490:482c:4384 with SMTP id 5b1f17b1804b1-490482c44ddmr216835835e9.24.1779703075156;
        Mon, 25 May 2026 02:57:55 -0700 (PDT)
X-Received: by 2002:a05:600c:6995:b0:490:482c:4384 with SMTP id 5b1f17b1804b1-490482c44ddmr216835185e9.24.1779703074518;
        Mon, 25 May 2026 02:57:54 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490417b0680sm83957175e9.8.2026.05.25.02.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 02:57:53 -0700 (PDT)
Date: Mon, 25 May 2026 11:57:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org, 
	xuanzhuo@linux.alibaba.com, horms@kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com, 
	pabeni@redhat.com, mst@redhat.com, davem@davemloft.net, jasowang@redhat.com, 
	stefanha@redhat.com, edumazet@google.com, stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <ahQbVxvbBEJZ3TBU@sgarzare-redhat>
References: <20260521124732.125771-1-sgarzare@redhat.com>
 <177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
 <20260523173557.5cc4f4f6@pumpkin>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260523173557.5cc4f4f6@pumpkin>

On Sat, May 23, 2026 at 05:35:57PM +0100, David Laight wrote:
>On Sat, 23 May 2026 02:20:29 +0000
>patchwork-bot+netdevbpf@kernel.org wrote:
>
>> Hello:
>>
>> This patch was applied to netdev/net.git (main)
>> by Jakub Kicinski <kuba@kernel.org>:
>
>Did anyone else notice that is isn't a bug?
>
>There is no way that a 'count of bytes of kernel memory' can overflow
>the size of 'long'.

It's more of an estimate than an actual calculation of memory usage if 
we queue the incoming packet. In theory, an overflow could occur if the 
user sets `buf_alloc` to 4GB. In practice, though, I think you're right: 
the memory should run out before we get to that check.

Thanks,
Stefano

>
>-- David
>
>>
>> On Thu, 21 May 2026 14:47:32 +0200 you wrote:
>> > From: Stefano Garzarella <sgarzare@redhat.com>
>> >
>> > On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
>> > to 32-bit values. The multiplication can overflow before being assigned to
>> > the u64 skb_overhead variable, making the skb overhead check ineffective.
>> >
>> > Cast skb_queue_len() to u64 so the multiplication is always performed in
>> > 64-bit arithmetic.
>> >
>> > [...]
>>
>> Here is the summary with links:
>>   - [net] vsock/virtio: fix skb overhead overflow on 32-bit builds
>>     https://git.kernel.org/netdev/net/c/4157501b9a8f
>>
>> You are awesome, thank you!
>

