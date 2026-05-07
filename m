Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DB73B9DB6
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169918; cv=none; b=itwfz6AEWPDbwXW9mxZHwtJyShpURMwjGjT1dlTcdMdB5nQYA4cVYMKelRAWwcvVHtXovAjfezJrLp7GmHnKc24pNRu1j8lN7rtctVlJN+MVNrkNsbIDi6AkQ8qDeo2ixPWlOIp7fkdCO5eeKVSihkZQ7p15wcuJpkM9y6tTumw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169918; c=relaxed/simple;
	bh=sZ79yV65rGcfZNXlNxRvakvY2Z8WmdeNfaJ+WX7yPAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbIYiNlTGpL42LEJVYsCLe3yO9b9nX4WHwkgX3YHCoe7Hp9oh5i5EtL9QnVkhzaVb1bWDfoIPES0LtmYjLN4VRJydPgYZ/VmouwpCZPL8fRzQqv4M9v62PxDFHUDVd0ytis5wgtWxyJilypxT1/8MJ8wNtDD3BhaDQJ94ejnCNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGaxOrcd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GK1QSXhd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGaxOrcd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GK1QSXhd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778169915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SMkAzYz7L2YKNDrmJwl9k395tnV77yLFqHt9dixreVQ=;
	b=XGaxOrcdhj9tv/oASFZ4TED5Gm4l3yA1FbP9y2L0DmpH8Rhfm+DT78M536oWQobq9ORQmS
	Iy/HdFrURi/cJv/HEiyWAyZcisKI8uHI9snzBHEBnfl9etRhqFyW2Jvzaz7F816c8y6a4s
	6p/WjcEdz8yeZTR5GypMt84yEsVDKR8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-w3DCxKslPJWcPjRmBizjLg-1; Thu, 07 May 2026 12:05:14 -0400
X-MC-Unique: w3DCxKslPJWcPjRmBizjLg-1
X-Mimecast-MFC-AGG-ID: w3DCxKslPJWcPjRmBizjLg_1778169913
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48d05e7b117so9177905e9.0
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778169913; x=1778774713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SMkAzYz7L2YKNDrmJwl9k395tnV77yLFqHt9dixreVQ=;
        b=GK1QSXhdBe/uV0+4/ebp6JyNLvVoHeU5ZH7PrbVjG++te+52J5Socma5315sxdfYNs
         C4NhVpGJgxrZUfJqstfUJIcxfEGecCbrfCb3KizaW3LARuDGHdo19ZLpaRd6J1BtoWHx
         EAKVetMaudpRmx2Ot8ORJPle8dw6fpyYz/JHC5ED2M6TN8YKVYBK21TabFvCuzMMnDnE
         /pV8H8b2xEu850DZMJZNRi+hBX7j/EX4HwCRvtYVCrpTmli+K/mbH1UkI+QyFf/QS/rI
         Ivvv1JodWRviiVRcthxX/dvugJl3D1m277t9lMMC4fgqhDQEYQj7xrz+5M1ILMdRxBgE
         ua3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169913; x=1778774713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMkAzYz7L2YKNDrmJwl9k395tnV77yLFqHt9dixreVQ=;
        b=EYPKA8BlLRrIA0yXWZiul8E7ZVkb5PoFdbdAXCMxFxOWb2sWJzjnFE1chRDEHULXic
         /czS75vKg6IMHVD+VlUDN/eRW7GN9RmJ5TLJ5IiH69aHshaZVcn9Chx5B/knYahcYrHt
         LU/c5BWdmTXY3KGiKK4aqOLnjnCRecYJy3FpbYOk0KFnyuX3TkLy/z8iaUhf9GzvB21D
         dLpWKTCRkRVCc/+wzIqEumCKdq6h2Ol6B3vGMtPn2Zt1RRyYiAHOoJRRhBJAXcoxZOpo
         3HZ3twsigRCfF9JcsMx88uVthYMCqBOE5sSqykUuFQYYq7uxxQLdSrk0GJHmGcE0Iv6q
         YReQ==
X-Forwarded-Encrypted: i=1; AFNElJ9SkShAeGoEat3aFkcSTyu+Ku75SZZHPHmC7D/18vJ/wBew3hlAVhdit3T04zXR11bxTQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvlttqb86xkUFU/D3TwokAPEhxh+RXtxkFHrgsKQenbucZa0FE
	KyC/T0nPzK1/aDTfLK58RiRtVEFmwmixHrIYx0Eui900Bjf6b/VsYyi7K7cAc8XqlaWV5R7vDmq
	7a/M8+r8sJVQMW42wz8n7Ba7Ekw1osQkD1nhxYNjjrrRuwH54h3hKlA==
X-Gm-Gg: AeBDieuGXKo7T85fX6pXN5ru+gGG1JNNkLKN16yOqyXTDRdwN8IW8Eu3H/+E9IQOOa5
	7M/7zU3VqX9wMdpIOxTgGX0moyK88ll/ehGmM7F9xSUz3/zOKjK7WvE9l7jSJhe5bx65Ak2IbTC
	Wy704LuF2jF3or8svsuvPFWZooOFnwaFQQTV2NnV53m/MYucAGGAZHIOgH/b8hLmPRHWaNJpcIJ
	3qXoFP1eFrGohbPZh/r0P6+r8O2IugkEvwt01KPFX1c1zFKp5NJxFBiVHmlLZvKaRSzKl/jVSC0
	5PpKeEYf8Ecj/+IxycVl0VEZi0oXGtDAciFl6DdYDWyKLe0FiYwtq/02ZcfuSyuqRyrPnsveux1
	oI+X5Pix60644Zx35xNAMPMwlgfQkrCkUs9xjLlCdcgKrUl6CEBbQ8yH1cGrbvNM=
X-Received: by 2002:a05:600c:4888:b0:48e:526e:1012 with SMTP id 5b1f17b1804b1-48e526e10a2mr74268865e9.5.1778169913218;
        Thu, 07 May 2026 09:05:13 -0700 (PDT)
X-Received: by 2002:a05:600c:4888:b0:48e:526e:1012 with SMTP id 5b1f17b1804b1-48e526e10a2mr74268215e9.5.1778169912467;
        Thu, 07 May 2026 09:05:12 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a547bsm145700815e9.5.2026.05.07.09.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:05:11 -0700 (PDT)
Date: Thu, 7 May 2026 18:05:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <afyy9CeniTBF3o2I@sgarzare-redhat>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat>
 <20260507074113-mutt-send-email-mst@kernel.org>
 <afyMCyBvZpzWrLtO@sgarzare-redhat>
 <20260507073340.0604667d@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260507073340.0604667d@kernel.org>

On Thu, May 07, 2026 at 07:33:40AM -0700, Jakub Kicinski wrote:
>On Thu, 7 May 2026 14:59:13 +0200 Stefano Garzarella wrote:
>> >well if you want to support pathological cases such as 1 byte messages
>> >that would mean like 100x reduction no?
>>
>> Yep, but since this patch is already merged, IMHO that is better than
>> losing data in those pathological cases.
>
>We can revert if you think that the risk of regression is high..
>Please LMK soon, we can do it before patch reaches Linus.
>

Some tests in tools/testing/vsock/vsock_test.c are failing with this 
patch applied.

Test 18 are failing sometime in this way (I guess because we are 
dropping packets):

18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch

Test 22 is failing 100% in this way:

22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed: 
Resource temporarily unavailable


With my followup patch adding also advertisement to the other peer 
(still draft locally, waiting for Michael proposal) I saw 22 failing, 
because tests expects that can use the entire buf_alloc, but now we are 
reducing it.  So IMO we should do like in `__sock_set_rcvbuf()` and 
double the buffer size, or at least digest an overhead equal to the 
buffer size set by the user via SO_VM_SOCKETS_BUFFER_SIZE (yeah, 
AF_VSOCK has it owns sockopt since the beginning :-().

With that approach tests are passing, but I'd like to stress a bit more 
that patch. I'll send it tomorrow as fixup of this patch, or if you 
prefer to revert, I'll send as standalone.

Thanks,
Stefano

