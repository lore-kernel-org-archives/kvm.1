Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8163264D0
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007564; cv=none; b=EWusesdlTNgkX/m+L69pltTYqEFNEysOF0rsHlkcgQ2PfE/8IXOX/9hfeHPje7WgVPqw5elz6SARdlPoBif+92W8gnqMGHkVEs58nFe5yhWRXQvrks+cAnj2hJANBhcBD/5JamCol2dKBqAk6ia9Dr9gNRoe/B+mue5sYi6YPf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007564; c=relaxed/simple;
	bh=Frd30LcVkMs1BH5UAHzuPsBYxLiGeiszbx4ehKsZq+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkSg90zWZWtQqOUZre15jM/3mqUVgE3EffpgAIfvEOgkg1/601fm+LM/M5bh/ncwUaR4pa/HMoSxKpLncE14OZo4flop744EIj4/1/t84vco8Rrhu/aV29CPKl92h+vdStyEdRoErkrSD2Knmd81oRDjJ3pKcee13j+PMqES/Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OZgcpp4t; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OZgcpp4t"
Received: from example.com (p50892d29.dip0.t-ipconnect.de [80.137.45.41])
	by linux.microsoft.com (Postfix) with ESMTPSA id 85F0B20B7167;
	Thu,  2 Jul 2026 08:52:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 85F0B20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783007561;
	bh=W1PIRma9VdMGV7CJDv/Z7U/HiT8rAw/JvBy6iodIcqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZgcpp4tIZ2Gnzeflljl7XTC6DPD9qNU+2kslLT2zdmIcqEHqA7uGDUoIN2C8IlfK
	 cKAg48W9CprbaZFzoN7FUZF4s3W90Lg41/fsGImEnOVQybJWTFxbHDxB6qxakJwe6Y
	 +ojT7FfMiw8FMS4JrQ3HCbxzlz4OpLs17s1CC4g0=
Date: Thu, 2 Jul 2026 17:52:36 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 26/34] accel/mshv: introduce SaveVMHandler
Message-ID: <akaJRKS+JdFvgZAM@example.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-27-magnuskulke@linux.microsoft.com>
 <CABgObfbS988oSPNOV4qLMcT1CPLAyu-NigwYPgZSgZq1ZY7fxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbS988oSPNOV4qLMcT1CPLAyu-NigwYPgZSgZq1ZY7fxA@mail.gmail.com>

On Thu, Jul 02, 2026 at 10:50:17AM +0200, Paolo Bonzini wrote:
> Il ven 17 apr 2026, 12:58 Magnus Kulke <magnuskulke@linux.microsoft.com> ha
> scritto:
> 
> > This mechanism is used to handle more imperative partition-wide steps
> > that have to be taken as part of a migration routine.
> >
> > Currently it's a skeleton that will just pause/resume the partition as
> > part of a migration. It will later be extended with more specific steps
> > like reference time and hypercall pages.
> >
> 
> Sorry, I forgot to reply about this one.

> 
> It is not clear why you need to pause, since this is handled by common
> code. Are you not handling live migration yet? That should be handled at
> levels above QEMU, because users expect migration to be performed while the
> VM runs, and the SaveVMHandler should just fail migration of the VM is
> running.

Oh, good catch, thanks. I misunderstood something about those hooks
apparently. I think this was originally inspired by migration logic in
Cloud-Hypervisor, which freezes/unfreezes a partition during migration
- but only after the pre-copy phase is done.

I assumed the hooks were also called only before the final delta is
transmitted. In tests I was relying on the reported state of the source
from QMP, which probably can not accurately reflect the state of the
partition as the freeze/unfreeze happens out of band (i.e. is is not
orchestrated by the migration framework).

I'll have to research a bit and see if there are more appropriate hooks,
or if we don't need to freeze the source partition at all.

best,

magnus
