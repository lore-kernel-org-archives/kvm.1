Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957D335839C
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 22:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789512968; cv=none; b=PrlAG6AkUYtoHrZHKNH/igwQNt9CpN8tCwkJ516+lLtUPQ0RW9PvzR0qriW5NH3UA9xbez4eC2rEynzak50XNrG2/XbUH3an/2M4jtVOj+apxgSe3ZL+02yrqEC/Bcoq/nZRybkpg8faxfFMqSBcmNHJED4o7NeVyxkEutyfz5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789512968; c=relaxed/simple;
	bh=D2zUWH66E4JDS2QbS/YUsl63GXMYkTMiaoJGK2SfZFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiL9jtcap/8JOnFg+vfM+PDg5dr18Mn1c5vCbcPIlpilrIjunGgUB17QEAKCAAYQwkwbmv0r95EYvjqY5PJo7FHeBcqeSiMwUfPkuQVbiDMfMO/B4qi3WF9/2ycBSIxNA3PiUlU4NFWePoRy0l+DHwhP1gtUV+Z/5is7d6FOrAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Gljnk+Wp; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Gljnk+Wp"
Received: by mail-oo2-f41.google.com with SMTP id 46e09a7af769-7fcb425fc2bso174496a34.3
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 15:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1789512965; x=1790117765; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bKxFu7FSdp0zRZPyAWEHKVW9lpDU21iZxHJocYoCDsw=;
        b=Gljnk+WpewSB1aIqtVbWI0YMEwr3Rt8ft90srD3ZnfmZ69WjBtYlaPHYxEdpeMoa92
         UwmQM5ECxSEaJLYhVbOYoXHkWXBY4v7WyIr/JtA4/qCTz2SGK98tufgkdGRMKqvgluTS
         oVBtug+ZWH1M5ijGwVZwcw5vAsXdrHg82/xBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789512965; x=1790117765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bKxFu7FSdp0zRZPyAWEHKVW9lpDU21iZxHJocYoCDsw=;
        b=QFZ7MSs74vSgwJKqBgDyC9tEcvhZWRhn+P9mVKHwGzZuFY45DgxXGKrSIeG5Ha/vLA
         uv+k/gqCrhHchTNvhDrmrMNgb4Td+XUTgTWbolC1nYNdRSu8m3gnSuTmHbQ46JvDpz4x
         w34U4IsJXYjZBNgcPqE1dhoXJsmuDKx2x5ZpDqRFvuW6Px90I75DHdvESBnCsjv0BDrY
         8tznpEXv7SyinfWHSYHnf0SZ1PhoYVQmTIV8nZ5aeYQb32UzN9WfmYIwp5e437POm9uJ
         mF7dH1DkPiz+P8LgL+hgzeUWGHQH28MA6jJlQim0ViKlb13HmIJ3ksphNIJt8LOrXWFa
         5Yqw==
X-Gm-Message-State: AFuF++lncNzgq5WHRvwWZO/pymNffbuDbt6sIUojOkIDDHIOWEH08PIJ
	zq3JtFR2wASKDZ1S+rDjcr/6ItagjLVSe66EHMaKyiM47jQ02z0ulfQecIxdIAT9yjr7KiAIKdh
	DV2w98Ew=
X-Gm-Gg: AYBFou0zQbFM80GT0qk6pGsna7mBWQOoRr5tNcwqNuRwZL+iP/6TfJP3allpRjpdxy5
	O6LkQ3dW/uQrxZ7EIJdjZrvdKfkHUHpxWXMU62qW4B0pAhy4294O5n20ilOiRfCc8x9I+aZy/Pg
	AyuTFSsHvivHqMBnmj+ZC7a7DoHRBT8gjKYsIu1gLKXW39tyy0pMPynXcwiDKG7nkCLvOblz/L5
	8bvukm9+qf/Hej8pP011CnQnLC6qqxNIGm2VcQW1JacHLuIA2JqWAsB6lLJ25xHE1oYVhsuSTY+
	/VZd14o/YGidm26gzs17pr/tBq0pPQHicGsOFv+zCKfocv5xorM6FXtKFwvsU3l5OMG5czP19ut
	a2VR5Y26sjkO8UxPACBGpFdZFTO64IqHMkicqOALYw7gcIs9Fsmra9gY3mEHp7FDmVkxneTkGbZ
	b8grfZdZm4Hb1+gN5agcFfdGkJemTWElcZ78SHxMATH6pEHOj22LGKuSScnChTGh9cdW9j3O+VP
	kQwnnV9dOCz1K23y6f/wn7MCKvKx6aVqi2M1m9Mb07ZMA2GX01u/w==
X-Received: by 2002:a05:6830:700a:b0:7f6:6618:e506 with SMTP id 46e09a7af769-80b2df33bdamr612316a34.14.1789512965339;
        Tue, 15 Sep 2026 15:56:05 -0700 (PDT)
Received: from com-75606 ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80b07ad0506sm810908a34.27.2026.09.15.15.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 15:56:05 -0700 (PDT)
Date: Tue, 15 Sep 2026 15:56:02 -0700
From: Kyle Zeng <kylebot@openai.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v3] KVM: x86: Restrict saved GPA writes to hardware write
 faults
Message-ID: <aqnNAsGF_iUQsVX1@com-75606>
References: <20260915222625.99965-1-kylebot@openai.com>
 <20260915224104.4EB441F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915224104.4EB441F000FF@smtp.kernel.org>

On Tue, Sep 15, 2026 at 10:41:03PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kvm: x86: OOB read and type confusion via static SVM feature check
> --
> 
> commit ed7805af977b5a574d9ccec8367687b0fbc85fd3
> Author: Kyle Zeng <kylebot@openai.com>
> 
> KVM: x86: Restrict saved GPA writes to hardware write faults
> 
> This commit restricts emulated writes through a saved GPA to cases where
> the hardware page fault actually reported a write access. It includes an
> exception for SEV guests to preserve existing behavior since their guest
> page tables are encrypted.
> 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 79468ddfe4736..de7fc8efeadce 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -33,6 +33,7 @@
> >  #include "lapic.h"
> >  #include "xen.h"
> >  #include "smm.h"
> > +#include "svm/svm.h"
> 
> [Severity: High]
> Does including a vendor-specific internal header like "svm/svm.h" inside
> generic architecture code violate KVM layering rules?
> 
> [ ... ]
> 
> > @@ -6454,7 +6456,18 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> >  
> >  		/* With shadow page tables, cr2 contains a GVA or nGPA. */
> >  		if (vcpu->arch.mmu->root_role.direct) {
> > -			ctxt->gpa_available = true;
> > +			ctxt->gpa_access = ACC_READ_MASK;
> > +			/*
> > +			 * Always allow writes for SEV guests, as the guest's
> > +			 * page tables are encrypted, i.e. KVM can't walk the
> > +			 * guest's page tables and so must always use the GPA
> > +			 * from the initial fault.  Restricting use of the GPA
> > +			 * to the access type that faulted would prevent KVM
> > +			 * from emulating RMW operations for SEV guests.
> > +			 */
> > +			if ((emulation_type & EMULTYPE_PF_WRITE) ||
> > +			    (cpu_feature_enabled(X86_FEATURE_SVM) && is_sev_guest(vcpu)))
> 
> [Severity: High]
> Could this lead to an out-of-bounds read and type confusion?
> 
> The cpu_feature_enabled(X86_FEATURE_SVM) check relies on a static host CPU
> capability rather than checking the active KVM hypervisor module. In a nested
> virtualization scenario (like QEMU with -cpu max), the host can expose both
> VMX and SVM capabilities, but the kvm-intel module might be the one managing
> the VM.
> 
> If a guest triggers an emulation fault on a kvm_vmx object, this path could
> call is_sev_guest(vcpu). Since is_sev_guest() expects a kvm_svm vCPU, it
> will blindly cast the kvm_vmx object to kvm_svm and read memory past the end
> of the kvm_vmx allocation. 
> 
> If that out-of-bounds memory happens to be non-zero, it would incorrectly
> grant ACC_WRITE_MASK authorization for emulated writes, leading to a
> potential security bypass or host kernel panic.
> 
> > +				ctxt->gpa_access |= ACC_WRITE_MASK;
> >  			ctxt->gpa_val = cr2_or_gpa;
> >  		}
> >  	} else {
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260915222625.99965-1-kylebot@openai.com?part=1

On this baseline, x86_virt_init() explicitly refuses to enable
virtualization when both VMX and SVM initialize successfully. VM creation
then fails, so exposing both CPUID bits doesn't appear sufficient to
reach the path described here.

Also, is_sev_guest() casts vcpu->kvm, not the vCPU. In the configuration
I built, the access would fall within zeroed padding in struct kvm_vmx,
not beyond the allocation. That's not something to rely on for
correctness, but it doesn't support the claimed OOB either.

Is there a configuration that gets past the initialization checks and
demonstrates an incorrect access? I'd like to establish that before
treating this as a functional issue.

Thanks,
Kyle
