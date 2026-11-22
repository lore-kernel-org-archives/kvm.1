Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795382390;
	b=F+7PBvdqDYN/3onMCIySqhlm+SzS+M9yNb4yj9dRWIsGom2qNdQ1PeFAuqM09iDMj76r
	 tw1afx0llcJrZA5oavzcxvQ+8i9U4uktib73BjlnTCBwbvxki8iZ3SpiQZAutYgmQudUH
	 Y4GT54LLs9iGZzr6oTlToWOzg554Cjt1PBoF4yMojHYCOie4RCvHfjttdIXsELScfSaJB
	 PZOkDI5P19Em8SHbkIicaoxvddOIgTdrFX5P03pV1hgmHW9CwgolnfhZENQYvPJaaFfL6
	 SwKZWzAr8EGeKaS0PZcZi0Pj7qFvT+nIBhcXnOASilVPevz0oxMwKO926DzliAVA+rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795382390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jlHx3q8hlvOapQpFRbpBP1dZTmv+VTbbRyW9rgzkxFM=;
	b=Vt9zWR4j4W9lomEDH22WepYCanUznohfgQAZ85FskWFMvmwe3xdomCHmhmURNig/p274
	 RLG7PZueqxpPvLZ16105j827+KYl0h0XdM02UOC5EcN+jfwVX1oPmwwJAAbtEw/kLOd/j
	 Irg8CjfPW3exOfpjDPxFAEkIplkGzwSq2hJpApA2nJv6y1h91eVIeQIuwLKdisanhiavY
	 dTgamMkGwxnf2gssgTTYDW64kKW64sdmUGMs+BsKdvrOXIteAbJhK8KiSW6fefKAnzD8I
	 3dy5Yp2qEBfxzDH9fj1F9OLGUgb3vEk3FJHoVzqLu7tA8J+y3vdH2nD6G6qE0brzeiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q6YuWc3T;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEAA606A31E
	for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 21:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAEAA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Q6YuWc3T
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9f6a16afcso44175ad.1
        for <kvm@vger.kernel.org>; Sun, 22 Nov 2026 13:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795382389; x=1795987189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jlHx3q8hlvOapQpFRbpBP1dZTmv+VTbbRyW9rgzkxFM=;
        b=Q6YuWc3T3SalsZoSZ7nZACQHkeGNao4ybVKhTt0wRTBMWq/STNikHYxymoVlbxJKwt
         ObO7f6LqOfkLa0ZWQsDUJxcoIFT1R7RX+ch+NcX9HjC1fUkz2lVXWap2Fhk6d1BNQ0/q
         ou34OmAd2JjIq4liY6+XTlyVs7lAo8j7mMJNCn4UbXdO1PySd7WVB7CcG5aY5NFk6zeK
         MTPQ2mPRuN0yBX2byMj04WfBHffJTGoEmJVbEpdFlNNAdwmn3w7R5fnIWHJ14+7KZJBj
         9JP319l80gUmvzuJ9ttWm+kYAoDSsisjSAMPzJOAjU3H2qQMyoaLkA8b4AIwL0EJiVEx
         8BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795382389; x=1795987189;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jlHx3q8hlvOapQpFRbpBP1dZTmv+VTbbRyW9rgzkxFM=;
        b=ofVU2c5XtE6zUi0G+W58jEtmfzChfrcCKukVURHnUhM4JsQ1dFTOKJKeIOCg//l+g2
         EdkBWBbBfr0YhPlwtAV4I6pwmL0nVXb0aaVDGAOKt5CWxUuyXb/OBy1QCxBaRyll7GRP
         iWIgsKDWT+uBZJXt65lHq24vzKu1SFEz4dPcl5YMMFAUdN89T1whxHgSrN/RcTZOL47P
         9jDMXpCL3xxN5ZVrO7g3t5IlsSDr22EJL9H9q+M4xR1YjbtlVgyNEeMJoh5WTwCERPTe
         Rbjpo7/5sME7ixh14uav9rqZ/SCNZamkldN0RXPjM0mbjtM+2ZI2rOm4+w9d2MBNCGPH
         mPxg==
X-Forwarded-Encrypted: i=1; AL+hErHWja8HnUDPxp2549d0iLHpJCIj7P8LyMWzASB75ttEPrdZX1qXFq4r5d/QPiwIJXvDoqo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+B3gqGNMLinl4HZ5gkl8JSpS8siPn/fznDzvBp81LeNpLXD030
	c8GIGNUFPNGwwL3umx9woq6mD4OG8EW1Ls/UjOGXKF7FVe5ck90Po78WdeUoxptjUg==
X-Gm-Gg: AZFdTZcWKm4XoMLXwkqwITDmhR0LORDxgVXTzD2Wa2Nazu2wHMq7KVwUaF9jHfZqB8B
	rnSnhpfJ+Um7QkAyTbzY9x9Qsij5RHVvmd0BP3KJ+NNvBjOwf19WXrxIv8IgSyX6vKHWkORCB8d
	gL6Llw8rkrQPkrxQ4L/KXzj5tqIE6f6HCXO3UqD+BYRywuDYiY9/JejVmW6+uv717/ZsLH3Or7s
	b13uT9O3csF2PkNBA8LkDmcRE9Sm5tH7Uu5mF6IjK+fEV4wLR/trqflgRxSQS4V6zf9ls0cz63G
	ujycoOmqqHyawRMo04Zi5VEUtl8FYaSXsOwyUAT5KzNMlhn7/SsSDIir73he2JEJil6sSKcVQdN
	s0BZ8ORR/PTPmTUOcfnzKxtrA+TxxT9rXMnbihINRMH2AoJaicT2QUh9ISDytuyS6HybTlEzkhG
	wOjYZUmAFvP3Z5bvpR+dwtUK8EhY/o1eXMaUpl3yrJHxWwS8wzJaG0GAiiKaxssXq9qIbGEd8Jk
	dahA26eZp8vU8NqGHanH2DJWRNNkLqWP2JoRC4sAxILF79/h30TVZLtXBXxSgFe9qIrIH7qdzas
	+lSQ1D7ISv0J+Urlc/G2v2XblGHMgE2XQp7XgfmeUaRUxcayR7tbXW4b/yvIEZsVRTS2IIXkI5t
	Yk4OMT3giVydNz2842MUXDw==
X-Received: by 2002:a17:903:19e3:b0:2d5:db38:8010 with SMTP id d9443c01a7336-2f066708a17mr4257845ad.15.1795382388397;
        Sun, 22 Nov 2026 13:19:48 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm18461423a91.8.2026.11.22.13.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 13:19:47 -0800 (PST)
Date: Sun, 22 Nov 2026 21:19:42 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, 
	jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rdunlap@infradead.org, rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, schnelle@linux.ibm.com, skhan@linuxfoundation.org, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 03/27] liveupdate: Export symbols needed by modules
Message-ID: <awNVk3q6Q6sAHn6U@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-4-vipinsh@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261102153656.1431701-4-vipinsh@google.com>

On Mon, Nov 02, 2026 at 07:36:32AM -0800, Vipin Sharma wrote:
>Export liveupdate_register_file_handler() and
>liveupdate_unregister_file_handler(). All of these will be used by
>vfio-pci in a subsequent commit, which can be built as a module.
>
>Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>Signed-off-by: David Matlack <dmatlack@google.com>
>Signed-off-by: Vipin Sharma <vipinsh@google.com>
>---
> kernel/liveupdate/luo_file.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
>index dbae0715220b..6aaa9a531428 100644
>--- a/kernel/liveupdate/luo_file.c
>+++ b/kernel/liveupdate/luo_file.c
>@@ -916,6 +916,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
> 	up_write(&luo_register_rwlock);
> 	return err;
> }
>+EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
>
> /**
>  * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
>@@ -933,6 +934,7 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
> 	luo_flb_unregister_all(fh);
> 	list_del(&ACCESS_PRIVATE(fh, list));
> }
>+EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
>
> /**
>  * liveupdate_get_token_outgoing - Get the token for a preserved file.
>-- 
>2.56.0.317.g454f8302e1-goog
>

Can you please send this separately, it can probably go in without rest
of the vfio changes? This is required by iommufd and guest_memfd also I
think.

Thanks,
Sami
