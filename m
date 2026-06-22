Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD62336607D
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 23:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782170831; cv=pass; b=IKW7oj5IjHMw+6AwKfaQmDx8JYbK+gt6lZuPy9Y9Io9cX8NoIAvxBarDmNPjf4gWAuKxJXU0t4fTBb2Zh6MufpnyH+FpHuUSXi8coSas+c6T2F0MdyRbW/3+Yhvn+9r6RKUAqU+XnDtv9+lZHtHd++MjLjpLvd+OwGr/1PEMVRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782170831; c=relaxed/simple;
	bh=TD2dhkemy3PiiKLe4OZTgMVkS/VkJHcUIyZaT+TJYAo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBLRM3f2Z1wzd+0Y5ChDGFF3/DGPoKwTkTgnJJu9fgdLexd4sbZ+y6/zKXFJLljqztYDIMe7XiM8E9To/Q8N7qdueObTI8vHk+pWoqTHwXyAA14r9gVndgLWoOmxWr5CYGsxLdruJANdNGxznmWfpcVvEEYmhOE8S8ojziNO/44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MK4QAmOj; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MK4QAmOj"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-13988680a69so11500594c88.0
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 16:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782170828; cv=none;
        d=google.com; s=arc-20240605;
        b=U+yJBAyN1jOqsC4b1jUabphzPrPeHBEeo/Alqh+5Cts0rvO5SZ0jaumMyf3BrERa84
         AMntgX1n6lMn6kVaWC5u+l7W5b9M1J4fkSwbMtuo1qQ07HapELkjwjytSVyPYV2HL+fS
         7IuHajMdnhj9YuyYeHdoMInbRwl9ZBESWNlry/o7L5c2NzRlqZBZ4C4NZCvYDN1s4/Zu
         j9Mtl/WIBISL5hpWqueTnV79ngQC61KYDiRmRW0SSbIyMVyAsr+Ae+UKGksyn6ohUvm1
         l3tpu6Dnhqx6jBlbnV3675rY4+MsCzxOVHaTzHxUriBoj/hMXoZRX7alzasan4Ysvi1X
         XNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8z5zT7JXgptWFjE3jHFCHBVUed62ggfr+7Ys0A7VNqY=;
        fh=BAv1Vd0ib/FzNoAQeGj+NzkX5lzYPWHYk1xFI990Uxg=;
        b=IileLUgIEMDNJerlB1AuchRo/A1f3/gkxlVcB9RRZA3LwHX7wQEV1ZTqGlAhF0YfCF
         IuE+45B2WJzXnoPXg33RdNTouHT+COVb22Oehdi4HYQrCO7rGI+yeJfZOKMU0oV8RMO8
         zHKqipkuLpVyoU/76NCwlID7tbYMWVUJWahgT7p9hjlddmCK0+x0XJYG484ZMhMBJiSG
         mzS+Csj698AFv7tOFFcAy9CW9KenuzDVNF+776jIwwy6QnS2vLhav+Ht5fKOveKS/X80
         cSpmFD3J6hRSHNKiAAwJXUrpm6yIatDO5GvMebMDImYuHLVXNW0MJIC4jCsgVGfjhadu
         fXyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782170828; x=1782775628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8z5zT7JXgptWFjE3jHFCHBVUed62ggfr+7Ys0A7VNqY=;
        b=MK4QAmOj9UIrY/QDK3TdWIp4ukMR1DYcWMTmu81isLim1I1mAQoClu6VqTnzUilnWc
         8PKJkDer4t1HDWnTO1150tOoFjj22wGyHIC7BLBly7BSSBeRstPitz4jkXfmxTv2V1uj
         xHTuvfDduO/SCXWQGIfCpTH9wR7jEl6qE0ixZrs9FT5CcDjwvhMmwa2rqaDZwC2Pjd4Q
         JyXTDxOWjxyXFZf6RVkkRV0eFLXPBT1Q3dxubgnHafvSQB8HZc53pYo5QPum0AmgIw74
         ETqem9jlSO6EpQs5adYj1nFomAlB8NU4ijh/t9JlLnOukqADGQzeTnFbg5qy5ivVDDu+
         1CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782170828; x=1782775628;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8z5zT7JXgptWFjE3jHFCHBVUed62ggfr+7Ys0A7VNqY=;
        b=sdnCFA0sa7OYBYdGWDFHD/TpVXP3Ufxq/JWgZDz1DvHr3UXytYQ30sjk5lASwNc2a7
         rf6gQLJQ+jNg5HMEFgvpKODdVQAQN6d4t5q2y8ZBZOSwGEeip6mgmHZUysWkCYfgPidn
         9IPPruos55kbWtVEEuilXNfpKVzJjOZBjNY51hqaiqlYHQTNQBfKcgNa0KvxGmVBX2PB
         C6mv1NIzW2BEdlwXLbyFv3VfKWwZDkR7Y08bKyxZRNm06l58NkBMf9xRmd+BWVzEz+RA
         4ZQXwJPrrer6yVgXOBRhohF0eB70noXWNKFeZwA2Up4fPVofA7Jq4mi9qUbXutr6BssR
         PGkA==
X-Forwarded-Encrypted: i=1; AFNElJ+1xCdQLc20axq40QS3cfT3o0MNTG2JiVGhR/1s9wCyQic9iS4s0riOyXXTJ8MPKe5ZhN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNCQAzj54+UsQxQTG9vl4oaBbfT2eEvF67nkBzWAXnualI6n//
	65uPVfA42hhvdkSPQKapl1NsXC6IBY/CDvuzf3sly5j49U3smzwqstA6K9b2yh5G2xx44UBiJsq
	G8SL9HyXskFbyQ4Y4qfUNB+WrvM2aIZudtLn+A4yo
X-Gm-Gg: AfdE7clrBjLVIwOD3ZsC6otWckyVTXX9jxssQmQFBQXLXEuQz2S53H8FgM9pWVdmAv/
	9g35tzYO4bsp8DBthOsb3O8BF/eCLKQ9xBXbIC0witgWawkAwvLfrbVfQtg0d/2VMS9+6EXeBnq
	gWdXpHgzLPGigE4Uo+3Y7Q8QqbG8yGf1FtklFmF9fB7tF9LxjdMRpl22gTbB1Jw1GZ0sw5aojBB
	y6yoJLZY8HY0HzI8aVYuaUNbO5DLkewNRstJ7QSsgtfHBwEQaO5mxOQPXGE9NHws7fA7td6V98/
	gp88nDEytkNvyHa0FbHJd1WirRgotBrGmffr4Zd7TVZsRpuHmiqBuej5RCU=
X-Received: by 2002:a05:7022:662a:b0:138:49ea:f467 with SMTP id
 a92af1059eb24-139c6e2da0bmr42465c88.0.1782170826758; Mon, 22 Jun 2026
 16:27:06 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 16:27:05 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 16:27:05 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <4b2216f5c459fe699a3f62464cbc765624e20ae6.1780676742.git.tarunsahu@google.com>
References: <cover.1780676742.git.tarunsahu@google.com> <4b2216f5c459fe699a3f62464cbc765624e20ae6.1780676742.git.tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jun 2026 16:27:05 -0700
X-Gm-Features: AVVi8Cehz0Rg1LgwIZbVcyJm62KBqkPPz4LAbN_M8Nt57BLwYaGpvUyCozqDq9s
Message-ID: <CAEvNRgGYM+evk5H-bU8suU++zX3-w25fcc+9mu1YoNG8DtysHw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/10] kvm: guest_memfd_luo: add support for
 guest_memfd preservation
To: Tarun Sahu <tarunsahu@google.com>, Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
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

Tarun Sahu <tarunsahu@google.com> writes:

> This patch sets up the basic infrastructure to preserve the guest_memfd.
> Currently this supports only fully shared guest_memfd and backed by
> PAGE_SIZE pages.
>
> It registers a new LUO file handler for guest_memfd files to serialize
> and deserialize guest memory. This allows preserving guest memory backed
> by guest_memfd across updates, ensuring that guest instances can be
> resumed seamlessly without losing their memory contents.
>
> Preservation is straight forward. It walks through the folios and
> serialize them.
>
> There is kvm_gmem_freeze call on preserve which freeze the guest_memfd
> inode. It avoids any changes to inode mapping with fallocate calls or
> any new fault allocation (fails) on or after preservation. No need to check
> this during the page fault as preservation is only supported for
> pre-faulted/pre-allocated guest_memfd.
>
> While retrieving the guest_memfd, it requires the struct kvm to create
> new guest_memfd. So it first get the vm_file from the same session using
> the token passed during the preservation. And use it to get
> vm_file->kvm.
>
> This change also update the MAINTAINERS list.
>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  MAINTAINERS                 |   1 +
>  include/linux/kho/abi/kvm.h |  79 +++++-
>  virt/kvm/Makefile.kvm       |   2 +-
>  virt/kvm/guest_memfd_luo.c  | 485 ++++++++++++++++++++++++++++++++++++
>  virt/kvm/kvm_main.c         |   7 +
>  virt/kvm/kvm_mm.h           |   4 +
>  6 files changed, 571 insertions(+), 7 deletions(-)
>  create mode 100644 virt/kvm/guest_memfd_luo.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9bfc3c1f6676..16cba790a84d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14418,6 +14418,7 @@ L:	kexec@lists.infradead.org
>  L:	kvm@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
> +F:	virt/kvm/guest_memfd_luo.c
>  F:	virt/kvm/kvm_luo.c
>
>  KVM PARAVIRT (KVM/paravirt)
> diff --git a/include/linux/kho/abi/kvm.h b/include/linux/kho/abi/kvm.h
> index 718db68a541a..42074d76e04a 100644
> --- a/include/linux/kho/abi/kvm.h
> +++ b/include/linux/kho/abi/kvm.h
> @@ -9,20 +9,23 @@
>  #define _LINUX_KHO_ABI_KVM_H
>
>  #include <linux/types.h>
> +#include <linux/bits.h>
>  #include <linux/kho/abi/kexec_handover.h>
>
>  /**
> - * DOC: KVM Live Update ABI
> + * DOC: KVM and guest_memfd Live Update ABI
>   *
> - * KVM uses the ABI defined below for preserving its state
> + * KVM and guest_memfd use the ABI defined below for preserving their states
>   * across a kexec reboot using the LUO.
>   *
> - * The state is serialized into a packed structure `struct kvm_luo_ser`
> - * which is handed over to the next kernel via the KHO mechanism.
> + * The state is serialized into packed structures (struct kvm_luo_ser and
> + * struct guest_memfd_luo_ser) which are handed over to the next kernel via
> + * the KHO mechanism.
>   *
> - * This interface is a contract. Any modification to the structure layout
> + * This interface is a contract. Any modification to the structure layouts
>   * constitutes a breaking change. Such changes require incrementing the
> - * version number in the KVM_LUO_FH_COMPATIBLE compatibility string.
> + * version number in the KVM_LUO_FH_COMPATIBLE or
> + * GUEST_MEMFD_LUO_FH_COMPATIBLE compatibility strings.
>   */
>
>  /**
> @@ -36,4 +39,68 @@ struct kvm_luo_ser {
>  /* The compatibility string for KVM VM file handler */
>  #define KVM_LUO_FH_COMPATIBLE	"kvm_vm_luo_v1"
>
> +/**
> + * struct guest_memfd_luo_folio_ser - Serialization layout for a single folio in guest_memfd.
> + * @pfn:   Page Frame Number of the folio.
> + * @index: Page offset of the folio within the file.
> + * @flags: State flags associated with the folio.
> + */
> +struct guest_memfd_luo_folio_ser {
> +	u64 pfn:52;
> +	u64 flags:12;
> +	u64 index;
> +} __packed;
> +
> +/**
> + * GUEST_MEMFD_LUO_FOLIO_UPTODATE - The folio is up-to-date.
> + *
> + * This flag is per folio to check if the folio is uptodate.
> + */
> +#define GUEST_MEMFD_LUO_FOLIO_UPTODATE	BIT(0)
> +
> +
> +/**
> + * GUEST_MEMFD_LUO_FLAG_MMAP - The guest_memfd supports mmap.
> + *
> + * This flag indicates that the guest_memfd supports host-side mmap.
> + */
> +#define GUEST_MEMFD_LUO_FLAG_MMAP		BIT(0)
> +
> +/**
> + * GUEST_MEMFD_LUO_FLAG_INIT_SHARED - Initialize memory as shared.
> + *
> + * This flag indicates that the guest_memfd has been initialized as shared
> + * memory.
> + */
> +#define GUEST_MEMFD_LUO_FLAG_INIT_SHARED	BIT(1)
> +
> +/**
> + * GUEST_MEMFD_LUO_SUPPORTED_FLAGS - Supported guest_memfd LUO flags mask.
> + *
> + * A mask of all guest_memfd preservation flags supported by this version
> + * of the KVM LUO ABI.
> + */
> +#define GUEST_MEMFD_LUO_SUPPORTED_FLAGS	(GUEST_MEMFD_LUO_FLAG_MMAP | \
> +						 GUEST_MEMFD_LUO_FLAG_INIT_SHARED)
> +
> +/**
> + * struct guest_memfd_luo_ser - Main serialization structure for guest_memfd.
> + * @size:      The size of the file in bytes.
> + * @flags:     File-level flags.
> + * @nr_folios: Number of folios in the folios array.
> + * @vm_token:  Token of the associated KVM VM instance.
> + * @folios:    KHO vmalloc descriptor pointing to the array of
> + *             struct guest_memfd_luo_folio_ser.
> + */
> +struct guest_memfd_luo_ser {
> +	u64 size;
> +	u64 flags;
> +	u64 nr_folios;
> +	u64 vm_token;
> +	struct kho_vmalloc folios;
> +} __packed;
> +
> +/* The compatibility string for GUEST_MEMFD file handler */
> +#define GUEST_MEMFD_LUO_FH_COMPATIBLE	"guest_memfd_luo_v1"
> +
>  #endif /* _LINUX_KHO_ABI_KVM_H */
> diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
> index c1a962159264..d30fca094c42 100644
> --- a/virt/kvm/Makefile.kvm
> +++ b/virt/kvm/Makefile.kvm
> @@ -13,4 +13,4 @@ kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
>  kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
>  kvm-$(CONFIG_HAVE_KVM_PFNCACHE) += $(KVM)/pfncache.o
>  kvm-$(CONFIG_KVM_GUEST_MEMFD) += $(KVM)/guest_memfd.o
> -kvm-$(CONFIG_LIVEUPDATE_GUEST_MEMFD) += $(KVM)/kvm_luo.o
> +kvm-$(CONFIG_LIVEUPDATE_GUEST_MEMFD) += $(KVM)/guest_memfd_luo.o $(KVM)/kvm_luo.o
> diff --git a/virt/kvm/guest_memfd_luo.c b/virt/kvm/guest_memfd_luo.c
> new file mode 100644
> index 000000000000..d466f889c9aa
> --- /dev/null
> +++ b/virt/kvm/guest_memfd_luo.c
> @@ -0,0 +1,485 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (c) 2026, Google LLC.
> + * Tarun Sahu <tarunsahu@google.com>
> + *
> + * Guestmemfd Preservation for Live Update Orchestrator (LUO)
> + */
> +
> +/**
> + * DOC: Guestmemfd Preservation via LUO
> + *
> + * Overview
> + * ========
> + *
> + * Guest memory file descriptors (guest_memfd) can be preserved over a kexec
> + * reboot using the Live Update Orchestrator (LUO) file preservation. This
> + * allows userspace to preserve VM memory across kexec reboots.
> + *
> + * The preservation is not intended to be transparent. Only select properties
> + * of the guest_memfd are preserved, while others are reset to default.
> + *
> + * Preserved Properties
> + * ====================
> + *
> + * The following properties of guest_memfd are preserved across kexec:
> + *
> + * File Size
> + *   The size of the file is preserved.
> + *
> + * File Contents
> + *   All folios present in the page cache are preserved.
> + *
> + * File-level Flags
> + *   The file-level flags (such as MMAP support and INIT_SHARED default mapping)
> + *   are preserved.
> + *
> + * Non-Preserved Properties
> + * ========================
> + *
> + * NUMA Memory Policy
> + *   NUMA memory policies associated with the guest_memfd are not preserved.
> + */
> +#include <linux/liveupdate.h>
> +#include <linux/kvm_host.h>
> +#include <linux/pagemap.h>
> +#include <linux/file.h>
> +#include <linux/err.h>
> +#include <linux/anon_inodes.h>
> +#include <linux/magic.h>
> +#include <linux/kexec_handover.h>
> +#include <linux/kho/abi/kexec_handover.h>
> +#include <linux/kho/abi/kvm.h>
> +#include "guest_memfd.h"
> +
> +static int kvm_gmem_luo_walk_folios(struct address_space *mapping,
> +		pgoff_t end_index, struct guest_memfd_luo_folio_ser *folios_ser,
> +		u64 *out_count)
> +{
> +	struct folio_batch fbatch;
> +	pgoff_t index = 0;
> +	u64 count = 0;
> +	int err = 0;
> +
> +	folio_batch_init(&fbatch);
> +	while (index < end_index) {
> +		unsigned int nr, i;
> +
> +		nr = filemap_get_folios(mapping, &index, end_index - 1, &fbatch);
> +		if (nr == 0)
> +			break;
> +
> +		for (i = 0; i < nr; i++) {
> +			struct folio *folio = fbatch.folios[i];
> +
> +			if (folios_ser) {
> +				if (folio_test_hwpoison(folio)) {
> +					err = -EHWPOISON;
> +					folio_batch_release(&fbatch);
> +					goto out;
> +				}
> +				err = kho_preserve_folio(folio);
> +				if (err) {
> +					folio_batch_release(&fbatch);
> +					goto out;
> +				}
> +
> +				folios_ser[count].pfn = folio_pfn(folio);
> +				folios_ser[count].index = folio->index;
> +				folios_ser[count].flags = folio_test_uptodate(folio) ?
> +							  GUEST_MEMFD_LUO_FOLIO_UPTODATE : 0;
> +			}
> +			count++;
> +		}
> +		folio_batch_release(&fbatch);
> +		cond_resched();
> +	}
> +
> +out:
> +	*out_count = count;
> +	return err;
> +}
> +
> +static bool kvm_gmem_luo_can_preserve(struct liveupdate_file_handler *handler, struct file *file)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct gmem_file *gmem_file = file->private_data;
> +	struct kvm *kvm = gmem_file->kvm;
> +
> +	if (inode->i_sb->s_magic != GUEST_MEMFD_MAGIC)
> +		return 0;
> +

How does .can_preserve decide route to this function? If it already
routes here, wouldn't this inode definitely be a guest_memfd file?

> +	if (kvm_arch_has_private_mem(kvm))
> +		return 0;
> +
> +	if (mapping_large_folio_support(inode->i_mapping))
> +		return 0;
> +
> +	return 1;

Let's return true and false rather than relying on casting.

> +}
> +
> +static int kvm_gmem_luo_preserve(struct liveupdate_file_op_args *args)
> +{
> +	struct guest_memfd_luo_folio_ser *folios_ser = NULL;
> +	u64 count = 0, gmem_flags, abi_flags = 0;
> +	struct guest_memfd_luo_ser *ser;
> +	struct address_space *mapping;
> +	struct gmem_file *gmem_file;
> +	struct inode *inode;
> +	pgoff_t end_index;
> +	struct kvm *kvm;
> +	int err = 0;
> +	long size;
> +
> +	inode = file_inode(args->file);

I think to lock out all allocates, you'd have to take
filemap_invalidate_lock() before freezing.

> +	kvm_gmem_freeze(inode, true);
> +
> +	mapping = inode->i_mapping;
> +	size = i_size_read(inode);
> +	if (!size) {
> +		err = -EINVAL;
> +		goto err_unfreeze_inode;
> +	}
> +
> +	if (WARN_ON_ONCE(!PAGE_ALIGNED(size))) {
> +		err = -EINVAL;
> +		goto err_unfreeze_inode;
> +	}
> +
> +	gmem_file = args->file->private_data;
> +	kvm = gmem_file->kvm;
> +
> +	gmem_flags = READ_ONCE(GMEM_I(inode)->flags);
> +	if (gmem_flags & ~(GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED

Why condition this on MMAP?

After conversions lands, we'd have to iterate to check that the entire
guest_memfd is shared offset-by-offset instead of checking for INIT_SHARED.

> +				| GUEST_MEMFD_F_MAPPING_FROZEN)) {

This would always be true since kvm_gmem_freeze() is done above.

> +		err = -EOPNOTSUPP;
> +		goto err_unfreeze_inode;
> +	}
> +
> +	if (gmem_flags & GUEST_MEMFD_FLAG_MMAP)
> +		abi_flags |= GUEST_MEMFD_LUO_FLAG_MMAP;
> +	if (gmem_flags & GUEST_MEMFD_FLAG_INIT_SHARED)
> +		abi_flags |= GUEST_MEMFD_LUO_FLAG_INIT_SHARED;
> +

Is it intentional to have a different set of flags that are actually
preserved? I think we should refactor out a function to transfer the
flags over.

> +	end_index = size >> PAGE_SHIFT;
> +
> +	ser = kho_alloc_preserve(sizeof(*ser));
> +	if (IS_ERR(ser)) {
> +		err = PTR_ERR(ser);
> +		goto err_unfreeze_inode;
> +	}
> +
> +	/* First pass: Count the folios present in the page cache */
> +	err = kvm_gmem_luo_walk_folios(mapping, end_index, NULL, &count);
> +	if (err)
> +		goto err_free_ser;
> +
> +	ser->size = size;
> +	ser->flags = abi_flags;
> +	ser->nr_folios = count;
> +	ser->vm_token = 0; // It will be set during the kvm_gmem_luo_freeze()

I don't think // is commonly used.

> +
> +	if (count > 0) {
> +		folios_ser = vcalloc(count, sizeof(*folios_ser));
> +		if (!folios_ser) {
> +			err = -ENOMEM;
> +			goto err_free_ser;
> +		}
> +
> +		/* Second pass: Fill the metadata array and preserve folios */
> +		err = kvm_gmem_luo_walk_folios(mapping, end_index, folios_ser, &count);

I think it's clearer to just define 2 functions rather than using the
same function twice to do these different things. The comments on the
two passes can then be dropped.

> +		if (err)
> +			goto err_unpreserve_unlocked;
> +
> +		if (WARN_ON_ONCE(count != ser->nr_folios)) {
> +			err = -EINVAL;
> +			goto err_unpreserve_unlocked;
> +		}
> +	}
> +
> +	if (count > 0) {
> +		err = kho_preserve_vmalloc(folios_ser, &ser->folios);
> +		if (err)
> +			goto err_unpreserve_unlocked;
> +	}
> +
> +	args->serialized_data = virt_to_phys(ser);
> +	args->private_data = folios_ser;
> +
> +	return 0;
> +
> +err_unpreserve_unlocked:
> +	for (long i = (long)count - 1; i >= 0; i--) {

Not sure if it's common to define long i inline.

> +		struct folio *folio = pfn_folio(folios_ser[i].pfn);
> +
> +		kho_unpreserve_folio(folio);
> +	}
> +	vfree(folios_ser);
> +err_free_ser:
> +	kho_unpreserve_free(ser);
> +err_unfreeze_inode:
> +	kvm_gmem_freeze(inode, false);
> +	return err;
> +}
> +
> +static int kvm_gmem_luo_freeze(struct liveupdate_file_op_args *args)
> +{
> +	struct guest_memfd_luo_ser *ser;
> +	struct gmem_file *gmem_file;
> +	struct kvm *kvm;
> +	struct file *kvm_file;
> +	u64 vm_token;
> +	int err;
> +
> +	if (WARN_ON_ONCE(!args->serialized_data))
> +		return -EINVAL;
> +
> +	ser = phys_to_virt(args->serialized_data);
> +
> +	gmem_file = args->file->private_data;
> +	kvm = gmem_file->kvm;
> +
> +	/*
> +	 * Obtain a strong reference to kvm->vm_file to prevent the SLAB_TYPESAFE_BY_RCU
> +	 * file memory from being reallocated while it is being processed.
> +	 */
> +	kvm_file = get_file_active(&kvm->vm_file);
> +	if (!kvm_file)
> +		return -ENOENT;
> +
> +	err = liveupdate_get_token_outgoing(args->session, kvm_file, &vm_token);
> +	fput(kvm_file);
> +	if (err)
> +		return err;
> +
> +	ser->vm_token = vm_token;
> +	return 0;
> +}
> +
> +static void kvm_gmem_luo_discard_folios(
> +	const struct guest_memfd_luo_folio_ser *folios_ser,
> +	u64 nr_folios, u64 start_idx)
> +{
> +	long i;
> +
> +	for (i = start_idx; i < nr_folios; i++) {
> +		struct folio *folio;
> +		phys_addr_t phys;
> +
> +		if (!folios_ser[i].pfn)
> +			continue;
> +
> +		phys = PFN_PHYS(folios_ser[i].pfn);
> +		folio = kho_restore_folio(phys);
> +		if (folio)
> +			folio_put(folio);
> +	}
> +}
> +
> +static void kvm_gmem_luo_unpreserve(struct liveupdate_file_op_args *args)
> +{
> +	struct guest_memfd_luo_folio_ser *folios_ser = args->private_data;
> +	struct guest_memfd_luo_ser *ser;
> +	long i;
> +
> +	if (WARN_ON_ONCE(!args->serialized_data))
> +		return;
> +
> +	ser = phys_to_virt(args->serialized_data);
> +	if (!ser)
> +		return;
> +
> +	if (ser->nr_folios > 0)
> +		kho_unpreserve_vmalloc(&ser->folios);
> +	for (i = ser->nr_folios - 1; i >= 0; i--) {
> +		struct folio *folio;
> +
> +		if (!folios_ser[i].pfn)

Is it possible for pfn to be 0 here? Perhaps this should be a
WARN_ON_ONCE().

> +			continue;
> +
> +		folio = pfn_folio(folios_ser[i].pfn);
> +		kho_unpreserve_folio(folio);
> +	}
> +	vfree(folios_ser);
> +
> +	kho_unpreserve_free(ser);
> +	kvm_gmem_freeze(file_inode(args->file), false);
> +}
> +
>
> [...snip...]
>
