Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795149914;
	b=qiL2rDq6XApVLZyyi4FAgvI/P+NrDwwyBu3vwzziq8CQ3I825rA8SCrqvrA9jGXnymG9
	 PlebcImml4W5h9RAKrYrqJNttWW2dH9hf0ATWlvOLHxGK6rcd1ce1yn7x2wrVoETHcPZm
	 xIZGhIU2beZqyT8v8YmEn8nGCktZVAHHsb0cAdMh2E5fXekhokqchv8l8YuYZa8tDNB0q
	 1Pmh9FGeJpBlmDvn8y5Dz/KZqd9B3t5hh09h21j4os/wL4u4sI4GML+RzS4+V5tc/vvE7
	 gNEVKzymDdto5N7MrHcMEqBX5TIaFI2j7tadlsrNPD98mNBWDEHM2BtR69Eg3yesKbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795149914;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=v+B77fwkqptEoKN+IMmcaaDy0E8T0emPfjLkiSTP7Sk=;
	b=gvGs6nIEQYsWgvXtg5jiHMX2/8GlEMt620hVmUYAP6YbBQVdATRN3gY90KbD/XT7oPOo
	 bVugVU/WuuhORciK3HorY16dYR675F6UXABMB9klLNM798CYfYIod2vXz7PGzuH5Ictl+
	 61z2/uv0v2D9/8Q/fizxZ+soPF4QhfVB0VJcm2ssFHVXwbyFa1564gUmXWKkwF5m82HYA
	 YRaHXmmqZ5kouTBopoQkxAza+wf2fSEbLp/VMfGsd5KEkWvDARhMbnIoK6h8+hXVkvZy4
	 hlBgH+pkdQbKnEdmg5Och7CTgXKXZHyqWSa9/lpp3eD5EMMjt5kgWqy4XFSI9bwVV2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="BmjHRpV/";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E779606A325;
	Fri, 20 Nov 2026 04:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E779606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BmjHRpV/
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3ufha1982242;
	Fri, 20 Nov 2026 04:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v+B77f
	wkqptEoKN+IMmcaaDy0E8T0emPfjLkiSTP7Sk=; b=BmjHRpV/gzb8K+Mon94K9d
	ShVXQaDyM2DM/QlXY0OTJOkkE6LZel9KO+j3nKq2QTXOzpmg2nQRxO3qa1raiLjk
	QWmGGPcKFQiFWHH/OzI6ad/kcxdSKpZuPW9Ika8JVNLh7FiwPz0WTzukpZH8Be1J
	8zldysRrsQgQZW3oUpJEUGEER5znCSqRSkUNuYCvuDeJxyhtfy7X5HH5S6C5agiB
	MF2xd+7nLMpRceznU7iXP7BL0kr5uS8BarslVhdCpFad1taXQO9DiQNnDOhKF4pF
	GjKwN3/xOoM6vb3P3qZApV+lFdcfKlXh9olZwLBDY4ES3+cB8/NDz+Qkfx1+usOw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105te7dn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 04:45:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3Z0Lk1655855;
	Fri, 20 Nov 2026 04:45:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1m3j05wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 04:45:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AK4j2iG45744426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 04:45:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DDE420043;
	Fri, 20 Nov 2026 04:45:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CBE52004B;
	Fri, 20 Nov 2026 04:45:01 +0000 (GMT)
Received: from [9.124.218.70] (unknown [9.124.218.70])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 04:45:01 +0000 (GMT)
Message-ID: <538f4b23-d533-46c9-b580-c8c0f1ef14e0@linux.ibm.com>
Date: Fri, 20 Nov 2026 10:15:00 +0530
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
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
 <20261023073642.59657-3-nnmlinux@linux.ibm.com>
 <sashiko-outbox-182440@kernel.org>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <sashiko-outbox-182440@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6affd051 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=9vqKEf5Rp1BOlTc_L4UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5b6ws5LknsHjSdTpxe9vCohWMaBL8Tql
X-Proofpoint-GUID: 5b6ws5LknsHjSdTpxe9vCohWMaBL8Tql
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAxNyBTYWx0ZWRfX1Syqa4lCQtXe
 1VfBxutd1na1qZe+cC1Pfyhzhs7Xp9VNMQCX2aSww9xBeaiN6654ldLp0/DSnJG4TxNYVRSyNa3
 3iyvWRitfBxAwgcwp1GO4LUjaRqlRmFPhMUD8injfkjGiI8GaSf5UtidBnRXqTQL7bQRe8lWIX3
 Dy+s396Orp88YpyIOeqGnj0V7jiFAx9M6BM9IKbVxeOKVuJdJE+8MoLytjBhVxKt2j+ZVlhHq3b
 5/GHgbzz9YVj0fSlk99Qm/OhyU4oN6W0FW2c/yFupvN6qSEET3N+WnFZEjGtNa6tMZSYwpsIutP
 lCv3FnQYAzfY0+90SzZVJDX6vP4Q6xMr5E8uIIyqZA9RlKojLcTm+AvjHQ00jMGSINzj1BFDFak
 VySVK8Fb/DwAxV0AcOD8nQqlpAw6NrzfvKvfUjyGEwd3zq2uKbMeUvDnTllSCE4IlhHM81vaRs1
 WdOkB0kaoAtX1aGYa9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAxNyBTYWx0ZWRfX6YvbTN2iG4Y8
 DCMFh++iDT58ARaFkL98OVicV/luyvG65wE6CkvZsa4aYgoCBLDxu+gL5/JqxTO/DnM5ogOtppZ
 2rH7/sISnW2Mfms+IS+q/XnceLGk5hw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200017



On 23/10/26 1:19 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] powerpc/pseries/eeh: static RTAS helpers defined without callers
> --
> 
> commit 8b171281b038661dc89a614c1b95db68271706f4
> Author: Narayana Murty N <nnmlinux@linux.ibm.com>
> 
> powerpc/pseries/eeh: Add RTAS error injection helpers
> 
> This patch adds static RTAS error injection helper functions,
> pseries_eeh_type_to_rtas() and validate_addr_mask_in_pe(), to prepare
> the pSeries EEH backend for RTAS-based error injection.
> 
> Closes: https://lore.kernel.org/oe-kbuild-all/202512101130.EYUo0oZx-lkp@intel.com/
> 
>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> index b12ef382fec70..28b1fd19e8bcd 100644
>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> 
> [ ... ]
> 
>> @@ -786,6 +789,137 @@ static int pseries_notify_resume(struct eeh_dev *edev)
>>   }
>>   #endif
>>   
>> +/*
>> + * RTAS firmware error-type encodings (PAPR).  These are pseries-private;
>> + * user-space sees only the generic EEH_ERR_TYPE_* values from eeh.h.
>> + * Only IOA bus-error types are supported; other PAPR encodings are not
>> + * reachable through the generic EEH_ERR_TYPE_* UAPI.
>> + */
>> +#define RTAS_ERR_TYPE_IOA_BUS_ERROR		0x07
>> +#define RTAS_ERR_TYPE_IOA_BUS_ERROR_64		0x0f
>> +
>> +/* Size of the ibm,errinjct work buffer as defined by PAPR */
>> +#define RTAS_ERRINJCT_BUF_SIZE			SZ_1K
>> +
>> +/**
>> + * pseries_eeh_type_to_rtas - Map generic EEH error type to RTAS encoding
>> + * @type: generic EEH error type (EEH_ERR_TYPE_32, EEH_ERR_TYPE_64)
>> + *
>> + * Translates the generic VFIO/EEH error type passed from userspace into
>> + * the RTAS-specific ibm,errinjct error type encoding defined by PAPR.
>> + *
>> + * Return: RTAS error type on success, -EINVAL for unknown types.
>> + */
>> +static int pseries_eeh_type_to_rtas(int type)
>> +{
>> +	switch (type) {
>> +	case EEH_ERR_TYPE_32:
>> +		return RTAS_ERR_TYPE_IOA_BUS_ERROR;
>> +	case EEH_ERR_TYPE_64:
>> +		return RTAS_ERR_TYPE_IOA_BUS_ERROR_64;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +/**
>> + * validate_addr_mask_in_pe - Validate addr against PCI bus BAR addresses in PE
>> + * @pe:   EEH PE containing one or more PCI devices
>> + * @addr: PCI bus address to validate
>> + * @mask: address mask (passed to firmware unchanged)
>> + *
>> + * RTAS IOA bus-error injection uses PCI bus addresses.  Linux PCI resources
>> + * are CPU/resource addresses and may differ on pseries due to PHB window
>> + * translation.  Convert each BAR resource to PCI bus address space before
>> + * validating @addr.
>> + *
>> + * Zero addr and mask are accepted without BAR lookup (no-address injection).
>> + *
>> + * Return: 0 if valid, -EINVAL on invalid input.
>> + */
>> +static int validate_addr_mask_in_pe(struct eeh_pe *pe, unsigned long addr,
>> +				    unsigned long mask)
> 
> [Severity: Low]
> Does defining pseries_eeh_type_to_rtas() and validate_addr_mask_in_pe() in
> arch/powerpc/platforms/pseries/eeh_pseries.c without callers or
> __maybe_unused cause a -Werror=unused-function build failure at this commit?
> 
> The commit message notes that validate_errinjct_args() and
> prepare_errinjct_buffer() were deferred to the next patch ("powerpc/pseries/eeh:
> Implement RTAS-based EEH error injection") and that pseries_eeh_err_inject()
> retains its existing MMIO body here so each intermediate commit builds
> cleanly with CONFIG_WERROR:
> 
> arch/powerpc/platforms/pseries/eeh_pseries.c:pseries_eeh_err_inject() {
> 	struct	eeh_dev	*pdev;
> 
> 	/* Check on PCI error type */
> 	if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
> 		return -EINVAL;
>      ...
> }
> 
> However, those deferred functions and the updated pseries_eeh_err_inject() are
> the only callers of pseries_eeh_type_to_rtas() and validate_addr_mask_in_pe().
> When building with CONFIG_PPC_PSERIES=y and CONFIG_PPC_WERROR=y (in
> arch/powerpc/Kbuild) or CONFIG_WERROR=y (in scripts/Makefile.warn), won't
> this commit fail to compile with -Werror=unused-function until the follow-up
> patch adds their callers?

Yes, good catch.

Although validate_errinjct_args() and prepare_errinjct_buffer()
were moved to the implementation patch, the remaining two static
helpers are still introduced before their first callers.

I'll merge patches 2/5 and 3/5 in the next revision so that all
helpers are introduced alongside their callers, avoiding the
unused-function warnings in the intermediate commit.

Regards,
Narayana Murty.
> 

