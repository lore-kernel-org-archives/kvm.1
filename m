Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C540DF59
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 00:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782345949; cv=pass; b=GYkDky7u5e7f1oRyo/0IKLDrBIM+dpHjOP1RyVScKjCOsDl3YYMUf1ZKfKYqB4YKAHKet/ILcJX6Uc1lN7OmVy9eq8Thzw0cKPEajmjIblt4+QvN5rGx1Y2j6S5nEsfVIIbJ5YduGQd3rb9fbLy71slgBIM46AWt20sZu689+Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782345949; c=relaxed/simple;
	bh=Vhp59FnIevSXEEdWsugGzaR2Idu0ffRc20bSQFGQLZc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bhsp5U/5bZjdWrsdhzBo7N6+uTy09WRpAC2HTgmUGwNjTN6BPD4+PUT4m4FUl1/t5blsZtBElTy5iHHkwAw0YPlWnAKNecX4yd10exP51u7mC9skwkv6xaypTJksT8hZvegimEZCL177nFBt2YWavwfyMZ8Hj0u4WdZu5VTCTSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOKPGFlt; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOKPGFlt"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-139a71baa35so4316954c88.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 17:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782345947; cv=none;
        d=google.com; s=arc-20260327;
        b=NFEZKJkzHtDQusJNw00RyEfn2BH53RnxGio/kEK9bXGl2vDJ3vK5p2rw+Sr0BTo5KC
         dyr1Q7B66xo52rVzCtUlr4tTzVrPMmplN3+bb6Y5+adiFFNSnaMnxZFQnzVXb33y8lqF
         cqeU1IDY8p6PD9UOQ3YZwcjLsjNQcF3TsatcQjD8kNWfJ/txZhNbRuQh69xs4LHURVjv
         Ue9/e4nV93rnmEMd2w7zp0pIvHG341iDSNKP6Iw7LgEPHgFqybPueVhNx+PyJMUb0h+Y
         gz5CcCH/9cfEvo79wC+BqOvYafjv28G5vFGYBFOA93q7FB9jjA7ctn+XsRvv/qLrcXrC
         0l+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=FpepC4xFaJGVnjf18g1C8zYeq9gRMdq/7IlUInDggZs=;
        fh=mvzsE1dGfi3stlCM4YYUqSTrK+srD1vb8sXRMSfCBDE=;
        b=EwTi8AhJhqZeXjeQcki/qXXvjTq90rZzJtJQCHM4FC5IcKeJlqYot0cVgKAVJ3n7t8
         KaXXV7X6FHnUpzYsDs8Zx6oxfepbLKSHqq99k/JTexnQFZNYmOI8xpf8yP42GrL52hvW
         fh00U7HTZCvQvtwkqwcZ7Z8i2h4tBoBG8yYd78/DnZthyxNrNfW105Y255yakknh79vq
         dTN6j/4S1Z9VImtGsYX2xl9EIzqvqp5C5nmKJEXNnvP2CdYx4LCog6edMRqozqwqmYkg
         8Y5/aQmHBUWg4CPBOQjdMdJvGKLFcgOMmW91P2GjN0A3c0yfmVG65UrMcu/xzaXYJEco
         fjug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782345947; x=1782950747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FpepC4xFaJGVnjf18g1C8zYeq9gRMdq/7IlUInDggZs=;
        b=hOKPGFltRjIywh7NhJRbZLBxvpHmMPXFX5eXQxaEfRzMWfErqyPd5s76gliKoS+W2u
         O3edmbj7F1czDUHL9ObJdwL5DZ7Vm1lZZCMNG/qS4W7Kf14GLsWwtqeTmMHOkvT992zJ
         xWUxeJnJucTrrPj1WyX4RzFEx9J/uEVVFgDdTtuXo2AvrwN+fdn8Ajc7UkY7Ij0HwsL9
         b4CL1PDru8CIWOKFYjHR7w/asYibNAC9KTKgzRur6huZI7woizeUynaI/lKndRtz2xqR
         DDIS+rY4ueUtvNycgls1qPcJr2czRm9E3TnO05FgOziI3P0aFubRHKdrD9CPQqkeUS7M
         EOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782345947; x=1782950747;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FpepC4xFaJGVnjf18g1C8zYeq9gRMdq/7IlUInDggZs=;
        b=Cp0ROvCfiRHRwF0o6Ub0OTsUAtBZG88Xw7eIBqYWB9qyFww7z+JHm9HKDDiRCBXyky
         j06SEpDK/RmOhP1y9iyoPsPn1DVDdJX1GfBEg8WZX0dlw3z+OTIwrvcE59oDM3ObR6/3
         edMLrzFoDhGq+ZsRdUzNDKlZEnaAvymmJ/dHfN477s12legiqPSYUFRLCHYc+fOzM7JP
         9tblwYj6Nx1l9Jn82R0Jjp4lbhFmgK5u8m/aXLH3bTzrCAlVk1flc/5J+iFwxiCENG68
         cXdvSOhGJopN8oYxrQz25ThCFRbvDjV7URladz4SGNr+B/GEi4qDDjgJv+HV6pysrS3m
         M78g==
X-Forwarded-Encrypted: i=1; AFNElJ+E4yV2oSMmPjULH3RkIkkGpRJk8wEa0uYNgaklX2IxrwDYnFDvgfcgVzthbxuG9ZUy2Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2EFBnB9AMj3GyO6ep2x5V7CCFXNpW3T4l+Mxbh2i7OSIfogY3
	VUOXF3e0Z1vuaFzE/8wvgeZqNxk2M0eDbXmgO6IaYxzOATFyARHSMOn+7un+lu7iJb/YLaIgvdt
	O98L7itvhC5Pnd9MlwvTvr1nI3ODfLgdx8438w0tO
X-Gm-Gg: AfdE7cl40Z9kdf4Dx7LLBTQ54D216rPcZW4vPN6EDRaRuT53ZBLtn5UMYucAeIJHfVm
	76VBlWb0+my9gi8u1MTc2jBtawLNB4W3SV4n2sr1a9S4D1VfY3y9tALE8E8tflgyUM7HfG7G053
	5xvCPv6Mjj7zAEQrv5KmPOD7XpZ98TFzt/DGyNIipYulmkdiumpD4JusROy7LZx7f3wqiR863J2
	6Yyjsh6x5UQYlgf0wlR2gHc2uzE9PDcILAd+62Jn64bWnd2z7DZpZLUkMzL+h3kGrdXFF9RjFtu
	GIfiKvF6qXEW1gYEpSsEDOUi0jJvWhdTThq01XRGmZQRAozsh38yHTfRtUs=
X-Received: by 2002:a05:7022:e01:b0:138:49ea:f463 with SMTP id
 a92af1059eb24-139dba54880mr251235c88.16.1782345945708; Wed, 24 Jun 2026
 17:05:45 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 17:05:44 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 17:05:44 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aji/2svhcc84rn5w@yzhao56-desk.sh.intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-24-9d2959357853@google.com> <aji/2svhcc84rn5w@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 17:05:44 -0700
X-Gm-Features: AVVi8CctoVihMuJ7SOXsg73Uq4ZLzDcGYZqps3qpfVHZ_IQN9jIN9AXdoFf5CH4
Message-ID: <CAEvNRgHYTFnHbsLLgMTCSitmnp1_j9Pomikm9qmpGTh1w8YE5Q@mail.gmail.com>
Subject: Re: [PATCH v8 24/46] KVM: guest_memfd: Make in-place conversion the default
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

>
> [...snip...]
>
>>
>>  #ifdef kvm_arch_has_private_mem
>> -bool __ro_after_init gmem_in_place_conversion = false;
>> +bool __ro_after_init gmem_in_place_conversion = !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES);
>> +module_param(gmem_in_place_conversion, bool, 0444);
>
> With gmem_in_place_conversion=true, userspace can create guest_memfd without the
> MMAP flag. In such cases, shared memory is allocated from different backends.
> This means this module parameter only enables per-gmem memory attribute and does
> not guarantee that gmem in-place conversion will actually occur.
>
> To avoid confusion, could we rename this module parameter to something more
> accurate, such as gmem_memory_attribute?
>

I asked Sean about this after getting some fixes off list. Sean said
gmem_in_place_conversion is named for a host admin to use, and something
like gmem_memory_attributes is too much implementation details for the
admin.

Sean, would you reconsider since Yan also asked? If the admin compiled
the kernel knowing what CONFIG_KVM_VM_MEMORY_ATTRIBUTES means, then the
admin would also be able to use a param like gmem_memory_attributes?

There's the additional benefit that the similar naming aids in
understanding for both the admin and software engineers.

Either way, in the next revision, I'll also add this documentation for
this module_param:

  Setting the module parameter gmem_in_place_conversion to true will
  enable the KVM_SET_MEMORY_ATTRIBUTES2 guest_memfd ioctl and disables
  the KVM_SET_MEMORY_ATTRIBUTES VM ioctl. If gmem_in_place_conversion is
  true, the private/shared attribute will be tracked per-guest_memfd
  instead of per-VM.

Let me know what y'all think of the wording!

>>
>> [...snip...]
>>
