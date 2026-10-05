Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB869490BE5
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206800; cv=none; b=nPHLgim3eRhVd5aEhaH3cTiuW9Th0SWrkrbgWL82KrDnSyc8DnXfXz55L6wQPDJimZnUm+JyUmYzr6w3vZHIFkW5LJ4sAjtlJ/+tL7zpt2SnOKa4qACx/8HtThQm/j/fuyIbZrkDGS1pp2DAzUgE+NcRBmy2MbNnxW7X9aJJI8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206800; c=relaxed/simple;
	bh=ybpmuL2vYfyQDcAM/C2s5NUPCTLl2rgC9pKl9yGd0Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfgYP3fx0gceWmNy9DoRnzBMZJoEEUYWUBaxiVbv+QlJBPW/o2emPj/jxhMoXyQJLU1FOo0YK1cEjEXICXHQajjOusPRTEGoX+AMdUIJudOu1Vvtuc2emOxZGutZ/ntCYwwG9EtUEHD55XbdY4nONI/PL2teNVmgY1Q5LiB2Op0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ThrBDxLZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OfN+7Nuz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ThrBDxLZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OfN+7Nuz"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CFgn72849822
	for <kvm@vger.kernel.org>; Mon, 5 Oct 2026 13:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JDSp49czoELykwuV0c41NKt0
	WWebvsAlOsdvzWqmJjk=; b=ThrBDxLZbRBxo/UjtYhkuhkuLg0Uh4kM0MKwjJLf
	xm/A9+6Gtj4iAmBrvNZ7C0nl/fpvVgXJqgwb8Tih9OAI9Unr3xok853TLmZvk1fC
	RqC+UFkVNzFSL94sjL+hWvJ4/k0wvj0HnBa8wlqgfbGwwssvNzvT8q/swStZ5RGH
	yU5ldsDeaiGZ0xBgVxrB9KqrbRUZkaXea2FKoDQOZCEMcV6Tem68A+3hX1uZBV0n
	qwfdZPP76FWkVuzPoZri5/v2KatI3rplDHKULtnfzi9lwDiDWFBxi33+HcxezSju
	A3ld06RpJWAiKHwYzVeq/6c0LYPp2l4rVSuQmCeKgqeZSw==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h49u40pgd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 13:25:31 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67124ce8015so2082158d50.0
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791206730; x=1791811530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JDSp49czoELykwuV0c41NKt0WWebvsAlOsdvzWqmJjk=;
        b=OfN+7Nuzjh6Rp9XwOzLvXF/P6i1runsmTwnwZ6iClB11iFK2sBCas3dRfJcdaEY9ae
         3Td8sBqhf3Sk0iATDPkztdFGH7CJUVmA4z6oF8nJkE6T+vm9rBQuqF9bMUNsgaruJ59X
         S/z6zrAv8Pd4EZIs7t3VqO8H5zPqHBUuorwv+JEbdoarWe2KrYEV889dwc6kPHM6YAjb
         aWgnq6Nw2GHWgwj+C/SEwlOnLXS4JMWMgrStu39KzmqFIc97EMTGWnmM6W8fvOfU2gNR
         fWyVhN5cpTQ7LVqlcD2n50/kdu9KYhOCKHGYMrT4aK6pqORbIWlaqrKwCCpDciznRoGR
         02lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791206730; x=1791811530;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JDSp49czoELykwuV0c41NKt0WWebvsAlOsdvzWqmJjk=;
        b=hsY6NdNv/7Bxd+w/+uz2BimFTxfLzLRdr1sY11teGHFC8ftrGv9NJNa03FirU725Pe
         TQGR3SgzHN1ev4w4+eizih5sXuEW5qQIrlTJMxtiLu9M8TxZ5sH/G9pc5Ynr2Yi2CsVh
         iW+XcHsq2Q7/KskUldb+JTetk6iU8xdim7MXB8+yta631Q6lJ8qrrzc3C0uykxiyaQiq
         QqC4VQWz+NRdSQmbgI2ZNZDXTZm+v03MUNw9MwuM/U1zDsMgnvFsN4GuLDXKh52nkGtI
         kaujflZZuTQYBIPM84jGm7Gs1s63XcwUvjyWIp2whepAoGubg6di5PjMBN/h/AEmlWZ+
         LapQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgBT5lBz8/8gThwHPGunjt6VPnatquEexVe3FZ6dUfUefoAt1yQ/Lo0fNl9nmDdgszXww=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcGtl9/NeRmuaZMN7nbtpgzxiXJiKc5fHZ91ua7L47MBeYNdMX
	ONH6UXnODOVqzS4cHG7N1MsK8XocIGlzJ8TebxGQGBIVscIKMwmwmz+Fi2Vk+8gJIAGtSrWAqyH
	NzwXAAQOE3ZSfgZa2Ds6PbM58tsw1A1FoE4njrEWuMYx03FO9d9AKUYU=
X-Gm-Gg: AYBFou2CLH8OzlDR6pwJjDoNeDpeqU+h1a84H5dgX8+LAzZa+x1/Oo8D83QFkAGEZII
	oHkCcHx9FhejlGAesa3TgkU3adHxSKFS4SNHFfVuEai5l9n4UBawFhcWVBeAbjf0YOPsqZMRqth
	Lrdww4dLCL3uDYqTduVCdWBWG5jXMb+saRAjVFX1bhhTjnI2e6p7sG2vZi0T7Lzf18esGKfN7tZ
	2U7i5QQnvU42eQFhe3rKFisjEwnQBthR9CAsfZztfbuMIBVkP5u/kxDbDqvkxNXJmeY7fvYRT1q
	B9u8j0BQVWSGWYS741BouQ9/sWXC2iiXOy5x5t0lwpK1hP7vjEL6E2/yKAsjFdOf+q/M3JQqVwB
	GUksPWVg+ZKGJa87CmXDnx197e44=
X-Received: by 2002:a53:db4c:0:b0:675:68f4:67cc with SMTP id 956f58d0204a3-677ac165dddmr3375798d50.80.1791206730536;
        Mon, 05 Oct 2026 06:25:30 -0700 (PDT)
X-Received: by 2002:a53:db4c:0:b0:675:68f4:67cc with SMTP id 956f58d0204a3-677ac165dddmr3375750d50.80.1791206728277;
        Mon, 05 Oct 2026 06:25:28 -0700 (PDT)
Received: from localhost (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c1b4a383sm3109497d50.7.2026.10.05.06.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 06:25:27 -0700 (PDT)
Date: Mon, 5 Oct 2026 15:25:23 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: Re: [RFC PATCH v3 01/14] iommu/riscv: Allocate MSI tables for
 second-stage domains
Message-ID: <dqo5xn7bz2wffbgolx76wryc7p7xsaygz2wrxhxvgnwekfpenu@tnu5uw4hauat>
References: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
 <20260928143113.49838-2-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928143113.49838-2-andrew.jones@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: jO_ZEXd9E62pFYP_DNITJVo0PebV6hTz
X-Proofpoint-GUID: jO_ZEXd9E62pFYP_DNITJVo0PebV6hTz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1MiBTYWx0ZWRfXy7UZ5afYV+20
 aLopx5BRa2Xg46P2qzcmjUhDr3RUyxqM8vlCUhYpi1bk71ulxd/BxuRLyW0MpxMyv9Eaaw7QG5/
 c3iu5vPrxivLe+14YLm6ef9BOy4cVZ8=
X-Authority-Analysis: v=2.4 cv=LuEHWXdc c=1 sm=1 tr=0 ts=6ac3a54b cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=zRh97aRZNhiOMYVz81Er1w==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=WSAePdX2diYu_KTn0zcA:9 a=CjuIK1q_8ugA:10
 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1MiBTYWx0ZWRfX8t1vrLNOImWR
 YA3eh50E1miwaquPDA5GYFLBtXlTRAYkzWXTiay+7I3Fhtp/xKAe6N0QJ2I+k8d1LBDGfZmNW98
 61CuUEbveP+AKd1ScT6PX0jgqPmVfDTHzE/CNYFkX7KRuLytF+1Oihvdwp1eu8ECvYXJkpJBUuX
 yY3yHjbH7CeYNY68fatbS9TDann9pwNb43P3emM9cMe9kQY+bjn+BLh6Dmol+UpjdQmv3LH/S1+
 YrmEP81w9yYMGeky7goIjH5/FGLFzc8vtaQnK0Ue8B6A3wViVLjslu+9RwuSvMQo5HHxwFDz+iS
 x15wDzGUfsLO2phMm0VgbiRdiBePTNgGIzcOPaAT2I6aJTyID20uyBA88nCH/K7Rf1UB1zdC/BV
 Q9drapshhYMneZl0V4sAo24Tg3IxYQN+FfpGTriOY6umYn2JAcYBYCA2UO1h/NZGy6q956UV3n3
 fuYsNbmRo9I/7svRIkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050052

On Mon, Sep 28, 2026 at 04:31:00PM +0200, Andrew Jones wrote:
> IRQ bypass maps guest IMSIC addresses through a flat-mode MSI page
> table owned by the second-stage domain. Allocate the table lazily
> during device attachment when the attaching IOMMU supports MSI_FLAT,
> and free it when the domain is destroyed.
> 
> The required capacity depends on hypervisor support and VMM policy.
> Expose the runtime-writable riscv_iommu.nr_msi_ptes parameter to set the
> MSI table capacity of new second-stage domains. It defaults to 512
> entries (8 KiB), and zero disables MSI table allocation for new domains.
> Existing domains retain the capacity selected when they were created.
> 
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> ---
>  drivers/iommu/riscv/iommu.c | 61 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/riscv/iommu.h |  7 +++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 0953aaf594cb..3bbb4d0d0a85 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -22,6 +22,8 @@
>  #include <linux/iopoll.h>
>  #include <linux/irqchip/riscv-imsic.h>
>  #include <linux/kernel.h>
> +#include <linux/moduleparam.h>
> +#include <linux/mutex.h>
>  #include <linux/pci.h>
>  #include <linux/generic_pt/iommu.h>
>  
> @@ -30,6 +32,16 @@
>  #include "iommu-bits.h"
>  #include "iommu.h"
>  
> +#undef MODULE_PARAM_PREFIX
> +#define MODULE_PARAM_PREFIX "riscv_iommu."
> +
> +#define RISCV_IOMMU_DEFAULT_NR_MSI_PTES	512
> +
> +/* A zero value disables guest MSI table allocation. */
> +static unsigned int riscv_iommu_nr_msi_ptes = RISCV_IOMMU_DEFAULT_NR_MSI_PTES;
> +module_param_named(nr_msi_ptes, riscv_iommu_nr_msi_ptes, uint, 0644);
> +MODULE_PARM_DESC(nr_msi_ptes, "Number of PTEs for new second-stage domains (default: 512)");

I never liked the need for this parameter. I think I have a way to remove
it, ensure table size supports (and no more than supports) the guest's
IMSIC topology, and moves ownership of the MSI table to the hypervisor
(which, since the MSI table is only needed for VM's, is likely the better
owner). I'll experiment with that idea for the next version.

Thanks,
drew
