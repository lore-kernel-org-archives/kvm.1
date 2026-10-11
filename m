Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACAC443AA3
	for <kvm@vger.kernel.org>; Sun, 11 Oct 2026 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742954; cv=none; b=G4o35kYQjIYzDaF4EGu5fVtPkrXfoNAU2bzOm1M4HYaEE0EsN4rxygR+oK6mzGJ1KHyltGauO8JMfDGEaE1PdHMXrZwS5QeFTtpWxZwf/bOxs2EfphEcEX0UvDv4IaLYzZf8tpsfXqpVsOkV9D+5LbvzwwOrbtN5gvq8h3A7F6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742954; c=relaxed/simple;
	bh=Sx/YLYtHnsGcMNWokhm0pgpzH9N8876oemZHYtrdgtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHa6/zGu/qvu/+fbnr8vUtW5LcwY+s/YbABtLCfDalgCr86XrDntELRQ2ZM0+peeNmVMar8SCA4Hc8d0xCx+ZjLDA5jgLjIk7u6/08ChzwMbl8q3WwDDkkVvy+w1qpQBGkZQrDJveSb2FLchqfftXKXS/i1sPsjhoPDbr2y3Qys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jc6qT34I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j6R3QYNx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jc6qT34I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j6R3QYNx"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69BILt313347930
	for <kvm@vger.kernel.org>; Sun, 11 Oct 2026 18:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J4GnUzarc/n9kpP41afLq33uqFjjFV9bhvTE/hjv9dU=; b=jc6qT34I/IsNsxmu
	+vEiY6Z/HcWeE1+pk0LJ5BfW5j38Uw7kYf2kf8xz/zZf8CbnN7p7HIDxtN9pHNHk
	6VWK47tzwUZQjDiHe8YlXU/qRHF24u+oSc7C9MPeVv2EHabHUlovBM80itaJhuqt
	Xy147D9pWJ4yrpr+II3Udip+s4FMv6bni4AHs86VnJHoh8CKm8SH6Lzf3ARVC++4
	fhPWk5qu22WogjceN7O3Wpy/YVFmiRQi1DK64JhDMYlhKej1kOl5g/0yn4YCgy68
	g/FXE0KmVs+4nNYzrj50jQcQSf7DyJAtGUM1od4ovz2S2ljo2vX/PegGr7kQAdpT
	b+Mu2Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7en9uc5n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Sun, 11 Oct 2026 18:22:31 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3515266f6eeso2409509eec.0
        for <kvm@vger.kernel.org>; Sun, 11 Oct 2026 11:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791742950; x=1792347750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J4GnUzarc/n9kpP41afLq33uqFjjFV9bhvTE/hjv9dU=;
        b=j6R3QYNxfxAMNEVQl7vLPLFYrFjUtegk+Yf7nYJOwRl05aFO8L+5ECzkplmMka/Kz4
         cz9SSaNFXUb4MgTtGoC+6vAF0Pyqg1q1KE2HRg4fgyS3uXv1KETSlE6OGukIF3CUFLwd
         epkopxs8Xj5etOI23yr0inOda4xP0PbbQ/IiWjBqfkV2ltbxVTFNPlUktCYeSthO04jP
         of/4hEDR6KeuWaTfRXhclVy3yIU6gBb8xucZrCP749UshpzAxcRVoIj+kyHkPGzm7p37
         wefskmbXWsheHaI8/JrK3jvRPYG6o09HDy7mAGrF9WyhW57aoVXb6Rbwl6e4XiS5eH7Z
         Za+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791742950; x=1792347750;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J4GnUzarc/n9kpP41afLq33uqFjjFV9bhvTE/hjv9dU=;
        b=01qPTCov/bDKKuKujysPueDzNDTOmAHNQ50dJXOJCWfbRDb3zlhfsC65Yua25CiUQL
         6jTEFQGFCtxuN8FeRMGI4bBCnGwIqu0qyB64O+g5vpm2CALb+Ho69poXx6R0ZGvYY8V+
         /ERQNy95w/Z6z8xbd4Mpp+gj34qaM8tuFPY0ODTmwDa13y3YnpVX9p3AHofLTrvemczg
         NrNInlkRxrfc2aDesYUGCNrHUhCUSUzZqp09U7lBM5nxEjv8WCpR83aRVf0ZE8LdQaUc
         Hi/DV7/bUk64Ii/yRNzlR/1na/tQLaKBCxG89zwcYJSbZWjtHcGpzlGpVNcFS/ZiHhb5
         BN6g==
X-Forwarded-Encrypted: i=1; AKwUvBxt+cYZNQbIX5qy6lgtPxhZjxvEBhtGbNjup9BqylXYZGHwu5m729xkg6cENrYaBeIiw3Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYITXK4BjojLyKGs8x7K4Ib2RXo7mTJMu+DBUae/qA+HqBOO+or3
	O+N35NrPBsih/wr0hyax619ZmJYoeH4Yhu/i49NnsNvmpYpARex9lJsrQT43vgrq3509y+cf3jo
	Up0roCwclmOfEj92wLuWrP1+3Bkb+c7GYan+JcF+d7L4NXk2bgvgymgY=
X-Gm-Gg: AYBFou0g0Se8JBHwpyr7bMVjYOoIk+KrnIjWH62hU+QsLveXnNI3z29s0R9UBW2SwQN
	/g1oYJ7BVKWouC+N3RwGz5BkAf55eX7jIzgj8RMIvmsIFMRKkvszToop8+vZZcx9rmCoTqNZYOB
	4+BrqahT40JwAkTB1Q23+VqrkPTN0gL3/HRJqNxawFvM2qcqYRSNoJL2Dc2phsr/YwtL4d2UKVi
	e3ezEULX12Ef6KBeVi5p4FmIZwftRffxq1foYvt2jUC2xs2nFb0nPqhQAOR+YntTD2oCEVqL8nL
	yyZbTIHzYCqhoT81ffM4iOvlYVoNoWGztKHYkGmXPPshoeROvWOucKRvY3l9aMgHhLfXZA0vk8m
	vWzMezpk+q6YLR6zipcDq+sila6MRl34ANMqfgEPuu0wn/DDst0EmGWv+Iw==
X-Received: by 2002:a05:7300:8a1d:b0:351:35b3:c5b6 with SMTP id 5a478bee46e88-3537e0fbed7mr11835705eec.27.1791742949788;
        Sun, 11 Oct 2026 11:22:29 -0700 (PDT)
X-Received: by 2002:a05:7300:8a1d:b0:351:35b3:c5b6 with SMTP id 5a478bee46e88-3537e0fbed7mr11835670eec.27.1791742949107;
        Sun, 11 Oct 2026 11:22:29 -0700 (PDT)
Received: from [192.168.1.20] (33.sub-75-218-193.myvzw.com. [75.218.193.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3581f594a41sm17453666eec.23.2026.10.11.11.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2026 11:22:28 -0700 (PDT)
Message-ID: <b1a3f755-19e3-407e-b8f8-b494de83f59a@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 11:22:26 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Enable Qualcomm WiFi PCIe passthrough to VMs
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, jgg@ziepe.ca,
        alex@shazbot.org, bhelgaas@google.com, jjohnson@kernel.org
Cc: johannes@sipsolutions.net, mani@kernel.org, yishaih@nvidia.com,
        skolothumtho@nvidia.com, kevin.tian@intel.com,
        linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
References: <20261011074514.515894-1-jtornosm@redhat.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261011074514.515894-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Woe+otfv c=1 sm=1 tr=0 ts=6acbd3e7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=AnolQpdaNwb4XK4FG+QP+g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=COk6AnOGAAAA:8 a=vTVf00-0V6mThgBseXsA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: sKNb88rWmIuVLuOIJyS37IqqmvtEfW2Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA3MyBTYWx0ZWRfX8igP8Pk9DXNz
 O8bJ4afRiIJ78/dtvIfjJiO6AsxnK0kXnvEWNn5tLTaufyOHzXGiqZgvhF07PgG+BdE51GnrLHm
 9Ewb7bWDXOeP7MUlcmreSfBpZ+0lWwyd3FhK5qbIyL3qLNlVIh4EsZ7zgacH137tdqYNcYHo2Ti
 vC95rmzO4aNc3iVA7p2SUVw9DiY5ZpwOPREZIrcVgFoSOycGDQLAF7iJafPK7d6hKr5HzeaF5of
 CcEXkDrkXqh0iNSd1JGtgArm64PN0o3g7ROhI3DXT/Yyi5WQEkm++Wll8nGYc5YCupbIGBb2dYC
 fQKLVsKlozgwrucf0hndnyTOqHC0u6H5UT7eyYbh6FW+pIvY/KkghELZv8cZnGFhp6tmbxPPA51
 JSSW/CYzZ/6Vxzza9FCJLH5d3QSPfxepgzEtKwrcdfxPtFD6Lv9bvoo79U4PE5hHKSFhY/xprG7
 NNegACgkCvXjpSbX2EQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA3MyBTYWx0ZWRfX+GgivJ9CXiIH
 AzNhviX0zjW2WAd+oB2VNykPup1Q1nPZeyxsw+xRmC32kU8jEdTaPxoIUwVzugFlUqGe2ZI1+8y
 Sz+/7lWYU4D5a6AiiW07sqbLVWQADn0=
X-Proofpoint-ORIG-GUID: sKNb88rWmIuVLuOIJyS37IqqmvtEfW2Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110073

On 10/11/2026 12:45 AM, Jose Ignacio Tornos Martinez wrote:
> This series enables Qualcomm ath11k/ath12k WiFi devices to work in VM
> passthrough scenarios, addressing a long-standing issue where these
> devices fail to initialize when passed through to VMs via VFIO.
> 
> Qualcomm ath11k/ath12k WiFi devices have been broken in VM passthrough
> since they were introduced. The Qualcomm firmware has its own interrupt
> controller with private registers that need to be programmed with MSI
> addr/data. The driver extracts the addr/data from the MSI descriptor
> and programs the firmware's private registers. In a VM, the driver
> only sees virtual (IOVA) addr/data, but the firmware's private writes
> bypass the IOMMU, so they need the physical host values. This causes
> firmware initialization to fail with errors like "BHI offset:
> 0xffffffff is out of range".
> 
> Multiple attempts have been made to solve this over the past 2 years:
> 
> March 2024: Workaround using module parameters [1]
>   - Required manually copying MSI values from host to VM
>   - Rejected by Johannes Berg as too manual, suggested VMM solution
> 
> August 2024: QEMU + kernel solution by Alex Williamson [2]
>   - Kernel disables MSI virtualization, QEMU intercepts config writes
>   - Uses brute force pattern matching to infer MSI data writes
>   - Stuck as RFC - no progress in 8+ months
> 
> No action from Qualcomm: Despite multiple reports, no vendor solution
> 
> The solution in this series provides a clean, kernel-only approach that
> addresses the previous concerns. The PCI reset support for these devices
> has already landed in linux-next (commit f8522a518e59 "PCI: Add device-
> specific reset for Qualcomm WCN6855/WCN7850 WLAN") [3], solving the device
> reset path for VFIO passthrough. This MSI series is the remaining
> piece, with both in place, these Qualcomm WiFi devices would be fully
> operational in VMs for the first time.
> 
> In practice, this specific behavior (firmware requiring physical host
> MSI addresses in private registers, bypassing the IOMMU) has only
> been observed in Qualcomm ath11k/ath12k devices. A device-specific
> approach seems appropriate, and the VFIO variant driver pattern fits
> well for this, following the same established pattern as mlx5-vfio-pci
> and nvgrace-gpu for their own device-specific needs.
> 
> Architecture:
> 1. qcom-vfio-pci variant driver caches physical host MSI values and
>    exposes them via extended config space with magic signature "QMSI".
>    Device-specific hardware quirks belong only in kernel drivers, not
>    userspace, independent of the tools used.
> 2. VM drivers (ath11k/ath12k) automatically discover and use cached values
> 3. PCIe link recovery handles VM timing variations
> 
> Thoroughly tested: 3 VMs across 2 WiFi generations, all devices
> successfully initialized and are ready for use.
> - VM1: ath11k (WCN6855)
> - VM2: ath11k (WCN6855)
> - VM3: ath12k (WCN7850)
> 
> Series structure:
>   Patch 1/7: PCI helper to find free space in extended config space
>     for device-specific data exchange between host and VM drivers
>   Patch 2/7: Shared header defining the MSI cache protocol between
>     the host variant driver and VM drivers
>   Patch 3/7: qcom-vfio-pci variant driver that caches host physical
>     MSI address/data and exposes them to VMs through extended config
>     space
>   Patch 4/7: ath11k PCIe link recovery retry to handle initialization
>     timing variations in VM environments
>   Patch 5/7: ath11k support to read cached host MSI values and
>     configure firmware with correct physical addresses, making the
>     device operational in VMs
>   Patch 6/7: ath12k PCIe link recovery retry to handle initialization
>     timing variations in VM environments
>   Patch 7/7: ath12k support to read cached host MSI values and
>     configure firmware with correct physical addresses, making the
>     device operational in VMs
> 
> [1] https://lore.kernel.org/all/20240322104912.94811-1-jtornosm@redhat.com/
> [2] https://lore.kernel.org/kvm/20240812170014.1583783-1-alex.williamson@redhat.com/
> [3] https://lore.kernel.org/all/20261005105436.83962-1-jtornosm@redhat.com/
> [4] Original problem report:
>     https://lore.kernel.org/all/fc6bd06f-d52b-4dee-ab1b-4bb845cc0b95@quicinc.com/
> 
> ---
> v2: Complete cover letter with more information

Thank you for providing this level of detail in your cover letter. I've raised
this issue with the engineering team in the past, but I've once again raised
the issue with your in-depth analysis.

/jeff

