Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A71409DE0
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079582; cv=none; b=Hcsww7YqwhPYwSOlVYIuC7z7TnkDQzNkvbCzs1hddIkhhZ7r0j534+JuGPIaXOxdOZj+ESHIKU4L0qfH5e2DXx9id7mngsdU5FSbhochlqJj4ZLxKwsfOI37Wl38cpoGutYjMEmgm/0ewkdbFz5QTBTzv9OOGegqSke6ip4f9dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079582; c=relaxed/simple;
	bh=ssU/CMwvlyKUg0mUiEEW5EzfHcWh+IawRyO5sqIsuug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MU6LdAUS1bSYoZwYVKsfI0VO+Q49vFEoVYvy1YXSNKyLkk2ch3OdWxMmIXRjqdfn15PRfbpvhmVRsTgZa6e7sbYXwjrANq4DB2XneXBT6FmWwmRAaL/9jHHsSFItqnXo6gvVlsIopOax/8dXrTF8doXLu0k4GmGsNZlkNDW61Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X5Gjv0Oz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H2zRninP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X5Gjv0Oz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H2zRninP"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TIQUgE876436
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nzDfJflnY7niPY39DVPah9WcdVeoxqqcSGibMMC2R2U=; b=X5Gjv0OzIlKCRCuz
	o74u+xyPw43HCkwUyn0d30iUBIBuDBPSXaBy06oCKcmyW7BtE7UuGV4AXCF2k78Q
	hvdOkz8VQjixXU/zEnTOsL/UlGN+OptvUGctRSfN4u702Br1C5X/d8ODnt9lotGl
	LcQZrrZUiQ2McTF+OQvKch0OujbczCUyKYpbB4PZZqo67FzQAHEIAY/kHaOUmIx7
	X33N4hgMsOge7NwrA6T9RgdcVsV8Mpnssa+OWrKk1/cylIQ1aoD//vVYC9QlaGfa
	qvcotdZWvLz2jJlLJ9SGQf7aeDT1opLXrelFRl4bx0MhsmBk6ocZA8p7LmVbkjYn
	+2eNUg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efg3401qq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:32:59 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12dece274b1so18811559c88.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780079578; x=1780684378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nzDfJflnY7niPY39DVPah9WcdVeoxqqcSGibMMC2R2U=;
        b=H2zRninPr3YLdjujO3zVPUcluxodI02GxdyvwmWYnhv8ZRl6Jr6XPqb5OaEEskbbB2
         a+VdkEgnbVUTRJGh1L8YAG5bxyv6MyWIm4b2VRC76Kwu5eP8ZST92Tn13nV+NhofUBAA
         svhQhImjEb0qav3Gf6tsCy91CGUTTfna6+LOINvMBMc9UTA47AHPDbm8ppCQRyzEQYis
         JO5F+cocgys/iLMEJVnu/CRdrJOZLmEioUpe84iio6fBCNcNHXUehKJEOZgfRLEvP7V/
         hWAe2uo02LMTchPX0Hv+8UvtvTB+CT2FfPOoQoWHq8VMiY42VCyHB4kmEBPpcx7dfnTx
         YSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079578; x=1780684378;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzDfJflnY7niPY39DVPah9WcdVeoxqqcSGibMMC2R2U=;
        b=Vz4ebM0UjCYZlvmAaC6iJTSuFeBYjgUQib0dljMN4Veu6rSk8+XFtDKys5rdx9qxd/
         DXcgNvF3X2UU8J84nk5xmO+28s55AGfuNEtOuUwmeGo/qDDvYtC55Ic8cEelRHxAk3Z4
         VnjTGU5PbnC3QKA1DBMLuNQXiq7B+bqSc71gaP9kz0fgJ2ODaVdFp0bcEw4XbcCW4gHA
         0D9YtI6FkIBLtw1AdwMa1bQ06cuekVbF60YKhErlCav13VIuDOsnwuiCU82KgD9aOPP3
         UkJcynYQmC4vzv0Y0dwdfqkrM3Kxr8akkpyqAl0W5+san2wPeqIK1vq68SVVjds6yNAd
         q36A==
X-Forwarded-Encrypted: i=1; AFNElJ/wlN8U0dENvI90f0rEJPyu+Urb40E9SX0Nt6pf2CmDhhKaWbcZNuusIaBgPaZ+KF2Ysk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVqj/a+Inw8fNswAjwPwLe/DX8eWjkmdSD9EucgNKQzN/DTauj
	I0dNXWsMQCDhsp7+U9S1h3Y+VhXGpruwU/q4PdZbzp5eV6rgALpndmCZiTKWjstHX6/GnkYX+Gr
	Xep4J7LxOOYKgcdDv5ZoZGTILxaYYZm6elsKP0YdzWT0QBgjARYO7Cdc=
X-Gm-Gg: Acq92OG/PAFN7C26l08fh6bBMMekXf2e27eM/+FbfTTO0sk24mtVk3wI47BFTj8nruT
	elp491N5avEU44WK8NTWuz64dEXQaYItMKSF0+tmo7RCPEUFxBJRyy76J8ifbdSDk0i1MAD31Jn
	kFtk/BJvlqQ7BsEyqObo3166xv4EiSTdzMB+dCId4t59UfUQ0l75WUSXJlvW1rYSGzfDkqjKjdZ
	g/ZXSuWNf27ZVOcdX150dRU1AOfVVzHjnIFM1jwpHv4RyP0DuZh2aLW5vuKy96OBjr/rlLWCx87
	hgq4g5dVt1eAA4KuHYFiqmbCCKnE3cb34qfWMBCNPxDYcOmp/YKSIHCVwLthA5/jhzRXQFiJFDw
	g6iqq+wki5AOUkHae0k1w22xQ4p15Kq+DQOG1X4NuYjZERTOQwOFYXK4A/GiSyn1gho8tOu3zuu
	mijpgKiXKTEVZpYqgSvTXQnvAY
X-Received: by 2002:a05:7022:b89:b0:12b:f8d6:d4bc with SMTP id a92af1059eb24-137d429c8cemr372085c88.34.1780079578398;
        Fri, 29 May 2026 11:32:58 -0700 (PDT)
X-Received: by 2002:a05:7022:b89:b0:12b:f8d6:d4bc with SMTP id a92af1059eb24-137d429c8cemr372048c88.34.1780079577805;
        Fri, 29 May 2026 11:32:57 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b36aef95sm1649548c88.4.2026.05.29.11.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 11:32:57 -0700 (PDT)
Message-ID: <179357ae-8d50-49e5-abc5-8abf670be847@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:32:55 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] accel/kvm: Remove need for
 AccelCPUClass::cpu_target_realize
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
 <20260529142434.87880-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VRN_400Y_rwE3n56EnGuHjiWNlhzUUW4
X-Authority-Analysis: v=2.4 cv=EOI2FVZC c=1 sm=1 tr=0 ts=6a19dbdb cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=tWnGTKlWpr7XSlU29EEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: VRN_400Y_rwE3n56EnGuHjiWNlhzUUW4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NSBTYWx0ZWRfX61GYxDnWosIc
 g61MDPMhmvf3sVAFkzJrEij0J9CuLzDzGzJBIh0O8qiYo7rNSdYwjrVKYtybKyOlAl18m4Ix8ql
 MFh/8jePZ5dAkpQqBjErl2k/Cp/7rkXBqAdJsURXiDfjcEXfFBMcIVnYFY4lBWd+wq1ppJQQ4ps
 hkqAPXECf2JHfJuFaANa4BwJS+ekOuyTMTzvBZe2PieM5BTpfN6Fdd7gi0C1nceRy3xOi66g04w
 y9TsaglwplC2pQ2XxYZOZWKPERx/HuKxLmd/UNEhrGjE77PVo1Ls7xHHSXeE2uRLEOl1EIiTZL/
 rSRKsgDCBaww1UC5wWnpggCBgjFELW/y99JcjYEnKBcCPhBcs+ATcFgjVoCrDebUI42grQk07Qu
 d4AapnX6viZQD5DoLlScyj3LKR1jpR3/CszFdXApI8YK8mzuXZdM43+OlBMSfjL51947wUsyUqp
 vDWp7ZGi6y41i24UHIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290185

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> accel_cpu_common_realize() first calls accel_cpu->cpu_target_realize
> then ops->cpu_realize.
> 
> Rather than having one handler for each host architecture, use a
> single host-specific method (prefixed with kvm_arch_* like other
> similar KVM methods). Register it once as AccelOpsClass
> cpu_target_realize handler.
> 
> PPC's ACCEL_CPU_NAME("kvm") TypeInfo is  now empty, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/system/kvm.h       |  2 ++
>  accel/kvm/kvm-accel-ops.c  |  1 +
>  target/i386/kvm/kvm-cpu.c  |  3 +--
>  target/ppc/kvm.c           | 23 +----------------------
>  target/riscv/kvm/kvm-cpu.c | 10 +---------
>  5 files changed, 6 insertions(+), 33 deletions(-)
> 
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 5fa33eddda3..fd7175ea9f5 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -364,6 +364,8 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
>  int kvm_arch_init_vcpu(CPUState *cpu);
>  int kvm_arch_destroy_vcpu(CPUState *cpu);
>  
> +bool kvm_arch_cpu_realize(CPUState *cpu, Error **errp);
> +
>  #ifdef TARGET_KVM_HAVE_RESET_PARKED_VCPU
>  void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd);
>  #else
> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
> index 6d9140e549f..4294c7a9514 100644
> --- a/accel/kvm/kvm-accel-ops.c
> +++ b/accel/kvm/kvm-accel-ops.c
> @@ -97,6 +97,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
>      AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
>  
>      ops->create_vcpu_thread = kvm_start_vcpu_thread;
> +    ops->cpu_target_realize = kvm_arch_cpu_realize;

cpu_realize

>      ops->cpu_thread_is_idle = kvm_vcpu_thread_is_idle;
>      ops->cpus_are_resettable = kvm_cpus_are_resettable;
>      ops->synchronize_post_reset = kvm_cpu_synchronize_post_reset;
> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index c34d9f15c7e..36634ec8929 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -39,7 +39,7 @@ static void kvm_set_guest_phys_bits(CPUState *cs)
>      }
>  }
>  
> -static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
> +bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
>  {
>      X86CPU *cpu = X86_CPU(cs);
>      X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
> @@ -237,7 +237,6 @@ static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
>  {
>      AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
>  
> -    acc->cpu_target_realize = kvm_cpu_realizefn;
>      acc->cpu_instance_init = kvm_cpu_instance_init;
>  }
>  static const TypeInfo kvm_cpu_accel_type_info = {
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index b94c2997a07..013f5e852e1 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -49,7 +49,6 @@
>  #include "elf.h"
>  #include "system/kvm_int.h"
>  #include "system/kvm.h"
> -#include "accel/accel-cpu-target.h"
>  
>  #include CONFIG_DEVICES
>  
> @@ -2353,7 +2352,7 @@ static void alter_insns(uint64_t *word, uint64_t flags, bool on)
>      }
>  }
>  
> -static bool kvmppc_cpu_realize(CPUState *cs, Error **errp)
> +bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
>  {
>      int ret;
>      const char *vcpu_str = (cs->parent_obj.hotplugged == true) ?
> @@ -2995,23 +2994,3 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
>  void kvm_arch_accel_class_init(ObjectClass *oc)
>  {
>  }
> -
> -static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
> -{
> -    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
> -
> -    acc->cpu_target_realize = kvmppc_cpu_realize;
> -}
> -
> -static const TypeInfo kvm_cpu_accel_type_info = {
> -    .name = ACCEL_CPU_NAME("kvm"),
> -
> -    .parent = TYPE_ACCEL_CPU,
> -    .class_init = kvm_cpu_accel_class_init,
> -    .abstract = true,
> -};
> -static void kvm_cpu_accel_register_types(void)
> -{
> -    type_register_static(&kvm_cpu_accel_type_info);
> -}
> -type_init(kvm_cpu_accel_register_types);
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 17ba38403a3..7c4440d0025 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1990,14 +1990,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
>      kvm_riscv_add_cpu_user_properties(obj);
>  }
>  
> -/*
> - * We'll get here via the following path:
> - *
> - * riscv_cpu_realize()
> - *   -> cpu_exec_realizefn()
> - *      -> kvm_cpu_realize() (via accel_cpu_common_realize())
> - */
> -static bool kvm_cpu_realize(CPUState *cs, Error **errp)
> +bool kvm_arch_cpu_realize(CPUState *cs, Error **errp)
>  {
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      int ret;
> @@ -2120,7 +2113,6 @@ static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
>      AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
>  
>      acc->cpu_instance_init = kvm_cpu_instance_init;
> -    acc->cpu_target_realize = kvm_cpu_realize;
>  }
>  
>  static const TypeInfo kvm_cpu_accel_type_info = {


Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick
