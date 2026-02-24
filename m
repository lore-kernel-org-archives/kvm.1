Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD133A0EA5
	for <kvm@vger.kernel.org>; Tue, 24 Feb 2026 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945841; cv=none; b=QJXEuEBmju5z9K7gdzG9ha5C2aVn2uJfEeHAWXUsds66LNEnaxGbk7/z9sgnSR/XI/3CLgOuHaw+rlFWUzTDOP1+eubk1pKcj5H3wUkHL7hr2zMlMDlNbXDdrihG3siAumcIThsOfTsvWS/JXoQyrBwInZDgtO65leLlyS0T62g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945841; c=relaxed/simple;
	bh=BSd3E9HvM832bf2kO/myULtnTWMJZqXPY/uCr6QDO2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrH6Zpl/wsu30YCYb76jMpxBCD1YyDEeDPbYZ1cjJQvpHGl9KBNqVSM9DW3uIBsR4WwBtG8DEM46tA/18hesc0sjXWDnx4XdYTUwNpoHxUZaytZk1RXL8kSi1V0KIOkGbm6mn21dCliD6YDUSrw3S59h0Mw+u9RRYTIdF6+rN4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8BZBiEA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ctx/NHPY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8BZBiEA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ctx/NHPY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771945838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSd3E9HvM832bf2kO/myULtnTWMJZqXPY/uCr6QDO2g=;
	b=H8BZBiEAK/gaF4kW89vzvCvJwvv5kjeLfj4rs7Lsg7KMZIGSFZDbx+7T3MikezmaHsyHjV
	0fSZUOcvTyfKltIrzPgrm1uGJb1140gl2DO5ZK7vP4xSCgrpygTDxoIQnHMd8bjmtQCCWr
	4p9XSGfOaN8wf3tptK7V1iO7pFvK4OI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-3KZgNQzsOG-f7vr0Buu35Q-1; Tue, 24 Feb 2026 10:10:36 -0500
X-MC-Unique: 3KZgNQzsOG-f7vr0Buu35Q-1
X-Mimecast-MFC-AGG-ID: 3KZgNQzsOG-f7vr0Buu35Q_1771945835
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48378df3469so40176195e9.1
        for <kvm@vger.kernel.org>; Tue, 24 Feb 2026 07:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771945835; x=1772550635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BSd3E9HvM832bf2kO/myULtnTWMJZqXPY/uCr6QDO2g=;
        b=Ctx/NHPYh/VlIhSL+ainpWSuiJKnfGC3Usql9ihCvxFiUp2vlmta+HpKLeDjm3AI/w
         fOgG0S/LDwYrkqy2mOAODcmzvgS3YJwb+NLg3KFKE5b37Mui7bekLVT7aIq7MV9wT3X5
         6IBPf2e1Bz72DRpBqb30IZweq1lDFj/Tg/HFUMp70asxmsNcszkQTpyp25yGs1qFw0D+
         kjyPZkTd3sXijGeXIMOOL8PxAV4Ta4CuTcKxQZUuOaTqNfeM8Pl44eFRnZArqycjzIqx
         NrBxURzteGK9i2yZ1L21G7GciE+EQ2cVH4NBTIabyQzCjX/IsNkyE44zGtF78ryIE0b+
         cL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771945835; x=1772550635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSd3E9HvM832bf2kO/myULtnTWMJZqXPY/uCr6QDO2g=;
        b=H8dE2jbkqCycdVE6BAVTa8aRMnGNvhNOdojWgL9roGu5WZj4AP/XK5qd4/XE/pgj1v
         E2A6lfig0wpvM30bZAZzNrVBuWZSAq5o3Ef5XIzqEuKTzlC9AGKzVDDG9BiYXXwhe1t1
         +QY6c6IRoRfQYFhV1X3hvcWAQ144SbhhPQ/X/E3zXhEJ3zSe4zoFUm/rBHBi0Na4YtW+
         YI1uNxfxmOqSL0NGFHb+fGuYPUgP6cZXVil4UfWI9rFPluOVh5ynmxxhcDmONM9BWwXG
         stdNG/zgIg62GDsnrNUR0E8JVn0g06KKtJnKRaEZ/lQQS1OcpKUQfYQK/gq460b585zy
         aynw==
X-Forwarded-Encrypted: i=1; AJvYcCW0ZQ5Kilisogl0hhY0H1P4KQRWRfIwsYFgSF5QawvG/623xyHdQAmZUOmpNk7Xu/J5LHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdA6swqEq9Ent96GxCKxc2HjO+Et8KezzYTeNlB64/Aa/+hm9y
	tXlKApvl0u4DgRR6yMJQu4vC+jPBP9H9DFMNnN+dj/v5zUa6KyxM/iVJgZUt2PK5WZcq9FBOecO
	OqpxEiVfEUVVRBn+C6YMxiyuE6mWB4zNtONWstVhEmp4Tv2KsBJPXkg==
X-Gm-Gg: AZuq6aLlbeGELkLJhQbA/gUhrbfFFuie6oJFGgfYJsPlgmtPhosEktUBAO1NL/zmutJ
	wZfo8exN+nuWtAuP9olfeVAQAYK7jmjuhDEKVI0KL8qYPigpVp/3FUVbmmTOuzl4RgvM4hOHiGR
	ztZ3/+TkT9QUKdBoJEWJuqpIiIuGFWFrtQmV3KD3YuT9siP1DpUzsph6/PNl63nPfuX14OBdimj
	7M5tFKp1I8ucdBNXJyv5uQBrOKndggo+DFbWh/o3qtPeBeGZmb+B1gAKf7/y/2Z9FduSf/B/c0v
	Z6BujKJGNCnZT/0RjeVZ3l5B0M9HZ+809XjToBStsKEQ8sXtYUs4Z7FBwoyTJo8hBB7cf3XvmuQ
	4NYIXhiiNXjY2969DA1YUAr5bTB8JnxEGn55DBhoPocaN5G7P+6aY3qEcqFmSPuDW3tEQ7es=
X-Received: by 2002:a05:600c:c113:b0:483:4b37:8620 with SMTP id 5b1f17b1804b1-483bd742cddmr3686805e9.10.1771945835282;
        Tue, 24 Feb 2026 07:10:35 -0800 (PST)
X-Received: by 2002:a05:600c:c113:b0:483:4b37:8620 with SMTP id 5b1f17b1804b1-483bd742cddmr3686325e9.10.1771945834815;
        Tue, 24 Feb 2026 07:10:34 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b8791a0esm73910215e9.0.2026.02.24.07.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 07:10:34 -0800 (PST)
Date: Tue, 24 Feb 2026 16:10:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	kuniyu@google.com, ncardwell@google.com, Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH net v3 2/3] vsock: lock down child_ns_mode as write-once
Message-ID: <aZ2_WfJ5NVuyZJSS@sgarzare-redhat>
References: <20260223-vsock-ns-write-once-v3-0-c0cde6959923@meta.com>
 <20260223-vsock-ns-write-once-v3-2-c0cde6959923@meta.com>
 <aZzvp52L4smGF7cM@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aZzvp52L4smGF7cM@devvm11784.nha0.facebook.com>

On Mon, Feb 23, 2026 at 04:24:07PM -0800, Bobby Eshleman wrote:
>On Mon, Feb 23, 2026 at 02:38:33PM -0800, Bobby Eshleman wrote:
>> From: Bobby Eshleman <bobbyeshleman@meta.com>
>>
>> Two administrator processes may race when setting child_ns_mode as one
>> process sets child_ns_mode to "local" and then creates a namespace, but
>> another process changes child_ns_mode to "global" between the write and
>> the namespace creation. The first process ends up with a namespace in
>> "global" mode instead of "local". While this can be detected after the
>> fact by reading ns_mode and retrying, it is fragile and error-prone.
>>
>> Make child_ns_mode write-once so that a namespace manager can set it
>> once and be sure it won't change. Writing a different value after the
>> first write returns -EBUSY. This applies to all namespaces, including
>> init_net, where an init process can write "local" to lock all future
>> namespaces into local mode.
>>
>> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
>> Suggested-by: Daan De Meyer <daan.j.demeyer@gmail.com>
>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>> Co-developed-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Stefano, I wasn't sure if you wanted the Co-developed-by and S-o-b on
>this iteration, but I added it just in case. Please let me know, if that
>wasn't what you intended.

It's fine, thanks for that!

Stefano

