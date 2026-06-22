Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F62271450
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782158422; cv=pass; b=aTvTVen8llosGn3jAKwWbjZ1/QQ61SUzYr/lyy9JefserV3cTDKeKQhsIi/0rneu7f/iKXOmMZUJr/zb1eokv8R5pFmENU8hc71S6dKZNBlgMsednlPfQw+2yTyS0lJuM6r/7bvImrD4E0dUgvT1pLjbNYXJeCq5LTYz95uFZR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782158422; c=relaxed/simple;
	bh=hfHN/Z+2NPVSlHp5rPcWswWWG1ea99joKQbc4iBg+/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjzCvRIAJFVE1Z1DgiA5YCoSf1FyQy0b0ia2/4vq6VYalj1hpKwxaY4Zg6ZVnjxh3yy+431YPJnJ3/Yi69yyBCduemGxE2Kj6jR+tuoznQyuSVgtgbTkCJgHHdVZ4XWwNHDS/Z2/aXJ8JCr25DOIZTDT1Ny0rea8+YQ/DFY4OuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A81kJq4l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hSKf2JGh; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A81kJq4l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSKf2JGh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782158419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAS3SRJgEsG/sXLm+WPk6enBbGWkMZFXlLvUcIRtis8=;
	b=A81kJq4lpCCtXHDxAUCwW6a+BN0GFe2RdkLynfxxZwrJGgnTQF6wcu6RapCcWYe0ej2YAC
	oNTHjlxNXGZEZg/N8K0anAI1L/ejsSsS4SQoW3YhhuNZpJAJ0Uh6AfxDajSSvYn/mNiNgL
	8b795KPdeuIqLVZ07NBl66Q5lIn3kFU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-LBY5_DY7Pb2PVF5ANBQYGQ-1; Mon, 22 Jun 2026 16:00:17 -0400
X-MC-Unique: LBY5_DY7Pb2PVF5ANBQYGQ-1
X-Mimecast-MFC-AGG-ID: LBY5_DY7Pb2PVF5ANBQYGQ_1782158416
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0b35fa876so48407055ad.1
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 13:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782158416; cv=none;
        d=google.com; s=arc-20240605;
        b=drzaRbswNHvc3czFc7R6/pdCgy66MLZT6bD4vqbslqyY8yWzVXnT0r2j80AumvCb7d
         QxXmUp6141OcNB4PmgpjPpFQx9NTG/v3vwLZletSlUoC5omixbAeZ5vXvt/+GgBRBQxR
         WRhMz96PJKflCLISBmzqegoB32Iiq291P1AF2YpfauZYOy9+9wsoo/9mlvj//QMAhRzQ
         6ED6g+CbrFRRcSZ5cIqU/uuRytUNPtTWtf6ESAsFfHfSycuVK6WTX/zEBdeGUz0ss0Nm
         z/aG21VvCSjvl78+fa4CfAf8CsErqr+8lWGIBROaNG0hro1Lw5pIIH/JQtexugn2VjlN
         yLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aAS3SRJgEsG/sXLm+WPk6enBbGWkMZFXlLvUcIRtis8=;
        fh=WmidntZyVI4ALetLWr4pDGFllhz1NCKGZrsoGE7tO1c=;
        b=jbyg3zvoGXqlZ2KlBxrbAsklBBcPmEFiW4KflOXedPKF0GTpR50Ie8iuP6wjtl4uev
         Cx863uSsT+3MBLx1l1xkLBn9+uAzEihaudUtd2NFk7W4lHgwC7OANI4VLaP/76rB5p5s
         zmUv9/El9g5rZ1hxNoCYsy+KFXIhF9xFSMI3yg1PuHIXjyd8a0Ceu70mLfiPKAHUz0Ew
         ir/DcD3eOolfdyFC84/RPIv1Y1wyk2VLpfenEs1rlNleBV5MSzkIsyvDgxPuyymSpTOp
         wErsgm2NV4ogQkq3ZXp/B0aMh38chGmK0tkGr+Oxsa0zaBeeXINr3emLkCjf2VbF/exg
         uySA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782158416; x=1782763216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAS3SRJgEsG/sXLm+WPk6enBbGWkMZFXlLvUcIRtis8=;
        b=hSKf2JGhohpqROGa0CWHbw4lt3AYU4d0u8l3hdp1wxjdn+dOHXYjdSJwaE2nLCdo3f
         57wrza506SVAFYNr5EwJWZXnguIBIe8Dh1GqogFZyf9CDdukRoVvOF7LpDYWfYd5OeHg
         jIB+rXmzcoMDfKoM081zi0m3V2eVKysFxdOSZfHg69lG5eaeA22MMh35dFBF/C5XoWOk
         1q5vwrVcw8r7hz4S3RY38xA4p81Gsf44aUIzY7U6ooTnkLmuya20BpiDXRfVeDWazkE9
         vJmVi9QJOjRpf59NHwpCSZBHQOj0CN5mmX4NN5yuN9odiGQDk0pthZAR7eXQ1ZOyRxCN
         WEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782158416; x=1782763216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aAS3SRJgEsG/sXLm+WPk6enBbGWkMZFXlLvUcIRtis8=;
        b=RlxzSB4fu16Lf6tHQIt4b1I5kU3KUmFOaLniO+QjxYRRqdj7mPlydTJlSP9z7zU0CR
         R3UF/ZKHDqo+4/laFldPChyxCN3kVnWFNbYKSPc4SLq2IuqQBesSuaDg1CR+LEqZWl0M
         h2YKQuahksv89EdY5z8YkM1GVQSrbQU+k31aYmUmFNkbgrkeGgKBJBQSMGIeHtnj/lpi
         s8/B1UxdVNxzCA3T0DyrmNB6yw0GFA81huV1UOqBHLDRIGHpk7YVib0KG8Z1LWVBPcW6
         IH4fqhYEn3WkZ+PW1mHZlRcy3K7NEOB20Xldc69GRmLYwhlTvcOpEwLz0FE1ulvC+5F8
         g3uw==
X-Forwarded-Encrypted: i=1; AHgh+RodGguB15fhEeggGV8fPD0zigDiUNNLZG14ntKrGNfwGIy95zPkc4JJm0iNBhQbRiE7atE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2UwFkaL/U7f5WZPDj3T4uIwkvopC0V5E+8Yx8GtwCteh5uw52
	m7Xgjju9ReB8BqNieEPE9RHMqn5Gk+xwF8NZTwVoQMDABm/DCA/V904JEWIbPZZ4Xf42m8JFGe8
	AHv4ji1KO+9PAGIXLu6IuMMvhm1tBQ0DblJtOIqN7V8/WITK3UQAaHM7lPN76i/Umrv5V+vt9iG
	R6/gGz3IKIsY7nAd2GT04fA881CBQI
X-Gm-Gg: AfdE7cnqNLeygnHalC0Lvmu0Q4P1nW0Za5ZqJ/PLchfPsdURdj16WJVj+/krkNI1PAI
	Oh/0n/I3sBHn2jQoIPtzeJvBuVUAzenHrlLQdagj2ymUDRMVAgChZwH9G+hHnNJq131g4qav1lm
	gOA+e9ZwqUYQIm2DneZY1Vu/hETrACz5S9h6YVwYHhZnl3OKn7AfojrIvCv3WHnQPfKM6/71Ita
	1r2M/oBDlfBkY3QGxuRrOOFWLpz9D0HlKLzaxRYqaoXfxfyPbOv3GFBxbbrpiG7GchJoFZHE002
	IkcL8883cofS
X-Received: by 2002:a17:902:d489:b0:2be:22cc:e227 with SMTP id d9443c01a7336-2c718c87b90mr172936595ad.4.1782158416344;
        Mon, 22 Jun 2026 13:00:16 -0700 (PDT)
X-Received: by 2002:a17:902:d489:b0:2be:22cc:e227 with SMTP id
 d9443c01a7336-2c718c87b90mr172936045ad.4.1782158415799; Mon, 22 Jun 2026
 13:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com> <CAJ+F1CKRvSWDOvKC98e_7uyjgJMuXfhOHP83H0s7a=+ZrYxA1g@mail.gmail.com>
 <ajVco512NDPKDPTr@x1.local> <CAMxuvazRnZw4PEsdKCEBD8X1ua5LMj5K-k+-oh-J_uvXm5vT1w@mail.gmail.com>
 <ajmMzMAXay65Sl7U@x1.local>
In-Reply-To: <ajmMzMAXay65Sl7U@x1.local>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 00:00:04 +0400
X-Gm-Features: AVVi8CcALnaUygDfXipA9K5Q53AEsopz0M20qNoO-DAXE4d6r2kmvEKjyvCr0e4
Message-ID: <CAMxuvawvb-oueGsgXQsPzAtB8_ArAM+SOtpacrvOGq=4d1F2Bg@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] Make RamDiscardManager work with multiple
 sources & virtio-mem
To: Peter Xu <peterx@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
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

On Mon, Jun 22, 2026 at 11:28=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Mon, Jun 22, 2026 at 03:53:33PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi Peter
> >
> > On Fri, Jun 19, 2026 at 7:13=E2=80=AFPM Peter Xu <peterx@redhat.com> wr=
ote:
> > >
> > > On Fri, Jun 19, 2026 at 12:11:48AM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Hi
> > > >
> > > > On Thu, Jun 4, 2026 at 5:46=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> > > > <marcandre.lureau@redhat.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > This is an attempt to fix the incompatibility of virtio-mem with =
confidential
> > > > > VMs. The solution implements what was discussed earlier with D. H=
ildenbrand:
> > > > > https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074=
939.18657-5-chenyi.qiang@intel.com/#3502238
> > > > >
> > > > > The first patches are misc cleanups. Then some code refactoring t=
o have split a
> > > > > manager/source. And finally, the manager learns to deal with mult=
iple sources.
> > > > >
> > > > > This has been tested together with the Linux kernel series from
> > > > > Zhenzhong Duan [1] for TDX guests.
> > > > >
> > > > > (help fix https://issues.redhat.com/browse/RHEL-131968)
> > > >
> > > > Can the patch 1-11 be queued or are we missing something?
> > > > (RFC patch 12 can be dropped for now)
> > >
> > > Likely yes.. one thing to double check with you before I do: We don't=
 need
> > > the kernel series, do we?  Since when unplug, I expect with the trunc=
ation
> > > approach that this series proposed, KVM will emit TDH.MEM.PAGE.REMOVE=
 then
> > > unaccept is done (?).
> >
> > > Say, what happens if we run QEMU with this series applied, but withou=
t the
> > > kernel series?
> >
> > The kernel series is needed at least for PAGE.ACCEPT. Without it, QEMU
> > will have KVM_RUN return EIO, and finish into assert (while tearing
> > down ioeventfd).
>
> Could you elaborate a bit more on why ACCEPT would fail?
>
> I used to ask the event flow here:
>
> https://lore.kernel.org/qemu-devel/agTjb3M8ElUAlfp1@x1.local/
>
> If AUG existed, then why ACCEPT would fail?
>
> PS: I didn't read a lot of what a Linux guest would do; I know there're
> some lazy accept approach, but IIUC it's only a matter of time to ACCEPT,
> not correctness.  My understanding is if we properly notify these new slo=
ts
> with AUG, then it should be able to ACCEPT?

Yes, it will, but it needs the kernel patches to do it (or virtio-mem
will let the guest access un-accepted pages and qemu will crash). I
submitted a few proposals before Zhenzhong Duan proposed the last
iteration.

> >
> > > What confused me a bit is the dependency of this series v.s. the kern=
el
> > > one.  It seems to use different approaches, but then I don't understa=
nd why
> > > this series was tested with the kernel change.
> >
> > My understanding is that the kernel may perform TDG.MEM.PAGE.RELEASE.
> > That depends on TDX config TDCS_CONFIG_PAGE_RELEASE which qemu/kvm
> > doesnt currently control. I don't know whether this is then
> > redundant/needless with qemu doing discard on the guest_memfd..
>
> The problem is if this series depends on the kernel series, should we the=
n
> wait for the kernel solution be accepted first in case it'll change?

I don't think qemu needs to wait for the kernel to be fixed.
Furthermore, this series is not tdx/sev/etc specific

>
> But obviously I still don't yet fully understand how this whole thing
> works.. :(

I am also slow, because I don't focus on this most of the time.
Someone with more experience and dedication would handle it better.

