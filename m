Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE647986D
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790031349; cv=pass; b=JknH/zs5pEJQEmrz6GgDJNw7tBYdn0u3XXESTPevZShzJx8JwxGpUpCMZlAD1pyLyEhLrskX0otRAUAafvF4QKyUjNdMZbiZm89yxzjRu3sG4gkNNrbMFd8scOS1qKaq1Q0eQ+CUGyL94mXfoxxrv83gy/+Gjh5zXfrhpd+8zmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790031349; c=relaxed/simple;
	bh=hyJLCVJxZDQDHfQeiCxaRFPeeiFOJ1V0CZ8eKBM6X+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAX7VSjnsuwHtk40jJCSL9SVmXB3Wl9Z5mjMsT+81eKiPnG8nVyNCvF+3c5AiSLHb5SHmyFWECJ6YDyChVPELuW65YqIN8u6AlJsSGHlULQG1EpGVbS1tpupwx8c2UGtjKNd4q6xAMPUyPqXPu03n4lpbvhLKC3MoEkdDOBILtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+9x8apm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0rpvREZ; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+9x8apm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0rpvREZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790031347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dX1swF85DcFrMT9o2ilhYKNWxIuRVz3Jd/fKWtp4O04=;
	b=M+9x8apmch+bIoBKCBbq9LPX8D/188cog2jiF1C+vuNfPPXUihph7w5w6ZlNVnKT8ykAdy
	mm8g+Yp9+DtLkS283BYNG5TE/6vksPD1yhxcb45R1lhjsRuco8xCjj9Dv7CpX1AfXv0N4m
	wjRFY1F+9W5Vc9weBUEdR1WX+qqSSNE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-57ObzpuHO92Tw0c_PEUS-Q-1; Mon, 21 Sep 2026 18:55:45 -0400
X-MC-Unique: 57ObzpuHO92Tw0c_PEUS-Q-1
X-Mimecast-MFC-AGG-ID: 57ObzpuHO92Tw0c_PEUS-Q_1790031345
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4870663a5c4so1173342f8f.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 15:55:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790031344; cv=none;
        d=google.com; s=arc-20260327;
        b=iVJtrmH0kN1vsoad+0Cc2pVDg9UevaPdptgNP6Bxq4fpL+rOESIo8ht1FbdwlrqLv1
         nwH0Xcy4DaerV18prTb/LWbac4scnonACEMfNbCQ1j4kTLCQFfOnlthf2YyXYV+eqWjZ
         NqhuUkRhdDceUV0JZHg3WOsjBx0lPc0qIVLVU2W+V3DXV09B2qpAMfqnYdn4+K9y1opB
         VpytCR/W2s/dypQnQwi68Bh10/RVQTLZ0vkJ95EDxeTM7vKY9YEeTwIafOk/wDpG5Cyz
         du7Ns06PcwTAlqaWn6vy0kndm05KJOKaVyFQ1LyTf/uMDN1wcsqHvW40V+S/27P2KOAd
         FHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dX1swF85DcFrMT9o2ilhYKNWxIuRVz3Jd/fKWtp4O04=;
        fh=ajUKCufCN1aA//NIf+V7Cja+HpEklHJNc+aqcNjUx/w=;
        b=nXV94ogc4Afvl5G7DBmk6C07/S/eLzVPy2DQqI+s+azOUVG578lpP7thOgO+FvXY1P
         u5gZsVy+1N1T6ns8+M8SENdXplCwdorXs1aLAAwOeYy83SzyO6ye7oMgG7cz/lcgHvLg
         WlnB40rKqAshvhAlhdaPI24aXvWZMYDMDS6LnaW/sJMEmmgjXHaA9C9ea4zT0z97oDr5
         u30G7SEeKSLSf+V28aiQQ9LNLci5Sq1OkFavTTlwXgyhjB/VWEs14VfmCBp40uu1ko1e
         2lEGe6VmeUIjJBpSST+N/P0MnpUonJlED7awsNdrIKE0v3/wRecjcNF1fGy4zP2qoYDX
         Wrsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790031344; x=1790636144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dX1swF85DcFrMT9o2ilhYKNWxIuRVz3Jd/fKWtp4O04=;
        b=L0rpvREZ06pO/MfnxK1HlXIf2ys5jTyGJfSlTqP/9VnkPw99O4DmynyfYWEuVWeO+x
         O1EtHo4VsYE+Gx2fQycjSRizBpW8AnAWQjH7Y+kpQJc6/2E6dUE9GLXydKlBmB2ZMOIS
         Zyj3oWyO99c0+vlMOoOPXutJQX034rboTb0joKuQLeeC+9jU0JF+KJ1cHKUBVzUgylVK
         hFsQ9TPuw9FqkDGsEIFpn2aVzbhkR8NncGFF4WDn7rtpyhEeZMLkN0bMWnz0cFdPDGbi
         6BorISDjqLIvx2s9H/lu3gRd89hCYhQOnPsY/65t7UlbmJqOZuOiQPTAonoBpBkDnfoA
         AoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790031344; x=1790636144;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dX1swF85DcFrMT9o2ilhYKNWxIuRVz3Jd/fKWtp4O04=;
        b=c5X9W4O8aBRJ0kUFdPlw2jXleYRncsBXwMRXZEdACoTC5aNDizjk1bj5GcHWn46BnP
         HYjDdzwgVnd2ZUzNIDl4dlll8pnpd614zIzQDhPEC7LVdu4cmSk9RIghAhkiS0fsvfUC
         qc1KyPez7ybU03jahISza8v4OvbtMjHc+RvAORTRnTC1HFmkiZUifpLL6kxJtHcrcI4y
         XMNbstAW994ne8ztaFlRKMu4gjuNXoABhAOrw9PgOi619O6Pok15TpcfeO3NbtQtGEfx
         0fEnuA0pKFedIcPvSldqBabJCDQ1bptoALA0EIXxwGHyEpZUcsVJ8RrDokswfYEQaxtC
         zv8A==
X-Forwarded-Encrypted: i=1; AKwUvBzrEdtF7pGGAkrwB0y5p6tXbGG3ht0gwOdUVXxub5/mpz14EswCjkjZLd+UuHIIs2tyTa0=@vger.kernel.org
X-Gm-Message-State: AFuF++nLJW6d++W3kiUnDc+WpyNq+17N40VTnsI6IpUY+deO2T1AW2lg
	qnkeBKgb7SAdVwAcbyzzrrKDhnkmvTO5tBswmf4LU/t6M21dgTv5xyl2Ki4oYuLxZVvO5gKyaYV
	LbQ9rdZHJe+hYdhq5JgItwFCYV4wefSxCt+lp2k5Je7MOGf7U9StdFjtogiJ3I37B8IHGLft4uX
	rbHWF1mjpU5e4pNXHot9v/uumymlfg
X-Gm-Gg: AYBFou1Fy/at6l/hXzXH1F16jdtqVQFzcB6hZnfQyt/KX/2oyUGjZUZL046EXWU5ZDz
	EL5G+jARk3XFO8Pj5wx5dvawsdH0Z3P4gbnpfxt1iZmg8xO9llexxZugsJlIZW0XF9rT8vkvVcY
	z7p+YmbmSQB3109lWcXVeZqyXCObEZFIT5GIaWjWZ5mj9IQ6EVkfy0/6+5oo6cVg0RZsFrjFbWe
	nwHkUZZAz+Ny/CF5YN2nRPPnAgnYgBUaDajROFYlGnpRvh97lNXbwWjkSCzWQ==
X-Received: by 2002:a05:6000:4308:b0:487:c4c:b7fc with SMTP id ffacd0b85a97d-4871e211314mr20146996f8f.4.1790031344708;
        Mon, 21 Sep 2026 15:55:44 -0700 (PDT)
X-Received: by 2002:a05:6000:4308:b0:487:c4c:b7fc with SMTP id
 ffacd0b85a97d-4871e211314mr20146980f8f.4.1790031344377; Mon, 21 Sep 2026
 15:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918094322.152817-1-pbonzini@redhat.com> <arG1Nh2yuMQyAdhV@google.com>
In-Reply-To: <arG1Nh2yuMQyAdhV@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 Sep 2026 00:55:29 +0200
X-Gm-Features: AcwNN1VWqZQpaC_UL0aFGn2RScAhYhRmCJ5aAiPwS9zJLHLF3gP_gxg2pCi6hao
Message-ID: <CABgObfatLAp3AsPktQVtVq0MgeJV1Bw+54i5LKye5KzjVPqbyQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/hyperv: do not overwrite hc->ingpa for slow
 SIGNAL_EVENT hypercall
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 12:52=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
> > diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> > index 9f5adcd26cba..e3a8e8236230 100644
> > --- a/arch/x86/kvm/hyperv.c
> > +++ b/arch/x86/kvm/hyperv.c
> > @@ -2501,6 +2501,7 @@ static int kvm_hvcall_signal_event(struct kvm_vcp=
u *vcpu, struct kvm_hv_hcall *h
> >  {
> >       struct kvm_hv *hv =3D to_kvm_hv(vcpu->kvm);
> >       struct eventfd_ctx *eventfd;
> > +     u64 conn_id;
> >       int ret;
>
> This doesn't apply to any branch I can find, and there is some unnecessar=
y variable
> shadowing going on here as well.
>
> The actual change looks good, but the diff is wonky.

You're right, I probably generated this from the wrong branch (or
machine). The right patch is at
https://lore.kernel.org/kvm/20260918135030.171564-2-pbonzini@redhat.com/.

(BTW, I would like to talk about memory attributes and kvm-userfault
next Wednesday... and whether those are two different things at all).

Paolo


> >       ret =3D kvm_hv_hypercall_check_params(vcpu, hc);
> > @@ -2511,14 +2512,16 @@ static int kvm_hvcall_signal_event(struct kvm_v=
cpu *vcpu, struct kvm_hv_hcall *h
> >               int ret;
> >               gpa_t gpa =3D hc->ingpa;
> >
> > -             if ((gpa & (__alignof__(hc->ingpa) - 1)) ||
> > -                 offset_in_page(gpa) + sizeof(hc->ingpa) > PAGE_SIZE)
> > +             if ((gpa & (__alignof__(conn_id) - 1)) ||
> > +                 offset_in_page(gpa) + sizeof(conn_id) > PAGE_SIZE)
> >                       return HV_STATUS_INVALID_ALIGNMENT;
> >
> >               ret =3D kvm_vcpu_read_guest(vcpu, gpa,
> > -                                       &hc->ingpa, sizeof(hc->ingpa));
> > +                                       &conn_id, sizeof(conn_id));
> >               if (ret < 0)
> >                       return HV_STATUS_INVALID_ALIGNMENT;
> > +     } else {
> > +             conn_id =3D hc->ingpa;
> >       }
> >
> >       /*
> > @@ -2526,15 +2529,15 @@ static int kvm_hvcall_signal_event(struct kvm_v=
cpu *vcpu, struct kvm_hv_hcall *h
> >        * have no use for it, and in all known usecases it is zero, so j=
ust
> >        * report lookup failure if it isn't.
> >        */
> > -     if (hc->ingpa & 0xffff00000000ULL)
> > +     if (conn_id & 0xffff00000000ULL)
> >               return HV_STATUS_INVALID_PORT_ID;
> >       /* remaining bits are reserved-zero */
> > -     if (hc->ingpa & ~KVM_HYPERV_CONN_ID_MASK)
> > +     if (conn_id & ~KVM_HYPERV_CONN_ID_MASK)
> >               return HV_STATUS_INVALID_HYPERCALL_INPUT;
> >
> >       /* the eventfd is protected by vcpu->kvm->srcu, but conn_to_evt i=
sn't */
> >       rcu_read_lock();
> > -     eventfd =3D idr_find(&hv->conn_to_evt, hc->ingpa);
> > +     eventfd =3D idr_find(&hv->conn_to_evt, conn_id);
> >       rcu_read_unlock();
> >       if (!eventfd)
> >               return HV_STATUS_INVALID_PORT_ID;
> > --
> > 2.52.0
> >
>

