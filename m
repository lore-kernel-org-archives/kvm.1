Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FA53F7A84;
	Tue, 28 Apr 2026 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375099; cv=none; b=LdETLB6kwtnVVcIVKIo3D2wa98a/DkqUx17iwQBvQZv6W33njOzxTxYYJy2oR/jya3h6yuVRV/EB4bwVgp9GM3hErxqz/peQthG2T4j/s8NO+LlcmhFfGJyQzitP4/6h0pmVZVCN4BUJGvlhU1euWo4XlGhuCcJLQ00KQhRkIs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375099; c=relaxed/simple;
	bh=o1xbIBD2azOTE9UhoYvFyikF8dUYobNN7z5jHDWI+3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZGWNcYULeKQ1YBcv3sQVhDU0/VgxGy21Ck5lm4qF9NQhRrRR072N7ZajXEJqhEyCoBRFpQc1vNIFTbDwpIUQfDGpUQ/nImmWD9Z0GbTyMEKwBhdzj99Pg0rhTsTja7aBlI9k0izyoUjFIEii4O0MrHj/Ji63u5fMhAPnW2cRhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=PzVj7XGS; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="PzVj7XGS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1777375050;
	bh=prTc1/eai3NnjFkzCz8C2Ci93RAJqPrPDxNZpslkpRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=PzVj7XGSw7f31bQxm+3/6vsuiP15BiiHo7zSNMPXM0p4JLv+4EzMx/pxF6Paild/7
	 vce4JlITN2aVgj/wYW2at8Fq2+wYzvPFGtiZaoIQSM+Bv3AgLyathbwwT4lXdemlnq
	 NVOSWJjrBy1rpaQHJwNBq6KEHWhC+7i8+VGXQ5DU=
X-QQ-mid: esmtpgz14t1777375042t8e172a52
X-QQ-Originating-IP: 0yfT/39+Bgj4m4yc2LIz2BGd81O6JxzWEMIJeJcq42k=
Received: from [10.10.73.115] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Apr 2026 19:17:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6219295977326612698
Message-ID: <7CFC18ABD138F62B+086624ea-7d8d-411e-bd5d-4c79899c58db@uniontech.com>
Date: Tue, 28 Apr 2026 19:17:20 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LoongArch: KVM: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS
To: Bibo Mao <maobibo@loongson.cn>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, kernel@xen0n.name
Cc: kvm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260428074742.2274610-1-maqianga@uniontech.com>
 <2074ae0a-5a3a-c0b5-cd09-040696679715@loongson.cn>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <2074ae0a-5a3a-c0b5-cd09-040696679715@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NrtVg7D34wGAcJ5a/nlGzO7Ozr75q/E6lYy3MZipGJAE/toxMkPPMwjA
	e3YrmIv+1L/KYd2MxL8uwSFv5TZO3XjYKpMccuLI6TRwYvW6KDesCgQgizocV+P1X2WsbIi
	wKDmbWvQYiFW9xUCdcVEpkKY1sTjHiuePl0oCT9DEHx6d3aawxR2Qew9nxD5AH8oq+qmc6x
	CiemwhN1aXfdKfWulSccgceZPhRO1kVS4bdbNvdKhh3DRS9NadE6frYLQ2YVG+TNP84PwOa
	ONU+2MIzdjfLz5Bk9RgLYb+8yn7aE1nhdmy/hWB7lyDtI2jD5a7qWJKu2FePSZr3ys2IYee
	xXYFpBD0vrZ2Y2UI9rEpxZGNEx/n21RLBP8Xk8VleDup8DW9rHDhfphVCZelPqp7ZLwZnd3
	r/CmSG8I1+nQ/77wCGXxw58iNpR5oYXqu6QP8V7nW0t1dyEmWTKGhN6qrMKYPYJiglGNDRl
	i1Tc1KASmMdBGB20lEpeFSnDn3VykQFGFiFEuPlTBoUUMn32Uc5ULU3Um6uBA/SCcTXWMeD
	mcZNABK0xf1ccMyp8vW37gnRexFPZK00bcI9SyHSLePgx7zLAU8Enx7Uje+vxm98FkHYJq6
	uGtIXTLHURrJfAHL0XTLs0ZMh6h9ac5F95jJ1dTh1HDhID7CQURZxlX/VvSFlQfyOskmXhB
	K5+K2d0tpfiRyx6O+CTct1WyEWcTuSBlezdb2BtWjx1Nt4SaulHl2VU9+zjvz+YfpCBs9e+
	gcm4pJ93E0K/uKkhSTiLn8UvU/gCBnHXX14dpHgzL4ZXhvzeF2pghF1mljU9tN67261/1uP
	Ih8c60YMi1ze1x6IedRq36V9SYcbx3NQ55QmCU1gRRIK1ca4GbnDy0beEqF/zX8I1RqTHjr
	Ckts6GoCBjQuIvGIjgb7sY88kDd/1x3mejuc344/c6n+7chiLb/BK/hvBVGF4ORWBEcj9tN
	8nmfFTFyld9VdUhwSSlHFN4vssOWAb0savWZaeoRlq2pLnTjzSl+K6R8749m/1ST9IkqMxL
	jYaXTWbK2imrNatAMmsSPiraz3jZxQCnCouuTkCQ==
X-QQ-XMRINFO: OWPUhxQsoeAVRscC/QzSek3CGsmIHPzmUw==
X-QQ-RECHKSPAM: 0


在 2026/4/28 17:50, Bibo Mao 写道:
>
>
> On 2026/4/28 下午3:47, Qiang Ma wrote:
>> It doesn't make sense to return the recommended maximum number of
>> vCPUs which exceeds the maximum possible number of vCPUs.
>>
>> Other architectures have already done this, such as Commit
>> 57a2e13ebdda ("KVM: MIPS: Cap KVM_CAP_NR_VCPUS by KVM_CAP_MAX_VCPUS")
>>
>> Fixes: 482795cb62aa ("LoongArch: KVM: Implement VM related functions")
>>
>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>> ---
>>   arch/loongarch/kvm/vm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
>> index 8cc5ee1c53ef..1317c718f896 100644
>> --- a/arch/loongarch/kvm/vm.c
>> +++ b/arch/loongarch/kvm/vm.c
>> @@ -125,7 +125,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, 
>> long ext)
>>           r = 1;
>>           break;
>>       case KVM_CAP_NR_VCPUS:
>> -        r = num_online_cpus();
>> +        r = min_t(unsigned int, num_online_cpus(), KVM_MAX_VCPUS);
>>           break;
>>       case KVM_CAP_MAX_VCPUS:
>>           r = KVM_MAX_VCPUS;
>>
> Hi Qiang,
>
> yes, this is better.
>
> Though value of CONFIG_NR_CPUS is 2048, currently max CPU number of 
> host hardware is 256 still because of limitation of AVEC and extioi HW 
> irqchip.
>
> If there is HW machine in future which supports more than 256 CPUs, 
> the max online CPU is no more than 256 with existing kernel version. 
> So I think that the "Fixes" tag is not necessary.
That makes sense. Let's remove the "Fixes" tag and send out the v2 version.
>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>
>

