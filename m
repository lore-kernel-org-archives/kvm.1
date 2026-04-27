Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9833E5573
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311458; cv=none; b=o86Dygia4NPm6tnFlypsVL/VcZ/KDgvWpTImh8G96yx6fBGB9esm7wkj8LFVlQWAS0yjNz4qvDPViCv+nL1dlt3jssJtmkDy55YbEf24xRseDHYx70iSuXT0OkQ0ZISMy+ZvuOWndvUlFySqnc6WfGRrYuDs4eGbGvR2CS80pIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311458; c=relaxed/simple;
	bh=yFtRRqldfkjaIFwxsTTNCTRJI7Fb5UyR+KfLi116/qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rw1Xs0BVTnU88hDQ9Fd4y+rJievmLcEoGT3ef1vxXK4nox4T2AMh3OdhHYiCM9fyDWSE8pMKna+3oMFNByDgVBNX5LnXIAf/CeYZsQFDGehJrVVu9JiCAGQNXXqo45jfmXVxPsVPhFzZHUM/lGOlrWvd8fo4yUk8kTC2YYdDIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eJ4G95zG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eJ4G95zG"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RFlDY92932084;
	Mon, 27 Apr 2026 17:37:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ET6ST3
	80paGznG+R1VpDgcL8IJqcUqUhLfjHop3Fm4w=; b=eJ4G95zG2P4myUCZhZ/yCc
	C3Ll/5HXzzmdktEaabUiqkMTnuiIPaEDakAzvl0SJXwghCKt3/RJ7Z1m4VzsetgU
	IROIr/AvzpfEwDGUzkoTllW7wbWPv2QkVBHSgwCEfkdMZhvWiO4PHQ6Vtp9idVeI
	WxndNkmp+LR6yt7m4+xyPF3i5o8zxZ1c25Nt+18kTsL5/8CxEhkfvjlD+7ODl9bF
	ByiodrxdLJ8Hpct46du5WOxwEsl1q7+86mK0xPXBRx4d/S9e80+kJTCwV66vHY8i
	F5X4Pf2+cyDpo18v8vEHfG+Sp91+Ti6NXldS0+BklxR05j/lODc4h4w+amrywOXw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9r1ref-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 17:37:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RHNhhT009956;
	Mon, 27 Apr 2026 17:37:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xjx9at-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 17:37:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63RHbMSQ47251952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 17:37:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20ED820043;
	Mon, 27 Apr 2026 17:37:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B202720040;
	Mon, 27 Apr 2026 17:37:21 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.47.231])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 17:37:21 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Mon, 27 Apr 2026 19:36:46 +0200
Subject: [kvm-unit-tests PATCH v2 4/4] b4: Add b4 config with default
 prefix
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-b4-cmdline-v2-4-0fea2a50a9d0@linux.ibm.com>
References: <20260427-b4-cmdline-v2-0-0fea2a50a9d0@linux.ibm.com>
In-Reply-To: <20260427-b4-cmdline-v2-0-0fea2a50a9d0@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=396;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=yFtRRqldfkjaIFwxsTTNCTRJI7Fb5UyR+KfLi116/qg=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJnv551XF3G/elM9fCVTQ5V47jk1Xb61Hvf9PK+FPL/Zt
 Ywj39G9o5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgInEZjP8D1M+u4r5+qOzhyXa
 K38X+1hZzJ0acvtlkvvjrshIv/Qp8xkZ2oUDP/wNYhCevmCD7ow5NeINnfrp+r7R8wKPmd5KORX
 JCwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Ib9nOhEuTRt-UURBQb6dYR5q9vZNZlK2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE4NCBTYWx0ZWRfX7NKMv8rml3u5
 zuNnSHaALfPUWF3fYI9jYVgaDdJyK2r73KmEjk6hy5OMOtq0g0saGS7JnhTxmh8GdkE3eBYCfYB
 RiNqfx4uX89nK24qblOgWwslr+UHGKD4zdaY9/3S6D7ajvWTurzgu63Z2WOruv2IY9KU4iyyh8l
 drPr6q2jqbqIp+s+eOiz4j4d74WrzpU3oPZs4/qBF+Dl5o6k5ayT9LVKR5+FUm7j+ISWcDPiwSm
 fRaPYc7ksxQJbcVAds0wiR0cUSMY3lTovLebEC8ceDbychTZAlUYs8PAnNOhKl6WTLt80ySi4YN
 lCSDKgoRtJ9V0smqM0m44BF2RpOk1eC+ErkKIdsh2ULzJTUhzOGzguuJg6s9/ZEfHKNCQvZ2KHy
 +7pGnPK7Mx0AXplQEp3+uyAVma6cowqCn3vPR5LLRP3OPZ5vL3c3zpNOXBAvOLyD8GOuSkFhcx4
 fCMWX2ngyhr0OYDETJQ==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69ef9ed7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=V6kfYKY3lgMUIaNSnIEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0l0aTKouLa92tN4hVQodNlbDiX1TKa4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270184

b4.send-prefixes adds the prefixes when creating a new patch series.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .b4-config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 000000000000..b780cc3d4e6f
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,2 @@
+[b4]
+send-prefixes = kvm-unit-tests

-- 
2.53.0

