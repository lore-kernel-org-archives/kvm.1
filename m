Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EDD3AAF65
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072735; cv=none; b=hdScYn54ffq50ZMwI3E7tqWwV6NVzmzeO2LkjYFhpPOTRsyuzfYzctO43a1SjOgprwMUE5WbtFXBo2m6FwfAp0EzB5nqnmpCLV1UHAWDLzozCbXZLVIOfXa+DGsIdyQOqlkR2jif9cK0ZoH5IlC1YraE/Ae+LL/7OsiiNqlhCnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072735; c=relaxed/simple;
	bh=alJVkv9Zl8Feffwv59ZU+q7P6tNHAmdNsmaRMU05vBc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iL38hNo2Yqlx5RdC3akqNGXdaM8Dk9qX8XI07EqBBstSzhwUmA+m1sBJBoZLSLcjTQ8xeHkEf7byzpl55qe705J5TwvGb1piz6T7ErqmRkkH1LEssWCX6ECxoU5I/LdhwQ7rNbrXavjULIgOhjVGfBbh2UYGGO1MEY9g6GbdMak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUWZmS16; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUWZmS16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B561F000E9;
	Tue, 18 Aug 2026 17:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787072734;
	bh=Yt7Lu/Ppn65igfUSxBL6Uyv1oioZW1LiB6mLm9IlaZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MUWZmS16VKOI7PJ3b09flM5NwkV+ZOkJmR3AlhXdVjQfOMcBN3Lazk4vHhCth9Uyv
	 kRpquLN2bA0C4saLrY9BChimclIfdeOQ/3rOBsZQ6xrjS1ilfBq6JZ7mqsi3UR2Mfs
	 9XOKtN+kSY37ZFji/ZNad22/inR2Y/3LxrFVXC5InNyRFpt8/3/Bc+sWVk8ImYcAQ7
	 dmeBSPgmPhHuRbd1Z8YIBeVICY8dq00wGunXmpxWeZ7hqCHcDniqlHB6X4uMP2Rmm6
	 VakL7822I08slqdFgIUYEFnbrnvSq4Q0YkLvusIcT6wuGu8KZLlS3/PbhIedP693D5
	 P8IbNsKXM2CuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] KVM: selftests: Check VMPTRLD with active eVMCS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vitaly Kuznetsov" <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260818165258.2613603-5-vkuznets@redhat.com>
References: <20260818165258.2613603-1-vkuznets@redhat.com>
 <20260818165258.2613603-5-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 17:05:33 +0000
Message-Id: <20260818170534.07B561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Code relying on CPU flags after `KVM_ASM_SAFE` incorrectly evalu=
ates them because the macro's cleanup instructions unconditionally clobber =
the flags.
--

--- Patch [4]: [PATCH v2 4/4] KVM: selftests: Check VMPTRLD with active eVM=
CS ---
commit d5821824a958c354147206d0cf6cf26eaeb71cc6
Author: Vitaly Kuznetsov <vkuznets@redhat.com>

KVM: selftests: Check VMPTRLD with active eVMCS

This commit verifies that VMPTRLD triggers a #UD when eVMCS is active.
It uses the KVM_ASM_SAFE framework to safely handle the expected
exceptions from VMPTRLD testing.

> diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testin=
g/selftests/kvm/include/x86/vmx.h
> index 047d02aa96889..e6adde3970d4d 100644
> --- a/tools/testing/selftests/kvm/include/x86/vmx.h
> +++ b/tools/testing/selftests/kvm/include/x86/vmx.h
[ ... ]
> @@ -336,6 +333,22 @@ static inline int vmptrld(u64 vmcs_pa)
>  	return ret;
>  }
> =20
> +static inline int vmptrld_safe(u64 vmcs_pa)
> +{
> +	u64 error_code;
> +	u8 vector;
> +	u8 failed;
> +
> +	asm volatile(KVM_ASM_SAFE("vmptrld %[pa]")
> +		     "\n\tsetna %[failed]"

[Severity: Medium]
Will this setna instruction incorrectly evaluate CPU flags?

The KVM_ASM_SAFE macro executes xor %%r9, %%r9 on its success path, which
unconditionally clears the Carry Flag (CF=3D0) and sets the Zero Flag (ZF=
=3D1).

Because setna evaluates flags immediately after KVM_ASM_SAFE finishes its
cleanup instructions, it captures these clobbered flags and always evaluates
to true.

Does this cause vmptrld_safe() to incorrectly return -EINVAL upon successful
execution?

> +		     : KVM_ASM_SAFE_OUTPUTS(vector, error_code),
> +		       [failed]"=3Dqm"(failed)
> +		     : [pa]"m"(vmcs_pa)
> +		     : "cc", "memory", KVM_ASM_SAFE_CLOBBERS);
> +
> +	return vector ? vector : failed ? -EINVAL : 0;
> +}
> +

[Severity: Medium]
This isn't a bug introduced by this patch, but is a pre-existing issue in
guest_execute_fastop_div() located in
tools/testing/selftests/kvm/x86/fastops_test.c:

Does guest_execute_fastop_div() suffer from a similar flag evaluation issue?

__asm__ __volatile__(fastop(__KVM_ASM_SAFE(insn " %[denom]"))

The fastop macro invokes __KVM_ASM_SAFE, and captures flags via pushfq.
Does capturing flags after the macro result in saving the clobbered flags
from the internal xor instruction rather than the actual result of the
instruction under test?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818165258.2613=
603-1-vkuznets@redhat.com?part=3D4
