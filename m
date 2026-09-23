Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDC653B347
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174702; cv=none; b=s1HNOALj+9gEDkzNBuazlGWqWGu2On7sxH3SCHC8MECI+BCFrKXSQvp0mqXYFsbillPYdBFRQyBl52P7RNQj8H5omsUAHtaP4eqJfRPtCh8KG2pNg9FbcP2vS612kt8l84EuAkqdBpROidEwkhtNynm2QXtnb0E/C0YynHqXg+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174702; c=relaxed/simple;
	bh=fHFWovMJOWv4N9ihuzDdOiS871+ultJ4OPaeZ48He9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpgZ9/KxYkweoO/tZ2Oq4svzGQGdy5U24PUC3BtqJWPeRsuTBqXqLuzCJP+L6rsW8KkVXhrc11QwmMQ2sp0IZB/sG5ozvqU6G6p9auYvxfRm5ZVMysABGItYLY49hYQ5C0e+uuEmE3vNRCBlikhwThwpyQTzAbXvvFacGSqLwds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lOcvg0Ls; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B5Xk9qjF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lOcvg0Ls";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B5Xk9qjF"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBcnXc3161354
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 14:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xgcOxoTBwTC0LF6Ccg2RoIG8nDW44o8mbEkBphCt1MQ=; b=lOcvg0LsZNHlJQcO
	83LWdgPgFbriVuwgIkvY1vjmlk3l0vvKq5h3c+UrBHs4eH8sUgVxSQO6/x7k7sWA
	XP9VHPwASEyTQBgKxgTVA9Qzh/Vpa4KV1F4MZcTE87LSY2YKrDyZxAD8y5rRIfqa
	0kZU1HHHHdP/tG9icKbXa+XeoO4Jnpmc1tO0ArX+MMrLhxHJ3rUnkD1MyDAzuBv5
	9e5urHMujrRvNlDJiuAx6R8rvM2q5XTIGwwp1wVaN23cB7UDJHJsv1g71ZijmXKP
	XizyejcqWjeG+hvuHg6+K8yMo852eB23u3BBgBaJ7+oAj83v3/xibK+Ja8JUaYxN
	NXqUZg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv32qud77-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 14:44:59 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso1574608eec.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 07:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790174699; x=1790779499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xgcOxoTBwTC0LF6Ccg2RoIG8nDW44o8mbEkBphCt1MQ=;
        b=B5Xk9qjFY++kUK3qen3DuSUqeO8CCdBvCN0GWfuL1k27+cTxPI4Fhr2AZ8cIR1A8A/
         bO35OQtbs9rJCcGUlVmhE0SWpRJ3k789hc7zz+WcUIHXW2tipRGtW3QxNimG229te+9a
         8zhyKeHQjjaW6vA4lmk1syHytReOVA1uADDsWpNagUTav8Z5EoFzPoLoqXbQVSmoVkme
         vDWMYmKx4AsopIG4LiC2aurQxeJil5Ass9dHIuGTJWDnGLxSevSG+WLpeEexwGcPuBCG
         c32XFboq+RNpaLJbGL9KWzUt6p27+f/U7aYF1rdh7g9+/94qq+R1NSuk7Ozv0tUmOzKl
         zlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174699; x=1790779499;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xgcOxoTBwTC0LF6Ccg2RoIG8nDW44o8mbEkBphCt1MQ=;
        b=YReTmTkhavHuBei7SVd1Qk14MeqayBSLNbaKbjTwKiOZrFp66AA1uKtKAw54n8weRL
         +OQTEVVbsAbvdhBic91HQmzpfSH3/3Gzd4cNyxVm1+wWQywGCNtpEJY16QpmgGnicirW
         NPETeKgt2CZhHjw7GiXABMq+fAbg8M4u45bsu8xe3h95FqapUNcHG3tQ0c6deVFdrLzj
         5Qds9ZumeZG4nyxzBRbp4696ApVEsnVc/ntEB4zDMZGa4PgIgE9PzPtJncaVe9reO2JP
         vDBWDeSIDIpEovZj+qFrWD9/e+Ypj7/O5bXzwfpCBDStBtoJUxp2haQViYdIDJey9zMJ
         B9Ug==
X-Forwarded-Encrypted: i=1; AKwUvBzEYrLmIT2OnwyS1uCTRuxM7Upf33X5v7NmE3ZeMY7KXD6mQvHAeYp76v3rQwCNL7f1ZTA=@vger.kernel.org
X-Gm-Message-State: AFuF++npLFoLg8tBL8iHXljxcqd0sMJHDZtLOBE6CXYydBseninNGcry
	CwiLrlOfWg6Q9sSftfWvIJfBGeKD0w2fCzy2QD9HgYpMiz23fAwB9CSWf8Iknl+4FWNtcNJmf1o
	lCIEfAKyBOP+fx0HnextmlCuVfwStep/RKMmvj8fh0X6bxJdo4IJR1R4=
X-Gm-Gg: AYBFou1hLdLzaza3Xvt1XLhdz5HFSF2Dhzr7xlbsHWE2lFLm8NsWmGON7j4C2oKXrzB
	3L9xTYKe/hQjW9Ke/bqVKrlPuRR9MC18IVJI8NVfr60nT0rdsSLuoKH1SQBW+9u7Ilb1RVYcf0J
	EqtEsHA8bgCU71i+tNoz/NrsI6OTsijJaZPzXk9BATN/HgZCTfL3YtY73ktYkKK7uBVlrLfTX/E
	NJb9mrZo7ovWJT9pehZwF5HjstgLxjGfT8yRTzvO0DJxf7bV9jw0c6EL99AfemB4ABZohJji5al
	0gfR62U35hYlHOBfNc0FgZqHPmOJe8eTv83Wrx/lKUuYz7GIfmpPF/z51LbQsjlHpt/3CO07NR9
	Xo+0i1C9rrEMBQMLkPBZtCoDvQk/zCX7brztp8+T5PSeQQ39nrDWXYsuzdnLwY6BTKFWY4uboYf
	LOTg==
X-Received: by 2002:a05:693c:42d9:b0:33b:e75b:cc42 with SMTP id 5a478bee46e88-33e8d7d8b7bmr2233674eec.19.1790174698762;
        Wed, 23 Sep 2026 07:44:58 -0700 (PDT)
X-Received: by 2002:a05:693c:42d9:b0:33b:e75b:cc42 with SMTP id 5a478bee46e88-33e8d7d8b7bmr2233634eec.19.1790174698038;
        Wed, 23 Sep 2026 07:44:58 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7d003sm6415514eec.9.2026.09.23.07.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 07:44:57 -0700 (PDT)
Message-ID: <fb2fbd8a-f362-49a9-836f-7ad271454578@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 07:44:54 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 000/114] single-binary: link multi-targets into
 qemu-system
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
        Chao Liu <chao.liu@processmission.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Fabiano Rosas <farosas@suse.de>,
        Xianglai Li <lixianglai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Max Filippov <jcmvbkbc@gmail.com>, qemu-ppc@nongnu.org,
        Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Bibo Mao <maobibo@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>,
        Laurent Vivier <laurent@vivier.eu>,
        David Hildenbrand <david@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
        kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Stafford Horne <shorne@gmail.com>,
        =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
        Song Gao <17746591750@163.com>, qemu-arm@nongnu.org,
        qemu-s390x@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SJnXx+vH c=1 sm=1 tr=0 ts=6ab3e5ec cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=GaQpPoNlAAAA:8 a=pGLkceISAAAA:8 a=p0WdMEafAAAA:8 a=GSDOiBCUhkFbxXud944A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-GUID: FtQQzZxUH313MPrsqMJ4Fmen_QxEG-Zn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfXyjR6ZLBff32h
 ivg+k3CCEHKdSQrYazuYh/6xSRDu0WP6FRXcPjlGM5YW9mJGLydVW2DNHT0EigmOtDvd+J76+Xc
 qN9CtUgw/PiojvrAGuA++HRmIPGJeKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX9f1tTCWo8N0U
 MIgsx8vQnUIGfSa3D4dGNQ7Oea9LunXrPSaWY90kURMN7ShPsdR+7zZz+M4YuMblS5TIexi4blg
 DCfDp7inJBdADn5JDILCA+ER7TwbwkeOahlP0nwVYBhyX1TAfnAKnWg9ycMJewAJ8xZ20nMoaYV
 TbS5EU3ppQ/R+0Bzj5Cx+DSy97hwxtXQsBpJK6mWP6fPklVHRggFShx1BOEA3ysBUM5u1mx5vp2
 11cKicHYKGbxz3bHT9pdhI+y6Vq0xqJ6jzccaLTHSgUVqPvyfSa64onYMzuPzr4RHSr1ENEMrSQ
 Vf201OxYilhdv3HyHaPJsCwfrRSNf0dhgimq25mjr1FSv70JkuXPzOE5icyTuliyYESyHX4Hk7w
 S7ymg9Hfwyde40cGK2wWw8h7ULzZ2ePgfAhP2TBes3qptWbDMmkOQl1koWmGQzozDbaa3ucqS1R
 3Q5pTtEEN4ZPimZdH9w==
X-Proofpoint-ORIG-GUID: FtQQzZxUH313MPrsqMJ4Fmen_QxEG-Zn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230058

Hi Yonggang,

On 9/23/2026 6:14 AM, Yonggang Luo wrote:
> This series produces one qemu-system binary that can run ARM (32 and
> 64), RISC-V (32 and 64), and MicroBlaze.
> Upstream filters machines with TypeInfo.is_available. This series
> passes a TargetInfo into that callback, uniquifies QOM names that
> collide in one process, and compiles those targets once so they can
> share qemu-system.
> 
> A combined link cannot keep C symbols or QOM type names that were
> unique only because each qemu-system-$arch was a separate binary.
> These patches remove those collisions:
> 
> - TYPE_ACCEL_CPU is the fixed abstract type accel-cpu, registered
>   once next to TYPE_ACCEL. Leaf names still encode the CPU type so
>   accel_init_cpu_interfaces() can look up "<accel>-" plus
>   target_cpu_type() (tcg-accel-arm-cpu).
> - virt QOM names are prefixed: arm-virt, riscv-virt, and the same
>   for or1k, hexagon, loongarch, m68k, and xtensa. Boards keep
>   -machine virt via machine_class_set_name(). query-machines returns
>   the QOM type in MachineInfo typename.
> - virt ACPI helpers and RISC-V TCG crc32/crc32c/wfi helpers get an
>   arch prefix so the combined link does not need meson -D name
>   mangling. LoongArch virt_acpi_setup is renamed in the same pass.
> 
> Target selection has to work with more than one TargetInfo:
> 
> - The combined binary takes arch:name on -M/-machine and in a
>   [machine] type (aarch64:virt). arch: binds the target. microblaze:
>   runs that target's default machine. arm, aarch64, riscv32, and
>   riscv64 have no default. No -M leaves target none and the empty
>   none machine. qemu-system-$arch keeps the historic -M name.
>   -M help lists every target; arch:help lists one. query-targets
>   lists each linked target, including none.
> - TargetInfo is a constructor list. target_info_select() picks the
>   entry, including SYS_EMU_TARGET_NONE. is_available takes const
>   TargetInfo *. While the target is still none, QOM skips the
>   unavailable filter so grouped -M help can list every machine.
> - query-cpu-definitions, dump notes, and Angel semihosting sit on
>   TargetCpuOps indexed by target_arch(). Registration uses a
>   QEMU_ARCH_* bitmask so one object can fill ARM and AARCH64. The
>   table is target-ops.h / target-ops.c.
> 
> qemu-system-$TARGET is still built, including the Windows *w twin.
> qemu-system is extra. It links each target whose arch sources are
> only target-info-def.c: arm, aarch64, riscv32, riscv64, and
> microblaze. Do not add qemu-systemw for that binary. A GUI
> twin would keep QEMU exporting data from the .exe into DLLs, and
> those data exports cannot be delay-loaded (qdev_prop_array and
> other qdev_prop_*). That would block enabling modules globally on
> Windows.
> 
> Examples:
> 
>   qemu-system -M aarch64:virt ...
>   qemu-system -M microblaze:petalogix-s3adsp1800 ...
>   qemu-system-riscv64 -M virt ...
> 
> A bare machine name on qemu-system needs an arch: prefix. An unknown
> target fails with "target '...' is not available".
> 
> Prerequisites:
>   [PATCH v2 0/9] machine: uniquify virt QOM names
>   https://patchew.org/QEMU/20260922215533.641-1-luoyonggang@gmail.com/
>   [PATCH 00/21] accel/tcg: share raise_excp across TCG targets
>   https://patchew.org/QEMU/20260918004225.827-1-luoyonggang@gmail.com/
>   [PATCH v5 00/11] single-binary: Compile hw/riscv once
>   https://patchew.org/QEMU/20260918-hw-riscv-cpu-int-v5-0-f98c5a244636@rev.ng/
> 
> v1: https://patchew.org/QEMU/20260823150731.896-1-luoyonggang@gmail.com/
> v2: https://patchew.org/QEMU/20260826184229.1145-1-luoyonggang@gmail.com/
> branch: https://gitlab.com/lygstate-qemu/qemu/-/tree/single-binary-arm-riscv?ref_type=heads
> x86_64 and i386: https://gitlab.com/lygstate-qemu/qemu/-/tree/combined-binary-multi-targets?ref_type=heads
>
thanks to pursue this effort.
It seems like your mail provider blocked the send after 40 patches. It
can either be:
- usually I have to reenter my password (after a timeout around 3 to 4
min) to keep on sending patches. A better way is to setup your password
in git config.
- Your reached your daily quota because there are two many cc on each
patch. Reduce cc list.

Also, I would recommend you start easy, with only two base arch as
targets (like aarch64 + riscv64). This makes the series much nicer to
review and iterate. Then you can do one series per extra target.
It takes time, but that's the only sane way to move forward.

Also, I would invite you to get the command line details reviewed first,
as it was the biggest point of discussion last time I tried this. Once
you reach a consensus, it will be trivial to add new targets in.
I'll follow any choice the community will make for this.

Regards,
Pierrick
