Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B695A0ADE
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788894203; cv=pass; b=VVNXJzUsTcw0FMxVFBGUuo7p32bMMeSY3gXB9Pbz8EXL1qLjfhWgMi5uODtF3FnH2lXGb3bQ9qm3/gFc0ZH3Y/kOd9C6c1C4aAydYqehROAfXjFFNQ6BdRwVy8t2wSFD83zpzk6vHofLB82lPVLMdCBXGetq33yM6kifgya0Tv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788894203; c=relaxed/simple;
	bh=SirRPd8MEjuE0M+o4ZIQ6nFLVuzs+EvDMR2q6/kdoLg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kk45PAxXvow8ze3mAos++78hhBFFgjSi42U8se/nILEYFGmlgwvSGn6QYNhLupA9uNsDH2Ptl9VQpw7ZeHSV5kLOY04hQPzmth5aRCJrrgM7+NbZfhkCTRqKhtFkdj5hr1sW/v1sLZ/X7YkZaCMrSYyabPva2e7kg6I67usNeRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CBVK+XcI; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CBVK+XcI"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90cc0ebbf4bso43782376d6.3
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 12:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788894200; cv=none;
        d=google.com; s=arc-20260327;
        b=jaCV8xqa/mDrd9ZY5eNaPZpBX2c4raPrdXqDYVWn3TnZ+lxHVvEtCqlI9HZKuduv7z
         IuU5PDGKB5XL9NkO9i2Vyhp2nT6fH34KCpuEX0O7Ub+gOoO0WnRV7Ear4hpuxx31rH5V
         wDrPMPG2zPXpmeN/hAlFYqWmk49cgfbUKanOJLZ4Rjz+yHCJ918YLsMFdgh2L/r1MRwH
         dH7GNJnaf9NPd9mPqOYBahEoI5EtKEXDAaJP12PlVLD5nlBDImjKZ/yOhbcPalxRF9I2
         tX8LA6ukEujNYOIL0dYiN6FkeyUKwcyTknFvL8HW1uT++J1cHO7HmMOFOhzUlJbG8Y7/
         GR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=CCBQFS/NlhUte57G9Iz7jkmENxjPMvZ6ht3E4pgVgq4=;
        fh=WIc/KGX/eBoYxsm9DlGQv+OM60hqOy1ETd2cata2W4M=;
        b=OCX298v4KYb1YrrYx1+xQX37bPhA5V+llDpEH/FaOZATiBDVEwNoVz8TYoHoGViSdf
         7NOkuZ/Z7ZpvM+b55s1Pnnp1Qz9C8LBHEUypiLoK9ZEfieShWxkpuEgxUJTO4GelRDf8
         IpR+WFNU25n0S30UmHGMgrWxTzLjC4jC3e0h+Wf5OBpKXYE8/4DuyJCJ7PDj/fCb6e9+
         P86ICiQ8fUgA1BmOWJRdHVCZYdHBzViUxpEAaKG2J+Af1Rre4qx7g9ukupVcVVraV9qI
         BXflkePdWtAVV26L4v+wLNu6pyGxYBzX1EyEatQ7oT9PlXFnpx6AHk/e2iMgZMdCgJx0
         8hZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788894200; x=1789499000; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CCBQFS/NlhUte57G9Iz7jkmENxjPMvZ6ht3E4pgVgq4=;
        b=CBVK+XcIap/64eG0GVnc0c8DwXLC7/QpA0q066jg4t1Dm/Nn+cIph5WGt3IqQEWTDF
         L/xAPFV83elhby1bm0Tso/Hraii+omYqfrcyIykj4Gq8sNFTh5mBNvcpuybf3Pite+Dm
         W9oeqRJ/8IBv27/dN4o0IOyKh52eY5vC0GeCUvQPaTneYgdaALWH3dGqVvwxsHrugEAi
         LtMVxcmNH3Qt1t91s9cMYIn0IPTmoEke2Ii3YaagMnHFbkB/oavZkCNizCZaIYGygVhl
         sh1xPrkSSGkLNxaqSUCjJhHtRNH4JaGBfLmzQ5NmYLr/UiVqyC6O6sqPGdfFI+ccWmEY
         NPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788894200; x=1789499000;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CCBQFS/NlhUte57G9Iz7jkmENxjPMvZ6ht3E4pgVgq4=;
        b=Dagkx/VND9yqphsaFHSCIVyXtVraYAkUeyxFDTMJd0ezeJ4v5ZaVUfT86bgK23LHxb
         Mu3TjmjnHT2kv06iSI1opsleRame1Te5OAlGNLnArdU2B9FOp1sH6ubnLYt6/9rI1ag6
         G7LCfLVxls0/5uI8w/nHh0HbXLyArZQ1Pf8j2TFqrQM+QGYGB8U0p0ftAdn9uC7kbBNW
         WefFNdEeIrM59+e2UVS20Kwoq968r+BfodthYQ2kvJl5/GVTEb2x7hkKP5Zmcdr3EFBm
         RksT8JLt4Vw79sKGsCIza8+ae9niC1Zb58gc1sad9rNiNIDuMqF8XWE8vG/HkAKZJjS7
         k5+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzZtyMNxlYqcp4C4hDik/1WnbJcXZE868XXbaxb0a9i8WCeeN+nZQta5RNle51wnntZ16I=@vger.kernel.org
X-Gm-Message-State: AFuF++kW/Gw77X75EMs6NgQvGMg9XDXEphSVG7Wl+Ob418ZToMGyYgwZ
	RWKuV+1LZWp0smaHG7/v1Rvuo9OJKkp2ePsDvnR6IiSBJ7VwStKtwXe4lQIbg0paFkPtPFtG4Co
	FeIv/iAYN4BWiQ8MGvmkIMX+ip6SQuDqGfm2e1Ln8
X-Gm-Gg: AYBFou38VwtqYQYJa+CzmHGOVk3GM0UmzQ/2ST0YpG+mzrCeO3c0d5tuyl9I/e7pQ+P
	HFOMVGVRMafQox+O5aYle2me/j20XDh9dcjXyhxU2eLDxCQWHP5fwB3C/QoyGEF1KZ8N9hZhyVn
	ftOW/T9AoISoqzDTJ79FpH2oh7U/snhSFWiWhYM/qsih9ybxZTZ1yFTeRHEneNqoe8XVp+9V4Ph
	6NNUgOG6BeiYw+1G41MVs17/8b+jFqYAdSg69HSDVPk8trH1uzdzoYwL+ATpWyGJvHcfNi/LEsn
	UxLkvDgTV8VZSLeiYdgL5Z4qKKboT0BF3/M780RPXrTCEA5uRk59Q5v1Q/wh+zvclIXsDRUCs/y
	TH/PJBQ/wntz0XE07sCwmNqlwApyQaQQ=
X-Received: by 2002:a05:6214:4287:b0:90e:7bee:9a6c with SMTP id
 6a1803df08f44-9103ef88de7mr407562466d6.19.1788894194840; Tue, 08 Sep 2026
 12:03:14 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 12:03:13 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 12:03:13 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260722-tdx-selftests-v14-5-15ad654a50db@google.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com> <20260722-tdx-selftests-v14-5-15ad654a50db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Sep 2026 12:03:13 -0700
X-Gm-Features: AcwNN1V9Kl5cU_xU1Qz969rvQ0JujFNCbBSW6jqcW2Xx-zikXZHSBnXLwAN1H4g
Message-ID: <CAEvNRgFiMWb_n4nL8E2HBfkQ247GEhGQ3us_cfoQG4-JBiD2aA@mail.gmail.com>
Subject: Re: [PATCH v14 05/22] KVM: selftests: Expose segment definitions to
 assembly files
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
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

> From: Sagi Shahar <sagis@google.com>
>
> Move kernel segment definitions to a separate file which can be included
> from assembly files.
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Sagi Shahar <sagis@google.com>
> Signed-off-by: Lisa Wang <wyihan@google.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  tools/testing/selftests/kvm/include/x86/processor_asm.h | 12 ++++++++++++
>  tools/testing/selftests/kvm/lib/x86/processor.c         |  5 +----
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86/processor_asm.h b/tools/testing/selftests/kvm/include/x86/processor_asm.h
> new file mode 100644
> index 000000000000..713b6bc0aeb7
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86/processor_asm.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Used for storing defines used by both c and assembly code.
> + */
> +#ifndef SELFTEST_KVM_PROCESSOR_ASM_H
> +#define SELFTEST_KVM_PROCESSOR_ASM_H
> +
> +#define KERNEL_CS	0x8
> +#define KERNEL_DS	0x10
> +#define KERNEL_TSS	0x18
> +
> +#endif  /* SELFTEST_KVM_PROCESSOR_ASM_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 7d23344854cc..97acc5aaf7b7 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -8,6 +8,7 @@
>  #include "kvm_util.h"
>  #include "pmu.h"
>  #include "processor.h"
> +#include "processor_asm.h"
>  #include "smm.h"
>  #include "svm_util.h"
>  #include "sev.h"
> @@ -18,10 +19,6 @@
>  #define NUM_INTERRUPTS 256
>  #endif
>
> -#define KERNEL_CS	0x8
> -#define KERNEL_DS	0x10
> -#define KERNEL_TSS	0x18
> -
>  gva_t exception_handlers;
>  bool host_cpu_is_amd;
>  bool host_cpu_is_intel;
>
> --
> 2.55.0.229.g6434b31f56-goog

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
