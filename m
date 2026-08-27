Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53D53D9543
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787871486; cv=none; b=kzK3dZDAZsxccpbxXKJXtAZNp/Mxi6PqdKsjygRLyQS8lbmTdD3zFL84E50afSkJJc6vXQfi33O+RPop10ZsMb8TB3ehUyHWRi9S+k+oQAumA7QWR8XebfW0QJ1ajxpAiMgJMO9UOY6oz82el3Y4g5Jh139oWTkOHMuV7BDEURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787871486; c=relaxed/simple;
	bh=QAfb4jDWyuzw3nF3WQOe7fzNvoM+8uw5KgyFJJPMUfE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tPpBMqbDpb9WB99UCOicXHBeFKdGNsZEi1eftscc6f/DViX7GdhruYVIDpMRKTRpmaIYVcYq0+7blJFqYIpQLGjI+nFBJrCnypHnUCLrz0vZIO7jra/D6a7cJBrVB1yyWvNg+3l03r3FIt+Jss3ZMIvcKs6wX5SmiNTQm+W5zFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjFmV/TG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjFmV/TG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1341F00A3A;
	Thu, 27 Aug 2026 22:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787871477;
	bh=3l9X4bSvYb6T6WGoa4O/3KRQ7qNqhq3vKJUxTpp/Xhs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JjFmV/TGsWRwm4lnMKTrU1Ui+Elgr3Lx1HwzRkGkJ4Y6K+T+XAdTEDlXDcNtDwtKm
	 89P0wRIcldRzYDML3xV/ebtFby1QCjphJcKX0QYpi1uuXPFud0GuRKaxCnHOwGGbK7
	 zgTOw8TOqBMnLxuVdRO5oydAL73loLkGjHxAIVHBhcGtS9tvyVMDbNyYb7L/F6N0Q+
	 drc3NPTpDMaQcKgEARqfCVTQLdSQIkb/rRU5EYtf4nvbREM/edBWYBE7iNFs6LjE+Q
	 a/KWboSyHp+w7ppZxjHi40YCLL5ohGEpMapenKQBixFwo0/HiWyMFPvGJGVuGQVrwa
	 k0uuWC1rNhxwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/16] KVM: x86/pmu: Remove redundant Perf Global
 Status MSR bit definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260827223755.143247-2-zide.chen@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-2-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 22:57:56 +0000
Message-Id: <20260827225757.5A1341F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing tools header synchronization for msr-index.h
--

commit e6cc32e583cfbb8bac5003f58672184385cc895a
Author: Zide Chen <zide.chen@intel.com>

KVM: x86/pmu: Remove redundant Perf Global Status MSR bit definitions

This commit removes duplicate Perf Global Status MSR bit definitions from
arch/x86/include/asm/msr-index.h, utilizing the canonical macros from
perf_event.h instead. It also updates the KVM PMU code to match.

> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-=
index.h
> index 18c4be75e9271..11b99d237e05b 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1243,14 +1243,6 @@
> =20
>  #define MSR_PERF_METRICS		0x00000329
> =20
> -/* PERF_GLOBAL_OVF_CTL bits */
> -#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT	55

[Severity: Low]
Does this removal also need to be synchronized with the tools copy of this
header?=20

Since the definitions are being removed from the kernel's
arch/x86/include/asm/msr-index.h, leaving
tools/arch/x86/include/asm/msr-index.h out of sync might cause the build
system's check-headers.sh script to emit a warning when building tools like
perf.

> -#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI		(1ULL << MSR_CORE_=
PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT)
> -#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF_BIT		62
> -#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF			(1ULL <<  MSR_CORE_PERF_=
GLOBAL_OVF_CTRL_OVF_BUF_BIT)
> -#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD_BIT		63
> -#define MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD			(1ULL << MSR_CORE_PERF=
_GLOBAL_OVF_CTRL_COND_CHGD_BIT)
> -
>  /* Geode defined MSRs */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827223755.1432=
47-1-zide.chen@intel.com?part=3D1
