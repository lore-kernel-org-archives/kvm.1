Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE98E376A19
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620101; cv=none; b=FRq097hhtsp8TpyFUvaJXpwSE7QCazE3UgLyva/HR+HmlLJ0guKd0aG3xxC+U6okpLs96rl2ZCcXEGWJotwXyriymuf03ucn4zXYLzMuRzg/BicHTwjne8CxRgOsWUiuo+LZAQ7H/cO3OJSgRqy3g/AfTInSrw7Z2/XfFlVND0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620101; c=relaxed/simple;
	bh=Mgo9D7i4SAm1ix+EblDUBSQHvAGRBPGGbt8S1ocsF40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0w+O3sDo9y/Wc3UI7ubUXigmsdOSzbxbH2y7glvoRAPb3iaSIqqfKDO+gN7J/+XOGorGf4uyB2W80LAofJLWGdMkRP3Ck+kGuaQ/o0tGoyhVnyPjlvszXUQUpa26EANg2IIBZgKP9l1zKf+FN14gHZZ7iH7Gkh6pVFnJrFqjBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HVgGzkTm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SbsULuEq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVgGzkTm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbsULuEq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781620099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e3l0uGCFBLNdzhr5oLMo3wkv8DBSjThMgB4WocmXwXI=;
	b=HVgGzkTmhHURXUO4qCbAe0LcvmHKJomiuv43Ciu6fm9LsUErRLq9fZ/BqTJcDVktvZZqQ1
	tcCDzvWlPeNImH0NtsuvHWwoELZK8AVF0B4KrpjbVUkfWvjznoY7cr5PKmpX+1xIjexTj+
	kLJqre1K3kiMCHWkIqZEMgch0j+pyCE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-4ZspwGaNOxaQmz1U-9fxKw-1; Tue, 16 Jun 2026 10:28:18 -0400
X-MC-Unique: 4ZspwGaNOxaQmz1U-9fxKw-1
X-Mimecast-MFC-AGG-ID: 4ZspwGaNOxaQmz1U-9fxKw_1781620097
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45eebc943bfso3246887f8f.0
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 07:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781620097; x=1782224897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e3l0uGCFBLNdzhr5oLMo3wkv8DBSjThMgB4WocmXwXI=;
        b=SbsULuEqWN/6QjyLMBRNIyT/b1Yn2Rb411BIM88ubifCTnrvDpuNkHKvtSaLrhKkLc
         8pnIhQ37T16HVrkKy5STEF0mtaRVR+ue75kFjUCFpEIpW/Q64ahCkNdZP+KBsPU58mZ9
         bDQ/6+pTgj3LTdXnpTIIP5L6UNJd2jdHGictQ/T+s106SwhaJ640IMsyH81T/SRy1BGS
         zet1jmyKhy1TNv22OueLtmMTff3h1gJk+FmJ4O++X9AHmLZHJP+AD9AIjRi9Hajw8IaA
         J8+QyGyXRIAuvBoWwcU7JykYp/7Ycwt5YoB1u2y5gR3sAfBCAxm46g/E4CT9hPR1cURv
         Sphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781620097; x=1782224897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3l0uGCFBLNdzhr5oLMo3wkv8DBSjThMgB4WocmXwXI=;
        b=aKx5utzfrGzlER3ShKFmrUtbDIFvmCe5sjdqm4TzivPWYTLJ2ZsYWy4TmEEVsaxjOI
         EdJBe+F1kw8bKcq7ZeYqp7edBeqzaicVIaO9s4MNkSKJdyM0hHaLj+Dv+U2TFbvTY16b
         8WbFxY6OtmwwvGcPDi3kpPeBuu90loHZAaKUGQRmCxHVCB7am++igzeVfdZjKrMZtqbZ
         p2+ONVWTlJRk93OpNrnG+eTPIv9M+O7dvv/6DA4XKCO+9nhTQwA6Ag375xrWrTS1Rkt0
         TkRw3Qci4hkLaipmtGPzHUR+aIjAkdfxlz2DDS/MZPDhddnLsvRZbNNWdSZft6qKs3Y4
         P4tQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4+xgHF/IGxG32eUlpj6DwHQAUIaCfILGDDlLb3dUBf5ASwjzPhUNBhUvq3S5cQqq/+z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUbRFDhV4KW9A9hMTCa/bij3K+jfh8x2TbzZob1jy4khLEShqC
	kDUc2TqTZYClHkU61NS4jTRasg6EB2OnZyAbtaBgYwSi6ywM6K60Q4xsX4zVJ1UPUs0EI65FGfF
	OZmPIpAcq/Xrgv/v+or2juD3MieJqiq0SedJCIola145vwdaepP3+JQ==
X-Gm-Gg: Acq92OEG19Je9YoT7MTfZYO7frWmxmOV0EM7FYNfI/VILijMQE8r/1MBJvdKDJA0eK5
	TbWr/CY2yxDeYEESUPNM887G4Uq08T0ZB/TimDN9QlS4B6+NksbPGyP3muzymHX79fDNmEtJtuz
	6m7WHWDfO/TQWSfQIBYwOL1qR0U0xT/El5OGF2LhMG8cV/2cyW72co9+HrDRxdtPFfcCVYsRgl9
	QxHNGlKCsc/LisYdUjGdBFm3+NO+d0crMsEtKl0x07wGy9zGUB9k9SDgCKkQ5SdwRPKpOMTjGze
	cMWKfYbRLz77XQIamNHCtGGjjqGqnBRJUfGEu/31+H3E7umQZl00ixW9Ii7+xDkRkrSWOv2Nndw
	CIw+LgZOZNKMSZJAlI9dJXL3tRxiyvPjL+TJF6WneNh49U+w/SfCNoQ92qdsmXhim2Ra6uqA=
X-Received: by 2002:a05:600c:a413:b0:490:bbc1:c9be with SMTP id 5b1f17b1804b1-4922fa492b5mr47691435e9.0.1781620096495;
        Tue, 16 Jun 2026 07:28:16 -0700 (PDT)
X-Received: by 2002:a05:600c:a413:b0:490:bbc1:c9be with SMTP id 5b1f17b1804b1-4922fa492b5mr47690935e9.0.1781620095878;
        Tue, 16 Jun 2026 07:28:15 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a9a399sm60380495e9.14.2026.06.16.07.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:28:14 -0700 (PDT)
Date: Tue, 16 Jun 2026 16:28:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, 
	maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com, 
	ptikhomirov@virtuozzo.com, den@openvz.org
Subject: Re: [PATCH 0/4] vhost/vsock: add support for VHOST_RESET_OWNER and
 CPR migration
Message-ID: <ajFdI921uj-nftA7@sgarzare-redhat>
References: <20260612165718.433546-1-andrey.drobyshev@virtuozzo.com>
 <ajFLvKcT-A0wvLYW@sgarzare-redhat>
 <4fa88fa6-a188-4c63-876c-ed748809bf0b@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4fa88fa6-a188-4c63-876c-ed748809bf0b@virtuozzo.com>

On Tue, Jun 16, 2026 at 05:01:34PM +0300, Andrey Drobyshev wrote:
>Hello Stefano,
>
>On 6/16/26 4:35 PM, Stefano Garzarella wrote:
>> Hi Andrey,
>> thanks for the series!
>>
>> On Fri, Jun 12, 2026 at 07:57:14PM +0300, Andrey Drobyshev wrote:
>>> Host<-->guest connections via AF_VSOCK sockets aren't supposed to
>>> outlive VM migration, since VM is moving to another host.  However
>>> there's a special case, which is QEMU live-update, or CPR
>>> (checkpoint-restore) migration.  In this case, VM remains on the same
>>> host, and we'd like such connections to persist.
>>
>> In the spec we have VIRTIO_VSOCK_EVENT_TRANSPORT_RESET which is usually
>> sent by the device after a migration.
>>
>> IIUC the specs don't say this has to be done all the time, so we don't
>> need to change anything in the specs, right?
>>
>> We just need to avoid sending it (which I think is what we're doing
>> here... I still need to look at the patches).
>>
>
>Sending this exact ioctl is guarded by one of my patches in the QEMU
>counterpart series:
>
>https://lore.kernel.org/qemu-devel/20260612165110.431376-6-andrey.drobyshev@virtuozzo.com/
>
>So we indeed avoid sending it on migration target in case of CPR migration.

Great, so we are aligned :-)

>
>>>
>>> For this to work, we need to be able to transfer device ownership from
>>> source QEMU to dest QEMU.  Namely, source needs to reset ownership by
>>> issuing VHOST_RESET_OWNER ioctl, and then target has to claim it by
>>> calling VHOST_SET_OWNER.
>>>
>>> Since VHOST_RESET_OWNER isn't yet implemented for vhost-vsock, let's add
>>> such implementation (patches 1-2).  Also fix regression introduced by
>>> the earlier commit [1] (patch 3), and fix the deadlock bug (commit 4).
>>
>> If it's a regression, should we fix it separately?
>>
>> Or is it related to this series?
>>
>
>Probably my wording wasn't quite correct.  I posted this patch here
>because we found the problem during testing this particular
>functionality, i.e. vsock data transfer + CPR migration.  And the
>problem was introduced by a recent commit, which is fine on its own, but
>breaks the CPR case.

Yeah, I figured out while reviewing the patch.
I'd avoid "regression" here and use just "issue", because at the end is 
just affecting this work that is not yet merged, so it can be a 
regression.

Thanks,
Stefano

