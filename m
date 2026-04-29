Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1813CE49E
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459019; cv=none; b=bGPv2eevTAInXhvM/3dOqjJxK59L4gElQyUx+VbdO6Kh8KJuBvFmK1p/Zvu65a5v/gkZuyt1BPpXC3KXeGme78B37t+QnWC80InYmQaf2FiO5ovOAA/pvPpOiCEGar67Be78oqY+zwXuUj+U9UcNHM+bqPULoWqSIPj6Yp0JQHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459019; c=relaxed/simple;
	bh=/oOkSzD6qmVsvpsVH9AtHt7dJBZc2mXnlIq7kZZektI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=jVf4wOKzdrNF0wCJ23XVGbpO2PsXmtTulBtkjSuyWRGB/tVbTwfjOH6dxZ7cJKGuUg3mcoXItsOsOgY0omaTELaYutYPTIT1p40quoa8UuitiGMH343lcX6VILYjpOIW0xJGr8AC0lH4GEWUn/LO4KKOC9Cqln0hi+EfZARRVzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9ZAIYPq; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9ZAIYPq"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso6102682f8f.2
        for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 03:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777459015; x=1778063815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a88lVFGd0bTcNDpi0vvKuLvilGml+v2O2rcvl8VmwI0=;
        b=T9ZAIYPqkBrI8o4vQs7lkXaGcAZZ/KN6BWBrATmeNr6SSDOC7owEXslRXlb8PL0O30
         KJoQrtC+/DjmFwWmRVIwNwgOI+N8RtCYhcmSsSA5b+YJyGC8aUt+svYSB93VUyj/CqBe
         vNinq6lDEU8XDXnqBJGccuAD4m4oTynYNDWVDGtZ3kRFBRz8I7VoXX1zZy6na+9P7vzV
         bTKg5Wlj25+mJyYhGA0bARJ2ecS6vICa6incCd2bNw8hZ0LvoZYPJJW3xp3FFmIQ1qHY
         O+0pQklqKVKW8a/rW/szcnKAS2CbMt4mIXSBPofoHuX17igNW/9xmI8hp2HeI1UrhHDI
         FI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777459015; x=1778063815;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a88lVFGd0bTcNDpi0vvKuLvilGml+v2O2rcvl8VmwI0=;
        b=XcRO/tatHhA6johXkrREzTFlAY4LUWjAFmmkDH3Ih7J5TgUqtyUIN2woMGMOR8+uS+
         IEeC+qdzG0vg6Fu64ksH1+pyrKK7B34tfs4WacJ+xc9OMFkFzbiqf5Y75heYj5udamgG
         LYnJKn3u44hhnDSpMC8njXtIKaLnDGw5wj0TdoNvMYGwHTrTv1jC4mV5ySWzKxDfO2oA
         hBdSex6K9Ij3MfR50mr0TYtkI2PmN2AuCo2Xb/kUN+duBPy3nNSvS6KmA0TAwRMz3dyg
         Ks6U0I0upJGJtBJaBc+sXF9/lgvspgEj6SIotMceJljqvalBLAH/pcClRIGSCDTBDHFt
         7Biw==
X-Forwarded-Encrypted: i=1; AFNElJ+TB3ibDf69yS9c8NJCDoXe3NVADYlMaczAu+AmQXrVs7DTBPijB4WobeGEr/WUXOMI9eI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNjL0Wfe6mWiMINpuBkPH6c0eCe2vYjVu6HAunufaURo/DwTkp
	lYnnHjVF8JWiKL/ZJhUZvy0WXnZW9b/waCx2BAG74RWCBpXDvr1gqbj7
X-Gm-Gg: AeBDievy/+ZMdYomE4jFkazssgpbhbZZI9pi7LX5wMlxQm2xSI03jPX0jpzPqhIbyxh
	KeKFRjmQLJgxppbsarERPlY6uiMfo5ftpiHGqk8ZBLIzI7zYR+TfZrYBpUD78GNhi1521mGDVbJ
	ZGSo/JerKfp+wCf4YzWvA5GaEkVWP35zEngpoy4yK86NknQ+KdRrWId7lL03Un5Ti3kRlm8j8CV
	H0dq724G944KNC0O1cGmKXFe17EW30cm/x2wtt17tbDaYMKiHUB+cmYQfKkSxxod11dqyq9q03w
	XI49k8e68iTIhhNByj23fNQcEvBz5/w1ogo/hj4op/2FOMUpzgDxz9P3zSM9cJ4wJ1D5c99UBq2
	0Joikg4aa/kSOFvR1Ue0enxMZz7jWEMrHKNSfu+Hnetg3PYNLLHM2iFGzm7bUQTHD+DtRKyyXVW
	rwF/mkxyuOLN8MawMxyyBJNjJa+pSx1AzYFkNNrCI=
X-Received: by 2002:a05:6000:1884:b0:43e:b0dd:396b with SMTP id ffacd0b85a97d-4464a4470aemr12037851f8f.25.1777459014631;
        Wed, 29 Apr 2026 03:36:54 -0700 (PDT)
Received: from [10.4.211.108] ([15.248.2.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7217c2asm4556829f8f.19.2026.04.29.03.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 03:36:54 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <d56d47ab-1306-4b33-9120-8849a7b33928@xen.org>
Date: Wed, 29 Apr 2026 12:36:52 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86/xen: Add
 KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE
To: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <c855535b4262ecd41f67734d19e8f48a7f014c2a.camel@infradead.org>
Content-Language: en-US
In-Reply-To: <c855535b4262ecd41f67734d19e8f48a7f014c2a.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/04/2026 21:12, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Commit 3617c0ee7decb ("KVM: x86/xen: Only write Xen hypercall page for
> guest writes to MSR") blocked host-initiated writes from triggering the
> Xen hypercall page setup, to fix an SRCU usage violation when the
> hypercall MSR index collides with a real MSR written during vCPU reset.
> 
> However, some VMMs legitimately need to trigger hypercall page setup
> from host context. For example, a VMM may intercept the guest's MSR
> write to track an epoch (for kexec/crash recovery), and then replay the
> write as a host-initiated KVM_SET_MSRS to populate the hypercall page.
> The host_initiated check breaks this use case.
> 
> Add KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE as a new vcpu attribute
> that explicitly invokes kvm_xen_write_hypercall_page() under proper
> locking. This gives userspace a safe interface to trigger hypercall page
> setup without going through the MSR write path, preserving the
> host_initiated defence in depth while restoring the lost functionality.
> 
> Fixes: 3617c0ee7dec ("KVM: x86/xen: Only write Xen hypercall page for guest writes to MSR")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   Documentation/virt/kvm/api.rst                | 11 +++
>   arch/x86/include/uapi/asm/kvm.h               |  3 +
>   arch/x86/kvm/x86.c                            |  3 +-
>   arch/x86/kvm/xen.c                            |  7 ++
>   .../selftests/kvm/x86/xen_vmcall_test.c       | 96 +++++++++++++++++++
>   5 files changed, 119 insertions(+), 1 deletion(-)
> 
Reviewed-by: Paul Durrant <paul@xen.org>

