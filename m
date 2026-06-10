Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01111FD4
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052078; cv=none; b=Kvc9fVOFM5dUHLoEwDl3m/imv+UXxJiKps5PHnjM2IGVkWLmXflPwbQp9zy5ggeSGpKw9ruOvlI9ogIbjkCR2ONYGvl5LaTHOpb6nXPmimaAtbAOD3UPhG8ed/Q8CXuYmwUM01JUHGRrAN6FQPhJJJlpq019qmmZgMtIbqvymP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052078; c=relaxed/simple;
	bh=oagkz4DR/x4jPm53BLhjZQgdG6Q8hArkeuQPRUTXPNc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QHtgc1A5Px20jO3QBekB0ipZRJiIGdNtzmn1VczigatoBOKozAk2CVvsaYRV/h9V6Tx9J1QCJ67vYsGm/hlVJYAzIAbb7yDe0FBYx7DkeT1xxnVQFfvXDZQeLqIUSXt4qDO7ocyIBYESmcYyobz2m+YVu7tyJzWMSai/nrkScKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gcj5ph1c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gcj5ph1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0FC1F00893;
	Wed, 10 Jun 2026 00:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781052077;
	bh=Lo7j4az9X+04K201Y5+qm6JUEhJzn1Yr6yLmfKCtLf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gcj5ph1cZKzWBcD8ZeeSnc6VCqCUJZM7xw//ji73pa/P8fYxecmxFurcQ6az4m5C4
	 OqjhzKcBs2o8AaFwtO7sojhQ+E96EgezJAOJW57J6mMtjguokprN8baBhghVFPGrrz
	 RgZuPZKzT4qrtEiEK79B+aEc7H1ocA+wWthThNexCosVF/3PQq6EcFCARm7HInGtld
	 CWHWm01zh8meZsZWZJHy7Ae7ydP/agTGPxr/PguGmLv1P+chtfT8D02FcGqdiXuVio
	 DdmZc51ESmXVc+0gB+2Biz8YXv+1SkvWs+Lgzi1aBPdmFcW5L9O3xytj9hy46R84ml
	 RvwYGjSyMT/3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/5] KVM: selftests: Add a helper to query
 enable_mediated_pmu module param
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260610003030.2957261-5-seanjc@google.com>
References: <20260610003030.2957261-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 00:41:16 +0000
Message-Id: <20260610004117.3F0FC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm_is_mediated_pmu_enabled() incorrectly queries the kvm_amd mo=
dule on Centaur and Zhaoxin CPUs, causing tests to needlessly skip.
--

commit f89432ff2f99beb9b018032f8161522a25f18627
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Add a helper to query enable_mediated_pmu module param

This commit adds a utility function to check if the mediated PMU is enabled
by querying the vendor-specific KVM module parameter.

> diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/=
testing/selftests/kvm/include/x86/processor.h
> --- a/tools/testing/selftests/kvm/include/x86/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86/processor.h

[ ... ]

> +static inline bool kvm_is_mediated_pmu_enabled(void)
> +{
> +	if (host_cpu_is_intel)
> +		return get_kvm_intel_param_bool("enable_mediated_pmu");
> +
> +	return get_kvm_amd_param_bool("enable_mediated_pmu");

[Severity: Medium]
Will this cause tests to needlessly skip on Centaur and Zhaoxin CPUs?

Since host_cpu_is_intel only evaluates to true for GenuineIntel CPUs,
VMX-compatible CPUs like Centaur and Zhaoxin will fall through and call
get_kvm_amd_param_bool("enable_mediated_pmu").

Because those platforms use the kvm_intel module, querying the kvm_amd
parameters will result in a missing file (ENOENT), which aborts the
execution with a ksft_exit_skip().

Would it be safer to pivot on host_cpu_is_amd_compatible to check AMD,
and then fall back to Intel for everything else?

> +}
> +
>  static inline bool kvm_is_forced_emulation_enabled(void)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610003030.2957=
261-1-seanjc@google.com?part=3D4
