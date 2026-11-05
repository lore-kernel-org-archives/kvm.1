Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903545;
	b=xk7MZjn3v4TrLpemDBDcsLp5hq6/iVLwJJHLfrYH0hGXRpecKwYHKZdFWyrZjq8lNc4I
	 hl9YXBz5txrq8sCnHovW8axFR9QCwqQ1pxK+SfN8C4vuXMv7uN0iEqvsEg78QgeShBQOR
	 T8rqKYjtKk1oU04iev4+EMVr3gRIfw2z5mI+MhkatrUZm8fzRHdeLDm7Rdlw6S6lB8089
	 k2IXGA0h2DHliRfaAiDpngxBNBfA93ex4hpLgwuuwIf7tanHXWTUOqaCenkvX4pW9OGBT
	 WenfFqKATEbBRznY0scN1tplPFmVp+iZ7gt4keaDmn3zUZDDi0go8gAQi0ERVjuv7rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZFFGdirTAMGtbCDF7cv9kKouCz6oxttoVV1PmG5xK7s=;
	b=obCH8JJJAN9+zYuyRxFhRg58CwpEd6fnEVwLXIhJUYvtkAFxe54/iWhAIg6CF2l6rxIm
	 HLYb0FqeVD1HQ92aWpiVIRaK3rVeTjJ3s+kPvIq7NT85Pg4U+L+xLnqxTx7tEnfrRHnqy
	 6cNmkJzNhgx3nh1AqWjhHPZBAhzfAub2ht0mJCgSUtXL3ucvFDPfGwajCZX1rqMHYIPWL
	 JmByhkEUgJQeaiMbdaAhIaJwMIxHBc+l0r/8iNMqP6f/DhkHPnP34akU/tCAYw9WTjaX1
	 FZqRJbMXXrBGKh2AyWoQw3ZAjLict/TOGyWvFzg7TlVluNv3yJ9HgOHNzZ3yFAMnTIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=JvgOmnIL;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E008C606A32C
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 18:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E008C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=JvgOmnIL
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eafb65e204so722778e0c.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 10:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793903544; x=1794508344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZFFGdirTAMGtbCDF7cv9kKouCz6oxttoVV1PmG5xK7s=;
        b=JvgOmnILEp6JoB8exJAxxf1LyevYPecxPtWt07s45vFoiXwM/vGzxz6h7ok69LJvKi
         EG52ZDyJHVw0E38MPTMnUjdz2EIndjE98ddI5PYY443VrBXbNSU0m7H/X+3OO+Zdmi+5
         Iz1Vuq9QASKNq7xMUvH62KWgK4P5i0pxrd57CmQOSDlBm63qfSimGQqUxxt/ExN7d9dC
         ueuY5vyFcxK4h/br9E+xv9+95pSwxQw8WSLoUPiXVVZQK6m4o//DKXX27ABQG0jxdnWR
         vFohz0VzJ+eltDMQmzaWdmwM8rcgAklwdVrsH+3QrAqQX9OsIbT9QJy+ru/xOevv5Yck
         CbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793903544; x=1794508344;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZFFGdirTAMGtbCDF7cv9kKouCz6oxttoVV1PmG5xK7s=;
        b=MvNxKdUc8MdC+qdSV909C0HI1ZPh8pr58S13N792UJ2NwJynJ4j4ZuEDMZcozXQwg1
         QOnwBTRGKwUTLn8rnIfjOdt8bYoBFj5Idx0t5MwPDOI+0wedbU0h1QP7cjFA50FbkZXt
         YYGnQKMv8ymFpCQ2gzfLfKYBo/rjIdVuYs3QRVVx3YgW76lqxYLDgA5lFlCSaEQIQIUI
         pboUHNVLJQBy+YGv/Jsmd5Nqmv6yjXxKx3fPdzCsLqjhnE35FJiyabciWdyaOM1HEpeM
         HTWnAtFQTNGjXldqBG9dJZsfF2hk4uVaGK+ktL007xBpA46OaOGE2lRzpgoCQyRcPDOF
         sjVA==
X-Forwarded-Encrypted: i=1; AKwUvBznlydtpzJaU8Z/+37YrGSyfr8cv17XL5cFK4QQ3/LhEXDbguvwomaP/9U4102zNXwF+Xs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kyfIe0GZ5gT2knDkeSXg3At/7mx1bFWTdK+QiFah1vkBs/AWY
	3UCEVCmjc3LLtoprIRF1O+VnEE43KMjE4YCxtaRHVzs3oPTfsaucmi/N1CGpR47smiA=
X-Gm-Gg: AYBFou1uLY48DrcVtfEPdUNjkoOAfCoGf1Hck+Dg47i038E4ogs2e4j70wpZbf9F4gz
	nUhDPfcGwjKd+c9rNwA7/k213xcvNT25Jwx0oE8L0vfDT1atCgRnDH/tz9iRXeIl8Ne/h9w7ktn
	ukYESqb1qF7P1V9/ZflGMFm72O02uBrKDcL7QBHJXoU/og2nsFzhXyjNDKZkTclgyjlKudNbXiK
	YeeuEHFT+XhmrdkorK1YIjq3DXhNkoevX0CCDT5wZfzb7fwiMCq3QhMeSn7+13bIJBLn5g6+P3D
	kvjnjZGTgL4FzWLHi2cYGDoR1uSS1iBOuUUdBA4Fr2OXz2dFb6P6StLfA2hAcOFkFZUKtbpQREX
	Anib2K5PRPr2BSoUMHwrp0EOR8dL2ZG90TrJNBAkwyRh88m2W0uHBxp+V3OSQjcJpCRiaLwAbyR
	DPQMEeLJ4xxnLpuEYKMCi9L6QIU6EU79Wo0etOEG7z1ZEK/kttDg9kHm3pnxS46eQMS/oxyFt4d
	GARWQpy1PTQJ9P+69zc5YfxaWmrfcyk5Ubb8BusQYaniRrJkGvK7oiYnli5qlvg6YsdleskNpvy
	xvIQq/4JAIMJtkKy2GssqsTDZsjGDibumDeQZk4Cw0SkEFs2fG5gZnnmiMtab6TtOySjzNcQPQg
	pMN7aPvR9xQ==
X-Received: by 2002:a05:6122:1782:b0:5ea:e1cd:6e4a with SMTP id 71dfb90a1353d-5ecc446d6b1mr99753e0c.23.1793903543539;
        Thu, 05 Nov 2026 10:32:23 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d77c6esm5043981e0c.6.2026.11.05.10.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:32:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP2G6-00000003Ng9-0h1l;
	Thu, 05 Nov 2026 14:32:22 -0400
Date: Thu, 5 Nov 2026 14:32:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tan Chi <tanchi25@mails.ucas.ac.cn>
Cc: gong.shuai@sanechips.com.cn, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	anup@brainfault.org, atish.patra@linux.dev, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, pbonzini@redhat.com, seanjc@google.com,
	kevin.tian@intel.com, andrew.jones@oss.qualcomm.com,
	fangyu.yu@linux.alibaba.com, wu.fei9@sanechips.com.cn,
	zhao.qingye@sanechips.com.cn, gsh517025@gmail.com
Subject: Re: [RFC PATCH v2 9/9] iommu/riscv: Add riscv_iommu_attach_dev_nested
Message-ID: <20261105183222.GE663069@ziepe.ca>
References: <20261029061131.584453-10-gong.shuai@sanechips.com.cn>
 <20261105144944.10193-1-tanchi25@mails.ucas.ac.cn>
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
In-Reply-To: <20261105144944.10193-1-tanchi25@mails.ucas.ac.cn>

On Thu, Nov 05, 2026 at 10:49:44PM +0800, Tan Chi wrote:
> Hi Shuai and Fei,
> 
> I noticed a potential issue with fixing the physical DC's PSCID to 0.
> 
> In QEMU, different VFIO devices can have separate stage-1 HWPTs while
> sharing the same vIOMMU and stage-2 parent. This means two devices may
> have different first-stage page table roots but the same host GSCID
> and PSCID=0.
> 
> According to the RISC-V IOMMU specification, DC.ta.PSCID identifies
> the first-stage address space when PDTV=0 and the first stage is not
> Bare. Could this cause the physical IOMMU to reuse cached translations
> across different stage-1 address spaces? Even broader invalidations
> would not prevent such cache aliasing.
> 
> There also seems to be a related issue in patch 6.
> riscv_viommu_cache_invalidate() unconditionally forces PSCV=1 and
> PSCID=0. However, an IOTINVAL.VMA with PSCV=0 also invalidates global
> mappings, while PSCV=1 excludes them. This appears to narrow the
> guest's requested invalidation scope and could leave stale global
> translations cached.
> 
> One possible approach might be to use the PSCID from the guest-provided
> DC.ta when allocating the nested domain, and preserve the guest's PSCID
> and PSCV settings during invalidation while substituting the host GSCID.
> I'm not sure whether additional considerations are needed for PSCID
> reuse or domain lifetime, though.

If the guest is issuing invalidations you must always preserve the
guests "ASID" or whatever your HW calls it. It can be virtualized and
mapped from a guest view to physical, but it must be preserved and
physical must be 1:1 with virtual.

Jason
