Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332C93E9C25
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706399; cv=none; b=cmMsLrEOabTtJFB6lBJn6FbLZ2T/CwjhLnBeec1mGG5xbMN+gmoW9L+EhI1814Y0vNXHR8kG0kTp9NIBsQc0BblkD2TM06Cjf0kVMRmXMQk8Pw3FeWekJDo/EnIaggvp79yxQ6CQ4ovZYbx02Lpky2csrelJA7qE7gAaU/Ax3TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706399; c=relaxed/simple;
	bh=rCoOpEyyUCy5izIH7PFgiOzmcy6juASzPqw0DoJcH0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcNsZp20pGztTDZzWHMfYzIBfm+LhdWkuatK75VzaAooLD7Wtj8ySNNPpyzxlLtwsEMd6SooobduM66NDIHwWcNUOkTKctpmcII39E1sJegwmvLChA5mI5j3aCPQLmsoYGrOxuXnNeztLyofKypbbXgE7DOqDIguQIEc6mXl0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTgqzR8h; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTgqzR8h"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4905529b933so12169905e9.0
        for <kvm@vger.kernel.org>; Mon, 25 May 2026 03:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779706396; x=1780311196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIaUsl5OR/SB9imIspw1g7Ej0mCc49YZbthvw9ulBV0=;
        b=JTgqzR8hYkHOKVq6LvCHMzI0UwunfbBdpl/kEjtAGqhI2I7iKdjb3u8htt8q3YB9ts
         ha7iOGO3j7TsCDYZrDTwZXZN5qnWneBCiiJrN0gZmfTP71m+TAnkmixGpGfXMYlFXLuh
         jOOkwKLGWqpVtCeS3Mrw2+SkkfDazmU9QwETwepYvxlj/z4HxlcXSZxOno+Se6LB3Y65
         apXE8bM7gRw4SA+Nb9040sqIvK2Rx3Q9BQGGpo+ObaOTNGJXB6N+/bJQZHUiZ89vGUAT
         n8b9ei+uZqcVnbG2clDOzFjzpS3Q8Snqg1RztkVmkKgDVnlZmA93NWsLguUXR7Rf98iB
         kObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779706396; x=1780311196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hIaUsl5OR/SB9imIspw1g7Ej0mCc49YZbthvw9ulBV0=;
        b=sWyQH+4VW5g5n5ZsSXVDp2VetYrC6hZNAGp6AxVRHwKNe+J1cZGU75irUNzKq8F1jS
         UhEOB/DDE2wq/KnTDVR6uLVX4D9zEoda7nejmmLULXN3NVGLz452cMwIlz+mYw1ileSg
         jaZXXSb1SrrBHlRGBiWiSWjP1lG5o3PHre7SIbeEjyaFvMW/Z3DIu6MP3zvEkFsB6n7x
         Ns6iCN6CWrMXEPTC+viu+NwuTfdjUnGHipMZM55499S4EbnncE4p5vRZTM/pqRhjyZLg
         EVXFHFQSe+iiuxiSxXNrGvPQmjLxIYl35C0RXoOO378PviklIdRKAMfAeh8hiUyu368T
         453g==
X-Forwarded-Encrypted: i=1; AFNElJ8VDXEVAE/1JhLWL0zwnpaI6z0uwwTIlSCPNjy6tgrKoibzaLNUy1jRtKcpMghhpQrkeKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQWXc6+kMpHmKemJpIcrzFrkPp2+XOe3VjgPnZY5nrq5KsoMm5
	CyLx1A83iSeSQf7HqxH+embm9Ofjo7QSC25XDuEexva4RAn+w+4X93nh
X-Gm-Gg: Acq92OFTSxOm1pU11KHTyVX6C1yG1kh+u13/88KvJWkhSUhQX23Ad6N9HFnKQpCuXZf
	NwP/BCf2A3qxnkMJ/NxZFKUBE8Cn1B5j1XEuzv1qcpf5NornwV42d2cejfzo00T0Psawt/OQBRM
	N3pWvevXOKat3g53bKhX9E0GFkT/+Q7mwOJ29t+yIHEpm1b/xZDkZSasLrmvQNuMN6+NZMYSnLW
	K7UacKAB1jVJTNMgTfquTJeki+5a8DLIXUdkmN6JVEYmfoL2O5C6b18b+6qtx91XpUA12Q51Z/j
	BRLgJ5vVyr5eHqMpnRYykNw5iIJpdQNG/JEbgqA74k/7wR2rx0RzOZpaFMwM9vd1nCj4FdomECP
	Td+3PEpsoYU2K0P3yaso5Ukb8qlYKUl4f6xPrwqgrzo39Wg0b0oGR0zf0ueZSN1LB8/im/OGEjv
	WuwSq5029hz0WU+d83koZD98J5LAxq78VVPem1UO6ujmbchSkA1BRVw1rH5IyvfIjW
X-Received: by 2002:a05:600c:468a:b0:490:3d62:f5df with SMTP id 5b1f17b1804b1-490428e5a6amr234019415e9.30.1779706396365;
        Mon, 25 May 2026 03:53:16 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904561a33dsm222417485e9.11.2026.05.25.03.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:53:15 -0700 (PDT)
Date: Mon, 25 May 2026 11:53:14 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org,
 xuanzhuo@linux.alibaba.com, horms@kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com,
 pabeni@redhat.com, mst@redhat.com, davem@davemloft.net,
 jasowang@redhat.com, stefanha@redhat.com, edumazet@google.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260525115314.3cf310e6@pumpkin>
In-Reply-To: <ahQbVxvbBEJZ3TBU@sgarzare-redhat>
References: <20260521124732.125771-1-sgarzare@redhat.com>
	<177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
	<20260523173557.5cc4f4f6@pumpkin>
	<ahQbVxvbBEJZ3TBU@sgarzare-redhat>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 11:57:45 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> On Sat, May 23, 2026 at 05:35:57PM +0100, David Laight wrote:
> >On Sat, 23 May 2026 02:20:29 +0000
> >patchwork-bot+netdevbpf@kernel.org wrote:
> >  
> >> Hello:
> >>
> >> This patch was applied to netdev/net.git (main)
> >> by Jakub Kicinski <kuba@kernel.org>:  
> >
> >Did anyone else notice that is isn't a bug?
> >
> >There is no way that a 'count of bytes of kernel memory' can overflow
> >the size of 'long'.  
> 
> It's more of an estimate than an actual calculation of memory usage if 
> we queue the incoming packet. In theory, an overflow could occur if the 
> user sets `buf_alloc` to 4GB. In practice, though, I think you're right: 
> the memory should run out before we get to that check.

The calculation is:

	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0); 

skb_queue_len() will be the number of items on the queue.
SKB_TRUESIZE(0) is the memory taken up by a zero length skb (basically sizeof(skb)).

Unless you either corrupt the queue length or manage to allocate skb that use
less than the minimum about of memory that product can't overflow 'unsigned long'.

The later calculations might wrap - but the multiply can't.

-- David

> 
> Thanks,
> Stefano
> 
> >
> >-- David
> >  
> >>
> >> On Thu, 21 May 2026 14:47:32 +0200 you wrote:  
> >> > From: Stefano Garzarella <sgarzare@redhat.com>
> >> >
> >> > On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
> >> > to 32-bit values. The multiplication can overflow before being assigned to
> >> > the u64 skb_overhead variable, making the skb overhead check ineffective.
> >> >
> >> > Cast skb_queue_len() to u64 so the multiplication is always performed in
> >> > 64-bit arithmetic.
> >> >
> >> > [...]  
> >>
> >> Here is the summary with links:
> >>   - [net] vsock/virtio: fix skb overhead overflow on 32-bit builds
> >>     https://git.kernel.org/netdev/net/c/4157501b9a8f
> >>
> >> You are awesome, thank you!  
> >  
> 

