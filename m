Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171DD4AD4AB
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 23:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909882; cv=pass; b=qZpXYaRBtHj7sJHNytLT7yrJPmpSgVlaExb8cVzYyd1xriAOBIsQEGLHrHelKRLU/ArW0atrqu4VRer7T7+p7tg0almukIJ+xYseY5VQ/W8SSYwCtWOgPYC/a/9ae8R2ghq4isdli35Io0ZW9IQYMv/1C73mw+Cdhj+MPKWA9jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909882; c=relaxed/simple;
	bh=BUX/j6GF6XPucpJCZBKJcMPFmpJb+KNmwo1Z/5+yXsg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4p+uqv18aRPogKomqE+b3Kec4AZvsSBfJs+JsCA/fMSPeGiu2libyqm/oza87fgQuZCr7Qu0Fa8lkPsCQxPcqkh5rGuMTBUT9bwaMBBjKGZBaqaCj2MhEn04PFD+9zCiRI+jrghK2ZVnVsY6LM25/MNNZnFwGJH0Xdymbiwyoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iciIM+yf; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iciIM+yf"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90ef16ca83eso6050016d6.0
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 16:24:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788909880; cv=none;
        d=google.com; s=arc-20260327;
        b=DEOawv81RWRIN9P2LJ42rd+ObNEKX5UG/twcwQEEkT/YzxhbQMGBee1TGG3KE/q+je
         ZDJWFEdhj0PRYT/3vH257mpWG7AYNxdPKUHDjoD+RaxQk+OCz6rbpxNPiaBIpIIBmjZz
         9vjeNHA/luYICUopJEnYFBmmCzwU+PO/h2sAMSwOG7o7h7yp3jZny9kw1cF3JoZsn+XK
         PMzIIXL03cqX5AMcCCwcuxOAiNKUwr683MgTaY0GkZNrIAEPBqcEbOv8l1oIxj7paVu/
         /OWPC32koUgSjQH0mwA+jYH2qv5fDA//C3FM6LAm40fuej7D8b9GpDj4Slw7sJfqkcuB
         e7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=0IN5QQmb/lTANWR/iwoSBOuy02Mh22swkqv8V9Ybn/0=;
        fh=f1cZ2aLB9PdfMg8RNLCzS38rXe+k0T1uGHEeCLtbSuI=;
        b=JIDkN3Hy5rDBqpxA7F3lELnsCvotRyH37a+qGN3mj3em+gH3pPcrYLEggPt7CxO5sR
         pQmX1F/lZpm3vDPgH0XlFYRw8QJEXyftUPcpJh3jDxWNeEnN3MLlworOOpOef/13FhwF
         3vFA78oO/bfykwPrGT30gFHQvpqAZlwwm69rH4NznMy4I70gXeoLbgLv79umcp/84qpF
         nRWZsE59hgGOWChO5fSuWVUbuC8bn+9iKa2PCkYroDDw0IguLTZ7+CaD9pIOCH93uE0x
         gVkIIxDmRLvoFeE865DWZNFrHXpDB/3bCYvdJXyECHVbAK7sePLwE4eRoCfhjG8CUKtJ
         Aswg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788909880; x=1789514680; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0IN5QQmb/lTANWR/iwoSBOuy02Mh22swkqv8V9Ybn/0=;
        b=iciIM+yfT1AHLW24zESpQnkRY48v0FlVHuK+O44tSw3v5Q8vshEESBTu6M/HGC+WzZ
         +utQ+MZF4vB2yVzggnhBIZi+dMZsVlXDucj6O4c1yMEYbaVzuHVXUyg6PMfobS0nf+c/
         cG4MiKp9YUskVAcj1Nkkn3N2l1svvSd7YbtfD4NXp+gvxuV7TwmWnQYn79yYUBshgTXe
         tO9c4oTY1JhkPa5m4jfXKWxaVbdGIi+m5TSCHeqziMqqYxl+R0NqBJd/OTjOXfCwqib/
         ie/Oc0k3pm3AIwgNbPb953Ho3ObLsb+FE6kGtvRlgoSs2iF+50QjsChG/Q5fxVVM75VW
         LiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788909880; x=1789514680;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0IN5QQmb/lTANWR/iwoSBOuy02Mh22swkqv8V9Ybn/0=;
        b=li8fDNF9IpP9E+fGJjHI08ZZSLmVzbaZKODRWc6Ub7rXQkT+Ger5ClWVFYmDtsym+v
         buwS66htqkRGYsSeuoE76xzsB/1BvBSuSkwCkAgFIoEcsh7BArKqDB4b1xESev2g6qNB
         FWukjBfZKpKCxe6MiL/Ag2jDSAm2v0U2J9qgb1i07fHISqKY8OWIywICk5v2m7J5bYN3
         cAVJpim/uaYF3H3VwqTg9Wr72Zw5z8u6Q8JPcWkhmZw/Hj0p/01aGvDEKidU4ogKO3/d
         +XU40jSSlXeQWa8eDja/saOgHwvPA0oUWqKtpZcK7zEgdzsJEI5FIdYMPGs3NRtsrSat
         OBww==
X-Forwarded-Encrypted: i=1; AKwUvByzIxO+btV5fjHbiTpfeplk7xsG6xtGuV0z5kH6RZd4+xnc8Chgh+HTQxw4jv7bK7kzBxY=@vger.kernel.org
X-Gm-Message-State: AFuF++mjn7F6sAbdz+dUnGBMFV4PjIs4TlzKNhFOBq9qQYmkDMhBJjuu
	gs/wk5ZSIEhg9NLemExQNwAx1yQOOelLna0swD1eENOP8zPKOUmQ56PMr0geAPJ3jmQOV4sTDT/
	jhVZfjle+/X9+HJRdcEGJsEQX84GR7aO2eSv4IlN1
X-Gm-Gg: AYBFou2y83xhDanMsCutBnLvmjTpldaNDfxO8/JNVI+xK0NQT3tg0zNhX4vsyZSLlJe
	HDEt+9j18T+CWrLuj8nb7lwBEVhcduqNOl+NsmG7y/PpiZLNZ7a4LUBDfBXjtZDMKwRa0TL8+VP
	v1XoxMFL/7UxrWLXP15/2sJxDjlbZecz5jxFKRIOpLjzO7AFPmB1Kzss4h44ITZDtWCMIfSCsgw
	aThgIMyHr4hdZJHSXiOxNoudszR4GN62f7vG9kH20PTvRp2CnEV+Rld6vu5iDFLmy8X2NTxIoQU
	NEDoPPYAFXqpWqe7SNUKGKLK5V95kFF5MXUKkXKpQVc4HdLRInIo0Ar2FD4QwCkS0OxusBLmUeL
	A5TqeWuIppzVM5AyHCvh44Q1JEn4wjGg=
X-Received: by 2002:a05:6214:4a09:b0:90e:7de2:d81f with SMTP id
 6a1803df08f44-9106b407918mr47732286d6.20.1788909879267; Tue, 08 Sep 2026
 16:24:39 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 16:24:38 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 16:24:38 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <0a08eab7-e093-46ef-97bc-531766cdbcf2@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-19-15ad654a50db@google.com> <0a08eab7-e093-46ef-97bc-531766cdbcf2@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Sep 2026 16:24:38 -0700
X-Gm-Features: AcwNN1UULNTPjF9-p9AmAvuYgtyt3ObShfxcFD10uTDSDoS21CnWX7JfXOpZMy0
Message-ID: <CAEvNRgHE-c09hdeLqkUfGdnrAUkENuSrdNqByXBYr3N=HSbB_A@mail.gmail.com>
Subject: Re: [PATCH v14 19/22] KVM: selftests: Finalize TD memory as part of kvm_arch_vm_finalize_vcpus
To: Xiaoyao Li <xiaoyao.li@intel.com>, Lisa Wang <wyihan@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Ira Weiny <ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>, 
	Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 7/23/2026 7:13 AM, Lisa Wang wrote:
>> From: Sagi Shahar <sagis@google.com>
>>
>> Finalize TDX VM after creation to make it runnable.
>
> The changelog is too weak.
>

Some other points I can think of (Xiaoyao, please add on!):

+ Why was kvm_arch_vm_finalize_vcpus() was picked as the lifecycle hook
  in which to finalize the VM? (See comments from the earlier revision
  from Sean) What are the rejected alternatives?
+ Expand on "make it runnable": finalizing also performs measurements

Just confirming: Peter, you meant to add the () at the end of
kvm_arch_vm_finalize_vcpus in the commit subject, right?

>>
>> Signed-off-by: Sagi Shahar <sagis@google.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Lisa Wang <wyihan@google.com>
>> ---
>>   tools/testing/selftests/kvm/lib/x86/processor.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
>> index 4b97a9a1bb5e..8319ae3d9fe6 100644
>> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
>> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
>> @@ -1489,6 +1489,12 @@ bool kvm_arch_has_default_irqchip(void)
>>   	return true;
>>   }
>>
>> +void kvm_arch_vm_finalize_vcpus(struct kvm_vm *vm)
>> +{
>> +	if (is_tdx_vm(vm))
>> +		tdx_vm_finalize(vm);
>> +}
>> +
>>   void setup_smram(struct kvm_vm *vm, struct kvm_vcpu *vcpu, u64 smram_gpa,
>>   		 const void *smi_handler, size_t handler_size)
>>   {
>>
