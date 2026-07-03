Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02CA340416;
	Fri,  3 Jul 2026 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067315; cv=none; b=RvzqUkNCWfkLUzPirP04ECyKRKFt7H61O1h+p+llRb1rEzo19CWrlhfOksBoBhpi7OGudHez73oTO4/ckGNX5s5dypCs4n04JO32GHbEgSZPyCJCEoWid6DxyhwTID02uHkUGyjdImXWA0puv/5oJParazYHvtQo3yn/0c7AEdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067315; c=relaxed/simple;
	bh=I7kViHvOqAa2QOxclPTEeSYPFhTt/rOFj4As1JtsxRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fM7/1XBwwxUg2NoyFYgZqnpIwLBKxgwIevojyQUXUWBx9oFaVdQxH97lfrSGW28fQ522KyzPnESWpBrR1xaSn6Yn4hbzhcEuleXvNgQEELzPbMVYfebI0Cz6iehebTXjbTTjaM3onNAsiLGH63HD+Q6WowNImXJPpTb80sxBXd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cbd4DtOO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cbd4DtOO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IPvP1812945;
	Fri, 3 Jul 2026 08:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WEp7ih
	hbqwOWllNpg4G2jbQyg82KbcXyJvgz7C3uUTM=; b=Cbd4DtOOBj0zdSOMr09tPf
	497fDDq73dDQT/NGJFqYaCK3RDv0nBUca6mMXrwT9SMn/rsDP9w7OyQCY5Cnwg5o
	PboeRiv2ofvvkvLBzfmzY/GcpiUANWemqrXKfCMoG1BB/cmx1UJkegy6j4vzR6ye
	lMWz0QG86hkIVkurT0NdEEWfXwEY2+ojHCFAbVuh2gvSKmDYwZt4cQoz1N5apZoi
	Dljbz6E0liJhlVGmjuAcJfgaBka0WhuIASRKl5F5rIDlLrGkl5iBUktnJgwavr9O
	WC5Zrnwz6/fBPfp0Ywwh6zw6S2uX+F1NTYnnhC+LyQswGEgZu/JTRQ31F+6KhgZA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qadt1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 08:28:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6638JrPk005112;
	Fri, 3 Jul 2026 08:28:22 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukfxdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 08:28:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6638SLgQ32637640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 08:28:21 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BA5158054;
	Fri,  3 Jul 2026 08:28:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6B665803F;
	Fri,  3 Jul 2026 08:28:15 +0000 (GMT)
Received: from [9.39.22.184] (unknown [9.39.22.184])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 08:28:15 +0000 (GMT)
Message-ID: <5bc225fc-4b0f-45eb-9700-57e27f575818@linux.ibm.com>
Date: Fri, 3 Jul 2026 13:58:12 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] selftests/vfio: Add sPAPR TCE v2 coverage
Content-Language: en-GB
To: Narayana Murty N <nnmlinux@linux.ibm.com>, alex@shazbot.org,
        dmatlack@google.com, shuah@kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: amastro@fb.com, rananta@google.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        vaibhav@linux.ibm.com, sbhat@linux.ibm.com
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3OCBTYWx0ZWRfX96M4ovCf14lJ
 JOQ5OKaWGCHYdQ4GNBHy+gFuTLEFuqvHaoAhX64faL/VI8K5R/2Lv3Tq9im5qvR3S0a+ojKyX97
 Tvsw3vgwYF20bkpa5YUlGPrgGRDT78hV2HIYAHa6y/NM1Arkr4Kqg8Tebgki1u7zr0KGXxLSBX0
 UwBdnUFd4JTc13XZuTEo/yCfv7uzdGrLeQin3L7eIuB6q4RAtTJFw+t+OWF9EXVo7I81o5FlqAn
 nZMDO4ORncT9pSWbAOnjUyt9kE7Kfws9u9rfyohZYlUnvA3Bcd1c6DZ3IbycM7F7q60GZXsc/BO
 GIAUqdWQFSEnymGDjjCLDsxZZlcCva8EaKHbeIHFCH9wicn1Dawan5YVIr6kiCcmlZfHLK4XLox
 TGwXenuAJ9aQBEmR88GlStdTMMPlyYiz3uVGciKVSbUdrFE/rKE17b664REllY+H6ZIZ0z3qmQZ
 1z3YTmTamP84825+e6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3OCBTYWx0ZWRfX6mc+ak0ifSgQ
 H7Dsrj2MrIytPGoD+jRvkarFUYp7+V7jCnU280MwRC6qnH4v5GMW3TGmnlDdUOZeT8mAxGzEFsi
 S+2KMxPMfCskKN1xytMKQwAQbDAelow=
X-Proofpoint-GUID: 5lI8WL29gxczl988owhbP5YUlXcUFVYi
X-Proofpoint-ORIG-GUID: nuNrdcZ5HGVH-3aUUAjjdGtWYJ0ziyjj
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a4772a7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=LWOX-0NBJ426XIOUI0cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030078

+ linuxppc-dev

On 03/07/26 8:58 am, Narayana Murty N wrote:
> This RFC adds PowerPC sPAPR TCE v2 support to VFIO selftests.
> 
> The series adds a selftest IOMMU mode for the legacy VFIO container
> backend, adds helpers for default and dynamic DMA windows, and exercises
> the sPAPR DDW path through the DMA mapping tests.
> 
> sPAPR TCE v2 remains a legacy VFIO container backend. This series does
> not add iommufd or VFIO cdev support for sPAPR.
> 
> The main points are
> 1. add VFIO_SELFTESTS_IOMMU_MODE for selecting a backend
> 2. add vfio_spapr_tce_v2_iommu as the PowerPC VFIO backend
> 3. preserve the platform default DMA window
> 4. create and tear down only selftest-created DDWs
> 5. prepare the DMA window before IOVA allocation
> 6. exercise DDW creation for hugepage DMA mappings
> 7. accept sPAPR-specific errno for invalid DMA ranges
> 
> Example:
> 
> VFIO_SELFTESTS_IOMMU_MODE=vfio_spapr_tce_v2_iommu
> ./vfio_dma_mapping_test <BDF>
> 
> Observed coverage includes anonymous mappings through the default window
> and 2MB hugetlb mappings through a DDW. 1GB hugetlb mappings may skip when
> the platform rejects the requested DDW characteristics.
> 
> Feedback is requested from the VFIO and PowerPC communities on:
> 1. whether the sPAPR TCE v2 helpers should remain in the common VFIO
> selftest library or move into a sPAPR-specific test helper?
> 2. whether DDW setup through hugepage mappings is the right initial
> coverage?
> 3. whether the sPAPR-specific overflow errno expectation should be
> accepted, skipped, or hidden behind a backend helper?
> 4. whether PowerPC should generate only the sPAPR TCE v2 fixture variants,
> or keep the generic IOMMU-mode matrix and skip unsupported modes.
> 
> TODO: vfio_spapr_tce_v1_iommu yet to be covered.
> 
> Narayana Murty N (6):
>    selftests/vfio: allow selecting IOMMU backend from environment
>    selftests/vfio: add sPAPR TCE v2 IOMMU mode
>    selftests/vfio: add sPAPR TCE v2 DMA window helpers
>    selftests/vfio: Exercise sPAPR DDW path for hugepage DMA mappings
>    selftests/vfio: Accept sPAPR errno for DMA range overflow
>    selftests/vfio: Enable VFIO selftests on ppc64 and ppc64le
> 
>   .../selftests/vfio/lib/include/libvfio.h      |   9 +
>   .../vfio/lib/include/libvfio/iommu.h          |  26 ++
>   tools/testing/selftests/vfio/lib/iommu.c      | 280 +++++++++++++++++-
>   tools/testing/selftests/vfio/lib/libvfio.c    |  37 +++
>   .../selftests/vfio/vfio_dma_mapping_test.c    |  30 ++
>   .../selftests/vfio/vfio_pci_device_test.c     |   4 +-
>   tools/testing/selftests/vfio/Makefile         |   2 +-
>   7 files changed, 382 insertions(+), 6 deletions(-)
> 

