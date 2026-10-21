Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792577475;
	b=pD2B9RODpLdSe+ddIIlskmoPqgddqN48mh4JAfCNM0KsLCzgPKMAJ56kSGQNsrOOLXPr
	 C8iuW+3y99t6i9ZMjNN2AN/DMYiBAcCtNZbnSuyI2CDacwAAV2rKHTldK/efb79/f0xx2
	 O6cKbHmdLViYDlz3QIXaAleKlZmDG5+f8Hczc/RKJ0psF2IhdU080glDCTYnwqIJvxxMO
	 DA3QQku8LVDoiKf8IxtMGv0+EQZtEzUQCpKmubM510qrkg8AGLsbpAS5Djk6pwDrQS1dZ
	 G1HoAvMi376ANiFcsjb0BQxx9OTMqG8EpuWk/CV1ZHG7A9VfPEFXxyh8HNw/rkolBEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577475;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vVLJOhfTidMKw4MIf43k3Z+xniDsBdpWe5ByNjjrE/o=;
	b=1m6bfEkR5u9ABiY49MnfPRhGHuVJqrECtMpCon5LJfFRDJt4NP02dWdRJGwrb6z8HW1G
	 FwCXfptz8aU8PV46ge8hL30MAyHYcp6JBd0N9potKZ2pWSCc3t+3UHQXYjL0QM91cglVk
	 O6CG2/89Kya6A/1Kaiok6I9IGv6EGZK9L+OtVm2TR0xjob5UZ8YS4egOL2F/mlPZzKGWQ
	 qwsJL1putmTrcSVOP3ejn5ktn93h0FsVtUS3d9s9dUPLVQ9ixvD/sIVIebinKQZjsxroq
	 HyDaoCT95N+xWv6uHDMamhWUE8xf2BTGCcT2cVdfGcQBGBY05vKaCeMkWiDxzljJpoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DRJpuDgZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=p2NMMm65;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29818606A31D
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 10:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29818606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DRJpuDgZ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=p2NMMm65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792577474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVLJOhfTidMKw4MIf43k3Z+xniDsBdpWe5ByNjjrE/o=;
	b=DRJpuDgZ7LgJO4mT4LS0rmTR2Oit+nfgKj7EybX09VGAcbFwck8EgxgOKLEMi+fvZZUlEw
	ZEQ7SIOEFNXramMqkbi3fIlhVMWLKVB6GUUqUYOUJciRsvaCvjL3SDmrUt7ORVAwp2Tas1
	DQaWVlFzjGEhDHyQoMiDU9wwdfqCw2U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-OwCU9IIoOm6qyo3he4I58g-1; Wed, 21 Oct 2026 06:11:12 -0400
X-MC-Unique: OwCU9IIoOm6qyo3he4I58g-1
X-Mimecast-MFC-AGG-ID: OwCU9IIoOm6qyo3he4I58g_1792577472
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1e295b702so5265275e9.2
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 03:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792577471; x=1793182271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vVLJOhfTidMKw4MIf43k3Z+xniDsBdpWe5ByNjjrE/o=;
        b=p2NMMm65jqUj/I4P1B9BWGIMi03CnY7qLB07ZBtujZih+ki0UsAbslcVS2RDxNYh/Y
         o2MMminxeoAs0V/jx+OZTBzf5RO5ereCCprRDR9pxx0wCTK/Zz7oPSzfiE2J0EIvRujU
         EzSPPpgnyZVIGxuwDqaIzeo4/hfhsxkaAQlpY4dwJbyLi7J9KSLygKezm5TbHBggRyXN
         3lJ6ksGEVRgwPNI0sQblkaXKLUSeJ6clUYyNgsMUz9s4A4u9MHlKa8AHjjU54WO+6yID
         rxfnlBdy26X2A/hQnxRPrHn8oMD6vkQ0eJvUy+avYZqyFNoWTcqPhPN0k7R+bTNR/5ZG
         NLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792577471; x=1793182271;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vVLJOhfTidMKw4MIf43k3Z+xniDsBdpWe5ByNjjrE/o=;
        b=vWiA2qunHFPuOCB9rHfijW5LWwIygYjzui6kxMhHaX1fQFhqJYAD8VWHaHHfB49FLI
         1iE8i3R+lr96NPd/BrCbQOqfllgeAyDvSZ0YJulXFYTityYNjZcPQV8LM9mRZLFmAmkk
         9UUQeh1M/yktPbLmLf3TycFwJwAiIlfobIMSUIsvOLCQjHsfNyKte9Twwtl8aUcNjKr5
         2XPcT4WG7RbqFuf6pMPb+pjI5b9aEEKgVNi3rMsVGorijgRNfWcvOPNGYuzhW7QC9bWu
         k9sdy+Df6kDSGAj9t4RXOndyqrqQUxa2ASaZqwScw/EIzw70xB659PjJ5JpzBIfD6irP
         olrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxxOyuyAPIsgpfzIDrL6R1GucF0bboXuw9pvhNWmaizjumR0Gh6wgX+nofxLA5uR6JExng=@vger.kernel.org
X-Gm-Message-State: AFq9FYI97HKMHaFDEf8l91cNJhxB4t5OeBaRmJFd04YDBCSzp2/d+c60
	9+x3VXZvbpT3RWPsLIhjiJzEKPM85KCFrTrRnlY67c+X4jxrY9Hg0q1nAj1IdT5akQqziiKJnXI
	d0LzDdYv3/eYDc2Dy5zJUTUAEyy2Bk0H1fdbbdgJpUPFCgQH4cY87tg==
X-Gm-Gg: AYBFou20MqKJb1KvpUHESU94BoX3u0TygvN4B2yVk8las8cjOaldN0UABK0YQy9197T
	Ju/wycjiPJHUK0vvmJAQV1IFgiuAcoX6p0UtZGePyBpUKNpwtIfP/drwyimLcuTgU6q0/HsB/Ud
	JOAcpIvjzaGstn/JOF7c26EXixbh28CiIU3xHLAAsEiGG64dBoNwrtCrvoHvmVxeL3eTGA+XZE5
	2BsEn0BfX/BVL62tVu/1PnNNTprgrJvX4dHM7E3jISwQ8jgftNgcS/vdcw9rTMu0lyGB8hGXa8U
	voBQ4siyYaX53+FjNR63Q7T/xMlEcNGVlxNBuFhohuaXzunHb4byIJ3wgD64faLAPLnQnNcxnQl
	VwLbWnA==
X-Received: by 2002:a05:600c:34ce:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4a1fd8a7d77mr31195125e9.2.1792577470698;
        Wed, 21 Oct 2026 03:11:10 -0700 (PDT)
X-Received: by 2002:a05:600c:34ce:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4a1fd8a7d77mr31194065e9.2.1792577469551;
        Wed, 21 Oct 2026 03:11:09 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.178.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d699dasm152330945e9.12.2026.10.21.03.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:11:08 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:11:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@kernel.org>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com, 
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next v4 2/7] vsock: rename the vsock pernet operations
Message-ID: <atiPgleCntfwV4-N@sgarzare-redhat>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-2-047527cfccfc@meta.com>
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
In-Reply-To: <20261020-vsock-guest-ns-v4-2-047527cfccfc@meta.com>

On Tue, Oct 20, 2026 at 06:15:05PM -0700, Bobby Eshleman wrote:
>vsock_sysctl_ops and its two callbacks are named for the sysctl tables
>they register, but the init callback already does more than that: it
>also initialises the per-namespace vsock state through vsock_net_init().
>
>Rename them to vsock_pernet_ops, vsock_pernet_init and
>vsock_pernet_exit, so that later per-namespace work can be placed here
>too.
>
>No functional change.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> net/vmw_vsock/af_vsock.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

