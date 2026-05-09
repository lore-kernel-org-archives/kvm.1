Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10F31917CD;
	Sat,  9 May 2026 01:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778291758; cv=none; b=guiQJmNZdFczzzcZIHRV+0O+PQNeSq4ENCVB6drVfzuALAMLR19qt7NXkNFnEk6MSvzQpB9tpaEITHB2GNIIXvap8/mBVaf7EOec0a/71bXCZn2GDDdGKwxdSzIePKldmitkEEM3K7rC9ew9sgV1BD2zES+vfDkwV4270aUy/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778291758; c=relaxed/simple;
	bh=P8Yre0bL4/dDZdUhvQEIYCKCOOJMbEbS6n1LVWZST/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AO2MFTpkjFNguGTKEgzm231KiWCigfhHpIr+VOxtw3WfFP8SgFNMxRX2sLN1IuanwjyvmN8s9UUt+ti//ezrZOUNoDcJCKz1Yj28xUigakGYMX7+L7TBCrlyd7SXUmN5rwSIedYQ5JxrmnMF9BDA8zKU4dtM2krFaH8lOMVXJ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6PvHSpu8; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6PvHSpu8"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ptSzZ7Q00sYT2nDsJ1InhZCyb9tZDRoX1xUOIXXL4LA=;
	b=6PvHSpu8whuuPPjlINKN1P8+8WGgowDULksAbsXcdZZomr9se1tcWrsq+oigM+f6Aw1eSUNCk
	lCFBobeTsGrEDImPdAsVtEonea4xwRkefNPWsq0oc8Oh+qohZb0Y/BgdytqqfhsNKZO/Sz0V//T
	7RRU5jABaQcG1GIRxReEcNI=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gC865356Gz12LF2;
	Sat,  9 May 2026 09:48:45 +0800 (CST)
Received: from dggpemr200006.china.huawei.com (unknown [7.185.36.167])
	by mail.maildlp.com (Postfix) with ESMTPS id 230A54048F;
	Sat,  9 May 2026 09:55:53 +0800 (CST)
Received: from [10.67.110.145] (10.67.110.145) by
 dggpemr200006.china.huawei.com (7.185.36.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 May 2026 09:55:52 +0800
Message-ID: <2715ea19-5480-4266-b581-0428494013ed@huawei.com>
Date: Sat, 9 May 2026 09:55:51 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT] USE_AFTER_FREE in complete_emulated_mmio found by
 KASAN/Syzkaller fuzz test (v5.10.0)
To: Sean Christopherson <seanjc@google.com>
CC: Zhangjiaji <zhangjiaji1@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Wangqinxiao (Tom)" <wangqinxiao@huawei.com>,
	zhangyashu <zhangyashu2@h-partners.com>, "wangyanan (Y)"
	<wangyanan55@huawei.com>, zouyipeng <zouyipeng@huawei.com>,
	<zhengxinyu6@huawei.com>
References: <67a2f20537354628bcb835586a7c6255@huawei.com>
 <aYuC87rMLlBYIZRc@google.com> <aZYneb7Dvuu-HQsP@google.com>
 <41da263a-ca8e-4041-8214-b6b9f80edebb@huawei.com>
 <af3yQrxgyC8YxAPt@google.com>
Content-Language: en-US
From: Xinyu <zhengxinyu6@huawei.com>
In-Reply-To: <af3yQrxgyC8YxAPt@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemr200006.china.huawei.com (7.185.36.167)



On 5/8/2026 10:25 PM, Sean Christopherson wrote:
> On Fri, May 08, 2026, Xinyu Zheng wrote:
>> On 2/19/2026 4:56 AM, Sean Christopherson wrote:
>>> On Tue, Feb 10, 2026, Sean Christopherson wrote:
>>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>>> index 2c7d76262898..0bb2a34fb93d 100644
>>> --- a/include/linux/kvm_host.h
>>> +++ b/include/linux/kvm_host.h
>>> @@ -320,7 +320,8 @@ static inline bool kvm_vcpu_can_poll(ktime_t cur, ktime_t stop)
>>>    struct kvm_mmio_fragment {
>>>    	gpa_t gpa;
>>>    	void *data;
>>> -	unsigned len;
>>> +	u64 val;
>>
>> Hi, Jiayi and Sean,
>>
>> Since I met a KABI consistence break problem from this change, I am finding
>> a way to avoid add including kvm_mmio_fragment.val.
> 
> I assume you're looking for a solution for a private/proprietary kernel?  I.e.
> not trying to figure out a solution for an upstream LTS kernel?

Yes.

> 
>> Can I try to directly malloc a 8 size buffer for kvm_mmio_fragment.data
>> instead of using kvm_mmio_fragment.val, and free this buffer in
>> complete_emulated_mmio when all fragments is been copied?
> 
> I highly doubt that will work, because you'd still need to stash the pointer
> somewhere.  And it pretty much would have to be somewhere in kvm_vcpu, which
> would likely mean a change in KABI.  FWIW, freeing the allocation in
> complete_emulated_mmio() wouldn't suffice; you'd also need to free the memory
> on vCPU destruction, because there's no guarantee userspace would complete
> KVM_RUN.

Thanks for your correction and patient reply!

> 
> You should be able to use the padding in the "kvm_run.s".  Thanks to s390's
> massive regs size, there's a huge amount of unused space in the union on x86.
> Note, because there can be two fragments in-flight, you'd need to index the
> array using the correct fragment number.
> 
> Userspace can scribble the value, but that's completely irrelevant from a host
> safety perspective.
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 6c8afa2047bf..29c7123d5467 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -515,7 +515,10 @@ struct kvm_run {
>          __u64 kvm_valid_regs;
>          __u64 kvm_dirty_regs;
>          union {
> -               struct kvm_sync_regs regs;
> +               struct {
> +                       struct kvm_sync_regs regs;
> +                       u64 x86_mmio_val[2];
> +               };
>                  char padding[SYNC_REGS_SIZE_BYTES];
>          } s;
>   };

I will take this suggestion.

-- 
Xinyu Zheng

