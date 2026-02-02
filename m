Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C5A2F7AAB;
	Mon,  2 Feb 2026 06:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770013646; cv=none; b=PXu5x7j13PFUVfEXjbcDLDX6RE0NsaGBRuABL12Qhxviya4GbSywYIKIJxF2Gmt0UaxbUS2V1qhGATidp4+3MO53kp7Uus0ZTQxUF9oPIKc7Zy2d7zMhlEdmmiw03JRw4cQXOXtaKVx9fa28xJASTNRsZiEwN8SGQSCZ2JGBGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770013646; c=relaxed/simple;
	bh=RdNudPUXX7CtFUI22MZ8axcv9U2f+cqLI4bFHMXNXi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Trbj7xUGIuCrByXBvO69xbDtyMHbg6UfPZtyheoFK21WhA5UngOWxeWMKydbB/d+nL94dfK0vR4b9aCbSwucEx8EOL6Ahn0HN6bEkdLl2ns2xy42rVWg2+pM5jTjQGNQq2PGkCjYJ1Lg2u3ggvM04Cu83PepjaDjf7Jb+kuUEUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3Pn+28x; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3Pn+28x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770013645; x=1801549645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RdNudPUXX7CtFUI22MZ8axcv9U2f+cqLI4bFHMXNXi0=;
  b=M3Pn+28xiwqnXKhjc8Qonme9zzGyBLceaTNOnyUHD+PgnoqWLnoMoMS4
   Dl+d3nqT2JbRqCKzm5CspaJg0FnWKC/3oWS4Pc9P69vChmYkaPtxH8Fn0
   34jEBdq8WCxnY5jH8kBt1pn5rRqYbp6K4buiiAaIXlslelNzw/+n+g8u1
   AqpwJdpJtJpscWu1xtkzxbNQtVbCfzpLEUIcC5dpxAJSl6ahgjwU1fLul
   WyCnMJm/ldk6K1TCvSf8NlpkwcIW7r522jltQqPxG23vLzzBiil8zgsfO
   xRQyn+ln5z2BioCSZChsb2eL3/99BakDZwqvRMnPjWTJ7vHhWCgkjEoWT
   A==;
X-CSE-ConnectionGUID: S7puLZ9SQJGEQlfSSQATWg==
X-CSE-MsgGUID: /kr0k0tUS3On7rCbDiZLbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="58748949"
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="58748949"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2026 22:27:23 -0800
X-CSE-ConnectionGUID: WSJvxEzJSo2X/LltvdRbsA==
X-CSE-MsgGUID: 0krXsQmUSvmzfjEY9sgTuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,268,1763452800"; 
   d="scan'208";a="240122835"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 01 Feb 2026 22:27:19 -0800
Date: Mon, 2 Feb 2026 14:08:54 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, x86@kernel.org, reinette.chatre@intel.com,
	ira.weiny@intel.com, kai.huang@intel.com, dan.j.williams@intel.com,
	sagis@google.com, vannapurve@google.com, paulmck@kernel.org,
	nik.borisov@suse.com, zhenzhong.duan@intel.com, seanjc@google.com,
	rick.p.edgecombe@intel.com, kas@kernel.org,
	dave.hansen@linux.intel.com, vishal.l.verma@intel.com,
	Farrah Chen <farrah.chen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 15/26] x86/virt/seamldr: Abort updates if errors
 occurred midway
Message-ID: <aYA/div9Rt/IJY8m@yilunxu-OptiPlex-7050>
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
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Tested-by: Farrah Chen <farrah.chen@intel.com>

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
