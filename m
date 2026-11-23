Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.72.192.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427946;
	b=YEfjvPQRAX+/UN+cbQYghHg+8TT37vVoR7fUhUbglioHQBBQTGiE4yhqsu0B9GOqMlPD
	 VPDt0OhfueoY4/n+7QuBo6Q837w5vPbit+WF8SIQDZr9nDTsos4VMa3SpMXr8i9zRxlZw
	 RAuX6ZwcIkv8dID2YiFcnLMhb+IO8hxwM6ghPX/8tSRCPsWGp5Ijo3ZqcLpPMH5Vb7n/R
	 Y9UIo8U9BHNsJbVtWVqIvTez998cl3ClPe4Yx1NU+YU/tz36VogpO+F8wHzOuMQyHUyim
	 03wgCXHERoPLQyqecNGZpxu9T2DQYIZXtoxn+DuHraqmOq7rZJ6egGhHPSNHVwHNTIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427946;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=e2GCZKnp60CtjzBTajuBcLw7h4qhesUfQH/BNFBFq0c=;
	b=gtTlt6CrznkgxiXg9Bzm/cIvobvKMutgxLmgvIH0S14LYhRATrk0a0EWA3PmckxusO8F
	 BIxatcRScIn2KvQrK+bDaUKHXWMHocFhbx1AEVGRR6swXReUZlAnKwzWFX3wg2oC3AHRX
	 yC7ptshTQKvnAUbdk5GhK+iKoEHX8clQ6fuM453qggFOtGYj2RQWhYIRxCL99BhVunGpo
	 HaUjrjN0HQUsu4X0mHTSWpuBiclrg2vfRs3CZ8B/2nPHgrFZiL+VbagoKdGPXN9NE4KFC
	 7O36qr0kHL6r41M92AZZtwNqTN41LuCRBzg6AC9aPpG7Y6vNHcAl9y9wEAyf2f1pAFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=10jens@web.de header.a=rsa-sha256 header.s=s29768273 header.b=B62IYeZ9;
	arc=none smtp.remote-ip=217.72.192.78
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B52606A31E
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 09:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79B52606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=10jens@web.de header.a=rsa-sha256 header.s=s29768273 header.b=B62IYeZ9
DKIM2-Signature:  i=1; m=1; t=1795427943;
 mf=PDEwamVuc0B3ZWIuZGU+;
 rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:G5nu2Sn0q7H2oM/6q5XtZarUiUXw
   2/iYuMwGrf+CH+fGyxuLiParUs8y223J/mnRgveDqyvkog1yOnV0imPuRC8gKp6NS5iWxmKme3K
   WVgadyZrVvCmEQSW/I5GRbevMuFuCLvr7BL7TBqpDPAshQiGso+Kh1XZhua8xjPO2/LgeseKqxa
   npWnF05lTKaA1kyA65TqWFpL1dNiUWklyUJ6PIURJtl1qIBFbp7rdRyYSE0X33bPiTvdriXbyBD
   1H+g+brF99Wp/BWny73rb446lNXeQ2ff6yUCtZld5suzn1BHgaJRhxTDl8rw17ELZg0O9F+15G+
   YBaLCxTOidDZXQ==;
Message-Instance:  m=1;
 h=sha256:
   qlpl+d/r2Ky2wrQixMrJY2LTR/fI+XXu6py4I9XoXhQ=:
   XiWtuvvTe5RoIXhKwpHDo0wpAnWZwZi6am5TzKqjoBY=,
  sha512:
   KxckhrjWCDrrRn8vDf7LoE8AThARPajYys5nE6gqxgRQpFLQnmMXDvkemXtx19VmAWuyLtwuCZZyGSR8Ok2Dtw==:
   BVFYVgqkv57eqSg4AFdcJYzSCw/Qx7fn+pX1qYDafR3cWaI/QkUwR12RofCC6uN6p8Uf1zSS5Qn5Ij/dTif8nQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795427943; x=1796032743; i=10jens@web.de;
	bh=e2GCZKnp60CtjzBTajuBcLw7h4qhesUfQH/BNFBFq0c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=B62IYeZ9CVfybjiPePbfDS1WVQ0SRkPJ4DKYTCQloMoVUKV29d1kdOi1pBgrdZnD
	 QE2CfkWUi+0b11mm45KfAMpLztmiwXXoG+as5D1Gyl0dch+KlOVc9NGfhytPrkYTe
	 PMoxe6Q//2SUwXW4z41HiLv8O2xz8GCkXO50fFKsxjHpv8FVJEA+x9pS8AHBPqUuK
	 sqFWTW572KSZlo8FcobzOBD3Lmg9EGdgK6xUaqqUOpFd4QfX/OTJLNFDz/Xv7StKE
	 5ephBICZWD9YfXE1xPls8i8wJhf5jEE7SHnBuqjnRlzn2vHJ7pK0fASidJ1rM5xQo
	 1fGA/2B/4+EEV5Xfzg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIL0Q-1xhZty3gyS-003BiJ; Mon, 23
 Nov 2026 10:59:02 +0100
Message-ID: <6a510228-2ae7-46c5-884c-2c0affef06da@web.de>
Date: Mon, 23 Nov 2026 10:59:02 +0100
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
Subject: Re: Bug Report Linux kvm/qemu: Frequent Boot Issues with Windows 11
 ARM64 VMs on NVIDIA DGX Spark due to Potential KVM PMU Migration Issues
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com
References: <af150d64-feff-4ef0-905a-14ab55b074fa@web.de>
 <86ld6jzy2w.wl-maz@kernel.org>
Content-Language: en-US
From: Jens Neubert <10jens@web.de>
In-Reply-To: <86ld6jzy2w.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bae3WFlIjNp1mDrq712oysxfsbCLGKqe0ekC0tT1a2kmYm/vIDC
 y4GJDN/7Yh3qCEJ0N1+1CkYcmoP+zVV9a6hhDCCxKsjK4e90LScyWvQiay1mt6vsGWFOOnm
 Vu9fgw3DlvfQHp/uiFRyJjWIaZkAD5gaxzzus1SLQ5ns8W6dA2rEL+6EiY+OlwBcWHnPvRd
 6jalADSEvqO7wqCOmXluQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jo4ZH/a7WNY=;QIAg5hKUli0h2EtAO9TKGQgXJQu
 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
 w==

Hey Mate,

thank you for your quick response. I really appreciate this.
Can you include that in the documentation?

Regards, Jens

Am 23.11.26 um 10:39 schrieb Marc Zyngier:
> On Mon, 23 Nov 2026 09:07:00 +0000,
> Jens Neubert <10jens@web.de> wrote:
>>
>> Hello,
>>
>> I am experiencing frequent boot failures when starting Windows 11
>> ARM64 VMs on an NVIDIA DGX Spark system with a heterogeneous CPU
>> topology (Cortex-A725 and Cortex-X925 clusters).
>> The failures can consistently be resolved by pinning the vCPU threads
>> to a single CPU cluster (using taskset), which points to a PMU
>> migration issue between clusters with different PMU types.
>> I suspect a KVM bug where the PMU state (specifically PMCCNTR) is not
>> handled correctly when a vCPU thread migrates between physical CPUs
>> with different PMU architecture versions.
>=20
> Not a bug. Actually a feature.
>=20
> Different implementations have different events, and an event count on
> one CPU type doesn't mean the same thing on another. Therefore,
> migrating between PMUs is not supposed to work, and KVM makes a point
> in honouring the stupidity of the architecture (and of the
> implementations that lob two incompatible designs together).
>=20
> There is a vague plan to allow incompatible PMUs to be used by
> limiting them to the cycle counter only, but I haven't looked at the
> patches (life is too short for heterogeneous systems).
>=20
> Pinning threads to a single implementation is the correct approach.
>=20
> Thanks,
>=20
> 	M.
>=20

