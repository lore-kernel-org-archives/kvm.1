Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF1E47ECDB
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318835; cv=none; b=FvJyD07Dfgun1NvHbSQublMCxYQ0wA+j3W8lbSFmCVidOy+l+mki6A6QVoeMOWR28J1pm1Su+QHslzR/ycgWOZWsQlOcdTaJZWq7oddchD7aTFsSQ/3AhgKA62fsJSJ/FUxypZ/lqKmvdjj0g8UCoMLcywg71ah1hrY+QIl2vm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318835; c=relaxed/simple;
	bh=5klepE7p4Hg1qEAbCF6RZZu8Pu13Alz4PVZPELP3bS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nd+81YfudwMd9U3w8lMfqOHtqDkVNtS2hLPv4OrqvrZVzOTV63E7hng5Bwy9Yu4BbzCUb6FVx1sAEQFmoFgVN4hzmfXoY+GKbn9oiBm6r089qS/uHLYie/jKSvmuPPj4w3Bo6jgg+fjN5pFqfizWvbt014Iy2+tn1HmX/qdc+ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uuvg/Hmf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uuvg/Hmf"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so681717f8f.1
        for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 06:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787318830; x=1787923630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=93TKIYVELb3f7XMDYi0bAF+lcotYrliPfpYhNsdjWuM=;
        b=Uuvg/HmfdhudG2I4OkIcuqi0ihof2HdqZeKDbGqe4K7rtcg/jZuIV+5wtYUtm0VrSH
         Few3nfouzm529EJIoWKAZkfHTZqnlZMbKqV/0+rsqABiJzOoVNqBeLXHgmY86Hint+xo
         aRcqJVH2GGtDgvuKIo0xtdXWOM6rA6CBJ+JSOPugVTPwXrXN8CwNstu7nCpwr/O83XcM
         XMdTD5c4+ruoXBOHgQeS+DZ14vYPUBia9mBAlPrrdJjoWtkbbeuwnU+GbMFukPsoOE/h
         WElOgELVgPVCokpRqEMCO7y9F1QUYCx8hHaSyNvmDeu7WNquADXA3oF0H9canxnKrYeT
         QDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787318830; x=1787923630;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=93TKIYVELb3f7XMDYi0bAF+lcotYrliPfpYhNsdjWuM=;
        b=nDR2EwAvsNzagnCn1s/IlpMHZmwDu7vTo3OUEvmM2lhkRvN5PdjY4DRMiODE1u2G+R
         5NwjD5UyqpYnPe2F6bWZJzPH8D2CihmloR6Ni0P8N4c5vpiXUUxqFooG81YM2TG4Iotx
         odiEOwKESJL2HH5vXdoQcq5WpigcmB0yjepq2w8s9t/2Vvh35cLDvf7d3O9AkJNGEwWe
         hKMDJVcKpGZXMKO9WojDzenmDqJVefvBqwQ3otrKf5jbf/VRqBE1HYfXd9DmCrZVX1d+
         C0F3vUQSWD7fSWYGUngQFy4Jkpwkd7n4QgFQqbW7Wwx65hvMtE0hFtWUwrD2IqzsooNS
         UBRw==
X-Forwarded-Encrypted: i=1; AHgh+RotCz3yeG/0HONO0rI+4Zk8YeVqrXtdEpsmGA97vlwOPEp5I9dBVqxcSzygY9TuxTQazJM=@vger.kernel.org
X-Gm-Message-State: AFuF++kYNHE7TcawrLOX8zm0HEcwokjklML1paSUSvoK93Ji6tSTLlnO
	9k4phDy3bdE6HtX9dpdIZsbNLhV3nVwCdTgubu/+WRbk/ZG0p/kX2pSC
X-Gm-Gg: AR+sD13xfegSLyqIP0bdyuWwmXCGKmrHCgHfPBLbQm0iq4D2xd0YIr6PA6ke8YDnT9F
	1C/VM9QQR7Oi0+0eQuRd/WY/JYdonuhVCfgvN5XB+h/Uy8GuPUqXJ4JXclHrXQwXToNBDcI+vVu
	2bWDffmEWUxoNxKxFNZrW1SBCWirrlXcVN1cDylVYgVs1WVQgSK/ZeBlsBJCKL1uYj/bcUwju9w
	z3lIpB/fskeb/UVmXbhQSKKaC6ngU7zFot/0dnnip5QY3RZyUABpWQKkVg7UC4Tp5r3nG7f4n40
	vW2ZT1pktHzpAXxT6znxvJKL4y19kA+lBHQ7ohZIQgmC0BQKF4d6fCnlmm7Z8VNoR90akGa+Es8
	qlfKODzlhNXl1Q8Ur2SRmbKq16Itcvh4JIIlpNzQMFDzoMhkPjgAs5qFrPejUqcqOTymcel3yhR
	mbUDJW2ZDZIWI72fxZNWk/nhQq77o9QleOPjeVQTOAt+oqmwaTpMp/vfaWaN24JQ3K21WN1mVoH
	lFBvw==
X-Received: by 2002:a05:6000:41dc:b0:482:aa2a:52f6 with SMTP id ffacd0b85a97d-482c0b41f95mr10002245f8f.1.1787318830006;
        Fri, 21 Aug 2026 06:27:10 -0700 (PDT)
Received: from [10.45.28.226] ([15.248.2.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482bf82594esm3408856f8f.29.2026.08.21.06.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 06:27:09 -0700 (PDT)
Message-ID: <12442106-e756-4902-b9fd-c760da04f849@gmail.com>
Date: Fri, 21 Aug 2026 14:27:08 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] KVM: arm64: Add pre_fault_memory implementation
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: maz@kernel.org, oupton@kernel.org, pbonzini@redhat.com,
 joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
 shuah@kernel.org, corbet@lwn.net, vladimir.murzin@arm.com,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 isaku.yamahata@intel.com, Jack Thomson <jackabt@amazon.com>
References: <20260612162354.73378-1-jackabt.amazon@gmail.com>
 <20260612162354.73378-3-jackabt.amazon@gmail.com> <ak5sAxb3G6hhFmBF@raptor>
 <alEXGmKiXgWPPdhF@raptor>
Content-Language: en-US
From: "Thomson, Jack" <jackabt.amazon@gmail.com>
In-Reply-To: <alEXGmKiXgWPPdhF@raptor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Alex,

On 10/07/2026 5:00 pm, Alexandru Elisei wrote:
>> Does it guarantee that, after it completes and returns to userspace, the
>> address range [gpa, gpa + size] is mapped in the VM's stage 2 tables? Or
>> does it guarantee that the address range was mapped at stage 2 at some
>> point during the ioctl's execution, but parts, or all of it, might not be
>> mapped after the ioctl completes and returns to userspace?
> 
> Nevermind, spend some time thinking about it and it turns out it's
> impossible for KVM to guarantee that the memory is still mapped after the
> ioctls returns.  So I answered my own question, thanks.
> 
> Alex
> 

Yeah it's best effort, as if a vCPU had faulted the range itself. This
could be undone by an invalidation or memslot update. The value is in
the common cast (for us, post-copy migration) the guest doesn't pay the
stage-2 fault fault cost at run time.

I think it would be worth me adding a sentence to the documentation
noting there is no persistance guarentee.

-- 
Thanks,
Jack
