Received: from mta0.migadu.com (out-80.mta0.migadu.com [91.218.175.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C316343636B
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511572; cv=none; b=RqkGiOz+loKP4/Vzgz4iAoRO6d3/7GjGLijTMYfhuLOAPtK68qaxhVIt/2dwrDOAWjfz9fJ+OuwsPKZw61fRsdQ76mkdVL+Ctvgm8Ie4lNaZ6g6tkc47WrdN76f2iVnRow0gSYbQopSN2GOAzSQKjiUdov3YD8dnGQWRcQh709A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511572; c=relaxed/simple;
	bh=xcY8MvnvZmT7aDUdDZL53RiTKNAdYrLmhkuOTgsocis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0uLRZ17PIdwipFA05b3G3tDp3RTOXyREC9a5k4S4mN+g6uXGEpqKLaaEHEaGKPVCisQT5u6+tXjFYW7dm42dmUu3Ya9v1NaEyS+rbnwxM+fWetaZTPvqJ7Lp6Ubf12SO1VqQ7rej3Fkk20xaaWf+yBTfKTe0PyqTDoMTXl55U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wtwnLCFc; arc=none smtp.client-ip=91.218.175.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wtwnLCFc"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xcY8MvnvZmT7aDUdDZL53RiTKNAdYrLmhkuOTgsocis=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788511567; v=1; x=1789116367;
 b=wtwnLCFcV+ahYRci3mrwQPhnrBleVq6c0fTImg1E9ueHiwST9zPAgrpiExO40QB2D6IA46AP
 SFtcjnpYsNGs7yx43l6WZD390ZyxpMOrWwkZOMc+bfVmln7tc5ZQtu7REkTsf3MZUjFFQhnlTQo
 NkBdM+sOJ+QblYXRPvwdqyks=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fb1047cf33684301;
	Fri, 04 Sep 2026 08:46:07 +0000
X-Mizu-Trace-ID: fb1047cf33684301
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b4a0b384c4so3664e87.1
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 01:46:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByEQm4Z/AVGhv/Ir0ZpcoV7y55QOkqkCuAuHHlawBCoIeZBxj1OzE17PAEurCHh4Ks/Z+Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lKoDrAH4Bb0xSyOpMG7F/SgWj8Dco9G8KWUeCNcJS/dxaIXFzy
	8yM6z4Z0dj+WV2lbZHfECuq8/Bk7NUiuOQp8wrqxEgamJCM6mjo6dqD8LvzzOLsIxEyGqUvlA1k
	4je0kZRMb7g7JmyAQ+w+TJ2uc0DeNoGtkfqBj0/ry
X-Received: by 2002:ac2:51d0:0:b0:5ae:cf5f:4a88 with SMTP id
 2adb3069b0e04-5b6170da3f8mr87362e87.8.1788511566149; Fri, 04 Sep 2026
 01:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826-arm64-52bit-va-v1-0-14ec98211363@fujitsu.com> <20260826-arm64-52bit-va-v1-2-14ec98211363@fujitsu.com>
In-Reply-To: <20260826-arm64-52bit-va-v1-2-14ec98211363@fujitsu.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 4 Sep 2026 09:45:30 +0100
X-Gmail-Original-Message-ID: <CA+EHjTyJpPd8HjaWBw0V6pHF9UR0w2UFmaKDe7U3O+Sj8wiyPg@mail.gmail.com>
X-Gm-Features: AcwNN1X26g8SofCUgL1E6IJkWpSM-nYwAAIsoW_5phvpJbgrH22ZIA1dnT_JA6o
Message-ID: <CA+EHjTyJpPd8HjaWBw0V6pHF9UR0w2UFmaKDe7U3O+Sj8wiyPg@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: selftests: arm64: Add 52-bit VA guest modes
To: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Takayuki Okamoto <tokamoto@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

Hi Itaru,

On Tue, 25 Aug 2026 at 22:18, Itaru Kitayama <itaru.kitayama@fujitsu.com> wrote:
...
> diff --git a/tools/testing/selftests/kvm/lib/arm64/processor.c b/tools/testing/selftests/kvm/lib/arm64/processor.c
> index 9108e14a9b5b..bcdf670c9eb8 100644
> --- a/tools/testing/selftests/kvm/lib/arm64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/arm64/processor.c
> @@ -46,7 +46,7 @@ static u64 pud_index(struct kvm_vm *vm, gva_t gva)
>         u64 mask = (1UL << (vm->page_shift - 3)) - 1;
>
>         TEST_ASSERT(vm->mmu.pgtable_levels >= 4,
> -                   "Mode %d does not have at least 4 page table levels",
> +                   "Mode %d does not have >= 4 page table levels",

Patch 1 added this string one commit earlier. Could it go in with the
final wording there?

...

> @@ -298,10 +304,14 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
>
>         /* Setup mode specific traits. */
>         switch (vm->mode) {
> +       case VM_MODE_P52V52_4K:
> +               vm->mmu.pgtable_levels = 5;
> +               break;

This is now the deepest mode, so page_fault_test.c's sizing is stale:

   * VM_MODE_P48V48_4K is the mode with most PT pages; let's use
   * twice that just in case.
  pt_size = 26 * guest_page_size;

The margin still covers it. Could pt_size come from vm->mmu.pgtable_levels?

Cheers,
/fuad


>         case VM_MODE_P52V48_4K:
>                 vm->mmu.pgtable_levels = 4;
>                 break;
>         case VM_MODE_P52V48_64K:
> +       case VM_MODE_P52V52_64K:
>                 vm->mmu.pgtable_levels = 3;
>                 break;
>         case VM_MODE_P48V48_4K:
> @@ -322,6 +332,7 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
>         case VM_MODE_P48V48_16K:
>         case VM_MODE_P40V48_16K:
>         case VM_MODE_P36V48_16K:
> +       case VM_MODE_P52V52_16K:
>                 vm->mmu.pgtable_levels = 4;
>                 break;
>         case VM_MODE_P47V47_16K:
>
> --
> 2.43.0
>
