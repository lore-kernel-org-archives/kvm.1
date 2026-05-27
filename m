Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62B8365A03
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909274; cv=pass; b=XZQTWvrGQdqaSPmQpT6or4JGRLvhqsiDKhsDHnmAUHieg1ukCnLou63wRvCGhCapP3/KxUVknO3+H6/svEBWwIPhMPdR5urG1ZEHPhJiHiIB0Aeaif7Nz/RZTKorgjpq1GZ+qlH9OpFzY4/KeZU1zREJ055dAO0DnbWITqEeQzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909274; c=relaxed/simple;
	bh=cxuZgmmkPCwg+JKDsJkcwE8p/yMe7OmgUBBQEoRSZlg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8+n0FenSio42rIlQVppfWXWgCj42wXiOR8vsyf86Sxw7zRHk01GS7M38upIfsQDjX9ydjR5cUBwTU9YB4VYl0q1xmbBwT1h8pGWW23XI2kkUUh9b7OoNVILmOP5yrcPFb57qxzGeE1UAiGF625JAGy/FbXO0pjqCGliHv2RrXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tUFcDEM2; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tUFcDEM2"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1363e78746eso7953000c88.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779909271; cv=none;
        d=google.com; s=arc-20240605;
        b=fb04zIkppa5ed/Le++NEK9KLU7CAzVnVW/wY0kmdHHsCeRAdjNFbNoBPOToPwLU08T
         i2eGlieOYNWUR71fZ1H/Oj2HssfEiHI78GXzvZA1tZbxXlTXK7CRWnsXZmO/VMxARNIT
         Uzm1fDTGADLMLEQD7xocNYe++di7d3vZMki77KBNJeezayymz2E2/6ycKQr6Tc6/4XsY
         vc7EkJHp3IWFcZk7qV2XqqHSnS+mE3C4pFYBJceUhjTZI1qjhso1JMeDXrLed8CfFeJK
         NAaDW6NE+frIMMZDgVf8RyA3LA+15mIuM4WB6L+SKTceKSOTGT4BlFahftq/FH01tm8K
         rNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=iKraDOkRUUv444/RRlQa6/+8h198diUf5YFK+z5gLHI=;
        fh=Pa26GOdeMZckfDwYDMTngPeGrmZeBrm7ArpUn2UVEAI=;
        b=JnMdpdSjsPzZuhQ4ZeDnPENJBtfFeAAaBMQuNGuXh24EvCmdB7LLDJnywD4igExpou
         87sN0MePffV8FyJq/JicO/fcb3sfwftloun2CplP+WUzX8fBobyozUG+XqyH6DR+LdCW
         v9Avg7t8yKJKhk7dfiSytZvAdVbI6lJlGuBOWeFJNAjskoPBTSjDKvCfTBBeXt5XMTtT
         YdrX21e/kILpCCreXRXuTCW7UVioY3l5h4vpKiG5QA6v7rJKbf8wcEzRaj2djrXGQHxH
         1fycXnC4xwGuqHywoSGGTNNaM8R6C7awlHokaoK/WfazxUwNCpqE+jOQM6x7EUGQq9H4
         5G1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779909271; x=1780514071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iKraDOkRUUv444/RRlQa6/+8h198diUf5YFK+z5gLHI=;
        b=tUFcDEM2xxbROHzdEHpwi2ChFz/4Wmgz6bMLf+gIuc4JW/vMOgM5RK41CsGUp69/Ao
         HhLkUnsLHe/trIxT0lBK3cCQVMtzhU/DfqszYSLBoW4Jga07yh3Z214ryPHCMCfM/Sya
         79O78mFe9x5NJqnxunpbjwhKyIfg3Q7x9Ob/8zaOtkFf4V1mU0Lf1rNLHK4wxiQqelmt
         bFFTyOGu2NY+8TUmlmW9wsSOUSAMH9/H2qub2c6/hGpngp5720wEAr6CIGOrjkeN4vXB
         M/K00qA7/Nz7AcmfqCLMw5LWW3WRWxQLvqoZ14/bslpRuOmPWnQuOv09JP2p0vhI909s
         dDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779909271; x=1780514071;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKraDOkRUUv444/RRlQa6/+8h198diUf5YFK+z5gLHI=;
        b=ASO2ThTGY2Bw/kzOkTrDDd0NuDjULK3PuGyX8epHi1GIHokvOsKc0GPYBKixWGHAOo
         mckhl8apD9zHwYA3jgvWxC+yFoJbkWWnjsvktXqQfx3mo3HGCZcBPFPNMWwboAb73wl1
         OvovWzfMEFQTJlHczdak9hyo/zMktFOQrtz1M+CBzCiRMCryJOpbydEhrFdqiDWHGheW
         K5Rq5Sb4+xHpyNGzMrLnju34iliXWDSbqJgSwOZ1TlPYTsuxtcqwKSagsGW798ZkTdm7
         WKw+Oeq4PoVINks2K7L+VPdldq/Bc3GWz3Qbe9DngTUDn2H6qzTHh6LHj00BIxIyj1ka
         4PJA==
X-Forwarded-Encrypted: i=1; AFNElJ+iSGGbJFAqk3ntcM6cz55aPfcFuzy0+SPMiRVElphE7sn67orkRTjiSmo5gyJ+OVxCMlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylz4OSwSckOj/o5ubclkjUxD6E5XOXf7iZ8j6NCzNqEGq9Su06
	M02sNuLrlzo73tOokXqKWuQdFXE75CC+vx45/UOac/OzTHTrtHqDjI4wdm/UOeeCwOfjNg4FHyB
	003nC03Erg6C/0hfYBdOQ26l7aNfsEEV5giSEiLq2
X-Gm-Gg: Acq92OEuGIoinCZrty2Z+zCv1lZTPONZLrSMJtV9tSedKiccK1DCIWlpICxpG/5VbWy
	rDHPl7MRrdM0xyktN9khB42i9jw1/TlVXN9jO7x2jzJACBKNr34tAR+zM1Hki43MGF1vCRH1eHc
	gosgsJHGvbKPSLBetzblD1zK59jKvl0Tvl/nhAAgjqy4oOAkjy2xGbLC20uqWJRa3yHU2eaKeaS
	/CpV4wBOAWGxievHqTS6aDJWK9gkdfBVWNlHvgYce9qF7OP8CKvkaWB2VEbmkxrcNcziQ1RMOFK
	Ql9EQ65lQoqmk2bZ70HizCabinVW1fktxTuUOpenrQZQ+bIcMSfiRLqS3MaHVEb4j4C3Gn3btVo
	PxXP0eboIu4IQbA==
X-Received: by 2002:a05:7022:661f:b0:135:f2aa:46da with SMTP id
 a92af1059eb24-1365f812eefmr8782266c88.16.1779909270126; Wed, 27 May 2026
 12:14:30 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 12:14:29 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 12:14:29 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ahXOiy0dBSBOQli2@google.com>
References: <20260522-fix-sev-gmem-post-populate-v2-0-3f196bfad5a1@google.com>
 <20260522-fix-sev-gmem-post-populate-v2-5-3f196bfad5a1@google.com> <ahXOiy0dBSBOQli2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 May 2026 12:14:29 -0700
X-Gm-Features: AVHnY4Lko5ticX5UbdxxG3ZWqAWN_nu1jsv5zl3_u-kUQ6XAw4rxQCl5mitsqfs
Message-ID: <CAEvNRgEJ9ozQsVkubL55+ApJ9Z0H_nRS1uP+BTa6+agYLAyMcw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] KVM: SNP: Mark source page dirty in sev_gmem_post_populate
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zongyao Chen <ZongYao.Chen@linux.alibaba.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Fri, May 22, 2026, Ackerley Tng wrote:
>> Mark the folio as dirty after copying data into the source page in
>> sev_gmem_post_populate. After the memcpy, failing to mark the page dirty
>> can lead to the memory management subsystem discarding the changes if the
>> page is reclaimed or otherwise processed by the swap subsystem.
>>
>> Fixes: 2a62345b3052 ("KVM: guest_memfd: GUP source pages prior to populating guest memory")
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>  arch/x86/kvm/svm/sev.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index dbf75326a40f4..1a361f08c7a3d 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -2395,6 +2395,7 @@ static int sev_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>>  		void *dst_vaddr = kmap_local_pfn(pfn);
>>
>>  		memcpy(src_vaddr, dst_vaddr, PAGE_SIZE);
>> +		folio_mark_dirty(page_folio(src_page));
>
> I'd rather use set_page_dirty().  I'll fixup when applying, unless someon objects.
>

I was looking for page, dirty but set_page_dirty() somehow escaped my
search. This works, thanks!

>>  		kunmap_local(dst_vaddr);
>>  		kunmap_local(src_vaddr);
>>
>> --
>> 2.54.0.794.g4f17f83d09-goog
>>
