Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69993976B4
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 23:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774567117; cv=none; b=W0EjaMTqb64JDufE7EIeadkgZed/iUDeUKrOheShjNchijS61kWtAZI/8nukr0JskCTMLuTYop3M8pzzakeNlzHVs9Uy0AjNaawRL+qHU3utbOmk7B22MDxMdwFIPRyey4iO7QhN5IfZr7fUJnXhx+aSH+9xz0Obe19Mkcq7j9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774567117; c=relaxed/simple;
	bh=8W0748SGA3a4asDg7zCZJmROZ8aIYjkamf7rs7VPh30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrCJZBOyrI50KcB+Q4OnVWDId+oA4Dzaacl+2vGFTuf4TwlwqN3XBvoRBavEJm1biAVnkt8NcdAMk2rNr4wrALlHvyl0CscxsueFoe92Ynj3bfLw+Oa8blv+jOJr0ci8gWMHSFSm8R8itTVLdvHnoUhYtgJe07zetoOP0tTW/VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doLmvjkx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doLmvjkx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95143C2BCB2
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 23:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774567117;
	bh=8W0748SGA3a4asDg7zCZJmROZ8aIYjkamf7rs7VPh30=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=doLmvjkx9xDrvQDTMn+M08liJvQJ89rIWFJQN9zy9aE8FQBxLYgGvO1JdvOy/2chk
	 H1v+5B9RNq0b1p/EqGKO1waqxiZHAo4ZxKul3CHHjLwjrGQRv/p1ajDC/GNpfFm+u4
	 XExrgP3v9UQso7Sphl32++2bQctwFKGefocjUT7W56Chhk2eV9cJC6S8ixjzsGixs5
	 DdrdaPqP05ewklAjISerOYar/96rL4NZHMmKkwJgU7tMpH+gM1JM+BT1ivxe5ePBB7
	 2wLV05NXZlzUJAvFPa40EivMoDPYBQIAkHEusE6vNQHoMwXOmPwwPVGk56nxeS48ZN
	 OY8wYM69O+qAQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8f97c626aaso250805066b.2
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 16:18:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUu6H/I83+eB7/gP+MS3U696fo0n5hm6xEqHIp23Vh0rW9On4bPe97B3Bc9x3idC+LmrcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoe+Dy2XzW/F1y+whj06ru1UsnwNq8+j0g2zqHdRtGdDVr+qwF
	7Jsxm3wCDm66Zsu8vGTUj1qng0duhnIswES4K04i6JlkX8Ogmedi4+HL3RvA5OS4nhZPluzD8wS
	nNEUhzzd8E4lYScbSPgtaGX2bMZaX7io=
X-Received: by 2002:a17:907:3e07:b0:b98:2888:6ee9 with SMTP id
 a640c23a62f3a-b9b507968c5mr16784866b.40.1774567116405; Thu, 26 Mar 2026
 16:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326031150.3774017-3-yosry@kernel.org> <202603270611.WB2i1rjQ-lkp@intel.com>
In-Reply-To: <202603270611.WB2i1rjQ-lkp@intel.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 26 Mar 2026 16:18:25 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPuDcHMObfzTQVY-P0Z3kXZbw6y5KJizxvpFWXdW7uKbQ@mail.gmail.com>
X-Gm-Features: AQROBzCJlt8Vy2TBMr8SwNB2MknkvCsicM7UuYcuxTf2vwCM_WDEcuVWpIrY6Ps
Message-ID: <CAO9r8zPuDcHMObfzTQVY-P0Z3kXZbw6y5KJizxvpFWXdW7uKbQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] KVM: x86: Move guest_mode helpers to x86.h
To: kernel test robot <lkp@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 3:49=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Yosry,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on 3d6cdcc8883b5726513d245eef0e91cabfc397f7]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/KVM-x8=
6-Move-enable_pmu-enable_mediated_pmu-to-pmu-h-and-pmu-c/20260326-191518
> base:   3d6cdcc8883b5726513d245eef0e91cabfc397f7
> patch link:    https://lore.kernel.org/r/20260326031150.3774017-3-yosry%4=
0kernel.org
> patch subject: [PATCH v4 2/6] KVM: x86: Move guest_mode helpers to x86.h
> config: x86_64-buildonly-randconfig-004-20260327 (https://download.01.org=
/0day-ci/archive/20260327/202603270611.WB2i1rjQ-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0=
227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260327/202603270611.WB2i1rjQ-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603270611.WB2i1rjQ-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/x86/kvm/svm/svm_onhyperv.c:11:
> >> arch/x86/kvm/svm/svm.h:520:6: error: call to undeclared function 'is_g=
uest_mode'; ISO C99 and later do not support implicit function declarations=
 [-Wimplicit-function-declaration]
>      520 |         if (is_guest_mode(&svm->vcpu))
>          |             ^
>    arch/x86/kvm/svm/svm.h:578:6: error: call to undeclared function 'is_g=
uest_mode'; ISO C99 and later do not support implicit function declarations=
 [-Wimplicit-function-declaration]
>      578 |         if (is_guest_mode(&svm->vcpu) && !nested_vgif_enabled(=
svm))
>          |             ^
>    arch/x86/kvm/svm/svm.h:639:6: error: call to undeclared function 'is_g=
uest_mode'; ISO C99 and later do not support implicit function declarations=
 [-Wimplicit-function-declaration]
>      639 |         if (is_guest_mode(&svm->vcpu))
>          |             ^
>    arch/x86/kvm/svm/svm.h:802:9: error: call to undeclared function 'is_g=
uest_mode'; ISO C99 and later do not support implicit function declarations=
 [-Wimplicit-function-declaration]
>      802 |         return is_guest_mode(vcpu) && (svm->nested.ctl.int_ctl=
 & V_INTR_MASKING_MASK);
>          |                ^
>    In file included from arch/x86/kvm/svm/svm_onhyperv.c:12:
>    In file included from arch/x86/kvm/svm/svm_ops.h:7:
> >> arch/x86/kvm/x86.h:169:20: error: conflicting types for 'is_guest_mode=
'
>      169 | static inline bool is_guest_mode(struct kvm_vcpu *vcpu)
>          |                    ^
>    arch/x86/kvm/svm/svm.h:520:6: note: previous implicit declaration is h=
ere
>      520 |         if (is_guest_mode(&svm->vcpu))
>          |             ^
>    5 errors generated.

Sashiko caught this first :)
https://sashiko.dev/#/patchset/20260326031150.3774017-1-yosry%40kernel.org

I think we just need to fold in including x86.h in svm.h, this fixes it for=
 me:

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ff1e4b4dc9986..2d55c6bf15b32 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -24,6 +24,7 @@

 #include "cpuid.h"
 #include "kvm_cache_regs.h"
+#include "x86.h"

 /*
  * Helpers to convert to/from physical addresses for pages whose address i=
s
