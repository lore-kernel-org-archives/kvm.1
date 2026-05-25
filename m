Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E933D37DAB7;
	Mon, 25 May 2026 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779702613; cv=none; b=nV0x3i0yFBEFGHuo2APTyYV9Du02w+tS6y8pDps7hJsQwk3+WGryTAr4mrEAAKXUrrDc/DJMjJgUEQpgSCYd0wxHB8yt122KwGRzrva3Klj4vORO7EiwlhYZtSdvvl1TDWChp9hfbJ97OR8NlAjKfA99mzI0LrN+tp9T+DBb2mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779702613; c=relaxed/simple;
	bh=GAlka/kyODkGVV+sYJKd6i3Pxf/xWRTI/62I48GxiY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FvFg61XOKJCeNC3ne4Xq0EU6XZAKVJMu5OxSBOu5Fht8lC0Wo1nbdKgv8umj8wC8IA1K8WeMxTBuauveWrdUUExx72hQacHo4qfqW2zuqSOMeT7aQ0uKCp8qwjcm7nl3hi0Pl2CznGbVeCB9ftxSjDsR/l452puBolm3Rls1wGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jalLWrSJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jalLWrSJ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P70pqL609776;
	Mon, 25 May 2026 09:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8SXEkshZgC7NQobwYiVJCAvXimLMq6MblPJ
	kIc1DOPM=; b=jalLWrSJi+OOj4XhX9kSSJD+VNEEdKhyxtDxTTNDqVbKYc8Mfk4
	pVNUHNkmlBjLFUT9IXIrdYaZK+dSio1O96qbH+Yb4URlVdnAN+o5P+sS8vVd+Clb
	0fSLASw17qUFDZpwudpbALXSQS4uMe/Qg8MHGvJGx0QS0uhY3xNkLq9OHe1iX0LW
	29B5mt2iMyhx/oOAx1xbw8wlcCMa5jU9b4Xq1+R+T81ObcW5EuW4sHopDkLC4wq0
	LjlKoyo7MB0Cl48D/Z0jcsOpu2o7jrO63eNm/Vp13oBmG0aadHACB5J0e4op1YCB
	U84XDv7VC6QTbrFfDao3fnOZqTt9zzoRWFw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb5h9nxv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 09:49:50 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64P9nl85019448;
	Mon, 25 May 2026 09:49:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4eb5ajeh9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 09:49:47 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64P9nlGg019433;
	Mon, 25 May 2026 09:49:47 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 64P9nlwY019430
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 09:49:47 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 62BE421CE0; Mon, 25 May 2026 15:19:46 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atish.patra@linux.dev>,
        Thomas Gleixner <tglx@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
Subject: [PATCH v5 0/2] RISC-V: KVM: Convert HGEI management to fully per-HART
Date: Mon, 25 May 2026 15:19:43 +0530
Message-ID: <20260525094945.3721783-1-anup.patel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: GePhHt82nA213QfqrdJ4IiZXjw2Z-8pi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEwMCBTYWx0ZWRfXyGpvfcIkjmFe
 f3WJ5UEV4cyj2+NcuKUiPKHmp10LDDR68/mJwQEA3OlrtqQvmQN5+FgmWHRc44bmk2S/WCwEquf
 kd8ccjssaxz4fWsnuH8zdmoWMMlC04/yUDtTiFQ4bMCSN7TMq1u1j1EXn/4KgzZKFmjVucwOuEO
 pwioasiUqjIk+tgJrQMXJ9T5rzj4Bq+iJ6lhOk08dDhrlXnKaNw/TkIPmQhAA6DdVOfF6k1azpx
 bFcFYHMscQyEZS2W5ZAeS4tsTUBMYa3wtvfewme7BV9TpdDyRzC/NOreiS8Sbeu9ugbjsX7aCjp
 7nrRq39p4IIogfaShuE5IQiF/3FirRgolah3ARV+R4SJPEOLmMLJUReQ9BgK3UeRRmWq+U3HYKa
 M4GhiEarvniwWIrpTBA7YTLl0hLBYKJH7adX7eF0bdfBfdBukyGGk1a2XXfueA3NbwWI79Kb1IV
 VdTFiRbclsUVcCsFVRw==
X-Authority-Analysis: v=2.4 cv=H7jrBeYi c=1 sm=1 tr=0 ts=6a141b3e cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=0T7DXsVKAORm7GO0La0A:9
X-Proofpoint-GUID: GePhHt82nA213QfqrdJ4IiZXjw2Z-8pi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250100

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

This short series converts RISC-V KVM AIA's Hypervisor Guest External
Interrupt (HGEI) line management from a global "one-size-fits-all"
model to a fully per-HART (per-CPU) model. It also performs the
corresponding changes in the IMSIC irqchip driver.

The motivation is to properly support heterogeneous RISC-V SoCs
(big.LITTLE, multi-vendor core mixes) where different HARTs may
expose different numbers of guest interrupt files / HGEIE bits.

After this series, HGEI allocation, freeing, and interrupt delivery
are completely per-HART and there are no remaining global assumptions
about number of guest interrupt files.

Changelog:
V5:
 - Avoid re-initializing hgctrl->lock in kvm_riscv_aia_enable()
 - Setup free_bitmap only once in kvm_riscv_aia_enable()
 - Make kvm_riscv_aia_nr_hgei so that it can be concurrently
   updated from kvm_riscv_aia_enable()

V4:
 - Don't modify kvm_riscv_aia_nr_hgei in kvm_riscv_aia_enable()
   since we use kvm_riscv_aia_nr_hgei mostly for HGEI enable/disable
   checks.
 - Use GENMASK_ULL() instead of `BIT(hgctrl->nr_hgei + 1) - 1`
 - Always setup SGEI interrupt irrespective of kvm_riscv_aia_nr_hgei

V3:
 - Move PATCH3 as first patch and kept the nr_guest_files in
   global config as the number of guest files across all CPUs
 - Droped original PATCH2 and squashed original PATCH4 into
   original PATCH1 which is now PATCH2.
 - Addressed comments in original PATCH1.

V2:
 - Add per-HART IMSIC guest files to compute final HGEI count.
 - Add min(local->nr_guest_files, nr_guest_files);

V1:
 - https://lore.kernel.org/kvm-riscv/20260421145451.1597930-1-guoren@kernel.org/

Guo Ren (Alibaba DAMO Academy) (2):
  irqchip/riscv-imsic: Add nr_guest_files in per-HART local config
  RISC-V: KVM: AIA: Make HGEI number management fully per-CPU

 arch/riscv/include/asm/kvm_aia.h        |  2 +-
 arch/riscv/kvm/aia.c                    | 88 +++++++++++++++----------
 arch/riscv/kvm/aia_device.c             |  4 +-
 arch/riscv/kvm/main.c                   |  8 +--
 drivers/irqchip/irq-riscv-imsic-state.c |  9 ++-
 include/linux/irqchip/riscv-imsic.h     |  5 +-
 6 files changed, 68 insertions(+), 48 deletions(-)

-- 
2.43.0

