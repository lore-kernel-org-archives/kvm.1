Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471EF4E1415
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606363; cv=none; b=V/FIT+VYye1tLDDjVZ/M5ufiNUopklSsy9CHQyNiNVyZ5uAGgW5WyLiiiOWjJVV22uz3ABnwS04t8aAFRP+l6pEdQ/E4hcrXh7aiSTCBeO+mAfrK3MX917gVTHJFXN/eP0906K+ZiZcGyH0RWn8xBLwUU9ZQqU+iWS7FlpUIczw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606363; c=relaxed/simple;
	bh=yRSrMfOIOY8yc+H0kITYB7yCLVZjoqzSM1JBHxbzG64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMrMzMsXnBT0kG6B2boLyllPBTtT0JkWd2KaVogfS4Rcj7jXBzZAKPE/4b7ZJ/+uOslwslASb6WfMdm+ywc1mlIn6OC1VOj4apE+Q3MZy4BeHzhFVg8rhFdHdIPds38N11BDSgrA5QDYcySZO0DniJtLbUA22EvakV2kcd8DIKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MMdr6s/s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z7Wn5Qt0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MMdr6s/s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z7Wn5Qt0"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAVBB1042595
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=95f+Fzhwpw4
	3Z8OjjMrn3wgehO1wG/e14m5ANO8Aj4c=; b=MMdr6s/ssYyFfuRlTdQjkQCbpmb
	f/ssEosnetm8jJ4kwLwqF35IMwwxxbL4dnl7LoGzzMRtqh3+R+xinaj7DNfgQ2Ga
	8Fy160rzhWysrV3GR7XiQJDH+kWFFlADerqmc9BHUEef8rnpccfEYuLFzmMdATsB
	3d2OuWjIf3U7Prn4tYsYMPvq3Yh6ANS8f2CrHpLroXfPgZYFJZ4MPiD20cw34Pcr
	vCMizsLjBIUMxH2yqZe2hiOP18Jmug11NTuvzHNS/3eQDvoYcgZz/vzUVJIcrpMO
	r9JmFn7Ah9My+daLge+eNX8ZN37hIulxY9tCaDYmtwqRS7UJEo6600umIpQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyk5mss0p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:39:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d9057fab9eso32214915ad.1
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790606348; x=1791211148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=95f+Fzhwpw43Z8OjjMrn3wgehO1wG/e14m5ANO8Aj4c=;
        b=Z7Wn5Qt0ybFL0FlWybS5cAlwUKgpyuWVeaW5hYFIug6E2jTGiz3S3agkwdM7QnyA2A
         +Q42tIbydLXNgKiyLUtuSTMhTF7oNanw0zeexxUy5qXsiT3iC9iQcsS/7jLvboVK4GDq
         vCV1gddwS2gJiVGXORzkkKFRX0vGIE72XxMcYygoLJyGzCrkIGx2SCX8H88lW2g0zZwa
         7voOuBBAIA2nONpM/bH5HmxOXFTj7T/DLBFWCG42AHOyP67tTR54qI7t7o9qWElLej5O
         lmYX9/YPiiIRNwGgEgZJzOUazR/xQ5GxkSA1RCGIrVZTPXWTL1VK35gGxygy9irFMXVx
         vWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606348; x=1791211148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=95f+Fzhwpw43Z8OjjMrn3wgehO1wG/e14m5ANO8Aj4c=;
        b=xtRMg0PkZvTiaIwS1kZN8FHHqk4csI+08cPYlNpTHJtffK+m0rSN9nSASxx/SbjoDb
         fS9rQ4/huNw872IfXGnH3dwOJ+eRSmqDbHbUwrAY38yWrRx/wRjbUvb0eCWvnQbI4sCH
         U2f2TbZIUAgREI4GDbXbThzO718MFT8PyPfxQzPK9PG6ImVL0HO3eQH4YAPulqK/FG2H
         kzSyWuIOnvQ10Q/UMuq6CUIenIjv3OTye6D/a9S7HM0mnblM8Y28QnKmwIDLxTtRs9Xm
         FlrLRqkk2rHDIKrhfuDsX7Ib14tF7ubqwvLEtVe9ZN1nbIcpHDgkH3gkMOmu/ApTed+L
         RF9w==
X-Forwarded-Encrypted: i=1; AKwUvBwJhX+O7q1h8wwrRpBR8xGYbLomR2N3xn8e8Di1WvuRJlXsdTmAAVkJGjw8h96a2w/fuRc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSyAIRU4xdwdm7Lkfzkgx8EQ0Ql0TAM1NZX6J0Mgi5jfh/iE+g
	aQp10xDMXP1goehGclNmWJVSaMngjNW3Rny7Brbt6M4YpZx3Oc2ULD1tuARvQHDxVX1EqGu0dbZ
	fvo8DfcPN37cwteba57ubpJzlUOwf4xrPAKEx35AcY8clObhhc9npE65Bw+91uu8=
X-Gm-Gg: AYBFou3dqSW45s5MkDabhauiB1axd1Ju118b7S5phand/lupVglttYaNK5QweWWKsih
	sHD8OQgqouUQtwlJzYccbB5sDnqMCcit5kttpFlO5FBPDcAo7qryF5kB7WplTx5xYJYO0Wyyowt
	8XDHquZDyceDWdlE56Xp4trCBJV7HQ6+/+Keidfty6ZUHLWhAKAugcUbwezbOJkvxJuwVlDlVzm
	5FK/tgaTVwlQU9pji0JiBeUs5CqSPVYNRoUn30gODBQqEcctvnXmodyJvaTAC4IAUgrW32+vW9h
	9avXAAK4Mj7/nrVuhZTeOFFgV/wNoX9u3JzE/UCGde1fvVA40SrjzDSCDhsVTte+oGyWeAKd7vT
	gMAf8Jnyq6e5Z3jvkaFGdMMstoInaAr+GV3ItcA==
X-Received: by 2002:a17:902:ce0c:b0:2dd:c054:197b with SMTP id d9443c01a7336-2df7e11d071mr107453845ad.32.1790606348240;
        Mon, 28 Sep 2026 07:39:08 -0700 (PDT)
X-Received: by 2002:a05:6102:3306:b0:79f:5d5e:11cf with SMTP id ada2fe7eead31-7af1d09c695mr3831186137.11.1790605933082;
        Mon, 28 Sep 2026 07:32:13 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5cba0ffsm4345440a12.5.2026.09.28.07.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:32:12 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com,
        Nutty Liu <nutty.liu@hotmail.com>
Subject: [RFC PATCH v3 09/14] genirq/msi: Provide DOMAIN_BUS_MSI_REMAP
Date: Mon, 28 Sep 2026 16:31:08 +0200
Message-ID: <20260928143113.49838-10-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: EJJrNgE3RRPU3lzSxZUDcvGC-eMoesi0
X-Proofpoint-GUID: EJJrNgE3RRPU3lzSxZUDcvGC-eMoesi0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfXxzWjUF8bx0MB
 xvKGPFYp9XiyCH8amMT20dgvDBEF7Ar2wgfBBF54YsevqnWjjstY4eeklSmrfkO9+yVhEUoXVTk
 3BJpoG2HDY7E1tCkTFqFIHngfgF7V2u9M5uts8kog7kv2+DuCV0da+hi82yt5Jcrj2GO1kTBbix
 z+83/YswbrPEHGwwiig0u4v+MrcEUtzBWfXpCIDvbHIiDi+to9iuyTEf4kgnLuYXyzH3R6rCUH3
 hYDZHJAQdDio3Qxpj7wSZRyWlY8ltGt+qteRS+PYAKIrNFkWaezmiTV1c/nBy3jNzzWO+e635t9
 1ApYyZjCVnpUgtCGjoPm3bJojApdF0gcQZU8MVvyh1sYYPUUcoddyE5eeE9GRSh6hCklY+Z7kPC
 +JwOHSET/QOBAfiIHEC3obbo30LkdfFgYorKryg4BGWGO0b46FERDI5dWQAHtzvUGkSE9criTy/
 hz5HCiH8ZhhFI12lebQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfXyzuKvVPdSEe4
 ef19SwBXxjeahoE6UTMYDwHDBpEQjY37lzG4Kq3bS/idj3CTm4LnTV10aVBlXAGzKNT8i2F1s6l
 tMPP4UxkhxSYn0KAKT0ZUgrICqsC7/0=
X-Authority-Analysis: v=2.4 cv=asYnmiZV c=1 sm=1 tr=0 ts=6aba7c0d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=69EAbJreAAAA:8 a=cHhBG6FuOey2j-0mYlgA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280058

Add a bus token for MSI domains that remap interrupts, needed by the
upcoming RISC-V IOMMU interrupt-remapping domain to distinguish itself
from NEXUS domains. The token is generic because remapping itself is
the only property that needs to be conveyed -- there is nothing
RISC-V-specific about it.

Such a domain implements init_dev_msi_info() via
msi_parent_init_dev_msi_info(), which leaves 'domain' pointing at the
NEXUS domain while 'real_parent' points at the remap domain itself.
Accept that combination in msi_lib_init_dev_msi_info(); no other
msi-lib changes are needed.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 drivers/irqchip/irq-msi-lib.c  | 8 ++++----
 include/linux/irqdomain_defs.h | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 45e0ed3134ce..9027dfbab15e 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -36,14 +36,14 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		return false;
 
 	/*
-	 * MSI parent domain specific settings. For now there is only the
-	 * root parent domain, e.g. NEXUS, acting as a MSI parent, but it is
-	 * possible to stack MSI parents. See x86 vector -> irq remapping
+	 * MSI parent domain specific settings. There may be only the root
+	 * parent domain, e.g. NEXUS, acting as a MSI parent, or there may
+	 * be stacked MSI parents, typically used for remapping.
 	 */
 	if (domain->bus_token == pops->bus_select_token) {
 		if (WARN_ON_ONCE(domain != real_parent))
 			return false;
-	} else {
+	} else if (real_parent->bus_token != DOMAIN_BUS_MSI_REMAP) {
 		WARN_ON_ONCE(1);
 		return false;
 	}
diff --git a/include/linux/irqdomain_defs.h b/include/linux/irqdomain_defs.h
index 3a03bdfeeee9..954cf585b3c4 100644
--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -26,6 +26,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_AMDVI,
 	DOMAIN_BUS_DEVICE_MSI,
 	DOMAIN_BUS_WIRED_TO_MSI,
+	DOMAIN_BUS_MSI_REMAP,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */
-- 
2.43.0

