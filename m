Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B7B3ED3AF
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410751; cv=none; b=IvNDTr1pEh/Mpy3ep9zYrfOknuz8THh636qk4AlMUKpLyhlZmNIqVyCHiR8f+si5SJf6LtJqkUumti+hvp52LRJdv1V6wHHEvRHkVJZBEpe5z5ld9z3Zd6V8wzzqftHx7zh6pZO5b7baxbwcA/LnrwX8IxVTFl3VFn35YfPQMSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410751; c=relaxed/simple;
	bh=46PND5RnHGmUFDZopgvjldaZXhIeN7d1AZchkjXwx/U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d22lgRpcvETJAPXFgFAhPw13WXDTtuwG3t7EiAowZ2jcdiDQq5m5gw/nB7/WCp/5wRLvTq1Wgg+kOvZqxV/TNCb3Ff8+tG3eXcE7AqTgBYsKo1T3IB/t8rs1Wci0bmONj3CBegfO4qc8z7RgJNIiKqT2bGzPaniUjng7qeQqWZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MUhM7vLg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ltsTqIe4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUhM7vLg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ltsTqIe4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oobf5YN5+qtUZI/HwZRRNiHwHVF1PjmeKxn5zqQ6qDQ=;
	b=MUhM7vLg4c4H61dzbTCg4KtNPlFNfvgpU5KoqpJED/1u/NNs+3CzdCcqBrM33Og0gtj/7l
	06rTqEkq77oF7WEydmiXSFbpZhq0ndmzLFDKUfPvx9AEMFZXiHc1dk6yAOpGYbRaRMzOmT
	60k1sSd3ZTvx+qtnlmrmi62wJPnw9tk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-tvRrVXNcMs2cwVXR4kdz8Q-1; Tue, 02 Jun 2026 10:32:25 -0400
X-MC-Unique: tvRrVXNcMs2cwVXR4kdz8Q-1
X-Mimecast-MFC-AGG-ID: tvRrVXNcMs2cwVXR4kdz8Q_1780410745
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51757a0de42so50099041cf.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410745; x=1781015545; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Oobf5YN5+qtUZI/HwZRRNiHwHVF1PjmeKxn5zqQ6qDQ=;
        b=ltsTqIe4B25jrBP0m2vz5n2hxuVoI1raPAzZukwqyM/WPgT2GdvL2mgey40oRAMHCN
         3Dv+vWXvx8aNbfAExX/XaWPm9NhodZTaPbw5HBLVdZuPXapDmPpp1ED0Y3WNXKLP30v3
         eVeMcWYPWz83zIVdJU5Sq3OkJvCzcAP8LDuUBc5tkmf4OKy5h2j9TtMrZvnYjfSISKpH
         9KXhow9cxI+dsHFV3VL0EoyTBk85jonk0EwnDmeOPPzBb0u+9AT59qpwjo5acWznDe6F
         3vhZc6LsXUQdIF7l4epipJ+FTp8gEVk/3kJ11MBm2R8jGVdxsPVUoXvObEY/XxXrAg9Q
         VJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410745; x=1781015545;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oobf5YN5+qtUZI/HwZRRNiHwHVF1PjmeKxn5zqQ6qDQ=;
        b=OJgqiEIHUzval1NvYXVw8JlPfjiQWW8ApLUrUGAwvNVX0iw+d0GsGIiBOCYh3NLFUZ
         r1snxHnmymI3Dj8Ep1KpTJdELdtJg1m1+sqdbidaB+ylTh2nApT1DZukfeBe2TMnNxXv
         xYyBz+X8jmfwRiKNAv0oscPNY2J+NVv3GjjHkVIEQ9Gcn410CGd76cjymEKfCPpXL4ug
         SWosPa4nDccNb2dkWLZsEVTStL+MAVu0yTy8I3L3F6bFE67dDj3zNWkwZKexLNgKBhet
         TFVn2maAn/ToHCFtJCqJk4g73eI6INOfdkTlLNJQAvumnCVoKgZHthPtv5TjjAxzKQ/v
         6P5g==
X-Forwarded-Encrypted: i=1; AFNElJ8Zh4cchK0tUPQfpazciUHE8uvAj2XEfxQaNkNvDnx1ybppfHKcCpN+ef1JluCOrdH1KKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwg3lhEAtNQGBPeSHxS6d4xyO/SrDkXkVacPt//soLwA+9VeqF
	9r+iHbW/MI92rLRlnpoeOvBXYD55BjMhFrvhd/wnyq5VSDpxkL44rEU+lghubXACLCOtX37tqw/
	jiiWmr46GvgoExgXK5edWhYZECScio8VMEQSWTO6nNEa7ZH/rFrbA4g==
X-Gm-Gg: Acq92OHlhR65c0AfaDgOngAHKVOmho/8UNMJUI4pPpYt33cVKiU2iTTyh1F26G1j1G1
	UKXe74BuOdC7gq2p4nmt9w6FUiIxZ5VzQfuieusXZRyH3K5L66QFTuMYJuBF25U1rhPanEs7v3W
	aFhS8RsNEf7Ma2EsGAPLkIQahjHYRNeebKr9BxFW1UGdHiplNLfajKmb+vzRz1yGzgXAXv4hqre
	WBqT7m/1H9tNVUYPp8QZCI+kyBQZsOY3Nu84nt3Ek8ucoXISyXP83J8G+O03fvQAjiIZoArHEI3
	phv9t9MDo1/IgG76bjlASefoCu9jeonj8SbN4+TF4vNC9G0b2pM6nPMYU8QiP9J8NrS7KF2dOhE
	WbuHfNYT69h3BYDnlRk/NTGZIx5H5dReGEuzhI54=
X-Received: by 2002:a05:622a:17cd:b0:50f:b904:454 with SMTP id d75a77b69052e-5173a6e3fa2mr230751441cf.11.1780410745170;
        Tue, 02 Jun 2026 07:32:25 -0700 (PDT)
X-Received: by 2002:a05:622a:17cd:b0:50f:b904:454 with SMTP id d75a77b69052e-5173a6e3fa2mr230751101cf.11.1780410744704;
        Tue, 02 Jun 2026 07:32:24 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c07e91sm198151cf.4.2026.06.02.07.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:32:23 -0700 (PDT)
Message-ID: <3d1bb83f327a6bf99aa6a1c29a8f41320b14152f.camel@redhat.com>
Subject: Re: [PATCH 28/28] KVM: nSVM: enable GMET for guests
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:32:22 -0400
In-Reply-To: <20260505195226.563317-29-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-29-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-05 at 21:52 +0200, Paolo Bonzini wrote:
> All that needs to be done is moving the GMET bit from vmcb12 to vmcb02.
> The only new thing is that __nested_copy_vmcb_control_to_cache now
> ensures that ignored-if-unavailable bits are zero in svm->nested.ctl.
>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Hi!

Tiny nitpick: Should the patch title be 'KVM: nSVM: enable GMET for nested =
guests'?
(I know that there is nSVM in the title, but still I was a bit confused abo=
ut it, at first)


> ---
> =C2=A0arch/x86/kvm/svm/nested.c | 6 +++++-
> =C2=A0arch/x86/kvm/svm/svm.c=C2=A0=C2=A0=C2=A0 | 3 +++
> =C2=A02 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 74a1df1cb84f..3d1fd1776e19 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -489,11 +489,14 @@ void __nested_copy_vmcb_control_to_cache(struct kvm=
_vcpu *vcpu,
> =C2=A0 nested_svm_sanitize_intercept(vcpu, to, SKINIT);
> =C2=A0 nested_svm_sanitize_intercept(vcpu, to, RDPRU);
> =C2=A0
> - /* Always clear SVM_MISC_ENABLE_NP if the guest cannot use NPTs */
> + /* Always clear misc_ctl bits that the guest cannot use */
> =C2=A0 to->misc_ctl =3D from->misc_ctl;
> =C2=A0 if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NPT))
> =C2=A0 to->misc_ctl &=3D ~SVM_MISC_ENABLE_NP;
> =C2=A0
> + if (!gmet_enabled || !guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
> + to->misc_ctl &=3D ~SVM_MISC_ENABLE_GMET;
> +
> =C2=A0 to->iopm_base_pa=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D fro=
m->iopm_base_pa & PAGE_MASK;
> =C2=A0 to->msrpm_base_pa=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D from->ms=
rpm_base_pa & PAGE_MASK;
> =C2=A0 to->tsc_offset=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D from->tsc_offset;
> @@ -898,6 +901,7 @@ static void nested_vmcb02_prepare_control(struct vcpu=
_svm *svm)
> =C2=A0 /* Use vmcb01 MMU and format if guest does not use nNPT */
> =C2=A0 if (nested_npt_enabled(svm)) {
> =C2=A0 vmcb02->control.misc_ctl &=3D ~SVM_MISC_ENABLE_GMET;
> + vmcb02->control.misc_ctl |=3D (svm->nested.ctl.misc_ctl & SVM_MISC_ENAB=
LE_GMET);
> =C2=A0
> =C2=A0 nested_svm_init_mmu_context(vcpu);
> =C2=A0 }
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index fd79874c5f4b..a82471a6d3ea 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5504,6 +5504,9 @@ static __init void svm_set_cpu_caps(void)
> =C2=A0 if (boot_cpu_has(X86_FEATURE_PFTHRESHOLD))
> =C2=A0 kvm_cpu_cap_set(X86_FEATURE_PFTHRESHOLD);
> =C2=A0
> + if (gmet_enabled)
> + kvm_cpu_cap_set(X86_FEATURE_GMET);
> +
> =C2=A0 if (vgif)
> =C2=A0 kvm_cpu_cap_set(X86_FEATURE_VGIF);
> =C2=A0

Looks good otherwise.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

