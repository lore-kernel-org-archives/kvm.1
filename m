Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B8E2010EE
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414184; cv=none; b=IeRkXHWweGNiF/6yaCsdKJEH+IVzujq5JwoJTOVtHMmEOFkNUphHDjmchW13gPeMhlGtYXr7jeGP5fzexxT81P/omtbqOZmZ7QoA2s4Pc6vMBpDvEA+QqJ/IL2gH/Nk9vUo71r/Ql76CONtMQrSfvV/VmuZF3Y0pdhn/IXeyurg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414184; c=relaxed/simple;
	bh=vluXKVHaJ8iBbVy/u4uEr3hEbeCOtuMLEWp0UWdCEL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j5vLaw0lbwRz8LgoX1V3NMMaS8Tq+mjP9tMAXIsbnjAZFLGfJDPN2aCMylgYrspNQ1P7W502FwEhhUQrFsGbAbqqTdpa/68YB/ulXu2Dx4YWa/oWvFxk6zVQlw0hJbDzDfAguvPftM1XxF8BxqxfnQwgqV73uRNdO2plFLmxPTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BGrfpJtd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNWY4uIp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGrfpJtd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNWY4uIp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780414181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPkVMH+az/KJ2b7MtH1kE/gL5yVPKK3Z4FpBdsXjeSk=;
	b=BGrfpJtdYKStaR+1V4EAFBJoFNOFu75zuMNtX7TCVMvAV3f5Ss+gI95UiQ1qxRqn/KCKC4
	w4LJU06jF2m5hiRAs98WPyp+9y04KuW5vik8UR58uqqKZoEI/g4YrJgZhLTYriJBTyKACR
	CbDrXjThqTqKR0UN3hUpSZ9D6EsVCHA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Y9dP4CsGP1aKHryGTQ8H0w-1; Tue, 02 Jun 2026 11:29:40 -0400
X-MC-Unique: Y9dP4CsGP1aKHryGTQ8H0w-1
X-Mimecast-MFC-AGG-ID: Y9dP4CsGP1aKHryGTQ8H0w_1780414179
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49058295985so67115465e9.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780414179; x=1781018979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPkVMH+az/KJ2b7MtH1kE/gL5yVPKK3Z4FpBdsXjeSk=;
        b=KNWY4uIpkLccaGcLZaH5V+6YJ7y7QgSXngx50TjRWRaK2KlL5K8KYSnnPywgediVW+
         K4TfzYdu4QhVGTmFagIipD/91GVlAXVhcFAZPb4Nr7XNd56g0PmCQOxFLRvkI8CMKUVH
         v4J5j3CsxHEuV89PigKAsXkI6kDIpVJPXuQUgwJS6X7Zamb+0RXpAHbKwpgcOj05QL0/
         fsKKG+bOzE1cBs9G4If4qG3DWRtzSUJK5MK3XuJ2YE0GSiP6N0hVA4yfCdyc13PZGKLt
         mifKsEZAbNVmpfZeVMnpU/W2e65nwI6vYOcHnun4hnPfXxlG70d4yVqkllzgpqg9me3Q
         LzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780414179; x=1781018979;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kPkVMH+az/KJ2b7MtH1kE/gL5yVPKK3Z4FpBdsXjeSk=;
        b=rNJm1vid3TU8pA4WW9u+HkJe802mbyBboJP53GQYITl5ylYXOIwspHXfvVLF+fmZ1H
         nLATL4UVabCDavuHbh1g+c81HVeplnLgbRPO0Z3LSvbdUdJHMQzCDOF8nl+hophsDce4
         WHH/5FWDSdkmOUkf9Q+II5xvUZtfcPfR1maNMbgBTN7R0L8rOBoOxHJkl08sO5LukOnF
         Ecwn/+RTJwAO6J54sKVkV8mnTbV4qacFkKBdH7qmmfSwIeCSudtoqDcIZ0i6yBULalsR
         z0woUs1BvuJ5nAmixXsMsQmOf1KmUAHQu8Fqa4jhU3LL0pzpwHPCrkmTa2Nc/Ax2bI3i
         a3aA==
X-Forwarded-Encrypted: i=1; AFNElJ/XQP0NYUuOxDAtYmwvgp3wiZ4qDFaOrlHjtit/FFmXK+PpKLmChpuEWhvEmSXyTD9aiMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsLnYDaj59zC530Kbc9RxcwBd1tht0UDX9sSHE2w6ocLHF5V6S
	AKByDUFtSofs+JSmMYv3Xj8VvRAXmriyXV/FY5HNA2egp2xsfjTZ0G6iEyV390avGan8DB8NlDZ
	rBz4yJUY4j8+ixT6kaAZGamylvXbXBJZSO37CHchimzKzHDtZdsnssA==
X-Gm-Gg: Acq92OE346rGJGSHIcIpEHiwb1XTXzWug0KgZlq3GwQc3/7smUxBl4rqSxN+GTrM9Qh
	Z5KID3wClr4qa97sUc0LC5NtQ4WBHa6WjNcPy4TL+KUPQASAUVM1tc5pKLPcmM4uTR16sbaVxMF
	tvzGWJBYe0Vhxb9/VDGlCIbHrmP4AiVLD2KkU3EMOiF4B+XvvVPIst9bv3Ns1h/mAmKWbW3gMGe
	s9UE/ksXUKXrhg57ef3dFUU5DfhDIrPXjJZmM/sGPqH3qYcVQHsOSzd0eHT+C/Y7NXHSOa+gJ0L
	Vgn+FE5jaJi/lP1Uvsj685qhX/33i59UWL7hBFfihAtuDskp0Jj4T7huhUsyrfVgf4ep7QpDiu+
	wSpS8YxkvmW/WHSYh8TyIqmmQ7WSlxmO82w==
X-Received: by 2002:a05:600c:3e87:b0:490:44eb:c1e7 with SMTP id 5b1f17b1804b1-490b50a5531mr2874245e9.30.1780414179449;
        Tue, 02 Jun 2026 08:29:39 -0700 (PDT)
X-Received: by 2002:a05:600c:3e87:b0:490:44eb:c1e7 with SMTP id 5b1f17b1804b1-490b50a5531mr2873785e9.30.1780414179059;
        Tue, 02 Jun 2026 08:29:39 -0700 (PDT)
Received: from fedora (nat-20.ign.cz. [91.219.240.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e2e8cesm70095795e9.11.2026.06.02.08.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 08:29:38 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: mlevitsk@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Subject: Re: [PATCH 20/28] KVM: nVMX: allow MBEC with EVMCS
In-Reply-To: <9176c891af8dc496f02c1e8cbef53976576ae7e1.camel@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
 <20260505195226.563317-21-pbonzini@redhat.com>
 <9176c891af8dc496f02c1e8cbef53976576ae7e1.camel@redhat.com>
Date: Tue, 02 Jun 2026 17:29:37 +0200
Message-ID: <87fr35j6zi.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

mlevitsk@redhat.com writes:

> On Tue, 2026-05-05 at 21:52 +0200, Paolo Bonzini wrote:
>> From: Jon Kohler <jon@nutanix.com>
>>=20
>> Extend EVMCS1_SUPPORTED_2NDEXEC to allow MBEC and EVMCS to coexist.
>> Presenting both EVMCS and MBEC simultaneously causes KVM to filter out
>> MBEC and not present it as a supported control to the guest, preventing
>> performance gains from MBEC when Windows HVCI is enabled.
>>=20
>> The guest may choose not to use MBEC (e.g., if the admin does not enable
>> Windows HVCI / Memory Integrity), but if they use traditional nested
>> virt (Hyper-V, WSL2, etc.), having EVMCS exposed is important for
>> improving nested guest performance. IOW allowing MBEC and EVMCS to
>> coexist provides maximum optionality to Windows users without
>> overcomplicating VM administration.
>>=20
>> Signed-off-by: Jon Kohler <jon@nutanix.com>
>> Message-ID: <20251223054806.1611168-8-jon@nutanix.com>
>> Tested-by: David Riley <d.riley@proxmox.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> =C2=A0arch/x86/kvm/vmx/hyperv_evmcs.h | 1 +
>> =C2=A01 file changed, 1 insertion(+)
>>=20
>> diff --git a/arch/x86/kvm/vmx/hyperv_evmcs.h b/arch/x86/kvm/vmx/hyperv_e=
vmcs.h
>> index fc7c4e7bd1bf..bc08fe40590e 100644
>> --- a/arch/x86/kvm/vmx/hyperv_evmcs.h
>> +++ b/arch/x86/kvm/vmx/hyperv_evmcs.h
>> @@ -87,6 +87,7 @@
>> =C2=A0 SECONDARY_EXEC_PT_CONCEAL_VMX | \
>> =C2=A0 SECONDARY_EXEC_BUS_LOCK_DETECTION | \
>> =C2=A0 SECONDARY_EXEC_NOTIFY_VM_EXITING | \
>> + SECONDARY_EXEC_MODE_BASED_EPT_EXEC | \
>> =C2=A0 SECONDARY_EXEC_ENCLS_EXITING)
>> =C2=A0
>> =C2=A0#define EVMCS1_SUPPORTED_3RDEXEC (0ULL)
>
> Unrelated to this patch:
>
> I haven't paid much attention to this particular area of KVM, but 'EVMCSv=
1_LEGACY' caught my attention now.
>
> According to the Hypervisor Top Level Function Specificaiton v5.0C and v6=
.0b that I have, there is only one version defined,
> version 1.=C2=A0
> Is there a reason on why we choose to call it "Legacy"?
>

This is the patch:
https://lore.kernel.org/kvm/20220830133737.1539624-8-vkuznets@redhat.com/

which was eventually supposed to be supplimented by something like
https://lore.kernel.org/kvm/20220824030138.3524159-10-seanjc@google.com/

> Also I see:
>
> Enlightened VMCSv1 doesn't support these:
> ....
>  * TSC_MULTIPLIER =3D 0x00002032,
>
> And yet I see it defined:
>
>  EVMCS1_FIELD(TSC_MULTIPLIER, tsc_multiplier,
>  HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2),
>

The problem is that EVMCSv1 spec came with a certain feature set and we
were expecting that it is a closed list and the revision id will go up
if needed. That turned out to not be the case, e.g. see

"21	Indicates support for non-zero value of the 0x00002802 (GuestIa32DebugC=
tl) field in the VMCS."
bit definition for 0x4000000A.EAX

As for TSC_MULTIPLIER, I believe that the field was missing in the spec
initially but then it got added. After some git-blaming I found the
following commit:

commit 96d6955d215e6234bb820fd23756b2a9b77aef0f
Author: Vitaly Kuznetsov <vkuznets@redhat.com>
Date:   Fri Nov 4 15:47:06 2022 +0100

    KVM: nVMX: Invert 'unsupported by eVMCSv1' check

which says:

"""
    From all the controls, SECONDARY_EXEC_TSC_SCALING requires special
    handling as it's actually present in eVMCSv1 definition but is not
    currently supported for Hyper-V-on-KVM, just for KVM-on-Hyper-V. As
    evmcs_supported_ctrls will be used for both scenarios, just add it
    there instead of EVMCS1_SUPPORTED_2NDEXEC.

"""

I have to admit I forgot the gory details on why we don't enable it for
Hyper-V-on-KVM. My guess is that KVM part is simple but we will need a
new enablement method from VMM (KVM_CAP_HYPERV_ENLIGHTENED_VMCS2 or
something) to not break migration.

>
> Anyway I haven't found any restrictions on the execution controls in the =
EVMCS in the Microsoft's spec,=C2=A0
> so it is unlikely that it is not supported.
>
> So:
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>
> Best regards,
> 	Maxim Levitsky
>

--=20
Vitaly

