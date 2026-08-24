Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63263161A1
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 05:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547969; cv=none; b=aDHfhOaIrwKSHX/csO7dWGWZ/X2nAzbO/GlusdI2rWQ/5wivBQMwikBOdoE8BQpkEY4LUUfctEIhTOFyOS92Uyhs4CbcykOV1CJSXPO90DKcWSamBFMdizd6H7cWLV29jlIKRceWuVjc8o1iwYTeLpozVHA7bg5c+EZKi2LYiAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547969; c=relaxed/simple;
	bh=5rupcJT86YaPtjGryK72kO/Ilfn6bO3Zw9JAE9GUZv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlkGJ0StL7r+eDZ3gnBuyjd+p5vs1W9LZYobQb3MYu4NZwcYj45O3i6dGZZlMoHht9R9H/YxvjqBycoUgtL5rvIlMO6J4bF//h57IYBnLAbXVVVeMN3m5TUPHcjGMlFAIjg26EQ6XX21pfYOtPQ82N/YsiAoKNnOP3sT9t8L/ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436267|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.113531-0.015932-0.870537;FP=7205660562698012251|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.ivaIACA_1787547955;
Received: from 172.18.22.44(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.ivaIACA_1787547955 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 24 Aug 2026 13:05:55 +0800
Message-ID: <199e4e38-9942-463a-8edd-b97cf2b32f73@open-hieco.net>
Date: Mon, 24 Aug 2026 13:05:53 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] target/i386: Sync AMD CPUID aliases for Hygon
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Yanjing Zhou <zhouyanjing@hygon.cn>,
 Yongwei Xu <xuyongwei@open-hieco.net>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-2-zhang_wei@open-hieco.net>
 <aoqzsAC5dBBuLQ8h@intel.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <aoqzsAC5dBBuLQ8h@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Zhao,

Thank you for the detailed review and helpful suggestions.

I have addressed your comments in v3, including rebasing the series onto 
the latest master, splitting the PMU changes, updating the IOMMU helper 
and tests, and fixing the pc-11.1 compatibility descriptions.

The v3 series is available here:
https://lists.nongnu.org/archive/html/qemu-devel/2026-08/msg05437.html

Thanks,
Tina

On 8/23/2026 4:47 PM, Zhao Liu wrote:
> On Mon, Aug 10, 2026 at 04:29:48PM +0800, Tina Zhang wrote:
>> Date: Mon, 10 Aug 2026 16:29:48 +0800
>> From: Tina Zhang <zhang_wei@open-hieco.net>
>> Subject: [PATCH v2 1/9] target/i386: Sync AMD CPUID aliases for Hygon
>> X-Mailer: git-send-email 2.43.7
>>
>> AMD defines CPUID[0x80000001].EDX bits as aliases for a subset of
>> CPUID[1].EDX.  QEMU currently synchronizes those aliases only when the
>> guest CPU vendor is AuthenticAMD.
>>
>> Hygon Dhyana uses the HygonGenuine vendor string, but implements the
>> same AMD-compatible extended CPUID feature aliases.  This can leave QEMU
>> advertising a feature in CPUID[1].EDX while the matching extended alias
>> in CPUID[0x80000001].EDX stays clear.  This inconsistent CPUID state can
>> confuse guest OS feature detection.
>>
>> Apply the alias synchronization to Hygon CPUs as well.  Gate the new
>> behavior with x-hygon-vendor-abi-fixes and disable it for pc-11.0 and
>                                                              ^^^^^^^
> nit: pc-11.1 ?
> 
>> older machine types, because the CPUID result is guest-visible ABI and
>> must remain migration-compatible.
>>
>> Add qtest coverage for the Dhyana model, including the compat property.
>>
>> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
>> Tested-by: Yongwei Xu <xuyongwei@open-hieco.net>
>> ---
>>   hw/i386/pc.c                        |  5 ++
>>   hw/i386/pc_piix.c                   |  1 +
>>   hw/i386/pc_q35.c                    |  1 +
>>   include/hw/i386/pc.h                |  3 ++
>>   target/i386/cpu.c                   | 10 ++--
>>   target/i386/cpu.h                   | 13 +++++
>>   tests/qtest/test-x86-cpuid-compat.c | 76 +++++++++++++++++++++++++++++
>>   7 files changed, 106 insertions(+), 3 deletions(-)
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index f064aa2b3e..2b4e322b2f 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -74,6 +74,11 @@
>>   #include "hw/xen/xen-bus.h"
>>   #endif
>>   
>> +GlobalProperty pc_compat_11_1[] = {
>> +    { TYPE_X86_CPU, "x-hygon-vendor-abi-fixes", "false" },
>> +};
>> +const size_t pc_compat_11_1_len = G_N_ELEMENTS(pc_compat_11_1);
>> +
> 
> compat machine property is already on the master branch, so this
> patch need to be rebased.
> 
>>   GlobalProperty pc_compat_11_0[] = {};
>>   const size_t pc_compat_11_0_len = G_N_ELEMENTS(pc_compat_11_0);
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index 82457bdb16..8e58f2a7ee 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -438,6 +438,7 @@ DEFINE_I440FX_MACHINE_AS_LATEST(11, 1);
>>   static void pc_i440fx_machine_11_0_options(MachineClass *m)
>>   {
>>       pc_i440fx_machine_11_1_options(m);
> 
> pc_i440fx_machine_11_1_options() has added pc_compat_11_1...
> 
>> +    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
> 
> ...so taht now we don't need ao do this again.
> 
>>       compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
>>       compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);
>>   }
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index 6c1e4eff5f..fd4366f51f 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -393,6 +393,7 @@ DEFINE_Q35_MACHINE_AS_LATEST(11, 1);
>>   static void pc_q35_machine_11_0_options(MachineClass *m)
>>   {
>>       pc_q35_machine_11_1_options(m);
>> +    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
> 
> ditto.
> 
>>       compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
>>       compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);
>>   }
> 
> Overall, LGTM except rebasing :).
> 
> Regards,
> Zhao

