Received: from mta0.migadu.com (out-32.mta0.migadu.com [91.218.175.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8337B53ECEC
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 11:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952969; cv=none; b=qHFlUzTGVazyk9CowuwVYqzYwBg4kO8r72rxTbNMnEFNkPIl7oe8bWLlgiAJOWWWtDFFdaTd83RCrIExSy1vQRQTHaWJ2y7vfv6InV8aaNIJbmq2u8kbuUG6Xkiy+6/oMq1Lq+d4JHuk8MDewA8Fhe/PA2Dcc+uX6xHP66JgSAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952969; c=relaxed/simple;
	bh=/JaBLDLeB9M4GD012hVnmAtxky5w5FAwuCSELvPTyb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqnwNhjrewUOFLpx2cnlMh/02XNKJ8PbQxSWaC9mTxxBx+Dwtlifu6xmT25+06z9+ybK5Eps8ds5Y/mm4ZjQfun+fZl2ZWtXk7iX+3vP1+K+IdJkMqgXgQ6TJ5DW/DHj5W0MR6LfapN2JDu0Kloy0DZKpTAU/CIeVtOlojaPn5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NdE8HbLK; arc=none smtp.client-ip=91.218.175.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NdE8HbLK"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/JaBLDLeB9M4GD012hVnmAtxky5w5FAwuCSELvPTyb8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788952964; v=1; x=1789557764;
 b=NdE8HbLKvFQ2nQtyw/gVrheVK0ZrXxAaRV14OzaMudUilkJ0qgVZnPY9UUC84anh9/5hVOEZ
 WkjmqU4jR8iyped6C8ffsV/2aX14ZVn3I57oqCR6AKjm/Hb/ZsKD9MPMoX5Mkc846LwYmQHlj72
 G8yLO7eb4ICwVyf+2g4DX/Uw=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a56f3bb7db8cf10a;
	Wed, 09 Sep 2026 11:22:44 +0000
X-Mizu-Trace-ID: a56f3bb7db8cf10a
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0b384b7so5853e87.0
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 04:22:40 -0700 (PDT)
X-Gm-Message-State: AFuF++ldTgI0WzfniD1exeRlk7SiPDuGINkaNaIkzYh3ra7h0Om92uv2
	+an82xvbFkSFFRCv7fQdLHGmamuFVsP8NuPgjfvhwzf6W25isO6paTl/y+1o2tR7NyeM55Fpbpm
	skI0V5zkm441SDOPtMCTk4F6gyeOvlOxOBwld8tnY
X-Received: by 2002:a05:6512:2509:b0:5b6:4ad:d6ba with SMTP id
 2adb3069b0e04-5b76588da4bmr83683e87.15.1788952959425; Wed, 09 Sep 2026
 04:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908162223.1683432-1-suzuki.poulose@arm.com> <20260908162223.1683432-3-suzuki.poulose@arm.com>
In-Reply-To: <20260908162223.1683432-3-suzuki.poulose@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 9 Sep 2026 12:22:03 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzGeHCWV=ooEv-P79NNqTDi-A+7y5BFvZRR0z8RwavoeA@mail.gmail.com>
X-Gm-Features: AcwNN1WOpbR1SFkQp2TefrPio8hkFdw4pDq7cjhhozRa2ggqEwHORcn6flp9uPk
Message-ID: <CA+EHjTzGeHCWV=ooEv-P79NNqTDi-A+7y5BFvZRR0z8RwavoeA@mail.gmail.com>
Subject: Re: [PATCH v17 02/20] KVM: arm64: Avoid including linux/kvm_host.h in kvm_pgtable.h
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Sept 2026 at 17:22, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> From: Steven Price <steven.price@arm.com>
>
> To avoid future include cycles, drop the linux/kvm_host.h include in
> kvm_pgtable.h and include the lightweight headers required for the types
> and inline helpers used there. Additionally provide a forward
> declaration for struct kvm_s2_mmu as it's only used as a pointer in this
> file.
>
> Both pgtable.c and kvm_pkvm.h relied on the indirect inclusion of
> kvm_host.h, so make that explicit.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> New patch in v13

Is this meant to be here (the "New in patch 13")?

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad


> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 6 +++++-
>  arch/arm64/include/asm/kvm_pkvm.h    | 2 +-
>  arch/arm64/kvm/hyp/pgtable.c         | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index 41a8687938eb6..c2e4b29e605fc 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -8,9 +8,13 @@
>  #define __ARM64_KVM_PGTABLE_H__
>
>  #include <linux/bits.h>
> -#include <linux/kvm_host.h>
> +#include <linux/kvm_types.h>
> +#include <linux/rbtree_types.h>
> +#include <linux/rcupdate.h>
>  #include <linux/types.h>
>
> +struct kvm_s2_mmu;
> +
>  #define KVM_PGTABLE_FIRST_LEVEL                -1
>  #define KVM_PGTABLE_LAST_LEVEL         3
>
> diff --git a/arch/arm64/include/asm/kvm_pkvm.h b/arch/arm64/include/asm/kvm_pkvm.h
> index beea00e693a0a..54a618d887fa4 100644
> --- a/arch/arm64/include/asm/kvm_pkvm.h
> +++ b/arch/arm64/include/asm/kvm_pkvm.h
> @@ -7,9 +7,9 @@
>  #define __ARM64_KVM_PKVM_H__
>
>  #include <linux/arm_ffa.h>
> +#include <linux/kvm_host.h>
>  #include <linux/memblock.h>
>  #include <linux/scatterlist.h>
> -#include <asm/kvm_host.h>
>  #include <asm/kvm_pgtable.h>
>
>  /* Maximum number of VMs that can co-exist under pKVM. */
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index b74dd5ce1efd3..f48253b9d88b5 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -8,6 +8,7 @@
>   */
>
>  #include <linux/bitfield.h>
> +#include <linux/kvm_host.h>
>  #include <asm/kvm_pgtable.h>
>  #include <asm/stage2_pgtable.h>
>
> --
> 2.43.0
>
