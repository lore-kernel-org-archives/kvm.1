Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C921E42DA53
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240971; cv=none; b=l+T5QPepJYRDgf4s5pCE2K4cjAriyRQwkCXRhy8aUaL+KlUYw0x9ko5dAgKdO3R/Nl7+iqYIGt1jVwfnoitkoM9vYZ1SeCeagwkO3FQgXPRz+pqfgf10rmunQeC3tifSxCswzSY5XjZ8ndxCZyjszKLfSX891XvFCSNMjrE5jLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240971; c=relaxed/simple;
	bh=5/Zq+DC7f6K6qWr3zNbMncY7gLwLeSoUByIua2yOhX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mha55HU88FCwnkM2ceeGtKNOA3/H4B3MJIQ4yl56bMAn3ir88U3mywgMAbl1kgKAx04Ai4n2eK1KKTK2D5dlRe0z3D1+0mxx8sjndEMN0NYq003uC/LNPE/7ge7SaV+iyrZ4urUiiyNAgv/B8XMS7McTR9ugF7jHlcQbY9BXvw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SVRyLTWr; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SVRyLTWr"
X-Forwarded-Encrypted: i=1; AHgh+RrfOhZdKOnehvmEJ4STR3YhQF0biEEFKxrVPhoJBDGrxKFVjBruwFeOMrqEH3ZDhtD14Nw=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785240967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dqyI5qm9zqPJIYbY9/rovdcA7+lWay7/Ez/wVrDixbU=;
	b=SVRyLTWrW/uPGrGzbS603z8DshjSFvYMJZsgvnDrdobiZjVLVyCHjIfgqndCo13Z5wLaNG
	aF3M7T1aqQUA8ylAwAh8keqkgHoA68XpDSrljfqMqlIPrFirEMWWObF9LrC5t8rEbWX0yB
	JKVIgkObkg8S6SMf7IpIHBSVGWtQVUk=
X-Gm-Message-State: AOJu0YyVF477PPQ1QyBri/HBj8O6DY9S3MQuiOrkmVFdKHxSBK1tlmAL
	keiYw6W8XCYtQZcAR0/4pr0wj5vHY2d9OCiSBf4NqwkXS4oPG5CDu9wYOTIsIzlU7H67zyiM6Ri
	pBKmzcBIpJQ0gDVSODsNE6HNRxFQQPcOHQ1sBAmim
X-Received: by 2002:a05:622a:a989:20b0:517:5d71:84e5 with SMTP id
 d75a77b69052e-529a766c096mr8268821cf.5.1785240933905; Tue, 28 Jul 2026
 05:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724104819.1296803-1-sascha.bischoff@arm.com>
 <20260724104819.1296803-4-sascha.bischoff@arm.com> <20260724111920.6F63C1F00A3F@smtp.kernel.org>
 <8733x7qt4s.wl-maz@kernel.org>
In-Reply-To: <8733x7qt4s.wl-maz@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 28 Jul 2026 13:14:57 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzTZ9MzcvDOGY0jRPbPM55s6dU0tZK1B_7ZJVEh2YBEBw@mail.gmail.com>
X-Gm-Features: AUfX_mwjwHyKXUcKuiFTWhSNn5WStIe_YCAOA9nyB_9-g6nziv2Dg2gtq14xsRw
Message-ID: <CA+EHjTzTZ9MzcvDOGY0jRPbPM55s6dU0tZK1B_7ZJVEh2YBEBw@mail.gmail.com>
Subject: Re: [PATCH v4 03/48] irqchip/gic-v5: Set up gic_kvm_info on ACPI hosts
To: Marc Zyngier <maz@kernel.org>
Cc: Sascha Bischoff <Sascha.Bischoff@arm.com>, sashiko-reviews@lists.linux.dev, 
	Oliver Upton <oupton@kernel.org>, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Sat, 25 Jul 2026 at 11:06, Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 24 Jul 2026 12:19:20 +0100,
> sashiko-bot@kernel.org wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] Failed ACPI GSI registration for maintenance IRQ due to missing GICv5 hardware IRQ type encoding.
> > --
>
> [...]
>
> > [Severity: High]
> > Does this fail to register the maintenance IRQ?
> >
> > acpi_register_gsi() passes the raw maint_irq directly into fwspec.param[0].
> > However, the GICv5 PPI domain select function expects the hardware IRQ type to
> > be encoded in the upper bits:
> >
> > drivers/irqchip/irq-gic-v5.c:gicv5_irq_ppi_domain_select() {
> >     ...
> >     if (is_fwnode_irqchip(fwspec->fwnode))
> >         hwirq_type = FIELD_GET(GICV5_HWIRQ_TYPE, fwspec->param[0]);
> >
> >     if (hwirq_type != GICV5_HWIRQ_TYPE_PPI)
> >         return 0;
> >     ...
> > }
> >
> > Because the raw MADT value doesn't have the GICV5_HWIRQ_TYPE_PPI bits set, the
> > mapping will be rejected. Should the GSI be encoded with the PPI type before
> > calling acpi_register_gsi()?
>
> Where is this coming from? I can't even find any public documentation
> for ACPI GICv5 support...
>
> Sascha?

I mentioned this reviewing another one of the patches in this series
[1]; I was planing to update the review-prompts once this series is
merged. That said, I am considering starting now, with the existing
GICv5 code and spec, but not include any of the code that is in _this_
series as part of the prompts until this series is merged. That might
be better, since it would make reviewing the next respin easier.

Cheers,
/fuad

[1] https://lore.kernel.org/all/CA+EHjTz0byw1LJDnqJGsPgOYz-pwyyY_u5S_44CbKGAfKnQkgQ@mail.gmail.com/

>
>         M.
>
> --
> Jazz isn't dead. It just smells funny.
>
