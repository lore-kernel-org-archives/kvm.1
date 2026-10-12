Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37C749CF54
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818782; cv=none; b=XwTjLdzsmXEzmrgsNSkD0U2QC6h85R9nVv3RiAh4WxiCJI/hZXPjQKrSZpTkcgUk+y8r9HWWpZq+UpcuRVlHXHXdcxiEKt4XzdPlVbJ8XSKgUL6NVLIKzvfSOkXl9WlT7ZhHyQSfOJ7e1XeWLaBVQnTbYZGDp8M2Q+vcqEty91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818782; c=relaxed/simple;
	bh=r4xS8qfNNip730dRIttM9p9vhzXPPetzgmX8Jzhtz04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bcVyPupMOgoebF6zefzpFr4+yANwTIu150XCn7FyDf/o64hXXTDcg0Ruy3Q0tZrqsy+tGFgXnygsYOkaTP/MWp12NVKPuJpm/ILoQn5miTYWNHscFcgM8vdEnUgWYKZTLKNhF2j8MNR7NAnlhA8Yv2JaYRbxoioJIwi7k1wxEj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XE1UZivP; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XE1UZivP"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so1555408a91.1
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791818777; x=1792423577; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuORvPXGU1IelcH358psfnrLkQ757pvSe+rshYdO0wU=;
        b=XE1UZivPLi+WvufAE+WmhUCqiVPVWoj6P2pxJhhtPYukpGyKlj27X3GZxWydIeUETx
         pmJiQTn64bM4pbZtb23rafEqyW4XJknl9/UJQ7NUKAC9mgEf3o55+/SxHutm1YRXCQNd
         Z8P+xhaUWLIk+n5Cuf4oXm9JOt/DaSefu2YSHDeL57QPeh+vjxFBLleMZBIMipJs2ueC
         obcN61ONM0aV/9lpG6/kcp7JIe6fxwakJC97sglRXe0UzGZ5S2MvhuZNQDkalmes5nZo
         Xbarjdf4Xw+UoqxVPf7GdgmsTiEy0/de+qnmVE7iBAEq33GdWBONfTBZb7FV+Hj3jp8L
         c/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818777; x=1792423577;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FuORvPXGU1IelcH358psfnrLkQ757pvSe+rshYdO0wU=;
        b=AKwYUagR0+amThLF/tTtcAYRKB822YtnbIdQqOEDM8BXjcQXV9u4vrmv0vcEWRQQuo
         msA7nrHUPctY1iEOkOiKCBzpdyMmTptntRGbfHE5tgzOZyIacZCs6icIqGMN56hSn6wx
         wBvN9SQ/bV0Ps5jRBM2U2PsvJgtwbAs7ZpyMazbkAiQMOZnK+XcXQYqvmoVIRGwsh3Q8
         gKd+BaBqYIW+/3QrP30tSL3RUknZEPZCzqAfJwQYnlarzk5opA0AZEzSvT7qKUFOsFI2
         j+EX4tlA/nTf/IWQEPsj6tU1GT7aET1CSlKuE3xuJmmNnToVObp4h0niEKEpW3yWFCeA
         w6fw==
X-Forwarded-Encrypted: i=1; AKwUvBxzl2pW7w445RFv8hJrsr4ijaCBmRIdSg0Tkqu8D4LpqiBCNLdudLUWFI4SPtNJzG2xXy8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkn0zPKyjpi/BpW7uc+FlkP0ETMDR8ifKe2rU5UQ7ItA+RXleH
	X4LNNu1t2rV/KGDUxAGRa5bEOWq6QSbAglX2wFfSozezISYVkNymNU/IdJtsMQmX5oA5aaFyB1z
	VqXcSfQ==
X-Received: from pjbrs15.prod.google.com ([2002:a17:90b:2b8f:b0:3a8:434e:45b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da8b:b0:3ac:1c76:61a9
 with SMTP id 98e67ed59e1d1-3ac1c767e0fmr1361340a91.13.1791818776719; Mon, 12
 Oct 2026 08:26:16 -0700 (PDT)
Date: Mon, 12 Oct 2026 08:26:16 -0700
In-Reply-To: <f7b3a63c-7a1d-445f-b062-4cea5343d266@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-13-15ad654a50db@google.com> <f7b3a63c-7a1d-445f-b062-4cea5343d266@intel.com>
Message-ID: <asz8GKNO9aQANr5E@google.com>
Subject: Re: [PATCH v14 13/22] KVM: selftests: Support guest_memfd in-place conversion
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ackerley Tng <ackerleytng@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Ira Weiny <ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>, 
	Sagi Shahar <sagis@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 18, 2026, Xiaoyao Li wrote:
> On 7/23/2026 7:13 AM, Lisa Wang wrote:
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index 4a48c4b42095..e547ea341ff7 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -484,8 +484,10 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
> >   	u64 nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
> >   						 nr_extra_pages);
> >   	struct userspace_mem_region *slot0;
> > +	u64 gmem_flags = 0;
> >   	struct kvm_vm *vm;
> > -	int i, flags;
> > +	int flags = 0;

Don't make unnecessary changes.  It's not just a "nice to have" thing, e.g. in
this case this results in extra conflicts with other changes.

> > +	int i;
> >   	kvm_set_files_rlimit(nr_runnable_vcpus);
> > @@ -495,14 +497,20 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
> >   	vm = ____vm_create(shape);
> >   	/*
> > -	 * Force GUEST_MEMFD for the primary memory region if necessary, e.g.
> > -	 * for CoCo VMs that require GUEST_MEMFD backed private memory.
> > +	 * Force GUEST_MEMFD for the primary memory region if necessary, and
> > +	 * initialize it as shared if in-place conversion is support, so the
> > +	 * selftest framework can populate it exactly like other memory
> > +	 * providers.
> >   	 */

Leave the existing comment as is.  The new comment should be anchored to the code
below.

> > -	flags = 0;
> > -	if (is_guest_memfd_required(shape))
> > +	if (is_guest_memfd_required(shape)) {
> >   		flags |= KVM_MEM_GUEST_MEMFD;
> > +		if (kvm_has_gmem_attributes)
> > +			gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED |
> > +				      GUEST_MEMFD_FLAG_MMAP;
> > +	}
> > -	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
> > +	vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags,
> > +		   -1, 0, gmem_flags);
> >   	for (i = 0; i < NR_MEM_REGIONS; i++)
> >   		vm->memslots[i] = 0;
> 
> IMO, this diff belongs to the gmem in-place series.

Yep, you're 100% right.  I pushed this to "coco" for now...

diff --git tools/testing/selftests/kvm/lib/kvm_util.c tools/testing/selftests/kvm/lib/kvm_util.c
index 3f559f207408..0c67d964a9aa 100644
--- tools/testing/selftests/kvm/lib/kvm_util.c
+++ tools/testing/selftests/kvm/lib/kvm_util.c
@@ -494,6 +494,7 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
        u64 nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
                                                 nr_extra_pages);
        struct userspace_mem_region *slot0;
+       u64 gmem_flags = 0;
        struct kvm_vm *vm;
        int i, flags;
 
@@ -509,10 +510,20 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
         * for CoCo VMs that require GUEST_MEMFD backed private memory.
         */
        flags = 0;
-       if (is_guest_memfd_required(shape))
+       if (is_guest_memfd_required(shape)) {
                flags |= KVM_MEM_GUEST_MEMFD;
 
-       vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
+               /*
+                * Allow mmap() and initialize the gmem instance as SHARED if
+                * in-place conversions are supported, so that the memory can
+                * be populated/initialized like any other memory region.
+                */
+               if (kvm_has_gmem_attributes)
+                       gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED |
+                                     GUEST_MEMFD_FLAG_MMAP;
+       }
+
+       vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags, -1, 0, gmem_flags);
        for (i = 0; i < NR_MEM_REGIONS; i++)
                vm->memslots[i] = 0;

but the entire in-place conversion series may need to be dropped because there's
a potential deadlock, and I don't see an obviously non-awful way to fix it.

[ 2260.466972] ======================================================
[ 2260.473150] WARNING: possible circular locking dependency detected
[ 2260.479329] 7.3.0-smp--ce115a0096358-seanjc-soink #75 Tainted: G     U     O       
[ 2260.486981] ------------------------------------------------------
[ 2260.493161] sev_snp_vmsa_pu/24505 is trying to acquire lock:
[ 2260.498821] ffffffffc01f7900 (sev_cmd_mutex){+.+.}-{4:4}, at: sev_issue_cmd_external_user+0x39/0x60 [ccp]
[ 2260.508387] 
               but task is already holding lock:
[ 2260.514213] ffff93c9dd1cf070 (mapping.invalidate_lock#4){++++}-{4:4}, at: kvm_gmem_populate+0x18c/0x300 [kvm]
[ 2260.524275] 
               which lock already depends on the new lock.

[ 2260.532446] 
               the existing dependency chain (in reverse order) is:
[ 2260.539917] 
               -> #2 (mapping.invalidate_lock#4){++++}-{4:4}:
[ 2260.546878]        down_read+0x3d/0x160
[ 2260.550716]        kvm_gmem_fault_user_mapping+0x43/0x180 [kvm]
[ 2260.556663]        __do_fault+0x3f/0x110
[ 2260.560588]        do_pte_missing+0x515/0x1000
[ 2260.565035]        handle_mm_fault+0x7f2/0x1290
[ 2260.569567]        do_user_addr_fault+0x47d/0x6c0
[ 2260.574271]        exc_page_fault+0x67/0xa0
[ 2260.578458]        asm_exc_page_fault+0x26/0x30
[ 2260.582991] 
               -> #1 (&mm->mmap_lock){++++}-{4:4}:
[ 2260.588997]        __might_fault+0x59/0x80
[ 2260.593096]        _copy_to_user+0x23/0x60
[ 2260.597197]        sev_ioctl_do_platform_status+0x50/0x80 [ccp]
[ 2260.603116]        sev_ioctl+0x220/0x2b0 [ccp]
[ 2260.607560]        __se_sys_ioctl+0x6d/0xb0
[ 2260.611749]        do_syscall_64+0xfe/0x460
[ 2260.615933]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 2260.621506] 
               -> #0 (sev_cmd_mutex){+.+.}-{4:4}:
[ 2260.627426]        __lock_acquire+0x160d/0x2940
[ 2260.631957]        lock_acquire+0xf1/0x300
[ 2260.636050]        __mutex_lock+0x8f/0xdf0
[ 2260.640147]        sev_issue_cmd_external_user+0x39/0x60 [ccp]
[ 2260.645982]        sev_gmem_post_populate+0x189/0x230 [kvm_amd]
[ 2260.651901]        kvm_gmem_populate+0x1ed/0x300 [kvm]
[ 2260.657066]        snp_launch_update+0x1a7/0x250 [kvm_amd]
[ 2260.662551]        sev_mem_enc_ioctl+0x371/0x3d0 [kvm_amd]
[ 2260.668036]        kvm_vm_ioctl+0x52c/0x580 [kvm]
[ 2260.672761]        __se_sys_ioctl+0x6d/0xb0
[ 2260.676946]        do_syscall_64+0xfe/0x460
[ 2260.681133]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 2260.686706] 
               other info that might help us debug this:

[ 2260.694695] Chain exists of:
                 sev_cmd_mutex --> &mm->mmap_lock --> mapping.invalidate_lock#4

[ 2260.706077]  Possible unsafe locking scenario:

[ 2260.711993]        CPU0                    CPU1
[ 2260.716520]        ----                    ----
[ 2260.721052]   lock(mapping.invalidate_lock#4);
[ 2260.725498]                                lock(&mm->mmap_lock);
[ 2260.731503]                                lock(mapping.invalidate_lock#4);
[ 2260.738463]   lock(sev_cmd_mutex);
[ 2260.741868] 
                *** DEADLOCK ***

[ 2260.747778] locks held by sev_snp_vmsa_pu/24505: 3, last CPU#35:
[ 2260.753785]  #0: ffff93c9d54bd3a8 (&kvm->lock){+.+.}-{4:4}, at: sev_mem_enc_ioctl+0x73/0x3d0 [kvm_amd]
[ 2260.763083]  #1: ffff93c9d54bc0a0 (&kvm->slots_lock){+.+.}-{4:4}, at: snp_launch_update+0x145/0x250 [kvm_amd]
[ 2260.772991]  #2: ffff93c9dd1cf070 (mapping.invalidate_lock#4){++++}-{4:4}, at: kvm_gmem_populate+0x18c/0x300 [kvm]
[ 2260.783356] 
               stack backtrace:
[ 2260.787718] CPU: 35 UID: 0 PID: 24505 Comm: sev_snp_vmsa_pu Tainted: G     U     O        7.3.0-smp--ce115a0096358-seanjc-soink #75 PREEMPT 
[ 2260.800310] Tainted: [U]=USER, [O]=OOT_MODULE
[ 2260.804668] Hardware name: Google, Inc.                                                       Arcadia_IT_80/Arcadia_IT_80, BIOS 34.86.0-102 01/25/2026
[ 2260.818127] Call Trace:
[ 2260.820579]  <TASK>
[ 2260.822687]  dump_stack_lvl+0x54/0x70
[ 2260.826351]  print_circular_bug+0x2e4/0x300
[ 2260.830537]  check_noncircular+0xf5/0x120
[ 2260.834553]  __lock_acquire+0x160d/0x2940
[ 2260.838565]  ? __lock_acquire+0x65e/0x2940
[ 2260.842664]  ? rcu_is_watching+0x11/0x40
[ 2260.846587]  ? trace_sched_exit_tp+0x25/0xb0
[ 2260.850861]  lock_acquire+0xf1/0x300
[ 2260.854440]  ? sev_issue_cmd_external_user+0x39/0x60 [ccp]
[ 2260.859928]  ? lock_is_held_type+0xc7/0x120
[ 2260.864112]  ? sev_issue_cmd_external_user+0x39/0x60 [ccp]
[ 2260.869599]  __mutex_lock+0x8f/0xdf0
[ 2260.873178]  ? sev_issue_cmd_external_user+0x39/0x60 [ccp]
[ 2260.878663]  ? pfn_valid+0x89/0x220
[ 2260.882155]  ? pfn_valid+0x1fb/0x220
[ 2260.885736]  ? lookup_address+0x49/0x70
[ 2260.889577]  sev_issue_cmd_external_user+0x39/0x60 [ccp]
[ 2260.894890]  sev_gmem_post_populate+0x189/0x230 [kvm_amd]
[ 2260.900289]  kvm_gmem_populate+0x1ed/0x300 [kvm]
[ 2260.904938]  ? snp_bind_asid+0xd0/0xd0 [kvm_amd]
[ 2260.909561]  snp_launch_update+0x1a7/0x250 [kvm_amd]
[ 2260.914528]  sev_mem_enc_ioctl+0x371/0x3d0 [kvm_amd]
[ 2260.919493]  kvm_vm_ioctl+0x52c/0x580 [kvm]
[ 2260.923706]  ? kvm_gmem_ioctl+0x192/0x1e0 [kvm]
[ 2260.928266]  __se_sys_ioctl+0x6d/0xb0
[ 2260.931930]  do_syscall_64+0xfe/0x460
[ 2260.935595]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 2260.940822]  ? trace_irq_disable+0x25/0xc0
[ 2260.944921]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 2260.949972] RIP: 0033:0x474bdb
[ 2260.953031] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[ 2260.971770] RSP: 002b:00007ffd188ac3f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 2260.979337] RAX: ffffffffffffffda RBX: 0000000028691b30 RCX: 0000000000474bdb
[ 2260.986468] RDX: 00007ffd188ac4a0 RSI: 00000000c008aeba RDI: 0000000000000007
[ 2260.993600] RBP: 0000000000135000 R08: 00000000004d50b8 R09: 00000000004e1b78
[ 2261.000734] R10: 0000000000000002 R11: 0000000000000246 R12: 00007ffd188ac4c0
[ 2261.007867] R13: 0000000000137000 R14: 0000000028693db0 R15: 0000000000137000
[ 2261.015001]  </TASK>
