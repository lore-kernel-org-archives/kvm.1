Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EC0383996
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779714613; cv=none; b=gGm9xrD/ZWvWcmev+/EPZJpuMqBsHX85k9j6eWEh0O7x4DUCRiXLJ3/kQ1GFZKE2wbidTiv7TooGxXnHTYdX5WBpqk3ryLdUB/jG6XPEQBKQR4clwEbDvvc5Y7x7kXf9Laa71mPJY7LVihqekVkduDU44AYUZa3pKnPUAJxz+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779714613; c=relaxed/simple;
	bh=BGZXA1mN8FhVP5FiDTI8b7j+Ir1HdkD6PebA7BvFpSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bf2JdMSajuKtU801kseIFg9vssKmAcWs55csuJuw6Yo+WlQ5j+NLtv0EzbWO83Bu8CHaZEucvTVQ0YBwBzYi4C9gQB+fLgo1sjnIJMpoVDyjqG3qGPsK4CmnASpNdy7i23IzNp2qMFxkpQCe8DBoPxpXQ019+EY8dNROKw+0dCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXewaeQz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V6TkJHq2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXewaeQz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6TkJHq2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779714611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwxIhTGbJtS9kc5tnabyAFBYHC9dUEXdNvoWrVinQAY=;
	b=OXewaeQzh7cOLfjR6Aud4xeiOGyPZywKBN5wNDO/eJFHr6WrB7Y3wERP0Ya19X/cWCn/1y
	S4bTwBUSMhNjw6hB1LAWLJ13H3MKQGFD2gR3ykYnfVG1w6jNE7Ndn8KFNZyNrmanGoACjd
	mFr1MQcCHEvWeWiYArZxWUOO0OMoyOw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-ZPaP9dq1PiqK1F3pZyiL0w-1; Mon, 25 May 2026 09:10:09 -0400
X-MC-Unique: ZPaP9dq1PiqK1F3pZyiL0w-1
X-Mimecast-MFC-AGG-ID: ZPaP9dq1PiqK1F3pZyiL0w_1779714608
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44cc3c9b2feso8474951f8f.1
        for <kvm@vger.kernel.org>; Mon, 25 May 2026 06:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779714608; x=1780319408; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jwxIhTGbJtS9kc5tnabyAFBYHC9dUEXdNvoWrVinQAY=;
        b=V6TkJHq2V6r/zBweIeWvIedUIJS+BYsasR4vbpVrO7pL0MTgbvx9ym1dFDm0H9Saxx
         WG3lsfttwQUZ36TCn5sNFH2XAyc3ySEijPBb1rtTV7bz6V3oqime0ni8S/gX8QNI98Ap
         8oeXmxTmeVtmFyDlbeZNF54FJLGiqucgomDDureDVAM0s1ev0RKL3k05W7BFwHwqTLNG
         GeDEINW6V1Ss3yn+yQkZqdUs4aC4zAoXVJfeJqzSfvM8fhzuwU0zENtSRVDkxNTIUUPd
         bPX5GChR+KE4VJ6ZLi5JPU5enR/8x5KFWByN1Af9x8skz1q9bh2z8GqlcO8qTVfq2Jnd
         2AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779714608; x=1780319408;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwxIhTGbJtS9kc5tnabyAFBYHC9dUEXdNvoWrVinQAY=;
        b=m99ZnIeUQreApoob9dNBL7nR+rCK39Oidn8rYpuNBE1hVB9gV8phAC9+5YVTYnTagT
         Efg3vDfeK0Jyciv9H3Mop0Jt9DTpYxEC177eiAWWgmUe4KDXJDRAvGLtRKB2TxPC+pd8
         eYMEQJgZNKBdAOX3FpXz6hzMn3o9tlSvkv00qM3g1m17L74EHOWCBJfybPlQiDGwyoGn
         kskxw5x293cCAdR4CkWvDYGhyKstzpC5DwuJUCdbmRXn7aW5aWduWgfqXjFHJ+Lo1QBu
         dQ7jEcGG7aJf2bU9dMjyIiXqwEmwpCLivCGuo5LDypkAMHJamZFRVUfRchkvcWO7Km+G
         VHAw==
X-Forwarded-Encrypted: i=1; AFNElJ8y4Vb8wgiKYeThz02aAzJQ+O+iGQrY4Z/8Ta4rFisasB2jFNlzi8hxQ19aRupPtUQRgJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnGEHY6e0GztyYXjEKfvwEjtS0JKaAM7nXkhR8BwB/w94NANgh
	kFuPe5ZByDG1DtdzoKk5sM3gC55gKHSnA8/h0ucnur73D3EZxY3RrQ8CdIbu67KFdiJtfm7/XCW
	UCNbYPsDB54hvm+1V40tSX5Nrd865Yg3W/f1Bv3ger87M5U6Z5qEHPA==
X-Gm-Gg: Acq92OFtTZfvx7X6qw/VvirlUlVhDJVK1q+QI0jwYKipUjQIdUvG5VZ6RfXMUX/e+b9
	RrcdS315CrQEohXQiueV7LdHbVsTdpWmhYtn3q4qv74I3QGy3kJpqzLMLBvgO9btXK8Ga9YMhov
	JPz2lYKqrWFZc2adkXw00rqqJSvVlg+fGeqWMIKuQAR4AF4dEVpwnhsIVc7t/4X1VsNJsJ7ilhV
	YxyuU3Nz6u9t5TKQRfL16nCd+PoLEeItgLFa/w0yDd4ySG23RJkedDSLzqTSqTh2gK9CKoJx2/o
	beUqsG9bwAE2q+CUbLGjzDhLaFvKQhnBoiEgO8esvcZaqIdiDO74Uh1nc9am9RXh2kmf1Jga/tF
	22fVu8OQPg5hq9O4s7UeYrS3nUNTndm4w8xXZ3wBdXWo5Lao/uJ9pK9LBaTidypN5iLdDrtbK9s
	y4OaXZrw==
X-Received: by 2002:a05:600c:35cf:b0:490:3bad:3784 with SMTP id 5b1f17b1804b1-490426bc6demr270215325e9.18.1779714605375;
        Mon, 25 May 2026 06:10:05 -0700 (PDT)
X-Received: by 2002:a05:600c:35cf:b0:490:3bad:3784 with SMTP id 5b1f17b1804b1-490426bc6demr270211505e9.18.1779714602516;
        Mon, 25 May 2026 06:10:02 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490424aa561sm118548825e9.5.2026.05.25.06.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 06:10:00 -0700 (PDT)
Date: Mon, 25 May 2026 15:09:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, 
	patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org, xuanzhuo@linux.alibaba.com, 
	horms@kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com, pabeni@redhat.com, 
	davem@davemloft.net, jasowang@redhat.com, stefanha@redhat.com, edumazet@google.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <ahRJS2bN9Bw_AKyo@sgarzare-redhat>
References: <20260521124732.125771-1-sgarzare@redhat.com>
 <177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
 <20260523173557.5cc4f4f6@pumpkin>
 <ahQbVxvbBEJZ3TBU@sgarzare-redhat>
 <20260525115314.3cf310e6@pumpkin>
 <20260525083859-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525083859-mutt-send-email-mst@kernel.org>

On Mon, May 25, 2026 at 08:42:01AM -0400, Michael S. Tsirkin wrote:
>On Mon, May 25, 2026 at 11:53:14AM +0100, David Laight wrote:
>> On Mon, 25 May 2026 11:57:45 +0200
>> Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> > On Sat, May 23, 2026 at 05:35:57PM +0100, David Laight wrote:
>> > >On Sat, 23 May 2026 02:20:29 +0000
>> > >patchwork-bot+netdevbpf@kernel.org wrote:
>> > >
>> > >> Hello:
>> > >>
>> > >> This patch was applied to netdev/net.git (main)
>> > >> by Jakub Kicinski <kuba@kernel.org>:
>> > >
>> > >Did anyone else notice that is isn't a bug?
>> > >
>> > >There is no way that a 'count of bytes of kernel memory' can overflow
>> > >the size of 'long'.
>> >
>> > It's more of an estimate than an actual calculation of memory usage if
>> > we queue the incoming packet. In theory, an overflow could occur if the
>> > user sets `buf_alloc` to 4GB. In practice, though, I think you're right:
>> > the memory should run out before we get to that check.
>>
>> The calculation is:
>>
>> 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>>
>> skb_queue_len() will be the number of items on the queue.
>> SKB_TRUESIZE(0) is the memory taken up by a zero length skb (basically sizeof(skb)).
>>
>> Unless you either corrupt the queue length or manage to allocate skb that use
>> less than the minimum about of memory that product can't overflow 'unsigned long'.
>>
>> The later calculations might wrap - but the multiply can't.
>>
>> -- David
>
>
>Indeed, I wasn't thinking. For this to even get close to overflowing
>we'd have to have almost all of 4G available to the 32 bit kernel taken
>up by this single queue.
>
>Revert, I'd say.

I also blindly added the cast to silence sashiko :-(
I see now that it could never actually happen, but semantically it’s 
correct, so maybe we can avoid the revert.

Thanks,
Stefano

>
>> >
>> > Thanks,
>> > Stefano
>> >
>> > >
>> > >-- David
>> > >
>> > >>
>> > >> On Thu, 21 May 2026 14:47:32 +0200 you wrote:
>> > >> > From: Stefano Garzarella <sgarzare@redhat.com>
>> > >> >
>> > >> > On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
>> > >> > to 32-bit values. The multiplication can overflow before being assigned to
>> > >> > the u64 skb_overhead variable, making the skb overhead check ineffective.
>> > >> >
>> > >> > Cast skb_queue_len() to u64 so the multiplication is always performed in
>> > >> > 64-bit arithmetic.
>> > >> >
>> > >> > [...]
>> > >>
>> > >> Here is the summary with links:
>> > >>   - [net] vsock/virtio: fix skb overhead overflow on 32-bit builds
>> > >>     https://git.kernel.org/netdev/net/c/4157501b9a8f
>> > >>
>> > >> You are awesome, thank you!
>> > >
>> >
>

