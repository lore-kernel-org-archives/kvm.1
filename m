Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFE455295B
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181834; cv=none; b=Vmwmdj/ymhgqEAKebAfQ1v7OiF3O5eL2EvD/COcQrPZwDelhE6mnYI7R226UjKKqO+gdSK7/aSqPKv1ODDu/GINpVFqNCRQygwL4KA5Nw1k5m++BOW1DqmMJYSU6IpQrCW48yXEuqGxOPLhws8GHBrkvBoc8RvkSe1oVnzWFTqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181834; c=relaxed/simple;
	bh=i8r25YKPjBa5pAJdoDmLFf+SIA2zoFkk6BGACm8KSEw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XvVHP3yw/6MnJYHntalSP3Zw3d8UwT9U2t+4kyL3NwbjP32J1aSD9kNe1eZaMJ8nBvMPwrajIGeiN1/oVacJX/wAu43NQGiU09AfH2R46BUEDC0+y6UFiuIs9+wI2N4P5qEB3s3KRX/718BVEtCY44GcSPGbSgkmn7AbK4ysyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ru8Aqjpa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ru8Aqjpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB2D1F000FF;
	Wed, 23 Sep 2026 16:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790181828;
	bh=4DWT2AAK8jHpK5+nLGYv9leqnobOt2ESr9tzamM9l+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ru8Aqjpa0aBg1DFGQK0sa2EP/A2WeyAK7rLjOlf2lZ3eL0WpkpY2+m1vgSkfNJdMK
	 KNVgUM0h5e6FFfGkXzAgRq782S7c1Fg4+m6qFOdFP0JfRy30t5BseZliNDsvBzcsh6
	 MZMdNCkPF975pbHSL20SPf3ExFVOWunAq/RPOaWyfRPLg5kV+kUEF86/2Wxschl/CX
	 Rl2lDy+jqpcsfqy/3OHPgAGaEY8ZcKDluc+JZfFfl44KE+TOYtOjHHrJY0RYBpmbWG
	 7O+jOC9vqmv5aybySdL1NPHSE3yfycaT4erSRFE5V+143Qckjd+QSm8WmiMt0KHYgR
	 L1NZtWL27VfqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: TDX: Synthesize SHUTDOWN instead of returning -EIO
 on unhandled EPT violation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260923163315.1580860-1-seanjc@google.com>
References: <20260923163315.1580860-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:43:46 +0000
Message-Id: <20260923164348.2DB2D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: tdx: host log spam via repeated KVM_RUN on unhandled EPT viol=
ation
--

commit 8eacf1c465f7e8b6cb99f1f4dae3c4af3bcde33c
Author: Sean Christopherson <seanjc@google.com>

KVM: TDX: Synthesize SHUTDOWN instead of returning -EIO on unhandled EPT vi=
olation

This commit synthesizes a triple fault instead of returning -EIO when KVM
encounters an EPT Violation from a guest accessing a pending page. This giv=
es
userspace the option to keep the VM alive or reboot it, rather than treating
the situation as a fatal KVM bug.

> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 7173ef3fc398e..eb82f739a7c04 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
[ ... ]
> @@ -1938,8 +1938,8 @@ static int tdx_handle_ept_violation(struct kvm_vcpu=
 *vcpu)
>  		if (tdx_is_sept_violation_unexpected_pending(vcpu)) {
>  			pr_warn("Guest access before accepting 0x%llx on vCPU %d\n",
>  				gpa, vcpu->vcpu_id);
> -			kvm_vm_dead(vcpu->kvm);
> -			return -EIO;
> +			kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
> +			return 1;

[Severity: High]
Will this change allow a malicious or buggy userspace VMM to flood the host
kernel log?

By replacing kvm_vm_dead() with KVM_REQ_TRIPLE_FAULT and returning 1, KVM
will clear the request during vcpu_enter_guest() and exit to userspace with
KVM_EXIT_SHUTDOWN. If the VMM ignores this exit and repeatedly calls KVM_RUN
without resetting the vCPU, KVM will immediately re-enter the guest.

The guest will hit the exact same unexpected SEPT violation in
tdx_handle_ept_violation(), triggering this unconditional pr_warn() again.
This can create an infinite loop that spams dmesg.

>  		}
>  		/*
>  		 * Always treat SEPT violations as write faults.  Ignore the
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923163315.1580=
860-1-seanjc@google.com?part=3D1
