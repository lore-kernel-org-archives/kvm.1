Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A928F414A27;
	Wed, 23 Sep 2026 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790145753; cv=none; b=eJi2SA5APV7fcNu5AL+8m+J8k1JChaD87o8EcjPUsr2CA14ctRQCowSaqGM86pydtoralXy/eLULtQYccfMfFfDDeA+vrKP27F1mcGFpLaTnHAggwOF9zH0i/IQqT4bIVeK9Wy1nyiZzuRb/OR6pri1fxOl8gmo4M3h3Kh3gyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790145753; c=relaxed/simple;
	bh=Z3gPbuK5qepuqx2fCRdB3pvyPoSFEwvQ7ryb6Thvrxs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rDE4b5Fg+nxW2nuwMxKH8oMvEsgWeQ6mGyjteCEJKO3ytjQZ95GvVotBTwxYLyUgjjvuB3Am6qu9LfOa7oJiEIWnbdtLWH4R1qiFjUlfsiVGTGMdyaELtgGsCAXIqhRL+s4vN9/5w5xHcOdSLxiG/N0PTSblnjrN/sv2fRDwZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxYdHQdLNqUfEOAA--.44198S3;
	Wed, 23 Sep 2026 14:42:24 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJAxlMzMdLNqOBckAA--.49011S2;
	Wed, 23 Sep 2026 14:42:22 +0800 (CST)
Subject: Re: [PATCH] KVM: LoongArch: selftests: Enable HW PTW by auto
 detection method
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
 kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260923012356.1058379-1-maobibo@loongson.cn>
 <CAAhV-H4AvjyfmjPiUBxBsWjRNFpP5c4sWK0+ZH-e1gjtrxBhMg@mail.gmail.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <0b746444-df7f-1edd-8fd0-1736c96ac366@loongson.cn>
Date: Wed, 23 Sep 2026 14:43:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4AvjyfmjPiUBxBsWjRNFpP5c4sWK0+ZH-e1gjtrxBhMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxlMzMdLNqOBckAA--.49011S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF47Aw4fWryxAr18ArW7ZFc_yoWrXF17pF
	yvkF4Ygr48KF17Ka4kXwn09F1aqrs2kr4xKry3trZ0yr1UZryfXryxKF9xuFy5XwsYq3WS
	v3Z7Ca13ZF4DX3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFa0PUUUUU=



On 2026/9/23 下午12:25, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Wed, Sep 23, 2026 at 9:31 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> Add HW PTW feature when VM is created. This feature is detected firstly,
>> enable it if it is available on host machine. With HW PTW feature enabled,
>> refill exception will not happen and it is not necessary to set refill
>> exception entry.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   .../selftests/kvm/include/loongarch/processor.h  |  3 +++
>>   .../selftests/kvm/lib/loongarch/processor.c      | 16 ++++++++++++++--
>>   2 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/include/loongarch/processor.h b/tools/testing/selftests/kvm/include/loongarch/processor.h
>> index 0e59daa8024e..8d9fabdc89e3 100644
>> --- a/tools/testing/selftests/kvm/include/loongarch/processor.h
>> +++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
>> @@ -79,6 +79,7 @@
>>   #define  CPUCFG2_LASX                  BIT(7)
>>   #define  CPUCFG2_LLFTP                 BIT(14)
>>   #define  CPUCFG2_LLFTPREV              GENMASK(17, 15)
>> +#define  CPUCFG2_PTW                   BIT(24)
>>
>>   /* LoongArch Basic CSR registers */
>>   #define LOONGARCH_CSR_CRMD             0x0 /* Current mode info */
>> @@ -128,6 +129,8 @@
>>   #define LOONGARCH_CSR_PGD              0x1b
>>   #define LOONGARCH_CSR_PWCTL0           0x1c
>>   #define LOONGARCH_CSR_PWCTL1           0x1d
>> +#define  CSR_PWCTL1_PTW_SHIFT          24
>> +#define  CSR_PWCTL1_PTW                        BIT_ULL(CSR_PWCTL1_PTW_SHIFT)
>>   #define LOONGARCH_CSR_STLBPGSIZE       0x1e
>>   #define LOONGARCH_CSR_CPUID            0x20
>>   #define LOONGARCH_CSR_KS0              0x30
>> diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tools/testing/selftests/kvm/lib/loongarch/processor.c
>> index 47bbde3e205a..35e35c62759f 100644
>> --- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
>> +++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
>> @@ -282,6 +282,7 @@ void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
>>          unsigned int cfg;
>>          unsigned long val;
>>          struct kvm_vm *vm = vcpu->vm;
>> +       bool has_ptw = false;
>>
>>          switch (vm->mode) {
>>          case VM_MODE_P36V47_16K:
>> @@ -300,6 +301,12 @@ void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
>>          ret = __kvm_has_device_attr(vm->fd, KVM_LOONGARCH_VM_FEAT_CTRL, KVM_LOONGARCH_VM_FEAT_LASX);
>>          if (!ret)
>>                  cfg |= CPUCFG2_LASX;
>> +       ret = __kvm_has_device_attr(vm->fd, KVM_LOONGARCH_VM_FEAT_CTRL, KVM_LOONGARCH_VM_FEAT_PTW);
>> +       if (!ret) {
>> +               cfg |= CPUCFG2_PTW;
>> +               has_ptw = true;
>> +       }
>> +
>>          loongarch_set_cpucfg(vcpu, LOONGARCH_CPUCFG2, cfg);
>>          cfg = read_cpucfg(LOONGARCH_CPUCFG6);
>>          loongarch_set_cpucfg(vcpu, LOONGARCH_CPUCFG6, cfg);
>> @@ -338,6 +345,9 @@ void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
>>
>>          /* PGD page shift and width */
>>          val = (vm->page_shift + width * (vm->mmu.pgtable_levels - 1)) | width << 6;
>> +       if (has_ptw)
>> +               val |= CSR_PWCTL1_PTW;
>> +
>>          loongarch_set_csr(vcpu, LOONGARCH_CSR_PWCTL1, val);
>>          loongarch_set_csr(vcpu, LOONGARCH_CSR_PGDL, vm->mmu.pgd);
>>
>> @@ -345,8 +355,10 @@ void loongarch_vcpu_setup(struct kvm_vcpu *vcpu)
>>           * Refill exception runs on real mode
>>           * Entry address should be physical address
>>           */
>> -       val = addr_gva2gpa(vm, (unsigned long)handle_tlb_refill);
>> -       loongarch_set_csr(vcpu, LOONGARCH_CSR_TLBRENTRY, val);
>> +       if (!has_ptw) {
> Why not just check CPUCFG2_PTW in cfg? In this way we can drop has_ptw.
Variable cfg is overwritten by the later sentence
  cfg = read_cpucfg(LOONGARCH_CPUCFG6);

> 
> Huacai
> 
>> +               val = addr_gva2gpa(vm, (unsigned long)handle_tlb_refill);
>> +               loongarch_set_csr(vcpu, LOONGARCH_CSR_TLBRENTRY, val);
>> +       }
>>
>>          /*
>>           * General exception runs on page-enabled mode
>>
>> base-commit: 93f51579e7df248780214094418f205253383cc5
>> --
>> 2.39.3
>>

