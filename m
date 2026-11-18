Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020214;
	b=vO8xlB7bSRH22i+gTfdd4yTlhcD3K/DgPvAl4hRM/Vn32jsG9Zw2do+bu5/X9ykt/qvv
	 JuMOxqhvY8G1ZY+DSeQWKOrq/P8JNCH4hRvY9/r1I9W9TtMlk+5d+KZiutDfZiM1y0c4y
	 g+NClhYU1SWxE1kUhKyv12sInswJSUWXqV/az8W1NH+b5TG4yUxduTv8wpfc70e1YM65H
	 VAphu2FgBF9UFTrbLvFuqtZHTVDL6qNqWdEc04pw2OxKZtjYm8A2Xlf8aICCMSXFU6+IB
	 WiaLUlMUjxmewFlesS31FDP+WkCkVBEbZsWgPp/rrfBj4ZIBajr/AD5mbOcH+vIDMKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020214;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=N/56M51bVJ30ADA/+2Hwiuo6wSZJG0GWyJmQ525LEjc=;
	b=YmPkDhvWV/HS8dKEAIiFWXJzYih7EMdfFg25iq8RQjOhO8EgNaF77CMA5vnlR0rDsWWU
	 uSLKsV90+osE8ji5Fmeh3eDbN8ljc0UDSPx69hjUlMFwCqSTn7M9vWzEIInEnc6qR+2oc
	 0MdXQj1P9xLuVSfaDzHcBkLvWObwGz5pspPt7Isa3h8T2HEdc/V3vnVvFhEVkYYI35o5Y
	 uzPpV4MUFdxGyeUENE38jKh9kNiED1gpYSWVKYjDrr7LBulZtKhR83xUrblSy9RPYqC2v
	 zH95y9xv6QoJN1lfuOiy5Cylf/g4WSvm3tuVILm5+qhXyaBZXS9YT2yuVQFLxBj+pbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WQyiqkrU;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BEF606A325;
	Wed, 18 Nov 2026 16:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76BEF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WQyiqkrU
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQT6w1373699;
	Wed, 18 Nov 2026 16:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N/56M5
	1bVJ30ADA/+2Hwiuo6wSZJG0GWyJmQ525LEjc=; b=WQyiqkrU9cTdiV+FGElqFg
	7GKx1EKIN1cWU2CmcWnZG3/eVW3UhoW+7+U9ciOQ71gA1fd0afSnZw47yZOA2zW0
	uFpZoQGCsrYR7iZJaqrvbnumjEbUcTcO89e19unn8FyRDFs1DwDTkzS5VbvqVGLi
	rTor3/DOFkNCJPy5ApOGLFa2FH0W1Bvq0JZy29hLy9BFe70s+sZdQE2CWiT+Pdch
	BzCiYpUu/nSBUasl/sW6eblwwhx/zmoQ0ui3gDo45w4bhZma0cg6dtO21sz4cwva
	teY4THcI/WM3UYaPCdL6ZwBlFxUw/wg5fFygC6T6ZEgVSUAIBLwpdJ+wbepgulAA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105nbfn2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 16:43:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDYuhE2135407;
	Wed, 18 Nov 2026 16:43:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1bb58x7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 16:43:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIGhCYA38732082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 16:43:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C66A20043;
	Wed, 18 Nov 2026 16:43:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D46020040;
	Wed, 18 Nov 2026 16:43:06 +0000 (GMT)
Received: from [9.39.20.8] (unknown [9.39.20.8])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 16:43:06 +0000 (GMT)
Message-ID: <864398a6-8a74-43df-9594-452a9edd99e9@linux.ibm.com>
Date: Wed, 18 Nov 2026 22:13:04 +0530
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] powerpc/pseries/eeh: Add RTAS error injection
 helpers
To: Narayana Murty N <nnmlinux@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
 <20261023073642.59657-3-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20261023073642.59657-3-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2NSBTYWx0ZWRfX5M/7kaUckwVa
 9bVNRbVncGYdF0O6aGDd2tdVH6iIs8iHk0DwXJahtm1qPjYjyWFLl791v7HXEHLQ0GuDd6QwmtR
 bkeeUuanNAz00ULcRCBljJHz8ZYoC9j9iaX/+n+4JvZiFs0LjYpa7a2Fo15/FJ5Mmgtz4+tH0iB
 Q9sjNxkUzzbvcf2uLrR87u9HSVugVas/CH2pzbplWMuT4OsWMl0Pp1Ec85ofCrt6PipJa1c5+sq
 MuPJbu8SZ8ZE7F8blGBfQWYz2XnwVNCmU0M+WvBx/SNUnh+TNVyfYKwjpTZqbr9cMkXvh02NBNA
 ZZoRpODT1g+Z3YBMCGAQ9kxvY1IVB/Y0XEInRbnpxqYE57XAJ/7CBBG8GS12JFK6yNNOwnXO5YL
 BI9Z//1SKA8hpOkLVlKRWklmpbAyephYmWIAGfTHtCd7rj23noS646D7c65IjvUi35Kvg8s42se
 bn/HJNvELSUFAwc81Ew==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afdd5a5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=qEGVIg7j7DtWFASSOSIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QKB4hkBqOdqGavT5Ikms5QDm3CTflvW8
X-Proofpoint-ORIG-GUID: BxDCxD-vQ0Z_fLU5-RuhbF3wSsp6Z_JX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2NSBTYWx0ZWRfX8fFtaM/B/xHi
 guROYTAUILGgrdjrlXLXYPgBHqUV8enrbdEOKIgaAgNBy+xM2Ns59vOs3vRI01FJXF0bOPOvMLj
 sipdCZf5zZBeBvCCk5DjQjULOODTI98=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180065

Hello Narayana,

The commit message contains several implementation details that make it 
difficult to
understand the actual purpose of this patch. Could you simplify and 
restructure it to
focus on the functionality being introduced and why it is needed?

On 23/10/26 13:06, Narayana Murty N wrote:
> Prepare the pSeries EEH backend for RTAS error injection by adding
> helpers that:
>
>    * map generic EEH error types to RTAS/PAPR error types;
>    * validate IOA addresses against the target PE.
>
> Define pr_fmt unconditionally at the top of eeh_pseries.c so all
> pr_*() calls carry the "EEH: " prefix.

I don't think there's a need to mention pr_fmt here, as it's not a key
objective of the patch. This could simply be a note at the end.

> Define RTAS firmware error-type encodings as file-local constants.
> Only the two IOA bus-error types are supported; other PAPR encodings
> are not reachable through the generic EEH_ERR_TYPE_* UAPI:
>
>    RTAS_ERR_TYPE_IOA_BUS_ERROR     0x07
>    RTAS_ERR_TYPE_IOA_BUS_ERROR_64  0x0f
>
> Add RTAS_ERRINJCT_BUF_SIZE for the ibm,errinjct work buffer size.

I'm not sure RTAS_ERRINJCT_BUF_SIZE needs to be included in this patch,
as it seems unrelated and isn't used by any of the APIs introduced here.
Would it make more sense to move this to the patch where it is actually 
used?

> Add pseries_eeh_type_to_rtas() to translate the two generic EEH error
> types (EEH_ERR_TYPE_32, EEH_ERR_TYPE_64) into the corresponding RTAS
> ibm,errinjct encodings.
>
> Add validate_addr_mask_in_pe() to verify that a caller-provided address
> falls within a BAR of some device in the PE.  RTAS IOA bus-error
> injection requires a PCI/IOA bus address; validate_addr_mask_in_pe()
> accepts only PCI bus addresses.  VFIO userspace resource addresses are
> normalized to PCI bus addresses in vfio_iommu_spapr_tce.c before
> reaching this backend; no resource-address fallback is added here.
>
> Use pcibios_resource_to_bus() to convert each BAR resource to PCI bus
> address space before validating the address.  Only standard BARs
> (BAR0..BAR5) are searched; ROM and bridge resources are not IOA
> bus-error targets.  Hold pci_rescan_remove_lock while traversing PE
> devices and their BAR resources so PCI device removal cannot race the
> address validation.
>
> Skip unassigned or disabled BARs explicitly: on pseries,
> pcibios_fixup_resources() zero-bases unassigned BARs (start=0,
> end=size-1) and sets IORESOURCE_UNSET, so resource_size() is non-zero
> for them and pcibios_resource_to_bus() treats them as bus address zero.
> Use pci_resource_len() (which returns 0 when end==0) instead of
> resource_size(), and reject BARs with IORESOURCE_UNSET or
> IORESOURCE_DISABLED set.
>
> Returns -EINVAL (Linux errno) rather than a raw RTAS status.

This is another example where I'm having difficulty understanding
how the above statement relates to the new APIs introduced by this patch.

> validate_errinjct_args() and prepare_errinjct_buffer() are introduced
> in the next patch alongside their callers so each intermediate commit
> builds cleanly with CONFIG_WERROR.
>
> pseries_eeh_err_inject() retains the existing MMIO injection body
> unchanged in this patch.


Okay, but could you clarify how these are related to the APIs introduced 
in this patch?

> It is replaced by the full RTAS session
> implementation in the next patch.  This keeps the patch bisectable:
> each commit builds and functions correctly independently.

Could you help me understand the need to mention git bisect-ability here?

I'm also not sure why the above two paragraphs are needed. Why do we need
to document the nuances of other APIs in this patch when they are introduce
or modified in subsequent patches?

>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512101130.EYUo0oZx-lkp@intel.com/


Aren't these tags intended for cases where the issue is fixed in a 
separate patch/commit,
rather than in a revised version of the same patch? Do we really these tags?


> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   arch/powerpc/platforms/pseries/eeh_pseries.c | 134 +++++++++++++++++++
>   1 file changed, 134 insertions(+)
>
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index b12ef382fec7..28b1fd19e8bc 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -12,6 +12,8 @@
>    * Copyright Linas Vepstas 2005, 2006
>    */
>   
> +#define pr_fmt(fmt) "EEH: " fmt
> +
>   #include <linux/atomic.h>
>   #include <linux/delay.h>
>   #include <linux/export.h>
> @@ -23,6 +25,7 @@
>   #include <linux/rbtree.h>
>   #include <linux/sched.h>
>   #include <linux/seq_file.h>
> +#include <linux/sizes.h>
>   #include <linux/spinlock.h>
>   #include <linux/crash_dump.h>
>   
> @@ -786,6 +789,137 @@ static int pseries_notify_resume(struct eeh_dev *edev)
>   }
>   #endif
>   
> +/*
> + * RTAS firmware error-type encodings (PAPR).  These are pseries-private;
> + * user-space sees only the generic EEH_ERR_TYPE_* values from eeh.h.
> + * Only IOA bus-error types are supported; other PAPR encodings are not
> + * reachable through the generic EEH_ERR_TYPE_* UAPI.
> + */
> +#define RTAS_ERR_TYPE_IOA_BUS_ERROR		0x07
> +#define RTAS_ERR_TYPE_IOA_BUS_ERROR_64		0x0f
> +
> +/* Size of the ibm,errinjct work buffer as defined by PAPR */
> +#define RTAS_ERRINJCT_BUF_SIZE			SZ_1K

Wouldn't it be better to move this to the first patch where it is used?

> +
> +/**
> + * pseries_eeh_type_to_rtas - Map generic EEH error type to RTAS encoding
> + * @type: generic EEH error type (EEH_ERR_TYPE_32, EEH_ERR_TYPE_64)
> + *
> + * Translates the generic VFIO/EEH error type passed from userspace into
> + * the RTAS-specific ibm,errinjct error type encoding defined by PAPR.
> + *
> + * Return: RTAS error type on success, -EINVAL for unknown types.
> + */
> +static int pseries_eeh_type_to_rtas(int type)
> +{
> +	switch (type) {
> +	case EEH_ERR_TYPE_32:
> +		return RTAS_ERR_TYPE_IOA_BUS_ERROR;
> +	case EEH_ERR_TYPE_64:
> +		return RTAS_ERR_TYPE_IOA_BUS_ERROR_64;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + * validate_addr_mask_in_pe - Validate addr against PCI bus BAR addresses in PE
> + * @pe:   EEH PE containing one or more PCI devices
> + * @addr: PCI bus address to validate
> + * @mask: address mask (passed to firmware unchanged)

Is the mask really necessary?


> + *
> + * RTAS IOA bus-error injection uses PCI bus addresses.  Linux PCI resources
> + * are CPU/resource addresses and may differ on pseries due to PHB window
> + * translation.  Convert each BAR resource to PCI bus address space before
> + * validating @addr.

The same comment is also present inside the function. Could we drop one to
avoid duplication? I think keeping it inside the function would be better.


> + *
> + * Zero addr and mask are accepted without BAR lookup (no-address injection).
> + *
> + * Return: 0 if valid, -EINVAL on invalid input.

I think, -EINVAL otherwise. would be more accurate.

> + */
> +static int validate_addr_mask_in_pe(struct eeh_pe *pe, unsigned long addr,
> +				    unsigned long mask)
> +{
> +	struct pci_bus_region region;
> +	struct eeh_dev *edev, *tmp;
> +	struct pci_dev *pdev;
> +	struct resource *res;
> +	resource_size_t bus_start;
> +	resource_size_t bus_len;
> +	bool found = false;
> +	int bar;
> +
> +	if (!addr && !mask)
> +		return 0;
> +
> +	if (!pe)
> +		return -EINVAL;
> +
> +	/*
> +	 * RTAS IOA bus-error injection uses PCI bus addresses. Linux PCI
> +	 * resources are CPU/resource addresses and may differ on pseries due
> +	 * to PHB window translation. Convert each BAR resource to PCI bus
> +	 * address space before validating @addr.
> +	 *
> +	 * Hold pci_rescan_remove_lock across the traversal to protect pdev
> +	 * lifetime: pci_stop_and_remove_bus_device() requires this lock.

Wouldn't it be more meaningful to explain why this lock is needed here
rather than listing other APIs that use it?

> +	 */
> +	pci_lock_rescan_remove();
> +	eeh_pe_for_each_dev(pe, edev, tmp) {
> +		pdev = eeh_dev_to_pci_dev(edev);
> +		if (!pdev)
> +			continue;
> +
> +		/*
> +		 * Validate against standard BARs (BAR0..BAR5) only.
> +		 * ROM and bridge resources are not IOA bus-error targets.
> +		 */
> +		for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> +			res = &pdev->resource[bar];
> +
> +			/*
> +			 * Skip unassigned or disabled BARs.  On pseries,
> +			 * pcibios_fixup_resources() zero-bases unassigned BARs
> +			 * (start=0, end=size-1) and sets IORESOURCE_UNSET.
> +			 * resource_size() is non-zero for such BARs, and
> +			 * pcibios_resource_to_bus() treats them as bus address
> +			 * zero, so they must be excluded explicitly.
> +			 * Use pci_resource_len() which returns 0 when end==0.
> +			 */
> +			if (!pci_resource_len(pdev, bar))
> +				continue;
> +
> +			if (!(res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
> +				continue;
> +
> +			if (res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
> +				continue;

Nit: Would it be better to check the above conditions before calling 
pci_resource_len()?

> +
> +			pcibios_resource_to_bus(pdev->bus, &region, res);
> +
> +			bus_start = region.start;
> +			bus_len = pci_resource_len(pdev, bar);

How the bus_len returned by pci_resource_len(...) is different from?
bus_len = region.end - region.start + 1;

> +
> +			if ((resource_size_t)addr >= bus_start &&
> +			    ((resource_size_t)addr - bus_start) < bus_len) {
> +				pr_debug("addr=0x%lx mask=0x%lx validated in PCI bus BAR[%d] of %s: bus range 0x%llx-0x%llx\n",
> +					 addr, mask, bar, pci_name(pdev),
> +					 (unsigned long long)region.start,
> +					 (unsigned long long)region.end);
> +				found = true;
> +				goto done;
> +			}
> +		}
> +	}
> +done:
> +	pci_unlock_rescan_remove();
> +
> +	if (!found)
> +		pr_err("addr=0x%lx mask=0x%lx not within any PCI bus BAR of any device in PE\n",
> +		       addr, mask);
> +	return found ? 0 : -EINVAL;

This check is repeated twice here. I think we can improve this. How about
restructuring the function as follows:


static bool addr_in_pdev_bars(pdev, addr)
{
     for (bar = 0; bar < 6; bar++) {
         len = pci_resource_len(pdev, bar);
         if (!len || !is_mem_or_io(res) || is_unset_or_disabled(res))
             continue;

         pcibios_resource_to_bus(pdev->bus, &region, res);
         if (addr >= region.start && addr - region.start < len)
             return true;
     }
     return false;
}

static int validate_addr_mask_in_pe(pe, addr, mask)
{
     if (!addr && !mask)
         return 0;
     if (!pe)
         return -EINVAL;

     pci_lock_rescan_remove();
     for_each_dev(pe, pdev) {
         if (pdev && addr_in_pdev_bars(pdev, addr)) {
             pci_unlock_rescan_remove();
             return 0;
         }
     }
     pci_unlock_rescan_remove();

     pr_err("addr not in any BAR of PE\n");
     return -EINVAL;
}


Splitting out the BAR check gets rid of the goto and the found flag.
The lock and unlock now sit around one simple loop.

- Sourabh Jain

> +}
> +
>   /**
>    * pseries_eeh_err_inject - Inject specified error to the indicated PE
>    * @pe: the indicated PE

