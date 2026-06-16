Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B375369D72
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614804; cv=none; b=hdv9yCmjiXWzkaKWib6B0Zt8eBRtgu5eVvQkcr3qclXf8XjWQgrlYNGv0AVcMeqNZYXNklcJdHmaF59U+1ZNvHr7j3R3vo469fmxYUtm1UIDc1V4wXvx6Ub3vGG5Aro30wMXxkyAuZkY9v8OfDqle1hZMGtv7Ulqh3vYHPJ1p8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614804; c=relaxed/simple;
	bh=bhB8cqYkdx99HnRuLaoyAkAfNvz4q6LWBo4ONFNXjmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLPG7uH54ZBu76ny+S6Mar9jYNxb5nKpRE4+bc2IHrCE1URN/g9CzvI+ukqXZlL728g7AM6PAkkkofVjMCMJM17mi4SjOjfxLVsNGjDFrRPcEDLNTlpZlOUc5UYrOAphg5lYwoO6gAHPiJyGPW92NZc85lWnlzv856z7yppWlDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=izDkDBJ7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VhkFnL13; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izDkDBJ7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhkFnL13"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781614801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EVj9gc1a5EiZ8GlGp7l1tQy1b06455G3XK/4iEWItig=;
	b=izDkDBJ7Z9CQ+t9sVivC6Fwt7u0570xgxg57lwKfLkuRLZVXR7g/lOyLyRryNTXuBpzFn8
	Dpr6Rb3M93oiOWlRL2ymPSwCcImleQkcSAKSx+mrqlt5ciA2q9kRjAFZkrlHyPiTqXe2Ws
	Aw74I8u0mEIbjU253CKkjOkysy7lWxE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-fY9jfkj2PNKwkxEiw0h9yQ-1; Tue, 16 Jun 2026 09:00:00 -0400
X-MC-Unique: fY9jfkj2PNKwkxEiw0h9yQ-1
X-Mimecast-MFC-AGG-ID: fY9jfkj2PNKwkxEiw0h9yQ_1781614799
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b37e1f47so33225065e9.0
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781614799; x=1782219599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVj9gc1a5EiZ8GlGp7l1tQy1b06455G3XK/4iEWItig=;
        b=VhkFnL13Ek65FEGi+s6bmkNVvVvIRXe3J3LDyCMXGs5ihkTxyKwKgmWpnRbdyid5dX
         GvxwKsSWnjGsS48pMa9+3r7H9W7w1ryI8blQx8PGBGX+1LIhtPlW1xXsoZigJwrSu49G
         noG3X6gvVLufbLXqL6YbDzUBQMP3uBfpPDXJKbQRmfFSt0maRVeTW9MEHU2mrR9YSTH3
         AqE6ijb0xoPJW4lqpN4B7XfgZg0xP0VRMnYcmXj71HlvKUw72yLWFOExfWdi0fm92cZe
         OZ2iYB3AB6yT0/DpcWeGzcmecZMqhmH3mI9Nov1c53NFo/9lcDqHxdsZ6t8SzaXR8J+Z
         708A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781614799; x=1782219599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVj9gc1a5EiZ8GlGp7l1tQy1b06455G3XK/4iEWItig=;
        b=aX0dyvr2RscQZ5HsRxFD7VW4Afl5T4B9BQMxXHdZSTK8kgy8PWDOpuMPVBGIpQOj7F
         iH0OivHmyiv2kal3t0KZfn2uENXnVw1UyD3TEHW2l5hDjT2NHr55PGrPVzxazB78lYNb
         YpqOtXErXhOkqLDGlZ1tVpb2CzJvZuQJZaoXu9oWuVtr4AN2h8gmvqvXr5Do4qtNjXqO
         Bq//Sr7rE0rRSV3V/HCJ6J6WiuRdlja+AHd1dHy+VmJ+4+QW99noLi8yhxkUfZMpUoHr
         MRh1JnD/J7lHRtvdmmZ6atHyqJmfxVoxzrzUTPtRq8rgqsHVnkdyQxcVbZ374O6u35Br
         uDMw==
X-Forwarded-Encrypted: i=1; AFNElJ9sBzL9LlM+kfoFXfEL8QG2Vwv4sdZIcx8d0gW/NN3R+lOW8ZEImEuXbNopdWx/kEkYl7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsGvogAShw2KkvZhxQgHwE6AI56gOlqS956rYch+mrchTc8WuG
	lOGV52jVw1b0Tegbc3A/vkEUkrwQBYNGk3zW7jDbzSOtWkQ6+PAfW/lV4yU19sXrjFfzRtXixYj
	rwQqIXN6SNoSwNdsEEqRLEWcH3wQktJVTOmVhcsp8QF6U13fNL8Xbaw==
X-Gm-Gg: Acq92OE+TpzhfnsNeGXBnMzr221NnsRhMMqOkmX23MIPNJ7OQVZBSZ7iYIU9YspCwHL
	NO4ZMXHrnb19m21HJ0ds/gXL3DMzzrN7DoGPugJT/CbQiGjJt/Itddem+OVKloKu+KkgDemDfoB
	bmKY+PfQowTKdu/NxCO+ABJGiGKrGrlTKzRKCKUo09/jaIxspedZqLUFOLWiEuOQgfGPQLC8FT+
	ZSCBkBZp3u8HIE2mj6RC0Dwu6+HGXvvRxNkZp9R7L40DENK250A2pdJkLibN09sfD4klH4HHI0j
	hbe0crTcFIPFNT7fXDSy4as4EjFYOzCz62eCL+dk9HZ5FK4WANNzIDkhhM8Rniokootu1T+DEYa
	4BPntm+aVJxog/5uY6QibbvF9zj/oVQxxGAvuSY4jt+EPIP2aOiIHeYOY/XO3IKQdiBJjrno=
X-Received: by 2002:a05:600c:4713:b0:491:7325:39c4 with SMTP id 5b1f17b1804b1-49220164d3bmr190086315e9.34.1781614797311;
        Tue, 16 Jun 2026 05:59:57 -0700 (PDT)
X-Received: by 2002:a05:600c:4713:b0:491:7325:39c4 with SMTP id 5b1f17b1804b1-49220164d3bmr190084565e9.34.1781614795388;
        Tue, 16 Jun 2026 05:59:55 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa97a07sm131444255e9.14.2026.06.16.05.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:59:54 -0700 (PDT)
Date: Tue, 16 Jun 2026 14:59:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Octavian Purdila <tavip@google.com>, g@sgarzare-redhat
Cc: netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2 2/2] vsock/virtio: restore msg_iter on
 transmission failure
Message-ID: <ajFEpMnHsxAYJSOa@sgarzare-redhat>
References: <20260613000953.467473-1-tavip@google.com>
 <20260613000953.467473-3-tavip@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260613000953.467473-3-tavip@google.com>

On Sat, Jun 13, 2026 at 12:09:53AM +0000, Octavian Purdila wrote:
>When transmission fails in virtio_transport_send_pkt_info, the msg_iter
>might have been partially advanced. If we don't restore it, the next
>attempt to send data will use an incorrect iterator state, leading to
>desync and warnings like "send_pkt() returns 0, but X expected".
>
>Specifically, this can happen in the following scenario, triggered by
>the syzkaller repro:
>
>1. A write-only VMA (PROT_WRITE only) is partially populated by a
>   prior TUN write that failed with -EIO but still faulted in some
>   pages).
>2. A vsock sendmmsg call with MSG_ZEROCOPY requests transmission of a
>   buffer from this VMA.
>3. The first packet (64KB) is sent successfully because the pages are
>   populated.
>4. The second packet allocation fails because GUP fast pins the first page
>   but GUP slow fails on the next unpopulated page due to PROT_WRITE-only
>   permissions.
>5. The iterator is advanced by the partially successful GUP (68KB total
>   advanced: 64KB from first packet + 4KB from second), but the send loop
>   breaks and only reports 64KB sent. This creates a 4KB desync.
>6. The next retry starts with a non-zero iov_offset, disabling zerocopy
>   and falling back to copy mode.
>7. In copy mode, the transmission succeeds for the next packets but
>   exhausts the iterator early because of the desync.
>8. The final retry sees an empty iterator but zerocopy is re-enabled
>   (offset resets). It attempts to send the remaining bytes with zerocopy
>   but pins 0 pages, creating an empty packet.
>9. The transport sends the empty packet, triggering the warning because
>   the returned bytes (header only) do not match the expected payload size.
>10. The loop continues to spin, allocating ubuf_info each time, eventually
>    exhausting sysctl_optmem_max and returning -ENOMEM to userspace.
>
>Restore msg_iter to its original state before the packet allocation
>and transmission attempt if they fail.
>
>Fixes: e0718bd82e27 ("vsock: enable setting SO_ZEROCOPY")
>Reported-by: syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=28e5f3d207b14bae122a
>Assisted-by: gemini:gemini-3.1-pro
>Signed-off-by: Octavian Purdila <tavip@google.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)

Thanks, looks much better to me now!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

