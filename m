Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622126;
	b=H4XHTd6HPgkWKCP/Fa6YtAPQbGDie3VuuncD5ogjUfoUtWPrJ+5rumYF6WmFYvtbZNT6
	 74TWOzVihAYGjYkzpATMQoedAGypfRWFtbHsASzlIHYAHECIQqzYT+Wnf+X9zWmoT1MKe
	 B6hc+2j0IdYDRl5wyUtvpkUlTXQ+kN35j+cNVdKnVe4gt7WiMrM/m7FpQ/wf1lMnJ1to7
	 ll1UP40u0atjS8sP7fEeYcB4AgYfySAdSx9Y8NL9uGXiBTt62ku+HhlrexA8dzf6tZXPK
	 +LgFrX2sJAx4MBFoSbM/NilBoLFEVjm0sCaHZXLNvqQC8euwpB6qYQjJANtwooMaC8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622126;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5praovLmNMiloGLMSjvfeB53TP3rGZZiLQVrVPcBvW8=;
	b=QdxLiA14ZLI+ssn/iKrvAdWiiy6ixAq2vlHoH1GzWYLtSmgDFfVy7j7glWX98gEBlWTs
	 rTF5Fdcm975JLJrHF6Q/OUAgO0HfFkoVx7vGS/zqFX/sfXl7iGcew7riVWK5uB9SpLe9R
	 8HZQQRLxN6CpU2++XoOM9O88KUT4A1tHdUnTKko/PmU88sJbDIWQdu0mP0ZreCsFxSFvJ
	 HEeHGrXWrqAlMZ5BlG+etu5u53B1Ivs5vUGZXSMgrzqin/uz6cFGhCPcNC8gz4BiWMBMJ
	 Jv98cqPfUePiMgfUcMlrYiK/IGy5Vvl+at0LMVtwU7yefWOFANRYmct0uddUA1jdwQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AD0606AA0A
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 12:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1AD0606AA0A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a0027ad06761c59e6b3.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:27ad:676:1c59:e6b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7623F243716;
	Mon,  2 Nov 2026 13:22:04 +0100 (CET)
Date: Mon, 2 Nov 2026 13:22:02 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v3 2/8] KVM: SVM: Implement GET_AP_APIC_IDS NAE event
Message-ID: <auh_-EkrjCjUaiA9@8bytes.org>
References: <20261102114137.1198982-1-joro@8bytes.org>
 <20261102114137.1198982-3-joro@8bytes.org>
 <sashiko-outbox-193355@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-193355@kernel.org>

On Mon, Nov 02, 2026 at 11:52:44AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> As reported by Sashiko on v2 [1], GHCB_HV_FT_APIC_ID_LIST is added
> unconditionally to GHCB_HV_FT_SUPPORTED and sev_handle_vmgexit() dispatches
> SVM_VMGEXIT_GET_APIC_IDS to sev_snp_get_apic_ids() for all SEV-SNP guests
> without host userspace opting in.
> 
> When an SEV-SNP guest queries hypervisor features via GHCB_MSR_HV_FT_REQ in
> sev_handle_vmgexit_msr_protocol() or SVM_VMGEXIT_HV_FEATURES in
> sev_handle_vmgexit(), it will unconditionally observe GHCB_HV_FT_APIC_ID_LIST.
> If a guest uses this feature and is migrated or restored onto a kernel without
> SVM_VMGEXIT_GET_APIC_IDS support, guest execution will fail when invoking the
> NAE event.
> 
> Should this new guest-visible feature default to off and be gated behind a
> capability via KVM_CHECK_EXTENSION and KVM_ENABLE_CAP so userspace can manage
> feature exposure and live migration compatibility?

No, this feature is for SEV-SNP guests only, which can not be live migrated.
Live migration for SEV-SNP guests will be built on-top of this feature (among
others).
