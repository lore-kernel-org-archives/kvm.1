Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084751;
	b=cZ/KHB8OOuywQ9wb2C0SlY8xYXVkRr+NYmMGHF8KYYMNgVhqsPHYigKMFoXrkOkT8xMQ
	 7PPYLb6lBXCZwKZ8da480zTPmEVMSju4oX8XHkFjYlbreQtCRkyYDVhf9Xeyf/CJXUlQ1
	 yVoMlNw19Uqu4OaGjBahKVatPltwHakw1fL3tOwBADaRcq5T4Ea7FN9bhXUmTu1VghaTT
	 srcCPgz11RMb/5KMzEMx3bUhqc3mpykFgqG+Enl1dBQ1rahDpo26ga+DUQhLiH4nEWVHM
	 +A0swDzWSNrbpUKxxz37GY+2rMwOBuSZNs8EcjRCtjuQTmJ4WIR4OAae/ZNgYCu6evA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084751;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/CFNMqgfBP3bLBE7uLBIndDHOkqXQcmPAJwtB40ak1c=;
	b=v0GnmNXprihoWQ2gHz/Nfe5MT735rAKDYucHCC7JSFsdXZTufEMbL//pkMjLOIqQ636h
	 kF+0jDa2hj4zESVt9xa/XgDJmpifnOH4Tx8rdGbFIrQS8u5vg8L+10BvAT0DiIXKce4E0
	 gfzEa7f1SgJJb696U9BNCO0vNvFFqzxspwSI+KO71hLJvWPlXKchtgbeSLU5OStcod4vn
	 /yZuAMKLw517jby4bh+Rg0GWEmGuKkcB8CLgQL6PjVjUe5Ghvk/oD+he8HKqbC0pxunCz
	 UCnSre/VkL2XI4bDMJNJzqOQHasL8iJBq6re6/cf/2juXL9c7kLcuGD6fEUavXz7Y+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Mt4ux1uO;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46507606A324
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 10:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46507606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Mt4ux1uO
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B96811575;
	Thu, 19 Nov 2026 02:39:07 -0800 (PST)
Received: from [10.0.154.42] (e121487-lin.cambridge.arm.com [10.0.154.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E88DE3F632;
	Thu, 19 Nov 2026 02:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795084750; bh=JV0LK5RPuLp7eoTydNpj5/9OhWM8WMGb7O2CLvrMU/Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mt4ux1uO3Xdl5dmTxMgsQKn+/cc+MBT++J7ESSO+ww4QsHaRLweyFlxiV+M26vi+z
	 3sWgeAc9W3eZwI+M7mAdPpBViUxkRLGsDVP0/600J2S0k/4AR84lE5zsb5wbkZ214e
	 ZKIJrZGxBqCZj4J0FK2F00RKKQwwEea0BvsZgiB0=
Message-ID: <d0e948c8-0d25-4207-bc04-01bc2bb6b7ec@arm.com>
Date: Thu, 19 Nov 2026 10:39:07 +0000
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
To: Sascha Bischoff <sascha.bischoff@arm.com>, will@kernel.org,
 julien.thierry.kdev@gmail.com
Cc: maz@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 timothy.hayes@arm.com, Peter Maydell <peter.maydell@linaro.org>
References: <20261016153939.913764-1-sascha.bischoff@arm.com>
 <20261016153939.913764-14-sascha.bischoff@arm.com>
 <412dc63b-df1f-4748-8235-542ecfc23894@arm.com>
 <a9f3e466-ab2b-4c98-a237-d8bd6810e06c@arm.com>
 <a991250c-946b-456f-bf61-f1ab536365bf@arm.com>
 <b33b0ca9-0134-4dad-aceb-8c9cb4ada9a2@arm.com>
 <41ee982a-cabe-477d-80f0-fabece8637c2@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <41ee982a-cabe-477d-80f0-fabece8637c2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/26 10:35, Sascha Bischoff wrote:
> Hey Vladimir,
> 
> I'm so sorry that I missed this.
> 
> On 10/11/2026 15:45, Vladimir Murzin wrote:
>> Hi Sascha,
>>
>> On 11/10/26 14:57, Vladimir Murzin wrote:
>>> Hi Sascha,
>>>
>>> On 11/2/26 20:51, Sascha Bischoff wrote:
>>>> On 26/10/2026 13:03, Vladimir Murzin wrote:
>>>>> On 10/16/26 16:39, Sascha Bischoff wrote:
>>>>>> Describe the IRS CONFIG and SETLPI frames and associate each CPU
>>>>>> phandle with its IAFFID. This lets the guest discover and configure
>>>>>> the IRS for shared interrupts.
>>>> Hi Vladimir,
>>>>
>>>>> Out of curiosity why do we expose SETLPI frame to a guest?
>>>> Frankly, in case we want to make use of it one day. The intent for the SETLPI frame is that is allows the injection of LPIs by a device without an ITS being present. Effectively, it gives MSI support without translation.
>>>>
>>>> Rather than writing an EventID/DeviceID pair to the ITS_TRANSLATE_FRAME (specifically the ITS_TRANSLATER or ITS_RL_TRANSLATER) and having the (virtual) ITS translate them using the Device- and Interrupt-Translation-Tables, an implementation that includes the SETLPI_FRAME allows a device to directly write the LPI to make pending.
>>>>
>>>> This isn't something intended for use on the physical side, so we don't strictly expect any physical implementations to include the SETLPI_FRAME (famous last words?). However, it is something that an emulated GICv5 implementation can go and do if it doesn't want the complexity of emulating an ITS.
>>>>
>>>> When initially prototyping the GICv5 support, I did have a SETLPI driver that tested this mechanism, as software buy-in is also required for this to work. Instead of programming the DT/ITT with the translation, it just gives the device the desired LPI as the "event" instead.
>>>>
>>>> Does that answer your question?
>>>>
>>>
>>> Yes, I was mostly wondering if we are going to have any user for that, but
>>> now I realised that it could be user (selftest and/or kvm-unit-test) which
>>> make sure that SETLPI stays unimplemented :D
>>>
>>
>> Just checking, are we permitted to expose SETLPI frame with IRS_IDR0.SETLPI set to 0
>> (IIUC it is what KVM currently sets)?
> 
> That's a really valid point, and I don't think I should do this. For whatever reason, this didn't click until just now.
> 
> I was thinking along the lines of "KVM carves out the memory for SETLPI so we should convey it in the DT", but that's silly. We shouldn't give the guest what is effectively a broken DT for the system it sees. KVM indeed doesn't expose the SETLPI feature to a guest via the emulated IRS's MMIO, so this would be a mismatch.
> 
> I'll drop the SETLPI frame part when I post a v6. Doh!
> 

Thanks! I'm glad we came to consensus on SETLPI, after all we
can revisit if/when we really need it ;)

Cheers
Vladimir

> Thank you!
> Sascha
> 
>>
>> Thanks
>> Vladimir
>>
>>> Cheers
>>> Vladimir
>>>
>>>>> Thanks
>>>>> Vladimir
>>>> Thanks,
>>>> Sascha
>>>
>>
> 
> 

