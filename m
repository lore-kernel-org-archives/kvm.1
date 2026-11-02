Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793652717;
	b=033ITd8Jrr9N3h+ex/be26P5VzO1C++dr4cOjbtLk3gc2/mVZL+gKs+yEFFlX/eqdBsE
	 YDqqlilmFzQVi+Gc2Y+cElv8yz01/mHTp0CNM7BIV/hRWi4biM8pBFESupbDMiQe7K8zj
	 6zh4ltSg2a6mlJib3VvLFoASQr1LoMrDL/G3MKD3CXtbW7ABZgNoE464gXcMVCUj47EOp
	 8Ugf1eezAfe4PS0RPj+kFgMom72BeLz5Teqe/P8/oxdF921PhFYc+FK/p7wZinWaPZjmE
	 tI0w/q4RzmT1MvJeG5y/3iYj8Sz1aAN01v8+JoYIp86BDyCpYtH4w6D3mvdSnbdP29w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652717;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=mXkAlDp/jDqONv+JRtyAiguFrJKWiJTAxrPRZ+Lf5Nc=;
	b=wM/ENXh9ZG6OMFvDsDEConyWY5uAVY/nwlmG+hyERBFvdOicofMKi9heLkvBAS/wxFCp
	 ExjUZ+DvItQ45dVr5tkNmlSm7SZIWT9m24+4K17EMx2jZ+ocEqJhMUgxzkEoBXkaAswAz
	 VDDl+1pCdDyd8A23KYCoVkpaP1K7yA/1T+k/xT14guMlkTl7sEZLlIRMHBS0zlvP1UJ7O
	 /0DVfpEeCz00pbJfv69aEMSQWbNbp9xfZw0m3UqBhuT+DL11DT7p0jlVHBimonul+MSRa
	 OKD4C5i1suczX7qJjeMSrrabw2g7TQz+MWQH6xKaiUo8GIS8AXaPkZDPv304WJUuW7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="hk8/ZdKT";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A94606A326
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 20:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18A94606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hk8/ZdKT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 075A5152B;
	Mon,  2 Nov 2026 12:51:49 -0800 (PST)
Received: from [10.57.89.36] (unknown [10.57.89.36])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D803C3F59E;
	Mon,  2 Nov 2026 12:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793652712; bh=mgQn+vHOFjT2swpROsPep99kP2Me6p9DgEiGrp4PTPw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hk8/ZdKT1NluAKxyYzyFN2s4pgd7tngHZxYGJRkQGgeiPRZVWmheZh/O27eOpQXz9
	 s4gO7PSEjeVL7OoeQK9JGajNq+ayQlN9PHvi9+pM+163PfCVVKacPslDhRHfNZgG/7
	 KtuNor/mESZFZJy4A5vRG4YNEf/+ZcsUzAWNblIo=
Message-ID: <a9f3e466-ab2b-4c98-a237-d8bd6810e06c@arm.com>
Date: Mon, 2 Nov 2026 20:51:49 +0000
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
Content-Language: en-GB
From: Sascha Bischoff <sascha.bischoff@arm.com>
In-Reply-To: <412dc63b-df1f-4748-8235-542ecfc23894@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/10/2026 13:03, Vladimir Murzin wrote:
> On 10/16/26 16:39, Sascha Bischoff wrote:
>> Describe the IRS CONFIG and SETLPI frames and associate each CPU
>> phandle with its IAFFID. This lets the guest discover and configure
>> the IRS for shared interrupts.

Hi Vladimir,

> 
> Out of curiosity why do we expose SETLPI frame to a guest?

Frankly, in case we want to make use of it one day. The intent for the 
SETLPI frame is that is allows the injection of LPIs by a device without 
an ITS being present. Effectively, it gives MSI support without translation.

Rather than writing an EventID/DeviceID pair to the ITS_TRANSLATE_FRAME 
(specifically the ITS_TRANSLATER or ITS_RL_TRANSLATER) and having the 
(virtual) ITS translate them using the Device- and 
Interrupt-Translation-Tables, an implementation that includes the 
SETLPI_FRAME allows a device to directly write the LPI to make pending.

This isn't something intended for use on the physical side, so we don't 
strictly expect any physical implementations to include the SETLPI_FRAME 
(famous last words?). However, it is something that an emulated GICv5 
implementation can go and do if it doesn't want the complexity of 
emulating an ITS.

When initially prototyping the GICv5 support, I did have a SETLPI driver 
that tested this mechanism, as software buy-in is also required for this 
to work. Instead of programming the DT/ITT with the translation, it just 
gives the device the desired LPI as the "event" instead.

Does that answer your question?

> 
> Thanks
> Vladimir

Thanks,
Sascha
