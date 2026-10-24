Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.249
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792826144;
	b=OiVn8bQ66I3USc1KksLRtvyGUyP1M6eUAXA7lILnyj4oGbvklYBHDzS1Rihyie4tYOLi
	 zu7SI+CBEqkKZyXEDm1SPNkhs1uCdI0Uub/L7FdOVRMUjHAoAz8x2EW9VSQIhaFOnVMU5
	 bEmTlkLDjpcmRzxyZV/A10C9z4OHXvS99UpnbO9lgorbYKQyoI1L75ZkJd+6V1A6GUktf
	 w5MLUYKbAoSHmTK/OvYJVE10bUvqGwXD5oZY/wGqlGZkqaTIYN77zvgw3K1rmKFzfiATS
	 oZJzYbptTDoriMWeiSZ3+8cfmrb3x9E5dGIhICiOXkdRAeURsHAvxvDCgKSbk+k2y+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792826144;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=xgVmkxubDRg1cJuzFYDYMiEdO1rVdRyOgY/ruAhYY2s=;
	b=iewHwICsK05xjho8600N8ru2YIOnETGxgtT5UMDiD3FI70rvD2IEMA3z4tUBIMeg0+Zy
	 PdLz84YcmkaeukvvWn/Ks3ZPcEQWEKDEzso4zC+fWCemiYsF0QQz1TQs7OZMaM7JoEqTC
	 AThZEcmU0LNHFx/OekY/FF6Gv+6TkUT+Ybwho54aVuO4w5oYD4huHUmccQ6eAMDQnMM3z
	 vXXL+zJfKRmtFPF9tQCzstRyHD/++jiltOULVTmwLksQ6r8igAnHeoTE0LnMqiYYcArMB
	 fxMtW4poJKvi3r2IcJUntLUuhYamBCrqFsrZUTQJRTQBqS5biBVi8roFXOAGiAre7AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Aq0BzqOU;
	arc=none smtp.remote-ip=95.215.58.249
Received: from mta1.migadu.com (out-249.mta1.migadu.com [95.215.58.249])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B54A606A328
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 07:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B54A606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Aq0BzqOU
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fS8yvEoIwEhEI1jeJexTVj+BAmw6eQpccC70A0wbAfc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792826141; v=1; x=1793430941;
 b=Aq0BzqOUljMMR5tzh7Kyv5yeWxOAyaaYbi+YtLE2cbYreaefc5j4CG0NjIHVwo0ho3SqZvw2
 B3ItMWMKFEtqQK42Qs8JMJc5DwFX2OlfzfBZHUfNke7xZiq14Prb87oEQSVJi159DCwwACOL33r
 vimuLFtJZeiPgdofygAY/Xws=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a29b08333ee19580;
	Sat, 24 Oct 2026 07:15:40 +0000
X-Mizu-Trace-ID: a29b08333ee19580
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5bcbb378fc9so3929e87.0
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 00:15:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzx9UXzVXFZyrQhQ0qcrYaifhzssfope9IgTqohIFwdpP2ixIEKxYmicawzTb7qvSHrx08=@vger.kernel.org
X-Gm-Message-State: AFq9FYIY+hgqMIczKpTV1sS/OLfB5aWOqppWqezo5axDn3Hcrgpq9A4K
	rgaNQlBB4XUtq34lrO/QLhbwIYf2keipH5QImfLFKtrb6orXU3LQN+sHSijULUE/CZjJoiJL0lc
	RMimS16kJf8kpeySmux1gK6zrBwqGAKsO4gERLqox
X-Received: by 2002:a05:6512:3e1a:b0:5bf:b27b:6371 with SMTP id
 2adb3069b0e04-5bfb79f9850mr46341e87.10.1792826135785; Sat, 24 Oct 2026
 00:15:35 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023070110.1833446-1-fuad.tabba@linux.dev>
 <20261023070110.1833446-2-fuad.tabba@linux.dev> <86fqxwzul7.wl-maz@kernel.org>
 <CA+EHjTw08SZC_3Uodt6ew6vXVH-doW-8G41fVCF-rmaKsv+0fQ@mail.gmail.com>
 <86ecdgzp6m.wl-maz@kernel.org> <CA+EHjTy0jpY3sdVCENJRj_kfRDwbZ6TpkCAHQ2xUO-7ZuErpcA@mail.gmail.com>
 <ad724195-3452-495a-a50a-5e5c8093a483@app.fastmail.com>
In-Reply-To: <ad724195-3452-495a-a50a-5e5c8093a483@app.fastmail.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Sat, 24 Oct 2026 08:14:59 +0100
X-Gmail-Original-Message-ID: <CA+EHjTyLnAXanf9R7SuoL3gFZUNewX7QOnW=mc3qzwvaxg7jJg@mail.gmail.com>
X-Gm-Features: AclHuK9QvFT6f4TAsNTrh2PdecgAYJ19yM-sYm9uDvK9gvirJINXHV46-ipXL60
Message-ID: <CA+EHjTyLnAXanf9R7SuoL3gFZUNewX7QOnW=mc3qzwvaxg7jJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: arm64: Hide FEAT_LS64_ACCDATA from guests
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Zhou Wang <wangzhou1@hisilicon.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Fri, 23 Oct 2026 15:10:23 +0100, "Arnd Bergmann" <arnd@arndb.de> wrote:
[...]
> That sounds good. For reference, I have prototyped support for
> LS64_ACCDATA in Linux drivers based on the corresponding x86 code.
> The code is not yet tested on hardware, but it may help understand
> how this may be used in the future.

Thanks, that's useful to see.

[...]
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
[...]
> @@ -254,6 +269,8 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
>          if (prev != next)
>                  __switch_mm(next);
>
> +        switch_iommu_mm(next, tsk); /* FIXME: is there a better place to do this? */

switch_mm() isn't enough when the same thread also runs a vCPU. In v2,
which I'll post soon, KVM will save and restore ACCDATA_EL1 only for
the guest, since nothing in the host uses it today. So after KVM_RUN
returns from a guest that has LS64_ACCDATA, the VMM thread's next
ST64BV0 would use the guest's value, unless KVM also saves and
restores the host's.

[...]
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
[...]
> +static bool try_enable_st64bv0(struct pt_regs *regs, unsigned long esr)
[...]
> +        isar1 = read_sanitised_ftr_reg(SYS_ID_AA64ISAR1_EL1);
> +        if (!(isar1 & ID_AA64ISAR1_EL1_LS64_LS64_ACCDATA))
> +                return false;

v2 will add an ARM64_HAS_LS64_ACCDATA cpucap, so this could test that
instead. As written it tests bits [1:0] of the register, not the LS64
field, since ID_AA64ISAR1_EL1_LS64_LS64_ACCDATA is the unshifted field
value.

> +
> +        sysreg_clear_set(accdata_el1, ACCDATA_EL1_ACCDATA, pasid);
> +        sctlr = current->thread.sctlr_user;
> +        sctlr |= SCTLR_EL1_EnAS0;
> +        current->thread.sctlr_user = sctlr;
> +        update_sctlr_el1(sctlr);

On a host that runs at EL1 (nVHE or hVHE), this also requires
__init_el2_fgt to set nACCDATA_EL1 in HFGRTR_EL2 and HFGWTR_EL2, and
__init_el2_hcrx to set HCRX_EL2.EnAS0. Without them, the ACCDATA_EL1
access traps to EL2 and the hypervisor panics, and so does ST64BV0
once SCTLR_EL1.EnAS0 is set. Happy to write those and the KVM change
once you're ready to post this.

Cheers,
/fuad
