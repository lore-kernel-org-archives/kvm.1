Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEAB2E22BD;
	Fri, 10 Apr 2026 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807398; cv=none; b=hoGXfu0Qy+2qOwftMF/HeTN2CEhCJXoDOvwWZJzuB/d4hZnIT9nFg2qbp8zvJKO0maKdMex6aurYdycJi0Y8EoDqOaYZYyFkVGIKGohDuV8DD/eYImdKrHJQPBDSv9FTQa0V5tGmB88MqySAf68KX/WosZzpha73E1QGmT/QXVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807398; c=relaxed/simple;
	bh=J+jWavQnwV+SxralKrFe9zArcC8dxsG0Cw+wki5OaGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z76mtubV5hzgUFOEv9U1X5lKWC9VirD33xw2N2sPbuG08Q4FaVO1vT47q4KuuQdLD/5aqMMUq6N8FcDb21kHnEd6OI8b3aC/B2HFZdqdFFCqADCdZkIHbZKcbIDV6Ai7rd9cnPtQbeKaWw2ZtOrjAVuVP4aLy/XFmUy5768maVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvijxktS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvijxktS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D22EC19421;
	Fri, 10 Apr 2026 07:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775807397;
	bh=J+jWavQnwV+SxralKrFe9zArcC8dxsG0Cw+wki5OaGA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uvijxktSiDvFy2JwOGZcErYU/CsITVz+oWvQXiHJIByrrgSok3lew36zcMIRoyYEd
	 zNw9+mwf2LO3mlt56GlBvP0F51tpj+m++2WdNILqlvYiVtuRTcUoShn8DzyMn9kCso
	 Wsz25Xqqloavo0Da6Hf45At2kDskWO/Su9mWAtoVkOGvmw4IDhBOMVB5wxz8R83JYK
	 Bpa7379DqTAA3yU8dQh0tNYpQWaXpiqUhUzOJqqzBoPGT/ZD54lvjCVc/RhQhQeMG+
	 QbsWrMP7ifx4na0l8YKU9HcGmnuNKArheFnDMfVvMBVeZFMA18ToLEMNohoongkMar
	 94hCqyHnJ+NlQ==
Message-ID: <d4f157a3-e178-4af4-a527-8439cf11f902@kernel.org>
Date: Fri, 10 Apr 2026 09:49:50 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Reshetova, Elena" <elena.reshetova@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "prsampat@amd.com" <prsampat@amd.com>, "x86@kernel.org" <x86@kernel.org>,
 "kas@kernel.org" <kas@kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "Qiang, Chenyi" <chenyi.qiang@intel.com>, "tglx@kernel.org"
 <tglx@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
 <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
 <7802b50589c80a7276a50cc473c1aa579750a30c.camel@intel.com>
 <CABgObfZ7_w8Q-dW=Sd4YA3P==BuN1edPv7Ty4EpPyU8ctW6RLg@mail.gmail.com>
 <424048885a01dcb6a7ef0256f0dc8a9adb546f22.camel@intel.com>
 <cab5371d-e0f4-42b7-bae9-2c7f981b26b2@amd.com>
 <49e8b24d836c1883e83ad72d1ab279f9e3eb7455.camel@intel.com>
 <IA1PR11MB949557E04741169BA209A69EE751A@IA1PR11MB9495.namprd11.prod.outlook.com>
 <9b1290bbc1283a2f35bdcd177d27ae7aea89151c.camel@intel.com>
 <IA1PR11MB94952B22F6EB648ED7C1AE3CE75EA@IA1PR11MB9495.namprd11.prod.outlook.com>
 <f4639348586233245343005708372230f2d4a2cc.camel@intel.com>
 <IA3PR11MB91365041D42CB7F53DA5A98092582@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CAMxuvawVL7-9+8U=Yf7_pJcsbCivgJqFStrXAtAaiBEqtZnc1A@mail.gmail.com>
 <IA3PR11MB9136BA4C593C5254EDD9D62092592@IA3PR11MB9136.namprd11.prod.outlook.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <IA3PR11MB9136BA4C593C5254EDD9D62092592@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/10/26 03:05, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
>>
>> Hi
>>
>> On Thu, Apr 9, 2026 at 5:36 AM Duan, Zhenzhong <zhenzhong.duan@intel.com>
>> wrote:
>>>
>>>
>>>
>> how
>>>
>>> For that solution, analog to hotplug, TDX Connect needs a hot-unplug handler to
>>> use "release" seamcall to unaccept private memory before unplug, that's it. But
>>> if the zapping S-EPT will not happen in host, I think this "release" seamcall is also
>>> unnecessary for TDX Connect.
>>>
>>> I also have a silly question which I looked over this thread and didn't find answer.
>>> Do we have to support private memory hotplug, what benefit we get to support
>> it?
>>> If we only allow shared memory plug/unplug to TD, then we don't need this
>> series.
>>> Guest decides to convert shared memory to private after plug and do the
>> opposite before unplug.
>>> This works for both TDX connect and memory unplug as memory release is
>> implicitly triggered
>>> in memory convert.
>>
>> I did some successful experiments with modified QEMU & kernel, this
>> seems to work.
> 
> Good to see, thanks for verifying.
> 
>>
>> On virtio-mem plug, set_memory_encrypted() makes the memory private +
>> accepted. On unplug, make it return to shared with
>> set_memory_decrypted(). QEMU handles REQ_UNPLUG and can punch both
>> shared & guest_memfd planes (which will TDH.MEM.PAGE.REMOVE).
>> Re-plugging also works fine.
> 
> If guest called set_memory_decrypted() on unplug, QEMU punching
> guest_memfd in REQ_UNPLUG is unnecessary as it's already taken during
> memory convert. So just to confirm, you want QEMU to take cover the case
> when guest failed on set_memory_decrypted() or never called it?

Once we have in-place conversion with guest_memfd, the punching will be
required, though.

-- 
Cheers,

David
