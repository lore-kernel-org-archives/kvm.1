Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BA82C235E
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 06:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790661715; cv=none; b=DINsvGUW+afw7g6ZWoKij0kpi3t71V17UR5asO3pQpXp9zXgoKvDYTcz06AZDYL2rfvhKOpZiFZw3W1XQImJv3mDxUCqxlv9pb/DX4KO3VGem0PBnO4CPi9lvWeQBYpOQgciEIN+JjOq245TOkyec4KGhn4s0OUL91eBJpxmewk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790661715; c=relaxed/simple;
	bh=XkksA9GSSGLliljq8Y/tXg08RLqx2fG9x+UiQATM4gY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rQYrjur+l++06/NXHg04Q/91oUuL7uaRL35aPaVxx5glFlnfmftE2OpFuWnPg7e0c+busB/VmGrq9itFo9RW5hrhkPXL0hBxSDi7oswN66x0CW2hBvAxZyW8FPsUINiw7LDiPMDKAQt4YR9KGz/aKNDlZLiE5Fri7/W9Ooh2nBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI8g6PX0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI8g6PX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8FD1F000FF;
	Tue, 29 Sep 2026 06:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790661714;
	bh=KO3n/0Zs5cHzfPk7xcnrFkbbTaaf0hIlmtvo3FRP0l0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fI8g6PX0QJaGb1HS0jY/Bpi8KW5q4LrcmdoBQJP312VJQLjD1Cvp2GzP6TrroF2vW
	 rM8+XJxH0yrG1sf+RLaU6KMGgxd23vdAqyHKiWGWbrTFayoY7cl7I9d4cOmotdncqF
	 z6sCzr5PEZ11DEhCCGHg8k+Zu6esTUPh6N3xjh0zPFYFzDL3hUtl+9HrKCvGuGFpQW
	 4fiqPCCUWwqcFgeiFwABHe6Ra4/NzJu5rLvLlKzbgtBNiWHm12u3W0dQYBWz65DTXw
	 r4Jqi+edSMxReZjwQ72/ywEcN5s9Whd9eEdlhKqWYr2IC771ayoKf6bMFmvYiZfzM8
	 7KpbSJSO402cA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] x86/apic/savic: Forward APIC_SPIV writes to the
 hypervisor
Reply-To: sashiko-reviews@lists.linux.dev
To: shrutiss@google.com
Cc: kvm@vger.kernel.org
In-Reply-To: <20260929055255.1380202-1-shrutiss@google.com>
References: <20260929055255.1380202-1-shrutiss@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:01:53 +0000
Message-Id: <20260929060154.0F8FD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/apic: lost interrupts due to incorrect APIC_SPIV update order
--

commit 26f070fb302ca5a93ef870d540aaf2cf4fb25a54
Author: Shruti <shrutiss@google.com>

x86/apic/savic: Forward APIC_SPIV writes to the hypervisor

This commit updates savic_write() to forward APIC_SPIV writes to the
hypervisor so that the emulated APIC state stays in sync with the guest's
local backing page.

> diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x=
2apic_savic.c
> --- a/arch/x86/kernel/apic/x2apic_savic.c
> +++ b/arch/x86/kernel/apic/x2apic_savic.c
[ ... ]
> @@ -223,6 +222,10 @@ static void savic_write(u32 reg, u32 data)
>  	case APIC_EILVTn(0) ... APIC_EILVTn(3):
>  		apic_set_reg(ap, reg, data);
>  		break;
> +	case APIC_SPIV:
> +		savic_ghcb_msr_write(reg, data);
> +		apic_set_reg(ap, reg, data);

[Severity: High]
Does this specific ordering cause a regression where interrupts could be
dropped?

When a vCPU writes to APIC_SPIV to enable the APIC, savic_ghcb_msr_write()
notifies the hypervisor. The hypervisor then marks the emulated APIC as
software-enabled and may immediately inject a pending interrupt before
resuming the guest.

When the guest resumes, the hardware AVIC evaluates the injected interrupt
against the local APIC backing page. Because apic_set_reg() has not yet
executed, the local backing page still reflects a software-disabled APIC,
causing the hardware AVIC to drop the interrupt.

Would reversing the order of these two calls ensure the local backing page
is ready before the hypervisor is notified?

> +		break;
>  	case APIC_ICR:
>  		savic_icr_write(data, 0);
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929055255.1380=
202-1-shrutiss@google.com?part=3D1
