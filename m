Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19D13EC6AE
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786993297; cv=none; b=GLVY/UmZbjzV8iyqPyJ9VAVcIeqyKAP/Ob7YBM3vu/F1PJKpP4MNLwYuKUMam9g40P+x1CeAKluhyFtp4P0snVIiHV25LKqRB3ogap0+/ONynZjtRNbHlhS/cbtMywWA5wMHfAp3fHuNG0S3Wu1duhq7/tF1Xsrv2O6kT9atTAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786993297; c=relaxed/simple;
	bh=RX2lrCR6MwFMPi5a64G3mEBIeUHFETUdmTXAREUE9Z8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AcjLCR4lQRqTfHYc7fTIcS8l46b2aPk413PYyg+vhiMw7F78L6WTpn5ZQgltv3PIidQZ+tSgONbA7VdKVYl+qizn10cMPZ6vwpaToFo1/bHxwbBgr5CFxWIAPfpUz2/Qdzk2AomHA444muB1o92xLWPDmg4LS9gxnGsGfv2m0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcZmZkiV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcZmZkiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF511F00A3A;
	Mon, 17 Aug 2026 19:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786993295;
	bh=bBKjO/BHo5S4Zv81afH1Z3K18lsvoarpy7qapI2FqBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mcZmZkiVSjFVx5fpsyCpRUXqyxxCFau9IkviWprHQxcC11mtWdtOuz3bNGx47+qA+
	 6DNxkwAAfSz7MddpGsQQABfdnWDZlIo8JBv7rzOCb+Gr9j4IPIF6kw8Sx2f3kcmS77
	 JvEyN3VLoAdV5R4LA2NsMRV1TDifBnDgfRfPbBQu0LjmUe9UroHzjuFOVofRUopJ/p
	 VfpjulGCOufWpyNfNt9/94LzepUwmxSt63H8gnIRIJ0ZfPU1zfkvGMD08pXlrj1uqj
	 n4wG/Q7/YdBuQXyqFd1migw/IApp15tZH/QISU1QvTmxeNZN9BVebJ4/TjBjirq5kK
	 tgwR81iIbIkjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/8] KVM: x86/pmu: Emulate RDPMC on performance
 metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260817183143.226156-8-zide.chen@intel.com>
References: <20260817183143.226156-1-zide.chen@intel.com>
 <20260817183143.226156-8-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 19:01:34 +0000
Message-Id: <20260817190135.4AF511F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Metrics Clear Mode is not emulated, causing guest application cr=
ashes (#GP) when RDPMC is intercepted.
--

--- Patch [7]: [PATCH v8 7/8] KVM: x86/pmu: Emulate RDPMC on performance me=
trics ---
commit 5022d9b3f098d7ca5a383495c52fb9e9c119df3b
Author: Zide Chen <zide.chen@intel.com>

KVM: x86/pmu: Emulate RDPMC on performance metrics

This commit adds emulation for RDPMC performance metrics when RDPMC
interception is enabled. It handles type 0x2000 but skips Metrics Clear Mode
for simplicity.

[ ... ]

> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index bbf4afcffafc8..3ca61e4b0ba68 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
[ ... ]
> @@ -125,6 +126,19 @@ static int intel_emulate_rdpmc(struct kvm_vcpu *vcpu=
, unsigned int idx,
>  		counters =3D pmu->gp_counters;
>  		num_counters =3D pmu->nr_arch_gp_counters;
>  		break;
> +	case INTEL_RDPMC_METRICS:
> +		if (!kvm_vcpu_has_perf_metrics(vcpu))
> +			return 1;
> +
> +		/*
> +		 * The index in ECX[15:0] is implementation specific, but no
> +		 * platform currently supports a non-zero index.
> +		 */
> +		if (idx)
> +			return 1;
> +
> +		*data =3D pmu->perf_metrics;
> +		return 0;
>  	default:
>  		return 1;

[Severity: Medium]
The commit message notes that Metrics Clear Mode is not supported for
simplicity. However, if a guest application uses Metrics Clear Mode (setting
bit 16 in ECX, making the type 0x20010000), it will fall through to this
default case since it doesn't match INTEL_RDPMC_METRICS.

Returning 1 here causes KVM to inject a #GP. Does this cause unexpected
crashes (like a SIGSEGV) for unprivileged guest userspace applications that
legitimately try to use this architecturally valid mode when RDPMC is
intercepted?

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817183143.2261=
56-1-zide.chen@intel.com?part=3D7
