Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB2346AF1
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295006; cv=pass; b=MYHtdMtK/HlMGGloeAvdiIIv8oWqor+dBniAmYQCvpOQTgIzgm1g+T3OFTthERPeJrl1cBdltq6pvTbcDrJc37BbjPwLe2FUXCORNVgyfH4gWNCzWE+wqVGVRTyqDnJq7aN8+MOj1+vnHI92lUETgt7Ou/pHRbdtP5BwEQxRvCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295006; c=relaxed/simple;
	bh=qRUdF/1ulz0ihnLQNBZ/eNUqEQEYykLz6znRDFporE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z98ZpeNGThVNU/uWkhTInbhU6n4u8lz1CK9mOllOYbEMEY6JeUcxb49ahaPPJGHx2D3kj9g582sZ0i/+KpGKSVVeNNqL9tP5KzPa9lhNlPSUZIyWo2LP9HMINUQw+6ps296iiHxlbaLrzs/si5B6oERppD1LTkBqd6Coap4OCIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=MvrKfyR8; arc=pass smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="MvrKfyR8"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-69de512e923so1786509eaf.1
        for <kvm@vger.kernel.org>; Sun, 31 May 2026 23:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780295004; cv=none;
        d=google.com; s=arc-20240605;
        b=LbqAcPagDKn/VGmSeyppIHhkhCcxmo0LDd6aAiNZVpVysPCVWV9JWzDrYbBJoW1OVw
         /zPWMaGPUr4WPVC54KxnCho7wg2ZE53cZgwT+2s81DFOFw8NVmF8wjlCKjOfRHVRuVM2
         W9rxxyXPb6KcuFt3w1PBsfZPmSN5RLUqeOecCiP/3L1N6erJmSyO5Tcnk99Hhi4uLQ70
         fjVOTrlQMS4yfExbDfnMeKx1pamFjGeg0D5/LK94iNP/f15TU56ZbvIhuFSd4jZtKvPX
         cQH43a2/ZUKbI4q22IGtjWIiLPAO8mDDSRi/YMO6+hrATXOErujFx7eeGrB9hIw0P5+h
         IUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Tz3p3k3U+Y3ZV6RLRiUy+C+O8VoH3a2d1/FWAmkUh0=;
        fh=lJpsyP+mG+mvQ7z3g2I4t0RytQi4TugL66rugGY5b0Y=;
        b=eJOpwRfKaswjoE+soI0QiPqbNi9c6511GQ/oQug+uQ0lnjP/vMqFIbj7qZQWMwS/OU
         dBhPSTvwd0HitmkFkGFAIBMyqetF2XTKV8NiWEcQAXzVElPpUEueHpE57rUG+LpNTcSf
         k8FffN5ag5RtKCeSiaEHp9NNaqtZ8xqJVc6oMPJ0GPj6dyPZLCf0uvWiWrjJ3kaRAuVN
         okF7XsUbrAqb3QESUtlJq7NiA+t73yoc9PJZF9AFV+oJ0uuTGrDFuvNwY0QazIhl6hsY
         CoGUHx2X9a6cbHUZ0o00DW24bGFDXSGS+jdLGoGPeV704rCnFQcpMGqvHtQFRlirISw0
         2ICA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1780295004; x=1780899804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Tz3p3k3U+Y3ZV6RLRiUy+C+O8VoH3a2d1/FWAmkUh0=;
        b=MvrKfyR8j2reXDx0qoHzNO9EN3HO8M2Q4o6iWCbgU82LVDA9Pbvl4Y4qYbaYwApLrj
         sz9jcK6JVlcm8hOodg6UGhNgD5ZVBa8kZd62OHIi33KvBPZeecgrlN90sFRBJVJdwHN9
         1B0IOrzf1+yZDWdK2YVQJgf8ZgeUfuR7TLQSLUXVRspu/Fy3g1ykvsQCSFdTJ53hcH/0
         9R/y86rnmaJc8ACbB49a8vSLobCoH/HG/RZJsTfX7p3fx8Udbr5A61gLG3abJvgqpcQM
         smnrS2xW1sxm4lcI2/WOEf1Z70zynhtywhAgdRTs9N+67NxTtDUruR+IcpXH3ly9hjjf
         hqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780295004; x=1780899804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Tz3p3k3U+Y3ZV6RLRiUy+C+O8VoH3a2d1/FWAmkUh0=;
        b=MNe45gr4OiF21VZ72WEtZfn2bRP7mjCY9ZwsP8GK/TwFtaXJALVXQVdftCUlHkDbfd
         x5CYJPgBj46hHfsGI/oEw7DVQwiCMaHclGFUHBhiPhnBl+9B3iVDT6iuai9YbLTtQy5b
         +pJaTgTKxMJrp2lNMvUwCF9D4zB3xvKdVsyQetWAgUeWykmVleC5/pnI4Uw4gcgLzqqi
         /D1StrJK/aZMgFCZX8V3mS3ew0LI3R0TVngXPo2rvH96+MYVG4HlKQvj24ygcmra0smA
         QY5raKBGlvsjEhiL+bVjMFrK7mh44wWrCpCOqVPFWG2CbqtEB3QHGuZuueIP97ysTP90
         p5QA==
X-Forwarded-Encrypted: i=1; AFNElJ+pW1eyKUTTFOqD7FJ6r6WpyeHXycoIeEweV51XtVarghZ7ms/BLud+QpjNCL1fIs9Hqv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUNfhQ2K39yJ2XW4J117axj5jiknCIsb3gUwIY5VxIQghk+lD8
	efZN98A2TO2Kf644iQfwPlK5VL/STog69jd6P/3nQe3J8kiUmNKMqQ1JaIwmumwjO6ozxhw/Phy
	aDg/nBe5BURLsbqte0eH3K8h+wVzHA2AQ8eLBJfEGEw==
X-Gm-Gg: Acq92OFCBPnGCcHdAqNaP8C86uBUMPS4N+Qdx8prEhwMjm3CMbDgM2ijhgPrps6NqyW
	qJVuKOfYDI2yqumo/IgrlxqdTk0I2s/9LqBAo3KFKGM49Tfh+vpUPGh3MumbvNspkYUmZHh2fms
	UAMaamlLWbvGuEP8QgjtGLdpI5x9U2YJqxHBH+PlDn2rvy5WESVAnuaAKwK+V2zLOZ9TzF18pkU
	wQ86OPWlM7hZtZNyF/EA6wmYsvdXeuDGURQBsXlUI4reE0LHc2D3VVMz+A9RqvSZIMDCwkMc4Pl
	6S1IyrxWYXAo9A/YZ8WUmXYLHmjXDPuMZUBVe2NT+IngWV5O7s06jXi/gQQVv+pWMsH4WsM8lur
	SdVIp0u1bDmOzshKY4ulnVq6mqeHh9cQQdN+T5w==
X-Received: by 2002:a05:6820:2d4a:b0:69e:2c0:8485 with SMTP id
 006d021491bc7-69e105a8b63mr5036974eaf.45.1780295003702; Sun, 31 May 2026
 23:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429173002565bdp1o7P0bvOs6yTz64yNx@zte.com.cn> <20260429173534386Dfz8RALJT73-jMfif0nSb@zte.com.cn>
In-Reply-To: <20260429173534386Dfz8RALJT73-jMfif0nSb@zte.com.cn>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 1 Jun 2026 11:53:10 +0530
X-Gm-Features: AVHnY4KcrK1-f9Gli02tgY1vU1JpDz19ta3d5NZ0oRcBHrYoMGeM9BX0ga_fxIc
Message-ID: <CAAhSdy2qqpZ6qucwsuRZWnKgno03Ok4czv8RTgpjA73i+yFhng@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=C2=A0=5BPATCH_v2_2=2F3=5D_RISC=2DV=3A_KVM=3A_add_tracepoints_fo?=
	=?UTF-8?Q?r_guest_page_faults?=
To: wang.yechao255@zte.com.cn
Cc: atish.patra@linux.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 3:05=E2=80=AFPM <wang.yechao255@zte.com.cn> wrote:
>
> From: Wang Yechao <wang.yechao255@zte.com.cn>
>
>
> Add the kvm_page_fault event tracepoints to count the number of KVM
>
> guest page faults.
>
>
> Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>

Lot of redundant newlines in this patch. Looks like this patch
was not sent using "git send-email".

Regards,
Anup


>
> ---
>
>  arch/riscv/kvm/trace.h     | 25 +++++++++++++++++++++++++
>
>  arch/riscv/kvm/vcpu_exit.c |  3 +++
>
>  2 files changed, 28 insertions(+)
>
>
> diff --git a/arch/riscv/kvm/trace.h b/arch/riscv/kvm/trace.h
>
> index 3d54175d805c..9056cc9883cf 100644
>
> --- a/arch/riscv/kvm/trace.h
>
> +++ b/arch/riscv/kvm/trace.h
>
> @@ -56,6 +56,31 @@ TRACE_EVENT(kvm_exit,
>
>   __entry->htinst)
>
>  );
>
>
>
> +/*
>
> + * Tracepoint for page fault.
>
> + */
>
> +TRACE_EVENT(kvm_page_fault,
>
> + TP_PROTO(struct kvm_vcpu *vcpu, u64 fault_address, u64 error_code),
>
> + TP_ARGS(vcpu, fault_address, error_code),
>
> +
>
> + TP_STRUCT__entry(
>
> + __field(unsigned int,   vcpu_id)
>
> + __field(u64,            fault_address)
>
> + __field(u64,            error_code)
>
> + ),
>
> +
>
> + TP_fast_assign(
>
> + __entry->vcpu_id        =3D vcpu->vcpu_id;
>
> + __entry->fault_address  =3D fault_address;
>
> + __entry->error_code     =3D error_code;
>
> + ),
>
> +
>
> + TP_printk("vcpu %u address 0x%016llx error_code 0x%llx",
>
> + __entry->vcpu_id,
>
> + __entry->fault_address,
>
> + __entry->error_code)
>
> +);
>
> +
>
>  #endif /* _TRACE_RSICV_KVM_H */
>
>
>
>  #undef TRACE_INCLUDE_PATH
>
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
>
> index 0bb0c51e3c89..0cfb0149da9f 100644
>
> --- a/arch/riscv/kvm/vcpu_exit.c
>
> +++ b/arch/riscv/kvm/vcpu_exit.c
>
> @@ -11,6 +11,7 @@
>
>  #include <asm/insn-def.h>
>
>  #include <asm/kvm_mmu.h>
>
>  #include <asm/kvm_nacl.h>
>
> +#include "trace.h"
>
>
>
>  static int gstage_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
>
>        struct kvm_cpu_trap *trap)
>
> @@ -43,6 +44,8 @@ static int gstage_page_fault(struct kvm_vcpu *vcpu, str=
uct kvm_run *run,
>
>   };
>
>   }
>
>
>
> + trace_kvm_page_fault(vcpu, fault_addr, trap->scause);
>
> +
>
>   ret =3D kvm_riscv_mmu_map(vcpu, memslot, fault_addr, hva,
>
>   (trap->scause =3D=3D EXC_STORE_GUEST_PAGE_FAULT) ? true : false,
>
>   &host_map);
>
> --
>
> 2.43.5
>
>
>
>
>
>
