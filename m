Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5914B25A2DD;
	Thu, 16 Apr 2026 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776325967; cv=none; b=QWYts0JjL8XGrcJLTItieJCVS1qXOjhdJZ/RetCzfp/EQZGG2EBI6aEqDEhFALd5oUhghKwY5h1hBhggfV0R5J6VaPd/Yn0kMPKFkqX6RxUzyrvwNwj6Vs2K0J1owHEZzOd7OTcIzLK5I12m76GfKlgRQ5Jm8l00aGn3TEq9tvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776325967; c=relaxed/simple;
	bh=3eznngIxB7sBMhkD+RkePITbslHeIIbj318YtTFjwwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pp5OrJuCXp+I4lwM9OLbACX0CIIrCK5ADY4EwccVv2ZbjT7f5YgEx+/Tod664nN59CGpLSZ+3PvBNd7OcqMg0mupV4xG5fykKtBYT2G3JCfK3DY3QT8VIjgsYdB1OHX6r228F6kC3fpWE6H/r7Q38grg4SMTiASXFfXqZ/fdM6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XvXj9MED; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XvXj9MED"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776325967; x=1807861967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3eznngIxB7sBMhkD+RkePITbslHeIIbj318YtTFjwwU=;
  b=XvXj9MEDTVRR+libDi+w9xEzwmpu9nP7twidWwS+hLaTsQEQK8D7F+6Q
   cxgovWtjUAC+AsrD2NQkx7GQ060D2qfDhUZ2Lv2iu2fuh9Pds04bjWr4g
   vNpHLREj2HCgu7gSR5wMiWl7xFVnvCF45g+LHXjqiPmZOKBgan7zaWWpn
   C/ajvH7+eRFGa+yyY7+NaSB28rzPtGGsWo3LxTqmPXFGC7lISsUbh9Wz+
   xx3gNSg2asRUdaKEEb51hIwLMpL8SMron8qR4g8fTC6qCfZtTSVygZo5+
   lJgzx6H6JZ6tPjJoOWj8sRZQfOtPP5pvKq3bgAl5EF9POchH2QhiDWN7L
   w==;
X-CSE-ConnectionGUID: Awsqv3EgQHuT7nCXnUbDgQ==
X-CSE-MsgGUID: imk/sQrUQACM1rC8D7aYkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="81199639"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="81199639"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 00:52:46 -0700
X-CSE-ConnectionGUID: J3mB+uQDSjm8yMqW86NbUw==
X-CSE-MsgGUID: l90HKRPwToSZtaXG5Ah+2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="235608328"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 16 Apr 2026 00:52:44 -0700
Date: Thu, 16 Apr 2026 15:30:48 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Dan Williams <djbw@kernel.org>,
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
	kvm <kvm@vger.kernel.org>, Steffen Eiden <seiden@linux.ibm.com>,
	Alex Williamson <alex.williamson@nvidia.com>
Subject: Re: [PATCH 1/3] VFIO: take reference to the KVM module
Message-ID: <aeCQKMbQpeQM2Rk3@yilunxu-OptiPlex-7050>
References: <20260407180107.1603697-1-pbonzini@redhat.com>
 <20260407180107.1603697-2-pbonzini@redhat.com>
 <adf29Rn7q9Db0hxc@google.com>
 <CABgObfZQ8kcdfiaUyGi6AcZErJztEmcdTcLwo946qtXfUwDM4g@mail.gmail.com>
 <adkFk3ZN4HJtpLA3@google.com>
 <69d977c0b367a_6c31a10021@djbw-dev.notmuch>
 <aeAt4b-QvpcwtRwQ@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeAt4b-QvpcwtRwQ@google.com>

On Wed, Apr 15, 2026 at 05:31:29PM -0700, Sean Christopherson wrote:
> On Fri, Apr 10, 2026, Dan Williams wrote:
> > Sean Christopherson wrote:
> > > +Dan
> > 
> > +Yilun
> > 
> > [..]
> > > I added Dan because the PCI TSM stuff is picking up "struct kvm *kvm" references,
> > > and I want to head that off too, i.e. have it use the file approach instead of
> > > whatever it plans on doing (can't tell from the code, because there are no users).
> > 
> > The PCI TSM *reference* for 'struct kvm *' will be inherited from
> > vfio/iommufd. However, the TSM driver needs some context to manipulate
> 
> I assume/hope it just need to read "struct kvm" state though?
> 
> > the VM. For example, TDX effectively needs:
> > 
> >     to_kvm_tdx(kvm)->td.tdr_page
> > 
> > ...for operations like TDH.TDI.CREATE that sets up the context for the
> > privately assigned device.
> > 
> > It could follow the example of arch/x86/kvm/mmu/page_track.c and do:
> > 
> >     kvm_tdx_tdi_create(struct file *kvm, ...)
> > 
> > ...and use file_to_kvm() for that limited helper that does not need to expose
> > 'struct kvm_tdx' outside of arch/x86/.
> 
> Any idea how many assets do you anticipate needing?  E.g. is it just the TDR
> page, or will TSM need a whole pile of information?

kvm_tdx needs to export several infomation for the whole TDX Connect
to work.

For TSM TDI bind (device secure state transition) part, it only needs
TDR page PA as the TD identifier for TDX Module.


For trusted setup in IOMMU driver, since trusted DMA reuses SEPT as
trusted IOPT, it needs EPT info - eptp_page_walk_level & ad_enabled to
setup trusted IOPT accordingly.

Also because of the page table reusing, IOMMU driver also need to
register a notifier to kvm_tdx for trusted IOTLB flushing on SEPT TLB
flushing.

Thanks,
Yilun
