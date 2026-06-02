Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A2B3EBF13
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410725; cv=none; b=O45Yd4w1aJ8YU5D0Z/27ZvHowpRQkL1OAGtDJVeYshnQEcVe1UI3YykLaUSJsaf+EDXStKK6idjpoOh+MQSFTZB1pO2QJPL/nM1+4wsbA/TeJbokM5pebVs1kXfd4QzVBf/1qXOaxPk7avvZGIj8Wa4iRXHGUb7mGHFTG9ysrwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410725; c=relaxed/simple;
	bh=INm3vf5DC+vwMLktOV9r3TfVA4RPJsJgoLGxXorIyys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=adUSLgnQen3ODLPOibAihJCR2Nzt1SxXtLT2Wgpjvvjy3f8RhKfLxIVfL2r0iXsqScDuZ/6XNr6YAwH39zLP/BdIIxpLxaonap8S0YfHqmV242t+2Ch1lu3akXYScusvCw79ACGayOwKMqCDxGXmeqwo8dmNoAKtRaVzsJre29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J7q9pKYo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gEYeVuZV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7q9pKYo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEYeVuZV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780410723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFOlMoZLgQnzCkQE9GiR1XVr30XojbF7TAtnbzsdBck=;
	b=J7q9pKYohgvVIqinN/4EuBDpz365tfPtXdXEaDYpxaNV94Fv+EY8aaVdvysgJErS2YvSDK
	L/tgG5L2yTNqTjnUySyNY7ccvpKc6UwZC9EAUvtkYJPvyjNwlDcamb9pQMfxeHrvZ6Y47+
	PQ5qtkF50FcyNcqOtjlhnR61JGveijs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-517dh5Q_M1GZiKBfKGGp8A-1; Tue, 02 Jun 2026 10:32:00 -0400
X-MC-Unique: 517dh5Q_M1GZiKBfKGGp8A-1
X-Mimecast-MFC-AGG-ID: 517dh5Q_M1GZiKBfKGGp8A_1780410720
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9156cb14b1cso320921185a.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780410719; x=1781015519; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JFOlMoZLgQnzCkQE9GiR1XVr30XojbF7TAtnbzsdBck=;
        b=gEYeVuZVZRda6OQ3jsx4+hRlP4hh+8TIqDK5g9G3SqnKHVNTDYxzju2Mwho6aDeKLQ
         vsCd7NFjXZze8n9Xl28pp0vT21q9JFZZJ9FQHL4B5O6xYl7PRXVrylWuRo8xFR5mKiGH
         O41mB0zlIl+FScqLmosLfqyXXQBadkiqi99Qpz+N7kb7G7OFm5jky1a9o9MegGPgavAw
         H7PggX3f4xXHZto31FYlTbRQ6GWxkfW8kf6dsi0YFgMuxYbfUmZEpXwANNuw26WMOOcF
         ctuw8tNdqHNVrddbWZRkaFfrUSvagNVji9JTtoDqShpwgfsyqLJCRcq03fuDXJQDdjP3
         nLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410719; x=1781015519;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFOlMoZLgQnzCkQE9GiR1XVr30XojbF7TAtnbzsdBck=;
        b=T8Gw1gCBuoRtIN8B3eKb8M99/vaR1y++ILHcvEZscl4NwAQlHyGDpG6chJYGqlJrqV
         dmDOiHDQyqoN6iOSSvaSK6BjIiUV3nx1V/YyqSIULnp0EobDs9u8moG0AbHLyk3PkuDZ
         bGp1MqjjDRKPeD50ZJGmF5zBvxBx8RK9eRTUR2ATIDvgEwvi8OBqJKgslJRiUZm/nsn6
         LclJZIyCBVA0QWOW8Qdd7HhawT9DPZYWKg5aKhTmU+Txkz9VOlTwWDlhW2HVkjVarnnA
         VyEeCThC3mF2LX3dhkQuH4LjR+5ghoHk6klSQNDOz9mESCWUPrRVD7YPEeF9J3MtoEFw
         4OPg==
X-Forwarded-Encrypted: i=1; AFNElJ8Kj7YsHYeEAjwPqvppDlyjjeOC4CSK6HX0u8wvXfK1U4JsvR+ELiIDulyfWlIsXJwbEHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ3ujN+CFYQ7EgFOzLtNx1lMxTVtDod/Rn5rxaofEGoGikBMtd
	Lhqhf3oPx2IbL0Uts6vtUxMlwBgNreE4LvC0APl1vZFYaJ4mvVJDwBmTIa7/5jEiSJW5my/snqx
	hA4WX+vG4BBkrfCNHWYGoiLKiaU0zSo1ksWOJWqjIg/LtIZjUhHNALhtC79vKCw==
X-Gm-Gg: Acq92OEk7paXvnRmtSbpfZ2z3u96+Xw+qYmN+hak9+JNrNpbAyxsYSgHBMRZ6m3XQXZ
	bl3wqcU5bZcqMNQl1M5UWbD2Vqdce4BtSBbl+oVkvJEczbtBeJyPSrFA0X2mFiycSnVGLUky08c
	plbSRx7ZGt18BXg3Ka3iOXhywMSrBT4XM4rEASXihqidN3Dc/I0XVDYJUPC6N5+ljjxlus27KJj
	ereS6nXo7Sc2l9JvnoKseBMD058aPEB0ssrpyhkIaOFvx13nBmt2ih5yU5HbUKpPwD+8cHuUsXD
	+PLe1msl+CV42M/fIf8dMxfjZp9ImBPkIn4pWHWSoPFLjy0obM8u7mJhzEFapa5kP9HMuHid/Pb
	4CgGiWgBnNwYfZxKY9tm8KLTBe9Ax+TsD7yzAMdw=
X-Received: by 2002:a05:620a:29d5:b0:915:29cd:306f with SMTP id af79cd13be357-9153dbca062mr2493808485a.55.1780410719490;
        Tue, 02 Jun 2026 07:31:59 -0700 (PDT)
X-Received: by 2002:a05:620a:29d5:b0:915:29cd:306f with SMTP id af79cd13be357-9153dbca062mr2493804085a.55.1780410718922;
        Tue, 02 Jun 2026 07:31:58 -0700 (PDT)
Received: from intellaptop.lan ([2607:fea8:fc01:88aa:f1de:f35:7935:804f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532650e85sm1286151485a.42.2026.06.02.07.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:31:57 -0700 (PDT)
Message-ID: <c981e4e208f02e3f8d834a390d12751578957421.camel@redhat.com>
Subject: Re: [PATCH 27/28] KVM: SVM: work around errata 1218
From: mlevitsk@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com, jon@nutanix.com
Date: Tue, 02 Jun 2026 10:31:57 -0400
In-Reply-To: <20260505195226.563317-28-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
	 <20260505195226.563317-28-pbonzini@redhat.com>
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
> According to AMD, the hypervisor may not be able to determine whether a
> fault was a GMET fault or an NX fault based on EXITINFO1, and software
> "must read the relevant VMCB to determine whether a fault was a GMET
> fault or an NX fault".=C2=A0 The APM further details that they meant the
> CPL field.
>=20
> KVM uses the page fault error code to distinguish the causes of a
> nested page fault, so recalculate the PFERR_USER_MASK bit of the
> vmexit information.=C2=A0 Only do it for fetches and only if GMET is in
> use, because KVM does not differentiate based on PFERR_USER_MASK
> for other nested NPT page faults.
>=20
> Tested-by: David Riley <d.riley@proxmox.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> =C2=A0arch/x86/kvm/svm/svm.c | 12 ++++++++++++
> =C2=A01 file changed, 12 insertions(+)
>=20
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 3895d8794366..fd79874c5f4b 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1993,6 +1993,18 @@ static int npf_interception(struct kvm_vcpu *vcpu)
> =C2=A0 }
> =C2=A0 }
> =C2=A0
> + if (!is_sev_es_guest(vcpu) &&
> + =C2=A0=C2=A0=C2=A0 (svm->vmcb->control.misc_ctl & SVM_MISC_ENABLE_GMET)=
 &&
> + =C2=A0=C2=A0=C2=A0 (error_code & PFERR_FETCH_MASK)) {
> + /*
> + * Work around errata 1218: EXITINFO1[2] May Be Incorrectly Set
> + * When GMET (Guest Mode Execute Trap extension) is Enabled
> + */
> + error_code |=3D PFERR_USER_MASK;
> + if (svm_get_cpl(vcpu) !=3D 3)
> + error_code &=3D ~PFERR_USER_MASK;
> + }
> +

Hi!

I wonder if we can limit this workaround to a range of Zen families at leas=
t.
For example, maybe limit this workaround to CPUs older than Zen5?
(Assuming that this errata is not present on Zen5)

The workaround does look harmless but still each workaround=C2=A0
is an extra piece of code to worry about.

> =C2=A0 if (is_sev_snp_guest(vcpu) && (error_code & PFERR_GUEST_ENC_MASK))
> =C2=A0 error_code |=3D PFERR_PRIVATE_ACCESS;
> =C2=A0


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

