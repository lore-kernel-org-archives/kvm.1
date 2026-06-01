Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67153750DC
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316756; cv=none; b=fybm1CxK3W42Upwpo/EpQ+XTqECKemxsx41fepErV9V83LETVi+NAfIaugNZxbxT01RrF8UWpYSIr2ITD1JsTvZ0s2W0gB9iYHKXPPfK/FagwnmGJoQbK/DjzUpFzbBKyimd2RC61Jn+59hYhWkblcSmGPl+WAeRrs6c/w1PntM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316756; c=relaxed/simple;
	bh=Cq6kgUnXTGUi0Hek+Dsa3gWSg8PBhUnAtCjQqpxEwjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUsd6NsKGB3d/CeRPM5SZWV2rqXjP28zHHoB73mLvSHfphv2i7GD7pgTwDK7DcIny0WPKqZN3ANtmFtxnFIatvvvOuFXwJxLNdnQJBrcJELAqR/r3u9QmEWAJyhnM+rpwNOL3Nm1ip0tiKaa2qcgNzgt/OrWIw9YYTyiT70taQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Urp4eBIq; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Urp4eBIq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780316739; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=qSGHvqd0B1TgP1CA27o+2RTQh6utjEByxs+dfuoSXoI=;
	b=Urp4eBIqPXBiDx7cmfxNNhwwq7Lsvp2eLOL6+tsDD/ks7aiQk/Epoe0P460IH//SlKz5naBL5B1c5baUQFduKRUS4ZMGKC5Kt6AUepb3Xn1JYpxto8kXZ99bTSeY5ENGYdtjvzSQogwMOopE24ptar9HicgGrLgE9ClOXW2GRFY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=yexun@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X4.lMuQ_1780316738;
Received: from U-KQJTCFK3-0011.local(mailfrom:yexun@linux.alibaba.com fp:SMTPD_---0X4.lMuQ_1780316738 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 01 Jun 2026 20:25:39 +0800
Date: Mon, 1 Jun 2026 20:25:38 +0800
From: yexun <yexun@linux.alibaba.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: kvm@vger.kernel.org, chao.gao@intel.com, seanjc@google.com, 
	pbonzini@redhat.com
Subject: Re: [kvm-unit-tests PATCH] x86/lam: Allocate test page from AREA_LOW
 instead of AREA_NORMAL
Message-ID: <ah13KeNB2jw0lUUw@U-KQJTCFK3-0011.local>
References: <20260601035401.39303-1-yexun@linux.alibaba.com>
 <8f155587-07b8-4315-9015-3d104ddfb34e@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8f155587-07b8-4315-9015-3d104ddfb34e@linux.intel.com>

On Mon, Jun 01, 2026 at 03:15:45 PM +0800, Binbin Wu wrote:
>On 6/1/2026 11:54 AM, yexun wrote:
>> diff --git a/x86/lam.c b/x86/lam.c
>> index 87efc5dd..b2dcf7f8 100644
>> --- a/x86/lam.c
>> +++ b/x86/lam.c
>> @@ -231,13 +231,13 @@ static void test_lam_user(void)
>>  	bool has_lam = this_cpu_has(X86_FEATURE_LAM);
>>
>>  	/*
>> -	 * The physical address of AREA_NORMAL is within 36 bits, so that using
>> +	 * The physical address of AREA_LOW is within 36 bits, so that using
>>  	 * identical mapping, the linear address will be considered as user mode
>>  	 * address from the view of LAM, and the metadata bits are not used as
>>  	 * address for both LAM48 and LAM57.
>>  	 */
>> -	vaddr = alloc_pages_flags(0, AREA_NORMAL);
>> -	static_assert((AREA_NORMAL_PFN & GENMASK(63, 47)) == 0UL);
>> +	vaddr = alloc_pages_flags(0, AREA_LOW);
>> +	static_assert((AREA_LOW_PFN & GENMASK(63, 47)) == 0UL);
>
>Although the error exists in the original code, the GENMASK(63, 47) is an address
>mask, it's not right to mask a PFN.

Thanks for your review. What about asserting '(vaddr & GENMASK(63, 47)) == 0UL'?
