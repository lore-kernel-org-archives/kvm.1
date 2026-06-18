Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3D32E736F
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 20:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815575; cv=none; b=qStUuEMfg1C7mCSn5bXbDYM+dSifXqT7QKHLHoSKl/bxDP/FQGnk6uc8YC7+1c1TkUMXCzjIqe8jMLWOKICRHCFeqNv1Rdf1xjxxlh9zfGV/lRDC3jFMwrOCMc08RrMFFQ/8rdvxk/jGPAyt5bLjQx7EOtWsqV+nDFet+IzPM9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815575; c=relaxed/simple;
	bh=yzn1jVjbkxYPZl2H7cFy1bKzVmxSMTpY6f+ZZyijLK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJColSDcECFZqodpt0xNjQQvNrsD9NT/RKG8pWYX/oBXkzPjvwxWTWMzNWhvtG8RWXlC3iHrxrPLFnXfvqapEiV6B8X5MQDirMOGGo8ZAqJFURFfiIKpUZvXhmD/jxYyKX/oD5hlInX/WRIvv1OKAL/Qe7iZkbGRF11HwBqCBH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VFDIJ00d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UUP5Y4Tr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VFDIJ00d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UUP5Y4Tr"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IKeMQs2900287
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 20:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DPqnVCoHQBGATnAtyDMuVQ6Ys2cDKQ4OwKSwyl7QuWw=; b=VFDIJ00dzSZXgKTq
	srQo7hRU2hFKEUjdVonUARfuKziuHh40POcnMjYYDMnj7995ql2kWStmofb3CrbR
	/Y/xh2f28aA9G+bPE9Yjjj5DG59mqDCULOpf0GjW/sjsGRMrZxUhhvWw0zwb7gVI
	gve5nNg+W1xoB6sebE6eGdihNloELVv37fvJMoO3f7fML4+WY+3iKzgrVfFqvQv3
	Cga+MbrMO2y8PyVNqVjcCcad9Zaa210F77Aeiunx9PA8iSZIScdXpJJj/V5Ujdya
	FMk09sc3XQY3kZBdd0LXF3RAfAiBqqZAIy2R3GWhPoebwOHfgQopEDYa87nnJJ8x
	vXVYKg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evm2298js-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 20:46:13 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-963b744b61cso1223854241.1
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 13:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781815572; x=1782420372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DPqnVCoHQBGATnAtyDMuVQ6Ys2cDKQ4OwKSwyl7QuWw=;
        b=UUP5Y4TrCUSjSjF/ZaZacdhj6DSNSWM8POfoZbfGJ8DWvSXvA3ZrsWTVJhK4wKsRcB
         a6blyWaR75NFR8ni3Wyx5G4i06NvbKPMTCHsDjQVk2aYjB2yEZSwGNFaRFQGrddoAdKx
         i32lsj4dPZiQuz8YMUEsPFIFvcU/zbopcCFfsmeRrsSzmLCFvijUSMxAPy3zUVcmY1uG
         /33CFJrDI7hzefF+NQyP87sjhxEUEgVaOCY9Rw3cuh9VKmyjYeuG5grTGP5gNhZDSl77
         AcxuDMRrSqj8L682SPubexPzbeyBGg58ad3FYBaDOJtGouhKtIZacQjJ5FZ3VVENovFZ
         0w4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781815572; x=1782420372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPqnVCoHQBGATnAtyDMuVQ6Ys2cDKQ4OwKSwyl7QuWw=;
        b=cT1R2v0jwKiHXv/aBmaa16e2M3b2w566njU4/Jm2uEQ+PLFGuG4ISEx6vsl26gxI0e
         QS1jYU3jk2YqQLIm1QnYNpd5FYRfTuUjZXdFfqe1XXGRE6+tfzm91ACAiEMIYesA5QDb
         MqqUlNeJK5XwpaueSqk4WvJq4fSIN0/KvCvcyu3+G7Oal8dJhwn1UliAsWa7E0VHz0b3
         SZXOGRnzVZCrLJ5EmpaKcYSn0oAeiP1Z6VnPIzvowkB+wwXqlHfgpGkPBq2LLyFbYvWm
         kPNb6E4ip8qmvkD1U+CK3qNP3GkERBSsK3zlZ/Qe7/0oBwPEx4obc4DKYTrdF+FzMfiv
         mWRg==
X-Forwarded-Encrypted: i=1; AFNElJ8W5u7uJjF4omwOqZSnSLlmpAE3ow6Q3Eln20xA6B1XJrQOxvXnwoSkR6h7bI6l6R8596Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWWSxmwwtyxzdjRoPRVfTJHUpBB43nujAjokmjFc9RmmEDB9Kw
	yIPw8+tdqr7uVGFCKqDp+ZoCXi161t2JCow29MI/aWtBntDuJqgAKNMZedMgvzVoZsyLaxub10P
	mvQH73vILQ7uyiBCAywYMOW8YOqwk9g3gYXU89RXDYeVheAzvLxXfI/U=
X-Gm-Gg: AfdE7cnaNJdyrKg9gr13KtQmT3JeZ6ltZ4sMxGc7caw1ytsVzyDhoK0cxXEx/mmLOcG
	CU3dsVca4zaAaIN+H85wO466JW554xFgG5aHCxKKFJM06rr1bjrmRAZYSBm3asCoDM0qJMRLZcs
	YWQmsrwWNpYLFIYO3VUp9HWKJNXWPFC/LPeYURpbPlv6ZVj5AYA6e94Qu3a+tA0nk/fTHGkQIvz
	rSDON5jh1X1Jrtoig5jwarawlf6JrXt4qd4gsGNdGy+fswWet1TzIeXrOHpaXpgRkK3amPCxBFA
	VdVkgFelLBy+kOTfAAKi9jySdQ5QYqiIK3tCe+cIm9qQgCxtHebA5N7B4/S5G6dIiLyZ6Z0IxuM
	fZGECkEGY4gptTq4JIv/WDtkDTtyUHfmW8phlTQQIRyY2r/BEAs3XmfwNw7f0Pg==
X-Received: by 2002:a05:6102:2910:b0:6da:1341:1147 with SMTP id ada2fe7eead31-72a1d20657cmr660277137.1.1781815572474;
        Thu, 18 Jun 2026 13:46:12 -0700 (PDT)
X-Received: by 2002:a05:6102:2910:b0:6da:1341:1147 with SMTP id ada2fe7eead31-72a1d20657cmr660246137.1.1781815572033;
        Thu, 18 Jun 2026 13:46:12 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1f886sm14231175e9.4.2026.06.18.13.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 13:46:11 -0700 (PDT)
Message-ID: <b7c8e3d6-aa2c-468a-9a78-0aee1c8b1e85@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 22:46:09 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] system/memory: move RamDiscardManager to
 separate compilation unit
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
        "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
        Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
        Ben Chaney <bchaney@akamai.com>, Marcelo Tosatti <mtosatti@redhat.com>,
        kvm@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
        Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
        Markus Armbruster <armbru@redhat.com>
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
 <20260604-rdm5-v5-2-5768e6a0943d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260604-rdm5-v5-2-5768e6a0943d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YN+vDxGx c=1 sm=1 tr=0 ts=6a345915 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=LzuOTfgjHi7GmFSmfN0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: D7vKTChlcy9CUyCbLS2jK61FU4BKIp0S
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE5MCBTYWx0ZWRfX7e2Prjzux1Dv
 wpuE/7k95/V18I0KAxv9RZ3IkfU+F5GB3lIOE945ILUwJgfWfZUES+3YfAUDjsKM23rq3Y7uY05
 P3Tvl4WfylMN6Z3tlKfFLMvJ+RrnHqE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE5MCBTYWx0ZWRfX2xi4Cq+X//I9
 OGTUjTC/K9/msSer0sR6+sg3hUS2ObqEzA2wbCgn9hd3YUTFDrzXbt0qravYr6m6ht9YVRym1Lj
 rjjwtq8+O5hCQEfgXsi3qgQvpP5tDUrfUGop2Vn9gs0ybs1lUAyfumtCYf6oFeBJhr91Ji7wK10
 YNfTzbDq5vhrmriTpWDrAbSre0uEXPoARZTGF6sRWYuI1z3cZXW7jid3zWpgfsuenE/z12gw+JV
 kya8upzGE/vO3AwtDUeEwTxxTepKWETfSL7fnmufFEpYMukJjhc4GHB/LSWbG20ySdcoDW9EImI
 +6SyHUVym/TzsPXOkX86u63O4JwLvi7sXhZuUYomsb6SzHtQ8l7mlN1yw3eJduxeO+FB3WX6BQ7
 jUqDGOi8MUhaCbZA2SurkCCVh+hrntAOnSn9z2MuXyroKe0uwMqbmWWKc+Jn55l5t8tBRNx0h2c
 HM88xuvvxDkrKM4q3Pw==
X-Proofpoint-ORIG-GUID: D7vKTChlcy9CUyCbLS2jK61FU4BKIp0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180190

On 4/6/26 15:43, Marc-AndrÃ© Lureau wrote:
> Extract RamDiscardManager and RamDiscardSource from system/memory.c into
> dedicated a unit.
> 
> This reduces coupling and allows code that only needs the
> RamDiscardManager interface to avoid pulling in all of memory.h
> dependencies.
> 
> rust-sys bindings are no longer generated for RamDiscardSourceClass at
> this point, thus we drop the unneeded InterfaceClass use.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Acked-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   MAINTAINERS                          |   2 +
>   include/system/memory.h              | 280 +--------------------------------
>   include/system/ram-discard-manager.h | 297 +++++++++++++++++++++++++++++++++++
>   system/memory.c                      | 221 --------------------------
>   system/ram-discard-manager.c         | 240 ++++++++++++++++++++++++++++
>   rust/bindings/system-sys/lib.rs      |   2 +-
>   system/meson.build                   |   1 +
>   7 files changed, 542 insertions(+), 501 deletions(-)


> diff --git a/include/system/ram-discard-manager.h b/include/system/ram-discard-manager.h
> new file mode 100644
> index 00000000000..da55658169f
> --- /dev/null
> +++ b/include/system/ram-discard-manager.h
> @@ -0,0 +1,297 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * RAM Discard Manager
> + *
> + * Copyright Red Hat, Inc. 2026
> + */
> +
> +#ifndef RAM_DISCARD_MANAGER_H
> +#define RAM_DISCARD_MANAGER_H
> +
> +#include "qemu/typedefs.h"

Not needed, already provided in sources by "qemu/osdep.h".

> +#include "qom/object.h"
> +#include "qemu/queue.h"
> +
> +#define TYPE_RAM_DISCARD_MANAGER "ram-discard-manager"
> +typedef struct RamDiscardManagerClass RamDiscardManagerClass;
> +typedef struct RamDiscardManager RamDiscardManager;
> +DECLARE_OBJ_CHECKERS(RamDiscardManager, RamDiscardManagerClass,
> +                     RAM_DISCARD_MANAGER, TYPE_RAM_DISCARD_MANAGER);
> +
> +#define TYPE_RAM_DISCARD_SOURCE "ram-discard-source"
> +typedef struct RamDiscardSourceClass RamDiscardSourceClass;
> +typedef struct RamDiscardSource RamDiscardSource;
> +DECLARE_OBJ_CHECKERS(RamDiscardSource, RamDiscardSourceClass,
> +                     RAM_DISCARD_SOURCE, TYPE_RAM_DISCARD_SOURCE);
> +
> +typedef struct RamDiscardListener RamDiscardListener;
> +typedef int (*NotifyRamPopulate)(RamDiscardListener *rdl,
> +                                 MemoryRegionSection *section);
> +typedef void (*NotifyRamDiscard)(RamDiscardListener *rdl,
> +                                 MemoryRegionSection *section);
> +
> +struct RamDiscardListener {
> +    /*
> +     * @notify_populate:
> +     *
> +     * Notification that previously discarded memory is about to get populated.
> +     * Listeners are able to object. If any listener objects, already
> +     * successfully notified listeners are notified about a discard again.
> +     *
> +     * @rdl: the #RamDiscardListener getting notified
> +     * @section: the #MemoryRegionSection to get populated. The section
> +     *           is aligned within the memory region to the minimum granularity
> +     *           unless it would exceed the registered section.
> +     *
> +     * Returns 0 on success. If the notification is rejected by the listener,
> +     * an error is returned.
> +     */
> +    NotifyRamPopulate notify_populate;
> +
> +    /*
> +     * @notify_discard:
> +     *
> +     * Notification that previously populated memory was discarded successfully
> +     * and listeners should drop all references to such memory and prevent
> +     * new population (e.g., unmap).
> +     *
> +     * @rdl: the #RamDiscardListener getting notified
> +     * @section: the #MemoryRegionSection to get discarded. The section
> +     *           is aligned within the memory region to the minimum granularity
> +     *           unless it would exceed the registered section.
> +     */
> +    NotifyRamDiscard notify_discard;
> +
> +    MemoryRegionSection *section;
> +    QLIST_ENTRY(RamDiscardListener) next;
> +};
> +
> +static inline void ram_discard_listener_init(RamDiscardListener *rdl,
> +                                             NotifyRamPopulate populate_fn,
> +                                             NotifyRamDiscard discard_fn)
> +{
> +    rdl->notify_populate = populate_fn;
> +    rdl->notify_discard = discard_fn;

Pre-existing, this initializer doesn't justify inlining in header.

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +}

