Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AA82D7393
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230078; cv=none; b=V3JIcKsZEndtKPXfN15B/JiK06CVNGcukYO8WFdfzXBeODSMCoBPKFtG6s6+zY9JqkfHbp/vG7N6K/a3hwCpcYSKkrlrFgCjQIhGBSH5Nd69xL4B2vzmQoNH0DHoPhuLmnWvDrK2D7+2TICDZ/8dzjeGXbHWhsdu5qMnZx842yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230078; c=relaxed/simple;
	bh=4tkCiFVwW47OcJkhVDIfx4MP+xtMRUL+fmH+scXiZkU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZITNIGqs5CogieRWZ4U2TfRpWS6wQw1/ubyDqMnFk/uPMwydE0zlkn+oSKSVJMAUNW8ZinKBAIHdqVjNynFpj48oQq6K3O3xNoiCJTPs7lj2l4M4FX1+7jBYXThfRuKAx3skG1wyyne+vSayNuYGiG2IJVTFkJLEIik61u0nvN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ry50pyvO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ry50pyvO"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmPSt1826009;
	Tue, 23 Jun 2026 15:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kxKZ2z
	/8zIt+F5hFTKVjpB9GxRm6XYLRlEsZxtFtefE=; b=ry50pyvOBjSnMUO5hbd6eI
	M8Gh+x0uhxru0xNU2g8sPZVIuFmQN6EAVIe4YCh7Gd30etL3qUp6JWwwiMUeh2fm
	sHN2ggvZT7HBQ7ZfXY7hsYbLqV7FWvkrjVWtAnvyvoFUtUcS4p5jORyJ4sosu0K8
	02Fp07MuJI9KsKLWXjBTDPwgACoxLbGjUV+jE3o4HPtBk38muxvQ1K12FN0bN0pJ
	cGhPRWZs119TqSERnVTPJwXA7eHGkKCk6rPVGUn8KYopd/17nlgxCp9xd2atRyNw
	F+PWrlZN520pjT15MDuW6qu/135PO/9DFJiyGHETaJM/YBF2HwxHd0YlDyLomQWw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsqbt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:54:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NFntRO015915;
	Tue, 23 Jun 2026 15:54:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vykt66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:54:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NFsNJ737486990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 15:54:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E271C20043;
	Tue, 23 Jun 2026 15:54:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF2C620040;
	Tue, 23 Jun 2026 15:54:17 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.124.220.40])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 15:54:17 +0000 (GMT)
Message-ID: <54a9b8d16347f6cc94a625aca81897ba6b875385.camel@linux.ibm.com>
Subject: Re: [PATCH 3/8] tests/qtest: Add Power11 chip & machine to qtests
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
        qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
        =?ISO-8859-1?Q?C=E9dric?= Le Goater
	 <clg@redhat.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
	 <philmd@oss.qualcomm.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini	
 <hbathini@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn	
 <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier	
 <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        Misbah Anjum N <misanjum@linux.ibm.com>,
        Anushree
 Mathur <anushree.mathur@linux.ibm.com>,
        Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,
        kvm@vger.kernel.org, Gautam Menghani
 <gautam@linux.ibm.com>,
        Chinmay Rath	 <rathc@linux.ibm.com>
Date: Tue, 23 Jun 2026 21:24:16 +0530
In-Reply-To: <20260623141933.577981-4-adityag@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
	 <20260623141933.577981-4-adityag@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEzMCBTYWx0ZWRfX9aRtM8Y1x/lk
 LIwfzlY8UdlAhWm1BAmcENOXm3jM9sqJ+MRPmDyag0Dgzz/hi0p7BfipbRUZy044ieNiOtfXF4B
 rKvmPmGcmdkKdF8sZVehKHU/Fj/NSGc9cLqZMLkQltNaS/MkkuJsn/n+b9NWe2Y5gucn5nif34n
 CqDckVHejr4yTaFvDH9rD3keCAjgQCMpxMnJqTw5+0wvbIdECCBGRa88fbc011Aae0t1vj+MOZl
 O6/G4POtSROhWaDxF43e2/1s9ElxQG9OJGVGozV+5PMUBSC/IPWcz23OKLdGVYG+KxtieJdH7UB
 rnhp/Mg1fLNtf2rxZ0/n/axrYzbX2gVHYucLwJuUKvI2JvGp+tGLM8raUbQgoO70hQh5az6yvbo
 QTaceQ9rPRPid6ca9nrvRk6+T7YONI3E6e8YMfKaKW04SaTsc8o3Eztz6iKV1XrI/j16Tw/qi6b
 I5ARhlQMP9rWCm3I51w==
X-Proofpoint-GUID: 4UoGGPogKiO1O3BLqd2imU7QKTNhJG7k
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEzMCBTYWx0ZWRfXwAkYxtNsMKnN
 68g/jSrYdIiW6JYu2rFtlj5etpHYf1A6MWK/Az3fvQ64tcdGbZo1jlqxJ6aPPGTvKG+jRGD+bWg
 fYoGLjBowmZTDMX9olA3Ez13qh0Zy1E=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3aac34 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=fajTbtvbSp6CR1kMGHkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _ul13uJ03nrwD7dBf97H8genPD3DdfMQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230130

On Tue, 2026-06-23 at 19:49 +0530, Aditya Gupta wrote:
> +static const char *pnv_get_machine_type(enum PnvChipType chip_type)
> +{
> +=C2=A0=C2=A0=C2=A0 if (chip_type =3D=3D PNV_CHIP_POWER8) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "powernv8";
> +=C2=A0=C2=A0=C2=A0 } else if (chip_type =3D=3D PNV_CHIP_POWER9) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "powernv9";
> +=C2=A0=C2=A0=C2=A0 } else if (chip_type =3D=3D PNV_CHIP_POWER10) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "powernv10";
> +=C2=A0=C2=A0=C2=A0 } else if (chip_type =3D=3D PNV_CHIP_POWER11) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "powernv11";
> +=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_not_reached();
> +=C2=A0=C2=A0=C2=A0 }
> +}

How about refactoring to the following?

    static const char *const machine_types[] =3D {
        [PNV_CHIP_POWER8]  =3D "powernv8",
        [PNV_CHIP_POWER9]  =3D "powernv9",
        [PNV_CHIP_POWER10] =3D "powernv10",
        [PNV_CHIP_POWER11] =3D "powernv11",
    };
    return machine_types[x];

~Shivang.
