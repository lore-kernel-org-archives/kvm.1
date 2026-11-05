Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869591;
	b=LarErQPaSnnesBwKDR7O7uupB1i9A0etzRDgmNTAFsNHC4w/t3WYvvR8uQ6+sXVB92EJ
	 bcYeHGJWoPJJ4wZSs7dF86u9RpfD0Oe5CDmUdaBtAswhFEMu03MVIKTZ3Z8YAUuM1lKkr
	 LlUEcuzsl2T//SKmcc6vrQ5vzFnk5SrqpMU/e14dEmBHjsxpgGNcj2qKaN1I9XoLk0Qn/
	 8Mn3ogsSVvBUsJ54zCdddYwKy44VFOcaL3z+zU9oM7ZqTDIGbH6gIjHsEfM0qvOJnfOFG
	 B/3lJp3dLImWh0euflZ4zuch4EBT8lNe8ignAs7T6mEzX7t0W6t7ovFQjT13F0e0Txg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869591;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=sXaBx9Aij9/vZ7m2OstPYoIGvXFxlj8rEgSuIQIdBWQ=;
	b=zJHqqJaFML728kVopHXcRundZGk5guxrN+jgD4Vg2oA0LfYTf2tOjcw2lmVER1F1eoJP
	 3uKTUpmjVHU2Xho8NyO29ukRFnNr0QwSqHXFbzPqhrASjpSWn+b/uUsGyZ4Ll6XQcqbrc
	 oYfEXdOpO51J7wyr/Zo/s+i/KydNDAdDMWVnQQxe1RCq6UcZu+4L1ShEFE0IFBX4HI9Ze
	 CTlhVYK78xeysWM0oj7FR86q+5Pk7gdHof0bghjWK4sQ3PeRoyn9Sdstcg8/svVqSOf3b
	 HrWIFMpHno563dFc9Xk85CHnX6hEXtwf2KJ4MtEdvbf/gtfW9jfe+sq8gfB0zO4kf8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MCaXKPc9;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=LDFA7cp5;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD71606A32E
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 09:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FD71606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MCaXKPc9;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=LDFA7cp5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793869589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sXaBx9Aij9/vZ7m2OstPYoIGvXFxlj8rEgSuIQIdBWQ=;
	b=MCaXKPc9aN0fAL8Vmah/490+jJGBSEw/qnPWHrn7yvGkqJkaepA6knzlUsynRNk24BEAoj
	XxsmAme8afGsvwlvkgN1KhptCbcaq6ZYwkHxAx7Q1I1ZuSMjUK3hzzmLdfFcKt5feIXole
	0j7czpxW+58iyv6+raNmxNifNlYvYGo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-BRYnESxbOuCfWTtEem1cQQ-1; Thu, 05 Nov 2026 04:06:28 -0500
X-MC-Unique: BRYnESxbOuCfWTtEem1cQQ-1
X-Mimecast-MFC-AGG-ID: BRYnESxbOuCfWTtEem1cQQ_1793869587
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-49205554e17so41606f8f.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 01:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793869587; x=1794474387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sXaBx9Aij9/vZ7m2OstPYoIGvXFxlj8rEgSuIQIdBWQ=;
        b=LDFA7cp5xhvjg7esDfWeYiNPdPFyqkYUvXry59Mm9WlFfl7VkUeXOFn7Vo5z3TfqT6
         G/hfh/eKSBuLCqc79qnntLKBCFb+UbjRgzSTbat7W/t46ybQqwKa6eTBfEURVzAxK0TX
         B4IfEA3H1Oow5E0RIJPO/Ctz1TX+bcNPnEl2HHLt6KlwhgomJ+WAZX9x4+oEgXQGvFgb
         pqaH42JDWV4CsyTJdisLYO/uTnu6NRkR/YGYiF1J9geI4E/hw4BZIGoXazQkn/lGtdW4
         IMYY616y4Iit0lfyEHn2Hk+82bQ/p0+epvcwgiLJMjXwl3SmRCxiZNyMW/GCZbRIAcP0
         HCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793869587; x=1794474387;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sXaBx9Aij9/vZ7m2OstPYoIGvXFxlj8rEgSuIQIdBWQ=;
        b=CtAKBpKcYodPLUHDULfitC5DBwd5eepoUf7TYynf8ZGTImIQer3LjTgq574UPf8lFB
         Q+Z+W1gWEqbUxNGJzdnzTor7q5MsYHqAd+/KpYhq7Wg9XowUym01T9I7D/nNxgxdWzwK
         yiLYMPMrY37YH3RtlCWznCtrn+BgKyKtaHVWk7idLaZI50/CTYs36BWfUVMXQaHbaUDt
         ON/d9QGo43dgxpPm8RXW5nwTnzWNMn8s4YmZNfxlILUd+zn5GVu5u2/UvxTcHrgmRRAb
         s7ruH0Qoha3QM3xsgHjHsFWrjaGqUGrBR2sLBez5QatdRHBLFwqgAYSS/raeMtjnJXC0
         tyGA==
X-Forwarded-Encrypted: i=1; AKwUvBxMLQJ/oMCbUJ6BdYbf5cFwv56h1xOsTobeJLGU+lC4DoGlMpDL9c/IrDs2mpYkSjcjvJ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z929jaZ/y+1BiyyDcUCdiYWfzUeO1Iieb0T8Bbkqol49YlALWaK
	8Ryt613VBnFyejeL99UzZN1hsYgKc1BF0NDrq2/LdhxSOBZJavjFFvIWfttFSUIK+UQlKBkRRpk
	GnBchPyHHj7HTFfNLDG3MACj4tB8DvDHxky0LHPqxZCPlHlgthWIKRw==
X-Gm-Gg: AYBFou2g+CvWSTUJ7mpD6FK9GSbHx6/f5qtf6V27BpyWAbAKdALPCA6y2ZiOrtcihXo
	ZKlMcgP6hYR+wIc+aioXM+KwHYGH9HBtE3W70+E1f0fH03ak9kNuK1WNuD3hCCLL4eaH8CHj3t3
	SNsMFkJulqiWunSZtr7KEgqXy3EZ+diZ+yx96kteIXwSjwZVD9Q0rSkY0ja7imWfBJb6WDcYZkI
	0W6VdfLgz7WKpwsU9A+kGDdLhKXlkM+0Yyp807deAx/5Ednk2HLk33SgM9oCBkkX8X9mkWN01ht
	ND1Gj2h+7tUvqVeOlRW2FByo6p8TdAftdzxyp38UcVF4EvCYf5Cs2iu0RnV3vKzAFJVmwg0msTu
	ZnepMz+DpKBjENy/7IqhvYkrqC4QAK3qW0YT0cW4Qseh04RlAr/5D
X-Received: by 2002:a05:600c:4ece:b0:4a2:40:8d2c with SMTP id 5b1f17b1804b1-4ac17b2c396mr392373305e9.26.1793869586733;
        Thu, 05 Nov 2026 01:06:26 -0800 (PST)
X-Received: by 2002:a05:600c:4ece:b0:4a2:40:8d2c with SMTP id 5b1f17b1804b1-4ac17b2c396mr392372195e9.26.1793869585957;
        Thu, 05 Nov 2026 01:06:25 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46489sm49581765e9.3.2026.11.05.01.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 01:06:25 -0800 (PST)
Date: Thu, 5 Nov 2026 10:06:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, bobbyeshleman@gmail.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/5] vsock/virtio: factor RX skb metadata
 budget check
Message-ID: <auxFXGVwY5IxlP5L@sgarzare-redhat>
References: <20261103041134.33310-1-physicalmtea@gmail.com>
 <20261103041134.33310-3-physicalmtea@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261103041134.33310-3-physicalmtea@gmail.com>

On Tue, Nov 03, 2026 at 12:11:31PM +0800, Jia Jia wrote:
>Extract the skb metadata budget check from virtio_transport_inc_rx_pkt()
>into virtio_transport_rx_buf_full().
>
>The helper retains the existing condition and will be reused by a
>following RX batching change.
>
>Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 12 +++++++++---
> 1 file changed, 9 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 43325d7aebbb1..2a9cfed085515 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -576,11 +576,17 @@ virtio_transport_collapse_rx_queue(struct virtio_vsock_sock *vvs,
> 	skb_queue_splice(&new_queue, &vvs->rx_queue);
> }
>
>-static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>-					u32 len)
>+static bool
>+virtio_transport_rx_buf_full(struct virtio_vsock_sock *vvs)
> {
> 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>
>+	return skb_overhead > vvs->buf_alloc;
>+}

As I pointed out in patch 3, I'm not sure we need this.
After we introduced the collapse, SOCK_STREAM should collapse rx_queue 
before hitting this, so not sure we really need this function.

Thanks,
Stefano

>+
>+static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>+					u32 len)
>+{
> 	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
> 	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
> 	 * metadata. Check payload against buf_alloc to be sure the other
>@@ -588,7 +594,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> 	 * queue growth.
> 	 */
> 	if ((u64)vvs->buf_used + len > vvs->buf_alloc ||
>-	    skb_overhead > vvs->buf_alloc)
>+	    virtio_transport_rx_buf_full(vvs))
> 		return false;
>
> 	vvs->rx_bytes += len;
>-- 
>2.53.0
>

