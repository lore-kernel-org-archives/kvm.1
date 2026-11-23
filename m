Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795437370;
	b=CgRDKbXHf4dm7c1R0eohwjSlPSW8uyE9QBMConeWDdrQkE4ZxMJvPAjOxgWP7/sGrwsc
	 rsV7yVuAW0IadtcmNWJpd1iuAemL1t6kgxV1faQriF7GCJK1OsqtzU+wnAa4E2WgjB/nk
	 2mrS64heuxsahnJOX6efJuv+m2qEVXTZA0WEuE4ONu9vtjYcrtuZ2sGkuWOIMBtakHeys
	 6BZguaA7Kv9Y9BUWg+EChZNTk8l5asmb97S+fbRN9E7eddmERLoRDAlU1Zx123Yffd7Id
	 90OHVglWNM1wsplYw2uxJKzzqFaY9raPQdWIhhL+iTG36Vjg9Du9d7Md4ydl/3l+rQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=U/uD1Gm/ThsK3UVlqQr4l1VJFGDwFXp2U6warxXaR1w=;
	b=DPHCoFYGQt+YpweEPwKMbymXK184k/6npe8glelTFuGhi/YGYWyHqXntyTtZv1FyJ4Ui
	 7mT/f9cjoNvuNGLReOq+OhHxZeLgcW8qt1Zt73ZUrvLpmXnBRWLak+LwYmMJNa3dyGNgT
	 xSwVxA78YqKjTPcWBwtgkMwxR2lU4s34YNy1H0pj0zbAs8fShbIgpiXEGTWFUspVWM30k
	 Q6OpmN8fy2qwayjRRx6ZjJsyTw037Alub35KkKSQZabe+qcX3IKh8on68pBv5oRpXtOBk
	 sxWL4Trj1hyI/GkSHX+ShHFCZ2HkRRHGWXDfef4GCVDGvdnr7kKbhTvJ82Gvz5L6tXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X4d4kmW8;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B67606A69B
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 12:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74B67606A69B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X4d4kmW8
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ae93a86008so1767078a91.0
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 04:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795437370; x=1796042170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U/uD1Gm/ThsK3UVlqQr4l1VJFGDwFXp2U6warxXaR1w=;
        b=X4d4kmW8MoeFSWSHykypJXTCQ9sxdfL8zvhoE66K6Sj3h/x0tCzJHWjyeNcIqmYJX7
         33uMM8OD9rktP9s+hYv7SVfmx+FeIdJHCtXn6/T1yfNIjSZg6zr5N2/uBNPgp+s/dvmq
         fUnJByPx57vrBt9LcrpB47M8hjODYv2XAtjtC4qshjGvL+5K3hrV5fnWQwn52FDlDKQC
         Yj9k41pAqekeHYLpXkL+XAmZk9gQ+eS9gQQf+F9TS75He2K9ZB1bfry+pOx5aQ9nK69E
         OroZyQjtslM8K4H7qnWIyby1ff9PkyzT4OzlTcTLU5wRVR01qaS4fU/cgvcd5E53uwQl
         gBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795437370; x=1796042170;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/uD1Gm/ThsK3UVlqQr4l1VJFGDwFXp2U6warxXaR1w=;
        b=j4Qhn3gVIrZjTTnZO8+KFvkpR4+L8R6doBHiqRXm48aYMhUKP0cHvpWh5hPPOYZ5+6
         AY/secOdKqNs4E/Ups3iHKoJpoi9cXNG8Fb/VhQyesYTnCDYPP+mN7FOan1oxYXxqjE5
         2SUXskeNGqWifFIqXoKDBsxYuoSCct+S6lDP85Oz5DtiXaQQGWf9kzHtkrLeZbCY+Ifk
         qgeuDeNn5/TJqIRSu2bIgQYyBr22ZHwNHZOqRPoghkd8vMOCvQhy9D8fgepyqOBYeRR6
         QXU5Z+uECm2EeDNli585L2ZcHcYzgOXjEAOUtrEwkQKu33W2/X05YOzoZfgtUcJ7Diz/
         op4Q==
X-Gm-Message-State: APuU4Z+6UWkW2fmwX3e/URRaIT3asYccVd8VnAy8GERCSxabtu1lWfC+
	SS8zHpwz2e2KzvW8QiUi2/+xtAmVHxQ4miVbEZYM6iiCGjWL884B+11g
X-Gm-Gg: AZFdTZcFvjT6Jtz8JTVY9tYYf3vU1/0sx3/x8EtoGab06AfanEqwDSD3LV4HCvfVeCZ
	piD6XpcKB4cDTfQnCTtPls17LLKSzXAfNXwCN9HHKuT/ytpx8wewN+c9qkx8wtKorG5/7ikMyJ3
	aP8f3XhMfm9scCFuzSUIOcNvGS2XtGBPNM3Du/N/ezWCmXZOTzYKzyvGGzlx6IPrgw3ofCSltiX
	uzYorvZmH7WsjDYWpwBobiuNv8oyp/B+wMBRwD+Be0JYyB0aXq1fHE/6Z/RtkZBtHGLbf5XRlCy
	zLu8kmEb/1LWnQtfvuDz2slTH81bywaB8fk401NSOMYELR6/pq34Tz4n/N08uYWrq9z7b1Aka6A
	MibL7Y63xTpvHtOoXMmPnrtpYWAUVz5iLaHmj0ACh2p5etOEX5Q7y4qh8b8bTI6LsbBA48JtKqJ
	BjD5a4X4QBMTeiPIL2iKWCYnmM3GKj/C/v7mj8Zor2Ah+ZJSNsteyQx0Yfik1pvw6YGxsrCF6zU
	Za91Y8u5xhwcyQehHzSdgEjxKFoGX+xDvgINkSTYSGfVu9Aakx89AIVIXZA0yHtofHuTvCDM1iQ
	rjR48wRQaH41llae2dc/MdiSCDTB3Gx5YtR/yIeRMcvrOuU=
X-Received: by 2002:a17:90b:3c07:b0:3ac:3588:b548 with SMTP id 98e67ed59e1d1-3b41c9b2529mr10221008a91.13.1795437369821;
        Mon, 23 Nov 2026 04:36:09 -0800 (PST)
Received: from [192.168.50.100] ([114.252.97.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b8733e6sm6119715a91.3.2026.11.23.04.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 04:36:09 -0800 (PST)
Message-ID: <7225496f-222b-46f6-a609-89921d6572d7@gmail.com>
Date: Mon, 23 Nov 2026 20:35:57 +0800
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
Subject: Re: [RFC PATCH v3 09/10] iommu/riscv: Add
 riscv_iommu_attach_dev_nested
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
 <20261119132744.396426-10-gong.shuai@sanechips.com.cn>
 <awG5Q7pmntSme1A2@orel>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <awG5Q7pmntSme1A2@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 11/21/2026 11:48 PM, Andrew Jones wrote:
> On Thu, Nov 19, 2026 at 09:27:43PM +0800, Gong Shuai wrote:
> ...
>> +	if (riscv_iommu_bond_link(s2_parent, dev, nested_domain->viommu->gscid))
>> +		return -ENOMEM;
>> +
>> +	riscv_iommu_iodir_update(iommu, dev, &dc);
>> +	riscv_iommu_bond_unlink(info->domain, dev);
>> +	info->domain = s2_parent;
>> +
> 
> When moving between the S2 parent and a nested domain on it, the parent
> briefly has two bonds for dev. bond_link() puts the new bond after the
> first bond with the same GSCID, which may come before dev's old bond,
> and since it's then dev's first bond, bond_unlink() removes it. dev is
> left bonded with its old GSCID, so its new GSCID misses invalidations
> once no other device's bond has it.

Thanks, you are right.

> 
> Passing the old domain to bond_unlink(), like I do in [1] for a
> different reason, would let it remove the bond matching both dev and
> old's GSCID.
> 
> [1] https://lore.kernel.org/all/20260928143113.49838-12-andrew.jones@oss.qualcomm.com/

I'll use the old domain to resolve the old bond domain and its GSCID,
pass the latter to bond_unlink() as old_gscid, and match both

     bond->dev == dev && bond->gscid == old_gscid

so that the old bond is removed rather than the newly added one.

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

