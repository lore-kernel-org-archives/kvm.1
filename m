Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678A6409DE0
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079415; cv=none; b=MAwCmWitrG34dfZtMaQ5JxvZmwU0Gd6orxeVfjn9EqcWGTcN9aUPlkVNgFq0nuaWZ2ggdwJb0kR6zNlBLERTeU3iAhWNo6MaboVCGEsBql7RweIblbz0LkyD6BIzbdZL7Hn4DdPFTUJVasq60X/5VTZZ/jseQJ5WesfHlVa8EwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079415; c=relaxed/simple;
	bh=c1pqme5xbeuDz4oBzaCov/G6FoPYPioglS2VAgPd2bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lf/cWBtPysL522s4dVVaviDt8TzjtWaekBSLaUcC36knPa4H1qzDPt5tafR0g4tZr0pOm/bmAqvZf12bV8AOJHzUNOI7FaojGYtz4HdT+McQPmUPHjVf3xeONLwM80ldf5JHsYcIQVVHJb2Z4Um9b3e08Vz8SXhiuATHnZqIdEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GsjShRk7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ioYefSma; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GsjShRk7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ioYefSma"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TI2Q943409786
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WVa12isQ6aEb9mJ/d1cwSJ+qKvKQJLYVeyR/ltxHKsM=; b=GsjShRk7u7YK67Ct
	ZkrYRssXZvfIlyBagnRiTa2izPqbZADPM8JyAtjJS9k4TkLkO+D7l8tvDM3aTp3L
	tZTa765Erlf0W6GNRA+7CVO9hB6qNOL4FZ/ShMyavbXcdxJxCDnRvlcLjMrsWI28
	Tz6bPLVucwsv4h2zF/PH5udFCiiCrEaAONGsZ9prp1HvbQff0CDVARQ+j3DBULaw
	AZDc5yfz85JwXD93xB9G3dkhtxpHKw6zcTj8tbnCjZP60zZEmVpbhuiCS87lH+3g
	oMegk60w0qPZCa/6ZpD06YjcdI50HDcZDrdcAmqCn9qO2Ek8HVSuVAkIsnG0b5lh
	o9Z5Ow==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eevug5h93-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:30:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-304df51ff3eso1946519eec.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780079413; x=1780684213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WVa12isQ6aEb9mJ/d1cwSJ+qKvKQJLYVeyR/ltxHKsM=;
        b=ioYefSma4U7ZFL1lVXW5Ilgyl8AQE7eImrgPaIIBaHEgG3C8F8M+AhL6OMQPotkOE+
         G+E8ThUu6sCM9QWEI7lrHg7LegHU/VJC8S1rFUqSNZ8vu/YH+/Xp5+OBTKEmFwQrUAiP
         JOCFp+i/bR7K7buIVIogNSaePstxnxLvajWUnUa69Njx6NJiAGP5VOpG5FfGYTTgsOz9
         bCgNs+PCjoO8FLjG3mPpEWKNlc06vLzhiaOdrRzTt1iHFJnL4FzTr94Oudgvd2rBAwDl
         wH45ZEk4OzZRIPIoQnIhaixFGn9oSQWHWSfuYZmnUXofB45RgtqAmVWEtdoUNk2LXjkr
         PGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079413; x=1780684213;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVa12isQ6aEb9mJ/d1cwSJ+qKvKQJLYVeyR/ltxHKsM=;
        b=J+Slr/4vkXE1PbBZc+DDJX/7630+CmicMoRWmBYAWD5EbEUC1MAARnNiWAX6XhFU2G
         u4t7bHoD8eK6/TkIFtgvqApSJjzQ9Rj3W7sH005PDy5W214HmC6D96F5IqA1a21Ns6wp
         ysdS6RvSegFYu6qHiMta9XN34O7jPh5yI0lH86hgrXYKDRHygBetf90zmGJPOYrlkSKY
         l6/illeH9O6hOGUZxZtHAdlHror/1ZTSXKUgU2eBLT30UWxie4t3nsL3Q0w/gbOv38zV
         aomGZ1nNb7qwmiVxX0x0RDYj07lYCftOUFu1HxLItRy1CLFLt/88yy7S8U4lcRh+mDbi
         02lg==
X-Forwarded-Encrypted: i=1; AFNElJ/3xm3DbgzJ8WOBV7ITZJf/TIz2r83xeYBL0t/VThJa83BtIWFDwYmThq4IuoDdMvIydUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0GxExoEtutQIwauu/RzJw6g0SVMCVCNinkMktJ4P6KFpz+uL
	Uep4gqLg5YTDx/9falp9xgZnV1MbN1C3plnAOSrAMMczaJ5aVvK2gUxEBVs3fic7xRN53AxuGzu
	GKZrws+bSaVePJ+KoRMJXPQC/ntegMuyUlfa0kpFo1FUzMJpt6YA5pOY=
X-Gm-Gg: Acq92OGAOmtxB6y3/40odyHaqy7ML8TBWAEC/7ohh5BQ1oXqdBl+IaBaYwZ50Jfo5XR
	AJIhz5+My0Ie251eYpA0ifu3z1vhFVGnLB02qjzV/VMY60mCTRPCGgUG5p1dWfkUZyXTF5WR2ft
	Moyu+fTgv2BTAwIYg9hBrKclxyeOrlHUhhHJYHkIWjY/oR7Adab8lnMe/jDGT2sVL7p8ic2FjSg
	MLUXxA6ZpYwJQyUYMpfOmP4lKIcmroFIbZmG2c4mFDEZGCPZDJFNsfcVOmxca0xtMrGemqNwW+9
	pyq2HNfhPREPsaE3lJeJnJGC+Sra08fQNTAJEf0L45USH8KRGBPTEqnnH3CP/6JVjBPO4mWeLgk
	JEBedGGPOUobSXMjcvHXac/ZyO3CLW76YlYXI5R2xhL4EgnWpdlYaDnuypq8GigmbDhkcYsj1ZK
	JwptK5Ch4Ap0QHUAudL4qx4Ls0
X-Received: by 2002:a05:7301:290b:b0:2ed:e12:3769 with SMTP id 5a478bee46e88-304fa6b6007mr531239eec.31.1780079412903;
        Fri, 29 May 2026 11:30:12 -0700 (PDT)
X-Received: by 2002:a05:7301:290b:b0:2ed:e12:3769 with SMTP id 5a478bee46e88-304fa6b6007mr531212eec.31.1780079412222;
        Fri, 29 May 2026 11:30:12 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53f002sm2113454eec.18.2026.05.29.11.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:30:11 -0700 (PDT)
Message-ID: <5a8cbc9c-1206-4140-ae91-235996f8374c@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:30:09 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] accel: Remove AccelCPUClass::cpu_class_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
        Pedro Barbuda <pbarbuda@microsoft.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Glenn Miles <milesg@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
        Peter Maydell <peter.maydell@linaro.org>,
        Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
        qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Phil Dennis-Jordan <phil@philjordan.eu>,
        Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
        Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
        kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
        Chinmay Rath <rathc@linux.ibm.com>,
        Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260529142434.87880-1-philmd@linaro.org>
 <20260529142434.87880-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NCBTYWx0ZWRfX88Q9/VUB5dxz
 f/S7gzbbO3YNSLJW+YeCSpyfxVKspxxZFbxhGrwsqBFGARDppZxIXMeg6V+CCtfsPt85kheWyOL
 CDyuvkSGcU+ypESzAH6Y7WGzG0Qs36iUU+D968+atg9zE8k7+N5IbXOIpQemtc2NN19WmWDMd1y
 36MqwHkWbFLHpQcZyUyfkggf0VmYKxqr5qRIt+VxxZEBtufrYH/5mIbQuZL7Na6xJ6lfuEGY41s
 MFuZVgmCBIMqXAWCDCW5ozklfI+m//hEr8sO9VCSXZT025fPpTl3yWMK43kIX9h2OB5e2bxU6eT
 v8PR7btCvDu91jqJ5v+Dud7yNUpoNU1sICcAJ7kdiOvIAzbZh6s5Dpa5gfeayjLv/Esw2CvtOd7
 7GVKhWZuEuIRgWumkUwThvloN+5fh5WEkUzg7aWW5H27wVU1gBi2ZBSOi4zBq7LzGn4c5i9GDll
 Up4TgCsICl1POokgvEQ==
X-Authority-Analysis: v=2.4 cv=SNBykuvH c=1 sm=1 tr=0 ts=6a19db35 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=M4ieH9tDHB7thNhbP8AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: pSbcpaUZuSIK4gOGujlhlf2KxAh-Vazm
X-Proofpoint-GUID: pSbcpaUZuSIK4gOGujlhlf2KxAh-Vazm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290184

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> Last implementation were removed in commits f50d0f335a6 and
> a522b04bb9c ("Remove AccelCPUClass::cpu_class_init need").
> Remove as dead code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/accel/accel-cpu.h |  1 -
>  accel/accel-common.c      | 33 ---------------------------------
>  2 files changed, 34 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
