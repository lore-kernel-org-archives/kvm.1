Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084510;
	b=ltGija0ED7zjX/vWsBVM6BJg6G7OG2rXzyuwxXOgRc+xWfykkQF/woNQGk+U+xx/BLEV
	 uwrCid/gawBMJNCBpypiPoTSejSUWeeRHM9Z7AlDUY1AYIf889oyI7OzKLVRywvBvYTp/
	 VnLtz0PR817lYh+6FQ8mmYVARz/Fbjq25c9SglULAwoyhWjotHBhUu6DHK7M15grXhGvE
	 OuEsBocElKymHjyYy4zGPDtBDOPugBdaPbhJjKz9ThGkI1B+XRK7Nkkfbj2SZHqOv0R/Q
	 eB0jkJg2/u/RThzFDTKgqLqZdYSsy4CyxJ/jtk/Eujs1yihdJQZzYWEmhxHrSArriZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084510;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=qUBGosQXygaRBrh7YIIWL4dTbzLPidnx+0MI7jijNTg=;
	b=SF1v89+1WCeCmwd2yiN27aWAo6sMnYE55TrbY1exmAgvtSqThQ/PvldpeBz9X21b7b9v
	 5Sl2VKPGd+egfUQYamvvB9oLARInONJcFfTCcdNSO2KamPcYUg3xa6t4M/HGEl3k8U8MJ
	 SCWNqsXGchHc0/lmcZlAEzN8XfPfW9MCmVkfD2kmPL4Xb8V1p0Cb6gKf8CKqGHXM28xN2
	 8TTO6cQp0/Dc5FEi/0O4G26xq/qqAygS+Y48ri7SvRgijaY8QAuqmZwKC2cjzrN22OkaX
	 NNuDPH14Jke3vodZ8vlwPFw3mVNL7cqeP67QHQIAlPPTgRthTRVvnGNARHtFzhoG2xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=i77k2lpw;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2135606A326
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 10:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2135606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=i77k2lpw
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 046271575;
	Thu, 19 Nov 2026 02:35:06 -0800 (PST)
Received: from [10.0.136.98] (M0PRX50XMG.cambridge.arm.com [10.0.136.98])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E72D83F632;
	Thu, 19 Nov 2026 02:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795084508; bh=x1y59sCR9yQXdJGlnshQjkwI0/FKpAuxOd5Os8IVMx8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i77k2lpw71ObP0izMd86osmQda3kbDOWK1h5AJZa3/uBQMJzwIBxf6QzxhnNIhTjb
	 cIGvgajmYhjmVn1ZRAbxV8qRSnY8qpsxekfADm3btBGl27OT2YuHjsV/rHCQy6oqZU
	 Hqo7zeUI8PcUA6HMvx/BzPOOtJXKVwKagt44psfo=
Message-ID: <41ee982a-cabe-477d-80f0-fabece8637c2@arm.com>
Date: Thu, 19 Nov 2026 10:35:06 +0000
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
Subject: Re: [PATCH kvmtool v3 13/21] arm64: Describe the GICv5 IRS in the DT
To: Vladimir Murzin <vladimir.murzin@arm.com>, will@kernel.org,
 julien.thierry.kdev@gmail.com
Cc: maz@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 timothy.hayes@arm.com, Peter Maydell <peter.maydell@linaro.org>
References: <20261016153939.913764-1-sascha.bischoff@arm.com>
 <20261016153939.913764-14-sascha.bischoff@arm.com>
 <412dc63b-df1f-4748-8235-542ecfc23894@arm.com>
 <a9f3e466-ab2b-4c98-a237-d8bd6810e06c@arm.com>
 <a991250c-946b-456f-bf61-f1ab536365bf@arm.com>
 <b33b0ca9-0134-4dad-aceb-8c9cb4ada9a2@arm.com>
Content-Language: en-GB
From: Sascha Bischoff <sascha.bischoff@arm.com>
In-Reply-To: <b33b0ca9-0134-4dad-aceb-8c9cb4ada9a2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Vladimir,

I'm so sorry that I missed this.

On 10/11/2026 15:45, Vladimir Murzin wrote:
> Hi Sascha,
> 
> On 11/10/26 14:57, Vladimir Murzin wrote:
>> Hi Sascha,
>>
>> On 11/2/26 20:51, Sascha Bischoff wrote:
>>> On 26/10/2026 13:03, Vladimir Murzin wrote:
>>>> On 10/16/26 16:39, Sascha Bischoff wrote:
>>>>> Describe the IRS CONFIG and SETLPI frames and associate each CPU
>>>>> phandle with its IAFFID. This lets the guest discover and configure
>>>>> the IRS for shared interrupts.
>>> Hi Vladimir,
>>>
>>>> Out of curiosity why do we expose SETLPI frame to a guest?
>>> Frankly, in case we want to make use of it one day. The intent for the SETLPI frame is that is allows the injection of LPIs by a device without an ITS being present. Effectively, it gives MSI support without translation.
>>>
>>> Rather than writing an EventID/DeviceID pair to the ITS_TRANSLATE_FRAME (specifically the ITS_TRANSLATER or ITS_RL_TRANSLATER) and having the (virtual) ITS translate them using the Device- and Interrupt-Translation-Tables, an implementation that includes the SETLPI_FRAME allows a device to directly write the LPI to make pending.
>>>
>>> This isn't something intended for use on the physical side, so we don't strictly expect any physical implementations to include the SETLPI_FRAME (famous last words?). However, it is something that an emulated GICv5 implementation can go and do if it doesn't want the complexity of emulating an ITS.
>>>
>>> When initially prototyping the GICv5 support, I did have a SETLPI driver that tested this mechanism, as software buy-in is also required for this to work. Instead of programming the DT/ITT with the translation, it just gives the device the desired LPI as the "event" instead.
>>>
>>> Does that answer your question?
>>>
>>
>> Yes, I was mostly wondering if we are going to have any user for that, but
>> now I realised that it could be user (selftest and/or kvm-unit-test) which
>> make sure that SETLPI stays unimplemented :D
>>
> 
> Just checking, are we permitted to expose SETLPI frame with IRS_IDR0.SETLPI set to 0
> (IIUC it is what KVM currently sets)?

That's a really valid point, and I don't think I should do this. For 
whatever reason, this didn't click until just now.

I was thinking along the lines of "KVM carves out the memory for SETLPI 
so we should convey it in the DT", but that's silly. We shouldn't give 
the guest what is effectively a broken DT for the system it sees. KVM 
indeed doesn't expose the SETLPI feature to a guest via the emulated 
IRS's MMIO, so this would be a mismatch.

I'll drop the SETLPI frame part when I post a v6. Doh!

Thank you!
Sascha

> 
> Thanks
> Vladimir
> 
>> Cheers
>> Vladimir
>>
>>>> Thanks
>>>> Vladimir
>>> Thanks,
>>> Sascha
>>
> 

