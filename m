Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794346785;
	b=ClWOTgPnqEH3x0j7+R1YIGZYTS0EzKxIoI0aGJGrSedmwlvRlkYDz30Q6Efg2Isqtlb8
	 /l0KkjdHTcCahll1KXPzy1saWLUeU7RhAZGZ5U3C1TWkWbek1ILQD7y3cU7cGX1nZM1Jd
	 +dPVUTI//Y3TjkyPYX7TsaaaHAMfVZdULk+PWfP5iy9odpmV3mn2HgekYckJF0cld327J
	 /mp8OzQcw+d/WwkNEWYoHJH+jb+5TY7EKLvq6ojxRs8rZASj228/9M2kjpbFGFnym3MY8
	 HcGXz5pvppXoBzbTbKOCBNlcoR+aB73OU6UVWen76tshE+4hMb/L5T7FE1moFxq15LQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=iE/aw4N49+XkvXz5BpRtqkYQEcfxLRfryXdyEysnhdM=;
	b=w0hKSSII1H/kV/rtlAeBwPKVTd+D/vT26H9RSjsM+cQoV+oxm3PHBphXs5+E6M0ONNB0
	 9noXBcxAEmBpqJO5L08KDNtCiTRcCWVDWSWFPYDcFa7+HbouY1cpygKwedPmUZh/BTRCz
	 sDqr5VyWAaUnjA2za+/OlEo8rTAhrp0Fu32ajQcyINEFsvHrDx+GAgbzQvC/YvVnqW91X
	 IdzGFLGtenjfsZbrPMs2Y92CCGZhmEp58OuQSTebB0YqnBaaH0IX14MvUqBG+1D5M5jOd
	 wQ5QPQJf9sM6xnztJp9b3weSlbkhUrq031ticjhG7v+/+WkbfWU2B/kTtZhaxCT0VYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=H+ckaDOt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080BA606A326
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 21:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 080BA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=H+ckaDOt
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9440304604aso267599785a.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 13:39:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794346784; cv=none;
        d=google.com; s=arc-20260327;
        b=E56ny5pDpOwZZNlrb+el05Wj1E1JP7r2Km7aA9x5V0McySGv/gnz4g2dfWS3Zs1lAl
         sY35PcS7qqskiZ9A6ELk6yrt7PGb+TErGsJjVsIHaLz0qa8EORA4rCfLN/3/tm3aUDQK
         hBVGSYGp32YG4QLHPDQxo2fADwXUbGTA/n7q6G1OpGA+gbg7LzzwdWz7lI7+sF62ITjl
         gXEVphuPqxvi2AqKwqcWkXPTQHykHSN9PDlNHMhHpUWce5HfizP2I4OcQufmtpcyCMHA
         qo17RV50zeDQYzJ/84Eod2Ql0itm8Q/7EnRRpoiJp211k8B2A2yJddWzjWs3teLdUjTd
         +GiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=iE/aw4N49+XkvXz5BpRtqkYQEcfxLRfryXdyEysnhdM=;
        fh=LYJv460e8gEfpZEscGwkn4BVujR4JKi7AMSryzh1T+Y=;
        b=Xo9d2b+y9Gq5SQCqbVsmWU5YE+6H9esctp4NsBa3EELEh+LQfuhCxrYifBDWQ7MSMz
         BRDqgpi4yxR8qVMsq2ljgGWQN4bLcBF/jM7stT08SB9CBVvpPBz9uA4UE6+aV8GTPuT5
         X3gNo9rTtrT+qEudGuuPQjOX+X9TMpNm/ax6jZ3CnF2bvH967V0JsvpMTuqdjqnuNZy4
         8gQOmQrZfmbZ1Q9r5/Dd09tDhtx97MFt0PEX95nKaCO8njEibcAGYqZxC6e17SdtRa5j
         V/0J2Ww6Rkg0fJ+W+aR30Gx0F+K3bpZsLTlKzlAP+d98vEbozcXfBbtPfJVA7bcC/CLS
         SZFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794346784; x=1794951584; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iE/aw4N49+XkvXz5BpRtqkYQEcfxLRfryXdyEysnhdM=;
        b=H+ckaDOtIOCnhx/jrqwxkuv0aBI9KiHdzFKcnxZzU+YavdoHOOF9T5gZQo/BKGIJd6
         vCJnxtEyU1t8zXCF3zy+dayh8XujIc/IDqGWgWoCnFXN+9nfBJKvyCxGiciUfGkS2rp5
         GkwFHqpBAqPv88LVBaKM29pKQ2NHdr7fWYPMlYuj9M9RjNd1yT7GkteG0UXzt0nebfjV
         AH03p3zKot1FGaLx5ZPgGcPWpjOhVvnAgyO0lQNfm8L++CW2G81vD9mpYU9EgA2nEkbU
         OoZe9O/RcFH4+xgWiH4r4R6urcB+QQiMnBrRLf8CLR6hcUkikZCiBALj+XhMgQsgGAvY
         a6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794346784; x=1794951584;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iE/aw4N49+XkvXz5BpRtqkYQEcfxLRfryXdyEysnhdM=;
        b=V5vuEtJsJSnUnxjCxFc2WrmfdmVo7dGF0sKvgNtHGLF390Z7c58LnBxOk00aO3ejwx
         +jTUloJJueFv7e0b2L2X8cRf6BVmnhv+WUBI6uG1izJoFgOy/7OUso50qH3LQlfbVuLY
         c0+3C3c/A4A5gcYOteB10csmRMZ7RpxzudYhQXuYE9dikhXIhtYJ/9+q283wDiJZJ/cE
         3N99o9z+lY4lPs15d9pKg20lARJh7W/JcfzgwAg/awH5ubSYyVeCyNpRa9cGhrHjB2v+
         kO9QpX0rTMtFCxfIwGS81VZIP/nssd5YmOMi+If6WANSg+O976uj2W4kk5JkmsLilMIo
         5Q3A==
X-Forwarded-Encrypted: i=1; AL+hErF0WrD2c9GC0F+F+i28KzFa17pZ+vcAlrwU9kPKZ6sQkL6GfZDoeLv53dr486clathaHwo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+awuRbvgNgcvIvEEerKj3o90R0XUorIkhL3mL7Y872lmV2cRkT
	TTLLNPijF9aGhrenMFXAJrPRqpGUE4C0JAnjN9JI4mRSLe7FG9CKh+YAQspoWSnQJUMLizMTsXq
	zWWZottKoS5WGvKh9p7qTisAlVu3lBi8dK+KEp6Vk
X-Gm-Gg: AYBFou2TLxN0jSIFSyY2ZRMzUijO0K8A5lKdsJwyt/FKc6JvtE25ojngI9BEKzjI+mr
	Nr1+9cf25KqrZSgJ4wzTTChs01CUK89y46w2i93I+tOHw3nIvx7ksVSyJ/wSIrg/1a9jw2mquA9
	6OllYQEhMLmJTNmzZEGcIgQD6+Fvn/AuUPrHZMPNNv2NoQHIf1hnNMYk735LQ5JMtVm7XGQvUEA
	x9CjX4fbGQNpyhS3PSPkmScgpmYyc/CRmgiRnZBc5zx5v0IXHwkFrSoCCDpjXSBObBQnznTd3ux
	FjOjWESnboCGF186RpwmsvwKwnQ5Z9vWKWgt/5jvHsdZS2MNEbRklTgoaD0yoewGEDKzz1Ht0T8
	phrimj2g/M3LsHrpSEiSsEAKts2ZseHAcWE3QUAJmzv0lS62YLzoiaG99VAsfU0YRxskdnbTDAF
	fZKlq8sSU9xmGC+d6DLfsDtrI=
X-Received: by 2002:a05:620a:6cc8:b0:93e:c12d:4ec7 with SMTP id
 af79cd13be357-947ae8caf53mr124925085a.39.1794346783277; Tue, 10 Nov 2026
 13:39:43 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Nov 2026 13:39:41 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <avNpDjWxrgThIUXE@seanjc-mac.roam.internal>
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
 <20261105-tdx-selftests-v16-3-2024e8fa517a@google.com> <CAEvNRgHKQVLVza1dw9-OrDAt4-b6zbhx4T64D421sqb2MPWs0w@mail.gmail.com>
 <avNpDjWxrgThIUXE@seanjc-mac.roam.internal>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 10 Nov 2026 13:39:41 -0800
X-Gm-Features: AclHuK_rifyMl6fGwEhJizkpiNdLB8JMLlwRf05wofhoaOCF7vOAUu20dn_gm7k
Message-ID: <CAEvNRgF+-12qeZQyrHb4Z8MWOjOGEYQj1hebnxs2gC9nY+M5RA@mail.gmail.com>
Subject: Re: [PATCH v16 03/20] KVM: selftests: Initialize the TDX VM
To: Sean Christopherson <seanjc@google.com>
Cc: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, Shuah Khan <shuah@kernel.org>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Oliver Upton <oupton@kernel.org>, 
	Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Nov 09, 2026, Ackerley Tng wrote:
>> Lisa Wang <wyihan@google.com> writes:
>> > +static const struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
>> > +{
>> > +	static struct kvm_tdx_capabilities *tdx_cap;
>> > +	int nr_cpuid_configs = 4;
>> > +	int rc = -1;
>> > +	int i;
>> > +
>> > +	if (tdx_cap)
>> > +		return tdx_cap;
>> > +
>> > +	do {
>> > +		nr_cpuid_configs *= 2;
>> > +
>> > +		tdx_cap = realloc(tdx_cap, sizeof(*tdx_cap) +
>> > +					   (sizeof(struct kvm_cpuid_entry2) * nr_cpuid_configs));
>>
>> Would be nice if struct_size() could be used here instead of manual
>> calculation of the size. Same below.
>
> ...
>
>> > +void tdx_init_vm(struct kvm_vm *vm)
>> > +{
>> > +	struct kvm_tdx_init_vm *init_vm;
>> > +	const struct kvm_cpuid2 *tmp;
>> > +
>> > +	tmp = kvm_get_supported_cpuid();
>> > +
>> > +	init_vm = calloc(1, sizeof(*init_vm) +
>> > +			 sizeof(init_vm->cpuid.entries[0]) * tmp->nent);
>>
>> Would it be possible to use struct_size() here?
>> Or perhaps kvm_cpuid2_size(tmp->nent)?
>>
>> > +	TEST_ASSERT(init_vm, "init_vm allocation failed");
>> > +
>> > +	memcpy(&init_vm->cpuid, tmp, kvm_cpuid2_size(tmp->nent));
>> > +	init_vm->cpuid.padding = 0;
>> > +	tdx_filter_cpuid(vm, &init_vm->cpuid);
>>
>> How about something like this?
>>
>> 1. Query TDX capabilities first to get tdx_cap->cpuid.nent (let's say N).
>> 2. Allocate init_vm sized for at most N entries, since the filtered
>>    result can never exceed TDX's supported CPUID set.
>> 3. Iterate over the TDX CPUID capabilities, look each one up in
>>    kvm_get_supported_cpuid(), and append matching, masked entries
>>    directly into init_vm->cpuid.entries.
>>
>> This would avoid the memcpy and all the memmoves, though this works
>> as-is. Just an optimization/different perspective.
>
> At this point, I'll do minimial fixup when applying, e.g. if switching to
> struct_size() Just Works.  But I don't want to do anything more invasive at this
> point so that we can get TDX selftests landed asap.  To be clear, I'm not opposed
> to more cleanups, I just want to do them on top.

Good to know that this series is ready for Sean's apply + small
fixes. Don't worry about my suggestions on refactoring.

Sean, for this series, is the next step to wait for the merge to
kvm-x86/coco? Do you need anything else from us?
