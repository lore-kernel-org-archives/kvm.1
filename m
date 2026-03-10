Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455D0363C56
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134827; cv=none; b=CYbna017A6B3G1NvUfDD/5jvsGBo0tVkkQZaFGIvj+BQdkJpNHa4rdBdI8LCGYH9mE/tGMFTltrj/wHWZeRGHq/7/l03DlHnWKkwwB2YJX39QzyQECee1K26Q/6tx9YiDq9KogS9Tmky8NtQAzvW2fxPZJzqFoLOnD6+4BvPg4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134827; c=relaxed/simple;
	bh=prO5jcc8QDr/hEZyY6kj9FvhTx8zB5lagn1VGqip1d4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hTP+mX6atWxHJjuARGhACYYS7/2EbbAAIn8Fk5Hlea8l+iubAZIohZDC+KjuL1YMDQztUgjhJ3FPDm57wYEg24C1gzOVEFQI+Hsv729JUEYvwf7GLrmoD3dRsH4f2FZDUQPCsKcGixpa3YuMy+bJSkw3xWXIUDg+x18xKrAr3+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+KVys5T; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6t7bpdV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+KVys5T";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6t7bpdV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773134825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z1KrvmYp6lBxwgMqOHTT+joFxW786mg3MVzokkCHO1s=;
	b=X+KVys5TGSxPXevBZsu2h7tseGI/pWZVW/ONI/057G4BnKP8+Rdce6MhmWxb+o0tDiuJ+K
	YxO0pyP6qrRvqRpkFrcZnzzKOaNsU7bs5qaEbJL+wln3dWnz7T2MbBRnQpbCzZn4SPxX8/
	XvSJNZmCxhSoDppSPLsCcb1vsjxiqcg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-Cu17Eo-LO763GH5T6nyPLg-1; Tue, 10 Mar 2026 05:27:03 -0400
X-MC-Unique: Cu17Eo-LO763GH5T6nyPLg-1
X-Mimecast-MFC-AGG-ID: Cu17Eo-LO763GH5T6nyPLg_1773134822
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4853ab1cae0so18644845e9.2
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 02:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773134822; x=1773739622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z1KrvmYp6lBxwgMqOHTT+joFxW786mg3MVzokkCHO1s=;
        b=S6t7bpdVbpym1WyJ2YrAK8q9/V90gCgAHJbQgzhOAp0BZj6wU/1+xl9zT/7JPkVygR
         Zul2w2cMarPyt7g13dtgttOpChhqKcCZkpFDAeljvbMJU4WTu3sPXIrmrh+MSNAR9fHK
         WDK61MswNJZBFuT/4oRwHCPGu416KZA438yaqmGpD2uYChe55iDjpvCEHbAjCklMrdoK
         +pmBEuEuqtqi+/JqphJNdEASrVfi+LqoKW25oKs9GYXQDW7+6/Bf+f8Z7iVPmZhh6oqb
         22eWNlTZA1rb/0le5vxgsnfrpQPvo2ytbjIyyJ3GEsRJ9uNeWOGIgfqVpucR/2t5/emG
         jOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134822; x=1773739622;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1KrvmYp6lBxwgMqOHTT+joFxW786mg3MVzokkCHO1s=;
        b=oP6DN0Dk/ZWDJ8KfWgsH2SjSAwzcDimJuTOir30N75U49Xqf1LnmZsjQ8VhHwxfxC4
         pvR0JZpzCP5Slg27jaitrpCBJM7g8fzadoFwo0MtYSiM4/aLxGINccgPNz1Ob3Bd/DS3
         ClviqrlpUj4UK4sR2PPCMv9DzLQpDeW+SSPhSOn6ZyvFEOuWzA1WQ3bOip7EfCND2Knk
         VDV4rC9pKcizLTnMGXShYL0qLVQng2QQGz5r+rsO7LlEclNUSComH+RAJFzigjQY8Tc4
         uwXiqKeAjCjuZ/hM8qM48tta8+p2uRLUeDwfibyfA0BRiuoy0BfMNK1Xo7/Z9PS68F8y
         JArw==
X-Forwarded-Encrypted: i=1; AJvYcCWHKed2Uq1ZzphDkYZjc18yPKhOTNSS0G2hm/ngOMdeJ8eAlxd0k1eMkbz8JArRMVXO3yQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwdpDzrLBvZIPu4nPEi47MfT+x4GORKzEsOTiIZAnhLjYXO4T
	p4QsbSAUCfkH6Fv+7h4dLUDIi+Jxq35LcpOZCoJt93EeNtTCzmFCTAbIofAnuirgDfGuBiJnhDD
	+6ZNtIaqeeOd32GG98RnrnVruNYCvQOSgZHvcvC+Rh0Ciq6+QRUbbqw==
X-Gm-Gg: ATEYQzwxsMHWLjuJ55N8XhQ1CTjLF0zLG1lyxbgz7oh3K190MN5Y02q5LVuNvGpLX5Y
	HpsWJCDGJwM69ks0vScB9vR0S5yIndyPNc7HdU41VJA7w80QLkpOhd7+0IHhFKb5GoVnW62LWXV
	5+frxn4SXZDnEuUatqiXffOmQgczJVPT2jN/XZ6BLSdP8PNf0li2F9wGe51dXYKVy6UyOHUqQdd
	N/M6Kyy9j9M/MIYuhrvae6WGIaLyMSlH49NnxqoUekuz204a1ZlTCnU+ZKzyXT/6BdKleMeQehp
	MXDnHTWeepAbAlZKlU038Tf2dcZg0T4Xb+YaE69uV0rxTlz7kpjNduBD91yohp40lqfQhQJDDrH
	qi8SmOuPAm1F2oc/EUL0ec8FanZOr0a+UB17QaTftL7WObOoBDE8k4dRz
X-Received: by 2002:a05:600c:5490:b0:485:35ee:f836 with SMTP id 5b1f17b1804b1-48535eefa3emr126931095e9.2.1773134822159;
        Tue, 10 Mar 2026 02:27:02 -0700 (PDT)
X-Received: by 2002:a05:600c:5490:b0:485:35ee:f836 with SMTP id 5b1f17b1804b1-48535eefa3emr126930725e9.2.1773134821691;
        Tue, 10 Mar 2026 02:27:01 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a8f610sm103923765e9.7.2026.03.10.02.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 02:27:01 -0700 (PDT)
Message-ID: <ef3435b1-5d86-4137-903f-bddeca3deb91@redhat.com>
Date: Tue, 10 Mar 2026 10:26:59 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v4] vsock: add G2H fallback for CIDs not owned by H2G
 transport
From: Paolo Abeni <pabeni@redhat.com>
To: graf@amazon.com
Cc: vishnu.dasa@broadcom.com, stefanha@redhat.com,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
 netdev@vger.kernel.org, eperezma@redhat.com, gregkh@linuxfoundation.org,
 mst@redhat.com, jasowang@redhat.com, corbet@lwn.net,
 nh-open-source@amazon.com, bryan-bt.tan@broadcom.com,
 syzbot@syzkaller.appspotmail.com, sgarzare@redhat.com,
 linux-kernel@vger.kernel.org
References: <20260304230027.59857-1-graf@amazon.com>
 <20260310091843.101237-1-pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260310091843.101237-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/10/26 10:18 AM, Paolo Abeni wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
>> @@ -581,11 +585,21 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>>  	case SOCK_SEQPACKET:
>>  		if (vsock_use_local_transport(remote_cid))
>>  			new_transport = transport_local;
>> -		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
>> +		else if (remote_cid <= VMADDR_CID_HOST ||
>>  			 (remote_flags & VMADDR_FLAG_TO_HOST))
>>  			new_transport = transport_g2h;
>> -		else
>> +		else if (transport_h2g &&
>> +			 (!transport_h2g->has_remote_cid ||
>> +			  transport_h2g->has_remote_cid(vsk, remote_cid)))
>> +			new_transport = transport_h2g;
>> +		else if (sock_net(sk)->vsock.g2h_fallback &&
>> +			 transport_g2h && transport_g2h->has_remote_cid &&
>> +			 transport_g2h->has_remote_cid(vsk, remote_cid)) {
>> +			vsk->remote_addr.svm_flags |= VMADDR_FLAG_TO_HOST;
>> +			new_transport = transport_g2h;
>> +		} else {
>>  			new_transport = transport_h2g;
>> +		}
>>  		break;
> 
> The old code had `!transport_h2g` in the second else-if condition at line
> -583, which routed all CID > VMADDR_CID_HOST traffic to transport_g2h when
> no H2G transport was loaded. The new code removes this check.
> 
> When transport_h2g is NULL (no H2G transport loaded) and the G2H transport
> does not implement has_remote_cid (as is the case for VMCI and Hyper-V
> transports), what happens?
> 
> The G2H fallback branch at line +596 requires
> `transport_g2h->has_remote_cid` to be non-NULL. If it's NULL, the
> short-circuit evaluation skips this branch and executes the final else at
> line +601, setting `new_transport = transport_h2g` (which is NULL),
> ultimately returning -ENODEV.
> 
> The commit message explicitly states the intent to preserve the existing
> no-H2G fallback behavior. Does this implementation break it for G2H
> transports that do not implement the new optional has_remote_cid callback?
> 
> This affects VMCI and Hyper-V environments: when no H2G transport is
> loaded, CID > 2 connections that previously fell back to G2H now get
> ENODEV.
Other comments from AI looked like nit picking to me, but the above one
looks relevant. I forwarded verbatim all the feedback for completeness.

/P

