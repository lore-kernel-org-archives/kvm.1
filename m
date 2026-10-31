Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793468756;
	b=0ek4Wz9Y79vmIrn/dr3ghD5MXYHlgOmkLl67Ip8i0OTkWNBKQTRRGWOL96H+y3AwgkkY
	 PEa689RHR0tsCSY21kiJEb4bYCWpdZOKoH63gD+6rHjjUftq+wOY8pizvd9zC/nXsXeOf
	 49IvzWNDycb2K/x7sS9h7T8e+3mLI6PjzHaMz3+aRXEs4D+vRPFXeBYs2+mhILleFrG8L
	 KcUm02YE1fXan+Ah9gInGV21QmuABp8/voTu6Y8gH7SPJ3x9n9NBdxpl0wfb36bdN4COo
	 k5asiYgUiPuvWy0/foVc0jlJkYoLdmJ1hHISiIHTDZ5z0rx0pPWexrvyHSc6rqagGzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793468756;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=12TO2e0T31cSdEte/htfI+5i3smqp4TVqWraSxvTy3w=;
	b=4ISmaWJ8yeXgteTkjF6wUiJf0vAnpj19UBgwTYvwFwnzybZDYKhsp3sw3oKDGARwN56c
	 rQFNFqix5DxfMxr3lGjM8MQyGjUKeVC8JGtbnh52oOGcSiV+/UQiu09suXBzeIUYQ2a4e
	 z+am06wmjO7MFWFToAljMEWen2U2gntuRVADO4GVNwBPkQJlKB5sc5RU0rsscEuCXUQLE
	 syw7YYjZe25AkWkzoS6Oe7qLy3npBiznPHkjLzujamJhHmPrUXdEGl3KZK3CuB7W6p23G
	 6Owh4rW31B/jxAWjoycOanfE3BtnGf/k6auHrk7QCgG21TZxMVaAaFZs3shR+hoIptg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=jrv2nOZ1;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b="neP/A2aO";
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4E2606A321
	for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 17:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE4E2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=jrv2nOZ1;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=neP/A2aO
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VDk6XS3860735
	for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 13:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=12TO2e0T31cSdEte/htfI+5i3s
	mqp4TVqWraSxvTy3w=; b=jrv2nOZ1hp7gZbhO1vM3/PcfFfO2Eo+JrSCQRcC1ob
	JZIOAFdqM7Cv70L7PuIETHnhd9trPMvIE4Vhr5Ze645lh6+3Z3Yyu4d6HgjnPR+W
	LnQeSKOap9tnbXCFr2Yu+24s9nG4SHxLCy42p6uCdErv6i+HSk+zX7/YTMo7Mmyo
	X56d+LUijffqg2f4G3pQC6yxJs/PWK5DGOYbNI1t2gXcFbRO6bSo1OdlXPsvhW1J
	dRz2RdOGf5rWwSJFVdPkSwT6YDcnZiNKaiOWQrdff+vERJPAujUGw0u8QERN1//v
	tFTTHhwz6oVCE1EidtJ61Jgic9T/tAcuIp2psuzp8EXA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hn9eqtu4q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 13:45:54 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93c5ab5c136so294313485a.3
        for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793468754; x=1794073554; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=12TO2e0T31cSdEte/htfI+5i3smqp4TVqWraSxvTy3w=;
        b=neP/A2aOSquMz2IRM3GwjWt3KSLmQ+sHBLc0gTN024tS1j2Ga1TlfzM0rbhUpalhBb
         MaMW0UySxvH6gCKTLWrXP1KvoUMJMyxZq6Kh87F6QViiC8q1HcJrGWj491QxL2ztzQid
         xYUcuWjDr6H5ykt/DYN3+8zpB3VcZ9uhk/KMyB3bH58mz9r3g4a7L1if8mbhw1ERRZs7
         29JUjpUrRNh9L/MmkOIbrleXFGUhDt5/NDUouq/1mRCJcYqL+EtlH0zqjLJ1UYSvL76p
         UM3mdFlMF1wfPmxDpHYtD3dXpRphcm0GeIwJ1geGp1JFt/9ftzdUPzhDxbSemzHyklBe
         PK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793468754; x=1794073554;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=12TO2e0T31cSdEte/htfI+5i3smqp4TVqWraSxvTy3w=;
        b=iLx+JBwVNT5uQAwH1r6jjRUdUYdp+8U08PAJYOV1mC8yueMuVL+yXsKRL3R0z/Nkdr
         5Q3OUQVd2JtN4RCVMe892Tn9y2g8T2mBpYHtJYKyPcn2X14E2cbwWkhrG4tttebMuqMM
         uSayO/7vu1/sf8FxZjKVQ1Y6bM0XeTBDoSgaaCXlZfHZcQL2KZ1GTLyY/jCHUXME0gBD
         6vah6mq0OclgjMiS22dJzZZ244y3vTRtQrwEqMU3dchyuBEEAFdpgJEj5lNFnJTkmpNb
         MruicpYo1yN/3CxvHSWETl5WMVY1G3g+IOxbOgxCPdj0rntRtQj1L1LyhCniEU1YpuJo
         i9Gw==
X-Gm-Message-State: AFq9FYKEfADZGiPKAHvWvMcOdWVmEXQI0bIrGlPV+Wns3S0DQgL59sSB
	p2FCFzp8343QvtjJnmbAWfXIgl28u/B+x3JU7Qyy0TDs3t5ctRgMvAcAKNRT5vRU7C7aHY406np
	8P2LNTuULNraQCxF61J8Bn2rOxPh+KxH/FJzoJ6+je9LBMVqAwg==
X-Gm-Gg: AYBFou3YYmG2LU5wG5ah4xCA0k1LDDcFUw0lvCBu8dVsi7vrbUQg0VkQOL/5pK2Ejyf
	CXSaf94g6tLpd7i1/zekihkZOmW5r7GIYclfGG9uUH+gLrEVxCdIlCVzal9RT1/IN545AO/mQeb
	XmkImMcYMwsNy900DThJCSnEuAu0Ofj651JqJ586wVkDTsLQE2w1wKNzcTMnEAwcQYfA0We+i2B
	uk8LJY1PpYRiwpOvugFSe8N+zfBTxmCvw1fdlpYswMnNPJiMpqIe+ImCzGyStRUUQACbNKAVW8E
	XtBYVmjIeyM8rpR/0imgo9nSzeQC7J+vNKsxFL8l8s0DZNfrr/xmFQHXBICPEhAFOgNLT1gqs3L
	FALydvkt4nHMqTpjNdfLfhDwPpFiJqup6obr5YNW7fzEdHnD4MlUh59NF6w==
X-Received: by 2002:a05:620a:270b:b0:93f:565f:e40 with SMTP id af79cd13be357-944217dc91fmr882365485a.65.1793468753915;
        Sat, 31 Oct 2026 10:45:53 -0700 (PDT)
X-Received: by 2002:a05:620a:270b:b0:93f:565f:e40 with SMTP id af79cd13be357-944217dc91fmr882361285a.65.1793468753266;
        Sat, 31 Oct 2026 10:45:53 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.159.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b79059sm10220667f8f.30.2026.10.31.10.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 10:45:52 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 0/2] vhost-vdpa: fix a pin leak and unpin mappings by range
Date: Sat, 31 Oct 2026 13:45:33 -0400
Message-Id: <20261031-vhost-vdpa-unpin-v1-0-94ffc9683256@columbia.edu>
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
X-B4-Tracking: v=1; b=H4sIAD0p5moC/yXMTQ5AMBBA4avIrE3SSvxeRSyKwVhU06GRiLsrl
 t/ivQuEPJNAk1zgKbDwZiN0msCwGDsT8hgNmcoKrXSOYdlkxzA6g4d1bLGoiMoqN0rXBmLmPE1
 8fsu2+y1Hv9Kwvx+47wdX36AmdAAAAA==
X-Change-ID: 20261015-vhost-vdpa-unpin-68ee785a019a
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
        =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793468749; l=869;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=yEsTLW5bz4gADvidYrxq5nthN1/BGAv4JgsFze3VSmg=;
 b=jeyY9hiphQ8blprG87I1oONkrIN8Q7ZL/IGjRLJbSRY/hU0x0AZTh7Gso9PmhW412uIWzzlh+
 JxQxyJSbDs9CNUNDmGS7lxZEUsybN2nVwItY57qixt33KLSfa4cYQmD
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfX7yJXYTrVp6hG
 qfDhtJ2dmTaB3p2TR8wI7iYmkNdqi9pCMrBRWitDkKw61486vrXKzWvUZhg+Vj+Jcglvkh25iVe
 lNFTuOJLz7OC11FUceqnk4jVsheIY5AMqZQBQ0/B5ojw7/JNYRcPCuvR1UdfN3PaBmZCf8qUcqZ
 yi8+6qk4n71s8uQl4MRX2TKfiPu7/2K4f7b9INvt3kRmVX0l/suzz1jqZyhAgoxOFAlWya5gLIR
 K2MfzXfR7GILVuoheW33rIxG/X21eXzeq9Ytz/SCMu49jBINm/qw/odNHppWrAXbEvW6FcVwLDp
 lTzwweX/Tp4rRxKnqekIfO85vJvxQKYQK9iA8JYiCyUEMtHR0s1mldTqYztuNHt7ZlqLNKAEF12
 3SGjHsv461K5DIH8fDZC4JzS+xt3JHESpC1XCY8wBAo4lIYLjHXsJa1hNoiPwie+eH2VHpzrGM5
 L3R56fdZAXgMyBVU4lA==
X-Proofpoint-GUID: HIlD92MRoxCvf_BwWZLJ51TiUpR2_p00
X-Authority-Analysis: v=2.4 cv=YM0KWhGx c=1 sm=1 tr=0 ts=6ae62952 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=P+xgYyhW+KadpqoI50EQPQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=mS1D9im87lyf6bhA-bcA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: HIlD92MRoxCvf_BwWZLJ51TiUpR2_p00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA3MCBTYWx0ZWRfX6+ntNvNuvZZA
 5GH24ckmdAOXmehL1AmZ/HvWdmONdyuf1wVfU6Nte0abZTTiKEsuebo0zsFRMHNz0SuQ7v4faH2
 d40/KYhlMdZzAQDdveyi+esBwBMANymhCxBhN6iwaRPvaYR0BcIg
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11952
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=10 impostorscore=10 adultscore=0 clxscore=1011
 priorityscore=1501 bulkscore=10 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310070

While testing the second patch I ran into a pinned page leak in the
vhost_vdpa_pa_map() error path. The first patch fixes that and is
tagged for stable.

The second patch unpins each IOTLB mapping as a range with
unpin_user_page_range_dirty_lock(), which marks each folio dirty once
and drops its pins in one go, instead of a set_page_dirty_lock() and
unpin_user_page() per page. It removes the last use of
set_page_dirty_lock() in vhost.

---
Tal Zussman (2):
      vhost-vdpa: fix pinned page leak in vhost_vdpa_pa_map() error path
      vhost-vdpa: unpin mappings by range

 drivers/vhost/vdpa.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)
---
base-commit: c69023b5e16e5ffe9368603dca76d85bd544ee57
change-id: 20261015-vhost-vdpa-unpin-68ee785a019a

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

