Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795437196;
	b=dCgzAiCAY4/kQnniBv5t6L8aJ2MaZdr6eBfqroF1mhvgpv2Z2mvV6UZJkcdILcy+vrSV
	 WJcldZ4EBpDjPh2ggSJkICeNL4wlXSCTvTJLEqnkeQbRHqPrj155WRgvtLCJtFDzFwY77
	 AKSB5zS59ILEjsLUXlKf9yR4THQENeV5FEE79u52v9Jsk8H6vi1pqyOiW+1b4TzzmvV19
	 3d/sixvpyGiwE64n+m6jJT2fz0GVwWcaGKi2coMkXDNMAXXQhntl3bfpk7a63KkFuJVWu
	 hED627Z0oOhEI9qa0vohPkUOaFZ0Fxrgp7B43SOn2c4vjjf5fp53zc1FpoD2nWlr7PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Hn7QLnatls3YJLh9hvARkpylGvnCInTwrPxLQjvpHck=;
	b=Nc06UHvZ7jpUvaCJrc9TUvc8Y7yyfstWz86kT1OekHmcvyPaLimgqx8s3PSeKQY8KE+r
	 rq8vGvfEAyRFXdrTr4Tn3zdDjQxi9Y8Lu6xtsCJvDf3arwnPYXu5hvKBjzlh3ddxsnLTq
	 ibsMXQf8JTghNgcF8eCgQVI3OSwreE9qQX+o1xuo9OS2ylFtO05e9XxQr2/L1E992YXWt
	 JY4fArJu2y+5tudTVLijife6wTVBcnv3GoTQ5m7UK/0BheZa+uI7Mtmq3l2Dcazf0mYrL
	 MmJYOdJSYCMgtPdmDY2MO1KFcFcw6uhyCpzUHgz+FcorMA3wTid38qms6WO6stWfHTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w0sKEFMU;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DD7606A31A
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 12:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07DD7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w0sKEFMU
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-3b14c80b210so706417a91.0
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 04:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795437195; x=1796041995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hn7QLnatls3YJLh9hvARkpylGvnCInTwrPxLQjvpHck=;
        b=w0sKEFMU+eaG9tWtdrJg66TGM2vOfSgYBXGN/RT18135qMoZytktIisMy13P9sdgdZ
         MmnDhx6FBcBKvrXLWbIRrhrRP05nQj6TXfQ3A928lxHhbqYIY6w1XayAgPI0pwYJkvOF
         j99uhIwSqxS2yvq/a8e1N0R1X7IySSi9XfN03R33ucwJGD5kUQyVu57yAv9bZ15ZuBbT
         Pf1YZz296rAeJqDnJdPnQySNvePN3LpefZdTWU+dWREBerrB3Z930oUuJ2hmHRwhrUlW
         EnScyeYoQ/i7vUwix4ZiZeYpFGyD5sWoIrEFnZLJ63hwMcbKnjJaVdMgDuSv0uwDNhh2
         dchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795437195; x=1796041995;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hn7QLnatls3YJLh9hvARkpylGvnCInTwrPxLQjvpHck=;
        b=s4nXe4GzZf1Gl6wpnaAsLqOa/Vear3pk/olQHs2gcpHIDTUoRBJDPImYG9hGOigZyR
         f9hGxh5QUrh1ZkWQ7euicfITsTpSJ+kB4pIPOeCANFvqRg/twoCU6w1rHA7FrVAFoxnO
         VVbxcE9O3ahfg0Kc8mMOOAk4NlmKeWVmhM6gdisc1L6A11NnvUrP3MWrDC2LWiV7bS0u
         uYPW88X50heRjgcZub1fvBgWbnV/M/MLPwXuPcVPZn4hFTecq2sWP1UaKb80/ec3bVY+
         GMWLKEOCnLb48SvWs+Nzppkt94uq+f7xHopROqr0wRycdzBog60fxYftfUuWmot0ibFV
         KEhw==
X-Gm-Message-State: APuU4Z+RH+1uBjsRg7+fCdfnosZ40om/zs1NLl7i4BYA0vHzY+WDucgT
	deaPaweKVt9ADBocKpvavtYt3sfplidXunjVfNE7tFx1SCICV0ScOHG2
X-Gm-Gg: AZFdTZdYfMMA0khqwDOCYxgFh1TrwZeWSYf1Yt9bnH1g8URkxPg9q/og/53S1LmOSCe
	e4L6I0bHwgFFhahlwOyXaDdGU8WbxUrJFuh8P63h+5pP8fYd6GK9NSsJKY2Q0+3tYEoHeHWbXn6
	0Pdbg5EsVnwIpDSPwu3nQR40EJW1D2caSwSfP7k2QS0IcmBv875e3++IimYHN3O5To+hqaZly1A
	PkdqxNk1YRSg6W19V9XtMLakJqBajCA0JXob9j2NmEEn5hiEtD0+vM2R70wPto/dgBp8InpVP4y
	QeNni7uYd061rptvAnPOGsuHmFmegDOTWyMnSJrYTz05PgBj5e2koz5uuepDPD0rVJeY42dOGW1
	CwW3o++x3RWtloKdQjHjTPkExSYOT5zghA+Q3cEHBGCQXtKKbxK42NmPqWYD3Td8dQpafM8Cxc9
	yAP1Gi5Vii2ETVFwurLsz5CRtUt4/ROMjVLHpGX7H8zHV6TJWsas/gZ+jLSLfFbwHP5N20jseh5
	Pam5oiOendtWAWuYVonSQGtX5+Z+tnd6Ftd+zlYxLtCb0PLpFiee7dyG9IAJaa96/AfV2sEwUvf
	rE+0BLPYYBYmMsSpzDx65zwpLrNISZYSPpB6+Dy2kphpF8lW
X-Received: by 2002:a17:90b:268f:b0:3b3:afdc:2e5 with SMTP id 98e67ed59e1d1-3b41c9cf56bmr7964160a91.30.1795437195128;
        Mon, 23 Nov 2026 04:33:15 -0800 (PST)
Received: from [192.168.50.100] ([114.252.97.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b217a5bsm7472471a91.0.2026.11.23.04.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 04:33:14 -0800 (PST)
Message-ID: <4ac66d3b-7343-4ff8-8ebe-d3bf9ab25da4@gmail.com>
Date: Mon, 23 Nov 2026 20:33:04 +0800
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
Subject: Re: [RFC PATCH v3 05/10] iommu/riscv: Add nested domain allocation
To: Andrew Jones <andrew.jones@linux.dev>,
 Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Anup Patel <anup@brainfault.org>,
 Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Tomasz Jeznach <tomasz.jeznach@linux.dev>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Fangyu Yu <fangyu.yu@linux.alibaba.com>, Tan Chi
 <tanchi25@mails.ucas.ac.cn>, Wu Fei <wu.fei9@sanechips.com.cn>,
 Zhao Qingye <zhao.qingye@sanechips.com.cn>
References: <20261119132744.396426-1-gong.shuai@sanechips.com.cn>
 <20261119132744.396426-6-gong.shuai@sanechips.com.cn> <awGP5H2JdjxW8WXG@orel>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <awGP5H2JdjxW8WXG@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 11/21/2026 8:37 PM, Andrew Jones wrote:
> On Thu, Nov 19, 2026 at 09:27:39PM +0800, Gong Shuai wrote:
>> From: Wu Fei <wu.fei9@sanechips.com.cn>
>> 
>> A nested domain describes two-stage translation through guest and
>> host page tables. Iommufd exposes this domain as a nested hwpt.
>> 
>> User space needs to provide the guest stage 1 configuration when
>> allocating a nested hwpt. Validate the configuration before storing
>> it for use in a physical device context.
>> 
>> Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
>> Co-developed-by: Gong Shuai <gong.shuai@sanechips.com.cn>
>> Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
>> ---
>>  drivers/iommu/riscv/iommu.c | 153 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 153 insertions(+)
>> 
>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>> index f2305b953f71..4f8ce579ef08 100644
>> --- a/drivers/iommu/riscv/iommu.c
>> +++ b/drivers/iommu/riscv/iommu.c
>> @@ -1698,8 +1698,161 @@ static void riscv_viommu_destroy(struct iommufd_viommu *viommu)
>>  	ida_free(&riscv_iommu_gscids, rv_viommu->gscid);
>>  }
>>  
>> +struct riscv_iommu_nested_domain {
>> +	struct iommu_domain domain;
>> +	struct riscv_viommu *viommu;
>> +
>> +	u64 tc;
>> +	u64 ta;
>> +	u64 iosatp;
>> +};
>> +
>> +#define to_riscv_iommu_nested_domain(domain) \
>> +	container_of(domain, struct riscv_iommu_nested_domain, domain)
>> +
> 
> Please rename the macro parameter so it doesn't collide with the domain
> member name, otherwise macro expansion replaces the member name too.

Thanks for catching this, silly mistake on my part:)
I'll rename it in the next version.

Best regards,
Shuai

> 
> Thanks,
> drew
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

