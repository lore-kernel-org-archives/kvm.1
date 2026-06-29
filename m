Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68AA397342
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782758973; cv=none; b=c/r0R4EWNGmtBd7YtmZVjp2CGxOQbvOrVRF5JZN8CA0eLBuD/ULKmE2suDfOHCzZ0XHtGY43Qx6oeJLa5dpmQN/Kkd1wUR6V7NjD4KbAlhQbVzN4uGzg0exiMtwUy7CB40PCSko1OAGyUi5lvSZfoNbvEA32vj/rhwEj+9kPh70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782758973; c=relaxed/simple;
	bh=+0vBR+HA70bF7KeT5WRM4vcCNzNdReOC0kUSTDbk8dU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZX0SgQ9FPqRhVzs6XhTsT1Q3jy3yIfYhIZaYw8rDvsxumJA0ZoGETGZ4NS3ta0MDTVFkMhaf7YYjRKOEowstPJE/naEwA1MrMUYvWJOoQs9qMYmyJjokIQ+X6f9MA2o/ZyG36rEHhZSdYN/xrtnY3MuzShYb69E37NBCiFs/YJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf7+0nkj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf7+0nkj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550311F00A3A;
	Mon, 29 Jun 2026 18:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782758972;
	bh=DM6ZsHxi4K255Aoago0+hNl+c7wx/M4oYxmWz+DRR+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xf7+0nkjfh+uwqQzAE5Ba8LopeQUAJE7VtP8BYucdHQ74AiK4nMWKWeAm9zz9lBRw
	 yvJHgl9iQpXsJ2syL7WwjI9YCbgR9WYSSlQTkHCYwYTB5TV70AQjKatGusLiRQ6Xjh
	 wQHtKHgiq71iFA21MZ+KEvSH3hYkCdXND16AthZt+RFusZNcXT8m2C5yUN0q5QPBwz
	 W3j6T9dan5sc+ss3KywhegJEyQcqIk8DmMQvmjyna/s/6Qr1rbNJNGtBCkEas5Q7ER
	 kd2YWbkLBfpH0elku/wkqOXyEbzTkMWusiXM5+BVTUetWGd2JLtYYpR19Y3QOp1NUZ
	 hpAYos1bzE2Xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/10] KVM: selftests: Reuse GPR switching logic for
 nVMX
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260629183746.699840-6-yosry@kernel.org>
References: <20260629183746.699840-1-yosry@kernel.org>
 <20260629183746.699840-6-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 18:49:31 +0000
Message-Id: <20260629184932.550311F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly introduced VMX_SWITCH_GPRS_ASM logic makes vmlaunch an=
d vmresume thread-unsafe, corrupting L1 host and L2 guest register state in=
 multi-vCPU nested tests.
--

commit f53344a36faa652dd7b5c7d1e749a4bffbc5242b
Author: Yosry Ahmed <yosry@kernel.org>

KVM: selftests: Reuse GPR switching logic for nVMX

This commit introduces VMX_SWITCH_GPRS_ASM to reuse the GPR switching logic
from SVM for nVMX. It replaces the push/pop of registers with
VMX_SWITCH_GPRS_ASM during vmlaunch and vmresume operations for both standa=
rd
and enlightened VMCS.

> diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testin=
g/selftests/kvm/include/x86/vmx.h
> index 4bcfd60e3aecb..a808dc21c9f21 100644
> --- a/tools/testing/selftests/kvm/include/x86/vmx.h
> +++ b/tools/testing/selftests/kvm/include/x86/vmx.h
[ ... ]
> @@ -373,34 +387,23 @@ static inline int vmlaunch(void)
>  	if (enable_evmcs)
>  		return evmcs_vmlaunch();
> =20
> -	__asm__ __volatile__("push %%rbp;"
> -			     "push %%rcx;"
> -			     "push %%rdx;"
> -			     "push %%rsi;"
> -			     "push %%rdi;"
> -			     "push $0;"
> +	__asm__ __volatile__("push $0;"
>  			     "vmwrite %%rsp, %[host_rsp];"
>  			     "lea 1f(%%rip), %%rax;"
>  			     "vmwrite %%rax, %[host_rip];"
> +			     VMX_SWITCH_GPRS_ASM
>  			     "vmlaunch;"

[Severity: Medium]
Will this replacement make vmlaunch() thread-unsafe in multi-vCPU nested
tests?

Since VMX_SWITCH_GPRS_ASM uses GUEST_SWITCH_GPR_ASM which operates on a
single shared guest_regs array in L1 memory, concurrent executions by
multiple vCPUs (e.g., via memstress_l2_guest_entry) could clobber the saved
host state and L2 initial state for all but one vCPU.

The previous push/pop sequence was thread-safe since it used the stack.
Does this same thread-safety issue apply to vmresume() and the evmcs varian=
ts
that also adopted this macro?

>  			     "incq (%%rsp);"
> -			     "1: pop %%rax;"
> -			     "pop %%rdi;"
> -			     "pop %%rsi;"
> -			     "pop %%rdx;"
> -			     "pop %%rcx;"
> -			     "pop %%rbp;"
> +			     "1: ;"
> +			     VMX_SWITCH_GPRS_ASM
> +			     "pop %%rax;"
>  			     : [ret]"=3D&a"(ret)
>  			     : [host_rsp]"r"((u64)HOST_RSP),
>  			       [host_rip]"r"((u64)HOST_RIP)
> -			     : "memory", "cc", "rbx", "r8", "r9", "r10",
> -			       "r11", "r12", "r13", "r14", "r15");
> +			     : "memory", "cc");
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629183746.6998=
40-1-yosry@kernel.org?part=3D5
