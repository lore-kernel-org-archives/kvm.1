Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F93E0097
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025535; cv=none; b=ixMSjujCppFgMwlpdqiBXIGbJHEXX2w2nIq+zhM26D7s3hwMPD19MuHfTRylqqherMm3xuLPXaXWLuEoRQ8kTWpbkCSp2i7/qpZQ0YATATie6WzOCmhKEiZz28dYXUboHFLTOf+++uwo5EuGnV2H0By/bEMH6bdVp5up/GiHzwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025535; c=relaxed/simple;
	bh=tKT2WtltnHm9yotRiXX+eFUmEP1+4NC/PxFzeHnanKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+4zXG5pOqVHnpT8BC42F0ca3qEXXmktTsPOfif0j7sDgIrvTL47kAvSDfWNhk/za32id0f0rwYEjw3+QJ42mRT5RuouDFAQnbwn9T5pECepeCB8dYNcAOdeZszN5gl4Kn/eR1w+YDekEvelFXJTfu8a4Z2sIIEKizPLvjOS7Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PMdonyuX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9MPKoqz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMdonyuX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9MPKoqz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786025533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t7aUwMTNUpYcD120eKUj1K7e7+QcP8SwvajEqZfXsIM=;
	b=PMdonyuXUhoh+yr+pDghVlar8BuOBW46ojoRqHM5Go8qUhmJhfTJPDu8dqlw8lprHA0mWx
	K+Hyd1WT3HV0VMqV5ftJsZKonyqYtoU1at6R8rwkUJzuDH9toVP72is5NjHYviyN1FA9zm
	WgyCo/SRHRcnAXZ73Cd+kSVuUR6WMI0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-v9QFuPWVOdeqxY9UuxbssQ-1; Thu, 06 Aug 2026 10:12:11 -0400
X-MC-Unique: v9QFuPWVOdeqxY9UuxbssQ-1
X-Mimecast-MFC-AGG-ID: v9QFuPWVOdeqxY9UuxbssQ_1786025530
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-495529a93f9so20877915e9.3
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 07:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786025530; x=1786630330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t7aUwMTNUpYcD120eKUj1K7e7+QcP8SwvajEqZfXsIM=;
        b=Y9MPKoqzFqLT728N35LXZcohQ5ADY0JIS6qy8/AvNeHFc/xiiDmjr3hzEjXVczvHq5
         RFupYqJnNNTrMd3SCAmo/wcwgHfCQcdnhUJ8Tv87wx4UedBspejbTmTp3P1YHW9gODdw
         Eqfe9LaO1w2kU+B6QYVr+lMWXbtJ/jiE1Us9/UEX4XRA1vfZJ097Ibivmm3F87JIu39h
         NWTpC9hS1+LR/JzBNcPMpHD6D1LCoTs2saue42MEmAChUX9gywjMBhEyBydeWumnxRUp
         5HN5m0yTbeIE/h6dutjoJ8fazNojx6bx77ONQEvxpf02+KtanHBPRuON3m3SF8Xp0HRF
         Tqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786025530; x=1786630330;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7aUwMTNUpYcD120eKUj1K7e7+QcP8SwvajEqZfXsIM=;
        b=MqrL7lZYiQoxy9OKEXC3nuqehOEKkZ1E9pv7D+Akei4pZu9zszwmoSwPjEjUy4dQM/
         OTxhTLUk7Bknku+hHw7SZvDpdfUfS2vls/QXeqBCVOGr5EkSbD/g1Kuab0brAp72wqf3
         g/o19SKc+J6t5VopnK3Q79VDJTkSsN75kXtB/F0ixffeWhRoGnJ1CgCMw6kU0/3iZ/tY
         W8iRTozTAk+0D6JsbQn30EUeLxTslQd76j95hdCfNHQcSTQ/wLQqyAlesgyHsFcsnxxb
         BH8fHlpPEllbY+okVyJyOiHYZ1Mi3qJVIinSm+ZcKCVDRIn8fHuoJiXwXiCXGGOPoA3U
         qsWw==
X-Forwarded-Encrypted: i=1; AHgh+RrV8hgv4W3zK19vAMT/O/M9xlCSEMmS461Lc/HaQXubQuwXSHuHlfTgoteYcSwFLeH3L1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YytgLdUtf9RFiIfdcysgRhXG7ehvrFDH/x7AieU+BYej5avZJ0K
	tzHTx3V+5TWnQcOpVtzZvSdmwrK6poZKaZBAD5+4txoiwagaCclIRHwLoKoaQ1vn1x4OWi7ccgA
	qYGUmK8Ye7Cva30OQbOna7RlMYt+DhPsF7z1fwCB+ZaPuvshxO6eFug==
X-Gm-Gg: AR+sD10ye0zVSOaxjq5/6MkSAwdGkK2eYKMiDnpRIcwoVUBkZUzfr7aJEZftMbqe4pv
	Z9ZoOq6x8IP8eOcXEe/Dr7+aWDiVXVvImRnJLLbgepZwECvxC+1k03CCTOclU1K4Wm5BXR/XoV9
	VPbIWqW+yk4wDij0eGGR0DV/WBtj8jUxs/vFu8MaoOs5LofxqGkwn+nGh7AU2gRhrVlsyIMRvJT
	uD3rMyQsQOQI0vPEAXRD1jr9hCAjZmBlQFqb0YKqeOZLnNahbttNDT6Eir3WGvKlT47j2zJrp1I
	lX/cG8uU/jEIvZo4zulJ0oF5tyODFBfqwggTW1lsfnApTTxjf+NNMSK53rIkkVK2oSxwMCm20+j
	M8BU=
X-Received: by 2002:a05:600c:3ba2:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-4994e794edamr191371025e9.2.1786025530343;
        Thu, 06 Aug 2026 07:12:10 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba2:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-4994e794edamr191369505e9.2.1786025529693;
        Thu, 06 Aug 2026 07:12:09 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.117.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49952dda992sm35827965e9.2.2026.08.06.07.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 07:12:09 -0700 (PDT)
Date: Thu, 6 Aug 2026 16:12:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, mst@redhat.com, stefanha@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com
Subject: Re: [PATCH] vhost: clear vq->worker under vq->mutex when freeing
 workers
Message-ID: <anSV9yFUHLubu7v4@sgarzare-redhat>
References: <20260723153310.745855-1-andrey.drobyshev@virtuozzo.com>
 <anSMBpQJ8x-vXYy2@sgarzare-redhat>
 <anSRyFTNGC-XcFM1@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <anSRyFTNGC-XcFM1@google.com>

On Thu, Aug 06, 2026 at 06:53:12AM -0700, Sean Christopherson wrote:
>On Thu, Aug 06, 2026, Stefano Garzarella wrote:
>> On Thu, Jul 23, 2026 at 06:33:10PM +0300, Andrey Drobyshev wrote:
>> > The effect is harmless in practice, as this only happens while the
>> > owning process (and thus the whole device) is dying, but the lockless
>> > write is inconsistent with the rest of the code.  Clear vq->worker under
>> > vq->mutex, like everyone else, so that all writers of vq->worker follow
>> > the same locking rule.
>> >
>> > This issue was found by Sashiko AI review.
>>
>> Can you share a link to the review?
>>
>> I don't know if it's common or not, but having the link in the commit or
>> after --- will help the reviewers.
>
>+1.  FWIW, I've been using and encouraging the "standard" Reported-by+Closes, e.g.
>
>    Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
>    Closes: https://lore.kernel.org/all/20260625212001.3B6561F000E9@smtp.kernel.org
>

Yeah, this makes a lot of sense to me! I'll encourage the same.

Thanks,
Stefano

