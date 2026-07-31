Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E219431A4C
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511587; cv=pass; b=INt8a/4ZIZwVQI63Td4/n1bwigkazKhyUXc7PnTsCAn3rUBCNNBEG0A7aBFINGsJ4hBAnPcDxnGoBroqNCLeVXARboLGn/LIZ2s711wl48QXTy6RjtATz7/0KbyUDL1M4hQR7gtlLO/0ZqRUV/lcUaVT73/NKh6dT6Cy8bb+3kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511587; c=relaxed/simple;
	bh=Pqrxltx6JOoP2Zv/1hEr8b44mUXs8JQJvJvfObJb/WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTxAT17jV7vjytKKOas+tNG7BsHTMuQ9Ma5x350gxxSUV9ygHLRR4pb2vFee2nuXySt0zHJ7dgQ3RM/Ab9jEcXDBKgh9cKkNYQmaz8T6dt/KARNx6VEZLZHP3dTN4f5MeMYYgx4+WHzgjA68BykZPhOlVN1caxhKdKupJ8gzFNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lu4O9DdX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gste/wW8; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lu4O9DdX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gste/wW8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785511585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwRPqdMP8W3EiF2fWFL202f4T2ZS8qMGrqjZ1PmM9Zg=;
	b=Lu4O9DdXiVS42nhmXsqWAzZkpeJCpdaWr0Xxsv3s0RjAoWJNI+y2cWbGUrhXoEsS0HkF8h
	pbsGE0Hnvjyr2qhwve92u3tLsSHQShHsUJiQwhHYcZ0bwwV7oiK7SLXVx0nvpbVGWQyZCi
	btVXbQ900MsMDyjEFb7wMKATAuR6Nco=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-VP0ldQ7WN0mLKRCPFXtfGw-1; Fri, 31 Jul 2026 11:26:23 -0400
X-MC-Unique: VP0ldQ7WN0mLKRCPFXtfGw-1
X-Mimecast-MFC-AGG-ID: VP0ldQ7WN0mLKRCPFXtfGw_1785511582
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-69848bef5c7so1049168a12.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 08:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785511582; cv=none;
        d=google.com; s=arc-20260327;
        b=rMFn0I2tuN+vZTyWturIdb46vvmbCNLQsGuJZcnJSw4f3lxhl17bIo6/bW6hFEBgBD
         4aBnL40CjL699vAl0d8XQZRMRjD+9+61dbz1GXj9wLFD52XtJJn/j35VS/ROzRihQK8U
         S9SM08eClfGDKUZfrtplK8OwLnh9xWLv6/4zvmjZQuHUKjKHWptEytyeWZUKFgOLA59d
         V8ZITom/Ljg77iU7lY02qLH/1Jc5WC83j2CUL84BZnMfjWNzh9MF6qPL8qNLY/txf7an
         JPWvp3gIrIJUIRajUwI+sY+UiQb6MAmnfbgL7V44MEOuR12CEm8ZJ1XvmkhlH+7K4GQj
         0rSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XwRPqdMP8W3EiF2fWFL202f4T2ZS8qMGrqjZ1PmM9Zg=;
        fh=CZQVXc/hc/Tt34ixfc0iKneom/R8iQnML156jpyaps4=;
        b=E9OWeavadJYjO9ES6LZMCzXqL6ABye4pP7VZZ2Pr2Zmjg3Yzgp3UhPn/nn6aTHB6vx
         Q/3BiU5uIj2o3DNGG9/qMpo3x3iMsfE38lZl6QAuDGW7UxDVNOlsKBJpD5hgDIJ/kskL
         ohIQmZR6EpvU6P+zNu/2ZMoPfShOB+wgFBxwktj0PuOtA5siZ96YibbfdPVl51tsv4Bc
         qaPRQGOHrgGCPK0TNBMsmLN1kKLrA5j/wry4c8SJCVCXvQWzoduuDwd/a2Famnz3lNZd
         QVPMDoo4VI8lYoVihmCMdCc6jGc1jLzIXS/m4PH5iuClYRXZdYN52XoRW873kZC0EDCn
         TySg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785511582; x=1786116382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XwRPqdMP8W3EiF2fWFL202f4T2ZS8qMGrqjZ1PmM9Zg=;
        b=Gste/wW8ZBSbrXjiwslpOeiSR7M3d00CvQDS8ZpzFRyTUV8GAV90QNGfdrRjmWj1tX
         EeNYYwDM4yUgKAp0RbSXihYsKLUxqugY+LLiwbiJsXXP+m62LUZxkmWMtoEmXPmlXjUF
         7Hn5UToCRgSTW5bA5PdZewJMzuG08OckMBGsdArv4GRvgnywCnN1OjmbgcExU+Y+f4D/
         n93TuD/1BW6ulU6Qg08jCrddHKLXjlv5p+2oI1d7I5sMeegzOGvfoMAo5ewW0QodX9St
         WXtrfqkjIvC9sAt1PtHuC9h3l+n/EPmZd9tNggzezykbVypcaRcZmLRlkWn1LzuhdoBK
         1c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511582; x=1786116382;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XwRPqdMP8W3EiF2fWFL202f4T2ZS8qMGrqjZ1PmM9Zg=;
        b=ZFVsAdRUhbTPjJ29FTL3nLbvfQG89uEj80oN2DOlLrewzi9qT6oi3lGvk0ByvlMyr9
         ULHAAQrr+jltNbFpPcCugfjw8WWbHh1fwN4DeHz+3KAXEE2VJQ7R9dRb8hqLyOA/HIIp
         ECxhPb7h4gq0r1ke1F1u+G6rt1cn2jaWVHgRMByPSXiOLiuh/VmjuEtY5Bluw+v6mZN6
         7D6r45isqF3njTG7B/cm8/WkI9srKICZ0DkoGo3vuensS08wMzjkyx2usAtolFsk+FUV
         WAtHmkRvT/5BAjLq9+CspKUfhvRFkHR5zf99zpvfVfFYadiGzetPI7yGBisabQSz+WT2
         v2RQ==
X-Forwarded-Encrypted: i=1; AHgh+RrBtAmEtF/GPJ5ehY7Mc7QfgQxyR/ps3EAxNoZeG+2RjftHegNtJnr4n/E9WIOR8oodYpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybIXyqWem5Z0mj6yCRw+yf4MIwm9uUGvsHkkqHbPXLXKp0ayEH
	NJOHnu4eUWVfa3YNf4bmUP2+ANI9pzNe8HdmceqVt4YOnIoQrVaElta5sDQBR3ABGsD2rkaOXnT
	Zek4Xyxa2/C7X7Xm54MeWbl6/QZsjhiRw0f2a3h7/twv8ihjUDMtAZpbGRTTuU5XLtbw7MGH3cB
	rfxHxo7L8NdKzleeQB48XLbNyhSFnnSdRdSNaWQwE=
X-Gm-Gg: AR+sD10h1Ay3Kg2SNbbi7D/YGPS0L4HsMqWT8/SRgfzGHHeM9PU7fH1hetuEJ5XYW4P
	HJ3oDivyEf7c1iEriDIbFY0vbBO7+m76PR6R71gh7xSCAcTnzLK9O6U/cmrZNu8VBhHsrwr8Ckj
	oHQruQLofr0UmZr6g0DmOJfwnlf2Z0GKRmgE3tmu2P5LQszbEk6XqiJoogCd6kocJ7kXJuJzDWn
	SGIlLcmmuC95Q+MH15Bmquh65eDqQme6Ss7ba8l+0x3DEr9KZ4sjfisgnA=
X-Received: by 2002:a05:6402:538e:b0:698:6620:d988 with SMTP id 4fb4d7f45d1cf-6a0a7ca9786mr43945a12.15.1785511582242;
        Fri, 31 Jul 2026 08:26:22 -0700 (PDT)
X-Received: by 2002:a05:6402:538e:b0:698:6620:d988 with SMTP id
 4fb4d7f45d1cf-6a0a7ca9786mr43920a12.15.1785511581703; Fri, 31 Jul 2026
 08:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729072044.25796-1-slp@redhat.com> <amuKVfib5kela8AD@google.com>
 <CAAiTLFU1ALsDoJoKW3d9bUvv990AozAoX=bEHmfnG54qyBAHFg@mail.gmail.com>
 <amybygGUiPlbiDE2@google.com> <CAAiTLFUFDa5X+Gg6WKeovcs5h3D9kDRaU1MYFRKdspkJSpiusA@mail.gmail.com>
In-Reply-To: <CAAiTLFUFDa5X+Gg6WKeovcs5h3D9kDRaU1MYFRKdspkJSpiusA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 Jul 2026 17:25:46 +0200
X-Gm-Features: AUfX_mx1yOpPzP-V8gfKcz5x8zAZvpde5a6CoE-Fy96JaL_yAc9qBKDl7JYHuZc
Message-ID: <CABgObfZ-TofpYGLqa9QdVk8iwa_4E=RjcbTarJfLX3wMYdwPXQ@mail.gmail.com>
Subject: Re: [PATCH v3] KVM: have hva_to_pfn_remapped write-upgrade PTEs
To: Sergio Lopez Pascual <slp@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 3:37=E2=80=AFPM Sergio Lopez Pascual <slp@redhat.co=
m> wrote:
> > IMO, that's a bug in the APIs.  If a normal #PF handler looked at a wri=
te fault
> > and decided a read-only mapping sufficed, that would be a bug.  I don't=
 see why
> > this is any different.
>
> In the scenario I've described above, were a read-only PTE has been
> installed on a fault generated by a read access, and a second fault is
> generated later when writting to the page, we aren't invoking any #PF
> handler. The call graph looks (roughly) like this:
>
>           kvm_handle_guest_abort()
>             =E2=94=9C=E2=94=80 gfn_to_memslot() =E2=86=92 gfn_to_hva()
>             =E2=94=94=E2=94=80 user_mem_abort()
>                 =E2=94=94=E2=94=80 kvm_s2_fault_pin_pfn()
>                     =E2=94=94=E2=94=80 __kvm_faultin_pfn()
>                         =E2=94=94=E2=94=80 hva_to_pfn()
>                             =E2=94=9C=E2=94=80 hva_to_pfn_fast()
>                             =E2=94=9C=E2=94=80 hva_to_pfn_slow()
>                             =E2=94=94=E2=94=80 hva_to_pfn_remapped()

There are two different bugs. First, let's look at this case where, as
you said, fixup_user_fault() is not executed. To force execution of
fixup_user_fault(), you'd need something like this in KVM:

     r =3D follow_pfnmap_start(&args);
    if (!r && write_fault && !args.writable) {
        follow_pfnmap_end(&args);
        r =3D -EACCES;
    }

     if (r) {

But that's also a bad idea for two reasons. First because you'd need
it for all callers.  Second, because all of follow_pfnmap_start()'s
callers anyway check something like "write_fault && !args.writable",
so the function might as well receive a new args.write_fault, and fail
with -EFAULT if args.write_fault && !writable.

Separately there is the case where fixup_user_fault() is executed, and
which right now would have to be done twice. The drm code already has
a solution in try_insert_pfn():

      /* Unlike PTEs which are automatically upgraded to
       * writeable entries, the PMD upgrades go through
       * .huge_fault(). Make sure we pass the "write" info
       * along in that case.
       * This also means we have to record the write fault
       * here, instead of in .pfn_mkwrite().
       */
      ret =3D vmf_insert_pfn_pmd(vmf, pfn,
             vmf->flags & FAULT_FLAG_WRITE);

The driver could do the same even for PTEs, not just for PMDs. The
issue of code duplication is now on the other side, because every
caller has to do the job of .pfn_mkwrite() and in fact the same bug is
there in vmwgfx. But the exact kind of processing to be done in
.pfn_mkwrite() is different per driver, as opposed to
fixup_user_fault() users, and there is a precedent for the API with
vm_insert_page_mkwrite().

There is no function to do it, but that's fixable. I will send an RFC
series shortly.

Paolo

