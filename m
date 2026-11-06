Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985325;
	b=1kelfFaYruYx//gmNm7gfL49OoC3n8uwox8rOxRtFqwyIg/mWkdKr13AMREqL/993Ova
	 lG0cr5m/+U0JVx2lmvfpAsjdlBahnn4sTnEmgTkWqvCg5Au0CsB+W/cmfxnXuQudmMMNv
	 vOta2yMhKJZun5GQkyS+tbXimNABwg+MigcmOzKLaMsMu/QTVVF6DEV3dietFy7zaFLk6
	 tdpQhioY+sHlJV/j81h6DW+bX3d7f/3werwGqItiJ17ZHyj6vnHrupB2/LrIHLoB+zPuP
	 pR/qVL21B4niI6Kb5oCKvloxf4XhdIN95eypfsyLcb4GtUyGktSzsLzQhihVgvhyDGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985325;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QIXG4hC3yAJsmesG5E8c3J8k1seOlbSXEBkKniP6NFk=;
	b=u7uj+MCP+Nf8sQUE5Go/LTWGXocl4/Juey6go9gToww8pDOGpO1Ly3BTWjkS09xQTcVH
	 hP1orcSw21U/hbWdttdW0tmUWpam5hGd/J0mXbrMSgeUzPVa2iqHJrrmnvZfsQbi7tfQP
	 7pxhoevDu4jqsgFLMYsrKmR4HKr/ixw5WObvZTZY8E9sqejabyWpU0AcwYU8WSlJ6VkM5
	 wvlQdEwOLma0oqTL4lj8XB2KmJXvoI2RdZ7eEvlG9OUS8HbAjL5IwcJ/wpMO6kuqFZ6E8
	 aO79YOJ/EFr3UsVRuhEfWuT2lw7yfiZTgBRYq0o6PxyCb3JVvs42KtfzfuDvrLFRDqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CWp3lA3Z;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZUaY7i0I;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49AC606A33F
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 17:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D49AC606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CWp3lA3Z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZUaY7i0I
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6HDSaf383184
	for <kvm@vger.kernel.org>; Fri, 6 Nov 2026 17:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QIXG4hC3yAJsmesG5E8c3J8k1seOlbSXEBkKniP6NFk=; b=CWp3lA3ZBUkp7Fol
	KBi1z85YbvC4Ff4EFM48+Xn7Eqdk9aEcyUzQ406xTDaux23vDyYkIz9jEPk0lJ5P
	rPBzMh/seGrgl5g/hIvVahi1yVqaEtvgeKZtxoIufjZahTCVsoxYE6C/Jqk3kf6s
	hwq7mJmRGNkliz3jREdoBRzAzZB62Gqr8L0ZKybwMSVYk7rYMUQdjBR856l3/qVK
	m1EgHrXjSJc5RNx4Basgl7U/GdAgv8OOnHUpjq2/ZxZh/h5wxKWcAHbn3HuIymHi
	1EdQ/D5TOfahmjntC+L1j+Csi+VS0Njjsbn/jbZozEPqs87nw0hibGDoMvLR2sA0
	NzLASw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsk3wg0ae-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 17:15:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36a3451ea93so1268090eec.1
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 09:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793985323; x=1794590123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QIXG4hC3yAJsmesG5E8c3J8k1seOlbSXEBkKniP6NFk=;
        b=ZUaY7i0I3yQpXGP9Ty8PsHJxTMq3kbf4feyznEGpqEiuDMyGq9fSAOtTNCXTzbxkom
         EQwsBwMYkbYbceaxVvcWeP+/BZ3Q5jNhZyO18up617uRkWmrYWS1Kp6UM2UtXJA6dUVh
         lMNhm80iBnsGcK+XLgqox4YYms1JlGFcAjrPxLDkPZc3cfcBTFXngbHC65RYXSnVG9N+
         2xgEZQUJlwwJQdefkRhIBTjHO22iDfeXegPztdq1B8phoCFfchUBk6l3da/jwClderEo
         VZrc8TNaNy6PYUaiwssCq5fkyakU/m+EDQ+uDTjaf9QW9Wm/qppJSYq61qeNqvgZpg6o
         byGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985323; x=1794590123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QIXG4hC3yAJsmesG5E8c3J8k1seOlbSXEBkKniP6NFk=;
        b=oYmPf6Getriz4fU7mLmtNJR+YZkyrfnqW2/LZ5OUsCfNGGfJ0O+DMDlY0i2xhuPcza
         IywUNtVVOIQt8kf1VCFtDKzSBO3c1ky1HQFLMoJQm1RoxH/eM1qwRxU16JnwUr5auR09
         7FjGE6exD2bKhIFmI4tqcqfpfdZq67a/ehB7rNs8SXKhShanIL27yNIObYVnm0e9fr/z
         1WysJZRkNE/MHi9qmaXLlNiHhDfz04VRERPAl51ECcplLZa0/1K8JYw238AekdFDqLR+
         GtSG8dnrP1p5LgZR5vMiJdrm3qSEdx9rm7/x6S8ksgjeohrbBGMbqm13FfTLTYOrgUqu
         hiTQ==
X-Forwarded-Encrypted: i=1; AL+hErEoMxU6MdDheXYMwtR8IEBAnD9Xqbv0Lkh9bHkTGLzkwJwOO+yYoyd+e4RIOiSFjEwIywc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rBcYI/zvIuR6Pi5PUji7+vRbs2/ub5sQ6//L2MLYV0/1cPhsI
	l+jU651gubImExo3qM87siXG8ArptsU+O9Aomh2hBD1hdnvO8IZs5imov0w46m07tpfrExoWDzO
	xicnO5O+mEtAX0oMdQD+EfhLfnb0CABewlWdlVgLmj07yN5+zatSUP8A=
X-Gm-Gg: AYBFou2zPxV2YuUV6SOllxWADDJaPmAl9k7YtAF+/2yUXbHZqB1HPxR23UC7FrEcKz0
	P6yFZsSR5rPY80flJ8JGEmCBeyXUFfrq2vBPDts86m1pZrneLOq9paNaccmMpSHGf7xcuyazrEu
	nLBNIu/aLbsgPcT0Um4f+xMxm3oJWpT4j4RQlRHS1pJ4SvA5TMc9GtW2qiPew/WfV1i7JnD2QKy
	30elOWwH9InsFBkzdHYQDvL234dBkKvhlLEqdl5bDxUOGg01yA2KO2YaJpjOZ2JgOyvbuAcNRB/
	2LjR5W4xlUX2u6ceEPoCk2gozSFWa2W+Qqxcyxzh4IBp/8DeIyeGex0z3+ZXUEU4gR8E3bqKeA1
	FviVk8lZ1MBRB39VuTKyOiZ9Zr0SeUvrkddjC4akV52AwNJSziSvnLr/mGYDDU2DxKipA6IN3DT
	tG958+8e9H
X-Received: by 2002:a05:693c:600a:b0:36a:3186:b712 with SMTP id 5a478bee46e88-36f76023b26mr3971968eec.20.1793985321847;
        Fri, 06 Nov 2026 09:15:21 -0800 (PST)
X-Received: by 2002:a05:693c:600a:b0:36a:3186:b712 with SMTP id 5a478bee46e88-36f76023b26mr3971885eec.20.1793985320950;
        Fri, 06 Nov 2026 09:15:20 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa9aea75fsm14693756eec.15.2026.11.06.09.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:15:20 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 22:44:25 +0530
Subject: [PATCH v7 2/5] iommu: Use resource_size_t for reserved region
 length
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
Message-Id: <20261106-add_iommu_ranges-v7-2-5c0f72083e52@oss.qualcomm.com>
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
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793985294; l=7235;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=llMLpfQId9UaG2rP5mXxqKjE8GpDMlcPgKGb0UPmgHI=;
 b=xOQtRH8sZwd0gtSU2fFskz28Dk4hc+HSvL1AZEsMm+mQ6tli2NY766/rhiLsr2TyCT8PTBDrr
 OAMPQHcGFXHDLPeeE1jhZGBbjPHAf+2djrReXZOQxJ/wO2HIwXTG48h
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: 8DFHS1U1-VlE97PXML4U3RjUskcIdPDG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX6MTc0+ftahwh
 ES6EZ82B8I/4aTemvPnpRj3JkzuhchLpcmhfCzbym+BqQUZaMEVQOhKzWS2MIRaYg7rl7amSuZu
 K9nh35TacNrvdQD6qEWIJhAgvNRpIRzG2suu/ViGAbt9yQyq2crFherhNpJ/EkWxI9tpzZttaIJ
 gTLh2OEWbpXERTu4BkNm4Q6iHmlgq2Gzm37sDciCxKApqa95OWhzIPmKGFxefLmjf8NLOlsCEpi
 muKmKgkqsJ8qAJjmmNqWu9QAR5vnZO3SrD5jOwh+z+52EYKN4DTDoObZxyQ1YqqcSmzC7rNTyZ/
 +1zd508H2VnYanbKSzaxfi8moBEIh6qNzUwiDX0oibMTcwAbg9qloqDCsqkrmeSDJP7JugWJFgS
 i1lZoq6ppSvZ3HfvBalnnSI6Q7jtoIyuctkAJOCQw5AXyAHQ6zcdv/YlEt8wcOd0M0V9pnlkfN3
 MZLT8ZifSHjKEc+yArw==
X-Authority-Analysis: v=2.4 cv=a6OlZkSF c=1 sm=1 tr=0 ts=6aee0b2b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ljjM-8V9AhcL1OkpCucA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX0UFowdijj9aN
 Icd+XmpWhYbCK8OUFLD1hn+30tjQaERXqH6QCtA/ZDTeyjvZBN+xnkRMbHiupQ2AOFAgC0tgJIp
 9bV9PtB4uTKcJCKA3vjxNRJl+015vFI=
X-Proofpoint-GUID: 8DFHS1U1-VlE97PXML4U3RjUskcIdPDG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060068

On 32-bit systems with LPAE, physical addresses are 64-bit. A reserved
region can be larger than 4GiB, but its length is stored as size_t,
which is only 32-bit there. The length gets truncated.
Use resource_size_t for the length so it matches the width of
phys_addr_t and holds the full size of the region.

Fixes: 2b20cbba3390 ("iommu: iommu_alloc_resv_region")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/d223ee9f-b262-408a-a201-8b16d310bbe0@oss.qualcomm.com
Cc: stable@vger.kernel.org
Co-developed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/iommu/amd/iommu.c       | 2 +-
 drivers/iommu/intel/iommu.c     | 2 +-
 drivers/iommu/iommu.c           | 2 +-
 drivers/iommu/of_iommu.c        | 4 ++--
 drivers/iommu/virtio-iommu.c    | 2 +-
 drivers/of/address.c            | 2 +-
 drivers/vfio/vfio_iommu_type1.c | 2 +-
 include/linux/iommu.h           | 4 ++--
 include/linux/of_address.h      | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 960e1dc05ec69b346d1af73241dfa51393b0851a..179e6c28afe6f86c233d9d7e64abb0870095e985 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3327,7 +3327,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 
 	list_for_each_entry(entry, &pci_seg->unity_map, list) {
 		int type, prot = 0;
-		size_t length;
+		resource_size_t length;
 
 		if (devid < entry->devid_start || devid > entry->devid_end)
 			continue;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5a2e705a2f2e025245d4b42c4a9f765c67d708d4..70e210ca085ff52519376358a3e3b7a01619d7a8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3535,7 +3535,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
 					  i, i_dev) {
 			struct iommu_resv_region *resv;
 			enum iommu_resv_type type;
-			size_t length;
+			resource_size_t length;
 
 			if (i_dev != device &&
 			    !is_downstream_to_pci_bridge(device, i_dev))
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b486b8bbd1fcdc359d936234bb3f8631306c8786..18f3efb94043ace9f1f4abc7c6ac8974dc25b0c0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3010,7 +3010,7 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
 EXPORT_SYMBOL(iommu_put_resv_regions);
 
 struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
-						  size_t length, int prot,
+						  resource_size_t length, int prot,
 						  enum iommu_resv_type type,
 						  gfp_t gfp)
 {
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a18bb60f6f3dfdba853b6e16dd2a8616f6a731c7..5c266511db78910d6fd221af5437cecff4931c22 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -170,7 +170,7 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 static enum iommu_resv_type __maybe_unused
 iommu_resv_region_get_type(struct device *dev,
 			   struct resource *phys,
-			   phys_addr_t start, size_t length)
+			   phys_addr_t start, resource_size_t length)
 {
 	phys_addr_t end = start + length - 1;
 
@@ -246,7 +246,7 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				struct iommu_resv_region *region;
 				enum iommu_resv_type type;
 				phys_addr_t iova;
-				size_t length;
+				resource_size_t length;
 
 				if (of_dma_is_coherent(dev->of_node))
 					prot |= IOMMU_CACHE;
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc13197f12227e69aedbc721cfd49cebde2ef..a37e713b0678a516a777436d616f0d3df54eae38 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -483,7 +483,7 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 			       struct virtio_iommu_probe_resv_mem *mem,
 			       size_t len)
 {
-	size_t size;
+	resource_size_t size;
 	u64 start64, end64;
 	phys_addr_t start, end;
 	struct iommu_resv_region *region = NULL, *next;
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 499d37ceae210ac844eef853aeecbfabaaa5e138..f665432638a6d1cc1ebfc0d2356b813c8c584910 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -655,7 +655,7 @@ EXPORT_SYMBOL(of_translate_dma_address);
  * Returns a pointer to the cell immediately following the translated DMA region.
  */
 const __be32 *of_translate_dma_region(struct device_node *dev, const __be32 *prop,
-				      phys_addr_t *start, size_t *length)
+				      phys_addr_t *start, resource_size_t *length)
 {
 	struct device_node *parent __free(device_node) = __of_get_dma_parent(dev);
 	u64 address, size;
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index f7addfbe1aab4f6fb662b8b2fa66bc02d98b5f03..9f508143505ad9e603af1730e811c30bd5edce16 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -164,7 +164,7 @@ vfio_iommu_find_iommu_group(struct vfio_iommu *iommu,
  */
 
 static struct vfio_dma *vfio_find_dma(struct vfio_iommu *iommu,
-				      dma_addr_t start, size_t size)
+				      dma_addr_t start, resource_size_t size)
 {
 	struct rb_node *node = iommu->dma_list.rb_node;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ef5043752a3651419679316c5a20cdf049efeaba..1d8f9381a358ec2309503bfe2866f08a1f236b2b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -306,7 +306,7 @@ enum iommu_resv_type {
 struct iommu_resv_region {
 	struct list_head	list;
 	phys_addr_t		start;
-	size_t			length;
+	resource_size_t		length;
 	int			prot;
 	enum iommu_resv_type	type;
 	void (*free)(struct device *dev, struct iommu_resv_region *region);
@@ -968,7 +968,7 @@ extern void iommu_set_default_passthrough(bool cmd_line);
 extern void iommu_set_default_translated(bool cmd_line);
 extern bool iommu_default_passthrough(void);
 extern struct iommu_resv_region *
-iommu_alloc_resv_region(phys_addr_t start, size_t length, int prot,
+iommu_alloc_resv_region(phys_addr_t start, resource_size_t length, int prot,
 			enum iommu_resv_type type, gfp_t gfp);
 extern int iommu_get_group_resv_regions(struct iommu_group *group,
 					struct list_head *head);
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 0cff9036539168b0cf2826ee34417738a4836ace..ae6d96c8c110adad966f2c1bad2cbefaf55e5c57 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -56,7 +56,7 @@ static inline int of_range_count(const struct of_range_parser *parser)
 extern u64 of_translate_dma_address(struct device_node *dev,
 				    const __be32 *in_addr);
 extern const __be32 *of_translate_dma_region(struct device_node *dev, const __be32 *addr,
-					     phys_addr_t *start, size_t *length);
+					     phys_addr_t *start, resource_size_t *length);
 
 #ifdef CONFIG_OF_ADDRESS
 extern u64 of_translate_address(struct device_node *np, const __be32 *addr);

-- 
2.34.1

