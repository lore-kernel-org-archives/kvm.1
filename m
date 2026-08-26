Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15EF3D524C
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737903; cv=none; b=VwbUsr7kvyEgkKOXMBMHYJko6J74sms0a4EbIPHkxrNsSI37ccMGp9ClOodwiCx8woivAli1zXgOMgtvxaX4rOWKaCOEZY1mF5oQnB0Ixb7ck36nrnKfCMBZT5U3/MyzIZ7r0VckzA6QPs1BsozxfgDUf02VUqvmurQuOIcN1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737903; c=relaxed/simple;
	bh=v9piU18lZ/lb9fnvVLpa9yM8T1ZB0s+iYSi2lwWzsEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OA2J5tPZL0pBJWHB2g/TaHbi2gjEcbTTQsmPwH6HKH+nzTY15mr6VD3qg76ccKd10zlHjZRexK02l8ytfj9bNIjpmn8ZF5fHgD58nRJc5ifoxBCDbNjhxbDmaxyzM36SnAyOCpE0NdgyCYoyEL23Urap1MNTa4fnHLJILHbYTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RgBXASq4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RgBXASq4"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2022323c37so92392566b.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 02:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787737899; x=1788342699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YHCoJr/FzmfjS/OK2p3bq3ZjrRpL2dhX1kSlnFW6rfk=;
        b=RgBXASq4Y5ZB/8UITMoDeg9AzTxArB4u87rT2AM7pPClo9WWEgFV4iZ3ef67hXd++R
         mhkdOlsy4++LSyeNDsbnWom+BAKdHrg+A1ioIdpCtLTT6K98TeypTZcNsMxerD0IXUyG
         4Q2e4ivrJQ3bh8JcwwtY9qiFfVcQToL+yaWmskYwuNHnRlUbyJBO+Ehu8r8rR6Y971FK
         658UcqR0Un1ZP1d6fuKIGOhdagCpZKIbZe4GjBW38g4lVpCPYWacg0YCM5KYP1/nCUfY
         sRNx7yTraQRljquxV8VwRKxFv6Z7euV6YOnvNzfmiwA8FfipW9kX5ZRrDY4L7FZQmdZ+
         O/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787737899; x=1788342699;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YHCoJr/FzmfjS/OK2p3bq3ZjrRpL2dhX1kSlnFW6rfk=;
        b=XQFzgsF/AHLofV+FTZTuLFuIfhdcs/CeFq1G9YHdZLE4Via3t2+RT7mpnSpbtIw4iu
         4jjQmsRbD6aAfls9hpoa8g5QuE9C4FTriv4Na1lV8w+HCvBCLPa8/K+e1xHKNgvZAO++
         DonPlq5W122ELJQzmljcz+xW1t9R6+2Vr/MjAvQXtVMgIq5HUVcDc0+uZcDD5mkRDrYr
         OMsdMR9s7fUfnwG4EaeMZNurHv8xWa6qG+0d26oga3pVf3ntsm7078cK4bk07BILWfw8
         Gg7Sa03+pnQKBmlnHcNz1l2v1oEGnAbUpEw2jUYegwSK6WSy2RiKEcOFYlgUe6+4CsbM
         4/Gg==
X-Forwarded-Encrypted: i=1; AHgh+Rr66EIB6ZPqFSlkDhYYOcQ7JT1gZiH+6p4ogIMra/sXBqs6OrfD6kufntUPcnzBI/zjkhM=@vger.kernel.org
X-Gm-Message-State: AFuF++lw1NDvlZregJlmyeHssHHI1OMO+f3gj/+Mji2sWgqO1bqnYLcd
	D8x6BP1c+vpI+lLB5bwtWq1yzFWaFrCXWjinxIjb1KqoHleMsene4M1AByVOGcHW7zw=
X-Gm-Gg: AR+sD11Op4gMKKmIsxh8GaRcPED48YrKr7JcVD5uunWA5bSp6cEfHfEehZk+iZa3Osd
	j7cG7fuYg22Cx71kEpkiTaCAAgaIsGXeGHz7DksPVC8s3CnzNUHYy5ShbUawrthx3v1bAeBtmRf
	0/sZfhyNVEERz98Cby1uBhRkOjOgtws9BdmRdFrDSHfWNaV9n8fXzHBJKRDgiR085fGdjzcEpCA
	0mw3M1eygY/zwHt9LJJgcbuKjEGlNvNAMnBsgdDDfH35R4tfJdyVB98p7dEG6jZ7BKWN3bCCv3u
	D+R6eT0E+VI5tgAeLHhtgJOrHf1w55BfU0vEl/ebh7l53/Tq4zoKFFsmumKRomTksXbmjfJzZP0
	MDDVhse/XoHDQpwdyB4a/AEfFhp8AYJFgLtOr55NLqFwPzNk3FlG+r86a+tmAHua1Y3fx/OyB9z
	M6PqTDP5ncYdalAUA68JFtoAkNTavlGegrS7aRnCQyUO77N+mJl8hkrTJ0ZFKz8Lw=
X-Received: by 2002:a17:906:ef0e:b0:c12:e178:9e68 with SMTP id a640c23a62f3a-c250c3292a1mr623262666b.19.1787737898915;
        Wed, 26 Aug 2026 02:51:38 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.207.128])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a704e55sm387662366b.21.2026.08.26.02.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 02:51:38 -0700 (PDT)
Message-ID: <99dd1836-55ca-4302-a81d-545394673702@suse.com>
Date: Wed, 26 Aug 2026 12:51:36 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] KVM: VMX: Consolidate the exit handler for VMX and
 TDX
To: Xiaoyao Li <xiaoyao.li@intel.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
 <20260819094903.3060020-10-xiaoyao.li@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260819094903.3060020-10-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/19/26 12:49, Xiaoyao Li wrote:
> The exit handlers for VMX and TDX have the similar pattern. Consolidate
> them into a single vt_handle_exit() helper.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Changes in v4:
> - new patch.

I created essentially the the same code locally after I read the 
previous patch as the code duplication was killing!

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
