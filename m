Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336905A5145
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895130; cv=pass; b=Nracl2d85s1t6ruQF1h5i5qfpG3TIz3laJK+J+8pgy9BQEpYx6WT4JusFVl3UmSiG7QdbvFMR+6aIASbKQJGGc71LkBRirK+s0zYvi3wimJ9LgIqVOE85BLYOxGknT2zpMJO2jusHBxNMj5+15Ons9vtUwXLcsGaVrb/6AhlmvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895130; c=relaxed/simple;
	bh=iF8wAwPOdw5l+3Cf+6kzkcaY9d4H9emgCFQIITZ4gH8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzC16OnDlDR+CVazOyF9hT/lVeiocVpQNxLSe8AZ40lkqiePWlFOZ4DVLzA/c4AQaHofA0ASlLF4Ake+oBwmFLNZlo6z0qQJYT/dBaaUmUDVfdl1aaZrWQEijmWLk6toBHQTnDYHXMI0t3rLITJVQ0UfiqMm3ose1iVK5A8RPeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jU3BKaz6; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jU3BKaz6"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-90cbff85fa9so57523606d6.2
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 12:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788895121; cv=none;
        d=google.com; s=arc-20260327;
        b=REdt+HUxYrdGqbDX6LUR9/67SNbU4VyK4rQTefp2OzVcuITAtXOXEVIchVbzoz3pes
         loExmnKZnMrE/GmBfQEm6o3KXImaor/8DetIHe4KZZmryGH+mqiNz5sFKsZb20IU+xxk
         L7S0XskrKCUx3a6Q/JbeTz5NoVXkQ73Q6vSwCTeQwg5yPSWeIY6eGqnCwAzd2L1uHiOs
         TnLAbzJniH5UTqqc7Ao5BRJ8TvkV3KqUNRs9ejXR0486RFp6jj3OGLyu+XeasuoVYX1N
         XOIzGzt4kkA5zQOq8DZDcMb9msEazpj+/T+Oj5LufTNFXvxoR8O+RWrEtq9+sHFyJFfi
         vx+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=X8Qt7g6L7Ojilnm+sGhiq7WuzC+eIMrDfW/7+fmIyko=;
        fh=rKEiLu6pWg5lP7U56q4yn5yp6JDdMybm6pi8hC0HLyE=;
        b=ezHns9EwNr0ID2s2Y09/DB4+gU0mvAA9en4sGhaJRctI7u7s7mj30UZ9zdW55m4HuA
         HDuqu/fohBM4G04t6z+Wc0u7ihp615iEg95BHaHLQPJjqTNCeOLZgzlxNtwMkavbYCAs
         7npjiuWCPbazErfG7shdtZLDtdhjrDbbPj7uK4f2fNllEyJLtcMxUZ8MlmZUgGn9qtuc
         FMIEuXvhCrmXBewst+bE+HrZt/+Vq6Liex9cIgdiBOdhIid5xvx8tX0H3F4pxKTzePr2
         NKai+JXpaOf2SPhAwbcYj5HZ/rQ/CV5O3BVSvAtWjiRAkjBvusoog7PE2T0tNfA+pzt0
         iwrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788895121; x=1789499921; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X8Qt7g6L7Ojilnm+sGhiq7WuzC+eIMrDfW/7+fmIyko=;
        b=jU3BKaz6tK34z124OveImkUQ+Mt+/YIIjfsIdW7cIVq9OQ1BvMRQsv5r1uDdElC/oM
         byOYvzELiLygiX66M4jnIR6qqMPjbdTz1vc/3x9tGoanK7OAMsLLLc6cczC7CukCwT58
         GKf8MbTh9KUVSTtRfTdlE/bgtYKsSOoV0YoBQcPQdDHvMS2zWL7iKrzH13cAeWoJb+CZ
         AW4D9jLaH7OLMymuYOXSQC9WzVTHVnbcpV5XcWpLZv658BnyKqthzP5qVu9FkBh3DKg/
         T541cmfGTAFdyHZiNzgawLs3cfz1ojuQjXEg2qNEwO6l8ksrg0P75ApLIG6jzvGKFGHR
         Mheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788895121; x=1789499921;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X8Qt7g6L7Ojilnm+sGhiq7WuzC+eIMrDfW/7+fmIyko=;
        b=VsGyIUNgBHrFNvwSnyLofnIzzQI80w9MzmpcNN5kWiPORO8XMFDU1lSmzleOLyF2AE
         YgdFf5d+2syUe3r4A23oQwPzFFt4KIwBdlGh/2s7i5EY+7uF08v6zKVkm+aemsLDl+Vc
         AHbt8veTLXoxujj2xQm8+YSg7ZXe8RhUOxHdnIz/4QRX4O8c5mjzz7LK6Jc6SHrGd4sa
         hWFPYBwSi8Sx2Yh9lri51QLHVDeNowEl/sE8m7yUI1kIyaPI8Tl6xiXH2MpaxJrjcn8T
         fJux1KrgazKkZHjq5TbG4v8I2H8LhUgXGOQUbrP5TZXI1des+TpU8dctDHk0PrPi6kTD
         nT1A==
X-Forwarded-Encrypted: i=1; AKwUvBwKDh0Q+tvgvYkMQnj67nvQqtCPxfiP8PE115FhLj2FU1G4U1dXJMtQCK7kjZDKci1YFKk=@vger.kernel.org
X-Gm-Message-State: AFuF++n2CSjt+Zbnu9n52jfmYo3x5V6+aD9EnFNjcet0PDvG5WXltrIX
	YDsAKsyo5AWJaGvNu8bo6Bc9r878dBGz22NWGmoGTM4OueuW2a9j0j0oNxMRMsVQLmiZrqR6BH4
	hybo7bHL+Lf2a7Hr2vGwnoYG1q32F6dbEn7PAewcg
X-Gm-Gg: AYBFou04N96mmKqk3qxDRykQs/ynk3lGkcQpAedl+xZZiaImn44dXCnH4gaoZCDAqg+
	YYkt5Jt1ag5lVT+2iQ/p2Vsj4Ez6wIQKqgfts49k11Wm7Zpu0WgOBzSgRiaJcJpnOVjwHcLfZT6
	NyTzVgrkXPnswc3bPA8i03IFeAtdLuu7mEwMbRObkL5H3S/e+Qx8nw5Ys/rdBUHonHEP+Uzvv1x
	/76BaeQLew9+6qxfXlFU2qPf7vEmMNGbumoHbWRJjouhq+EvaATyTmNv+Z2FUj+2H3JZUcUjI7Y
	AV04DlW8rgd15+uJK1ljlo12Idslwp3urKCQbVj9Awq1LGU7Rcb6z8PySASEt3JzgNsBKHdoiOU
	BDyRzpm7K2MZCYpEarEF7IMjRKuKMoh4=
X-Received: by 2002:a05:6214:8110:b0:90e:8d49:1ca2 with SMTP id
 6a1803df08f44-9103ef006e4mr328434076d6.2.1788895119795; Tue, 08 Sep 2026
 12:18:39 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 12:18:39 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 12:18:38 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260825081448.GB3694338@pedri>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-11-15ad654a50db@google.com> <20260825081448.GB3694338@pedri>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Sep 2026 12:18:38 -0700
X-Gm-Features: AcwNN1X5p6qITiCXmMYSZPSPB-N20ut6cFscoALs2WRbCQrztSKzH7k_if4I128
Message-ID: <CAEvNRgHiQ5g94SQ8S6CTyTmEOguQqY9GmQUu1K8ff9L1pALpQA@mail.gmail.com>
Subject: Re: [PATCH v14 11/22] KVM: selftests: Set up TDX boot parameters region
To: Peter Fang <peter.fang@intel.com>, Lisa Wang <wyihan@google.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Ira Weiny <ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>, 
	Sagi Shahar <sagis@google.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Oliver Upton <oupton@kernel.org>, 
	Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Peter Fang <peter.fang@intel.com> writes:

> On Wed, Jul 22, 2026 at 11:13:16PM +0000, Lisa Wang wrote:
>> From: Sagi Shahar <sagis@google.com>
>>
>> Allocate memory for TDX boot parameters and define the utility functions
>> necessary to fill this memory with the boot parameters.
>>
>> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> Signed-off-by: Sagi Shahar <sagis@google.com>
>> Signed-off-by: Lisa Wang <wyihan@google.com>
>> ---
>>  .../selftests/kvm/include/x86/tdx/tdx_util.h       |  2 +
>>  tools/testing/selftests/kvm/lib/x86/processor.c    |  2 +
>>  tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 51 ++++++++++++++++++++++
>>  3 files changed, 55 insertions(+)
>>
>
> [ ... ]
>
>> +
>> +void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm)
>> +{
>> +	struct td_boot_parameters *params =
>> +		addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
>> +	u32 cr4;
>> +
>> +	cr4 = kvm_get_default_cr4(vm->mmu.pgtable_levels);
>> +
>> +	/* TDX spec 11.6.2: CR4 bit MCE is fixed to 1 */
>> +	cr4 |= X86_CR4_MCE;
>> +
>> +	/* TDX spec 11.6.2: CR4 bit VMXE and SMXE are fixed to 0 */
>
>         This is now out of date (11.9.2 as of today)...
>         I wonder if it's better to just say something like: "Per the TDX
>         spec, ..."
>

Makes sense, thanks!

>> +	cr4 &= ~(X86_CR4_VMXE | X86_CR4_SMXE);
>> +
>> +	/* Set parameters! */
>> +	params->cr0 = kvm_get_default_cr0();
>> +	TEST_ASSERT(vm->mmu.pgd < (1ULL << 32),
>> +		    "PGD must be within 32-bit address space for 32-bit boot code");
>> +	params->cr3 = vm->mmu.pgd;
>> +	params->cr4 = cr4;
>> +	params->idtr.base = vm->arch.idt;
>> +	params->idtr.limit = kvm_get_default_idt_limit();
>> +	params->gdtr.base = vm->arch.gdt;
>
>         vm->arch.{idt,gdt} must also be 32-bit addressable here, just
>         like vm->mmu.pgd.
>

Something like this?

    TEST_ASSERT(params->gdtr.base < (1ULL << 32),
            "gdt must be within 32-bit address space for 32-bit boot code");


>> +	params->gdtr.limit = kvm_get_default_gdt_limit();
>> +
>> +	TEST_ASSERT(params->cr0 != 0, "cr0 should not be 0");
>> +	TEST_ASSERT(params->cr3 != 0, "cr3 should not be 0");
>> +	TEST_ASSERT(params->cr4 != 0, "cr4 should not be 0");
>> +	TEST_ASSERT(params->gdtr.base != 0, "gdt base address should not be 0");
>> +	TEST_ASSERT(params->idtr.base != 0, "idt base address should not be 0");
>
>         Making sure that cr0/cr4 are simply non-zero feels kind of odd
>         to me. And cr3/gdtr/idtr all came from memory allocators with
>         non-zero minimum addresses.
>

I guess I intended these to be sanity checks that the caller didn't
leave these unset (defaulting to 0), for an early warning to the
selftest writer if something went wrong. I'd prefer to keep something
that would retain this early warning for the writer.

What would you replace this with, to provide the early warning, or would
you rather just remove it?

>> +}
>> +
>>  static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
>>  {
>>  	static struct kvm_tdx_capabilities *tdx_cap;
>>
>> --
>> 2.55.0.229.g6434b31f56-goog
>>
>>
