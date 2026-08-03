Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E6F3A900B;
	Mon,  3 Aug 2026 07:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785743272; cv=none; b=OvX7uk/8/FjdgnahDbsdtu6rX5oqtXZH3F8Aukl1+vfR5gr4DsTYICLZBQzJ3qLNwdShB9DgAKOjopHsSHMTMaM/W6mvm3PzIZYczwgzbyhYiNVc+iy+b9fRgdk7FiWavZ6nUmjFRwAAF1VfDkFwDxcqhLHttS5FP9d+mxdpzcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785743272; c=relaxed/simple;
	bh=h2ARywrfLi9H1ZKhiCEV1QKvo/q5f3DvYyGJY+XrrEA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Vnr/ljPQLOZH5KLbkojD8mmqgyYocHiTGatN4qQcISjd19otDO7Bz6tlFTQrgLUR1NFNgb6cX4W75Jw9xxwbF0i/j62ehMplL46DJmFao3WGx/kr51i5skL7lzUYmcj7N5JpRlXXfhwYjhsD9M3PUSP+3iRcUtMEQ9GxfhENweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxOqGiR3Bqz9gJAA--.9381S3;
	Mon, 03 Aug 2026 15:47:46 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxPsecR3BqkeEhAA--.56294S2;
	Mon, 03 Aug 2026 15:47:41 +0800 (CST)
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Add myself (Sean) as a reviewer in
 the main KVM entry
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Ackerley Tng <ackerleytng@google.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oupton@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20260731173842.2649391-1-seanjc@google.com>
 <20260731173842.2649391-6-seanjc@google.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <5ef3fac2-ebf5-5171-a12f-4ccce1c48079@loongson.cn>
Date: Mon, 3 Aug 2026 15:47:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260731173842.2649391-6-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPsecR3BqkeEhAA--.56294S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar4kKw4xGryxXrykXr15KFX_yoW8WF15pF
	WfCr4jyrWDKFWrJwn7Kry2kay3X395Cr9I9Fnrtrn5Zr9xJw1Fqw17tw4a93ZrJr1Ika1j
	9rs7uF1Iga18ZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07joc_-UUU
	UU=



On 2026/8/1 上午1:38, Sean Christopherson wrote:
> Add myself as a reviewer for overall KVM, as I have been helping shepherd
> a decent chunk of the virt/kvm commits into the kernel over the last few
> years, and I expect to continue doing so.  Of the 270 non-merge commits
> that have been made to virt/kvm since v6.6, I have committed 127 (~47%)
> and Paolo has committed 117 (~43.3%), with all but 5 of the remaining 26
> coming from non-KVM folks, e.g. from treewide changes.
> 
> Note, this intended to purely be an efficiency and quality of life
> improvement, for both contributors and myself.  There is no implied right
> of succession or anything of the sort.
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oupton@kernel.org>
> Cc: Tianrui Zhao <zhaotianrui@loongson.cn>
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Acked-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c79bb25522f..556ccf640516 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14047,6 +14047,7 @@ F:	kernel/umh.c
>   
>   KERNEL VIRTUAL MACHINE (KVM)
>   M:	Paolo Bonzini <pbonzini@redhat.com>
> +R:	Sean Christopherson <seanjc@google.com>
>   L:	kvm@vger.kernel.org
>   S:	Supported
>   W:	http://www.linux-kvm.org
> 

