Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1813C415C
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410065; cv=none; b=Q/FMFGmHA6DNbb6hN4wbE1dwXY6vpMhB45q/YVCXr63ucjhWMlGD6jPMxcPoOu6EphGSWLw7UMNchID+63IN4MskMAQA/rPYJfJpLti1A6RCnYA3rcZqTDoh6yQfrG94/Qi65M3O2PleXC7BKcgCV4qWNyFvxQGOz4fWg4PsD48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410065; c=relaxed/simple;
	bh=+W0rrURTIZCgH+yOdPQlNjDHpWvV+3WBIFW2/XMLMNo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mVHxZKV9aTscaLe2Mkjogv1uw+EqlrkiW2G1+sgAbB7qAxv4S9e42/RaHmzA54n+rOhyiS3g4U+4mDzg2NC0DNQKVKLoY4xDESAQmSMGfKB0TYwJ4+ZrOfXd2I94QPdoFsUXIbnNzngze+aBklwLmmtwdz5fA687jO/PHxnfqQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUeHV4ld; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sc2N/HcY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUeHV4ld";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sc2N/HcY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNgFgrpf7w/FMs0bq28uFQIumMwYrw0jgR/RkY8a7d0=;
	b=BUeHV4ld/XB/j+RmQEc3ws+y4DsXra7UMKB3JmdcllLCAM7MIUuzqxjrhr5qOFzox4xMT2
	ylgXYcsbwZRhsRalDu6MwgWDSjcXaQWlHFTWuFqNtluqpiuq9J/vmYcjSXmwpLu4wCJSeq
	+yIGJEQ71TQhr396l/Ema3e91hHzENs=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-15Np6SfxP3qIaZL6Dor5bw-1; Tue, 02 Jun 2026 10:21:00 -0400
X-MC-Unique: 15Np6SfxP3qIaZL6Dor5bw-1
X-Mimecast-MFC-AGG-ID: 15Np6SfxP3qIaZL6Dor5bw_1780410060
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6c7b5cf8bceso1191254137.0
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410060; x=1781014860; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gNgFgrpf7w/FMs0bq28uFQIumMwYrw0jgR/RkY8a7d0=;
        b=sc2N/HcYWWPSUVPXL7hpKfN7c188MjS9Oi3FIPWDGYV3r6S5C5opmypFBuUdMz8E0k
         7mvjLCT0u74VeHCHyGMzitYEYt6rHqyYqjhPaZ6/oaVjq25Uan2M/bY1LALbHdGKriZY
         lbtYG+hmmgMaGIAedU4NvpOF7AkXdYSNVsUYCei7xnR6IG6B/K+V2PnBQwNiwJRn7YE4
         N+Eg8z1w19iOCtoZ+wA50zvQ4n7Dh+7Z2XD++O6Cf5C5dH924KgTjxxkfmgwK6FwR9qh
         t3uE8QIPMaMUC2P91AMD+iQXaqe7UYImWtF43piJEtRcqgD76dwk8GoYrhdcy0mXI9G8
         uIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410060; x=1781014860;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNgFgrpf7w/FMs0bq28uFQIumMwYrw0jgR/RkY8a7d0=;
        b=g2pM8ssH4oKdRR0sHO2uVj4QqPObgpIKKivvBKXY3TXXwMrAjEOOXQRRbRB1qOXmyH
         hGrWa/m373bI/0i6cZUfsunoOzPo1wLQeN2FkAOxny0f9kEpX9nohQty1JrmuKdzlgG9
         HXCD9Y2oYInLLRrS2EwiDMnj/OaBqJ8H6NBQsbpKYhJrE2kgFgDTXKfhM8R9oJu0bI+A
         v51fRL7UITpivEGcBj2ne7IH207sbIyCU8wfkS/H3SQOHhWIW62jQbOJrGpH0+bsMteW
         zzP1FMky1w5R15LPjy7HSOGM0jRX729sAzEkN3KjhK5fC7zwi1Uek/nx3W1shcz4Xndc
         f4vg==
X-Forwarded-Encrypted: i=1; AFNElJ9tO1e8DHcwGXxghp/0rYN8+7s/WQzGq903nKD8SYdvvTZhNQHkOWUbYOqON5ZOchPa7eA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ou3LtCyZv1vo1/P+vODm5x409po36AEdTS2TKczN9qml+yyw
	tZA7zWaP/VtlOnZrIv91lxQ93omWnao1JzCXmbjjRrnXpFxZyeuR3y+QfUlRj4f27aLaeIjErjO
	4sYTs6wQNPD9RvlP+2YF8Le9GZ/kRhv9sLGyF1V21wYC1H+Sem6dxFw==
X-Gm-Gg: Acq92OHwE7jQaGN8BbhKEzfkcOEy9jr7l8NA2ntdNlg085+335fxRK82nhPwSDh49o2
	ceZnFG5yQIiJYGjEvGTdJGbktrSCbv90a8Swh3m0KiPn8PuMfhkLd58cxpKSbsncf0JB+m1jDJK
	wa8n9FltSXJE+fxhyElJzB0YP7QtoWsFlFe4r/JDkZv+5K9hqpF0rA7pqMVzrFj6r4uvyF5EJ4C
	qryJLd8D3GuYu9zRxG8Z8uNYPvvlTRrpuxiWH4efzOSCqlxej9bXLT5q5SJSXhFZgpaIL0sRRHl
	sU7KJsyF4ywD2BFYXn5dwtKWEJo6UJINbHJ8kyGqCu4P1pFfyp3FJCqooZhCWk2yoC9VgzIcmDs
	GKQ1Kd/FVsUWyapnc9Rq8zf6qkJtldSpfDPJZdCA=
X-Received: by 2002:a05:6102:640f:b0:6cf:37fe:2cb with SMTP id ada2fe7eead31-6cf37fe145dmr3576251137.27.1780410059848;
        Tue, 02 Jun 2026 07:20:59 -0700 (PDT)
X-Received: by 2002:a05:6102:640f:b0:6cf:37fe:2cb with SMTP id ada2fe7eead31-6cf37fe145dmr3576204137.27.1780410059317;
        Tue, 02 Jun 2026 07:20:59 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea064f97sm119970196d6.13.2026.06.02.07.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:20:58 -0700 (PDT)
Message-ID: <8892ec32671534e51168655fbbcce9f4340d29b2.camel@redhat.com>
Subject: Re: [PATCH 04/28] KVM: x86/mmu: shuffle high bits of SPTEs in
 preparation for MBEC
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:20:57 -0400
In-Reply-To: <20260505195226.563317-5-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-5-pbonzini@redhat.com>
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
> Access tracking will need to save bit 10 when MBEC is enabled.
> Right now it is simply shifting the R and X bits into bits 54 and 56,
> but bit 10 would not fit with the same scheme.=C2=A0 Reorganize the
> high bits so that access tracking will use bits 52, 54 and 62.
> As a side effect, the free bits are compacted slightly, with
> 56-59 still unused.

First of all thanks for documenting this black magic!

Minor nitpick:

There is a slight inconsistency between the commit message, which says that=
 bit 62=C2=A0
will be used, and the comment below, which states that=C2=A0
bit 62 is unused=C2=A0 (although in following patches this comment is updat=
ed).

Also, although I'm not entirely sure this is worth mentioning that bit 62=
=20
just happens to be 10 bits away from bit 52,
so that we can still just copy the permission bits from EPT's SPTE as a sin=
gle block,
even though between bits 52,53,54 and bit 63, there are other bits which
KVM uses for other purposes.

>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/kvm/mmu/spte.h | 20 +++++++++++++++-----
> =C2=A01 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
> index 4283cea3e66c..317b9cd1537c 100644
> --- a/arch/x86/kvm/mmu/spte.h
> +++ b/arch/x86/kvm/mmu/spte.h
> @@ -17,10 +17,20 @@
> =C2=A0 */
> =C2=A0#define SPTE_MMU_PRESENT_MASK BIT_ULL(11)
> =C2=A0
> +/*
> + * The ignored high bits are allocated as follows:
> + * - bits 52, 54: saved X-R bits for access tracking when EPT does not h=
ave A/D
> + * - bits 53 (EPT only): host writable
> + * - bits 55 (EPT only): MMU-writable
> + * - bits 56-59: unused
> + * - bits 60-61: type of A/D tracking
> + * - bits 62: unused
> + */
> +
> =C2=A0/*
> =C2=A0 * TDP SPTES (more specifically, EPT SPTEs) may not have A/D bits, =
and may also
> =C2=A0 * be restricted to using write-protection (for L2 when CPU dirty l=
ogging, i.e.
> - * PML, is enabled).=C2=A0 Use bits 52 and 53 to hold the type of A/D tr=
acking that
> + * PML, is enabled).=C2=A0 Use bits 60 and 61 to hold the type of A/D tr=
acking that
> =C2=A0 * is must be employed for a given TDP SPTE.
> =C2=A0 *
> =C2=A0 * Note, the "enabled" mask must be '0', as bits 62:52 are _reserve=
d_ for PAE
> @@ -29,7 +39,7 @@
> =C2=A0 * TDP with CPU dirty logging (PML).=C2=A0 If NPT ever gains PML-li=
ke support, it
> =C2=A0 * must be restricted to 64-bit KVM.
> =C2=A0 */
> -#define SPTE_TDP_AD_SHIFT 52
> +#define SPTE_TDP_AD_SHIFT 60
> =C2=A0#define SPTE_TDP_AD_MASK (3ULL << SPTE_TDP_AD_SHIFT)
> =C2=A0#define SPTE_TDP_AD_ENABLED (0ULL << SPTE_TDP_AD_SHIFT)
> =C2=A0#define SPTE_TDP_AD_DISABLED (1ULL << SPTE_TDP_AD_SHIFT)
> @@ -65,7 +75,7 @@ static_assert(SPTE_TDP_AD_ENABLED =3D=3D 0);
> =C2=A0 */
> =C2=A0#define SHADOW_ACC_TRACK_SAVED_BITS_MASK (SPTE_EPT_READABLE_MASK | =
\
> =C2=A0 =C2=A0 SPTE_EPT_EXECUTABLE_MASK)
> -#define SHADOW_ACC_TRACK_SAVED_BITS_SHIFT 54
> +#define SHADOW_ACC_TRACK_SAVED_BITS_SHIFT 52
> =C2=A0#define SHADOW_ACC_TRACK_SAVED_MASK (SHADOW_ACC_TRACK_SAVED_BITS_MA=
SK << \
> =C2=A0 SHADOW_ACC_TRACK_SAVED_BITS_SHIFT)
> =C2=A0static_assert(!(SPTE_TDP_AD_MASK & SHADOW_ACC_TRACK_SAVED_MASK));
> @@ -84,8 +94,8 @@ static_assert(!(SPTE_TDP_AD_MASK & SHADOW_ACC_TRACK_SAV=
ED_MASK));
> =C2=A0 * to not overlap the A/D type mask or the saved access bits of acc=
ess-tracked
> =C2=A0 * SPTEs when A/D bits are disabled.
> =C2=A0 */
> -#define EPT_SPTE_HOST_WRITABLE BIT_ULL(57)
> -#define EPT_SPTE_MMU_WRITABLE BIT_ULL(58)
> +#define EPT_SPTE_HOST_WRITABLE BIT_ULL(53)
> +#define EPT_SPTE_MMU_WRITABLE BIT_ULL(55)
> =C2=A0
> =C2=A0static_assert(!(EPT_SPTE_HOST_WRITABLE & SPTE_TDP_AD_MASK));
> =C2=A0static_assert(!(EPT_SPTE_MMU_WRITABLE & SPTE_TDP_AD_MASK));


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky


