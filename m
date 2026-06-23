Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD665395AC0
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245884; cv=none; b=Ake28V4Q64hXN4GrVrSsEE+W0W0xlz3uWSfGibU96+vTgKbCx94d/tEejvBWa66ZlIHOurKvcK8GobozGxfrRg6yLXbXO8U04/kAcsT6U3kBguSEX+twCdjnEYokY47DYz/MpkP68RJlgBraL5xLvvs3OAD6Fo3/WYv/ypBBU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245884; c=relaxed/simple;
	bh=pfBbZTVSVd9kFMPR307jWCQr5DUyZeOASXb+3/YzapQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BmulqlJu034F30pFIhlaLs5mwEU+uZ1Fzt1zCXAL8IPaGTwFEbDayQWxLtH6qO+MkTuDliyYtyJCXzvbpQfBcPVcgBug+RlERT0Vt2miYvI3YGQQ8aSN5cywmVNU5kvOoOkklACoywIpD8X0qBPcr2pSwy3rpJaetPYMjI6vIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gi1OEUgm; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gi1OEUgm"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8426ed9f24dso935796b3a.1
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 13:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782245882; x=1782850682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4it6V/RsWdXiHrdeR0Q4Fr1bmFRjk/MLCAbcFKI4NI=;
        b=Gi1OEUgmss1sLwDT0qmEL2Sl4lEoOHjfjiJK+dETmdhb0mGXMiUYUbEEjsCqoHwUl2
         PK9d12qDwL9uS3uciolcP/d6dHVc6y/lqIXEvOQ50d3HhxqYrZekGz5+JeRfYbWF5gKr
         mxfwGc7f7LSOg7aX5yUAFWAwUzKZxgf1cGYEFeIFHEBhF9A6XdnqXVL58duIIgNoJjT8
         VLyZfgInlUb6nrmsESzIvKaYUaq7ReWb6WYPE5edRUO6leA8Yn9Qt+UV1Cd5U01Q00Zj
         MlwmJb/ExwdiSE7vKDpBejXP+VoVZaWJqjlpm1c8fkjtTsUIc4Aju/pUDAprxFT5Majr
         xXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782245882; x=1782850682;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j4it6V/RsWdXiHrdeR0Q4Fr1bmFRjk/MLCAbcFKI4NI=;
        b=T5oGj0NdQHrTqH9xPTb9OOqg3sQsEhtl0i4mUuLYGssDm/3NTsd0ZyZjFgE1fz22dk
         hOfqj0fGr218Z1y1ccMk6KNfUwpudGEX6duKQEwZBkFvA2KYXf0llmyQb9tUax9g6k4b
         eFexDySXXNiphtt/aBPNeJnEqi2aZUaIeyu1YSlsqdFKtpNL4TZzemre9uNoIEzT9xbj
         7eBL5wR1xmfez+mh8H+N09W6y0t34peVEwV5GV7V48JMoHw7jozz0z/UrVDjZsmSQdhQ
         XZzrD4+Kl1UrPjp8wrHNUJu0yo4Lt9mkju2DfWU2ksE/UeR22W3GznDSxJ5AEYDeaBl/
         i90w==
X-Forwarded-Encrypted: i=1; AFNElJ9KMUUx8/nv6A47IMkLtyQGd3q20iR4QrlN7EJNkyXptDKk6YACaBgHCHovlUD+UqhIdAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsLJcHLUZb0YJrE6tRMTT1mJg0PNzWQCImf6EqJG/A8kdc26M9
	6O+imvVZNXFNAcKeLiP7MwcdoDJYJEG1+eBtdxUZQyKCYdOxdw6Rz6QJx2uSnexHPwGO9xgC62s
	s7v5YtQ==
X-Received: from pfjd3.prod.google.com ([2002:a05:6a00:2443:b0:842:33b9:bdf8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21cd:b0:835:447b:a2ac
 with SMTP id d2e1a72fcca58-84591b23f6emr4790574b3a.5.1782245881715; Tue, 23
 Jun 2026 13:18:01 -0700 (PDT)
Date: Tue, 23 Jun 2026 13:18:01 -0700
In-Reply-To: <20260611123528.572255-2-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611123528.572255-1-joro@8bytes.org> <20260611123528.572255-2-joro@8bytes.org>
Message-ID: <ajrp-Tv7t4U-IS7y@google.com>
Subject: Re: [PATCH 1/4] kvm: svm: Streamline VMSA setting for VCPUs
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coconut-svsm@lists.linux.dev, 
	Joerg Roedel <joerg.roedel@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026, J=C3=B6rg R=C3=B6del wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
>=20
> Streamline the VMSA setting state of vcpus, where a VMSA can be either
> KVM-allocated or guest-provided. This consolidates the various
> tracking state around VMSAs.

This needs to be split up into distinct logic changes.  There are renames, =
there
are tracking changes, there is code movement, and who knows what else, all =
bundled
together.  And the changelog is little more than "consolidate stuff".

>=20
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c | 301 ++++++++++++++++++++++++++++-------------
>  arch/x86/kvm/svm/svm.h |  31 ++++-
>  2 files changed, 237 insertions(+), 95 deletions(-)

+180 lines of code doesn't scream "streamline" to me.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 6c6a6d663e29..9b1280222e20 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -147,6 +147,9 @@ static bool sev_snp_guest(struct kvm *kvm)
>  }
> =20
>  static int snp_decommission_context(struct kvm *kvm);
> +static int kvm_rmp_make_shared(struct kvm *kvm, u64 pfn, enum pg_level l=
evel);
> +static void sev_flush_encrypted_page(struct kvm_vcpu *vcpu, void *va);
> +static int snp_page_reclaim(struct kvm *kvm, u64 pfn);
> =20
>  struct enc_region {
>  	struct list_head list;
> @@ -156,6 +159,173 @@ struct enc_region {
>  	unsigned long size;
>  };
> =20
> +static void *sev_es_vmsa_ref(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +	void *vmsa =3D NULL;
> +
> +	if (svm->sev_es.vmsa.vmsa_state =3D=3D VMSA_SHARED) {

Unnecessary curly braces.

> +		vmsa =3D page_address(svm->sev_es.vmsa.vmsa_page);
> +	}
> +
> +	return vmsa;
> +}

...

> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 5137416be593..3d4799f09b23 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -240,9 +240,29 @@ struct svm_nested_state {
>  	bool force_msr_bitmap_recalc;
>  };
> =20
> +enum vmsa_state {
> +	/* No VMSA set */
> +	VMSA_NONE,
> +	/* VMSA allocated by KVM - Shared in RMP (if applicable) */
> +	VMSA_SHARED,
> +	/* VMSA allocated by KVM - Guest-private in RMP (SEV-SNP only) */
> +	VMSA_PRIVATE,
> +	/* Guest-owned VMSA */
> +	VMSA_GUEST,
> +};

I am strongly against this tracking.  AFAICT, every case is completely redu=
ndant
with other information that *must* be tracked.=20
