Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794556857;
	b=dD2TUtXo3ACcMhRBZJZMFn5ikPN1zFDNGecBDmEzhoTv6l4SrolNMZMQf+ONXgRLYwEK
	 Rz0D0ozFDLBPOsapxUnNxjdbwH6cB3yQgyjR2I3hSil7h1xYAY0AXWQtxsc/VVsQnerS/
	 hToBtKy1kYd9Bg/0Iw9HW0M4P1XiRW4rRslxWIvaY/XiBDTCBFvKEvY0mDrQ6pGB1oPb1
	 msa1bHHaez4Fd3pCsuLZ92Il6WBGg0nnW1yIQIjVQYYWjx/WkWpfMEawjQkRPwscQNGMR
	 e7PxQxsoQTNiKFSwMEvkCTjuJslBulWj++48TqLXJCrrTVUsO3MaLLau4Wh40mvMGKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794556857;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FNM0+Gbs89qhYCIsRWQ2+LM6nKtUULmAfqDYB/OAGfk=;
	b=Jx0dLQjGnpaENPYF3jdF392e5tSUgS98clocZoLHnmMIktd7Nyys4m3lHKNFNQX3szTF
	 TJ3B8JmKYoK0r3Ewyg5+rnRds2AWRPuQZt6W5+LhWMISxXedRdGwmCAFjrxmqa3ej5Dyp
	 x2ynKR8cu2A4PmpsLnCIFFzzsgwuYJ1Gz7uRyxOz10IpYYcn37TWqcikHPaqZA2q1Mu7Q
	 a3D8VK+KIn3dU29Ge7oOOKmnFiNmlz78EC88gYlAFfxBc+310z0hcY2JvimGCJb8zHGdN
	 iPWkmxt2qmxi+L7gIZVcebSnZvaEHBq4pcT95Ny7Pi71Gb564+exiMXD8AOebIug9wQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kz71YDOC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PmAsxdDi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28212606A32D
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 08:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28212606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kz71YDOC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PmAsxdDi
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD57HSv1973522
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 08:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FNM0+Gbs89qhYCIsRWQ2+LM6nKtUULmAfqDYB/OAGfk=; b=Kz71YDOCG6MGa4OO
	omCac5hqmQ8LB6GGuYtwxpMC8O5C2E5AgJCvsmrKeQXyNvJIuHbIMTCwUTUmmoPp
	dBpjqftP24hkxQp5YR6oxPSajBE64d6hxGD2nJ8pjqIDtYmzySzzmLdA/iXh/eAH
	/rnXG2CIi57BVkDsZsRCUPtXF8YX1EKQLpiOR3b6oenFbanMvu0T34Ne0/3x+kAm
	r3t3tnr2KZBmoB4pkvQAxHTXAYOePUnU5Q02J5XGJVuf59h4SEOdmlDdiRTJf3EC
	cxFXjaVocK+D0o+mAsCzMcIUxj9/KkcoPadzhdCunDEzqx1pZawYVNoMoplsJR3n
	ukoKzw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwg1bb473-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 08:00:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36ecd5db581so2507006eec.0
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 00:00:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794556856; cv=none;
        d=google.com; s=arc-20260327;
        b=DqJ9ckqjU3Tvtj9HLe+W4qDrb+xdNrO8j5yxpAATx5wx9CR+4iCT/DoTGFxnREaQuf
         FR1JnWYXO1R03CvK7+MMge0ZVjD21FId2AOdQbCxKGMzwOxNw3fbEGjEe0JnZ0x69h5+
         PlnmiPnyIh6uSktE+wwnJWjQmnNmTyoYUkPP/B4PVJ4pFhRCzTQCNHgHlmWkKs0WuXUw
         cHpLcifXJQP8NM7RkCTM2lPHUmTw0qAhAjA+0874wW21H7vmPrDl0io7ploH7wrEBvrh
         Do+e1j5+xvObElFuNUFWbuZ84E0+nXG+Buvf2v1NsuiiGrXA2c1ImTfrm4Qi9wRR356p
         CRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FNM0+Gbs89qhYCIsRWQ2+LM6nKtUULmAfqDYB/OAGfk=;
        fh=CIFNvJ1Tkqysyl4FhMTA3/oakxP70ShlRnwSZ0gxoj4=;
        b=GMR7jbiZ+MsryOISL5WshfMzqgXDQGgz2VWosINfxWf5JUITqzvtHdfR+q9IIRZJu1
         Ho+5d1XWpUR2qesDNRZhOSH8BAr6/TWTQ5J05KBLXzQ0N4at85q/c1XC8ZuzKaWnnG/X
         nBnR6RU0h47yo8QNDObQFntoR/9rz7GU+k80tYFG7Ijz6cJKnhnCKSumSs0zqskmkiTl
         FhLWFX5xjAoUbYd9xLtczMoVKjODTz/UxIOcD/cLhriN50M69wgYKuhbASkl5OGuy08b
         Yar+91ckisl9mxqXEklq9p5ZurMWkM38z4lcd/jyjdGZFTS5gLikWTto91gZNC9DiHgI
         bVRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794556856; x=1795161656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FNM0+Gbs89qhYCIsRWQ2+LM6nKtUULmAfqDYB/OAGfk=;
        b=PmAsxdDivcWKEr/vppXhflFQ/pSfWJQQvCDU+wjw6o0boU5YZE8Zzj7+qe84zwNgWD
         4mVrmE2Q/SKUb4Pk03hItackrmri40LEAvzhX7+omGqwoiTLycjoZh+P30ZyLs8CUEty
         QRkFDQ3fE+yEUV71v3ACiQN5wue5Jl/ePhMVfkyJT3kC+l8E7rDLyRjB+HYNkgMUekDs
         uo41ASwa4FhrqjPUGvDah9y8jJDyncASE2TwhFk5OiZv3bdfU78R7TXF5KJvgKFN7pyZ
         6dcZJJnyAXkkUHIzYqJZyLnSgaz7VjMw9kKz7Elamc8+mjgfWN7pkb+q0BdNKLwCZjpS
         Lq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794556856; x=1795161656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNM0+Gbs89qhYCIsRWQ2+LM6nKtUULmAfqDYB/OAGfk=;
        b=jw1uytboZSt1R3uRGKz59ZsJtmnasEO7GEz6rCgJF5fSbdbLcOoaQOumt+rGJv7pEV
         C7jB0mcDt1W8CF4MWbbkDTuIUQlHYXBNEcnPy189lN69P4y/QWRyhKMN8oB4I66wz/+a
         ZZBFKfmke+9QPTVgUM6Y8MMuMvgKLq2Dttzc+Hq7yiw2thaRP6W9m+3lVgT1oABUbiwK
         +N4H4c1yFwyoDYsRFUmG6+JTqZQd8cyVMcBgvirhPNc42pYcut+3O3B9rr4CiG3KePPX
         d6QnkJvIwadSrMw2+e60+ihOicT4B5NqudczRh1oaZCKMqk24Ou09+WHDQ6aOIW+mGsH
         lUSA==
X-Forwarded-Encrypted: i=1; AL+hErF2yMxl2eREISscqSh4I6nhcjDgv7qkg7hkRTM+tC+NxhP94A+TkhnYDfQDQ6quNSS7+7A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vKS4rVCZfEfrwOxsFcZXvCi6mPC1pnx8SkFuXifH7XpXgUZOL
	JUtGFup8qALNEZHtNSGcVEpiXzH50XG2f2Fuhv81M1BpdgrEzDv8dJFA3hTTCHXtSJX2sF0DedU
	w9n7zYxYBZfITtmvH5iahuVnsyBwu+ai0fYUK46zoPiIjVF8OJKYWGKmkvomm0ivaNyPSknReKj
	Bt7zZ55zv/pKelN8rLzljfTvaDgAZvNxYeO7H9Z+to
X-Gm-Gg: AYBFou1C+8DVcXRiVSJPMNeEnMeNU8/3m42PmaMnqtFZwYDdIwwb27mIgKIk47TQqm3
	E1xxZhSjY/o6Htnei5vRUaIE7adAcSvpHmfOKh5MyeQrFpPT7UBMEoiua+jAPBuIbh59meZl7h/
	fxJ6b6FNu0J9G1q8Ag0SlRwt9pI0h8L/BiDSTDV2sF9weaYd+TSyeJG7HBtFw=
X-Received: by 2002:a05:7301:c02:b0:36a:50f4:ed0d with SMTP id 5a478bee46e88-37966766d98mr1454897eec.25.1794556855435;
        Fri, 13 Nov 2026 00:00:55 -0800 (PST)
X-Received: by 2002:a05:7301:c02:b0:36a:50f4:ed0d with SMTP id
 5a478bee46e88-37966766d98mr1454857eec.25.1794556854546; Fri, 13 Nov 2026
 00:00:54 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023142550.148604-1-oleksii.kurochko@gmail.com>
In-Reply-To: <20261023142550.148604-1-oleksii.kurochko@gmail.com>
From: Anup Patel <anup.patel@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 13:30:42 +0530
X-Gm-Features: AclHuK9I8L1Jkoa68vnSH3mJyt49oobnf7EDpmkY2TDzdHkp1PyujMbXCJ4T8rI
Message-ID: <CABBgwmuBBbyBytwRBTeAqF=0c1m+TFK8E3yPopGNQAsrMFO2vg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Order IMSIC VS-file write before releasing vsfile_lock
To: Oleksii Kurochko <oleksii.kurochko@gmail.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=c6Q+0h9l c=1 sm=1 tr=0 ts=6af6c3b8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=NEAV23lmAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8
 a=loDQXBK_udfRwOWNHxcA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: A60osYejVZQHYXNSAiwj2j3r1q46JVpr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfXxTqBCU+wHc67
 /89SKR208p3grN/7FcOrfc2LEbFCcXHpth9+p2tYRgRHvMVfiDm3Q/WTpgy46cxYCpygbkK6kDF
 noNAejWsVaiMgB12T0G7sxDJ2zqCl8kHepajFynw3qa04qdGA3+PWQsS4kR464VG4mKRQbrZsWR
 22LZ6kCnehiyDdfyPutX2Nb4SWKj+h4FVX6f1Qr1HqcecS8tBjO3anwETAn07Z2jVuAvRy9ZBbl
 jhSM9p6+Jiz075OOhuDYtbiU14+PZ2lvUw8V4EhNwKcofODraljuK1ZTukRAuC0AyLrQQ6L5uiG
 sHSGKBpK4mUl3VCWgSm9Oi9bdF3zQxqJerqyDmdHyQfJMuyPeEPlO8gy/hBlipUn0BmhYfIVkTe
 RXFgrzEEsyDjNa2vgKNeRopdZrrQlYUwPIXGDnj5KyhjRbnm34GYU76WrezmXH+0q2JQgtRbsVo
 XMvzwcKdo+pSxbkdj3A==
X-Proofpoint-ORIG-GUID: A60osYejVZQHYXNSAiwj2j3r1q46JVpr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMSBTYWx0ZWRfX/vyO0o3UC1gd
 hOrDkMR6DD8EoII+CJfoHMwW/OEzJQGwWmRl/Nz6jEmd+u8552eBWmlR1eaqo/ydYUclnyDQWyd
 jjE134NkL5NhDiT26gzwr4iVpCqZPz8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130031

On Fri, Oct 23, 2026 at 7:56=E2=80=AFPM Oleksii Kurochko
<oleksii.kurochko@gmail.com> wrote:
>
> kvm_riscv_vcpu_aia_imsic_inject() writes the interrupt identity to the
> SETIPNUM register of the vCPU's IMSIC VS-file while holding vsfile_lock
> for reading. The lock keeps the VS-file from being switched under the
> injector: kvm_riscv_vcpu_aia_imsic_update() and
> kvm_riscv_vcpu_aia_imsic_release() take it for writing to move the vCPU
> to a new VS-file or to the SW-file, then read and clear the old VS-file
> and free its HGEI line.
>
> On RISC-V, writel() is followed only by mmiowb_set_pending(). The
> trailing "fence o,w" is deferred to spin_unlock() by the mmiowb()
> tracking, and rwlocks don't take part in that tracking:
> queued_read_unlock() issues just "fence rw,w" before the AMO, which
> doesn't order device output. So the SETIPNUM write can still be in
> flight after another hart has observed vsfile_lock being released. If
> the old VS-file is read and cleared before the write lands, the
> interrupt is lost. If the HGEI line has already been handed out
> again, the interrupt ends up in another vCPU's VS-file.
>
> Add an explicit RISCV_FENCE(o, w) after the write to the VS-file, which
> is what spin_unlock() would issue via mmiowb().
>
> Fixes: db8b7e97d613 ("RISC-V: KVM: Add in-kernel virtualization of AIA IM=
SIC")
> Signed-off-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
> ---
> Why RISCV_FENCE(o, w) and not mmiowb():
>
> - Since the mmiowb() rework in v5.2 (e.g. commit 60ca1e5a200c
>   ("mmiowb: Hook up mmiowb helpers to spinlocks and generic I/O
>   accessors")), mmiowb() is an implementation detail of the spinlock
>   code. Explicit invocations were removed from drivers by commit
>   fb24ea52f78e ("drivers: Remove explicit invocations of mmiowb()") and
>   from the documentation by commit 915530396c78 ("Documentation: Kill
>   all references to mmiowb()"), so adding a new direct caller would go
>   against that.
>
> - RISCV_FENCE(o, w) states exactly the ordering needed here (device
>   output before the store that releases the lock), which is fine for
>   arch-specific code, and it is the same instruction mmiowb() expands to
>   on RISC-V. wmb() ("fence ow,ow") would also work but is stronger than
>   required.
>
> Scope: this only orders the write before the lock release. Whether a
> write that is already in global memory order is guaranteed to have
> taken effect in the old VS-file before kvm_riscv_vcpu_aia_imsic_update()
> or kvm_riscv_vcpu_aia_imsic_release() reads and clears it is a separate
> question, see https://github.com/riscv/riscv-aia/issues/172. If it
> isn't, these paths will also need to drain the old VS-file, and such a
> drain depends on the ordering added here.
> ---
>  arch/riscv/kvm/aia_imsic.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index f17dc559a709..807bb73a129a 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -1056,6 +1056,13 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcp=
u *vcpu,
>
>         if (imsic->vsfile_cpu >=3D 0) {
>                 writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
> +               /*
> +                * rwlocks don't participate in mmiowb() tracking, so ord=
er
> +                * the write to the VS-file before releasing vsfile_lock,
> +                * i.e. before the vCPU can be moved off this VS-file and
> +                * the VS-file read and cleared.
> +                */
> +               RISCV_FENCE(o, w);

Another fence after every writel() is a big hammer in the path.

If the intention is to have correct contents when VS-file is read then
better place to add a fence is at the start of imsic_vsfile_local_read().

>         } else {
>                 eix =3D &imsic->swfile->eix[iid / BITS_PER_TYPE(u64)];
>                 set_bit(iid & (BITS_PER_TYPE(u64) - 1), eix->eip);
>
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> --
> 2.56.0
>
>
> --
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv

Regards,
Anup
