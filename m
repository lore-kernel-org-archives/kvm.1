Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC9835AC0C
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780409997; cv=none; b=l6B+GxghR5wCswdGrBPIAchWByxwJ4g71DQPlv8aFax2MbiptatIXmlZBXkSAr3gpzu9FsQOPLPk8bbwe0VkTWmgNWqCQxeZC1tUOAgbrH6zruInPywLwJ6vCdxRmODzhKeTaaM8IqPLsX11SQfjSw1r5qodaOA203d02ULyeLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780409997; c=relaxed/simple;
	bh=IigbIAsNGIOymUp1XVgxeqtCZiRTVQeLrkoo2bwIPRc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m5Nm2rpzFdI/YSIgAQgd8/nwOSM+ztcyJX+DyAnA7Rctg1vHWEWZeCi0764jtCSpR7c31FGpDwEX1NCHIondzeUqR9oKBDiSZD0m5Qk8Xe5JkpZOKwgEODbusQmuIirUSszL5cY2+rMqjpW6i0zx7QG7NstbIjWCzj4m2U2pJ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VCDg3+JV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lOEfSnVb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCDg3+JV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lOEfSnVb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780409995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bypqkl0d6hEGmwRUbgbrPYXyMqhraUbpftLZEMOjdB4=;
	b=VCDg3+JV1Ao+Suz0Q9oqHTNUrIRfYZtNhA1gtuxt2n1aMQY+Yh78Z5zmD6qHAPnAjqWEun
	i8++/sr70WPkNKsKee4lTxdjejH7Jx5wHJsXVReWM4VDbFadyuia3tUnMtKBJQDp8tVEMd
	zO9qTadaS/44+rjT8fbB0gokf6MlBqk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-KUqgqO3bMRiXygAkQN9GMw-1; Tue, 02 Jun 2026 10:19:53 -0400
X-MC-Unique: KUqgqO3bMRiXygAkQN9GMw-1
X-Mimecast-MFC-AGG-ID: KUqgqO3bMRiXygAkQN9GMw_1780409993
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8cce42a4e75so65975866d6.3
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780409993; x=1781014793; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bypqkl0d6hEGmwRUbgbrPYXyMqhraUbpftLZEMOjdB4=;
        b=lOEfSnVboSehKDm5s4cObNH0Q/FlgNVRCGEM+m5k0XRTWmbSH/V0Z8cLoh9IrKOmrY
         lGsvqt7qXZL0eR+LF0obpRWoROBZt4wFoie9oDqPE3Y6YzhfE0tnLq1brBv0NEFnFXl5
         VoKNTYNpKNxcDJ1iJ504tLtG+wLenDf7nDB9Iim9UtLGTZZHsFeifESal6tE1wKzAGnF
         DOMQwnkE1ANHprIalsAdi86fQ4CRtU5Na1tT7YSLam12fN4fmBglg0BQum0JsEVhkLBP
         2uda6sbs+0IRFqySR9RmiE8cbn8L3yVsWAoArTHhr41YfQtysNYTDzoqCqwRLnuCJOW5
         wklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780409993; x=1781014793;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bypqkl0d6hEGmwRUbgbrPYXyMqhraUbpftLZEMOjdB4=;
        b=nQ52ulewWKUPDL+TdWNeRCvTEzggjhlUDPOTNTKFoVNQwx9omvjT2ujCCm6LftpvBy
         kest+D4So401cyJYv/ap6+vSuQH3Z650ouOD7eImLtKxAseGdbn6CrswLXrl/UAbwPRV
         bQ3uPZTyqtVjSCJgTTzqZUKV3uZbX9kjm4YTt9AffbBiujl+CdXIKK6yK65n6YS2M0w8
         aQCFVTsTwHn7ooG7qeAbGVPW3BQ5leHL1sP4Tc/2GW8pnsX7dDGUh1g8doR79T/enyUB
         y6i4g3J7Add/sJibK134ZPT1cZH21fLOLEc8TaxJKM5xyjl8c+0p7jof/AgDeOqYLggc
         HfZw==
X-Forwarded-Encrypted: i=1; AFNElJ9A2RP4CUM/CUuIpTzBfqxpK+hD8wrLys6ev1IJnics4jfYUgL0nFOIODo07r9pvDp9ZXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4+Uen6uS0fO53X25nCLCufQ8dx/DblkJXj0NCjIE34kLe4o83
	rdFt8YWIILDIUv+ISwC+AC7eFzJ+7tj0lpuTNyYHbful8SY4UsyY3LhbnH/NQE6B8WogWyYOHJ7
	hjnBXy1CUcFcKwFiKIiW8N+I4X6Vr/XSd3GnouPK4qCOwhNtkb0wggg==
X-Gm-Gg: Acq92OFTcCd4AwaEnQVdu9T4AzFRQRgLIspu3kOTsRLIhg0ab8tXTZztRQGc/KZF+hK
	P6uy8tIbvLbrUFBkBwD49kgowbUjJ70nFeL7wVi/CzWtnpLMVvKbkX6DrPDbg+5vIuXM/bGgRVI
	Qye/mmW+pYJhDJmC40OzEE/NXquuPhe9yxLFG3mGOaN+KvDzVJvOWL4MMysRbYYvqzwcrjt4gRD
	Sw6IN5ZXUX+cJNW7D8yP9sygGvaKXL1EcUDT6EVUwopmzL7/tt80o9Ml60/fCo3cDlwvpJanyLK
	ZBvufoEeOTwSU3Db0WmjuoB/8OBaXcp6Z1PjoKg3K4kpmeO6q/+jktfSzOS7v9r1TZFHkzEP6xG
	E1lY7rKl8IuIhcXWPfAYv7LR6tJLAUT4qRS++ST4=
X-Received: by 2002:a05:6214:5290:b0:8cc:ce88:9eda with SMTP id 6a1803df08f44-8ccefd4421dmr250419616d6.15.1780409992878;
        Tue, 02 Jun 2026 07:19:52 -0700 (PDT)
X-Received: by 2002:a05:6214:5290:b0:8cc:ce88:9eda with SMTP id 6a1803df08f44-8ccefd4421dmr250419026d6.15.1780409992211;
        Tue, 02 Jun 2026 07:19:52 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cec1d7ebd4sm19076986d6.23.2026.06.02.07.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:19:51 -0700 (PDT)
Message-ID: <e592aba166c1571cdc9019e031c4bdde42bf95b5.camel@redhat.com>
Subject: Re: [PATCH 01/28] KVM: TDX/VMX: rework
 EPT_VIOLATION_EXEC_FOR_RING3_LIN into PROT_MASK
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com, Sean Christopherson
 <seanjc@google.com>
Date: Tue, 02 Jun 2026 10:19:50 -0400
In-Reply-To: <20260505195226.563317-2-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-2-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-05 at 21:51 +0200, Paolo Bonzini wrote:
> From: Jon Kohler <jon@nutanix.com>
>=20
> EPT exit qualification bit 6 is used when mode-based execute control
> is enabled, and reflects user executable addresses. Rework name to
> reflect the intention and add to EPT_VIOLATION_PROT_MASK, which allows
> simplifying the return evaluation in
> tdx_is_sept_violation_unexpected_pending a pinch.
>=20
> Rework handling in __vmx_handle_ept_violation to unconditionally clear
> EPT_VIOLATION_PROT_USER_EXEC until MBEC is implemented, as suggested by
> Sean [1].
>=20
> Note: Intel SDM Table 29-7 defines bit 6 as:
> =C2=A0 If the "mode-based execute control" VM-execution control is 0, the
> =C2=A0 value of this bit is undefined. If that control is 1, this bit is =
the
> =C2=A0 logical-AND of bit 10 in the EPT paging-structure entries used to
> =C2=A0 translate the guest-physical address of the access causing the EPT
> =C2=A0 violation. In this case, it indicates whether the guest-physical
> =C2=A0 address was executable for user-mode linear addresses.
>=20
> [1] https://lore.kernel.org/all/aCJDzU1p_SFNRIJd@google.com/
>=20
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Message-ID: <20251223054806.1611168-2-jon@nutanix.com>
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/include/asm/vmx.h | 5 +++--
> =C2=A0arch/x86/kvm/vmx/common.h=C2=A0 | 9 +++++++--
> =C2=A0arch/x86/kvm/vmx/tdx.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A03 files changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index 37080382df54..b2291a766e3f 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -608,10 +608,11 @@ enum vm_entry_failure_code {
> =C2=A0#define EPT_VIOLATION_PROT_READ BIT(3)
> =C2=A0#define EPT_VIOLATION_PROT_WRITE BIT(4)
> =C2=A0#define EPT_VIOLATION_PROT_EXEC BIT(5)
> -#define EPT_VIOLATION_EXEC_FOR_RING3_LIN BIT(6)
> +#define EPT_VIOLATION_PROT_USER_EXEC BIT(6)
> =C2=A0#define EPT_VIOLATION_PROT_MASK (EPT_VIOLATION_PROT_READ=C2=A0 | \
> =C2=A0 EPT_VIOLATION_PROT_WRITE | \
> - EPT_VIOLATION_PROT_EXEC)
> + EPT_VIOLATION_PROT_EXEC=C2=A0 | \
> + EPT_VIOLATION_PROT_USER_EXEC)
> =C2=A0#define EPT_VIOLATION_GVA_IS_VALID BIT(7)
> =C2=A0#define EPT_VIOLATION_GVA_TRANSLATED BIT(8)
> =C2=A0
> diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
> index 412d0829d7a2..adf925500b9e 100644
> --- a/arch/x86/kvm/vmx/common.h
> +++ b/arch/x86/kvm/vmx/common.h
> @@ -94,8 +94,13 @@ static inline int __vmx_handle_ept_violation(struct kv=
m_vcpu *vcpu, gpa_t gpa,
> =C2=A0 /* Is it a fetch fault? */
> =C2=A0 error_code |=3D (exit_qualification & EPT_VIOLATION_ACC_INSTR)
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? PFERR_FETCH_MASK : 0;
> - /* ept page table entry is present? */
> - error_code |=3D (exit_qualification & EPT_VIOLATION_PROT_MASK)
> + /*
> + * ept page table entry is present?
> + * note: unconditionally clear USER_EXEC until mode-based
> + * execute control is implemented
> + */
> + error_code |=3D (exit_qualification &
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (EPT_VIOLATION_PROT_MASK & ~EPT_VI=
OLATION_PROT_USER_EXEC))
> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ? PFERR_PRESENT_MASK : 0;
> =C2=A0
> =C2=A0 if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID)
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 1e47c194af53..89f9fe30435d 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1845,7 +1845,7 @@ static inline bool tdx_is_sept_violation_unexpected=
_pending(struct kvm_vcpu *vcp
> =C2=A0 if (eeq_type !=3D TDX_EXT_EXIT_QUAL_TYPE_PENDING_EPT_VIOLATION)
> =C2=A0 return false;
> =C2=A0
> - return !(eq & EPT_VIOLATION_PROT_MASK) && !(eq & EPT_VIOLATION_EXEC_FOR=
_RING3_LIN);
> + return !(eq & EPT_VIOLATION_PROT_MASK);
> =C2=A0}
> =C2=A0
> =C2=A0static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)

Looks OK to me,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky

