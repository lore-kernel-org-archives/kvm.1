Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483E3EDE76
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588684; cv=none; b=mQAW1pK5yiKhmJu6lZImio8ZmlcIwvWlDhJe18jfpAYicYE3Je3vvfKG4iRtTVT6GEAKHwtZ4RvuOnJDVtH10wJvEmYauACdyFJk7YgJI+vIyzjQVj1rsUvqXMSgs0cvXa24yRIPZkuetDC4VfmizLi6O4UVsSQabyMC36Bg3/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588684; c=relaxed/simple;
	bh=FjpUXsvhXEAkUlVQP4tEH1Ee2iSdcpYkelan5p5vzPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPVdX5ShDQrk7C7h3iIRf5fdjPV3dw4y3VKDQxw+NNO4a569Er8s/Z0iXROOWHjUPm6HZXGHGiJ90lcmklzut2BewJO7CGr5wISn4wRyqirhNcZZvh3ZcariDijnRAR9dtW6Zfh/jFINs0YMWO+k2ZNj+QuQOtyTqMF8DJHSb3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcjPQO+q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m3q6G+k2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcjPQO+q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m3q6G+k2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783588681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lcgAW3wWwD+CDc95tyrJwQ6t0jD3GIhvTCB6YDG1NyM=;
	b=UcjPQO+qoU6ZVHP6rwYFyANn87eqyTY43At/U71P+XkzDvPGkXD5bArq3NcdQVVjc8SIJO
	euH/LHeMExy+qt2y85G9kucD/7O96e6KJ2Emt4D467fRBgF3/7Btco6jtzKd8ua6zXiAn/
	FLZWCgYUDah6iFktQZYMSpPDBomxKX4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-vo1Yy-wgOgqaHUWkm013VQ-1; Thu, 09 Jul 2026 05:18:00 -0400
X-MC-Unique: vo1Yy-wgOgqaHUWkm013VQ-1
X-Mimecast-MFC-AGG-ID: vo1Yy-wgOgqaHUWkm013VQ_1783588679
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47485fde05aso1189597f8f.0
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 02:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783588679; x=1784193479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lcgAW3wWwD+CDc95tyrJwQ6t0jD3GIhvTCB6YDG1NyM=;
        b=m3q6G+k2BxxHrRuy8NIc3HM7r5BkAQ5kBQ1fZ9ywGCU76Ww2QoD/Ei/V6NBLnwI8dP
         49p94kw0oGoRgi10BqgLIvP3Fl7Fwk+kdgpsLR7Me3bzNDOqPzGkN/Owy8+dCZwIys5S
         E/HTui+ygs+0ZK7c0wRh8RmbhlFIObPhFcEFbMDpxyv+QGLycE8U1jdpm5wWcmcXfhO2
         KxQuY430In6dk8AbRp8TUiJ52D/d64S9jTnwkznspCX+hXqnuRKzGQU3vGuTB7NjcFtS
         HEFq3Y+yLePpLqpZWWE84RKIjYCyY2s2Yy8bXB0IgAEEUt01zrrBzLbXZ6ksZeGPKNIv
         UnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783588679; x=1784193479;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lcgAW3wWwD+CDc95tyrJwQ6t0jD3GIhvTCB6YDG1NyM=;
        b=IcflSfHT3Kne1iIh6dSaUwMzspLT4iFXa+bjByiiP7wOI63rHOVsv/WshkqAkw3Yil
         DAUsiA06zhMagZkW3PKUU3ILURHomlq6sE6V1PYAu2aE0lF/+Rlum3dolgpMNyAbcb/Z
         PIfTeDNx2bDxiIGtlV1S31IzeScua5vNW3G/LYVNJc6HWmk26A7gS1jTl35s1R/wqE7n
         BUJaM/JObi66aK4NNwmtH1lsQNf540JevL3STuSvNHDwal0QFu1d9OSQ58uX7OflFPu3
         SephXlJNJKezO6Hw2eE6KJfZFveIW0J8HfGrgH1nNYC+BjY19m118k+EKKInmnZtVs9n
         9R4g==
X-Forwarded-Encrypted: i=1; AHgh+RrY5S/bYf1k9X/D8YVbDOPE1lHi6DfnGAIAvng1OaJSdxGHkJW2PuRzMg6MkL1JrYEdQCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxiam6LpM4rGZhniXBa1bzMl4CFZCHAvXeeLhnoQVGN96eBzjL
	Z+0Mok+HWlXg0HOaMWvoR0YdMaElEYRK1+4CukPBBd/oqii2N7xdoc/yrJbI3x6QVrbKe40MjGQ
	WAEgVCny2eo6NqxImetZXbVOrdk7SgAwblNCg/jBcvyITAYSt/Tc6Kw==
X-Gm-Gg: AfdE7clqHT92+7SanLOFZ+fl2Zz+y3SXWZs4HzL61BHlSrK/OdhbSFu63F2Cid7Vqn2
	q+ShPAuqBklRGwHgnDz61YyJyS6/lW6rnR6SjPXJaM/x5bJJq3gMvN7wlwcPNzz6SlNn0xM0sPW
	DU38JI2G+Atit90tqr3trM8G3lGZ5lB8M+NSiKz3l5l6XYtTS8Ye93WhRPZr2PJqOKvwUrezoIj
	BA3VUo8/4ePFM+9NF6f5etxl0pmItyZ72ZKMfs3XtmxkFdCCZuFvsYuSg7q1L+C7Rki6B+gCJ3W
	irT4iD43MiPhgJrx3O/qgweFhee7gm+riX49cWgkMrOehAQ/xnOdbSD4aQjMWUBm22WEAcwMS1H
	7hg+4wBQUtvWm2SL60vjICTSwI/FvDOkeN75nVf7HLiUhm8qRiML/L3avpkt7
X-Received: by 2002:a05:6000:1a85:b0:460:1223:a044 with SMTP id ffacd0b85a97d-47df06c10c9mr6983270f8f.0.1783588679361;
        Thu, 09 Jul 2026 02:17:59 -0700 (PDT)
X-Received: by 2002:a05:6000:1a85:b0:460:1223:a044 with SMTP id ffacd0b85a97d-47df06c10c9mr6983241f8f.0.1783588678905;
        Thu, 09 Jul 2026 02:17:58 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d910sm48486557f8f.6.2026.07.09.02.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:17:58 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:17:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, 
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net v2 2/2] vsock/test: add test for small packets under
 pressure
Message-ID: <ak9h1kWcLmpP74PI@sgarzare-redhat>
References: <20260708102904.50732-1-sgarzare@redhat.com>
 <20260708102904.50732-3-sgarzare@redhat.com>
 <20260708065853-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260708065853-mutt-send-email-mst@kernel.org>

On Wed, Jul 08, 2026 at 06:59:41AM -0400, Michael S. Tsirkin wrote:
>On Wed, Jul 08, 2026 at 12:29:04PM +0200, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> Add a test that sends 2 MB of data using randomly sized small packets
>> (129-512 bytes) over a SOCK_STREAM connection. Packets above
>> GOOD_COPY_LEN (128) bypass the in-place coalescing in recv_enqueue(),
>> forcing each one into its own skb.
>>
>> Without receive queue collapsing, the per-skb overhead eventually
>> exceeds buf_alloc and the connection is reset. The test verifies
>> that all data arrives and that content integrity is preserved.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>maybe cut down SO_VM_SOCKETS_BUFFER_SIZE? will make it easier to
>trigger?

Currently, with the default value, the trigger is practically immediate 
for packets between 129 and 512 bytes, but yes, a smaller buffer size 
certainly makes this effect even more pronounced.

>
>anyway
>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks!

If I need to post a v3, I'll add it; otherwise, I guess we can leave it 
as is or send a follow-up for net-next.

Thanks,
Stefano

