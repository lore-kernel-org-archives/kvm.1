Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802495;
	b=UJ6YR4ayAfijd3uHVqNf7RcYZwbWoyHhoynilGblf4ao+3j9OmmLgF7xQoiIeHuuf85W
	 geINuOawP6neq/nyMWpCBSw1tqrjYX3FWfy36124SWsvQX6Klb6LHZLmAc9uEafEt928q
	 21cygxlzGFik/ALiDpE7ray1NVaTqug8RfXuVyOVnYyLK1KG9cDAinm+Ghxcl7G3Icmhp
	 yhsYqGQhXaBK9Z50p6HMFYRjK6ZFCOG78Ypc8LFLsYeQ8F5ZlQamuXzJ39ehMw0ueBwwf
	 T0HmLbYnyCK6FVET3rOOg8Bpgqt6fcaL5lWCCmSjvsmdsBx7YbcTuqyyOpDORAUqrEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802495;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4/Evz9fjrrpCnCXycWC63zfKI3HUYi26oAG2Biknep0=;
	b=q0DpAiBMshrlk/1E7aOkcYErND7Md89ns041aTzRxKX2F2zwPib4gm8OawNNZzQfiNtB
	 Kpb1p1EpcokKG4IA6nlGWJbAOf8MYDNwbICVvX+UI98MNnULFKYoz92VhASPoGyaz9Yed
	 W9+TnBXocCWYx8Us08O//kz1pb7iNSOWNtRV3ekaGPAEG5MJg2Q16V/25EqEEWeXJpq0k
	 87QUVGCp7Vw+ePcGfqkmKnQxQ670sgUATP/aoUpmtLpv+pAPLdd0091TKOE38l8/Q/59E
	 U2NNrcd3u2LIBgEwOGIfOhWiadCE4GWTo/qKmLrdOIIlI5P1v4K/I7ODvTJIF/4qZrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UCCgpa0h;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="iaIe29/b";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B153606A32F
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 14:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B153606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UCCgpa0h;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=iaIe29/b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793802493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/Evz9fjrrpCnCXycWC63zfKI3HUYi26oAG2Biknep0=;
	b=UCCgpa0h1y5+YbuN7Y9mcWyeMbYvSsWTkRRsjbxugC5r8oPcixNo2j0t0+l0nJrPbeB9xo
	nwbUclSoDqXyo6cVKm4u0py2WzalOC+VGMxyhMM90ycDKgpIIsYFamqAVgtByNvLZlpMgU
	4SGvFc87JltRAOQicXyH75IoPEmwx5c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-b-Jda3qqMI-miBrv0CFvMg-1; Wed, 04 Nov 2026 09:28:12 -0500
X-MC-Unique: b-Jda3qqMI-miBrv0CFvMg-1
X-Mimecast-MFC-AGG-ID: b-Jda3qqMI-miBrv0CFvMg_1793802491
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48b01a74792so680427f8f.0
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 06:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793802491; x=1794407291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4/Evz9fjrrpCnCXycWC63zfKI3HUYi26oAG2Biknep0=;
        b=iaIe29/b2YAJYfvUKG9cgMgWKhkRRPN6mzfVnfyEm8iti9EoypvstgW8Bw5glKA6UH
         5Cw/+Ha578Ab+8w+SBkcDKs2Nx3V5dwxF0HoBVFOA3czWMkpL3WEvst7hz5u2qzBVSS2
         YsNmt8+IetDIVVchHMvRPzn8XwBs1u+xW0VMv5IJEe5iyzHhR8MzAejjvga6/5BmXoth
         Aa1HfCADmvVtrEOQsKoXJi61pO8gwhkYZW8IcTbYTxmPxks+k9F5Q9mbAmCIGcTTG8Rr
         YrRPM3MfwQcokwlLRdP9zk+kdtGpuOIUw8dXhFbQC1xtLpQTJ7fDS9APT0nTu+NcMLyn
         3Wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802491; x=1794407291;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4/Evz9fjrrpCnCXycWC63zfKI3HUYi26oAG2Biknep0=;
        b=T+NNBnDdfxvfNjzbyK+GVgG0n9ASx3xmDXBhyE1oAoh3ZUuu81aYFn2QjQT006pQ0A
         92RPvo/7BmGMmXykegvCi28BgbU60j3v/thVBsHUcABGAV/x7jHqSHsCfTeddQqFk7+y
         aFxFsnZmHNSJ6ye+/tctx0Fyga3aN+jlJG/9S6+4vxuT8jumG5EGTKv1Tf2+K81c7BFh
         nle6YNstolxcm07ZA6aWLcvgT3FFJUem8aLiyOHBPfIY58uNRdiBL5RPtsp4q4WHvxy+
         kZ9anGuyIIKPurMDSHUXnZ+WcBYbbqQMPrG7Q2LXaxAM1gR/sfhm4J1uEkvAymg4/5eu
         kjCg==
X-Forwarded-Encrypted: i=1; AKwUvBzEN1tWc5e0CAXKbPLO28cbgLkfGl9qkLWDySFrzedcJGqMjSOeqVrR4Wv0NtRfacTEko4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8XE/QNctqLp48WGYntFyRDDTHPc/Z6vU7ubvQD1Hs5F8B1qAbm
	CE7mL1S0WxgCh6ZdhTwamsfP/jtd00C5MaZgx7kgNjlIWKUwwncoYJ0gRb3pYTLKnbV0UiB3/H6
	zndSDLgHMz/cPwTCvsnGJ7m1PJG9Gtqzv2y9z9450t25+UV076WSgag==
X-Gm-Gg: AYBFou3lIA8O2Sh3ScOF5jcnYm9VaFlLHjenw0vpbIJgQ1YdHT2dLQu3KwIl7ST44MZ
	VcPqedZf7ROj8Ls0JjzyovdTjTW8nJp4P6Qx1P/4CxU3ebmL8VbIkWRVgBAiXoWkDZVIw4VjMYp
	gQ4OwkIvqd7In/EiBHVsqJdFB5pwyf7o2l1MLkvXvkU/D7pYBG+fPhhDiheGwSZ+1/RRMIIZnqY
	0hP6fB7k1ftFDb8j1OIEM15vXuc3EBwU+v26I/Sys5ra0411i9pM0V5vVDvfHsRY/8yqhbLVhnR
	AfduEQiHAWy6Q7T6vPXFZoXxmEACMJ1F6yt1u/92pbaid9HcqAgdRgy7l0s2YrruA6pXBiwhFI8
	YuMRqpNFAT84q815NEyEUJiCFh+tR3UdUZEfs72894ecqPveuaG4Usu9L62FF5GjKZy0fTm9VEm
	GiHXeqQcbCfhIcKPecWXT5XJmPaNgBGzjdc95IFWUvZJU=
X-Received: by 2002:a05:600c:4e08:b0:4a1:ce33:1536 with SMTP id 5b1f17b1804b1-4ac1719112emr360222155e9.9.1793802490768;
        Wed, 04 Nov 2026 06:28:10 -0800 (PST)
X-Received: by 2002:a05:600c:4e08:b0:4a1:ce33:1536 with SMTP id 5b1f17b1804b1-4ac1719112emr360221625e9.9.1793802490212;
        Wed, 04 Nov 2026 06:28:10 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a9faff90sm162472315e9.5.2026.11.04.06.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 06:28:09 -0800 (PST)
Message-ID: <ae9abdea-6c34-4386-853a-862f5f16b031@redhat.com>
Date: Wed, 4 Nov 2026 15:28:08 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] vhost/vsock: size receive SKBs from declared
 payload
To: "Michael S. Tsirkin" <mst@redhat.com>, Daehyeon Ko <4ncienth@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "David S . Miller" <davem@davemloft.net>, Will Deacon <will@kernel.org>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261004235101.1464007-1-4ncienth@gmail.com>
 <20261104065405-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261104065405-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 12:55, Michael S. Tsirkin wrote:
> On Mon, Oct 05, 2026 at 08:51:01AM +0900, Daehyeon Ko wrote:
>> vhost_vsock_alloc_skb() sizes the skb from iov_length(), the total guest
>> descriptor length.  virtio_transport_inc_rx_pkt() instead adds hdr->len to
>> rx_bytes and buf_used, and budgets each queued skb as SKB_TRUESIZE(0).  The
>> guest controls the descriptor length and hdr->len independently.
>>
>> A guest can therefore provide a 64 KiB descriptor while declaring a zero
>> payload.  The descriptor-sized skb remains queued, rx_bytes and buf_used
>> remain unchanged, and only the fixed queue-entry budget limits retention.
>> This is not a lifetime leak: the skb is freed when dequeued or at socket
>> teardown.  Repeating this across connections can nevertheless exhaust host
>> memory.  On Linux v7.2, 455 such descriptors retained 30,255,680 bytes for
>> a 262,144-byte receive buffer; a full-payload control retained 265,984
>> bytes.
>>
>> Vhost previously read hdr->len and allocated pkt->buf from that value.  The
>> conversion from virtio_vsock_pkt to sk_buff instead allocated receive skbs
>> from the descriptor length, introducing the allocation-accounting mismatch.
>>
>> Copy the header into a stack object and validate hdr->len before allocating
>> the skb.  Size the allocation as sizeof(hdr) + payload_len so descriptor
>> capacity no longer determines queued memory.  Check payload_len against
>> len - sizeof(hdr) to avoid addition overflow on 32-bit hosts.
>>
>> Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> 
> 
> Weird that this wasn't applied in net yet.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> let me know if you want me to apply this.
Someone change the patch status to 'Not applicable' likely assuming it
was vhost stuff. The patch fell out our queue, but I just applied it.
I'm not sure if the bot will catch it up, given that the patch is so old.

/P

