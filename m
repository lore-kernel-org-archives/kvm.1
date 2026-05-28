Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B369A3E1CF6
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779967869; cv=none; b=NszZzVYvV6SkNwge34I3LX0fmQmIHrAm0LOaYZiOPFjkp6tItJR/xvvO1t3Zf1GS8J3QTZJymc1kTYyT1W/rqWyltoG+4uG97ecu/kiqU9jPAsiAn23Opn81WGaHwjEpRiaQp2/5F7DZwUF54gHNg8Eb+ZG12fHU1MWNrEnstpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779967869; c=relaxed/simple;
	bh=YGXFY+DdOfGDfcNodx7fpJ7KmGTdQmFAHhs3kK5kKDA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uFqONalcBTLaiJYUX+lOF9wX9juPryeeZxdm33ALWXqC927/IW7fXP103aTdPG3n2IO/YFqOkyMYHQPOPLdzSZD6/RfjVblqqv7KQwZZyTsMNAO2YzOMcXwgA553Ae/+UYuGwqIzhJRX9CNUBbXf8l7PF3yavqG6BkMhpMp5j3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTtZeswF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTtZeswF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D871F000E9;
	Thu, 28 May 2026 11:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779967867;
	bh=10CDDemI1K7C8vi0TDGYiikKXHIZEdCy1JF88eZz8WU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KTtZeswFwbiFOifVUeJey3GfdcjaOf+hLFx4t7nQ62WCJiyW504bfKcPRm40cTo4f
	 +c3vwdJC/ABtyiSGXA+XGLc48y6YFXwN742rs/TYpe5EGmEzDGt6fevnHXE5a5R+aF
	 B7ghQS9r32sCZAs8YrtvNygQTjU96Xf45WnS/usrOyKIg/Qs0aiGiWROVHh/r3aC43
	 9WZQ+f8Su8pz7SArXFXxBVq5fzlSk1QohhMduFZLgxw9zRDHJ+YZh7cCvBTGkIAOLc
	 fSWGRlwa3eLLEL032Q6GvcjEOR0bOghWKoJe+hbie9WTjdgfnKIWO9Z7jSQQprWlWq
	 35JtB5frN8gog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] KVM/x86: Change comment before KVM_MSR_RET_*
 defines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528111357.264809-2-jgross@suse.com>
References: <20260528111357.264809-2-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 11:31:06 +0000
Message-Id: <20260528113107.48D871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The commit encourages returning negative errno values instead of '=
1' for MSR emulation errors, which breaks the x86 instruction emulator and =
causes fatal VM exits.
--

commit 9a1f204ea737ebfbc9866132f9f3977dfdf82723
Author: Juergen Gross <jgross@suse.com>

KVM/x86: Change comment before KVM_MSR_RET_* defines

This commit modifies the documentation for MSR emulation return values,
stating that negative errno values can be used for error cases instead of
the value 1. It drops the warning about returning 1, 0, and negative number=
s.

> Don't mention the value "1", as current cases where MSR emulation is
> returning "1" should be modified to return a negative errno value
> instead.

[Severity: High]
Does recommending negative errno values inadvertently break the x86
instruction emulator?

Looking at emulator_set_msr_with_filter() and emulator_get_msr_with_filter()
in arch/x86/kvm/x86.c, the sign of the return value is used to determine the
outcome of the emulation:

        r =3D kvm_emulate_msr_read(vcpu, msr_index, pdata);
        if (r < 0)
                return X86EMUL_UNHANDLEABLE;

        if (r) {
                if (r =3D=3D KVM_MSR_RET_INVALID)
                        return X86EMUL_IO_NEEDED;

                trace_kvm_msr_read_ex(msr_index);
                return X86EMUL_PROPAGATE_FAULT;
        }

If a negative errno is returned, these functions return X86EMUL_UNHANDLEABL=
E,
which x86_emulate_insn() treats as an emulation failure by returning
EMULATION_FAILED. This causes KVM to exit to userspace with
KVM_EXIT_INTERNAL_ERROR and abort the VM.

Conversely, a positive return value like 1 correctly results in
X86EMUL_PROPAGATE_FAULT, safely injecting a #GP into the guest.

Could standard guest #GP conditions be transformed into host-level VM
crashes if developers follow this guidance and switch to negative errno
values?

> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 38a905fa86de2..5ca2f3d44092c 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -675,8 +675,8 @@ enum kvm_msr_access {
>  /*
>   * Internal error codes that are used to indicate that MSR emulation enc=
ountered
>   * an error that should result in #GP in the guest, unless userspace han=
dles it.
> - * Note, '1', '0', and negative numbers are off limits, as they are used=
 by KVM
> - * as part of KVM's lightly documented internal KVM_RUN return codes.
> + * Other than these internal error codes negative errno values can be us=
ed for
> + * error cases, or 0 for success.

[Severity: High]
As mentioned above, updating this comment to encourage negative errno values
might lead to unintended VM crashes during emulation. Is it possible we sho=
uld
keep the warning about negative numbers being off limits here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528111357.2648=
09-1-jgross@suse.com?part=3D1
