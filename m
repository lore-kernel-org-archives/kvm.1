Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634965;
	b=aJjLmCjQM5LbWlqjuP2bDpOR2nPZNX+k9R2W+ZZc/yFvizFPQ4FhyXvtrvONibJesJAm
	 yIRLlGR+7Kp7XD43h/vB33867vQssZijh2Z1L4EBa/1wx71cKVu1CpVfrqaPFY5hbHWcf
	 g6sfBzZRwGmblpuHXwcLLTNrUoVv2DZ7XN81cefrq6CTkysWuavRqrFQhDF6LJox4+MNy
	 DmxWMdQ2JtSYXdh/o1d4bXiWWPtQCso2TwW0IYpnqDvj/4FVN8ClWingEQXNxMupqkggP
	 n0ffpwIugv5goMUFOJgbmkFgzV1BfZ+KRy4ol6tUrZ0aGQM4Vqcns3ysOTKpEJv6xJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634965;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=WOD7jNOguTPM3f0I1EurNaX4vtHpw/z9o1XjLk8dmuM=;
	b=tV1rTgOr+R3na/ADUVJkcwnWI79TXFkL+9tGIx2GXCRcdVDCHEDQ6flxN9PH9I7C5qAi
	 v9bYAN2wpeRbGelXO3AxidEmku3Doe/SDyJ+busJ4Mp3EYsAT+MY9hzuP9gOVtgC2/6l1
	 g9brkyYNydA6pXt4S4viU5spFM6t0BUBaZ0N+upSHg0PIIez3cCO9VpdGIhPP3Yzxf3Dm
	 OD2PjzABlu0wHD0PHCaytEjcn5OFWA3dOyIPz/kWRmFE2Y6T+hhQyLwYW3rJGjB1sVvN7
	 4AtZeBuVlqAgkTUJsGtrwQRRaA2NL+Ry75EA0z2FOcailTCSWSP1loaMn8CqifAOLVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="X8w4/AbF";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06DC606EE89
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B06DC606EE89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=X8w4/AbF
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1C891691;
	Mon,  2 Nov 2026 07:56:00 -0800 (PST)
Received: from [10.57.58.9] (unknown [10.57.58.9])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF8733F673;
	Mon,  2 Nov 2026 07:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793634963; bh=sK8CDXUGmOLbKSZoZedtgP+NgS11nXnsgqrqH7cwaJ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X8w4/AbFkMqcI9AjrwJEDpVcy2lynhF/HzWTp314P2oc9qiwkI11BehY2vEXmSTDO
	 bZDiW2thPiKLVRtAaVD9womR1e4wQ8XitrZ6Exs3J+oFAcis8xCy/VALmiC/IO1CoK
	 wRI1OKmieIuLJ3gFQs1NSBC0fz8eD8HNP76WiMA0=
Message-ID: <0bdedddb-a235-48b4-a60b-27f369624732@arm.com>
Date: Mon, 2 Nov 2026 15:56:01 +0000
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
Subject: Re: [PATCH 04/11] KVM: arm64: CCA: Check for LPA2 support and SHA-256
To: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
References: <20261102141304.126883-1-steven.price@arm.com>
 <20261102141304.126883-5-steven.price@arm.com>
 <sashiko-outbox-193589@kernel.org>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <sashiko-outbox-193589@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/11/2026 14:38, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] KVM: arm64: rmi_has_feature() passes non-constant mask to u64_get_bits()
> --
> 
> commit a9400749495394b73c9cccd919996b48771556fe
> Author: Steven Price <steven.price@arm.com>
> 
> KVM: arm64: CCA: Check for LPA2 support and SHA-256
> 
> This commit adds feature checks during KVM RMI initialization to verify that
> the RMM supports LPA2 when KVM has LPA2 enabled and that the RMM supports
> SHA-256 measurements.
> 
>> diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
>> index 9d118768550d6..5b07beff8bc91 100644
>> --- a/arch/arm64/kvm/rmi.c
>> +++ b/arch/arm64/kvm/rmi.c
>> @@ -6,8 +6,30 @@
>>  #include <linux/arm-rmi-cmds.h>
>>  #include <linux/kvm_host.h>
>>  
>> +#include <asm/kvm_pgtable.h>
>>  #include <asm/virt.h>
>>  
>> +static bool rmi_has_feature(int reg, unsigned long feature)
>> +{
>> +	return !!u64_get_bits(rmi_feat_reg(reg), feature);
>> +}
> 
> [Severity: Low]
> Can this fail to build if the compiler decides not to inline
> rmi_has_feature()?
> 
> In include/linux/bitfield-fix-width.h, u64_get_bits() calls
> field_multiplier(field):
> 
> static __always_inline
> u64 field_multiplier(u64 field)
> {
> 	if ((field | (field - 1)) & ((field | (field - 1)) + 1))
> 		__bad_mask();
> 	return field & -field;
> }
> 
> Because rmi_has_feature() is not marked __always_inline, if the compiler does
> not inline it (for example under CONFIG_CC_OPTIMIZE_FOR_SIZE or compiler
> instrumentation), the feature parameter is not a compile-time constant inside
> field_multiplier(), preventing constant folding from eliminating the call to
> __bad_mask().
> 
> Should rmi_has_feature() be marked __always_inline, or use field_get() or a
> direct bitwise test instead?
> 

I'm not sure how likely this was to fail. But there's an even easier way
of writing this function:

       return !!(rmi_feat_reg(reg) & feature);

So lets go with that. I'm not sure why I'd used get_bits here in the
first place.

Steve

