Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39BC3D0BE1
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791834965; cv=pass; b=bT5WuOi8hx8kdsFU/xXjCNt7AuYVf1cDae7sRBPAi//7x/qmAZ5tKr8LEuw37RlIuWPyF7cl9KvDZvyc4lehMEbQQu9srHcnEVf0CNw+5WqYbn5ZRjaO9V1xvQIz3Fys9o5saaBIJC2MbEpS58b95RbIZMo46BMl5WVR8xrgn4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791834965; c=relaxed/simple;
	bh=ykAyMeg5cLWvpTP17bZqxvUgF+tQqEuApowKIdMGRBc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKCjvPM/d0don9pGmqRusU7PniUve0lElq09kKjDBFB7ZbgQtAc2Sct3HimUjnGOcZC7nbcer6TjJsAX1h9zdY5GIQn+6wOkom5Op1tiUA0WlMbNdyDF8W/m1S1Eax1Paph/bDyfHncMHEq3sEJQ3uJKaflUI5uBf1WV1vQ2SYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qnne7WSn; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qnne7WSn"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5356b6a7fe5so29596851cf.1
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 12:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791834962; cv=none;
        d=google.com; s=arc-20260327;
        b=o/w/YAmEHjwRi0rmgqSWkqHuWV51c/5lLMuVT0u6EwqrjRu7tgm/wcgHJjgVMXHKTb
         NjE/CIcanFtZ33rpywmZOB5oBNpHD1Z1SMuyhbZOmgesQTNj3oeDbmmo1+U3V9MGug6n
         UPMZBM3sP5nM8th39Bw2oy108V4CUTXrLnNJHk3/E0h9iaF1SZCtJ9/4hpYTwmlowHhI
         dZHPyS51RR0zg3+xV3IGHDG4fhmoDGubMfdhdOtZtHfIKjC6/JtIS2i8TmcNC6m0LP5a
         TuOu6fxN/SwpcBUG0CaBBAwQifVUSYJSiOEIrGFGzD5ZXECS5wee5ajzjhX6y8hARwO8
         S0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=icwfB1j65gommGELuEv6cpQTb2mLGBkRO3hbTGmifjI=;
        fh=j4ctoeDtphtaTIBg0PqurqSYJtUbPqDbJfeyBV84+cU=;
        b=fW/U492ZAYINpvVa5EtwW+zPhIrbzjtekJfKEk0g+tZiJ/EcbVVtoWvx678vdgcx0k
         tYQP+9dg71Torp1S9EHF8+nz7dNL30CaAz6lvjb7NYmrsx0Hfvv7FHtN5a4gYEg44H4F
         fFnGmvcZ3JB1aPNqydr4RNJsYbV9A4tB/VaOFTii6e49BrO9fEhl6bJ73pOmsOcRPy8D
         1dCGEHvzIMu5ztGp1GdkTobnfIwX4O/thgl5T5PANZKUPhfXvMR1ia0ALjhlYORQN76Q
         k8n13NiGEPCuvO/wymtGW5hFV/ugZsl7ANyMRyEAWM+NMng0ZTgBJpjR8pd+hqdocHl7
         /X9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791834962; x=1792439762; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=icwfB1j65gommGELuEv6cpQTb2mLGBkRO3hbTGmifjI=;
        b=Qnne7WSnIof2cHrsoyLslCN+u9IDXRa88tEsEkL1GA3edtrEmsFvs3OCSL+LnfnevI
         1uMC4GtWl0sBGWbsH0bfKoVRCn6lL31JupFmVIK5Ogd3kzFEhNOKIHZ+/aM3sFW7Yx2I
         po3l5h/xkDgpTqdMgrMbhAVGF1jPOzsYnIJuh/Gl9vAy68bYFH+8Hd6JYlugG08lHmsc
         pqFinjAczzGaxWuti1awg0jXnHsnt74RjE54SQ62CSGfHxHM00EguLfgba86GdovLSK8
         eB5vU33syLOtk604+DHfWojOkkIjF2QsF++BKjQp9Upu/dbur+rMvn5EXRb0WbqjJDAW
         918w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791834962; x=1792439762;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=icwfB1j65gommGELuEv6cpQTb2mLGBkRO3hbTGmifjI=;
        b=DZx890P3caMgOX4TdUkKgsVLntkPpQRnRPq/DmWTfhihE6Ln1DDhdn5xn0KsRE607l
         HJr2OErEdPe8I8nxQd1uU/g/2CNR2/OHkCIG+daZOOrxP6/A2xBsYo9DIMm8ZnbRlnJb
         mKpxu2DTyAkkH4xPAOAcgQgPC8hkrDuHJcmBiAXBEYds0lknqLqhz5MBP2PRQsusKCFZ
         07CW1uwMUGYF1mwWt1q98zez5BpwTvELdHYe/auRU+6katlyqODAIslxgbtHj6A/mauZ
         jKlaF/AHMTkPDT5j/Np1j9KpWtn7zCzYDTK61tcAUYSX3fwIFjkwNWil0hX6oK+7dB+R
         Wn4g==
X-Forwarded-Encrypted: i=1; AKwUvBxszkzEdliSwhmXOG2aLWkWtSPzH8JgYAMZPiPscsLMkPNqI2ygEbFcHmLihYldVUA8TP8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIktYWNNRcPLWWoeOyhxw8F2vyWwArg8Lj20Qa6fO35O3M0wjXA
	niBWj1DPf/ao1jpe7kj1GC2TLRzpYjRi4td3kKniaFs23zzK5xgaqN1fyUZkg4C4h8mZsDFsyLQ
	FVcyGYNkKNYJrf8sArhZTG+CYiRpWvi8qc11uF7yU
X-Gm-Gg: AYBFou0QM3oqXnw2tYBBlOgWZxmyH6UnmF1OS/Xn4zdMgwbwvi1yTAAdE32Bv41l74B
	8l0b9zHUxpFPGqr2aFEP42F1gkq2xcmcJBNj32VivlBho3fjF1xhu9HM5wKuGdjv/cp3DM7VTyY
	gRs522KB06IDxSxaN3hp6LzxAWBVHol+xGPQ/JVUb9KbhIN81pZbgMzYUgrkYFR0d2v+AtM2W4j
	OJwqRtAIYV8hxtC5AdTsLjY90W6CGe/kx+9LXHYSWg0DUXlpZB/UH9R12VW2ect0p6SBtFsTvKv
	xugLXgRpf1Owi0bkl5z4mNrT3FZchrDE0HufcxyDeAlSHCpaWoJWKnYRBtr4hJBG+cFYAZEsW56
	5baalqogzStVOsq5HwlfLOSFcMD7zdpAGSStGsNTsUw==
X-Received: by 2002:a05:622a:e0d4:10b0:535:a5f8:a5cc with SMTP id
 d75a77b69052e-535a5f8b5c9mr113956761cf.76.1791834961181; Mon, 12 Oct 2026
 12:56:01 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Oct 2026 12:55:59 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Oct 2026 12:55:59 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <as0FedYcvJvdOaq2@google.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-13-15ad654a50db@google.com> <f7b3a63c-7a1d-445f-b062-4cea5343d266@intel.com>
 <asz8GKNO9aQANr5E@google.com> <as0FedYcvJvdOaq2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Oct 2026 12:55:59 -0700
X-Gm-Features: AclHuK9--zvAlpxvHRdbaW31_YfepDcGf8JCdVJWPGaZldlrnmAD2OQLzSaLDfk
Message-ID: <CAEvNRgG3h5jgHOpHvJ_uuJv8o-mq0Jy9gXUhKcDZXfSGAfZBiA@mail.gmail.com>
Subject: Re: [PATCH v14 13/22] KVM: selftests: Support guest_memfd in-place conversion
To: Sean Christopherson <seanjc@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Lisa Wang <wyihan@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>, 
	Sagi Shahar <sagis@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> +Ashish, Tom and Mike, dropped a bunch of others that probably don't care about
> the CCP/PSP driver.
>
> On Mon, Oct 12, 2026, Sean Christopherson wrote:
>> On Tue, Aug 18, 2026, Xiaoyao Li wrote:
>> > On 7/23/2026 7:13 AM, Lisa Wang wrote:
>> > > -	flags = 0;
>> > > -	if (is_guest_memfd_required(shape))
>> > > +	if (is_guest_memfd_required(shape)) {
>> > >   		flags |= KVM_MEM_GUEST_MEMFD;
>> > > +		if (kvm_has_gmem_attributes)
>> > > +			gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED |
>> > > +				      GUEST_MEMFD_FLAG_MMAP;
>> > > +	}
>> > > -	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
>> > > +	vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags,
>> > > +		   -1, 0, gmem_flags);
>> > >   	for (i = 0; i < NR_MEM_REGIONS; i++)
>> > >   		vm->memslots[i] = 0;
>> >
>> > IMO, this diff belongs to the gmem in-place series.
>>
>> Yep, you're 100% right.  I pushed this to "coco" for now...
>>
>> diff --git tools/testing/selftests/kvm/lib/kvm_util.c tools/testing/selftests/kvm/lib/kvm_util.c
>> index 3f559f207408..0c67d964a9aa 100644
>> --- tools/testing/selftests/kvm/lib/kvm_util.c
>> +++ tools/testing/selftests/kvm/lib/kvm_util.c
>> @@ -494,6 +494,7 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
>>         u64 nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
>>                                                  nr_extra_pages);
>>         struct userspace_mem_region *slot0;
>> +       u64 gmem_flags = 0;
>>         struct kvm_vm *vm;
>>         int i, flags;
>>
>> @@ -509,10 +510,20 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
>>          * for CoCo VMs that require GUEST_MEMFD backed private memory.
>>          */
>>         flags = 0;
>> -       if (is_guest_memfd_required(shape))
>> +       if (is_guest_memfd_required(shape)) {
>>                 flags |= KVM_MEM_GUEST_MEMFD;
>>
>> -       vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
>> +               /*
>> +                * Allow mmap() and initialize the gmem instance as SHARED if
>> +                * in-place conversions are supported, so that the memory can
>> +                * be populated/initialized like any other memory region.
>> +                */
>> +               if (kvm_has_gmem_attributes)
>> +                       gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED |
>> +                                     GUEST_MEMFD_FLAG_MMAP;
>> +       }
>> +
>> +       vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags, -1, 0, gmem_flags);
>>         for (i = 0; i < NR_MEM_REGIONS; i++)
>>                 vm->memslots[i] = 0;
>>
>> but the entire in-place conversion series may need to be dropped because there's
>> a potential deadlock, and I don't see an obviously non-awful way to fix it.
>
> The underlying problem is that drivers/crypto/ccp/sev-dev.c does memory allocations
> and copy_{to,from}_user() while holding sev_cmd_mutex in a variety of locations.
>
> I genuinely think the right fix is to not do that, i.e. to perform invasive surgery
> on the driver so that it holds sev_cmd_mutex only for the operations that really
> truly need its protection.

I reached this same conclusion, and I think this is the right fix.

To add on, the main purpose of taking the invalidate lock in
kvm_gmem_fault_user_mapping() is to synchronize with
conversions. mapping.invalidate_lock is the lock used to protect
attributes.

(The maple_tree's internal RCU lock is for lockless readers (these
readers are only within KVM) and respect the KVM MMU protocol and will
check again before committing the result of the read.)

The purpose of taking the invalidate lock in the populate flow is also
to synchronize with conversions, so using a lock other than
mapping.invalidate_lock wouldn't work, both cases would still take that
other lock.

> Because taking page faults while holding a *system*-wide
> lock is asking for trouble.  Deadlock aside, if one of the user pages being accessed
> happens to be swapped out, tasks could be blocked on sev_cmd_mutex for quite some
> time waiting for the page to come back from disk or wherever.  Rinse and repeat, and
> I wouldn't be surprised if VM creation/boot can stall for hundreds of milliseconds
> or worse.
>
> The alternative would be to take sev_cmd_mutex around the kvm_gmem_populate() call
> in snp_launch_update(), but even if the CPP maintainers were willing to provide hooks

I realized you meant CCP/PSP instead of CPP :)

> to allow that, I'm not willing to take such a hack in KVM.
>

Is this a hack because sev_cmd_mutex() would be held for a long time
while the populate loop executes?

> So, very sadly, I think in-place conversion is dead for 7.4, and will need to be
> revived on top of an overhaul of sev_cmd_mutex locking.
>
> Or I guess maybe a less painful temporary workaround would be to disable support
> for SNP if in-place conversion is enabled.  That would avoid extending the in-place
> conversion bottleneck for TDX, pKVM, and CCA, without having to take a gross hack
> to make SNP play nice.
>
> E.g. this as a workaround for 7.4 (not yet tested)
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index fad72cab76cf..df885b8214d4 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3213,6 +3213,14 @@ void __init sev_hardware_setup(void)
>  	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
>
>  out:
> +	/*
> +	 * FIXME: Allow SNP with in-place guest_memfd conversion once the PSP
> +	 * driver no longer takes its global mutex outside of mmap_lock (which
> +	 * leads to deadlock with sev_gmem_post_populate()).
> +	 */
> +	if (gmem_in_place_conversion)
> +		sev_snp_supported = false;
> +

If we go with something like this, when SNP and gmem_in_place_conversion
starts to work together, would we need some kind of new CAP or other way
to advertise that guest_memfd and SNP are now friends?

If Michael/Tom/Ashish are fine with this, I'd definitely prefer some
stopgap over delaying all of conversions.

I just saw Michael's email, thank you so much for jumping on this
quickly!

>  	if (sev_enabled) {
>  		init_args.probe = true;
>
>> [ 2260.466972] ======================================================
>> [ 2260.473150] WARNING: possible circular locking dependency detected
>> [ 2260.479329] 7.3.0-smp--ce115a0096358-seanjc-soink #75 Tainted: G     U     O
>> [ 2260.486981] ------------------------------------------------------
>> [ 2260.493161] sev_snp_vmsa_pu/24505 is trying to acquire lock:
>> [ 2260.498821] ffffffffc01f7900 (sev_cmd_mutex){+.+.}-{4:4}, at: sev_issue_cmd_external_user+0x39/0x60 [ccp]
>> [ 2260.508387]
>>                but task is already holding lock:
>> [ 2260.514213] ffff93c9dd1cf070 (mapping.invalidate_lock#4){++++}-{4:4}, at: kvm_gmem_populate+0x18c/0x300 [kvm]
>> [ 2260.524275]
>>                which lock already depends on the new lock.
>>
>> [ 2260.532446]
>>                the existing dependency chain (in reverse order) is:
>> [ 2260.539917]
>>                -> #2 (mapping.invalidate_lock#4){++++}-{4:4}:
>> [ 2260.546878]        down_read+0x3d/0x160
>> [ 2260.550716]        kvm_gmem_fault_user_mapping+0x43/0x180 [kvm]
>> [ 2260.556663]        __do_fault+0x3f/0x110
>> [ 2260.560588]        do_pte_missing+0x515/0x1000
>> [ 2260.565035]        handle_mm_fault+0x7f2/0x1290
>> [ 2260.569567]        do_user_addr_fault+0x47d/0x6c0
>> [ 2260.574271]        exc_page_fault+0x67/0xa0
>> [ 2260.578458]        asm_exc_page_fault+0x26/0x30
>> [ 2260.582991]
>>                -> #1 (&mm->mmap_lock){++++}-{4:4}:
>> [ 2260.588997]        __might_fault+0x59/0x80
>> [ 2260.593096]        _copy_to_user+0x23/0x60
>> [ 2260.597197]        sev_ioctl_do_platform_status+0x50/0x80 [ccp]
>> [ 2260.603116]        sev_ioctl+0x220/0x2b0 [ccp]
>> [ 2260.607560]        __se_sys_ioctl+0x6d/0xb0
>> [ 2260.611749]        do_syscall_64+0xfe/0x460
>> [ 2260.615933]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
>> [ 2260.621506]
>>                -> #0 (sev_cmd_mutex){+.+.}-{4:4}:
>> [ 2260.627426]        __lock_acquire+0x160d/0x2940
>> [ 2260.631957]        lock_acquire+0xf1/0x300
>> [ 2260.636050]        __mutex_lock+0x8f/0xdf0
>> [ 2260.640147]        sev_issue_cmd_external_user+0x39/0x60 [ccp]
>> [ 2260.645982]        sev_gmem_post_populate+0x189/0x230 [kvm_amd]
>> [ 2260.651901]        kvm_gmem_populate+0x1ed/0x300 [kvm]
>> [ 2260.657066]        snp_launch_update+0x1a7/0x250 [kvm_amd]
>> [ 2260.662551]        sev_mem_enc_ioctl+0x371/0x3d0 [kvm_amd]
>> [ 2260.668036]        kvm_vm_ioctl+0x52c/0x580 [kvm]
>> [ 2260.672761]        __se_sys_ioctl+0x6d/0xb0
>> [ 2260.676946]        do_syscall_64+0xfe/0x460
>> [ 2260.681133]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
>> [ 2260.686706]
>>                other info that might help us debug this:
>>
>> [ 2260.694695] Chain exists of:
>>                  sev_cmd_mutex --> &mm->mmap_lock --> mapping.invalidate_lock#4
>>
>> [ 2260.706077]  Possible unsafe locking scenario:
>>
>> [ 2260.711993]        CPU0                    CPU1
>> [ 2260.716520]        ----                    ----
>> [ 2260.721052]   lock(mapping.invalidate_lock#4);
>> [ 2260.725498]                                lock(&mm->mmap_lock);
>> [ 2260.731503]                                lock(mapping.invalidate_lock#4);
>> [ 2260.738463]   lock(sev_cmd_mutex);
>> [ 2260.741868]
>>                 *** DEADLOCK ***
>>
>> [ 2260.747778] locks held by sev_snp_vmsa_pu/24505: 3, last CPU#35:
>> [ 2260.753785]  #0: ffff93c9d54bd3a8 (&kvm->lock){+.+.}-{4:4}, at: sev_mem_enc_ioctl+0x73/0x3d0 [kvm_amd]
>> [ 2260.763083]  #1: ffff93c9d54bc0a0 (&kvm->slots_lock){+.+.}-{4:4}, at: snp_launch_update+0x145/0x250 [kvm_amd]
>> [ 2260.772991]  #2: ffff93c9dd1cf070 (mapping.invalidate_lock#4){++++}-{4:4}, at: kvm_gmem_populate+0x18c/0x300 [kvm]
>> [ 2260.783356]
>>                stack backtrace:
>> [ 2260.787718] CPU: 35 UID: 0 PID: 24505 Comm: sev_snp_vmsa_pu Tainted: G     U     O        7.3.0-smp--ce115a0096358-seanjc-soink #75 PREEMPT
>> [ 2260.800310] Tainted: [U]=USER, [O]=OOT_MODULE
>> [ 2260.804668] Hardware name: Google, Inc.                                                       Arcadia_IT_80/Arcadia_IT_80, BIOS 34.86.0-102 01/25/2026
>> [ 2260.818127] Call Trace:
>> [ 2260.820579]  <TASK>
>> [ 2260.822687]  dump_stack_lvl+0x54/0x70
>> [ 2260.826351]  print_circular_bug+0x2e4/0x300
>> [ 2260.830537]  check_noncircular+0xf5/0x120
>> [ 2260.834553]  __lock_acquire+0x160d/0x2940
>> [ 2260.838565]  ? __lock_acquire+0x65e/0x2940
>> [ 2260.842664]  ? rcu_is_watching+0x11/0x40
>> [ 2260.846587]  ? trace_sched_exit_tp+0x25/0xb0
>> [ 2260.850861]  lock_acquire+0xf1/0x300
>> [ 2260.854440]  ? sev_issue_cmd_external_user+0x39/0x60 [ccp]
>> [ 2260.859928]  ? lock_is_held_type+0xc7/0x120
>> [ 2260.864112]  ? sev_issue_cmd_external_user+0x39/0x60 [ccp]
>> [ 2260.869599]  __mutex_lock+0x8f/0xdf0
>> [ 2260.873178]  ? sev_issue_cmd_external_user+0x39/0x60 [ccp]
>> [ 2260.878663]  ? pfn_valid+0x89/0x220
>> [ 2260.882155]  ? pfn_valid+0x1fb/0x220
>> [ 2260.885736]  ? lookup_address+0x49/0x70
>> [ 2260.889577]  sev_issue_cmd_external_user+0x39/0x60 [ccp]
>> [ 2260.894890]  sev_gmem_post_populate+0x189/0x230 [kvm_amd]
>> [ 2260.900289]  kvm_gmem_populate+0x1ed/0x300 [kvm]
>> [ 2260.904938]  ? snp_bind_asid+0xd0/0xd0 [kvm_amd]
>> [ 2260.909561]  snp_launch_update+0x1a7/0x250 [kvm_amd]
>> [ 2260.914528]  sev_mem_enc_ioctl+0x371/0x3d0 [kvm_amd]
>> [ 2260.919493]  kvm_vm_ioctl+0x52c/0x580 [kvm]
>> [ 2260.923706]  ? kvm_gmem_ioctl+0x192/0x1e0 [kvm]
>> [ 2260.928266]  __se_sys_ioctl+0x6d/0xb0
>> [ 2260.931930]  do_syscall_64+0xfe/0x460
>> [ 2260.935595]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
>> [ 2260.940822]  ? trace_irq_disable+0x25/0xc0
>> [ 2260.944921]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>> [ 2260.949972] RIP: 0033:0x474bdb
>> [ 2260.953031] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
>> [ 2260.971770] RSP: 002b:00007ffd188ac3f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> [ 2260.979337] RAX: ffffffffffffffda RBX: 0000000028691b30 RCX: 0000000000474bdb
>> [ 2260.986468] RDX: 00007ffd188ac4a0 RSI: 00000000c008aeba RDI: 0000000000000007
>> [ 2260.993600] RBP: 0000000000135000 R08: 00000000004d50b8 R09: 00000000004e1b78
>> [ 2261.000734] R10: 0000000000000002 R11: 0000000000000246 R12: 00007ffd188ac4c0
>> [ 2261.007867] R13: 0000000000137000 R14: 0000000028693db0 R15: 0000000000137000
>> [ 2261.015001]  </TASK>
>>
