Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.139.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793050996;
	b=seFQNpc6GylUq7oPq7HEMv9jmtAAQ0UCJus4pIAx+O0teidgTtJYwn1LoHs9Pe/Abuna
	 ge/diJWM7vbcP0M6cNGsI0+5ed21e9/VCUctrYDpxQou+3l022Hwz47RBgp9q2bv5Jt2f
	 F0sk6DCCtH7ea+p4tk3qTL4tE27dgbrlvzMODOVAjKb1bnXagnlokqEUptgS8ENnbBeOX
	 NdPa7hrRuKNe3uIRZ0WdTp9wkloqJcbJHReQqpnNh2U47LpBi7yo96V081Fp5264zyLgi
	 Oq2OxCrxfi078f99qGDWtp0VBNGhaoVMMiz6un1yPLj8sO2YbOqYzv5cu0lsIceZXWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050996;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=0Lq4a/V8mDm6FCGgdk05nU9bT6DX1rNy3nB4AjBmimk=;
	b=qWamf3eZGgS0qxVw1ExzmXq5bBSNQTWyJZfHAmZk7n/+jA+8AxshuebnRxUFAm9BPk0C
	 2wrsTIhn/xgY2gjq9hIjSVb5wKehxliMEBn4Ho7VQoeNTvR04i2TpvMMGuE0bScDOivXD
	 X34ScF7XShuU0UJn0aIqtDkJTLRQ05+NNg50sEX7cgRmB49zY+f9FLbkHj39vqcit5x8X
	 8Y7OPCV+O5+A/fOWpqjdDVASMNnbJqWPnUujZTVvIBU7Ia9BnCm1v7dijdoxExvFnTEGX
	 ej/DV1SRVpgFpWTSrHrzrsYnoqoRch1ffx1VX6KSY439166i2adpkyw37mULxUKkffQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=fFqDVruR;
	arc=none smtp.remote-ip=68.232.139.117
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4A0606A31B;
	Mon, 26 Oct 2026 21:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C4A0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=fFqDVruR
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1793051002; x=1824587002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K8Tw0xjvYKK5C3EMr77Wx4LoUSWiFby6WDQXp/hFglg=;
  b=fFqDVruRMWH3WtvV1cI0fpT6D4dw8oHupgTBadNcrcuXGG5/3E8nDHGt
   PTmUQlP45QK30et00rkJN3kh4BksMY4b9/xrCXDPWjQu4rbfJbMbwzWLJ
   RZe1WB5i+9tN8yNy1FwyQBwOez1wkG/nqpK8ABzQDAPPKssQe+MP8DqU9
   3HPPS+oknEkywUON7cKyZEJ2/940haOTnz+jcI8t2MUnCdKc5Y7Sv2f00
   km8U65dF/CpxQ8K9TZw1Kf9K8KN/GyfozcmyfJeHr4tgyCjARSCv6pceO
   KftkOnP9ily+FFMOeeu9lnMYzjgQ05Gm+AMNK/C3fvYutQVvFF0TyTwNS
   A==;
X-CSE-ConnectionGUID: v4N2/SSOQ7OWG0uKTUeBrA==
X-CSE-MsgGUID: r69fHcvGSjiOax1fSVtqVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="259043794"
X-IronPort-AV: E=Sophos;i="6.27,180,1786978800"; 
   d="scan'208";a="259043794"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 06:43:20 +0900
Received: from az2nlsmgm1.o.css.fujitsu.com (unknown [10.150.26.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id C29121C000D5;
	Mon, 26 Oct 2026 21:43:13 +0000 (UTC)
Received: from az2uksmom4.o.css.fujitsu.com (unknown [10.151.22.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 7387CC00FDD;
	Mon, 26 Oct 2026 21:43:13 +0000 (UTC)
Received: from sm-arm-grace07 (unknown [10.124.178.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmom4.o.css.fujitsu.com (Postfix) with ESMTPS id 36B3A405E32;
	Mon, 26 Oct 2026 21:43:07 +0000 (UTC)
Date: Tue, 27 Oct 2026 06:43:05 +0900
From: Itaru Kitayama <itaru.kitayama@fujitsu.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v3] KVM: arm64: selftests: Test VNCR translation
 invalidation
Message-ID: <at_JaV29gVqxueSK@sm-arm-grace07>
References: <20261026-b4-vncr-mapping-test-v3-1-7c094a00d46e@fujitsu.com>
 <861p9czwxc.wl-maz@kernel.org>
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
In-Reply-To: <861p9czwxc.wl-maz@kernel.org>

On Mon, Oct 26, 2026 at 08:30:07AM +0000, Marc Zyngier wrote:
> On Mon, 26 Oct 2026 03:10:10 +0000,
> Itaru Kitayama <itaru.kitayama@fujitsu.com> wrote:
> > 
> > Add a standalone KVM selftest that checks VNCR accesses after L1
> > updates its stage-1 mapping and issues a TLBI. This guards against
> > stale VNCR translations, as KVM caches L1's translation of
> > VNCR_EL2 and must drop it when L1 invalidates the mapping in
> > kvm_handle_s1e2_tlbi().
> > 
> > Keep VNCR_EL2 unchanged while remapping its backing page A to B then
> > again to A. At each step, L2 reads and writes TPIDR_EL2, and L1
> > verifies that the accesses reach the selected page while leaving the
> > other page unchanged.
> 
> If you were tracking cross vcpu invalidation and exercising all the
> architecture corner cases (such as permission changes and co), that
> would be helpful.
> 
> But as it is, it doesn't help much as a validation tool. Its scope is
> way too narrow.

Thank you for your comments. I will try to incorporate the suggested
test scenarios.

Thanks,
Itaru.

> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
> 
