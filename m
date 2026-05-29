Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F3F376A1C
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074622; cv=none; b=kjhXyxoujcWUCEMj1mM5HKNd3nsmLg1wE1CM4NnH8b5OKdMXP+fPua2rdsScwOBmRc01jCaCKIWhq/3d6iBxBPSyLi4LZyFzvLcsZ6Mu2XCMo+0u+WidBx2rHG0I2gwijDLC/SFYYw+by00W1h6XKM+C9/cZMC6Hge0j+yh8vFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074622; c=relaxed/simple;
	bh=wMIRWPVm+r0VN0D0usddVdKct2ivn3U71T2fYilRABY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YEznPGa3WlltNDcy4hLvfXBqir+cJzdLqeki+QBWH+b06uvqjrVSbc6yEhjgvefMfoGjbN8VF6UTApSgsvScNHUUH1MiVgQndmq/MNCxFI2/Z3OaOHSk7/FvbuPnRJrKjXsKnMA6GS9BSGRu54eLiRJ5rxGaH/S8AqN8LsJRoec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnBO9Sxb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnBO9Sxb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD1E1F00893;
	Fri, 29 May 2026 17:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780074620;
	bh=y3ACOIOX3BkDm0bQj9w46HyKP8mV3HZRUT80B8l6PpI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BnBO9SxbSzORuN0otOD+eSBekf9+OuEVo24Mj/YYnQM1STl6W4FGGvPg42SIknzGN
	 ZNOp0QmqVLDk7D+7VFABEe7dRYM+XL3RobCMwFko6p+1teguK18HJ/FG7AOheeivSs
	 4Pq8xq1k9kEPlYS6sb0uHGZxFMB/ywtCnI8QQO/SoCtUOc2C6SNTV967nGhpWV2Byz
	 IXgXdx++mTWpYsUTk007qjcFA8Y9TZNv3Mjq9ukCai05NTKjcb0uS65ssKIZBls6PC
	 9RAb6AJRDQRMZPoaevbK1vErho7gWfrzKb912L63RJDt1gEVTKLoXx5rSw/RNe8FbY
	 +M6rPdJLmXY/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/27] uapi: KVM: Provide arm64 UAPI for other host
 architectures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-5-seiden@linux.ibm.com>
References: <20260529155050.2902245-5-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 17:10:19 +0000
Message-Id: <20260529171020.0FD1E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] Including both the host and guest architecture KVM headers in =
the same file results in fatal compiler errors due to redefinition of stand=
ard structures.
- [Critical] `struct kvm_run` memory layout is corrupted for arm64 translat=
ion units running on s390 due to the absence of the `__KVM_S390` macro.
- [High] The newly introduced `include/uapi/arch/arm64/linux/kvm.h` and the=
 existing generic `include/uapi/linux/kvm.h` use the identical include guar=
d `__LINUX_KVM_H`.
- [High] Unconditional use of the `__uint128_t` compiler extension in the f=
allback definition of `user_fpsimd_state_arm64` breaks compilation for 32-b=
it targets.
- [High] Kbuild logic restricts cross-architecture header exports exclusive=
ly to the s390 architecture, breaking unified cross-platform compilation.
- [Medium] The patch exports headers into a new top-level `arch/` directory=
 within the standard system include path.
- [Medium] Missing vital architectural constants due to the exclusion of `<=
asm/ptrace.h>` on non-aarch64 hosts.
- [Medium] Missing `$(srctree)/` prefix in Makefile pattern rule prerequisi=
te can break out-of-tree builds.
- [Low] Unnecessary addition of the raw generated include directory to the =
global LINUXINCLUDE path.
- [Low] Mismatched header guard name in comment.
--

commit ca2d355250085514c5eaba71ad083aa58746bc53
Author: Steffen Eiden <seiden@linux.ibm.com>

uapi: KVM: Provide arm64 UAPI for other host architectures

Enable the ARM64 userspace API to be used on non-arm64 host
architectures, with initial support for s390. This introduces
conditional aliases to achieve architecture independence and updates
the build system to export arm64 architecture headers for s390.

> diff --git a/Makefile b/Makefile
> index f056c921ea9cd..c34f823a9db05 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -588,6 +588,7 @@ LINUXINCLUDE    :=3D \
>  		-I$(objtree)/arch/$(SRCARCH)/include/generated \
>  		-I$(srctree)/include \
>  		-I$(objtree)/include \
> +		-I$(objtree)/include/generated \

[Severity: Low]
Is this addition necessary? The kernel's USERINCLUDE variable already
includes -I$(objtree)/include/generated/uapi, which is where the arm64
generic headers are correctly generated. Adding the parent directory might
improperly expose internal generated headers to the global search path.

> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/=
asm/kvm.h
> index 1c13bfa2d38aa..75cf5aff940e1 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
[ ... ]
> +#ifdef __aarch64__
>  #include <asm/ptrace.h>
> -typedef struct user_pt_regs user_pt_regs_arm64;
> -typedef struct user_fpsimd_state user_fpsimd_state_arm64;
> +#else

[Severity: Medium]
By excluding <asm/ptrace.h> on non-aarch64 hosts, are we missing vital
architectural constants (such as PSR_MODE_EL1h) needed to correctly initial=
ize
the pstate variable in user_pt_regs_arm64? It looks like applications might=
 be
forced to manually redefine these core arm64 architectural constants.

> +typedef struct {
> +	__u64		regs[31];
> +	__u64		sp;
> +	__u64		pc;
> +	__u64		pstate;
> +} user_pt_regs_arm64;
> +typedef struct {
> +	__uint128_t	vregs[32];

[Severity: High]
Does using the __uint128_t compiler extension here break compilation for
32-bit userspace targets? Since this type is not universally supported on
32-bit compilers (like 32-bit x86 or 32-bit s390 compat environments), would
it be safer to use a standard integer type like a __u64 array to guarantee
ABI compatibility?

> +	__u32		fpsr;
> +	__u32		fpcr;
> +	__u32		__reserved[2];
> +} __attribute__((aligned(16))) user_fpsimd_state_arm64;
> +#endif /* __aarch64__ */

[ ... ]
>  struct kvm_regs {
> -	struct user_pt_regs regs;	/* sp =3D sp_el0 */
> +	user_pt_regs_arm64 regs;	/* sp =3D sp_el0 */
> =20
>  	__u64	sp_el1;
>  	__u64	elr_el1;
> =20
>  	__u64	spsr[KVM_NR_SPSR];
> =20
> -	struct user_fpsimd_state fp_regs;
> +	user_fpsimd_state_arm64 fp_regs;
>  };

[Severity: Critical]
If an application includes both the host's <asm/kvm.h> (e.g., s390) and the
guest's <arch/arm64/asm/kvm.h> to interact with both architectures, will th=
is
result in compilation errors? Both files unconditionally define standard
architectural KVM structures like struct kvm_regs, struct kvm_sregs, and
struct kvm_fpu.

> diff --git a/include/uapi/Kbuild b/include/uapi/Kbuild
> index 61ee6e59c930b..452bf9d5c9c0f 100644
> --- a/include/uapi/Kbuild
> +++ b/include/uapi/Kbuild
> @@ -12,3 +12,7 @@ ifeq ($(wildcard $(objtree)/arch/$(SRCARCH)/include/gen=
erated/uapi/asm/kvm_para.
>  no-export-headers +=3D linux/kvm_para.h
>  endif
>  endif
> +
> +ifneq ($(ARCH),s390)
> +no-export-headers +=3D arch/%
> +endif

[Severity: High]
Does this logic restrict cross-architecture header exports exclusively to t=
he
s390 architecture? It appears this will prevent include/uapi/arch/arm64/lin=
ux/kvm.h
from being exported during make headers_install on native arm64 systems,
meaning userspace applications cannot unconditionally include
<arch/arm64/linux/kvm.h> when targeting arm64 VMs.

> diff --git a/include/uapi/arch/arm64/linux/kvm.h b/include/uapi/arch/arm6=
4/linux/kvm.h
> new file mode 100644
> index 0000000000000..21528a146b4d9
> --- /dev/null
> +++ b/include/uapi/arch/arm64/linux/kvm.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef __LINUX_KVM_H
> +#define __LINUX_KVM_H

[Severity: High]
Is it safe to use __LINUX_KVM_H as the include guard here? The existing
generic include/uapi/linux/kvm.h uses the exact same guard. If the generic =
or
host KVM header is included first, the ARM64-specific definitions from this
file will be skipped, preventing userspace applications from simultaneously
accessing host and guest KVM ioctls and types.

[Severity: Medium]
Does exporting headers into a new top-level arch/ directory violate Linux
UAPI conventions? By placing headers in include/uapi/arch/arm64/,
make headers_install will create an arch/ directory in the global system
include directory (e.g., /usr/include/arch/). Standard convention dictates
that exported headers belong in linux/, asm/, or asm-generic/.

> +
> +#include <arch/arm64/asm/kvm.h>
> +#include <linux/kvm-generic.h>
> +
> +#endif /*__LINUX_KVM_H */

> diff --git a/include/uapi/linux/kvm-generic.h b/include/uapi/linux/kvm-ge=
neric.h
> new file mode 100644
> index 0000000000000..a9c757029808b
> --- /dev/null
> +++ b/include/uapi/linux/kvm-generic.h
[ ... ]
> +struct kvm_run {
> +	/* in */
> +	__u8 request_interrupt_window;
[ ... ]
> +	__u64 cr8;
> +	__u64 apic_base;
> +
> +#ifdef __KVM_S390
> +	/* the processor status word for s390 */
> +	__u64 psw_mask; /* psw upper half */
> +	__u64 psw_addr; /* psw lower half */
> +#endif

[Severity: Critical]
Could this cause memory layout corruption for arm64 translation units runni=
ng
on s390? If a developer uses a separate translation unit for arm64 logic and
includes only <arch/arm64/linux/kvm.h>, the host's <asm/kvm.h> is not inclu=
ded
and __KVM_S390 remains undefined.=20

This removes 16 bytes from the struct, shifting the offsets of all subseque=
nt
union fields and causing a silent ABI mismatch with the host kernel.

[ ... ]
> +struct kvm_pre_fault_memory {
> +	__u64 gpa;
> +	__u64 size;
> +	__u64 flags;
> +	__u64 padding[5];
> +};
> +
> +#endif /* __LINUX_KVM_GENERIC_H */

[Severity: Low]
This isn't a bug, but there is a typo here. The #endif comment refers to
__LINUX_KVM_GENERIC_H, while the actual header guard defined at the top of
the file is __LINUX_GENERIC_KVM_H.

> diff --git a/scripts/Makefile.asm-headers b/scripts/Makefile.asm-headers
> index 8a4856e741803..86d4d7173fcdf 100644
> --- a/scripts/Makefile.asm-headers
> +++ b/scripts/Makefile.asm-headers
[ ... ]
> +# Let architectures define architecture specific headers that are shared=
 with
> +# other architectures to enable single-system cross architecture communi=
cation
> +$(shared-uapi-y): $(obj)/%.h: $(shared-uapi-src)/%.h FORCE
> +	$(call if_changed,share_hdr)

[Severity: Medium]
Can omitting the $(srctree)/ prefix in this pattern rule prerequisite break
out-of-tree builds? Unlike other rules that properly use $(srctree)/, relyi=
ng
entirely on VPATH resolution violates Kbuild best practices and can lead to
missing prerequisites during out-of-tree (O=3D...) builds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D4
