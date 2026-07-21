Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF06445DF60
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675795; cv=none; b=IUBhUjOvKWREBEsnPg3cnag0a33sXuq2SIc1nvQ/u//S4zkvPf5wcKFigC55Pt/w3l/FR1H/ZCuJVnVE8heQ4uCri3i8T2Qilys3BFPQGqZGMTpqHA3bNl2XxzdEri/WbkL0UYjdqngpn/58AAeaky7X1mMLgPQ/DzVl0BYEcP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675795; c=relaxed/simple;
	bh=Rq70YB5wvuBY11YYUxc575/F50J3oUaqfmOQ2MXUECA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQOZPvroF/z3Hr0fzjQMKJT70JMq0VcLPWq8KF9R78Se6NBqr/ayMf+h2VIZ1nOA8Cvi6bIZSlsmEZAz4Gbelpd6FNKtJwUgxI+uRfw0bnVPENSFBnT1gEz0ReUyshr9WrCwrLvyCuVZzmoni5lKrICy4aDnLS4o3NowxwfLYPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HeJlgKuH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HeJlgKuH"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ccdf36f63dso605775ad.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 16:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784675793; x=1785280593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YTeUMJ8fGG4D2+fB7l4SqWT2YEzPSI0An+cEWlkWt3c=;
        b=HeJlgKuHcAZRwGttOzB0CDT9rDRw424J7ABVnmfYt4Q0rFulopD+Mpeq1jiZeR1OUP
         sPiXuh6cebk4DcutePgBgGQFYJna2/7gxvEtYD0dOOGsj8YEjq8Y+aoKpGUtelInph1W
         k6Ptn/tucxKfGDehcOrrjNnEP0JRNwWo5g4MLSQVZ9DiLzDGKZKWKFsWBP5MyemdNz37
         PYzSnx7F075p6PgWhszOhgpN3x2m60iD/Uc6L07FdlaSLuHKOS6+QKguDgrABpxdHldm
         HUUDQtuQyl13juvLgnVOIzwuW3yzoVMh7H2HtQTvzA6+N4XalCBb9FinHzYjRF1ZqOxU
         +XuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675793; x=1785280593;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YTeUMJ8fGG4D2+fB7l4SqWT2YEzPSI0An+cEWlkWt3c=;
        b=EAavn+Q1uJTGMOGOfkSckWzXtbSoVqIkKijriUcu3QUUHfkG47CjM21NP5OLRqaU7o
         QVmUOl9L6lGRvRJ3b7X9zpe8PpvnbH/PGwy+qkGiF6CbnPGhP+yxzyxH305uu4EF3dFn
         jQdKNd0wb6fJIMtNJJDbYlNo3E8TIk3ALqh34i7Jxuen2g9WRoyFhksNaNzmfqZGuWKm
         NW+bm5MQLxbeehVPHzZS7yI2zwb8FcYNgwn359+LCVobrgiZ8WXIjPXY35BW4BTOcdqd
         vzHLV32aDwKNVF9Sa4802SUANXeisyOntMOyUXNq/cFIbkuU77ZX6I9tFXRSwErSwEaT
         KdRw==
X-Forwarded-Encrypted: i=1; AHgh+RqjPNcPY4nOt+wz332n0K0pWA1fzUQv+B58L6/oASMWM5uGZ0ZAi4kgffg9lwK/qQXjxH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Dt3+dlV4j1LRpKAbNsz10WuVT8Xshl5cgV3pv6N2c6egfVAC
	nwuwzriKbK+SJc8lBh4e8iiiu9QBgwipRUpAVP3dZ5lXSlhTqRwrXxQd0AoK9srC
X-Gm-Gg: AR+sD10/M/eRUWFZqXUrQIMfYDQJbcM0XCAEkQgOm+16RH/4LDudE+ZgVLReizhguhw
	VC0SjT7xt6gvwaX8hWP0Hqw96dImHJ32r7HL5MpCF8f0OpfGn8XkcwgNohTrmJP97xc9dzhRC84
	UNkxE0Ga25vgpts5OG6Vf7gIKq2NLbWo6AZUwQvZtlI2xLVwPGWNxQNNPJFpwF4BbiNUITwQgMx
	PixeY8TD7UgrZ53KTRx1crSmVGlEoEKfTUbDuUoFTTXzwRcrWd16PBdBgBIlM8go1i5XEPp3IBd
	UnLf3fclmUI6rlJfaVrzyZB0JQUyp+k+KtRZ/ZO5t/xh44mArQuLUP5imMaa9pD62ak7z7h5eyE
	DKVU1Lnw/YR2f5JKikbOJ9xh9F6SMsLLJ8D5vZT4oifXuKbH1crPNHeOwxac7YPLCjzvsrM4xEo
	yt3NYy9MdYGHYTLqC88J8rsu7YNk40fmP6
X-Received: by 2002:a17:903:166e:b0:2ca:be81:b469 with SMTP id d9443c01a7336-2cf8f0f6fc8mr1987375ad.0.1784675792455;
        Tue, 21 Jul 2026 16:16:32 -0700 (PDT)
Received: from google.com (66.68.82.34.bc.googleusercontent.com. [34.82.68.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efae5aesm4141155ad.15.2026.07.21.16.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:16:30 -0700 (PDT)
Date: Tue, 21 Jul 2026 23:16:25 +0000
From: Josh Hilke <jrhilke@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, graf@amazon.com, 
	jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, julianr@linux.ibm.com, 
	kees@kernel.org, kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, 
	lukas@wunner.de, mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v5 06/20] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <al_8v_I9Z2Dc_qjc@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-7-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714151505.3466855-7-vipinsh@google.com>

On Tue, Jul 14, 2026 at 08:14:51AM -0700, Vipin Sharma wrote:
> +static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
> +{
> +	struct vfio_device *device = vfio_device_from_file(args->file);
> +	struct vfio_pci_core_device *vdev;
> +	struct pci_dev *pdev;
> +
> +	vdev = container_of(device, struct vfio_pci_core_device, vdev);
> +	pdev = vdev->pdev;
> +
> +	guard(mutex)(&device->dev_set->lock);
> +	guard(mutex)(&vdev->igate);
> +	guard(rwsem_write)(&vdev->memory_lock);
> +
> +	/*
> +	 * Userspace must disable interrupts on the device prior to freeze so
> +	 * that the device does not send any interrupts until new interrupt
> +	 * handlers have been established by the next kernel.
> +	 */
> +	if (vdev->irq_type != VFIO_PCI_NUM_IRQS) {
> +		pci_err(pdev, "Freeze failed! Interrupts are still enabled.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (pdev->current_state != PCI_D0) {
> +		pci_err(pdev, "Freeze failed! Device not in D0 state.\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Reset is a temporary measure to provide kernel after kexec a clean
> +	 * device while VFIO live update work is under development and not
> +	 * fully supported. It will go away once continuous DMA support is
> +	 * added to device preservation.
> +	 */
> +	vfio_pci_zap_bars(vdev);
> +	vfio_pci_dma_buf_move(vdev, true);
> +	vfio_pci_core_try_reset(vdev);
> +	pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
> +	/*
> +	 * Userspace cannot use the FD correctly now irrespective of liveupdate
> +	 * freeze failing or succeeding. They will have to reinitialize the VFIO
> +	 * device to continue using it as reset might have loaded default PCI
> +	 * state. Disable ioctl, read, write and mmap access to the device.
> +	 */
> +	smp_store_release(&vdev->liveupdate_frozen, true);
> +	return 0;
>  }

I'm seeing the same lockdep splat the David found in v4.
https://lore.kernel.org/all/ag-aFA1BJxdJMywr@google.com/#t

======================================================
WARNING: possible circular locking dependency detected
7.2.0-dbg-DEV #3 Tainted: G S
------------------------------------------------------
kexec/13355 is trying to acquire lock:
ff3f086c95315d08 (&group->mutex){+.+.}-{4:4}, at: pci_dev_reset_iommu_prepare+0x6e/0x200

but task is already holding lock:
ff3f082de7f399a8 (&vdev->memory_lock){++++}-{4:4}, at: vfio_pci_liveupdate_freeze+0x58/0x100

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&vdev->memory_lock){++++}-{4:4}:
       down_read+0x3d/0x160
       vfio_pci_mmap_huge_fault+0xb9/0x150
       __do_fault+0x46/0x150
       do_pte_missing+0x21a/0x1000
       handle_mm_fault+0x7f8/0xb60
       do_user_addr_fault+0x476/0x6c0
       exc_page_fault+0x68/0xa0
       asm_exc_page_fault+0x26/0x30

-> #4 (&mm->mmap_lock){++++}-{4:4}:
       __might_fault+0x5e/0x80
       _copy_to_user+0x23/0x60
       perf_read+0x114/0x310
       vfs_read+0xe7/0x360
       ksys_read+0x73/0x100
       do_syscall_64+0x15f/0x4e0
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&cpuctx_mutex){+.+.}-{4:4}:
       __mutex_lock+0x8c/0xd80
       perf_event_ctx_lock_nested+0x15a/0x210
       perf_event_enable+0x18/0xa0
       lockup_detector_online_cpu+0x22/0x30
       cpuhp_invoke_callback+0xfb/0x2c0
       cpuhp_thread_fun+0x164/0x1e0
       smpboot_thread_fn+0x17e/0x280
       kthread+0x10c/0x140
       ret_from_fork+0x16b/0x310
       ret_from_fork_asm+0x1a/0x30

-> #2 (cpuhp_state-up){+.+.}-{0:0}:
       cpuhp_thread_fun+0x95/0x1e0
       smpboot_thread_fn+0x17e/0x280
       kthread+0x10c/0x140
       ret_from_fork+0x16b/0x310
       ret_from_fork_asm+0x1a/0x30

-> #1 (cpu_hotplug_lock){++++}-{0:0}:
       cpus_read_lock+0x3b/0xd0
       __cpuhp_state_add_instance+0x19/0x40
       iova_domain_init_rcaches+0x1ef/0x230
       iommu_setup_dma_ops+0x18a/0x560
       iommu_device_register+0x188/0x220
       intel_iommu_init+0x35a/0x440
       pci_iommu_init+0x16/0x40
       do_one_initcall+0xf5/0x400
       do_initcall_level+0x82/0xa0
       do_initcalls+0x59/0xa0
       kernel_init_freeable+0x152/0x1d0
       kernel_init+0x1a/0x130
       ret_from_fork+0x16b/0x310
       ret_from_fork_asm+0x1a/0x30

-> #0 (&group->mutex){+.+.}-{4:4}:
       __lock_acquire+0x14c8/0x2750
       lock_acquire+0xd3/0x2c0
       __mutex_lock+0x8c/0xd80
       pci_dev_reset_iommu_prepare+0x6e/0x200
       pcie_flr+0x32/0xc0
       __pci_reset_function_locked+0x84/0x120
       vfio_pci_core_try_reset+0xa4/0x110
       vfio_pci_liveupdate_freeze+0x8a/0x100
       luo_file_freeze+0xd1/0x290
       luo_session_serialize+0xa6/0x240
       liveupdate_reboot+0x19/0x30
       kernel_kexec+0x39/0xb0
       __se_sys_reboot+0xfd/0x210
       do_syscall_64+0x15f/0x4e0
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &group->mutex --> &mm->mmap_lock --> &vdev->memory_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&vdev->memory_lock);
                               lock(&mm->mmap_lock);
                               lock(&vdev->memory_lock);
  lock(&group->mutex);

 *** DEADLOCK ***

9 locks held by kexec/13355:
 #0: ffffffff85a81270 (system_transition_mutex){+.+.}-{4:4}, at: __se_sys_reboot+0xe4/0x210
 #1: ffffffff85e1cfa8 (luo_session_serialize_rwsem){++++}-{4:4}, at: luo_session_serialize+0x30/0x240
 #2: ffffffff85e1d140 (luo_session_global.outgoing.rwsem){+.+.}-{4:4}, at: luo_session_serialize+0x43/0x240
 #3: ff3f082dee702108 (&session->mutex){+.+.}-{4:4}, at: luo_session_serialize+0x99/0x240
 #4: ff3f082db51c2588 (&luo_file->mutex){+.+.}-{4:4}, at: luo_file_freeze+0x81/0x290
 #5: ff3f082d8af761a8 (&new_dev_set->lock){+.+.}-{4:4}, at: vfio_pci_liveupdate_freeze+0x38/0x100
 #6: ff3f082de7f39780 (&vdev->igate){+.+.}-{4:4}, at: vfio_pci_liveupdate_freeze+0x49/0x100
 #7: ff3f082de7f399a8 (&vdev->memory_lock){++++}-{4:4}, at: vfio_pci_liveupdate_freeze+0x58/0x100
 #8: ff3f086c908911f8 (&dev->mutex){....}-{4:4}, at: pci_dev_trylock+0x25/0x60

stack backtrace:
CPU: 132 UID: 0 PID: 13355 Comm: kexec Tainted: G S                  7.2.0-dbg-DEV #3 PREEMPTLAZY
Tainted: [S]=CPU_OUT_OF_SPEC
Hardware name: Google Izumi/izumi, BIOS 0.20260327.0-0 03/27/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0x54/0x70
 print_circular_bug+0x2e1/0x300
 check_noncircular+0xf9/0x120
 ? __bfs+0x129/0x200
 __lock_acquire+0x14c8/0x2750
 ? __lock_acquire+0x1223/0x2750
 ? check_noncircular+0xa5/0x120
 ? pci_dev_reset_iommu_prepare+0x6e/0x200
 lock_acquire+0xd3/0x2c0
 ? pci_dev_reset_iommu_prepare+0x6e/0x200
 ? lock_is_held_type+0x76/0x100
 ? pci_dev_reset_iommu_prepare+0x6e/0x200
 __mutex_lock+0x8c/0xd80
 ? pci_dev_reset_iommu_prepare+0x6e/0x200
 ? lockdep_hardirqs_on_prepare+0x152/0x220
 ? _raw_spin_unlock_irqrestore+0x35/0x50
 pci_dev_reset_iommu_prepare+0x6e/0x200
 pcie_flr+0x32/0xc0
 __pci_reset_function_locked+0x84/0x120
 vfio_pci_core_try_reset+0xa4/0x110
 vfio_pci_liveupdate_freeze+0x8a/0x100
 luo_file_freeze+0xd1/0x290
 luo_session_serialize+0xa6/0x240
 liveupdate_reboot+0x19/0x30
 kernel_kexec+0x39/0xb0
 __se_sys_reboot+0xfd/0x210
 ? check_object+0x1e8/0x390
 ? init_object+0x34/0x110
 ? lock_release+0xf0/0x330
 ? kmem_cache_free+0x1b5/0x520
 ? kmem_cache_free+0x1c9/0x520
 ? _raw_spin_unlock_irqrestore+0x35/0x50
 ? kmem_cache_free+0x1b5/0x520
 ? __x64_sys_close+0x3d/0x80
 ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
 ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
 do_syscall_64+0x15f/0x4e0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f04e7233313
Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 89 fa b8 a9 00 00 00 bf ad de e1 fe be 69 19 12 28 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 f7 d8 48 8b 0d eb fb 06 00 64 89 01 48
RSP: 002b:00007ffe7c91b688 EFLAGS: 00000246 ORIG_RAX: 00000000000000a9
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f04e7233313
RDX: 0000000045584543 RSI: 0000000028121969 RDI: 00000000fee1dead
RBP: 00007ffe7c91b9b0 R08: 000000000000000a R09: 00007f04e72a4ff0
R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000002
 </TASK>

