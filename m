Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817A2403B1B
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 22:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932022; cv=pass; b=E88Mmk+RaCi469IqCTuRLzwBTxvNdwb5oQYpBRHrgaaQg8HbWrLX7KiQAiLCwxaNwK4sZopNRwQQE5k8uhhrKWQT1vcwhkhiM79iuH6SIZiwLI3Ez1vCTAEJJlrGX+gc43dm+1tnCsliRAZSFyepq7xbuA6WYnbFH+i66vzchAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932022; c=relaxed/simple;
	bh=l8gsbB4MNN06wOKbHuGu34rbQhV1QvndhFbTSBKkm+w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYn6pf39dj9pSkZTrm1nvCCK6VGn5Vjc4aY+MeVb8jqqXImuL4OjDCzfTb8KX0jmz4wCx8wPyP9FlslXrIbUt/loMZNh2CmoWVe6K2WV5EW9g5PdN8JuIQRoZPTwAaannxBBKXEAwUmeGSNzmCryrK317ulXVWW3PLIpxuOQci0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zdjf+Ter; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zdjf+Ter"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38101f85591so1882551a91.1
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 15:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784932021; cv=none;
        d=google.com; s=arc-20260327;
        b=ZPKvOHqo3l/eizFqZKmFgwMquiHlXncRM0nXyObsaWwpRmjv4ERG8U9fqPA8AvTlgJ
         ry3iGNSANnPz3UJFv6cu9MBMLe+Ig6RvjATftrTWBYTehZWVbjJs3Al2LKYlFjGUi4DA
         4UmeVQyel8MmmP4WhZ+z53p8BDAUSoGLia2rlDOD8ca16dmuNQc+oCN4rFyg+yqWb0xY
         I4x18CFQ7lkDFi4xrpD4rPvpdmtRAoE3UekAMgmwxKRfYof80fIbLIoEotNDpqq5Gn4F
         TwaUD/DVp0tNzTl72L38/UZR9xh0Sc2/GbYZ6iG+le01ir6YfZ1TPaPTCp1weCPH6loW
         lr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=MetIniAEDCZS1PteAG9tZMTckOLASLfoWHNvNGHv2oM=;
        fh=e3kyGFlNwvy13isKO6JQAB06HTLMPy6UfyNg2FExr1E=;
        b=Y0lPJNxVzZNJ0Zn/Zh2878S7IilzXswRtN7xLi4b06rZgKvCz3uOb/QeDBOwZbUpiw
         gHhv70EVuTfuVdaxGF9if5yMEZ+Nq2rjUSpg5nNi00X4jTX3c8qsdf7bWlKs1hBEU+3Y
         dfJgdXHVBulhnQqUB/V/dobRjqEU/H0S1ts4JISxpvpg8cNfelaXrrGTKaOSgjMnKInE
         gxeTSPgHFq/jleulOf9e5/nmnttMiaAeS5HnL6pYbucOBcmxrhVHnJH3glhPW4nqLem6
         Lz+VMimUD44Y5BOAw3eVtSOR54iH0CNQ3SITCrobOx3/k82uGdUSnemyu7GFs+PbsYca
         H9cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784932021; x=1785536821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MetIniAEDCZS1PteAG9tZMTckOLASLfoWHNvNGHv2oM=;
        b=Zdjf+TerLDEZa5KjKalpyEmlkfSaxRKzM/VYhu09IFoUy70JDKp6auLP4XsOE17HbO
         13X/K+MlcJJtY48bOO8RSuZTS/VkmhGdwacDmh6F6SFT/quF/HjkAjPbSoEjBbxoWirM
         rr54FPB4zYcGM2rJwJNeHlO7AwEFwxMxr4uKVHiwIS1/dnBfyc6Pzn+0b1D+TDCYcchE
         OxXViXJv7VQBzNP8YsjGaFi8UHro48StuuEyhBbglXiMt2BElrpTDzG4C6AA4hRAvknU
         5DXUhdrloL7lvyiQsGXAhBZ97r724YgiG8XChZDVDHzvlJxFfOWzzGEy4+TaI1o9LXkP
         igtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784932021; x=1785536821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MetIniAEDCZS1PteAG9tZMTckOLASLfoWHNvNGHv2oM=;
        b=anWWu4uI3E5/Zh12Qk7Yx9ACl96iZghxxDhnedPTrZ1plpymR6vBmAd0RAkY6VPqM0
         el3eP/nmKqXdBuY9LUFnRzlkp5PONWcKv03OHMlVN3ORhB6fp4HwmYCNicLwOuC4yr3e
         aWqmOLVOKjf52vtsZT8kaL7hInR9iYOxjcsJ0LJ2N9OqyFOu6o9VXLJZ+kP2aG2nd6PN
         faHz46fNwopxplyW+3dnHZbPYy1oev/dl8mP8I318biUFe1m2Zq89XFeSUqL/LVnkxSU
         NhlvFnVM4CExDdiDSWI3j1TKjxD+8E8nK7icSjHLeZGVGBYbbc+wM99wVzBApy+iUoWR
         K3tQ==
X-Gm-Message-State: AOJu0YwodqY3VNYdUcQ+Hli1WKJIF3sGAu1r8DGnlWtr8PIoby9VtYoV
	FTXRWWd8YbIqhVbBGR0AfCHpICmexrVQvDWuLkOp6qlIh1rLsw7D19HIt1Uav1Ex4lekT0V7qam
	n8eryNHJioD1HRd3clSWqkfYEKTIkLlP4Zo6ytcJVJI1Ap05oC6AtPkmNYOg=
X-Gm-Gg: AR+sD10FX232xoS9W8e0PYZ0FxqJ4GXKw7pTJSuNzoQvTKfYORt5pvWzn5wunRjryfe
	2TyJtgdhYwGcvaw459XyqkT1OIdKUHiSbBtsGu4XaaWQt8a9G+CzmaOKTNb+LvoFt7TvV/gjbmT
	fsgyICJH8rXoOkJin7WmK1iqEqrZ2nKUKdn6Hep/EWjFAc2o4TV2cBecxZfOVLh0ohN8D9IFcpG
	f+zHjuqi2z96+GuBeMEPOYeoSiH3IwjDEjon3dZntuMz0kUCspiwjaLlzduKiUJRGxKXz+T3Ety
	vuidym8HG/fopusZoPDhSetDjOT/+WOXhzJzDRJuhzZbb16WV9Nx5a+DSQ==
X-Received: by 2002:a17:90b:53c4:b0:38f:a81:15b1 with SMTP id
 98e67ed59e1d1-38f1f121dfdmr2263760a91.19.1784932020101; Fri, 24 Jul 2026
 15:27:00 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 15:26:59 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 15:26:59 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <affe09f7-31bd-4d86-906c-9c6f92eb903a@intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-24-9d2959357853@google.com>
 <20260619005856.09DD81F000E9@smtp.kernel.org> <CAEvNRgE6iKBhMYM64rgvuVEOvAFyNoryzpjTtSQRf5TcrLTepA@mail.gmail.com>
 <affe09f7-31bd-4d86-906c-9c6f92eb903a@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 15:26:59 -0700
X-Gm-Features: AUfX_mzvttvkeqF-juQumTmgnDd1Lckidkf3twfrA-bvzjcL5NrRUSAmvOW-w8Y
Message-ID: <CAEvNRgEapm67HO3VvK7ZkXy7JFrs06A6SbJGPua-nDO7pScNfw@mail.gmail.com>
Subject: Re: [PATCH v8 24/46] KVM: guest_memfd: Make in-place conversion the default
To: Xiaoyao Li <xiaoyao.li@intel.com>, sashiko-reviews@lists.linux.dev, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 6/25/2026 7:47 AM, Ackerley Tng wrote:
>> sashiko-bot@kernel.org writes:
>>
>>> Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
>>> - [Medium] Unprivileged userspace can trigger a WARN_ON_ONCE if the hos=
t administrator misconfigures a module parameter.
>>> --
>>>
>>> commit bf8cb04a544d7b8235d73034e0febf195ab335c3
>>> Author: Ackerley Tng <ackerleytng@google.com>
>>>
>>> KVM: guest_memfd: Make in-place conversion the default
>>>
>>> This commit makes in-place conversion the default when the architecture
>>> supports private memory. It introduces a module parameter to override t=
he
>>> default and adds a warning in the CoCo VM memory population path if in-=
place
>>> conversion is disabled without enabling per-VM memory attributes.
>>>
>>>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>>>> index 86c9f5b0863cb..5cb73543c03c8 100644
>>>> --- a/virt/kvm/guest_memfd.c
>>>> +++ b/virt/kvm/guest_memfd.c
>>>> @@ -1193,10 +1193,15 @@ static bool kvm_gmem_range_is_private(struct f=
ile *file, pgoff_t index,
>>>>   {
>>>>   	struct maple_tree *mt =3D &GMEM_I(file_inode(file))->attributes;
>>>>
>>>> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>>>>   	if (!gmem_in_place_conversion)
>>>>   		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages=
,
>>>>   							  KVM_MEMORY_ATTRIBUTE_PRIVATE,
>>>>   							  KVM_MEMORY_ATTRIBUTE_PRIVATE);
>>>> +#else
>>>> +	if (WARN_ON_ONCE(!gmem_in_place_conversion))
>>>> +		return false;
>>>> +#endif
>>>
>>> [Severity: Medium]
>>> Could this WARN_ON_ONCE() be triggered by unprivileged userspace if the
>>> administrator misconfigures the module parameter?
>>>
>>> If the system administrator sets kvm.gmem_in_place_conversion=3D0 on a =
kernel
>>> compiled without CONFIG_KVM_VM_MEMORY_ATTRIBUTES, it appears this warni=
ng can
>>> be reached from an unprivileged ioctl path calling kvm_gmem_populate().
>>>
>>> Since an unprivileged user creating a CoCo VM can intentionally trigger=
 this
>>> warning, could this act as a host-side denial of service on systems con=
figured
>>> with panic_on_warn=3D1?
>>>
>>> Would it be better to convert this to a pr_warn_once()
>>
>> Sean, what do you think of using pr_warn_once()?
>
> How about don't expose the module param when
> CONFIG_KVM_VM_MEMORY_ATTRIBUTES=3Dn? something like:
>
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -103,7 +103,9 @@ module_param(allow_unsafe_mappings, bool, 0444);
>
>   #ifdef kvm_arch_has_private_mem
>   bool __ro_after_init gmem_in_place_conversion =3D
> !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES);
> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>   module_param(gmem_in_place_conversion, bool, 0444);
> +#endif
>   EXPORT_SYMBOL_FOR_KVM_INTERNAL(gmem_in_place_conversion);
>   #endif
>

I think this is a great idea, please check for this in v9!

>
>>> or perhaps validate the
>>> module parameter at initialization time?
>>
>> I thought about this too, but didn't want to move it to initialization
>> time because this (populate) is probably the first time the kernel
>> knows for sure something is used weirdly.
>>
>> Like, perhaps the admin did compile without
>> CONFIG_KVM_VM_MEMORY_ATTRIBUTES and also set gmem_in_place_conversion=3D=
0
>> but wants to use the host only for non-CoCo VMs and hence doesn't need a
>> warning, idk.
>>
>>>
>>> --
>>> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-gmem-i=
nplace-conversion-v8-0-9d2959357853@google.com?part=3D24
>>
