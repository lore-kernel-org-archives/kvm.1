Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDECF3BD649
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761560; cv=none; b=LfDdwoy3UC+krnONUf2F1DcwzrGV2FJsaQd1hBScy1Oo+RUf7pkkNyGaMT4qzcARRKnqznmVNl2/0U01dIL4Jc9rzerp9X/nHmX7vRegBHi7rrRL9NRGlV0rIJ17/6UvFT1LFRIwkuJiaIqngHRVg2tgHSA9HhXg1CRpPmpEcyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761560; c=relaxed/simple;
	bh=uQyeAJaOPIVRnUM/WPrf88YUnn3TiiHht7t9VOLuVqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kzczpOZD217CNjEwnbd/I6R7pJQDcwbRDjNYBXwHLDRWQMVCCAUFWIcXlEFW0QH1ZUbhwdg2Fs0+xMblIOVuP0pj/co9v2BynuyEYg0C6AVLrtYdpbVHiH9tHrN8ir0kzALqrgLJ9dLVgkAErFRlqvuWUex79yujZ1rz1ygT2DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9Tg2HPR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9Tg2HPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557421F000FF;
	Fri, 18 Sep 2026 19:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789761558;
	bh=jPF/dhy8Qy0ULSwWSsIwkP5ApXxMdH+MQ7vMQ/9XYfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T9Tg2HPRT/r0qaMXxlj4fR318gBjU8tfLDAflLquLHjJa0cz+YOx/9WdvnjSLbmK/
	 XSx0Uvpf23kI9fzsrMwAv9lu7kxMh5rhnzmAVL0ZcvWBPmf1h9KN+uB1MwkxC262se
	 ROsXN1v4ZPBIJJIsorTJklyHtB0sBotdsE/2w/Qd9tVHuFy+7vgD7AxBdz4atWl4Fo
	 rLMncl/o4RxsaTZUpiDGFMWhDpifIS76Vh8x3rJHMpSjFlweE5Nrk7d0OcscXRPB5S
	 A8M3qZGXZb2TqoIlpKtPhHZQ1CUpxl3i2x3AQafG9NJXo/a7oJ4gYFEL8dlWGeBVY2
	 Nkvft0nFmB73Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/12] perf/x86: Add
 INTEL_TD_METRIC_FIELD_{BITS,MASK} constants
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918193937.569414-10-zide.chen@intel.com>
References: <20260918193937.569414-1-zide.chen@intel.com>
 <20260918193937.569414-10-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 19:59:17 +0000
Message-Id: <20260918195918.557421F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf/x86: conflation of UMASK shift and MSR metric field width
--

commit ca73afb21aaf968ca13fd3d0ba413055c3dc1861
Author: Zide Chen <zide.chen@intel.com>

perf/x86: Add INTEL_TD_METRIC_FIELD_{BITS,MASK} constants
   =20
Replace the hard coded field width (8) and the equivalent 0xff mask
used for PERF_METRICS MSR field access with named constants
INTEL_TD_METRIC_FIELD_{BITS,MASK}.

> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index cc13164d948f2..cbc9a179f2e5c 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c

[ ... ]

> @@ -4742,7 +4743,8 @@ static int core_pmu_hw_config(struct perf_event *ev=
ent)
>  }
> =20
>  #define INTEL_TD_METRIC_AVAILABLE_MAX	(INTEL_TD_METRIC_RETIRING + \
> -					 ((x86_pmu.num_topdown_events - 1) << 8))
> +					 ((x86_pmu.num_topdown_events - 1) << \
> +					  INTEL_TD_METRIC_FIELD_BITS))

[Severity: Low]
Is it safe to replace the UMASK shift here with the hardware MSR metric
field width?

The original << 8 was used to shift the metric ID into the UMASK field
(bits 8-15) of the software perf event configuration (attr.config).
INTEL_TD_METRIC_FIELD_BITS represents the hardware width of metrics within
the PERF_METRICS MSR.

When evaluated in is_available_metric_event() during perf_event_open(), this
currently functions because both values are 8. However, conflating a softwa=
re
API layout offset with a hardware register field width could cause this mac=
ro
to calculate an invalid configuration mask if the MSR field width changes in
future hardware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918193937.5694=
14-1-zide.chen@intel.com?part=3D9
