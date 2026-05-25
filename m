Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA066340260
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703189; cv=none; b=KC7kHWphCOOcPbiI1WoDCKulAJCsmy1Of+XvCqFgduKApJ6AgxqjHUWQfBhW5f4uTo4TTqW7TarTKWA4aBFFFuoCmzNwys1+MPvFL3t9JJbpRp44R32bkRq0dyLTklpQ6oRtJ49KqYpFz0snfH16mFTsxWCJTSyDLaHzQE3NbtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703189; c=relaxed/simple;
	bh=P7Cd6RXV9AfSdcu38Cms8bb3Wa97kPnhAN8zSlepGnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BqX6AziNaMZ3bcSG/y1m5CLfTaMNgvU5Tee2uYr1p9x9UOUm00ryLNudDiFSpysg3F7bmgiq/PCibyDBpvkPLjChte0VXu9pk3ykFbbFTtxwqvFdL4L5AffmBLmOFe1bOddOiSjtcVrBtKWZsIQgZ5Sy3hlV5KEz33OBzzKqz8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dmK7uSQG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PP+7V5ra; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dmK7uSQG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PP+7V5ra"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P7QNFr3063423
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 09:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=3/gvsRa9rAHCNHfljIYQFKolUiZ0vZQ20gw
	HqqZu+wY=; b=dmK7uSQGA+xzlJvOD6xix17u2lbxkjd1glYwe3lhU6B2ShhJBrG
	w9hsUI92oJ2lV10TRAEo3jzDTZw52bp67jwlSZwIxZDxUo8JCgiebPPNmMRgNYkA
	QAoSdwDp2bv0Cq6C+jQ2403A/sMdeffcX5jzrDiaYySAEFf7xgJNM8tok/p/0mR9
	cLSxvKLrnEFyqeZRtDb/BMiGYBrG9x7OLrXyPqmtGJqAbyKgRIBbpMFCdAwCX97K
	L1fLdSixnpTBM6NBPJytyqaJUbeOo1I825evf00sHOnGnjircyt3nR61AB1lTXem
	q7I/WYgk/cgAZhcieImyj6MmVkbifXac6Zw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecj1ggkyj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 09:59:46 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-83f24cd00f8so4847372b3a.0
        for <kvm@vger.kernel.org>; Mon, 25 May 2026 02:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779703186; x=1780307986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/gvsRa9rAHCNHfljIYQFKolUiZ0vZQ20gwHqqZu+wY=;
        b=PP+7V5ra5fGAHReDAYJUj637alg79q21albjLiNmFnII51KIewnVRk37Z3ViRn4gXs
         67WUF+yfeZYkXtQ+vVIIBBfGUi1WJlQzv4s8OtMj0sFDNSCiTIO+eBZ4P+5rMEboCz9b
         jStBYAu45Ue8lgFp3X+bC3pC053uGa/SrfnA+tC+iVP8vTn9oLKMw4pUdbEagvTlzTZ+
         3UArfTY2rn0ruzu5mxc5GkW4E4qpcig33qjP9xoO/R/nDMLzDkHk4pNHM5rl4KNetRBX
         YmUrTZHa9dNwOxy14i2apw2j30vClVbNyPgX92w4ajKqAVbAluxrOmpmomu921t3kY2y
         2Wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779703186; x=1780307986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/gvsRa9rAHCNHfljIYQFKolUiZ0vZQ20gwHqqZu+wY=;
        b=CY+XI7A9Y26cUpsq8ro81A7pFQENZlTJ7xPCypC7eE8MXKuDlEjkSclz0H3/qXultB
         AMr9icqWvBwYfDwyBIyIDfXQckcpgL8f9/MjN+wZNKyrKC2ad0p0HbxJWTO6Z7ML1sLa
         sxbq8FLq7h9bvARmLQHX95ihDAgdxiAQuiW/H5lWyPbijwCdCsLwFyAgAbNON1+bwxw4
         w53/UcpD0nU7YMTPwwWzpOncrDuXoN3pTKO6S/jgye0hjNloAjovMOiNeOJ07ov5EEJH
         E84TJ0FMv1SBTrNYHZucPnJntL5SnT13ztUo58tkwdObLP5q7O8dDddca7wqoOaPJYRW
         odEg==
X-Forwarded-Encrypted: i=1; AFNElJ9Z5XYgbm7ypmKdIM21sSBvkPojwTTCVVH3SWEj8a0BA6JM4FaHzebmtvDF3UWPOq0Fp4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNTM2w8b7EJJAFhe2tBFGOzCQSoB2Hukl6zT9PcPKjT/APFIr9
	4wthjIj7aoSX6tq1jyHtXiT2XqBfT6YmgnOcpWi3cJImGER64NOSl89ga+eJowHGj7KStzxW+Tz
	97TmFRp4EuFcG+QpKXnpAhj75i+e2AD6Gbz1AdMw5MHW8IZirQRwnaYA=
X-Gm-Gg: Acq92OHCm4uxz0/z9qKktxKs9eRcR+WljLU40qTqj9/iBGUJNPoKlcnP7G+HTeleq+n
	OzKlUUxFO6u5KHGWG62hUgQGBHmmTbdP2wtZwFTWveTuzjjg2d37n606UYhRCuXbMOh8D9d8zUQ
	pGoNZCWq8+XWkwVscru+6iIIJGkWzjcPq5KfmLINV6Yd4cYcIO8R43l92o8BTYRV0BqOexxdKmS
	5wQyHekKu3FzWd8xtF5d/gMMjoWM0Ib16BvX42UI4SggX6EvJRKss90HzIe3GzM4w+KkVx6t4uw
	Nyj0SPg1Rib4lkw94casH6rE24re9vrEYwxuuhZze2CxySmkSkWS+F/GF0f9DXq778UZdTZzFhO
	leNJZdYw5cRGfFRJleXlj9smcizb+jsvG11qN/+sBl1P+qRUKNqKKumvoBD1XmZ6EtqK5NopRdE
	xL5ETT9NIQsPoAiAUkr4n32/rwcLZupOUTA4kHbSonDGgCmbQ=
X-Received: by 2002:a05:6a00:8c12:b0:835:3949:3c22 with SMTP id d2e1a72fcca58-8415f32e8c8mr13624182b3a.27.1779703185546;
        Mon, 25 May 2026 02:59:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:8c12:b0:835:3949:3c22 with SMTP id d2e1a72fcca58-8415f32e8c8mr13624123b3a.27.1779703184887;
        Mon, 25 May 2026 02:59:44 -0700 (PDT)
Received: from hu-mchitale-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84164e9e635sm10019260b3a.38.2026.05.25.02.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 02:59:44 -0700 (PDT)
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>
Cc: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: KVM: Fix ebreak self test failure
Date: Mon, 25 May 2026 15:29:28 +0530
Message-ID: <20260525095930.3924905-1-mayuresh.chitale@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1lBhT17mNP_xtvE0wEq3irs0N4D7Qch8
X-Proofpoint-GUID: 1lBhT17mNP_xtvE0wEq3irs0N4D7Qch8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEwMSBTYWx0ZWRfXzs3vRHdDTdgQ
 23ytNFJXRTbCuUt3Oxwab775JW5EVRz3G0OmqIYXOQz3GJMOATKjFV0ubIrznv6SqJKYrRO7x1Z
 3E6xIYxZq7QVwi1YEsaalfuFbHPsKf0Ipp6gN5z3iozg2fFcTwJpaBimG2TEpBSAs5vBB+jH1if
 81Z2zwnGU7An7RuqJP+zF3DZBSe4YESiTu2eDBEcCnNAZAXgJmql8wGUjVX9s0/KXQsqQe9+2X2
 3j3okrfLyMvnjUDxDO/kYvuyiJp7v4dwDP6BksHEJCnZi/LR5O66B1a1liCTzoLZS33XUF6VxYy
 3hNSq3cVRk4WWkjtZMeO9EJLmebJrvWNvR2zQwf4IAYIf76CicMqQwhpsA5Hxdy/pV3vIZG9skr
 ZhKThOBbAipEe+axVyavVZa3pDauq5jHKTIDen6KeouBN7Fjd8g12d/eh4lMaKNhvD4bLeplQv2
 lwqJE3+dW+rdoqSXGaw==
X-Authority-Analysis: v=2.4 cv=D8F37PRj c=1 sm=1 tr=0 ts=6a141d92 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=H_xIGRXdBt4bEJCxPLsA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250101

The ebreak self test enables/disables guest debugging as a part of the
test. However the KVM_SET_GUEST_DEBUG ioctl doesn't actually do it.
Fixing it by calling kvm_riscv_vcpu_config_guest_debug.

Fixes: 6ed523e2b612 ("RISC-V: KVM: Factor-out VCPU config into separate sources")
Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
---
 arch/riscv/kvm/vcpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index a73690eda84b..cf6e231e76e2 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -538,6 +538,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	else
 		vcpu->guest_debug = 0;
 
+	kvm_riscv_vcpu_config_guest_debug(vcpu);
 	return 0;
 }
 
-- 
2.43.0

