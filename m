Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0562939EF0A
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787050795; cv=none; b=jjKunkKFVO+AmdVqILQxPeMkhAj28O7rE4wgY9Kee8j2JOcP0v0Ho9bOQtjaqtDqzWlt2ofVL9GKTFZcZtB+rWjJ7aVMK+qIM4FUlFG5poqqjnNuVGwHseeaffYldNUT58FCIWADqL8wFDGhwL27tWM396cz264WS29FwyU8x60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787050795; c=relaxed/simple;
	bh=qQpo4F8E8YM6JVnq7O1ZYj6VyTUk3b19py9kDJeWMKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7viOdDQd+fHu97+VsqVwRXLuIarPSIFqIPPiWSje6bwpFu9S0WkGLFx6Rj6AplzreE7WAxFhtxSDXyFAD/41I1iyFUPK8Is4KGwac7+LuksNuFKxmEOWVYmTj0hdvpUyAm8lAKWHHxfhJwn2iPfKV1rKT80kS4h6+HJhte47mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J60TawLL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LZL2R+vy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J60TawLL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LZL2R+vy"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABU0Y1021530
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 10:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=97oyElD7Ik9opXwUE5qADXHh
	NFeKHDDf3nqCTfRJei4=; b=J60TawLLIuSg8NbfgtjwGsJfjgui/RptVu344kDD
	llEnlZc99ED1Odhs98GrZXdsPCRnQXysN50fi6sV9C+tdTfr8EeVCR0vmQoGfl5v
	ttGcLdBFc4b3bHstiQfuRnCKqD2HG/GF+oDwusUL8IyyGkBDLRsTpgqntLKj32Zq
	Ckl0AG/gfe6B9jxGHt+3vo34GRPskctLjTG1igjzEgrAhaEjaaky361TJZsdtzzm
	/kvE5xvcEwWkGGhW0oSDiAEl0ncmwLymcCCFDMV8+6Nhdjl5Ubp2v9+4G5iLCxA8
	s2WM+NId3pst9+pYQVSHe6uLWZNX/muG//QOMJel0lrPDQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g48q0uadc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 10:59:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e82060977so100518185a.1
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 03:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787050792; x=1787655592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=97oyElD7Ik9opXwUE5qADXHhNFeKHDDf3nqCTfRJei4=;
        b=LZL2R+vyrZwKue7MtvdywyjlLbByGV5fX8opgQmgyezj6EEMurEcVxun5VvCqJWWa6
         qeXquKpnfVB6Y0r2WsS2ZCBp8UzchIK8y9GZru1d6lRmfF+5AaZTyhXcGsHXy2vEsrxQ
         UBAF1iNzpAh7rkvFDL9PLRQzTkZ5LbJOXI4WHpivvy3oBpC28UEI4epCZT5tkMFl1A1V
         0Gg4AwtTjriDjMNt5J8rWd+TztjDnUtZnFbK7nlG9fMaG9dMmZZ9RlizmYJ52IE9YPv6
         PKEujSQ4e2ThoOhLpKm1VV3yri9WbwshoblAId1XJh993wMa1IT0wuhXSUXdkbp8HL6F
         weEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787050792; x=1787655592;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=97oyElD7Ik9opXwUE5qADXHhNFeKHDDf3nqCTfRJei4=;
        b=aJNTQ+no0BcFo+40xqkoOyyQMl5qMKT8sVy2daJTvOhegeXz4mhZD6W2f4C8KpSsVP
         HAAlwPl6/0znpcH/zK9xRQgazcBAJzgDbrw4XRAXHUs7cOnxDVeMCb0vocztguryVwLP
         8oh2Kg0d4hh1ruC1FgL6I+oZXVV1c3lNlVytRpyqbjZFZDp5PxCvzP/xrCnloErL3OAX
         vkm98Y/9jDnPJMJ3suFBmXQtopvf3dl57QTsHzOpFuj4KEjbLMeZuPZN7+0daB8CqWyC
         mxSygvgw5rC8fQlUful5uluMZFdPQpxR++0CXFs0HqOu2uY3hbdXt+FsBDaw+WnysHWV
         gqyA==
X-Forwarded-Encrypted: i=1; AHgh+Rrx2clzkbtMzZqrwwSQflxYY06LBFu+gvhTedjTMquOvvl/jJbQg5dzDnPI6S8WuvVu0/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwemtKFjTk7oDOtGgFk6oQzP0AoyUZ8+dNCLa6pJesB2HaelFR3
	BHcz/VVZHpTthe095zLWCNwfF1rQTxJrBTLcKOSS6nmIZM0PcBSVyHh7aLdsUAg1IgAfaCHqowx
	U8iNTrbfdnD/UjE49cIlghucbwHPfo4obk/4nchOJKNHQghpmyy05Qfo=
X-Gm-Gg: AR+sD10QGo77f5+9eK/xbLRzknMXvs2Qns88coobaO4wQ9ABNVyhTsf+Q3h2/lj2g0x
	Ww7JsduqBf1krscSJPlVAoEhe7dLF6MUTcVp5hROEBZEcttvwtNqaWiu9y7KSS6jkmNZediHTCr
	kQPETHqKAQRvwa3YF+lGpxfVQziOwnKXBS06jBYqk03DSlyHeLPYRI9F6GqLyGC5+Pmr/CW1hsT
	4Atp2aLmCO3AIVDFML3MHujAbqnqT+f43aE0kx6ekb5xYt3HBPdoeSu9XmmBNOonVs1GBn8WWyZ
	bZixATuXuDmOgZFLm/YLfMb2hwxzOwX8aiWUTjcIEoLu1RIuErWWOQoSZLl4rbt5vKvERXstX1N
	xC3ZW9ysvIzEueTW8zUJ01H0sOQNtYfmwUfw=
X-Received: by 2002:a05:620a:280e:b0:936:a8a0:cdf0 with SMTP id af79cd13be357-9370662ee48mr557156285a.15.1787050792139;
        Tue, 18 Aug 2026 03:59:52 -0700 (PDT)
X-Received: by 2002:a05:620a:280e:b0:936:a8a0:cdf0 with SMTP id af79cd13be357-9370662ee48mr557152885a.15.1787050791724;
        Tue, 18 Aug 2026 03:59:51 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b783basm11499220f8f.30.2026.08.18.03.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:59:50 -0700 (PDT)
Date: Tue, 18 Aug 2026 12:59:49 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        tjeznach@rivosinc.com, jgg@ziepe.ca, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
        atish.patra@linux.dev, skhawaja@google.com, jgg@nvidia.com,
        guoren@kernel.org, kvm@vger.kernel.org, iommu@lists.linux.dev,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zong Li <zong.li@sifive.com>
Subject: Re: [RFC PATCH v2 05/10] iommu/riscv: support GSCID and GVMA
 invalidation command
Message-ID: <4mcwrlk7yc4kozsqbrumf5gbknydquzwdb4g7lv6bgjk7m6ob2@alld2yusipnq>
References: <20260507113706.11400-1-fangyu.yu@linux.alibaba.com>
 <20260507113706.11400-6-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507113706.11400-6-fangyu.yu@linux.alibaba.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4MCBTYWx0ZWRfX1mBz7iRZAGmq
 HCmYnLXI0dRiMlWKXvKAHvGIfpDs6MC5C3WJK1UKhjiRjCuTT1Cm+ufe4BAKMC74MdlzrhvkFjy
 yzMGZO5MwccHJkNderbsEFXOA6fOcTI=
X-Authority-Analysis: v=2.4 cv=VuITxe2n c=1 sm=1 tr=0 ts=6a843b28 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=SRrdq9N9AAAA:8 a=VdMlnMEb94GnahmMsAwA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: EYN_aUjkXFIOx8etTtD0I31oiB9K1j4H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4MCBTYWx0ZWRfXxIowh2l5422x
 THHrKq/p5gsQybq+mU9AyLGVCljJAgdTFkAsJKScqn46OISH8RvmaE0PYcb9xc7KfdAlULQ4q/N
 YC+qZTD3LmLL8i8k27korOBm2hUBIR/7+kKZYZNiq9uMDY/+edoSwvVUQmVzIaqZ50fd01yioRK
 /oscCyEFaWPfhxz0XhNR1Hj/yzhNNm2jYcRphiWZ6puwU9+9Le8dIE9WWTh+KISk74Rd6yiTW60
 ihXK4CDZ6SEYRZXS+FccFeft+2myg4mvDGIjuyrmsUQD1WhtCqeT+ez9RFOrI8+sk3IJLEDcRqI
 kPcVCfo9tXksThvv1/inXFbzu6qFX/k/YtIXxvCU+SJufbj0ufNiYlQVf7MPy7U+w0EbV/lswsD
 p7Jsx061kVmTdBIsAqS9JeRVmCpkinhazZXl9Z9NLg5RaW1jn5mGOZAvEOVxfujZoZgFg0tyNzH
 CVOsWBWNR8eccWnTfnw==
X-Proofpoint-ORIG-GUID: EYN_aUjkXFIOx8etTtD0I31oiB9K1j4H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180080

On Thu, May 07, 2026 at 07:37:01PM +0800, fangyu.yu@linux.alibaba.com wrote:
> @@ -1212,8 +1225,15 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>  	if (!riscv_iommu_pt_supported(iommu, pt_info.fsc_iosatp_mode))
>  		return -ENODEV;

This needs something like the below diff squashed in.

Thanks,
drew

>  
> -	dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
> -	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
> +	if (domain->gscid) {
> +		dc.iohgatp = FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
> +			     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
> +			     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, pt_info.ppn);
> +	} else {
> +		dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
> +		      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
> +	}
> +
>  	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
>  	     RISCV_IOMMU_PC_TA_V;
>

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 307baf33c646..434d2d4f26f5 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1262,9 +1262,9 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 	kfree(domain);
 }
 
-static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu, int pgd_mode)
+static bool riscv_iommu_fsc_supported(struct riscv_iommu_device *iommu, int mode)
 {
-	switch (pgd_mode) {
+	switch (mode) {
 	case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
 		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39;
 
@@ -1277,6 +1277,21 @@ static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu, int pgd_m
 	return false;
 }
 
+static bool riscv_iommu_iohgatp_supported(struct riscv_iommu_device *iommu, int mode)
+{
+	switch (mode) {
+	case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
+		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39X4;
+
+	case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
+		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48X4;
+
+	case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
+		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57X4;
+	}
+	return false;
+}
+
 static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 					    struct device *dev,
 					    struct iommu_domain *old)
@@ -1294,14 +1309,17 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 
 	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
 
-	if (!riscv_iommu_pt_supported(iommu, pt_info.fsc_iosatp_mode))
-		return -ENODEV;
-
 	if (domain->gscid) {
+		if (!riscv_iommu_iohgatp_supported(iommu, pt_info.iohgatp_mode))
+			return -ENODEV;
+
 		dc.iohgatp = FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
 			     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
 			     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, pt_info.ppn);
 	} else {
+		if (!riscv_iommu_fsc_supported(iommu, pt_info.fsc_iosatp_mode))
+			return -ENODEV;
+
 		dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
 			 FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
 	}
