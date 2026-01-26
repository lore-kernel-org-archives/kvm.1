Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A75F313547;
	Mon, 26 Jan 2026 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423485; cv=none; b=qBDZCZzObhJJi7h41ymlreLSwE1wOPu0ms24HMmIj8p3XhtQQWNyiVdW/9i2u5a6zoHbiZyWfBr/B/Bs5RXzDEU6YaTvQMdKidJ3prtS291p+TiJFFOcjA+SOnf1OAVmLxteSnWbuWaAr6JGTyfj9ASqiu1lqmJg+TGIi4VSbYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423485; c=relaxed/simple;
	bh=NPxJr0SexMG6ZHaMxAyoRNYVoChLeTyfZ4OfoTpWZZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HW3XHG5896xCXWQesgY/VuJeVhQ9eSPZ7QEqhsdEpUKC3KOWbmqu4sDm+9TaPF0F+6b7KEOckQ8a30OBYdrb0RDpLnqUbiwazVxwOV31uiQQdaORUQH0RKH93MUIONUMbbe8uXTQLAArWmk5ZfSSxC07Vh9R0ZHhkAHbWZO/TmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P913ahc/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P913ahc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769423484; x=1800959484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NPxJr0SexMG6ZHaMxAyoRNYVoChLeTyfZ4OfoTpWZZ0=;
  b=P913ahc/jhvHd9ToHv4m3qDCcub8Lhvo0sjE/gIJ3PtQy0CcC64NGDYb
   FYobFwXyPgO0r49MZvZiczd5VA6Rb4K8ePRN3SjqhBtlZVrE2nOYHn9v5
   nZuQvRIQ2KbKUccgL2Ey7PMqBTt7/ZtJLa/6nY7M7I5YOnIN2Kg9wDhKm
   2uBKlTgIImw+SASVOdCkJc6BtPuA+qdJmeM5c6IkogF0dUHVGSBj525gx
   Y4QB4qptdBkk6HuY/CfQBB010gzDMDsxZuXKF7YIUS9osRzQyJTNb6N+8
   8ONgHls/lrtD6oHrJ1EO6LKV08TV9Qt3Y1/VYcBx9TnwkqlGVKYj6v6C7
   w==;
X-CSE-ConnectionGUID: Hlb4JBTgTMGeIgvmLrtiuA==
X-CSE-MsgGUID: k0ZbfQBKRmyRskGmvCQvqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="81968050"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="81968050"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 02:31:23 -0800
X-CSE-ConnectionGUID: apvYbk4lQrCmcSpZKYUE1g==
X-CSE-MsgGUID: MVl/WAJETxuOprhw+LGT3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="207997581"
Received: from krybak-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 02:31:15 -0800
Date: Mon, 26 Jan 2026 12:31:12 +0200
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, x86@kernel.org, reinette.chatre@intel.com,
	ira.weiny@intel.com, kai.huang@intel.com, dan.j.williams@intel.com,
	yilun.xu@linux.intel.com, sagis@google.com, vannapurve@google.com,
	paulmck@kernel.org, nik.borisov@suse.com, zhenzhong.duan@intel.com,
	seanjc@google.com, rick.p.edgecombe@intel.com, kas@kernel.org,
	dave.hansen@linux.intel.com, vishal.l.verma@intel.com,
	Farrah Chen <farrah.chen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 15/26] x86/virt/seamldr: Abort updates if errors
 occurred midway
Message-ID: <aXdCcJhcU9WOHv92@tlindgre-MOBL1>
References: <20260123145645.90444-1-chao.gao@intel.com>
 <20260123145645.90444-16-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123145645.90444-16-chao.gao@intel.com>

On Fri, Jan 23, 2026 at 06:55:23AM -0800, Chao Gao wrote:
> The TDX Module update process has multiple stages, each of which may
> encounter failures.
> 
> The current state machine of updates proceeds to the next stage
> regardless of errors. But continuing updates when errors occur midway
> is pointless.
> 
> If a CPU encounters an error, abort the update by setting a flag and
> exiting the execution loop. Note that this CPU doesn't acknowledge the
> current stage. This will keep all other CPUs in the current stage until
> they see the flag and exit the loop as well.

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
