Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170965;
	b=fsYP2YXsP51rVk1awIKFq0oHVD6M1xNBJDmigo1z/TufISxOFAvYr5TpnndKRtEUL0zp
	 F1OvoSJ77sBHccnBweKB0xISzQsIE8nxoTxrQGcQNVhwMH+QYjpryjlpli5aUzLTCzBNY
	 ZmSBHo/AlaHyal2dWz3+AUJwo1vcs3eoIahCla3vRkTkG3QVCwB12tKJaiIaU5QZygp6T
	 m5er8i4K6R5jD1i1jruNDTgQbqDZWkqyTazvy1chvLKYFixYVtUoCn01TLk8JGTNYzPCQ
	 aNR8ksc0xy3MNIlsEyivCWr5Ga3PghpyrFARYLte1mNKqvOddeXyiijue0J7U/qI1JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170965;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=YY/D6NwXvAt8GUNLURk0RoyGVkXYLPKr3FA7NvSrM04=;
	b=GeNMe4JdggAb6rcX+b8kA3+xSnpAefExkTSLxJ3nLEnHGorNXmDQj/3JaT/ITSFcFTm+
	 6Wq3O3vw5AMf2IP5iMEFejn9C5dsBl/yq4qdK+ZTVh5tJwM01eWhkkTDDlMfY9BXV343R
	 5JSNSE9ghHACNsRuvsMfBuD+QzkaIpuR+9EZDREC/RyVfmm5rTwdvBzHReWD8yC0jJ7Gn
	 256JBqOFCkyI7mr4DJsjNjWwEzEBf5bh3+y3ZzFtfa2X0qjqoKNHrO6xC7KAXsmEeR1f+
	 qtttckL9FDv9bVgxWzDXs573QV8dUNkfN2YGseifsWGDufRgWRNVYeXQmNiOy17uM8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h4uKSajK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R9WjRqJ4;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22563606A320
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 10:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22563606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h4uKSajK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R9WjRqJ4
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7frBL2695560
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 10:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YY/D6NwXvAt8GUNLURk0RoyGVkXYLPKr3FA7NvSrM04=; b=h4uKSajKK5dVxUFf
	JIxAtAPjf2a8Sk1VwgoXr6oWF1E7rgxFGbWDsHbolwgPQ9loa26Bwcj3UMHTC1Ou
	MdmwEHJVyune52IBCrXOUA+9xdZyjB3+dTAXrraukG1HHFhee5GMKUhbyl75rwv/
	czornfm6BbkQND6CWWP4Ae9d+uzDHRnTiFGmXQzQ/SxbV/+ck92gR6CXwU42aoJH
	wlurXDUamkqlBbPwXTN7QG5BDAPNKK8k/dkr3RmpnlulIpx8+p7WVZM1il0IeKBl
	Z2Dnlw6AqiHZU8YL94QxIY475V9vUTd/Tayuls2D36bS74pR3XgjjZrNL5B9h8si
	Y5aDOw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27au384y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 10:36:04 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-38531c1a566so1696566eec.1
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 02:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795170963; x=1795775763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YY/D6NwXvAt8GUNLURk0RoyGVkXYLPKr3FA7NvSrM04=;
        b=R9WjRqJ4QQWUeQL4yX5jyUOWIQDkm6G3uIiGearW9gr8ecGN1WZD/p8JQ6lnocq1gV
         lbYRZQr063YsKMPANGEqreoHgH9fAg6mwa1NeDtzFwZGfNpYLdNZDOMmoILp0rSCtoaX
         Yp0Uiusbg/2XCDScQQOXOTldX8b+jNUijVHlARegY7GkNqOl47G5gcG0m81MdWyIqnNU
         OJbrPgHFxRXRsxI1ixJF4GRXXTa03wZqwPU2g+HQT8DvaS0DJuXjJ8bCvjrBV9suPfNm
         gtH2NfN/HAyf2IIWiB76H6BRaMOyFuxfQDzW2hk8/r6KXwiiMhW5bySKVT3xdKk91GTT
         m8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170963; x=1795775763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YY/D6NwXvAt8GUNLURk0RoyGVkXYLPKr3FA7NvSrM04=;
        b=J/0FLW8NwrqVPdYQaxtDfUw6D0ywxUhE4fXeAj8Bsg44TWVcnJG5b9qWk3aXREuNde
         kGXPlMCV24Ypwufv+gyUQ+cubl22zq+6rM0EFGrd5M/cj+vdl2MnxFOJu95MlmFetSJq
         x+LmOJrzjDivB8djUM7gwppykh07dKmgLWjeFaSW8diN/ONnQxX6jcGpd/ScGAmTLhc8
         Z5A76xlipSz8YEzR9aiRzrZAobiKmgUJVS97vmP079QwYGmIUEzFoAc6qa2ute6G9ADc
         I2Q+pNqdw+KBqVQrO9UY0Svze1W5p0HskqoEVdRLKajgdXddCHGIGR9dq0KtS/1ub6/U
         D2Bw==
X-Forwarded-Encrypted: i=1; AL+hErEIf3XJppnSIH2d81+KlnB21A+zz4MHxCl9L+c8nOiiPM2LCjNvO8WUSx2+T+bIhiF9F1w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9b9D1kqsg9jbPaJLKNpuanYx6Vq4tn24z9+pH5ytKJ+lKwmMQu
	4ZQ9GL4A5g73+3ctTFNJPQXSKQzKLEn0PUbCJkWLJoYtNbliBqfwTQOEWtnHR45HBDQOcVUvFNd
	MJ8kvzXDi2TSQE9gIN0wrT/wQ/C0XL0vDqvm6C8jUNyiEb5yTmUHTEn4=
X-Gm-Gg: AYBFou2Agqe8i8ojbMk/hIIFtq3aGlmaqZjwB1u1Xps99YOO6Z/acCuyGcFgQf84/Ur
	4DTWgG2B2LGSmxO443nDuDbLhlXJrPRT2q54PxbwQVgFRJoBUwQsyX7Pq8o/3VorotzyYdFxrF+
	3VLdRzvMAjGmJO1YHexuH4ysd5MSGi6BKUHlx9hjw8xzFW+oOdpN6zfDY0IVBPDpVKYvXpzTUXo
	8K50gYW/kNeEd5V0k6ioDnfe7R1CNPkHTg4BUOs2XrRQ1wXUyZZfVc15SaDTU1zKgo9tWQuFcVO
	/pxcYTk9QRDh4K1HTonj+IR7CfPEH6FPKsW5Ouo+cfZMlWvQvSnP+E8CFRtat2Ig1TgMkHowXhE
	8TRKgvUnUC2qVjKtS5B363pJXRquwiqk2aVx6l9bfwk9EH095z0Y+r4YD+6HVc8U1htlcL7p4SU
	TvA2lhaAjf
X-Received: by 2002:a05:7022:4181:b0:1b0:4272:4282 with SMTP id a92af1059eb24-1b5568ba440mr3940286c88.17.1795170962923;
        Fri, 20 Nov 2026 02:36:02 -0800 (PST)
X-Received: by 2002:a05:7022:4181:b0:1b0:4272:4282 with SMTP id a92af1059eb24-1b5568ba440mr3940229c88.17.1795170962392;
        Fri, 20 Nov 2026 02:36:02 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm5751096c88.7.2026.11.20.02.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:36:02 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:05:14 +0530
Subject: [PATCH v8 2/4] iommu: Use resource_size_t for reserved region
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
Message-Id: <20261120-add_iommu_ranges-v8-2-d90486973b73@oss.qualcomm.com>
References: <20261120-add_iommu_ranges-v8-0-d90486973b73@oss.qualcomm.com>
In-Reply-To: <20261120-add_iommu_ranges-v8-0-d90486973b73@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795170934; l=7401;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=lAW81bYzUUhgYHNWMgCQPymvHpXLoor0T9PhGuMwfWc=;
 b=Qco8yvhIVGKE/Rsm7ltl1KXI+gWCZ1vE8QgCc0KLZOIIaad+e1dvDgpsf+st8GRL1OECvOF3G
 nRfsYY0CeClCxBmfzYu2/g4tblcfgkbodiEsV7YMppTP1Q5PbkrcJK4
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfXwkBLstmJMUEO
 IfRzS1+QAyKetn1Lc9EdA54eUnCmZLFmlJTWBjvZwOQRr3K4E1/9WAckKXdEVSm330aF4WQ+wYB
 9e8+WhAi08wF9XjBRBcZ3xLmArXzwjPcUeQG5kJuhq6Smhw19QTKFE/Foy9D50hmFUJyHEqQlN8
 gU9Imy9YWna0TvN49zHqNlSsqcapqn1JFy4f7nfoaUDeGjEV2u9kNjnsFHcYs463W3N+nQfFbD2
 +1QUAbJfyAcweHhuaC3sScPfOIST73AHdmOt0BWlM+MhidUUa8YCqbjRT0mqrqyHQ241swnJnIY
 ktGbd1uKahJW4aWdAZ4aojkjUdKEKKWHCdvJyEd6T6OE39C90iCV6ila8m/wSoGJG4TkXDkFN0L
 K0X1o5A8bw+joKc45nChw57gHo83feGN2mhU4PKJTtnLmkGkN9ZHxwyx8fkJIKD8+vLgCx+akRv
 Sz1EXqw6Hxqoxw5zNjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfXzAdJ1uZjqJfX
 UqyJ87ikJmePP+euhaVvGKcvDiHjAd6QRrzDQ64EMnLczCxOSTasujuWHIlIt95nKvJe7QJ96+i
 nYEGnD/0IPX8SrMiCsqitpLXwKcaWEM=
X-Proofpoint-ORIG-GUID: 1EvBx8do9eTlePe0Tfyio926MUIXoSmf
X-Proofpoint-GUID: 1EvBx8do9eTlePe0Tfyio926MUIXoSmf
X-Authority-Analysis: v=2.4 cv=KuHYSmWN c=1 sm=1 tr=0 ts=6b002294 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OYu7oO-Aqzh5uGTkRJkA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200042

On 32-bit systems with LPAE, physical addresses are 64-bit. A reserved
region can be larger than 4GiB, but its length is stored as size_t,
which is only 32-bit there. The length gets truncated.
Use resource_size_t for the length so it matches the width of
phys_addr_t and holds the full size of the region.

Fixes: 2b20cbba3390 ("iommu: iommu_alloc_resv_region")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/d223ee9f-b262-408a-a201-8b16d310bbe0@oss.qualcomm.com
Cc: stable@vger.kernel.org
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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
index 41ee4ad1dcf826cc765c6f198d487620be60281d..f9f8ef919236a28c6514609d2710b7801a67834f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3146,7 +3146,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 
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
index 8da858154949e849ef6bc1d303271883fa4762fc..4412dc39a5e87900f3a22e824a99babdcc9f695f 100644
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
index 7fde3ddf231af7fcb6571e3daeaf227552eb17bc..37c48d05c73bf9bab85ed134eac6c6998191405c 100644
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

