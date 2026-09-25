Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C300D4B1CE1
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352186; cv=none; b=VOmyzN1A0lYxPnBL4WDyRV+a0q8eJQWXNN+6HFZlgkF6ovDDDOmzcmPvA6iNLjJ/jveAZih2iYFEI4HadrBLEX5CR5SlYEw8fh5vLyUxZI6nD7MAIcAdEV1jYida15jr4D7PvjLOdGW0Rb7vsCmcKJMIZ7FJU28FZLSeTuJxso8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352186; c=relaxed/simple;
	bh=JZCiMhMj9Qi1hwAH9YEFbNu41lkzW5HMsRwV5LvxLlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQ93QTm/ScCom/zxbsrKPQ82rlx4f859s6X7wXniTLH5tu7jKPqEvCOm6y+R5hfiteNorh3JBqvkb/fKBfJfusiTMmO6gzzURrqaLPmCDovnjF9skbTG5/mFWlJ5jPjnQo2OlGrpAS+U0zKTvoAuPYorFOSbY21V+L3W/KKNaXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CHIwSdtj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O8ImMFwm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CHIwSdtj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O8ImMFwm"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG1fL51668863
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 16:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=pPUscgiiGEE2Ts6w5N0M5vrxQHmauRrDTsR
	QpGYB8bo=; b=CHIwSdtj/Lo9jqq+QUDkDZGz5er9nK0n/ommKXcOJ3ouoxXBwYZ
	GJFYPJoqGOOQVQY3Ck5zZR0Oe3H5c4P3ZPwA8DgCCts3xY2kyJ2DM2XwL+hCT3vs
	+huoMoGs3NEoGKPtvOUpsHUHgZlXKxnJYhiBajxGYaeWKSaQSisInxkFX/MduxQX
	zoIyo8LGTCLBKBDRI9Q9gKyeAXglMOdn2BFrFeXUOJAsROkDUjY+SUYJSHNP0V/I
	ZAqqvSBAev5cV/NXqOltAuw/MHUKNha2o2n2lAKVgWjEFaLH5hvSSiN3TZEeSQiH
	W6RwmnYSLQfAFYAnoSAaD5yKdTqfZ6tbw3g==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw898v9dv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 16:03:03 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-78fbc5a4cf8so1949931137.0
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 09:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790352183; x=1790956983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pPUscgiiGEE2Ts6w5N0M5vrxQHmauRrDTsRQpGYB8bo=;
        b=O8ImMFwm8e+k569S6yaClhxmtN2rBkILtnCqpZNP52f+Y9SEHbPVKDFpEr6/ke7c4f
         JUeV2bWsNGWJOiRXR6kcNrcO05IyuvbjR0izkR0o0TL273/VsV8xRg958cJCOzwkAghg
         /Z4ols//r3a45ARIUOXwgotlzz5CGRFXKFBnGhxpxjlr5H47RimsBFtqELd8KWAL+NZR
         JgozIB8GSK2b6MnPx3xjEqCz946fuqakJNo4mbSgti+2OueK4EvJULRzJWPKIxTUfoRW
         ZR2wg7BjOuuAjkzQJpg+QwqETTK7qcaMAJM91x9HceW5Subo9FEwtQm9LejH/Ft+pwvY
         gKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790352183; x=1790956983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPUscgiiGEE2Ts6w5N0M5vrxQHmauRrDTsRQpGYB8bo=;
        b=xa6RhVFYTolTb3tdMCX+E7sH8eJUagqJJcuwghDGmvalMG7CAkoSCml+iuWKMh0Fd9
         aizYs51TK5VsTf33ZSfeES2eeCUFtAWsXPjhB01/QR6VLnRPLQRIOhlJrwbFoyIwqvUL
         U7J7345TD/3WsecYLQWe+ZYe5WLph3bn8e5pYe4+vVt8NGrmlYTXI+Q3w/Hw3ILOljQL
         ONvg4DwFO4sCOu3NeERFbtY7MIpmIJi7vDgMUEFREOl7MRKjzRjQNGPP3KQSCqctDNpA
         mroev406e+CaHG1ALThQWD91YN8266hL+pujxGmZPkx12+OQ0nX7HExDEQThaGMGucO9
         2wcQ==
X-Forwarded-Encrypted: i=1; AKwUvBz0uJm22KRE0zcq7R6K2xHYzJDHrp64qRI4pLm4e8rkUa1kVYGoxk5REmB98UbHSmOuPlc=@vger.kernel.org
X-Gm-Message-State: AFuF++kWrv5DZngFiE49bx/zxS+7dcG+7gIi72XRZN3zQN3U7R4hVj4Z
	04AgDJFRMaCP+2yzFu1L++ne5A7xh0gml10oQx8KUtOnz/xfJFV7i0d2J/jMFRoQDnBg30vuK0L
	pzEzHR4lgIKuTEtwxsZjSBfonRccYFiFHdBsdjz0YF3+CUqLCnrhvAgw=
X-Gm-Gg: AYBFou0q/YM3JZeFGFSB06ZVr4NhbRnKUzPcLRwiJcQK/y0bnyL5lrvGuK/aN881f/V
	9X+oeQQSvbFx0Tmj30LS8y+TnZVzajEHS3mwWAtRkjAgBb5pQkE4RZgPR1JbSE0fYj9CG+NVtoW
	IbdTuZoaJt6WWqZdCtm9iHbosB4kRcNmt6QV0sigZVQRSsg7b7p2BJ9fLOIXuOWa6josokSqOaG
	z8/jv6SJs3jAoCi1Oq7IPeh9l+dpFCWvZdRUF/WCh+vikqlH9EtpWHRluYprr2erj7jy+P9R4zm
	GtBAQgYCTlAUETz9cCWGnWL8rcf9ePjyLNxGwWAZuKGGLaNtNSe3NUBBWLmD4T4+02N7pyk8Wuy
	sgJcHYNnEt3e3oWlIL0N04pg1RB0Mkrb40PfCtg==
X-Received: by 2002:a67:ef82:0:b0:7a7:69a1:add2 with SMTP id ada2fe7eead31-7af1f1fd553mr1987015137.30.1790352182765;
        Fri, 25 Sep 2026 09:03:02 -0700 (PDT)
X-Received: by 2002:a67:ef82:0:b0:7a7:69a1:add2 with SMTP id ada2fe7eead31-7af1f1fd553mr1986990137.30.1790352182076;
        Fri, 25 Sep 2026 09:03:02 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a84221bsm8151098f8f.36.2026.09.25.09.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 09:03:01 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: kvm-riscv@lists.infradead.org
Cc: anup@brainfault.org, atish.patra@linux.dev, pjw@kernel.org,
        palmer@dabbelt.com, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: KVM: Reject vCPU creation after AIA initialization
Date: Fri, 25 Sep 2026 18:03:00 +0200
Message-ID: <20260925160300.467884-1-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX9VVOSyGjQOaS
 uz5luQiK/ZCsPLJhJn7Lsj8A7FZLNMqq4O6Sdo7UkZ2lqF4mEwHwiL0KnmxS4a/v+BxfVpi1XKj
 HANi1xqix4YSE8cFmJfS69s35ashrpsH4r4VdFFiulr0GmSswoDcMxRjL1Bzc2muM7Y27Q0KusF
 IejmUfbS72U0QKIZxKxLbzuXJp5qZdjgpGLSNLKg8v5ja2e8GOBicj5EhCyGmuAtiL2ep4pRFRt
 I7mTnCtEYTGxMqfpe2xH2FDJus/UzZkcT+q4la9H6eHDci3I/lOwKYBSDwxaWlGwfLfyQvK+1My
 68VKXohrkQFt4ggGN9inxGdJ118k/T1IJPUtE3eT5Gqe9TDly2YW3lMmtuowXk1Z2bMLiMl9kat
 5T2xrYW2hUUQUlCxeRFVD2LR7Tlyn9uSiub/Bc/1TV0S30zfvBV7exhfKq1iPHiKQCi5UPNzv43
 eIAUYY4/rv8B0E/4d/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX6B/i5giN/9uK
 FuOYgJden0Ff+xdSqqNUopu9WoRzMxpMMO2W0oeqKVNVnkrvOif+GNAXzPpImX6H3hapz2jAKPo
 Lhy7vM2COqVxclcaupwjxUyl8fM+fP0=
X-Proofpoint-GUID: LOU6GFUW2M5DzATUXJuhhRV9T0XFZqcx
X-Proofpoint-ORIG-GUID: LOU6GFUW2M5DzATUXJuhhRV9T0XFZqcx
X-Authority-Analysis: v=2.4 cv=EJWTQFZC c=1 sm=1 tr=0 ts=6ab69b37 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=9vyTzsUqMagNZt02PzcA:9 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250063

AIA initialization sets up per-vCPU IMSIC state by iterating over all
online vCPUs. Creating another vCPU afterwards leaves it without
initialized IMSIC state, but KVM currently permits that sequence.

Reject KVM_CREATE_VCPU once AIA initialization succeeds. Both paths are
serialized by kvm->lock, so checking the initialized state from
kvm_arch_vcpu_precreate() freezes the vCPU set used by AIA.

Fixes: 89d01306e34d ("RISC-V: KVM: Implement device interface for AIA irqchip")
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 arch/riscv/kvm/vcpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index e062ca19f9d8..ccf2def834f1 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -138,6 +138,9 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu, bool kvm_sbi_reset)
 
 int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 {
+	if (kvm_riscv_aia_initialized(kvm))
+		return -EBUSY;
+
 	return 0;
 }
 
-- 
2.43.0

