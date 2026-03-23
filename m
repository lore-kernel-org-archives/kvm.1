Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAA540DFD5;
	Mon, 23 Mar 2026 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774226270; cv=none; b=GXsW34HeMDljFyrsA+gLEBCBsD/AK9NFM/+ZenyDOUtjRMPmxYkXtsj5SDr3LyI1HV/LsE1RkH0KJuYOQ6ROMRoDdANm/Np18mOc4lN/b2QVPvBprpmQrm4b5pXy5XcmZX5efP1e5S5l7vaZtLtToWwbNusITxKDse5nmO6Mzeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774226270; c=relaxed/simple;
	bh=T1wXjwFJ6EPw2lxeonXsway4t6B4x+Ls7EDi3ELuspk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWMmu/ljYwR6bodgEQjACOzcdt6Qu3T8lrga0HCy7EvjFRiE4MT1gLSX2x/eRnDlb7wKAPlJs/ygIaoKmqVNGpYkQIZoWDDEhP/lsTX1Dey0COCC3JJxdl/FNxAv4B094An73ranabFOFeQ41YpJbqc6v+suDgNezn8phchXuxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQpLLk9O; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQpLLk9O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774226269; x=1805762269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=T1wXjwFJ6EPw2lxeonXsway4t6B4x+Ls7EDi3ELuspk=;
  b=SQpLLk9OI1cnqrbNgMRUIrx+fnfOlplcNCnTEFzC+TEbPRvmFDcLuaUR
   /lQtJexnSSd9Z+MhsotyR+Yl90QosgA7kO9xCcmJyKyHNXmFf1D0fCzHt
   hUgpvEWQxRVRkTuCwsvFjTI1icOKH8bCz9imP61kNQWCUXa/8Wo1Jk0wF
   rLC23vHaA3fO0mQhuX1iMKiI+Q8CUBZ2PGhXmaRUj7kZiJ3/gx05uyJm4
   O3entePJzC/7c5eJKgtglAP5078e1CbPhJDYv5wJVRQpZ238BToZ81sMm
   0KyR1J0g5QKxz2UldLgIe174Srt6uyGTJLw/1LIu7gaRRKax7GM8whduT
   Q==;
X-CSE-ConnectionGUID: Ahn3K1GSSzSgHC6qyYTNsw==
X-CSE-MsgGUID: A2z02wd7SASU+EOp6+Wjdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="74404280"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="74404280"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 17:37:48 -0700
X-CSE-ConnectionGUID: hNLso/mySB255Be9DTSd3g==
X-CSE-MsgGUID: yfhaF/OjQQS4/KvARcTBXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="223890385"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 17:37:45 -0700
Date: Mon, 23 Mar 2026 08:37:41 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: David Matlack <dmatlack@google.com>
Cc: Yi Lai <yi1.lai@intel.com>, Alex Williamson <alex@shazbot.org>,
	Shuah Khan <shuah@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alex Mastro <amastro@fb.com>
Subject: Re: [PATCH 0/2] vfio: selftests: Fix MMIO test failures in iommufd
 compat mode
Message-ID: <acCLVWggK3wru6aF@ly-workstation>
References: <20260320040322.487429-1-yi1.lai@intel.com>
 <CALzav=c5Sgv-x4LoCbJGdwuuQBr_4DQyZV=0vvnzG_16T3HtzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=c5Sgv-x4LoCbJGdwuuQBr_4DQyZV=0vvnzG_16T3HtzA@mail.gmail.com>

On Fri, Mar 20, 2026 at 10:43:54AM -0700, David Matlack wrote:
> On Thu, Mar 19, 2026 at 9:03 PM Yi Lai <yi1.lai@intel.com> wrote:
> >
> > This series fixes two issues in the vfio_dma_mapping_mmio_test selftest when
> > running in iommufd compat mode.
> >
> > The first patch fixes a segmentation fault caused by an uninitialized list head
> > when __iommu_map() fails (as expected for MMIO regions in iommufd).
> >
> > The second patch fixes a test assertion failure by aligning the check for the
> > __iommu_unmap() return value based on the iommufd mode (native vs. compat).
> 
> Alex Mastro also sent a fix for these issues here:
> 
>   https://lore.kernel.org/kvm/20260303-fix-mmio-test-v1-1-78b4a9e46a4e@fb.com/
> 
> Can you take a look and see if it looks ok to you? I think I prefer
> Alex's fix. We shouldn't even be calling __iommu_unmap() after
> __iommu_map() fails.

Yes, just remove calling __iommu_unmap() is a more direct fix for the
two issues I encoutered. Agree with the fix.

