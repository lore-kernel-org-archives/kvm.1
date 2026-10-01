Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56152FE44
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868955; cv=none; b=MH1PGjow9CdXd0hOboMCSXpBgxsY/GFl73S8yjlZrH5VuFIdV5mB7XpT/zKRt9UkRnt+BqQWW178q7tmCYnJOH2xujdRSK6wSzbgZagLTcOjXTPw0C3TIYAL25nSaSFB+UxJ1QPndk6jj+4eB9mFAzjr7UYjsye5MUWgwmjekkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868955; c=relaxed/simple;
	bh=I0NXwypq4Uv0Un6xp/gPcOKxwUA50SPOzqYxq8E8tAk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NmNxDjOS3xDiLZ+9t9V2MFAQU3auZag6rGRIRcnvqNL6VyejFSTwmFXebJss3Td4FmqzwYXRMcbqtsPTjrgDYFd9Dzu4oY7xfuJWpo9TnC1ORJC6uAPLdzUlAHp4VH0uswsVekQ7Y+h5xWrpKyH0dmZc/El3w7fHCfQ2N4fvVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SateFPqz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SateFPqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA561F00898;
	Thu,  1 Oct 2026 15:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790868953;
	bh=kgsXVf7mGbh76839gyqMfoOpQCQi8tU/SkGwaJPzUic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SateFPqzyN4abXzANKcKyfHzqBb6QzUyxcDVRDIg8ggy7egwH/i4WQiszVWEyP9Mf
	 x98Xp4C8/Ff9c7/jba/DMIU2pHnqbxg+I7UXL924lW9x2q/2DfWgmalztEki9iqPrE
	 YijjDCTrs2UEfsDCuV/LFOtoNdUob2sxIDYAO/XBEzEysfPv17t8HRb5AgPFJ8syUo
	 +kfQvsYDIKMw4WZ6agPsHQOqSkD2SS5Pv7dMYt+RhHKXVsP4XwTHm2UrquHbWURLiD
	 FmCm+4vonL1hL1FaK21zCrDC0j+sW82ZqnY85eqOq8ITyQeKL1OmL2GXpAObls/IUs
	 PRd7DLQYem6cA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/18] x86,arm,fs/resctrl: Introduce architecture
 hook to program global kernel mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Babu Moger" <babu.moger@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <12063d85972c5a41a95fbded4a01858e5bb04e6e.1790867441.git.babu.moger@amd.com>
References: <cover.1790867441.git.babu.moger@amd.com>
 <12063d85972c5a41a95fbded4a01858e5bb04e6e.1790867441.git.babu.moger@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 15:35:52 +0000
Message-Id: <20261001153553.2DA561F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] resctrl: silent truncation of closid in PLZA kmode configuration
--

commit afe4da7391bfbc3b6cf3aee15c764cd25113c4e6
Author: Babu Moger <babu.moger@amd.com>

    x86,arm,fs/resctrl: Introduce architecture hook to program global kerne=
l mode

    RESCTRL_GLOBAL_ENABLE_PER_CPU mode enables kernel work to use different
    allocation and monitoring associations than the originating user task.

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cp=
u/resctrl/ctrlmondata.c
index e74f1ed54b86c..d5580277db627 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
[ ... ]
> +void resctrl_arch_configure_kmode_global(const struct cpumask *cpu_mask,
> +					 u32 closid, bool assign_ctrl,
> +					 u32 rmid, bool assign_mon,
> +					 bool enable)
> +{
> +	union msr_pqr_plza_assoc plza =3D { 0 };
> +
> +	plza.split.rmid =3D rmid;
> +	plza.split.rmid_en =3D assign_mon;
> +	plza.split.closid =3D closid;

[Severity: Medium]
Will this silently truncate the u32 closid to 4 bits on systems with more
than 16 CLOSIDs?

Looking at union msr_pqr_plza_assoc in
arch/x86/kernel/cpu/resctrl/internal.h, the bitfield restricts closid
to 4 bits:

	struct {
		u64	rmid		:12,
			reserved1	:19,
			rmid_en		: 1,
			closid		: 4,
			reserved2	:11,
			closid_en	: 1,
			reserved3	:15,
			plza_en		: 1;
	} split;

If an administrator assigns a resource group with an index 16 or greater to
kernel mode, the ID will truncate. This causes a QoS resource limit bypass
where kernel execution uses the wrong cache or bandwidth limits.

Given the 11 reserved bits right next to it, is closid: 4 a typo for a
15-bit field?

> +	plza.split.closid_en =3D assign_ctrl;
> +	plza.split.plza_en =3D enable;
> +
> +	on_each_cpu_mask(cpu_mask, resctrl_kmode_set_one_amd, &plza, 1);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790867441.gi=
t.babu.moger@amd.com?part=3D5
