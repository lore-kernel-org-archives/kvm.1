Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402186;
	b=lnX2yMsY5Cbg2TuNXblyLf7CTWIgAvHK7+W9IKWHJQUyCvl80DNbLiiTxkWgVhqpYsrq
	 aDTCSYIr9YGH2bt9PfYgMiVvppcj5af9eBjuhXjhFiTIQ08fbHNRvQ2odONJabN8NSVyG
	 Cve9Buwevd83sXFCk6Kl2uSX0SDPsDIhqd9BBpCl+EQAv3bz1z6GyY7lxM3KWBn67FCgV
	 SY9V/JpzjpKDqF2BGGqE6qbhgP9CAkir8ONBqUfGj/0zHZ2lhyE4xVtL10qTcPRAXmjFM
	 5ZysezfANkQDSF6opBOYDXJ/3byxZ8qUkHPLpJWAQyWXRLl6hPNgjG45cnE7uMk5mFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402186;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=L8WR9+GG2EfUF3UrFaA4c5ksUoCcRyLK8GiwEhxkvFI=;
	b=xFTlVnTnFYSQ2LbwWrRxMm9t8H71R1UBX+KqJwSb8+1LavSQjZXKbKw4m2ptJ/7QBEGn
	 sCI5FJXoeUmotdIvfJzxnck3cSS2pUyi/tFLGd4s8kpYlXXO0oljqIqNwsm3xsWLP8Ufr
	 gBARkf400thQ/Avrxw/DP1xkxL8kWzrdT6lJ14tfQhwlXMzaXywwYRDjr290TaVzNLbxm
	 Rqyl13bqlN2c07NvANM3J8diI6fHL0T6P9flVYqgIqJfcqb0J/ygThdHM9KfgEMsavuBx
	 GTuOCsaHOOG5ZwbNgP1wHFp6+fDR00JrKrf2QcHZoM8yDL/ft0lZOeWv8Kl4nFL2gMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PH9mWwXg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZjzR67P8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD0E606A339
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 13:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBD0E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PH9mWwXg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZjzR67P8
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCZXFQ1251153
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 13:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=L8WR9+GG2EfUF3UrFaA4c5ks
	UoCcRyLK8GiwEhxkvFI=; b=PH9mWwXgQ5gEnifkFQhZ3anQH+M6DXWxjaYRNBm4
	8z/pNaY5400bAsBEpQNm+vBW+Q+jfqxxN8HzrTI5OzBHGZzkIlvScO/QKa7SGl2a
	PcypMhUu/gBKUX5uX9oh04q9yOC77RcAXm6BOFLzWoUXUVzVzcsM5EsBVKTYRsaf
	ij+ZkoP+ccbshZD5IvbBTtE8sEoCZpbwWmu4e2y+FeoOw8o2qNPB3O+GvjrxE3+p
	AL5/WPO/FeuqH2XP24+LiL3cpFAdsvCWMFBzD9x9fNyI2UQVztZgs07w1ZKgjDrL
	0O5WFB1GTvFsJB+TEYBpy6tRV1lwTog6SnR/2XN3l1argg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv7c5md4w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 13:03:04 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5eac74b0596so2648683e0c.3
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 05:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794402184; x=1795006984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L8WR9+GG2EfUF3UrFaA4c5ksUoCcRyLK8GiwEhxkvFI=;
        b=ZjzR67P8wqGqtdDTOZihJridX5Q+5MAT9lUERZhujk3OFRjnm/V3mV6hyZLHbMF+FB
         +byN0EVBtuZuuy7pVYmilcT+CwaRmYKUJUn1DS22CGwS191pyWZ2YqgC0M32PjG0nK7r
         fdUJ0Z32Nk3ThjHjex4z18y95JXPOjKkHBew2NeXNP42a6nE9fwxzlMoOUFCPeMLElUM
         u44kv3rU/ciITpwAdoXoXmblb0bND3+tK1Q4gU+gaSRSlNag+u0LRXnKMR+hpPZQyPwk
         wTgsrQqOEWHdoXmaZhouO421u7IYZzMWsXy53ZGchDt7r/u5x/cejS8bsSnALtMQugnt
         0rMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402184; x=1795006984;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L8WR9+GG2EfUF3UrFaA4c5ksUoCcRyLK8GiwEhxkvFI=;
        b=Vo1vV+l9Avy1ApSUdl5Z1V3kffErftfZqQTp6FpUKq08t+uAXhBHF5h/YISRkg/uES
         Frzyl0xON76oW5uvpzHIBJ5jCD0VREX+Dcf1Zz6lkToss84owjvRb+yw/uqDSSHeNACD
         vLYZ9H2vb/IyYTx5Inlt/SIgbDuV3PHobOKmoOKcSt3YABMH7Uumf7MHkTvG1o47L5Tr
         FLI2uidacZlk6+EegHx6CEoBqGGIEMoApdHv3SW0faMVlRNsoVDMQaDvDvY8DfF5E558
         1oDQAIdIzQ6++EqUFwlPIsbIyID/aaguJMY1Zjr/5rtbcyshQIyDjVdRQM4o4e3YRLJw
         FJQw==
X-Forwarded-Encrypted: i=1; AL+hErGqoApZLcRZGJMSAfV7GmFGdclCAe84vPKdfq8RIMAYsDIjfsrmmNR5UBCcYYIcKt0QVdk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ml8uRZ3l0m3j8LWQCIrvEhB9Or+IsTPt8sSZx+yFsycfl0LTw
	yKe+i+VhRm71GEnIsGZvpAJxlht3xiGVaxDIi8zY98Ljj8+I08KBbcFiwjfDolt3gBjDXWmJkI1
	aXa1/+hSbdTV1oakgiH++rJaThPqK8E1rPj0+6JZ6ttVwDynMfV4Bg2g=
X-Gm-Gg: AYBFou0NrbeiCLDIYSr4Oa075xprKXtPskRlUXuo2fubUTxP4y9hWoNgQvtFl7CYiyI
	BeZiCWUrQrYwfo9YLH3czoVrQsXtxI9tu6/l/LWiSipzxGjdrzX44tpC6C/olxxsFhW6ncnaKVe
	APrGIYXnqISdVbHF7+//24CGwV8k7GgHxAyr8HWXwkkt7UmTZoSFxv4dHAdkg3gbHo9prQo2DxS
	xrejM+JEwLAMyOpGWPrwLj1gcU5530kpgpqts/BJ65z7/Ckjyda4OMJ19yFQnkk0VzisBQIFkDY
	9r4oz+8Ls91JBAivJ8jbVNMTZMnAnqkjCHRhgLzA8oZSKd6klhFRMZ+BUIbto7mWWS/O+xmqUnf
	VCwelSR7pd/yq29XuNY/gJCQi/I4ZSaD/6oUfZHEJpafcUynP1zAPWIU6XLMwEIOWtGyVOIwvLO
	m3PGue5JjT1e8ioNeug21jgli7Z0fd4Hr/Wa3Mgh3NoOPAdi/6epIClN1hTWxh+g==
X-Received: by 2002:a05:6122:1782:b0:5c9:a7af:8178 with SMTP id 71dfb90a1353d-5ee1c2b2435mr795065e0c.2.1794402183907;
        Wed, 11 Nov 2026 05:03:03 -0800 (PST)
X-Received: by 2002:a05:6122:1782:b0:5c9:a7af:8178 with SMTP id 71dfb90a1353d-5ee1c2b2435mr795003e0c.2.1794402183114;
        Wed, 11 Nov 2026 05:03:03 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157bafba6sm959941e87.62.2026.11.11.05.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:03:02 -0800 (PST)
Date: Wed, 11 Nov 2026 15:03:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
        Eric Auger <eric.auger@redhat.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Oza Pawandeep <quic_poza@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Subject: Re: [PATCH v7 1/5] iommu/dma: Keep reserved regions below the IOVA
 rbtree anchor
Message-ID: <5pyhbuzlrk2pf3sct7zopoycvgliuvzzmd5qse65p3r63jarvo@g3clac2ao4xq>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-1-5c0f72083e52@oss.qualcomm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-add_iommu_ranges-v7-1-5c0f72083e52@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX2zzrdXvfDin7
 nqD4PK7Lm4O1VkLbpK9HQg+LF3v52DXwOttNfvbAMTPpQRzFFY9WXsJN7fKvMwEQQry9Vid0kS+
 1VfqCm7xPa9jlg7spDx2NJfg1K1pMSHL4JCjzGinq7nbKIedboxfwUJbJRzBW1rzz6siYTf6VBY
 sD0cuIWGl6inu+SNfA45Q1IpfBAcStHJmkmlX9z4237JNGTcrWMfiJSkM2mGFe4NSQQMIpU1RQ6
 N8EN5qNpxQkWawByoRY6a1cIW3MVFe0zO672rOHRNiCHxRL5d2XPhXf/T88DLwo8av1wzBcqRlM
 3Dxpm0YDkxbCAf30OCugPg2/L/Fob3E+uOR5ZLKaYT98dHyFVdgXUBNuqw3HIwwFLKPxYd2oHSM
 R8Q4LeSax9YjEOqimjOErVz9RAffP9K9ylKFKAdGSQef1d8E0elmJCiLf4D1qI1DMe6Bwnfk68+
 p30tvh+XxJvvn+Rmymg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX4+VhYYohO+8d
 /PHeB10paTZlbXqHu6P7xT4JVu+q3Nuq2f14eUryMKUE0bNfTCIRGQVBNu2NM/03S324+rFjQeG
 j8IdLY/9RxCwNaVlZau8Dqz5zQm5gr4=
X-Proofpoint-ORIG-GUID: 9s7yjlSLP6XpC6ZokXjTG2l1hT319UJV
X-Authority-Analysis: v=2.4 cv=eq9KXYpX c=1 sm=1 tr=0 ts=6af46788 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=WA2_6xBGtpbLEjlkeFEA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: 9s7yjlSLP6XpC6ZokXjTG2l1hT319UJV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110051

On Fri, Nov 06, 2026 at 10:44:24PM +0530, Vikash Garodia wrote:
> The IOVA allocator tracks address ranges by page frame number (PFN).
> The highest node in its rbtree is a fixed anchor at PFN ~0UL, which is
> embedded in the DMA cookie. dma-iommu converts reserved regions to PFNs
> with iova_pfn(), which returns unsigned long. On x86-32 with PAE,
> addresses are 64-bit but unsigned long is 32-bit, so the upper bits of
> the PFN are lost.
> A reserved region that ends at the top of the address space then gets
> the anchor's PFN. reserve_iova() merges it into the anchor and lowers
> the anchor's pfn_lo. At teardown, free_iova_mem() no longer recognises
> the anchor and frees it to iova_cache, which corrupts the slab. PCI host
> bridge windows above 16TiB and the reservation after the last PCI DMA
> window hit the same problem.
> Compute the PFNs in u64. Skip ranges that start above the PFN space and
> clamp the end one PFN below the anchor. The allocator never hands out
> those IOVAs, so nothing is lost. On 64-bit, PFNs never reach ~0UL, so
> nothing changes there.
> 
> Fixes: fade1ec055dc ("iommu/dma: Avoid PCI host bridge windows")
> Fixes: 7c1b058c8b5a ("iommu/dma: Handle IOMMU API reserved regions")
> Fixes: aadad097cd46 ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-195658@kernel.org/
> Cc: stable@vger.kernel.org
> Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---
>  drivers/iommu/dma-iommu.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
