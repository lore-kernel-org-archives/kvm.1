Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C7246AA89
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647950; cv=none; b=PyLklSu28kUAOEoWJu34l9HkTTDsDXceQKBJ72Ts1EY7A8HyCmyUWkIqzOgl0CgonGt/Q24Kh2sgzcPpx4yJsxT5JG3eC/VF1z6M8NnhYbc9BaN/d/cwnUyfgZcoZk46+im+DgSe5E41nNXe9IfJbatA6ChcxOAPyfUpbK0lsto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647950; c=relaxed/simple;
	bh=fnGcqlp+PIpDwV5UTCN1K4XItWzBa2mzQPtdzrj7IIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aI9hL+ASnGMGj/axwxza0RiVYeuqRmCqI86YfjpXCVXfWQNOEbbjfASyffq4qEZUyWjQIjqB4ozhDDe05gb4tdRXf7+T1jjqn/tAkUXItWuJib5NhdDQ7eyMq/VKWgeyODp1xfW1p7Q+NI7ScacRE/8TnrK3JRTrC/XD57dT7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=epc70d9b; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="epc70d9b"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4720f3bf164so2859343f8f.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784647946; x=1785252746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2DC9XvB+0REkpBk4lVoyAb+GKqX4RxR1iS8G5MlGtxM=;
        b=epc70d9bVkB695AaWq021YBN32tL/OsOgRovmnAhGyF9+3PZ46tEKmVp9uLx6kK3Cl
         sZY68GTl4qjMdJDI6W50Ser/VGFBmYYt85dydNGf6IrHhbfavPHgGR8sLeTUoiAyunzq
         gRXZQvgWzfR0b4AInArXL/7N5BxqXbMZ0vfpLoEH4OZs9tgMSeVqgQGvoIZ68w703+1C
         nRZUiL75QRyN+bGbltoRLdngYmu6qMr9xia0DDd9qsQCh/0v1NBsnqQ9dfjmT+hUdPam
         r3NO9IN85IGgH5DMGpYFWreTG3DCsSds1ih2gBx7OQJMOj43sBvvGlP9UxxH7kp+BVPY
         vpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784647946; x=1785252746;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2DC9XvB+0REkpBk4lVoyAb+GKqX4RxR1iS8G5MlGtxM=;
        b=RNY3WOd+OdqolQMdsNDqzkg4OtWqFtWHMW0h0WFCNuagG37iMlt9Rh9OuIZOH/LjXy
         KTGWgl0KsU+m0XlqWd9gEZgcPP72Sdwb9PuMsK01f0cF8NEaqb506vuH418dijFUNLyO
         xH+I9KE8VrB6Xw1KtYNbCA4xPBpbpPtBpLWPMTRIi2HQun9GCb5YYyKp/pPWkoZBtn7v
         kB3IBl1HJhopsx6BOVmLBapA82l8ocXSTGXLW44np/5W2S4AhZTAJ9ilc4DObbuCuRW0
         e/BlHGmUeEIKWQyzFMwQlWoKg0iSodsgfBLODWja5uNM2FA0xPyEWuGsPg2w7cCqlAxI
         Z2zA==
X-Forwarded-Encrypted: i=1; AHgh+RoHdvmt8RA/sri58BdaEG4ougwjHIhzzwu4PpC3drHE/gcXyIlMRDpJI9y3El4JVEPFaHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCgc5VTh/7tkj92t+T+7b4Zx/6aUbIhbSmTK21g7FEezqsKqnQ
	l2GoOLdVglVeatqEcJyVrMM1rJV/9INLg36dHWvupMhPT5nib5N5sKUy2hM1lqp96u0=
X-Gm-Gg: AR+sD11xtDlG33B7x1rKuJrBBsT0R9ZD7gbl1ga8tY7qn5dmfsI8oEgswnQjSSgRC2r
	G/qxzZHcgcJ8SsZqGEzTTJKQ6A/qj1zc1ju/EpyW58NwfkoD6U+oQIoHiFXYvOAY4QkHaI9HJL0
	0+dFviyGxhfr713kTJ3C1nN/ZtBlUbbFMN7dvoGRwuX04Bewa9C0vLVN0JbdWhKdnMvs4ERF5ii
	kVhibkr2FXJ8jk9IWfNE6asaCyoKiTVwtLoSPegDxFZOsu3K3+bhja5Zl3WNJkg022NIVatHQEm
	YzBT9We26ad9P2VYJ4ddmjr4dJeDRmNhICuzFdPlYl937NNsVr48h6BQxItLW7ApVj344BKFXE8
	GSoYr9SNayTAe+xSYd58Y9pitf7ruzPjbZ1C0z7i5ZtkP5Egk3JjRspbeQExGZUxyt4sTUO/6+a
	RyWZ/1
X-Received: by 2002:a05:6000:985:b0:47d:f508:3364 with SMTP id ffacd0b85a97d-47f840c9494mr147362f8f.15.1784647945778;
        Tue, 21 Jul 2026 08:32:25 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.206.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e52aa4sm40851079f8f.10.2026.07.21.08.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 08:32:25 -0700 (PDT)
Message-ID: <615f6cad-99c6-4872-adf8-f7b45a660cc7@suse.com>
Date: Tue, 21 Jul 2026 18:32:22 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/11] x86/virt/tdx: Handle multiple callers in
 tdx_pamt_get/put()
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, bp@alien8.de,
 dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, pbonzini@redhat.com,
 seanjc@google.com, tglx@kernel.org, vannapurve@google.com, x86@kernel.org,
 chao.gao@intel.com, yan.y.zhao@intel.com, kai.huang@intel.com,
 tony.lindgren@linux.intel.com, binbin.wu@intel.com
Cc: Binbin Wu <binbin.wu@linux.intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
 <20260718014500.2231262-6-rick.p.edgecombe@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260718014500.2231262-6-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/26 04:44, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> tdx_pamt_get()/tdx_pamt_put() unconditionally add or remove Dynamic PAMT
> backing for the 2MB region covering the passed page. However, multiple
> callers can add or remove 4KB pages that fall within the same 2MB region
> and in that scenario only a single PAMT entry is required.
> 
> Make the helpers handle only adding/removing Dynamic PAMT backing when
> required, by refcounting each 2MB range. Gate the actual Dynamic PAMT add
> and remove on refcount transitions (0->1 and 1->0). Serialize the refcount
> check and SEAMCALL with a global spinlock so the read-decide-act sequence
> is atomic. This also avoids TDX module BUSY errors, as the Dynamic PAMT add
> and remove SEAMCALLs take internal TDX module locks for the 2MB ranges of
> the specified PFN and the PAMT page pair PFNs. So simultaneous attempts on
> the same 2MB ranges of the PFNs would otherwise encounter an error, which
> would not be handleable in the put case.
> 
> The lock is global and heavyweight. Use simple conditional logic to keep
> correctness obvious. This will be optimized in a later change.
> 
> The pamt_refcounts[] are atomic_t's. They do not strictly need to be
> because all access is protected by pamt_lock. The overhead of an atomic_t
> in this situation is minuscule compared to the global lock. Leave the
> atomic_t in place to enable future optimization with minimal churn.
> 
> AI was used under supervision to collect/apply feedback, split patches,
> review code and workshop logs.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
