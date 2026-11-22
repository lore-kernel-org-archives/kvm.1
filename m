Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795323350;
	b=jo8PTpamcx7rJ+i9YesIEbivooysGP8smWEsIEwW5RDPPeDbP/5hKEFdXQBr13/f39RJ
	 PkT3d3rAVjUQKSSt0a6X8De2QyLbzfS3Lg88RoPUP81ks7PBFzo9HP0qiuXCzW3SrF+oo
	 BsuzChDsfjb6AMtD2xcgPtJBzhKXSQbqtmZNX0BBd6SBmPtv76f2HPh1LpatMEr/QelT9
	 6Y8DC8102Dejs89hNoTwVpBaPZP2uh7Y0Fr7+52v5l+2pNKBuOnsIpgw7fVFIo2HQNWN2
	 U/UqiFlLLz5nbkSegWEMlZLqIWycMZP3BsYDCrgQxMhBhlerUAG4wiaYhijFnab/bxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795323350;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=KewcbK56oZjNmCRF93X2jQ9HTPDY+IubXbrWyxoc+jw=;
	b=FcoFmIAAdn1tW4DL/HKD37WCID+/kQeNoGNms6N4MZ2zxBatkxQrC+1hDcYhoW4hg4CN
	 nQfFV47njs1ic6lXoj1et1W/Gq74ziHfxdfbar8l6Blg+ZphFLZFMQQWqG9Pkg0AIfwGg
	 XlNLNgmWsp9RXrz1vnVKdMPr/lCLVFAD1dLkK5SBxBb9W5jkjcuuMDhd5K8U5/RL2qgYC
	 TSYPhi2uvvF/Rs2aKp1SX1Cd8Gh2r9AQI8cRG6MIa8hUXy96cIZDX+CU+YSQHEZT6QByj
	 uwSr8rcbX/zMVUqg4NMUX1JsvVVcWNCBmuFWHnbnqiaqBjiXIX2QKKHGDjrqhQODovQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XwLamNMf;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA7B606A320;
	Sun, 22 Nov 2026 04:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BA7B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XwLamNMf
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM44oX63672982;
	Sun, 22 Nov 2026 04:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KewcbK
	56oZjNmCRF93X2jQ9HTPDY+IubXbrWyxoc+jw=; b=XwLamNMf87+ta/lbVmPRAO
	OKfQUc7gQF9SokjYt5kI7cdaZRPOpJaf6e3l4+gUi/dYzzidnia4CJOxTf1hnSXS
	yYRaxVHHFui8sAEv0JPsbRSLIE0YbjqBTMqOl1j3d/5nOoGhcaaBgldazGR2A9ie
	BuL7Vqf4FPdNux+TxxaurtoVOW+ZRoLS1+paW/qM9+JBFyNz+4Lo+Tl7HAMtXt4A
	ALJ85afqBq8wt1TE21zyNEjC+MIDIavebeN7qKSOnzsmF5+gGL+fVBVuFCFgW8E8
	gk0QRz6dMmtZo0mkxzqz62Qtq7QSkE1jVVKKsxBB4sT7+vDiMTKv52rHYO00P5gQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34guvumc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:55:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM3nJfv2766997;
	Sun, 22 Nov 2026 04:55:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3qufgegd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:55:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AM4tTx645613436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Nov 2026 04:55:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDE7020043;
	Sun, 22 Nov 2026 04:55:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B34920040;
	Sun, 22 Nov 2026 04:55:27 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.90.96])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 22 Nov 2026 04:55:26 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Gaurav Yadav <yadavgaurav386@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: BookE: Use vcpu_err() instead of printk() in kvmppc_dump_vcpu()
Date: Sun, 22 Nov 2026 10:25:25 +0530
Message-ID: <179532322375.92012.11986007993512084245.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20260807084050.25216-1-yadavgaurav386@gmail.com>
References: <20260807084050.25216-1-yadavgaurav386@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b0275c4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=MdpIrRKBePn9w66PKCMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAxOCBTYWx0ZWRfXz/YxoQvCypfA
 ceWttOwK0ZFOPx2R/Q+7pzuCBMA3yYhzTVQ3k2IpRZ5ZSASF+jJiooZYT9wFKlspFITe7KFU4Zo
 17zR3lhPQUlkRf8dVoFTvfunF2+WdKE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAxOCBTYWx0ZWRfX9h7479ulO/dX
 LHJx//TeCYVofoXUCaDxS37dnl/QR3qeIyimrW+Jp1pW0xa5RSHFk3q3VkS2N2fIcYu70RTwZuj
 071G/nFDbH35ejfezkQpVUF+E4XIkY39D+Pmufd4YE5AQso3w8V94lI6F1JF4zUitQlNcIyEdUX
 4whawB4NlL3ZEPRPqWXrl2XplO74v3j3CrGBFdcE7c8ZRpxpKXNy1KJhPJcQyMYN9GbSaAMydKk
 Tstno5/3/Awk6/uSQ+/cNsJOGuxDUN0adwLAVdUBrFPx4bRY4MvW61kpnOXqdUKrDWPRWJNYWCy
 w0nXoWq/3WRidDtMMEnBiLHKXa/1umXlk0/EuDBnx2paFNf0enbpyPJMtvr9yBWPyxzBuI9t047
 U8xRdInKRiuwQzlFeYbUIl7RPx/sj5oufOtC4VJHykZtLIcwRJyQNJYzmGjsUdP7wjMQ6c4ho38
 XowrPnrz+w8SNezBb3w==
X-Proofpoint-ORIG-GUID: 8ayBAf8X8rEvDU0NCMa86urG__PzPvtf
X-Proofpoint-GUID: N2uqNbXCFFjR_JRDdvaJ3IFDov1BhLGO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611220018

On Fri, 07 Aug 2026 14:10:50 +0530, Gaurav Yadav wrote:
> Replace generic printk() calls in kvmppc_dump_vcpu() with vcpu_err()
> and remove the corresponding TODO comment.
> 
> Using vcpu_err() provides vCPU-aware logging context, making it easier
> to associate register dumps with specific vCPU instances in logs.
> 
> 
> [...]

Applied to powerpc/fixes.

[1/1] KVM: PPC: BookE: Use vcpu_err() instead of printk() in kvmppc_dump_vcpu()
      https://git.kernel.org/powerpc/c/54efc2e1e9af9e3a14264db5686330e4fd477286

cheers
