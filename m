Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBF319EED3
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529645; cv=none; b=JVOYsR+F9mxyRQwGvKWGTZH8KjxdCpnThrhJ+7molqVoRNdPPLJjI5n5xWgu1wdiKUJgZN4IM2FT4HIxSxkvSJdBsb0mnjcd5awDN478veXEW1uFPpfX8FhyPECc9s6PDc+OkPYCA/SMVSJVJwfvAAwFDni7nEZXdH+710vYpQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529645; c=relaxed/simple;
	bh=K716DTanmUuxkLCrAOcl4M42HRMRaKEiccCTD0ZeLjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZbt1qQiiWNSSu0RwwuHE7njAj0p9UQHL3hNKADCIKhpCAYzj4zQbiInh/NnEia9JLSaSg6l97smCIKICpn/115q88xdUaxUrNHAqi+xDhhSKYrsXQandQwumlJ74miNGkZ9D6HBFeZfXoz29cyNhs9pk7Nz8EzIyTP9ikuI5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dIptz9GJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dIptz9GJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TMX0TS3705253;
	Thu, 30 Apr 2026 06:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BoVrbhhZTtyFzhjhqEHFbnlMkbunPWcBJaMQvhPlE
	GU=; b=dIptz9GJoSvVAdPSqx1xu2ZKJjz/s1qeejuqT1mt4/9W6Rpz0uQNasQpd
	9i8Uj4U7/MMDh0sxagMK/7s8LOG9uss7Q2qVFMX2ZMLhJGBbryDZS1l6cItF8Ny7
	w8jOlpBOF97lTmHVS8bQN5TOk7opXkFcrKEJqsQzNv9JsHNMAQaVq9aOk4SusVvS
	XxlJ+1b2wQ0YffyzUDh3XHgbLgJ3EqAn3X9MI7litu1d6pCMJy5AW6t3LCKCOoqd
	Bel4BhdEIewgAbu8Nq+0i0vkxW8efMgPKWryEXfd5/wLBQl87Adsb7Gh1E0IGGZM
	NYdOd59L4JjIPTDcMxQfMz9Um1R7Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e4jc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 06:13:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U6CecJ020219;
	Thu, 30 Apr 2026 06:13:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk9p0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 06:13:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63U6DkcZ49742256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 06:13:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B395B20040;
	Thu, 30 Apr 2026 06:13:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4ECAE20043;
	Thu, 30 Apr 2026 06:13:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.18.70])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 06:13:43 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
        kvm@vger.kernel.org
Subject: [PATCH 0/2] ppc/kvm: Handle CPU compatibility mode correctly for nested guests
Date: Thu, 30 Apr 2026 11:43:31 +0530
Message-ID: <20260430061333.37905-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 94hG800faMXWk8v6Haz5UenxaMHWjis1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1NSBTYWx0ZWRfXxhsa6TJH/xQ0
 B3gnRpNaMjOjUtjMvf0/hT43bYF9ZzMsHSndZCt8uWx/d2J7HdHul7HW4VVsnni7uSqZtFpvAE8
 oNsBvXsbcxjEwP5X+QiUNXxx7dIxS+BEjuUTePge45XAnT71U97JiWVruYwkiDp5Uq393SjBKEb
 LxSDjqQ2kU+VT3vtqvIdjGsgN31bypUGYSfa4jEt+NrBeXgNT9YPlnY27mjosaumheccMSpISHi
 JP8fMKatEY0UehcJ999QXJSdRxtslIz5IMYdbZfUb4iTVQuUQQvGgd6NKFvJCKRQ9QR1xYKT5jp
 3KTDNtp1PiR0uPwVh1uomwjd4gF+E7cNGBNze58dV5XNKP5/5XmlcTFoo1N6yBT4UjyFR31gaR5
 yOurSFlJVbliwHsNAfsIdfdFufoMp00qkcoARMfm3CvPyVqJ/5GM4JOiKEClaTYO+jVG9hAYoDy
 RT/u4xhYM6jdscvjrdA==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f2f31f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=M_kZukdR289U2EYsLHYA:9
X-Proofpoint-GUID: Smxxb0R-qk6hM6ePIKqsrWD8BqUQDg28
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300055

On POWER systems, newer processor generations can operate in compatibility
modes corresponding to earlier generations (e.g., a Power11 system running
in Power10 compatibility mode). In such cases, the effective CPU level
exposed to guests differs from the physical processor generation.

This creates issues for nested virtualization. When booting a nested KVM
guest, QEMU may derive the CPU model from the raw hardware PVR and attempt
to configure the guest accordingly. However, the host is constrained by the
compatibility level negotiated with the hypervisor, and requests exceeding
that level are rejected by KVM, leading to guest boot failures such as:

  KVM-NESTEDv2: couldn't set guest wide elements

This series addresses the issue in two ways:

1. Do not silently fall back to raw mode when KVM rejects a requested
   compatibility level during CAS. Instead, propagate the error so invalid
   configurations are visible and fail early.

2. Query the effective CPU compatibility modes supported by the host via
   KVM and use this information to select an appropriate CPU model for
   nested guests.

With these changes, QEMU avoids masking KVM errors and ensures that nested
guests are configured with CPU models consistent with the host
compatibility mode, allowing them to boot correctly.

Patch summary:
  [1/2] hw/ppc/spapr: Do not fallback to raw mode when KVM rejects compat
  [2/2] target/ppc/kvm: Use host compatibility mode for nested guests

Tested on:
  - Power11 pSeries LPAR in Power10 compatibility mode
  - Power10 PowerNV and QEMU PowerNV 11 TCG L0 host

Note: The corresponding Linux patches have been posted [1]

[1] https://lore.kernel.org/all/20260430054906.94431-1-amachhiw@linux.ibm.com/

Amit Machhiwal (2):
  hw/ppc/spapr: Do not fallback to raw mode when KVM rejects compat
  target/ppc/kvm: Use host compatibility mode for nested guests

 hw/ppc/spapr_hcall.c |  9 ++++++++
 target/ppc/kvm.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)


base-commit: 759c456b1d22fe4083c8b384da27d3f56fd53f82
--
2.50.1

