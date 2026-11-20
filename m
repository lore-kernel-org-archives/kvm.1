Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170974;
	b=2D84zlRF8XqaoR4yCiFIbS5bHBx5WRp+0AWZ2SHIvd4k+WTVZw+cMsbiLPB7c1giQgKI
	 NpahUOdmsNk4pLqKV/0UFa3BDkS7XPMp3B6DMLYVAXCqd3ijxpqLQwMdF0F5os/tMTG8v
	 MLvRDwAUdT24PN0A88KizqQmNdavv/GODqPrFhS8BGl+5WuUHUbG1v3bn32D8tdFq9nVg
	 yL6cheIXU6PTuqGvh7oy17E6/Qc0gOyFn4ozlZuU6OHYWCNorkcFlRJnYRIc5p208x57c
	 62aXFnn97QMFHCL85g3ayIBWglFlPNfS5g9FPb17blhrtA/a8fWzPyVdw2T+vsAGv5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170974;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pIfEubddR2pcpnMGyBUcV0RpWLk27H11lQvg0UYImfQ=;
	b=BJ70kyvDErGA3/uQYiW9my/kFSQVAc6EcKlAOGcc20XNvKRm/lEFRSyonmfyrjvkrxRn
	 F4O6winen0BAIoOIYYrNYW94sUgYSHwHV0a4caPbUZuq9f6Ggcxb0OEbJcH0481qRz0aN
	 EkmHhRekErBRCiK5kniFp1TrjuFxnXsTI4ZBoXjM19BiRU2Z2bIVIPIWLSnN732ymov7V
	 cIKywUirGJ9UNao5wpaKfLwOB809C74xdXquKSVW5JfniYI3gQgDtagcN6dBJPy2WgaBa
	 LdIHrfB+QuXGAQVm66CZwmkSe4H7QrJiT7eMLN5Zb9lKkeH/rc5ZgK9VGrea/qyXGuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RcugcrQR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YkfX+kaf;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC6E606A338
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 10:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BC6E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RcugcrQR;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YkfX+kaf
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7fDtY3320735
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 10:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pIfEubddR2pcpnMGyBUcV0RpWLk27H11lQvg0UYImfQ=; b=RcugcrQRpXJG+2cX
	u/yN0UKmUym66Avol2QZZENLLL1C1qiJKsNGUVVpxouxFhIQmcFvVY++uOB1LECj
	K4w5dJCAIb22JuWT3egj5keqXqGvDPqWI+jRISryqqF/WjlkBoCa3jlwmdy7DWHC
	c/RX4OAuwm+gAE7ip2IGZTCHMnMiUteLC9/q31gVzEoDjZsWzQp6bg7jIooQad4d
	4GT7vMoEdeaxiR/9wm+COH53gvxIYiAkTLj5NVZkWZfiMNhLOZhaIhfu8WVt/qoG
	S/SI1ZXKNM7NnLytpNT7PsNq3lSMhXRLyK5cWjcAfnfySlPMiWcHkzdHP00AaMS3
	q76F0Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2frhsb17-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 10:36:12 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-154e9d2d94fso1745318c88.0
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 02:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795170971; x=1795775771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pIfEubddR2pcpnMGyBUcV0RpWLk27H11lQvg0UYImfQ=;
        b=YkfX+kafgILz+gdzAlG573EqB+8jM0snWVYVuh17n4ySpagJaP5hq1IzsbAiXMTt2C
         c2anGgoivaDcjiRUHGwfOjJu2eWUUVOsb+lMM6EORfKyEq6kfbdP4aHnHtfBqpr1uNlW
         q/tv9L6hwrFjslzY5o0x49yuDV9GNsfPXfU+LkIqD/E9KWFOG+is2uMPEfzZBssK3RES
         Vna6HHuNU/yEztKWHHfmRxDdO/vosmS60GEiE9dt7+p5FFkbBRv+yISQpmT8ksWzEgSn
         +giqGiVfdD+wpaDVjkH3f0n3HVBPIJNZ396ae8UPAm1hj9FP47xtiPrJWK0rDlaS6p4N
         dDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170971; x=1795775771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pIfEubddR2pcpnMGyBUcV0RpWLk27H11lQvg0UYImfQ=;
        b=C4umWOVlvhRWh+IVpw+kMQ/5nfiuGO3+OQ1FLYOb7hTOdqaeuHVDXnjg8YNchR45lg
         uaaEu9Mf4OG06rt4tKvbj5BwAEQye1zEKtVMhVmf7Vg9Fp7Etb2xEUqRfnBsqKSXaUC6
         nS5cmk7b+rIO1VUR53bjXIsLap6LepFWtrZ8Ab5dCQLxsmkDNn1L7GzR3iKXz7OhjGTB
         0KWgBJEK0tZ75CbfG5Kw8VV0S3CzmhN7hKjllJfXAxDXpmc5DOzIPLb0ykRJz2CeSie5
         87Yc38CqQ4wQDrPuEcpo/ddAVehvFViIk0zWOYCylrezvhWxNCvzdfwojk5j/C5MzPFq
         TeQQ==
X-Forwarded-Encrypted: i=1; AL+hErEGU+dU1szs3r1FRymNCn7xuXc6ibMATkHC6EU+RO5qOl2FTXjILQK3VtMG4hRAk6yVoxE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/IfED5skaJYTDgAPYyHeiAY73hp6OWAh/a4YUGylrGs5Z1uvjO
	NKBi5YEpLAbTEJo6+iM4FZdws4sK7eTgjP1BsYO+rOmNRzn/JpFFJRMdAPGmycs9YnhEQqfuSB2
	g7l/PaIwV296OivtvO6Mho4JaHD3cGfYXoUDI1Ojo6ebvGdBAGl+myTk=
X-Gm-Gg: AYBFou0F5tm/sYtQbLTL9BCZ5rldfQVxJoPfiXAzYytTssKnR4wUkPf113+Z+TQmda4
	E1Mxnu+sJ9np9HAiK2EN8GoGo3ZYD5VVyGl7tn+d3RvYD/MW7iv61SJFEyDzlLQ0YpyXLCWCPsl
	KOaocVoC+xXp4mJ01OOxr70cYZhPW0TP1lXPfMLO3haOM5ECVopWah5Apyp7bSvKFim1hElYud/
	OIM/xI/e9rLUa1yBUhyVIwbNLnnwsqys+yM/WeB6aSnUjPnfFXx9SN7utuq6fwJvtfI4VskNShy
	q4DbFcCc8qpQQ02cNpmcE8dvZdK0/MTe06/gp/JM4JvQBX1Lmrvy2z4j1llz5K23rnkUlL9u1+q
	HGfiWGZal8ob9hqGyed9V8SQxWwfKEhwBLoSrJAj3GiphEQ9dqhSQ4azrTYyVUnhOm7WVoHPAxz
	9nzovAJsYp
X-Received: by 2002:a05:701b:4308:b0:1b5:1a6e:1bec with SMTP id a92af1059eb24-1b5568779e3mr2412548c88.10.1795170971355;
        Fri, 20 Nov 2026 02:36:11 -0800 (PST)
X-Received: by 2002:a05:701b:4308:b0:1b5:1a6e:1bec with SMTP id a92af1059eb24-1b5568779e3mr2412504c88.10.1795170970833;
        Fri, 20 Nov 2026 02:36:10 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm5751096c88.7.2026.11.20.02.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:36:10 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:05:15 +0530
Subject: [PATCH v8 3/4] iommu/of: Make OF_IOMMU depend on OF_ADDRESS
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
Message-Id: <20261120-add_iommu_ranges-v8-3-d90486973b73@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795170934; l=2526;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=8VtOi8S+vuKc7RA+CVg3aczf+OtltBZNKbr3XIYNYKo=;
 b=xsG659uTuS5o1iuLQ6eSuJqdRUJEN1+bgvkjt7FkqqfPKK37yn8B+cgqpCnZxWeW0JXiteD/n
 7R4lNKjGmyHA0Je7SgBkedvZqTo7tgI93FdK/lauEWxlaoswYRhPRP+
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfXwxq0GiQBa4D4
 5hE9LNlCgFZgInFGOdEMGnSYM6bnXcMPHz39qh+O6hKoLaZxpbtcVztrEEJJrdOW1U+CUsK9iOA
 83yXsNZBlWhby7n79SNY0M+h/QQZIkk=
X-Authority-Analysis: v=2.4 cv=d+9gWhjE c=1 sm=1 tr=0 ts=6b00229c cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ntQ06SF4OG-o5Uha_HkA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: MPTqbqXi9JYr5pl2OkzFL5U3SMvbHQe1
X-Proofpoint-ORIG-GUID: MPTqbqXi9JYr5pl2OkzFL5U3SMvbHQe1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MiBTYWx0ZWRfX0dNmqwha+AxM
 v07nHnhb4mXtOLhimW0jkD9DT+f1aK63T21HWVt5XQ4Dk6ABaYQW1ApOC1aSgd1mPQUEfGz5+Y3
 Zno96U5ezQy2HvXz0uyx/6u9YqOGBsW8coCfxuAqz2xue+JbIBV6YG4yciXiukArFtNtMppywH5
 WOTzr1puuvprUFg0LX8uvj8ItHlrMt2lrrksMrDsIGdGPngPV2QMZdJXsUL3KW4gG+4lEJZaGJR
 YkCrlTFm13rjHjWKXcfMBYoXuSBxXOjVpH2BA4ZuLmpoSttARWZTPmyZxROgsjgNaKS/Gs0cRz2
 VXXvDLi/6m4Bgxv//qN9FUCjJwCVLY6JLhyEVoJYZeH6rZ3IvWecu+X0bhTpQdV5kXCmVFUNCrk
 oC74MyS+Oz+gjMYnIrvg9Ro4PDO4vXMUS0Rw0bKUdrwgOUqgsmHy900HNaNJin3rkEmult6JAtq
 QGDcrsz9905vawrHfhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200042

Currently, the OF_IOMMU code is built when OF and IOMMU_API are enabled.
However, the code also uses OF address parsing helpers, which are only
available when OF_ADDRESS is enabled. Since this dependency is not
expressed in Kconfig, when OF_ADDRESS is disabled the code relies on
CONFIG_OF_ADDRESS guards and a __maybe_unused annotation to avoid
compilation issues.

The only architecture supporting OF without OF_ADDRESS is SPARC, which
does not use OF_IOMMU. Therefore, make the OF_IOMMU code depend on
OF_ADDRESS so that it is built only when the required address parsing
support is available, avoiding the CONFIG_OF_ADDRESS guards and
__maybe_unused annotation in the code. No functional change is intended.

Suggested-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
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

