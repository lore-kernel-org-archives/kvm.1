Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402101;
	b=mCdFx8nfSMb0WL3hMWfB+okHK5lWVMqihLpQLbc9jEX+iyTSYLu4W8THCZcywL3+ERsl
	 sbKRq1RDETNoqyAZ9DN5ljy8EbQY7PMRVXhOdtjYsudN/WHiURHS+3CaHCsOHHNhOWcLf
	 y6KYiv2p+Wf6uuxVvMOT/rhWwkMjx0LPcSbgWdAOTBfA+qCLqY/a91D1cCXxEO36lHyyX
	 dOXP1bPDAH1ujOJ/021jWxEjdw6mjyqdraMMT2UpWDjSwdKV2t9nafO9BHh+dQHncl0nF
	 C1DhOMQCpisxmSIwbFkNoReTIVAwTo/3DlD4fSGgCgjKvM1hCGCapxFMDtlmuQRmzhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402101;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fNNA5DINfFRpf2eORoYgUUVlbLJUUgtkmYcnEbAYKiY=;
	b=i9Mts2RB0zKYxSXRe9+xI5TYnIBKtJ81JS+EQJigGOGj1B+qMwQgN8BcNCXSwVo6/BRP
	 saapSJuh9FhUkzYugxgAlyyT0g2QDJ79owEqXSpqD3kshqWawj/3y4Z5P4ycXVPH6mUf5
	 Gi1DCH6hjdktYGbXi97FembIFAV7nWz3VmNR/4Wxg2PiKUuXJVQRTBRviimzHwIrNDpDz
	 tTTDLxmjh3g/ucqMuxiQv+OA24ri5L+hFmNNG9omXxZlhEs1WWsWJzC4hyzFEox73hT3Q
	 kW22M6oipBAohZ+AWI23OBe8tos5FJ9bcpkwaDtjZRNJ/CpDv4uoqOGEbYSwBB7JnXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p6q+meWf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ahN0Ajmk;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05CA606A31C
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 13:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C05CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p6q+meWf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ahN0Ajmk
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABCYwju2356537
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 13:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fNNA5DINfFRpf2eORoYgUUVl
	bLJUUgtkmYcnEbAYKiY=; b=p6q+meWfh8pxTAsOPcNqXBXxXBRbH+GJDC4uiwKA
	LJ5hYTCU3/k1FKYji7ugZnbHErDA5WuhE5KzDaz8lgoup47Kf0aitPgAEw3rW0lp
	tMtswTpUYDD8q4tClQtiOBprE7ZUy4pXagV9SgI+lMAfwYQfVHVebO5KPPIcUnid
	chmnqaobA7mVsL+v/gdx+NJL5U1KFoj9M4mB1lr2ZMcQaWN29IzteadEmIgwVhrK
	EIpAcU2xW1xN36ygYXdO+5SKN19CrB5t79dsRs5D885Pvk1tYO8MeB2FCyVs7Qv2
	wejjCK8v+qWke5jhjykBYz7/jQCHfyyuSVzlG19XahwgNg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvgjdhwm7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 13:01:39 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5ece3cd5a00so2423218e0c.3
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 05:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794402099; x=1795006899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fNNA5DINfFRpf2eORoYgUUVlbLJUUgtkmYcnEbAYKiY=;
        b=ahN0AjmkD63PvVgeHmTW9R+4V623g7CKUjFoxTx/rILg6XoSPLCx7vdHPmEiblcs9+
         OXFKV7KwAzlj2DLe0CbFaW5Bl+jini2AbY9yNuUlleNQsjl8UoD/rLmNakZWu011wDRz
         38XM8LokSGsfwigtXiC7FcGwIKOc7I2XZxri8d7jzBWcGK4gC/ypzwPsIgP4XWflydYe
         RvqfloJW/9ugMzKTVIOYs+R/w5gem1fhgrJt9duQl6Q62scnAmDmH8VUXAEEpO75agNy
         j8BI4XUxTGkuy4yAazi5PoyFxyec5jlQglS9mkW6IXcVyjrruY5FmAnPRdATuGlT8Bjm
         HNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402099; x=1795006899;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fNNA5DINfFRpf2eORoYgUUVlbLJUUgtkmYcnEbAYKiY=;
        b=B/DgWqWmQmAIaQno/058eZnwVLtns+KhwhGrIuPC8mimkkl/MfCc2nI+dtqBpFLLoR
         sg47vqoYqyFkjyNVtWXM1tmRG9W7l63arBYEkHsPAmlmbVby9EyJpYiFSmKYsRYvPto+
         GRrEajZ+p+UwLXTRvbLEBNGMkm/lISoeTVEBLu5ukfo0fxdSy80JPd4cbt78sQogEWPe
         F6dAFW45xjxXOXIqa9TwlJk8VvRD8+9csz5nK575pXuq2qCUnnPo3lETFnHRY17Pt+Ow
         04wmZI2gLzDuVS5W5n/cgi6QG1KinjmCjhokuZAU/JnJLfxx+J+4Q/dgyzZZ0d/nBzT3
         6DSQ==
X-Forwarded-Encrypted: i=1; AL+hErGrr0ylce01DbHJNp2lC4o1Kszn8ylt1abuvvBl2mbvNRPg3zXzrkMinHoU7zMzeI6ud+A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6UOfVmZDneV/kcDo5n4pJrp+S/iuMBO+POGneiIex7YjQXYm1
	ZzAjBqjeoHnOGEDXSBYNywLZNsP2s68xDGtJJaV8rzdBFSSMvo3D/iqFDXLi1ysQrfvS+n5l92o
	ULnrNvygCyJtZuEEi1cTihh5bevAn7Hjg+8ojknRqwEuVaXA6Hbf6Vrg=
X-Gm-Gg: AYBFou0T6X6wSX1dUx/XUhQxxEYJfy/vQfjK4C4ddCY8A4mIgmr+jS6lsvM0lLfcwiI
	Fyvt7641i8kfUJMloI2e7TRV/QO4i0ycMhnie0xod28dG9/0ZzrgUwH8IBwteToE9Snb2gqipeQ
	7gjawW4U6jNrHwWUyZocHsRl5j0jon+T0cUwFPz5yTsQ8Kx06zBKIHGRbY+ZJ9IGJWB+idSqahq
	hmRIKTR6WO3tfFTjo2oQXtcsI58cuUIlJTdpjrB+dZT+Jiaa3zresMeI4BPUz7Z7L8y5D9b5Oii
	oK/5j8EUIPNzgUJphCU3qt/n5C1A9WyJLFu1UYfJooaZA0LlrY7cEjo89dl5N3OAwL5zV80yn6h
	2vcgWxapOQZD5GngR8eXfwbvXclY5IawPvU0G1wn/kKpBgR/ZjYDIq1qiGMYSGnLOYXbAeDq3wO
	NaYJXmazEuniqdzhQy3SVEj+1iIBxGKiotM73XUFJgCi9/X+des4pQEY+GX7EcGQ==
X-Received: by 2002:a05:6122:d12:b0:5ea:389c:520b with SMTP id 71dfb90a1353d-5ee1c3daf90mr672613e0c.8.1794402098946;
        Wed, 11 Nov 2026 05:01:38 -0800 (PST)
X-Received: by 2002:a05:6122:d12:b0:5ea:389c:520b with SMTP id 71dfb90a1353d-5ee1c3daf90mr672510e0c.8.1794402098347;
        Wed, 11 Nov 2026 05:01:38 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157b7a657sm947505e87.11.2026.11.11.05.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:01:37 -0800 (PST)
Date: Wed, 11 Nov 2026 15:01:35 +0200
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
Subject: Re: [PATCH v7 0/5] of_iommu: add support for "iommu-ranges"
Message-ID: <h7j7lyl6d67xfdw3gyabfngpurumbqd6fkcvuhyi4juashcx5r@egybwhfdaonn>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
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
In-Reply-To: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=E7tYNqdl c=1 sm=1 tr=0 ts=6af46734 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ycv8Z8E-TvjlFfbjzzEA:9 a=CjuIK1q_8ugA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: BfKMisqm79CXCckcvkIWJaMjo6Jkpe6C
X-Proofpoint-GUID: BfKMisqm79CXCckcvkIWJaMjo6Jkpe6C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX9nA1EfMRUPq9
 4W+R2+kZvmU3XNx21wP4TYgBliLIgWl9tyAFe85SUtzrQvBu7jLAc0jiEWN5KBwT+7UXszWN6g/
 fBvNraq2TIGiSIqzow0z/Zq8wgzOkogyuEOJmaXMxQLQVEZR7d7rko5Iw0A8tHpiwTvn3Oi4U9L
 bMJnKDIpgKnO5i/egqwOIlAqQpYdx8nsVpbGAPyRpU+rEV79TAxuWMaOyopt68RqifbpL50WqyI
 1GYP9ubA1BT4HQwddATyvCKIlFIBEzKJplA7uNYWZUMQud0VELDJqwnbCi58eU+mXg9huJq9+f0
 9amG9XkA1+N9hvcVcVXJ13yAhRKG8eNe4Bo2jtThGur8Yf2AqiLErnTKSgoPnwz8aQzW0uL/1s0
 3Y38gvojQCQGy9ejYT6+QhbMZtGUZMcpQXjf9MWUur89tBKUrh0N+6ko70JkfTseQLRFClaoWUf
 QSCzQMOa3JlXu310KhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MSBTYWx0ZWRfX2shmmAdPIu/C
 BqQDy5Xi1KBqKn6Z/OODjIxY7SmWeqWPvQVryvb+8lA3N2on1JZPgWIclVs3RVi4H8VT9U4j8qb
 t/igxK+iXo5Ty6AGeeT6YJK/4QJx8z0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110051

On Fri, Nov 06, 2026 at 10:44:23PM +0530, Vikash Garodia wrote:
> The series adds support for recently introduced property 
> "iommu-ranges". It adds the required checks to error out for cases 
> which are not following the schema definition.
> 
> Iommu-ranges was defined in schema with this PR
> https://github.com/devicetree-org/dt-schema/pull/207
> 
> The patch series is being posted as revision v6, since the patches 
> were initially part of the media series [1]. The patches are moved out 
> to get review comments from iommu reviewers, which was otherwise looking 
> as a media series. Happy to move this back to media series if anyone have 
> any concerns. 
> [1] 
> https://lore.kernel.org/linux-media/20260926-vpu_iommu_iova_handling-v5-0-0322ca5dc10c@oss.qualcomm.com/
> 
> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> ---

FWIW these changes are also required for the DCP display controller to
work on Qualcomm platforms...

-- 
With best wishes
Dmitry
