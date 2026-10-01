Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AA153B61D
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868154; cv=none; b=o+fheEMGoTp3oRqESdtXNR8g0ZMIv7PcL7kXj04FXFdgPXscBfGqes9Nc/BcbSY6I1UDGfSeMIVWFr6oreP+aREoVAKvfXzc0lfd6H1PMt8A2WEz9wgwpX8wjY1YRsQr+MbUTK0d6PWsXj1QsqLyKcClvtFh5tAjeOT71+TUzIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868154; c=relaxed/simple;
	bh=2BGDYwy99C5Nu8oF2EcyRwQfM2ggEa3RUa7HIa/9c6k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oWit+Z8M4EiQA7Fr6dPvR89gioZ9RIXP/aTHeCcKs7MRQwK7XTCPmX4J1MqgAq5s12LBOx/j9QCz7T6V8MMU4TPpnK5nJm/iOCvdt2DTL/M286plm3JvDllSobRW6AD+UMAH5Xq+Lj8vVTkKqvGz8s0QnuF3fHJEmjSnFPh7v6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Za+0Iv2m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Za+0Iv2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E5A1F000FF;
	Thu,  1 Oct 2026 15:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790868152;
	bh=NhwWlL76pcyMLSIU6D8uwJ/PQyqN/XjqzBtneo/ODY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Za+0Iv2mQCb4r5SiG4PFtCuC+uipBS2ue4c8fKkhS1A96+Kq4Ua8IKvPSWw0xxX8G
	 wwuMrc+GlQExhy4BJbVKRkKLUz1wDMabKk0uNEc19oWTRJjZNYf3PN4LCfk6mOUEi9
	 vrzyKe4jIrAgbVoTa/fPfIRyoeYd1IIL4xtVj7xF8Gp+Pj9uT4GPWzGInE97arNtDG
	 y0sjtq9LSf1fODtdADPLNteJNQvKbMzGpSSOhq1w5/Q9zb3akZJ8DfCVh1ma6ZUEnP
	 e7QcVjMNo0f51Pjlzz9FUC0HOZua0aywlcvlc3gVY9MMPx/9l+dJvRcJdJNB53wIox
	 XkNO+JDQs1S7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/18] x86/cpufeatures: Support Privilege Level Zero
 Association (PLZA)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Babu Moger" <babu.moger@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <6d0336754b14f33fbc3c5e276ffd7ab12e0d0435.1790867441.git.babu.moger@amd.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <6d0336754b14f33fbc3c5e276ffd7ab12e0d0435.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 15:22:31 +0000
Message-Id: <20261001152232.64E5A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] x86/cpufeatures: missing tools header synchronization for X86_FEATU=
RE_PLZA
--

commit 4774876a98b5fdbef10f6f59346ad4e8b9b8b7ac
Author: Babu Moger <babu.moger@amd.com>

x86/cpufeatures: Support Privilege Level Zero Association (PLZA)

This commit adds support for the Privilege Level Zero Association (PLZA)
feature on AMD processors. It updates the cpufeatures header and the
scattered CPUID bits to detect and expose PLZA.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537 # [2]

> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index f70ee74b5f921..a5599455ce158 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -529,6 +529,7 @@
>  						      * and purposes if CLEAR_CPU_BUF_VM is set).
>  						      */
>  #define X86_FEATURE_X2AVIC_EXT		(21*32+20) /* AMD SVM x2AVIC support for=
 4k vCPUs */
> +#define X86_FEATURE_PLZA		(21*32+21) /* Privilege Level Zero Association=
 */

[Severity: Low]
Does this change also need to be synchronized to the tools directory?

The tools/perf build process runs check-headers.sh, which strictly checks
for synchronization between arch/x86/include/asm/cpufeatures.h and its
copy in tools/arch/x86/include/asm/cpufeatures.h.

Failing to synchronize the tools copy will result in a "Kernel ABI header
differs" build warning when compiling perf from this commit or anywhere
later in the series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790867441.gi=
t.babu.moger@amd.com?part=3D1
