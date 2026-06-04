Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68063370EB
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586965; cv=none; b=ZCg/jFhRgee2Bo/OL4n5SVlPCEMSESzcwPZxI7ZvulprtgyePKIemBV18hTCATFzkia4d8+zHi5mxR9NtFROYUDWYXQIFcf74JtJOuoQi+B6KrwUuT0QoOjpYe6VhWecSBdXegYcwtzTgW68GNvRhrfY70VeNC0BjUVfSzWFpok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586965; c=relaxed/simple;
	bh=UkMauGVB26yFY7UTIwWOcgIzL97oaXwcfIInVZVnp0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ks+glSKdpb7oerP/lEx7WWDmIsUqZLKJsUrtCUwVqro54p1+/9Jwg/Z76FCbpX8W9ampwTkrsF4J1rTFNUlE9E9LSOYrUH2HMleCjYAhcvYHXxweDnUUJDw+cYHYiPC3CJ7CcEoHWi9s8UNy7I74/745WGvhosncLmVpUaksjl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qlncft6F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ilYChW73; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qlncft6F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ilYChW73"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654Delqj313995
	for <kvm@vger.kernel.org>; Thu, 4 Jun 2026 15:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qzF1JQDHu/K7zEZi00iVkIXGDGc/cwKiYYKzelWhYfQ=; b=Qlncft6Fwh6BKW7n
	ka795Z+gVHHYDdEefWUmmoQD4RgUPeiGhHV8SLohswSyxQA7tUpBQh5QJy+w6cUx
	nthELcj2CqKsQtu8IWnnUGVBvx1B4CcqQbh0/tJI53DobGxPsWEKB0olLTomoQjJ
	dKokvTmQAdHSd8V/mrQrqOhm7qnHT3NPPfKphB5f08Ld+jJ4MMnuk4pGoYKPsYNR
	fBUyH5fUfYvPA9cIOWGy6Lhda0l5bMpg0n4kcqegrR9PrsGt3p4KFs11AYqkLbIx
	DPVLtwnic5BaEo8QCGinJHUSHwKzz5V/qJ+gTP541f0Kvr7AYVrKVIkHTnW2gfBI
	ME5ykQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejy5v36ex-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 15:29:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3075fa5a407so2678197eec.1
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780586962; x=1781191762; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qzF1JQDHu/K7zEZi00iVkIXGDGc/cwKiYYKzelWhYfQ=;
        b=ilYChW73DD4JVlwf36MDUbIxRVgOyS/x4M+pk/YSoF4CFShn3QcVjT7yuhLbqj6elx
         GIgZON3eOgFVYNPwfq2aCssnAKBiG2EOwLz0jGKfLeV5orEzfa1ocBlPQ+WRD4pOuHUZ
         nDjxuNwkoRZ69kgRB8sdCYtLoLC6klk0IohQmhLgNlAHnY0ydj7r1dNnO87kawOJmD0a
         xgoF6yE/KApkQoD+wORsoMHDYbEajBq63BM12BNVCEgrp42f5Fq11xieSh3EB+ImJWPX
         cjEftxioWbf9VS0XKRHPz1tK+KufGQ0AB34pD78LtyEgMXJVNFpi1Z2CvfRvUcg5Dckt
         Fojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780586962; x=1781191762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qzF1JQDHu/K7zEZi00iVkIXGDGc/cwKiYYKzelWhYfQ=;
        b=fEiAidzhqz77o6SA+I4RY4JeioMK9AH8hFUUYciBvjYPngSfZVJGazV79CJhgZqHph
         2VBp2W5yeKbds4cocL/X5ms4Fvr1J/03zWZ2lOHs8jhRm2Kdx9JMd3x72VWIuvHYKq6u
         UDxNzXKvvjpS3aKvWe070wvqVDUrFLCFufs6Q7q2qqYQN6nFR2JWHW7cTUwRbAt+kAfL
         WZuhFuZg5gY37bSm1pPJvz0TrtjCauzidi1GIAsTMbK4NZrRuPVP9x0Jmvg8Q5Be9Mja
         cB4TvgECVBZX/C0rexx8LfQaH6CUWLzHf7hk2GxjxRvTDGXWO1qyHJNQ0iy/AVam6hSH
         PP/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/aCzeuY6C4enzAuYQSdKc55Ga+hiVx516xvN89VVtcgfUvzC/1gPJluvss2+29x6zJfZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjqiob3auHS5GI/Gn81327VMJ0sJBu6IgMwpsd8AOMdTplKuGM
	9NsCjcHJ/ls8ONe+NRrVnwL10NWLwH//oT1HCp+W8573HFeM966e7KcluNG0aAy0qwnXDA9+IGV
	aMIR3jompCDs0G6EtIYRvOIzKG5i0FK1M/txq+3XpABnhggGyto7vStc=
X-Gm-Gg: Acq92OE4yEKOAMZEE+RCTbbQUKQ1nUFDuECzcrWyketrgCpeGQG6p/aKGc+DQ7hBsB+
	LnN9ItHSYzbWMmlI6Vl/Z8mCQ+kZnJ31msiroh9UYe12YhGbKNA+MVpfuxx3MSCwRXTKYmR8fQZ
	pPFM0xnx4rA1zjuG6ayZgI23PxwPenx2hZXo3VmDNhq1vn6t3RIdV3i9YjMss2O8lrj9Sbweqa2
	yi2ib8zr8SIrBU32S6SVIKbYMwuiNdqhpPxuwzbtiNWkbM8+tg7juZdWnjmIpin5I0SfOLHv2Qq
	L0IHMJmr3m3WeFgUBSwyxStd1jGJRRpUG9idqq/66BKGU3BvoaMqrRAS7uGfoW9SlvhijGyXfzH
	CpyxfgQkkt2qjZ4Uu1VYVtthc1pcD5nOLLRjmrVLHRQ==
X-Received: by 2002:a05:7022:693:b0:136:90d9:f204 with SMTP id a92af1059eb24-137f6bb4bd5mr3557182c88.25.1780586961864;
        Thu, 04 Jun 2026 08:29:21 -0700 (PDT)
X-Received: by 2002:a05:7022:693:b0:136:90d9:f204 with SMTP id a92af1059eb24-137f6bb4bd5mr3557156c88.25.1780586961314;
        Thu, 04 Jun 2026 08:29:21 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5539035sm4107408c88.11.2026.06.04.08.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:29:20 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:29:19 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Guodong Xu <guodong@riscstar.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Deepak Gupta <debug@rivosinc.com>, Zong Li <zong.li@sifive.com>,
        Christian Brauner <brauner@kernel.org>,
        Charlie Jenkins <charlie@rivosinc.com>,
        Samuel Holland <samuel.holland@sifive.com>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, Guodong Xu <docularxu@outlook.com>
Subject: Re: [PATCH v2 08/10] riscv: cpufeature: Introduce ISA bases bitmap
 and rva23u64 detection
Message-ID: <ug2cipududshcbv24ruicqpugzinujnamvdcuy6pubkwh67bfp@2fysrplz3nr4>
References: <20260511-rva23u64-hwprobe-v2-v2-0-21c5a544f1dc@riscstar.com>
 <20260511-rva23u64-hwprobe-v2-v2-8-21c5a544f1dc@riscstar.com>
 <5tjmypgyxbhgxfjub5q6ne475uysse6yl473sxisjoammkdvbu@yebejqbiy6e3>
 <CAH1PCMa-5W9PsX8cDLUk6-MkcM53HOz2QtaxCHd+XOr7DgH5+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH1PCMa-5W9PsX8cDLUk6-MkcM53HOz2QtaxCHd+XOr7DgH5+w@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE1MSBTYWx0ZWRfX0NP5StM7nGYi
 Fxm+8swAJMECU6jjo6it/su6PeVEwkIAWSScEP3GXfUa5ogozzC2dk5z5WHydvGoi5YKlDhx/vu
 mhbvzfwPfOd4DnqTpMl3aD625aK7ey16iNNB9PRVZnLjBZ4m84RpB2zYGhZ3XDTU3iOw7TgvGPL
 TFk/OI3ps2jD3Bl7elwIkublP1yXFaJO+TdJUnMWNxp8en+7JZJ0s3MvsqReYFQi/jrYyS7yMRe
 KJEqPi7rD4OakVYEZSR1oMHwV9ToEvn4mDYPtkb4LiRFy5kvP+/zM2a+S3s/6+xWpE99RxDFc4J
 fTsYqyzovVuRCJV3xXVqYTUf7z+Vrm5gnxT7H2F3DhKWOxTFQo5iiPSoh8olbSOZn34HvNAX2ss
 njlSfoWzvz74UkivyGYeGElT7UziQIFDI4SbXEwoDWgLBmpZk60WTCjtEq9t72cE6ZYmEs4BTHx
 r14gva0FdNWTn9FMzHw==
X-Proofpoint-ORIG-GUID: NyNx-hXOLi78pVDQVC8VGJzEiux7ls58
X-Authority-Analysis: v=2.4 cv=afRRWxot c=1 sm=1 tr=0 ts=6a2199d2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=c92rfblmAAAA:8 a=ee_2aqc6AAAA:8 a=VwQbUJbxAAAA:8 a=-RU_IiooM-Ar16elnkoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-GUID: NyNx-hXOLi78pVDQVC8VGJzEiux7ls58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040151

On Sat, May 30, 2026 at 08:42:29AM +0800, Guodong Xu wrote:
> On Thu, May 28, 2026 at 12:35 AM Andrew Jones
> > Sashiko points out a few things about this patch which I think I
> > agree with
> >
> > https://sashiko.dev/#/patchset/20260511-rva23u64-hwprobe-v2-v2-0-21c5a544f1dc%40riscstar.com?part=8
> 
> Quote the following from Sashiko.dev:
> > Should this mask specify the individual subset extensions required by the
> > profile instead of the superset extensions like RISCV_ISA_EXT_B,
> > RISCV_ISA_EXT_C, and RISCV_ISA_EXT_V?
> 
> My preference is to leave the mask on B/C/V (and A) as-is. I'd prefer to
> keep matching on the single-letter, rather than expanding them. Here is why:
> 
> - The RVA23 profile lists A, B, C and V as single-letter mandatory
>   extensions; it doesn't enumerate Zaamo/Zalrsc, Zba/Zbb/Zbs, Zc* or the
>   Zve*/Zvl* subsets in the mandatory set.
> 
> - In current merged code, hwprobe_isa_ext0() is already using
>   riscv_isa_extension_available() signle letter checking for C and V.
> 
> PS:
> B maybe a special one, just in case anybody raise it. As the community
> discussed when I adding it into the bindings, because B comes later than
> its sub-components zba/zbb/zbs, so, when I added B, I cleaned up all
> in-tree dts files which declared zba/zbb/zbs but not B and made them declare
> both.
> 
> Link: https://lore.kernel.org/linux-riscv/20260115-adding-b-dtsi-v2-0-254dd61cf947@riscstar.com/
> [1]
> 
> Also, in the bindings: extensions.yaml, a schema rule is added which requires
> a node listing zba, zbb and zbs to also list b (and the reverse). Moving on,
> new dtsi/dts fils, a node with only the subsets fails dtbs_check.
> 
> One may argue that the schema check doesn't cover ACPI path. But again,
> shouldn't the vendor who publishs RVA23 hardware be conformant to the
> extensions wording in RVA23 v1.0 spec?
> 
> What do you think?
>

I certainly see a case for the kernel staying out of the extension
dependency validation game. I think it makes sense for an ISA string
validation tool to exist for vendors to do sanity checks on their
ISA strings, but that's not the kernel's role. OTOH, whether or not
the kernel wants to try and detect inconsistencies with the ISA
string in order to build confidence in using what it sees there
and publishing what it sees there to usermode, through hwprobe, might
still be worth debating.

Without CPUID / ID_* registers for Linux to be able to check an
authoritative source of truth about what is and isn't supported by
the CPU, riscv Linux has to decide to either blindly trust the
hardware description or do sanity checks / probes in order to
confirm what it sees there. Maybe we can assume that any extension
used by the kernel will trip over itself quickly, alerting vendors
to fix their ISA strings, but I'm not sure we can make that assumption
for usermode extensions that Linux doesn't use, but does expose
through hwprobe. What apps need to run in testing to exercise them?
How long will those apps need to run before they trip over something?

The more I think I about it, the more I think the lack of CPUID / ID_*
registers puts Linux in a tight spot. If Linux trustingly publishes
what firmware tells it to to userspace and userspace blows up, Linux
will have to share some of the blame for having misled it. So, should
Linux validate everything it publishes somehow? Or, should it at least
do relatively cheap sanity checks on everything it publishes in order
to build some confidence?

Thanks,
drew
