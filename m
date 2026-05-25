Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26BF19D8A8;
	Mon, 25 May 2026 03:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779678210; cv=none; b=BBkn8JBGH6y5EE945tk4FsVVeC6CCNDmoV4MkEGP7YWlpqlBpthDEbqCoczpDKqgbekiN+QW41yH5iv3SaT/G8XqEJ6sr1ADRmb/UAhzdMsOrICkJymv9X6FPE0Dao1r9uFLvGFpkuvWq/1cD3Kt99RGG92yArbU5hwHvZLZRA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779678210; c=relaxed/simple;
	bh=sA7O1lmBXjcix/Ebl8qjUgRhkkKS+17tBSoXyQrS/gE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TLSDyQGdjzvwl5ByuyTuHZxecIYftmV17v9gx3FoBfngU3OG5CBkeZxBOIWUR7PfSdmFh1JklhjpnCHa9CrsLiQ8Iiv/iSJOC6R2Bhqr+q5rVzXUHojAGr/LqLdWe3nk0UKHN3QHiuK0Pbeu86jGOIF2V/F2SjyLhYeVW/H8h1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Bxzen0uxNqXu4MAA--.35532S3;
	Mon, 25 May 2026 11:03:16 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxHOHsuxNq0tqPAA--.10277S3;
	Mon, 25 May 2026 11:03:08 +0800 (CST)
Subject: Re: [PATCH 1/2] KVM: selftests: Cast guest_memfd fd to a signed int
 when checking for >= 0
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fuad Tabba <tabba@google.com>,
 Ackerley Tng <ackerleytng@google.com>
References: <20260522171535.3525890-1-seanjc@google.com>
 <20260522171535.3525890-2-seanjc@google.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <9fb7d8ce-c694-b547-70f5-142e332772db@loongson.cn>
Date: Mon, 25 May 2026 11:00:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260522171535.3525890-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxHOHsuxNq0tqPAA--.10277S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr4rCr4UKrW5CF43Gr47KFX_yoW8Xw13pa
	y8A3WkKr1rKF1xZwn7Gw1kZryS9Fs5Gry8Cw17Jr13uws3tw1Iyr4xKayYkF9xZFWxtF15
	ZF97KF93Xa18JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9N3UU
	UUU==



On 2026/5/23 上午1:15, Sean Christopherson wrote:
> When conditionally closing a memory region's guest_memfd file descriptor,
> cast the field to a signed it so that negative values are correctly
> detected.  Because selftests reuse "struct kvm_userspace_memory_region2"
> instead of providing custom storage, they pick up the kernel uAPI's __u32
> definition of the file descriptor, not the more common "int" definition,
> e.g. that's used for userspace_mem_region.fd.
> 
> Fixes: bb2968ad6c33 ("KVM: selftests: Add support for creating private memslots")
> Reported-by: Bibo Mao <maobibo@loongson.cn>
> Closes: https://lore.kernel.org/all/20260508015013.4108345-1-maobibo@loongson.cn
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   tools/testing/selftests/kvm/lib/kvm_util.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index e08967ef7b7b..4ad015c6c44f 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -817,7 +817,7 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
>   		kvm_munmap(region->mmap_alias, region->mmap_size);
>   		close(region->fd);
>   	}
> -	if (region->region.guest_memfd >= 0)
> +	if ((int)region->region.guest_memfd >= 0)
>   		close(region->region.guest_memfd);
>   
>   	free(region);
> 

Reviewed-by: Bibo Mao <maobibo@loongson.cn>

