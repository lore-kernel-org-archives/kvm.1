Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D2D3C4B83
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837957; cv=none; b=aLWBrvXa2wJsATOtwbyjOuQAXMbsEyiQgFTOVJHfBrlO5ehE1Gfu8qDnM4s+H2IMm2j5Btc3yNn+fLkOploELgzDQi0YDRrxTlDD/gSzZJzlNId125j/cTJQFlTG0eOx7K/+cNaP/Dg/OPmMb00zJlGrVjwB96L8jR38txXyS3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837957; c=relaxed/simple;
	bh=tOylSTeK1/et88nUOdoHMPwJCZzkJ8qTh4JcTBRo7RM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=aVU02Rk8dB+UlDRjyglZJn6cgR9h1WnZ7nDd/7EuMPimzwI3DFFdXZSmfAqy6P5V5Uq5COheF+ssqG3UVxAiq23hwRz4edmKPpjfDvpNGM3aMTvSwdjs730ZqlHnU4eivsPvLb5zCGkRmd0NqI/fAtkcvSzjMHC6Bx6L2nM0k6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WlcIYofd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RMyMowbU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WlcIYofd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RMyMowbU"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEDRJg2199805
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 16:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U3na9UkHS5H0EdRatGfrYFloO7dlcC1NaROMwvFcLHk=; b=WlcIYofd0TKj1RFi
	Zc7FOeuvtbaXqFV9DaLqiXBNIcqumqfqD4GexonA6tW3Huf28vM7ZG8fNFlHXGRM
	/npCa7edFxUWcfiDgU3Ljty3RvtQ/9txAzgk7ERROWi9mjbYBlnHxVi3JiAUbVhA
	xoGOQKy3Dk8AKfdwFb2YON7dwiQ+JIc70Xbh8vkDqqmQKaocD2PCgYZz8NLo5jiy
	BT2lvL9UTToezbIJ/nv11m7nB9c1hS66R+K4j1TVUtnrWAJUa00ZyEIcjEhYSBLi
	xTqPoJNEfotMTYYGR7IkiyyVuZ9ngBZR5YlbhfI4T3zToGCka+FT1sKo5tX6S7bX
	uTJUmw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4fc08peg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 16:45:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e55721a8cso386454485a.1
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782837954; x=1783442754; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3na9UkHS5H0EdRatGfrYFloO7dlcC1NaROMwvFcLHk=;
        b=RMyMowbUMvTCnPGIqQ1P/V0q3RKWcOYQ9O+Pf1tYF0WO8V/fe1WWmw353dyDzzVq/S
         DRDtc+zc1arwu0mkQXxosfMaZRoezJkBfuEVKcPucE8iokM6vDoLMEuo06bRYILfIGpD
         Q4UGWGhQhKg3sdsjd4VcLRiASm4umiIbk0Q6WqbjtuZzP6ESXQJ9dprZzW6EENMYtzIZ
         Tzsw9CDhKR4eevPCI12uQydF5dLoQkVvv0Ob0HUidk15I531HaqutIBhYn5w5aD1YLSI
         VdXgHuExdNWAVC8t0jaywxEBWHW1XdqSkXaG8PFPWqhXkcMh6hQgg/FP8pItJICng682
         prlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782837954; x=1783442754;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U3na9UkHS5H0EdRatGfrYFloO7dlcC1NaROMwvFcLHk=;
        b=pdy7I40nVRM6JeFZ/uc3roCfTARJq4ZwNFDEWICgfduCymzi/kvD8+mS2R5xIiBAqC
         yvesJnNwUdfD2jIyvua5hVIjH2ek0VhZgsDdn9AJDwb0GxD7Nsefu8uA45rlJpE2AQ36
         2rOlSGy5ZVYcYdAeYufjcZx1oME5gTsuwcF7rvVJi2E3QrI+o6JvLhHnp2YpLVy/tcRQ
         wk8BROtV5lEiVtqwBvBBywa0wa+C87LiH/h+MUgsEVTow7T05FCoQ3cTWW9TlnIuML0h
         jmHujD2AJVQUcYK9xhIGr1Nh9lrUts8oNyKRZnpV+PVKtKNRUQ3Nliww+nDqUN2Mx5y8
         Qy6A==
X-Forwarded-Encrypted: i=1; AFNElJ+7/+m+DtMM50S3lcbGYbCArdtd6u0xYOqFhM85qLxk8s7v6ADOd6TQWMGxfTEkLm9u4Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy29eCXfBMn2G8rjVj34vtBeG+ikr0n6/9wDvcDQq/YUXOpNLbv
	v//0dys472nFKunkQ1Eb0giWBPi6yFclcEb3CGAsr1I4pESGnETR1S9nhxsDnFfwHFjg9+AvnXY
	SrCUr6MvWb/2VetcInrhC3tyOUHGBj2enrKriXevvDx7p2wLlXENDwJw=
X-Gm-Gg: AfdE7cl5L/1J0ugJdWeIzfAfWIH09L8ME/bbXXaH4hASW0cQkzuY7T2YuZnxWD0zQ0A
	zZ43JrzmCCfGun1fICmfUTrMWUqt6Ni1l77a28o+9W72KRq/jRMc2zqDPdiAmb+4ByLgMl2gN8t
	mQYLmTZt781LV/rVOSme1u4gqTR98PLViRVhZDpIbHZnhJaLQ6V0qothx7PXE0cEGAxub/qK3IS
	+IODZzNwJheuax27r2vLkTridTSLc/vagKr+Lx1s56XkeDb3jMZr7saNOP2JOaDNfN/kj8YMqQF
	RB+aok3Q7QkhHFDo1DYI4PVWHT4lHvMhOLhUkUzbAi7Gv8T1+UERui4HiG+KY2te7VueRtM9KDs
	Y36MNRIQ6DYByXGpTYuad+RH/IV6fRxn69SKtvoHp/cEblBc=
X-Received: by 2002:a05:620a:2894:b0:92e:5028:dbe8 with SMTP id af79cd13be357-92e626718eemr717535085a.21.1782837954411;
        Tue, 30 Jun 2026 09:45:54 -0700 (PDT)
X-Received: by 2002:a05:620a:2894:b0:92e:5028:dbe8 with SMTP id af79cd13be357-92e626718eemr717529285a.21.1782837953875;
        Tue, 30 Jun 2026 09:45:53 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f0cb41sm153934166b.38.2026.06.30.09.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 09:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 18:45:51 +0200
Message-Id: <DJMJB4B8Q57Y.34SUOKB6MD8IE@oss.qualcomm.com>
Subject: Re: [PATCH v2 01/16] riscv: Introduce instruction table generation
Cc: "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Nam Cao" <namcao@linutronix.de>, "Alexandre Ghiti" <alex@ghiti.fr>,
        "Anup
 Patel" <anup@brainfault.org>,
        "Atish Patra" <atish.patra@linux.dev>,
        "Conor
 Dooley" <conor@kernel.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Andrew
 Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <kvm-riscv@lists.infradead.org>, <linux-kselftest@vger.kernel.org>
To: "Charlie Jenkins" <thecharlesjenkins@gmail.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?=
 <radim.krcmar@oss.qualcomm.com>
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
 <20260621-riscv_insn_table-v2-1-7f0810ee2274@gmail.com>
In-Reply-To: <20260621-riscv_insn_table-v2-1-7f0810ee2274@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE1OCBTYWx0ZWRfXxaiVyJaEr2n0
 vPZVZFNzJFbb9w9h2ra0Zj85SuHi7wT66MsfZNHVrhZknxKpIoGC8mzJrNZ3ko9oxKSwdSrHLZ6
 So099MoQ5aBubPG4j2gv0aW+kzWRvVq/Gny8MK/F99EjdYuzSPNUYQKD5Q15oOwFJGKpc+6cpN2
 XHXlpXHI2kVE8y8KT7/Lw1bN8NcfwyPOUIjVN/5RpKBeikUEFvX1AhulGnIc9VLMMbiY5nGDFR6
 2NgeSzaYMD4HeJyFrAt2WK0FcSyLBeDAC/XQv5QnZausQXzbdfrLYw/eWVc5jGYeHfon6kt1P9B
 eOdpENaEZCNoLaCQWYJwKwFOsknzHP0KSCMZLwIKcKVsY4AA4fWcb79QaeBgZiV6iZLkw3RKcgl
 XuNWsGSTiDFAXgtlyyBhhV8T9xTfSTwjugoND+AIcenT1FU3+lIMe5c0poM+EaOTjGpU6lZU0k+
 GBWmvG/v4QDpjYPAw3w==
X-Proofpoint-GUID: vWn3Zzd3McjOzmT4w1w-AWnx41YY9CzK
X-Proofpoint-ORIG-GUID: vWn3Zzd3McjOzmT4w1w-AWnx41YY9CzK
X-Authority-Analysis: v=2.4 cv=Ivkutr/g c=1 sm=1 tr=0 ts=6a43f2c3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=5Hg8iMh3NijzzsoxLLcA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE1OCBTYWx0ZWRfX5TVhL8wfBb4H
 GOAjlvyaaxns/qIbisStYCqlZ/8DN0q+0/q77CP6BIFGyre+eyj/9VTyqDu6m4xw+509Lz6M7WE
 oTHejKLzd8sVgexCaDtdMykkTMiLHvk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300158

2026-06-21T21:01:19-07:00, Charlie Jenkins via B4 Relay <devnull+thecharles=
jenkins.gmail.com@kernel.org>:
> From: Charlie Jenkins <thecharlesjenkins@gmail.com>
>
> Eliminate the need to hand-write riscv instructions by using a shell
> script to autogenerate a header from an instruction table. This is modele=
d
> after the syscall table infrastructure.
>
> The table is generated externally by riscv-unified-db [1], but is
> in a simple format to make it possible to use other tools or modify
> manually.
>
> [1] https://github.com/riscv-software-src/riscv-unified-db
>
> Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
>
> ---
> diff --git a/arch/riscv/tools/insn.tbl b/arch/riscv/tools/insn.tbl
> @@ -0,0 +1,1392 @@
> +# SPDX-License-Identifier: BSD-3-Clause-Clear
> +#
> +# GENERATED WITH https://github.com/riscv-software-src/riscv-unified-db
> +# "./bin/generate inst-table -o test_table.txt"

I checked out the repo, ran the command, and got a different table:

> +andn common 0100000<25|111<12|0110011<0 xs2=3D24-20 xs1=3D19-15 xd=3D11-=
7
   andn common 0100000<31|111<14|0110011<7 xs2=3D24-20 xs1=3D19-15 xd=3D11-=
7

I assume there were some recent changes in the output format...

I think it would be nice to use their latest format and also note the
UDB commit that was used, so it's easier to reproduce our file.
Hopefully there won't be breaking changes too often. :)

Thanks.

---
Sashiko seems to have noticed a plenty of other issues, so I didn't
review more...
