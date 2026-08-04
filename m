Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492E43EEAFE
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785829448; cv=pass; b=Z2hUTVeoEYLzXXT+o7Y+fwhGsCD3JN4uZNQotwlwcsjFCR9nXXMJRHsJaifelEnbOYlAvteXCmI0h2vdy1BsUOBiCllrfXy3ds8PZPdG6F9GCXoy1q4CIYuSuHiiGdEKHjnNwL8YfGeZBkdEj9iNcTaxg3W4aAa2cF6UXbmxoxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785829448; c=relaxed/simple;
	bh=Md0uUDvXSXYg6Min9kFS/7ZZuZQPQgNP00ZjBzqZUPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BK1z+2qpkb7lVz8gltyDs3bd6MfFUA7gUrO7gtATPeLQkVTlyaOGiX9lnCXZoTt2A+RtImlcZi/eqc5TcomBC6Z8i3eV7Bimys4aaXvisW0CeQR5YtnwotxjQeMyxy6gUOijJ8LfkxcnYns2Vs4q1iQdJ4qvjl1G8U9/kgLJXBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LT98Uom6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9zhTZeB; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LT98Uom6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9zhTZeB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785829446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JuJ4T7YMURULM3HSxrDVFMFMsakI5G9cZVqfapUK9bI=;
	b=LT98Uom65wL63EpOhrXXexw9W4j0fO6himfXPxvoBpFXJm9ToSSyRcy6JaqIByefWAtEC5
	uXZTUjNd+bE673UTnZAVcGslonh2KpkQD7ggxtgGG4/SkKiZ5cXcN1R6unl/ltkrxsf2bq
	ExCkQuanQ5Q+y24Bu8lJz0irlU8yd3Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-V-_6sfo0PW2-NbPfZNwJVA-1; Tue, 04 Aug 2026 03:43:59 -0400
X-MC-Unique: V-_6sfo0PW2-NbPfZNwJVA-1
X-Mimecast-MFC-AGG-ID: V-_6sfo0PW2-NbPfZNwJVA_1785829438
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47162f83c75so343901f8f.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 00:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785829438; cv=none;
        d=google.com; s=arc-20260327;
        b=lywaa9HBkuYDt5gOkajFKZ0x5O6i0SbylLgBITrex1k+ZnH1R4ax+EeKjXv6ES+QV1
         o0uZ1ELHe0XNJ6/8hFHDL9UpUiH/dZG10pmQPqYblT0B9Lch7GY+phjhafHIrwhcgKyg
         HHg+/IgTalER0O8n09CDamO2WuMxNY3J4G11qm7TweXoLTiIt8yEaSD5jBmEAKfjGhE4
         0onbvkxFZ2t6j4bjRwJF4wd2gn5nuriv5VZmZsuhbtccsA4q6P85dOGvB33yoaL527R4
         7h5h+bO3bBhkbcHyRFoF+DAVvagmGQC1eyy8mvr4N7amyzl15IjTPGEjTZEc/xHuiW8H
         VksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JuJ4T7YMURULM3HSxrDVFMFMsakI5G9cZVqfapUK9bI=;
        fh=QxC/NDOpzaogPKu7jYTr5cy3J2+akTvb11mjvkZbyFU=;
        b=bUV9NI8zIPVGIR2f8g52TjaQh9ka/dJ8wpepUP++jkf3BWt4W4yuBrNnFJmtV26w/2
         7GsSdS/rvRsBc/ytJa+mvDzr5vbP1I395lwgxlLg2hTsQVpE2bSjQURU571QUpIzph6Y
         eW6n+tmWY2DU2JR9XsayQcYnyiUcJQwbTg8V8zUe7vY3yUya9bY6Pg+axP7eHmRcXz1o
         NzMAcxlSfmjacskkxyVpBeTkSs/pYixH1eJtuawCsrWIz+8wEIMNUmQs2RwQUNZwzRfQ
         Rz393D5oWWmsgFOOUXJKTdTIgQZebCX4PU+/fehZp1ru6+Hjtw6zs8D3mvpan0Ng0eMR
         JeCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785829438; x=1786434238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JuJ4T7YMURULM3HSxrDVFMFMsakI5G9cZVqfapUK9bI=;
        b=H9zhTZeBelk13CzVMYTGonDLpMpNyEh1DOOGRqhIaEXYiI+tsIfdqTWcbmDeyLWYHG
         CjfWcKruBeZiFHswOd1ZiC/lpLl8BT7zNDVerYgQSMgtNKMV+4OaCNytDWY/4W2QiuMD
         Y3QScDRnhliU5sdb7/V8YYEJVmPGO+1udq9urgQ+T8yxUbEQBOsAtffklMGGUPVhZXr8
         ZiDq5CBV+GsR0Bwc4C01OLGXphvyz3bQ4vqC4Rg/vpLnPFelmYE6e8pjztvNSshzDZ9S
         E3FIrAZ13OcOpzb39tnmvHEWBn3JwVawK16VyKzxpivmkwrC5tV5bPfYEMLMV4SYz6+n
         q2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785829438; x=1786434238;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JuJ4T7YMURULM3HSxrDVFMFMsakI5G9cZVqfapUK9bI=;
        b=KnTZONxRuiMpwSXVmHjB9xhwiviapGqUD8mmSKMXIyzV+uD+yYawXPPugbupGa53Bq
         Vmh+QdTVDy5Uu2Rcp2uk+kUZ+6B3P7l0nVUpoACuSdGgt/qH9G66VwnjZBlqSi88N2w9
         5nV+cpNaJzE7nw9GEpFwh1YZ5OSgKgDqpqIIUeNN/mjXqZSONFv5Uh0q1I6RtHjhOR3H
         QYQHe4yjX3dKytQoU6+39KNKQvygXWSDwWPZtN1xwWkS17fCagUigr0ybMki+c/nEpZn
         288hnTh7dxX9W6JadXSZTonTb2RllhNiDPcp70zi9tzpuCySGT1QA0dPAY3/JUWBfKMU
         rQdg==
X-Forwarded-Encrypted: i=1; AHgh+RpQggnFuQPv5S26gZZenm9xB+/SjbN35RevJDyeMTjzuabMPqO+Wpd1BsCnGY/21Q5mlOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbpcMWdvEkMDBG+V8K8bcazMYRx8ahEha1sOi0bGU803OkJAz/
	bxJ7S45Vy43l8nIYG3sJtjuuQlHRsxJamHu1Um/T6DVVwuHP6aKrMxDTbZC3QVLTK8Nm7irFRhp
	7KqiSY/BkUA0RxnuXZi6mpmHa2lRO/ID/PHRaFahjb0GZ/puMMAuey2/pjYJ5ibKRjvOBEm1G9w
	hQmeS/gNY9jGfTSlsa8RcycMNPZPce3/cFAuApYp4=
X-Gm-Gg: AR+sD120B4oXGbexAUNfyCMa8GRadDMWLL7F1YyXo5k6SHq03zJ4AexzhPA7s9w/Nsy
	zME6NOPOQgoKZU0AUjSZvwDfJu4kJk4exs188jchGjw3XhbdT/GLBKATfFN78wL7ffBeMoOkDDR
	5jBdVvT1hxA5YOrvIEQIQN52Temtoo5T8KEvp9k4KVkqZ2MRg93PJvjxQ2QeF1kuqFl2wae251J
	Ry/3wxBSt49lpQZmrmigVfUjK5SQ/bHQ8VC1b7GL0adlFdE6kYabCsvT00=
X-Received: by 2002:a05:600c:a6a6:b0:498:1577:e11a with SMTP id 5b1f17b1804b1-4994a0fbae5mr39911315e9.5.1785829438325;
        Tue, 04 Aug 2026 00:43:58 -0700 (PDT)
X-Received: by 2002:a05:600c:a6a6:b0:498:1577:e11a with SMTP id
 5b1f17b1804b1-4994a0fbae5mr39910985e9.5.1785829438007; Tue, 04 Aug 2026
 00:43:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731175834.1121005-1-pbonzini@redhat.com> <amztmWhHXUR4zBv1@google.com>
 <CABgObfZ5sPgfJz-_reACs5WkjRRkdNuinfY+nSrdHvG5xSiKUA@mail.gmail.com>
 <anCZoc65i2xXNQgO@google.com> <46663836-fd97-4328-8c7d-5efeeb222ce6@redhat.com>
 <anEYxL8kf0O889S2@google.com>
In-Reply-To: <anEYxL8kf0O889S2@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Aug 2026 09:43:44 +0200
X-Gm-Features: AUfX_mwuVEPY2O8FDXouVaAV17hKHXFvDAT1RkAAb5PCK_MTPdOqrkRmjYdV3to
Message-ID: <CABgObfYZvs6rZKSk_Ym=L-vxLHY6WLoo2dL3NneabbUqvZxaDQ@mail.gmail.com>
Subject: Re: [PATCH] kvm: apply VM_READ/VM_WRITE checks to all VMA types
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 12:40=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
> > > But the issue Sashiko reported is just saying that KVM sometimes does=
 what I'm
> > > saying KVM should do all the time: return -EFAULT.  Or did I misunder=
stand that
> > > one too? :-)
> >
> > Yes, that's correct.  My point is I'd rather not introduce other change=
s to
> > the !VM_WRITE case in stable releases.
>
> Yeah, agreed.  But what I don't understand is why this would be sent to s=
table@
> in the first place.

Because the patch
https://lore.kernel.org/kvm/20260731160514.1101989-1-pbonzini@redhat.com/T/
needs to be sent to stable@, and this one fixes a problem in that
other patch. So this one needs to come first.

Paolo

