Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32941286415
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463724; cv=none; b=uFLPQTEnIUPaBgzOHjD/0U5QsJcnCt2UszXL61ochVyPBjazOyKTHRqpMFtqA96WMFqeDIbi57WsR9LH8Viu/+Kstm/V4GrnRJ/Ul2g5GI3FIWPJ0YZ5WWcFnRjFygMf64O+AbNnASQTM2+tBrNjNOUHwGMR3F8LN6VnM/+0IDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463724; c=relaxed/simple;
	bh=8SKE5+w+nUC99O0PQPXOslSSjU0k/cav2IEwIOqB1o4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pz+jq+4qO17jzznVZs+8TIgD2vkJ7ZsF890cnxYhvOZZc3EI7r++G3Ciwun/uIOYHQeVzZ7aNDHZEMLD6gcfPutlxXX+2m9FqY52313TrkxnaPoOABJz9Nu9uBBYIO6GuyKL+OM2g7gslx0qWz3kSE5oNsKlyVsSbwmrQUHyEFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8Jnl+m6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8Jnl+m6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172581F000E9;
	Fri, 26 Jun 2026 08:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782463722;
	bh=cTIFKFfXeX2xk6Z/mOOtvMk5UiCmmucmn3EbcJ2LHY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z8Jnl+m6DjHc7CVmpKUhwANNj2WDS3FcduGMba1zX2VL5ET2+pzphsXsgLTMxtUCN
	 hPO3On6q8DmtVygIHrROSY+BM73Xo6qFGiOF+wvmu4X+U+A3fcrNWiSQi/yaozfZ/D
	 KChQDe9kayLgfBQB9IdNwDMgkBhcHU5mJfABiFmorRCY/T8t+mM0Y6UYgdRtNZXcXX
	 lWeWuTi/D/7nlF3rHLsy/+u2Ee5MifksM9XTxZ4i16gv08V7bVRwAcf7YWOJQJMG2X
	 jsXWgvCVAbbywPtJdb3lK0m5/irqDPiD+93GF4avRQ/pVQW/Sj6OHDbrVH/tAjZbmB
	 92RtoYJhNXxRw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] KVM: rust: add Rust reimplementation of eventfd
Reply-To: sashiko-reviews@lists.linux.dev
To: leixiang <leenollei@gmail.com>
Cc: kvm@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260626083212.39611-1-leixiang@kylinos.cn>
References: <20260626083212.39611-1-leixiang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 08:48:41 +0000
Message-Id: <20260626084842.172581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Recursive spinlock acquisition causing guaranteed deadlock in =
`irqfd_wakeup`.
- [Critical] ABBA deadlock between `irqfds.lock` and waitqueue lock intenti=
onally hidden from lockdep.
- [High] `kvm_deassign_ioeventfd_idx` fails to free the `Ioeventfd` device,=
 leaking memory and eventfd references.
- [High] MutexGuard dropped too late, holding `irq_lock` across `synchroniz=
e_srcu_expedited`.
- [High] Logic error in `irqfd_wakeup` injects spurious interrupts for deac=
tivating irqfds.
- [High] Unsafe RCU list traversal in `kvm_notify_irqfd_resampler` lacks `r=
cu_dereference` memory barriers.
- [Medium] Unaligned memory read causes undefined behavior in `ioeventfd_in=
_range`.
--

commit 3427a3ec37eb356c05fc7c711d26f74d692d5086
Author: ninol <leenollei@gmail.com>
Subject: KVM: rust: add Rust reimplementation of eventfd

This patch introduces a Rust reimplementation of KVM's eventfd support, pro=
viding irqfd and ioeventfd functionality. It uses RAII guards for lock mana=
gement and is selectable via a new Kconfig option.

> diff --git a/rust/kernel/kvm/eventfd.rs b/rust/kernel/kvm/eventfd.rs
> new file mode 100644
> index 0000000000000..d9b12c7caccb0
> --- /dev/null
> +++ b/rust/kernel/kvm/eventfd.rs
[ ... ]
> +unsafe extern "C" fn irqfd_wakeup(
> +    wait: *mut bindings::wait_queue_entry,
> +    _mode: c_uint,
> +    _sync: c_int,
> +    key: *mut c_void,
> +) -> c_int {
> +    // SAFETY: wait is embedded in kvm_kernel_irqfd.
> +    let irqfd: *mut bindings::kvm_kernel_irqfd =3D
> +        crate::container_of!(wait, bindings::kvm_kernel_irqfd, wait);
> +    let flags =3D (key as usize) as bindings::__poll_t;
> +    let kvm =3D (*irqfd).kvm;
> +    let mut ret: c_int =3D 0;
> +
> +    if (flags & bindings::POLLIN) !=3D 0 {
> +        let mut cnt: u64 =3D 0;
> +        eventfd_ctx_do_read((*irqfd).eventfd, &raw mut cnt);

[Severity: Critical]
Does this cause a recursive spinlock deadlock? This irqfd_wakeup() function=
 is
invoked from the eventfd waitqueue wakeup path where the waitqueue spinlock
(wqh.lock) is already held. Calling eventfd_ctx_do_read() here will try to
acquire that exact same spinlock again, resulting in an immediate deadlock.

> +
> +        // SAFETY: kvm->irq_srcu is valid.
> +        let _srcu_guard =3D unsafe { SrcuGuard::new(&raw mut (*kvm).irq_=
srcu) };
> +
> +        // Read irq_entry under seqcount protection to avoid torn reads
> +        // when kvm_irq_routing_update() writes concurrently on another =
CPU.
> +        let mut irq =3D loop {
> +            let seq =3D unsafe { bindings::read_seqcount_begin(&raw mut =
(*irqfd).irq_entry_sc) };
> +            let entry =3D unsafe { core::ptr::read(&(*irqfd).irq_entry) =
};
> +            if unsafe { bindings::read_seqcount_retry(&raw mut (*irqfd).=
irq_entry_sc, seq) } =3D=3D 0 {
> +                break entry;
> +            }
> +        };
> +
> +        let deactivating =3D !irqfd_is_active(irqfd);
> +        if deactivating
> +            || unsafe {
> +                bindings::kvm_arch_set_irq_inatomic(
> +                    &raw mut irq,
> +                    kvm,
> +                    bindings::KVM_USERSPACE_IRQ_SOURCE_ID as i32,
> +                    1,
> +                    false,
> +                )
> +            } =3D=3D -(bindings::EWOULDBLOCK as c_int)
> +        {
> +            // SAFETY: FFI call.
> +            unsafe { bindings::schedule_work(&raw mut (*irqfd).inject) };
> +        }

[Severity: High]
Does this logic mistakenly inject spurious interrupts when an irqfd is
deactivating? If the deactivating condition is true, the || operator
short-circuits and evaluates the entire condition to true, meaning we will
schedule work for deactivating irqfds. This could lead to use-after-free
issues if the work executes after the irqfd memory has been freed.

> +
> +        // _srcu_guard is dropped here
> +        ret =3D 1;
> +    }
> +
> +    if (flags & bindings::POLLHUP) !=3D 0 {
> +        // SAFETY: Taking irqfds.lock is safe here per original C commen=
t.
> +        // SAFETY: kvm is valid, irqfds.lock is valid.
> +        let _spin_guard =3D unsafe { SpinLockIrqSaveGuard::new(&raw mut =
(*kvm).irqfds.lock) };

[Severity: Critical]
Is there an ABBA deadlock risk here? This acquires irqfds.lock while the
waitqueue lock (wqh.lock) is already held by the caller. However, in
kvm_irqfd_register(), irqfds.lock is acquired before calling
add_wait_queue_priority_exclusive(), which in turn acquires wqh.lock. This
lock inversion can trigger a deadlock when registering and closing eventfds
concurrently.

[ ... ]
> +unsafe extern "C" fn kvm_irqfd_register(
> +    _file: *mut bindings::file,
> +    wqh: *mut bindings::wait_queue_head,
> +    pt: *mut bindings::poll_table,
> +) {
[ ... ]
> +    // Initialize wait queue entry with our custom wakeup handler.
> +    init_waitqueue_func_entry(&raw mut (*irqfd).wait, Some(irqfd_wakeup)=
);
> +
> +    // Temporarily lie to lockdep about holding irqfds.lock to avoid a
> +    // false positive: add_wait_queue_priority_exclusive takes wqh->lock
> +    // internally, and lockdep would see irqfds.lock -> wqh->lock, which
> +    // matches the reverse order in irqfd_wakeup(EPOLLHUP).
> +    // SAFETY: `kvm` is a valid pointer, and `irqfds.lock` is held.
> +    unsafe { bindings::rust_helper_kvm_irqfds_spin_release(kvm) };
> +
> +    // Add as priority waiter on eventfd.
> +    (*p).ret =3D add_wait_queue_priority_exclusive(wqh, &raw mut (*irqfd=
).wait);
> +
> +    // SAFETY: `kvm` is valid, lockdep state is restored after
> +    // releasing wait queue lock.
> +    unsafe { bindings::rust_helper_kvm_irqfds_spin_acquire(kvm) };

[Severity: Critical]
This isn't a false positive; silencing lockdep here hides the real ABBA
deadlock mentioned above between irqfd_wakeup() and this function. Could we
restructure the locking to avoid this inversion instead of hiding it from
lockdep?

[ ... ]
> +#[inline(always)]
> +unsafe fn ioeventfd_in_range(
> +    p: &Ioeventfd,
> +    addr: bindings::gpa_t,
> +    len: c_int,
> +    val: *const c_void,
> +) -> bool {
[ ... ]
> +    if let Some(datamatch) =3D p.datamatch() {
> +        // KVM guarantees val is naturally aligned; assert to match C's =
BUG_ON.
> +        debug_assert!(
> +            (val as usize) % (len as usize) =3D=3D 0,
> +            "ioeventfd_in_range: val pointer not aligned to len"
> +        );
> +        let _val: u64 =3D match len {
> +            1 =3D> unsafe { (val as *const u8).read() as u64 },
> +            2 =3D> unsafe { (val as *const u16).read() as u64 },
> +            4 =3D> unsafe { (val as *const u32).read() as u64 },
> +            8 =3D> unsafe { (val as *const u64).read() as u64 },
> +            _ =3D> return false,
> +        };

[Severity: Medium]
Could this result in undefined behavior? In release builds, debug_assert!
compiles away, and ptr::read() strictly requires the input pointer to be
aligned. If the pointer happens to be unaligned, this invokes undefined
behavior. Using ptr::read_unaligned() would be safer here.

[ ... ]
> +unsafe fn kvm_deassign_ioeventfd_idx(
> +    kvm: *mut bindings::kvm,
> +    bus_idx: bindings::kvm_bus,
> +    args: *const bindings::kvm_ioeventfd,
> +) -> c_int {
[ ... ]
> +            // SAFETY: kvm_io_bus_unregister_dev will trigger the iodevi=
ce destructor,
> +            // which implicitly performs list_del and kfree(p). Using `n=
ext` above avoids UAF.
> +            unsafe { bindings::kvm_io_bus_unregister_dev(kvm, bus_idx, &=
raw mut (*p).dev) };
> +            let bus =3D unsafe { bindings::kvm_get_bus(kvm, bus_idx) };
> +            if !bus.is_null() {
> +                unsafe { (*bus).ioeventfd_count -=3D 1 };
> +            }
> +            ret =3D 0;
> +            break;
> +        }
> +        // _mutex_guard drops here, unlocking before eventfd_ctx_put.
> +    }

[Severity: High]
Does this code leak the Ioeventfd and eventfd references? The assumption in
the comment that kvm_io_bus_unregister_dev() triggers the destructor is
incorrect; it only removes the device from the bus array. The caller is sti=
ll
responsible for explicitly deleting the list entry and freeing the memory.

[ ... ]
> +pub unsafe extern "C" fn kvm_notify_irqfd_resampler(
> +    kvm: *mut bindings::kvm,
> +    irqchip: c_uint,
> +    pin: c_uint,
> +) -> bool {
> +    // SAFETY: kvm->irq_srcu is valid.
> +    let _srcu_guard =3D unsafe { SrcuGuard::new(&raw mut (*kvm).irq_srcu=
) };
> +    let gsi =3D unsafe { bindings::kvm_irq_map_chip_pin(kvm, irqchip, pi=
n) };
> +
> +    if gsi !=3D -1 {
> +        let mut pos =3D (*kvm).irqfds.resampler_list.next;
> +        let head =3D &raw mut (*kvm).irqfds.resampler_list;
> +        while pos !=3D head {
> +            let resampler: *mut bindings::kvm_kernel_irqfd_resampler =3D
> +                crate::container_of!(pos, bindings::kvm_kernel_irqfd_res=
ampler, link);

[Severity: High]
Can this plain pointer traversal cause a data race? Accessing an RCU list v=
ia
direct pos.next dereferences under an SRCU read lock lacks the memory barri=
er
provided by rcu_dereference(), which is required on weakly ordered
architectures to prevent reading uninitialized state.

[ ... ]
> +pub unsafe extern "C" fn kvm_unregister_irq_ack_notifier(
> +    kvm: *mut bindings::kvm,
> +    kian: *mut bindings::kvm_irq_ack_notifier,
> +) {
> +    // SAFETY: Caller guarantees kvm is valid.
> +    let _mutex_guard =3D unsafe { MutexGuard::new(&raw mut (*kvm).irq_lo=
ck) };
> +    unsafe { bindings::rust_helper_hlist_del_init_rcu(&raw mut (*kian).l=
ink) };
> +    // _mutex_guard dropped here
> +    unsafe { bindings::synchronize_srcu_expedited(&raw mut (*kvm).irq_sr=
cu) };
> +    unsafe { bindings::kvm_arch_post_irq_ack_notifier_list_update(kvm) };
> +}

[Severity: High]
Is the _mutex_guard actually dropped where the comment claims? Because
_mutex_guard is not explicitly dropped (e.g., via drop(_mutex_guard) or
wrapping in an inner block), its lifetime extends to the end of the function
scope. This means irq_lock is held across the blocking
synchronize_srcu_expedited() call, violating the locking hierarchy and
potentially causing a deadlock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626083212.3961=
1-1-leixiang@kylinos.cn?part=3D1
