Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC27D470133
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784707167; cv=none; b=fBY7wbmIwgK+ZTs+2XTeM/a2fJc0c7PdHbXIHgcpWos9MHR+qrRVtFapTvkx+NmZl+KwccZsIFYpltW0aScD9CbVVjeDIh9iFer18oRBPilLtahCtq4IGHP3QsMzxpu4trsf5DxHvBWWshDm9cmn02l2uuDnQkSCZZz4QLKn1GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784707167; c=relaxed/simple;
	bh=L1ZlHTw+wfSWt/JfEcI4TxNzRMBbmHZ7QGPCEnXC6/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAWjJBIM5KYd4+6/xuqocvsn0QYvSNruVyDJZ5c1JPgGPGk5LrjnHxhO1WXhnn7w43B/9FPG1tiLClXx3mZVanwE+Rk7rRgQjrU0giGZG0Agyx2ioSUExn/4t1uh5tiRjxihsvhDHxrA77GCT7hYZ56kj4IGs6KBqj7I4kRBmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P/DVsH1x; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P/DVsH1x"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so25168075e9.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 00:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784707164; x=1785311964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Iq0O2sSgzi6ReiR/HqVVmK6buuu0zFra1jDt9JKJi0A=;
        b=P/DVsH1xSDALZbVU8L6HpPkHM6zIV4Ct320HfDGwWBzGP1bii3aGRqXObKabGuNtdT
         Zp4UbQO9tqwkJKOSYBNYL01rfqI7b3OFxIfG16bKuJWAUrhQIIETckDWhmUWBNCT74eV
         cpUzrRFp9ZWzIYRV/OeUbs/2nB1MlejATlavnlwoNJHkfKMeGYEsqLOylTyUph9zzyeu
         8a2Pl3zgx5lorkMz/MdOJB5Ygn4SmE8TNmBr8CoSWgkza1eZk72mZPEZ9VcYbEOxOapU
         n4dZxCTQezhlTSjaelu/v9R6ns++OjeYCl2tXTOudeCTWuzTbRsEBOVV+cTfOT/hFV67
         aavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784707164; x=1785311964;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Iq0O2sSgzi6ReiR/HqVVmK6buuu0zFra1jDt9JKJi0A=;
        b=RFtkLczt3Kc9eSszUfmtvebTSg92p07p21cg3ENQmIiNtN5Lhv8sb48WwyJBwiqEGP
         Vsa3p3HDe2zEwx/RdZlqhv3lS3GQ2pIrMF4f0U1kUN9FRzZtwiHjrLybIcFSOEbd73Tt
         MBJiJdlBOiGshLwEXE/I7ZvAkfQ5lfLRlZrc9Vd2jeH3diSfr7DqxqhH6WoGr1yfZnzT
         nMufSAgAdzmvj27ubsojb2b+EkUlpiK12GG91XjDWgsKisGIMd9JcwVl4GTgquEbxOEl
         uIXKIzMq4ob1m4bR+pAeBHE9drF4YWofkLEaKoTy0tlk7iJQl8Gn6tr/QEpFTZr+y/J6
         nTZA==
X-Forwarded-Encrypted: i=1; AHgh+Rph3Lc0tkv8BAzPUPb7iZDRV4R0fetwvqiUqio7eac7GzuJ+FTlICDlXRkehMGjXVSyoGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzimD1tYunqD2Oa5caItJ7siyqovIJVGQCuAA7u54spAoRSWmGg
	bER+etiQ4Wba19CvpG/FjUOmaIj1PrlXR4QmjBavdmq4UCTT0KotE4XxrVbpONisBdU=
X-Gm-Gg: AR+sD126X/hrtdHPLQisiuBNNva08KI49GGHqnuHsej8cZeWBIu0aR2HbR15kOzZY9/
	h/xKdV1pw9evPH2Ey7eFtfABz+1ncBpZuCoeNcNlK9nM80DRahtuNU7kSbNwY1NmPVyduUkm+20
	X25yIbCWh0NyW+HMFNvOhjmTq1DRzB25UTnp/16IPQf3roZA/C//ik8c8cynDW7roX32LUB5C3X
	rUywoFIaVIwdB5KVJYDEJQ+PcMVjWyzkLQY7Xy2Gc25AI/Q0DrLgIXscvL4D0QdzvqC/3n6duXq
	hYYaP6pRAGGDfX57qqsWbpY/g049u+W+5C0Sfq9ErF611qsAE6o0QsEs4TzQQQnWnoGiMC4VTYb
	5vwL4Xw2/8K4/cPSmMqM9Ur0MJQj2xLpIQhu1cKjVBkH+1EoF3wx2oEAJNxOn4Lz6Kzp61XwboM
	P7YoptGiHJ7nqIb2U=
X-Received: by 2002:a05:600c:8010:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-4956a519015mr28908465e9.16.1784707163859;
        Wed, 22 Jul 2026 00:59:23 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.206.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a6354a3sm79090575e9.10.2026.07.22.00.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 00:59:23 -0700 (PDT)
Message-ID: <9c7c170a-6438-454c-b96e-24aae0c27c9a@suse.com>
Date: Wed, 22 Jul 2026 10:59:21 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/11] KVM: TDX: Allocate PAMT memory for TD and vCPU
 control structures
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, bp@alien8.de,
 dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, pbonzini@redhat.com,
 seanjc@google.com, tglx@kernel.org, vannapurve@google.com, x86@kernel.org,
 chao.gao@intel.com, yan.y.zhao@intel.com, kai.huang@intel.com,
 tony.lindgren@linux.intel.com, binbin.wu@intel.com
Cc: Binbin Wu <binbin.wu@linux.intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
 <20260718014500.2231262-7-rick.p.edgecombe@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260718014500.2231262-7-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/26 04:44, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Use control page helpers for allocating and freeing TD control structures,
> such that these operations can work for Dynamic PAMT.
> 
> The TDX module tracks some state for each page of physical memory that it
> might use. It calls this state the PAMT. It includes separate state for
> each page size a physical page could be utilized at within the TDX module
> (1GB, 2MB, 4KB). In Dynamic PAMT, only the 4KB page size state is
> allocated dynamically. So the kernel must ensure PAMT backing is installed
> for any 4KB page being gifted to the TDX module, and must tear down the
> backing when all associated gifted pages are reclaimed.
> 
> TD scoped control pages (TDR, TDCS) and vCPU scoped control pages (TDVPR,
> TDCX) are all handed to the TDX module at 4KB page size and are therefore
> subject to this requirement. Replace the raw alloc_page()/__free_page()
> calls for these pages with tdx_alloc/free_control_page().
> 
> Switching between special Dynamic PAMT operations or normal page
> alloc/free operations is handled internally in
> tdx_alloc/free_control_page(). So don't check for Dynamic PAMT around these
> calls. Just call them unconditionally. Similarly, drop the NULL checks
> before freeing, as tdx_free_control_page() handles NULL internally.
> 
> No functional change intended when Dynamic PAMT is not in use.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> [sean: handle alloc+free+reclaim in one patch]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [rick: enhance log, reviewing, rebase, with help from AI tooling]
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com> 

Reviewed-by: Nikolay Borisov < nik.borisov@suse.com>
