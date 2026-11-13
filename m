Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588392;
	b=PdKQfyuR7cWNLOeLFoc0pfFxCeR1gr6JYfFo2+LTNePuBh6b7Rb3TyOubFhJbNqIxGyR
	 PU4G7KhhBW/PPAFWIsHZyGxfEkC/7uq2vQ6YAcNDqkcp6Ocw600ZkVsSaGAcDjsh7bJxQ
	 fpUHGepeF9f4BnGQbCUwDHHe3yImodO78U0BvbeLuPxR+xxjTMovjiZIDuh52Tu3cgxmE
	 5fX91SsR3e8bwqunDayq6DmJTFODNjdD2H+e1DXQtcebC5oirQdbaxJ76w8JaeWgdbohF
	 gjkF4b128GGmh3acmXy/nbUbs5SBV4Y5j21fiiH3KXUaljSiQZqgdIwr6LlDY3lD8tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=72MfZYvopQpVYse1zx4/Q4H4dnKwTtleOUe6/DuAvNo=;
	b=YnwBlVKG8UhLSEHhhAZCDbimSBc4Lv/8jwam9jcw95xIPA7h2zWzqxp6ufQPR6Qkglrp
	 Fgor6J+VsdUVLc1Pm4sCypTil7IfDT5IXSEwu2mRo2o+vINaJc7G4BMDaOVx/CgUabIhI
	 gAy2GQWNcIllo6nCfF8NMl/K7126apYznC4Yg9u466C37yOw8vdT7LIUL32ce/cilaVuf
	 Buvx0LykhjLJI0KVsyzi/d3nK8Kb8+hacj7ZTC/I48tQ1H3VWwDc9GMXcTvutX+hia2Bf
	 SnaIPL3xEbQad3dTWRxvES5wlpGMwH2P7GLPF+oRCZsTDgfXx/OGeDKWzdQK371G69A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Xr3Btyt3;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCA7606F5D5
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 16:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FCA7606F5D5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Xr3Btyt3
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cddc4bde4adso505740a12.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 08:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794588392; x=1795193192; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=72MfZYvopQpVYse1zx4/Q4H4dnKwTtleOUe6/DuAvNo=;
        b=Xr3Btyt3iLlJkSbXUZ/tdJ7o1mG8bsf8i6d4z5fsQXNqJvG11cxs7MMT4kGbkjCX6z
         5lE5cCiIzclOjM1rKaOS8QQ1HM1I4qg+2pqmpQ3Otx/G5eob2eI3+6LXKfBCFbAU+f80
         7pTTqmKCjlDDzVdkgzPvolSgOjKMDH576FczZeI+tHjHrfDGT4dJasXVlaL+zyukPBnw
         2EXJ8/YxLvX29A0In9hL0+4MXoKcqU7DgnD+Lcj8FnrpTkgyNllu6FZTJ2WgG5zZOZBY
         /RdnbIoXCXK/Y7P1V/QJ25QfEAOH5d3SOTblQM6BW58Ja4GPOGL0GAMWFVUoOpi/1/m9
         Le9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794588392; x=1795193192;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=72MfZYvopQpVYse1zx4/Q4H4dnKwTtleOUe6/DuAvNo=;
        b=ElI4IlXX9ekNKjTxbo9cSF8GS2XOeZ2T0eTqc8iE0w9WKvodM+Tly4GNu2zpptY9Fy
         Mo1pUsy4vf3TzKBB1J9rhQQ/4TMw/uYSkksfghvbqMWVuZ+gxAb6485jgl+ml1ffKPD5
         E36D37vO51BZejvqd46TbtJaohBgA561J6ngPGlFcWhmhHTyZ4uoLOlmsoahJSgAOATv
         zccCzMPFZYyG7803g4TDPJqPFMmBdPZi1t365ZyXElIObk+pGP3Lfguu8F0kbyZN/kKw
         OS7ZMl2yNx8xKQBuDp1MC7QSdYP50zosrL4fak/9/qY8MLuIRhovp+6jzOZQuPVn5PBf
         ZBRA==
X-Forwarded-Encrypted: i=1; AL+hErGxWBRlsoeMswPCoENI+bdfKVJNd/ZHfiOv+1fkVJ9e0CYVrXhbVme6bCXxu+5SKn33bz0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/D63aPB0O0qL1/BuO/5ssi44KJ1Bh4kBs9LdJMBF4pn55OIXXa
	rIa45hvo/Cm3ygEqwfYlX7gdfS/sBSxLtzRSD8wYjuq9dLhSs3cEGIyrj8MPepVYqj2ua0ykd+7
	Piuw26g==
X-Received: from pjbng15.prod.google.com ([2002:a17:90b:1a8f:b0:3ad:3715:39c8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c8f:b0:3a5:133:ca5f
 with SMTP id 98e67ed59e1d1-3b1b0b983efmr2928551a91.46.1794588391487; Fri, 13
 Nov 2026 08:46:31 -0800 (PST)
Date: Fri, 13 Nov 2026 08:46:30 -0800
In-Reply-To: <20261112184929.GGavYKObGQNQ0wbDpD@fat_crate.local>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <cover.1794244450.git.prsampat@amd.com> <c64b614ddc83eabc6bb1bdf288272110df04256a.1794244450.git.prsampat@amd.com>
 <20261112184929.GGavYKObGQNQ0wbDpD@fat_crate.local>
Message-ID: <avc-5lkQhoR6US9o@google.com>
Subject: Re: [Patch v4 3/4] x86/sev: Add guest support for Enhanced SMT Protection
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Pratik R. Sampat" <prsampat@amd.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, tglx@kernel.org, mingo@redhat.com, 
	dave.hansen@linux.intel.com, pbonzini@redhat.com, thomas.lendacky@amd.com, 
	kim.phillips@amd.com, nikunj@amd.com, michael.roth@amd.com, 
	ashish.kalra@amd.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 12, 2026, Borislav Petkov wrote:
> On Mon, Nov 09, 2026 at 08:35:13PM +0000, Pratik R. Sampat wrote:
> > @@ -849,6 +850,18 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip, unsigned
> >  	vmsa->vmpl		= snp_vmpl;
> >  	vmsa->sev_features	= sev_status >> 2;
> >  
> > +	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED &&
> > +	    (sev_status & MSR_AMD64_SNP_ESMT_PROT)) {
> > +		vmsa->vcpu_id = apic_id;
> > +		/*
> > +		 * The mask fully set puts every vCPU in one group, so any two
> > +		 * of them may be co-resident. A legal ESMTP sibling must
> > +		 * also match on ASID, so the sibling of a vCPU in guest mode is
> > +		 * always either another vCPU of this same guest or idle.
> > +		 */
> 
> This comment doesn't belong here.
> 
> In any case, this set touches multiple trees so I'm open to suggestions from
> KVM folks how we should do the patch merging tetris eventually.

Post and merge the guest patches separately, and put any architectural collateral
need for the guest code in those patches.  This is not high on my todo list, i.e.
the KVM patches can come later.
