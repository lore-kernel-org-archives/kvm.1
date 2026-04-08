Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8276834F27F
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 04:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775622564; cv=none; b=NpRRJY6GN+Zcu27yG3Ii8qzHTZcyMevHCQomYNv5a2/hG6LIwjoycK3wFj9TvQf0Z4m//17hE1p/0ISS/shN1FHPicDkByxhZ2PvTwG5qP0QJg/yUHD7Ekc8dz/VsvdbBZwg6xFZnaH8HRPulyPWE37Pf8N9YpmoeLMiNwWOovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775622564; c=relaxed/simple;
	bh=Q5vvkADNjmf2tMKvyLEqSxGEcpX6Du2zVw+kx/aiaFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFwfoe52TfHViiHsMdVL7Px7QaNldBD3wRlLe9VDSEJxoOpxjJQujMHoasvyN9DTjkv91XbH9A09ia2x9Gy/16wDr0qFwFEG2ccXrNEnA8+ets5vlEQ+tvuHq1mo4Lr3rZ+jFdYTNi1Sw5qbODChdbHJkuLfV0qXXKSkpB6HNrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HH44Swm7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HH44Swm7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637Eno5j2329508;
	Wed, 8 Apr 2026 04:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fbU3U9
	g+IPjQX/84R/EftEMLT3wDPQDbCdM5WWuF8w4=; b=HH44Swm7Ykd9Lg9Npx0R+b
	WzZmJPNppRyGix4yqXbnHnl/NyIdYmSgtd26l/YdUNLkfJZOp4VoPo5IZ+mYTKnS
	IPGILyML3qwONd7Krk2b7IM33m+lwzOyBu9DgmSZZTonR3B6R0jRPYNA5zgOoBcF
	1VKPXmINwdLaRSW4tWzXIKMizMrLZJ52Oqh+4cRalPU+6tfFpW06MTFJl9DS4hkl
	H/UqHzsOWuMd76f+OINgG6owENJ+tN60QA2cCCbPTnwEPi7NBDnJbzhyv4PvXHWc
	/JqORlFLO8WLSxqpkMGLpIOcIy2x1BwqUkcESYsjf56ajXlCwqV8kctmggJSO5QA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kdrer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637NnE2P007917;
	Wed, 8 Apr 2026 04:29:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2dyyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384T8qv34079034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:29:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A215B20043;
	Wed,  8 Apr 2026 04:29:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09F2320040;
	Wed,  8 Apr 2026 04:29:07 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:29:06 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Christophe Leroy <chleroy@kernel.org>, linux-mm@kvack.org,
        kvm@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 1/2] drivers/vfio_pci_core: Change PXD_ORDER check from switch case to if/else block
Date: Wed,  8 Apr 2026 09:59:06 +0530
Message-ID: <177562236414.1381144.5625779243354479459.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <b155e19993ee1f5584c72050192eb468b31c5029.1773058761.git.ritesh.list@gmail.com>
References: <b155e19993ee1f5584c72050192eb468b31c5029.1773058761.git.ritesh.list@gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfXxHzVAfxPfHY6
 EKqjgTI2MkqUEF04YC3L+FdtHaHfmYfrT9+WRNltZwCelmXviAjJV0qZI73MqNGcI672XNHsoaS
 VbW3a1L0ijrR4aIT6h12p6L4lFy1XGaGzRl/NDTq0A2wwpU0zIL9cMzrsWxu5/qL2O6PqMrcH8r
 ZqRP6gX9WlzX1vNSAB71LgTZIuL6FlUVBg8sPVGo1nRy7hj4d6Qa7rgrZQ78sFjrCWRSg5tvoCP
 SXkwZGgvfZ7u5gYYsJgE5vEmarW42K3W2w3tE43s645h8fVaRkBLKEfW6yuE58fBGouYZqhCUiY
 jM+fd7sYvq7s5jm9tcSJtexfvbOltrYSW0eA3WW05Al8d0WFwiBpCbMoRG/LdVxG1UfJpAmbGTW
 1puX9KVpYIUN7NUwHME80Ihkwhr0QIdIFhK5Shk7yIJaj5KBtBGUW5bKB9dYmZc7Q7b9UfCPjQ1
 z8gbaq6BhqLQE85+vVg==
X-Proofpoint-ORIG-GUID: 7LjTGaq9Zv79J28arr1hhQxynanjC-Cr
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d5d997 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=FPAXCejgittSz9clB9QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KQK6zNVxSIIYeGvpK0VHj7vdbHkJuYoH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Mon, 09 Mar 2026 18:08:37 +0530, Ritesh Harjani (IBM) wrote:
> Architectures like PowerPC uses runtime defined values for
> PMD_ORDER/PUD_ORDER. This is because it can use either RADIX or HASH MMU
> at runtime using kernel cmdline. So the pXd_index_size is not known at
> compile time. Without this fix, when we add huge pfn support on powerpc
> in the next patch, vfio_pci_core driver compilation can fail with the
> following errors.
> 
> [...]

Applied to powerpc/next.

[1/2] drivers/vfio_pci_core: Change PXD_ORDER check from switch case to if/else block
      https://git.kernel.org/powerpc/c/948b71aa81cd89b222942db6055e8d9c51c54e78
[2/2] powerpc/64s: Add support for huge pfnmaps
      https://git.kernel.org/powerpc/c/d1503aa9ab8057cb93367e0184528f61f7510845

cheers
