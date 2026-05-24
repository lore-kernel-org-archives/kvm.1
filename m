Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1123ACEF0;
	Sun, 24 May 2026 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779639651; cv=none; b=ELmZUR/+xaygUhbUdGls3iYIBaQT8Lfv7qqjLzyqqZxcIIT40jSwBZYv0N35I64Z1SF5bK/020w1Ti0m3szEbxgLw0+xqaw0HR6MW+tFuELDlT3AKCGuynMYGy4QMD6tMQcMjUSQQ5cycvYy4haQmqfoXoTPVZZR7us71Mw4Md8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779639651; c=relaxed/simple;
	bh=7+EyGHYJWsceYkN0P9lyHfNWbRmcVV0QVPwLpQcU4NY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R4tCrEZqOi65CwYSE34iWwMQ3vnD6uEk2bDOMLYpPW0YQ+KhIFyyGsQ1DPfCnexeT1UzcJj8bhpdKQuBcXnnnZdNP/kPljE1Hzs616oIPch+9s2WtuGttiscWreK+tKmOxEHh5Dwy+alnq80ptCdyld2K7KNEkr6RniAUxWZB0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dtFnHIzS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dtFnHIzS"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64NL5sA31498348;
	Sun, 24 May 2026 16:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hdgYunfzgz7gRF8cx00GMl2+9vS+/7kqWBw
	kqOe/6fo=; b=dtFnHIzSNR14ugY/2oN6AVgHRxt6ZMg4uaGIgMj/YUG6GsJYGV6
	nB1Xk3xr2j0eK7Q3YURcOJVivZ7Ucdcrjme7b8Vb6+3lBJS4Z3+dw7G9NBfLKqYE
	pOIdXybRtWjB9vgYu+OUVPBEU+VhCvymSExxSlbu6OMZgmVAS8t3b5sY6hOBSIs1
	hF9pRiYPsOq/didLF1j/+yBi6J7hFICOvUintPXM3Mk6Rp+rfKupC5wsJ5dezqO9
	yraLSD4gAmCWXUXT593wyX8HVyN1FyobOQlFkfSu0UYI9zq/YmnwZkW4OrGJL4Cl
	cRv7OReX92m8P6A54iA41uSwIfZbE0cN3tQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb386kqth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 May 2026 16:20:24 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64OGKKFe025074;
	Sun, 24 May 2026 16:20:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4eb5ahj3eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 May 2026 16:20:20 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64OGKKU7025058;
	Sun, 24 May 2026 16:20:20 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-anuppate-blr.qualcomm.com [10.131.36.165])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 64OGKKAa025054
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 May 2026 16:20:20 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 486687)
	id 659E721BF4; Sun, 24 May 2026 21:50:19 +0530 (+0530)
From: Anup Patel <anup.patel@oss.qualcomm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Atish Patra <atish.patra@linux.dev>,
        Thomas Gleixner <tglx@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
Subject: [PATCH v4 0/2] RISC-V: KVM: Convert HGEI management to fully per-HART
Date: Sun, 24 May 2026 21:50:07 +0530
Message-ID: <20260524162009.2602535-1-anup.patel@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: Lxv0I_R_MNDPKhaUzBwpO-OUTLuvY4uh
X-Proofpoint-GUID: Lxv0I_R_MNDPKhaUzBwpO-OUTLuvY4uh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE2NCBTYWx0ZWRfX1YEuiN8g2mWS
 hz9WL+QmkEMaAri/H3AglasEE8iwk2KJ0woBLxVhDnTpxpCIkpDUy2K5JCCj/4Zg/CCvWvDEwqB
 b8WfoXYe7gNWhnyYULaiql6UW85L7Zx7MZWpnfqsGDlt7NaSqIti5q4hkOYmfwmNo9rjLnrJTfJ
 Tbxbq6r6MqNl9y7dka3orUfHoShBINNGPQNyWm2pi6x2TE54gFnenwABl1f5aLXHV5kdit/Cc1I
 No4PiumDbuqW0Ha7/J3vF4s7HLdiSrbra90RHjsOAbZ6DUr0tgJIKTLKolMgZdaKH43TnYvqQCK
 MNXt68+2atb946w0UKWNRqWo3nBNn+OSivGCoMhLXr1ZoMVsYLM+JfaGx0TATsyJ1mra4o28FjB
 k+QGlXykU5hGgNVeirLjwAfsD+jh66g9XW9Op0/YdFOXVUB2RRzpfbxyz3dLBQkexNNcQ17EFqT
 7KMMQXK/+MkU6ex4JCA==
X-Authority-Analysis: v=2.4 cv=PJY/P/qC c=1 sm=1 tr=0 ts=6a132548 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=KRMKSR888c52cKfz2NEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240164

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

 arch/riscv/kvm/aia.c                    | 65 +++++++++++++------------
 drivers/irqchip/irq-riscv-imsic-state.c |  9 ++--
 include/linux/irqchip/riscv-imsic.h     |  5 +-
 3 files changed, 41 insertions(+), 38 deletions(-)

-- 
2.43.0

