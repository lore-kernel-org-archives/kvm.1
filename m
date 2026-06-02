Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B43CB2E0
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410085; cv=none; b=Uf9c39s/WFRvDFnoa+LsO6KzTdlh03HIciKgyRQNHpjOX7lhCcOZywCI4ovgzh+8uyvya7j49zeGTlGeiotgCD15tcwyGXvKgiIwXQWkXS69Uf/FTCUBFZfb/qPg9cetKZVGIygUOK/ibSELMinjSuq/sE4X1VbnawyeFg8Odc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410085; c=relaxed/simple;
	bh=4+ZbfNZUKm6BjeoLdpUYopmSVBgmH32jaO1OXvl0sM8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BRTDLA9hOYpHY4XZmwtGQcG+F87xgElA4UB/unCS2g0zniDumQRy5RSm+z/rNgz/sEW1+b7RjH+wVqswCdWrzYCt7NygOENZwrcukQsB4PCwcQpnQz53I1VBdvJZTNwVeR3AZgF9Ctqs36DlLUtMWoFsHjqPWFdO8hnBPAD7n58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CKV5Lzgs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PxtZfw5D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKV5Lzgs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxtZfw5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wv5+KxNYa0xgoVoEdVchOIn7ysLVyRU25+L+skl5v1c=;
	b=CKV5LzgsKfb95jUnvNo7nz5Rz8e9tGmyYf/2Aft9lgYuCz+jAFgqwDn7UmyxupPYsn4odr
	btBQUsD44tb5Xk2STOr8KGxwKrC1nMpGJ48QA1AGgZuMbHW50yxyalDC7+DkFmfVog3nLI
	+8IcaSc44mvJB4UuNPwPrPAhxR86reU=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-6kocJH_PN2eHmc5qSh4Jbw-1; Tue, 02 Jun 2026 10:21:22 -0400
X-MC-Unique: 6kocJH_PN2eHmc5qSh4Jbw-1
X-Mimecast-MFC-AGG-ID: 6kocJH_PN2eHmc5qSh4Jbw_1780410081
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-96388871d70so4841401241.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410081; x=1781014881; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wv5+KxNYa0xgoVoEdVchOIn7ysLVyRU25+L+skl5v1c=;
        b=PxtZfw5Dp3ii6gfSKXSEcD9Gipus5a+G+GzV3s/WV2BWx37pru53vMAnH1jIDgzRha
         0QX7Gx4VLlhgVatIqSFDcsMxXY9omvUA3Q5h8gjM8WFxJf4l6mBmVO+WJYQYhEFQQY+e
         i7lXBqdFYgG4EtA4MuaEMSWqlo/WIphnZcp1DEEIFxKcJyNKyknbdiEls94dI6Kil/Ed
         NM32pNAopkEJ93o5EJlL1HYIaN+3HkMXpfz7vhuiTkMOS/xsp63pF0DYZn1Z+eu2/89u
         BwblKngFkssMJyN+2taQ9fsQ5nV0dYFbKlFxPOZ/jwqv3z2igx9S6oYj2SWYnuTwCd0T
         Rz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410081; x=1781014881;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv5+KxNYa0xgoVoEdVchOIn7ysLVyRU25+L+skl5v1c=;
        b=hb2zn5Cyx/UWi3usPTnp4B60svvuyDjISkek8rHJL71o6OM2GC9ZwHtuQ5xrEWS20H
         xRM2s6T6pYh77nWi+HLoEn0CJXLCFjIFTMr9J5EachKz6bazBgczWE/qxC98mTSq/cVF
         azOIl8ziw6efZnzwDivUhqX5Sb5mCxH2nUTz4mBhHBNbwkPU3wUDm+xszc79EuVl5s0W
         RfOxiDZk4XK5BHT3z91o5I2SXM/bzLfnCZ3UIebQFyieI20c7y/3qCqsTvIWCQV1TzUA
         vDBEVjIPdeQHVWlTjM4soczlT3XYk9mx6mBHwFYmC8JgAu9ACT3V/Y9k0FHiA3TeEblm
         /wNA==
X-Forwarded-Encrypted: i=1; AFNElJ+8hBco0h7e+NjR7PKz1Ff7S1z2zL3FEckn/FBGWZdAalur3MfhhoPaV2W8wdeQVTksXfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5iosm6qvMkjbMTKxXla/JZz5BeoAduZdDxQgMCKCLZ26iwykS
	LsqJs/6wloyc20SRxfqsyQtfi2T/xyiSgCYl8AeUT4fq0Pa7/QBYvhxTuzAxQP8zWP2crviaprA
	FmvA8WX7aUBuxIVlCz/LH1I3T4o293Q4OQ/IeiOIgof6grqVnIKosgA==
X-Gm-Gg: Acq92OE5tIErUPSB2J2FALKeCG9NnYJKCGGzVyTgbmuWQ1XPfgAiNz1bHr0rxN8hbMr
	kZUGOAw/TiMpFcTAUT6ow6CQwo282EXbV50AREx79hfdvToDjQz9xT4RpJL291RfUN8SnPLlPnN
	IHZD9BT7WVpEOr0ShsIz6gBg07rxS2gV2LKWpSon0HqzE8ejrIZUUWDGKMD41o+0qwpfpgNpHC2
	UQ0fi3EJDyOCXt15clTQcp7EJ0WSJftbTwweIJH79q4/3tkJridCCmLgvhVYrt3DiNTMcAoOQfQ
	/OBmsFRPT3ykYP0v8iHDgubDWVGwm/FbyMSRKBOL9cplYfmSCGJgXzb1BC0Ae3KqehDwBTmPubI
	9McH5YdUHAzsOe7cFYY129lyDIkDsfTXeZI2LBTs=
X-Received: by 2002:a05:6102:c87:b0:6d5:91f0:21b4 with SMTP id ada2fe7eead31-6d591f02461mr6896048137.29.1780410081088;
        Tue, 02 Jun 2026 07:21:21 -0700 (PDT)
X-Received: by 2002:a05:6102:c87:b0:6d5:91f0:21b4 with SMTP id ada2fe7eead31-6d591f02461mr6895999137.29.1780410080678;
        Tue, 02 Jun 2026 07:21:20 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915790a787bsm229962585a.29.2026.06.02.07.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:21:19 -0700 (PDT)
Message-ID: <e1c5ab918a342c22ae1cc5692ad98a9510185e61.camel@redhat.com>
Subject: Re: [PATCH 05/28] KVM: x86/mmu: remove SPTE_EPT_*
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:21:19 -0400
In-Reply-To: <20260505195226.563317-6-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-6-pbonzini@redhat.com>
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
> spte.h is already including vmx.h, use the constants it defines.
>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/kvm/mmu/spte.h | 8 ++------
> =C2=A01 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
> index 317b9cd1537c..bc02a2e89a31 100644
> --- a/arch/x86/kvm/mmu/spte.h
> +++ b/arch/x86/kvm/mmu/spte.h
> @@ -57,10 +57,6 @@ static_assert(SPTE_TDP_AD_ENABLED =3D=3D 0);
> =C2=A0#define ACC_USER_MASK=C2=A0=C2=A0=C2=A0 PT_USER_MASK
> =C2=A0#define ACC_ALL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (ACC_EXEC_MASK | ACC_WRITE_MASK | ACC_USER_MASK)
> =C2=A0
> -/* The mask for the R/X bits in EPT PTEs */
> -#define SPTE_EPT_READABLE_MASK 0x1ull
> -#define SPTE_EPT_EXECUTABLE_MASK 0x4ull
> -
> =C2=A0#define SPTE_LEVEL_BITS 9
> =C2=A0#define SPTE_LEVEL_SHIFT(level) __PT_LEVEL_SHIFT(level, SPTE_LEVEL_=
BITS)
> =C2=A0#define SPTE_INDEX(address, level) __PT_INDEX(address, level, SPTE_=
LEVEL_BITS)
> @@ -73,8 +69,8 @@ static_assert(SPTE_TDP_AD_ENABLED =3D=3D 0);
> =C2=A0 * restored only when a write is attempted to the page.=C2=A0 This =
mask obviously
> =C2=A0 * must not overlap the A/D type mask.
> =C2=A0 */
> -#define SHADOW_ACC_TRACK_SAVED_BITS_MASK (SPTE_EPT_READABLE_MASK | \
> - =C2=A0 SPTE_EPT_EXECUTABLE_MASK)
> +#define SHADOW_ACC_TRACK_SAVED_BITS_MASK (VMX_EPT_READABLE_MASK | \
> + =C2=A0 VMX_EPT_EXECUTABLE_MASK)
> =C2=A0#define SHADOW_ACC_TRACK_SAVED_BITS_SHIFT 52
> =C2=A0#define SHADOW_ACC_TRACK_SAVED_MASK (SHADOW_ACC_TRACK_SAVED_BITS_MA=
SK << \
> =C2=A0 SHADOW_ACC_TRACK_SAVED_BITS_SHIFT)

Makes sense,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky

