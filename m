Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD0A46AF21;
	Wed, 14 Oct 2026 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966879; cv=none; b=JVb+GxDYys2H7ZEOsp7zb6TgjmJ03gOPM7WqxH/PIERB82dsmDOCQzaffvUCZaIjahOElblwCOD8Ve7UfGkwgjj33sUkPBt2N5Dy8DFJ0y64++hQBqUrRoEbxeC2+R1Y8iB8xHT7/LIu+D9Ozr/Y4q8wP2jqbxRs3/kfYwibgCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966879; c=relaxed/simple;
	bh=As4xWKoCTFyDtzbB/O7H7eilC+aDL7lf7ZzhIf7cknI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6Ua8Lf+cV4314P8KhkJnxcMF7tI+eKpwg2smduwApVg/F9rmAB7cPMYIgbquptyWP0NfRSTnJpiPhKFMRr3fcaJTDjb41XPAuL5TocHQbAiRrvjhFz/8Qoq5ljoQFlpH+hs61UTgG+6IBGMo/HqUtJoryx3hRDpXO2j0jmq1pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RR3IZ7kG; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RR3IZ7kG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791966877; x=1823502877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=As4xWKoCTFyDtzbB/O7H7eilC+aDL7lf7ZzhIf7cknI=;
  b=RR3IZ7kGiFeqPPlWUXRSLq3+/nWgdDkB44aP96d6aBJCD8Ut8V1ptmAl
   4u3/GegVbqKv++RAjuw5JFd9py/C/jVFQwLuGaPfFabXgvqMw46sUyj7P
   4eZ06Dp0MqYQJn4u+MRpAuOIzJO+Uz/z5dPAMbrDYI/TXM/DGTpkrbOJ1
   maulkL4WULZqW/QHQyGUwTjTYQ+EMGdG27BVMErIU59VP8BagLO9rV/nt
   ZDtKHpOjj6D96CfoVXit9q+4szuSghYICpQa/qQ7OOq+kjt7eLYyZIUgN
   IApIb9oz92RRgiybyXIFmIKFrxj0qY6CVK2fa6O2nitAW7UMj1G3x9wHM
   w==;
X-CSE-ConnectionGUID: 2kqiC2qeTPOBnUEjQCbOAQ==
X-CSE-MsgGUID: oAkY88V0Sq+OxmCtA6yWDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="591712"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="591712"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 01:34:29 -0700
X-CSE-ConnectionGUID: FfYjxweyQ5yAiTtIT4OZ7w==
X-CSE-MsgGUID: eLb3SKHaS3W4fuBJZ3UEmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1297969"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa008.jf.intel.com with ESMTP; 14 Oct 2026 01:34:26 -0700
Date: Wed, 14 Oct 2026 16:30:24 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, binbin.wu@linux.intel.com,
	tony.lindgren@linux.intel.com, rick.p.edgecombe@intel.com,
	nik.borisov@suse.com, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH v4 10/10] x86/virt/tdx: Verify structure member sizes
 against metadata field IDs
Message-ID: <as89oLMguTZ9pM8A@yilunxu-OptiPlex-7050>
References: <20261012094754.27702-1-chao.gao@intel.com>
 <20261012094754.27702-11-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012094754.27702-11-chao.gao@intel.com>

On Mon, Oct 12, 2026 at 02:47:37AM -0700, Chao Gao wrote:
> The TDX module reports its capabilities and limits as a set of metadata
> fields, each identified by a field ID, and TDH.SYS.RD reads one field by
> its ID. TDH.SYS.RD returns the value as a u64, but metadata fields are not
> all 64 bits wide. A field ID therefore encodes the field's size into
> bits 33:32.
> 
> The kernel mirrors these fields in C structures, and each member's size
> must match the size encoded in the field ID. FIELD_MAP() stores the member
> size and uses it to decide how many bytes to copy from the value returned
> by TDH.SYS.RD. The size in the field ID is never consulted, so any mismatch
> goes unnoticed. Declaring a u32 member for a 64-bit field, for example,
> would silently store only its low 4 bytes.
> 
> Add a build-time check that the size encoded in each field ID matches the
> size of the corresponding C structure member. A wrongly typed member then
> fails the build with no runtime cost.
> 
> BUILD_BUG_ON() cannot be used in a structure initializer, so use
> BUILD_BUG_ON_ZERO() and add its zero result to the .size initializer. This
> performs the build-time check without changing the stored size.
> 
> An alternative would be to leave the size bits out of the field ID
> definitions and construct the IDs from the member sizes, which makes a
> mismatch impossible. But the TDX module ABI definitions list the full field
> IDs, and definitions with the size bits stripped would match nothing in the
> docs, making them harder to verify. Keep the IDs exactly as documented and
> check the size they encode against the C type instead.
> 
> AI was used under supervision to review code and workshop logs. It
> suggested moving the size check into its own macro to keep the .size line
> short. Rick also used AI to write TDX_FIELD_SIZE_CODE(), which converts a
> member size to the size encoding in the field ID.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
