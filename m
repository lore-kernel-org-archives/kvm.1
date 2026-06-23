Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE4D2765ED
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782229516; cv=none; b=GhWv0PxY3ABi0yjwYs+UgZZQlI11KWsvmY2yxuwkDhGfXYhGTZYTPh0/0H819+Rst217kY9uCKzE4HCU21WVzb76Smc5IKQsozTOJUHahEbmbfbGeIn6No0euZ62Lxs1F1uG+kduzTnmGqmbCB7z9L+MTvyiBjzLWMqqRvl5syE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782229516; c=relaxed/simple;
	bh=AgN/xen2BOovvC5YvbeKJ/vf9Mq4/1rGh/HWy2Cz3ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiFrkkATJYxcO0bbC93v691e0dxlEMQJJF1tobL42ARjyUSnwwUJiPrqI050RaDehQf1vowenLwnGnIHKRkhLaZPHQWnuAsqFqLNYLXkKSGNnVxvpeSXxdLT8j+4KsM1E4bFoO9lP00KVSl2Kiuos7lK4UCxYL37KeT862oZLCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E7AFpzws; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3Z8+uti; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7AFpzws";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3Z8+uti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782229514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I5a/T4Vqnm4D5FklI48JkOMRyoCfPv+sa5L5OLPTryY=;
	b=E7AFpzwsHuTgIvBhwcWINCso0HY7S9pp9RqKafJ2ch6FX0eYwYerDTIfhYwd3JEMSdbGR5
	+Sn0e62+ysg2AXu09PoSFSMVaJa1UTH/vN8q7IkD10q2vWUJMtEN6O+br14XPeb/GpvBzS
	3n4W8rOySXuZFSr7mTVEDpfXywfLYJQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-WP_MIORGMWeXUMirXvwGtA-1; Tue, 23 Jun 2026 11:45:12 -0400
X-MC-Unique: WP_MIORGMWeXUMirXvwGtA-1
X-Mimecast-MFC-AGG-ID: WP_MIORGMWeXUMirXvwGtA_1782229512
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-519fd49d101so17672701cf.0
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782229512; x=1782834312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5a/T4Vqnm4D5FklI48JkOMRyoCfPv+sa5L5OLPTryY=;
        b=T3Z8+utiWkc0YS+Hx/Y/G0j9bMCVFUnJvQPAfWEkz8DtziEPk6znu8DkH6O3/Hfkrq
         kI7q2hBl89vYLFLo2yIOPRXqF2JDWKPCgMFYZ3ZYHwHqmLmyggCF+af2mPdJFgzt/Kza
         4z6g8FCajzTl+TmpRtBL+hcy4vaH54FmW0HABmEBqb3PruDrPwJZLQIp6MKXRcr7MRA1
         FtBAr5BdNttd/3OEhgImgrCHH/TLwp/TYDmUYesVid7LPm/9K+L17aPVpkwHmphGfGYr
         4x8DX7YQhpBqJD43MYieWHQnOUOE7ccqzZKkf0Iriyv5CljJrhrsV/VMkhERvIs6lo3J
         RBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782229512; x=1782834312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5a/T4Vqnm4D5FklI48JkOMRyoCfPv+sa5L5OLPTryY=;
        b=UeS35ctX4cMTWYuTSwD7bp+cLff5pW1N4PI93v5g5Kjh4qnlqkCf0BrSaKHUoaUR5q
         hQT9tz6LSQyNaRggLdZzNckN3bQfrXJBbkGxVh6tyA0n90z1gdGJuBZOQ+X3JT5uA7PH
         7BpM6ncInKbsLDDQb2uHpO0ph+ECQRcEnXy1ZuWof5+osEsqCzf4LpqONn56mwujjMbi
         4t/jg93SDP4e1MC5WW4zz7QpKtvZjDI35Is5HdFh8svPJE7KQUA3yVT1xc2xPSZTRgIY
         RiPclqAi2yupfYmFKkMFPA2K7xQ7jbTNDAYffxQsxTH+30mwAzV7C63eVyMrOjasjn/H
         B1QQ==
X-Forwarded-Encrypted: i=1; AFNElJ/WtgV8NF9I00liEGbxPD4cidhrpOJg/voshLKuEt2JWglA3UeK4AGixBeYFvkw4g71wQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr4fa9nPSjuh1k96iRiKxNkSJ/BUf6/SaTacbM4G++dzm9LlVg
	+QPIaTeVwP7z3mBDknqcDPT6BRFh8tGK+mPShd8X+e6uRKXtJOte8eRpvcrstaCGiTyK74Y9BPa
	PzhPdnx437GO/FIXQ4442Q+2SpiKgyKqmrqE2lHuzFcowTqygI6GS5w==
X-Gm-Gg: AfdE7cnQgtyfI1iYnc/jrKYR/cmouG/2qex9/rneq3JoKCRAaKHm1wGDtCPJpOYJUjU
	wWINOPtSaIhS2bqKztZUYVqNHnEZvkUr4Xg2WOo9HfUgqXDHZxKJLHtFR6kU5qGvFyctDM14ufU
	elyevcDG0vT77KbPqWK/eEsf8F73vt1No9Vxz0QdTRE57lYQ9kwxG/VyHEFJGQ7hd8lLwiQrgD+
	plsFgJnCsewLpdzapBB8REjVmX/eF+lLjAzxoSUZ79F1pKliztJwpVN5A0NZyAJV98YsvgzfLwi
	unWrQ6SBZTyqJ+M0AaSLWCN6cM4rk+1FDFOQGpnJ52erjsy5UcpOPeJ14yDhIgInXaD/M3W80RW
	NICzGIO2wIJxz1xgzTdHXpY+P1Qd93MFk45h6Pcwvoz2KFpiSkWzt2BDWoNTnQXR7rCgHXLlX
X-Received: by 2002:ac8:5fc3:0:b0:517:6fc2:4760 with SMTP id d75a77b69052e-51a51788b89mr60583991cf.9.1782229511534;
        Tue, 23 Jun 2026 08:45:11 -0700 (PDT)
X-Received: by 2002:ac8:5fc3:0:b0:517:6fc2:4760 with SMTP id d75a77b69052e-51a51788b89mr60582621cf.9.1782229510620;
        Tue, 23 Jun 2026 08:45:10 -0700 (PDT)
Received: from x1.local (bras-vprn-aurron9134w-lp130-03-174-91-117-157.dsl.bell.ca. [174.91.117.157])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51ae9505sm28287431cf.26.2026.06.23.08.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:45:09 -0700 (PDT)
Date: Tue, 23 Jun 2026 11:45:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Anthony PERARD <anthony@xenproject.org>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Fabiano Rosas <farosas@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Reinoud Zandijk <reinoud@netbsd.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	=?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
	qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH 0/3] migration/ram: Abort on unsupported migratable RAM
 changes
Message-ID: <ajqqBBA3Ynxqgu_S@x1.local>
References: <20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
 <ajmZrT1d0QXCWTNq@x1.local>
 <b8154a3d-5538-42e1-995b-2aeb05daa4ab@rsg.ci.i.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8154a3d-5538-42e1-995b-2aeb05daa4ab@rsg.ci.i.u-tokyo.ac.jp>

On Tue, Jun 23, 2026 at 09:05:22PM +0900, Akihiko Odaki wrote:
> On 2026/06/23 5:23, Peter Xu wrote:
> > On Thu, Jun 11, 2026 at 03:35:47PM +0900, Akihiko Odaki wrote:
> > > Supersedes: <20260604-migration-v1-1-cef4a5b1bbdd@rsg.ci.i.u-tokyo.ac.jp>
> > > ("[PATCH] system/physmem: Assert migration invariants")
> > > 
> > > ram_mig_ram_block_resized() already aborts migration when migratable RAM
> > > is resized. Extend the same handling to other unsupported changes to the
> > > migratable RAMBlock set, such as removing a migratable RAMBlock or
> > > changing a RAMBlock's migratable state.
> > > 
> > > Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > > ---
> > > Akihiko Odaki (3):
> > >        system/physmem: Pass RAMBlock to RAMBlockNotifier callbacks
> > >        system/physmem: Notify RAMBlock migratable and idstr changes
> > >        migration/ram: Abort on unsupported migratable RAM changes
> > 
> > Thanks for looking at this, Akihiko.
> > 
> > I understand this is a protection to the system to trap error use cases.
> > The question I have is do we have any possible way to trigger these.
> > 
> > I worry we add a bunch of code and notifiers, and then there's zero way to
> > trigger, essentially add dead code.
> > 
> > Logically we could already add assert() on things we don't expect to
> > happen.  This case might be slightly risky, but still I think we can also
> > consider things like error_report_once() instead of introducing slightly
> > complex notifiers just to cover what we think shouldn't happen.
> > 
> > Or do you have way to trigger any of these notifiers?
> 
> I simply followed what's already done for resize(), expecting resize() does
> the correct thing and following it won't introduce a regression.
> 
> > 
> > PS: today I went back and I wanted to try how the existing resize()
> > notifier would trigger, I can't even reproduce it with David's example
> > here:
> > 
> > https://lore.kernel.org/qemu-devel/20210429112708.12291-1-david@redhat.com/#t
> > 
> > I can trap a qemu_ram_resize(), but that's invoked with newsize==rb->size,
> > so it didn't really notify a thing.  I don't really know how to trigger
> > ram_block_notify_resize().  If you know, please share.
> I made an LLM amend the reproducer. Below is its output.
> 
> Regards,
> Akihiko Odaki
> 
> LLM output:
> 
> A synthetic but effective variant is to add custom ACPI filler tables so the
> initial `etc/acpi/tables` blob is just under the 128 KiB alignment bucket,
> then let the normal boot-time fw_cfg ACPI rebuild push it over.
> 
> I tested this shape:
> 
> ```sh
> truncate -s 65000 /tmp/fill1
> truncate -s 50600 /tmp/fill2
> ```
> 
> Then add to the original-ish command:
> 
> ```sh
> -device pcie-root-port,id=rp0,chassis=1,slot=1 \
> -acpitable sig=FI1A,data=/tmp/fill1 \
> -acpitable sig=FI2A,data=/tmp/fill2
> ```

These lines should inject some sections into ACPI, but I don't see why the
acpi table would change: that should be appended right at QEMU boots, so I
expect the ACPI table to grow indeed comparing to when without these lines,
but not resize during VM running.  I wonder if below is hallucinations from
the AI.

> 
> Observed via `info ramblock`:
> 
> ```text
> before cont:
> /rom@etc/acpi/tables   Used 0x0000000000020000
> 
> after cont:
> /rom@etc/acpi/tables   Used 0x0000000000040000
> ```
> 
> So this does produce a real RAMBlock used-size growth during boot in the
> current tree. With migration started before `cont` using a stalled `exec:`
> target, `info migrate` moved to `cancelling`, which is consistent with the
> current resize-during-precopy abort path.
> 
> The key is not the root port itself; the key is making the ACPI table
> rebuild cross `ACPI_BUILD_TABLE_SIZE` alignment. The filler is a bit
> artificial, but it is a good stress variant for the exact class of bug.

I did have a closer look on this whole "MR size can change" thing.

We have two users: ACPI (rom_add_blob()) and other firmwares (most of them
rom_add_file() users, very little used rom_add_blob()).

AFAIU, the real resize should only happen at the 2nd user, not ACPI.

ACPI seems to be able to change ROM size (PS: this is tricky to call it ROM
in the first place: I believe it's only a data blob in fw_cfg) when e.g. it
scans the pci bus and things changed, only happen during reboot, but it
can't happen during migration because qdev_add is forbidden.

Device ROMs can really change size if dest host has newer firmware packages
than source, but that's another use case and I _think_ we support fine,
except that firmwares can only grow not shrink, guarded by
qemu_ram_resize() check on max_length.

That's a pretty niche use case and nothing I can think of that on change of
flipping migratable and so on.  So IMHO we will need to understand the
problem better before having more notifiers.

PS: I wished ACPI three use cases of ROM can be part of device states
already, then it is out of question on MR resize complexity: the max size
is 128K as far as I know; it doesn't need iterability... we migrate devices
sometimes much larger than 128KB on device states.  It can be a VMSD field.

Thanks,

-- 
Peter Xu

