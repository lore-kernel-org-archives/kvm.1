Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E164C4D4896
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170652; cv=none; b=GkW7GRSNFSBX4KxtbwRpPycAIe5M1NRCahdqe0DEqrLiHxRD83SVawYXI1SkdNj7/mXO/JYyCyrnjCn0TGNwWTKeDsoNkZYUyr0GGBn9K4XIsImvwaEDzxBMbkTz177nSjzJEmrRAr5PLx02Un9yZcKT/n++v3n+glzrOTm0sNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170652; c=relaxed/simple;
	bh=QvulPLUdeFiIX/pUNhij9BR2bW7DrV3DGivLiwm9Oi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XvTaEOp0T5u76dZOwQabkPkoZFO92Yn3RHBwyRCMrW/nn8P0mp1DTMY7WpThWlkqZ9gvnOgWWSILhJWy1YUOLdBy2lWBDLB75CSFxOlUN4fn2wVwSUlojL5IN5G2aObZQT04sGUC2+FmcPraCOJoWCu/t/sFXfYu+aoNf4OU/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Px6sTk+T; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Px6sTk+T"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so10608685e9.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790170648; x=1790775448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fcrUh4n9/+wLrzrrVFpgROhaQUP011P1zLKET1PjOsk=;
        b=Px6sTk+Ta8F0bfdt2pFb2NfsN2Ea+5zo+fW2E7iJ/E3CWLGFZlMJxFSTeTdvqFjD1Q
         w9ODEuzvPCPq4W0I8S2hXMDUtC+hLujDg2fRVzP9O77KtKkZpaRqp5zGzOS4cDnKlGZM
         lTPDBP6afc2goITu1m57uprDCBBYKRPIC/aobDHLEpxG7jHjdIRMCVrIXJPvOLWRICuX
         egCiaTeTppQpimadpj/Sb4j1AsJSArIIOOSZJeGDAFZksGKYqh6VDHj3Yh2Rqif68Ug+
         zLRrB+H8rSIb+apgrxBYHj95na/T9bZ8tMOVbFLNmmoIVDX0yFnHWa/4SNWjmjZYJCPI
         yVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790170648; x=1790775448;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fcrUh4n9/+wLrzrrVFpgROhaQUP011P1zLKET1PjOsk=;
        b=qBdpQb1ql4AaQSa1k0HIs9eDM0+iQfSGUPdniVteAz6l3X/WCQUVIHsCrrj47nUNyX
         4sVEUxC8RYTzzqQVGJ4QCKr0PWiAhj7CQ4e9y2yc0L7rj8aa6y0PI4X4MTi70YVZXLfa
         sYyYszRkFnyekZ0sdSi0PjoPReF0d9f1/q88L0/krsle5cT4joh9Ppybe4CHnbEJItgG
         YX+SB7z0A6fVFUuyIZrgS9015R8OxQ43Knw9cYCnAsxZfTYVSD/rKaO6PEtltogEfO4/
         xsrSoNylrkBVyjzptxC3TlaDjWkZQinJTEUExE3PWmpvzovxfiYXHSuohWX+wc5HWOCD
         zNbA==
X-Forwarded-Encrypted: i=1; AKwUvBxCblQl4owZXnLMC/rQu9+sM3w795BfdLO0OEcneSBrBGlv4gkgS53FjxMtz+Wbs9k3vlU=@vger.kernel.org
X-Gm-Message-State: AFuF++n3TzrZoqxwDOqYBbg1RQPWwjQ8xrR1GGUDTZtUhwMD/hbvsEHw
	4XZXGjSHhNiwswDczaIh3CcPhr1wVfBr5XFUc3MVat4J9ESH7McmOLiF6GH6nB5puw==
X-Gm-Gg: AYBFou2EKWipMUXBqdOTQYVgDMoKABmLBDWVOXCqrLtbJm6w7W87V6+D3DlUWQ6vALB
	eYg5pJjDskuixJU8Xu6/1E/uNylrGoDCzuJAIv4HCE6RjnhRxzkmZTL3R+JQozQG3qnADLrq8PP
	YEFmP4Vz//rRe/5Gh8oR81p2GNuQTF4/f/qgeKOYn84cncMzvQAQy0f4mxbD5D9vAe3DvffiyXM
	xVrGVqIwueC4edPam5F/VAIKN7nWHItUP6D3T77kgLXq+19MdL5/s3xoycgH5gZYmMfsMHRtUAd
	6ID+6iZNjvfLQarFBngjDTOFrcx+7Qu9JkbwFBbHRXpglO6RufAmwdPCVn7d2y0p3LFXQftgtTW
	LJAQHJbHBmVyx1eqXt3hcdDVOSMb6MrRi5kATpa0KwYdhJymOpZ3+8S+NDtCJRWWfzpziRzXTX+
	+L0mEHLYHQ0Y24Brx56mJ/XLRyIoD4M/LJjrSGX80mQTSh24ZkIWFkupVeUz8EI5sfbbD0xVQI+
	FtLyn/p25wH457CLNoOv/wzg4i+olV26ftAKO8+Erc2eB7mPbRlveMCfTqX4xXD8cXwG3Sspg==
X-Received: by 2002:a05:600c:8b88:b0:49c:fc6e:8cbd with SMTP id 5b1f17b1804b1-49fdf152e3fmr34515245e9.33.1790170647957;
        Wed, 23 Sep 2026 06:37:27 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde198f85sm82730105e9.8.2026.09.23.06.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 06:37:26 -0700 (PDT)
Message-ID: <b7d1510e-ce88-4e1f-8ac2-f9c33eed0c67@suse.com>
Date: Wed, 23 Sep 2026 15:37:24 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 000/114] single-binary: link multi-targets into
 qemu-system
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260923131635.1894-1-luoyonggang@gmail.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

(reducing Cc list to mailing lists)

On 23.09.2026 15:14, Yonggang Luo wrote:
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
> Changes v2 -> v3:
> - Drop -target. v2 parsed a target_name token and required it on
>   bare qemu-system, with -target ? to list names. v3 selects the
>   target with arch:name on -M. No -M leaves target none. -M help
>   and arch:help list machines.
> - Rebased onto current master. Upstream is_available(void) replaces
>   TYPE_TARGET_SPECIFIC. v3 passes const TargetInfo * into
>   is_available. The v2 patches that registered TYPE_TARGET_SPECIFIC
>   on ARM and RISC-V virt are dropped.
> - TargetInfo is a constructor list, not chosen from argv[0].
>   target_info_select() sets the current entry. Add SysEmuTarget
>   none. A single-target binary does not switch TargetInfo; arch:
>   must match that binary or the machine is rejected.
> - Drop -Dsingle_binary. qemu-system is built from
>   single_binary_supported_targets once arch_srcs are only
>   target-info-def.c. microblaze joins ARM and RISC-V. Per-target
>   binaries stay. Still no qemu-systemw for the combined binary.
> - Unique virt QOM names extend past ARM and RISC-V to or1k,
>   hexagon, loongarch, m68k, and xtensa. query-machines returns
>   MachineInfo typename.
> - TargetCpuOps is an array indexed by target_arch(), registered
>   with a QEMU_ARCH_* bitmask. The header moves from
>   target-info-qom.h to target-ops.h.
> - Those targets are compiled once: ARM, RISC-V, and MicroBlaze fold
>   into common source sets, TARGET_* ifdefs become runtime checks, and
>   KVM moves to system_ss.
> 
> Pierrick Bouvier (2):
>   configs/targets: remove target info definitions
>   target-info: rename target-info-stub.c in target-info-def.c
> 
> Yonggang Luo (112):
>   meson: stale qemu-version.h only when .git exists
>   target-info: rename target-info-impl.h to target-info-def.h
>   target-info: set cpu_type from TARGET_BASE_ARCH
>   target: remove CPU_RESOLVING_TYPE
>   vl: parse early options before target-info init
>   target-info: replace QOM registration with a constructor list
>   tests/unit: add test-target-info
>   tests/qtest: prepare machine-list-test for combined qemu-system
>   kconfig: rename REGISTER to HW_REGISTER
>   target-info: add TargetKconfig
>   target-info: add target_is_* helpers for each architecture
>   target-info: add i386 and x86_64 helpers
>   qom: pass TargetInfo to is_available
>   module: use static ModuleEntry and per-type DSO lists
>   module: add before/after hooks and module_call_init_fn
>   qom: register late types through module_call_init_fn
>   qom: inherit is_available and filter after MODULE_INIT_QOM
>   tests/unit: add module-init and qom is-available tests
>   hw/arm/virt: prefix ACPI helpers with arm_virt_
>   hw/riscv/virt: prefix ACPI helpers with riscv_virt_
>   hw/loongarch/virt: prefix ACPI helper with loongarch_virt_
>   target/riscv: uniquify TCG crc32, crc32c, and wfi helper names
>   hw/riscv: gate boards with target_is_base_riscv
>   hw/intc: use target_long_bits in IMSIC geilen
>   hw/misc/riscv_cmgcr: replace target_ulong with uint64_t
>   hw/intc: use kvm_enabled() in APLIC AIA helpers
>   hw/intc: send IMSIC MSI via kvm_irqchip_send_msi()
>   target/riscv: add kvm stubs source set
>   tcg: fix off-by-one in helper extend-free assert
>   gdbstub: drop per-target cpu-param.h from helpers.h
>   hw/riscv: expand boston-aia and microblaze-v-generic to TypeInfo
>   target/riscv: Include migration/vmstate.h instead of migration/cpu.h
>     in machine.c
>   target/riscv: gate CPU types with TargetInfo
>   target/riscv: select ELF dump class from target_riscv64
>   target/riscv: replace TARGET_* macros in CSR helpers
>   target/riscv: use target_long_bits in pmpaddr granule checks
>   target/riscv: preserve signed XLEN semantics without target_long
>   target/riscv: replace leftover TARGET_LONG_BITS
>   target/riscv: select monitor width at runtime
>   target/riscv: replace target-width format macros
>   target/riscv: replace TARGET_LONG_BITS in translate
>   target-info: add tl_is_64() and target_is_tl32/64 helpers
>   target-info: dispatch CPU QMP, dump, and Angel semihosting
>   tcg: give TCGv its own type and runtime tl ops
>   exec: allow target_long.h, abi_ptr.h and cpu-ldst.h from common code
>   migration: add TargetInfo-gated vmstate fields
>   target/i386: always compile XMM, YMMH, and Hi16 VMSD
>   target/i386: replace VMSTATE_UINTTL with 32/64 TI fields
>   target/ppc: replace VMSTATE_UINTTL with 32/64 TI fields
>   target/sparc: replace VMSTATE_UINTTL with 32/64 TI fields
>   target/mips: replace VMSTATE_UINTTL with 32/64 TI fields
>   hw/hexagon: drop unused migration/cpu.h include
>   migration: remove unused cpu.h
>   target/riscv: gate KVM CPU VMSDs with target_has_kconfig_kvm
>   target/riscv: use tcg_imm_tl in translate
>   target/riscv: select FP and amocas width at runtime
>   target/riscv: drop TARGET_RISCV XL shortcuts in translate
>   target/riscv: select KVM host CPU width at runtime
>   accel: use a shared TYPE_ACCEL_CPU parent
>   kvm: always compile guest debug
>   hw/i386: move APIC_DEFAULT_ADDRESS to apic.h
>   kvm: stop including cpu.h from kvm.h
>   kvm: default kvm_arch_reset_parked_vcpu in stubs
>   kvm: drop COMPILING_PER_TARGET wrap around kvm_arch APIs
>   kvm: add split irqchip and send_msi stubs
>   kvm: replace TARGET_S390X and TARGET_PPC hints
>   kvm: move kvm_ss to system_ss
>   system: add qemu_host_arch() and reject unavailable -accel
>   kvm: add AccelClass is_available for host/guest pairing
>   hvf: add AccelClass is_available for host/guest pairing
>   xen: add AccelClass is_available for host/guest pairing
>   nitro: add AccelClass is_available for host/guest pairing
>   mshv: add AccelClass is_available for host/guest pairing
>   whpx: add AccelClass is_available for host/guest pairing
>   target/i386/nvmm: add AccelClass is_available for host/guest pairing
>   accel: replace ACCEL_CPU_NAME with accel_cpu_register_type
>   whpx: move whpx_ss to system_ss
>   hw/riscv: move boards and irqchip onto hw_common_arch
>   target/riscv: include target_long.h in TCG helpers
>   target/riscv: compile CPU and TCG once
>   target/arm: replace target_long in A64 translate
>   target/arm: use 64-bit TCG addresses in A64 translate
>   target/arm: move kvm_arm_set_cpreg_mig_tolerances to kvm.c
>   target/arm: allow -cpu host with Nitro
>   target/arm: gate -cpu host with TypeIsAvailable
>   target/arm: fix family-common KVM compile
>   tests/qtest: raise aspeed_smc-test timeout to 12 minutes
>   hw/intc: move ARM GIC kvm/hvf/whpx onto arm_common_ss
>   target/arm: fold arm_ss into common source sets
>   meson: link shared objects into qemu-system
>   target/microblaze: fold system sources into common source sets
>   meson: add microblaze-softmmu to the combined qemu-system list
>   boards: remove unused DEFINE_MACHINE_WITH_INTERFACES
>   hw/arm: set virt TypeInfo.is_available
>   hw/arm: set remaining 32-bit machine TypeInfo.is_available
>   hw/arm: set aarch64-only machine TypeInfo.is_available
>   hw/microblaze: set petalogix-s3adsp1800 TypeInfo.is_available
>   hw/arm: expand leftover 32-bit DEFINE_MACHINE to TypeInfo
>   hw/arm: expand imx8mm-evk DEFINE_MACHINE to TypeInfo
>   hw/microblaze: expand petalogix-ml605 and xlnx-zynqmp-pmu to TypeInfo
>   hw/i386: set TYPE_X86_MACHINE TypeInfo.is_available
>   hw/block/dataplane: move xen-block onto system_ss
>   hw/remote: move multiprocess memory onto remote_ss
>   hw/remote: set x-remote TypeInfo.is_available
>   target-info: add SysEmuTarget none
>   accel/tcg: tolerate NULL target_cpu_type for -M none
>   qom: skip unavailable filter when target_none()
>   module: load every arch-tagged module when target is none
>   target-info: select combined qemu-system target by name
>   vl: parse arch: machine types on combined qemu-system
>   qapi: add query-targets
>   tests/qtest: cover combined qemu-system machines and accel-cpu

Now this is really excessive: You mail out a huge series (a fair part
of which apparently still needs to make it through), cross posting to
lists covering components which are touched only in very few places of
the series. I consider such rude already for much smaller series; here
you definitely should have made per-patch Cc lists. I wouldn't be
surprised if xen-devel@ isn't the only list which is being spammed for
no good reason.

Jan
