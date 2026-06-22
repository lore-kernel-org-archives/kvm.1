Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB79215075
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782129231; cv=pass; b=T2T5ir3sNlsKNK83Yd/qzqMqbncIRun8ZHAbU5gk7p/E1UmC8mytjeQMOEZaoHTWtZVjmVEHuAfoP+UOfhIlAyhtjFqiSn1vK0DzcdkcwmToYosj2l9jBM/01A7HuSs++b0z5D7jIo2kch0vRv3WlK/ybLn69cZNlylewki4ujE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782129231; c=relaxed/simple;
	bh=7YxaNe+IV2f3GoMU5nHv8O4OQctVhayImGinD01gk6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxkiOcmMWLM+GyiCPpi5qxcQphqy50GVABCPmflUZoaTRR3lmCEy0/EIR7aS+DQERNhzgMjIMAbu+bhoVNQacGC8pXZT+3TqdDhc+YXdjtZC7wZyKK/LTAVUw1mStxYAa+vg3WkHwjXyy0xJD22PWGCStdBCMI5C78VSBAICoVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZkbjHuNf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DVOokrw5; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZkbjHuNf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVOokrw5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782129229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fh9EbXDsUdt3JnPQT1zJjA204fWMQDrKUHfp8WDHpjI=;
	b=ZkbjHuNfIzXLML+MmTsWkXrDT9SfM/lZNOIULDzl+aA4VD8rWRzuzf0QTxHxpNzLzcKOxr
	Oii/yRQul0g5L66ZMPOHeyoGwKGrOf+471Cy6X3nOcIHQLtb5Ay/6AbzAinAcWy5kyNRBU
	ajuf0hdHptbyEsOQv9KD69nLQ6M6X3A=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-WM81EaKgOKiRGgcWBlf-ZA-1; Mon, 22 Jun 2026 07:53:47 -0400
X-MC-Unique: WM81EaKgOKiRGgcWBlf-ZA-1
X-Mimecast-MFC-AGG-ID: WM81EaKgOKiRGgcWBlf-ZA_1782129227
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso90316425ad.3
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 04:53:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782129227; cv=none;
        d=google.com; s=arc-20240605;
        b=eGQ9PaKHCGaPws00KRaFdu8v8BPOzpFEoVWVuSY890x8EB6qqobRL9KffP2usLKgn8
         Eo6BMYhrmjKICXCZj8uY8vv0EXXsYzLKuXBh/6wOUTjVGPKSLW3XJuX8eaDTa9ueszDD
         bPgA2RvMhBRFLZIc6DVTOmR6OTUuYn7NbdUDp8OhXLgbvkDxDADWzL5emRj6JLgOoFwP
         4dpJJx2zzkgZbYwS3ARb2YEL6ZWFqsC3lOLlmWOHTofDs8S9d96ZrP8Bgmv1XZoe6Rb7
         maGzwaKl7uzf7U1aH6EKu1L74i9VLSANyiKFXKGhqYPfv+cwwQlfMabjUZHuGHESgxx3
         Xg1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fh9EbXDsUdt3JnPQT1zJjA204fWMQDrKUHfp8WDHpjI=;
        fh=BIzKdEsj7aMaoywm+ybDi8y04HVq287ar+HjHtBp188=;
        b=IE2utv8YmA01qQglYaeWU3/z/dRxXg4tfnDAo6dXrUrlVlrxI+q5di0DsXdAcD+Jyv
         Xt8JPz7NOpz9Y5EsSMqlihDuFyB8lI94NNUOgQfnz1CQML9IdA3w5RwkyCx44REgQrPI
         eGgODVi5fRhqHNihnq0qwiSBAsRvsLK65ujisLEOVxDe0F0aj7KKhXc68BMQeE+Mrc35
         JYC9Uo69WCLob7W1BBh/ITZIplKqEwjxqeyonmue8U4g1yYXWewQEzxBRwKfSkzANDlW
         R8tfJQRzsZuzYlwcqGpUCJspY+fxvdKQsJGdWNPcJeMkXSDrWmK6fQ6szAq17dnEi/kk
         +v5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782129227; x=1782734027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fh9EbXDsUdt3JnPQT1zJjA204fWMQDrKUHfp8WDHpjI=;
        b=DVOokrw5Ac6eGMfyoOl4mQJtzfz5mDv9Sp82KNA+9VThcN7onS5hgROnyfTRuWT1t9
         2vOFYlJEiMyhRrqp56NJerYlrco2sGoV7sKTK4Y9h/gD7xncqheaLP3A9hsMIx2CgVGL
         NrtnWnPelkifyhNcIHPgkumRL9p99sdvLfQ1xxmOwUCPrJZlK7lBvlZ5fFwNoudE+pM/
         feRbd2b7d0ppN3bahdgV/AakAuPf5oxzb9QeOZcKqM/BIBVVmwZhZTgTkw7jYBR77CTS
         7uInIEaAJXL/JmvAQbU5f36kU+mpHTXqBzkoO1mo/G8QPBU5OwFPTYaxi0CaX4xAxYj1
         U6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782129227; x=1782734027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fh9EbXDsUdt3JnPQT1zJjA204fWMQDrKUHfp8WDHpjI=;
        b=S3N8Jv/T4cnU55SqbRGDCSlJkdPQ9taqiysRm9qmgPp5I6yDG8dwx/ri9RC4xwneMj
         7fM2Yvp9ECsS0nKG8leguzvIFAR4YnoO1HRiBy9VjR2faMuv+PwSVFLMnzcYmr5s/lav
         Oc/0rpwxgmDuS0opkdU2sM6zrCBSsvIcerM4qadY1AVVC895aCgaUgk7zkFNq48hc1Hh
         DEOXn6RNDnzAIZ8ByUHOTTNyPxl7CeA1XIjOB4KqhhYJEi96ymKzLZV7DjPuX6Y12CIs
         QmmZwDBtsKtQnDJ5cMvAlr7TvEZmSj7uI5O3Y4fLe+adeUwY+NHDiAkOTumO3tk0Ta/W
         mV6A==
X-Forwarded-Encrypted: i=1; AHgh+RqhTPn7pHADOkAwIleLC8lZ98gKksGelqvgOHVDaAaF0da0NZ2W3yWVjfp9Xauvr3v2ARs=@vger.kernel.org
X-Gm-Message-State: AOJu0YypW9AeqhHp8PEbYlouQ8Rgx58BQ2PA4hkJbzDY830QMu1bBHLd
	6bO3Wbtp553JEWRMSjKkRZ2HJ/So6+pCMjT0Ng9YtP5xV9rkrkr+innF2Nl3V9bkr1mwSw2Ek4M
	9rfzNaVk/+vQbdz6Myr0zEyP/YUCxDXADPYkVQMgK+C1gGzdvQIiHBOFPIPPzemv5XOqVhbI2EB
	P1qae7YJ0KE3wwYFtq8cF34iGH5Ak1
X-Gm-Gg: AfdE7ckGQbvQ3WovNXXFnOiMyrlTIMlH5p7F8n3TY38aFR78yZnRSwfd5+OfQGHcvqH
	3mwOXHfwBDcuKIU/ay6bb/bMiQiBgsnYsjQ1QxvRviBdWX2NMJQT0U+zHn4RYaeHhCX5lQAo1aG
	lMiipvp5OTBLZQQ0epgqRBXqvckyfq+79CvzS9Ui98x8o2zgnJyua3tk5w59b6kNcL0aumjBPVi
	HiddoI+C7fPUev+vaOMbiMtYXF7S/b0he94ApnN89EsIZJ9zC5uL+HwrjbYhytC85sMB2zM0BWL
	QNDZj7Oy4ERU
X-Received: by 2002:a17:903:2f48:b0:2c7:1200:bd7e with SMTP id d9443c01a7336-2c718f60995mr175520555ad.18.1782129226687;
        Mon, 22 Jun 2026 04:53:46 -0700 (PDT)
X-Received: by 2002:a17:903:2f48:b0:2c7:1200:bd7e with SMTP id
 d9443c01a7336-2c718f60995mr175520225ad.18.1782129226133; Mon, 22 Jun 2026
 04:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com> <CAJ+F1CKRvSWDOvKC98e_7uyjgJMuXfhOHP83H0s7a=+ZrYxA1g@mail.gmail.com>
 <ajVco512NDPKDPTr@x1.local>
In-Reply-To: <ajVco512NDPKDPTr@x1.local>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 22 Jun 2026 15:53:33 +0400
X-Gm-Features: AVVi8Cetkjgs_ZPbhSsYJ4D0E5D4CqDmlEHuwWMGY_b4e-igfUqu15XDdXHKZHo
Message-ID: <CAMxuvazRnZw4PEsdKCEBD8X1ua5LMj5K-k+-oh-J_uvXm5vT1w@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] Make RamDiscardManager work with multiple
 sources & virtio-mem
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenzhong Duan <zhenzhong.duan@intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
	qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>, 
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
	"Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, Fabiano Rosas <farosas@suse.de>, 
	Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>, 
	Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
	"Dr. David Alan Gilbert" <dave@treblig.org>, Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>, 
	Markus Armbruster <armbru@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter

On Fri, Jun 19, 2026 at 7:13=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Jun 19, 2026 at 12:11:48AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, Jun 4, 2026 at 5:46=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > This is an attempt to fix the incompatibility of virtio-mem with conf=
idential
> > > VMs. The solution implements what was discussed earlier with D. Hilde=
nbrand:
> > > https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.=
18657-5-chenyi.qiang@intel.com/#3502238
> > >
> > > The first patches are misc cleanups. Then some code refactoring to ha=
ve split a
> > > manager/source. And finally, the manager learns to deal with multiple=
 sources.
> > >
> > > This has been tested together with the Linux kernel series from
> > > Zhenzhong Duan [1] for TDX guests.
> > >
> > > (help fix https://issues.redhat.com/browse/RHEL-131968)
> >
> > Can the patch 1-11 be queued or are we missing something?
> > (RFC patch 12 can be dropped for now)
>
> Likely yes.. one thing to double check with you before I do: We don't nee=
d
> the kernel series, do we?  Since when unplug, I expect with the truncatio=
n
> approach that this series proposed, KVM will emit TDH.MEM.PAGE.REMOVE the=
n
> unaccept is done (?).

> Say, what happens if we run QEMU with this series applied, but without th=
e
> kernel series?

The kernel series is needed at least for PAGE.ACCEPT. Without it, QEMU
will have KVM_RUN return EIO, and finish into assert (while tearing
down ioeventfd).

> What confused me a bit is the dependency of this series v.s. the kernel
> one.  It seems to use different approaches, but then I don't understand w=
hy
> this series was tested with the kernel change.

My understanding is that the kernel may perform TDG.MEM.PAGE.RELEASE.
That depends on TDX config TDCS_CONFIG_PAGE_RELEASE which qemu/kvm
doesnt currently control. I don't know whether this is then
redundant/needless with qemu doing discard on the guest_memfd..

