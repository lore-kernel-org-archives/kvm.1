Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE7D40B6FB
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410456; cv=none; b=DuqkSosjVKISfnBj2U3zNGls4OzPY41ohS7at/zlbeWe+Q1/1C7LXnXVpgw6KdywVRu1pYRTrxpIT8v52ule/3JXSQO+BspujU0mlJCranzyHVKqhM5jWbcShSoWQjsbjipyeqQNue+WsonguPTyFf2IJ4sjbOp6wichtE1JIs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410456; c=relaxed/simple;
	bh=35IMlH4OzBqYLuw8iEp9io5JfWoCGDHcQ7v9cyibe0Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JsTUgPm+uK8IgEccHoShVjAps21laim6sjnk8c6TCSKBobPw5J1AAspVhY0ND1nTgBZW/ZZzJ22gj2z+9iCvIO+ASKWc8jdnaT0UZ5TU8PJgjWrqgCs5OCO9kWGrTtqJ/0ZhStpRiNfoortSz9btJCFs+faRv5Bis3NXdPRVB98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hScIXXXH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qc+g4pS0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hScIXXXH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qc+g4pS0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AjO1aJ0XV4DwgUuOwUUhINE4bMb6M06WtkPvEZxflRc=;
	b=hScIXXXHN1qlRvq0oZtkMmBshwxAhs2OMkxzkd77hvyjjroFWRB7d09qwj+Zicw2/R3hwO
	AAJRncsjOiMynSB/7k9orliyYb5q1gYFVEuJjoFo1UXfU2a6BvoydZElyrflxK8R1HIlAD
	06p47pvkZge8UZKT0QIdPPQva19pDKI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-g6yPwzfdNLm1RZlgSN8Qxw-1; Tue, 02 Jun 2026 10:27:30 -0400
X-MC-Unique: g6yPwzfdNLm1RZlgSN8Qxw-1
X-Mimecast-MFC-AGG-ID: g6yPwzfdNLm1RZlgSN8Qxw_1780410450
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ce9df49c6bso37078606d6.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410450; x=1781015250; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AjO1aJ0XV4DwgUuOwUUhINE4bMb6M06WtkPvEZxflRc=;
        b=Qc+g4pS0mEU0f9IixvrcABW29qrXqoQKlF5d8WQtqwCruIUNfT6VoxNHOvWy1t+6wu
         05pOJM2Rny7OGcq+tRPIyL23GVFVj8iC9BJXirI5cYZDs/eeAaciANhSbrLxIdvwpHh4
         EQwfMEjKuKhyRgAknpb8z6Hs/wO7iO3/9P1Evm6KcHZrmSm4ZvV9ieyb0/fItplJxF1o
         BCk/XsjFxEaBZLFw+hivPPY9KKQaBeI9ytNrrmNFKZhn0sUCh7fF3xh03GP7pwgycrqq
         fWyPO50zy0KswIzWvfi4pQWVBIYaoKbq9rdI0q7c9ZjX9KtBbOhOkVIdWM1AotKgk9PX
         7pJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410450; x=1781015250;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjO1aJ0XV4DwgUuOwUUhINE4bMb6M06WtkPvEZxflRc=;
        b=Kl6SazNzOB8tl0zzqYMx+Lp9tJo61cn7L0S5GdRhyc4XxICxkC0ZcXSFHwlzf+yC7j
         kA9j0jkwAA3Kg//fwC4yvImOvzIlMZV6CSXQunh6bH8ssvWFqodpBjYsbfxrRpSb7G4Q
         P3IrLisnA0JuXDfawsdecT+sHY2LO+gh7GMQ//o1fVd+WBGvZs5fj6136h+Def/i4kRk
         8k5se/adge5kplApMRJQ44qyz1EEjjhYs1IQrmVNiHIZVCLuvZfMrcMhgbjEuj4rJ9ip
         6tx/l5+Z+9jB9YitSnuxLZmxV6nlUMcubBPkqbCKVVVfuKUoOgoYEpo3ctstAtmfUeKc
         270Q==
X-Forwarded-Encrypted: i=1; AFNElJ9RUYjsfbFy1XBxWUtjBcfgRMkptR3ArX4JO0lcf44iGoztTSWqdG4S69TsBmiR1l+FT3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK8fZ9FNnSRLKYI+4P5cTjsUyuvifQtY7MXk2D0AC7i3sga/75
	coeN+meD8QzHjh96Id5M8meUeyCTcFpNfapJDTUiuB9VMg0b0pMlAP0niofGRl0x7/6cL34VDf/
	4gSp+hMq5IJ0wSSWYBiRoW4SG0OUGwCJcEeOlT8GD8KVlVEtGfZ+gzQ==
X-Gm-Gg: Acq92OEtv1ZTunSxwSCy/IWn75ltbQXW4a8cNIDZ64vDEGt3N7Jgi2qLzx5q4pFI6PI
	h5PiFCT5HNx+jLmY7iA0TSPjmOg8VKlm/ZPi2adkiRznFY6lv1arpufDyxguOlbSkd1Vgzu2s/F
	cukOSM5d9z+TB5oLwoldWHAsQObu23RXAiWJsf8cAdPvPBxbWiGK02cXzqvhZq+dxQ24PNiqIjJ
	TH1veX4Q5DzII9R5rdN/AhUOQIKWRqlF5zZFSdq8b7/78gftne3J0EgwaTjud7oQ0Lx14zCR+W5
	o6HOFcduRNYFgRYn0U/zlCoQ1QzmgmHO+fbDbL6nULIUqdTdMjLpmn+JfhuHS1zPXqHIAWzI9n3
	j4364ldoEAZKgUywX8eZ1Z5FlRDEx9U/0Ys8noEA=
X-Received: by 2002:a05:6214:8082:b0:8cc:f7b7:bf8c with SMTP id 6a1803df08f44-8ccf7b7c3e8mr241014086d6.5.1780410449618;
        Tue, 02 Jun 2026 07:27:29 -0700 (PDT)
X-Received: by 2002:a05:6214:8082:b0:8cc:f7b7:bf8c with SMTP id 6a1803df08f44-8ccf7b7c3e8mr241013506d6.5.1780410449045;
        Tue, 02 Jun 2026 07:27:29 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea1cadd2sm123187286d6.24.2026.06.02.07.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:27:28 -0700 (PDT)
Message-ID: <6cdfabf53b2faeb1a22b802feb66a0e3b882ebfc.camel@redhat.com>
Subject: Re: [PATCH 17/28] KVM: nVMX: pass PFERR_USER_MASK to MMU on EPT
 violations
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:27:27 -0400
In-Reply-To: <20260505195226.563317-18-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-18-pbonzini@redhat.com>
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
> For EPT, PFERR_USER_MASK refers not to the CPL of the guest,
> but to the AND of the U bits encountered while walking guest
> page tables; this is consistent with how MBEC differentiates
> between XS and XU.=C2=A0 This is available through the
> "advanced vmexit information for EPT violations" feature.
>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/kvm/vmx/common.h | 12 +++++++++---
> =C2=A0arch/x86/kvm/vmx/vmx.c=C2=A0=C2=A0=C2=A0 | 10 ++++++++++
> =C2=A02 files changed, 19 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
> index 40fa72f31fc7..08005676702c 100644
> --- a/arch/x86/kvm/vmx/common.h
> +++ b/arch/x86/kvm/vmx/common.h
> @@ -100,9 +100,15 @@ static inline int __vmx_handle_ept_violation(struct =
kvm_vcpu *vcpu, gpa_t gpa,
> =C2=A0 error_code |=3D (exit_qualification & EPT_VIOLATION_PROT_USER_EXEC=
)
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? PFERR_PRESENT_MASK : 0;
> =C2=A0
> - if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID)
> - error_code |=3D (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) ?
> - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAG=
E_MASK;
> + if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID) {
> + if (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) {
> + error_code |=3D PFERR_GUEST_FINAL_MASK;
> + if (exit_qualification & EPT_VIOLATION_GVA_USER)
> + error_code |=3D PFERR_USER_MASK;
> + } else {
> + error_code |=3D PFERR_GUEST_PAGE_MASK;
> + }
> + }

Minor nitpick:
Technically this code should check for VMX_EPT_ADVANCED_VMEXIT_INFO_BIT.
Otherwise we might pass (in theory) the PFERR_USER_MASK when it's not there=
.

Yes, in practice, undefined bits are zero, and on top of that, as long as M=
BEC is not supported, MMU core=C2=A0
should just ignore the PFERR_USER_MASK, but still even if this is for docum=
entation purposes,
it might be worth it to check it here.
What do you think?

> =C2=A0
> =C2=A0 if (vt_is_tdx_private_gpa(vcpu->kvm, gpa))
> =C2=A0 error_code |=3D PFERR_PRIVATE_ACCESS;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f1d616f928a1..9d5cd358ccc5 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2790,6 +2790,16 @@ static int setup_vmcs_config(struct vmcs_config *v=
mcs_conf,
> =C2=A0 vmx_cap->vpid =3D 0;
> =C2=A0 }
> =C2=A0
> + /*
> + * Virtualizing MBEC requires advanced vmexit information in order to
> + * distinguish supervisor and user accesses.=C2=A0 For simplicity and cl=
arity
> + * disable MBEC entirely if advanced vmexit information is not available=
,

This makes sense, however it feels to me a bit out of place in this patch,
it seems better to belong to one of the former patches.

When thinking about this, and last two patches, I started to think that may=
be
it is worth merging:

  'KVM: VMX: enable use of MBEC',=C2=A0
  'KVM: nVMX: pass advanced EPT violation vmexit info to guest'
  'KVM: nVMX: pass PFERR_USER_MASK to MMU on EPT violations'

into one patch 'KVM: VMX: enable use of MBEC', except the code that passes =
advanced=20
EPT violation to the nested guest (the 4nd hunk of the second patch).

And then turn this hunk to a separate patch which can still be named
as the second patch.

This way it will be IMHO clearer when we honour the 'enable_mbec', and in t=
heory
there will not be a two patch window in which mbec could be enabled with un=
supported
configuration.

Finally (assuming that what I am thinking is correct, I haven't verified it=
),
assuming that 'EPT advanced qualification' was specially added for MBEC,
we can add a comment stating that it is unlikely that there are CPUs
(outside of some weird nested configurations), which support either but not=
 both features.


> + * this way mbec=3D1 in the kvm_intel module parameters implies availabi=
lity
> + * to nested guests as well.


Best regards,
	Maxim Levitsky



> + */
> + if (!(vmx_cap->ept & VMX_EPT_ADVANCED_VMEXIT_INFO_BIT))
> + _cpu_based_2nd_exec_control &=3D ~SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
> +
> =C2=A0 if (!cpu_has_sgx())
> =C2=A0 _cpu_based_2nd_exec_control &=3D ~SECONDARY_EXEC_ENCLS_EXITING;
> =C2=A0

