Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F27328B71;
	Sat,  8 Aug 2026 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786204499; cv=none; b=SCIbw3NosFwLolunjKO6sgsIpm5ejbL27Ujpi/RDdbr0hB/SpQkSlIU4k62DR9Cib+BB9G7/JvRB5qRoDmMYLnKJJdgwOznk5bLRl9W0+pLgKo4nLY4rWxz06TquzyoPoBK5n0Pc8cuLZhcSuP4nPimqC/yK53XYcuKI0aVbvmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786204499; c=relaxed/simple;
	bh=iIKW+2DDNWU0m1qUvehAflFTc3It/F/kDA8mpwHPSPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifAk5/utetWKGMDommcsYE44zBNXZgkvcSKgIy9o9YTnxnwBwAWrHnu2gHHelfCj6mYP4Z5SE7jlEID7jjhiFNk2Cx1NvPrJrPOngl8sioYfcyFeq9Ufi7i7CJcpFGaTRqO/TB8nMLjrI7xO9g79wn5vNQI5yD8Szt0+8I80ZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rkjilzkA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rkjilzkA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678EOTFr459369;
	Sat, 8 Aug 2026 15:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=e5BA6ZubqZMUr47Lcr59yxPyFrI05d
	l50H9qpnVUH3w=; b=rkjilzkATKO9azGynhyyzbXLmYrbCm3rvpzlu1ayKHZkIC
	o5AW2FStJOl/2tA6WCn0ocLZulGX0pI00B7DRgWCYf0yHkG5dG2XH5q8bqo2b3Yk
	z/fGY8wYHyWbBxKUIvtUMOH+UpBLfs158VQDKrP+Zds4Y0oOu+G362fe0UUUGcsp
	WcqjYcUJJK6R7IVCJh3pa6eLEs1s9bf+JCfHb5PeIr+XQzipPbgGFTXxhsk7drBy
	I2Vy+utI2z//D5B1DST19RZXoGxDD4LLsDhgkB0qHq+jQn5mF9TdFcNo2tRq691w
	yyFt0QjPkAOFJwT6Dk96BV3lffttoeFuc0fMCLKw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnvsfnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 15:54:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 678FfYmm031335;
	Sat, 8 Aug 2026 15:54:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kkxgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Aug 2026 15:54:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 678FsaEX34603356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Aug 2026 15:54:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7970620043;
	Sat,  8 Aug 2026 15:54:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8484D2004B;
	Sat,  8 Aug 2026 15:54:33 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  8 Aug 2026 15:54:33 +0000 (GMT)
Date: Sat, 8 Aug 2026 21:24:41 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v8 4/4] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Message-ID: <20260808211732.f0cb80c2-50-amachhiw@linux.ibm.com>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Gautam Menghani <gautam@linux.ibm.com>
References: <20260807172433.82045-1-amachhiw@linux.ibm.com>
 <20260807172433.82045-5-amachhiw@linux.ibm.com>
 <zeyxjtus.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zeyxjtus.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a775142 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=CEs3Oxsm4vumbZvd9zwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: BrubJN4GbLuN9ew35KBM5Y3Ok6-Camtk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDEzMyBTYWx0ZWRfX+gp10oRyMkS4
 lpaJHBA5CyD78nCOGOtdagHZpX/xFmFgkngI/41areyFUu5SpO6zEpJwfR4kP1GRpQJ5qgBLtBX
 bJ6qKK/xPyBD+4fH4RQnwsIX964gzP9SYLLve2xSoQtOW9dM3GK69mVNtGXNagxvrFxcbTisql6
 iKujrGwYClDG9GCEFDxP1aOhsDvQN0tudVqXGjQToB/K/9HZgubV+GBarDK2tCqWe8WnvlcZ8Lh
 J4zmaogbEOtioaLHRWP+PrT3TT7mMvN8KwR5sjMaLE9+QKHM03CDa2JPh1GN6kKNonrvw5E/mFF
 BNtWwVHmkA/sjTsGlngGL0dF5S3eH9olOWXhkugMARH99Kle0jBO0lJZYyZJnTTvSjguKH1VcH4
 xR3Bpe8ngOtj8r4ctHEnvt1z6YqvWDXyyh248xYdWg4/XFB6S11RFpnn9f8tI2GAFn+vW20dsx8
 MJaVj6mUBdOy6xyYC5w==
X-Proofpoint-ORIG-GUID: pf6vKQfc3DbB4qcZCoyxvpM5ITgk2__2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDEzMyBTYWx0ZWRfX9KyKgjmnC5JB
 lSxNVCWd9aqXwV+NhS95R1Ejn+5m8Sl1j62V3FzA/nMIOBNiJ8qDQL/GgUvkplSvwAEx9ZN95b/
 VWXNh8odu7MytBfzPqoOJP7/pRFlDV0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080133

On 2026/08/08 06:45 AM, Ritesh Harjani wrote:
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
> > documentation.

<snip>

> > +
> > +The ioctl uses ``copy_struct_from_user()`` and ``copy_struct_to_user()``
> > +to support extensible versioning across three cases:
> > +
> > +- If ``size`` is smaller than the kernel's struct size (old userspace,
> > +  new kernel), the kernel zero-pads the unknown trailing fields before
> > +  returning, and writes back ``size`` unchanged so userspace knows how
> > +  many bytes were filled.
> 
> I agree with Sashiko comment here. This para is slightly misleading.
> This sounds like we are zero padding to userspace struct before
> returning. Whereas what we intend to say here is, when we copy user
> struct into kernel (copy_struct_from_user()), we zero pad the trailing
> bytes in kernel's struct.
> 
> > +- If ``size`` equals the kernel's struct size, the struct is copied
> > +  verbatim.
> > +- If ``size`` is larger than the kernel's struct size (new userspace,
> > +  old kernel) and the unknown trailing bytes are all zero, the call
> > +  succeeds as if the sizes matched. If any trailing bytes are non-zero,
> > +  the kernel returns ``-E2BIG`` and writes back its own struct size into
> > +  the ``size`` field so userspace can retry with the correct size.
> >
> 
> BTW - I anyway feel this is too much. We can get rid of all 3 points
> which explains how struct copying is working. We have more than enough
> documentation around how copy_struct_{from|to}_user() works and we have
> also added the comments around the code. So I think this is just
> unnecessary.

Agreed on both counts. I'll drop the three-bullet block in the next
version - v9 is on the way!

> 
> We can just say:
>    +The ioctl uses ``copy_struct_from_user()`` and ``copy_struct_to_user()``
>    +to support extensible versioning.

Sure, makes sense.

> 
> 
> With that taken care, please feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks again for the detailed reviews on the series. Will carry the R-b
in v9.

~Amit
