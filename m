Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644AD496D40
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 23:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791590111; cv=none; b=GfFnhLLCHUOBoP7vo9FOGGSVsjl845wud32fExQ/+Ca4X25teNJKLjYTOOLimsOYBmsg0A8+YqYfe6m5vT3thQXP08HyV1a51YxF96IVxHcyre0l+R6EVQua9K4ZGSJc1jER3sC4tWkgfnFG4sdAAFwhOxkuWVD43gD5J+ASiM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791590111; c=relaxed/simple;
	bh=OTuIxEnE53RMnJTWBfwtM00al2IqAmzEpzc7fkrWpq4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lCX0fLsJqs6jHMvzLGQqrjrWDb1QWsAVpW167Iwsk6kNGAbQ4I/gVkeE13HX9KprBndJ/HFgeEhIqJ3dnGhr+C29CQl4TilGRtRFLkBtPelve+kQr3sVOR5O1XU8Jfeha3+KNtmw+wnH3aJZQdzsx46aN3DS2S8bdjU+EDLa1QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BltmmSI5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BltmmSI5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157DF1F000FF;
	Fri,  9 Oct 2026 23:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791590110;
	bh=aQ628lSQhiIgOxo7K73Y9P5rqOtTDtgnX8Z+7h6lp3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BltmmSI5GZVrr46HMWDgMmvtuBNcuTYvv33f7YaB+x/SNc6FxWJp3Whp5m6j22rBi
	 zCPdbkixMhcPs0cBSjex7PPs+Q1PGvykKoS2TTealLOzBzBEsgOWFcma5SZV+akvQZ
	 yUIkS2croYNaWKEgrWceRh40qFDgnyBfFhZKhIxLX8YOBNCpuNRVonMHbyWiJyPXeb
	 8X3Pl4yn8Cm7sDsk8RXp9fEGFVmBu1jKAX/LfFc5YaWyfP/XEbLX9SxTuXwlHN0LrW
	 y8rzGeyg7NPymuvwNFpVE0dLcKBnXuEpIirq33M+URETsLDDmDXAVXBGUfV9lsh0rJ
	 RiAW2c9aFlpWQ==
Message-ID: <sashiko-outbox-166189@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] fs/resctrl: Assign counters to existing groups
 when enabling mbm_event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Babu Moger" <babu.moger@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <3d966ae2e051ef54e1aedb1a2839c812ab880bcb.1791589412.git.babu.moger@amd.com>
References: <cover.1791589412.git.babu.moger@amd.com>
 <3d966ae2e051ef54e1aedb1a2839c812ab880bcb.1791589412.git.babu.moger@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 23:55:09 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/resctrl: MBM counter leak and hardware misconfiguration for ps=
eudo-locked groups
--

commit b647b3c26df799d4d9b84cff6fe64eee2efa36ad
Author: Babu Moger <babu.moger@amd.com>
fs/resctrl: Assign counters to existing groups when enabling mbm_event

When switching to mbm_event counter assignment mode, existing monitoring
groups are not automatically assigned counters, leaving them unassigned.
This commit walks every existing group and assigns available counters to
match the auto-assignment behavior that occurs for new groups.

Closes: https://sashiko.dev/#/patchset/8cb66e18e32e4087a9712c1e68ee6da614ef=
e244.1784322818.git.babu.moger%40amd.com

> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index a932a1fea8182..84d422da1bace 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c

[ ... ]

> @@ -1272,6 +1275,22 @@ void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
>  					   &mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID]);
>  }
> =20
> +/*
> + * resctrl_assign_cntrs_allrdtgrp() - Assign counters to the MBM events =
of
> + *				      every existing group.
> + */
> +static void resctrl_assign_cntrs_allrdtgrp(void)
> +{
> +	struct rdtgroup *prgrp, *crgrp;
> +
> +	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> +		rdtgroup_assign_cntrs(prgrp);

[Severity: High]
Does this code inadvertently leak hardware counters to pseudo-locked groups?

When a user creates a control group and transitions it to pseudo-locked mod=
e,
its rmid and closid are explicitly freed. If 'mbm_event' assignment mode is
then enabled globally, this traversal loop captures those pseudo-locked gro=
ups
because they are retained in rdt_all_groups.

Since rdtgroup_assign_cntrs() lacks a check for
rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED, the counter allocation proceeds.

Could this cause rdtgroup_alloc_assign_cntr() to program the hardware using
the stale, freed rmid and closid of the pseudo-locked group? This appears to
permanently leak scarce hardware counters and potentially corrupt the hardw=
are
monitoring state of other active groups that have been re-allocated those I=
Ds.

> +
> +		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
> +			rdtgroup_assign_cntrs(crgrp);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791589412.gi=
t.babu.moger@amd.com?part=3D2
