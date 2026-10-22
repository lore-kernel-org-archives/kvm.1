Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792690500;
	b=xqROJpyUpI9o5W0W0hyEAYcQvVOKS0Zx3eSt5ixBDwYayquNH/5xPA+efFajBH7eR8XG
	 riKkoePWgKyddpbrlz1or9/aVIXjM/1ae9D00YWxqDeDxnlB6gWQOlchsEWtqMVoabGuF
	 VqQBVc5IBbB2bcvDRWfP/cp9KbBwFAU2WQax0cJ9qRlgWXcvNZyY0VDYmrKReL8JoxBod
	 qsQUNLciIqpj4ce3rKHLVlK3I7rVdPC2Pw2Yzd6+tz0WI9bxOj27YKfPdmKyhx/4mqlPb
	 K3q+QezHNfwWWr8QByDdgm+K1PFPmBtRp5E3E0uShzxRevkz3RlBNGRGjUEXnaruNEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792690500;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=8J1zzDxtlEA13ky6xYJ/w+ZJ3LY5rj/np53fpaLDum8=;
	b=OuKMSMQMMzzPYCJSj4h+IKVB2/LTyXMQyDmDQwHPDskohR2kU2mQx+P6xVtNn60LOSF2
	 +LgrOkKYarwIfBrGsPTG7HxKRh5opO4NYknNxLnA95xSkueaejiNRrzvT2nl8Yvc8WB6O
	 48riBOs6KVTE6cEc2JwhhH3x3SeTFSmCkDmofoUOy+dKzV8JEx4gIOTIYhHTdid3bQ5an
	 3vatgC3hkx5T4RRra2qWkWrv6wbzQepX78ogG/L7JRWDo9BY1WW2QLZT1CSjf9vSk0aHA
	 teSmTexrWCpBTT1aGRSG955gNsOlIn/U22qN1AebWVxsGut4H2uRnUpTQ3YqLmvCkFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cr+LiqX6;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FAA606AB64
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 17:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7FAA606AB64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cr+LiqX6
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8364E1691;
	Thu, 22 Oct 2026 10:34:48 -0700 (PDT)
Received: from [10.57.76.220] (unknown [10.57.76.220])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CB493F673;
	Thu, 22 Oct 2026 10:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792690491; bh=wULjyGcKG4QcdOpXfpsEHSuPmredAn2/K/5P6lqhDNw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cr+LiqX6dxnXyLCw6xcG/iiQ6lcbH2bua/6JIR9Sdx6NiJ7Zxwgdi5SE9qksYSe+b
	 ktoOVvsAeu4AJfhU0NNcOhHnAIuqI5pXCJdoySjpJTN9pJXqo6xGAOR9TzidsE9XnW
	 EI2YkVhAW7DbynslCf0yp9btO9PFWcp7CkDg3Gd8=
Message-ID: <84e2b43b-5c4e-4e15-813d-856ce21d25d7@arm.com>
Date: Thu, 22 Oct 2026 18:34:47 +0100
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
Subject: Re: [PATCH kvmtool v3 01/21] arm64: Propagate IRQ routing
 initialisation errors
To: Sascha Bischoff <sascha.bischoff@arm.com>, will@kernel.org,
 julien.thierry.kdev@gmail.com
Cc: maz@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 timothy.hayes@arm.com, Peter Maydell <peter.maydell@linaro.org>
References: <20261016153939.913764-1-sascha.bischoff@arm.com>
 <20261016153939.913764-2-sascha.bischoff@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20261016153939.913764-2-sascha.bischoff@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 16:39, Sascha Bischoff wrote:
> irq__routing_init() can fail while allocating entries for the default
> routing table. gic__init_gic() currently ignores that error and
> continues with a partially populated table. Return the error before
> the VGIC is marked as initialised.
> 
> Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> ---
>  arm64/gic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arm64/gic.c b/arm64/gic.c
> index 1e400962..debb0381 100644
> --- a/arm64/gic.c
> +++ b/arm64/gic.c
> @@ -344,7 +344,9 @@ static int gic__init_gic(struct kvm *kvm)
>  		}
>  	}
>  
> -	irq__routing_init(kvm);
> +	ret = irq__routing_init(kvm);
> +	if (ret)
> +		return ret;
>  
>  	if (!ioctl(gic_fd, KVM_HAS_DEVICE_ATTR, &vgic_init_attr)) {
>  		ret = ioctl(gic_fd, KVM_SET_DEVICE_ATTR, &vgic_init_attr);
> -- 2.34.1
> 

FWIW,

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

