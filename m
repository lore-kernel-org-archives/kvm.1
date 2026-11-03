Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703483;
	b=Kd7oj1vsqWKU1cm2W3O4z0U9DwEvglTnDFQgm1CQ8RguJ1sMrftwThT/JzkIRjKagu/C
	 YkW/gEnSh7KqvxwT0qSUViOmHGkNnqZFK4LDK+O9UMDzQ0X5voecfnMX44/y4CMnCly4O
	 payxDUQ+oXjpTHLFSOKMVN+DBVdmcSgfCS5M8Ln/znFEgHsc9F6P4hZPhLhVyP6zKfmsZ
	 ARdcQh9Na+0fi/hn1hnTfPEAFAO8361eVxHQV9zwijCDt7wZnr1U7Ag+5eACa8/r5lswh
	 beu8tCEjpJUVBpN3wmO6WxRKHDSb1d2KG1udhGQ2eMrC8ttphZ0rPyV6xmQBi8gNEiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703483;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uecybL+gqfrB8HHj3vVKJyhfRKn7L+ejiH5DOEaosNc=;
	b=PF/zwW3LHATxFErl84JcpyG78R+KsTJshwwrXRVB1J4pfEGwGYfXkA4wtCtso9qkX/5R
	 tKd7FVsPUOyFPybbBQ51u/8thllxdk1q4schjuzfxmTWjWvoG+DiA7Q+6P0ZwRfoOGwJa
	 ORTfJWHz46o+OlkwzlEOj0X/LK84HmAX6DJrYWMBDjaSyx9gwk7AoAMx49ZLA8MDcYwD+
	 BJLrnfqdwf8hdlBbmPIsCZAvYEKrBOgX6TmTjomI9zOXoULDQOCjDYkUXpSL8qcSVo1sQ
	 bDqQ7v0m+kCs+9T0TlJsnhiqN9P3/bgK5cXjZh98PW9AgyjfC01CDQhcPiTI+FMEURg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bBa7T2lO;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IR7HKpyH;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40737606C5B4
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 10:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40737606C5B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bBa7T2lO;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IR7HKpyH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793703477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uecybL+gqfrB8HHj3vVKJyhfRKn7L+ejiH5DOEaosNc=;
	b=bBa7T2lOJ+4pF2WLhuJ0Y1S/bo5D48zOxrbNpkeP0iS0LOi67rlAAT3sznN229mI9G3Cy/
	kMYmP/+nP8amZ7BywKn3sLSxA80NwooEqQggcMYv7ZUw/iT1mPr2fOtMRvjlPCJX6AHSyq
	apDQurP5hOTmEwx7YKaWSiT0Kzlockc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-foFAQpuPPLybceeRiUkvug-1; Tue, 03 Nov 2026 05:57:56 -0500
X-MC-Unique: foFAQpuPPLybceeRiUkvug-1
X-Mimecast-MFC-AGG-ID: foFAQpuPPLybceeRiUkvug_1793703475
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48df730c035so2812078f8f.0
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 02:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793703475; x=1794308275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uecybL+gqfrB8HHj3vVKJyhfRKn7L+ejiH5DOEaosNc=;
        b=IR7HKpyHpsu6vhKrQ2umLvoyYUPBYAXMIoBY7nB3Guu/f+JDm/h4J8Eu/Yde4UqUyy
         pwI1kjp429XrY3TRPE3QkcTlZmhy+Zui6gkCSUr0mxWKOl0Cx84ul0mY4+Woz3AktlBN
         PG+0YoaN1x0c2ZvdoVXkJswZJWBLMQ9fVki2P5xN3O9mnjKYKzysByPpWC/U/XKpthB6
         sXs3P84hbEpNBy0K0rrBeDfsDY9s7oStI78pwNsWs2+xoSL/xoVBGNMKhz4a3a1LVona
         dDx0JUDNe679Q4woAXHDbi7QJTWRWXo/RLnFCuGFfmwG+qLUTmcf+81v7R3C0Mdfv2ZK
         aB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793703475; x=1794308275;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uecybL+gqfrB8HHj3vVKJyhfRKn7L+ejiH5DOEaosNc=;
        b=qvKOj78W42mfso79kAn8zRW0Wj98OgnDoyTcrkqZQEkVUtoKeJf3YPq7Pl8+ohnLgp
         S6jBuLGcEMES3IkDNmEmoqSwPIyEdUx8K89/el6REMZzRc+O9nz5ODb+1DifyljwZ524
         56zdaRj6cokXoq8RE4iZ78RM7UOhv35fD7i2UmYbQWfzFFjBz71yPnu5tNoD7P4xh5b0
         qRIz3x91j4ta3W7dGkH8z7jVIM/5/pXOU43rMHTRPRdjgsGwf7tK7TxU1LrNkRh5JjqS
         QDFghX0ccyPBl7hM0lzfLkZa5QqaJADom73/FRAB7iLVgAB8oV7Ro8m+HLQJeE9X99hV
         gwVg==
X-Forwarded-Encrypted: i=1; AKwUvBxmz7p0YZiQO2fLiVfCpDQdvq8Z37OZ+OlLgnGl85CMLeSbNGf0AZrcJhU71F34lxLtXGs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HzkY4yqr5yoMQ7VQ4O0nM1ikUNSEe7uS8l5PQ9BHnpBrYVbmB
	35BMsLSqyarkx7HU3wHl+Trx8yxNMdJ3mYnpEZIORaBSjW6r35pdV4f0keRlPbFP+xMs3DZB5dC
	8BjHdQYvMnwERVIYaWEa6zRwThBFm9eaugZ10rU0aiX2sOlHc6Zl8qQ==
X-Gm-Gg: AYBFou2Ufa3l0L07OMaUIYaGlyxNv8UKLny+FtlwuVoKXwdLRtvvgGFF8fd59knv1jb
	M/EX/SktsF3uFzxs7CkI2xleYH+jMtFl1rGNB0+R6PoWwfe43OlVVFwo2uCkGHc68IRBlKuBJQH
	GJtCPbridWJEcpNyNotTFamXwZq+6/ApCIfyJFekZHeFVAhPXpgsKcK3nATMRn3OalShl9wy/jW
	GvOEunw9uDxJqVmpzQMV9ANjicofp4cuc546zCtb1if/zg1x92M67apeQwH7lFz5K8bwI9i31aS
	fboS3I3MRi8FfZe/53EPJI5LWa4UyyF+dRQrw7ZvlzUkN14iZvmDdbGq5e8mCwSZue1wYwiTDCx
	iHyINZ896/i44gZ23bjfFnS+QpaIsoamLbcTIrUMpIQ==
X-Received: by 2002:a05:6000:25fd:b0:48e:2406:57d0 with SMTP id ffacd0b85a97d-48e6e2f6620mr27753776f8f.19.1793703474655;
        Tue, 03 Nov 2026 02:57:54 -0800 (PST)
X-Received: by 2002:a05:6000:25fd:b0:48e:2406:57d0 with SMTP id ffacd0b85a97d-48e6e2f6620mr27753733f8f.19.1793703474133;
        Tue, 03 Nov 2026 02:57:54 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8c6e9sm24257782f8f.43.2026.11.03.02.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:57:53 -0800 (PST)
Date: Tue, 3 Nov 2026 05:57:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH] vhost/vringh: reject zero-length indirect descriptor
 tables
Message-ID: <20261103055650-mutt-send-email-mst@kernel.org>
References: <20261102122942-mutt-send-email-mst@kernel.org>
 <20261103032935.58823-1-fangxy@xiaopeng.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103032935.58823-1-fangxy@xiaopeng.com>

On Tue, Nov 03, 2026 at 11:29:35AM +0800, Fang Xieyan wrote:
> Hi Michael,
> 
> Yes, same fix - sorry. The October 21 posting is a duplicate
> of the v2 I posted on September 26:
> 
> https://lore.kernel.org/virtualization/20260926160755.21485-1-fangxy@xiaopeng.com/
> 
> I resent it as a new patch instead of a v3.
> 
> The !len form is equivalent to v2's len < sizeof(struct
> vring_desc) check when combined with the modulo check -
> zero is the only length below one descriptor that is also
> a multiple of the descriptor size.
> 
> The diagnostic change is to pass the byte-order converted
> len instead of the raw desc->len, so the reported length is
> correct when the vring byte order differs from the CPU byte
> order.
> 
> Would you prefer that I send a v3 on the original v2 thread
> with this diagnostic correction, or should I drop the
> October 21 posting and leave v2 as is?
> 
> Thanks,
> Fang

pls take a look at my tree, vhost branch. if you want any
changes made wrt that, pls let me know.

-- 
MST

