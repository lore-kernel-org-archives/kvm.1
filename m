Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC57F42B75E
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546329; cv=none; b=ovujdEcZKA40uL07Q4c8vnHnS7nlFwBDfQt+ZOtEdm8wNsz4xxfM5m3YCRDwAhoSC8IvYlZRvU3Eg2sJlTZiIDojsy2aWXIiA+BmxpJ7k9+CzzTy5spKhkCrrQYcugX5cSUW3s3bto9kiAjVepUc2DFDMZjhVzL2PEIIXcUU9D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546329; c=relaxed/simple;
	bh=exrgthwg5jDx1dyyDi852A8kRHJMlEqeSzl3PkzyBuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpQavjFLf2gGimjhI0pwkBix7W+9f6dP3vO4XoTvBEWhPKC/KuUebNlZYAJ/UwvuDXJulz+3IPu4j2aD/xfOmgqJQf2hVzDX41a5NyRqfT66AKr3Z/2vsIS9/rTzyT0jJfCJODkxpXjeIla7LBaN6Z6H0jV+t3CdU+nBAIbntWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nhEQV86m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dkyG4g4z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nhEQV86m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dkyG4g4z"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QF9h5l4002842
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 17:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rPbpzrC2aPa4EGCloOgWbFEDSRaP05NlTmZeiPLlyww=; b=nhEQV86moGMY711b
	Nh3LuQ6mylVdcg0h1yyIvqm4tG/omkJum1sHAjmI3qJqqjlgKE4/6MiFrSzOuSin
	aNOq3UfNw4Ni3YO3MpFmTyuKwhK+i04aTzSyu6XaMOVzfcIYfZqCnLRdE+V+xMLl
	8e+N1eBzSbQ7npZNwP+1XfBa/whu/SZdu+rDANrUUTALzcVdRUGlVgx+XF71N9BT
	NgZl/dp/lHmVdt906sSZKEsaEho7IPUo+4JU2neGEz86+vNfb2U0EYuNQAc92fRL
	R7tGYEATX4OHFRKgqWnPqt9WldyUaLPBlP2+h9AsY3Np+w1Ei1wF8pe6ExCReEir
	iPIZag==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4tkn3984-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 17:32:02 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12721cd1a2aso7467608c88.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 10:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774546322; x=1775151122; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rPbpzrC2aPa4EGCloOgWbFEDSRaP05NlTmZeiPLlyww=;
        b=dkyG4g4z993wUOo3m+cYwMVt61nVtQtsOmQ+8e+99SLqmPqoyz0mX6QDzTTMMN4u9y
         pflNMgS0ZdWPwrE/MeRvha8SXmP/Apn2luuL/WLd2QkWlnBlcYzk4vywppBjVrzqPLyn
         R9Qhj+rj4o/vdfqknD9hcWUQKZgd/Ypmd142mLCMZCdZrYUEgmZuccTM/pNMEX7rcsp7
         dXqRA6enV+gES5PkHU8RqKT4m0+v++mAN8qE6M9ASN3ldoU9OJbTBWNTcmrXAK5NIRh9
         dGVwaxy2F2CKiztcoXvY41jJdHtVt752RA7+jjCMMR997qWbmmKz0Cn6p556YkHoNhz/
         H0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774546322; x=1775151122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rPbpzrC2aPa4EGCloOgWbFEDSRaP05NlTmZeiPLlyww=;
        b=DDYeVxuWMpLVgmkcy3LCD0j9OfGbQTcJcXE7S6ga8uG+J/00OrN+Kh62qouMbqlBYt
         nrjTFTFAIeCOBor4v9CIijiixOKI0cwVp9YDmf04ibEe+66G2jXW3LDW+tz2o58HrGWY
         oovu3B0xaqzC13rUQmtVktmIuawNxlrDPj9lTc6HQ2xL7kACG9TnXScHCAPn/FKuTi3W
         4F2ra20xJcJpXOguLmYUIuETnaCyhxKnX7sOExxHpN4cksFtTRagRfbUIiGGCWTpbR11
         +aosJr0VTn8V+x5Vnm8xBFp9MS0PCqw8eUS1n3CkkC+fI35yNjgnXrx9cMXWIYpfPa4A
         8NNg==
X-Forwarded-Encrypted: i=1; AJvYcCXykzimFYFE16QR3p8an5M8QMdF4OhVgrTq7R1hau0q5fBAMl7ZlbWCZ9bVA1zI6BdysnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLuwfHUQ8MHfDHdFJOIqH3jmCN4GRM6DtGIRjk0Etjvs00cVEi
	HJEQrIenON5Ka531bY1gKd8AFE4jGP9IZdfcuhwK+t0vHQqqB5KSopHN90h895KFrZq29D86GLY
	GM4ECl3lywqY4MdLTxJam+OUMY5znTxDY2Ho+IQcMZBY2yRazhzuJ5ag=
X-Gm-Gg: ATEYQzzlGJRQpZjLE9quolZxpBFJapTGmVWyb+77xCSJGPGF2GS328VfrXBdW9hoXFq
	E3dqkenrUzRO43iTs0yFSwex10KiegVZaRWCZvO/Q73QvOD4pGb2GpRelF7Qav8sWZ+6c3wIzlG
	qUHQNzFXBgvkO00lFrqMFyuQ2l8s1tN+6XdriyxUrF3atFGzVQZXWCj08sEiUC9DMert4F8Ezs0
	Ozx9vab+uSAXoAMsldlUp6FNbrGiUfbjx+3VW94ICHy4gw0DU44k7uA54TD0G749wYomfkqg8MD
	Zju/LkAq3feyphQxoLJnv7ZD1IC+qS/zY50Njh6tYmAQicfsh/Odh1vzSfTP39bGFOIkIj06sEl
	HGnqgHLf53qXuaBIDk4O4ehjyEaOviAQ=
X-Received: by 2002:a05:7022:ea32:b0:11b:1c7e:27d0 with SMTP id a92af1059eb24-12a96b81410mr5209936c88.0.1774546322069;
        Thu, 26 Mar 2026 10:32:02 -0700 (PDT)
X-Received: by 2002:a05:7022:ea32:b0:11b:1c7e:27d0 with SMTP id a92af1059eb24-12a96b81410mr5209889c88.0.1774546321377;
        Thu, 26 Mar 2026 10:32:01 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec26651sm3075347eec.2.2026.03.26.10.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 10:32:00 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:31:59 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Vincent Chen <vincent.chen@sifive.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>, iommu@lists.linux.dev,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com, tjeznach@rivosinc.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, anup@brainfault.org,
        atish.patra@linux.dev, alex.williamson@redhat.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com, alex@ghiti.fr
Subject: Re: [RFC PATCH v2 08/18] iommu/riscv: Use MSI table to enable IMSIC
 access
Message-ID: <cllm27bdn63x7r6zmpgtyssarybhd4i6l7l2sdxvv6bxnghhol@jyfya7yihymi>
References: <20250922-50372a07397db3155fec49c9@orel>
 <20250922235651.GG1391379@nvidia.com>
 <87ecrx4guz.ffs@tglx>
 <20250923140646.GM1391379@nvidia.com>
 <20250923-b85e3309c54eaff1cdfddcf9@orel>
 <20250923152702.GB2608121@nvidia.com>
 <20250923-e459316700c55d661c060b08@orel>
 <20250923162302.GC2608121@nvidia.com>
 <20250923-b2caf55f4f87f05aaa619e0b@orel>
 <CABvJ_xjnVJjV2GnYr=1WuXqo9VivNXniq8BJ39LQNwaT6vUiQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABvJ_xjnVJjV2GnYr=1WuXqo9VivNXniq8BJ39LQNwaT6vUiQQ@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyNSBTYWx0ZWRfX7jZodSmDDyHR
 z6RVLJDFLvo3kCkgiJTCRveRL8d4yrn49LZtsSRHENOG7ISz8cdPcEq0IwN68LACRFfNIy33FSz
 FNdx7cFph5Lq3Nk+jnBGgkQZQfMDjtrLkARKdjGgQwu42Uy/o9ZW3vTmelC++RBRO5T/RktbRwD
 LaikYRba2LVsg5oVJ7RAGRc5HJ3V7c3ohNTdUyLWxx1s5oCnnD3SMKqx7BI+CDgIGbPgPtzFs+c
 bC+d6LH/4aAuCHnRKsDNtkhx4AqqZxWoPwnAugdtA2UlJ/DMIvJF2w6JveFv5buB4/ILIip9TdY
 8fjrY1PTVqmyttQ0Sogr6YpSrfp2GoaN1lXi01uNpZNcrDcp/SN/BEB3XZ0wjvtOGvszPN0a/rD
 fDMWeUqCBxBjQLcLI8hqYieBz7+T1UJwbFIz7isNfL9xn339S4LxYLD8YK+922o7JVPYq0Ct5Gn
 NClCCNoNaL046eWhGvA==
X-Authority-Analysis: v=2.4 cv=It8Tsb/g c=1 sm=1 tr=0 ts=69c56d92 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bDdBU3oEAAAA:8 a=kVzS7ww4oF5vT_6CylwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=DN7SgORnOiO7RqxRx1GC:22
X-Proofpoint-GUID: 9CY4dOA6YCtYQT1Gw3yvcttAf6BtwT0k
X-Proofpoint-ORIG-GUID: 9CY4dOA6YCtYQT1Gw3yvcttAf6BtwT0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260125

On Tue, Mar 24, 2026 at 05:12:26PM +0800, Vincent Chen wrote:
> On Wed, Sep 24, 2025 at 12:34 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Tue, Sep 23, 2025 at 01:23:02PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Sep 23, 2025 at 10:50:56AM -0500, Andrew Jones wrote:
> > > > Yes, this is the part that I'd like to lean on you for, since I understand
> > > > we want to avoid too much KVM/virt special casing for VFIO/IOMMUFD. I was
> > > > thinking that if I bit the bullet and implemented nested support than when
> > > > nesting was selected it would be apparent we're in virt context. However,
> > > > I was hoping to pull together a solution that works with current QEMU and
> > > > VFIO too.
> > >
> > > You probably do have to make nested part of this, but I don't have a
> > > clear picture how you'd tie all the parts together through the nested
> > > API..
> > >
> > > Somehow you have to load a msiptp that is effectively linked to the
> > > KVM reliably into the DC for the iommufd controlled devices that are
> > > linked to that KVM. Then synchronize with VFIO that this is done and
> > > it can setup KVM only interrupts somehow. This kvm entanglement is the
> > > "virt" you have mentioned many times.
> >
> > Yes, the VFIO+KVM irqbypass framework currently provides much of this
> > support (which patches 10-17 of this series leverage). But, if using
> > nested is necessary in order to "signal" to the relevant subsystems that
> > the device's irqs will truly be isolated, then I'll need to start figuring
> > out how iommufd can fit into the mix (or if we'll need an iommufd-specific
> > implementation for a new mix).
> >
> 
> Hi Andrew and Jason,
> 
> I just noticed this thread, so apologies if I missed any prior context
> or if this has already been discussed.
> 
> If I understand correctly, the current discussion revolves around
> using nested translation to identify a safe "Virt Context" for VFIO,
> largely because the base RISC-V IOMMU/IMSIC doesn't validate MSI data,
> leaving non-virt cases vulnerable to MSI spoofing.
> 
> I'd like to share an alternative idea and see if it might be a viable
> direction for this scenario.
> 
> As Andrew mentioned, sharing the same IMSIC file without data
> validation makes it difficult to prevent spoofing. However, what if we
> consider utilizing the MRIF (Message Request Interface File) feature
> for VFIO passthrough devices?
> 
> While MRIF is primarily designed to extend the number of guest IMSICs,
> the specification doesn't seem to limit its usage strictly to the Virt
> Context. If we assign a dedicated MRIF to a passthrough device (even
> for non-virt/userspace cases), the device would only be able to send
> MSIs to its own isolated MRIF via the IOMMU MSI table.
> 
> In this setup, the actual interrupt delivered to the physical CPU
> would be the Notice MSI generated by the IOMMU hardware itself. Since
> the address and data of this Notice MSI are strictly configured by the
> Host OS, the device wouldn't be able to spoof MSIs to the Host or
> other devices.
> 
> If my understanding is correct, this approach might naturally provide
> the isolation needed for IRQ_DOMAIN_FLAG_ISOLATED_MSI across both virt
> and non-virt contexts, potentially simplifying the need for KVM/VFIO
> special casing.
> 
> I wonder if this approach would be acceptable, or if there are any
> hardware/software constraints I might have overlooked?
>

Hi Vincent,

Thank you for your thoughts on this. I agree that using MRIFs would
allow IRQ_DOMAIN_FLAG_ISOLATED_MSI to be set. Indeed that may be the
best we can currently do for userspace device assignment. For guest
device assignment we can already do something similar by simply not
implementing irqbypass at all (VFIO without irqbypass does essentially
the same thing).

I plan to post another version of this series which will only use the
MSI table for guests, since I need g-stage to not be Bare in order to
enable the MSI table anyway, but we don't want to unnecessarily mess
with g-stage for non-virt uses.

Thanks,
drew
