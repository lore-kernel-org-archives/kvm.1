Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC04451357C;
	Tue, 29 Sep 2026 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681473; cv=none; b=Yq0CHLK5xIBo3DIxB3n8rTZtBitsCWc3Epxt4tjtN2o+yrw4lM4yI2mP12kxr73orQLGsXgYETC/SbIcYjOPJlq0B1N0oRs1F0OwLvuV0/htAY6nyMmzIoCsglRKMviQIGV63KCgtAdvZSCkJEZTekCSkb1t9jXubhpzca63zHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681473; c=relaxed/simple;
	bh=39WAh65SpL0BJXfTCIl7yx62Bw/nb/Mc+m5exwkUOZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TiTAn7Xs4iIhOP0iSmFWmhaxgNhZbbWpsKq2VdSFVSlU/n1XqcQZ9zwXePCsSp8qdGznGQZCENO8H9+94/U7/bNDOK5LNU1NRZkUqlsW7D6Qy8m0i9NIc4qnp4briLBhVh8lha+R0rXyUblU8C7lgOSvWHvt/jVD/BsI8BzOI28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pp3s2yHs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pp3s2yHs"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5Lvt2187741;
	Tue, 29 Sep 2026 11:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Cvf5Xf
	u+khajZRhnM2vhFUes+Kbf/fmv87LY0yilRxY=; b=pp3s2yHsuRE+s68seff0Rn
	CzE9bvDk6a2aoGeiOHkWGnZVXSYdQxnt9IlOWY7g1/hmBCR6OrZyy2QZbZAO4aHi
	mHyVWo7SJUrVJq78S1bGIpGrM3OjYc2akMwJttV+5e67A+dXfySgrcsbk5/mdXzs
	nirg3qcvJwwKVEQY2euggXjUAnohWEoZ/Y+odXZESEo9YhIZD36+q/19TCn844ql
	xIm1Hp5QtNMb6cWNSuHkTH9n4wramp+QLMRn7qkFc/WvAtthudFMy/h2HbFnGTLi
	IcmLqs8ml1l1b2bUfEue3Bqf/KeqRGM1oRf2yVkz1Os+WruMSPaYdRRIg2ykueHA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr6p89-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:30:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAlWOe1617007;
	Tue, 29 Sep 2026 11:30:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw9kcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:30:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TBUsVj47776004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 11:30:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 738EE2004B;
	Tue, 29 Sep 2026 11:30:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E93E20040;
	Tue, 29 Sep 2026 11:30:52 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.88.139])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 11:30:52 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: PPC: Fix callback check in kvmppc_gsm_refresh_info
Date: Tue, 29 Sep 2026 17:00:51 +0530
Message-ID: <179066556642.265207.5042470829768833413.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918143124.9913-1-kaylovefoss@gmail.com>
References: <20260907145626.7675e892-56-amachhiw@linux.ibm.com> <20260918143124.9913-1-kaylovefoss@gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfXxQrIG4TXKTm7
 kJgmDjFNCK38PrsZ7/iZIncsD61bt1wPlYOqhTTJ+TjYQobDKPoagF8+P4FpRFXxw8iiHWCq8jO
 vJ7yEebkb7iqNeYtjjZeX6litoHUPSvfTyPL/llbprPY1F4o3f7I25hJh5Tp8gugrCmTD+8DgbI
 f9abyQiuMzIKDgLir+gy7P/nUHFCMAjZxthq8BY6V+aG3bBtAXKytn/deqt4i36Wt8xN34fHPjI
 iEExOu+ELtxAvmobbfLTy3OCjvPf2dVyPkVwLtVNw2uNAIYT6kk839YcyrH9AxNMAPryU0f9b9a
 +3qCLD7UcPk7iGk9LgUrZeEzVzlWBC/CELouE0rWBwKbViKU+FRrq7QBvdLcj9mQUk6iWCjxoOK
 3EhwY3Ac9Kiz9DfgXva3HF9C+l6r/uffUa8HJpjdlS/qsQ3jDm8HK9g99o4CaB0DWpgvMojJQml
 faIBDsk9f23sobRPmOg==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abba171 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=YIANAUWjHg1vaRIBkk0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: IS5Q3jFlb55IySXQVDdL7Wgcz21oD-tY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX69obAp5echqk
 44bhsbuKdLBxVfDNBI1r2/XghGQ8e/rhHlrGAVrSTh6otrG0BQTXu+Spke7ViQRIug5E6C/WIik
 K/E9syQNz+xCgWH1RqkQ/mZK1ADIR88=
X-Proofpoint-GUID: HEir2pvLhUj7b05oo2dcFlXWw7a4oYZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290044

On Fri, 18 Sep 2026 21:31:24 +0700, Bui Nguyen Nhu Quynh wrote:
> The kvmppc_gsm_refresh_info() function incorrectly checks for the
> presence of the fill_info callback instead of refresh_info.
> 
> This can lead to:
> - NULL pointer dereference if refresh_info is NULL but fill_info is present
> - EINVAL return if refresh_info is present but fill_info is NULL
> 
> [...]

Applied to powerpc/next.

[1/1] KVM: PPC: Fix callback check in kvmppc_gsm_refresh_info
      https://git.kernel.org/powerpc/c/a7ea67879af09438d38032107b89a62739b09e96

cheers
