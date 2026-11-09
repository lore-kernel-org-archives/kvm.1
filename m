Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794254141;
	b=rPqkUGSyYt4oWyz+afV3VUKrdalkcWeo3ViaF7PNFOBq5y0dyVxR6PAsm3vu4HbyR3wW
	 CdLDZAfTFSN2A0Aq+yl+CL3JdZ2UqsQU4Pob5E3+ppIcS/F4+PxtQyUii/vtexCxkPa6V
	 PTIt9HRPzeGvxGnhSm99X6rdvz7+5sDXDVvxtJ9o2CBnMoOLY+AdDDF7aVr6t/QqeqA9K
	 YrA1Nvio+YBRF3zH8KLwU9dskalCaT7TjPBY6HVyw7/xiRaFQTyM2mWfQiw0Fg7CR48qF
	 uJQFe/0VS6eCazb7139wINAnUQYA+LklV1DZtj/I+fpEKCUdLmeNDtoInWMOjnMTgAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=vsEcZqtV2lv2QZR9DYMmC/AF0mepkP+kQ617u7eTRdo=;
	b=2/0fpeug0mnbkymXbT9N7IAN0PGRz9YvJz3vEKvuZ1dl8aVuVtSA4uZaI4WpORPA6l3c
	 JVxRvWhE+B0oGGbExGkvCkSA+wpV/QKH9zxaDC4ZY6+URn3RyvDujQE7qJbEEVZOyDAbG
	 Nzs/KuIA8xUE+tKvx1GSqD6RRTeX9r1wlKt6bwQYLR52fH5NKGeNeT6PanPADI0tYRP+y
	 0I2QEobNIYUB6oFZ0JF4RkzfdDgB139XkhKkqlUYGgJcG3emUtRgUw+BIHPDMB5/mSH6G
	 wmSRzDj9NMyjn+Ky/Hr6k1WTZwcaonxgeGWdUo2oN7fXvSb73T3HRrTulfjggLi7KMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nNuGxWm8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB2C60A2601
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 19:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABB2C60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nNuGxWm8
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91ebdf1c2d1so13797306d6.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 11:55:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794254139; cv=none;
        d=google.com; s=arc-20260327;
        b=Cb7XQ3qTmMdWdBYZMNqIvJ6VES1lLcZpvmUK9i86n3XIrtXvEku+4zRLQtAQGG2iXu
         51yvGmB9HGN8x+JcARLONVfCmU3LA6ALPP/k0OEQI6doOA5oms+ky/t9DVjNGL+1LnPf
         QkQY+5KNS/KpPsXBKXEDOoRRgFs9iN22NLRS8Ko3e5ffh+RcV1sVAHx8Pu2/pc/1Clds
         D9kQU03ug1Inj2OkczVPloNMJ6BGlBtNNXGdPVMbEO7JmDBPVbd0QgizkKgtKYQfIc8P
         uYvLJzIdwyO6MbcUn3TXhhJxIA7DYHGhnpCR1H8tALKQ/t8K3v3FWT2CTyGU+ukKjIQC
         ZpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=vsEcZqtV2lv2QZR9DYMmC/AF0mepkP+kQ617u7eTRdo=;
        fh=XFHjvTU0TZGPJrNmj/59QvCRh07yFRWVFNLhiBcrTTE=;
        b=PUslnkVGK9IX0+gDnVAdv+fGroYEHAwkTuW+Yit8BqT4iSQcXuO6/vWYEWLG1rR70I
         3IWFxaM8IzxLZXmoShqdtn5CQeTFy3iuVzjMp7+bWeJTjUa+wcgFCWymXDg5/BwA+AP8
         3dxcnqL+IudZvc3rdFsEz+e8QgVYZTTWN01+MIqDf5F8eb9P5Ni9xea09Mfwp0tWkQlN
         14wA/c7O4KdE82PqFw39AK17rkbmGQtW7MlGUoIyc2zZe2NkCzNE4f/5AzZC4UYGfMn6
         xNhwJ9fEwIoestRoBQMMY/KgpmI9f0adsjW9JUVZgZxvgC7wF54duocSRYzrDTcTIvsv
         h2fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794254139; x=1794858939; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vsEcZqtV2lv2QZR9DYMmC/AF0mepkP+kQ617u7eTRdo=;
        b=nNuGxWm8Llt4wMSkTawrXFCtJ01glbLkTUhNNxKxqyXsBD0dSWALjhimvqMhO2OxRn
         QVdVQipKx5PjIzJEQQr/sF8toDoGfl0PguXQ/4OZetVUxLVDejmRRFUvTHUI/MQDaUm6
         8xQcLCMRsZ/aD7IQSLJ8XJcnm66ipa+y/gsifit5VlukaYh7OimEPUbRz2bBDAJ2WA0s
         jsSVMH6GELppwjZ5ZNBP0ONytHjT/rt0/OInzCOvGgAOh7rMmMb0lM1H77QtAB/hxoyt
         ZF/DPHqsC6C3PkbWztg92OZJdOSd2fcopjzCFlKGZ6+neC1XBI7g0tv5xX/u8f5p6+/k
         UDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794254139; x=1794858939;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vsEcZqtV2lv2QZR9DYMmC/AF0mepkP+kQ617u7eTRdo=;
        b=SWTFDYd+Z9Z139/wKQUv6PHmNMXUIhl0BPtdPywDI3SMNZvWPxx9HR53IPyGnsk8pE
         FjA3qjo6dnxcyoiA0ynCralP4BgyyAJw1uxeqfc9VmbGzY1BRIsEnyXlJ2ckceS+JgYs
         ySAhSVBZKO8caK6gm/yF74/Hjt9PuZBz/g5x1w0VDkP8U+mKA5VQuHJUSSVnR0cqC5Dh
         sxFiidth6w1smYc22hYIb1Zp9eBBl/K/qz7JDPDu84nNvKEuDGuQ1Cx+4GOGUgbLEvCw
         ii4xmbT5zTxtTUBn192DOi0z2GKqMLfnXeCcV/brtwZbrg+IJwh9kLOnlZ7m3o16ZlO2
         iErw==
X-Forwarded-Encrypted: i=1; AL+hErGRZciJikgb8E+pGWuYG1E9jDLtvw9VaqWBtZimuEe+YG7SvaJfCuE16+wRBs+CLItP8us=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gcLBn0QgCnT8T5mGrzqkkRSRXNnrrJ2sWn8vW31tpYNc5V/S0
	LRDztHZ2PZUTi40YOMUCVSkF+jaiigGpPyOybWszy2FmSpeGH5cauLUmgbPn+2/1BlwzkAT9hCR
	uUpQr0VRIfGI0oRl2BFFVAJyx/XuMJ4mGEHpvwZkD
X-Gm-Gg: AYBFou3o9L3RD7Wqp+YYSIb/K7BuXXiFnxf4fkpUSt2t41cTxEPwqC5Pl+D8gglDy36
	nINp7Iu+Z/kzfLFeEaEcFrQCpf9FIpyG0j6yI//28ebWV5DJRQ9gKNifPZ8a+uIsCYms+SfRSz7
	nHF2DDD5tApbfHRjD6/1QIO6FMQ9Wc8B8q/lkNoatkUBs37TgDaov96snFJK37C+zM2WiLU8Trm
	c1VYuQnrKz1LpXEYVbblJTRg80+OTS5oqyQ1wXqo8MdOh1COQdAacqtZxcQ94kSqV4lIaCJa9vd
	yCzl6PxNQgFuFYxjzhu5hRBszHyODygOUa9mZcVU5P+E65za2YGrjnvj17Q4qQ0M9q+pbsovrXq
	5RSGb9qwgweXJ/skQW84yoEONvOwN6UG3R6WCX0Kpt1Ip8GwLLjyoUUkXjyEM8EDsjoTY4cifko
	9cgEdepNHEBs0BU4OSlRO47gU=
X-Received: by 2002:a05:620a:710b:b0:93e:49eb:a274 with SMTP id
 af79cd13be357-9479f2fa7d5mr94788085a.23.1794254138721; Mon, 09 Nov 2026
 11:55:38 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 11:55:37 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261105-tdx-selftests-v16-9-2024e8fa517a@google.com>
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com> <20261105-tdx-selftests-v16-9-2024e8fa517a@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 11:55:37 -0800
X-Gm-Features: AclHuK-fw27NEX4WLMeH0MQEMu23wQjUHEw6LG3xIqCQa_4vVj4k3LjJhmBS0EU
Message-ID: <CAEvNRgFvkWCM_JDxiamzQW=stgOnY0Xum5aphVv-Zo941zx2sg@mail.gmail.com>
Subject: Re: [PATCH v16 09/20] KVM: selftests: Set up TDX boot code region
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Lisa Wang <wyihan@google.com> writes:

>
> [...snip...]
>
>  /* Leave marker so size of td_boot code can be computed. */
>  .globl td_boot_code_end
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index 564144c40f0a..b4a7089b3636 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -1,8 +1,46 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>
> +#include <linux/sizes.h>
> +
>  #include "processor.h"
> +#include "tdx/td_boot.h"
>  #include "tdx/tdx_util.h"
>
> +/* Arbitrarily selected to avoid overlaps with anything else */
> +#define TD_BOOT_CODE_SLOT	20
> +
> +#define X86_RESET_VECTOR	0xfffffff0ul
> +
> +void tdx_vm_setup_boot_code_region(struct kvm_vm *vm)
> +{
> +	const size_t total_size = TD_BOOT_CODE_SIZE;

This caught my attention because it wasn't quite reverse-fir-tree
ordering.

Naming is confusing here since there's both TD_BOOT_CODE_SIZE and
boot_code_size, so which is the boot code and what is the right size?

If the only use of TD_BOOT_CODE_SIZE is here then maybe we could just
directly memcpy (td_boot_code_end - td_boot) and not have the macro.

> +	const size_t boot_code_size = td_boot_reset_vector_trampoline - td_boot;
> +	const gpa_t boot_code_gpa = X86_RESET_VECTOR - boot_code_size;
> +	gpa_t alloc_gpa = round_down(boot_code_gpa, PAGE_SIZE);
> +	size_t nr_pages = (SZ_4G - alloc_gpa) / PAGE_SIZE;
> +	u64 gmem_flags = 0;
> +	gpa_t gpa;
> +	u8 *hva;
> +
> +	if (kvm_has_gmem_attributes)
> +		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED | GUEST_MEMFD_FLAG_MMAP;
> +	vm_mem_add(vm, VM_MEM_SRC_SHMEM, alloc_gpa, TD_BOOT_CODE_SLOT,
> +		   nr_pages, KVM_MEM_GUEST_MEMFD, -1, 0, gmem_flags);
> +
> +	gpa = ____vm_phy_pages_alloc(vm, nr_pages, alloc_gpa,
> +				     TD_BOOT_CODE_SLOT, true, false);
> +	TEST_ASSERT(gpa == alloc_gpa, "Failed vm_phy_pages_alloc");
> +
> +	virt_map(vm, alloc_gpa, alloc_gpa, nr_pages);
> +	hva = addr_gpa2hva(vm, boot_code_gpa);
> +	memcpy(hva, td_boot, total_size);
> +
> +	hva += boot_code_size;
> +	TEST_ASSERT(hva == addr_gpa2hva(vm, X86_RESET_VECTOR),
> +		    "Expected RESET vector at hva 0x%lx, got %lx",
> +		    (unsigned long)addr_gpa2hva(vm, X86_RESET_VECTOR), (unsigned long)hva);

TEST_ASSERT_EQ would work here, same for the == assertion above.

Not a huge issue,

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

> +}
> +
>  static const struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
>  {
>  	static struct kvm_tdx_capabilities *tdx_cap;
>
> --
> 2.56.0.455.g6c5a503b38-goog
