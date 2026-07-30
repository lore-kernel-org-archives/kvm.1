Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BF2399CF5
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785435183; cv=pass; b=RV7uWGYhYmRcmSxQsx/ArNRRpjfpgZcfUF48teP26nHxPTFst46VVoWyA4FSzn3SwCFOZ/RwxWCI8sQFBCvhQ/vxbJujGZcWBtRog2aTd9hgRy0UtVuJ+BPN+BtqpYAPyP2VQpMa0gUPZDSVUxUQy9HLAqOhshKJHO1vVx+SlCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785435183; c=relaxed/simple;
	bh=vP4SBAjY5cYxaFndxMG2sjpjVkz2m/5BGIn+iBJhang=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBabL2d2NqVcz38xdqsolj7iqA2fiF6XKFt+VTg8OJWkTzvQ0WWwKhXUb0npVJPUjbu3ZOq5WaFqZ19MJwBIemnQmATl6hLGVajHwBATLTF+Y5Fc1VqwcBBkqoqBRXK7Ifh1+C0h+pqbL3HrB0nmAJAZKpNNfJ9UPbgPER6+Jqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/TJTNzJ; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/TJTNzJ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-381b831d535so231987a91.0
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 11:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785435176; cv=none;
        d=google.com; s=arc-20260327;
        b=ctq5X5YqZuIntjm5oQ/6U+64hdvUWH9iC7m8oAJtIb9gkggly7OOjVcB8Vl31XghNa
         iRTHkEiundp9hapg7d25AjHCiczERtKT9zP9LJCxPYM1fMRRei8oPKWuGKD9ndEBpe0T
         q7wjeXzpTDvpg5fa9EqoOa01a1r9NvlWnZZAYpKVD8P5c/uIZF/0miJT6KnNqnKwhpZF
         GxDqI+AKTxx30DOs48LZmK8H+M5rtM6M0Iu6PQUbu/lcxT0mtSoZ3l5RjXas6tptgbfU
         CBfpfC3nc0oziSiH4+XiPNr0szR9Y70B2kN2HGaTdacfBEnr/+d4xCQ01kbl//kEqI5t
         Z9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=YghvBOxKZj6r8MAI+WUSEYlYQEu1XclpHCz2MD6Rx8I=;
        fh=NB9zDDnbg6ae8MJk3mxfZIcPxeZQj3j6WzPXXGCGQgI=;
        b=X0A6Swx13DLlyqbTKWFSnZNCjSxQyxsJAjK6NQrCzEgcETolLURrJJ3sxmUz5Cerfi
         pxsoZGFLnrRhFiwrsrBTdSGucxi0nueAHXQpaobzsi607BjaxeeMNxdS5GgEEOoaJZk0
         K37ZZ3bYJu4vsCogryv9GAZcKqwKoEnC5FBqGA8kosdJkM+x5mDS+o+NKTnd3JjIgNsp
         iFWbf+vrUwmKrciOkL/rx3nmLukx9oVzz3hKzULOAce2uxPZIaygde9rI42Mq4o4DS9s
         nTkpvvNRc3OFaXzlMbp8e8oZ3g5S8x/lv5LQuggeB20tnOvXJ4KVL/i+qVo164g8JI2w
         LR8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785435176; x=1786039976; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YghvBOxKZj6r8MAI+WUSEYlYQEu1XclpHCz2MD6Rx8I=;
        b=e/TJTNzJ0zlJVWarGwUr0khRWwRm7ROnzAr9WnxSYAKypmHcbAXRLrcJa2cNeEHpuJ
         Pi0Nyl/L88CxIdojNYITM65XdE/xcUr8mWKuGp6OH0JHWHAoPovJcP8P3Bi2o43HLBlg
         DOW5jcLcuGm2gCZWmiRLRTQuX1a14Ahum0Gm5v+sgNe1dk2zf8ei/eRA1BzhTdjEIw9F
         K50ki8+isWotkmS3vyJ2WDV4a7OGFJRiLgNca78/62lNJKGKP8L+OU+H3+66eSG+IoUH
         zr4ROhy8A9FH25kiC1XHNrMoPQEvDu/6MGwOBu08v1TsOFvsQ56o3J2jw9tU4J5BAcXk
         D4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435176; x=1786039976;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YghvBOxKZj6r8MAI+WUSEYlYQEu1XclpHCz2MD6Rx8I=;
        b=XAHz9w7wohfp6OJmoAuMsVJWBgHNHa0rYikLY5N0TeGffkoWT7a8Un3bHIjDe2IJwz
         3E7CqrsKGVVw6GHf8wMQ0Bv5MsrTnyyjVknlTBFZkSGjw/332M6ZLavCijM5FWsh8z+V
         JzBalK1pEgmmC9oDYxP2lEqVBqS5bnpL+9kvYMNhYlfo4y3Ah4evIzmccpgIbjd02Glh
         EdYU0gws5k0QvsPLYdEyA/qV79Kemky/w1kfkh+4tC1qh9K24bIaeDlVYyIzxNHW8Jvv
         Pzt+eK+2OgeVK+mef3+3uPPNIb7We9BTPv2zsQICPS9G9d8QEjY/6g+FkuZVahDvW96X
         E+8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp7X6yMtyvvEpAQDEC4wj2SsSx3gMDiw6vVnrQ/D/o14V06/Qo6tvUOXWwlmPHF6bpHsGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoIBU4G1nRUDHONlGnx8+krzIGqW8ayxvqvMLNuv5Oz/gVWx3A
	YevcjvR7+lAlHKY+StUOR8oTBYKjiq+CxyUDOMNhdirzxa2m3gqKWs2FZOA7WYSwzGppXDpmJxt
	crXxw2S4DlU2JSj0Z9RnHpVJvEgdXleX05BaC7cnJ
X-Gm-Gg: AR+sD116mLtWTHyymhknmqJsM6imIUMTTYn3SIMDEWCtoFoU6j388S23lSkkBJVrpbt
	CHuY16vTE11G+KdqxY4DEI9yGdG7EAHZN20cYOGYOxAr8cNROyWQDck13V3ckFNJnyN4h/lvEWY
	u2IUlnlspHb2Xk8+tYOvVUIQkRNoZc1nEP7hPD+J2YD5ivW+K+0TPlxJkkseXYK/HsHh0XDxn/p
	04G+xSNkVAH5+24OADkgmhYF04mkFpHds4Q0QzCWolcqA7ceWJdQkaL32u03ZEyegFuy7o4L9fW
	zfk3EgRNFkaUI2ihdD9wjFzSndFD0R8y3KllrYafgO3qIM+RrArR2LAiDI6WXX+wU31ZNo1PKou
	0ebyVqrwFb6Pw6S0KHxAL8RSwbTOyEsWQsw==
X-Received: by 2002:a17:90b:582c:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-38f9bdaf33amr3348945a91.13.1785435175540; Thu, 30 Jul 2026
 11:12:55 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 11:12:54 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 11:12:54 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260728121138.1103610-7-tarunsahu@google.com>
References: <20260728121138.1103610-1-tarunsahu@google.com> <20260728121138.1103610-7-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 11:12:54 -0700
X-Gm-Features: AUfX_myTOZtTYgrc2JARzoakReAlBZfwUvudyD8fyzAtRRNHq5OayI8CE2nMNDE
Message-ID: <CAEvNRgEVxQS2r0_iPHciV=NEKFzwnrfitp-QdP1keAg5Ud7-TQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] KVM: guest_memfd: Move internal definitions to
 internal header
To: Tarun Sahu <tarunsahu@google.com>, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"

Tarun Sahu <tarunsahu@google.com> writes:

> Extract 'struct gmem_file', 'struct gmem_inode', and GMEM_I() from
> virt/kvm/guest_memfd.c into a new internal header virt/kvm/guest_memfd.h.
> Also split __kvm_gmem_create() to expose a non-static
> __kvm_gmem_create_file() helper that returns a 'struct file *' instead of
> an fd.
>

This is done basically to support a new virt/kvm/guest_memfd_luo.c
file.

Would like to know what Sean thinks of this! I'd like to know for future
guest_memfd work too.

> These internal definitions and helpers allow upcoming guest_memfd Live
> Update Orchestrator (LUO) preservation code to access guest_memfd
> internals and reconstruct guest_memfd file instances from preserved state
> without installing them into a file descriptor table up front.
>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  virt/kvm/guest_memfd.c | 68 +++++++++++++++++-------------------------
>  virt/kvm/guest_memfd.h | 39 ++++++++++++++++++++++++
>  2 files changed, 67 insertions(+), 40 deletions(-)
>  create mode 100644 virt/kvm/guest_memfd.h
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index db57c5766ab6..dd84bba8974b 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -7,38 +7,12 @@
>  #include <linux/mempolicy.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/pagemap.h>
> +#include "guest_memfd.h"
>
>  #include "kvm_mm.h"
>
>  static struct vfsmount *kvm_gmem_mnt;
>
> -/*
> - * A guest_memfd instance can be associated multiple VMs, each with its own
> - * "view" of the underlying physical memory.
> - *
> - * The gmem's inode is effectively the raw underlying physical storage, and is
> - * used to track properties of the physical memory, while each gmem file is
> - * effectively a single VM's view of that storage, and is used to track assets
> - * specific to its associated VM, e.g. memslots=>gmem bindings.
> - */
> -struct gmem_file {
> -	struct kvm *kvm;
> -	struct xarray bindings;
> -	struct list_head entry;
> -};
> -
> -struct gmem_inode {
> -	struct shared_policy policy;
> -	struct inode vfs_inode;
> -	struct list_head gmem_file_list;
> -
> -	u64 flags;
> -};
> -
> -static __always_inline struct gmem_inode *GMEM_I(struct inode *inode)
> -{
> -	return container_of(inode, struct gmem_inode, vfs_inode);
> -}
>
>  #define kvm_gmem_for_each_file(f, inode) \
>  	list_for_each_entry(f, &GMEM_I(inode)->gmem_file_list, entry)
> @@ -557,23 +531,17 @@ bool __weak kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
>  	return true;
>  }
>
> -static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
> +struct file *__kvm_gmem_create_file(struct kvm *kvm, loff_t size, u64 flags)
>  {
>  	static const char *name = "[kvm-gmem]";
>  	struct gmem_file *f;
>  	struct inode *inode;
>  	struct file *file;
> -	int fd, err;
> -
> -	fd = get_unused_fd_flags(0);
> -	if (fd < 0)
> -		return fd;
> +	int err;
>
>  	f = kzalloc_obj(*f);
> -	if (!f) {
> -		err = -ENOMEM;
> -		goto err_fd;
> -	}
> +	if (!f)
> +		return ERR_PTR(-ENOMEM);
>
>  	/* __fput() will take care of fops_put(). */
>  	if (!fops_get(&kvm_gmem_fops)) {
> @@ -612,8 +580,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  	xa_init(&f->bindings);
>  	list_add(&f->entry, &GMEM_I(inode)->gmem_file_list);
>
> -	fd_install(fd, file);
> -	return fd;
> +	return file;
>
>  err_inode:
>  	iput(inode);
> @@ -621,7 +588,28 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
>  	fops_put(&kvm_gmem_fops);
>  err_gmem:
>  	kfree(f);
> -err_fd:
> +	return ERR_PTR(err);
> +}
> +
> +static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
> +{
> +	struct file *file;
> +	int fd, err;
> +
> +	fd = get_unused_fd_flags(0);
> +	if (fd < 0)
> +		return fd;
> +
> +	file = __kvm_gmem_create_file(kvm, size, flags);
> +	if (IS_ERR(file)) {
> +		err = PTR_ERR(file);
> +		goto err_put_fd;
> +	}
> +
> +	fd_install(fd, file);
> +	return fd;
> +
> +err_put_fd:
>  	put_unused_fd(fd);
>  	return err;
>  }
> diff --git a/virt/kvm/guest_memfd.h b/virt/kvm/guest_memfd.h
> new file mode 100644
> index 000000000000..c528b046dd69
> --- /dev/null
> +++ b/virt/kvm/guest_memfd.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __KVM_GUEST_MEMFD_H__
> +#define __KVM_GUEST_MEMFD_H__ 1
> +
> +#include <linux/kvm_host.h>
> +#include <linux/fs.h>
> +#include <linux/mempolicy.h>
> +
> +/*
> + * A guest_memfd instance can be associated multiple VMs, each with its own
> + * "view" of the underlying physical memory.
> + *
> + * The gmem's inode is effectively the raw underlying physical storage, and is
> + * used to track properties of the physical memory, while each gmem file is
> + * effectively a single VM's view of that storage, and is used to track assets
> + * specific to its associated VM, e.g. memslots=>gmem bindings.
> + */
> +struct gmem_file {
> +	struct kvm *kvm;
> +	struct xarray bindings;
> +	struct list_head entry;
> +};
> +
> +struct gmem_inode {
> +	struct shared_policy policy;
> +	struct inode vfs_inode;
> +	struct list_head gmem_file_list;
> +
> +	u64 flags;
> +};
> +
> +static inline struct gmem_inode *GMEM_I(struct inode *inode)
> +{
> +	return container_of(inode, struct gmem_inode, vfs_inode);
> +}
> +
> +struct file *__kvm_gmem_create_file(struct kvm *kvm, loff_t size, u64 flags);
> +
> +#endif /* __KVM_GUEST_MEMFD_H__ */
> --
> 2.55.0.229.g6434b31f56-goog
