Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70BC2DC798
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033733; cv=pass; b=knz2x+FzEUbggZalEdJNJsgU/obi7gYxgj3we7w5G6UlXmpJ/AseL+6IEoI3zIFXHp6BHWlnyNiUBc7Rw5wzFx6QlT8B6+5Pk9/eGwS4DgHYvoqKaJjoWYVPBOGOsF4jgLxQDc21g7PMZfHgLe+D1PZIqwVwqQmXZpw4QUefpOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033733; c=relaxed/simple;
	bh=P9oAoZ7SecBGhbTjR0WqYokr5JGDD2Bt/xiDHYc/qjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y23vPKWf6pqf+M3aOK5PGUchxr6gnEVP0jromyolcLcm+FmoFAri6Zw4SeGwULaPQdalnOSLLRNq/KNo2kRI/3TvIoT6fgkXCdyjLGZqTAhW9c0BarytLswyh3gnh31srZmq1fKUlUBle041pKpBQw0aYnZvZ1qF2bXqZYOalGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F4KnF94T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OwseXXVR; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F4KnF94T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OwseXXVR"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A8pbMN3967625
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 09:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fe1R8wzIKX66YSLfrokubx/6sXM/pQiZhT04/7N60Yo=; b=F4KnF94ThZPlCPXB
	ELuACDM7vfX4nzSaDQPZ2nwfPYa2kiethzdgojbYncp/GJlM1PpgA8MVhziljHN0
	BMbRolZ5FAeZf0jub24aO0L3T9DtkEcfIEALAv0acWO/t1wPgcEvOs2sWoRn+Aap
	biHeqtD079eamRlmvVsXGYHa8r81KTcGP2nxsCgF4ukpAjn2rsbbARgaSROcSUJK
	LQtnlrO4tNxIrr74DK8xfSTLUlzJcbwUarRsEBHldvcrGARMsOxRqzMQfIJLLWeL
	nxhu+fhvZkFKfTrgJKhnQ7en80JXJF6QQ+mGHAEc0W01WGcqVlzJZWR84QN/6KrO
	PYr4dg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkrdn8g6r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 09:48:50 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3965ba1ba3eso2652753a91.2
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 02:48:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789033730; cv=none;
        d=google.com; s=arc-20260327;
        b=H+u2x6EuSKoNamEev6myMHgYp8lWFGYjNdjWmHpxHEerco637bUQdDStknxqKGSQhh
         ucTB4LbbZXOxAIV5YkMG51zqN1ADIB4nkcp8ucasEs4vlDkiyU016PDA3Tt85KMeMjiG
         w5kTt2KxBoBshP0pt03XIEjIkBcMjwUc1PP26/fZYLCquGUF2P5THrwI2KvzyHR9Ep4c
         6Xbx/pr0aoHE6ZHpBibUlydyV0bbLF1xvVii4qSHZHn1YeGsGuKirI43RJ3yWboYuwUM
         aWtYSCepMMIOpccYZe9yu1rbpeoN+LpuO/tz/xwA3+Z30uQc+LkxYxMfMN3UGniT+k55
         Yu/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fe1R8wzIKX66YSLfrokubx/6sXM/pQiZhT04/7N60Yo=;
        fh=fSa9b+LcB7rYdNHx6Ya4lnn6ulOx8ripi+aHoz2BMlg=;
        b=cBJZimm83eL/h7JpdUZ+szauMeNEeb9o++3obt6TPOvTwLzCsLZ0dL1VBEpdZ6+fAR
         I20vtFFXsMyoS0aAvMJVNiac8ehvWNtP2vv6P7EWX1k5Q0fcQsKAasyFh79qlL8SaXSh
         FbRw1hq/2/jkuAOpfbKBbFwoa+WoCB4M2mCau1tAU5jLSfF1UjTXe102LMXBzJk9IDF1
         FD/FuDG2wxf4kW8dE2nVkfdcVH+Kf5mHFMeSpXp96hVjA2CevulfTk3aSgwUj7Xzs3YS
         W3M9i+gfXPptdaQh+uu27LprS7svbIhDdnFklK5wPcsLUJdLQ4vEjvQKkuSxGAq5y/Tc
         8eJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789033730; x=1789638530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fe1R8wzIKX66YSLfrokubx/6sXM/pQiZhT04/7N60Yo=;
        b=OwseXXVRLXcLF8Q/LPoSjzcEiRysHr0EM17EG8aa4L1CrcOSNiXP6yD2eO+93JtM/V
         Umau0lahU0kxuWa2G9Q0bxTAXotnAC7GAB5KGcpysPKXrEmmJtNy0zKFHWT+1uH3TLYF
         xqlR+uWqLXPEAyyWp5+zv2xsEw9hQvC0sHmy09rod0ZXKL8HjOiEaY1vpiOpETcXm5d0
         dHysh7jXqzQCYAAhBK/jMbQHTOT+AQ5uVQIBtZOT4QdlBsG+SISwyejnEmW7IQQswpyo
         ctymM3jO35TWL7/l9wkNXWOEiaOGAkAaKXZpQK9cN9Lh2L/f20smPNXtjkf5ormpfVlI
         ITig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789033730; x=1789638530;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fe1R8wzIKX66YSLfrokubx/6sXM/pQiZhT04/7N60Yo=;
        b=skOJqC81NTfPBpU3uSTu96idgAcUMWKfdzrl/aCCIKHAEyCE2rxUc3qskUxDXwX8Qy
         hTe8BX+zm2JTX04trWP9E33Biz3md2xUPg4yNgEmA+FvSFtdWYmrNf55t/4O5zMWxsXX
         +AIEiqRxqIm2srTFG3XC0wH9ZygjxoesB4oGVPrfV9KTfQ/gGXtTnFWESL2JAT+Congx
         Wv3/reOksaYZXoCd8NW1dsjy5F2QFL/Amq1VO0Cot80FgFOI0nuhc59cwiQZxMKlTh2Y
         0ubfQSJHPoy35sN/dXjN7FZCDs3CYLOKb0AoOqyQbFM82rJaWawVWQg+fBVt3dRi185K
         MKZA==
X-Forwarded-Encrypted: i=1; AKwUvByWPXg18wb40/bssf6Jerow4krAvMv/rqwAyed8aywhb8CZA7PH1EZUHMsi12//Zo+gflA=@vger.kernel.org
X-Gm-Message-State: AFuF++lxPOyGtpUkqI+0yl2nmUilAT4NHeS4TyfT1EmltnONpGSTAC23
	oQ3ud2tnfGqt6Kc91yF8Zsu7e7g1UHeW1XfAhEgwUAJH4CHLeYtDxojW2cm5Hg6hXITVmEuMoPN
	25Mu/pzCCrB/86NyQCsheY9iMwdpTD63DDs0mEfJAuA4MHEYxaQxSzTuX5t9DzvdGZwTWEMRks9
	kO4h0Bx0lGd1MQl5Opa94ukKCOQeQTig==
X-Gm-Gg: AYBFou1jViQ7pvUGjajttwTLOWDYCaVV5VbFmoIywRP/cyC0p6JntpMe8RX1wpFFFNg
	VRI+k/rc8Tk1fULSD+hxx/HtdxKsGO7ZWx0geXGDjKcsFSek3CvCi35JbHG8cGT7nWmIRsKmloW
	UTDKihsr8SzsLvriX3aW1N8Uvzs0CMZr0y1qkUhZdNR6nG1btbLVnt/4H+pg==
X-Received: by 2002:a17:90b:5485:b0:398:9be6:f999 with SMTP id 98e67ed59e1d1-39d70c2f16emr9938807a91.24.1789033730188;
        Thu, 10 Sep 2026 02:48:50 -0700 (PDT)
X-Received: by 2002:a17:90b:5485:b0:398:9be6:f999 with SMTP id
 98e67ed59e1d1-39d70c2f16emr9938760a91.24.1789033729754; Thu, 10 Sep 2026
 02:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721073612.137259-1-xb@ultrarisc.com> <20260810-imsic-attr-race-v2-1-00ed95ad321e@ultrarisc.com>
In-Reply-To: <20260810-imsic-attr-race-v2-1-00ed95ad321e@ultrarisc.com>
From: Anup Patel <anup.patel@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 15:18:36 +0530
X-Gm-Features: AcwNN1VtrgITlL2Xz8ROk6p7GYj2cQAUch2tRwnfxZo4Abg2uCG431NY2Z7hSEs
Message-ID: <CABBgwmtrZY_KB+ffy5At3sz4FjOqkePiDwCEsF-pG7ZBJBOxBw@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: KVM: Serialize IMSIC attributes with vCPU migration
To: xb@ultrarisc.com
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDExMSBTYWx0ZWRfX+DfXF96jpPRz
 twi3v3LHtwsvvC5WX9dCcryORQYWHsTY9cR//mPxRhlpt7c2OW8fmimZfhK4V4hvulZXIo1pGrq
 +lQ7+W2cQG35P6zuBoUyCDYMJ4CrblGUv05SIkK/lAu1XGFp5wtcbDo1Gy9WLggOLUBTPPj4DV0
 sNZTf51lOW9PSrSND2zXhzf9UNA7j1/pBs4J1kS2FCVO56RE2onHj+fYhIKHaweC3zT1PF41bfq
 XvS/Ea/wl3aDbwUXPvaYpc1l1Nk6HpQinRreoYSlJ7iXGaHwsEApUBOnV2W1FSMmaSlHUU0Ml2B
 77YkZCemZReg9PWkJ4p2BDPBzv7/9f8Xm0+qD5aZl20n3C1OpNKnex0qzaZDbFQXYFxMN9k/qag
 qctC+Zd7JCGmKVmtl8050+t3h5z58y1JCken7esli/yLMaaBFOtSJ/a9Mxa2qQ0zkta+MY/y/lP
 V153DTmA5OfpKNWP7ZA==
X-Proofpoint-GUID: 5idGcYoS6m79jAkDLptcJ6ieMz1o-1_v
X-Proofpoint-ORIG-GUID: 5idGcYoS6m79jAkDLptcJ6ieMz1o-1_v
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDExMSBTYWx0ZWRfX6mr4ISFT+Vi9
 iI2lA51tbGnbaNemD1RdyKh3Y3LniMZLNpZOMcUyBblAC72mKYVZlKu45psgOg2/5oN/jkQottK
 DYf82T4CUP4gZJOLpLcMfxt/4Gee+CI=
X-Authority-Analysis: v=2.4 cv=eOmGH3p1 c=1 sm=1 tr=0 ts=6aa27d02 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=Lx1EvxgrAAAA:8 a=W-_n0kkjAAAA:8
 a=BwDWKhTLMd55pYuKsv8A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=ZFi1QaP_tuf8dODdgmj-:22 a=qeNa2pbTr82C0GpJEZFS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100111

On Mon, Aug 10, 2026 at 6:51=E2=80=AFAM Xie Bo via B4 Relay
<devnull+xb.ultrarisc.com@kernel.org> wrote:
>
> From: Xie Bo <xb@ultrarisc.com>
>
> KVM device ioctls are not serialized against KVM_RUN. As a result,
> kvm_riscv_aia_imsic_rw_attr() can snapshot the physical CPU and HGEI of
> an IMSIC VS-file before a concurrent vCPU migration releases it.
>
> The HGEI can then be allocated to another vCPU before imsic_vsfile_rw()
> uses the stale tuple. A GET or SET attribute may consequently access the
> new owner's interrupt file.
>
> Serialize the entire IMSIC attribute operation with the target vCPU
> mutex. This prevents the VS-file from being migrated and recycled until
> the attribute access completes. Acquire the mutex killably so that the
> device ioctl remains interruptible while waiting for KVM_RUN to finish.
>
> Fixes: db8b7e97d613 ("RISC-V: KVM: Add in-kernel virtualization of AIA IM=
SIC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xie Bo <xb@ultrarisc.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-7.3-rcX

Thanks,
Anup

> ---
> Changes in v2:
> - Use mutex_lock_killable() and return -EINTR when interrupted.
>
> Link: https://lore.kernel.org/r/20260721073612.137259-1-xb@ultrarisc.com
> ---
>  arch/riscv/kvm/aia_imsic.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index d38f5de08..74f520e57 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -969,9 +969,14 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, uns=
igned long type,
>         if (!vcpu)
>                 return -ENODEV;
>
> +       if (mutex_lock_killable(&vcpu->mutex))
> +               return -EINTR;
> +
>         imsic =3D vcpu->arch.aia_context.imsic_state;
> -       if (!imsic)
> -               return -ENODEV;
> +       if (!imsic) {
> +               rc =3D -ENODEV;
> +               goto out_unlock;
> +       }
>         isel =3D KVM_DEV_RISCV_AIA_IMSIC_GET_ISEL(type);
>
>         read_lock_irqsave(&imsic->vsfile_lock, flags);
> @@ -995,6 +1000,8 @@ int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, uns=
igned long type,
>                 rc =3D imsic_vsfile_rw(vsfile_hgei, vsfile_cpu, imsic->nr=
_eix,
>                                      isel, write, val);
>
> +out_unlock:
> +       mutex_unlock(&vcpu->mutex);
>         return rc;
>  }
>
>
> ---
> base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
> change-id: 20260810-imsic-attr-race-06772a04450e
>
> Best regards,
> --
> Xie Bo <xb@ultrarisc.com>
>
>
>
