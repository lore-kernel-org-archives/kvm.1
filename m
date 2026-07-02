Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0457248034D
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986942; cv=none; b=dY79MXx/vTby2MhCGm0OyXMGo2SHNJCehQZ/yeD/CfePWXhjFDenYeXlkbprCqlw9YsAOIgoN3SIHzPHrvxXVfxkLWOJV8FfnnQM6V36+g1RP6dw2Q+TfhKoCMnYHBScDCME/967e1jcZtQTJXU+6UDLx39QIkqoqsxtKLaBl6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986942; c=relaxed/simple;
	bh=sEu0x2NcKEiphU/d6SAhlCCLXAZ3h5HuqyggX6C2Idg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsG23C2b4+8mYdaQ6rleNnM671WjeIqK+O/RVqe87UySEHmN5XPCP3JrdTep9sERbZ2IibediGwcELsAwCpOqmawS83uoHQJ9MQdxCZfmYgFqgTDi5Zp0J9Uoomxm3XwDIYuupZ+XU6Tcn/YIeqfOCkhg51D/WjTW6Je02wzNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PVOxRJMT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PVOxRJMT"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493be1b9564so11937835e9.2
        for <kvm@vger.kernel.org>; Thu, 02 Jul 2026 03:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782986939; x=1783591739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O3uHxdfu4LT2DDxsNGpyxu0PXFIuEcbzMwBwzmwAGrI=;
        b=PVOxRJMTYgqiyf6UPgf5FeHdo0WfmkhAu74qZC1BNWd+kmEpw7Ry1vdg+29OfvQYU3
         ScFRh/E5P7bX3uUPoVUCpbUBxLaprwGv/LfeiTgacRigvgL9GvucvhwlM7uIJuTNuR52
         JoteaNw1HjHirZeJAlAR48GFGc86RgkUmVBv5mZYwnvzNpPVqShrd2oAt7XhZJWnrofs
         ch1icj1hBQoZF31OkPyCeq5F2dVO3HSK4XFOKxLSAxvEym3ElqD0C48FnVNCEG52Mwcy
         5/SqfeQQB79HHapgk7Zm4wuYYcsTe6++W7B6DM8cXRlkycJ+e0j0i+gmep4b+JeWtsF0
         KUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782986939; x=1783591739;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3uHxdfu4LT2DDxsNGpyxu0PXFIuEcbzMwBwzmwAGrI=;
        b=s8u5pF7eH1f28i8NHKV9L5R1ASCPLs5VKNzIjTRKdVg6XgV1BOxrX9W8FzzHZ6qZzW
         4UsTTtRM+3Z3G2U8YsxlZOVaGQ0upRJQEqzp/xotlSMytfOEuhy6vYQ9pWYvzZpAvgZy
         G8A0reu5y3RA2kLwZQXyCqgVuxpLr7nMnOYAGKPu+ZNllIqyDvzq1ep7hYicqbK98hUH
         pBm2nZXXEKK9tbVJPWKNq6BvdiYpsSMxkglgKS3jZDpv8j8JaIaImWJFD5ZSVDVU9UsT
         XUMcwQa0Qvvj2ZWuR3nXohgCGtD2KLl3MIFxdgQT7V0DuESWKJnTdNOphbO3EkEytD90
         w94w==
X-Forwarded-Encrypted: i=1; AHgh+RrWTNjZrDGKf/f3OSRkY/zUFTY/oCvCSBjjEJe5qBZusnQyTObyUjXuTwwkvc+yXF8atFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDiLZZ1YrdhWQJFVyOyQAXXxw1jMS+SWJNhAznhnyaRXuED6GD
	jijRDh+1peL7OD8fMOdzjU56hn07brXL+TdX53GlGFvJUKVnVgcRIiYXMoRfDqZHi/0=
X-Gm-Gg: AfdE7cnkI1AX+CyagkqWAl8u4l20alDFrAFzyuWmjyQxLFwMbc+xLH+DDzNqPa/mN6/
	V5wtpb1OEC1E9hmMdDKs7UY+AB9MSMg5JcZhRLU160fx8HUOpYP50dLX/pzXhUnZycwHYbf8R8v
	PaK9TzAEIalFqnJV/MUnoHaBy15Q2nI/0AnuVJyjhitm/V5c8ZXhcoy+6arr66OACJYZgve9ZIZ
	K58+A0ug/IMDICc++zA3ygClOjbxgiXzx9Wcy8MUPCklQDMZavtIpT5HmyV1CM1eXFwJn/rOvfY
	3VIOHfdiyj7YnHZeSq2F2qMxr0y1nVq+hVSVS3aBrYWCkfD6rwXuO0AqESXbTCEq00MH4aRtwrf
	GjtDi07sSDR3M4xFjwHsKD8GsNAllOa0r5DK+OjRQaq8/FjOXlvVFHXXZtdteUOI326zevt5Pni
	Yfm2Ga4U+18XBK7hQ=
X-Received: by 2002:a05:6000:2282:b0:470:4900:8d14 with SMTP id ffacd0b85a97d-477b32c1b95mr6663756f8f.2.1782986939393;
        Thu, 02 Jul 2026 03:08:59 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.207.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db8a4a09sm7836921f8f.13.2026.07.02.03.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 03:08:59 -0700 (PDT)
Message-ID: <480873c9-c25b-4666-9abf-2e5b6894eef5@suse.com>
Date: Thu, 2 Jul 2026 13:08:57 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/15] KVM: TDX: Factor out userspace return path from
 tdx_get_quote()
To: Xu Yilun <yilun.xu@linux.intel.com>, kas@kernel.org, djbw@kernel.org,
 rick.p.edgecombe@intel.com, x86@kernel.org, peter.fang@intel.com
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, sohil.mehta@intel.com, yilun.xu@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, xiaoyao.li@intel.com
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-12-yilun.xu@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260522034128.3144354-12-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/22/26 06:41, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> Separate the logic that returns GetQuote to userspace so that
> tdx_get_quote() can be extended to support in-kernel quote generation.
> 
> No functional change intended.
> 
> Signed-off-by: Peter Fang <peter.fang@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>   arch/x86/kvm/vmx/tdx.c | 25 ++++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index ed12805bbb44..9f7c39e0d4b5 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1524,6 +1524,20 @@ static int tdx_complete_simple(struct kvm_vcpu *vcpu)
>   	return 1;
>   }
>   
> +static int tdx_get_quote_user(struct kvm_vcpu *vcpu, u64 gpa, u64 size)
> +{
nit: Function name is misleading, imo appropriate name should have 
"fill"/"init" in the name as what it does is to fill the run->tdx 
structure.


tdx_fill_quote_user/tdx_init_quote_user


> +	vcpu->run->exit_reason = KVM_EXIT_TDX;
> +	vcpu->run->tdx.flags = 0;
> +	vcpu->run->tdx.nr = TDVMCALL_GET_QUOTE;
> +	vcpu->run->tdx.get_quote.ret = TDVMCALL_STATUS_SUBFUNC_UNSUPPORTED;
> +	vcpu->run->tdx.get_quote.gpa = gpa;
> +	vcpu->run->tdx.get_quote.size = size;
> +
> +	vcpu->arch.complete_userspace_io = tdx_complete_simple;
> +
> +	return 0;
> +}
> +


<snip>

