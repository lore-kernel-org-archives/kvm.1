Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D249639936E
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551546; cv=none; b=O/11pE9S5FwLmGi71rT6fdrwShBFFgyG+D3ELGk6lFqx6DrX9s0AJBHk0vbQVyeVz8OUSz3Od7P+GaPFayRk7VgiBVE6Qy25jsjewQFAniiJE1Q/cCjE29L6r0z6yu72fLn2mSKsPVS95ucwvokNkBsroIDA7Mwgp3VesG2I9a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551546; c=relaxed/simple;
	bh=z7XMqNzqbaQp3YVbNCSinxYvK5mXLBbHoHlDC+DisRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7Q0qWkWiLjX21irMz946OLt0/UyMVk/I8YAkuGg4fdhEFL+Y+I2MEHbSSOLEm32PPHmTnC4ucrk+sB4B2XHJzYUfILx93+nb0agG1QT4s6VTctnKEw+2T7kKLBkdfLPbpOhFuByYPdoya+Q2LPGAsN31ZlrQakhJxJicvbYmUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NkqxTo+i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QuUh8Fwv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkqxTo+i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuUh8Fwv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775551544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=90Dv0Gfd1H3V0FF0ZZTa8jkFYwFCJbiDQpupdqGKTx4=;
	b=NkqxTo+iRgJTl+3PH6z3BvE2jnc96lV5QqQG2F7C2+ozTTlWnTiDAvfdP1nd02Jj+OrhGS
	IXSTrzay+1MbfVwHXhh1yDRte4oKsK/ogvwJn6zvPDQbGAC0DGJLyppJ5ip9+tlgGCBrIT
	foo5JIoHOaMCuWS+L31PddUQ+bfLee0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-N9LOTj4hPU-pyK23hVmmmg-1; Tue, 07 Apr 2026 04:45:42 -0400
X-MC-Unique: N9LOTj4hPU-pyK23hVmmmg-1
X-Mimecast-MFC-AGG-ID: N9LOTj4hPU-pyK23hVmmmg_1775551542
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488b6feb9beso6483835e9.3
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 01:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775551541; x=1776156341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=90Dv0Gfd1H3V0FF0ZZTa8jkFYwFCJbiDQpupdqGKTx4=;
        b=QuUh8Fwv5bfnd+aAjW7iR5w2eJktf60pi+AhtvXEQRhaUk7DyiMj+1ORH4KMoYL7eW
         vF/OG0nWF8RjfNsSBOTReiHwai79fos2stpwhXVmzrYsU6RrXz6jTkRVcwcRwhBXRdyg
         Ob+6WeHHKvRtln/JhrxEHcw6sYho9c8cFWqPmDozQVu8Cat6/Fg3m9bjexeeSWW4WE7K
         USaKERp2a7AAtIplsgUpgiERxNfGA1qfVrXI8I903P6vDuln2dGPX8Dm49ov2ZPWSyK5
         unqzwTjzuOfjtdv0Xn+4RR9wR1ilIu/N/23TUeM4W3D426JZ+rGJJBVRCAG2MAyq1mw3
         50Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775551541; x=1776156341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90Dv0Gfd1H3V0FF0ZZTa8jkFYwFCJbiDQpupdqGKTx4=;
        b=bwphn1qKboCUUa4/B98Guuc188e4wrvxmmuDLy20sRz/8jXfv3I2ZtfZX6CKFFp7qf
         KBqxF6TOTCHVdkRU+0YdMbbLKavo/aStfppU3ZfX3NsPFva2otLCoSpbG3PqZlj05B5r
         QGvXT0LMfp+szYTY/GiXegUpwPVwAX+ay7HS29oFiVSYC2uzhd8ygUN06zeOTMtIUSYI
         rlZc18yUaaWg+jCkEzgaNtEw2lr/enhmY+pjsR+FKDDObX8VYxce8VvLN+nt4iFjrZdz
         qiM1gBjMw+zS3ydbzwRnF+Jul04CT7lvUY13JbCr9CKaFVuoFPFuOjAI/2kC+bo2Zrgx
         rAWA==
X-Forwarded-Encrypted: i=1; AJvYcCVZmBSqECq5o/tKysTN7un9HMo3nz25b7jZ0ZJZwQrEx9OWAKVbQpEAI9l1CwT/tH7qWbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrnU4HEVg4yJV1mUJRjjMahQAJmo2wvQAFGEyFdM+HAn1PvH12
	KrpLpcwEFxe1Vjl+BLZXFt5sg2sZq0Fj23UrZvRrli1c4RaPCkUVLjvW6DGaY0yKxlO1Q3tsVJi
	2gGLtkfPV7XLfnqWn1XxkgRtgeARPgYzuyQ3feHEQJUvbZfeXXELckw==
X-Gm-Gg: AeBDiesuZzPmmShUYUoankKUn596RfBhCvi4gpbntS2Kv9Mk1nUMdBw+0SkU2pwPoQO
	/lp7m1PFmouV3d0pte1GQan1DDGXngoVtZsktQBwFFO3Rr5QTLosG1CQCK90QHnlCAhHVHwuph3
	pGy3jr+s9GTMdkI0+iQEK34l2tGRlVrDy/bUMnt5PGWdgXSor9tVmJfI2hH8FK8mpbqaD0Y9UmF
	na77NCtsyFzqpAdSMBF8VjEmWDrXSMMwaZEFSrTMKJIDJKH5qZnyGhb0mGm+7Vh2lLYUNtyK/bS
	lo4grMwNrU7cB0O48yjRxmWIHCEf7bMd2S3XjkQoFt6Xeyj0+4RsE7ycfmiEd2Dhp/EQy5L+C0g
	RUpLjAogTIY4qK8DBCRrbBrISbfo=
X-Received: by 2002:a05:600c:4f15:b0:488:945a:ed63 with SMTP id 5b1f17b1804b1-488995cbaa7mr243063865e9.0.1775551541506;
        Tue, 07 Apr 2026 01:45:41 -0700 (PDT)
X-Received: by 2002:a05:600c:4f15:b0:488:945a:ed63 with SMTP id 5b1f17b1804b1-488995cbaa7mr243063245e9.0.1775551541043;
        Tue, 07 Apr 2026 01:45:41 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a7165aasm527048625e9.14.2026.04.07.01.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:45:40 -0700 (PDT)
Date: Tue, 7 Apr 2026 10:45:37 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: add MSG_PEEK after partial recv test
Message-ID: <adTEDKJZklJgdcop@leonardi-redhat>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
 <20260402-fix_peek-v1-2-ad274fcef77b@redhat.com>
 <2521971f-798d-4560-b2d8-bb540591d4b1@salutedevices.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2521971f-798d-4560-b2d8-bb540591d4b1@salutedevices.com>

Hi Arseniy,

On Sun, Apr 05, 2026 at 10:14:26PM +0300, Arseniy Krasnov wrote:
>
>
>02.04.2026 11:18, Luigi Leonardi wrote:
>> Add a test that verifies MSG_PEEK works correctly after a partial
>> recv().
>>
>> This is to test a bug that was present in the `virtio_transport_stream_do_peek()`
>> when computing the number of bytes to copy: After a partial read, the
>> peek function didn't take into consideration the number of bytes that
>> were already read. So peeking the whole buffer would cause a out-of-bounds read,
>> that resulted in a -EFAULT.
>>
>> This test does exactly this: do a partial recv on a buffer, then try to
>> peek the whole buffer content.
>>
>> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>> ---
>>  tools/testing/vsock/vsock_test.c | 64 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 64 insertions(+)
>>
>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>> index 5bd20ccd9335caafe68e8b7a5d02a4deb3d2deec..308f9f8f30d22bec5aaa282356e400d8438fe321 100644
>> --- a/tools/testing/vsock/vsock_test.c
>> +++ b/tools/testing/vsock/vsock_test.c
>> @@ -346,6 +346,65 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
>>  	return test_msg_peek_server(opts, false);
>>  }
>>
>> +#define PEEK_AFTER_RECV_LEN 100
>
>Hi, may be we can just reuse MSG_PEEK_BUF_LEN which was already used in MSG_PEEK tests ?
>

yep, good idea!

Thanks!

