Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695A3B2FC7
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674108; cv=none; b=NP/wgtASURz86LXF2Jq0bvwPskN6MbR01vpax+2tXDZsM581C9+A7smz0fMQcM4tpzmvpCnkml4SOUSHkQRFD1QsYd4R3hzNy4D899E/zzCEgx0sB1BesNWigZ3WIyrrdy8lh027OizTmCYucwEyFjalPBlpTGHzUfOCgOM7IuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674108; c=relaxed/simple;
	bh=0bjgd3+mvjM+SD6+WctCfW2sEDqMAJmseiFloV+zTTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWnkqI4GHq1Owxn6X1zoz6i/GUObVtBOB/oYlV3uDeMScc4M3bDsZTwmvuBtM3OWogkFTqWF4GYdwOZEgM21/wS/4ksBFje9MzblJMOL0LbdQjYjoRTbp3+ScGM+wxpJ9hYmtlEcN+mvA7lBaI1YX0P60CLmDWngXEkXg/2xJeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DSJTayal; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DSJTayal"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493f60208a5so1441405e9.3
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 02:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783674105; x=1784278905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GM/K7mEoxx2butYPcCAhdKcKE6yuKUATXnqo6Q9P4rU=;
        b=DSJTayalw7fgw2oikcsB3bZVqdtaZc+fdv34LdF3Ozw+QYS8vd/Pirqd2GsDjqzD9P
         tR0LWr0a5hNNBicfRNCFD4kHQ313CPVbCgsPLZBm4Prrnal1Yt3VWOJeersqvTytiWCy
         hQsr3bv+DCk+1Ft2HWhqvGv7Ev0TDwuXQBOdHqGPNHKQO19UV03kazq4iEA+q87BO0rP
         A7G3rhTRx+kyFj5hyjbqmg985IHYEOantFbmEWGXSWGJ+ym1jiZovtKXLn+aX/2Jd8fT
         KTPc/j/WpRdMBohlfrxsMejAQlJ60QDztjeLa/Bvpr7TZXws6DFSTY5kg69SfEQWiaJD
         rugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674105; x=1784278905;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GM/K7mEoxx2butYPcCAhdKcKE6yuKUATXnqo6Q9P4rU=;
        b=IQveTJQAGXPJv4FYsdzVZ3vdwqI8bHe8j/fw5lqLNlrYnvecZnTccpk3se1Ashe08n
         57qXyA+JqPvu8tufYdBd17O7JgNeEvOMzuj6geOClM3UBWWDTYIsZJy3JC06kik8B9uE
         pSXWiE0IjerndwsozqPoJIXgsv3Z8F6a7ADUnlhw0abUJ5Erb8PO9j1i9FhAzy3+fP1i
         OsfD27Fdx7S81Bv9ruc32DzP3EZUsUyTc2PzoZ7ewyyKRfd/0VzBNApb3Gw0fSWWvkTH
         q+w3loTCaJVaVZ7rkyAtHxPkY3lEmsE8hJNYsL3qZ6L2sDH4sPP4RLvm3eKU0NxVEibq
         Gi2w==
X-Forwarded-Encrypted: i=1; AHgh+RoexcalVSRqAHm7SIBnw8ait+ITvFEO1nJ+GToG6JvQt5/7sidCLm6xPpcvuDRdFIjvjPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVFn5D5KhOCTD+7w0T+G09mrrDzyaxO6KEdG4D2y7wpW1PmVZ+
	rAO7KDvqciof9pZsTC8PID66G29+Jn8VCxsTpRcG7CbAtOERKcc/RqSukXoxA7GgVQY=
X-Gm-Gg: AfdE7cmVb1mQxHAJdFmQqM1JXYlHnDxr4i4zD35UgSB/9g7EaoW2/+0ufQnkYCRZXgh
	HH8s1yCBy0b/vBFYr3xzNIkVffQTo4R6l+oPVXjrvExdy/4FjkRFpGTGN3TInkC2uGWqhMvXfOP
	t5I1OiUa8Q7nTekkak6fDGDKJ9NRhs3mTpUQM+GKnKfT3+2o+SpMr5tuF/PEbbuLf7ld0tZ6ojG
	yuQfzNs3SYt0/fN2knrXri1N0VUvutYWrqxaq8+XuHJnr7tpgtIZfjlWzW9iDjkPrXPlBcxFhOJ
	JQXnxB20s8gFj9swCtrBat3E87goo9zPactUjvYo/QHT9bIXmv2NGeAu+/+uGHXp4W4pbFf5wcd
	W8zqGXhZPn9xq+6fk+EDXiuUkflvMlOm2z4woC9ATZCkc4oLBwPyOrKalWP4NfZ5nvkScOkPdol
	RLc4AvJKAk7kd/mRw=
X-Received: by 2002:a05:600c:1d25:b0:493:e79e:da63 with SMTP id 5b1f17b1804b1-493e79edbb0mr91113305e9.34.1783674104915;
        Fri, 10 Jul 2026 02:01:44 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.207.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6ccdbbsm127156535e9.3.2026.07.10.02.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 02:01:44 -0700 (PDT)
Message-ID: <e6c0ecd4-c128-47c3-99ce-1d45113f6766@suse.com>
Date: Fri, 10 Jul 2026 12:01:41 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/17] KVM: TDX: Add in-kernel Quote generation
To: Peter Fang <peter.fang@intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "seanjc@google.com" <seanjc@google.com>, "djbw@kernel.org"
 <djbw@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Hansen, Dave"
 <dave.hansen@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>, "kas@kernel.org"
 <kas@kernel.org>,
 "tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
 "Xu, Yilun" <yilun.xu@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Mehta, Sohil" <sohil.mehta@intel.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "Maloor, Kishen" <kishen.maloor@intel.com>,
 "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-17-yilun.xu@linux.intel.com>
 <aj1tFuwZWdPGfUoG@google.com> <20260629100301.GA1743876@pedri>
 <akMQ3J6fK3DUBsPH@google.com>
 <23a9173f6e278ca7dfedce3374626c6ea3e1b47a.camel@intel.com>
 <6a445e4be6b12_3a3568100db@djbw-dev.notmuch> <akVNdxCzk-n4bgMv@google.com>
 <9df36c49e6be69dd9eece71f70a404a84b1563ab.camel@intel.com>
 <20260704054342.GB2169894@pedri>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260704054342.GB2169894@pedri>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/4/26 08:43, Peter Fang wrote:
> On Wed, Jul 01, 2026 at 11:45:53AM -0700, Edgecombe, Rick P wrote:
>> On Wed, 2026-07-01 at 10:25 -0700, Sean Christopherson wrote:
>>>>> That is a good question. The answer is partly historical reasons, but I
>>>>> think the pros/cons don’t really move the needle too much.
>>>>>
>>>>> The main benefit of doing it with the host in the loop is that the guest
>>>>> side TDVMCALL quoting interface can stay the same. There is also a wrinkle
>>>>> in that there is a limited HW resource involved in the quoting,
>>>
>>> What is this magical resource?
>>
>> It's a HW crypto thing. I'll let Peter explain more.
> 
> It's called S3M (Secured Startup Services). There was once a public
> document about it, but it was removed for some reason. It basically

Are you referring to this: 
https://www.scribd.com/document/970439243/S3M-Intel-White-Paper ?

<snip>
