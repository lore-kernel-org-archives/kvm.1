Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B53451CE
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788850032; cv=none; b=JeAcU+oRl3AzeLR3iXER7J3NOO2FWbNq9OufNHHSHtC5Kp05nafVDVo0fE1KtHmwPafzwilBvmgEOU4xJfpkv1s8z1j5h5iNEPLqBuwQ11JDic4E9DFgecGAfcc+cjWS2NQS7uAQsg3oke3YC+CXI5Lv6rbpZ5m1/K0HzxNEUns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788850032; c=relaxed/simple;
	bh=kb87Y4IYHxF6Ta03dXCpn3WcpvTYwXjOw6j9lCNrrNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9UlvRJJOzWdr/GeYN+mveRBFy73WNiiHKW51OPPbsBdirz4kGhWbocDAw5VphFalycWekljfPG7p9/dotN2QnWBVHQideWjAs7ZhhxCNEzaKSdPBl/ZYD0vafVuFdpw8s7ZVujh4rWW6SZcuWg0jIKtqf8UMbsI4XzhatEhRZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNFVfgaf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ROci3oW4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNFVfgaf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROci3oW4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788850028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UiMHGFhPbk7D6S9onjfcZBvfsx9CaE6NOzQzrP6JAw=;
	b=WNFVfgaflrTGAeUeTzEf8EXmwgi2EXqs9JKFxxxzvR9+9VEx1L6GBqLGq23S0hf2hABpkU
	oJ61l6dje3SEyURYSY2HxyD8pPvOYU/7SvsehLuzhi83iei8fs7LPqTYtzE/gelAQTPdy3
	TaONJjnwAvNNeBijbVew9N4xBJbdg9s=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-zc44TgVOOsWHy3AEcIliAQ-1; Tue, 08 Sep 2026 02:47:07 -0400
X-MC-Unique: zc44TgVOOsWHy3AEcIliAQ-1
X-Mimecast-MFC-AGG-ID: zc44TgVOOsWHy3AEcIliAQ_1788850026
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e13b57b2cso4990003b3a.1
        for <kvm@vger.kernel.org>; Mon, 07 Sep 2026 23:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788850026; x=1789454826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3UiMHGFhPbk7D6S9onjfcZBvfsx9CaE6NOzQzrP6JAw=;
        b=ROci3oW4J48Vksrk/UngTONeT+0O7511RZK2TzmfkThh02KMD4nlz0oqBuyo6D7jfY
         gAW9vYA/LIOD9OAIOc9TyLZCsRABS+RU8N2GWgvU+aoVKo+ddQSJDe2w9t+MXfLzXwnf
         EnAkrLF9rpRO6kbwMvuml2fiZNosnNYmzwyvqftgQk/EF9K0yWPWeq9/5o9Kz8JohzZT
         Hq3ztzNiaj2jS+anD2cKhQdbcWVuX5ml/XiP0ZDEze1mMhL/sWQvKT2IsMV1ddO1CieL
         qjwU7nehdmDYxAV3GY4zqP3fMYLxS07syB7S6SZXV/v6x5sbavkKO9qWWj+Xfz+9S3uK
         asFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788850026; x=1789454826;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3UiMHGFhPbk7D6S9onjfcZBvfsx9CaE6NOzQzrP6JAw=;
        b=V7RjmLSFfSMduE1xot7n4ALmc0TQ2EqxORccWnGiEHCwKofftVGMZ7h/T1xdlxu91E
         rJh8+fPtfI+g0Id+QlH2ijD3AXnNAjJ/HSWFLsesDqJru6jxOwx5jd+SJmMfKtrCE76F
         QkZF7A9pEaExX2FhVAfH2u4zJt9p0gXU5txx0L9zWsozbY7aBni8iToYksvFKwB4ncy2
         DgzkJi2sGdy+BMyG/F/eOjNYy7bC3yQln0DCMuPEzSFqet6LsmBg9mcU01e5+YDvEKwB
         aAYA0M81L7XTmoNSMwA6ai4LMKx+UXYpeGFJAh9FvbgrsFIuhjfSTys3oTLUbPFRerGa
         0tEg==
X-Forwarded-Encrypted: i=1; AKwUvBxRYMzQ6z7JSn4diSVWUztnHzmorv6OL3QB0cOL0/rQtX8ZQKmgroPdkQ4WDyCH6/YA+KE=@vger.kernel.org
X-Gm-Message-State: AFuF++mfvU19cpk7ggCWUFq7cS7MfHa42NePEmy4bRhTvB0qvBOTlG4L
	PVkq1wyy2l5xAQZJhYbUxZLrbeW5klMRirg+qUg7UaGc2TeRaJijr88K+ydj3i7ZqUCujdgrMLy
	Rt9NLIctAwRRQgR/nbel9bPs3k2z1C5JhLLH1+Ye10bDB4xzDMl2aoQ==
X-Gm-Gg: AYBFou0aEt0foKuRD3l6tIyRh6UTlbF0Jx2uL9w9bqfI87SzJwbw/w+MGxI1aDynZrh
	G4b+EvxWi3CHfm8J1nEONareZY044ap0Wm3cnxgTN0dh+JgYu+hHnStZyNqsMTogRxei5GCoVye
	pzL1q7dElRBjcI937ohY8HWjjwnmijVsZWoD7nNVVyeVkR/nIBUi3WEhcgLhj85g2z/Ti4VYYA/
	IcTy+g/aEiBRDLUsWSn3T76c9uylTVxTp54jfmSO5R6jkt/pfQ4+2Ftrflg8d/00nG+L4dI5yq1
	7AI/vd0zR9NyXLrGeUDJ2AOZKdjLCBnPNTfJPj1QcMK2QBpi7uS3qnbjZGJteHrDrqykUs1Fn7Q
	kyBOWv7Q/GNVRk6GuQ1IOXjB8k9El5peVr8Ja22K1qw==
X-Received: by 2002:a05:6a00:2e19:b0:853:50f2:9c03 with SMTP id d2e1a72fcca58-86169182795mr34477507b3a.11.1788850026311;
        Mon, 07 Sep 2026 23:47:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e19:b0:853:50f2:9c03 with SMTP id d2e1a72fcca58-86169182795mr34477437b3a.11.1788850025792;
        Mon, 07 Sep 2026 23:47:05 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86154048df2sm5208107b3a.61.2026.09.07.23.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 23:47:05 -0700 (PDT)
Message-ID: <25894d08-0fec-4dcd-9d5e-e8270ff9d26c@redhat.com>
Date: Tue, 8 Sep 2026 16:46:52 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 2/7] firmware: arm_rmm: Check for RMI support at init
To: Suzuki K Poulose <suzuki.poulose@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: maz@kernel.org, will@kernel.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 steven.price@arm.com, aneesh.kumar@kernel.org, oupton@kernel.org,
 joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
 linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
 sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
 WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com
References: <20260907095942.1140734-1-suzuki.poulose@arm.com>
 <20260907095942.1140734-3-suzuki.poulose@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260907095942.1140734-3-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Suzuki,

On 9/7/26 7:59 PM, Suzuki K Poulose wrote:
> From: Steven Price <steven.price@arm.com>
> 
> Query the RMI version number and check if it is a compatible version.
> The first two feature registers are read and exposed for future code to
> use.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> v17:
>   * Rename ARM_RMM to ARM_RMM_RMI to make it easier to add Guest facing RSI
>     support, which is also in progress
> v16:
>   * Update Kconfig text to include PCIe TDISP.
>   * Export rmi_feat_reg() here rather than in a later commit.
> v15:
>   * The code is moved again, this time into the 'firmware' directory.
> v14:
>   * This moves the basic RMI setup into the 'kernel' directory. This is
>     because RMI will be used for some features outside of KVM so should
>     be available even if KVM isn't compiled in.
> ---
>   arch/arm64/Kconfig                |   1 +
>   arch/arm64/kernel/cpufeature.c    |   1 +
>   drivers/firmware/Kconfig          |   1 +
>   drivers/firmware/Makefile         |   1 +
>   drivers/firmware/arm_rmm/Kconfig  |  26 ++++++++
>   drivers/firmware/arm_rmm/Makefile |   2 +
>   drivers/firmware/arm_rmm/rmi.c    | 101 ++++++++++++++++++++++++++++++
>   include/linux/arm-rmi-cmds.h      |  34 ++++++++++
>   8 files changed, 167 insertions(+)
>   create mode 100644 drivers/firmware/arm_rmm/Kconfig
>   create mode 100644 drivers/firmware/arm_rmm/Makefile
>   create mode 100644 drivers/firmware/arm_rmm/rmi.c
>   create mode 100644 include/linux/arm-rmi-cmds.h
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b5a51b0ef9440..ff9565d3ffa59 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -38,6 +38,7 @@ config ARM64
>   	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>   	select ARCH_HAS_MEM_ENCRYPT
>   	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> +	select ARCH_SUPPORTS_RMM
>   	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>   	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>   	select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 17b83a2518a8f..db26f6b0eaf5e 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -293,6 +293,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar3[] = {
>   static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_CSV3_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_CSV2_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_RME_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_DIT_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_AMU_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_MPAM_SHIFT, 4, 0),
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index b7cc11e4fbfa6..62660bf520a8d 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -310,5 +310,6 @@ source "drivers/firmware/samsung/Kconfig"
>   source "drivers/firmware/smccc/Kconfig"
>   source "drivers/firmware/tegra/Kconfig"
>   source "drivers/firmware/xilinx/Kconfig"
> +source "drivers/firmware/arm_rmm/Kconfig"
>   
>   endmenu
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index be46f1e1dc77f..196a650ccf025 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -39,3 +39,4 @@ obj-y				+= samsung/
>   obj-y				+= smccc/
>   obj-y				+= tegra/
>   obj-y				+= xilinx/
> +obj-y				+= arm_rmm/
> diff --git a/drivers/firmware/arm_rmm/Kconfig b/drivers/firmware/arm_rmm/Kconfig
> new file mode 100644
> index 0000000000000..82724ee23186d
> --- /dev/null
> +++ b/drivers/firmware/arm_rmm/Kconfig
> @@ -0,0 +1,26 @@
> +
> +config ARCH_SUPPORTS_RMM
> +	bool
> +
> +config ARM_RMM_RMI
> +	bool "Realm Management Interface (RMI) Support"
> +	depends on ARCH_SUPPORTS_RMM
> +	default y
> +	help
> +	  Support the Realm Management Monitor (RMM) on Arm systems that
> +	  implement the Realm Management Extension (RME), as defined by the
> +	  Arm Confidential Compute Architecture.
> +
> +	  The RMM runs at EL2 in the Realm world and provides the Realm
> +	  Management Interface (RMI) used by a Normal World host to create,
> +	  manage and run protected virtual machines called Realms. The RMM can
> +	  also act as a TSM, as defined by the PCIe TDISP and can manage the
> +	  PCI IDE setup for securing the PCIe links.
> +
> +	  This option builds the host-side RMI support used by KVM to detect a
> +	  compatible RMM, configure it, manage delegated memory and enable
> +	  Realm guests.
> +
> +	  Selecting this option does not by itself make Realm guests available:
> +	  the system must also provide RME-capable hardware and firmware with a
> +	  compatible RMM implementation.
> diff --git a/drivers/firmware/arm_rmm/Makefile b/drivers/firmware/arm_rmm/Makefile
> new file mode 100644
> index 0000000000000..65171988fdcae
> --- /dev/null
> +++ b/drivers/firmware/arm_rmm/Makefile
> @@ -0,0 +1,2 @@
> +
> +obj-$(CONFIG_ARM_RMM_RMI)	= rmi.o
> diff --git a/drivers/firmware/arm_rmm/rmi.c b/drivers/firmware/arm_rmm/rmi.c
> new file mode 100644
> index 0000000000000..008a783407b4e
> --- /dev/null
> +++ b/drivers/firmware/arm_rmm/rmi.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023-2026 ARM Ltd.
> + */
> +
> +#include <linux/cpufeature.h>
> +#include <linux/memblock.h>
> +#include <linux/arm-rmi-cmds.h>
> +#include <linux/slab.h>
> +
> +#include <asm/memory.h>
> +#include <asm/pgtable-hwdef.h>
> +
> +/* Currently only the first 2 registers are used by Linux */
> +#define RMI_FEAT_REG_COUNT	2
> +static __ro_after_init unsigned long rmi_feat_reg_cache[RMI_FEAT_REG_COUNT];
> +

I would drop RMI_FEAT_REG_COUNT and use ARRAY_SIZE(rmi_feat_reg_cache) in the code.
Besides, __ro_after_init is usually put at the last the declaration.

static unsigned long rmi_feat_reg_cache[RMI_FEAT_REG_COUNT] __ro_after_init;

> +unsigned long rmi_feat_reg(unsigned long id)
> +{
> +	if (WARN_ON(id >= RMI_FEAT_REG_COUNT))
> +		return 0;
> +
> +	return rmi_feat_reg_cache[id];
> +}
> +EXPORT_SYMBOL_GPL(rmi_feat_reg);
> +

I would suggest to rename 'id' to 'index' since it represents the feature
register index instead of feature register ID.

unsigned long rmi_feat_reg(unsigned long index)
{
    :
}
EXPORT_SYMBOL_GPL(rmi_feat_reg);

> +static int rmi_check_version(void)
> +{
> +	struct arm_smccc_res res;
> +	unsigned short version_major, version_minor;
> +	unsigned long host_version = RMI_ABI_VERSION(RMI_ABI_MAJOR_VERSION,
> +						     RMI_ABI_MINOR_VERSION);
> +	unsigned long aa64pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
> +
> +	/* If RME isn't supported, then RMI can't be */
> +	if (cpuid_feature_extract_unsigned_field(aa64pfr0, ID_AA64PFR0_EL1_RME_SHIFT) == 0)
> +		return -ENXIO;
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_VERSION, host_version, &res);
> +
> +	if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
> +		return -ENXIO;
> +
> +	version_major = RMI_ABI_VERSION_GET_MAJOR(res.a1);
> +	version_minor = RMI_ABI_VERSION_GET_MINOR(res.a1);
> +
> +	if (res.a0 != RMI_SUCCESS) {
> +		unsigned short high_version_major, high_version_minor;
> +
> +		high_version_major = RMI_ABI_VERSION_GET_MAJOR(res.a2);
> +		high_version_minor = RMI_ABI_VERSION_GET_MINOR(res.a2);
> +
> +		pr_err("Unsupported RMI ABI (v%d.%d - v%d.%d) we want v%d.%d\n",
> +		       version_major, version_minor,
> +		       high_version_major, high_version_minor,
> +		       RMI_ABI_MAJOR_VERSION,
> +		       RMI_ABI_MINOR_VERSION);
> +		return -ENXIO;
> +	}
> +
> +	pr_info("RMI ABI version %d.%d\n", version_major, version_minor);
> +
> +	return 0;
> +}
> +
> +static int rmi_read_features(void)
> +{
> +	/*
> +	 * Since we've negotiated a compatible version these feature registers
> +	 * should always be available
> +	 */
> +	for (int i = 0; i < RMI_FEAT_REG_COUNT; i++) {
> +		if (WARN_ON(rmi_features(i, &rmi_feat_reg_cache[i])))
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init arm64_init_rmi(void)
> +{
> +	int ret;
> +
> +	/* Continue without realm support if we can't agree on a version */
> +	ret = rmi_check_version();
> +	if (ret)
> +		return ret;
> +
> +	ret = rmi_read_features();
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/*
> + * Note arm64_init_rmi() must be called before kvm_init_rmi() otherwise KVM
> + * will not support realm guests. subsys_initcall() is called before
> + * module_init() (used for KVM) so this is OK.
> + */
> +subsys_initcall(arm64_init_rmi);
> diff --git a/include/linux/arm-rmi-cmds.h b/include/linux/arm-rmi-cmds.h
> new file mode 100644
> index 0000000000000..2fb1f7f86d71e
> --- /dev/null
> +++ b/include/linux/arm-rmi-cmds.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2026 ARM Ltd.
> + */
> +
> +#ifndef __LINUX_ARM_RMI_CMDS_H_
> +#define __LINUX_ARM_RMI_CMDS_H_
> +
> +#include <linux/arm-smccc-rmi.h>
> +#include <linux/bug.h>
> +#include <linux/types.h>
> +
> +unsigned long rmi_feat_reg(unsigned long id);
> +
> +/**
> + * rmi_features() - Read feature register
> + * @index: Feature register index
> + * @out: Feature register value is written to this pointer
> + *
> + * Return: RMI return code
> + */
> +static inline int rmi_features(unsigned long index, unsigned long *out)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_FEATURES, index, &res);
> +
> +	if (res.a0 == RMI_SUCCESS && out)
> +		*out = res.a1;
> +
> +	return res.a0;
> +}
> +

We needn't expose rmi_features() through include/linux/arm-rmi-cmds.h since it's
used for once in rmi.c::rmi_read_features(). I would suggest to drop it by combining
the code with that function.

> +#endif

#endif /* __LINUX_ARM_RMI_CMDS_H_ */

Thanks,
Gavin

