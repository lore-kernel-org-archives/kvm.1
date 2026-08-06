Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FE9274FD1
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 13:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023209; cv=none; b=juTVQW6KDjmfv0z7zLwakHLJvdXflmZq6tXkSVUtb4lhMJDpb0RmBZFv0qTWax9ieZHsB/VLTsPENWvTaxUv8BVTNeL1l//mtOBAhfeft9bqyl0tIDUXc7DK6+KlP7ysEbuafFuuSO5p5Ocnr0drRIFMeLoi/juk+8Fosd1cIm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023209; c=relaxed/simple;
	bh=eqJ7V9HEqhuX1egyQNA0z+ZN2aVQaW7md1oiro/iJs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmbBm2+zk2sD0k/kKLEg/h7sXKgjAU+romc2Db9QXxyewccV/mA/Nf6w6EouLAtniG5KL7zjhpidadRAf6tql1UgtZWKIGDDc0na+uWXvOBxqiZ7VJqBBdJtKdbZgFL62H7aFNn/hfqtuhFbHfzURfysZxidH5MLP1Kf419o4Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aEX6w46G; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aEX6w46G"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4954afac04bso24616425e9.0
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 06:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786023203; x=1786628003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aAbzrtK1BVcaf7lpt2UNBYq7bb5HfmvZs4b+FrQTjPU=;
        b=aEX6w46G2I+x44GRtAya4qIYXRqqNz0G0v2NIqfOG/Ln0wJvyT7olZXMqnPCIWdyGt
         I3Fg+j6hM7POquXRKGGrej1/M0Gcx3jFDjBs+UO1DHjAkbGpK8m83wjKWWZYKL2NOIc2
         NPKbTihKTGtoMSyHOB80+KtyOk9SgFV2SQ40UdvYE5BIHt9oKQJThe58h7wl+lE9T5PQ
         Oq8QvRzLRBxsp4XJ9EpRp+EyV+jh3cyJxCR1m/+0dH9ilE7I/AKkEECdZfOieESwF84o
         Iq3OpUsySdJvajkFqLxhAcweFiqoPZbfH9XU/72jDLvX8O0Y+tT8giqd+2n+es20l+Ne
         QRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786023203; x=1786628003;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aAbzrtK1BVcaf7lpt2UNBYq7bb5HfmvZs4b+FrQTjPU=;
        b=ry5afePJVhiAbdEEskp1RBgFlKhG7VfYTvF51Lp0LX9naSbwxO10LBtfQ813NndDpG
         oCQoi/iE2sHMQEntE6JTHandtrH1vy5bA2pEAk9crNB9cPtTJlOBGdgNT4hjc0RpGTH+
         Ds6vkipyPufMoKeOx4w3LQ3Ap9njz37DGEBXNzRIUCI3xyUJFVmLrlpZRiQ3KuPO1U44
         G4OIh8YwboXlZSZnjftQDnmi8q5YmI3Vu1wCojZqqOm/NIsCZw5jDnXxpHMCAGJhREcq
         lC2ixxEtfLLJjKcSD0zpozpFxAJQ4U9pbriIxlYN58eV4b4cMqV5QfafGmJBhUMMRy1V
         DlbA==
X-Forwarded-Encrypted: i=1; AHgh+RokXBKku2GCrk3wg3jL31kTc05Oq9M2NDxl/otijj56FTE5VtpNFDwVml6koNTzUkGJnQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7riGNuZ4XC+a4Q4mm4ZCLGpCk0B6qyKoBue543vbH4jidbOKW
	XWgzVYHNX4dY3zBJcrDN3oDXyCyEq9BVZZAUlC5JHT826lJzEuRpLb6jqh/Rs9ONPqU=
X-Gm-Gg: AR+sD1355E+72hNT75HKp0LNcEgMNN6Hcmpc5QgZ7sj+sj20isukVPbKp1H4iQhesTL
	oQwyJ/ZlK8uYpyNfbekN0k9n0H2fqiS4VSIwk4nIt/qZIAjJenX/NwhmsR4kL7GlU8khhhgVcJX
	lwLEsuhpJ1EXOF25KCgpUqEz1Kmuue6588/tc8tML01OS7VLVCL0UFH7CKSP4lsbpUGBCzTadgE
	WkcBzLrd6ZhvVtoLLy6o86Hy6ThhH7skInL7PuHYxbOoLDjripPK7FUQtke/b/VeAfwIXVNvDDS
	pL88V+YCUZENu+yxDFvwinfOifZ8jIpeoHVVoSv14GeSltbpWvx8+inKOBf+8qLTFhlHT5J23xk
	AsiaiA2ax9hyzv5QLHTQsJEXPk0862HGGjS+5BWKvkPIE4yNEmxRyCwx5OVrtN1zgJQB3y9l0cA
	tm3Co2Gr9gD14BhvFv382H8KKClRwc906obWQtUZTfX7rTUss7YT38T5gZiq2PTg==
X-Received: by 2002:a05:600c:a21b:b0:495:4e89:3f30 with SMTP id 5b1f17b1804b1-4994e7c5e49mr154753255e9.15.1786023203426;
        Thu, 06 Aug 2026 06:33:23 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.206.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49954246f9dsm74934255e9.15.2026.08.06.06.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 06:33:23 -0700 (PDT)
Message-ID: <82482276-0140-4d90-a983-fdfc5bc2e4a5@suse.com>
Date: Thu, 6 Aug 2026 16:33:20 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: TDX: Enable Notify VM exit
To: Xiaoyao Li <xiaoyao.li@intel.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260805031257.1844914-1-xiaoyao.li@intel.com>
 <20260805031257.1844914-2-xiaoyao.li@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260805031257.1844914-2-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/5/26 06:12, Xiaoyao Li wrote:
> Enable Notify VM exit functionality for TDX guests.
> 
> Notify VM exit is an existing feature supported by KVM. Userspace can
> enable Notify VM exit through KVM_CAP_X86_NOTIFY_VMEXIT when it's
> reported as supported. However, KVM reports the support of this CAP just
> based on the hardware capability but doesn't differentiate between VMX
> and TDX. This leads to the issue that userspace can enable this cap for
> TDX guests without getting an error, but the feature is not actually
> enabled because KVM doesn't call the TDX module API to program the
> relevant TD VMCS fields.
> 
> Enable Notify VM exit for TDX guests by:
> 
>    - Invoking TDX module API calls to set NOTIFY_VM_EXITING and Notify
>      Window in TD VMCS. It's done in tdx_vcpu_init() where other TD VMCS
>      bits are set. Since TDX vCPU cannot be reset, it only needs to be
>      configured once when initializing the TDX vCPU.
> 
>    - Adding corresponding exit handler for TDX Notify VM Exit.


nit: That feature is completely misnamed in the kernel. It should be 
instruction timeout (as is in the SDM). Please reword the changelog to 
refer to the name of the features as they are in the SDM. I.e if you 
search for NOTIFY_VMEXIT or NOTIFY_WINDOW absolutely nothing can be 
found in the SDM. The changelog should ideally mention both - SDM's 
nomenclature and linux's nomenclature.
> 
> Note, Notify VM exit can happen when executing the IRET instruction. If
> the IRET unblocks the NMI blocking state, bit 12 of the exit qualification
> is set. In this case, the VMM needs to restore the "blocked by NMI" state
> when it decides to re-enter the guest. For TDX, KVM cannot manage the
> GUEST_INTERRUPTIBILITY_INFO and it's TDX module's responsibility to
> handle it.
> 
> Fixes: 161d34609f9b ("KVM: TDX: Make TDX VM type supported")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> The enabling of Notify VM exit was missed in the initial upstreaming of
> TDX base support. We suppose the patch needs to be backported to
> stable kernels. So, the cc stable is added.
> ---
>   arch/x86/kvm/vmx/tdx.c | 10 ++++++++++
>   arch/x86/kvm/vmx/vmx.c | 23 +++++++++++++++--------
>   arch/x86/kvm/vmx/vmx.h |  1 +
>   3 files changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 545b03d9d10b..cdc0d24657ac 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -2129,6 +2129,9 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
>   		 * - If it's not an MSMI, no need to do anything here.
>   		 */
>   		return 1;
> +	case EXIT_REASON_NOTIFY:
> +		/* NMI blocking state is handled by TDX module */
> +		return __handle_notify(vcpu, false);

I'd rather there be a private handle_tdx_notify function in tdx.c than 
exposing __handle_notify and introducing the boolean. This is needed 
because the TDX module handles the NMI unblocking, so let's keep the 
implementation specific to tdx.

<snip>
