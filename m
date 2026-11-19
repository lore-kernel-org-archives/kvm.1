Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101428;
	b=f+ky0QnIPQEv/TvTFAhZFZzTLgfqZ0uB0kngPXXSK0KRmsjVsyTUvZblLLs76+d3YFfN
	 sUv1Tp9ZjZxiNwsZI/rp6KwIEM4nqmGAInOkWTvZYN6G7/lS44tSqpSmLtEy4NCtnvX51
	 rf3+an4zBB3kmRyhpK+LXefapuvcFONiQl3ARo/CgjQ9Cok6PnTAoIfODzv1VyKEeh9UM
	 vU3GG9wufTpmcOkpsakAmftjLLXf6tJgikUt8dhJuB3JOjyrKGMS7oYpTfP8Yus0Oe58Q
	 l6Eum8tJ04SN81EIhgRkNdbns1X43eO/DzvsJVUd/PfcHuL8ES34XyPKJs/2EVbqzkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101428;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mjCxSf15mAPakEhD7vh/i5/i7+CcuyVlsLkCJ9N8WsQ=;
	b=UIYBHlbuB64XtwdkmFJojyhLnBXM2XiM8fWpfWnr1P6mV1dF+6KsDA4f4RwPXzvXqjvm
	 sIlEIb88VmodQDjKUVBi9RL/GC9TrRsk1YuSgWceEu8S8Jb6d7lqS3V6FdUYw2E+GcDxW
	 XsAY3Ik/wcwPaO8KCxK7eT+DK0wUpu8ngzZzwSRAaeGD/COGgkdm48sJTXhrFBDkCXGvh
	 Z65+8Xuf70PAV87TcvIhYUWtAmUjaFU2fdN3C1sJR7be8+/OeEYI8FwFhp11G3x+EXvVC
	 HCfMqDsV8pgM5sma2+bPtsbcTLDeOoIfBZra+LaFcVT3KvmCc54k3uG7bvdjpZrO0bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EXDMKD6y;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IUWlH+K9;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17012606A325
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 15:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17012606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EXDMKD6y;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IUWlH+K9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795101427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mjCxSf15mAPakEhD7vh/i5/i7+CcuyVlsLkCJ9N8WsQ=;
	b=EXDMKD6yqKFvkXbYVx/MdSNdc8a+6Q90BNwrR2g7ckKOVn4s7V/hShdXN+KN46YQxBRZYB
	K2mwp0OJMdu6Wjf4ITxn2Fbl8968cXtYQoT4YpQXWAdooqAhfzKiohCHCvHiyYOKuWG4C9
	1dettkrgYMruBDA9zOOMFFzz4DqllSc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-jy_6SpKWNj2_Y6xbjBKS2A-1; Thu, 19 Nov 2026 10:17:05 -0500
X-MC-Unique: jy_6SpKWNj2_Y6xbjBKS2A-1
X-Mimecast-MFC-AGG-ID: jy_6SpKWNj2_Y6xbjBKS2A_1795101424
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4bb6bbc025aso20997505e9.3
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 07:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795101424; x=1795706224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mjCxSf15mAPakEhD7vh/i5/i7+CcuyVlsLkCJ9N8WsQ=;
        b=IUWlH+K9m4dAZ99xhZkMm66CDHfQQpuhK7inqhjwnJcph+H/r0YQE344/dAseahaMS
         xUjhHtovxFHAbvYsihdu8qXKez2hpG6v+4aOTHwuhTegH05gJgXbn8kjYS6MKVj3ZoS8
         n3YcE4lPOSF42mi5t6CjZsP4wiSSQJ7fObtAkqUSFrPdXyzGiQLdx1Zn2hyBAdUYsz9X
         nVAP1yu/Fl+CTeIZj0s8c1wpBdyLGkTR/A6x4e1sLPbFU4hSj2VHSaU2C5IKq16z/lJn
         sax/k0MDQBGfyXmTRfvh2qTzUjoGVbPov6Eh1dBsUD6sRi744WwcCdVTchlClgU9uNFV
         S3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795101424; x=1795706224;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mjCxSf15mAPakEhD7vh/i5/i7+CcuyVlsLkCJ9N8WsQ=;
        b=muV2KkrTWj/pTCazHy89M5FAz8gO9GqoQhev/cFIaA4L3VL1YowuWXmdTcowqIotoL
         lcF8tC5xcz9JVYcLiH0vzcYjlzM39dcAKDs3o6xGlV39DOKuFfUKUzmu7e2JmPQZ52Bp
         Q9sSp6WjMEc+6BPnAL/0HWB0h9HS8LuI1VB6ourcQ5Nag5NLKC5U2EjRd+6rl4uQzqkb
         2u9dN7FurFGmHrMFooLE5uYHqjR6/5GDGHv1lbNLfFLR2mXGTa79PZ6r5XOUJyeXDy6i
         UQ+o137cclW1hbQLxW5QDvTzkBzVPhUlbgvNB+SCVGZr9krqP3/61wXfb5RW05KZXmX4
         M5BQ==
X-Forwarded-Encrypted: i=1; AL+hErGD5VujtGNzzAqk1rxbfTobrgqSYEhKh51/BkyZbctXcxTyv55PG61oY+KreHneeZ0wN5s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BP8p9o4pJewzRc/MGS6WabG9OCdovp+EY9samJ15+eI6Xu0oM
	ltUJBWE723bJklGp2FNUpu6/jbo0QlNC/rj4STRYepr0kx1oJO7vVlJacMQBm+Arw6T2kJdcG/Z
	BaR+MdBcz1XyDlVrksjLuB2irkCt9WW7T2K4zyN9SNM201PM0EHhbWwQTIHXkKQ==
X-Gm-Gg: AYBFou3Aw3WNp3CbJ6L479sLjMsm4BMdnOd8Z3GE4YNgwXcIqaeIJ28B2Cmn5Kj46Yk
	0exJwo23wc3mEjUDrxO+85/EogmAlBHYlWBqy9VAkNl2+xeh9JRQro2BEfDRrJOabWKhCEcT2pt
	lyEyDd+Ku2VNmOEvVBBgKPz4AN1ZHiycZp+herfNjbgTiNMIyhAPM5wGxynrBq8rB7mYx57x/ul
	cop9oUIqZ3szeFz+hdO1Yady18gGwO5OT2B0jpdcE1hyyv7NLVvwhqTPPpDXOId38y4vlY4zO2O
	7MhJKuN+O1gUOEXsxZBZCNbvQOsk+mz8LLkAMWf0/m+8xrLGgKtNHL2WNKrvYvzAWi4SSKcldtT
	GHK//NeC3aSaPgZnNeIY2svPqwK2m3ddsoQ4F/X+bgQ==
X-Received: by 2002:a05:600c:4583:b0:4a7:9025:5c3b with SMTP id 5b1f17b1804b1-4bb7da2633emr133918375e9.19.1795101423963;
        Thu, 19 Nov 2026 07:17:03 -0800 (PST)
X-Received: by 2002:a05:600c:4583:b0:4a7:9025:5c3b with SMTP id 5b1f17b1804b1-4bb7da2633emr133917645e9.19.1795101423444;
        Thu, 19 Nov 2026 07:17:03 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1522:6500:ac93:c62:f076:48c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84e47177sm29776395e9.2.2026.11.19.07.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:17:02 -0800 (PST)
Date: Thu, 19 Nov 2026 10:16:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: raoxu <raoxu@uniontech.com>
Cc: jasowangio@gmail.com, eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/net: Fix receive queue test in busy poll
Message-ID: <20261119101645-mutt-send-email-mst@kernel.org>
References: <005FA5F7354482C7+20261110051642.249640-1-raoxu@uniontech.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005FA5F7354482C7+20261110051642.249640-1-raoxu@uniontech.com>

On Tue, Nov 10, 2026 at 01:16:42PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> sock_has_rx_data() returns a positive result when receive data is
> available. Socket implementations with a peek_len() callback follow
> that convention, but the fallback for sockets without one returns
> skb_queue_empty(), which has the opposite meaning.
> 
> This makes busy polling stop when a raw packet socket has no queued data
> and fail to recognize queued data through the fallback path. Return the
> negated queue-empty result so the fallback matches the callback and its
> callers.
> 
> Signed-off-by: Xu Rao <raoxu@uniontech.com>


do u want to send v2 addressing review?

> ---
>  drivers/vhost/net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 4570a4ffbab2..10ed2d55ff07 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -538,7 +538,7 @@ static int sock_has_rx_data(struct socket *sock)
>  	if (sock->ops->peek_len)
>  		return sock->ops->peek_len(sock);
> 
> -	return skb_queue_empty(&sock->sk->sk_receive_queue);
> +	return !skb_queue_empty(&sock->sk->sk_receive_queue);
>  }
> 
>  static void vhost_net_busy_poll_try_queue(struct vhost_net *net,
> --
> 2.50.1

