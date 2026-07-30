Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808B38D011
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785443707; cv=pass; b=DQXIrk26UIi7QYtDSNV3AB5++ctwMTeq6FbPGiMzFIOPqP12lo1VdUS0SOjI5JJGROUltirFMI5X7jwY/zW5+ROomXxlGMD0EO18FsUiSKh1jars5O0ns55yorj6QQ4LyZFJDCqQP7C5JtzJOJGJnDJ5phWNLUG0YfeS4SY/arg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785443707; c=relaxed/simple;
	bh=30g6+52vpLwa+w0jwIJQYFnjqb/F+49RsIdPCA/cCGI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4SVKQebPG+2gp+S5TfimU5ixWC3+ID9fHkzLFp6rA6pZU3ZSl7lkEckdQTtHdnKqFfWnVZmZEcG9fIPQyV4ar4ahia4tthPKlijMGj64ipACGT4NfcOV66oUFAKzGz6un2wHOY2g3fTyeQSXabuuJgmsF1gK64mNHYCetZOx6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FgE6wtnm; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FgE6wtnm"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e58034d05so343491a91.2
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 13:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785443699; cv=none;
        d=google.com; s=arc-20260327;
        b=Uror8IzsK7AGiMhAQwNneH9OVRMEgGPH7pnD7TOJXYIOx2ntOJmPuJqR/HG78z5aat
         yR6KDtO/+s4NMmH7qKR1sXrAip1vb2UqWUIfVOFVpUT7YzEMdUnHQu1Tx7iZ5nyVknQZ
         bivZ1EvjymIaaYlBi8RZqUY/8wkV/7EL98dT99svIc9n2p+vRfrLi9PMWMtPIkIShcnz
         hqYLLOHZjXOZOo5S7hEcS3H/KT8xoYzUxWz/l5ida2ejZbIR0Mt3rUDI8bco2C+jYNQn
         9Sd3TtEeNcAaUlMYsXQkl/dT9hwUM/fhviIT+FYq+GUIu7d14DaCiLBlsaQxNGVSPhmj
         JZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ZeYSeUDQaPUMgdnk0OR676C/F3UEN+xBjEeugnIWfJ0=;
        fh=lfeD6oXUOXUqKKEWq9uCpbJFP4c25yo5X3bpr7EwmIQ=;
        b=LFI80AVtOikdNVO9nD+vaZr1pZVswdWy9M9BPH64klYw89Kd/a04pzAQmhLny/xcxC
         6VcmxliUPs0IbZ+drHkMAAQU2E9OkTkulSXcdNS85QVbcN+A35Z9CBxQEVbMAEfgX5TI
         Q08AgHpslA9wF7TRoredDuemHZd4XTALP3PLvEe/E5qW0g99dRZT3MtVpl5ap48txKMC
         qKUJ2AbftAFtYAG+mqyF/Oi/UeOUuZZMaGTvTVdY/Oo0QKDntYqQi0fv5pdY3pSnSDZH
         CRlEqVUgq3AfBX2ceAJVd7+hrhxNVtLf9NVPdTcg5Cwv5EVg0oXi6Pku9TttraaoJxvD
         f3fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785443699; x=1786048499; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZeYSeUDQaPUMgdnk0OR676C/F3UEN+xBjEeugnIWfJ0=;
        b=FgE6wtnmAFYvzjw5wFWRd6huJNE8KA8k4l1SKooUBzxMVVwd+7U7VXuCU5YcS8WEaD
         Vrwj8/c1KYuw8fdTLncr9hVfiFepcy6j5dRZ9fvrnW83jJ19GTz2sSIBW5+2Q4pS8K9E
         UMd5Cbdf8rR/SH0v4tJFusrjrjdeJC2sNbMGc7S8mBDr4DcOPl1y6QQ/mQ7maFIYlOxc
         s6IGf8HwDp9a14sShNX41524Nmf94qkwdPAAyMei1hm6JRQTUL/5daQAaLelttfr7ZtD
         0BL/uLBgdiJNBdhVo0kkOdd7FcaoTCcJqUMGRL11vNgFqkNQTxkeQhFa6HrH7JjPNZNn
         hfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785443699; x=1786048499;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZeYSeUDQaPUMgdnk0OR676C/F3UEN+xBjEeugnIWfJ0=;
        b=O3skPy/g9FE7cYEOlKT4Htgmiw9IKvA/FFLW3JxOCrCNdffkSZC9BTB3z9PK9vObWK
         mI1GHpZdI4V4p82e7vAuY8dMJGqYPAQsGdHZbc4mFQTjnrTbVOJQKRln/wTgQs7DeWJv
         YISb2qyn6c8D6SYwyAnFlPZHag1EON5KvEDxvLtTE2yFTXZvNEFEI8YT381H+G1qC7SX
         AqCspTKhCJJTtu/qx/QTavathSaaRLlWHLOCBLOWarQa2w6pOqVT92QC91FG0LiJlKuT
         oUvde+eaJZxEppsFyuDUBYHSL0WqOgZKVu2ASahIUiWHDXmrUGtiYwsm9VrB+Ltim7QF
         BFng==
X-Gm-Message-State: AOJu0YwSEsasa+ga7xpZLES+JdsSegGWVZrpMp1bhjHI8uoOQK2bH+lF
	SUWTvpVglvdOCkjCmmh3oCTdFRunh3U9zPnmWZy3OyOSzD+5ngguHITw5C9gUwV9wCmCLrohEfR
	zKed6VzvDYJjWiKwU3A30mpSI6enHk3Ax/oVqINL3
X-Gm-Gg: AR+sD10vEOnSPZuhxAxGw8ZTeZNkyYGkZGuPEbUiqmMoGfdiTFKhPcwU69uHx9CyTL+
	47I1c6P2qPTMLH6eh1sl5ZE3pjm1B3pTR/jpg2Hs6onGOTaV5Vbwbu9C93nXeiWs/IkKve7X+tk
	6IF7pqdHlPbV+T6j40GIed7dSgUyTNq9hQfko3XRm0zakPKfrNMOh0rvtRU6KOrQQc+IbEpBTc6
	2G7EbXyUf7IMik+wP6mEKjwTF4ICW84xEEw5CNdO63e/TzobKHCuZVpCKYXmYK4dXkS4UESZ1dn
	BFzCjrt8fGzR60qHtN/Nggo831lYsFZdTgkCQPX+hrbv48kRBNKDuQYi1E4gW19Gx/0IPG5FYt1
	MuWdurKVDqOaJtsWVwfTtUXXTSRuQARnodYU=
X-Received: by 2002:a17:90b:2c88:b0:38e:2c8f:a01a with SMTP id
 98e67ed59e1d1-38f9bda173amr3473378a91.11.1785443697893; Thu, 30 Jul 2026
 13:34:57 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 13:34:57 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 13:34:56 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <7dafaa90-f3d4-4be4-a5cc-472163f18040@intel.com>
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-3-35f9aec2aed2@google.com> <7dafaa90-f3d4-4be4-a5cc-472163f18040@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 13:34:56 -0700
X-Gm-Features: AUfX_mzoiUtQGNkPMfuHgGb11yV4gcaKdQOzK-P2tpO8oMq-FVBJLM1nZe0Ady4
Message-ID: <CAEvNRgG3qXrG2ix2MEcyVo0GXaen-Pte4gFAwEN+9AY=VtGU5w@mail.gmail.com>
Subject: Re: [PATCH v9 03/41] KVM: Enumerate support for PRIVATE memory iff
 kvm_arch_has_private_mem is defined
To: Xiaoyao Li <xiaoyao.li@intel.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 7/29/2026 8:35 AM, Ackerley Tng via B4 Relay wrote:
>> From: Sean Christopherson <seanjc@google.com>
>
> Though the patch order and diff of this patch is adjusted to what looks
> in v7, per Sean's request [1], the changelog still looks somewhat
> confusing and part incorrect to me.
>
> [1] https://lore.kernel.org/all/akVGZOeR1ytfkamK@google.com/
>
>> Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE based
>> on kvm_arch_has_private_mem being #defined in anticipation of decoupling
>> kvm_supported_mem_attributes() from CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
>
> As I commented in v8, the "in anticipation of" thing is not correct.
>

What I think was intended here is that in patch 20 of this series, "KVM:
Let userspace disable per-VM mem attributes, enable per-gmem
attributes", this part

  -#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
  +#if defined(CONFIG_KVM_SW_PROTECTED_VM) ||	\
  +    defined(CONFIG_KVM_INTEL_TDX) ||		\
  +    defined(CONFIG_KVM_AMD_SEV)
   #define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)

decouples CONFIG_KVM_VM_MEMORY_ATTRIBUTES from
kvm_arch_has_private_mem().

I get it now, so CONFIG_KVM_VM_MEMORY_ATTRIBUTES is not actually being
decoupled from kvm_supported_mem_attributes().

>> guest_memfd support for memory attributes will be unconditional to avoid
>> yet more macros (all architectures that support guest_memfd are expected to
>> use per-gmem attributes at some point), at which point enumerating support
>> KVM_MEMORY_ATTRIBUTE_PRIVATE based solely on memory attributes being
>> supported _somewhere_ would result in KVM over-reporting support on arm64.
>
> 1. I'm not sure what "memory attributes being supported somewhere" means.
>
> 2. the kvm_supported_mem_attributes() will be renamed to
> kvm_supported_vm_mem_attributes() and it's still under the guard of
> CONFIG_KVM_VM_MEMORY_ATTRIBUTES, what's relationship with "guest_memfd
> support for memory attributes"?
>

I think another way to phrase this is that if we don't make this change,
say, on the foo architecture where there's no CoCo and no private mem
support, kvm_supported_mem_attributes() would return true for the !kvm
case, which is over-reporting.

How about this, replacing the entire changelog paragraph above:

  Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE
  based on kvm_arch_has_private_mem being #defined. This improves
  reporting accuracy by not reporting support for
  KVM_MEMORY_ATTRIBUTE_PRIVATE when kvm_supported_mem_attributes() is
  called with kvm == NULL.

  Give architectures full control over overriding the default definition
  of kvm_arch_has_private_mem() by removing the coupling with
  CONFIG_KVM_VM_MEMORY_ATTRIBUTES.

  In a later patch, kvm_arch_has_private_mem() will be defined based on
  whether architectural features are compiled in, and made orthogonal to
  CONFIG_KVM_VM_MEMORY_ATTRIBUTES.

>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> Reviewed-by: Fuad Tabba <tabba@google.com>
>> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
>> Tested-by: Shivank Garg <shivankg@amd.com>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>   include/linux/kvm_host.h | 2 +-
>>   virt/kvm/kvm_main.c      | 2 ++
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index 9f78a466c6f3e..c125d2e8155a7 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -722,7 +722,7 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
>>   }
>>   #endif
>>
>> -#ifndef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>> +#ifndef kvm_arch_has_private_mem
>>   static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
>>   {
>>   	return false;
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index 902aa166c9c0c..9501dd8d015d1 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -2421,8 +2421,10 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>>   #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>>   static u64 kvm_supported_mem_attributes(struct kvm *kvm)
>>   {
>> +#ifdef kvm_arch_has_private_mem
>>   	if (!kvm || kvm_arch_has_private_mem(kvm))
>>   		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
>> +#endif
>>
>>   	return 0;
>>   }
>>
