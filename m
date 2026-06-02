Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F336313D886
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410019; cv=none; b=RVH7w1TpZaBB4wUDu2alSoIBkCajCaSn/xkQCDTESLRlXZQxG73ARZoPVto4iB9QrSC3TfnzvQDI6UGFACIKanR5QDU8Hbx3Gc6jI+jfgXbamx7abvHehxvY+7EHge4ovZVX0Nn2L1akpR5pzyysCuyJI6cSiZV9qxqClGLVKeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410019; c=relaxed/simple;
	bh=gWZENFnUAaRVr6ZZ1tYRFlHuexmR2VG5OI/Dx4btvWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h4zh++Log1o9AB/Z3GGPKM9XXEbm4R5+XCWgjreFGIJI4UET2yz0HgrPWmVxvpbajZU6gA/0gKC/bFOxgaZAu6nxYm6454B8Xj5oKB18BUcS0sBFndr60/j+lDVi8PRVzWaYsMTvFCjShFr2bBpHucK/buf1/vPZ19YWUTdtBB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IdG614gK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cp1jm09N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdG614gK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cp1jm09N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rSz3RdhwhpdG6SJv/JipBQkzKuAPDGbzpB4LZ5RrYSI=;
	b=IdG614gKvBFJPF796k1Xm8nOFVcHX9iPKtRkggnm5/cj4anrk9rrwaDs8hLJ+krLPW88t1
	/aX1RmsodG46db2hEx6XuCm5ekn/PlGV1iW9a6uHFUzTkRmi9TS9iUlxG1qXAl/qkNC0Iw
	d6LPigZN/8561sqNb2hozgvbaaSXRGM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-LejxQArjME-ewe4QgbfK1Q-1; Tue, 02 Jun 2026 10:20:14 -0400
X-MC-Unique: LejxQArjME-ewe4QgbfK1Q-1
X-Mimecast-MFC-AGG-ID: LejxQArjME-ewe4QgbfK1Q_1780410014
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ce9e6cf3aeso65406016d6.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410014; x=1781014814; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rSz3RdhwhpdG6SJv/JipBQkzKuAPDGbzpB4LZ5RrYSI=;
        b=cp1jm09N+YLjs5X6t5tcfh7YB+2li3ld3IZVDbYWdNq/2EX+J+VgTRpSZ2gck4QvN4
         fP9nh7iavMaEHpRJ8BDF6FOf4ln07/AzduhYxEIzzaR3fSuv37n4v5T6kfStC7xQDb+x
         h+MJn8TFH9uMHa9zdU+NHgccdaOHhTJk+FKJZijOIErEqJEVGTT46Ue+/1A5YrkR5EK4
         d5quaDkFeIzoYOYwarcb4740F2l7Q2GivzVSrociKlELlV6qP314dDoyaXqFjY3bzOKh
         kcRquKUi/UybHQceiqzZ7PYALU5FR+0TstVdTLarZ7w/o1wGxit7Bb7jCq9JVwVnZOW7
         YinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410014; x=1781014814;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rSz3RdhwhpdG6SJv/JipBQkzKuAPDGbzpB4LZ5RrYSI=;
        b=ltWbIx1YzrF07H5i2307/Zx5rYsZtrwPS54rH4jrOSmpMl5IVwfg4GPY8W30blHg/K
         ExPUa1jU8ptcfLgichviE1k3FTHNWm3rVQPneXi9PdseWkybxEqb62JmVJhWxw2cjlyO
         3UAn7iYc6/xJoJJSxuUTZDfXoQzrNY7y/Mc7reSZwkEm9W0kxAW7W173ErBR+VI9D6Fs
         PZTVcn/ReEfoBGeIOze9r19voJyt4uC00jxE12peRslYylsELa1SVBgagqSitaJizsob
         WNdQqpuxlsdss7+BjMRT6ZBVwOYPBoFw6iiZ1VXz4J7vh/DV80oD2QDZCNuyb54O7Ezs
         s82g==
X-Forwarded-Encrypted: i=1; AFNElJ/9yLXod9kjKewt1ZFjLqYre0UBZ1c77vws7/PBDIkBNzjaeEszt8tsM8GHneA0chHIkk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxJaJUdFYx3nrzGuJJ2j69A3T35IB+VkVW9Dkoheqi5+V173RQ
	2/cEu1r+B9B7jj7TyAXIWtHNZh25h65eL++OtGX96bUqhHND3kg2WTUyJrsROvOJ/N3nU0nEhaA
	tk7RULQYg9fj/im3WJZz5d8RVneWTNnprs9af1N9oYm+K985lcGJlDg==
X-Gm-Gg: Acq92OHzIjZMY/MCeoyqRCZJQ0HhDK7JFr9+42M/ua/AJCjjsVmCMwNt3E/lTYgx/BV
	4pTJ1MBQ/iSO5WR1Xgb8WlBn0pEvUUa07dMOVxmM3uc72GixJ749ynUNwnec46VYCtXYRMaE4on
	VSPOUfd5ci8wo+/95ihZkfThJo1+EWz7ttx6Pw+5LKgOoaeJ5vErvh3kgevrmMukgH8mYzq3Iac
	81Y+KlVNg/lhpsDkyoiwPlCkCR8c2ZsGZ/IJDhVZ4zLR3Gg6n0RPXbPRr2s/5E4RxQU+NlW12m7
	col/yPpUXmmoFHl8QUVys9zEHqSbLpp1Vod7OSXmZ+XIgJasivW15B8XQPf9T4I5sZlNTLZG+bf
	Kqj6dM+S+16/vCC9cCT3LXZ1bWL+Tr1tahDeUdt8=
X-Received: by 2002:a05:6214:23cd:b0:8ac:bb62:fe52 with SMTP id 6a1803df08f44-8ccefd32da9mr246440146d6.4.1780410013935;
        Tue, 02 Jun 2026 07:20:13 -0700 (PDT)
X-Received: by 2002:a05:6214:23cd:b0:8ac:bb62:fe52 with SMTP id 6a1803df08f44-8ccefd32da9mr246439746d6.4.1780410013497;
        Tue, 02 Jun 2026 07:20:13 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea085db2sm120136616d6.18.2026.06.02.07.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:20:12 -0700 (PDT)
Message-ID: <e8060b411aa9cdf56fb3146911b307161f7a89fd.camel@redhat.com>
Subject: Re: [PATCH 02/28] KVM: x86/mmu: remove SPTE_PERM_MASK
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:20:11 -0400
In-Reply-To: <20260505195226.563317-3-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-3-pbonzini@redhat.com>
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
> From: Jon Kohler <jon@nutanix.com>
>=20
> SPTE_PERM_MASK is no longer referenced by anything in the kernel.

It might be worth adding a note saying that this macro has been unused for =
a long time.
(to help with backports)=20

The last commit that referenced it was this one, if I am not mistaken:

commit 1441ca1494d74a2c9d6c9bd8dd633d9ebff1daba
Author: Junaid Shahid <junaids@google.com>
Date:   Fri Jul 22 19:43:16 2022 -0700

    kvm: x86: mmu: Drop the need_remote_flush() function
   =20
    This is only used by kvm_mmu_pte_write(), which no longer actually
    creates the new SPTE and instead just clears the old SPTE. So we
    just need to check if the old SPTE was shadow-present instead of
    calling need_remote_flush(). Hence we can drop this function. It was
    incomplete anyway as it didn't take access-tracking into account.
   =20
    This patch should not result in any functional change.
   =20
    Signed-off-by: Junaid Shahid <junaids@google.com>
    Reviewed-by: David Matlack <dmatlack@google.com>
    Reviewed-by: Sean Christopherson <seanjc@google.com>
    Message-Id: <20220723024316.2725328-1-junaids@google.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>


>=20
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Message-ID: <20251223054806.1611168-3-jon@nutanix.com>
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/kvm/mmu/spte.h | 3 ---
> =C2=A01 file changed, 3 deletions(-)
>=20
> diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
> index 91ce29fd6f1b..28086fa86fe0 100644
> --- a/arch/x86/kvm/mmu/spte.h
> +++ b/arch/x86/kvm/mmu/spte.h
> @@ -42,9 +42,6 @@ static_assert(SPTE_TDP_AD_ENABLED =3D=3D 0);
> =C2=A0#define SPTE_BASE_ADDR_MASK (((1ULL << 52) - 1) & ~(u64)(PAGE_SIZE-=
1))
> =C2=A0#endif
> =C2=A0
> -#define SPTE_PERM_MASK (PT_PRESENT_MASK | PT_WRITABLE_MASK | shadow_user=
_mask \
> - | shadow_x_mask | shadow_nx_mask | shadow_me_mask)
> -
> =C2=A0#define ACC_EXEC_MASK=C2=A0=C2=A0=C2=A0 1
> =C2=A0#define ACC_WRITE_MASK=C2=A0=C2=A0 PT_WRITABLE_MASK
> =C2=A0#define ACC_USER_MASK=C2=A0=C2=A0=C2=A0 PT_USER_MASK


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky

