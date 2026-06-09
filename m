Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5763E315A
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991861; cv=none; b=MNfDNCFLn7u3MiF8ZsGbKI28Nk8mB9xJvmcilEKN2dX0Xxm8dAezedatCTTjY2PGDKTXIVwWL6375kLxNX440IIT2XJLgvES0YKPP2JKAKLpIhX/B/JplzAPaKKuEZP3QV9G1esXDqsdAW6T1X6kOHh0Qpuh/HunFTdkPkzfJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991861; c=relaxed/simple;
	bh=0xsYWNRyz0n9Lm085AVd/EIkLvs88LLzW9fO/x/oDWQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aNpb9Hmp1SrCYc43Ij2dPv1xLeoeQxVkNFFcd1mMBuAYMmaujpT1hY2PKcViJFVJI3eI80nrWm0GCo8pfW5+MPm9wvl2s2PhsOxMO+/G+px7fMNUCaPt/kVtk2ZjK9Na5tdXEdtLSvVKlv7nV4XN//+tzHtQh4Wl2hiVH9H7jFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxsOpvxydqEisSAA--.48447S3;
	Tue, 09 Jun 2026 15:57:36 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJBxLMJuxydqII+gAA--.41451S3;
	Tue, 09 Jun 2026 15:57:35 +0800 (CST)
Subject: Re: [PATCH v2 2/2] KVM: LoongArch: selftests: Add FPU test case
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260609072715.1005923-3-maobibo@loongson.cn>
 <20260609073957.3865C1F00893@smtp.kernel.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <a37de928-431f-05d6-549b-6edac646444e@loongson.cn>
Date: Tue, 9 Jun 2026 15:54:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260609073957.3865C1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxLMJuxydqII+gAA--.41451S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxurWUCr1rAFy7JF4kJFyfKrX_yoW5uFy7p3
	y8K3Z0gF4ktF4aqr4xZw4UuFWfK3WUGF17Zw45KFWDAr4YkrZ7tF4DG3yjqws3ur4FqF18
	Zr4rJan0yFWDZacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
	05UUUUU==



On 2026/6/9 下午3:39, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The selftest fails to actually verify that `vcpu_fpu_set()` modifies the guest's FPU state, silently passing even if the SET API is a complete no-op.
> --
> 
> commit d53e91be78e2fb09e2650551dd5ea13d9268274c
> Author: Bibo Mao <maobibo@loongson.cn>
> 
> KVM: LoongArch: selftests: Add FPU test case
> 
> Add FPU test case and verify FPU register get and set APIs, the
> FPU width supports 64/128/256 bits.
> 
>> diff --git a/tools/testing/selftests/kvm/loongarch/fpu_test.c b/tools/testing/selftests/kvm/loongarch/fpu_test.c
>> new file mode 100644
>> index 0000000000000..5bccce9db5d01
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/loongarch/fpu_test.c
> 
> [ ... ]
> 
>> +	fpu.fpr[0].val64[0] += random();
>> +	vcpu_fpu_set(vcpu, &fpu);
>> +	run_vcpu(vcpu);
>> +	vcpu_fpu_get(vcpu, &fpu);
>> +	sync_global_from_guest(vm, *fp);
>> +	TEST_ASSERT(!memcmp(fpu.fpr, fp, 8), "Wanted 0x%llx from f0, got 0x%llx",
>> +			fp->val64[0], fpu.fpr[0].val64[0]);
> 
> [Severity: Medium]
> Does this logic actually verify that vcpu_fpu_set() successfully modifies the
> vCPU's state?
> 
> If vcpu_fpu_set() is a complete no-op and fails to update the state, the vCPU
> would retain its original state. The guest would store this original state, and
> vcpu_fpu_get() would retrieve it. Thus, both fpu.fpr and fp will contain the
> old un-mutated values, and the memcmp() will evaluate to 0, falsely reporting a
> pass.
Here is function vcpu_ioctl() in file 
tools/testing/selftests/kvm/include/kvm_util.h, it will check return 
value and assure that vcpu_fpu_set() returns successfully.

#define vcpu_ioctl(vcpu, cmd, arg)                              \
({                                                              \
         int ret = __vcpu_ioctl(vcpu, cmd, arg);                 \
                                                                 \
         __TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd, ret, (vcpu)->vm);       \
})

Regards
Bibo Mao

> 
> Should this test also assert that fp (or fpu.fpr) matches the mutated value we
> intended to set?
> 
>> +
>> +	fpu.fpr[0].val64[0] += random();
>> +	fpu.fpr[0].val64[1] += random();
>> +	vcpu_fpu_set(vcpu, &fpu);
>> +	run_vcpu(vcpu);
>> +	vcpu_fpu_get(vcpu, &fpu);
>> +	sync_global_from_guest(vm, *fp);
>> +	TEST_ASSERT(!memcmp(fpu.fpr, fp, 16), "Wanted 0x%llx %llx from vr0, got 0x%llx %llx",
>> +			fp->val64[0], fp->val64[1],
>> +			fpu.fpr[0].val64[0], fpu.fpr[0].val64[1]);
> 
> [Severity: Medium]
> Does this have the same validation flaw as the previous check for the 128-bit
> vr0 registers?
> 
>> +
>> +	fpu.fpr[0].val64[0] += random();
>> +	fpu.fpr[0].val64[1] += random();
>> +	fpu.fpr[0].val64[2] += random();
>> +	fpu.fpr[0].val64[3] += random();
>> +	vcpu_fpu_set(vcpu, &fpu);
>> +	run_vcpu(vcpu);
>> +	vcpu_fpu_get(vcpu, &fpu);
>> +	sync_global_from_guest(vm, *fp);
>> +	TEST_ASSERT(!memcmp(fpu.fpr, fp, 32),
>> +			"Wanted 0x%llx %llx %llx %llx from xr0, got 0x%llx %llx %llx %llx",
>> +			fp->val64[0], fp->val64[1], fp->val64[2], fp->val64[3],
>> +			fpu.fpr[0].val64[0], fpu.fpr[0].val64[1],
>> +			fpu.fpr[0].val64[2], fpu.fpr[0].val64[3]);
> 
> [Severity: Medium]
> Does this also have the same validation flaw for the 256-bit xr0 registers?
> 
>> +
>> +	run_vcpu(vcpu);
>> +	kvm_vm_free(vm);
>> +	return 0;
>> +}
> 

