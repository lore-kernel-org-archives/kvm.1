Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64EB3DBD52
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775125410; cv=none; b=S97qsdTuCv8bYFu2M/KT1QCT7zFp/+Bi7opBdsfltDQ9PDMQ6AZbvQ/jmS8XgPEL+pv56GYzG1C13hGdWkqytoSTiPM3r9SPdVSONhaI2GK7sTkxUwCopQA1AvyQ4SNFJpM9BhgClKiRpfccpqDs/cWFaZ++H7c14figil0BQ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775125410; c=relaxed/simple;
	bh=nLS4MJyMMwQ2WYFmClH5/ODmfyCS3vaEK2/pUfWjWpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JrCDC1AcENwRhQRhlvMiYTYkSxkgkE42GS2tIYzrXEzdrCtRvQHc2R8/XEj2i40oUGu1tk3uTMbeI/LO4p1GB+R5cOACnQpfEvAScJWt7OFjxUxUUkIedU571yBQMXcIgiFvGz7PS71Bd4+xfMbZFlRuGlS2InY5WMLZ0cBvaB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UlP4958g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cZl57m7b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UlP4958g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cZl57m7b"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6325VU3W090876
	for <kvm@vger.kernel.org>; Thu, 2 Apr 2026 10:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9NJM49s+MiVY1tQMsPbOJHH10Xogvc7mmpy
	Ts02c6Ms=; b=UlP4958gdS9gDtGGXlkbTIAwReZ8obzELD2H/85Wb9ZPv/YSXr7
	bhVmtqDH1m7FsugU0zpLe2/bHjqLPGfilTh/A2VG4/QuNYEyrcCUBukDdElQrBpz
	2EguKES2Lhn3q/LfSx+tq+8LtQR2SikmyENdnDvusozue9F5cmIUNb6kNdap+3B8
	nZ0j9oZFNh7C0JeVqITCR0jiI4BktJ5D8Px+qLhCoJGVm3INZqHUff0q6hgE/0fz
	cuetOmdYSyRlnCYNC2y302YFVKyR5EvdhTue2NgWhdGG+SRl147r2DrqeRGbApeF
	MmwoywgB/S30uGO8BJjHA20sb0cmqVHo3Mw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9jcu95vf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:23:24 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82ce50e6e28so526833b3a.2
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 03:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775125404; x=1775730204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9NJM49s+MiVY1tQMsPbOJHH10Xogvc7mmpyTs02c6Ms=;
        b=cZl57m7bbsoK5LSVrlq8pQoWKxLI4fSwVBCNUQerS4oem+U7HM/sL42pnIy2XJesFR
         AFDA2upM1yktDfk5NFquMd7dyqVII1sf+fFmzUGqi3OOYk+HHP+ZeY+NuREX1oOGAfs9
         +OXpY61VY5QNYys6w+iDMx7ScFd5Vykfku+dwzmzpfjLFwdyO2G/WDsNoz5zYKAnMosb
         z30FH2OUktRtaf2G1jaRs6Ly1iDaiJjWQg3WQbg1Ui4MCfjJmZVSB62EAwiemkQMLap7
         lG7hzEiKZKlJxq47tOyYCuCCr0GdU+mGMBRNJP8JFTAJlG1Wb0OIvQiXxvK5cTlejrAN
         sUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775125404; x=1775730204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NJM49s+MiVY1tQMsPbOJHH10Xogvc7mmpyTs02c6Ms=;
        b=AHvG8Tp4rRikRT/I1GgworqxBRr60EobXukIVEe7crSHY4noBoLIjTV3PLpe6xTPS6
         u42Fb+RSiy2oBIHFP4+0HRPRgi+z4D52pApZxSk35Ma74bic7+F+8q5ha26+VBrKNQUj
         m5wsIoM+BIYMyAOI/NLmjZqIlAeRDDE7ERXZWSEXRsPdcy7iPHBZ0TUzEAumaItlGn00
         Bcve6OqlyYYfDQuj/aQHByjof8d+C22JUG/Rz9VCrpsuIqbjs+RxSPnkQP6P8wt3imWZ
         Gt6W9IEKt5hcj9ACl+XH9qMnoBlK8vuXkc+3MGfhDaNpEqH9nz4zKWk/Un2ejx+Q+1dP
         +gXw==
X-Forwarded-Encrypted: i=1; AJvYcCUUPY6PxNTZkwF//hXY9pKLbgKCcAUB4hrpW7fDoHjKfsX/mK1cldcwpCb0sr4NcCH7WiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwOvUwiWYpTTqWHkKoeU5ihIV2Oa4qaCfpBQY9mQoItONtloyW
	tiv5PI/fFzEnvUwgEWzj2PqL1qroQfTF+eslrPRC9jPtQUWpPOTbKYE/F1SPICWomtuOViC9vQy
	zNsSNldHdbz+efqa2bCMWkmSU6qXkXh/RbpnQsqEhv2+FwH+LRQxAtp8=
X-Gm-Gg: ATEYQzwn0fKUH9xYcO47i9kizUfk4AGRf3nV/zLURLMX9D5FTmGM1Icw22ETwWtzR3E
	SruxurPOCAaQA4xK4f+nAqi5CsVzYPjenm0j83YYJuzS7ulTEkiEbrU88PUbeFp5RFMs8vT6pLM
	XJPdmMjDdFRcbfP6tkvzhOVX+6Bu5KK/2WEdFQWR8MIPLvyHwFQ0yT4QelML/nk+alsJPFaxYzD
	X8eWoNcYIEx5jrhFPe2o6kX2NmHSlVa2oFVVaqI/neAep+paMQbkBAVB/Cvi41K6bj5ZGME8/MN
	g4K7bpDIURzwA/c4aEHMf4EUtqXDZfJ+kK0euZpanNXTFeG/qPPsZWnTiTDKYiokvtaZ8s1uw9U
	BNpN9KRUQxE/62hPYigyAHq+bxOTrZrwnlbGAYnY1Yu1cUJOKXEJXlJndLqo=
X-Received: by 2002:a05:6a00:12e0:b0:82a:1935:f21b with SMTP id d2e1a72fcca58-82ce8b1505fmr6940219b3a.55.1775125404004;
        Thu, 02 Apr 2026 03:23:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:12e0:b0:82a:1935:f21b with SMTP id d2e1a72fcca58-82ce8b1505fmr6940195b3a.55.1775125403534;
        Thu, 02 Apr 2026 03:23:23 -0700 (PDT)
Received: from hu-mchitale-hyd.qualcomm.com ([202.46.22.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-82cf9c41bc6sm2643160b3a.29.2026.04.02.03.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 03:23:23 -0700 (PDT)
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oupton@kernel.org>
Cc: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: riscv: selftests: Implement kvm_arch_has_default_irqchip
Date: Thu,  2 Apr 2026 15:48:14 +0530
Message-ID: <20260402101818.2982071-1-mayuresh.chitale@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA5MyBTYWx0ZWRfX62e+on3xYzWi
 pTPQd5vD4FocEsu9SNRYadvM3GiquD/EFzGOk8i2TaAyNMFbo8uM0emBBZjpw6MzidDmHFjKkQK
 E/IWplaPfuMOCX3VnLuTWEJpGuPUxDTYUtvrIMhITP4qW3kuXEfc9AnuLFGD5dye4zb680cIM4E
 XuOnflGaboMNfV8DF9mZvgK6zQ2dJmBWMkabDLLTFrpvUtXt/ABHrTw9TRVj097dBAqlMB5Mdib
 6ptMFYposbfc8JDpL0sv4/yWpsB0fKDrBIE01XzQVew9LgizBgjthFZWjf2LRZ3M5BYobzkwd/o
 4LgeOtIrO5TvJDb53dhCkXztaiaYkalElAFbiaBppfDa5FeQGGXbeLVNFw80BSufisIvsV4jj/W
 aBDz70wzf+lmY6z08OW53DMKNUSSBX0oMvKWcE5+rtLnIpfz+FcFkQZxw5sihDrJ9nRKzplPbxm
 uyTaSGSQygrFOHr3UWg==
X-Proofpoint-GUID: i9Baa18LyZShexOj5hteb5PzAhoNkFEZ
X-Authority-Analysis: v=2.4 cv=eYYwvrEH c=1 sm=1 tr=0 ts=69ce439c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=wNTC72m251yRgy6-mc0A:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: i9Baa18LyZShexOj5hteb5PzAhoNkFEZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1011
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020093

kvm_arch_has_default_irqchip is required for irqfd_test and returns
true if an in-kernel interrupt controller is supported.

Fixes: a133052666bed ("KVM: selftests: Fix irqfd_test for non-x86 architectures")
Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
---
 tools/testing/selftests/kvm/lib/riscv/processor.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index 51dd455ff52c..067c6b2c15b0 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -566,3 +566,8 @@ unsigned long riscv64_get_satp_mode(void)
 
 	return val;
 }
+
+bool kvm_arch_has_default_irqchip(void)
+{
+	return kvm_check_cap(KVM_CAP_IRQCHIP);
+}
-- 
2.43.0

