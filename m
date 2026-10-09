Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5FD4BD344
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553482; cv=none; b=uwB8oJGJmiMRPjviHxe2koY7kE7203j1owRosQfl2pY9NQi9JakawAfETDmIAVBjVTAVTmn1SUcPK+JV9LYeBVi1ypY5YRaI5ksvippuM7IhNAsjWwWzhMzv/zc+wLtBE7rkDDB1rICLdWLFzA0hae5Y1hSv8IXDst+aPyHo7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553482; c=relaxed/simple;
	bh=+TJXvTuEDpLBeW2Z5+bCHGtCqrOgV8KN7NzrYqOoeJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N41+nkiHzA1o9g2cKgtAEF93kScmzhIrpeRMZVZN3IFarciK5gQcGiQ7FEK9JWteg/pPvy1i39hmbGYxMHgwzh2KljEYfyyDBnQFaQLZjJaEdhR8xRZrU4dX5wSJT76EIPZscSvHPGZXaQSaaIFdAWlnZqXcXty9m7EnhDyHsks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oNQzOqDf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I4D0lnFz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oNQzOqDf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I4D0lnFz"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DKrEv1886457
	for <kvm@vger.kernel.org>; Fri, 9 Oct 2026 13:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f7o1DrLEcBNqQ1Flg54Ai3oN+ooXrDNjlEfZL6fV+XQ=; b=oNQzOqDfJ8E0CPBB
	Ja8vOPcar2eUVBtqsQBHGXD28HvyGnyzsjQ9uPF7ugOuJ4EissLWjdr+erCsSaRX
	5mDpDYapWDZqqMXPIhjE4O1vY+LzMX1RQdTP7kLU9psuxyyldBpNsAwy7R3vFaAE
	/K9bap81PxZ16S5dyAGRlNlAqdbtzkYUnhgDp4Mzq4HukEtqdpdP90vUiqHVlBkR
	hujCMycUkpxWfxYJ19O3QLes2JLvCe3kqohhszuorDMfg9Fwqa/PcdFXaXnrBQLN
	6YsJQXApC/yW09ZnMnR5pye3/K5ngUF270upxojLcm6/VIKvxNNHbXHgI2b/ePDT
	01ajHQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxkbyc0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 13:44:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934956beec8so1361117285a.0
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 06:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791553480; x=1792158280; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f7o1DrLEcBNqQ1Flg54Ai3oN+ooXrDNjlEfZL6fV+XQ=;
        b=I4D0lnFzJfV/pZCCWko+ZznEEILnim3jtZnMU6tHfZynfU9xg9v9tVUcecIsDH+hAG
         quUb0lUqRaO38w6bxhCTRGQ5bwOovVfyQ8IcMSWVL/IKI9SbmDJURRsUiBcRPEeRYIjU
         OyDIh6JQChjKImUxtrkzNVb4p0vJrgKNnw+8Ny2yWJscx+sQzKZQdqnqyd6wJPF/i2b/
         qTXFZYmcVK0hfgT8rHn8irdh2TCCN++y76gH6NtsddWyZsHXtQ0loLZ+eGBE9Gwk0DFg
         dvo2erW+Qk+dtdCWNDZ/1ptw2gZ+sdG463fYAzMgpQYD8MMM97WPYodekEBGqwVhJo1k
         o/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791553480; x=1792158280;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f7o1DrLEcBNqQ1Flg54Ai3oN+ooXrDNjlEfZL6fV+XQ=;
        b=onLeS0eZ3aOrGxdCIyWHtMlpzXSEyszWgjywEDxCQR89Iod+8JandZeGNJ5lg0P0R6
         JCdRbZ9BV4zCFUR/vI1JIPd6C9xPPjk7doO38/Zkvo9YwkPisWxnf+iIUnHMk9eQVOdj
         QdZwUq49t6YVtB5Tx3nSCqfhw+jOq9CkeFDBqlykF8yZWmceWeOam2+L9XVNiQsn8jK1
         v8r8b86UoO6h4R1vN2PkFfgseF1vYij9LuAWG/NmOpDUgIvG00pKwl0j8WyJeAIP1QPP
         T8Sg5ktWpEFWHhJaNiDMykpzNAuYvkHxpGWsS6Nqm6lOjZLK2LPjK8HTU2ZyzTlQ7f5C
         MsEg==
X-Forwarded-Encrypted: i=1; AKwUvBxPHFF5MnzEOFGoylCTpR+pAtih2/hjF5V1T0e3Ew4y0vMgFX84Ne+erX8CxliWp50ipm0=@vger.kernel.org
X-Gm-Message-State: AFuF++lJt9rHQzGV9z1+4O9yOnuF6Xw3sCA9wT5JL7YHMKrtWsrZioYC
	fO941ZtMrMEn4Ud5V2twB/uRWPHf2AJRPHSFv4FQANFeUq2rb5t9iI6VWbbyStbWWKUFEz1SsD/
	fLtZLRezB+DdyAEX61y+W2tndiBgVP3k5wEzHj2TWmhqaW/1Hyzf3qTQ=
X-Gm-Gg: AYBFou1pWDRrFjM/c9apxvYuXlE0ApnG3viuCKXfVoP4mczzCGAJDYPYP1g1GKLr5de
	LJ086iJdT2BlvY55ffoR376BK4Is+O8YssN3awg79nmF4D+6Q2B6mXBlOY/TrBvhcZlmMoziTFX
	KrNTN0XZZweYUrfMJdRQRh34FQMfrTpMFurR8osnyLOTeauRmht++OVc2etTiIPOP09gojpAuG+
	sM1UzGm10mQyHxN612S4bxWG8l57DCdhbkWJ2OkfSZLObsQoo212U+aQn93VEy9k4bdZDQp1jRF
	87Q2vRs3L6gpWEPcM8aUUf3zyd0SmyMpDlcjXYfr2k4/AJ8gGT+Or4o/QpWv37Noby3llVXJi/J
	bLK+LPfiwTTDKZu3X2cZ5pdhHBlEu6+PMmwyEdg==
X-Received: by 2002:a05:620a:171e:b0:93b:d7a3:45d0 with SMTP id af79cd13be357-93ebd293de6mr253479185a.57.1791553479691;
        Fri, 09 Oct 2026 06:44:39 -0700 (PDT)
X-Received: by 2002:a05:620a:171e:b0:93b:d7a3:45d0 with SMTP id af79cd13be357-93ebd293de6mr253474985a.57.1791553479218;
        Fri, 09 Oct 2026 06:44:39 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c1e33d2sm81608725e9.0.2026.10.09.06.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:44:38 -0700 (PDT)
Date: Fri, 9 Oct 2026 15:44:37 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Anup Patel <anup@brainfault.org>
Cc: kvm-riscv@lists.infradead.org, atish.patra@linux.dev, pjw@kernel.org,
        palmer@dabbelt.com, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Use a raw lock for IMSIC wakeup state
Message-ID: <7zy352odf4hekcibmio3atunubffzxfcsqnn55q6sfkksnynfj@5bx263nnizdm>
References: <20260925155116.465203-1-andrew.jones@oss.qualcomm.com>
 <CAAhSdy0Y8kQ=gsiX0QX6Ntq=fL89METhA0s7G3niBBJrHpue7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhSdy0Y8kQ=gsiX0QX6Ntq=fL89METhA0s7G3niBBJrHpue7A@mail.gmail.com>
X-Proofpoint-GUID: AIAKh7grcim-5WIakzIKmxdz2NZy_SEa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1NCBTYWx0ZWRfXwxPaLS/V7gHk
 grrafLDFil9qsKkNaOcHHiLlTX7AYlhWbtT9PTyx6bx1pQVYk4EVsdcuRyk35A3QP3aRhoEwBlP
 RZixkBPvMxRHFbnKpNymcSGhGMqSHhU=
X-Authority-Analysis: v=2.4 cv=Cs0q4X4D c=1 sm=1 tr=0 ts=6ac8efc8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=98eIWfJVglYkh31htLYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1NCBTYWx0ZWRfX6+joCFXwUqVq
 DQGcGTdCZVk3Ac8+W7jdR5W2hn6gqSXsCwXvaedWaGOJv3//PgOOCKIQ0xoEvP4ZeYAkha3shRp
 P7w9m6Jo5TDrVs+zpBlT9B8agcF0b3hyUlrcqsfx20wxiWgDy+B3Z8qpg8KTGPuW/UWiW2gET9K
 N0u0JyxvDUruVtAl+mjLc6CciVCKWp0AJCo6IEafD9uhbPse5sEvg3FQIf1jWqfPRR8/zTUZv3+
 WaifDagppZtgecxNYGFLbUWzm0BcE2Zh00dPjXdVpOL5Gs0QwD5QkT0IyEUuutqxa6DWureMNJp
 2qU8YGt6ev8mwrpLJe8WDlRQ3SjPlxLzlm9TCeiLRTzjYOWYpWnHEmWuRDcBfHSJQEPPFBAXVc9
 zpl8pH2BlkpEP0DMu94Av9yd6tdo8G9oOLWQdhTXxsNIV9dBirfdQYbRPKQXHgGtc2i4s+c6XdQ
 6lXlXXx+R7x9KgSB42w==
X-Proofpoint-ORIG-GUID: AIAKh7grcim-5WIakzIKmxdz2NZy_SEa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090054

Hi Anup,

On Fri, Oct 09, 2026 at 01:45:20PM +0200, Anup Patel wrote:
> On Fri, Sep 25, 2026 at 5:51 PM Andrew Jones
> <andrew.jones@oss.qualcomm.com> wrote:
> >
> > kvm_riscv_vcpu_aia_imsic_put() can run from the scheduler preemption
> > notifier while the raw runqueue lock is held. Taking vsfile_lock, an
> > rwlock_t, there violates the lockdep wait-context rules.
> >
> > Protect the CPU/HGEI pair with a separate raw spinlock. All updates to
> > that pair retain vsfile_lock and take the new lock, while scheduler-out
> > uses only the new lock around the HGEIE update. This keeps the wakeup
> > setup serialized with VS-file publication and release without bringing
> > wider IMSIC operations into a raw critical section.
> 
> Instead of introducing another lock, why not replace
> read_lock_irqsave(&imsic->vsfile_lock, flags) with
> write_lock_irqsave(&imsic->vsfile_lock, flags) in
> kvm_riscv_vcpu_aia_imsic_put() ??

Unfortunately, write_lock_irqsave() has the same PREEMPT_RT issue, since
rwlock_t is sleepable on RT in both modes.

Thanks,
drew
