Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2D519D89E
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410149; cv=none; b=QGWz1OqtasdviFvv8aL/uq0aYgxrTDmPyGcndh2shgJhz5bczGqkDx9z0ZBehRQxQrB+DR+IIvN2FS3yhTlR4vC5zi6X1946mUhXnvU5rTMf7Jd8oDYLbRB0vljCxq3bfZZENswVbjl52bFFZvO8My/LGV3wH6s4Cy9Q4iejEUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410149; c=relaxed/simple;
	bh=BSUBrqj5iGAOVVJ1n1DCCi5idG0PzlWRlV0mXApEYcU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nrA7CDTy5r+dWWjcQ+O4TKiNrH4xEbxsE2OSR+5CNUF56y8E2B8jEBwBoSEHcpo+my5OEax8TFbdoQqpHt/HLSBk6qYeRZRtefaUqu99Q9/Y7Lj6OxwetWpPgxJ6gBsURFDaR+I35P9vAhtZ4EcHLE2RJlBYwkoar/rK9W/vfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLwqEZJm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lFgLGaXm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLwqEZJm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lFgLGaXm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R7lXqE3xoTzjYRu9osoDZ9/iNcSA5rWTRQLH8FhptgM=;
	b=CLwqEZJme2l+HZl+5q8aNgUEJR3fwviHSjzdcalMYasTAsWIgGjua4XVDuLkb1aokxydP9
	RFOM/6MZmvxyj0/a3RhRTbfdLQRrJhB5hnj8NCxHsDYhNwtLPBlUshXZFaSvV1npqX/XkH
	7vZPwPSc6lxJaUJYnLACCc8XF0R9tkw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-6v4kpuxNOC2kuY_6Yp70eA-1; Tue, 02 Jun 2026 10:22:26 -0400
X-MC-Unique: 6v4kpuxNOC2kuY_6Yp70eA-1
X-Mimecast-MFC-AGG-ID: 6v4kpuxNOC2kuY_6Yp70eA_1780410146
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ccebf7e86aso99409366d6.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410146; x=1781014946; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R7lXqE3xoTzjYRu9osoDZ9/iNcSA5rWTRQLH8FhptgM=;
        b=lFgLGaXmv4v64/2axj43qNKr17tjiZnPmqimXcKTwg4UXE2c2mNd3wF76kfHw6tQic
         QgGoMBdFWywjUmWPylIJByIHgOvOy6A/5ev2862Zooy99bedmwAP/KxuKVk9dZ0g8fNA
         mZmva22rB/stVWXMtsOfHvL+ZoKdYjIAZICZF1CpawggPFYcfa3y3nUV5nh2QJ2IGsHk
         4KN2AdBhDdk2Gj2ZISyAPYJjE7biJtBT4aTCMBbjrVTw3B0ZjPIDsHUMAApOXWvPDV4J
         KsmFezzEXzcEOAp5jYq9FHdj2KfmSG3zzvwVBrZlE6uApbqeNDXVmOrUmteCKo8Y6j61
         P2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410146; x=1781014946;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7lXqE3xoTzjYRu9osoDZ9/iNcSA5rWTRQLH8FhptgM=;
        b=cCQgPXsB+evATSr+bJBtKwKIyuhuy2Gfe0YqYB73Kp3nFZokXbOcMlj6PWgXtKiYYc
         oUNayVrADxuK6qSxuxPtYvjNitle2dnxuRMx5dMHx7zPUuHb+ijLIRrCOPi4C6emN2FT
         aIDQCVaC8xOcYr18/HzRMIfpGV79/0yMTETEDu58DWbzbLHxpBkQK2tgavDThT53sN2P
         CA2klOi0VvFo7uk42mm01i2sY+vfPCmVeSruTnNX3Fd7Ytb4mEMJdY280bJ4yMe0EC2r
         7X8gI9Cx++fbemzkV04AAIZ3RKEp5e/G70ELrUrx71aOBmiVv959Ho+SQZdyDaZhqkPD
         ZbvA==
X-Forwarded-Encrypted: i=1; AFNElJ+4naEwdXPw/XECcVKaenyDZyCGNAuXqFfEfLQ7RfFK8rekezzZwVHbwo8OhEPAWrz3anM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6GlTC9n1yGTCT+WK4kQwRcRxgnXhDQHGUe/3nXDwuDHF5qJhg
	JEp4xOoEu/dp85gtKJyv2iGPp6TnguiHBCDdfCPc8JxDAkjHJVXk+Y0BPSB/SnASCzoazmerCYN
	kTPBoyqq2HUjSUdai5bSiyMi9KzLnGhSlB4v5+OYvDwvJl6gRt2+EeA==
X-Gm-Gg: Acq92OEQtw/7prlnwoUyfbpivVUkOIQwonFpxAPV0D5yZfpE/lAD0OROp6LPL9hQ0zN
	Ss77Vbl0p1Al4y0gm5ogE3OGy4CnYwE510iPak2Kkn4xGvc9LXQrQFaI+s/AOW+KFHfq5L6Zp8j
	hUmq1eDUUFIJJeBHJED/rXN2Lnvxc48eAfsLLJVZm9ygqDSc3FmoAmoU7OnlKAsa0lv3B82Wltx
	UX0xUQwYkQhxxml1GSXbA+XDMzW7VuPkTTzpjXGx6dbEcCQpiHzKME2Q2pzjj2FI1COr+EROS1M
	39d/3c2nNihYlQKGe6uc8Rxvq6YlWaJpGCeLbl3mzEPV9O82ENaI4Du/ArV9mBz1As94KaRGBWS
	APqdpunO9uPD25I7PKuipi/9/1knjk5fmwtO9MpA=
X-Received: by 2002:a05:6214:1c88:b0:8cc:d74a:8dff with SMTP id 6a1803df08f44-8cebf39a305mr60446386d6.5.1780410145660;
        Tue, 02 Jun 2026 07:22:25 -0700 (PDT)
X-Received: by 2002:a05:6214:1c88:b0:8cc:d74a:8dff with SMTP id 6a1803df08f44-8cebf39a305mr60445836d6.5.1780410145202;
        Tue, 02 Jun 2026 07:22:25 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cebf08e2d9sm26738496d6.10.2026.06.02.07.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:22:24 -0700 (PDT)
Message-ID: <663ea0eaab130115fed8d6e06115085b9dabae14.camel@redhat.com>
Subject: Re: [PATCH 07/28] KVM: x86/mmu: rename and clarify BYTE_MASK
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:22:23 -0400
In-Reply-To: <20260505195226.563317-8-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-8-pbonzini@redhat.com>
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
> The BYTE_MASK macro is the central point of the black magic
> in update_permission_bitmask().=C2=A0 Rename it to something
> that relates to how it is used, and add a comment explaining
> how it works.
>=20
> Using shifts instead of powers of two was actually suggested by
> David Hildenbrand back in 2017 for clarity[1] but I evidently
> forgot his suggestion when applying to kvm.git.
>=20
> [1] https://lore.kernel.org/kvm/e4b5df86-31ae-2f4e-0666-393753e256df@redh=
at.com/
>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/kvm/mmu/mmu.c | 63 ++++++++++++++++++++++++++++-----------=
---
> =C2=A01 file changed, 43 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 24fbc9ea502a..d94a488db79d 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5529,31 +5529,55 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *c=
ontext, bool execonly)
> =C2=A0 =C2=A0=C2=A0=C2=A0 max_huge_page_level);
> =C2=A0}
> =C2=A0
> -#define BYTE_MASK(access) \
> - ((1 & (access) ? 2 : 0) | \
> - (2 & (access) ? 4 : 0) | \
> - (3 & (access) ? 8 : 0) | \
> - (4 & (access) ? 16 : 0) | \
> - (5 & (access) ? 32 : 0) | \
> - (6 & (access) ? 64 : 0) | \
> - (7 & (access) ? 128 : 0))
> -
> +/*
> + * Build a mask with all combinations of PTE access rights that
> + * include the given access bit.=C2=A0 The mask can be queried with
> + * "mask & (1 << access)", where access is a combination of
> + * ACC_* bits.
> + *
> + * By mixing and matching multiple masks returned by ACC_BITS_MASK,
> + * update_permission_bitmask() builds what is effectively a
> + * two-dimensional array of bools.=C2=A0 The second dimension is
> + * provided by individual bits of permissions[pfec >> 1], and
> + * logical &, | and ~ operations operate on all the 8 possible
> + * combinations of ACC_* bits.
> + */
> +#define ACC_BITS_MASK(access) \
> + ((1 & (access) ? 1 << 1 : 0) | \
> + (2 & (access) ? 1 << 2 : 0) | \
> + (3 & (access) ? 1 << 3 : 0) | \
> + (4 & (access) ? 1 << 4 : 0) | \
> + (5 & (access) ? 1 << 5 : 0) | \
> + (6 & (access) ? 1 << 6 : 0) | \
> + (7 & (access) ? 1 << 7 : 0))
> =C2=A0
> =C2=A0static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept=
)
> =C2=A0{
> - unsigned byte;
> + unsigned index;
> =C2=A0
> - const u8 x =3D BYTE_MASK(ACC_EXEC_MASK);
> - const u8 w =3D BYTE_MASK(ACC_WRITE_MASK);
> - const u8 u =3D BYTE_MASK(ACC_USER_MASK);
> + const u8 x =3D ACC_BITS_MASK(ACC_EXEC_MASK);
> + const u8 w =3D ACC_BITS_MASK(ACC_WRITE_MASK);
> + const u8 u =3D ACC_BITS_MASK(ACC_USER_MASK);
> =C2=A0
> =C2=A0 bool cr4_smep =3D is_cr4_smep(mmu);
> =C2=A0 bool cr4_smap =3D is_cr4_smap(mmu);
> =C2=A0 bool cr0_wp =3D is_cr0_wp(mmu);
> =C2=A0 bool efer_nx =3D is_efer_nx(mmu);
> =C2=A0
> - for (byte =3D 0; byte < ARRAY_SIZE(mmu->permissions); ++byte) {
> - unsigned pfec =3D byte << 1;
> + /*
> + * In hardware, page fault error codes are generated (as the name
> + * suggests) on any kind of page fault.=C2=A0 permission_fault() and
> + * paging_tmpl.h already use the same bits after a successful page
> + * table walk, to indicate the kind of access being performed.
> + *
> + * However, PFERR_PRESENT_MASK and PFERR_RSVD_MASK are never set here,
> + * exactly because the page walk is successful.=C2=A0 PFERR_PRESENT_MASK=
 is
> + * removed by the shift, while PFERR_RSVD_MASK is repurposed in
> + * permission_fault() to indicate accesses that are *not* subject to
> + * SMAP restrictions.
> + */
> + for (index =3D 0; index < ARRAY_SIZE(mmu->permissions); ++index) {
> + unsigned pfec =3D index << 1;
> =C2=A0
> =C2=A0 /*
> =C2=A0 * Each "*f" variable has a 1 bit for each UWX value
> @@ -5598,16 +5622,15 @@ static void update_permission_bitmask(struct kvm_=
mmu *mmu, bool ept)
> =C2=A0 *=C2=A0=C2=A0 - The access is supervisor mode
> =C2=A0 *=C2=A0=C2=A0 - If implicit supervisor access or X86_EFLAGS_AC is =
clear
> =C2=A0 *
> - * Here, we cover the first four conditions.
> - * The fifth is computed dynamically in permission_fault();
> - * PFERR_RSVD_MASK bit will be set in PFEC if the access is
> - * *not* subject to SMAP restrictions.
> + * Here, we cover the first four conditions.=C2=A0 The fifth
> + * is computed dynamically in permission_fault() and
> + * communicated by setting PFERR_RSVD_MASK.
> =C2=A0 */
> =C2=A0 if (cr4_smap)
> =C2=A0 smapf =3D (pfec & (PFERR_RSVD_MASK|PFERR_FETCH_MASK)) ? 0 : kf;
> =C2=A0 }
> =C2=A0
> - mmu->permissions[byte] =3D ff | uf | wf | smepf | smapf;
> + mmu->permissions[index] =3D ff | uf | wf | smepf | smapf;
> =C2=A0 }
> =C2=A0}
> =C2=A0

Thanks a million for demystifying this black magic!

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky


