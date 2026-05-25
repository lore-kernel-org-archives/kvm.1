Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1CE3F4125
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779722191; cv=none; b=Z8MZ2LwxZDwR049fHocc42iMxPITko2YnQbsexrlLzm+NxGlz5lshycL67V/6+CYeoUjuhpsQXYRM2XbT2o7+fkaO+Ma8VLF5mIc88b0mxHeo2D/N+rfmoH1FBVE+ikHarfGEfQGYJXz+8bloZ/GnXfSZonV/YNEhwTEIZ8Hjm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779722191; c=relaxed/simple;
	bh=AJUSWFiE6Q27sPZdsP0TJj9XuNjCnHJMEQ5y+0iZRbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhGz3nJYTQB1KKliA5Y+ysltYN4BdQYlEVStJcrypvXUhJxVx+5KiRdeOUWI/vOwa5ALuNGaC/fhqEJ+xRYqS07CCy3mve3xOaY1rU937YrRYupTnFNkRrWDs4VaccZUjlSEWiJse607mIEeNr6FWBfuWfN55Phx3xdeXSB5rYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LguTpTI6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hAzRXwyX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LguTpTI6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAzRXwyX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779722188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRIUymRBu2V1hz/h+nW5xnuAvIV3Q2kXa6qoE0y+ue8=;
	b=LguTpTI6BWaTZH5ABb/3/RebpIGBfLjK8R2TXfxdx4gqJ3ZxGF/6fJ2KhhQ1dVqwTZrYGf
	kzOPyntBBL5YHpIzhPsAdtnOpwG7d60gFU4kaXOJfH6r9CPB5QMnxXhnlC7Zg21QB5KE+b
	9rPyz8oFIz5Yhi3RXpJKv3+uC/caXyw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-6qaqLFdVPSaImeoLA-tTPA-1; Mon, 25 May 2026 11:16:27 -0400
X-MC-Unique: 6qaqLFdVPSaImeoLA-tTPA-1
X-Mimecast-MFC-AGG-ID: 6qaqLFdVPSaImeoLA-tTPA_1779722186
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44d79da8cf7so7380159f8f.2
        for <kvm@vger.kernel.org>; Mon, 25 May 2026 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779722186; x=1780326986; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LRIUymRBu2V1hz/h+nW5xnuAvIV3Q2kXa6qoE0y+ue8=;
        b=hAzRXwyXAktwhDS3ouSPPjjPmrO7cY4ZjTuUsruD0+iZc8MiVfBSqoyfgzTi9zDQXh
         WNW9zvRgErVlYmPEeP1mimuzm9QHX0rcJuVAU3Dl/UeXSbVOIZXUDn5GHNbskNI7it/+
         Xm4riBjfeoDz7PLtmcL7xRrBl+MaGaKSvjFJvpePQuHLBfMZS9HYR8G13vWfBDzdEgkF
         1Nl31+f4MNNvI62Rbhsd2FFGDVC5QEvBe6xFHjDkishS8P5oKzT8o8CR4FophObKpMcZ
         +ZC0CNF+o9uRY734yAzsrbG7JbU4+cEIj+VHWFpVX+npsnr8y8iBG0F6mQRrqxLctJeE
         r+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779722186; x=1780326986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LRIUymRBu2V1hz/h+nW5xnuAvIV3Q2kXa6qoE0y+ue8=;
        b=rBfKU23AUHlC5ALhSFxFiK3ra43S1UhMizi4x0oEBw1wyu9dkZWoGfGpRDFrRoHEw3
         22VzCb5sFNQs7gfnAspqqezADz1r9OnCcNFshGSjzMbiB9ra+qzy4/+607OMazPdgslS
         x5RZvix4oCLe3RtqHL6KEMPwbwjy/rwjW9MwzNmpmJ17q7mHRLMSO0XaEzbGeICVDuvv
         wht1EcAKXuL4qZ9N8Wz5C58xnnd5iP8BMXal687qxmEzKHFBK8Pm4Z6U2TmExt1wCBD6
         N9OShk3EfUuxpULPTdPBLlW8bkRbabKCehrPpZBcvhtp+qS1vWu6Z4x+lMBr47ggEp0Z
         AK3g==
X-Forwarded-Encrypted: i=1; AFNElJ9w92yR+TJk0g0vTm0GF8dEnAMCvUAbyk3jPQkhRFsmLS9KJ8w2wwHOldYmpjTRv9b+Pto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+h0SFJbCHxAqwh+Q+Uy2vLZOSntYq7Scwp+8gDM08r6YESjWA
	+iouN7AZwPrG5LCcLUOcueNzKCpUXgs6tJBGQ7aBkf8A1R3V61Gv3idwfsjyJfKn1wPk7IMGAnt
	SpK2vNX146Meq5t0nK5X4HrPAx04qHQWsCoA0SXloVJfTQdkc9sYWiA==
X-Gm-Gg: Acq92OFcHvgM66kW8o9yCMKRH1u9aMww3W/TvbTtma7OMrBvXOeQc2M+ySq/FFUCW1F
	u0m+CR+U+MntYrfSu1qchrMaZ0QOUpwwi6xcViBNk4LbN7ILO59h7Fic5DXOlLCtMPCFvmlm5l/
	cuKVg3XMLDmRC4bs8pTaLWSL8H9i/Gdv24NweFW+eZvn3qKtW+MEvT+I9jLrWkdwaSiND1+rJ0R
	3vvTbuNPQhvT6ShHxcELLVR+jzP/KydDwRggmJ9fakoUeaFQGpaG3BiH5CEsf4jc0WXyb3JholT
	zME4myqnj8MAdIFUU8RUQAHNdfPS0OSyR9jtppKre5mn5IB2jDQoXvaU3mQIYMValxqGEmlC1sp
	x1fxKXVmANQGqDLYx7pNFOCj2QX9vTVDhvsyQe9iJsVE9nNuq7NBOhBJWanCJMsjaLWaAJk8=
X-Received: by 2002:a05:6000:29c8:b0:45e:8526:7dc5 with SMTP id ffacd0b85a97d-45eb38b3902mr16847539f8f.28.1779722186152;
        Mon, 25 May 2026 08:16:26 -0700 (PDT)
X-Received: by 2002:a05:6000:29c8:b0:45e:8526:7dc5 with SMTP id ffacd0b85a97d-45eb38b3902mr16847494f8f.28.1779722185615;
        Mon, 25 May 2026 08:16:25 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9de2dsm26855784f8f.4.2026.05.25.08.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:16:24 -0700 (PDT)
Date: Mon, 25 May 2026 17:16:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	patchwork-bot+netdevbpf@kernel.org, netdev@vger.kernel.org, xuanzhuo@linux.alibaba.com, 
	horms@kernel.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, kuba@kernel.org, eperezma@redhat.com, pabeni@redhat.com, 
	davem@davemloft.net, jasowang@redhat.com, stefanha@redhat.com, edumazet@google.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <ahRmBTnNMrg-oano@sgarzare-redhat>
References: <20260521124732.125771-1-sgarzare@redhat.com>
 <177950282964.1445071.6600517211632117224.git-patchwork-notify@kernel.org>
 <20260523173557.5cc4f4f6@pumpkin>
 <ahQbVxvbBEJZ3TBU@sgarzare-redhat>
 <20260525115314.3cf310e6@pumpkin>
 <20260525083859-mutt-send-email-mst@kernel.org>
 <ahRJS2bN9Bw_AKyo@sgarzare-redhat>
 <20260525155322.240fbd87@pumpkin>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525155322.240fbd87@pumpkin>

On Mon, May 25, 2026 at 03:53:22PM +0100, David Laight wrote:
>On Mon, 25 May 2026 15:09:54 +0200
>Stefano Garzarella <sgarzare@redhat.com> wrote:
>
>> On Mon, May 25, 2026 at 08:42:01AM -0400, Michael S. Tsirkin wrote:
>> >On Mon, May 25, 2026 at 11:53:14AM +0100, David Laight wrote:
>> >> On Mon, 25 May 2026 11:57:45 +0200
>> >> Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >>
>> >> > On Sat, May 23, 2026 at 05:35:57PM +0100, David Laight wrote:
>> >> > >On Sat, 23 May 2026 02:20:29 +0000
>> >> > >patchwork-bot+netdevbpf@kernel.org wrote:
>> >> > >
>> >> > >> Hello:
>> >> > >>
>> >> > >> This patch was applied to netdev/net.git (main)
>> >> > >> by Jakub Kicinski <kuba@kernel.org>:
>> >> > >
>> >> > >Did anyone else notice that is isn't a bug?
>> >> > >
>> >> > >There is no way that a 'count of bytes of kernel memory' can overflow
>> >> > >the size of 'long'.
>> >> >
>> >> > It's more of an estimate than an actual calculation of memory usage if
>> >> > we queue the incoming packet. In theory, an overflow could occur if the
>> >> > user sets `buf_alloc` to 4GB. In practice, though, I think you're right:
>> >> > the memory should run out before we get to that check.
>> >>
>> >> The calculation is:
>> >>
>> >> 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>> >>
>> >> skb_queue_len() will be the number of items on the queue.
>> >> SKB_TRUESIZE(0) is the memory taken up by a zero length skb (basically sizeof(skb)).
>> >>
>> >> Unless you either corrupt the queue length or manage to allocate skb that use
>> >> less than the minimum about of memory that product can't overflow 'unsigned long'.
>> >>
>> >> The later calculations might wrap - but the multiply can't.
>> >>
>> >> -- David
>> >
>> >
>> >Indeed, I wasn't thinking. For this to even get close to overflowing
>> >we'd have to have almost all of 4G available to the 32 bit kernel taken
>> >up by this single queue.
>
>Except there is usually only 1G or 2G available to the kernel.
>And all the skb would have to contain no data.

`skb_overhead` was introduced to prevent exactly queueing skb without 
any data (essentially containing just the EOM for SEQPACKET) that we 
plan to fix properly in some other way instead of queueing empty skb.

>
>> >
>> >Revert, I'd say.
>>
>> I also blindly added the cast to silence sashiko :-(
>> I see now that it could never actually happen, but semantically it’s
>> correct, so maybe we can avoid the revert.
>
>Lots of things are semantically correct :-)

I see :-)

>
>I didn't look any further down the function to see if it could be
>'unsigned long' (or even size_t - but I like 'proper' types when they
>are always correct, I have to remember that size_t is unsigned long).

IIRC here the main reason was to handle the next check with u64 to avoid 
overflows (buf_alloc is u32) when it was introduce, but maybe, after 
commit c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to 
preserve full buf_alloc") it could be size_t.

>
>The problem with the (u64) cast is that gcc is very likely to make a
>'pigs breakfast' of it and do a full 64x64 multiply.
>It'll then try to keep the 64bit value in a register-pair which ends
>up being spilled to stack as a pair.
>I've seen it spill a constant zero and do a multiply by an immediate
>zero when doing 64bit maths on 32bit x86.
>I think gcc can hold a 64bit value as two separate 32bit values; that
>can generate reasonable code. But if they get merged (eg because of an
>"=A" asm constraint) it all goes horribly wrong.
>This is why there are some asm 'helpers' for mixed 32bit/64bit maths.

Thanks for the details, I'll keep these in mind, really useful!

Stefano

