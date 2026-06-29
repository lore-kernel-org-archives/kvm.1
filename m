Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07F32D0C7E
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757308; cv=none; b=ccabdJXhGXxoZuZc0bvPzPjCx2y4m2WvklGMC7hcMQwB5eytvq8X8uAM8drDp0Jgrip0w7TTlC/ejHSlrR9up85ihoJ+VHyRMsarHgBDufEO6EPGgHhsE+L/n0mjtf4HYtuUnirZF0vmOX5PX/QIjlhzhjoscRSyKUuObQwuN3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757308; c=relaxed/simple;
	bh=UxPy28BlakFH2AGOi0mSU0DEdiX7NTawDP/pfcVgC4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+ohKkiVlxCaXWHVX7T3fAZUErZJng5h06Ltl5do3enkplkIO27af7uqBYRUqdZSvo5MK4xeoh+y6xtL6W239PrkVkLaqA8HwYuhhtqplNiFppuy5r9o0cVLevXstVw81CUaSxhn5uwLYG/sRrLWXIBiaurhsvWaqUBLTOzojRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jWsiNZEv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oop/7MwD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWsiNZEv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oop/7MwD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782757304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mqhrmw4306aEe95JPXSB7j+flpGUNhgGo9WXZ9ofnDQ=;
	b=jWsiNZEvbVgG2mhNZMOkXj7WO8LT+wO5mHtMbC+F6gvIxzV1qGgD7n+4eoQarl9oIsxUvY
	tmXmjOXi6q9r+XJMAbwPu2iNhqCLrVWuQPiAQVWtIGiY3sK9gBxuc0nmX9PZlRi7Rvc6K6
	2NHAmm5Ig5+yCZUHCTRMq3hkHr0k2+Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-EMQVVS6xNUCp7wxyukYPkA-1; Mon, 29 Jun 2026 14:21:40 -0400
X-MC-Unique: EMQVVS6xNUCp7wxyukYPkA-1
X-Mimecast-MFC-AGG-ID: EMQVVS6xNUCp7wxyukYPkA_1782757300
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e632390d2so30550785a.3
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 11:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782757300; x=1783362100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqhrmw4306aEe95JPXSB7j+flpGUNhgGo9WXZ9ofnDQ=;
        b=Oop/7MwDsB85TrUTff0mr837haeKWbh/huzILq0ggrJFuMhKvPYDhhVABXpvxo5YOT
         VlfXxjygKi0MC2AdSu5fPEZH9xlHpGRwyLSeMW99KI/6SzjFjWE4c7JrBT31fuwdB5e3
         RUO+L8uyQ+4hIJPNU0qNLtBeURfuSW57hEZH6algYon+qQYaN6Fidf1piV2FxtVl/DBK
         fxIMcG5nWAa2BLMDSp+cadWfbcWh0sLOnvY4iVE664m2Bs5RNwJioR6gNvHZis29Nst7
         7oaR1vrPvAAAfYvktdAeBTK6W5oCs8gL3jXMZ+ZVlt9cmH97KNimhD/ZMFckc2A00q4G
         gjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757300; x=1783362100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqhrmw4306aEe95JPXSB7j+flpGUNhgGo9WXZ9ofnDQ=;
        b=YNAMDXyDG8XT35eyjijeVWG5WMnV9iA+qVRstYwgxJJhGxr+H/mAlpuNgG/WXHWwXl
         vo9sgIKAkEtuHbfYlRPwT/WxaH2bvtubXRQxvCQokJtCQpe+89XZLYdOf7jlbgpdZFqg
         0cLfwDiujxIssReQ9WBMZCkSgTgp+5P43rEVcAuoJHaFE8EpZFO1J5/39flHVd0lX5m5
         KhKm0H4+2stK4zfUe8npDWy6cprhh8GsOoycuQt/G5nWocSy0h/cWSnu2TEGb6d8xGuV
         05acJ2JktxnmnxAA91XSO+6plNIMy1nXbsfDcS5OeLyv7qL3qOo407KrIKDp172FAKfD
         ZwFA==
X-Forwarded-Encrypted: i=1; AFNElJ8EhYWBww16lwP3zDiunWjjQxuy3YzKRzHjESeEnIqaLv5lmq6ldhSkHwdIU9hxQzAPguc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBoaBIOFPf9Lg6eFT7lKcdhLQMERKgolCGHMamxvrFOcyt8U5d
	xk5SFZ82kXpdafb1FUiA//qhhSWG9OgtdP3+llzXMm4A51RsO2Gp3C5L0yS6+2jzYcKeVMk/fKO
	GA2cqisAFJ02G2d5pLlRfHAgANGgf219qERcSCkkiCGw+pubxKCx1rA==
X-Gm-Gg: AfdE7cnqczG0wqlORXSCAXuCDEJ2LHJFpZpuutxVBIl5zfCQH7ffufps220pzG6F1nU
	//oH9QyDFUDJBosopRitLPcO9ehhZ/dkyGcFkuSVcU9GPFrnH1Zz1rPN0YMd0fZpZAdxRk75+pb
	GE4ajEYk7pOWt1fFloDQoCvud+KQwadj9ztrIdr4G6rIL5N04l97Gyej6eXYnQwQMcjjqM599F8
	QSegqtOSe7vJqz6Tv5XM+RsTauDd5SpV1I2AKuvG2vbuotP/dlaKeLh3fgXb7pimWOXqWQbNd2J
	1ILIl+N2VsuWp9XWVASKvOvYfJe+ZuqCKeUW+xPd2dbdo+CMHsuJsvtpaquaPFXQKjxOFwrDUzP
	mTjk=
X-Received: by 2002:a05:620a:4045:b0:92e:44f5:d638 with SMTP id af79cd13be357-92e62816f4amr111572185a.67.1782757300261;
        Mon, 29 Jun 2026 11:21:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4045:b0:92e:44f5:d638 with SMTP id af79cd13be357-92e62816f4amr111565285a.67.1782757299582;
        Mon, 29 Jun 2026 11:21:39 -0700 (PDT)
Received: from x1.local ([174.91.117.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e623869e6sm40403985a.45.2026.06.29.11.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:21:38 -0700 (PDT)
Date: Mon, 29 Jun 2026 14:21:26 -0400
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
Message-ID: <akK3preOMO_rkZFF@x1.local>
References: <20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
 <ajmZrT1d0QXCWTNq@x1.local>
 <b8154a3d-5538-42e1-995b-2aeb05daa4ab@rsg.ci.i.u-tokyo.ac.jp>
 <ajqqBBA3Ynxqgu_S@x1.local>
 <377d55cb-b239-40d8-b6c2-79e25cdeab1d@rsg.ci.i.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <377d55cb-b239-40d8-b6c2-79e25cdeab1d@rsg.ci.i.u-tokyo.ac.jp>

On Wed, Jun 24, 2026 at 01:38:32AM +0900, Akihiko Odaki wrote:
> On 2026/06/24 0:45, Peter Xu wrote:
> > On Tue, Jun 23, 2026 at 09:05:22PM +0900, Akihiko Odaki wrote:
> > > On 2026/06/23 5:23, Peter Xu wrote:
> > > > On Thu, Jun 11, 2026 at 03:35:47PM +0900, Akihiko Odaki wrote:
> > > > > Supersedes: <20260604-migration-v1-1-cef4a5b1bbdd@rsg.ci.i.u-tokyo.ac.jp>
> > > > > ("[PATCH] system/physmem: Assert migration invariants")
> > > > > 
> > > > > ram_mig_ram_block_resized() already aborts migration when migratable RAM
> > > > > is resized. Extend the same handling to other unsupported changes to the
> > > > > migratable RAMBlock set, such as removing a migratable RAMBlock or
> > > > > changing a RAMBlock's migratable state.
> > > > > 
> > > > > Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > > > > ---
> > > > > Akihiko Odaki (3):
> > > > >         system/physmem: Pass RAMBlock to RAMBlockNotifier callbacks
> > > > >         system/physmem: Notify RAMBlock migratable and idstr changes
> > > > >         migration/ram: Abort on unsupported migratable RAM changes
> > > > 
> > > > Thanks for looking at this, Akihiko.
> > > > 
> > > > I understand this is a protection to the system to trap error use cases.
> > > > The question I have is do we have any possible way to trigger these.
> > > > 
> > > > I worry we add a bunch of code and notifiers, and then there's zero way to
> > > > trigger, essentially add dead code.
> > > > 
> > > > Logically we could already add assert() on things we don't expect to
> > > > happen.  This case might be slightly risky, but still I think we can also
> > > > consider things like error_report_once() instead of introducing slightly
> > > > complex notifiers just to cover what we think shouldn't happen.
> > > > 
> > > > Or do you have way to trigger any of these notifiers?
> > > 
> > > I simply followed what's already done for resize(), expecting resize() does
> > > the correct thing and following it won't introduce a regression.
> > > 
> > > > 
> > > > PS: today I went back and I wanted to try how the existing resize()
> > > > notifier would trigger, I can't even reproduce it with David's example
> > > > here:
> > > > 
> > > > https://lore.kernel.org/qemu-devel/20210429112708.12291-1-david@redhat.com/#t
> > > > 
> > > > I can trap a qemu_ram_resize(), but that's invoked with newsize==rb->size,
> > > > so it didn't really notify a thing.  I don't really know how to trigger
> > > > ram_block_notify_resize().  If you know, please share.
> > > I made an LLM amend the reproducer. Below is its output.
> > > 
> > > Regards,
> > > Akihiko Odaki
> > > 
> > > LLM output:
> > > 
> > > A synthetic but effective variant is to add custom ACPI filler tables so the
> > > initial `etc/acpi/tables` blob is just under the 128 KiB alignment bucket,
> > > then let the normal boot-time fw_cfg ACPI rebuild push it over.
> > > 
> > > I tested this shape:
> > > 
> > > ```sh
> > > truncate -s 65000 /tmp/fill1
> > > truncate -s 50600 /tmp/fill2
> > > ```
> > > 
> > > Then add to the original-ish command:
> > > 
> > > ```sh
> > > -device pcie-root-port,id=rp0,chassis=1,slot=1 \
> > > -acpitable sig=FI1A,data=/tmp/fill1 \
> > > -acpitable sig=FI2A,data=/tmp/fill2
> > > ```
> > 
> > These lines should inject some sections into ACPI, but I don't see why the
> > acpi table would change: that should be appended right at QEMU boots, so I
> > expect the ACPI table to grow indeed comparing to when without these lines,
> > but not resize during VM running.  I wonder if below is hallucinations from
> > the AI.
> 
> The resize happens because the ACPI fw_cfg blobs are built lazily when the
> guest firmware selects them. acpi_add_rom_blob() registers
> acpi_build_update() as the fw_cfg select callback; after `cont`, firmware
> reads the fw_cfg ACPI entries, QEMU builds the tables, and
> acpi_ram_update() calls memory_region_ram_resize().
> 
> Below is the reprouction case (LLM-generated):
> 
> #!/bin/sh
> set -eu
> 
> QEMU=${QEMU:-build/qemu-system-x86_64}
> tmp=$(mktemp -d)
> trap 'rm -rf "$tmp"' EXIT
> 
> qmp_migrate()
> {
>     printf '%s%s%s\n' \
>         '{"execute":"migrate","arguments":{"channels":[{' \
>         '"channel-type":"main","addr":{"transport":"exec",' \
>         '"args":["/bin/sleep","1000"]}}]}}'
> }
> 
> truncate -s 65000 "$tmp/fill1"
> truncate -s 50600 "$tmp/fill2"
> truncate -s 256M "$tmp/nvdimm"
> 
> {
>     echo '{"execute":"qmp_capabilities"}'
>     echo '{"execute":"x-query-ramblock"}'
>     qmp_migrate
>     sleep 1
>     echo '{"execute":"query-migrate"}'
>     echo '{"execute":"cont"}'
>     sleep 3
>     echo '{"execute":"query-migrate"}'
>     echo '{"execute":"x-query-ramblock"}'
>     echo '{"execute":"quit"}'
> } | "$QEMU" \
>     -S \
>     -machine q35,nvdimm=on,accel=tcg \
>     -smp 1 \
>     -cpu max \
>     -m size=20G,slots=8,maxmem=22G \
>     -object \
>     memory-backend-file,id=mem0,mem-path="$tmp/nvdimm",size=256M \
>     -device nvdimm,label-size=131072,memdev=mem0,id=nvdimm0,slot=1 \
>     -nodefaults \
>     -qmp stdio \
>     -serial none \
>     -device vmgenid \
>     -device intel-iommu \
>     -acpitable sig=FI1A,data="$tmp/fill1" \
>     -acpitable sig=FI2A,data="$tmp/fill2" \
>     -display none
> 
> Expected markers in the output:
> 
> /rom@etc/acpi/tables ... Used 0x0000000000020000
> "status": "active"
> "status": "cancelling", "error-desc": "RAM block '/rom@etc/acpi/tables'
> resized during precopy."
> /rom@etc/acpi/tables ... Used 0x0000000000040000

Yes, this script did trigger this.

I didn't check why -acpitable is special, but still, it isn't a real-life
use case to me, and after "cont" it won't change.  It's just still too
special so far so less of a concern to me.

The other thing is, it also didn't further prove there's any possible
update of e.g. migratable flag or idstr that would justify the new
notifiers are not dead code..

On the ACPI code alone, I kept thinking we shouldn't use resize() callback
on its own; we already have vmstate_fw_cfg_acpi_mr, I think we could have
marked all three regions non-migratable then migrate them in the same
VMSD.. It saves all these complexities on thinking about what could happen.

But the same applies here, if there's no real-life issue with it, we don't
need to bother either..

Thanks,

-- 
Peter Xu

