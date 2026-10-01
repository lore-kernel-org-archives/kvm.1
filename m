Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE5C41735B
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790871562; cv=none; b=dHXekcKjvjBlx07T/UGN84FeohkqHZXSJWiQu920SzZ9R7rbbc2xZnsjNkkkDDzgzDjapJVMW18XpBY4viouEvkd8mL9K+K74VM2sABEf20jJEaEBfixvGccljgclnYw2QWX0N7MctZdyK6p3DJztp9CLVKpnSGMOURSHCUzCJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790871562; c=relaxed/simple;
	bh=vdrItP7NNIB5efxVoNcXZS6zdv9F/6GpckExPWjVY50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTIm+NE3yJVBwisbBGxT3dZr5Om9zufELjrUGc25wizaep7RgnkyL7vSDXza+3+QfmDJ5gdJEafjYnDHdXZLl4XuNUCMSlcZuqkvuDT6khoXvU9X9qU4zco6UWtcycXo1y2wJffBhvDO7C2xHDb0sbzQehGgHFpLI/my0gklPS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e5R9yb/f; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e5R9yb/f"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a01ff8c098so6584975e9.3
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790871559; x=1791476359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vi7SR1DPMZ2IESiCs8hDuzeZjMXZIWPfZzQhtaUi3a0=;
        b=e5R9yb/f+WfsYhr27bBkJHkYcGkpou46eFxfBEGNMNhUgSYWuehlbEv+cwx3iqvbVQ
         u+nlXRPDym3ytnMkK8Z+PXUhzmghph1okbVGInaDdw3siq5j164Je7CRFVg65rsIac3H
         h+z69HZHfPl+r4GhMRJOp5Jc/68uNV6ZFTIH+c10AdfP3sCP9hy334wUU3fW/DkNE2Fc
         pFotfIgnxC7EbHNT+idDAIaCzMAWEzY0v2EryfoDMKoMnCbSpDtjNoeFLeh9Ar6+s3Te
         hwdfXeayf4b8ZJUhSfw53xBsuBjBDVTPBMqCRJR5SyHHJ4BHFfUQfzrOZSGkjX8RMa9E
         YGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790871559; x=1791476359;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vi7SR1DPMZ2IESiCs8hDuzeZjMXZIWPfZzQhtaUi3a0=;
        b=dRXJwi/fFc9OGRcQwvzkpxOrpwjVkwIHUCCdvEE5J7iXG4dii5+GxAYb+ItAIwYhwn
         I9LlplJLH7suzazkiYP2OvytWPNqUbztstPAHDXF45O3OOPr7L7FtWcM3yns7ZEYOdeT
         vBibAjJEWOiugmm+t92ptbRkoJxDFL8ljnmmYQgiVB+fdosQg9kS9/Ov6XDE8d0qryrT
         uYXGJEXQUrL90K7IxE4JJL3p7bHoy5gQ4qYQL2a4RlVK897P/76p+52U4/L76lwZL291
         LXg75dSBatb63CvJG314g6ba1WkSpEQNIAigovqX3mYFHnhzLBEX+Yo4kuCbOAQvtdny
         MK8Q==
X-Forwarded-Encrypted: i=1; AKwUvBz8D7UI+NU5A2QUiYsZhXKShnfYVkJLN9diFrWkDNYQVnWr8dmwA+wCiYSRl4LJiQdefN4=@vger.kernel.org
X-Gm-Message-State: AFuF++mRgjy85XjnHzVGouS1BacKh0E7nrcSHQVzYE5H59aGX8qqbGvE
	lyP7r6aWN/mCogPx9um+2cY3XGxCavimoND/3Gd2zUIIY6V4MW5VA0/EFbBAk/q6fu8=
X-Gm-Gg: AYBFou14v2Iwu6CntggtaInXQfUiniDLM+rsKarjmMQkIq5+678j8RADz01DZyN0BYW
	FiJh6XSXPipmamnGTZ28YUY8sC3fPax2kOVDppzhAUtr0P9tNO98bRnNXFPuGChoSKBuROBax53
	v1dFwIdqc0rlqNFh6+mM2SZXhGZRqmf/Dh8NDudUhcyBn9HGbY75xqzcgZwPWSJjuHjQ4hbgONW
	ZEV64Qq32SRssLHMbhsUZqQKM0zdk/vdJRklRxLInY50zCa4EWpbcZ22GIh/E3JqitSmb3YQKBt
	XYuCXffCEbgMhFv4oS4gPpzHTFBOF4LMOKHSden72/v7Z/Rh0r2H0GhQb9ADtUnymTSC1JfAL5W
	FDsmxePuxkIbN2wRsv5sn8Lbe+HqCMDDeL2eaC9VWRMhrWXhY0aaJeyvnWzQYgjYp/XDEwCoEaj
	mm1NE1emAFc8igNlw6+10fcnqoLCxGyThWZa7RSKFNf5BBgXAbkpcrr4moKcXgZHr18Hjsk2QUK
	mMLo9qFMXp4UR7dtKEXvHRdQFRqfxHy5w==
X-Received: by 2002:a05:600c:6217:b0:4a0:1ea1:477a with SMTP id 5b1f17b1804b1-4a0276a31b1mr2008765e9.27.1790871559329;
        Thu, 01 Oct 2026 09:19:19 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0db6a3b7sm4158135f8f.41.2026.10.01.09.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 09:19:19 -0700 (PDT)
Message-ID: <0b1f8e58-51f8-4062-ab0e-6cd5b915b49e@suse.com>
Date: Thu, 1 Oct 2026 19:19:17 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] x86/virt/tdx: Add a helper to read a table of
 metadata fields
To: Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org
Cc: yilun.xu@linux.intel.com, binbin.wu@linux.intel.com,
 tony.lindgren@linux.intel.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
 <20260930053901.22528-2-chao.gao@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260930053901.22528-2-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 30.09.26 г. 8:38 ч., Chao Gao wrote:
> The metadata field readers get_tdx_sys_info_<class>() in
> tdx_global_metadata.c were generated by an out-of-tree script. That has
> not worked out: the JSON file they were generated from is neither stable
> nor authoritative enough [1].  The goal now is to maintain the readers by
> hand and to establish one standard way of adding a metadata field.
> 
> Take get_tdx_sys_info_version() as an example:
> 
>        if (!ret && !(ret = read_sys_metadata_field(0x0800000100000003, &val)))
>                sysinfo_version->minor_version = val;
>        if (!ret && !(ret = read_sys_metadata_field(0x0800000100000004, &val)))
>                sysinfo_version->major_version = val;
>        if (!ret && !(ret = read_sys_metadata_field(0x0800000100000005, &val)))
>                sysinfo_version->update_version = val;
> 
> Two patterns stand out: the read-check-store sequence repeats once per
> field, and the error of each read is chained into the reads that follow.
> Neither is common in hand-written code.
> 
> Prepare to eliminate both with a loop that reads each field, stores the
> value into its structure member, and returns on the first error.
> 
> Add 'struct field_mapping' to describe one field as its ID plus the offset
> and size of the member that receives its value. Add TDX_SYSINFO_MAP() to
> build such an entry from a field ID, a structure type and a member name.
> Add __read_sys_metadata_table() helper to read every field in a table.
> Annotate that helper __maybe_unused as there is no caller right now.
> 
> Following changes will convert the existing readers to use the new helper.
> 
> AI was used under supervision to review code and workshop logs. It
> suggested adding read_sys_metadata_table() macro, which avoids repeating
> the table name when passing both the table and its size.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Link: https://lore.kernel.org/kvm/1e7bcbad-eb26-44b7-97ca-88ab53467212@intel.com/ # [1]

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
