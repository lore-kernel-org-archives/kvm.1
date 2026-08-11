Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDA7445AD3;
	Tue, 11 Aug 2026 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457038; cv=none; b=cxpQ+8HYU45OM3LvF6tMjPyA8PerOneedDBC1Xml+xzn9SD6jsjkaSlSFGwSp5i9tpvXq5ywduO77TyA7oJEoe3tqj3S+FsGOSMO3E3yn0RdkBXvszRCLYyyDPUBIifOpAHK1DOWw7Llmqlj9DZDvhXaPNitY+OuUaotm0gVlLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457038; c=relaxed/simple;
	bh=7JHJsVwv8q9ro12ZyXg8t3aIaavLSfxDmwSP+nXunHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AG/jZBtVOlvSv3/0rtck+EpozXO3mGho54rjhFg/QnAc8A7mTFzhm0E4In6ckvoxgMHXjesZv5ejIaS6Y60zUsm3eyI5WcaJkFwWBooA9nMcpIblN0D34WQbn7guvkO6GJUsQ+UNUsZ5p0PYf3tKwdC3WWswX+3FiD9YteLJTmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rKBHPFAg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rKBHPFAg"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWct5492485;
	Tue, 11 Aug 2026 14:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dKAHFXuRiLyTFft9S
	xrzg1DrtOzev+TQHXYWHsfwFkw=; b=rKBHPFAgz+E5rgmuXJO7q9WMQa8Y/3NIo
	Bg/MM0iDRHiUctH6L42X8JgKfmQUyz/1jl33d1SVvLfHLSTe2SMXU5GIhZN/wKXy
	GsIWNLMvgHT83bqOGv9SWaM4FxcvDZpgaBEKtqOehNzt39js86I+IAROaMS99Hup
	CULsI+3us876Q1T9iPXsXRMcSaFL3joDbruxwlIRymmKcg+eFVfFwtuEwCH8tSQZ
	lHcU0pkM8bvPclYkhIJebekMANBbHqMNj7Pjz7+5kqHy1BGu+/QSIFb0e/7F7r17
	oYPkzca9L38gmxZ4ZPL0rwbhxJs2KjJCCQzYovgpSB7NSw0fWoSkQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9d839-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 14:03:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDuG8g029804;
	Tue, 11 Aug 2026 14:03:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy0yv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 14:03:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BE3hWF40305104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 14:03:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 253A52004B;
	Tue, 11 Aug 2026 14:03:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F07A220040;
	Tue, 11 Aug 2026 14:03:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.219.6])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 14:03:40 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, atrajeev@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] powerpc/perf: Update prev_count of event to get accurate values
Date: Tue, 11 Aug 2026 19:33:09 +0530
Message-ID: <20260811140313.15397-4-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260811140313.15397-1-gautam@linux.ibm.com>
References: <20260811140313.15397-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: u4Na4jzxmqRsBFgKisVgJDNiZERexDqA
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7b2bc4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=2AWsWaKDJcEKxLcdIakA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExNyBTYWx0ZWRfX5VXTNq0FaKf8
 Qysatjkipqj+OzTqOUeaHVRPTakkrv9q1p693Ntr8EIoaZ2Cyndj4mMwXbausru4ksnUcAYWkaY
 yxCiiUAlie/++h+VxfZ8hmXWdaFZzCqsFXB87TjVPpr5JCN5pkvA3pXkIOWUK7M+9mmLdIZtgqw
 9YxANRKgNZC65QHFwJnXawGu0IFvgxhuH/d2EZUHNM5DCUMD9QhEeoz2Bicgd1PePMZ1g44ycHK
 zzSKbKxCr68TZCRwmKw7Fi5HlZEPbVjUr1Q09MbdOgCeeHEjh+rVKq/zbQq9FoX/Rd0zqrGdyuQ
 xj/XnKbrDlecmjYerkTiqCoNEpAqSeGdWp8JtbzOXrj1aI6yd34+aa1wNrYwAzhwh1Hpb+VEoh0
 fKHIio2PXGJ3geINzIxgoBXz05YeWnpVcRinUbOZv5zZmaZTB4n+yEVOO26E+gb3sR1nKjsoX6K
 Pr6Ktr5Vj48836BSecg==
X-Proofpoint-ORIG-GUID: pIdlkqF6E0zehb9GQMbNwchtfqSQ5FfX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExNyBTYWx0ZWRfXw3ycQyk6lPb0
 smC+YbrhzeemXW+C0Ww5dmPd981VMHLC3HKID6iGE5lFcWMtN99hg+Nedkfu//8nCRQKNPoMVBh
 /1RFk5tDkh7XOquPjhqSFlyBt++z1zA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110117

When vpa_pmu_read() is called twice while a process is running on a cpu,
the "event->hw.prev_count" variable returns a stale value on the 2nd
read which results in a larger value getting added to event->count.

Fix this by updating the event->hw.prev_count every time vpa_pmu_read()
is called.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/perf/vpa-pmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/perf/vpa-pmu.c b/arch/powerpc/perf/vpa-pmu.c
index 334ef7719db9..f5cfa4d5e369 100644
--- a/arch/powerpc/perf/vpa-pmu.c
+++ b/arch/powerpc/perf/vpa-pmu.c
@@ -145,6 +145,7 @@ static void vpa_pmu_read(struct perf_event *event)
 	final_data = new_data - prev_data;
 
 	local64_add(final_data, &event->count);
+	local64_set(&event->hw.prev_count, new_data);
 }
 
 static void vpa_pmu_del(struct perf_event *event, int flags)
-- 
2.54.0

