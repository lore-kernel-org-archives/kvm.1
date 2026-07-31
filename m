Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187923EAA6;
	Fri, 31 Jul 2026 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465027; cv=none; b=QC9QrrHG8cqZ7FJ5v+f8lmo6yaxqh1eMPQa/2svP9NfZDxACMQNhUBlD9bnBpbjDTZsECGgkllBJjowBYmztNNK+Zg4ffv7p3E7FEYAOH749rlC/2/IeiqCC2bdyeY/bZ8uW67vVCAscrF0hdtBW6Rha3gkasexvEUB9OG6oBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465027; c=relaxed/simple;
	bh=dsOwYgn4rPNoCzjNcGwU6HrOV4OTM8Ctv9IMOrIcWK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvsLa5dcaAUyEyqthbS8SlN31tbyCejzul5FyQRUJod6P6tvtKxOW3bi1tsj/1zWIq01yIY76vvEzJEJEqu2mh5TNVIBq5IKansZ8dkIQk93fpBIPCpW8oirN78rQbQPnTniSoBXS9cT4m/uN0G1xfv9nQMsI7jHFYBtYrMv6FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fG+2hftE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fG+2hftE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785465026; x=1817001026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dsOwYgn4rPNoCzjNcGwU6HrOV4OTM8Ctv9IMOrIcWK8=;
  b=fG+2hftE89SUEDH4olO85I64e4bJkwHn3oxGKMww0VvaNEcLpY5KVufE
   24WIW5rIpc2NgvnOIOZD6vhS1WYUU8q5BQi5C6no/JDXr/l/XuwJ4+N0T
   FiCxkvaW7mdu37P5fLF8GIjYFYOzv03egAJdpheAzXacd8qzsK1je83BC
   KDrv8/k7nI7+swSPr1AgMpxIXAPHSpU/BQaybUS40m566yMVh8W950qXF
   GlB+/ySEBZbi3BdnMZrnrhUlHKcDLD0Run1j3yuBCJYYUUkpZi/+Coo7k
   HNxcJVTxJvs7bCEmELo56hfQV1kxQKGY/mRVjMglgOiOpRSiGAeU/NZmO
   Q==;
X-CSE-ConnectionGUID: QxvwqAeoRQiEEhB1vepLfA==
X-CSE-MsgGUID: UD+xwb90QY2liL74yOaaow==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="86283353"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="86283353"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 19:30:25 -0700
X-CSE-ConnectionGUID: JcNKgZAuRpC7ds39C933LA==
X-CSE-MsgGUID: 4nQur/I4QXm8Uu2cxQupxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="290406632"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 30 Jul 2026 19:30:21 -0700
Date: Fri, 31 Jul 2026 10:30:19 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>,
	"djbw@kernel.org" <djbw@kernel.org>,
	"Maloor, Kishen" <kishen.maloor@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 06/17] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Message-ID: <amwIu8VcGh8uTZPl@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-7-yilun.xu@linux.intel.com>
 <akIo+E5hfQL7C30E@intel.com>
 <603e7857a2036b0fef86dcf8ad0ab97e0232188c.camel@intel.com>
 <amsxCvZUpNwxeDK4@yilunxu-OptiPlex-7050>
 <amt1QNCBQas95XYB@yilunxu-OptiPlex-7050>
 <1f99ce03929f3272319d0f81aecaa93e86022aae.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f99ce03929f3272319d0f81aecaa93e86022aae.camel@intel.com>

On Thu, Jul 30, 2026 at 06:41:55PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2026-07-31 at 00:01 +0800, Xu Yilun wrote:
> > > I've found issue in my implementation. If extensions are required at
> > > boot up time but somehow not required after update, the code just skip
> > > tdx_ext_init() and the update succeed, but after that the extension
> > > features will break.
> > > 
> > > IOW, we should not update the metadata, we should follow the boot up
> > > time metadata to ensure no feature changes.
> > 
> > Sorry, I changed my mind. I remember TDX module architector said "the
> > host should not assume any feature/SEAMCALL must be associated with any
> > extension, it is hidden from the host. Today a SEAMCALL is backed by an
> > extension, tomorrow it may not".
> > 
> > So in this case, ext_required may flip across updates and we should
> > honor the runtime metadata.
> 
> Then this is an incompatible update, no? Linux doesn't support incompatible
> updates. We can keep it simpler.

I imagine if a SEAMCALL is no longer backed by an extension and we
switched off extension after update, the SEAMCALL would still work. But
I don't have use case and I'm not sure.

OK. I'm good this is defined as incompatible update now. Maybe I'm too
worried about thing that is hardly possible. I'll make this set simple.
