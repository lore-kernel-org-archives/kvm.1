Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4D221ABBB;
	Mon, 12 Oct 2026 03:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791775901; cv=none; b=udF+z54BpyMl/CHs9zNOKCVfi4R3SzWbPz2mGo5trc5pGrMy7jwpRTKKDM1hkf9UY28/E5EHf7Oy9TFdC/asNV2VkU83WDYmMFEUe1zKMHIPQdX3zckttkP3xyQtPV63p+Z9XG8tHnvLxYrYhoUy+6H/jAGLGU6QEisVrR4HhFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791775901; c=relaxed/simple;
	bh=S2DhvhBRRlTc1xKKf7vo5Ik5eV/etJY2KRa4JiufX6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXD/Na72Q0DSppwCl1oASNsYVxZR+H0Gx2trtae+WtLsZlAoHiu6H/81WKtdd5XF4jEAZXfDA/up9zOOkskY28f7U+uE4Xk8abixI/0A4bQhL1oQaarK8vEt0xe6QodWV9faH0HABD4OruXfnkG9YkEI2vxAl8SPI48d3ASNt5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NmvYktia; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NmvYktia"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C2EHQ61283967;
	Mon, 12 Oct 2026 03:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=d7JgXl
	Korf287xaWZYBakWg28EUeEtPgyrnE8F59PQA=; b=NmvYktiaPnAHxHrihqGzgV
	l9IP8CISCTTb9qk8wT/M65ym9tVncgndulWtwi3Zq7p11kWLGZfvw6az/D6U5STj
	FZ6YfCI/nQVum7Ds063aoTVaadxtl3XP8kr+ErjwVBrKr2UGukD3fpg+841JmP3N
	uoxQnUABwO5HJhkC9UmJbsRVOuI08EL7etdv9qUzoqMS31Cs5Yg3s4ywbjrSWPof
	MVEaWLQAuq2Yflom5KFY62bC9nTYThooaIUE9NYWDNZmu+IKcp5JSW1lBjZhlSs+
	v4Jx40G7D0NLADVEqEkhnvk4V0yH2Kw6/0zdRtN8veheCBJ0iGo6MX/eLrUUL9/w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwh6yww-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 03:31:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C252cS563558;
	Mon, 12 Oct 2026 03:31:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vknr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 03:31:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C3VNwn52232510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 03:31:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 910E520040;
	Mon, 12 Oct 2026 03:31:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52D9C20043;
	Mon, 12 Oct 2026 03:31:21 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.8.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 03:31:21 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        "Vaibhav Jain (IBM)" <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Add missing mappings for tracing exits
Date: Mon, 12 Oct 2026 09:01:20 +0530
Message-ID: <179177344614.763259.9028932882290464322.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260512115724.59299-1-gautam@linux.ibm.com>
References: <20260512115724.59299-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxMiBTYWx0ZWRfX6jFE1aE59g+Z
 Cx0krZs2wQT/+4mLmbbhJtDBEUEE5X4/oiAhzrHqfvJgXJd6HEaYWx1Lg+p3M/nGbAEj2bWZECS
 Xj4aq/URkY5mHhSiNCqgRUYOw+9nw80=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxMiBTYWx0ZWRfXyx9/qiVSwi7P
 jhAH/WAe6XnbDofcppdtijS1/0PsVdRZOviOljNBOhr3Q86u/oOk4bh/8ZI8frDxRgjNHm4LnLh
 7/q0bl5Rlgz+up/uFS5w1dg8LGsk+yeUKeZTTETYbWB7srzmiYhe/XHCtQxId2bOJWNTt+ohRPf
 MqvH2bicK5mpaHIYrtlUlkuWBZOjIOkNL3zpEh2nvfXHsS/uWyaDN0ndjOoC1jTdS/3vLYgI59c
 KMnZxO8qjsC6bF3vuKqvCiH/rR2tI41rWxHj+F/pAyeXCzdFkvfWV4LSPrcCA+0qKK4Rb6vqCCb
 ueIEzIb6kJ5eTXa9E4O8oymZAsoAf9ZUof9qGXkmiYEgq5ykAJoH7lPx7IdUBJd+zxTS6dErhlK
 uMdL3m6PvU2c1GSTnijY/cEgntCFTRP61SZVd8FeuNRdAVEekKAkn3D4HC7e9Ms8BmTGd2DEaH1
 DtZFsYswLxd8Ef1MMZA==
X-Proofpoint-GUID: u2XXVp3Cw1y6J2SDCzJqCNGQeUIdBbGc
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acc5491 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=tM1m2YJIrCFxkhTIm4UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: y0PRhc9eZwuL-ZXkrTGGwM5NZFQo-gJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120012

On Tue, 12 May 2026 17:27:24 +0530, Gautam Menghani wrote:
> The macro kvm_trace_symbol_exit is used for providing the mappings
> for the trap vectors and their names. Add mappings for H_FAC_UNAVAIL and
> RETURN_TO_HOST so that trap reasons are displayed as string instead of
> vector numbers when using the kvm_guest_exit tracepoint.
> 
> 

Applied to powerpc/next.

[1/1] KVM: PPC: Book3S HV: Add missing mappings for tracing exits
      https://git.kernel.org/powerpc/c/bda16261848768b8c54bfa22dea369d7133d8241

cheers
