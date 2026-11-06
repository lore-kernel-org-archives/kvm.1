Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985332;
	b=IvFZ5Ny13JKU128L54P+Xqap/gr1zuUXbiexPu1oYFHEvRWu/HZ2qumEdXRDgTS1XC6B
	 lggOEp501tZenoGjtEoqbiwEyGPVQt1CiGxyGPxV/l20QKe+kOcJ9B180kOtEYWAvxMzE
	 fwCL2hUK7xexpsXLVZeISGTQYN+V+j5mxO5bU0D+lAkcNZDDkv+hNlRvnN640LO0hv9Cm
	 i4bnlKDzVQtfsziIzjySbz5RGj9RxrxtJcSXi0QjNpqwYACvYx7GkulhTNWEsNyrj6Yif
	 JnJdQoaaEafVE+cuOVXjoKTdpuqgtpJKYcdkkqwfDKGR3rJTqZk1p6GQICdaghTIr/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985332;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zF/sv9c+NsXmkESm0mCjV6+WOZV3eXKN1t46mzLarEY=;
	b=S1iPDEkmGm4GxYDf4TEmkwGXWLsasKMmTJ3unW5Pym/xLf/2nxNrirrZ3VtqYq6rBfvX
	 Fljv1dSRP+V7DkCRajZNA0h+j6Wl940UgUEnnX48NXiJBVbrzAf6ANGQLv++HM5Cs8bhX
	 pi0DjpnE8wpPyAMfuszx/AiKCn8qyYlZ/lu2cwKenlfmh4TMxUIubcrsFf1e9JfzqpYIu
	 sS/Ge1ZZznqHJimZfrgP9omqm/zvVb8iWw8u26VJLT9JcKpHKKOhTJWLhKJwvKv40BYSk
	 BUmJwP7GG43LjhVhKEpkN9P9NuuRKYMpXE8EOWzMQp//MJN/Yg9K3PSKTff67XoJ1gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P3vtkPAE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xhy6mpYY;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137A1606A331
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 17:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 137A1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P3vtkPAE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xhy6mpYY
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F030t102294
	for <kvm@vger.kernel.org>; Fri, 6 Nov 2026 17:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zF/sv9c+NsXmkESm0mCjV6+WOZV3eXKN1t46mzLarEY=; b=P3vtkPAEC2OU1b00
	o9yuEbq8a96oHz1CCQpEWhumD+JCXfrJVBaEIxKLCybmx//oe5RQ+4TB3R4RicYA
	x8TZSJGyfPSH1nDyG03f5E9JggRSUiS7uCxRXY7ILjVYOpxMvG4rRGUMLRaa5bP5
	UuDfaHXj9CtyeReUgmTt/+k92RDns0w8pGXjAknEiMN2jU1c9TcBu72fo9zzYHa0
	GzK/JZh+EJuGhzj/k7it8UPWJ1+AiDsiyf0DcvT3Rl8QRCcBVcoqnvnBA2awSEyR
	mzl5nimqZk+9pnEZH+xGfOExCks0/mVlm+SA7Bcirbuk6TlcOj5YWpvNTsTgUNHC
	60f7hA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa3uyq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 17:15:31 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36f479b9819so1458176eec.1
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 09:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793985330; x=1794590130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zF/sv9c+NsXmkESm0mCjV6+WOZV3eXKN1t46mzLarEY=;
        b=Xhy6mpYYH+FaV0vtIaet0pNDRikfJtbPr3n7+QvJHvxrEkGscfVKGVT9i+0iMeTZii
         eU/qTs7DtHPn0igoyprHP1e4e8Fwtwf/r69jOFHmRODxGKSlLTsWD0g4IW0FxYwZ97VQ
         E49P4oEG0RJho/jRZuP/tgOoFFE+7v95aH19AlpI3/BNSiV2oXop7htxwvUF7aZhLW5c
         LmkCRVShGVzrJi1ez7GmRR9G+6a5QMu2CQ7XS4hCUewk/3aKEmrYm+LWy2B5UonhwQAn
         3F+9CVAhloyYTZYkpcZrlbLxhMrJO6VzzBlfjJgqU0yvbLKmDmet1pas9Io/qF0YEGDI
         Rm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985330; x=1794590130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zF/sv9c+NsXmkESm0mCjV6+WOZV3eXKN1t46mzLarEY=;
        b=VIfdqjlDsc2mgVNNjtWwDLMcD/ep5z/GUTLn/zjUtefGJ6XsdnMRzjJfmnA5eq6rDd
         lvYTuawwi55dubvqH1gexvJpAxtEos918HaFEwlJ3trYtl0BvyKqXvBVvUkjmG3jlY7C
         9cUi8I97nDc1/i9QekYHPbWshaF/eaQA6dhxo2kdxGe+DzR9Aw526TDiS3bQPpIN/n3m
         1R9WkSNHL8b0B4pZekqH3i9E0eNMufa1axyh9pHDA9u02dJ7G5++YqXEcmKQenFakBug
         AzGyi41qubk9+hG3yKr/+1EFqSSscYd19TXxg8mgEYuSq/wfNdOKnFfuL9FPc6JaY/4X
         CZzw==
X-Forwarded-Encrypted: i=1; AL+hErGnpKnIzAV/iddSOCBhZwEaWBj1DvTcQaaCY5a+OwLA6wNaG2F2bPQ2yLQhYEQ5PbuVbW0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+iAfwS8PtKXHxq16YV5exxhgOvhmPfnA4jkaIjx2Fsf/rMHurS
	APdnkgQgx/glDK4WBoEyP0J6U4R5ORWTsymxLRMoJCm3jN2DtpmxjQFsjdPro93ThDdm0R3zVhn
	Fd6n0OYtRphF7EWMFkTlB9WeQrz70GmuYmNOOrZ+yHQQtOSj3NKfWgUc=
X-Gm-Gg: AYBFou0idDCkncphbOjrlP2Zd8O2zPc7Z4ZrWgjoT35SPAuvNkLkw+5zuK8hZRtZn+R
	3K+wXbTWNrbi7kiyG3yeWAYK67gaCEiksRFCcrD4keSZnNPl0u4QWxnJxwTABLPrjODqndWYLdp
	b4rH2IFPPiu72AbUO8GxKPrJ26Lqy6/mOfgeJ1gQLVQ2S8AESSKCJ6YYwXfVaH7xTMfviCUKMN3
	5um7kHsX107NXOmY4P7T/sNZTZFE7aP9jhjglUNpfRypjL40u1im+lo2UsB4SbZtZSWbvSAo3qo
	n2nL8GjvJJQsOMw5SDy2DJkYkJ/iP7ZpMQnYgpqhBGkRdFIzamvwHa31XqLa6F5iAIiiHHJPgVQ
	5bHbX9bEtc+aGVD9eXVB0AICVJjlU06qpHzF9wJlj9nblcbt6l+Crgbz24np+Cnbx2jSfrmxaCD
	6p+4K1nG7H
X-Received: by 2002:a05:693c:80c1:b0:36a:1732:1e7 with SMTP id 5a478bee46e88-36f76d0f26emr4000270eec.31.1793985330022;
        Fri, 06 Nov 2026 09:15:30 -0800 (PST)
X-Received: by 2002:a05:693c:80c1:b0:36a:1732:1e7 with SMTP id 5a478bee46e88-36f76d0f26emr4000223eec.31.1793985329467;
        Fri, 06 Nov 2026 09:15:29 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm14693756eec.15.2026.11.06.09.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:15:29 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 22:44:26 +0530
Subject: [PATCH v7 3/5] iommu/of: Make OF_IOMMU depend on OF_ADDRESS
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-add_iommu_ranges-v7-3-5c0f72083e52@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
In-Reply-To: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
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
        Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, devicetree@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793985294; l=2273;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=NupkmvlL/dCPtTaOqaRQsl8ArnjGwSn52BAlgLqDvzE=;
 b=zmYLfThWfIv3sYXwDsJ6RflfKmCfmALOpmNPBUN8TCisKPeZCWDqMJUW2XSqMOPFsQD3BtSCT
 o8PihuvJzOpAYMe5W/ppgKgNz7pZ2PFLD8vYjYsYkLQ8uPypf6/trFV
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfXyMfMmB91ckZl
 TS2vLjN/u2M38qcdoNyFsn255JtGy2bXYn4mM22mUbbavIB9170Uzas9JFEX1lDLeZsup8et0XJ
 DcP92BZg4xm/uOCT+C+aAc5C4FaErKDcHo+fm22BdfYjgvw6BGYbDeN2cySo2pRtCsm3rcGETyU
 o020qRc5nYvDfuklfTEiiw6ohHalEW3J75NPjkGXcxFuuX2Ypub+gAn8COn19f3obodgRW8ZvuM
 KmUOoZhp+eeyLd43XIF+2vvGklIYbkwIppP0jKZzqGc65boWW+wGuW/t6ZhG+h6BpMdFt/K7yS2
 2GeXgfoWbVI6lPsgmIKB4zzT7SJl/ls6HNCabdKbunjQevni/gw/txmCoyCxQ4lvu3ObysXSXW0
 rmFI2q54AyyGNkAcQdCO+aqTFMTJR2PY45f3kBMd0P2f9N/1SCWy352KTo9k1FSVofBMJEm2yo1
 Up0+sAkK4AvFJ1DVF9w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfXwVycCVDHeDgq
 BKMeHIwoG8JiZh1hDTFpX7PstyKdVJTeSuYG0Vvd3642+ibpDfjpxRuHqAiuESV9nTfhtXe4Ct0
 GZbHvt886g512z5DcgRZIJ8WOyfBjqk=
X-Proofpoint-ORIG-GUID: 8HNY1A_fEjABi8z8pZfI1bc-xhQKVd-o
X-Authority-Analysis: v=2.4 cv=GpzXaU1C c=1 sm=1 tr=0 ts=6aee0b33 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fdurNWXONF6VWYIYtoQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 8HNY1A_fEjABi8z8pZfI1bc-xhQKVd-o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060068

The OF_IOMMU code relies on OF address parsing helpers, but the
dependency on OF_ADDRESS is not expressed in Kconfig. As a result,
of_iommu.c contains CONFIG_OF_ADDRESS guards and a __maybe_unused
annotation to handle configurations where OF_ADDRESS is disabled.

Make OF_IOMMU depend on OF_ADDRESS and remove the now unnecessary
preprocessor guards and __maybe_unused annotation.

The only architecture supporting OF without OF_ADDRESS is SPARC, which
does not use OF_IOMMU, so no functional change is intended.

Suggested-by: Rob Herring <robh@kernel.org>
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/Kconfig    | 2 +-
 drivers/iommu/of_iommu.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 85a8d7fdfa30b64e21b8db0db1d5bc268c04f24b..c1e97bd885f933cae45fb7806183477f2d64cd5d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -147,7 +147,7 @@ endchoice
 
 config OF_IOMMU
 	def_bool y
-	depends on OF && IOMMU_API
+	depends on OF_ADDRESS && IOMMU_API
 
 # IOMMU-agnostic DMA-mapping layer
 config IOMMU_DMA
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 5c266511db78910d6fd221af5437cecff4931c22..6675fc900e6c2d55b34c61dc9effaeb48e24f18f 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -167,7 +167,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 	return err;
 }
 
-static enum iommu_resv_type __maybe_unused
+static enum iommu_resv_type
 iommu_resv_region_get_type(struct device *dev,
 			   struct resource *phys,
 			   phys_addr_t start, resource_size_t length)
@@ -203,7 +203,6 @@ iommu_resv_region_get_type(struct device *dev,
  */
 void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
-#if IS_ENABLED(CONFIG_OF_ADDRESS)
 	struct of_phandle_iterator it;
 	int err;
 
@@ -265,6 +264,5 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 			}
 		}
 	}
-#endif
 }
 EXPORT_SYMBOL(of_iommu_get_resv_regions);

-- 
2.34.1

