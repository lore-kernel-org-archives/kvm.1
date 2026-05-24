Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E039314B95
	for <kvm@vger.kernel.org>; Sun, 24 May 2026 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652169; cv=none; b=RXankqC0OaubbgTYLQgql7zZBlgtqWb8rCRAWrg6wBv9ksOQIm1ye1ySfwU+BhfpHxORE+oyHk6Tv27RuhCLIJvaAGdFlgEdnxXaURB2OnFUqbVhjHgF2bXATbqFk8woPQJcxpKB8YdHZmDUoAkbWnZKTOtW64VA4aegioaegN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652169; c=relaxed/simple;
	bh=Aikse4RE6NDmdwoW209Q/3yBuQ/vdaxwxVtNl3i70Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYN+1HkzZKoGH9v8x598TqbZTxGavW0Nsch1Ssrv0WDdjAdHzHcV9xCA8egDSt62Dp14pI2zmUIVH7NBOybINr2Z0ug6PiP0D5N/XQ7MKwH3Xw4i6Ur+EH5fGJc5yIpgdXdg5aVvjsciCM4HG5GfMxxZGKc//hruwBY2bn+4c9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N3Wz0mnp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jwi0oRdC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N3Wz0mnp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jwi0oRdC"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64NMo60B3079108
	for <kvm@vger.kernel.org>; Sun, 24 May 2026 19:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=J5MO/OMSAh+ISDr45BR8NwJA
	XuQI8xvKI6XO4ycoTj0=; b=N3Wz0mnpcXw5UIH0b2xrFG3DN3CKQzkY9k2DY9eM
	Qso5dHfjbzeuP7oy1uorTKXI22jUThALjtRfxAcvs4E78L8yVrSRhmjI00oepO7A
	kSq4ANK599NGcpX8yAeN+pG7408cOdP993E8LCBi8GONTLtsVb/yZ34zxuhud+Wq
	Q0iKNxI4377/ah9tNN5qK01bcgPp7GGUCuB2/uI1NHBgOIFy6w9g5WsW+WYlp6r0
	y6wVf+9iB9RYicyHIgZUP9GghqNoI9xiL304LpaJsLIyjC4fCubBmN8IoCK4D6kF
	NlBhuyZLFpZMG2FY3v9KsoVx5cKG48i71tfATu39JOfZiw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb88w3d4x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Sun, 24 May 2026 19:49:27 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2bda35eab74so8154935eec.0
        for <kvm@vger.kernel.org>; Sun, 24 May 2026 12:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652167; x=1780256967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J5MO/OMSAh+ISDr45BR8NwJAXuQI8xvKI6XO4ycoTj0=;
        b=Jwi0oRdCzA9PJxG8Y2+c5nDoEuDVADR3wV+hmx+TyNHdyQHWxTijv8+gtBoGSHiaLW
         xRNZFSaAi1VLXMK+7M/PyiCbQbVKhvGdLRZNKmq9t6/cJeimJQIb674Xzpprb6PD7d1w
         NxG/G4B4GRWXVQ6orDa0mYbK+pPWbXMNkiLkroGGI6/trx/ZCTygeqo9hNdrYj4fSExR
         VjEkE8JY7y9ab4SIV6Q2m+7QlLcRgmK9zbPvCt1xOWOW4Ve1iriSTKqY9aP1q1R3oYIv
         rVtFdSAMtKlBC2uqoaZyzKAcyWWtTyabp+Qe15SecTWSfitRF2KWZr/ik7DoOubP1ke6
         MlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652167; x=1780256967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5MO/OMSAh+ISDr45BR8NwJAXuQI8xvKI6XO4ycoTj0=;
        b=o6neuV+8EYU2B6yRlVGVv/QSLBuE195+1FtoGB4XssATg+kzsDcJj2OYDPH7zNcK88
         71PbmIe5gGtGkZwA161FuT2N7yKtuJxiZDqdfVmeHig03jJfKYiFdklJjtuUt6BXBrw0
         51WK2RNFSt9C7jtmK4zHQM6n0jwhYZik273z2Ce5OHSWsQuyIbDZVoYa6MuLojKrapfi
         zvFpe/NPvzB9Rk3ix5L++03fRzYCrkXw8IV8d+IKzhmV7yKQkNuFprMNw4F6ai9uH4Vb
         vRJGsbEyVmE8sRYKL4+VaHa3N3CaRR1hjy4gL1HyRUd/2ByDq3STnhQaJyInY6/XqYfm
         VCfA==
X-Forwarded-Encrypted: i=1; AFNElJ9jDWVJQGzxUBsZTPJpCHH8zcg3PeSS9JHFcL/x2RubLT649MPpCCVkSiK9nMF8SU1USnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlbTOJYBnMKoWo5cKUpAp54zM1cDjqa0shJDTUc3CIEz8UkEjc
	qRtLsEA2tGEWjdDQ4Gg0gI0SVyNCv8bVkBs2GAbapBqlet/cwLhUAsd11RLuRhRMBVrUEg9z7PV
	ca/xYydkGZTYpFVm+AWVlaOnYgDv3MUrowxz6e8pYw494jj6TxDvpUVI=
X-Gm-Gg: Acq92OEMOqBLNsuVqS2WPuo3WIkYycH1nHH6bmkxHzdqRqo44Fu3rpIx2Pek0ElrsmN
	fVROhFwqNxZLieZqLeiIulfQE0XlTrS+yq01JnCqLaR42HEmTUo8WSvpLCrFMsH/II/ZIPMycOF
	zqOuxmtYkKaGMWLmZThWUbrqBhxAiwwPoEfa64i3BRuTqzeq2q6zxXQhT1tfYTalHstvCQiD7Hk
	ZH5o35QlCNiuCszim0xfOcHlnxQvSoK4GQYgEhLU384mGpRgEc8s1B+fOnZBLF0UdxSXfmnsUGP
	+0KZlN+GvhnTULN+odltQX5mQ7bfz7lcTMaGRi6uP13SYDhn23Eo/Gc4UQ/A0VwqNRWxDdLJ/Zz
	vWHEDa++ujB2/yARUsPwYbGKYrJIVLrQ=
X-Received: by 2002:a05:7300:72cd:b0:2e7:190:41d6 with SMTP id 5a478bee46e88-3044a3f996amr5218053eec.2.1779652167004;
        Sun, 24 May 2026 12:49:27 -0700 (PDT)
X-Received: by 2002:a05:7300:72cd:b0:2e7:190:41d6 with SMTP id 5a478bee46e88-3044a3f996amr5218032eec.2.1779652166440;
        Sun, 24 May 2026 12:49:26 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ef470dsm6221072eec.4.2026.05.24.12.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:49:26 -0700 (PDT)
Date: Sun, 24 May 2026 14:49:24 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Cc: ajones@ventanamicro.com, alex@ghiti.fr, anup@brainfault.org,
        aou@eecs.berkeley.edu, atish.patra@linux.dev, jiakaiPeanut@gmail.com,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, pjw@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Fix TOCTOU race in SBI system suspend
 handler
Message-ID: <y5hmqjrtgeby3amnlfycifpfm2dc3oaj5eebgvdu3tgjjgohvx@kw3a7xpxqrbt>
References: <rqpv3mrcsxxdlaedbckb26bf5vfkj3xgd6m26me24nf4tbcqtb@jh62r2df3ur7>
 <20260523013232.2352161-1-xujiakai2025@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523013232.2352161-1-xujiakai2025@iscas.ac.cn>
X-Authority-Analysis: v=2.4 cv=S/jpBosP c=1 sm=1 tr=0 ts=6a135647 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=fKUkpt_rHN1RTTC0GtAA:9 a=CjuIK1q_8ugA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfX/jTNDUliklvy
 9+no+bcHvwVG2MUZdixJ07cHOVAoWTs5EmaT2MLhCRYoOXKbVC6azGyDzFuAstbjtgJN/4U3T5c
 oWKthR2bH6V6Y1fkbw4dgYCSd3aOswUwPGb+xKHXulBbLvNKPK/6hX+C7P5GQRdH1iop/uMJsXP
 J7Gn35fGdFjKmDYKWbpsuPcNHLLNofoIeYixlFX9m/Qmq47Xm5pBqa3Ks3hEvlFlcUMyKLmkorO
 6U6ED3WI6psziOq0xpjfEFslsp3Z+a59L7eRxZCxnolbrBrwexwFNso9DssNhwctfN6WwR0HMLk
 Eoe2A5oMeK8DSZDMg0p5q0rA6YJq9QZyFod4zhVnMSpe8SIsMXw4oqf4tT1wgGNydaiZAWOoCj1
 KgwFzitymBGMxqRjPBtaCnqO9GhOnyPf4qDxdr6G4riOpS6yEpYfG06vCBY7qsElFpru0mN5pBO
 SWPFdSMyqdGK+Ctoctw==
X-Proofpoint-ORIG-GUID: c_VPYtnu7OPWgDTeE6Gh_kaQ9ghcNdKH
X-Proofpoint-GUID: c_VPYtnu7OPWgDTeE6Gh_kaQ9ghcNdKH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240198

On Sat, May 23, 2026 at 01:32:32AM +0000, Jiakai Xu wrote:
> > But... before we get too carried away. Unless I'm missing something, this
> > race really looks too theoretical to justify any change at all. Do you
> > have a test case in mind that could force it?
> 
> Unfortunately, I don't have a reproducer or test case that can reliably
> trigger this race. 
> 
> But as we saw earlier, this is a real bug, and we can tell that just by 
> analyzing the code.
> 
> The real environment is complex and unpredictable, and such races are 
> possible. Wouldn't it be nice if we found it and fixed it now?
>

I assume the scenario we're trying to fix is:

 HART-x                                                 HART-z
 ------                                                 ------
 SUSP()
   Check HART-y is stopped
                                                        HART_START(HART-y)
                                                        HART_STOP()
   Check HART-z is stopped
   Determine all HARTs are stopped and exit to userspace

Besides the fact that the race seems quite unlikely (only a pathological
guest would try to force it), userspace can/should still double check that
all HARTs are stopped before proceeding with its system suspend
implementation. So, since we would need to introduce a new lock to resolve
this very unlikely issue, then I'm not 100% convinced we should. I would
be more willing to fix it if I thought the host was at any risk, but I
think this is "only" a guest corruption issue. If the guest does wild
things like this during a system suspend, then it can keep all its pieces.
I would agree that we should add a comment about this choice, though.

Thanks,
drew
