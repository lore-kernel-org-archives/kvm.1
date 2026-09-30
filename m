Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D3C4F93A7
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784395; cv=none; b=CwiJDGLmfqDVNDdhYqtbC58hUDAaMYKWlJ0o6bTxjst6zs9jKz9u43bDkwNnGJd0pCc5L0KWTYPXj6NvpvjL/1khKjG8K/j/WsmKq3x0/SJAK89fRAHnWDfMXeTaUXzBT+ZAKT8kealvX8dvzAhw5QhpOhtnUNUqXieOyAJ0D5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784395; c=relaxed/simple;
	bh=M3mU235Be7SmeB5TrecbBlDrIaYaw+U/+jYODikK3Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtTK47aXU/9iiFbEQJJOJnoczLI4HOozUc/Q2Awk+fIi+eHkpkcACUg+E1PNsU3IPw+s/46N320tkT6jQ9kBnflbQMAgaP3/bSZQ0t4Rq9E/gw0msjOBJA6IP/UKnS+FY11FtyAJzxm1+6/ksNLNx1nhMqqyFV2nIWbgao2qHgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GrzS+zys; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jclVqyvW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GrzS+zys";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jclVqyvW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UDxq6Z3668540
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 16:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RJsMX2lmV5ZOu0OhhWQETYgs9bQFhObUxVjX+YGHGYY=; b=GrzS+zys6kCaaQuR
	hoYYKt3vxHvQAsVUc8sd7nR5DNlwNVQ/udeLha/y7PBdkrOan6v5ddR1cVm9uk4/
	QenhZMPEoE+sSrea/Xf7uz3u6zQZ+zmLeh8yOeFhXcYjex23pw7gf/YsduLeNbCN
	36DYaVdtCJXpvAp18lcvQWydfUe+3VFOhZ3fIt4dQjTqmVfwn+pRr4uBO9A9ajib
	Jn5mjjn2PImG2IOXGizFtK9L0rmR07DJB4QON5XZumW/LopQArDtELJI51GS+wKz
	eSCMFF5usimEHanL4mpYFl4PXD20XyLB+Sdv54i+20Pfb7rnXm/U2plXKUzH1a55
	zkI1Iw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rj2urr7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 16:06:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34d62bb27a1so1229521eec.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790784388; x=1791389188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RJsMX2lmV5ZOu0OhhWQETYgs9bQFhObUxVjX+YGHGYY=;
        b=jclVqyvW4xohGXhTSz3AB+UEipNuWRCjruPxKqT1Xs75exQSY8HThu9gVx1HRQg7tD
         DtmeicRfEjLq8NWW/Um1S21cH5khdfhXqzDSI98FYFYgr5nkuU6qKezaQHnTYyUstDxh
         BhIi2ssBtH9byW+Us1ew7zqNsdV+Afgv4kkNQYee3SMQ+o9OYU9lNOBtrWrU0UbuSCHo
         8H7yQney9QUaIEQWslHTHll9LAUv+tU14kF/nb3KqNEFIH2XtUUotEz/z8s1Ty/oOjoa
         FBX/IHT7dgwj/E/GonLTR5Gw8pkGRRBGLdJGBR7NU5ImUJa8elyzmsBKmTzRzXRjcZQV
         VMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790784388; x=1791389188;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RJsMX2lmV5ZOu0OhhWQETYgs9bQFhObUxVjX+YGHGYY=;
        b=Mz1vEMl/Uqhgnr/xU3wp/WE2n/w8i4btktUQrx/D6In65GayS21Su7epjQIgK7gZNl
         jEt9pICCDIVKrLTfyRQgJrorKQe4AOqwoMfj0GUzlF0va+Bnn6fjpii5ynLpYIH+uUzH
         La49c1V94ROm/t9yI0P3r4KOBgaVzDvtunhIOmwQimiEHDSOSIvQBE9UvqQom8cgEL3d
         zQtrN5XFWnIq25BRAla8OQqLnDS/X5nwr2vI/c1AY3prHFPG6r/e4BU3DDgBwDAm9+kQ
         szcCt0J7+MeL4iklqKaO/AjlH6N0YNNcmC+19J9QxOTjVZx1fQagAArEH2BKt1L6I8cB
         GG4g==
X-Gm-Message-State: AFq9FYLMfpvBxo1IlqJK7pND9pZunmtRDcs6dj/4T0d/djI1XWPOHGl5
	rg150vaA3O5I0wazWg412kqVK1i+S9Ha+xsobFguHudJoglxYQfBhGU196egncJcsGBqAvTLIwB
	h4xZ6bvbV4z/1wLEkqJtCbsmh2PNnw1Wxbv6YObgOqSvVkmIrogGUafY=
X-Gm-Gg: AYBFou0Dcp1RY/UlvLVu28P6ExB2skogILuGqOHn4VzaSs0Yy3LK56lRFooQn2LSawN
	cbceDA7IpPhptQO94lACFAe/tSn2QVz3qKsrqiHXurBiXAcY7nKRHbVwySgpj/PlPdHnf3N89YL
	PgVxLegE02dgSELjvvj45y/Xkjv6ePYlvdGyw/JoUIeObZR9qO5+qf9jHDHbXrJPY+b84yat9qC
	P8dwbUJQx3mZNHqcoS9j6HWQKZ9IURaLsRz1NhWVzXEFs5jKfWgPPOqgCjgn96U3qOP3lh3i72O
	cjySogricaYpA/zwQljyGtYPmgVUh2mQKXAPhHyEkwQ8supUaXm92CZDDTVZ+yfkD8Hfa1bzIvj
	8a8OluWG0HUMzN4uiR0RIZF9Bj7/43Vgwmu0zUv0/f7nMmj8NE/BPiw==
X-Received: by 2002:a05:7300:f791:b0:34c:5283:4f07 with SMTP id 5a478bee46e88-34cdd792968mr2177214eec.38.1790784388295;
        Wed, 30 Sep 2026 09:06:28 -0700 (PDT)
X-Received: by 2002:a05:7300:f791:b0:34c:5283:4f07 with SMTP id 5a478bee46e88-34cdd792968mr2177166eec.38.1790784387688;
        Wed, 30 Sep 2026 09:06:27 -0700 (PDT)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db0c8e76esm167595eec.4.2026.09.30.09.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 09:06:27 -0700 (PDT)
Date: Wed, 30 Sep 2026 09:06:22 -0700
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org,
        will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, steven.price@arm.com,
        aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com,
        joey.gouly@arm.com, tabba@google.com, yuzenghui@huawei.com,
        linux-coco@lists.linux.dev, gankulkarni@os.amperecomputing.com,
        sdonthineni@nvidia.com, alpergun@google.com, fj0570is@fujitsu.com,
        WeiLin.Chang@arm.com, lpieralisi@kernel.org, enju.kohei@fujitsu.com,
        sudeep.holla@arm.com
Subject: Re: [PATCH v20 7/9] arm64: Block hibernate and kexec while RMM is
 active
Message-ID: <20260930090622.00006590@oss.qualcomm.com>
In-Reply-To: <20260929221623.1342076-8-suzuki.poulose@arm.com>
References: <20260929221623.1342076-1-suzuki.poulose@arm.com>
	<20260929221623.1342076-8-suzuki.poulose@arm.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1OsKUF_QGPs5eiJF63H0TItP0U_ELaq4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NCBTYWx0ZWRfX1KlKUoG0rWHU
 nRClIskCDrTSE8r1qU2fdPFfTOUTzDL/OuJblbeBebVnKd87OcM3ZSyLtoCEZvVzc871jOJHHw1
 A855E5Ej9rrH9rfVopVZbAE46wYd9h+Vu1q6W/o52B8pp64xOYAYehoAojcrape+HGJKW3tSOC4
 T6xdjEVw4YEuTx0sgF5lAriWlJNYt7tk0H46uSI2oQbC3Rd5zRWdCj2i3ol+mbhwj+YF+AJkhxJ
 2sTJFOHjwFSWrORiP/xo9BjWUuMe4L6MMjoe0atSVN2hy1vMj/TFBJS18BZ8ztH5eEhbgOVKFyH
 zuyG7VTKvbXpwkhC/iZEbcogsFbRo8Tvcht9bMmVMyES2hxTj4J3S788rkfZ1FOjuT4oXZ/7kEo
 +1HwhqOeuiTy+czuuQA5o/7X8Xgoha6WZdcrzS9sA1Du/buESv52/INIFq1Zdno565Eze75SvRq
 A0Kx4ZvybSS5Tg1UNfw==
X-Proofpoint-GUID: 1OsKUF_QGPs5eiJF63H0TItP0U_ELaq4
X-Authority-Analysis: v=2.4 cv=Ypya1IYX c=1 sm=1 tr=0 ts=6abd3385 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=LZvgd7wXd7bcPLl1K1UA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NCBTYWx0ZWRfX6IumDn0xERKu
 lV3bfBXelFegRE4B1lmJxi50SenVqWsNwYWrM5QG5hZt63suwVyTzDkddqsMq8b0riIuygYlka0
 QgZR0DiPxcdaxkiJa2mmqNOApZUQGv8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300064

On Tue, 29 Sep 2026 23:16:21 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> RMM can be deactivated only after all delegated granules have been
> reclaimed. If a new kernel is entered while any granules remain in the
> Realm PAS, accesses to that memory can raise a Granule Protection Fault
> and be fatal to the new kernel.
> 
> Crash kexec/kdump needs separate handling. It can be supported only once
> the crash kernel can tolerate delegated memory inherited from the primary
> kernel. i.e., be able to read the pages safely and fixup the GPF. Until
> then disable the kexec completely.
> 
> Hibernate has a similar problem. The image cannot be safely saved for
> delegated pages, as the RMM doesn't support exporting the pages.
> 
> Disable both kexec and hiberation while the RMM is active.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Not my area of expertise but follows similar patterns to blocking these
for other reasons.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
