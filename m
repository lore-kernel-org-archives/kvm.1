Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794383664;
	b=fa/NeNNjzUrhE0g/Yg0uE/UB5KCTrqJV+ZaVGvEbmbXUZWXh09OQ+QUPzx/fwyEY+mBi
	 kp7WkvU3NEb9irVfwIKKQt64RL7kkE7bFxMYJV1vRu7XXnhDfDcxcJOU0qdjLSZJRaX5+
	 1fvwzVOxCu9JfGMRjGJ+cQsZ10tlv4uoZNpN10inQFEvmWcC+z+xyAlG/V2Z4oOeUmYY9
	 zEBNwVn32AQ9/aPboEu95Ok09HdL9TRjBzrJXHeT3Zi+q3KeiuGuz8qlND+wQH8krc+9z
	 v3fZMnTVsxteQSwauuztKGcjA8jAlV3+YGXpwmWogYKxz1saGcTQdRv5YmIKkUyV6GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383664;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=rMmIOYVl64Nfr02Tf6vKaYBHgvMLGqEBK3OO7jbaHrs=;
	b=p/BK+Pwi+nsg95fU73HpOPYAxUA/0kfdqduybIe/NpAv+6iIc364Jwg+NZEEpltR8OZl
	 Wu5qSQPBknotxMFCi2kRWt6nwW8JJAxdLnkRCfM2USDvxF5yK9pqiJ8CWC50fUruSi+TV
	 8+V9z77VYD7So4ZsecG3x2E4DADqPM87y2CaZlPHFfiIaBwJQMACBDt1d+yHXGOVA8C7Q
	 aMZOjJvpp/ZtQHI50c4rsUvfOrIynGgtAVip+xCtaukLcHR1GS6UFTa1lq+o+8h9Fpqe4
	 mIUJE90wgu8CS2tzp8T3WjkphOY0k+6P3zES6H7afZFk3NKU6bzLy5NZr8lLVEjLaGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KGrEuIKD;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=aywhyibE;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8754606A320
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 07:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8754606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KGrEuIKD;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=aywhyibE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794383662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rMmIOYVl64Nfr02Tf6vKaYBHgvMLGqEBK3OO7jbaHrs=;
	b=KGrEuIKD/hFyC68kL5L/Zdh9PDGrGhgfMDmCoJdSVwLauTAGKEBLXFlm34Y5QCuYlGGqbO
	IiyTHttMAf5gWsgM+szorTRgn2y8iBIrK+93HXwxK5l9HNru/l9uThx9LbOXiaVSgn4EhF
	zUcl+W/zvvU6CMh3Zt6nrH/dyhGYTf8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-Viq6JlWeO72vK3gY6mxafQ-1; Wed, 11 Nov 2026 02:54:20 -0500
X-MC-Unique: Viq6JlWeO72vK3gY6mxafQ-1
X-Mimecast-MFC-AGG-ID: Viq6JlWeO72vK3gY6mxafQ_1794383660
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a70b42bab0so29131545e9.1
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 23:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794383659; x=1794988459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rMmIOYVl64Nfr02Tf6vKaYBHgvMLGqEBK3OO7jbaHrs=;
        b=aywhyibEomtjFoOvaXIkv6In1CK4v86NGWZyo+1p22RCRdJYm43Hq09M3hxcv6oMdb
         GeSFC5jnxln8lvhEtUJkMZwAb4RSQB9AqhhBkx5wbfxfyy4O97HgwpPbCcVOtv6A+H3h
         5huRRxMSQGmz4c2sNrQs9pxKFst9BTbRgkxg11lToYSXm+Vy/tFYGkjEhjK6G4CNfJ+0
         0wl5gtPGuU3GqEJsYj+SNlGd6B0mVi4/DguqGB/zGawEnI/3xH8lDzaROROBG7v3uM4a
         Mz040XtKgJ1PnQP07woz7cC+uXpxbWSXKI2tiSOsmf/qrLV8129RRFJSKSsGe1ZmIeQ9
         XgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383659; x=1794988459;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rMmIOYVl64Nfr02Tf6vKaYBHgvMLGqEBK3OO7jbaHrs=;
        b=gsbHx6e152x0JgqpOrpBN+TKsW3U0quVEvgnZa4m1rsj4VyZTFvFCPUQ5f2NI/A0SS
         zrXY2iJUeNp8aOKvuhiziBZKbWRFQVOGWvXEfdGGFJUOnsvR+lNEgEs/IzNIRNQjOE7w
         nQ2k5gKbMjhkrYUNNyHY9qFMMILmIoslgqwH2Z2QrZ50v8AB5OU6zN39GSr8BQdkHC4Z
         1B1eJjdCd0Iff3ahvs/bXYxKpZe3co/2MH5DHlGjjGRriKg2TAaOiQhwNGRF6XueUDol
         GLfOMHnR0mIgyuGwpNKwEt3mseVTZOwktEqAqQtx0T9lpwqwcrwtoTUjXQejBnctPmH9
         3hOQ==
X-Forwarded-Encrypted: i=1; AL+hErGyOoXfZUBAwmauF3NTqBVMZtugd5mk/SMK8yljsVlp7bMGmfQm0SYBdiKN4y+DkvOBxlA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SAXtjJy23eBx4+JtHONunI7TWhuUpzhq4kVPKkJiuZ2oTIqwJ
	5Pukf/MfwQuqtrLmOpK984/EOZovycwXwRg7ZxwocwOMb88TZC7zPwc5/8RY8FCgk8W1/6PZu+X
	s0uLCaglhGojheqDJA2cpG3NfNgNNMOUi/y5zFGV4IX4D44hFTXfcaw==
X-Gm-Gg: AYBFou1Se8TXCrq/UPLawGzJSLYGs4hF8vASduTkMWRemSqeJAubm+E+j4JCyX+Kybc
	y2CvDjIVMreVTuxlbB1Gv9Zes3Ruh70A8Km6ctBv1wnI2YDd4X9LNNiEbC9nVzoE5jhnEak6KS/
	ogEI8ZS3mGJddCpYrDBQ59hV8+wE17fes0Yoe6+DiVfwVuuanqCXfPydUgG2Zl8o8Lj8uRgpNCB
	elUhnWDPf2yC1hzJwwiqbsuEGZ6hbSbdRb5T467luM898gjnq0fpQPsEym81+uQexbnUBKfuZfs
	Qhx8lwTv2jqtEndLq/avS3hRvIiu9WhG1MpvERuCfAnLyVB05X60IN8v0kxm+CdNZ0g2HI1Push
	kOoMMmHXloZ8b7C80UJVsZOpAtxfdjTSUL6Ki3qniVxbr
X-Received: by 2002:a05:600c:34d4:b0:4ba:cd:f45a with SMTP id 5b1f17b1804b1-4ba09376eb2mr27495315e9.14.1794383659662;
        Tue, 10 Nov 2026 23:54:19 -0800 (PST)
X-Received: by 2002:a05:600c:34d4:b0:4ba:cd:f45a with SMTP id 5b1f17b1804b1-4ba09376eb2mr27495005e9.14.1794383659316;
        Tue, 10 Nov 2026 23:54:19 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01d9df5csm144516265e9.0.2026.11.10.23.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 23:54:18 -0800 (PST)
Message-ID: <1346902a-67ba-49e5-9dfc-fc3990c3329d@redhat.com>
Date: Wed, 11 Nov 2026 08:54:17 +0100
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
Subject: Re: [PATCH] powerpc: Link with -z notext
To: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
References: <20261110154415.46220-1-amachhiw@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261110154415.46220-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 10.11.26 um 16:44 schrieb Amit Machhiwal:
> Building the powerpc tests with GNU ld 2.46.1 fails when linking the
> test binaries:
> 
>    /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
  Hi!

This does not happen for me (using GNU ld version 2.46.1-1.fc44 from Fedora 
44) ... which compiler and distro are you using?

  Thomas

