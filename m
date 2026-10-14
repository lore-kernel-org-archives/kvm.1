Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E777C485926;
	Wed, 14 Oct 2026 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964760; cv=none; b=mfE7xtIJmEFyS1BwPsPOKv4gpHwVQOfUVZZ6iO2+amVTkB1qfDWi9mDl+EeJBDcjw17/NyKsY6qXtQSmDC5ZuP6Q7pzAqElTMn6lqJ0CfqJLnjB2EA+fJTYSHN7xT1f8XMxdHgUdKZKbu81ZmdLf8BLRd9SANRBUiS1I0e9pPw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964760; c=relaxed/simple;
	bh=l08knvCCtKwAEbBwToNKNaVbEYAyRrjBpOhUgHvPQd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svuR8ZorCCnVe9FFCOCJhm1LYme0XNutty0fzOjJkYn1DoGY1iBqTEj7/M51SkUbSRYF7ZVaVXJJD0J10GzVcrzg2k0CJ7fCv24itLtKA/OEl9J9573D2mGkdx/O1FNi+j7twbX5/t4QCs3+dm8w9krc8hXqXgamSw0EMtA540U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IsLVK60R; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IsLVK60R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791964758; x=1823500758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l08knvCCtKwAEbBwToNKNaVbEYAyRrjBpOhUgHvPQd0=;
  b=IsLVK60RcCXg1k189AOHADNc4OSDVK2BxPqyHh3d8/NmpIGTvPI/XnD+
   Qmx3PCgCzW0VzHyYQ3RxVjBg3KEsZm/z1Eh64tv/RBTCXEPY/2QWpQLIZ
   vHA5bVdgS7xwIonggbXHwbwdA/1k8yCQ12GqiKOE036pHmVlXYy2QabFf
   t0EnFsFE7dvxvaMwHmHi7H9d5I61tvrlQtrPg7YvBMVHHoW9ZnYi4GmmX
   8TrI2hZ+Z4OIF00zmLxoWPFVevvMbjGVD0c2l3GLkD5hZeZokh91p9onJ
   GKLbM8AmPH5eEJU2q4l/sQhlhXKQzYPKTBWkClQ71K+KIPLXUrNznQmFj
   Q==;
X-CSE-ConnectionGUID: BxjdpFqQT0OJUsGjPcmheA==
X-CSE-MsgGUID: yEYIBOxxRTKsHMV8tL7Jow==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="714425"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="714425"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 00:59:17 -0700
X-CSE-ConnectionGUID: vjZz9PwrRnmynaksbI2EaQ==
X-CSE-MsgGUID: dEeHiQ+7SY6F1RiRTj2lNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1441668"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa006.jf.intel.com with ESMTP; 14 Oct 2026 00:59:14 -0700
Date: Wed, 14 Oct 2026 15:55:13 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, binbin.wu@linux.intel.com,
	tony.lindgren@linux.intel.com, rick.p.edgecombe@intel.com,
	nik.borisov@suse.com, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH v4 07/10] x86/virt/tdx: Convert the td_conf metadata
 reader
Message-ID: <as81YTrFev4tNndv@yilunxu-OptiPlex-7050>
References: <20261012094754.27702-1-chao.gao@intel.com>
 <20261012094754.27702-8-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012094754.27702-8-chao.gao@intel.com>

On Mon, Oct 12, 2026 at 02:47:34AM -0700, Chao Gao wrote:
> Continue converting the metadata readers to the table-driven helper.
> 
> The "TD Configurability" class holds several scalar fields plus two CPUID
> arrays. The arrays have a fixed capacity, but the number of entries to
> read is variable and reported by the num_cpuid_config scalar field.
> 
> Add a table that pairs each scalar field ID with the 'struct
> tdx_sys_info_td_conf' member that holds its value, and read those fields
> by walking that table.
> 
> Annotate the table as __initconst as it is referenced only during init.
> 
> Leave the two arrays open coded. 'struct field_mapping' pairs one field ID
> with one structure member, so describing an array would require a field ID
> per field plus an entry count that is unknown until num_cpuid_config has
> been read. That is not worth building for the only two arrays the kernel
> reads.
> 
> Read both arrays in a single loop, as both have num_cpuid_config
> entries. Store each value directly into its array member instead of
> into a temporary u64 first. The members are u64 already, so the extra
> copies serve no purpose.
> 
> The inner dimension of cpuid_config_values[] is fixed at 2. Read the
> two values with two calls instead of an inner loop. This saves a level
> of indentation and is simpler to read.
> 
> AI was used under supervision to review code and workshop logs.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
