Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166CE372B50
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780314886; cv=none; b=Z125hHcsHnkUshSNFM+FZlJ2KSzJLnOt+Q6Fequclkz3fWgYfQs3LLeNCKfVyWP1Td1iIzVwGPRoirYzyFGsh+ynX0WC6ryz6g9cf1K7nj3fCDgUeLRtu1QVGc/VbnRDh6PC7DRIZfg4b26ds+OTnkV6YeGNI1W/WO7Lt5ErdtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780314886; c=relaxed/simple;
	bh=TYMQ/MBrv0S/spCp1Vu8Oj17AqXw/ovHPENsTq2r2u8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tGNmvMZBJXM/pxuL4FVR5QVVKSduuGVzYvX3gigRLscPEHW7Cl+Jfy75+w9a/XqFB4c4f548Lkhsb4hOaSCx1aiSiz4j+oKmVWJIeXjnKrcPVWtnWX6lWB8/NVetPeDxbtqjXWrbgVCFgFFcPUywbQSHd8Rveu3Mw16sgYBlyHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDhovk+G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDhovk+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA2E1F0089A;
	Mon,  1 Jun 2026 11:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780314884;
	bh=vOeZ4f8t987Zk1A167WKCAeXKZzMrGTGgLw/2NtsoFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hDhovk+G2UMfOpANf8DNx3W0D5tWnTu1tJckFce29yCU+zMxa/B1IMNDQab03hw2c
	 ZTOJhgZbSvgUHqkg6lvL9jtr0s5zbbaRk9CIQWq2qbgzj7RCYo/M0+BxgslbONujm7
	 D4ijydr73Llm3g82MPT35Zfx1ZP/d+JXl445jx+8z3SFAMRBS8nHagITkknl2h9dDy
	 /ejhRtnlZB4R11Ikz6MRhUsQk3elFtH2tIiAvKGtLilgS/hHHyZ57i/GceYBcaJV0S
	 SF6iJoPknojqtnwzlDi4OXIQsqfFF6Hj7EcibR2QJfF+ci/GCwiXqogAvHW7ReEsV6
	 gYzqR8fF7c5bA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/5] KVM: riscv: selftests: Split SBI FWFT into
 separate feature-specific sublists
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yong-Xuan Wang" <yongxuan.wang@sifive.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601-kvm-get_reg_list-v2-v5-5-415d08a2813b@sifive.com>
References: <20260601-kvm-get_reg_list-v2-v5-5-415d08a2813b@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 11:54:44 +0000
Message-Id: <20260601115444.8FA2E1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `pointer_masking` FWFT registers are omitted from `filter_reg()=
`, causing spurious "new registers" output when testing other FWFT configur=
ations.
--

commit aac064e5a6f0dbfa5efc45c4b208f71e477aa98e
Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>

KVM: riscv: selftests: Split SBI FWFT into separate feature-specific sublis=
ts

Divide the monolithic SBI FWFT register list into separate sublists, each
testing a specific FWFT feature independently. This allows tests to run
correctly on platforms where not all FWFT features are available.

> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/tes=
ting/selftests/kvm/riscv/get-reg-list.c
> index 5033c09201ef1..cb86cb6b36355 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
[ ... ]
> @@ -149,6 +150,14 @@ bool filter_reg(__u64 reg)
>  	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_=
REG(iprio1h):
>  	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_=
REG(iprio2h):
>  		return isa_ext_cant_disable[KVM_RISCV_ISA_EXT_SSAIA];
> +	/*
> +	 * FWFT misaligned delegation registers are always visible when the SBI=
 FWFT
> +	 * extension is enable and the host supports the misaligned delegation.
> +	 */
> +	case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_S=
BI_FWFT_REG(misaligned_deleg.enable):
> +	case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_S=
BI_FWFT_REG(misaligned_deleg.flags):
> +	case KVM_REG_RISCV_SBI_STATE | KVM_REG_RISCV_SBI_FWFT | KVM_REG_RISCV_S=
BI_FWFT_REG(misaligned_deleg.value):
> +		return sbi_ext_enabled[KVM_RISCV_SBI_EXT_FWFT];

[Severity: Low]
Should the pointer_masking FWFT registers be included here as well?

If config_sbi_fwft_misaligned_deleg is tested on a host where the SMNPM
extension is available and cannot be disabled, KVM will expose the
pointer_masking registers. Because they are omitted from filter_reg(), won't
the test framework spuriously report them as new registers?

>  	default:
>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601-kvm-get_re=
g_list-v2-v5-0-415d08a2813b@sifive.com?part=3D5
