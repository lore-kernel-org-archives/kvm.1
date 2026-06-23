Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856662BD587
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228810; cv=none; b=HjMZJ/6FdNcDUgxC1vBQ936/8AqrZiVlKk96KKRjnBQGmoINysB+HIuvT6E0Q4BQ6sM0YolS7xluuXNuJ0Xb1Lf6SNiVhEyiDYlIzoP4/lfJrJ54zT9eJ1aBEjpC40qAu8TPI9NHvkcvIL+RcNEMVvh0CNTmQeXjk4nu0XAp9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228810; c=relaxed/simple;
	bh=lpOwfglJZDHPn+JDNnBl4hYd48fcElWX5MTh1iwTlg8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M1pBVN+QZB8xtMVGWYbzc6cNY1V0ZbOHN9bYZx2qZ0XhVzuF6qstw0bf0T4J93YVpZq5S0bmLVW9X1Hy/ehJvVq4gx1KdD0x72+ZRK/TqttvDhtok++pWQOej1WRS1O4ud3IZxbNO/JjxIk/i0/SWpwZ4ERyKMl37VM7s0baO30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sKh8VY/j; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sKh8VY/j"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-695c0775f8aso7169626a12.0
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782228807; x=1782833607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i1Bny3807BZgTs2uePjipxUsmHzpP562txJFNUNSguI=;
        b=sKh8VY/jKz/LI3HDBO4pigU3vQrOCt00aQMAZ2m6gQGMf+9JqplOH4HgWEQlCdbvjT
         dGe5xDVTdbY8r72xujtKjrAu3nma3vTmkzLAhm0Hol03PtWYk5n6nV9hEWje+Nve1aSD
         wycBI0fs13bStMMLO/vSbKKTfVOycRiH770/DBobyKo8pGq0IU+bSLWxLc7UGBut34WT
         M/Qza8f8W+CatJeBQS3stH96thE5Gt9GIv4IjJ7xNIvtYfwT77CfE1jWvJIZ5gYO3QPj
         eOn+ocG68PwZRazDnhQkRwex/recdKPrdJTY/i/AuEYb9J2WFE8qdoNpuiUJBLL1MfcF
         DF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782228807; x=1782833607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1Bny3807BZgTs2uePjipxUsmHzpP562txJFNUNSguI=;
        b=DpRs3jqWLJVWyJVkmD+vXsfe1pqRiXPorfw7/alTv9B5Fr13JHZnmb26DECo7aGTFb
         /I/vEYsf4RsuEtWSQVOBxzBBJZm7MSUUGKKjFGU0gFCXh6OvJSzHWyALpSxMB310LjqY
         S6nz6OKnfJgKEBLx23i6BC5cNPgwWGnrXs4/uAS53BbqY56IWVjyYM2OWma6OHCweNCk
         zs28+/bzDum069K3v5fqsRaiGz/+gfm97MzbU4CFvPXSyFUk49JzMAvZbFgai48HqPAm
         RZa+3GlHgwMecTDBxRzBim4ecof6i1veD0ujcMD1pfqi2KfFwdIfEa0wgoQfmPqFbr/j
         WBAg==
X-Forwarded-Encrypted: i=1; AFNElJ89djTCCbxB7bVb+wgldgpubEWUDLibzVM/B/TruWzm9tHjwjw5k7tTeMJZfUEhm3hXsso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQh/0UfbBDwE7qb0iV0aIuoc+UUa6qYJQQekB0ZlLRaQ8ivSec
	+fvs3TOJNyQKBfnRDWzygLNI5Ep+ffcunfABy+UEAa5Lnd5vBvzlQwYqJGTdNgm6Ds34cqpSbc6
	bKDjDGGMGNXH+yOK0Mw==
X-Received: from edgd28-n1.prod.google.com ([2002:a05:6402:a51c:10b0:695:d3d9:5811])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5253:b0:697:96c2:b591 with SMTP id 4fb4d7f45d1cf-69796c2c000mr5685499a12.11.1782228806744;
 Tue, 23 Jun 2026 08:33:26 -0700 (PDT)
Date: Tue, 23 Jun 2026 15:33:26 +0000
In-Reply-To: <CAEvNRgGharGxs9s_ow0Z4iiQ9PCzdghch-4Fk6UMjiPP9tX-5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com> <20ae20f9d1a198b289444ebb4c824314cbba1bcf.1780676742.git.tarunsahu@google.com>
 <CAEvNRgGharGxs9s_ow0Z4iiQ9PCzdghch-4Fk6UMjiPP9tX-5g@mail.gmail.com>
Message-ID: <9huzo6h1mfuh.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 03/10] kvm: Prepare core VM structs and helpers for
 LUO support
From: tarunsahu@google.com
To: Ackerley Tng <ackerleytng@google.com>, Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
	fvdl@google.com, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, aneesh.kumar@kernel.org, 
	skhawaja@google.com, vipinsh@google.com, Pratyush Yadav <pratyush@kernel.org>, 
	david@redhat.com, dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, axelrasmussen@google.com
Cc: linux-kselftest@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> Tarun Sahu <tarunsahu@google.com> writes:
>
>> Introduce core infrastructure to support VM preservation with LUO.
>>
>> First two changes are just refactoring, no functional change, third
>> change introduces a new member in struct kvm.
>> - Move ITOA_MAX_LEN to kvm_mm.h for reuse by upcoming kvm_luo code.
>> - Add a public kvm_create_vm_file() helper wrapping kvm_create_vm()
>>   and anon_inode_getfile() to provide a unified VM file creation API.
>> - Track a weak reference to the backing file in struct kvm under
>>   CONFIG_LIVEUPDATE_GUEST_MEMFD to enable reverse file resolution
>>   without circular lifetime dependencies.
>>
>
> Given the above, I think this should be separate patches.
>
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>> ---
>>  include/linux/kvm_host.h | 14 +++++++
>>  virt/kvm/kvm_main.c      | 79 +++++++++++++++++++++++++++++-----------
>>  virt/kvm/kvm_mm.h        |  3 ++
>>  3 files changed, 75 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index 4c14aee1fb06..9111a28637af 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -874,6 +874,18 @@ struct kvm {
>>  #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
>>  	/* Protected by slots_lock (for writes) and RCU (for reads) */
>>  	struct xarray mem_attr_array;
>> +#endif
>> +#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
>> +	/*
>> +	 * Weak reference to the VFS file backing this KVM instance. Stored
>> +	 * without incrementing the file refcount to prevent a circular lifetime
>> +	 * dependency (since file->private_data already pins this struct kvm).
>> +	 * Used exclusively to resolve the file pointer back from struct kvm.
>> +	 *
>> +	 * Written/cleared via rcu_assign_pointer() and read locklessly under
>> +	 * RCU (e.g. via get_file_active() to prevent ABA races).
>> +	 */
>> +	struct file *vm_file;
>>  #endif
>
> We didn't really talk about this during the calls, but it seems weird to
> preserve a vm_file with pretty much nothing other than the vm type. The
> entire VM is re-created, which means it could potentially be a
> completely different VM?
>
> In some sense it's more flexible since the guest_memfd can be restored
> with some completely different VM, but it seems like it could introduce
> other issues.
>
> I think other KVM folks would probably have more thoughts here.
>
>>  	char stats_id[KVM_STATS_NAME_SIZE];
>>  };
>> @@ -1074,7 +1086,9 @@ void kvm_get_kvm(struct kvm *kvm);
>>  bool kvm_get_kvm_safe(struct kvm *kvm);
>>  void kvm_put_kvm(struct kvm *kvm);
>>  bool file_is_kvm(struct file *file);
>> +struct file *kvm_create_vm_file(unsigned long type, const char *fdname);
>>  void kvm_put_kvm_no_destroy(struct kvm *kvm);
>> +void kvm_uevent_notify_vm_create(struct kvm *kvm);
>>
>>  static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
>>  {
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index 89489996fbc1..65f0c5fb353e 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -67,9 +67,6 @@
>>  #include <linux/kvm_dirty_ring.h>
>>
>>
>> -/* Worst case buffer size needed for holding an integer. */
>> -#define ITOA_MAX_LEN 12
>> -
>>  MODULE_AUTHOR("Qumranet");
>>  MODULE_DESCRIPTION("Kernel-based Virtual Machine (KVM) Hypervisor");
>>  MODULE_LICENSE("GPL");
>> @@ -1349,6 +1346,19 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
>>  {
>>  	struct kvm *kvm = filp->private_data;
>>
>> +#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
>> +	/*
>> +	 * Clear the weak reference of the vm file.
>> +	 * In case vm file is closed by userspace, but kvm still has
>> +	 * other users like vCPUs, clearing this pointer ensures
>> +	 * that we don't have a dangling pointer to a closed file.
>> +	 *
>> +	 * Cleared via rcu_assign_pointer() to ensure proper memory visibility
>> +	 * for concurrent lockless readers under RCU.
>> +	 */
>> +	rcu_assign_pointer(kvm->vm_file, NULL);
>> +#endif
>> +
>>  	kvm_irqfd_release(kvm);
>>
>>  	kvm_put_kvm(kvm);
>> @@ -5476,11 +5486,47 @@ bool file_is_kvm(struct file *file)
>>  }
>>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
>>
>> +struct file *kvm_create_vm_file(unsigned long type, const char *fdname)
>> +{
>> +	struct kvm *kvm = kvm_create_vm(type, fdname);
>> +	struct file *file;
>> +
>> +	if (IS_ERR(kvm))
>> +		return ERR_CAST(kvm);
>> +
>> +	file = anon_inode_getfile("kvm-vm", &kvm_vm_fops, kvm, O_RDWR);
>> +	if (IS_ERR(file)) {
>> +		kvm_put_kvm(kvm);
>> +		return file;
>> +	}
>> +
>> +#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
>> +	/*
>> +	 * Weak reference to the file (without get_file()) to prevent a circular
>> +	 * dependency. Safe because the file's release path clears this pointer
>> +	 * and drops its reference to the VM.
>> +	 *
>> +	 * Written via rcu_assign_pointer() because the pointer can be read
>> +	 * locklessly under RCU (e.g., in kvm_gmem_luo_preserve() via
>> +	 * get_file_active() to prevent lockless ABA races).
>> +	 */
>> +	rcu_assign_pointer(kvm->vm_file, file);
>> +#endif
>> +
>> +	/*
>> +	 * Don't call kvm_put_kvm anymore at this point; file->f_op is
>> +	 * already set, with ->release() being kvm_vm_release().  In error
>> +	 * cases it will be called by the final fput(file) and will take
>> +	 * care of doing kvm_put_kvm(kvm).
>> +	 */
>> +
>> +	return file;
>> +}
>> +
>>  static int kvm_dev_ioctl_create_vm(unsigned long type)
>>  {
>>  	char fdname[ITOA_MAX_LEN + 1];
>>  	int r, fd;
>> -	struct kvm *kvm;
>>  	struct file *file;
>>
>>  	fd = get_unused_fd_flags(O_CLOEXEC);
>> @@ -5489,31 +5535,17 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
>>
>>  	snprintf(fdname, sizeof(fdname), "%d", fd);
>>
>> -	kvm = kvm_create_vm(type, fdname);
>> -	if (IS_ERR(kvm)) {
>> -		r = PTR_ERR(kvm);
>> -		goto put_fd;
>> -	}
>> -
>> -	file = anon_inode_getfile("kvm-vm", &kvm_vm_fops, kvm, O_RDWR);
>> +	file = kvm_create_vm_file(type, fdname);
>>  	if (IS_ERR(file)) {
>>  		r = PTR_ERR(file);
>> -		goto put_kvm;
>> +		goto put_fd;
>>  	}
>>
>> -	/*
>> -	 * Don't call kvm_put_kvm anymore at this point; file->f_op is
>> -	 * already set, with ->release() being kvm_vm_release().  In error
>> -	 * cases it will be called by the final fput(file) and will take
>> -	 * care of doing kvm_put_kvm(kvm).
>> -	 */
>> -	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
>> +	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, file->private_data);
>
> Notifying with file->private_data threw me off... I would rather inline
> the rcu_assign_pointer() in this function and have this line read
> notify(..., kvm) like before.

Yes, I will update it to:

     struct kvm *kvm;
     ...
     kvm = file->private_data;
     notify (..., kvm);

About rcu_assign_pointer, I am not sure, IIUC. that only set the
kvm->vm_file pointer, which does not have any relation with
file->private_data. And keeping the rcu_assign_pointer(kvm->vm_file,
file) at the current place (inside kvm_create_vm_file) logically makes
sense. because, kvm_create_vm_file creates the struct kvm and vm_file,
So, all the relation variables should get updated there.

>
>>
>>  	fd_install(fd, file);
>>  	return fd;
>>
>> -put_kvm:
>> -	kvm_put_kvm(kvm);
>>  put_fd:
>>  	put_unused_fd(fd);
>>  	return r;
>> @@ -6341,6 +6373,11 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
>>  	kfree(env);
>>  }
>>
>> +void kvm_uevent_notify_vm_create(struct kvm *kvm)
>> +{
>> +	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
>> +}
>> +
>>  static void kvm_init_debug(void)
>>  {
>>  	const struct file_operations *fops;
>> diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
>> index 9fcc5d5b7f8d..7aa1d65c3d46 100644
>> --- a/virt/kvm/kvm_mm.h
>> +++ b/virt/kvm/kvm_mm.h
>> @@ -3,6 +3,9 @@
>>  #ifndef __KVM_MM_H__
>>  #define __KVM_MM_H__ 1
>>
>> +/* Worst case buffer size needed for holding an integer as a string. */
>> +#define ITOA_MAX_LEN 12
>> +
>>  /*
>>   * Architectures can choose whether to use an rwlock or spinlock
>>   * for the mmu_lock.  These macros, for use in common code
>> --
>> 2.54.0.1032.g2f8565e1d1-goog
