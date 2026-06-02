Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE73F6614
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410418; cv=none; b=IvO2IKEBshmwfaGjgd4bC/46imccStXtEtfBRJroQoxhA2jNMCosV8DOyeXYRJZDPd6sE4HLl5OkPRBnJUw1Adwmoma4xbgXNGYU1obxQkK46V3NUBL7mJ7a4btHpg7fvPRaCBKYQ1FZXpaB/+oP0CQ/dQp4x9+dJzS2vGa7bJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410418; c=relaxed/simple;
	bh=qaxaZzitvIzJgajHAHhER2gHDhp8kJ8rJObvUQaPrGw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s80PIcSw+qtVgC8TKV+8IuWYw7j5Fckl2n/2tzV0P0wB4+rHZlOhVG5jbT2BmvOKC8dkauF3COFtrXQ0ksS+blDV1hdY8g0AjHl1HeJNx99WubK/Q0vTLyiwWhqt4Fip+zwpD7cMvhTcTGB7W+h4NVrPkDKhzFjO+GFz6AlYhQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nc0AQByC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYJGzcQy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nc0AQByC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYJGzcQy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Vm3vBj/gSGB95euxXlqG8MODm/vUUxMIN1zocpN6/k=;
	b=Nc0AQByCDNVmMJIZo2kpRzkIsjXxobT03J65JVpGVbCJtQsxurfYkGvgSQXoL/VyQLJNaa
	kjmdEBRCyCN4fYW96r4E8yqdbTDPvDYxU0ByLAl2RA540rIJlIcsF1RZioY/0TM+Dx8WVU
	+ATVwMSLfPBZKKgratlUvww5wt4w81o=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-gfJGc8sENQi_Vx4BZ_6zAw-1; Tue, 02 Jun 2026 10:26:53 -0400
X-MC-Unique: gfJGc8sENQi_Vx4BZ_6zAw-1
X-Mimecast-MFC-AGG-ID: gfJGc8sENQi_Vx4BZ_6zAw_1780410413
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-915767b341eso184531285a.3
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410413; x=1781015213; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Vm3vBj/gSGB95euxXlqG8MODm/vUUxMIN1zocpN6/k=;
        b=NYJGzcQyTSbIxA7nbcKiqVm/wJBkJEAVpX1IuU608tv3cpH3klwhKmwuILh5eTvU/7
         rD9IkbKSy+GN8J0EvC8mT3WjafWqA9oj5/GAJeQepNCBT+SHKAku1f5SQ9dML3aUM9KT
         FNSypzHzf3Fo2CxovIXMXp4lCHWIEbLJk61Vdmu1KthK7jQcrXNeQLD78xXcZK1EX+Yb
         CCByVVE146ZpxMUdaGn2YXWihT+enk6W5oDURyD83vQZmpIsXFsjos5/5Yjc7u8hZ6+0
         vFQwuLYjSj4PmbhWNiKrGQyf53ao2152/LFTB4CgiUPC0UAMUBLqK7Y8Hh8XsYe+wl+N
         CwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410413; x=1781015213;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Vm3vBj/gSGB95euxXlqG8MODm/vUUxMIN1zocpN6/k=;
        b=tMyftnjhkHUQBzYI8RZTyfuhMnjAXgeurkAVT7yUgQ3/IQd9GuID3zLyCKDE/EBO18
         P5vBQzZynKPQib1Ggr0LLuBxsFhg5M0Z7i03npISb86G87AHFPEtTh8AdrFx2RKWCR/4
         a2JzSCrQnY4/I1i4/uHRUSZOqRQhh9dTPDL9eA1AxTpQaPmHorSv6R7DmwDon/AZhYZr
         MA91sthn2xmUrYRiupBHUk4FocYS7aGzPYkxUK2W8lyGDwnMbqRYhOVldcUV/QH66oHf
         yYl9/nSKvJHuwO/emqOLh1VG5WoekYktqmaL1V07IqOiLWhIRvUCS6g9TNUy1ZUaSjd+
         usIw==
X-Forwarded-Encrypted: i=1; AFNElJ+Zwi6SThiUdYj8835bS1rEgR8MpwkflUenrry3aqEHSUzyeFhbKdA10whcN4x2ryqRqRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymiAim37b/W3/wQQc4K+r4GtgS6J56o+hlNNDMvMKXJg1q3xDR
	was2wG8ieJhVhbV4tCnDSUNjCzAWQOgMEWm1r/xfUZ0P2SDN9mqeVsrF7QU1GAC7d4N5mqgGBy0
	OJxueHPoF6Um8lr9pXo0+qRoknxF0aIPG0DwnAeHQlXphFW5nsknQSw==
X-Gm-Gg: Acq92OFDF2k/Rsn8wHsKYCP6f0fytC45eE8TAStDBpZFufwaFcWtQuRZJCKuCHVqOdX
	2E6BfHYp7KN7PzswIrhYAJi4J8NrSfvmFivRRXAJuWAUCERlsKUsJEIU5p3vkfOq4/16GcIGq88
	+oK7MBsnIBqJGNVBWWacKggD766XujQTjTVheJkIITVdjUpP8tEpX9vQJYeW34EJ9AMYmn1puut
	n6+blHdlxyVGCqk4XsfbVMpa9gfAJFT1AXET6Ai+2Q7E8h2CW+LebPLMyyNQsZFHSUCUS9eu/DD
	trhUd7v9Nfsrtufz4pjOhN08M/4jQjq9Bklv9zgG54jD3d2WkFbtldlBQ333qoWg0cyPrIcye4v
	1fKXxhBOla7n1NdB+IasKmq/4OD6fFyXC0dcRIJo=
X-Received: by 2002:a05:620a:1997:b0:914:b5f8:c2b3 with SMTP id af79cd13be357-9153d96a548mr2428361785a.18.1780410413226;
        Tue, 02 Jun 2026 07:26:53 -0700 (PDT)
X-Received: by 2002:a05:620a:1997:b0:914:b5f8:c2b3 with SMTP id af79cd13be357-9153d96a548mr2428354485a.18.1780410412507;
        Tue, 02 Jun 2026 07:26:52 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9157f038322sm126685085a.45.2026.06.02.07.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:26:52 -0700 (PDT)
Message-ID: <8e5accc667177fe1d1f955a01a1688fa1b9a9154.camel@redhat.com>
Subject: Re: [PATCH 16/28] KVM: nVMX: pass advanced EPT violation vmexit
 info to guest
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:26:51 -0400
In-Reply-To: <20260505195226.563317-17-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-17-pbonzini@redhat.com>
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
> KVM will use advanced vmexit information for EPT violations to
> virtualize MBEC.=C2=A0 Pass it to the guest since it is easy and allows
> testing nested nested.
>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/include/asm/vmx.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
> =C2=A0arch/x86/kvm/mmu/paging_tmpl.h |=C2=A0 2 +-
> =C2=A0arch/x86/kvm/vmx/nested.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 ++++++=
+++----
> =C2=A03 files changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index 54aa5be50df9..ed2ded531e55 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -535,6 +535,7 @@ enum vmcs_field {
> =C2=A0#define VMX_EPT_1GB_PAGE_BIT (1ull << 17)
> =C2=A0#define VMX_EPT_INVEPT_BIT (1ull << 20)
> =C2=A0#define VMX_EPT_AD_BIT =C2=A0=C2=A0=C2=A0 (1ull << 21)
> +#define VMX_EPT_ADVANCED_VMEXIT_INFO_BIT (1ull << 22)
> =C2=A0#define VMX_EPT_EXTENT_CONTEXT_BIT (1ull << 25)
> =C2=A0#define VMX_EPT_EXTENT_GLOBAL_BIT (1ull << 26)
> =C2=A0
> @@ -617,6 +618,9 @@ enum vm_entry_failure_code {
> =C2=A0 EPT_VIOLATION_PROT_USER_EXEC)
> =C2=A0#define EPT_VIOLATION_GVA_IS_VALID BIT(7)
> =C2=A0#define EPT_VIOLATION_GVA_TRANSLATED BIT(8)
> +#define EPT_VIOLATION_GVA_USER BIT(9)
> +#define EPT_VIOLATION_GVA_WRITABLE BIT(10)
> +#define EPT_VIOLATION_GVA_NX BIT(11)
> =C2=A0
> =C2=A0#define EPT_VIOLATION_RWX_TO_PROT(__epte) (((__epte) & VMX_EPT_RWX_=
MASK) << 3)
> =C2=A0#define EPT_VIOLATION_USER_EXEC_TO_PROT(__epte) (((__epte) & VMX_EP=
T_USER_EXECUTABLE_MASK) >> 4)
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index 8dd9d510fc34..d4ce55195a7c 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -494,7 +494,7 @@ static int FNAME(walk_addr_generic)(struct guest_walk=
er *walker,
> =C2=A0 * [2:0] - Derive from the access bits. The exit_qualification migh=
t be
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 out of date if i=
t is serving an EPT misconfiguration.
> =C2=A0 * [5:3] - Calculated by the page walk of the guest EPT page tables
> - * [7:8] - Derived from [7:8] of real exit_qualification
> + * [7:11] - Derived from [7:11] of real exit_qualification


Something that confused me at first, so I am thinking,
maybe it is worth mentioning that bits 7:11 are copied not here but in nest=
ed_ept_inject_page_fault ?
(this is a pre-exiting problem though)


> =C2=A0 *
> =C2=A0 * The other bits are set to 0.
> =C2=A0 */
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 299d4ca60fb3..46b65475765d 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -443,10 +443,14 @@ static void nested_ept_inject_page_fault(struct kvm=
_vcpu *vcpu,
> =C2=A0 vm_exit_reason =3D EXIT_REASON_EPT_MISCONFIG;
> =C2=A0 exit_qualification =3D 0;
> =C2=A0 } else {
> + u64 mask =3D EPT_VIOLATION_GVA_IS_VALID |
> + EPT_VIOLATION_GVA_TRANSLATED;
> + if (vmx->nested.msrs.ept_caps & VMX_EPT_ADVANCED_VMEXIT_INFO_BIT)
> + mask |=3D EPT_VIOLATION_GVA_USER |
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EPT_VIOLATION_GVA_WRITABLE |
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EPT_VIOLATION_GVA_NX;
> =C2=A0 exit_qualification =3D fault->exit_qualification;
> - exit_qualification |=3D vmx_get_exit_qual(vcpu) &
> - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (EPT_VIOLATION_GVA_IS_VALID |
> - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EPT_VIOLATION_GVA_TRANSLATED);
> + exit_qualification |=3D vmx_get_exit_qual(vcpu) & mask;
> =C2=A0 vm_exit_reason =3D EXIT_REASON_EPT_VIOLATION;
> =C2=A0 }
> =C2=A0
> @@ -7240,7 +7244,8 @@ static void nested_vmx_setup_secondary_ctls(u32 ept=
_caps,
> =C2=A0 VMX_EPT_PAGE_WALK_5_BIT |
> =C2=A0 VMX_EPTP_WB_BIT |
> =C2=A0 VMX_EPT_INVEPT_BIT |
> - VMX_EPT_EXECUTE_ONLY_BIT;
> + VMX_EPT_EXECUTE_ONLY_BIT |
> + VMX_EPT_ADVANCED_VMEXIT_INFO_BIT;
> =C2=A0
> =C2=A0 msrs->ept_caps &=3D ept_caps;
> =C2=A0 msrs->ept_caps |=3D VMX_EPT_EXTENT_GLOBAL_BIT |


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky

