Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5423368B7
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782156500; cv=none; b=r+Q8cgkTgUu2ZNiqsroVIQBdCTXVtzqexVsCMifIvd7Hy+0rFE6c6Nth11ovXIa2JcpGaqkzAOhO6T2kBHAbgfRYbhWy+uj54isRbjvUKr8eG4hssWx3KbW55QrOOpcEXGMEfkZYspk6tYhMQJDeOM5jyiGerRqq0H55FEN9jfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782156500; c=relaxed/simple;
	bh=FmcISOu+pXDdvYZErgQO6TdnNZae35gJPWujl4yUO1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TT6O7dZ2nCroB3foTg33SrEUNptxGWhiX8KrXzwOsUKu8rjWs18+4XZU7oCoraguECxEt4f89mUDjXcEjrgBBVpdYt16DzWhp9rS4GXN8n12tRZKn4H5Mf0R/qms1HsKJniYy/NkTcPrtcoASzVDR2CmpGlmqkqr1LqIdoXqNr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aau7LbsD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErlPbLLg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aau7LbsD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErlPbLLg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782156498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VG7BnIPX3GQnSpBekFs0Zvg/+BJtTZ/jPlj0eSfGCtY=;
	b=Aau7LbsDxukCDXTVyej4126G9F8g7sFzU3d6vfvEdMxQ3Vw1berj8o0i2HIdJWDZneaLqR
	CLuoc6By6TKH6IpqGtqKdr0AMq1VYlluNpOTReFnGbfaRGoGKIb7ZSc0Nd+23pi/rjXEo+
	9QJC+fQRAbMxzjF0v6UyMiEK9QN0XBI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-edvpDwMGNSmvQNtd3uKkNA-1; Mon, 22 Jun 2026 15:28:16 -0400
X-MC-Unique: edvpDwMGNSmvQNtd3uKkNA-1
X-Mimecast-MFC-AGG-ID: edvpDwMGNSmvQNtd3uKkNA_1782156496
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-519899aa6bfso89065031cf.1
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782156496; x=1782761296; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VG7BnIPX3GQnSpBekFs0Zvg/+BJtTZ/jPlj0eSfGCtY=;
        b=ErlPbLLgz9Lvbi0HUa4JDhtJMaxCWm2kUdl8Zd2luLor8te7fFIhzTTC9ugPzIzYxa
         JVwfw/qF3CnTy9if7C+J5FwvY5oDVnWtl8pzgZa7+fPv9FuQ4PpwufOf4EtJAzcL3mH/
         Hpk3LVM9UYiJrGsNQH6UdglU25R3tjX0d4W8pqV7/lQNetVg+cfKGc/K7bsGFk98e8Xg
         nf/qVXKDjBHnhGXRbS4enMUZmPepScEnBa4zBBAg1inO4AsGkt7Z1lOuIi+Qt7cHAwFS
         5r6rbrC6MWlCQt7rC5OAr5l6sr+vmmZwxK1qZRqtR/sEHdo35INDs3SJynSscqm5yCOT
         ZCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782156496; x=1782761296;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VG7BnIPX3GQnSpBekFs0Zvg/+BJtTZ/jPlj0eSfGCtY=;
        b=WohHmjFpuGWDBqE3NdtvWtLY0gE5IRDNszBqLEWjXtyhK6QST+SpPGkBCFIJxG4yF+
         ED9C0EOwG3XkA7NhQameNQp8muis/o//jYMFPX3aYykYLy9aViGB68GiDixHj/Q/8J2c
         QxPlYY9IpzhMn2tKx/63HZqeMaXDcYTFmagRejwkYSUkQG1j2fbCWUr/YhaXSc0QKPQd
         oL4EFH/aPinDHIyHet+MD2nBfijm4AZfVkkOEHxPCyUbTW6RHvaAOUffMpjZ4vICocr5
         ULWTiGAGwh3z9wm6hpD6YOglLIonQwgzBHqeIa7Gq8qpDshrvLt4oX+Axz+L8t3d/xZR
         cEjA==
X-Forwarded-Encrypted: i=1; AFNElJ85Qirh/hLWVdag+nmli5YTv8LcBzlEuTedIrqVw4m5Ppr3yMn7gQl37JIYlGhiC74Qw28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo4ic/XjbR27MX2i4QjNsboEvr9AECzA+zwk+k5nnvOG71bcyt
	uMokCKMIg9VznXxpStN/FHVkrLjYs7jXcl3KLh9HomzT7KGyBhJ1Lyfo7Aa4ewi9l4MGVj5oh/n
	IDyFEPLwkVhSbnIEpDZt/zOUIyYoor8kkNJlJ0dUo4A2fGYKWazM6UA==
X-Gm-Gg: AfdE7cmw4zqyo1wroiYc1Q3zQxJTZfEHuqDEIXVs+C5Z8ZJcezsiojBtQPbEEu4eskm
	D08vhvMhABe90LHf2B1uAwt/qCsDH8JERhSZ5Bw9ybaYSNpFzHtF8O3kLf9wSq9FBCnlbcthCrP
	cwotIP3Hn0CCrtiqYVzAvS+NG2UeoLTU01rPku5zVm932Wkkp+5//AgPw5aIx/n3dIkWXSKSPDI
	nuXX9wo9osTD5c8EuG+wrHP7jYcOfeflfmLMHGAZ5nxQ48A8aKDHmbDmyM9deTM/9Fv4Iwx1E8j
	gd7T7zgYPTxhYbtgSuxeKd0ZUZnhyAl56+9bnsCH0fYD75cWOzPVey3TDIY6h5Taj0Bn95mCOAU
	JkT1gvHouzcx21yMbx/3aEIbZEIZTDyME24G0kU5TkwTKm5MoamORlP6Wf+VT78o4gK3NggrG
X-Received: by 2002:a05:622a:1492:b0:517:7baa:c57f with SMTP id d75a77b69052e-519e4e4e50bmr239733101cf.54.1782156495799;
        Mon, 22 Jun 2026 12:28:15 -0700 (PDT)
X-Received: by 2002:a05:622a:1492:b0:517:7baa:c57f with SMTP id d75a77b69052e-519e4e4e50bmr239732491cf.54.1782156495119;
        Mon, 22 Jun 2026 12:28:15 -0700 (PDT)
Received: from x1.local (bras-vprn-aurron9134w-lp130-03-174-91-117-157.dsl.bell.ca. [174.91.117.157])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51a9bca9sm5745081cf.19.2026.06.22.12.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 12:28:14 -0700 (PDT)
Date: Mon, 22 Jun 2026 15:28:12 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenzhong Duan <zhenzhong.duan@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>,
	=?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
	"Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
	Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
	Ben Chaney <bchaney@akamai.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v5 00/12] Make RamDiscardManager work with multiple
 sources & virtio-mem
Message-ID: <ajmMzMAXay65Sl7U@x1.local>
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
 <CAJ+F1CKRvSWDOvKC98e_7uyjgJMuXfhOHP83H0s7a=+ZrYxA1g@mail.gmail.com>
 <ajVco512NDPKDPTr@x1.local>
 <CAMxuvazRnZw4PEsdKCEBD8X1ua5LMj5K-k+-oh-J_uvXm5vT1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvazRnZw4PEsdKCEBD8X1ua5LMj5K-k+-oh-J_uvXm5vT1w@mail.gmail.com>

On Mon, Jun 22, 2026 at 03:53:33PM +0400, Marc-André Lureau wrote:
> Hi Peter
> 
> On Fri, Jun 19, 2026 at 7:13 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Jun 19, 2026 at 12:11:48AM +0400, Marc-André Lureau wrote:
> > > Hi
> > >
> > > On Thu, Jun 4, 2026 at 5:46 PM Marc-André Lureau
> > > <marcandre.lureau@redhat.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > This is an attempt to fix the incompatibility of virtio-mem with confidential
> > > > VMs. The solution implements what was discussed earlier with D. Hildenbrand:
> > > > https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.18657-5-chenyi.qiang@intel.com/#3502238
> > > >
> > > > The first patches are misc cleanups. Then some code refactoring to have split a
> > > > manager/source. And finally, the manager learns to deal with multiple sources.
> > > >
> > > > This has been tested together with the Linux kernel series from
> > > > Zhenzhong Duan [1] for TDX guests.
> > > >
> > > > (help fix https://issues.redhat.com/browse/RHEL-131968)
> > >
> > > Can the patch 1-11 be queued or are we missing something?
> > > (RFC patch 12 can be dropped for now)
> >
> > Likely yes.. one thing to double check with you before I do: We don't need
> > the kernel series, do we?  Since when unplug, I expect with the truncation
> > approach that this series proposed, KVM will emit TDH.MEM.PAGE.REMOVE then
> > unaccept is done (?).
> 
> > Say, what happens if we run QEMU with this series applied, but without the
> > kernel series?
> 
> The kernel series is needed at least for PAGE.ACCEPT. Without it, QEMU
> will have KVM_RUN return EIO, and finish into assert (while tearing
> down ioeventfd).

Could you elaborate a bit more on why ACCEPT would fail?

I used to ask the event flow here:

https://lore.kernel.org/qemu-devel/agTjb3M8ElUAlfp1@x1.local/

If AUG existed, then why ACCEPT would fail?

PS: I didn't read a lot of what a Linux guest would do; I know there're
some lazy accept approach, but IIUC it's only a matter of time to ACCEPT,
not correctness.  My understanding is if we properly notify these new slots
with AUG, then it should be able to ACCEPT?

> 
> > What confused me a bit is the dependency of this series v.s. the kernel
> > one.  It seems to use different approaches, but then I don't understand why
> > this series was tested with the kernel change.
> 
> My understanding is that the kernel may perform TDG.MEM.PAGE.RELEASE.
> That depends on TDX config TDCS_CONFIG_PAGE_RELEASE which qemu/kvm
> doesnt currently control. I don't know whether this is then
> redundant/needless with qemu doing discard on the guest_memfd..

The problem is if this series depends on the kernel series, should we then
wait for the kernel solution be accepted first in case it'll change?

But obviously I still don't yet fully understand how this whole thing
works.. :(

Thanks,

-- 
Peter Xu

