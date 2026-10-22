Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792690571;
	b=p0s+t9wrNDxttD1rdao06WeykwTOPydppjGWMbR+AxYe6Ph892CYtbK5ks4a377tbop4
	 O/plroU4Fp8IqWAvEGxpAX5r8pQ7jR2PG75ULKFVWobSkhN6Gw8Z01kyxYHMBzNF1na7S
	 jgBHxXb/ZVIJf5fxls19CjRwVFrgJgLoDIKApeBQEFGVaCbAS8oE3LnBJBVI0H6Ixp3BW
	 jl/jJrj0Kw9QezdJYih9gscI0UNNVpHsGOYyEcjpynkARj6hgWLsPYqHpzG9aInqA7YZ7
	 6wOOThISx9AUYVMqEs+RDqbT93JaM7VC0RmXMO2vTwWvkLC0upA6oFk13zwMIGi4V5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792690571;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=l+TQBu4SXtfqFnKBes+LVkp2Ddr0ISNvsx6EE4IKKwc=;
	b=5faj8g4lB+pNhED6J2DOBNCHyf/X5v/ZHIwC/Cu+AppF8SiVjCEGq8B+Icbv1UHj4/Sb
	 B7GOTh7CACLTWz/gY/dAWd4R8BAdeF7HcJaulr8RB6XripBkmfxA4Xixu8CHot+dMaB0n
	 j1dieKZdAHJd2aU8fROBKx8WX9M1fIIrI39wSWS5n7u2sOP5U4HMxkomIc7adMlfV6w9Z
	 ZhCb9LCp3byYYlZ2IGY+Rtekhtybrz2WDGQAlFexUcwZqnWwbV0T34jMr9i4vvEEu+LLU
	 a2eoJRW+yeFmWipmklmoWQ2bbz6JrTW0Yd88sI8F03+nK8a07JVZhJeiEiC9Lx/jraA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XohEXmmt;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9047B606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 17:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9047B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XohEXmmt
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 440461691;
	Thu, 22 Oct 2026 10:36:05 -0700 (PDT)
Received: from [10.57.76.220] (unknown [10.57.76.220])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C46823F673;
	Thu, 22 Oct 2026 10:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792690568; bh=lHYN89xQNU74Xdvy0zIAa5XVtCOYzCD6u7ACK7KXC0U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XohEXmmtUeUuMVJgnwr/lb6SNHl8RmkjLOTgEOGbggF5bd+/gL3BtCwY/7cPaODHR
	 AXvJ2KVTXeJ3Xo6OenhYhkgbu5VkZhGgCH/5Qno5oTDey9HzzJF8/fDnPvd77Cl8cd
	 avpjToRyWv3AZ5JFOHnm71kYKeDw8HWzXYMU8wPU=
Message-ID: <0e6348e8-e151-4e6d-a275-6ac113a5b8b5@arm.com>
Date: Thu, 22 Oct 2026 18:36:04 +0100
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
Subject: Re: [PATCH kvmtool v3 02/21] arm64: Close the ITS descriptor when
 setup fails
To: Sascha Bischoff <sascha.bischoff@arm.com>, will@kernel.org,
 julien.thierry.kdev@gmail.com
Cc: maz@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 timothy.hayes@arm.com, Peter Maydell <peter.maydell@linaro.org>
References: <20261016153939.913764-1-sascha.bischoff@arm.com>
 <20261016153939.913764-3-sascha.bischoff@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20261016153939.913764-3-sascha.bischoff@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 16:39, Sascha Bischoff wrote:
> gic__create_its_frame() closes the device fd if the address attribute
> is unavailable, but returns without closing it if setting the address
> or initialising the ITS fails. Route all errors after device creation
> through the same close path.
> 
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
>  arm64/gic.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/arm64/gic.c b/arm64/gic.c
> index debb0381..f8371f50 100644
> --- a/arm64/gic.c
> +++ b/arm64/gic.c
> @@ -124,17 +124,22 @@ static int gic__create_its_frame(struct kvm *kvm, u64 its_frame_addr)
>  	}
>  
>  	err = ioctl(its_device.fd, KVM_HAS_DEVICE_ATTR, &its_attr);
> -	if (err) {
> -		close(its_device.fd);
> -		its_device.fd = -1;
> -		return err;
> -	}
> +	if (err)
> +		goto out_close;
>  
>  	err = ioctl(its_device.fd, KVM_SET_DEVICE_ATTR, &its_attr);
>  	if (err)
> -		return err;
> +		goto out_close;
>  
> -	return ioctl(its_device.fd, KVM_SET_DEVICE_ATTR, &its_init_attr);
> +	err = ioctl(its_device.fd, KVM_SET_DEVICE_ATTR, &its_init_attr);
> +	if (err)
> +		goto out_close;
> +
> +	return 0;
> +
> +out_close:
> +	close(its_device.fd);
> +	return err;
>  }
>  
>  static int gic__create_msi_frame(struct kvm *kvm, enum irqchip_type type,
> -- 2.34.1
> 

FWIW,

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
