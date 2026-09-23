Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5542D746
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790186839; cv=none; b=TaGbt2dElxAXjH2lneYPNHWjhCEVuFVuMmiu8BOmbtarxIDM5Coqc4ZtZpzhVuTxft/VteDtYLAXkioXZ35iHG1TQJ6yo+7X2ctJqJAZxwrWs+GKls8pUHPG/blpLy3BWeQ02wIL5wAPtRw9uTjz5IDXIZOrwtJgZxBn0PNmDBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790186839; c=relaxed/simple;
	bh=0RHbBIO+5daZ7u1pt6wqZwvh/ADkO8ov3DoazbKFTWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BohgGE04/WNYsetkstXlYlXsOx6Kk2Jfa3k7HDHU6JDJ6Rd8Jxj2JHavyhR82buRAvtQ8UdfhKoVEHhBnKKgspOTq1fcDEy6+UsZ24VWUvcO0bBDct5wKnQ4o3XuBdM8uCXDqjREbn5dtuiLrvSXAv0vTm3ipEYcI245yPKRhkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V4480C1r; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V4480C1r"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so9412545e9.3
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 11:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790186835; x=1790791635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bF9Hx4fO0G/KQwjXpbhUb7EMr1USXSagsKF9OVM7N2Y=;
        b=V4480C1reD4CUZBA//D6GziYWarkPf7D8X2LDc4LvPs/Ntk/v2yOygNyTLfNQVsVES
         OgKYZzra+c1s/HAdST84Bbb5eJqwWvDjUSggxbOe45bCrQIsdJ22IY+/NYzWMBHfktAq
         ocPNsh6qr4jDAiqRscHEF079HjGVEsxDB4CVdsdiNOiR1aEOfky1cZFIs3QvXnl0gbWK
         B3WnQU5bNAUhiw2tkfcCX80N2kD3Ixbnd/Eh9dgcGFVtVSiHXLGnNz+LHTr31jtJzLHr
         z+k339xNfuuL/oF2CA2h2fq4QnW2WqD7aDcozes/bYRguqUZu/1PD1QKlLd0VQHFKe7B
         65gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790186835; x=1790791635;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bF9Hx4fO0G/KQwjXpbhUb7EMr1USXSagsKF9OVM7N2Y=;
        b=acVySOA8wVJmGIlvWi7NNfX+sKxk1Vfror08ftnLsoIck0uWMZqdRQQPpej0i5nbOS
         bHjl+fs0DC1095OO99sV00v6B3y3RvUAFCTy/kP0zM30arP+48hwDQn3fIiEFQ92shUC
         340thEN5kW7/VacVwCCVkmFbCKmwFS6fUT2CRvA8KWZKUDYTBUX0vvDLMFSiUxesvDP9
         q9tW2GKOUyW+s3DSn6baNB9MhAwqqQYkpV79HYD4pPV8UX19d8COqwoa9vQRRMukq7YU
         NRWXGUlekcdGl4uRmgx/QbLAEVQfjQ0GRVFHXgtTwkrmkJ4mEHZvNOdSeQMshBCG5jtW
         9YKA==
X-Forwarded-Encrypted: i=1; AKwUvBwRQmfSf/XRlRPwJYwE7dqsGO0mZErkwS9U+e4/Mz9HzYZOwa2pxB3t6AHjhcsL34Lm4qo=@vger.kernel.org
X-Gm-Message-State: AFuF++mP3fBCNUu8JsRRvjNAnsdI0kEBa9Ko6OnldL5RJiGayrdFtkYA
	2adWIsSOTfsVJoF8z1PByaGUmyYNcQcqKIwnmnnzbfsM9cNjCCHgHcdOIv2Zajn3rQU=
X-Gm-Gg: AYBFou3ZLvOdFmAjGYX7vvWfVKN1mxoirzYuKRxa4m59OHfi/r7B1JDHz6i9LJnoGtA
	t2a65NvM9phdCm2kMps97+7kYRceHeWcogusdx8jtRTxlyifZE6ImmH6GCxvoOkjguw8yrlHNwT
	lcq/ar2og4JpS0AJjZEtvnyXROo36wxFJ5N2Vr+kAruIP4tiPzIWBO9KMmZa46EsoziwGreDx2p
	1w+df6Z2l3ZoAx4GiUf/yL9taaI93boIDXmPcoxuDvgriYfj4RXJuSNU2sZaPOidbd9LkiwE+o4
	r8OL8qZfzdJiBzlpAbZWxTE6qnuVMcCup93Jo8zG+mgUGiadLBlJ96SDm4cn7/jLh8AC85b+rQr
	qhJggv5NqBckZds8WauZcFYSvy8BJzb5dVFi5mCeHskrng7q7zW1LdZR64tnXxmwK9C0Kwnogs0
	45ghyIxbnu2X6NDkAJCkEZhFTgwF6At9nesFBEq3L+PejH2Ynbie3hIMj9tV8HdVgOZLlqPX1eR
	lH+HTzbzEMm9jKXQHzwHZYw74AzUnzcqw==
X-Received: by 2002:a05:600c:1d29:b0:49d:797:83bf with SMTP id 5b1f17b1804b1-49fe66f3c7cmr113335e9.21.1790186834258;
        Wed, 23 Sep 2026 11:07:14 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf3541aesm50836905e9.0.2026.09.23.11.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 11:07:13 -0700 (PDT)
Message-ID: <486830fe-5b79-441e-bea4-c09241081923@suse.com>
Date: Wed, 23 Sep 2026 21:07:12 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/virt/tdx: Drop tdx_clflush_*()
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Gao, Chao" <chao.gao@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "x86@kernel.org" <x86@kernel.org>,
 "kas@kernel.org" <kas@kernel.org>, "Wu, Binbin" <binbin.wu@intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
 <20260922205215.870563-2-rick.p.edgecombe@intel.com>
 <86d0237e-80a5-4592-8e34-67960de70d8f@suse.com>
 <4527da9ddff360149bbc6ed8aadfc44dfc40c53b.camel@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <4527da9ddff360149bbc6ed8aadfc44dfc40c53b.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23.09.26 г. 19:26 ч., Edgecombe, Rick P wrote:
> On Wed, 2026-09-23 at 14:58 +0300, Nikolay Borisov wrote:
>> The code change itself is trivial, however nothing in the code being
>> removed is tied to CLFLUSH_BEFORE_ALLOC directly. And from the changelog
>> it's not entirely clear which those operations are (as per other
>> reviewers feedback). Looking at the TDX module spec that flag is
>> mentioned in relation to the following 3 operations:
>>
>> TDH.MEM.SEPT.ADD
>> TDH.MEM.PAGE.ADD
>> TDH.MEM.PAGE.AUG
>>
>> Whereas the patch also removes flushing from MNG_CREATE/VP_ADDCX/MNG_ADDCX
> 
> The docs are a bit too ambiguous for my preference, but in the "ABI spec" it has
> this blurb:
>     When allocating a memory page to be used as TD private memory or TD control
>     structure page, the host VMM is required to ensure that none of the cache
>     lines associated with the page is in a MODIFIED state.
> 
> So those others should be covered by "TD control structures". It would have been
> nice if these bits were included in the base spec flows too. But I think it's a
> symptom of that this arch was never really needed.
> 
> Similarly, for the system scoped memory that can have reclaim, I would have
> expected that the HW limitation reasoning would be the same as the TD scoped
> memory. But the docs are even less clear on that point. So the docs were never
> super clear on how this should work in general.
> 
> Instead we have the original intention of the Linux code, and some recent
> promises from TDX arch folks:
>   - CLFLUSH_BEFORE_ALLOC will not be set in the future
>   - VMM is not required to call TDH.PHYMEM.PAGE.WBIND on page reclaim on any
>     platforms supporting TDX.
> 
> Does it seem sufficient?

In my opinion the above contains important historical detail and it 
would be good that it's not lost so putting it, probably slightly 
rephrased and/or summarised in the changelog will be beneficial.

> 
>>
>>
>> So concrete references in the changelog would be much appreciated i.e
>> whether flushing for those 3 additional functions was because people
>> were overzealous, or they simply have been omitted from the public
>> documentation.
> 
> I'll try to add something to the effect of the above, if it explains it enough.

Works for me, thanks!


