Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7EB3233E8
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202595; cv=none; b=NoxzFbmH/x1rQmr/dKdtaJQtdj6GtkVwqxyYZsz69uIDc5G4YqIs5z2aUOLPQGszLhB8mAn24LymchY9o/FzXKUrqx+WL+qvFgDYtLiZS7FlG7wZdrWbHYvKGSaWvNppdrTYGWDLLxj+83eRx3Qsv4VDH45mSV9cGe4KA8IfIXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202595; c=relaxed/simple;
	bh=IoVyplfXD4VR5y6U+uekOt1s2x8HLH8CVW1h3/1qkBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AwBgH73i87ZOWDGVzVaIY052UgWejWgoMuqR/DuWgHzn9E2+9t3AUxn0/pr0dgS4yAfalWgglDE08MhUQX/kFN5vyV/NDfEQQV/fYmYWZcys7L102UJmMse41LefwtokbLN9RMGak3pyGXGs2J2FUZxrSlsBtcF2P4+MNXWU678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NKO/mig/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NKO/mig/"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JEnsip1594906;
	Tue, 19 May 2026 14:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=itnP5A
	F1cZ1UvGGw4zM43+PT/iwC/X/DLDFttbOsQlU=; b=NKO/mig/xL6oN5B66tpC1F
	F+wf9gWYrgsc1pU1t+ZGBkPclGkQanhYM6VON9GsFgcilK9BytGzeOYKozLjeHGN
	pgcnhOSDzdNI7U7N6t37hbsTgAEYf6UO/X4YgQ9W4FZEXcPZ/5HSu0cHSMotP+5G
	9M10Fsv4W1QwiNzrAYWdaQnY74rSHnU3okAkJp/b74FpQTT3tXikDjbm0EqrTLPi
	kcGbJ9m/77iZHONuiH9A58COV0/NqLUuT2B9dc3QqRchZlYAh6vTB2LNd15oHO7f
	J1H9GB3Irx5RSJxEgPnF6gefegOpX/mZEwCI8wxjd78lZ8GrbvL+kRLCoyixRCMQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8curt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 14:56:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JEs5t6025317;
	Tue, 19 May 2026 14:56:22 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gax0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 14:56:22 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JEuKFO16777852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 14:56:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBA2E5805D;
	Tue, 19 May 2026 14:56:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 994FA58055;
	Tue, 19 May 2026 14:56:16 +0000 (GMT)
Received: from [9.61.246.77] (unknown [9.61.246.77])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 14:56:16 +0000 (GMT)
Message-ID: <8acc0275-ea29-4008-8380-d8eb3de85576@linux.ibm.com>
Date: Tue, 19 May 2026 20:26:14 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Fix GCC 16 const-correctness violations
To: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>, qemu-devel@nongnu.org,
        kvm@vger.kernel.org
References: <20260518172517.12466-1-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260518172517.12466-1-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0NSBTYWx0ZWRfXzsLDmnYHM/7d
 2eYv5bjGJn0tqBXHN9ZX7uhV6FscbdIGJNe/x1MAhuXY+nHhcElwG4LQU3nJY/C1Egha2wCt4Hg
 jKzyPBcd4SLCym/AdRey+dRYoW2WQhZH+cZJzKZvMOrl4XmPxVXTUAwsSqkzHmITOMFmAF8fHeI
 7jSIeeSasXFxsF2MjZTwemmNi2RbsCG8LactRFAsqoGZC2aUeNKQzHsNrb9ZtozVkYq0+bmWbxr
 gWuVg6NSxaTYB7Ehs09aLWuCxwA9YhCpKhd97KgyqtOOhhkaiXq8x6pmHyIpNS669fMx2DQFsLy
 f7dFUtIYUkQRqSSxmiYOc/F5GxcxZFdi4akztq9wHPKo6Wlim5+TOZSzjgrkkGr+qwt9P8QEfMY
 getghArkhLmZgSpOd2WwgR8JwqMqjnZY626aD4T3RqbmZ9zZAsKUSA2nnsJ7LTL3n0Ax24DflYO
 HWXCwlJ/v9crLwAqFhQ==
X-Proofpoint-GUID: pqqxBL4ZpGLEKFCqnoLa6qsDhWv2tpD_
X-Proofpoint-ORIG-GUID: SnglmWk2wc3S6qnM5sFBkl-DoQcykg8Z
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0c7a17 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=M7BuaEJ1ckrLMzOwP28A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190145



On 18/05/26 10:55 PM, Amit Machhiwal wrote:
> GCC 16 has tightened const-correctness checking and now correctly
> rejects attempts to modify or assign const-qualified pointers without
> proper qualification. This series fixes two such violations that cause
> build failures with GCC 16 when using -Werror=discarded-qualifiers.
>
> Both patches follow the same approach: changing local variables to
> const-qualified types and using GLib string functions (g_strdup,
> g_strndup, g_strstr_len, g_getenv) that work correctly with const
> strings, eliminating the need for in-place modifications.
>
> Changes in v3:
> - Harsh: g_strndup will abort the program in case of OOM eventually making it a
>    dead code. Additionally, typecase (suffix - cname). Also, unlikely() is not
>    needed.
>      - Remove error handling (GLib functions abort on allocation failure)
>      - Remove unlikely() macro (provides no benefit in initialization code)
>      - Typecast (suffix - cname)
> - Update the commit messages accordingly
> - v2: https://lore.kernel.org/all/20260511131018.102168-1-vaibhav@linux.ibm.com/
>
> Changes in v2:
> - Avoid pointer aliasing
> - Handle memory allocation failure error
> - v1: https://lore.kernel.org/all/20260504134344.38958-1-amachhiw@linux.ibm.com
>
> Tested on:
> - GCC 16.1.1 (no warnings with -Werror=discarded-qualifiers)
> - GCC 15.2.1 (backward compatible)
>
> Amit Machhiwal (2):
>    target/ppc/kvm: Fix const violation when trimming CPU alias suffix
>    tests/qtest/libqtest: Fix const violation in qtest_verbose()
>
>   target/ppc/kvm.c       | 11 +++++------
>   tests/qtest/libqtest.c |  9 ++++-----
>   2 files changed, 9 insertions(+), 11 deletions(-)
>
>
> base-commit: ac6721b88df944ade0048822b2b74210f543d656

Hi Amit,

I have tested this patch and it has fixed the qemu build failure. Here 
is my analysis:

[root@localhost build]# gcc --version
gcc (GCC) 16.1.1 20260501 (Red Hat 16.1.1-1)


Before applying the patch, when I tried to build qemu it failed:


[1431/2891] Compiling C object tests/qtest/libqos/libqos.a.p/.._libqtest.c.o
FAILED: [code=1] tests/qtest/libqos/libqos.a.p/.._libqtest.c.o
cc -m64 -mlittle-endian -Itests/qtest/libqos/libqos.a.p 
-Itests/qtest/libqos -I../tests/qtest/libqos -I. -Iqapi -Itrace -Iui 
-Iui/shader -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include 
-I/usr/include/sysprof-6 -fdiagnostics-color=auto -Wall -Winvalid-pch 
-Werror -std=gnu11 -O2 -g -fno-link-libatomic -D_GNU_SOURCE 
-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing 
-fno-common -fwrapv -ftrivial-auto-var-init=zero 
-fzero-init-padding-bits=all -fzero-call-used-regs=used-gpr 
-fstack-protector-strong -Wempty-body -Wendif-labels 
-Wexpansion-to-defined -Wformat-overflow=2 -Wformat-security 
-Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=2 -Winit-self 
-Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs 
-Wold-style-declaration -Wold-style-definition -Wredundant-decls 
-Wshadow=local -Wstrict-prototypes -Wtype-limits -Wundef -Wvla 
-Wwrite-strings -Wno-missing-include-dirs -Wno-psabi 
-Wno-shift-negative-value -isystem /root/qemu/linux-headers -isystem 
linux-headers -iquote . -iquote /root/qemu -iquote /root/qemu/include 
-iquote /root/qemu/host/include/ppc64 -iquote 
/root/qemu/host/include/generic -iquote /root/qemu/tcg/ppc64 -pthread 
-fPIE -MD -MQ tests/qtest/libqos/libqos.a.p/.._libqtest.c.o -MF 
tests/qtest/libqos/libqos.a.p/.._libqtest.c.o.d -o 
tests/qtest/libqos/libqos.a.p/.._libqtest.c.o -c ../tests/qtest/libqtest.c
../tests/qtest/libqtest.c: In function ‘qtest_verbose’:
../tests/qtest/libqtest.c:2175:15: error: assignment discards ‘const’ 
qualifier from pointer target type [-Werror=discarded-qualifiers]
  2175 |         found = strstr(log, domain);
       |               ^
cc1: all warnings being treated as errors
ninja: build stopped: subcommand failed.
make: *** [Makefile:170: run-ninja] Error 1



After applying the patch, building qemu worked perfectly fine.

Please feel free to add:

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>

Thank you,
Anushree Mathur

