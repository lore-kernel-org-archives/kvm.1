Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792997070;
	b=bmI2OgNHTmmbPa9acvTM4awgMhNPJPelFdCZh21+gHl8aBGyn7BXpFxaD4TQ+oOPIy0o
	 h5DIqxUg6vfFDRuwsbHAAyAo20jFV7ArqCiHbCv8Zr7p03/3CKPe6zCfICLaeUt1aZICb
	 3tHY4BLXsLtjdkA/HA1OUSe6m5GUtFVElXzc2r3JtOJkWaTNfMxWiyNAtiyW+Hz4mnFA+
	 Ifdnyl+QvhmbKDybCQebHPLBt41hUkoOqR3XoUdQmVsPQ9byqGmn4Tv4B5WMp5TeEcf0b
	 1ze7gQsKTmzkRAqW3O53h/DzOi9G5zIoq6dsR45v//5YP4OBKTuA+SUKxwYE/T9aafw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792997070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=M3EDOowXZsrrhNVEgNXQbzKMdEe3cl0umytkMHrXnV0=;
	b=DJThxC4KZxD/w5v1s3GmjHZISQxeT1A5ikjzAAD0VXa/uxrph25WGARpLjwK7s933Yaj
	 pSEf826EuZUDI+T8NHWZlOo2PhSD9VL2em0KWqg1J5D7Wgp92qb35vlqe8eYXnFVYtH/e
	 1046COBrrNl7I2YV4CFiJS6O81zP0PUkGABjiR0VKouZygU85mT+FzZjon5iXnkzn+b8r
	 rE93q0s63+0SNQ524UhF8CICdUjbTy/lhQXmP4ScjbVFZKo9RWz43O0axs+g9JShxBeBC
	 XdiC7y6UPkofTpQp1jyUd9aao8XM0pFqi339AbKuG+Oj964qM4EgTlMzlGmUJnl9q8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--gongtao.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fF9K+m73;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5638660A261D
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 06:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5638660A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gongtao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=fF9K+m73
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a030e0f9c1so3173115b3a.2
        for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 23:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792997070; x=1793601870; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M3EDOowXZsrrhNVEgNXQbzKMdEe3cl0umytkMHrXnV0=;
        b=fF9K+m730/hslEY2RWIjWXh4j/MqjpulINvJrQ0/0oTdxq34K5F6siWmcNg4d97vA6
         odhmYHiBVU7QeedofFCjWv2NXvDQ+PbWkcb6oyfZ0AIHa32Yh1WLTaOu/IY7cY2iYhtU
         lWP0YqAY/K9xsJEq0n+wYVuhl7eExTA4yz0qO/fodnRz0prlbYf5l/8Pni7UkTMxvrQT
         T4ifb2ZVCP67nK2GKJrmTZ6z5wCYbBTEyVg/b6YKJ5yyCAhtMpcCMTo+Idj6AznT48Fq
         MdLgw9hNwJj7csw31v9/QJ2Vmpn9dtW7E53sK/8hAdzlYzWFAghbkJsZeBMZ13LNFSGF
         ZK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792997070; x=1793601870;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M3EDOowXZsrrhNVEgNXQbzKMdEe3cl0umytkMHrXnV0=;
        b=OlgLltJWVEF7RXBo376LVgVOXk9eNo09i69QV8I4X8x63MC6G6BOBGOHpl9W+Dn9MB
         By5EbcPISYZjYqjHJwAjw9tCnNleNauSS7EIbZJRjrNJ1jM+DD6oA1AmygJOozBDL/nU
         3vcbTyykel4j2El3wkoxSibjiiic7JKux3TFUJSKY94ybKH4yZII0imUopfp/ULTaKt1
         DP2lRHKuehJlBD6EupMPhdjCZ2ixwkhsK9UB5V+VuJP81MwsP2NTY5M2aUABKlaXkclp
         x5W1vjAxGaWzdaiS2dRx3lqcnGB9LpjPBVcx/Zk3Y+F2uCydmingLZo0JSsM8SbbRY/d
         HNpQ==
X-Gm-Message-State: AFq9FYLaBesewirtDqjGDhJ6aCZh93yPpo1rgTOSf3QdnNWMXMAtLZOy
	U31O2A6s/ElzufFtCYXomBPjN6rF/+gUB+NnEJiHfL2vyLAjmTAAhB6n5sBTMXFhANBUW7v70Kj
	pEkZBKBb1f88SqqHmjPBWDw6eF9agggKjYw9KIp46tStewzV4nlc2chhAZvKRrnFjhA50FmJUBt
	a63z19mvZUaez7hoDf+5G/nkwq8taCEo7DUF7aig==
X-Received: from pgby7-n1.prod.google.com ([2002:a05:6a02:6507:10b0:cd6:9a63:3839])
 (user=gongtao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c91a:b0:3e2:a0b7:9af2
 with SMTP id adf61e73a8af0-3e7cd4d63abmr6026951637.65.1792997069364; Sun, 25
 Oct 2026 23:44:29 -0700 (PDT)
Date: Sun, 25 Oct 2026 23:44:21 -0700
In-Reply-To: <20261026064424.3003536-1-gongtao@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261026064424.3003536-1-gongtao@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261026064424.3003536-3-gongtao@google.com>
Subject: [RFC PATCH v3 2/5] KVM: guest_memfd: Add ioctl KVM_LINK_GUEST_MEMFD
From: Tao Gong <gongtao@google.com>
To: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, David Hildenbrand <david@kernel.org>, 
	Ryan Afranji <afranji@google.com>, Vishal Annapurve <vannapurve@google.com>, 
	Sagi Shahar <sagis@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Tao Gong <gongtao@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

A guest_memfd file is bound to the KVM instance that created it and
cannot be bound to another VM's memslots. Add KVM_LINK_GUEST_MEMFD to
link an existing guest_memfd's underlying inode to a new file (and fd)
bound to a target VM, allowing multiple VMs on the same host to use the
same underlying guest_memfd memory without copying (e.g. for intra-host
migration).

Only allow linking between distinct, compatible VMs (same VM type on x86)
so that private memory of a confidential VM cannot be mapped into an
incompatible VM, and serialize additions to the inode's gmem_file_list
with the mapping's invalidate_lock.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
Co-developed-by: Tao Gong <gongtao@google.com>
Signed-off-by: Tao Gong <gongtao@google.com>
---
 Documentation/virt/kvm/api.rst | 42 +++++++++++++++++
 arch/x86/kvm/x86.c             | 10 ++++
 include/linux/kvm_host.h       |  1 +
 include/uapi/linux/kvm.h       |  8 ++++
 virt/kvm/guest_memfd.c         | 83 ++++++++++++++++++++++++++++++++++
 virt/kvm/guest_memfd.h         |  1 +
 virt/kvm/kvm_main.c            | 10 ++++
 7 files changed, 155 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 3d6a4bf01c700..7c527a1e7c487 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6759,6 +6759,48 @@ if the guest_memfd memory was pinned in IOMMU page tables.
 
 See also: :ref:`KVM_SET_MEMORY_ATTRIBUTES`.
 
+4.147 KVM_LINK_GUEST_MEMFD
+--------------------------
+
+:Capability: KVM_CAP_GUEST_MEMFD_LINK
+:Architectures: all
+:Type: vm ioctl
+:Parameters: struct kvm_link_guest_memfd (in)
+:Returns: A file descriptor on success, <0 on error
+
+Errors:
+
+  ========== ===============================================================
+  EINVAL     ``fd`` is not an open guest_memfd file descriptor, ``flags`` or
+             ``reserved`` are not zero, the target VM is not compatible with
+             the VM ``fd`` is associated with (e.g. on x86, the VMs are of
+             different VM types), or ``fd`` is already associated with the
+             target VM.
+  EFAULT     The parameter address was invalid.
+  ENOMEM     Ran out of memory.
+  ========== ===============================================================
+
+::
+
+  struct kvm_link_guest_memfd {
+	__u64 fd;
+	__u64 flags;
+	__u64 reserved[6];
+  };
+
+KVM_LINK_GUEST_MEMFD creates a new guest_memfd file descriptor that is
+associated with the target VM (the VM on which the ioctl is invoked) and refers
+to the same underlying memory as the existing guest_memfd referred to by ``fd``,
+similar to how link() creates another name for an existing file.  The new file
+descriptor can be used in KVM_SET_USER_MEMORY_REGION2 for the target VM, and
+the memory's contents, size, flags and (with in-place conversion) memory
+attributes are shared by all linked guest_memfd instances.
+
+The primary use case is intra-host migration, where the destination VM needs to
+access the same guest memory as the source VM without copying it.
+
+No flags are defined yet; ``flags`` and ``reserved`` must be zero.
+
 .. _kvm_run:
 
 5. The kvm_run structure
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c081e4b9b25de..4427d32290c0f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10648,6 +10648,16 @@ bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 	return gmem_in_place_conversion || !kvm_arch_has_private_mem(kvm);
 }
 
+bool kvm_arch_gmem_link_allowed(struct kvm *dst, struct kvm *src)
+{
+	/*
+	 * Different VM types have different requirements for, and different
+	 * (vendor) state associated with, guest_memfd memory, e.g. memory that
+	 * is private to a TDX guest must never be mapped into a non-TDX VM.
+	 */
+	return dst->arch.vm_type == src->arch.vm_type;
+}
+
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
 int kvm_arch_gmem_make_private(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 			       kvm_pfn_t nr_pages)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 485f18454eb45..5cffb7ad376e1 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2585,6 +2585,7 @@ static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
 #ifdef CONFIG_KVM_GUEST_MEMFD
 bool kvm_gmem_is_private_gfn(struct kvm *kvm, gfn_t gfn);
 bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm);
+bool kvm_arch_gmem_link_allowed(struct kvm *dst, struct kvm *src);
 
 static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
 {
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 8dff2fc1972e9..53fe8dce57db2 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1690,4 +1690,12 @@ struct kvm_pre_fault_memory {
 	__u64 padding[5];
 };
 
+#define KVM_LINK_GUEST_MEMFD	_IOWR(KVMIO,  0xd6, struct kvm_link_guest_memfd)
+
+struct kvm_link_guest_memfd {
+	__u64 fd;
+	__u64 flags;
+	__u64 reserved[6];
+};
+
 #endif /* __LINUX_KVM_H */
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 3ca6f64d48040..54b11747a8c48 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -892,6 +892,15 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 	return true;
 }
 
+/*
+ * Returns true if a guest_memfd instance associated with @src may be linked
+ * into @dst, i.e. if both VMs can safely share the underlying memory.
+ */
+bool __weak kvm_arch_gmem_link_allowed(struct kvm *dst, struct kvm *src)
+{
+	return kvm_arch_has_private_mem(dst) == kvm_arch_has_private_mem(src);
+}
+
 static int kvm_gmem_init_inode(struct inode *inode, loff_t size, u64 flags)
 {
 	struct gmem_inode *gi = GMEM_I(inode);
@@ -970,7 +979,10 @@ static struct file *kvm_gmem_alloc_file(struct kvm *kvm, struct inode *inode,
 	kvm_get_kvm(kvm);
 	f->kvm = kvm;
 	xa_init(&f->bindings);
+
+	filemap_invalidate_lock(inode->i_mapping);
 	list_add(&f->entry, &GMEM_I(inode)->gmem_file_list);
+	filemap_invalidate_unlock(inode->i_mapping);
 
 	return file;
 }
@@ -1026,6 +1038,77 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 	return __kvm_gmem_create(kvm, size, flags);
 }
 
+int kvm_gmem_link(struct kvm *kvm, struct kvm_link_guest_memfd *args)
+{
+	static const char *name = "[kvm-gmem]";
+	u64 flags = args->flags;
+	u64 valid_flags = 0;
+	struct file *dst_file, *src_file;
+	struct gmem_file *gmem;
+	struct timespec64 ts;
+	struct inode *inode;
+	struct fd f;
+	int ret, fd, i;
+
+	if (flags & ~valid_flags)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(args->reserved); i++) {
+		if (args->reserved[i])
+			return -EINVAL;
+	}
+
+	/* Don't let fdget() silently truncate the fd. */
+	if (args->fd > INT_MAX)
+		return -EINVAL;
+
+	f = fdget(args->fd);
+	src_file = fd_file(f);
+	if (!src_file)
+		return -EINVAL;
+
+	ret = -EINVAL;
+	if (src_file->f_op != &kvm_gmem_fops)
+		goto out;
+
+	/* Cannot link a gmem file with the same VM again. */
+	gmem = src_file->private_data;
+	if (gmem->kvm == kvm)
+		goto out;
+
+	if (!kvm_arch_gmem_link_allowed(kvm, gmem->kvm))
+		goto out;
+
+	fd = get_unused_fd_flags(0);
+	if (fd < 0) {
+		ret = fd;
+		goto out;
+	}
+
+	inode = file_inode(src_file);
+	ihold(inode);
+
+	dst_file = kvm_gmem_alloc_file(kvm, inode, name);
+	if (IS_ERR(dst_file)) {
+		iput(inode);
+		ret = PTR_ERR(dst_file);
+		goto out_fd;
+	}
+
+	ts = inode_set_ctime_current(inode);
+	inode_set_atime_to_ts(inode, ts);
+
+	fd_install(fd, dst_file);
+	fdput(f);
+	return fd;
+
+out_fd:
+	put_unused_fd(fd);
+out:
+	fdput(f);
+	return ret;
+}
+
 int kvm_gmem_prepare_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot,
 				   unsigned int fd, uoff_t offset)
 {
diff --git a/virt/kvm/guest_memfd.h b/virt/kvm/guest_memfd.h
index 01bd359d27e30..7ffa4fa7337e9 100644
--- a/virt/kvm/guest_memfd.h
+++ b/virt/kvm/guest_memfd.h
@@ -8,6 +8,7 @@
 int kvm_gmem_init(struct module *module);
 void kvm_gmem_exit(void);
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
+int kvm_gmem_link(struct kvm *kvm, struct kvm_link_guest_memfd *args);
 int kvm_gmem_prepare_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot,
 				   unsigned int fd, uoff_t offset);
 int kvm_gmem_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *slot);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3ed481c4a15b6..70521371b64ab 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5453,6 +5453,16 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = kvm_gmem_create(kvm, &guest_memfd);
 		break;
 	}
+	case KVM_LINK_GUEST_MEMFD: {
+		struct kvm_link_guest_memfd params;
+
+		r = -EFAULT;
+		if (copy_from_user(&params, argp, sizeof(params)))
+			goto out;
+
+		r = kvm_gmem_link(kvm, &params);
+		break;
+	}
 #endif
 	default:
 		r = kvm_arch_vm_ioctl(filp, ioctl, arg);
-- 
2.56.0.257.gf7497c7d27-goog

