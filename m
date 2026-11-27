Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799041;
	b=3ZJp4wihAl+rlYqbpl8Ac81v5njWqY87j1esYTd9usi2qZ/sh/LK1o/D2TvE7Yw/7hKg
	 4MAXIaDB4ZBHZCS/wOy/htxr1YPPIAeBjypPgvTTu/U018GT1w7A5gPH3gvGlX6uDGO3n
	 zKJ2RWhm16j9kBXZOtzllNtmJX+AUSiwbC4J2EBEsqmNSbhgFnHmMkA0WCEv0QJReNShY
	 lBJNnpJUeeFc8vj53v8aYRxFJ1xgJMszRDsYvpLeJ9ko6ZY9cEeNVH4cRSwFTFHZNJ2H3
	 UAPeiYyZ3Cpf/W00nkXoEu+lgrI5T2o63toH5387ZcKgiDIN8LZ5Fklabruu3FF4uLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799041;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=mvdbAcNvPUl8+xzdr4AGicznVSCZCG5IMnLlhWSXHrU=;
	b=T14GhyVEbvBo/TrRyFCgu9EbbCSFkf/g3t9Jl1A58eC3au9yw+N6GDOa3rksGavTcczY
	 YQ4WnkHQLOQsQOk4vzcvRC6AsKfm4N9kna4QNoYqHNuYQEIHdeC+e6Xb8yVjBv765Ft1L
	 9LMFnyiuFJ6M7YcZF+ev1PLdav6LA/nyePcjLMyo0uuIjSz1xiCp6rQORa4n2HQpGFCcO
	 KoY8Bv8wZ5XJbLOTeetusX2BOj9Rc2sHX8h+ocxVY1vlqL88hMBNdGxOLF7Tjl25J5ncL
	 /z8mjJoiTqiRUItUu86y6z6Qa6PIBnTCbm1r86KVUrlGDJAnA5mjGw4SfGtftKrZc1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=tTkQH1ZZ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562D5606A31C
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 17:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 562D5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=tTkQH1ZZ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 097361575;
	Fri, 27 Nov 2026 09:03:58 -0800 (PST)
Received: from [10.57.93.100] (unknown [10.57.93.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B22653F632;
	Fri, 27 Nov 2026 09:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795799040; bh=i+TR0LzfgP/WQDZoX/lAs0W+jLjvNb+/N+OgMW3wgv8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tTkQH1ZZfilUfU3xL7Yhc+Jx/xhLm5R5sKA/HF/HbtoIdwQyfb0+pnWiJtFaPOfat
	 IIIuNDYDs24vugGcoicxQ7dSLW+uyvT94G04XT7TlOULBPuHuBee6FCMxLjZU6iOUX
	 GU6TxtjrHYWE+xM8PyTqEVXlPuwZgHKeREHNcL1U=
Message-ID: <e8d77727-5d88-42a8-9df3-234bbc5137e5@arm.com>
Date: Fri, 27 Nov 2026 17:03:58 +0000
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
Subject: Re: [PATCH kvmtool v6 00/23] arm64: Support GICv5-based guests
To: Will Deacon <will@kernel.org>, Vladimir Murzin <vladimir.murzin@arm.com>
Cc: julien.thierry.kdev@gmail.com, maz@kernel.org, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, timothy.hayes@arm.com,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261125151356.2875108-1-sascha.bischoff@arm.com>
 <1aa97f61-b740-4044-9065-f3ccfcb709fd@arm.com>
 <awhpViXFw-mts2ck@willie-the-truck>
Content-Language: en-GB
From: Sascha Bischoff <sascha.bischoff@arm.com>
In-Reply-To: <awhpViXFw-mts2ck@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Will,

On 26/11/2026 17:16, Will Deacon wrote:
> On Thu, Nov 26, 2026 at 10:22:56AM +0000, Vladimir Murzin wrote:
>> I reviewed and tested the patches for GICv5 IRS support (01-18). They
>> do what they promise - allow booting a GICv5-enabled guest. In my
>> opinion, patches are in good shape, so could you please have a look and
>> consider merging GICv5 IRS support (patches 01-18)?
> 
> I just hoovered up the pile of kvmtool patches sitting on the list, so
> this doesn't apply any more. Please can you send a v7?
> 

Done!

> Cheers,
> 
> Will

Thanks,
Sascha
