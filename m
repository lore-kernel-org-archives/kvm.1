Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618017;
	b=VcbgGETML1FkL1gUxtHWjKB6wpyowyCIQSkMm0wFLDSb7ibIiix3NDJGb3CYaW1u2B8j
	 paHf1/z7fOvr2S9sykAYYhsL1uaJMb8tRxcB4sD7pyPyIEur+Yy6H+dSdBFx9uXcu7MJO
	 e/MjyTqnqJLtS5Z+qJc+Xy7hXUMDrb276pqlUyD8PZ6zYIcVcdrgdciB8M6YCD0ylhDPI
	 7AIq7VKNNerxbqolft5y4yRlrQ8Z2IH4KwV0phgxpCT9/kOYxEUk36RmBTxcckwtkpax+
	 HRQGoidKlKDdQabTJdQJMIQ+B0qrwTbmwXTMEqAn/Wzn0SttjLJXFLyp64Zix6hz8MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=a8Rvs+APlES4o/Y+QNKx+Wsj0zsjMwsSLTHZLYdVhZI=;
	b=tLighUQNV4akwHqYgZxyREiS7X/S1nqK1/bkauKlXqQYVFGGjKnvxgqrDk0eR4PsOWDe
	 lbXN3gcPU9LvCnyIZ+Le/IHE/4ETVyka47T7Wc27jU/5xh1C8gsTicZkFZRngXu6VY8Vr
	 f2p74ExYGMBPCwQQ4hi/+La1h+hyuNfROA1PUk/1YvRSnWq3uRYjLPoFg2kka/McFyE0S
	 0h+sKoXGCPkSaxeZoM/pX7es79IdtjkOwmCOD3LQhYNwMNJ1qtubRSu4R/zI9ojlaKNlE
	 YUUxI7BvtkVBcCYATFZ3e8UhhtuR0dbkJki6xU9GjneqaNproCcGQvrqZWr9+JgyMOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NrH6aB6V;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDB1606A324
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 11:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FDB1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NrH6aB6V
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1008948eec.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 03:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793618016; x=1794222816; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=a8Rvs+APlES4o/Y+QNKx+Wsj0zsjMwsSLTHZLYdVhZI=;
        b=NrH6aB6V18WdvAaTOTYu2ib/o3fJ3G04pmguQH+yPdqTn82Eo9//qh9iYqXbBLisDx
         CMU3fG0f7a1PTXKTWI1ryI+9KqeGmtILbHEzpfk9PGQ8M4k7bgMvRWiglac5kEgNrizu
         ITizSUknar3bqCMxA15U+b3wAE7H1E8/6mh6Zd186ILeujGUFTzblfL8010uYcnAq5gQ
         FYwmkTxWmZrsUXvjH/0JvXCyLvWITeNPWjt3vBl1zd7RzaA+KgtM9R2nH+JIgxWsg7VJ
         U+ymX5bkZDPRoUYS/kpqj/lNx+XVzqlWvJo/RTKNKWgXYCFeIhSx+EysUSeT/MXSiLHf
         XuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618016; x=1794222816;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a8Rvs+APlES4o/Y+QNKx+Wsj0zsjMwsSLTHZLYdVhZI=;
        b=rAaxieLZOHVGn6LStkCQ/WBbbsi+1D1u7pMIq60drcmc2x6c280K3ngMt3lxa6FrY0
         UtZGoTr8Yp3AZornUUE+ddwathaEe3ncBy8sXul03TJHfV4Kn/CLrbMLbuwK63XYSYoG
         mQpbcPpSvLfRSgBnrbj0TWXi7kQwzMkgDJM1A2VOHK+P6fOkh9f8P4xnWUkk28Si8cL9
         mYmv9sTbKYyoB+F6d9te8lpQ2ztWhgV6Dbn1kQDNNa2kp32ucLzqdCcqzG20xHCRffSV
         m7zVYmNO9yj9lM52yZJ+IuNAp7Q/jfHtBQ6A0Nsl8I5AeJTUzOQMdxl3LnfL0zNwDOuv
         cvVA==
X-Forwarded-Encrypted: i=1; AKwUvBxxGIibBOGoZanK/9c/MfmLOt/4Wkx0ch6W6QOl2oZ1UCd+gUu963u+k1CkJLPmdO+QQCs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ps2Bxq3Vk4BHugB1Novfw+7AX31aJOPj0dhEd8ZIgk8xlklqq
	rBfid8RxZlqDbUkLimNRfA6VXcfqcLM+D87kPE4o0Z2Bv7gT/ex3/LER
X-Gm-Gg: AYBFou0BFAghvHC5A4g8T60wytb1prn0+GtwNaeQYQdVAbJqHmIWsv9aqRdO1Ua+JW7
	zvirPIuK2eTl7O16k2cgstHVhehpKjJKn2Xo7F7BwsBzNUwY5uL84IsPJD1e9/u1FZoIB7xaLlH
	eiPMK0jbOb5fSHm6yvEFf28to2vjIcNfIkRwDua0G8B/Vf7ZpHxzf52ZhYCp5hD/TjnUzOSSHFE
	W2uf7FHyOUt3t8fLIVOC5CdSurJmrb/D9vrdwCYuQhFx5Dt/PCvNWmFNCi2rM8ZcT3ag0Wdfw7K
	2AoyZPF4zp1tZwq2oeXjNDIWDiqvE++61TAZ3bcW+WV3MSvIrDoiSIJxZ0ID98xCu3Qs+JBQQQK
	rGMBReNGQsig4s1HOqMl5CFPDQiH2i4xwN0QDjCGIjlaGFx1jOsBQffUqy1kikrQzJXytniB1Pm
	veri0RBqWe0Vglu9HT+/xBTwghxvOD/uq6o3JMYEB75dcJ3anr2QsoGf3x3SuTK4Y8RZZRtzqNi
	nbTTtIfMe3HLcfqMb10Zqw8usxlf53rRiOBvAcBBh7zqhevw97ld+DWdb/CkBB0yGrxLTsna5aG
	t+trlm+6RW6a3pP4EtIBXQyVx6c=
X-Received: by 2002:a05:7300:3b1a:b0:351:52ec:60ee with SMTP id 5a478bee46e88-36a423f04b7mr23743030eec.28.1793618015928;
        Mon, 02 Nov 2026 03:13:35 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm42099651eec.11.2026.11.02.03.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:13:35 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v5] KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit
In-Reply-To: <20261102091700.253381-1-gautam@linux.ibm.com>
Date: Mon, 02 Nov 2026 16:42:12 +0530
Message-ID: <y0bb5vxv.ritesh.list@gmail.com>
References: <20261102091700.253381-1-gautam@linux.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Gautam Menghani <gautam@linux.ibm.com> writes:

> A huge number of spurious interrupts can be seen immediately after a KVM
> on PowerNV guest boots up in XIVE mode.
>
> $ cat /proc/interrupts  | grep SPU
> SPU:     223705     192439     273526     147623   Spurious interrupts
>
> This bug was introduced by commit ecd10702baae5 ("KVM: PPC: Book3S HV:
> Handle pending exceptions on guest entry with MSR_EE"). The root cause
> is that once LPCR_MER bit is set, it is supposed to be reset by
> software. But when a vCPU starts running with LPCR_MER set, the vCPU does
> not exit back to the host until the decrementer expires or there is an
> hcall, etc. This is because KVM on PowerNV guests have support for
> native XIVE, so they are not dependent on host for interrupt emulation.
> Due to this behaviour, a huge number of spurious interrupts are seen
> since LPCR_MER continues to be set and LPCR_MER cannot be reset until the
> vCPU exits to the host.
>
> Fix this behaviour by not using the LPCR_MER bit whenever native XIVE is
> available (currently in case of KVM on PowerNV only), as the XIVE hardware
> can present interrupts to the KVM guest vCPU directly. So the LPCR_MER
> functionality is not required. This reduces the number of spurious
> interrupts drastically.
>
> Fixes: ecd10702baae5 ("KVM: PPC: Book3S HV: Handle pending exceptions on guest entry with MSR_EE")
> Cc: stable@vger.kernel.org # 6.8+
> Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
> Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v5:
> 1. Drop the redundant check for the presence of the native XIVE
> device. (Ritesh)
>

Thanks Gautam for confirming that.

The patch looks good to me. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

