Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD6E3CFF72
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776861877; cv=none; b=F0hCx2VLa1zuTCCXCJLKVpZigrdMPNdeMF5BlLQ9sPvFvtIZ1NjzpwpQqyAa3CNS8kLxihSc00I5++2AGU9ByyJFA4PQpOHbzydpCLOwf09xNXedTyeCUXrOgceoZ6ELZ32MzrtLw2e8ENWHap68RXld7QsCUZHUeu1XVk1jjkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776861877; c=relaxed/simple;
	bh=mf9a3y5plEHz+Od0utgXOjx+K9GtbZBq+Py1FIzyxKw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=aqiedAOMWYKQLvMaUC3aMokAa2vxiHxgUOEZs9kUP9IPjncDakxJxy3gINGeVeEZ3nW34BLlikOcXzdfdl3hZc3VSwNE19ZUSHcmJdQZIeV7rFyrxXWrCVeX+VjWAmZXzMx3727b0HXUuoyhnuBo7+JVfXlB/V2YRVW1PX1FqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iolh/Egh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iolh/Egh"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MC1L6x878106;
	Wed, 22 Apr 2026 12:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=89jJKFMUgIHKQ11XHc2SdyY7ZEDCaGScBoL48lZuKoA=; b=iolh/EghdM9g
	CJnI3yRo5Z5qT7nJiGy6H0RuGtPDgt8blI48LEzuMzUd0zvsXfjPxTUcO1Cm+aWg
	ANusvzbmeDokzYuVsB6WB6o5+Bzirwy/FP4wbwxcLN9RHktC0yh0IB3fD0pdaX1r
	4ZuaXLJpDmwaihlV+7PDFALQhBa3jGgDwXGuQIAQizN2Kmni7tLsXJCfb4LVH7f/
	n0hOlSlG00HCb5Vvr9j5rBEYLez3EaEOVZhi1ORrT20vF529tt8HZDhv75Q7e10n
	KbQXnprQy8B9cFzBCk+3vMK8ilfJFZp/BUH/ztiIzpptZiu6QhCfbKtr/eSUu1Fo
	W4XRHoStLw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu23g9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 12:44:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MCZIWr009689;
	Wed, 22 Apr 2026 12:44:23 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxt842-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 12:44:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MCiMrK38601296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 12:44:22 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 619055803F;
	Wed, 22 Apr 2026 12:44:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7921D58055;
	Wed, 22 Apr 2026 12:44:21 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Apr 2026 12:44:21 +0000 (GMT)
Message-ID: <baa2ce88b3554a6434415c8e78281bb221953196.camel@linux.ibm.com>
Subject: Re: [PATCH 0/8] target/ppc: Forbid to use legacy ldst_phys() API
From: Miles Glenn <milesg@linux.ibm.com>
Reply-To: milesg@linux.ibm.com
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        BALATON Zoltan
 <balaton@eik.bme.hu>,
        Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org,
        qemu-ppc@nongnu.org, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,
        Chinmay Rath <rathc@linux.ibm.com>
Date: Wed, 22 Apr 2026 07:44:21 -0500
In-Reply-To: <20260319111936.68041-1-philmd@linaro.org>
References: <20260319111936.68041-1-philmd@linaro.org>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDExOCBTYWx0ZWRfX/JS91OLd4Eza
 Q3NGHm8RYqxLUayU5o/3uANQoJ17VNzPgjDdidyI0E+5y2xXENQBXDI04L/8oIBEjdA+99/mDaE
 OFFAKXMsGcacEQWcDoirEUqkRLUt+TpdapvgSoU9IIGvdvALqo7C0vEqzblkX/3Hrx9GUKEezaV
 v+hFC58Tu07BgrQRL2pSrymnOX38b5/jEMiDRZqg76rxG1rlVceln8E1jwU3tUVdb8O7NZUQOVQ
 rOAdzhh55ZZXDHVnYeATZf9f4eBuqUS8LdhfrXAlE6IsrKIV+4piVqajABKfUzT6lRcmZS68GG1
 dbg6BaDVHI5o+8ofcZvXaWY8x1EUjcHh/0iLRNZMHpFi9aXHa8jEpldG9Mps9jrOCSPaKPhNvHc
 vczNla3CCAIFuY0IHBWCsFdJ5eqq18sWastXMHvw3uQifdAwuF2LZq2cx89ehl0ddmjpKIg0dsE
 /v80GkNWS6FGBAA9lXw==
X-Proofpoint-ORIG-GUID: THHtA1YjjoXQPcqkEhYoK5Rng_csG3NH
X-Proofpoint-GUID: WfIISZnP3XFT1Yze3vtg-p8qnafDcxvQ
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69e8c2a9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=FbiGK3ctOxS2QG3a_X0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220118

Acked-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Thu, 2026-03-19 at 12:19 +0100, Philippe Mathieu-Daudé wrote:
> Replace legacy ld/st_phys() by address_space_ld/st()
> then lock the target again further legacy API uses.
> 
> Philippe Mathieu-Daudé (8):
>   hw/ppc/spapr: Un-inline rtas_load/store() helpers
>   target/ppc: Factor common ppc_load_epr() helper out
>   target/ppc/mmu: Remove unused hash32_store_hpte() helpers
>   target/ppc/mmu: Restrict hash32_load_hpte() helpers scope
>   target/ppc/mmu: Replace legacy ld/st_phys() -> address_space_ld/st()
>   hw/ppc/pegasos: Introduce rtas_ldl() / rtas_stl() helpers
>   hw/ppc/pegasos: Replace legacy ld/st_phys() -> address_space_ld/st()
>   configs/targets: Restrict the legacy ldst_phys() API on PPC
> 
>  configs/targets/ppc-softmmu.mak |  1 +
>  include/hw/ppc/spapr.h          | 18 ++-------
>  target/ppc/cpu.h                |  2 +
>  target/ppc/mmu-hash32.h         | 32 ----------------
>  hw/ppc/pegasos.c                | 67 +++++++++++++++++++--------------
>  hw/ppc/spapr_rtas.c             | 15 ++++++++
>  target/ppc/cpu.c                |  9 +++++
>  target/ppc/excp_helper.c        |  3 +-
>  target/ppc/kvm.c                |  2 +-
>  target/ppc/mmu-hash32.c         | 24 +++++++++++-
>  10 files changed, 93 insertions(+), 80 deletions(-)
> 

