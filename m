Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437A837DE8D
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781642826; cv=none; b=ktjuQpWZw4PlaCybNVXrj/EqmdLA/DxV8g9dEUqFYvrnxzCZ55t17yGAtV9Bv0bs4w2I6QoGAtHAGN9Z5jzbaaZ+2u/JHWhOMIILY/GofU/dhYEh7Mo4T/NagzvFYko59e0cd20uZ72H9E5PVi/GPk5XY9F+tYrPX3EUODBA9vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781642826; c=relaxed/simple;
	bh=55ubhwgPFP/ggX+sEQoWYZsZ9CMeijE8qXL6+9SVM4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=se1NCn6oOGrZpRQzvMEXXuKwAu1Ew7T/17zbBLtScMefQOE0YwaGlUaNbSMhKVhKX8JqG9qwwrnYCUsNIKwUsG05pjuSQdrZZZgY1Le9AW68ny0CV2mYu9waMjkRgJw7GHS0hR7XSWal9a/WwoxwU8tPjmkgoOdVwyXlErdmw5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Py9mUpUd; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Py9mUpUd"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-43bfe055ffbso3222041fac.1
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 13:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781642823; x=1782247623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N3bsbmxS4GadL4Z4bToRsBD+Gi0dvukUshOqKGVXCG8=;
        b=Py9mUpUdWt5vXOQMHpSDFKNdc07dV8zSmKyrmmqNUKFTu/VSDcSGSFT/b2qqNsW69W
         SNSwSPbiHJsW7x7URUBqDzziXp+n1NzryTK6BcpA4Rp1Nra3/rgmAqE1ch2zhzeu30wP
         e1wZ/1W1k+2sVKyjipQ8CzHQw2tNo2TI0UXy5fhdoeYEJPL9fckaT7oF38Oax4pwssJK
         0MUYJxjS5vtn2bFYV+tidJ0pp8MVx6j2bH6L5OgHnqOA5K9+Brdd+NsaYlPCCw2f4h8W
         ODsQ5gbidbn8t2I5yA/Zgp1SMqBzcNCcFo72ar7wJ6jooOBG+XkY527bxxeVUQFJ9PNA
         B29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781642823; x=1782247623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3bsbmxS4GadL4Z4bToRsBD+Gi0dvukUshOqKGVXCG8=;
        b=BEnIVW1xyn+Jw9KgPb9OALqoQdvRQ4hsJLiuL3LjUdEAQ4+dudeGTBR4DpW/rtFVrl
         FNp9qAtySZujHCbcBndKMHBQJADalJiYIy//3vZDiVivvs0p850jYjSAV2XfDC+UMgWA
         yiQPpCR540ZnzZPH1L5cRWYVf7oc2QVGh9hLpAc2oNmizRwjnMmpsmRlvhAUcXsVvCa2
         oS8n92XOLYmftvqI6+gogTRLAKA0V4xYf7E8qY5z9yvKiiGmAjKXoT8n8Q7TIJLBD+nq
         goSe9mW07zkpz7Wmjo9lX+1JstZlX1LohmJ9u0aONlPIwkx7B7SHFi6lwagv76OdibW+
         xlKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+U+iYBOleji3+/ueZBCBG4MgQy71k/bVOJao1D3yWNSu9faKaZZir8ghsm2X7iklzrQUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhSvc4X965lI+LTWEEOPyt2OxuEdHVL8mpFyWfMIqq6JhFlUPZ
	Y+ZUNKsvFr5ICGzBRL/8sKax5E0aRJbX7/nH2jwjIQXDmuM/MPtdGM29INi18rCaGpw=
X-Gm-Gg: Acq92OGR9fgkYFh0x2e0b8HFhw0wcagREX8PikT2mnMB7U93V9LjjOrbHAduck8VjBy
	g+Ld5b6px8NUFpYVGd9Ghzb/9hexkcdnhFbaJNog8d+JzyA8qCNfmJV6q6rj22axdOV1lTCoQnu
	+gAtHhONxB8CHQ9l/uwuqot+9/CNiFBG7t5dFZaIgd2nIOocOYCMp+sN3kwd7GwTv2pKejid21e
	X30JxHirSf4C8vbPrdNifq62IHxgq0GdDzfrXAXmZ/vMcmvGHdLMyMi+ITqriC5UHkYx5VLN5nl
	sQTBPCmVIUEMXquvFG9O6VxHVOpUTv3paes01LV+w7oK2RmEtQnhwhUVcqfDkwkCzg5efclqy/8
	NMm+T0IVcJN+RU/0BY5ROuF4Wuvh7/72Z7QkpBsksT9zNF5pLFjnBXRaBuNs9IPVEblx1f6ZyLw
	TiGUeS3T0gQoNcWz0TbpY16S65T2jVv1hP+mLZX28aBy0r+Anx2MVHF7uWGwWHFvTMGkYKnj1c6
	X5uq/Xn0A==
X-Received: by 2002:a05:6871:538a:b0:442:175:cea7 with SMTP id 586e51a60fabf-4469010a70amr626699fac.1.1781642823167;
        Tue, 16 Jun 2026 13:47:03 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-443090386basm2851306fac.17.2026.06.16.13.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 13:47:02 -0700 (PDT)
Message-ID: <910230d8-6a14-4d56-9520-169bd379f3d2@kernel.dk>
Date: Tue, 16 Jun 2026 14:47:00 -0600
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] iov_iter: export iov_iter_restore
To: Octavian Purdila <tavip@google.com>, netdev@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>,
 kvm@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux.dev,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20260613000953.467473-1-tavip@google.com>
 <20260613000953.467473-2-tavip@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260613000953.467473-2-tavip@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/26 6:09 PM, Octavian Purdila wrote:
> Export iov_iter_restore so that it can be used by modules.
> 
> This is needed by the virtio vsock transport (which can be built as a
> module) to restore the msg_iter state when transmission fails.
> 
> Signed-off-by: Octavian Purdila <tavip@google.com>
> ---
>  lib/iov_iter.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 243662af1af73..067e745f9ef53 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
>  		i->__iov -= state->nr_segs - i->nr_segs;
>  	i->nr_segs = state->nr_segs;
>  }
> +EXPORT_SYMBOL(iov_iter_restore);

I don't have a problem exporting this to modules, but any new export
should be _GPL. So please change it to that.

-- 
Jens Axboe
