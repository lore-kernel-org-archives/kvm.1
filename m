Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817292FFF8D
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589015; cv=none; b=fVfMk0qsKjd6Ro6ZMs3RhGFasPtOnQ5VVFi4q0B4F7nzqTuobcLOwEle3Tod3aZi+fXy4WOa6VdNcv3rLxzBXCVgIRqk3LKfO/aNfyvfoSh7WnnpbXfPcpWtXeCWAliwFyIrjx/n6FYjjTjWMWaXGMZfmOt9zbCWyIVAIrXiAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589015; c=relaxed/simple;
	bh=Mpc15BTxXFPLS7siOrt94DVTxzgWbPGCx4J/ojX1QSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVJNZuxTGRhIZ+43m6vSsktmx/8ioRzhhQ8tGz+KDbbVyA6ET7uAomPfkippSsBX4D9Sfhl8nizo8qDnvxFvdw5OJfl8CniEqFRcHNS0EE6BMQkCfBaIt/mq3QqWr1+9C/yugj1qGobvR7Q7bT5eKhe6Ie3VJd1yAExS9MSIc0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R57WYhlK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TzwKFFr/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R57WYhlK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TzwKFFr/"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654A9cB73234473
	for <kvm@vger.kernel.org>; Thu, 4 Jun 2026 16:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8T3I1JSi6bPzTWMglkCJmeKM
	pAKkFgJd3nlCAFBxxjI=; b=R57WYhlKJl3K8bFUdl58ZqjkhTtCV46ZT5QO6j0A
	Kddjcmp6YEGcd8WIruVAt0ZMvC+hOWwkGsLEYz7Yb32W3tRSjhQMXgZc94DdG/6u
	YU3sFnnQtRqKdtqQjus9VHxy5Ee7e1r+jsPLX0pbfzq5ydcL/dpmaF0z9cdGphrJ
	/WYa44pwTb1IiQegKIZ9sqhZSST8w2Iiz/tW0BAkpcmqQsPp61iSH/YrPG4o0pxF
	PHXOOSiUGCCBEuyEbblKvDPdgi5d/iDCJwe1OMDiZjxZ7Cg1LrZfd6m3m8FpJylJ
	7poDjZlZipbJF3WIo4ECfDqr2LrUdd2XCKi/I3p96YyXYw==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs4s4qn3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 16:03:33 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-69d85c328c7so797752eaf.3
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 09:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780589013; x=1781193813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8T3I1JSi6bPzTWMglkCJmeKMpAKkFgJd3nlCAFBxxjI=;
        b=TzwKFFr/yAqAzsnz24uUZ2xYa0AKrhpiOmdwSN4zzb3G1FeWtsYG5lyd3Hsb+OUfMJ
         hIXbCczAD1Lns2anFm8HA2kw1NOKbMKhD8k8ZiQtae3PTHslV8T23VKPUMINx7dp7vHz
         xEHjxdssQfhQpGl1tNqO8daUw03uiuF9m7PHOHYH+a6h93cmIFn5fkS7phl/zWgALKnF
         vHxtgXmkFWk/A4wRHU8+ENAWZ998LoaEZbCoLcVsGM/0BLgyAKvtEUZ+dk9ko1Yw7NFF
         WTyZful/xUvQkTRB5/62Brdz2XW8eUpmTYia4q2M/1/FTRkzjcjlkB4HsIFL5caekQM7
         k2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780589013; x=1781193813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8T3I1JSi6bPzTWMglkCJmeKMpAKkFgJd3nlCAFBxxjI=;
        b=EcJPaD138E1rozTzJGXBm+TzwhyKnNeEHPYSuL3WN14nKzmrCSpW/5uSJbRoDAlVaG
         WQaaQG8uIbsVuceGCq/BXGL2beycskEL+gyJVGS9XyrOILTVF0NpybM40LanZPllKVU9
         be9HTLogD/LXYx5gxFQl7ZuD7gyMkzvqnb760UHSGVSkklXKSGGdTHRImv41OZAG5ArX
         X4juA/8NRjpIJxsl7WUHF3Qa+0YwroZ/5Il046/6gmEIQIuDntzTsnZPaaqIjPHW/hKE
         SjpfwvW5mmjatgaTVjD01+WBKy5Q3f9JTfktekrSEeDZvtZkiExmicWRVcfccrpqVmvN
         HFeg==
X-Forwarded-Encrypted: i=1; AFNElJ+5DslqYYdUIJmq4rAVeassrArqjCJM5r0cTvzWwJ5quA+wOhQ4hqHXpm2rmzRSlyO6tJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzVJAofCb3vyc/WZ5e2aP+nJvGE9bX7yMcT44cfkAn/Q415c6M
	DOh6ZTBGXkpCm5JYnek2PmGl86Ye95xZbPJtBulGq+K/5BCXQpu2Mcc7fMZKQWO3aD4h5oncB9c
	zXveECuP33Qwa9cSZajiv6rE3L86PyGBtgiGnX1Fjhm7wRsS9c/WenEBWwROnSrA=
X-Gm-Gg: Acq92OEXOyT9puyOFkToUemt2X+CENu9GRYwY4LVyrcgfNRTWW5v6VNCrdUU/8UF5QF
	775jenYUaH3BqgAtOrPB+/veyhHWRUuj5JwetksYmoJ/HxoJrk38oDFp0LLBkC5botoBrXyifgm
	7PRlGPVXpcM8vL7mg3gK5CIu9Tzn/fxzDbbBA5w786YEOvOWyWL9YofrSCzHMQpsmhvlOWE2f49
	ZK4LKJecALnJUa2kEzgcn3jnsr8eO6t/wQ2sfe/YPxMBiealNqt4O9eS3DZXbzt/rD3ZKmshCbo
	oIB22cW79DqaCG6pfn4e2QJLOhlXzMURz/2IrsJY8cfbCv7CH5DbwKbmu46iLSAdyl7bOmcIJoc
	EPwnn6D2V2l9b/FI1PCFnXM6NGBjyQCbmZ+Nvox6gRg==
X-Received: by 2002:a05:6820:4b0d:b0:694:6acf:a420 with SMTP id 006d021491bc7-69e47ed36bdmr4713234eaf.15.1780589012794;
        Thu, 04 Jun 2026 09:03:32 -0700 (PDT)
X-Received: by 2002:a05:7301:100c:b0:304:4f23:4466 with SMTP id 5a478bee46e88-3074faa488dmr4046204eec.15.1780589001468;
        Thu, 04 Jun 2026 09:03:21 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db55f60sm6911110eec.6.2026.06.04.09.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 09:03:20 -0700 (PDT)
Date: Thu, 4 Jun 2026 11:03:19 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Guodong Xu <docular.xu@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>,
        Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
        Chen Wang <unicorn_wang@outlook.com>,
        Inochi Amaoto <inochiama@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
        devicetree@vger.kernel.org, spacemit@lists.linux.dev,
        sophgo@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Charles Jenkins <thecharlesjenkins@gmail.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Jesse Taube <jesse@rivosinc.com>, Andy Chiu <andybnac@gmail.com>
Subject: Re: [PATCH v3 00/15] riscv: hwprobe: Expose RVA23U64 base behavior
Message-ID: <dyafwgy6wgahizpld2vfuk56nzhueh727u6vzblmasmw24vb23@uw46cc5sxpb2>
References: <20260603-rva23u64-hwprobe-v2-v3-0-5529a7b28384@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-rva23u64-hwprobe-v2-v3-0-5529a7b28384@gmail.com>
X-Proofpoint-ORIG-GUID: WdZJIf0tX8R4CaPiKp9ITsw_L8qnfXAv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE1NyBTYWx0ZWRfX+Ycb5HEpkDVQ
 +xtjsTZ1uFbOI/Ios73porQI5KeHCwvprxZbWLHKtg2WPKujEbcIcSFsyTBkIJDexC7hEUyu2ut
 UH/OSaG2guaXF7hbM4UxYTDsqNxSmj9yDC4GsOj4637F3V1xHv4p5UCkR+s27vKatkLuT9r3yRH
 De7vcpFL5vACBHSzhFysHqSxMhq/wo+mLSeERtAUv4Is2Y/E/iQeihFdBs+MSNzoyg4HAtEn5nU
 azSswewrjBKyYkFeilpg/POBB/4J7hzSk3I1deHlViyBiexuM5siu5DV0GD4cOhzen7U7UJstUD
 qcWqEmXAPoOo9qIPBvA4uyxgmw9UXBaqxfS4U3jL3fOgpATFcf/BG2q7yo+VclWr3CixbRvjT6G
 scgDn2v2c2W9simGuRGy5nGY/Qju37A9Qd7UsrqYKpzUe8y2GOOSesEnuuU5fxNuAT6iitzRaJ/
 Z13FkRjnEbgU6LI1W3w==
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a21a1d5 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bmEhWVV90QwrJAxICpMA:9 a=CjuIK1q_8ugA:10 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-GUID: WdZJIf0tX8R4CaPiKp9ITsw_L8qnfXAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040157

On Wed, Jun 03, 2026 at 07:11:55AM -0400, Guodong Xu wrote:
> This series builds on Andrew Jones's earlier RFC [1]. It lets
> userspace check for RVA23U64 conformance in one call, instead of
> walking hwprobe + prctl across every mandatory extension.
> 
> The series adds a small framework that resolves profile-class
> bases (IMA and RVA23U64) from the kernel's ISA extension bitmap at
> init time, and surfaces the result through both /proc/cpuinfo and
> hwprobe. Later patches can add RVA23S64, and backward RVA22 / RVA20
> detection, to riscv_set_isa_bases() without changes to the
> surrounding code.
>

Hi Guodong,

The series looks good to me. Thanks a lot for picking up this work!

drew
