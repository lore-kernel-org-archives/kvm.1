Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2DD3C4557
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928359; cv=none; b=YfNVZSZY3MqXP1jlmp+Dhv4fAL8SW8/EjY8QnD7JIkvV0GqelQM0lXLh8du2HPm9D9H34ho0PasqBONQSfwtWMYTtXgXhRESC8RST8MQsqVsn5Tnixp29XPBl8zaPrPPKaep64VUTUG3XPCRdDDYS+KpufJx1DxCM2HwZHuv948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928359; c=relaxed/simple;
	bh=tCrAN+QwYjri3tjSjOiLo4/IEE/Kzj/RPrjDTuJhjQc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m+VtxdolKhgpskVLCoBafN0qo8BczMlRDWqwHt0FQ3ylwEweN88PSY+NCsITtPCmAjajB2pjWNgQX3POvTtXYs75R2A1iDFNoF9q6rFbqccuN3ZNawblLcTQkE7LjddSG/9OvJLgRpsX7D6X4D+E49ja3Leq4xEogobsbI/GBfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fsg1FZ2Z; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fsg1FZ2Z"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36e09ec696aso7437848a91.0
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780928357; x=1781533157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3OMkuM0krcAErV2R0QvPhqc4eN2qPVaOBf2x8HQL30k=;
        b=fsg1FZ2Z3MfEsFdIcj24CgYBn4MLlYgrkHRlSNIRrbgDSXeCX/CiG/sTb0YOOj1RxA
         tiKXDQZ69GkKHnWfWYX+aT+XhVCf9JcT1yPHYM3Pcem8VknGBl0hP2Bxr/POSo/O5Lb1
         neJxIebOop5kBFAQwN4G8KEFdqFbYtQAxhmKatBmty+MbeOwDJQfzahyG5+4Hc4ZrISq
         +kb8nY0t9zku04Qtt0vaC5FzIqmTE3DVlTLOxolMbcQmFQil7peInp/w6aXtOOS1qcon
         9Zf5JHUuxy5R0MGXMbM3VzFXucXD3sfQ7I4HJ3nj/iIhZ7At2JLdOTUfdurtSuIlyALL
         I87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928357; x=1781533157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OMkuM0krcAErV2R0QvPhqc4eN2qPVaOBf2x8HQL30k=;
        b=sQQqcTaBRD8J6okkNb6QGG6A45Uyvxid+HKVHxbyVWggFf4wP8GglAWCmlr9iYbRWi
         TEFnneDD+BGCW5JzBNAAKhretZ8s3gnuwI3Lso5nU6i8GB/QR/nJUrbJtMEEPkK5sA1w
         W9CO95TeV8aqfBOupldboMO/AWPkLWI9/F8viLOUC9Y2TswwKhxgOfiWWzG3l0tYITTQ
         9IjwJsNR8JbhrqsiKYF0sYrXDhb2KsZkinIZaxbXiseSEwADYcw0lvsvmLwjgCCWyxRQ
         r1wctCp6I9mpbKYYy1HQgSmsAmfKyM+kdKD/foO1ghWsw4EcL1MgXYok2O0qBlbwFixw
         MgSQ==
X-Forwarded-Encrypted: i=1; AFNElJ/PmQ/Mm6MU8Jnd9QVnWpZToFFAT0sGiCNuy/IVPMYZbMjNc6EUItLrTukDZ4Fe7Kv5srs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzhRs6vBOgvPlLidXHSzVUUPLmOyW/ApRATKhBJSad6RawnPIU
	PLuLq3MOsSBuYjr1K7k/AM4iMQMTkFB4MyexF6lbakV/FFdi3lYOIurlB/v7ao5ZeSZQbiiiZQ5
	nrBA61w==
X-Received: from pgaq66.prod.google.com ([2002:a63:4345:0:b0:c80:24e3:5130])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3fd0:b0:36b:293:68d1
 with SMTP id 98e67ed59e1d1-370f0772017mr16427503a91.16.1780928357037; Mon, 08
 Jun 2026 07:19:17 -0700 (PDT)
Date: Mon, 8 Jun 2026 07:19:16 -0700
In-Reply-To: <4e5b6b9c-4f7d-4d62-874a-4bcb745e9a47@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <20260417073610.3246316-2-binbin.wu@linux.intel.com> <4e5b6b9c-4f7d-4d62-874a-4bcb745e9a47@linux.intel.com>
Message-ID: <aibPZMfxabh6meOk@google.com>
Subject: Re: [RFC PATCH 01/27] KVM: x86: Fix emulated CPUID features being
 applied to wrong sub-leaf
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, rick.p.edgecombe@intel.com, 
	xiaoyao.li@intel.com, chao.gao@intel.com, kai.huang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 08, 2026, Binbin Wu wrote:
> 
> 
> On 4/17/2026 3:35 PM, Binbin Wu wrote:
> > Guard the use of cpuid_func_emulated() with a check that the CPUID
> > sub-leaf index is 0, as cpuid_func_emulated() unconditionally returns
> > emulated features for index 0 and does not account for indexed leaves.
> > 
> > Without the guard, when iterating over reverse_cpuid[] entries that
> > share the same CPUID function but have a non-zero index, e.g.
> > CPUID_7_1_ECX (function=7, index=1), the emulated features for index 0
> > are incorrectly OR'd into the wrong capability word.  For example,
> > RDPID (CPUID.7.0:ECX[22]) gets erroneously applied to CPUID_7_1_ECX,
> > which would allow userspace to set bit 22 of CPUID.7.1:ECX in the vCPU's
> > capabilities.
> > 
> > This is currently benign as the affected bits in the non-zero index
> > words happen to not correspond to meaningful features, but it could
> > cause problems as new features are defined in those positions.
> > 
> 
> Hi Sean/Paolo,
> 
> While the bug is currently benign, I still think it's worth fixing.
> 
> There could be two options:
> - Considering cpuid_func_emulated() probably would not be extended
>   in the future, still keep this simple implementation, but add some
>   comments to cpuid_func_emulated() to call out only subleaf 0 is emulated
>   as suggested by Xiaoyao.
>   https://lore.kernel.org/kvm/fa47d520-1de9-4ddc-94ca-6bb53ac30f10@intel.com/
> - Add the index input parameter to cpuid_func_emulated().

Definitely handle this in cpuid_func_emulated().

diff --git arch/x86/kvm/cpuid.c arch/x86/kvm/cpuid.c
index db8be9173bd0..737ca3e7bda2 100644
--- arch/x86/kvm/cpuid.c
+++ arch/x86/kvm/cpuid.c
@@ -400,7 +400,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
                if (!entry)
                        continue;
 
-               cpuid_func_emulated(&emulated, cpuid.function, true);
+               cpuid_func_emulated(&emulated, cpuid.function, cpuid.index, true);
 
                /*
                 * A vCPU has a feature if it's supported by KVM and is enabled
@@ -1369,11 +1369,15 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
        return entry;
 }
 
-static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func,
+static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func, u32 index,
                               bool include_partially_emulated)
 {
        memset(entry, 0, sizeof(*entry));
 
+       /* KVM doesn't currently emulate any non-zero indices. */
+       if (cpuid_function_is_indexed(func) && index)
+               return 0;
+
        entry->function = func;
        entry->index = 0;
        entry->flags = 0;
@@ -1411,7 +1415,7 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
        if (array->nent >= array->maxnent)
                return -E2BIG;
 
-       array->nent += cpuid_func_emulated(&array->entries[array->nent], func, false);
+       array->nent += cpuid_func_emulated(&array->entries[array->nent], func, 0, false);
        return 0;
 }
 

