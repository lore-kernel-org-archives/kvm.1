Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8C4E3241
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614522; cv=none; b=IAqtn4eSKt9pdZNk3NDnwmtK1DNig3PZVE8MPke42fkmfpiN1EsiHgGz5/FG8jZ5TrOG59r8239aZTwH9uKwmfnplCvekyCcBmEmLS2XhwzeFbaBV8xDLc4Nmfc/SQQ8Xiqv6CN+3lgGRQEbE94+g3o/gDEX/hK+g/mF10afS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614522; c=relaxed/simple;
	bh=CD5a+7Ez4rYXqFw6VrpjAY/5sXrdRVK+oT3Rt4dAP7A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nBVxgRDpxf0s3nTaHVevOf04hQPC4tKYpv4E8sIAayE8u+GlGgjFyYkGy1XJ2gYHP6x9M2V/S4JYdx767sZfjUAkfiAADBcysIS20LaNOX/1xQJWqgDLvxbPAl2S5UtmhN31aZNSKxm5Ud5s64b0ynYKxWaGRfKhJ+BJJcfG7QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xs5CzrS8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xs5CzrS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30991F000FF;
	Mon, 28 Sep 2026 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614520;
	bh=UbjDl/VyrkLr3CM6vU/GwJfwBEa8Le6J2stMW4Mu4gg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xs5CzrS8tnqsak16GJKm6drNx3NzMaXX8TV1AfJiibkAXnCghNZobgijkP8r2JEWY
	 4P4lGpH8TvdNEdKjssJEXe1j8N+ZLlkZ6UyNkVbUTT38cZaydVX7ERoDnxpTEBWvZH
	 +buabTaSPxPNgw79LXfkZj3iL3hU5kNIFxfvuQjycvRZKqehjkIDM+CgemMejknWrv
	 ebk6csYoZILkShzq3Asy36N17ok52K3dTr9X2BXw3J9P0mhQxIMO0hSPsrOr8qcMsJ
	 NkTgG9IEEy7BoPrO2BKAqVGIgCzQHB6owDa6rr5FfAOVzOq+Vbs0d/SpFsEUtCWvSs
	 je1qLPd9PuLRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y v4 06/11] KVM: X86: Rename gpte_is_8_bytes to
 has_4_byte_gpte and invert the direction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kenta Akagi" <k@mgml.me>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260928164427.4699-7-k@mgml.me>
References: <20260928164427.4699-1-k@mgml.me>
 <20260928164427.4699-7-k@mgml.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:55:20 +0000
Message-Id: <20260928165520.A30991F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tools/kvm: inverted page role bit breaks plugin_kvm.c parsing
--

commit e1e76187db8d1987f4d32cf661bdfabf00f858af
Author: Lai Jiangshan <laijs@linux.alibaba.com>

KVM: X86: Rename gpte_is_8_bytes to has_4_byte_gpte and invert the direction

The commit renames the gpte_is_8_bytes bit in the MMU page role to
has_4_byte_gpte and inverts its logic. This removes a special case since
guests with paging disabled do not use 4-byte PTEs.

> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 2c378064a1db9..d31817fb39620 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
[ ... ]
> @@ -316,7 +316,7 @@ union kvm_mmu_page_role {
>  	u32 word;
>  	struct {
>  		unsigned level:4;
> -		unsigned gpte_is_8_bytes:1;
> +		unsigned has_4_byte_gpte:1;

[Severity: Medium]
Does this logic inversion break userspace tracing tools?

Looking at tools/lib/traceevent/plugins/plugin_kvm.c, the in-tree plugin
parses this raw bit from the role word under the assumption it represents P=
AE
being enabled (when set to 1):

tools/lib/traceevent/plugins/plugin_kvm.c:union kvm_mmu_page_role {
        unsigned word;
        struct {
                unsigned level:4;
                unsigned cr4_pae:1;

It then prints it as inverted if the bit is zero:

tools/lib/traceevent/plugins/plugin_kvm.c:kvm_mmu_print_role() {
        trace_seq_printf(s, "%u q%u%s %s%s %spae %snxe %swp%s%s%s",
                         ...
                         role.cr4_pae ? "" : "!",

Because this patch inverts the logic in the kernel's role bit without
updating the plugin, will tracing tools like trace-cmd and perf now display
an inverted PAE state (printing 'pae' when disabled, and '!pae' when
enabled)?

>  		unsigned quadrant:2;
>  		unsigned direct:1;
>  		unsigned access:3;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928164427.4699=
-1-k@mgml.me?part=3D6
