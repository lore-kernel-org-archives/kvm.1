Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAB5328B4B
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786129867; cv=none; b=W9VpdoqnjNIPxKmuwKjA5P7mNh2DCMR/KqGzvf72Ycm5P/XdZweO0/dg7zGkHXJ3mKoRyroSJ3GiFFgcbm+LxszibWb+ZTuMDHqLFR5kZPyMtP1LC20s2eoYWbHHRdVq0ALymft9Q9QxZLxINzpbFVfUcaxCtgtDLgfmHLeOA8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786129867; c=relaxed/simple;
	bh=8+7e+SOvMIMJWj8aydFmApQxqF94aJTOOymoIZpuYME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KLAr3YnY8kH8m2ZIG9pcs1kUkXcd8TVXQzcy5u+An5ZVcm1xSo7dgZUKUWo9GRPfSfIsH3OB9UH8goDsy2KiZ1g+AtT9HwrBFf3/BP+h/XpFsdegY8IhPmaBw/5i7fw12Cxqsp1gmy9QspTaQrdukRxlzvsUYpMVBRhUE2ZBVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=byFmlSvj; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="byFmlSvj"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb4bd11ddf8so3973610a12.3
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 12:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786129865; x=1786734665; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pEoaFtbBw4uM/HC2SCgHUUoy2AlMce3ARxmiATtbCDs=;
        b=byFmlSvjUT05leHDx07ETS17/AficWgibdyPMqT4mENRD71q3kZ0B9p6AOro8jO/rj
         ZKG3Qrio+elINiZD3idZEDW9FRdcVmSbU9xflagDd1uVFJPrW6Ol2kiOojld4hLelO0p
         QAt0XyrI+iXGcQOgNdycRu58dn35/dv5ww8gh8qJap+vqN2MgggypeXPJh1LHaehQWNq
         tHryK83XjmmYxqqDTKoz0Lbv719O1PXCnm/dYnxI7lQNtaBlPEiox5eNRRBo9yoSpDJS
         052RL8WmIJsnUkR7xzxj0p46wMp/qyGUAK3MzHmwJOa78yDl5Xsx72s08yhfpv1rJm4i
         r3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786129865; x=1786734665;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pEoaFtbBw4uM/HC2SCgHUUoy2AlMce3ARxmiATtbCDs=;
        b=dSTTW0qdGxGbSeKU7Sbet7/drQcN6xkapk70VjVKFJaVr82e1IJrVhKNKxW18Q8A3M
         96LUTqFlZ/f1OX3M9Qs2A9vf57Pq6RBZubAQQ49d8OG+j0//ly+JdHVZeHyCaYYeXCKN
         5RbzAQCulpESV54BW3BQZu1bLlniH1iNpt0FzP+XUV+MYGBq9aCOi3gqwF9tS/+UVdha
         lHevRg+SmLvCjuHWx0wLCVa91zIWj4r4Gwk81E8sPx1HH+C+mhboyFsyP9pek+ov/6Gh
         LW91a8tyoDqQ0to4RER6pBJ5uOv/ucTQ9rFeF8JHRSND7wj14G4r6aQKRCUvLCRU3XxY
         5CLA==
X-Forwarded-Encrypted: i=1; AHgh+RrtMBukOCPCLvDYtm+d3uivcEDz5ojfOQiQBw4rU3dxpNwrQyFXNpjkDH6XXLNH6qxvN0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWuMXEbIzEXdKqqWj/hRkGH2YaMi0ln7X21R85ic3UlhEygtDR
	DbYRDBNIyK+vQSYibiBFmXZXVw5mjiSEGsF4HQbD6cwdak3Gf/PUD2LZwQwQw0voBsEsLhG6/N4
	vjtpdIw==
X-Received: from pgmc25.prod.google.com ([2002:a63:1c59:0:b0:cbd:2000:e6f4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3398:b0:3c1:c6e:9360
 with SMTP id adf61e73a8af0-3cbce974faemr2952166637.32.1786129864862; Fri, 07
 Aug 2026 12:11:04 -0700 (PDT)
Date: Fri, 7 Aug 2026 12:11:04 -0700
In-Reply-To: <6d8ac2f9487e5a00745be5fadac3f83679cae99f.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806214050.78058-1-seanjc@google.com> <20260806214050.78058-2-seanjc@google.com>
 <6d8ac2f9487e5a00745be5fadac3f83679cae99f.camel@intel.com>
Message-ID: <anYtyBPskIAJlFlt@google.com>
Subject: Re: [PATCH 1/4] KVM: x86/mmu: Reload MMU on *every* page pre-fault attempt/iteration
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kai Huang <kai.huang@intel.com>, 
	Yan Y Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 07, 2026, Rick P Edgecombe wrote:
> On Thu, 2026-08-06 at 14:40 -0700, Sean Christopherson wrote:
> > Reload the MMU (which is a nop if the MMU doesn't need to be reloaded) on
> > every attempt to pre-fault a guest page, i.e. when the page fault path
> > signals that the caller should retry.  If the synchronize_srcu_expedited()
> > in kvm_invalidate_memslot() completes before kvm_vcpu_pre_fault_memory()
> > grabs SRCU, but kvm_mmu_reload() in the pre-fault path completes before
> > kvm_invalidate_memslot() triggers x86's "fast zap all", then the pre-fault
> > task will reach kvm_tdp_page_prefault() with an invalid root.
> > 
> > Attempting to fault-in memory with an invalid root ultimately puts
> > kvm_tdp_page_prefault() into an infinite (breakable) retry loop, which
> > manifests most obviously as a hang in the pre_fault_memory_test selftest,
> > but also eventually causes RCU (SRCU?) to complain.
> > 
> >   INFO: rcu_tasks detected stalls on tasks:
> >   000000000cda47bd: .. nvcsw: 6/6 holdout: 1 idle_cpu: -1/25
> >   task:pre_fault_memor state:R  running task     stack:12696
> >   pid:95588 tgid:95588 ppid:95584  task_flags:0x400000 flags:0x00080801
> >   Call Trace:
> >    <TASK>
> >    lock_release+0x4e/0x320
> >    __get_user_pages+0x546/0xcd0
> >    up_read+0x1b/0x30
> >    get_user_pages_unlocked+0xee/0x350
> >    hva_to_pfn+0xd3/0x3d0 [kvm]
> >    lock_release+0x4e/0x320
> >    xa_load+0x5c/0x170
> >    xa_load+0x14c/0x170
> >    __kvm_faultin_pfn+0xd9/0x130 [kvm]
> >    lock_acquire+0x65/0x2b0
> >    lock_release+0x4e/0x320
> >    kvm_mmu_faultin_pfn+0x1e1/0x690 [kvm]
> >    gup_fast_fallback+0x63e/0xdf0
> >    kvm_tdp_page_fault+0xeb/0x140 [kvm]
> >    kvm_mmu_do_page_fault+0x12e/0x200 [kvm]
> >    kvm_arch_vcpu_pre_fault_memory+0x16e/0x200 [kvm]
> >    kvm_vcpu_pre_fault_memory+0xc1/0x1f0 [kvm]
> >    kvm_vcpu_pre_fault_memory+0x116/0x1f0 [kvm]
> >    kvm_vcpu_ioctl+0x3a4/0x6b0 [kvm]
> >    clockevents_program_event+0x5d/0x170
> >    __se_sys_ioctl+0x6d/0xb0
> >    entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >    do_syscall_64+0x10a/0x480
> >    __irq_exit_rcu+0x8e/0x140
> >    entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >    </TASK>
> > 
> > Fixes: 6e01b7601dfe ("KVM: x86: Implement kvm_arch_vcpu_pre_fault_memory()")
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> 
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> But, did you hit this somehow with an unmodified test and kernel? The log makes
> me think it was hit in a normal test run. (which I failed to reproduce)

Yes and yes.  I often test by running all selftests in parallel.  My guess is that
PREEMPT_LAZY plus oversubscribed CPUs allowed the timing condition to be hit.  It
wasn't anywhere near 100% reproducible on my end either, maybe 1 out of every 10
runs?  20 runs?  (of the entire suite of selftests).

P.S. I was very proud of myself: because the failure was so flaky, I used perf
and bpftrace to debug the issue instead of my usual hack-the-kernel approach. :-)
