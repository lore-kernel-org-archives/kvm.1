Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095DB376A16
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454248; cv=none; b=u/J7rPRcIl9lE2gvU/hi4FKPfomDEVXrbsV/ijfl5EjDYgLTk6zjigoc/NSjtxdhhCvSqNXG6JwUL+O3LlAttHaCpj4hXGWIX78IgWU4H2caGEDTlClQfWaj98TDOYPkxstqSIoyCGnGNX0zoq/2uw8xHnmZqcK1m1nxQaUa6ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454248; c=relaxed/simple;
	bh=l1jsG2QJcUthUWPm6QMnCxmlu8D88y6qpfsLyiP+5Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgKHorkbXoi7I4rg06WrHPEhPTIq4CVm14FT/Q7raMKgRN6QXfyHE+Ly0jfBKIu5YUoi83ZSJCoEjJKH/4mvTkiv8cLXFMdNT6vX+d6AUqG+MrG8q3uyBe9g7YQpoH/Ymqph3cn2e8Vs7rF+8B4KSAUFE1VIU3ql+9aAij5BpBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mXls+qtX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sr5zhTsS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mXls+qtX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sr5zhTsS"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MAIpHS1800953
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 12:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rXlJwEKxokX+wnRp06beoB2Vqo9GEkg42UQMNgZOco4=; b=mXls+qtXCZljlfkr
	7YpD1hKAiWwM+Ee2Q5AG4oUA9GRJnOtlK8EqTOgD9gdEvq9MgoyTbp2xEMfTG3mm
	1d+lTUZYyUikwVJ1x2SPYDiuCrVH+7UveQPMJ8i42kS2XR04D96K/8FyqxaGsagw
	U3NFJ57iz66hiO32GT71UhGGoFxswXfGyaEQyB80wvdPer176nO0h350YSGh6AVJ
	J++k0z2gwr7BoaWibi3JY9XmuyV7wy/EcJWL9NMR31c1HouSOlURy1yxe+Mv6bDL
	XLgvEONbC9whtem7wg4zobbvrq/BanhmJI5ICWVKx59wxGoRBtauFtQ7Yi362u16
	Qb0R0g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean9g0g2m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 12:50:46 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3041ab826ddso5054502eec.0
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 05:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779454245; x=1780059045; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rXlJwEKxokX+wnRp06beoB2Vqo9GEkg42UQMNgZOco4=;
        b=Sr5zhTsSKQV3f5p5imR64kg3CZVCRMLKGZYZCUUEMmhjdPoLRje8mfFqlWZqXvfWfz
         XaLy4/1LXexKfOujN1jz8uvDe4mA0zVvCotKkTRGfBRyHioHhDFls0LUAfnH+omPLktf
         zALlhcDuDKzCdGasIo9z8HkDTkp32uRq4ypkqbbeuRvW4t+HZr28XU3XqeYrB2Gpw2h+
         fF9lUjdg2PrDJSzvFXwLvfbMNMxn0BVb/ULMPPRPAeQX3y28E4zVDHXLw91TQPUMcarJ
         CzGq6Z1Naj8zzpTHfjJgnXTJgv56FsrFxYiIXeJrAcwBDRRrfFM+af+qAB7nR/jUcJW7
         1ZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779454245; x=1780059045;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXlJwEKxokX+wnRp06beoB2Vqo9GEkg42UQMNgZOco4=;
        b=VOn6E5ySjckaaN6I4O5jMUfwOtJFI1eazG3ZIbdHqb8IskkVYmQOd3KKr0m1zuJvT2
         q+9oDtsmm3vpqbJ34GP0XZ08zzhPPs33xOc297n+Hb2J1JJ7sVrllnfXv3F5haviOBow
         otaOOGkeb52Ov1s12mk9WAwYpOwpbbtdSPhvuAL0cOWXacTQPyB25QJNwxymVF9VpUv4
         XH8qye83LGEnWcBx+OBI3PlBfrZOs1SoQZUUYXh1W0p+U4nrkzGJ3pzUbwOa1jDFaz7E
         X9lHLoS6/ca6EkNxHM3N5B80van6PrsBUbLdeogbtGjR/BD7cBqwnuDQv6BZ2QU8/M75
         bogQ==
X-Forwarded-Encrypted: i=1; AFNElJ+KbDRvZED6LWBvJAHnEYmPGa5+9GDoCDNX98VULPhXUnhTMB6VcprXT0JVaKv+YIj2WG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ8e3oCXBP/p/hmzPmZ+t+9QZnPMc0TMKGn3nQmwuuqve9av00
	oIBBdtO/4v+aLEPixqIV3eU2cBtiKFhOMAl5FqLH8jNRw15ETRqjJKPvRnGsN/Jl1gwYI1kx55T
	FNBjtIX5BlLnnuwPBFG+xqH80Aw37IjZhvXHlOnVZpujgSjsnGWiAaRs=
X-Gm-Gg: Acq92OGpqLkJdemDE5pnfjvX/RMaRnAjgOWPXeGVG0mv/Vt0i/l12psHH9HVaGlzXuz
	DKt6oGkIT0uhYbZK3SsiICqNr9oOrhn4Ax/R6MNGLT4SuZAeEBroX1sL5NbqynApX1RalowXV1I
	ckG7TaH4yUpa7kEoQsPR67ofzmeYPacFgikrLXw0MRUXxZterld062lZrzMbH65sw48mWO4JhVc
	GV1t/MsK5DA2oDxQeq1ZxJHO80oa6XKOvDU7CZBYnG2TYxCXoLslY+uOkvoam4g8I34CLOmg4aG
	AGqEPjUZAlUXnCd0WZ2ZEc44dCtKDPlnpuj4k8F0tuN9AYzYJxnqz9asrKsAWGs6fRBsHGDTwIa
	4DrP0VChugx+2aSFewToeOFcfFSYWaHDY4NODS31ofg==
X-Received: by 2002:a05:7301:6007:b0:2f2:5726:db31 with SMTP id 5a478bee46e88-3044913a03fmr1905501eec.35.1779454245482;
        Fri, 22 May 2026 05:50:45 -0700 (PDT)
X-Received: by 2002:a05:7301:6007:b0:2f2:5726:db31 with SMTP id 5a478bee46e88-3044913a03fmr1905472eec.35.1779454244912;
        Fri, 22 May 2026 05:50:44 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452230dddsm1100812eec.17.2026.05.22.05.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 05:50:44 -0700 (PDT)
Date: Fri, 22 May 2026 07:50:43 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: ajones@ventanamicro.com, alex@ghiti.fr, anup@brainfault.org,
        aou@eecs.berkeley.edu, atish.patra@linux.dev, jiakaiPeanut@gmail.com,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, pjw@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Fix TOCTOU race in SBI system suspend
 handler
Message-ID: <y2nfuwydbx4wxk3optxr5bex2pubo5whqvk2bzsl7os2kdkwaq@yk36oa4kozfh>
References: <yirnowpcfq6wqru3jshbbaicqftfj4ef3dcss65jdtuon6nzml@iyv45tnmmfha>
 <20260522031813.3429490-1-xujiakai2025@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260522031813.3429490-1-xujiakai2025@iscas.ac.cn>
X-Proofpoint-GUID: unQ1ASUkO-4ZS2Muk9esaDIKzCAA0c3s
X-Authority-Analysis: v=2.4 cv=B/qJFutM c=1 sm=1 tr=0 ts=6a105126 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=dx1DtnK-AAMJs4xixqwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: unQ1ASUkO-4ZS2Muk9esaDIKzCAA0c3s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEyNyBTYWx0ZWRfX4z0rp+w/Y8gS
 c2SO+7vzDx52Ps2fWR263Brk9I3xKLa0g3bH50dXVpKfff7gD98nDIEu1CdrN5HD5d29WMAsCl0
 3f9mD3P8Ku80Z402Jde848xxBF+IqJVzRCQZnwNuVhrXE09+ol8YHomEOWUXnpEOpY61Ht2FIUj
 nvCw/JZp7D3RqJFQAnI9Nq+48aQ2xmZ9gT6QG7Mt3XaJM2wcrzBbM96GYTeksY4FqB3CcWiHU+K
 WK/uFEyq0bpolgdmUS4U8MkMmvN0tby1xMOpJEUPyZucex2NeLWSnZwYbTPU2+6FPls9zN7bhV+
 SFIxPY8ju43jTctxRAi0mARicYh2+F+PCETfPu5cw4YFbPcEcqKGZk/66VJ7spVvVdbgRQ02HtU
 BWgmHEp9fM9uPhahInvVUnuoLKM9CfwQ/cW3smT1z35FH1FWuUtpdGjECIlE7u0eOkO/f+l7Hrb
 6whqy2nmHxFHd7qD2sA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220127

On Fri, May 22, 2026 at 03:18:13AM +0000, Jiakai Xu wrote:
> Hi, drew!
> 
> Thanks for your review!
> 
> > > I'm not a big fan of this approach and I see sashiko found it has gaps[1].
> 
> I read sashiko's feedback and I think it makes sense.
> 
> > > I'd rather we introduce a mutex to kvm_arch to serialize cross-vcpu
> > 
> > Eh, not sure why I said 'introduce' here. We can just use kvm->lock.
> 
> I looked into that, but it may be not suitable. Here's why:
> 
> Documentation/virt/kvm/locking.rst explicitly states: kvm->lock is taken 
> outside vcpu->mutex. The susp handler runs inside kvm_arch_vcpu_ioctl_run(), 
> which is called from kvm_vcpu_ioctl() where vcpu->mutex is already held.
> 
> Taking kvm->lock inside the susp handler would produce: vcpu->mutex → kvm->lock.
> So may be we should introduce a mutex to kvm_arch to serialize cross-vcpu
> mp-state operations.
> 
> What do you think?

Good catch. I should have trusted my initial instincts to introduce a new
mutex :-)

Thanks,
drew
