Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823647;
	b=zKpYm3Nj7pvCP/KFXYx2CckY4BkLjDS5qEnye4PnxwNxm2iU80NNClw82jrxfz2+fOYu
	 fMM2BKVPG46sYPaGMIypmeOjDtl5ChnyymCRsovj9vx31iOYdazCCjZo1mMitEAIT4YCN
	 F/+fXUComj0aHkOiR2+4eWB+Iu2c+JdMFkss7Ef2+rrr0GnYLLt66NepA1BCTO3uJ9ZDB
	 41EGRgPL4dilAxx4y4bnezsYwoj9qcMndo7ocuzyw+k3ADHLHWNxEOPHN6mYf6+MEM0lX
	 KnRJhLjTdmG0ZltwcXvRy+e02iTHx1HZGXilJafwr2vV2tqyxpSNoYobbDyZ4eM6Jag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=YBF8x8sJdLXwce+ZD1baPxrZukLcOjCkutFhGRoX8Ps=;
	b=1VRlnpNzv5+ZCIwJR8J1vGIOrX08FiS93bYarIONfNp6W0BkuJxQW8Sks5/mKw9lQzwe
	 ybbcXbx6gBD7J26iJMOyqx9cde428Tmi8ZtWE225/8VEvIbZdveaepYD1+6vTiSb8bz3z
	 i64CY+Y6Re+Z906EK4XSrxV1IbQuWLmx7ntBoAk2BdPpGKVArUX2SC4Q2cOicvGVITKob
	 IIUyt/0+hzZ9lqW6zjJA/FSEf9qKHIvNTsI9+N/VgT8muMd+TUPUilOaYuFTQ7aQQqybU
	 MBI1Hk0AdxEbCmSKsM3ZMM6tZulgSS+1Pys7W/LQv4EJ7iH5GZQ1BF2sg57jj7iekgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PN1sUwyA;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCC2607264A
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 20:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CCC2607264A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PN1sUwyA
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3adc5b185bfso1242804a91.3
        for <kvm@vger.kernel.org>; Wed, 04 Nov 2026 12:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793823647; x=1794428447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YBF8x8sJdLXwce+ZD1baPxrZukLcOjCkutFhGRoX8Ps=;
        b=PN1sUwyAddPe7VvpEaZRJFq1QZQ7kwG61fsfBBo4Z2jueT8w/WyQkPsLAzpW6/H0F4
         +33Uu7Nx0w8lExd6aDaU09xnhCaWRykUWL3qbJrkbneSeYICnJwbrEMQ/CDvPbW/68X6
         n7gnpQdqtgEIW9p8K7XIPumNUYEvX4RBSd+nsieePzwjksBiWC93wNYgy+JLwG3tc8Db
         RgN9CfRxkScddyeazcJDM/VrLUn/GD93UaqglBwYZUcKCgaI8eD6Tnp2HTUq3r3FDV8x
         Rhexa5nj0aVxR9tGs9krKM2vAWINtOpgqF0t5X0iUzrfAmA61ywAB/3gq3daMxANJUaN
         DWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823647; x=1794428447;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YBF8x8sJdLXwce+ZD1baPxrZukLcOjCkutFhGRoX8Ps=;
        b=hamQar6iflTCEcVBImkBRiyBgzwJoOy56ES0HBu8W9JK5iUV3TviLzcuKa1q/3JAvm
         5YzjG2fBhHvE6oSUdI33hLgt35TaCIlnMlIbUogWnjCVaV/ZdjY229YBXDumAo14SgNf
         jlwPTzQxvR2U1E8k+vRjmREn4LRN2zE7oidgVxMcvMZDxQnFuYaZL60c1YMtJQFYC/dY
         ElcExdnGt+f1YAWhsF4MrVI+ol51bvE6+NoZC6oyvogM3TxwiuPCyh1aqBZezH+tjSI4
         lRbB85U4LwnhlZKk8ezBJCf2VRFCTbFm6ttuRSfcx7L62bwlLIqz/PYAJ1gAagxfaerM
         5O4g==
X-Forwarded-Encrypted: i=1; AKwUvBx2QUZ7Yop2LrpUQ9AEcweF4nNbdTTNbthXgndmBs8aq43qO3R6PyXNFhDte9CAPLa6NJw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ATtmRIEd2qokGW/udUPJOJIzrxokRj5iY62HOvwgsb0indWu7
	9VVEAH4A30e6jdWcgcc4fHTkB1mQHtwFTKf4hw+v71+qdIHnZP9UPCO5IRlE1armENyMKRFIu34
	rMLc6tQ==
X-Received: from pjqv12.prod.google.com ([2002:a17:90a:af0c:b0:3ad:ce09:ff3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380c:b0:3ad:13fe:41ba
 with SMTP id 98e67ed59e1d1-3ae897c8968mr13887718a91.52.1793823646440; Wed, 04
 Nov 2026 12:20:46 -0800 (PST)
Date: Wed, 4 Nov 2026 12:20:45 -0800
In-Reply-To: <auh_-EkrjCjUaiA9@8bytes.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102114137.1198982-1-joro@8bytes.org> <20261102114137.1198982-3-joro@8bytes.org>
 <sashiko-outbox-193355@kernel.org> <auh_-EkrjCjUaiA9@8bytes.org>
Message-ID: <auuTnRi2EhuY0HT6@google.com>
Subject: Re: [PATCH v3 2/8] KVM: SVM: Implement GET_AP_APIC_IDS NAE event
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026, J=C3=B6rg R=C3=B6del wrote:
> On Mon, Nov 02, 2026 at 11:52:44AM +0000, sashiko-bot@kernel.org wrote:
> > [Severity: High]
> > As reported by Sashiko on v2 [1], GHCB_HV_FT_APIC_ID_LIST is added
> > unconditionally to GHCB_HV_FT_SUPPORTED and sev_handle_vmgexit() dispat=
ches
> > SVM_VMGEXIT_GET_APIC_IDS to sev_snp_get_apic_ids() for all SEV-SNP gues=
ts
> > without host userspace opting in.
> >=20
> > When an SEV-SNP guest queries hypervisor features via GHCB_MSR_HV_FT_RE=
Q in
> > sev_handle_vmgexit_msr_protocol() or SVM_VMGEXIT_HV_FEATURES in
> > sev_handle_vmgexit(), it will unconditionally observe GHCB_HV_FT_APIC_I=
D_LIST.
> > If a guest uses this feature and is migrated or restored onto a kernel =
without
> > SVM_VMGEXIT_GET_APIC_IDS support, guest execution will fail when invoki=
ng the
> > NAE event.
> >=20
> > Should this new guest-visible feature default to off and be gated behin=
d a
> > capability via KVM_CHECK_EXTENSION and KVM_ENABLE_CAP so userspace can =
manage
> > feature exposure and live migration compatibility?
>=20
> No, this feature is for SEV-SNP guests only, which can not be live migrat=
ed.
> Live migration for SEV-SNP guests will be built on-top of this feature (a=
mong
> others).

True, but they can be live-updated, and in general changing the guest/host =
ABI
without input from userspace makes me more than a bit nervous.  E.g. if the=
 guest
side is buggy, downstream users will have no recourse other than to rollbac=
k the
kernel.

Is there a need for this without KVM_CAP_SNP_DIRECT_VMSA?  I.e. can we tie =
it to
that?
