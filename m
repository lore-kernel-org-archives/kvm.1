Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35CC4D09F5
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606303; cv=none; b=lP/NnZUaUv+l0UoH2PyV+dVC6L/fkyJxMCozKYGKcFfvkclunh4WxhBHmOCdF+BM288MZCQuPaO+ThNSFfLOS1IiI7p0Z8h5aUZSvFSqk7YYvdjwss+G3ofVc6WpQKBI2e/XHeIlCZZyjmaMI++Y3aM2MCQisA4y2bnzNuVcuco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606303; c=relaxed/simple;
	bh=x/6Mj8dzphmWlnSGBe6+AGxpWwqp9NycJT4FTm8Zu80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ND2L8L3sAah87fQTGXTUyrz5KX7fmfzTmfU7lVftq/KkjLJRp7u5Q9tryz144zv1QSz4EXS8SWuv0OsrsUzXZSYcA6aYFrD8e7w0uAQ4bXnFOyVTLun1vTnw3K+6dxGX3q6gxWXsqEM8aYCweDxeBN6RO8jd8lX3QcoNBVTXOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c73uNlh2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VbS4IRZf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c73uNlh2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VbS4IRZf"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAJkO1839640
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cTgrUnplzPT
	siEHPRzeo3nJSaP/Fgn0ZqMMHeAun+wQ=; b=c73uNlh2ZtQ7oej8s2yZmevZ3k7
	REywjteFYrK1X5Mt2oFWX74+RMx/ANasUOMEci/WYpFAXC3eDSM5KKAzRlk3ReD7
	NUZtqsG30imxmipV6zJe4iKrMnyIydGyy5CtfKz83zRJXFTE9OM969wZ2NXR5Otv
	NAIQbJtoaIKI6VIJsMCp6Qw8twxVRMN/oM3cmg5y/rJX49tS6VfHXrbIsMlLtvre
	iX79BU25HrE3sHCpqucTiplywvFHg7xkKlgxy/GHBb+IBd7JAdfRd4vtTxc5ZUER
	GbzudQZgtsGlq26wWi4UY2xGnSHc4G2L9c73XXMYhDJooGSRemk8PoT7n/g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynb6h7bv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:38:09 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5332a735eddso38692371cf.2
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790606289; x=1791211089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cTgrUnplzPTsiEHPRzeo3nJSaP/Fgn0ZqMMHeAun+wQ=;
        b=VbS4IRZfG09fsTRNI9fUGOtUgD8lS64Cv2hRvopQJLwRGZEejJebixUUc6+WqplrZY
         vp7+gXb2XcyCAbAslt9hk72ET3x3JLthhCDu8bnMWae9SVKHMaABjPnorpFhC7SfwmMl
         1NnbFgfQFnFSgzi1MvcuaMICJoVwNQJ1YzW5UHRALWt8aCcNHylq/Qa/udtOl3YTV/K3
         pkiJ5VvJqpnewjQuFg9dJ7uhf9MKWVZ2CYqDTjd4Y6CQTqECFhpY17f9iNbmeICveijh
         cszWwB7Y1rMvNj+PKL8O2vZrvX8pu+c63kdtPqDVDCJQGKL0pgtOu2Li5YtSLZxwSZNv
         VxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606289; x=1791211089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cTgrUnplzPTsiEHPRzeo3nJSaP/Fgn0ZqMMHeAun+wQ=;
        b=e0Iy490ddeUf1F6BNuQiY11XAHb7vafaYHiQiH1ndnHM6CcqPsp7w/YjDWwzFSnBJ7
         pS0lPNGiJ7LVqxXPbBm0NBhCGRat5unyS+swH+5/Z15cHRF/75t1hXQZH2hv5nXGy6z7
         C7Ucx4m3H4AG06PhfrbeHPWbGsIj0dnU8BcC2fYv8Ld15lN1PU37ePHyQPq5v8bo0htv
         InIDOr21s+PTRoswc2IbB1J2Y1Jr/eF2e5frF9QN2NLblFj1vrZuEnpnNGtI15y+fkaC
         Wklz6Opv96PTOMSxKiVV30MFC7Td+ve4/Eru5tfuwNyPlYjiLfIllWfCA/QX9cCu0+59
         /qBA==
X-Forwarded-Encrypted: i=1; AKwUvBz1PVgVm0VYf8HyNqrllm+HyNwQ4XpbdcrezG5a03P+jaUTt0UHKW36aKVdkwmMUUKcfhY=@vger.kernel.org
X-Gm-Message-State: AFuF++k7LRf0O2DMDF+jMU12hEn7ZIe4yWx+KCBu7kSv7oZ3nm8Llwxn
	+VdvVnJaLdC/ymh+xKGUxHCdY8K85i7c36ox+Wvo3UuPs9//4GleMYULPPQdS2MxXTh+5PyV9uM
	odEkNQrmWUFKEdL1RSHhi1wVvrOi+kLUb6x1yKP0su9LfjaKFgrC76MO6r6snhkk=
X-Gm-Gg: AYBFou3G99r1N3tTWAkyQY66wdQ5qeDQgzxBtFWGQarzPkVGa2YFe7fPKwDcMs15rWf
	oZyYvMu7pWImbP98/X8Kr6pGxHiy8klIDoBPOFa+/3W5gas89Gj7q8ZS1/ot5g4eORW7/dWleie
	UA6wiuauYRRrQob2VnK1G0IozICtju6i4OXOzHG/HJnSLf7mBMFx9wIugPQhpSs69gWB9kJaGns
	joV+hSTBuGY+SXybGU6BPhYs0IHuR/7RmYpl3bptzbyD6W66iDF8SDAFsxJQhXUSj+oCd7I1AqR
	HcypIXeXHgMYmmOlJoKYK6/PyE3Ufha8hoCI2ekbUvt1Z4xGFYPT97WU4IosuY/nKw3z+FpupJm
	GeyFzxuXpvzqvS2bdshwsprXAmUHVgnFarTrgww==
X-Received: by 2002:ac8:7f8c:0:b0:532:b3ce:f38 with SMTP id d75a77b69052e-5330b59362cmr219839931cf.4.1790606288560;
        Mon, 28 Sep 2026 07:38:08 -0700 (PDT)
X-Received: by 2002:a05:6102:2b89:b0:7b7:6dec:6eb0 with SMTP id ada2fe7eead31-7b76decd903mr718307137.15.1790605931408;
        Mon, 28 Sep 2026 07:32:11 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbed87650sm291164166b.50.2026.09.28.07.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:32:10 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 08/14] irqchip/riscv-imsic: Define IOMMU IRQ bypass protocol
Date: Mon, 28 Sep 2026 16:31:07 +0200
Message-ID: <20260928143113.49838-9-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
References: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfX7lsFuFUYqMGo
 pfehdOC45IiC4L6vZ6T7zhAtBy8mWcaKputNWwtZxTj53qow5csQ5Xw1Rno3MNvI3PtgPPuHAHz
 gN8I7TSG42U016jFuAyl7NjVDnSlm+cUutcGRc1r/7QQnq4kqb+J4SMbpjZRZ6Ij77HVjvXcuTs
 nYBUdKoFF5lReaEkElRqWiqyzSDzh9wnxR1Y+VPnic/+KFNOddS2LehgvoxmhA2FVU15Arw+eVF
 rUXfkn3g3CRHqJjJrX32yDi6abvmFbtmbm/uWhD5lDhl/B/pOga009ovgBnHvlE6DtobI0tr7fR
 hiRnOxQh9uK2qLyIBDtgUL0/zV2CFXJHZsYfD6hRTE0ZpGmIMQPI1qaaBlmA8MDpMhtI5x221kH
 yuwXnT4vma9IJtFnzquZs8DyPUEMXDoEU0niOZI+E89yxR4hwH9VpwMu52tG4DPf5QiiTcikKg9
 0C3++Eb++hdO1HLW01Q==
X-Authority-Analysis: v=2.4 cv=K+e3jCWI c=1 sm=1 tr=0 ts=6aba7bd1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=4AuT_VmNVbg3FCPyVe8A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfXz0FOhseFq7+b
 EQQQJHE62D7fHVoznqSKIP6qX7QRbODdHg3atPhWlwdRozp3tLYHhyRddADyAVLqFjMAbWPJdwN
 Dz+RGQkARpftYoM54iPSLSzDq3B9dtM=
X-Proofpoint-ORIG-GUID: SYsS08ATTuM-yQwX_7VsrIP6kPmvDV4Z
X-Proofpoint-GUID: SYsS08ATTuM-yQwX_7VsrIP6kPmvDV4Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280058

Define the RISC-V IOMMU payload for irq_set_vcpu_affinity(), including
domain-wide target setup and individual target updates for IMSIC and
MRIF targets.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 include/linux/irqchip/riscv-imsic.h | 52 +++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
index 662cb0442424..d024a6524baa 100644
--- a/include/linux/irqchip/riscv-imsic.h
+++ b/include/linux/irqchip/riscv-imsic.h
@@ -104,4 +104,56 @@ struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev);
 static inline struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev) { return NULL; }
 #endif
 
+enum riscv_iommu_ir_cmd {
+	RISCV_IOMMU_IR_INVALID_CMD,
+	RISCV_IOMMU_IR_FORWARD,
+	RISCV_IOMMU_IR_UPDATE_TARGET,
+};
+
+enum riscv_iommu_ir_target_type {
+	RISCV_IOMMU_IR_TARGET_INVALID,
+	RISCV_IOMMU_IR_TARGET_IMSIC,
+	RISCV_IOMMU_IR_TARGET_MRIF,
+};
+
+struct riscv_iommu_ir_target {
+	u64 gpa;
+	enum riscv_iommu_ir_target_type type;
+	union {
+		u64 hpa;
+		struct {
+			u64 mrif_hpa;
+			u64 notice_hpa;
+			u32 notice_id;
+		};
+	};
+};
+
+/*
+ * FORWARD enables forwarding for one IRQ and provides the complete target array
+ * so the first forwarded IRQ can initialize the domain MSI table. UPDATE_TARGET
+ * replaces one target without changing per-IRQ forwarding state. The caller
+ * must quiesce all MSI producers using the table when changing both words of a
+ * live MRIF PTE because the update temporarily invalidates the entry. A NULL
+ * vcpu_info disables forwarding for the IRQ.
+ *
+ * A well-formed request which is incompatible with the producer or current
+ * domain configuration returns -EOPNOTSUPP, allowing the caller to fall back
+ * to host delivery. Invalid payloads return -EINVAL and operational errors are
+ * propagated.
+ */
+struct riscv_iommu_ir_vcpu_info {
+	enum riscv_iommu_ir_cmd cmd;
+	const void *owner;
+	u64 msi_addr_mask;
+	u64 msi_addr_pattern;
+	union {
+		struct {
+			const struct riscv_iommu_ir_target *targets;
+			unsigned int nr_targets;
+		};
+		struct riscv_iommu_ir_target target;
+	};
+};
+
 #endif
-- 
2.43.0

