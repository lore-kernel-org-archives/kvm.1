Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A6235DA49
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861158; cv=pass; b=ZS9Yr86rJwX5Fctj/+oR9q3OCZF3GrHWs8BPu8g4aU4WgqZt2sr15gyxnD2Ki/MLW6unmHP0M0iKARd1rlSnqOhr7fH6QNSJna/vVaX4kkxV6mmnJwOX0KUUequntS7x4endM5Senjcrmk7MbDL0ZoEDPt2xc1D0toVQA5zb3yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861158; c=relaxed/simple;
	bh=y43IQfs1i1le1AIroVpz9/oDYT7obWLVd6/WXo6ERP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhb0wQqUhsxzJ6V06g68XHe5ag/90dMzhsZyb73Kxeso8x9pb9mZNr/kANmAiFvtJW9ID4ua5qQhYujy036OxsHbqJf9+d5yOrnY4SA89vNhNDM8CV1Vz4ijz4AY7a8rMd42B1Re/W/Y7YjPkB4ycV4Wm7NehQEUFRhqnXlMzkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L46S/jwI; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L46S/jwI"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51765531803so213501cf.0
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 02:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781861153; cv=none;
        d=google.com; s=arc-20260327;
        b=BXeHgZy4yL9nvJfUwTGclxOZ/k/wwwEU9BiSTS3kIGSNmCmFK4hfgF2NFmUF8A4OCs
         k0Zdl3xHJXj1vvKoGEWR5Vz5QfJBDtHFaRyCKBc7EPh0SoDLJXgwPoG4hU0OBIT5Y8eH
         PGcieXJ/3YLBObh0VWyB1DZ/PqR+zLbpmWUkFoFLeRYiqLpxzCNVw9O6ndkXOJqvkoSF
         ZfV8U21x7yHcsx17lS8uB18O5xsCOh2BDnjC0OVTu6yH5WAyR4C74V3k35K0MuL3trPU
         wvdaDLbwq+X5xk4ddkm34uUjrigiapu9PqQySNtZMnDKL7Ic2vZJMbo/n6HjwavaSf0i
         Sxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=urVcLx5BPkCCi6p3vFYGwMdjBtbKpYO1ZXkEN7UqG9M=;
        fh=CxfIk4/JXSAXYT4KhSNwavEOu+/nsyCEAsszEwQeFxE=;
        b=nOuvhj2IslkMR0tLhpTxuYSdIxOzhSzBEeR5ldQsS6RHBSxOLYIsmoPNsfk1q4Webe
         Om3dm1KWxGAQMEFn+eUtH9VS2PZFGZvv0vghTxXD3ukEfm7qypIaOrqT11ha8YsggI0B
         etdzyen3m55urUYddHA2odr3GfaNpPOttahbupYPmzNQe4sQeccXysGwd4HQFqQdmB55
         SLRk3qzuW5zdtA4CAv6fsjqUi5ztkEiL6dUlPzqWYK+jf0/Q22rRhwU8C2d+Z9MGL6VK
         cmBockO5ifO844KmCP4QMV8V1I7TOobo9s/Sq9+CnpjGmkHbU4TSD3H28/yHa0AaTiQT
         IhqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781861153; x=1782465953; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=urVcLx5BPkCCi6p3vFYGwMdjBtbKpYO1ZXkEN7UqG9M=;
        b=L46S/jwIVZRxzygAip/YSspQxb4IBXPlUh4UlDLFM1x0BxCH20Bwkb2xPlbmLnbNIg
         t0ssEdQ1SyCGldE08tgNU0lZR8L5bmFEsnDiyknfZxRZEGBaFTQxAiw4OHZTdWfG+A4x
         XfYA8GIC4Feq56obqCdccyJM73XDcEDb3fpR1rCF84DHn6pjuicZ6J6B5jjnvGmgcm9t
         9EPYC+ovxzrBgbRPgXrdnjfwfM2UI4ScX/8hyT/kfhrKkRICDI1E4eOw20+3UIR9qRf/
         3kDqhlBF+m8J16dO6MId+gO5ZOtvAP6C8QVp1+QmViNFU97SEJdLaAE/fempUBAvsQQ/
         uAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781861153; x=1782465953;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=urVcLx5BPkCCi6p3vFYGwMdjBtbKpYO1ZXkEN7UqG9M=;
        b=oOBVsSXXGoRBy5MUHK6UBbxk4wg+Frh289/O1zSm384xWsqfVtqdxu5Ye7i8cR1SDV
         NuLBtexbP+InObkTRnRY2tTAYqP+N0rdKM9xLIWZlHXiwWOBDfOETtymddYgypCWCqjf
         5iGLu4uHuDXnxGta6uNTpa/pORCE8YhdSMTkLvWl7TYW7ag433IWtlxNaO8atPbD9jTO
         tWYhfgOmodJ/Olybz+gwIwqtW7yslvF/+ckN+XaXOLhr8v9bLKryz4riAN0Qym0AqqMQ
         or3NNIIjXkrLTDbhUi1QjfYFkw3y7lzRHbMhbMnHxwK6PHAiFoofCBfMCDnhKJoyszc8
         gAIw==
X-Forwarded-Encrypted: i=1; AFNElJ/mpTj3c00NlSfzrQX5UePAoiycImEShgMr6a9xqhphQlKSfY3aFSUXmQAcBCaCk4Fgiig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Wx3OQAA+sL/oloWb2agJBkyc9KBXZJ1EVrT6lwXFZxGFHIpX
	zFn8G80FAJitce/ntNv0yrEC1LAOxaYcHjgn6dzhFejScVeJo5YcLvXIC439N7YofTivTcFTXVO
	kezs0NiTwmb5tiYQ8acFEHvsR61viATqOZOIiCX3Z
X-Gm-Gg: AfdE7cmW0JvvHnJ4UzjXmv0DFYnQelDicS1JXQB2fUhWnaaEuAInBgloZdeiDkUq1l/
	v/89JDA65ktd2uc2U2kNa4OG74RKjyaV4nKKHhfkHGjnWZRwnOg+n/Ohv85udXU+8Wi7Wx6d59R
	KzwSlwVBDNUpp+CEz8iL0JqWacRG7j+WBDp77Kwzoh8btdxnc7qIl+dxqWWFWGfjbAuByeq5IcQ
	R+QOwtwj2VYGIGqajDFHRMG3LdYddu0v7x6XMKFQgOfyU/BctjeIsoWpYtyabZZl24p6/jUnw==
X-Received: by 2002:a05:622a:4186:b0:516:4f62:85eb with SMTP id
 d75a77b69052e-519e4a74a8emr7841591cf.22.1781861152102; Fri, 19 Jun 2026
 02:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-13-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-13-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 10:25:15 +0100
X-Gm-Features: AVVi8Cepq97zo_gQa9J80U8EU69NTSVdwN_TrW1pA3rg2sfSJVKhF_cpG6CcVaU
Message-ID: <CA+EHjTx2xKjheiW5VzHw_TdWFUqdJqfgu=dOPa=_yaYBMY8uyw@mail.gmail.com>
Subject: Re: [PATCH v8 13/46] KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jun 2026 at 01:31, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> Introduce base support for KVM_SET_MEMORY_ATTRIBUTES2 in guest_memfd, which
> just updates attributes tracked by guest_memfd.
>
> Validate input fields in general. Guard usage of KVM_SET_MEMORY_ATTRIBUTES2
> by making sure requested attributes are supported for this instance of kvm.
>
> A new KVM_SET_MEMORY_ATTRIBUTES2 is defined to support writes (unlike
> KVM_SET_MEMORY_ATTRIBUTES) in addition to reads so it can provide error
> details to userspace. This will be used in a later patch.
>
> The two ioctls use their corresponding structs with no overlap, but
> backward compatibility is baked in for future support of
> KVM_SET_MEMORY_ATTRIBUTES2 and struct kvm_memory_attributes2 in the VM
> ioctl.
>
> The process of setting memory attributes is set up such that the later half
> will not fail due to allocation. Any necessary checks are performed before
> the point of no return.
>
> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> Co-developed-by: Sean Christoperson <seanjc@google.com>
> Signed-off-by: Sean Christoperson <seanjc@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Note sure if it's user error on my part, if I'm applying this to the
wrong base, but I found a build break here on patch 13:
kvm_gmem_invalidate_start() doesn't exist in the base tree. The
function is kvm_gmem_invalidate_begin() here. The rename
(190cc5370a8b6) landed via a different merge path and isn't an
ancestor of the stated base.

Patches 19 and 20 have the same mismatch. Fix for all three is
s/kvm_gmem_invalidate_start/kvm_gmem_invalidate_begin/.

Cheers,
/fuad

> ---
>  include/uapi/linux/kvm.h |  13 ++++++
>  virt/kvm/Kconfig         |   1 +
>  virt/kvm/guest_memfd.c   | 116 +++++++++++++++++++++++++++++++++++++++++++++++
>  virt/kvm/kvm_main.c      |  12 +++++
>  4 files changed, 142 insertions(+)
>
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 419011097fa8e..956877a6aab05 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1649,6 +1649,19 @@ struct kvm_memory_attributes {
>         __u64 flags;
>  };
>
> +#define KVM_SET_MEMORY_ATTRIBUTES2              _IOWR(KVMIO,  0xd2, struct kvm_memory_attributes2)
> +
> +struct kvm_memory_attributes2 {
> +       union {
> +               __u64 address;
> +               __u64 offset;
> +       };
> +       __u64 size;
> +       __u64 attributes;
> +       __u64 flags;
> +       __u64 reserved[12];
> +};
> +
>  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
>
>  #define KVM_CREATE_GUEST_MEMFD _IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 297e4399fbd49..cfa2c78ba5fb9 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -102,6 +102,7 @@ config KVM_MMU_LOCKLESS_AGING
>
>  config KVM_GUEST_MEMFD
>         select XARRAY_MULTI
> +       select KVM_MEMORY_ATTRIBUTES
>         bool
>
>  config HAVE_KVM_ARCH_GMEM_PREPARE
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 65ce795c090d9..0d14548c1ed22 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -541,11 +541,127 @@ bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn)
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_is_private);
>
> +/*
> + * Preallocate memory for attributes to be stored on a maple tree, pointed to
> + * by mas.  Adjacent ranges with attributes identical to the new attributes
> + * will be merged.  Also sets mas's bounds up for storing attributes.
> + *
> + * This maintains the invariant that ranges with the same attributes will
> + * always be merged.
> + */
> +static int kvm_gmem_mas_preallocate(struct ma_state *mas, u64 attributes,
> +                                   pgoff_t start, size_t nr_pages)
> +{
> +       pgoff_t end = start + nr_pages;
> +       pgoff_t last = end - 1;
> +       void *entry;
> +
> +       /* Try extending range. entry is NULL on overflow/wrap-around. */
> +       mas_set(mas, end);
> +       entry = mas_find(mas, end);
> +       if (entry && xa_to_value(entry) == attributes)
> +               last = mas->last;
> +
> +       if (start > 0) {
> +               mas_set(mas, start - 1);
> +               entry = mas_find(mas, start - 1);
> +               if (entry && xa_to_value(entry) == attributes)
> +                       start = mas->index;
> +       }
> +
> +       mas_set_range(mas, start, last);
> +       return mas_preallocate(mas, xa_mk_value(attributes), GFP_KERNEL);
> +}
> +
> +static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> +                                    size_t nr_pages, uint64_t attrs)
> +{
> +       struct address_space *mapping = inode->i_mapping;
> +       struct gmem_inode *gi = GMEM_I(inode);
> +       pgoff_t end = start + nr_pages;
> +       struct maple_tree *mt;
> +       struct ma_state mas;
> +       int r;
> +
> +       mt = &gi->attributes;
> +
> +       filemap_invalidate_lock(mapping);
> +
> +       mas_init(&mas, mt, start);
> +       r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
> +       if (r)
> +               goto out;
> +
> +       /*
> +        * From this point on guest_memfd has performed necessary
> +        * checks and can proceed to do guest-breaking changes.
> +        */
> +
> +       kvm_gmem_invalidate_start(inode, start, end);
> +       mas_store_prealloc(&mas, xa_mk_value(attrs));
> +       kvm_gmem_invalidate_end(inode, start, end);
> +out:
> +       filemap_invalidate_unlock(mapping);
> +       return r;
> +}
> +
> +static long kvm_gmem_set_attributes(struct file *file, void __user *argp)
> +{
> +       struct gmem_file *f = file->private_data;
> +       struct inode *inode = file_inode(file);
> +       struct kvm_memory_attributes2 attrs;
> +       size_t nr_pages;
> +       pgoff_t index;
> +       int i;
> +
> +       if (copy_from_user(&attrs, argp, sizeof(attrs)))
> +               return -EFAULT;
> +
> +       if (attrs.flags)
> +               return -EINVAL;
> +       for (i = 0; i < ARRAY_SIZE(attrs.reserved); i++) {
> +               if (attrs.reserved[i])
> +                       return -EINVAL;
> +       }
> +       if (!kvm_arch_has_private_mem(f->kvm))
> +               return -EINVAL;
> +       if (attrs.attributes & ~KVM_MEMORY_ATTRIBUTE_PRIVATE)
> +               return -EINVAL;
> +       if (attrs.size == 0 || attrs.offset + attrs.size < attrs.offset)
> +               return -EINVAL;
> +       if (!PAGE_ALIGNED(attrs.offset) || !PAGE_ALIGNED(attrs.size))
> +               return -EINVAL;
> +
> +       if (attrs.offset >= i_size_read(inode) ||
> +           attrs.offset + attrs.size > i_size_read(inode))
> +               return -EINVAL;
> +
> +       nr_pages = attrs.size >> PAGE_SHIFT;
> +       index = attrs.offset >> PAGE_SHIFT;
> +       return __kvm_gmem_set_attributes(inode, index, nr_pages,
> +                                        attrs.attributes);
> +}
> +
> +static long kvm_gmem_ioctl(struct file *file, unsigned int ioctl,
> +                          unsigned long arg)
> +{
> +       switch (ioctl) {
> +       case KVM_SET_MEMORY_ATTRIBUTES2:
> +               if (!gmem_in_place_conversion)
> +                       return -ENOTTY;
> +
> +               return kvm_gmem_set_attributes(file, (void __user *)arg);
> +       default:
> +               return -ENOTTY;
> +       }
> +}
> +
>  static struct file_operations kvm_gmem_fops = {
>         .mmap           = kvm_gmem_mmap,
>         .open           = generic_file_open,
>         .release        = kvm_gmem_release,
>         .fallocate      = kvm_gmem_fallocate,
> +       .unlocked_ioctl = kvm_gmem_ioctl,
>  };
>
>  static int kvm_gmem_migrate_folio(struct address_space *mapping,
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 01761f6e25d25..a08b518cdb175 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -105,6 +105,18 @@ module_param(allow_unsafe_mappings, bool, 0444);
>  bool __ro_after_init gmem_in_place_conversion = false;
>  #endif
>
> +#define MEMORY_ATTRIBUTES_MATCH(one, two)                              \
> +       static_assert(offsetof(struct kvm_memory_attributes, one) ==    \
> +                     offsetof(struct kvm_memory_attributes2, two));    \
> +       static_assert(sizeof_field(struct kvm_memory_attributes, one) ==\
> +                     sizeof_field(struct kvm_memory_attributes2, two))
> +
> +/* Ensure the common parts of the two structs are identical. */
> +MEMORY_ATTRIBUTES_MATCH(address, address);
> +MEMORY_ATTRIBUTES_MATCH(size, size);
> +MEMORY_ATTRIBUTES_MATCH(attributes, attributes);
> +MEMORY_ATTRIBUTES_MATCH(flags, flags);
> +
>  /*
>   * Ordering of locks:
>   *
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
