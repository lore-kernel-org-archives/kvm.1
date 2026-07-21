Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BCB481FB4
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784634077; cv=none; b=MJz09od2TN65NdxNN51Jouu4VuadmEl+WFX9LzLEHPzihXQ3BpdGIKv0sY/j8V98+Yz+STp1ybbbN0wVibpQytLRMhmmc5eVCdEB1y6Q0vZ9nI/iiIbCG244u2+9z9cx3+iDmQvCUvmCSb39h1t7wwnqAWNigJMC/GfXlv4Y5mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784634077; c=relaxed/simple;
	bh=oZ+/cKJtLKNjBGW1Elrkjcvv2CevawJpV07t5TYidmc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IaljYKOPZRWN6AzodKiGaYost82OYLJEUUElSJ+RB40K17qhTL5kGlb2U7e1mFq1XUR6fKhlRt4AppzucjMQ2Ow6DrTPIXytIjlfBmJrET4BgmOWSJvxKSQnHf/OplYRPN4mIbh4cOZ2jLFfoqBSp867D7xGm3/UlH6ACeyIgHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndCq+6Ip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndCq+6Ip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F851F000E9;
	Tue, 21 Jul 2026 11:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784634071;
	bh=fnFYNQ7/uWm1/elWBjSBbvrnpFHLdXwae4WxYoBvNck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ndCq+6IpCqTeunFoS3l+5xirEPF81ySpxMimgJRlj9BmqSB85Y/G/+FESzY3nmmsD
	 /enVGv0URcKbn3PYAsZVB1YtF1CdH52SHWJoSCvTukE8RYxQNZ+sJTiRE5yJ1j7pTs
	 C+t5ovURwvAPnSPbe5kZgPC1nVFJP/JBT9J/bTGDF0kyt9AhYggq5HTg8S89XdfRMt
	 ZmP0lKVWt+5CHJNXyz9HRyrJC4XbrN7yxPn8U1z+537H6xCVvNqZ2NtFHeq0G+wnoF
	 W7onMDA8qTVjdHJ2MAega6LA/HwhD3Pv2LFYREdp+TE33Rw76ueUcWSpsKbCW9RmjX
	 arjngnAsK7O/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] KVM: selftests: riscv: Add lazy V extension
 enablement for guests
Reply-To: sashiko-reviews@lists.linux.dev
To: JinRui <jinrui@haiwei.tech>
Cc: kvm@vger.kernel.org
In-Reply-To: <574AACF6F4298057+20260721112454.330498-1-jinrui@haiwei.tech>
References: <C286E18DD19A86E7+20260721105736.320687-1-jinrui@haiwei.tech>
 <574AACF6F4298057+20260721112454.330498-1-jinrui@haiwei.tech>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 11:41:10 +0000
Message-Id: <20260721114111.35F851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The replacement of `guest_unexp_trap` with the full exception ve=
ctor table silently removes guest register dumps (`vcpu_dump()`) on unexpec=
ted exceptions, significantly degrading debuggability.
--

--- Patch [1]: [PATCH v3] KVM: selftests: riscv: Add lazy V extension enabl=
ement for guests ---
commit f9473f3696d28b72282cabd505ada7d8de6f8b19
Author: jinrui <jinrui@haiwei.tech>

KVM: selftests: riscv: Add lazy V extension enablement for guests

This commit adds lazy V extension enablement for guests to handle compiler
auto-vectorization on hosts with V extension. It replaces the unused
guest_unexp_trap() handler with the full exception vector table, allowing
safe lazy enablement in route_exception().

> diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/te=
sting/selftests/kvm/lib/riscv/processor.c
> index ded5429f34483..841474acfabd1 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/processor.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
> @@ -297,14 +297,6 @@ void vcpu_arch_dump(FILE *stream, struct kvm_vcpu *v=
cpu, u8 indent)
>  		" T3: 0x%016lx   T4: 0x%016lx T5: 0x%016lx T6: 0x%016lx\n",
>  		core.regs.t3, core.regs.t4, core.regs.t5, core.regs.t6);
>  }
> -
> -static void __aligned(16) guest_unexp_trap(void)
> -{
> -	sbi_ecall(KVM_RISCV_SELFTESTS_SBI_EXT,
> -		  KVM_RISCV_SELFTESTS_SBI_UNEXP,
> -		  0, 0, 0, 0, 0, 0);
> -}
> -

[Severity: Medium]
Does removing guest_unexp_trap() result in the loss of guest register dumps
on unexpected exceptions?

This deleted function triggered KVM_RISCV_SELFTESTS_SBI_UNEXP, which
explicitly yielded a vcpu_dump() on the host side. With the new default
exception handler calling kvm_exit_unexpected_exception() instead, it maps
to UCALL_UNHANDLED.

On the host side, assert_on_unhandled_exception() catches this but lacks
the vcpu_dump() call:

tools/testing/selftests/kvm/lib/riscv/processor.c:assert_on_unhandled_excep=
tion() {
	struct ucall uc;

	if (get_ucall(vcpu, &uc) =3D=3D UCALL_UNHANDLED) {
		TEST_FAIL("Unexpected exception (vector:0x%lx, ec:0x%lx)",
			uc.args[0], uc.args[1]);
	}
}

Will this make it harder to debug guest test failures due to missing PC and
register states?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/574AACF6F4298057+20=
260721112454.330498-1-jinrui@haiwei.tech?part=3D1
