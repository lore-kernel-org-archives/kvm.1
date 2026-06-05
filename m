Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D0C386552
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682778; cv=none; b=UkqCaqJzhIKbz3hr+dhQANRndnRACdjUqrw96qS8Qw5aGFed12fzgOxSo8p4yv6B2fOyzEiY92Azmbi9RpOb7xOH0XLm+mVTTRJZlvNXgrpv8TM6h96YSSWiqqjCiS2yvXTThIRHQeBvboYqwJ8VKvITntEwSPQ+T2YsKopgmyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682778; c=relaxed/simple;
	bh=+8gQj00GuJ586QRB6Rpkf1Gfw/HJzE/5m6yKLPedL3Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DRZGzdHxY28VP3xG1LyY9SDUt+oFwz/m8H2w3lwdNFE/kqQkxe5JMgbFxkbVA4DeSVwOkEg83rm7+G84iwnpMc6Sj3qAj5wDRhSCY9QNFIkbOqjAI/bX66kspcT08Ug2yzam7DFNmKo157BwAz81mbnmhSWgAzHsjPXWJOe08wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0m+HVx4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0m+HVx4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4B01F00893;
	Fri,  5 Jun 2026 18:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780682777;
	bh=ljgWbqRzSzgZ/8fd2QBhSGec3VbuF3PokkzaYu4DaLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L0m+HVx4yNtFTVdmvvpoHkXaA+5aAuI7EZFrz4Id13fMN4B7BIzUoMI1xt++CU8/9
	 h8Kq7GkIHThYy/Xj9mFfdopDKNEvYtT4KEe2540kICvHbtwUuYe+UZrYj2Nrm671l6
	 l+koSbPwLPD9bBtY8DBdU230bORPXkcWNLjt7tRl642JdZ7jTpv+42/yshQpn1PQ6C
	 LxfvHwO/WG8Ld0z7O7THQuIZJ25cBeenoYqb0TssKRfohRhhzg55MnJZVp3nhOjIzo
	 LwICQybAqGuH3tcKK+K6007TMeMCi5WkHb7j7WyUuw388v6GcmjeYh+iad7oHBIBG3
	 AajDTVSqAMmqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Expose number of shadow MMU shadow
 pages as a stat
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260605174611.2222504-3-seanjc@google.com>
References: <20260605174611.2222504-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 18:06:16 +0000
Message-Id: <20260605180617.5B4B01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The field `n_used_mmu_pages` was not removed from `struct kvm_arch`=
, leaving unused dead code.
--

commit 5fa7e390c84e0ce29ce7989e7bf60ba442c4e942
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/mmu: Expose number of shadow MMU shadow pages as a stat

Turn arch.n_used_mmu_pages into a stat, mmu_shadow_pages, as the number of
live shadow pages is arguably the most critical datapoint when it comes
to analyzing the shadow MMU.=20

> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 3886b536c8a57..be84e4d2405e0 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1701,6 +1701,7 @@ struct kvm_vm_stat {
>  	u64 mmu_recycled;
>  	u64 mmu_cache_miss;
>  	u64 mmu_unsync;
> +	u64 mmu_shadow_pages;
>  	union {
>  		struct {
>  			atomic64_t pages_4k;

[Severity: Low]
Should n_used_mmu_pages be removed from struct kvm_arch in this file?

Since all usages of kvm->arch.n_used_mmu_pages are replaced by
kvm->stat.mmu_shadow_pages in this patch, it appears the original
declaration is left behind as unused dead code:

arch/x86/include/asm/kvm_host.h:
struct kvm_arch {
	unsigned long n_used_mmu_pages;
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605174611.2222=
504-1-seanjc@google.com?part=3D2
