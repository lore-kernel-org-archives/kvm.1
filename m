Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A1E360EED
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 07:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484213; cv=none; b=Yik4ZuFK/eZna0eiVX0bzyIlnG3AsDuOk0OPBe/pkTniuUmEb5bqaSQLnmo+SeV91hv7Qrv8W8/INMzMqU3uJwvFD7noTSB/Lsluq6lbk45TEXuwz3BQ6Ax35iVF3//OnElIHZ0f9aU25ruFfzToqMnnUiIgK1Ylp5FpUzCHf3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484213; c=relaxed/simple;
	bh=zXVds8DrkY8+TP+t2Qwkyg705QKpcGxR8lbY9/QeFFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LCbDQKesaFmPXJiginTNHj2tjqlBsP75xuEl0gxIgf1VbxAmDPVjmFvQat2DW+1+AC8vh+zSbc5vOxC0kn2g95hl8OGZfz4Px73J3AM1g2L7DJb/ju18tdwCLz2ZBizzKIgD+UF3/OEJ1qe0eNzd9uD2auYnnPA8mLGoz28prh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07836451|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.274819-0.00941988-0.715761;FP=7060517339840209002|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045018182;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.iaJHpDT_1785484205;
Received: from 172.18.22.107(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iaJHpDT_1785484205 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 15:50:06 +0800
Message-ID: <ba2b2084-26c3-49a8-bf56-fff34b4c0802@open-hieco.net>
Date: Fri, 31 Jul 2026 15:50:05 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] target/i386: Sync AMD CPUID aliases for Hygon
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
 <20260706055530.1752094-2-zhang_wei@open-hieco.net>
 <amxIj+rZvDrtX7BM@intel.com>
Content-Language: en-US
From: Tina Zhang <zhang_wei@open-hieco.net>
In-Reply-To: <amxIj+rZvDrtX7BM@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/31/2026 3:02 PM, Zhao Liu wrote:
>> -GlobalProperty pc_compat_11_0[] = {};
>> +GlobalProperty pc_compat_11_0[] = {
>> +    { TYPE_X86_CPU, "x-hygon-vendor-abi-fixes", "false" },
>> +};
> This needs rebase on v11.1 🙂

Right, I will rebase this on top of v11.1.

>> -    if (IS_AMD_CPU(env)) {
>> +    if (x86_cpu_has_amd_cpuid_aliases(cpu)) {
> Or we can omit this helper ("x86_cpu_has_amd_cpuid_aliases(cpu)") and
> instead do the check directly inline?
> 
> I think we should have fewer helpers like this, unless the conditional
> checks are really lengthy... Since the helpers added for each ABI is
> similar, but we can’t consolidate them into a single generic helper
> (because while the AMD and Hygon ABIs are basically similar, there are
> still differences), having too many similar helpers makes the code seem
> fragmented.

Agreed. The helper is unnecessary for this short condition. I will 
inline the Hygon-gated check in v2 to avoid adding another small 
ABI-specific helper.


> 
>> @@ -2461,6 +2467,12 @@ struct ArchCPU {
>>        */
>>       bool vendor_cpuid_only_v2;
>>   
>> +    /*
>> +     * Enable Hygon vendor ABI fixes for new machine types.  Old machine
>> +     * types disable this to preserve guest-visible CPU ABI.
>> +     */
>> +    bool hygon_vendor_abi_fixes;
>> +
> Maybe the following comment to emphasize this is a compat option?

Yes, that wording is clearer. I will update the comment in v2.

Thanks,
Tina
> 
> /*
>   * Compatibility bits for old machine types: if true, apply Hygon
>   * vendor-specific ABI fixes.  Old machine types disable this to
>   * preserve the guest-visible CPU ABI.
>   */





