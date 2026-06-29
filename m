Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E8D29C327;
	Mon, 29 Jun 2026 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782721788; cv=none; b=XjugwkiNDMSk55IX/UAdv4OLkeCXmf3b4OUnsEFYUwSMs98OWiVybDQ1HFqFlQgyfhDZEOL/k+Pra1xpgs5bKVjVc38OKa9StGun7EMKAO0/HuSFP6auDfbpYnCbNC0Hcwm1MWKmJLzPFZcBV9lCd7dQ+lgoW/KVtk9BFomHGqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782721788; c=relaxed/simple;
	bh=Id9xLPNKbg5OWIdweCc1COuge7p5Pn8IIzoY8l3TedA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9d3LZW3c0qX7YvgAm+UpHMJxilakwUiIi2mtJCSFGdFCzhBKZOQG4mahc5LwygvVhS3XP4Y/r9ELNzH55L0VC8TcMkc7LNc3YUa7DQzdORMRblPiQjfNVCNiInrBZcanvNXQwV9OoECPGz2aznN0D9pjd5+KDq0qPrpcGBU0js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=rqtdQ7f+; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="rqtdQ7f+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1782721775; x=1782980975;
	bh=WbqvebtWAj0YtJohER5RHxaa/NC/OEAtmPKk+oAJGis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=rqtdQ7f+5623PJZgD/6ikZQAA82lmfhviw31P8LaCrMIubC/1CLAU+eWVgvdJduAM
	 eW0cyroTlKOYgK2ZAr+HrpbtL4Z+MCMqG3+tNZB/UFVqaPzkq+cF75NDsIf48AJIAX
	 AuBYHy+/kL7XIPmbsqMpsrFq3TOPWqmWsmieubd2VBHSKFb/kQ1qB+CSV9rytIJT+a
	 qO2K1t7jKE8416lJmREy7bwYZzR1HVirsix0uXh1t2iUGg+umXq/V05GZwsI1zw3hx
	 FltgKv98KhEM0mAd9k0t9+Ney+BXoUrEy9PhM33xmDj+jRmJ2bHBXqNWkN62slRa7d
	 6ypYQXY5zwfbg==
X-Pm-Submission-Id: 4gpfZz39P0z1DDqt
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: leixiang <leenollei@gmail.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	ojeda@kernel.org
Subject: Re: [RFC PATCH] KVM: rust: add Rust reimplementation of eventfd
Date: Mon, 29 Jun 2026 11:29:05 +0300
Message-ID: <20260629082930.23182-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260626083212.39611-1-leixiang@kylinos.cn>
References: <20260626083212.39611-1-leixiang@kylinos.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jun 2026 16:29:34 +0800=0D
leixiang <leenollei@gmail.com> wrote:=0D
=0D
> From: ninol <leenollei@gmail.com>=0D
> =0D
> Introduce a Rust reimplementation of virt/kvm/eventfd.c, providing=0D
> irqfd (interrupt injection via eventfd) and ioeventfd (MMIO/PIO write=0D
> to eventfd signal) functionality with full C ABI compatibility.=0D
> =0D
> The Rust implementation leverages RAII guards for SRCU, mutex, and=0D
> spinlock management, reducing the risk of resource leaks on error=0D
> paths. It is selectable via CONFIG_RUST_KVM_EVENTFD and replaces=0D
> the C eventfd.o with a shim providing only weak default functions.=0D
> =0D
> Signed-off-by: ninol <leenollei@gmail.com>=0D
> ---=0D
> =0D
> Hi all,=0D
> =0D
> This is an experimental/exploratory RFC for a Rust reimplementation of=0D
> virt/kvm/eventfd.c. It is intended as a learning exercise and a proof=0D
> of concept to explore whether Rust can be practically applied to KVM=0D
> subsystem components.=0D
> =0D
> I fully understand this may not be the direction the KVM community=0D
> wants to take. If you feel this is not worth your time, please ignore=0D
> it entirely. If, however, you find this approach interesting or have=0D
> any feedback on the implementation, I would greatly appreciate=0D
> your comments.=0D
> =0D
> The patch provides functionally equivalent irqfd and ioeventfd support,=0D
> gated behind CONFIG_RUST_KVM_EVENTFD. It uses RAII guards for lock and=0D
> resource management and maintains full ABI compatibility with the C=0D
> implementation.=0D
> =0D
> Testing: Built and boot-tested on x86_64 with KVM enabled.=0D
> =0D
> Thanks for your time.=0D
> =0D
>  rust/bindgen_parameters         |    2 +=0D
>  rust/bindings/bindings_helper.h |   18 +=0D
>  rust/helpers/eventfd.c          |   34 +=0D
>  rust/helpers/helpers.c          |    7 +=0D
>  rust/helpers/kvm.c              |  221 +++++=0D
>  rust/helpers/seqcount.c         |   30 +=0D
>  rust/kernel/kvm/eventfd.rs      | 1419 +++++++++++++++++++++++++++++++=0D
>  rust/kernel/kvm/mod.rs          |    8 +=0D
>  rust/kernel/lib.rs              |    2 +=0D
>  virt/kvm/Kconfig                |   15 +=0D
>  virt/kvm/Makefile.kvm           |    7 +-=0D
>  virt/kvm/eventfd_shim.c         |   52 ++=0D
>  12 files changed, 1814 insertions(+), 1 deletion(-)=0D
>  create mode 100644 rust/helpers/eventfd.c=0D
>  create mode 100644 rust/helpers/kvm.c=0D
>  create mode 100644 rust/helpers/seqcount.c=0D
>  create mode 100644 rust/kernel/kvm/eventfd.rs=0D
>  create mode 100644 rust/kernel/kvm/mod.rs=0D
>  create mode 100644 virt/kvm/eventfd_shim.c=0D
> =0D
> diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters=0D
> index 6f02d9720ad2..c433a6ca5336 100644=0D
> --- a/rust/bindgen_parameters=0D
> +++ b/rust/bindgen_parameters=0D
> @@ -14,6 +14,8 @@=0D
>  --opaque-type alt_instr=0D
>  --opaque-type x86_msi_data=0D
>  --opaque-type x86_msi_addr_lo=0D
> +--opaque-type hv_.*=0D
> +--opaque-type IO_APIC_route_entry=0D
>  =0D
>  # If SMP is disabled, `arch_spinlock_t` is defined as a ZST which trigge=
rs a Rust=0D
>  # warning. We don't need to peek into it anyway.=0D
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h=0D
> index 446dbeaf0866..2d65f2b1672d 100644=0D
> --- a/rust/bindings/bindings_helper.h=0D
> +++ b/rust/bindings/bindings_helper.h=0D
> @@ -65,8 +65,12 @@=0D
>  #include <linux/io-pgtable.h>=0D
>  #include <linux/ioport.h>=0D
>  #include <linux/iosys-map.h>=0D
> +#include <linux/irqbypass.h>=0D
>  #include <linux/jiffies.h>=0D
>  #include <linux/jump_label.h>=0D
> +#include <kvm/iodev.h>=0D
> +#include <linux/kvm_host.h>=0D
> +#include <linux/kvm_irqfd.h>=0D
>  #include <linux/mdio.h>=0D
>  #include <linux/mm.h>=0D
>  #include <linux/miscdevice.h>=0D
> @@ -94,6 +98,20 @@=0D
>  #include <linux/xarray.h>=0D
>  #include <trace/events/rust_sample.h>=0D
>  =0D
> +#ifdef CONFIG_RUST_KVM_EVENTFD=0D
> +/* Custom helpers for eventfd.rs */=0D
> +unsigned long rust_helper_spin_lock_irqsave(spinlock_t *lock);=0D
> +void rust_helper_spin_unlock_irqrestore(spinlock_t *lock, unsigned long =
flags);=0D
> +void rust_helper_hlist_add_head_rcu(struct hlist_node *n, struct hlist_h=
ead *h);=0D
> +void rust_helper_hlist_del_init_rcu(struct hlist_node *n);=0D
=0D
[...]=0D
=0D
> +#[cfg(CONFIG_LOCKDEP)]=0D
> +#[inline(always)]=0D
> +unsafe fn spin_acquire(=0D
> +    map: *mut bindings::lockdep_map,=0D
> +    subclass: c_int,=0D
> +    trylock: c_int,=0D
> +    ip: core::ffi::c_ulong,=0D
> +) {=0D
> +    // SAFETY: Caller holds the corresponding lock; this is a lockdep an=
notation only.=0D
> +    unsafe { bindings::rust_helper_spin_acquire(map, subclass, trylock, =
ip) }=0D
> +}=0D
> +=0D
> +// RAII Guards=0D
> +=0D
> +/// RAII Guard for SRCU read lock.=0D
> +struct SrcuGuard {=0D
> +    srcu: *mut bindings::srcu_struct,=0D
> +    idx: core::ffi::c_int,=0D
> +    _not_thread_safe: crate::types::NotThreadSafe,=0D
> +}=0D
> +=0D
=0D
> +impl SrcuGuard {=0D
> +    /// # Safety=0D
> +    /// Caller must ensure `srcu` is a valid pointer.=0D
> +    unsafe fn new(srcu: *mut bindings::srcu_struct) -> Self {=0D
> +        // SAFETY: Caller guarantees `srcu` is valid.=0D
> +        let idx =3D unsafe { bindings::srcu_read_lock(srcu) };=0D
> +        Self {=0D
> +            srcu,=0D
> +            idx,=0D
> +            _not_thread_safe: crate::types::NotThreadSafe,=0D
> +        }=0D
> +    }=0D
> +}=0D
> +=0D
> +impl Drop for SrcuGuard {=0D
> +    fn drop(&mut self) {=0D
> +        // SAFETY: We hold the lock `idx` on `srcu`.=0D
> +        unsafe { bindings::srcu_read_unlock(self.srcu, self.idx) };=0D
> +    }=0D
> +}=0D
=0D
You are adding things that are already being implemented in much better way=
. For=0D
example, for SRCU we already have v10 [1]. But even before that I think thi=
s=0D
patch has even more serious problems. It has multiple fundamental issues an=
d=0D
things seem to be placed randomly all around.=0D
=0D
Regards,=0D
Onur=0D
=0D
[1]: https://lore.kernel.org/all/20260613065348.96750-1-work@onurozkan.dev=
=0D
=0D
> +=0D
> +/// RAII Guard for mutex lock.=0D
> +struct MutexGuard {=0D
> +    lock: *mut bindings::mutex,=0D
> +}=0D
> +=0D
> +impl MutexGuard {=0D
> +    /// # Safety=0D
> +    /// Caller must ensure `lock` is a valid pointer.=0D
> +    unsafe fn new(lock: *mut bindings::mutex) -> Self {=0D
> +        // SAFETY: Caller guarantees `lock` is valid.=0D
> +        unsafe { bindings::mutex_lock(lock) };=0D
> +        Self { lock }=0D
> +    }=0D
> +}=0D
> +=0D
> +impl Drop for MutexGuard {=0D
> +    fn drop(&mut self) {=0D
> +        // SAFETY: We hold the lock.=0D
> +        unsafe { bindings::mutex_unlock(self.lock) };=0D
> +    }=0D
=0D
[...]=0D
=0D
> +#include <linux/kvm_irqfd.h>=0D
> +#include <linux/irqbypass.h>=0D
> +=0D
> +bool __weak kvm_arch_irqfd_allowed(struct kvm *kvm, struct kvm_irqfd *ar=
gs)=0D
> +{=0D
> +	return true;=0D
> +}=0D
> +=0D
> +int __weak kvm_arch_set_irq_inatomic(=0D
> +				struct kvm_kernel_irq_routing_entry *irq,=0D
> +				struct kvm *kvm, int irq_source_id,=0D
> +				int level,=0D
> +				bool line_status)=0D
> +{=0D
> +	return -EWOULDBLOCK;=0D
> +}=0D
> +=0D
> +#if IS_ENABLED(CONFIG_HAVE_KVM_IRQ_BYPASS)=0D
> +void __weak kvm_arch_irq_bypass_stop(=0D
> +				struct irq_bypass_consumer *cons)=0D
> +{=0D
> +}=0D
> +=0D
> +void __weak kvm_arch_irq_bypass_start(=0D
> +				struct irq_bypass_consumer *cons)=0D
> +{=0D
> +}=0D
> +=0D
> +void __weak kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd=
,=0D
> +					  struct kvm_kernel_irq_routing_entry *old,=0D
> +					  struct kvm_kernel_irq_routing_entry *new)=0D
> +{=0D
> +}=0D
> +#endif=0D
> +=0D
> +/*=0D
> + * The Rust implementation provides kvm_irq_has_notifier via #[no_mangle=
].=0D
> + * Symbol export for KVM-internal use must be done from C.=0D
> + */=0D
> +extern bool kvm_irq_has_notifier(struct kvm *kvm, unsigned int irqchip,=
=0D
> +				 unsigned int pin);=0D
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_irq_has_notifier);=0D
> -- =0D
> 2.43.0=0D
> =0D
