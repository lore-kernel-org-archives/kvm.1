Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52986455173
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 20:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789589198; cv=none; b=IjB5O4mR9h2E6aQuumA6u7XZ0YQ66+IBlzwc+yvu+TRPpiPLwRUq4sv27CTY7iaEInnqh9j6If9KId3hiYa3L+0VNrKFBsTHlMR7OU31YSZoeFyEAo8BbcX0AzoenSDXhfZBmfi5HNnL2cNUk9wav6dnQwNuRZOqMAQ+1Gsqni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789589198; c=relaxed/simple;
	bh=VzEKtVPwJ5c3PLCUjVCyd1bpWYSReBC0FowIesfcq6I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=crKiMQwRYF8hf9//3qlO/c0lQpoobyTw6MVmloHDirH4Wb+4vMaorqzklJuuj7ebRa5+6BIdUq4JOeIdHlP55wqxfWyC9/eqlV+h/w752EZRn/FKugzDhVFde29sh/7AuWmpCuvh5c2XluB2+xIA6TONeG48o2nRkt0hfocS+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddGbeInn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddGbeInn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7CE1F000FF;
	Wed, 16 Sep 2026 20:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789589182;
	bh=UcnFb/KbilU9/kVofd4ZcSKkdM0gJuvL1jItDUnltDw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ddGbeInngNnXZM2wlKkzW+J/oTPvkkTDBn1nNT1sSOFN0WBL1SBIBOIRPFMi8chi5
	 B2aZ+bYRcPaKPlWRh1bC23MwcFIT6oeC1Sbazm+p1gZotwZoZWoGyHm2fXgGhZUSGs
	 EEkmMvMoqv2iTz2qoI/jh06zqz1+covDefqGhriJFWu6lRTbs08RaUDpO82vueTx/N
	 ReOrKqH63E1Be8C/dNn2bCYaaRGqaiMqgWhgatO0DaAZ9e+v+wzB9bRzfA3pFBVqpl
	 WQE8IPkhOSTNF/ZmKV9hV80hgrtDQdblGPfG7QoaUKfbXJxvDvo8yGEB85FPckRP2L
	 fWdWkvrmNFSwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 5/5] x86/sev: Re-enable RMP optimizations on SNP
 guest shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <9b4608b96d44fa256b55b6ea91603a02a7cd0a35.1789586444.git.ashish.kalra@amd.com>
References: <cover.1789586444.git.ashish.kalra@amd.com>
 <9b4608b96d44fa256b55b6ea91603a02a7cd0a35.1789586444.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 20:06:21 +0000
Message-Id: <20260916200621.EF7CE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: system-wide synchronous IPI broadcast on every SNP guest tear=
down defeats batching
--

commit 23bdc9ba80b8a413abe236834cbaf2ae517ee599
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Re-enable RMP optimizations on SNP guest shutdown

The RMPOPT table indicates whether 1GB regions of physical memory are
entirely hypervisor-owned. When SNP guests are torn down, this patch
re-optimizes all of physical memory by calling snp_enable_rmpopt(). This
process is intended to be batched using a delayed work queue to avoid
overhead during multiple guest terminations.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 0a887f8e05d3a..e05adec44d0aa 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3032,6 +3032,8 @@ void sev_vm_destroy(struct kvm *kvm)
>  		 */
>  		if (snp_decommission_context(kvm))
>  			return;
> +
> +		snp_enable_rmpopt();

[Severity: High]
The commit message mentions that using mod_delayed_work() batches multiple
guest terminations into a single pass.

However, doesn't calling snp_enable_rmpopt() here on every guest teardown
trigger a synchronous system-wide IPI broadcast each time?

arch/x86/virt/svm/sev.c:snp_enable_rmpopt() {
    ...
    on_each_cpu_mask(cpu_primary_thread_mask, rmpopt_program_base, NULL, 1);

    mod_delayed_work(rmpopt_wq, &rmpopt_delayed_work, ...);
    ...
}

Could this unbatched IPI broadcast cause severe performance degradation and
latency spikes across the system when multiple guests are torn down rapidly,
defeating the batching intent?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789586444.gi=
t.ashish.kalra@amd.com?part=3D5
